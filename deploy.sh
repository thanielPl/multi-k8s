docker build -t daniellazar/multi-client:latest -t daniellazar/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t daniellazar/multi-server:latest -t daniellazar/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t daniellazar/multi-worker:latest -t daniellazar/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push daniellazar/multi-client:latest
docker push daniellazar/multi-server:latest
docker push daniellazar/multi-worker:latest

docker push daniellazar/multi-client:$SHA
docker push daniellazar/multi-server:$SHA
docker push daniellazar/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=daniellazar/multi-server:$SHA
kubectl set image deployments/client-deployment client=daniellazar/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=daniellazar/multi-worker:$SHA