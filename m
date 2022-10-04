Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996F65F4875
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiJDR1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJDR1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:27:18 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DBD6555A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:27:14 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so607945wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 10:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruxSNDrAyIsZW86sIahAkKmDpVpE5j1H1T3C5bdYovs=;
        b=qT6Sc8H6U7PqP88ISMx9JRsYeDCfwmeX8XWzBqw95Zrw1oRDxbv2ZYcI9VAHdjwAB2
         pz5kjGKiYP9t4Yr3k+48GNB8t8PzobVT3ivtR840ofya6AZrG/4gmlkEuOj9wa16Jq20
         wFmzLe7iNFlxJLBDtGGzPXDqA4tk2jajpOYzizM68o1NlkZj6RivqqxNMIbX09vTGLxN
         vVlLa8wm/Ury9rWdCoarZ2aPoRntQwlzaFfH5z8whVoojLmuuwUi5kOWKZiirw7pO3fi
         oyi/oBrgMElJBlDuzedb60Iyuqf+K57GZsK7sv4bx12ik9RJY2hD8xtoue9Sbrd+rcFP
         CCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruxSNDrAyIsZW86sIahAkKmDpVpE5j1H1T3C5bdYovs=;
        b=ZAigLBRHJZPze87OoMce2f3aTaCBsnyghAHhDukjFLe3TtlJyIh5EyEiJ+UOSNIb7N
         QU0KuBDE/Wh12tI9iA6UrvYcYkN+SCMBEeEciBxaCFadR+zc1YH3K2XnvIHa5fpaGj7a
         JUOmpTtkJI5/Kkykw5M3L1y93+PB7F6+Vdc4nrtGXxSrxGWUqxvnBQDUBG52UxwTT9c2
         i437j/U1AnC5Ux5atTEy+XbvXsmr7x3GtCWkX9mRva3bfMFmqDaivykKDyfI67MGyoVG
         TmgBc8Zqj4ndfjtONvEoVDZrWKvvlPP8e+lqgzklJUp8XdBR2l12VogGHhzxKoRzFjqu
         MICA==
X-Gm-Message-State: ACrzQf0LEEiRV428jV4+meQV1wyfQK2em4378sZmv4K4onHCyg8vjvY1
        o0sVgJ5KfiUcf+CvuSzjyRyyk2Ug9EJVeA==
X-Google-Smtp-Source: AMsMyM6XiJfl/UzOMKRZDskQDdM+15btP26qbCA/h4X62O/v3STY2X5zlfvron0IxxKvFOluIQLvVg==
X-Received: by 2002:a1c:cc0e:0:b0:3b4:fda3:c808 with SMTP id h14-20020a1ccc0e000000b003b4fda3c808mr573627wmb.146.1664904432111;
        Tue, 04 Oct 2022 10:27:12 -0700 (PDT)
Received: from mai.. ([2a05:6e02:1041:c10:c456:8337:99aa:2667])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm13060941wrc.62.2022.10.04.10.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 10:27:11 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH RFC 4/9] thermal/acpi: Move the active trip points to the same array
Date:   Tue,  4 Oct 2022 19:26:53 +0200
Message-Id: <20221004172658.2302511-5-daniel.lezcano@linaro.org>
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

This change does the second pass to move the active trip points in the
thermal trip array.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 75 +++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 38 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 8bf2b25acdf1..ce37494bd133 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -153,7 +153,6 @@ struct acpi_thermal {
 	struct acpi_thermal_flags flags;
 	struct acpi_thermal_state state;
 	struct acpi_thermal_trip trips[ACPI_THERMAL_TRIP_MAX];
-	struct acpi_thermal_trip active[ACPI_THERMAL_MAX_ACTIVE];
 	struct acpi_handle_list devices;
 	struct thermal_zone_device *thermal_zone;
 	int kelvin_offset;	/* in millidegrees */
@@ -383,68 +382,68 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 	}
 
 	/* Active (optional) */
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
+	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
 		char name[5] = { '_', 'A', 'C', ('0' + i), '\0' };
