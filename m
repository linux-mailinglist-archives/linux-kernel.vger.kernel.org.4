Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64405F4877
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiJDR1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiJDR1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:27:19 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E0865809
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:27:17 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so980725wmr.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 10:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JV78r0khKIiVMoqle2Ji/80JCnIJufCj0psslXCqQ5A=;
        b=F6wDpcwl5ot3TQcMzPUxRoigjYRXF3M2Y2IAQ2j85gh1vseO7Eo0xFf9d8xlgCQPeK
         mWfqR/Q/obiFkQmLP90BbfZXT+AafX6xFDCtQqLfL5B2U+H5aotBBpxz79HxjOfWxeee
         fcPUHhp0xp1yMoHPMQDWF/lelYJBs6ZrslFrk2EowpZ1tHynvx6Qz6IlY1SRwgbwcqAN
         qWVN48XBdgGbzDwe5MMPXtfBsQRzV2GRQUi+PIgqg5Bd0fNoUjD77GOiHxGXAa2cGZ0n
         LjlxrLOCc3FmPhY1GdZQ/ZpW2DZKE1r6cbPify6A1QO2iCGCJmegsdXUqxnXh0QPhHik
         HIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JV78r0khKIiVMoqle2Ji/80JCnIJufCj0psslXCqQ5A=;
        b=BmyRbnmWC56eS5entEkaR14uihmzcIi1mEn50w9ncXW6/8iveNQ0nipvJeFAPtE6NV
         64oVIqYbrRFSGIuQgHltDWwqzaeTwDp1W+E0plk3ayrz86+3YsPG6AKnNT+UNsKfBNYf
         /5TMbaQB/8IeKdhqWWhWaInErg8BJdnRIxiLeRkcYYnpwjqVTWCpkzcRb8+VEI89O+MG
         hcZv+7mjnpTQlTYgYtlBLscduWXCMPKAS8l7Jgby22f6UOxLeODHJYC8sDOFsjQpteSF
         ae+LsuBv2aS+8CDMreGi9b2SClsyAlNjGsYNQD5T9rO7XbsI9Qpjq/V55RmYqCAKUC2Y
         5I8A==
X-Gm-Message-State: ACrzQf1ZH5EjN++XBiQEnxAi+X6JzB9oSlbDJ6NeGtLgR/mWaGXz32zi
        NUxGW98nWkGY2Kf7TZ8tkW8zDPH4kFdbaQ==
X-Google-Smtp-Source: AMsMyM4fF1yhBIxAQ1lvjEfocDTVgWjd/SuzwVIm6gIeECdmc+PYKnm1lKeoxZTYCDZHaxMdAXv9kw==
X-Received: by 2002:a05:600c:21c7:b0:3bd:ef29:2d08 with SMTP id x7-20020a05600c21c700b003bdef292d08mr563673wmj.177.1664904434840;
        Tue, 04 Oct 2022 10:27:14 -0700 (PDT)
Received: from mai.. ([2a05:6e02:1041:c10:c456:8337:99aa:2667])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm13060941wrc.62.2022.10.04.10.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 10:27:14 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH RFC 6/9] thermal/acpi: Encapsualte in functions the trip initialization
Date:   Tue,  4 Oct 2022 19:26:55 +0200
Message-Id: <20221004172658.2302511-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221004172658.2302511-1-daniel.lezcano@linaro.org>
References: <12068304.O9o76ZdvQC@kreacher>
 <20221004172658.2302511-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal trip update function is a bit difficult to read. In order
to improve its readability, let's encapuslate the different parts into
dedicated functions.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 267 ++++++++++++++++++++++++-----------------
 1 file changed, 159 insertions(+), 108 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 9841b597a9c7..e62381561255 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -246,117 +246,123 @@ do {	\
 		"Please report to linux-acpi@vger.kernel.org\n", str); \
 } while (0)
 
