Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B6F5F4869
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJDR1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiJDR1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:27:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D1F5A899
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:27:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id i83-20020a1c3b56000000b003bd44dc526fso1215272wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 10:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+UH6eHRlE/MTxCKRlbB94yySc6CPvVskocmDXPZ1ko=;
        b=rSeZSThbp1adPwA74ZTvwspF6EWUoGUJdGpR9GbxnB2tfpzniKQrul5Gf6OFj97Wca
         zpoH3oBT+zdI9JJ1t9vLo3GhOSA90OWancwRmU3exbgtRM4rh1p+IwWrtvaPCcCbABxl
         +wnmMJOkeookBw4tKeUyoV2qj2bAs2RTyzwPNfQU+c/NkbIDExV2nslHQZ4J9SrshBYF
         itPrj0hUTxi1tAKJvYeZT4X+RcrWG8AQDQZ5BkzAhGeVNXl8VCleBd/h+fDADP/7k2k+
         ePVNoAlqkjvVP4BSm1K1GMAN+HHS+hbTgLybqx8//PJuUo3nbFSs4RAiAzLgB2daUK1E
         1mAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+UH6eHRlE/MTxCKRlbB94yySc6CPvVskocmDXPZ1ko=;
        b=lU1CAJq8FQuiEDtY0qdjTBmr6wPP8A8kKcG01diELbFKyaGxRM3aIeLYpFkqUGghUe
         nFiF8fjgGtzIGfj0KUiqnqC90baFpqKfv1JfxyAkk6/bJVIT6N0KXD86wqzrzC/Le0pq
         GrEyM2KBoVUMFEvLvkpUUoqUv5oLgzca3QHc8AGbjCAUy//VjCWGP8sCdmd/Ya1KTN0r
         pkwQHc5nPVk+DvbZXYSZiWlO2sKDXPXLIaxjR8u+RJZOqdcU6orHqRZ5es9VL9+q7Z8T
         4lG556cd3LKBq/SQhOQNAh8u6SUoRtTQHUEHodFBSLglzPdDwbNcdP0WTZ1mcMQ/XQIX
         QiIw==
X-Gm-Message-State: ACrzQf1g0fNhXdfo006vpTqBKTWhJ06lVCGGRLVrWfnfJ8cdnQG8m6G4
        L/YRv9NjIlwhvw84/Q48sJTKPA==
X-Google-Smtp-Source: AMsMyM47YrG4B1I62NMttOD8xCnS4Oa0WqUvvvUfsXwTaorb52kIib0lRTGlLBpEpi7voCeEKpk2ZQ==
X-Received: by 2002:a05:600c:5014:b0:3b5:889:58a5 with SMTP id n20-20020a05600c501400b003b5088958a5mr589786wmr.140.1664904427990;
        Tue, 04 Oct 2022 10:27:07 -0700 (PDT)
Received: from mai.. ([2a05:6e02:1041:c10:c456:8337:99aa:2667])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm13060941wrc.62.2022.10.04.10.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 10:27:07 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH RFC 1/9] thermal/acpi: Remove the intermediate acpi_thermal_trip structure
Date:   Tue,  4 Oct 2022 19:26:50 +0200
Message-Id: <20221004172658.2302511-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221004172658.2302511-1-daniel.lezcano@linaro.org>
References: <12068304.O9o76ZdvQC@kreacher>
 <20221004172658.2302511-1-daniel.lezcano@linaro.org>
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