-		valid = tz->active[i].flags.valid;
+		valid = tz->trips[i].flags.valid;
 
 		if (act == -1)
 			break; /* disable all active trip points */
 
 		if ((flag == ACPI_TRIPS_INIT) || ((flag & ACPI_TRIPS_ACTIVE) &&
-			tz->active[i].flags.valid)) {
+			tz->trips[i].flags.valid)) {
 			status = acpi_evaluate_integer(tz->device->handle,
 							name, NULL, &tmp);
 			if (ACPI_FAILURE(status)) {
-				tz->active[i].flags.valid = 0;
+				tz->trips[i].flags.valid = 0;
 				if (i == 0)
 					break;
 				if (act <= 0)
 					break;
 				if (i == 1)
-					tz->active[0].temperature =
+					tz->trips[0].temperature =
 						celsius_to_deci_kelvin(act);
 				else
 					/*
 					 * Don't allow override higher than
 					 * the next higher trip point
 					 */
-					tz->active[i - 1].temperature =
-						(tz->active[i - 2].temperature <
+					tz->trips[i - 1].temperature =
+						(tz->trips[i - 2].temperature <
 						celsius_to_deci_kelvin(act) ?
-						tz->active[i - 2].temperature :
+						tz->trips[i - 2].temperature :
 						celsius_to_deci_kelvin(act));
 				break;
 			} else {
-				tz->active[i].temperature = tmp;
-				tz->active[i].flags.valid = 1;
+				tz->trips[i].temperature = tmp;
+				tz->trips[i].flags.valid = 1;
 			}
 		}
 
 		name[2] = 'L';
-		if ((flag & ACPI_TRIPS_DEVICES) && tz->active[i].flags.valid ) {
+		if ((flag & ACPI_TRIPS_DEVICES) && tz->trips[i].flags.valid ) {
 			memset(&devices, 0, sizeof(struct acpi_handle_list));
 			status = acpi_evaluate_reference(tz->device->handle,
 						name, NULL, &devices);
 			if (ACPI_FAILURE(status)) {
 				acpi_handle_info(tz->device->handle,
 						 "Invalid active%d threshold\n", i);
-				tz->active[i].flags.valid = 0;
+				tz->trips[i].flags.valid = 0;
 			}
 			else
-				tz->active[i].flags.valid = 1;
+				tz->trips[i].flags.valid = 1;
 
-			if (memcmp(&tz->active[i].devices, &devices,
+			if (memcmp(&tz->trips[i].devices, &devices,
 					sizeof(struct acpi_handle_list))) {
-				memcpy(&tz->active[i].devices, &devices,
+				memcpy(&tz->trips[i].devices, &devices,
 					sizeof(struct acpi_handle_list));
 				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
 			}
 		}
 		if ((flag & ACPI_TRIPS_ACTIVE) || (flag & ACPI_TRIPS_DEVICES))
-			if (valid != tz->active[i].flags.valid)
+			if (valid != tz->trips[i].flags.valid)
 				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
 
-		if (!tz->active[i].flags.valid)
+		if (!tz->trips[i].flags.valid)
 			break;
 	}
 
@@ -473,8 +472,8 @@ static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
 		tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid |
 		tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid;
 
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
-		valid |= tz->active[i].flags.valid;
+	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE; i++)
+		valid |= tz->trips[i].flags.valid;
 
 	if (!valid) {
 		pr_warn(FW_BUG "No valid trip found\n");
@@ -535,8 +534,8 @@ static int thermal_get_trip_type(struct thermal_zone_device *thermal,
 		trip--;
 	}
 
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
-		tz->active[i].flags.valid; i++) {
+	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE &&
+		tz->trips[i].flags.valid; i++) {
 		if (!trip) {
 			*type = THERMAL_TRIP_ACTIVE;
 			return 0;
@@ -586,11 +585,11 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 		trip--;
 	}
 
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
-		tz->active[i].flags.valid; i++) {
+	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE &&
+		tz->trips[i].flags.valid; i++) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
-				tz->active[i].temperature,
+				tz->trips[i].temperature,
 				tz->kelvin_offset);
 			return 0;
 		}
@@ -719,14 +718,14 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
 		}
 	}
 
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		if (!tz->active[i].flags.valid)
+	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
+		if (!tz->trips[i].flags.valid)
 			break;
 		trip++;
 		for (j = 0;
-		    j < tz->active[i].devices.count;
+		    j < tz->trips[i].devices.count;
 		    j++) {
-			handle = tz->active[i].devices.handles[j];
+			handle = tz->trips[i].devices.handles[j];
 			dev = acpi_fetch_acpi_dev(handle);
 			if (dev != device)
 				continue;
@@ -789,8 +788,8 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 	if (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid)
 		trips++;
 
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
-			tz->active[i].flags.valid; i++, trips++);
+	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE &&
+			tz->trips[i].flags.valid; i++, trips++);
 
 	if (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid)
 		tz->thermal_zone =
@@ -1083,20 +1082,20 @@ static int acpi_thermal_resume(struct device *dev)
 	if (!tz)
 		return -EINVAL;
 
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		if (!tz->active[i].flags.valid)
+	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
+		if (!tz->trips[i].flags.valid)
 			break;
-		tz->active[i].flags.enabled = 1;
-		for (j = 0; j < tz->active[i].devices.count; j++) {
+		tz->trips[i].flags.enabled = 1;
+		for (j = 0; j < tz->trips[i].devices.count; j++) {
 			result = acpi_bus_update_power(
-					tz->active[i].devices.handles[j],
+					tz->trips[i].devices.handles[j],
 					&power_state);
 			if (result || (power_state != ACPI_STATE_D0)) {
-				tz->active[i].flags.enabled = 0;
+				tz->trips[i].flags.enabled = 0;
 				break;
 			}
 		}
-		tz->state.active |= tz->active[i].flags.enabled;
+		tz->state.active |= tz->trips[i].flags.enabled;
 	}
 
 	acpi_queue_thermal_check(tz);
-- 
2.34.1

