#!/bin/bash

api="https://api.xn--e1aa4abnv2b.xn--90ais"
sign=null
vk_user_id=null
vk_ts=null
vk_ref=null
access_token=null

function authenticate() {
	# 1 - sign: (string): <sign>
	# 2 - vk_user_id: (integer): <vk_user_id>
	# 3 - vk_ts: (integer): <vk_ts>
	# 4 - vk_ref: (string): <vk_ref>
	# 5 - access_token_settings: (string): <access_token_settings - default: >
	# 6 - are_notifications_enabled: (integer): <are_notifications_enabled: default: 0>
	# 7 - is_app_user: (integer): <is_app_user - default: 0>
	# 8 - is_favorite: (integer): <is_favorite - default: 0>
	# 9 - language: (string): <language - default: ru>
	# 10 - platform: (string): <platform - default: desktop_web>
	sign=$1
	vk_user_id=$2
	vk_ts=$3
	vk_ref=$4
	params="vk_access_token_settings=${5:-}&vk_app_id=7144202&vk_are_notifications_enabled=${6:-0}&vk_is_app_user=${7:-0}&vk_is_favorite=${8:-0}&vk_language=${9:-ru}&vk_platform=${10:-desktop_web}&vk_ref=$vk_ref&vk_ts=$vk_ts&vk_user_id=$vk_user_id&sign=$sign"
}

function get_user() {
	curl --request GET \
		--url "$api/user.getInfo" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "xvk: $params"
}

function get_recipe_categories() {
	curl --request GET \
		--url "$api/service.getCategoriesRecipes" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "xvk: $params"
}

function get_notifications() {
	curl --request GET \
		--url "$api/notifications.get" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "xvk: $params"
}

function get_user_settings() {
	curl --request GET \
		--url "$api/user.getSettings" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "xvk: $params"
}

function get_rating() {
	# 1 - type: (string): <type - default: likes>
	# 2 - offset: (integer): <offset - default: 10>
	curl --request POST \
		--url "$api/rating.get" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "xvk: $params" \
		--data '{
			"type": "'${1:-likes}'",
			"offset": "'${2:-10}'"
		}'
}

function get_category() {
	# 1 - category: (string): <category>
	curl --request POST \
		--url "$api/category.get" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "xvk: $params" \
		--data '{
			"category": "'$1'"
		}'
}


function get_recipe_info() {
	# 1 - recipe_id: (integer): <recipe_id>
	curl --request POST \
		--url "$api/recipe.get" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "xvk: $params" \
		--data '{
			"recipe_id": "'$1'"
		}'
}

function get_recipe_comments() {
	# 1 - recipe_id: (integer): <recipe_id>
	curl --request POST \
		--url "$api/comments.get" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "xvk: $params" \
		--data '{
			"recipe_id": "'$1'"
		}'
}

function set_like() {
	# 1 - object: (string): <object>
	# 2 - object_id: (integer): <object_id>
	curl --request POST \
		--url "$api/user.setLike" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "xvk: $params" \
		--data '{
			"object": "'$1'",
			"object_id": "'$2'"
		}'
}

function add_comment() {
	# 1 - recipe_id: (integer): <recipe_id>
	# 2 - comment: (string): <comment>
	curl --request POST \
		--url "$api/comments.add" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "xvk: $params" \
		--data '{
			"recipe_id": "'$1'",
			"comment": "'$2'"
		}'
}

function delete_comment() {
	# 1 - comment_id: (integer): <comment_id>
	curl --request POST \
		--url "$api/comments.delete" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "xvk: $params" \
		--data '{
			"comment_id": "'$1'"
		}'
}

function get_favorites() {
	curl --request GET \
		--url "$api/user.getFavorites" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "xvk: $params"
}

function get_subscribers() {
	curl --request GET \
		--url "$api/user.getSubscribers" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "xvk: $params"
}

function get_recipes() {
	curl --request GET \
		--url "$api/user.getRecipes" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "xvk: $params"
}

function get_likes() {
	curl --request GET \
		--url "$api/user.getLikes" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "xvk: $params"
}
