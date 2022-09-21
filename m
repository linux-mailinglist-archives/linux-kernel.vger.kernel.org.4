Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00895BFB7D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiIUJo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbiIUJnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:43:39 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3415792F66
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:27 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z6so8961796wrq.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=7quZAPuMcAvt+QXLI2xXiL2djdLPPOTNpr/QroOkKRY=;
        b=sByVIPNDLmDYSFTGYcTERiiNfEOuoQBslOrtQDNC00W2kxzxcRnc6MpaAgAQIXSOVZ
         9BSuOjTHh4wSPezXiKS2cSPXVmi0pBTXKd3UKdVufS7dKcX3aPHpdZIdVu+Eycz5UeK1
         4BH8wGjDawRKACIEe2xAJm0B3y4NBifmBQsb8CX/aCEv/oC5fndK88GKjWAJr1wP3yfo
         jtziyV3tXRDrSBgLKbouGMRI+ITgYUeDR7ZKYGxDGDvufPYf+jMrbDBCl5oQvF0az/E/
         IUqEh8cjclwOaG04ZAkBCDr3Ly+x4PfvrC+6LLRokHIAR4DBaVAd5ZZMTRtrsHdaDq8m
         p8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7quZAPuMcAvt+QXLI2xXiL2djdLPPOTNpr/QroOkKRY=;
        b=PjjCkUCfAMgk0WDXhwfWaSprk6EFNym78aM2XgQIPpnpiizlO9mIjWVFRr+dtOpJKF
         9q4YBhDgxGSccRXhs54gWlkdAi7D+fqKa+u2xNotiSPjBXbJhcAMq9pvMv7lD34z7spq
         Lc4ejmUW57pLg82jcEUZfMJA9HzHncPKDgiBcd1W+REbNjNMg9+nkylYqmW8DwhahF2D
         PyKFo00XBxVDY+aSFOKPn882OfbFdjWhyFdtaEyyPPWWX8a16Tc3B3YfzEi8I2pNmp+s
         0mQgjq/zOIBZQiP86zTdPa1/R0bz3fS6NYb9V/nkjoXP6vsqwW1UOnGb3LtgjmJRfV0p
         lekA==
X-Gm-Message-State: ACrzQf0VkP6XsQMJf3UpbXmIzpdsg6EyPdL1ldyve1GTJJRLgpXiStyh
        en32Ta8MqtJdBGCnzkEJlTdhtA==
X-Google-Smtp-Source: AMsMyM4GaTpuAZvarnVQi/zmxslSM+uiX4cFvH3cZ7LGjti0lmceFW62GVIVNv+IyWvariq/nH03/g==
X-Received: by 2002:a05:6000:1d9d:b0:22a:745b:9f00 with SMTP id bk29-20020a0560001d9d00b0022a745b9f00mr16509094wrb.280.1663753406662;
        Wed, 21 Sep 2022 02:43:26 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id r123-20020a1c2b81000000b003a62052053csm2763917wmr.18.2022.09.21.02.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:43:26 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v4 05/30] thermal/core/governors: Use thermal_zone_get_trip() instead of ops functions
Date:   Wed, 21 Sep 2022 11:42:18 +0200
Message-Id: <20220921094244.606948-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921094244.606948-1-daniel.lezcano@linaro.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The governors are using the ops->get_trip_* functions, Replace these
calls with thermal_zone_get_trip().

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/gov_bang_bang.c       | 23 +++++-------
 drivers/thermal/gov_fair_share.c      | 18 ++++------
 drivers/thermal/gov_power_allocator.c | 51 ++++++++++++---------------
 drivers/thermal/gov_step_wise.c       | 22 ++++++------
 4 files changed, 47 insertions(+), 67 deletions(-)

diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index a08bbe33be96..09234f3d2fb9 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -13,26 +13,19 @@
 
 #include "thermal_core.h"
 
-static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
+static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip_id)
 {
-	int trip_temp, trip_hyst;
+	struct thermal_trip trip;
 	struct thermal_instance *instance;
 
-	tz->ops->get_trip_temp(tz, trip, &trip_temp);
-
-	if (!tz->ops->get_trip_hyst) {
-		pr_warn_once("Undefined get_trip_hyst for thermal zone %s - "
-				"running with default hysteresis zero\n", tz->type);
-		trip_hyst = 0;
-	} else
-		tz->ops->get_trip_hyst(tz, trip, &trip_hyst);
+	thermal_zone_get_trip(tz, trip_id, &trip);
 
 	dev_dbg(&tz->device, "Trip%d[temp=%d]:temp=%d:hyst=%d\n",
-				trip, trip_temp, tz->temperature,
-				trip_hyst);
+				trip_id, trip.temperature, tz->temperature,
+				trip.hysteresis);
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (instance->trip != trip)
+		if (instance->trip != trip_id)
 			continue;
 
 		/* in case fan is in initial state, switch the fan off */
