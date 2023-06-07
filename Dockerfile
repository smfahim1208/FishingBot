FROM maven:3.8.1-adoptopenjdk-16 as builder
WORKDIR /srv/build
COPY . .
RUN mvn package

FROM adoptopenjdk/openjdk16:alpine
COPY --from=builder /srv/build/target/FishingBot-*.jar /usr/lib/fishingbot/FishingBot.jar
COPY ./docker/docker-entrypoint.sh /
COPY docker/fishing-bot /usr/bin/fishing-bot
RUN apk add bash jq
ENV MC_SERVER=PBzzNETWORK.aternos.me
ENV MC_PORT=54877
ENV MC_PROTOCOL=AUTOMATIC
ENV MC_ONLINE_MODE=true
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["fishing-bot"]
