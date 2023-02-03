Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7F068A09A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjBCRol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjBCRoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:44:37 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19746DFC3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:44:34 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso6531848wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 09:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTJte4qZE/LXbMp1K0FOI8nJeIqbfiwwJeeV+duwur8=;
        b=nfivpy9slATDSW5QCPXHCagBLS4OIGxOhcaPbFRuQslx4rRFB4QXr9HjCY3MAlGYFD
         uOuDzrTBGBFYfzBBapVihH1Z+FHMCctSC47y35wLrwg9qrmVLd7MuncN0rpC1C1AIKg9
         HBrShOlV9afpj/EAzz6jJuWWyYYK1Zgr74+4bPHLCPEYzFSRebDatp1BLlhxFQwrmQ+N
         ApznrGqS+HVl6KNloK2+gzk74DfxPHwFryhK5HnWmPuFX100/9F0lcwX3c4XUpkv8Zx2
         gz1tTpGwYTWm/hxIfl89iMpryIfpWh7aQVc+ly0hXQZzq1eOGM4eOvMgVC9qalek/4gJ
         PqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTJte4qZE/LXbMp1K0FOI8nJeIqbfiwwJeeV+duwur8=;
        b=QLbaSiIA/quoa5Y29bszK7v/hyi5Yw4Jl8eQeiLQJQUfOSC8Cg3heXNj+v/MRtkGHV
         J+aqd0BFnrsDOjiQzUlEVr/YsaJ0QBp6mKvcjoYU1FC3Y+jkzROhViu8C7cETs7fP0W6
         8SBCFXCuaK5uv3ssWvwSnRMHbgMLKa1Fwe3Y5OluL6xE46lQ3hFMgN29Pyv3d0cYBH+u
         fzwniJJ85v1nEDD9WprcQ+Feh17RpzFBrj5VmVvAWrWBhX5rWC7nH+/wMsGp+V/v25dJ
         zNk3aQMzn/kLTIQfZorItwMJs2u7T2Kb3/NSuu6SDebwQQqzOO4Q2SYztnSPsYuoa1jJ
         K5EA==
X-Gm-Message-State: AO0yUKWhBLeXOTtnuzXq0/Ik9LvfSCpjXh71Xey7lf6JWgZN+EIiNTKD
        hqSzImIwZSxkj0FP7IvbTGSMZiSkXL//fYh4
X-Google-Smtp-Source: AK7set9KDHtnCwuz0X6/KhnJZBmXH4IaiQ/IxRJRa6wcD/jIbiOophKmKxZrsbVibVn4iCkl2qwVCw==
X-Received: by 2002:a7b:ce11:0:b0:3dc:5e16:37ea with SMTP id m17-20020a7bce11000000b003dc5e1637eamr10559000wmc.30.1675446273359;
        Fri, 03 Feb 2023 09:44:33 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id z1-20020a5d4c81000000b002bdd8f12effsm2443528wrs.30.2023.02.03.09.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:44:33 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     daniel.lezcano@linaro.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 01/11] thermal/acpi: Remove the intermediate acpi_thermal_trip structure
Date:   Fri,  3 Feb 2023 18:44:19 +0100
Message-Id: <20230203174429.3375691-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203174429.3375691-1-daniel.lezcano@linaro.org>
References: <20230203174429.3375691-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct acpi_thermal_trips() contains the critical, hot, passive
and active trip points structure. In order to use the generic thermal
trips which is a simple array, let's move out those fields in the
struct acpi_thermal instead of having them encapsulated in an
intermediate structure.