@@ -50,10 +43,10 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 		 * enable fan when temperature exceeds trip_temp and disable
 		 * the fan in case it falls below trip_temp minus hysteresis
 		 */
-		if (instance->target == 0 && tz->temperature >= trip_temp)
+		if (instance->target == 0 && tz->temperature >= trip.temperature)
 			instance->target = 1;
 		else if (instance->target == 1 &&
-				tz->temperature <= trip_temp - trip_hyst)
+			 tz->temperature <= trip.temperature - trip.hysteresis)
 			instance->target = 0;
 
 		dev_dbg(&instance->cdev->device, "target=%d\n",
diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
index a4ee4661e9cc..c515e7a52294 100644
--- a/drivers/thermal/gov_fair_share.c
+++ b/drivers/thermal/gov_fair_share.c
@@ -21,16 +21,12 @@
  */
 static int get_trip_level(struct thermal_zone_device *tz)
 {
-	int count = 0;
-	int trip_temp;
-	enum thermal_trip_type trip_type;
-
-	if (tz->num_trips == 0 || !tz->ops->get_trip_temp)
-		return 0;
+	struct thermal_trip trip;
+	int count;
 
 	for (count = 0; count < tz->num_trips; count++) {
-		tz->ops->get_trip_temp(tz, count, &trip_temp);
-		if (tz->temperature < trip_temp)
+		thermal_zone_get_trip(tz, count, &trip);
+		if (tz->temperature < trip.temperature)
 			break;
 	}
 
@@ -38,10 +34,8 @@ static int get_trip_level(struct thermal_zone_device *tz)
 	 * count > 0 only if temperature is greater than first trip
 	 * point, in which case, trip_point = count - 1
 	 */
-	if (count > 0) {
-		tz->ops->get_trip_type(tz, count - 1, &trip_type);
-		trace_thermal_zone_trip(tz, count - 1, trip_type);
-	}
+	if (count > 0)
+		trace_thermal_zone_trip(tz, count - 1, trip.type);
 
 	return count;
 }
diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 2d1aeaba38a8..2ef86ced4c7c 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -125,16 +125,15 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
 				   u32 sustainable_power, int trip_switch_on,
 				   int control_temp)
 {
+	struct thermal_trip trip;
+	u32 temperature_threshold = control_temp;
 	int ret;
-	int switch_on_temp;
-	u32 temperature_threshold;
 	s32 k_i;
 
-	ret = tz->ops->get_trip_temp(tz, trip_switch_on, &switch_on_temp);
-	if (ret)
-		switch_on_temp = 0;
+	ret = thermal_zone_get_trip(tz, trip_switch_on, &trip);
+	if (!ret)
+		temperature_threshold -= trip.temperature;
 
-	temperature_threshold = control_temp - switch_on_temp;
 	/*
 	 * estimate_pid_constants() tries to find appropriate default
 	 * values for thermal zones that don't provide them. If a
@@ -520,10 +519,10 @@ static void get_governor_trips(struct thermal_zone_device *tz,
 	last_passive = INVALID_TRIP;
 
 	for (i = 0; i < tz->num_trips; i++) {
-		enum thermal_trip_type type;
+		struct thermal_trip trip;
 		int ret;
 
-		ret = tz->ops->get_trip_type(tz, i, &type);
+		ret = thermal_zone_get_trip(tz, i, &trip);
 		if (ret) {
 			dev_warn(&tz->device,
 				 "Failed to get trip point %d type: %d\n", i,
@@ -531,14 +530,14 @@ static void get_governor_trips(struct thermal_zone_device *tz,
 			continue;
 		}
 
-		if (type == THERMAL_TRIP_PASSIVE) {
+		if (trip.type == THERMAL_TRIP_PASSIVE) {
 			if (!found_first_passive) {
 				params->trip_switch_on = i;
 				found_first_passive = true;
 			} else  {
 				last_passive = i;
 			}
-		} else if (type == THERMAL_TRIP_ACTIVE) {
+		} else if (trip.type == THERMAL_TRIP_ACTIVE) {
 			last_active = i;
 		} else {
 			break;
@@ -633,7 +632,7 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 {
 	int ret;
 	struct power_allocator_params *params;
-	int control_temp;
+	struct thermal_trip trip;
 
 	ret = check_power_actors(tz);
 	if (ret)
@@ -659,13 +658,12 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 	get_governor_trips(tz, params);
 
 	if (tz->num_trips > 0) {
-		ret = tz->ops->get_trip_temp(tz,
-					params->trip_max_desired_temperature,
-					&control_temp);
+		ret = thermal_zone_get_trip(tz, params->trip_max_desired_temperature,
+					    &trip);
 		if (!ret)
 			estimate_pid_constants(tz, tz->tzp->sustainable_power,
 					       params->trip_switch_on,
-					       control_temp);
+					       trip.temperature);
 	}
 
 	reset_pid_controller(params);
@@ -695,11 +693,11 @@ static void power_allocator_unbind(struct thermal_zone_device *tz)
 	tz->governor_data = NULL;
 }
 
-static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
+static int power_allocator_throttle(struct thermal_zone_device *tz, int trip_id)
 {
-	int ret;
-	int switch_on_temp, control_temp;
 	struct power_allocator_params *params = tz->governor_data;
+	struct thermal_trip trip;
+	int ret;
 	bool update;
 
 	lockdep_assert_held(&tz->lock);
@@ -708,13 +706,12 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 	 * We get called for every trip point but we only need to do
 	 * our calculations once
 	 */
-	if (trip != params->trip_max_desired_temperature)
+	if (trip_id != params->trip_max_desired_temperature)
 		return 0;
 
-	ret = tz->ops->get_trip_temp(tz, params->trip_switch_on,
-				     &switch_on_temp);
-	if (!ret && (tz->temperature < switch_on_temp)) {
-		update = (tz->last_temperature >= switch_on_temp);
+	ret = thermal_zone_get_trip(tz, params->trip_switch_on, &trip);
+	if (!ret && (tz->temperature < trip.temperature)) {
+		update = (tz->last_temperature >= trip.temperature);
 		tz->passive = 0;
 		reset_pid_controller(params);
 		allow_maximum_power(tz, update);
@@ -723,16 +720,14 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 
 	tz->passive = 1;
 
-	ret = tz->ops->get_trip_temp(tz, params->trip_max_desired_temperature,
-				&control_temp);
+	ret = thermal_zone_get_trip(tz, params->trip_max_desired_temperature, &trip);
 	if (ret) {
-		dev_warn(&tz->device,
-			 "Failed to get the maximum desired temperature: %d\n",
+		dev_warn(&tz->device, "Failed to get the maximum desired temperature: %d\n",
 			 ret);
 		return ret;
 	}
 
-	return allocate_power(tz, control_temp);
+	return allocate_power(tz, trip.temperature);
 }
 
 static struct thermal_governor thermal_gov_power_allocator = {
diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index cdd3354bc27f..3cb16d7e65d1 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -95,30 +95,28 @@ static void update_passive_instance(struct thermal_zone_device *tz,
 		tz->passive += value;
 }
 
-static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
+static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip_id)
 {
-	int trip_temp;
-	enum thermal_trip_type trip_type;
 	enum thermal_trend trend;
 	struct thermal_instance *instance;
+	struct thermal_trip trip;
 	bool throttle = false;
 	int old_target;
 
-	tz->ops->get_trip_temp(tz, trip, &trip_temp);
-	tz->ops->get_trip_type(tz, trip, &trip_type);
+	thermal_zone_get_trip(tz, trip_id, &trip);
 
-	trend = get_tz_trend(tz, trip);
+	trend = get_tz_trend(tz, trip_id);
 
-	if (tz->temperature >= trip_temp) {
+	if (tz->temperature >= trip.temperature) {
 		throttle = true;
-		trace_thermal_zone_trip(tz, trip, trip_type);
+		trace_thermal_zone_trip(tz, trip_id, trip.type);
 	}
 
 	dev_dbg(&tz->device, "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
-				trip, trip_type, trip_temp, trend, throttle);
+				trip_id, trip.type, trip.temperature, trend, throttle);
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (instance->trip != trip)
+		if (instance->trip != trip_id)
 			continue;
 
 		old_target = instance->target;
@@ -132,11 +130,11 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 		/* Activate a passive thermal instance */
 		if (old_target == THERMAL_NO_TARGET &&
 			instance->target != THERMAL_NO_TARGET)
-			update_passive_instance(tz, trip_type, 1);
+			update_passive_instance(tz, trip.type, 1);
 		/* Deactivate a passive thermal instance */
 		else if (old_target != THERMAL_NO_TARGET &&
 			instance->target == THERMAL_NO_TARGET)
-			update_passive_instance(tz, trip_type, -1);
+			update_passive_instance(tz, trip.type, -1);
 
 		instance->initialized = true;
 		mutex_lock(&instance->cdev->lock);
-- 
2.34.1

