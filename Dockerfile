# Build phase 

FROM node:16-alpine as builder 
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# app/build --- where all the files will be stored
# Run phase - here we will drop most of we did in the build phase copy only the prod file to serve on ngnix

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# Defual command of ngnix will start it , so no need default CMD to write 