The struct acpi_thermal_trips() contains the critical, hot, passive
and active trip points structure. In order to use the generic thermal
trips, let's move out those fields in the struct acpi_thermal instead
of having them encapsulated in an intermediate structure.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 183 +++++++++++++++++++++--------------------
 1 file changed, 93 insertions(+), 90 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 539660ef93c7..b2e73e45c6d6 100644
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
@@ -272,7 +275,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 	if (flag & ACPI_TRIPS_CRITICAL) {
 		status = acpi_evaluate_integer(tz->device->handle,
 				"_CRT", NULL, &tmp);
-		tz->trips.critical.temperature = tmp;
+		tz->critical.temperature = tmp;
 		/*
 		 * Treat freezing temperatures as invalid as well; some
 		 * BIOSes return really low values and cause reboots at startup.
@@ -280,32 +283,32 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 		 * ... so lets discard those as invalid.
 		 */
 		if (ACPI_FAILURE(status)) {
-			tz->trips.critical.flags.valid = 0;
+			tz->critical.flags.valid = 0;
 			acpi_handle_debug(tz->device->handle,
 					  "No critical threshold\n");
 		} else if (tmp <= 2732) {
 			pr_info(FW_BUG "Invalid critical threshold (%llu)\n",
 				tmp);
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
-		if (tz->trips.critical.flags.valid == 1) {
+		if (tz->critical.flags.valid == 1) {
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
@@ -315,22 +318,22 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 		status = acpi_evaluate_integer(tz->device->handle,
 				"_HOT", NULL, &tmp);
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
 		(flag == ACPI_TRIPS_INIT)) {
-		valid = tz->trips.passive.flags.valid;
+		valid = tz->passive.flags.valid;
 		if (psv == -1) {
 			status = AE_SUPPORT;
 		} else if (psv > 0) {
@@ -342,122 +345,122 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 		}
 
 		if (ACPI_FAILURE(status))
-			tz->trips.passive.flags.valid = 0;
+			tz->passive.flags.valid = 0;
 		else {
-			tz->trips.passive.temperature = tmp;
-			tz->trips.passive.flags.valid = 1;
+			tz->passive.temperature = tmp;
+			tz->passive.flags.valid = 1;
 			if (flag == ACPI_TRIPS_INIT) {
 				status = acpi_evaluate_integer(
 						tz->device->handle, "_TC1",
 						NULL, &tmp);
 				if (ACPI_FAILURE(status))
-					tz->trips.passive.flags.valid = 0;
+					tz->passive.flags.valid = 0;
 				else
-					tz->trips.passive.tc1 = tmp;
+					tz->passive.tc1 = tmp;
 				status = acpi_evaluate_integer(
 						tz->device->handle, "_TC2",
 						NULL, &tmp);
 				if (ACPI_FAILURE(status))
-					tz->trips.passive.flags.valid = 0;
+					tz->passive.flags.valid = 0;
 				else
-					tz->trips.passive.tc2 = tmp;
+					tz->passive.tc2 = tmp;
 				status = acpi_evaluate_integer(
 						tz->device->handle, "_TSP",
 						NULL, &tmp);
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
 		}
 		else
-			tz->trips.passive.flags.valid = 1;
+			tz->passive.flags.valid = 1;
 
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
 
 		if ((flag == ACPI_TRIPS_INIT) || ((flag & ACPI_TRIPS_ACTIVE) &&
-			tz->trips.active[i].flags.valid)) {
+			tz->active[i].flags.valid)) {
 			status = acpi_evaluate_integer(tz->device->handle,
 							name, NULL, &tmp);
 			if (ACPI_FAILURE(status)) {
-				tz->trips.active[i].flags.valid = 0;
+				tz->active[i].flags.valid = 0;
 				if (i == 0)
 					break;
 				if (act <= 0)
 					break;
 				if (i == 1)
-					tz->trips.active[0].temperature =
+					tz->active[0].temperature =
 						celsius_to_deci_kelvin(act);
 				else
 					/*
 					 * Don't allow override higher than
 					 * the next higher trip point
 					 */
-					tz->trips.active[i - 1].temperature =
-						(tz->trips.active[i - 2].temperature <
+					tz->active[i - 1].temperature =
+						(tz->active[i - 2].temperature <
 						celsius_to_deci_kelvin(act) ?
-						tz->trips.active[i - 2].temperature :
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
-		if ((flag & ACPI_TRIPS_DEVICES) && tz->trips.active[i].flags.valid ) {
+		if ((flag & ACPI_TRIPS_DEVICES) && tz->active[i].flags.valid ) {
 			memset(&devices, 0, sizeof(struct acpi_handle_list));
 			status = acpi_evaluate_reference(tz->device->handle,
 						name, NULL, &devices);
 			if (ACPI_FAILURE(status)) {
 				acpi_handle_info(tz->device->handle,
 						 "Invalid active%d threshold\n", i);
-				tz->trips.active[i].flags.valid = 0;
+				tz->active[i].flags.valid = 0;
 			}
 			else
-				tz->trips.active[i].flags.valid = 1;
+				tz->active[i].flags.valid = 1;
 
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
 
@@ -482,12 +485,12 @@ static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
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
@@ -524,7 +527,7 @@ static int thermal_get_trip_type(struct thermal_zone_device *thermal,
 	if (!tz || trip < 0)
 		return -EINVAL;
 
-	if (tz->trips.critical.flags.valid) {
+	if (tz->critical.flags.valid) {
 		if (!trip) {
 			*type = THERMAL_TRIP_CRITICAL;
 			return 0;
@@ -532,7 +535,7 @@ static int thermal_get_trip_type(struct thermal_zone_device *thermal,
 		trip--;
 	}
 
-	if (tz->trips.hot.flags.valid) {
+	if (tz->hot.flags.valid) {
 		if (!trip) {
 			*type = THERMAL_TRIP_HOT;
 			return 0;
@@ -540,7 +543,7 @@ static int thermal_get_trip_type(struct thermal_zone_device *thermal,
 		trip--;
 	}
 
-	if (tz->trips.passive.flags.valid) {
+	if (tz->passive.flags.valid) {
 		if (!trip) {
 			*type = THERMAL_TRIP_PASSIVE;
 			return 0;
@@ -549,7 +552,7 @@ static int thermal_get_trip_type(struct thermal_zone_device *thermal,
 	}
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
-		tz->trips.active[i].flags.valid; i++) {
+		tz->active[i].flags.valid; i++) {
 		if (!trip) {
 			*type = THERMAL_TRIP_ACTIVE;
 			return 0;
@@ -569,30 +572,30 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 	if (!tz || trip < 0)
 		return -EINVAL;
 
-	if (tz->trips.critical.flags.valid) {
+	if (tz->critical.flags.valid) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
-				tz->trips.critical.temperature,
+				tz->critical.temperature,
 				tz->kelvin_offset);
 			return 0;
 		}
 		trip--;
 	}
 
-	if (tz->trips.hot.flags.valid) {
+	if (tz->hot.flags.valid) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
-				tz->trips.hot.temperature,
+				tz->hot.temperature,
 				tz->kelvin_offset);
 			return 0;
 		}
 		trip--;
 	}
 
-	if (tz->trips.passive.flags.valid) {
+	if (tz->passive.flags.valid) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
-				tz->trips.passive.temperature,
+				tz->passive.temperature,
 				tz->kelvin_offset);
 			return 0;
 		}
@@ -600,10 +603,10 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 	}
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
-		tz->trips.active[i].flags.valid; i++) {
+		tz->active[i].flags.valid; i++) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
-				tz->trips.active[i].temperature,
+				tz->active[i].temperature,
 				tz->kelvin_offset);
 			return 0;
 		}
@@ -618,9 +621,9 @@ static int thermal_get_crit_temp(struct thermal_zone_device *thermal,
 {
 	struct acpi_thermal *tz = thermal->devdata;
 
-	if (tz->trips.critical.flags.valid) {
+	if (tz->critical.flags.valid) {
 		*temperature = deci_kelvin_to_millicelsius_with_offset(
-				tz->trips.critical.temperature,
+				tz->critical.temperature,
 				tz->kelvin_offset);
 		return 0;
 	} else
@@ -657,9 +660,9 @@ static int thermal_get_trend(struct thermal_zone_device *thermal,
 	 * tz->temperature has already been updated by generic thermal layer,
 	 * before this callback being invoked
 	 */
-	i = (tz->trips.passive.tc1 * (tz->temperature - tz->last_temperature))
-		+ (tz->trips.passive.tc2
-		* (tz->temperature - tz->trips.passive.temperature));
+	i = (tz->passive.tc1 * (tz->temperature - tz->last_temperature))
+		+ (tz->passive.tc2
+		* (tz->temperature - tz->passive.temperature));
 
 	if (i > 0)
 		*trend = THERMAL_TREND_RAISING;
@@ -703,17 +706,17 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
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
-		for (i = 0; i < tz->trips.passive.devices.count;
+		for (i = 0; i < tz->passive.devices.count;
 		    i++) {
-			handle = tz->trips.passive.devices.handles[i];
+			handle = tz->passive.devices.handles[i];
 			dev = acpi_fetch_acpi_dev(handle);
 			if (dev != device)
 				continue;
@@ -733,13 +736,13 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
 	}
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		if (!tz->trips.active[i].flags.valid)
+		if (!tz->active[i].flags.valid)
 			break;
 		trip++;
 		for (j = 0;
-		    j < tz->trips.active[i].devices.count;
+		    j < tz->active[i].devices.count;
 		    j++) {
-			handle = tz->trips.active[i].devices.handles[j];
+			handle = tz->active[i].devices.handles[j];
 			dev = acpi_fetch_acpi_dev(handle);
 			if (dev != device)
 				continue;
@@ -793,23 +796,23 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
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
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
-			tz->trips.active[i].flags.valid; i++, trips++);
+			tz->active[i].flags.valid; i++, trips++);
 
-	if (tz->trips.passive.flags.valid)
+	if (tz->passive.flags.valid)
 		tz->thermal_zone =
 			thermal_zone_device_register("acpitz", trips, 0, tz,
 						&acpi_thermal_zone_ops, NULL,
-						     tz->trips.passive.tsp*100,
+						     tz->passive.tsp*100,
 						     tz->polling_frequency*100);
 	else
 		tz->thermal_zone =
@@ -986,8 +989,8 @@ static int acpi_thermal_get_info(struct acpi_thermal *tz)
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
@@ -1097,19 +1100,19 @@ static int acpi_thermal_resume(struct device *dev)
 		return -EINVAL;
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		if (!tz->trips.active[i].flags.valid)
+		if (!tz->active[i].flags.valid)
 			break;
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