No functional changes, just simplification of code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 197 +++++++++++++++++++++--------------------
 1 file changed, 100 insertions(+), 97 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 0b4b844f9d4c..0dbce190cacc 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -166,7 +166,10 @@ struct acpi_thermal {
 	volatile u8 zombie;
 	struct acpi_thermal_flags flags;
 	struct acpi_thermal_state state;
-	struct acpi_thermal_trips trips;
+	struct acpi_thermal_critical critical;
+	struct acpi_thermal_hot hot;
+	struct acpi_thermal_passive passive;
+	struct acpi_thermal_active active[ACPI_THERMAL_MAX_ACTIVE];
 	struct acpi_handle_list devices;
 	struct thermal_zone_device *thermal_zone;
 	int kelvin_offset;	/* in millidegrees */
@@ -271,7 +274,8 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 	/* Critical Shutdown */
 	if (flag & ACPI_TRIPS_CRITICAL) {
 		status = acpi_evaluate_integer(tz->device->handle, "_CRT", NULL, &tmp);
-		tz->trips.critical.temperature = tmp;
+		tz->critical.temperature = tmp;
+
 		/*
 		 * Treat freezing temperatures as invalid as well; some
 		 * BIOSes return really low values and cause reboots at startup.
@@ -279,31 +283,32 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 		 * ... so lets discard those as invalid.
 		 */
 		if (ACPI_FAILURE(status)) {
-			tz->trips.critical.flags.valid = 0;
+			tz->critical.flags.valid = 0;
 			acpi_handle_debug(tz->device->handle,
 					  "No critical threshold\n");
 		} else if (tmp <= 2732) {
 			pr_info(FW_BUG "Invalid critical threshold (%llu)\n", tmp);
-			tz->trips.critical.flags.valid = 0;
+			tz->critical.flags.valid = 0;
 		} else {
-			tz->trips.critical.flags.valid = 1;
+			tz->critical.flags.valid = 1;
 			acpi_handle_debug(tz->device->handle,
 					  "Found critical threshold [%lu]\n",
-					  tz->trips.critical.temperature);
+					  tz->critical.temperature);
 		}
-		if (tz->trips.critical.flags.valid) {
+
+		if (tz->critical.flags.valid) {
 			if (crt == -1) {
-				tz->trips.critical.flags.valid = 0;
+				tz->critical.flags.valid = 0;
 			} else if (crt > 0) {
 				unsigned long crt_k = celsius_to_deci_kelvin(crt);
 
 				/*
 				 * Allow override critical threshold
 				 */
-				if (crt_k > tz->trips.critical.temperature)
+				if (crt_k > tz->critical.temperature)
 					pr_info("Critical threshold %d C\n", crt);
 
-				tz->trips.critical.temperature = crt_k;
+				tz->critical.temperature = crt_k;
 			}
 		}
 	}
@@ -312,22 +317,22 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 	if (flag & ACPI_TRIPS_HOT) {
 		status = acpi_evaluate_integer(tz->device->handle, "_HOT", NULL, &tmp);
 		if (ACPI_FAILURE(status)) {
-			tz->trips.hot.flags.valid = 0;
+			tz->hot.flags.valid = 0;
 			acpi_handle_debug(tz->device->handle,
 					  "No hot threshold\n");
 		} else {
-			tz->trips.hot.temperature = tmp;
-			tz->trips.hot.flags.valid = 1;
+			tz->hot.temperature = tmp;
+			tz->hot.flags.valid = 1;
 			acpi_handle_debug(tz->device->handle,
 					  "Found hot threshold [%lu]\n",
-					  tz->trips.hot.temperature);
+					  tz->hot.temperature);
 		}
 	}
 
 	/* Passive (optional) */
-	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips.passive.flags.valid) ||
+	if (((flag & ACPI_TRIPS_PASSIVE) && tz->passive.flags.valid) ||
 	    flag == ACPI_TRIPS_INIT) {
-		valid = tz->trips.passive.flags.valid;
+		valid = tz->passive.flags.valid;
 		if (psv == -1) {
 			status = AE_SUPPORT;
 		} else if (psv > 0) {
@@ -339,72 +344,70 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 		}
 
 		if (ACPI_FAILURE(status)) {
-			tz->trips.passive.flags.valid = 0;
+			tz->passive.flags.valid = 0;
 		} else {
-			tz->trips.passive.temperature = tmp;
-			tz->trips.passive.flags.valid = 1;
+			tz->passive.temperature = tmp;
+			tz->passive.flags.valid = 1;
 			if (flag == ACPI_TRIPS_INIT) {
 				status = acpi_evaluate_integer(tz->device->handle,
 							       "_TC1", NULL, &tmp);
 				if (ACPI_FAILURE(status))
-					tz->trips.passive.flags.valid = 0;
+					tz->passive.flags.valid = 0;
 				else
-					tz->trips.passive.tc1 = tmp;
-
+					tz->passive.tc1 = tmp;
 				status = acpi_evaluate_integer(tz->device->handle,
 							       "_TC2", NULL, &tmp);
 				if (ACPI_FAILURE(status))
-					tz->trips.passive.flags.valid = 0;
+					tz->passive.flags.valid = 0;
 				else
-					tz->trips.passive.tc2 = tmp;
-
+					tz->passive.tc2 = tmp;
 				status = acpi_evaluate_integer(tz->device->handle,
 							       "_TSP", NULL, &tmp);
 				if (ACPI_FAILURE(status))
-					tz->trips.passive.flags.valid = 0;
+					tz->passive.flags.valid = 0;
 				else
-					tz->trips.passive.tsp = tmp;
+					tz->passive.tsp = tmp;
 			}
 		}
 	}