-static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
+static int acpi_thermal_trips_update_critical(struct acpi_thermal *tz, int flag)
 {
 	acpi_status status = AE_OK;
 	unsigned long long tmp;
-	struct acpi_handle_list devices;
-	int valid = 0;
-	int i;
 
-	/* Critical Shutdown */
-	if (flag & ACPI_TRIPS_CRITICAL) {
-		status = acpi_evaluate_integer(tz->device->handle,
+	status = acpi_evaluate_integer(tz->device->handle,
 				"_CRT", NULL, &tmp);
-		tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature = tmp;
-		/*
-		 * Treat freezing temperatures as invalid as well; some
-		 * BIOSes return really low values and cause reboots at startup.
-		 * Below zero (Celsius) values clearly aren't right for sure..
-		 * ... so lets discard those as invalid.
-		 */
-		if (ACPI_FAILURE(status)) {
-			tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 0;
-			acpi_handle_debug(tz->device->handle,
-					  "No critical threshold\n");
-		} else if (tmp <= 2732) {
-			pr_info(FW_BUG "Invalid critical threshold (%llu)\n",
-				tmp);
+	tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature = tmp;
+	/*
+	 * Treat freezing temperatures as invalid as well; some
+	 * BIOSes return really low values and cause reboots at startup.
+	 * Below zero (Celsius) values clearly aren't right for sure..
+	 * ... so lets discard those as invalid.
+	 */
+	if (ACPI_FAILURE(status)) {
+		tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 0;
+		acpi_handle_debug(tz->device->handle,
+				  "No critical threshold\n");
+	} else if (tmp <= 2732) {
+		pr_info(FW_BUG "Invalid critical threshold (%llu)\n",
+			tmp);
+		tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 0;
+	} else {
+		tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 1;
+		acpi_handle_debug(tz->device->handle,
+				  "Found critical threshold [%lu]\n",
+				  tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature);
+	}
+	if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid == 1) {
+		if (crt == -1) {
 			tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 0;
-		} else {
-			tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 1;
-			acpi_handle_debug(tz->device->handle,
-					  "Found critical threshold [%lu]\n",
-					  tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature);
-		}
-		if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid == 1) {
-			if (crt == -1) {
-				tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 0;
-			} else if (crt > 0) {
-				unsigned long crt_k = celsius_to_deci_kelvin(crt);
-
-				/*
-				 * Allow override critical threshold
-				 */
-				if (crt_k > tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature)
-					pr_info("Critical threshold %d C\n", crt);
-
-				tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature = crt_k;
-			}
+		} else if (crt > 0) {
+			unsigned long crt_k = celsius_to_deci_kelvin(crt);
+
+			/*
+			 * Allow override critical threshold
+			 */
+			if (crt_k > tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature)
+				pr_info("Critical threshold %d C\n", crt);
+
+			tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature = crt_k;
 		}
 	}
 
-	/* Critical Sleep (optional) */
-	if (flag & ACPI_TRIPS_HOT) {
-		status = acpi_evaluate_integer(tz->device->handle,
-				"_HOT", NULL, &tmp);
-		if (ACPI_FAILURE(status)) {
-			tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid = 0;
-			acpi_handle_debug(tz->device->handle,
-					  "No hot threshold\n");
-		} else {
-			tz->trips[ACPI_THERMAL_TRIP_HOT].temperature = tmp;
-			tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid = 1;
-			acpi_handle_debug(tz->device->handle,
-					  "Found hot threshold [%lu]\n",
-					  tz->trips[ACPI_THERMAL_TRIP_HOT].temperature);
-		}
+	return 0;
+}
+
+static int acpi_thermal_trips_update_hot(struct acpi_thermal *tz, int flag)
+{
+	acpi_status status = AE_OK;
+	unsigned long long tmp;
+
+	status = acpi_evaluate_integer(tz->device->handle,
+				       "_HOT", NULL, &tmp);
+	if (ACPI_FAILURE(status)) {
+		tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid = 0;
+		acpi_handle_debug(tz->device->handle,
+				  "No hot threshold\n");
+	} else {
+		tz->trips[ACPI_THERMAL_TRIP_HOT].temperature = tmp;
+		tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid = 1;
+		acpi_handle_debug(tz->device->handle,
+				  "Found hot threshold [%lu]\n",
+				  tz->trips[ACPI_THERMAL_TRIP_HOT].temperature);
 	}
 
-	/* Passive (optional) */
-	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid) ||
-		(flag == ACPI_TRIPS_INIT)) {
-		valid = tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid;
-		if (psv == -1) {
-			status = AE_SUPPORT;
-		} else if (psv > 0) {
-			tmp = celsius_to_deci_kelvin(psv);
-			status = AE_OK;
-		} else {
-			status = acpi_evaluate_integer(tz->device->handle,
-				"_PSV", NULL, &tmp);
-		}
+	return 0;
+}
 
-		if (ACPI_FAILURE(status))
-			tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
-		else {
-			tz->trips[ACPI_THERMAL_TRIP_PASSIVE].temperature = tmp;
-			tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 1;
-			if (flag == ACPI_TRIPS_INIT) {
-				status = acpi_evaluate_integer(
-						tz->device->handle, "_TC1",
-						NULL, &tmp);
-				if (ACPI_FAILURE(status))
-					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
-				else
-					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tc1 = tmp;
-				status = acpi_evaluate_integer(
-						tz->device->handle, "_TC2",
-						NULL, &tmp);
-				if (ACPI_FAILURE(status))
-					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
-				else
-					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tc2 = tmp;
-				status = acpi_evaluate_integer(
-						tz->device->handle, "_TSP",
-						NULL, &tmp);
-				if (ACPI_FAILURE(status))
-					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
-				else
-					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tsp = tmp;
-			}
+static int acpi_thermal_trips_update_passive(struct acpi_thermal *tz, int flag)
+{
+	acpi_status status = AE_OK;
+	unsigned long long tmp;
+	struct acpi_handle_list devices;
+	int valid = 0;
+
+	valid = tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid;
+	if (psv == -1) {
+		status = AE_SUPPORT;
+	} else if (psv > 0) {
+		tmp = celsius_to_deci_kelvin(psv);
+		status = AE_OK;
+	} else {
+		status = acpi_evaluate_integer(tz->device->handle,
+					       "_PSV", NULL, &tmp);
+	}
+
+	if (ACPI_FAILURE(status))
+		tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
+	else {
+		tz->trips[ACPI_THERMAL_TRIP_PASSIVE].temperature = tmp;
+		tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 1;
+		if (flag == ACPI_TRIPS_INIT) {
+			status = acpi_evaluate_integer(
+				tz->device->handle, "_TC1",
+				NULL, &tmp);
+			if (ACPI_FAILURE(status))
+				tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
+			else
+				tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tc1 = tmp;
+			status = acpi_evaluate_integer(
+				tz->device->handle, "_TC2",
+				NULL, &tmp);
+			if (ACPI_FAILURE(status))
+				tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
+			else
+				tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tc2 = tmp;
+			status = acpi_evaluate_integer(
+				tz->device->handle, "_TSP",
+				NULL, &tmp);
+			if (ACPI_FAILURE(status))
+				tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
+			else
+				tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tsp = tmp;
 		}
 	}
+
 	if ((flag & ACPI_TRIPS_DEVICES) && tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid) {
 		memset(&devices, 0, sizeof(struct acpi_handle_list));
 		status = acpi_evaluate_reference(tz->device->handle, "_PSL",
@@ -376,12 +382,23 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
 		}
 	}
+
 	if ((flag & ACPI_TRIPS_PASSIVE) || (flag & ACPI_TRIPS_DEVICES)) {
 		if (valid != tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid)
-				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
+			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
 	}
 
-	/* Active (optional) */
+	return 0;
+}
+
+static int acpi_thermal_trips_update_active(struct acpi_thermal *tz, int flag)
+{
+	acpi_status status = AE_OK;
+	unsigned long long tmp;
+	struct acpi_handle_list devices;
+	int valid = 0;
+	int i;
+
 	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
 		char name[5] = { '_', 'A', 'C', ('0' + i), '\0' };
 		valid = tz->trips[i].flags.valid;
@@ -447,17 +464,51 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 			break;
 	}
 
-	if (flag & ACPI_TRIPS_DEVICES) {
-		memset(&devices, 0, sizeof(devices));
-		status = acpi_evaluate_reference(tz->device->handle, "_TZD",
-						NULL, &devices);
-		if (ACPI_SUCCESS(status)
-		    && memcmp(&tz->devices, &devices, sizeof(devices))) {
-			tz->devices = devices;
-			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
-		}
+	return 0;
+}
+
+static int acpi_thermal_trips_update_devices(struct acpi_thermal *tz, int flag)
+{
+	acpi_status status = AE_OK;
+	struct acpi_handle_list devices;
+
+	memset(&devices, 0, sizeof(devices));
+	status = acpi_evaluate_reference(tz->device->handle, "_TZD",
+					 NULL, &devices);
+	if (ACPI_SUCCESS(status)
+	    && memcmp(&tz->devices, &devices, sizeof(devices))) {
+		tz->devices = devices;
+		ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
+	}
+
+	return 0;
+}
+
+static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
+{
+	/* Critical Shutdown */
+	if (flag & ACPI_TRIPS_CRITICAL) {
+		acpi_thermal_trips_update_critical(tz, flag);
 	}
 
+	/* Critical Sleep (optional) */
+	if (flag & ACPI_TRIPS_HOT) {
+		acpi_thermal_trips_update_hot(tz, flag);
+	}
+
+	/* Passive (optional) */
+	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid) ||
+		(flag == ACPI_TRIPS_INIT)) {
+		acpi_thermal_trips_update_passive(tz, flag);
+	}
+
+	/* Active (optional) */
+	acpi_thermal_trips_update_active(tz, flag);
+
+	if (flag & ACPI_TRIPS_DEVICES) {
+		acpi_thermal_trips_update_devices(tz, flag);
+	}
+	
 	return 0;
 }
 
-- 
2.34.1