-	if ((flag & ACPI_TRIPS_DEVICES) && tz->trips.passive.flags.valid) {
+	if ((flag & ACPI_TRIPS_DEVICES) && tz->passive.flags.valid) {
 		memset(&devices, 0, sizeof(struct acpi_handle_list));
 		status = acpi_evaluate_reference(tz->device->handle, "_PSL",
 						 NULL, &devices);
 		if (ACPI_FAILURE(status)) {
 			acpi_handle_info(tz->device->handle,
 					 "Invalid passive threshold\n");
-			tz->trips.passive.flags.valid = 0;
+			tz->passive.flags.valid = 0;
 		} else {
-			tz->trips.passive.flags.valid = 1;
+			tz->passive.flags.valid = 1;
 		}
 
-		if (memcmp(&tz->trips.passive.devices, &devices,
+		if (memcmp(&tz->passive.devices, &devices,
 			   sizeof(struct acpi_handle_list))) {
-			memcpy(&tz->trips.passive.devices, &devices,
+			memcpy(&tz->passive.devices, &devices,
 			       sizeof(struct acpi_handle_list));
 			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
 		}
 	}
 	if ((flag & ACPI_TRIPS_PASSIVE) || (flag & ACPI_TRIPS_DEVICES)) {
-		if (valid != tz->trips.passive.flags.valid)
+		if (valid != tz->passive.flags.valid)
 			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
 	}
 
 	/* Active (optional) */
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
 		char name[5] = { '_', 'A', 'C', ('0' + i), '\0' };
-		valid = tz->trips.active[i].flags.valid;
+		valid = tz->active[i].flags.valid;
 
 		if (act == -1)
 			break; /* disable all active trip points */
 
 		if (flag == ACPI_TRIPS_INIT || ((flag & ACPI_TRIPS_ACTIVE) &&
-		    tz->trips.active[i].flags.valid)) {
+		    tz->active[i].flags.valid)) {
 			status = acpi_evaluate_integer(tz->device->handle,
 						       name, NULL, &tmp);
 			if (ACPI_FAILURE(status)) {
-				tz->trips.active[i].flags.valid = 0;
+				tz->active[i].flags.valid = 0;
 				if (i == 0)
 					break;
 
@@ -412,50 +415,50 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 					break;
 
 				if (i == 1)
-					tz->trips.active[0].temperature = celsius_to_deci_kelvin(act);
+					tz->active[0].temperature = celsius_to_deci_kelvin(act);
 				else
 					/*
 					 * Don't allow override higher than
 					 * the next higher trip point
 					 */
-					tz->trips.active[i-1].temperature =
-						(tz->trips.active[i-2].temperature <
+					tz->active[i - 1].temperature =
+						(tz->active[i - 2].temperature <
 						celsius_to_deci_kelvin(act) ?
-						tz->trips.active[i-2].temperature :
+						tz->active[i - 2].temperature :
 						celsius_to_deci_kelvin(act));
 
 				break;
 			} else {
-				tz->trips.active[i].temperature = tmp;
-				tz->trips.active[i].flags.valid = 1;
+				tz->active[i].temperature = tmp;
+				tz->active[i].flags.valid = 1;
 			}
 		}
 
 		name[2] = 'L';
-		if ((flag & ACPI_TRIPS_DEVICES) && tz->trips.active[i].flags.valid) {
+		if ((flag & ACPI_TRIPS_DEVICES) && tz->active[i].flags.valid ) {
 			memset(&devices, 0, sizeof(struct acpi_handle_list));
 			status = acpi_evaluate_reference(tz->device->handle,
 							 name, NULL, &devices);
 			if (ACPI_FAILURE(status)) {
 				acpi_handle_info(tz->device->handle,
 						 "Invalid active%d threshold\n", i);
-				tz->trips.active[i].flags.valid = 0;
+				tz->active[i].flags.valid = 0;
 			} else {
-				tz->trips.active[i].flags.valid = 1;
+				tz->active[i].flags.valid = 1;
 			}
 
-			if (memcmp(&tz->trips.active[i].devices, &devices,
+			if (memcmp(&tz->active[i].devices, &devices,
 				   sizeof(struct acpi_handle_list))) {
-				memcpy(&tz->trips.active[i].devices, &devices,
+				memcpy(&tz->active[i].devices, &devices,
 				       sizeof(struct acpi_handle_list));
 				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
 			}
 		}
 		if ((flag & ACPI_TRIPS_ACTIVE) || (flag & ACPI_TRIPS_DEVICES))
-			if (valid != tz->trips.active[i].flags.valid)
+			if (valid != tz->active[i].flags.valid)
 				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
 
-		if (!tz->trips.active[i].flags.valid)
+		if (!tz->active[i].flags.valid)
 			break;
 	}
 
@@ -480,12 +483,12 @@ static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
 	if (ret)
 		return ret;
 
-	valid = tz->trips.critical.flags.valid |
-		tz->trips.hot.flags.valid |
-		tz->trips.passive.flags.valid;
+	valid = tz->critical.flags.valid |
+		tz->hot.flags.valid |
+		tz->passive.flags.valid;
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
-		valid |= tz->trips.active[i].flags.valid;
+		valid |= tz->active[i].flags.valid;
 
 	if (!valid) {
 		pr_warn(FW_BUG "No valid trip found\n");
@@ -522,7 +525,7 @@ static int thermal_get_trip_type(struct thermal_zone_device *thermal,
 	if (!tz || trip < 0)
 		return -EINVAL;
 
-	if (tz->trips.critical.flags.valid) {
+	if (tz->critical.flags.valid) {
 		if (!trip) {
 			*type = THERMAL_TRIP_CRITICAL;
 			return 0;
@@ -530,7 +533,7 @@ static int thermal_get_trip_type(struct thermal_zone_device *thermal,
 		trip--;
 	}
 
-	if (tz->trips.hot.flags.valid) {
+	if (tz->hot.flags.valid) {
 		if (!trip) {
 			*type = THERMAL_TRIP_HOT;
 			return 0;
@@ -538,7 +541,7 @@ static int thermal_get_trip_type(struct thermal_zone_device *thermal,
 		trip--;
 	}
 
-	if (tz->trips.passive.flags.valid) {
+	if (tz->passive.flags.valid) {
 		if (!trip) {
 			*type = THERMAL_TRIP_PASSIVE;
 			return 0;
@@ -546,7 +549,7 @@ static int thermal_get_trip_type(struct thermal_zone_device *thermal,
 		trip--;
 	}
 
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips.active[i].flags.valid; i++) {
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->active[i].flags.valid; i++) {
 		if (!trip) {
 			*type = THERMAL_TRIP_ACTIVE;
 			return 0;
@@ -566,30 +569,30 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 	if (!tz || trip < 0)
 		return -EINVAL;
 
-	if (tz->trips.critical.flags.valid) {
+	if (tz->critical.flags.valid) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
-					tz->trips.critical.temperature,
+					tz->critical.temperature,
 					tz->kelvin_offset);
 			return 0;
 		}
 		trip--;
 	}
 
-	if (tz->trips.hot.flags.valid) {
+	if (tz->hot.flags.valid) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
-					tz->trips.hot.temperature,
+					tz->hot.temperature,
 					tz->kelvin_offset);
 			return 0;
 		}
 		trip--;
 	}
 
-	if (tz->trips.passive.flags.valid) {
+	if (tz->passive.flags.valid) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
-					tz->trips.passive.temperature,
+					tz->passive.temperature,
 					tz->kelvin_offset);
 			return 0;
 		}
@@ -597,10 +600,10 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 	}
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
-		tz->trips.active[i].flags.valid; i++) {
+		tz->active[i].flags.valid; i++) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
-					tz->trips.active[i].temperature,
+					tz->active[i].temperature,
 					tz->kelvin_offset);
 			return 0;
 		}
@@ -615,9 +618,9 @@ static int thermal_get_crit_temp(struct thermal_zone_device *thermal,
 {
 	struct acpi_thermal *tz = thermal->devdata;
 
-	if (tz->trips.critical.flags.valid) {
+	if (tz->critical.flags.valid) {
 		*temperature = deci_kelvin_to_millicelsius_with_offset(
-					tz->trips.critical.temperature,
+					tz->critical.temperature,
 					tz->kelvin_offset);
 		return 0;
 	}
@@ -655,8 +658,8 @@ static int thermal_get_trend(struct thermal_zone_device *thermal,
 	 * tz->temperature has already been updated by generic thermal layer,
 	 * before this callback being invoked
 	 */
-	i = tz->trips.passive.tc1 * (tz->temperature - tz->last_temperature) +
-	    tz->trips.passive.tc2 * (tz->temperature - tz->trips.passive.temperature);
+	i = (tz->passive.tc1 * (tz->temperature - tz->last_temperature)) +
+		(tz->passive.tc2 * (tz->temperature - tz->passive.temperature));
 
 	if (i > 0)
 		*trend = THERMAL_TREND_RAISING;
@@ -701,16 +704,16 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
 	int trip = -1;
 	int result = 0;
 
-	if (tz->trips.critical.flags.valid)
+	if (tz->critical.flags.valid)
 		trip++;
 
-	if (tz->trips.hot.flags.valid)
+	if (tz->hot.flags.valid)
 		trip++;
 
-	if (tz->trips.passive.flags.valid) {
+	if (tz->passive.flags.valid) {
 		trip++;
-		for (i = 0; i < tz->trips.passive.devices.count; i++) {
-			handle = tz->trips.passive.devices.handles[i];
+		for (i = 0; i < tz->passive.devices.count; i++) {
+			handle = tz->passive.devices.handles[i];
 			dev = acpi_fetch_acpi_dev(handle);
 			if (dev != device)
 				continue;
@@ -732,12 +735,12 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
 	}
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		if (!tz->trips.active[i].flags.valid)
+		if (!tz->active[i].flags.valid)
 			break;
 
 		trip++;
-		for (j = 0; j < tz->trips.active[i].devices.count; j++) {
-			handle = tz->trips.active[i].devices.handles[j];
+		for (j = 0; j < tz->active[i].devices.count; j++) {
+			handle = tz->active[i].devices.handles[j];
 			dev = acpi_fetch_acpi_dev(handle);
 			if (dev != device)
 				continue;
@@ -794,28 +797,29 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 	acpi_status status;
 	int i;
 
-	if (tz->trips.critical.flags.valid)
+	if (tz->critical.flags.valid)
 		trips++;
 
-	if (tz->trips.hot.flags.valid)
+	if (tz->hot.flags.valid)
 		trips++;
 
-	if (tz->trips.passive.flags.valid)
+	if (tz->passive.flags.valid)
 		trips++;
 
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips.active[i].flags.valid;
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->active[i].flags.valid;
 	     i++, trips++);
 
-	if (tz->trips.passive.flags.valid)
-		tz->thermal_zone = thermal_zone_device_register("acpitz", trips, 0, tz,
-								&acpi_thermal_zone_ops, NULL,
-								tz->trips.passive.tsp * 100,
-								tz->polling_frequency * 100);
+	if (tz->passive.flags.valid)
+		tz->thermal_zone =
+			thermal_zone_device_register("acpitz", trips, 0, tz,
+						     		&acpi_thermal_zone_ops, NULL,
+						     		tz->passive.tsp*100,
+						     		tz->polling_frequency*100);
 	else
 		tz->thermal_zone =
 			thermal_zone_device_register("acpitz", trips, 0, tz,
-						     &acpi_thermal_zone_ops, NULL,
-						     0, tz->polling_frequency * 100);
+						     		&acpi_thermal_zone_ops, NULL,
+						     		0, tz->polling_frequency * 100);
 
 	if (IS_ERR(tz->thermal_zone))
 		return -ENODEV;
@@ -985,8 +989,8 @@ static int acpi_thermal_get_info(struct acpi_thermal *tz)
  */
 static void acpi_thermal_guess_offset(struct acpi_thermal *tz)
 {
-	if (tz->trips.critical.flags.valid &&
-	    (tz->trips.critical.temperature % 5) == 1)
+	if (tz->critical.flags.valid &&
+	    (tz->critical.temperature % 5) == 1)
 		tz->kelvin_offset = 273100;
 	else
 		tz->kelvin_offset = 273200;
@@ -1094,20 +1098,19 @@ static int acpi_thermal_resume(struct device *dev)
 		return -EINVAL;
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		if (!tz->trips.active[i].flags.valid)
+		if (!tz->active[i].flags.valid)
 			break;
-
-		tz->trips.active[i].flags.enabled = 1;
-		for (j = 0; j < tz->trips.active[i].devices.count; j++) {
+		tz->active[i].flags.enabled = 1;
+		for (j = 0; j < tz->active[i].devices.count; j++) {
 			result = acpi_bus_update_power(
-					tz->trips.active[i].devices.handles[j],
+					tz->active[i].devices.handles[j],
 					&power_state);
 			if (result || (power_state != ACPI_STATE_D0)) {
-				tz->trips.active[i].flags.enabled = 0;
+				tz->active[i].flags.enabled = 0;
 				break;
 			}
 		}
-		tz->state.active |= tz->trips.active[i].flags.enabled;
+		tz->state.active |= tz->active[i].flags.enabled;
 	}
 
 	acpi_queue_thermal_check(tz);
-- 
2.34.1

