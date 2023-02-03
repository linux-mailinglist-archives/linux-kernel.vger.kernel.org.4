Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274B668A0B3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbjBCRpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjBCRpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:45:04 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A8FA6C3B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:44:45 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h16so5304441wrz.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 09:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+5C4ydL02isaLKa3zc+GpYQSiiz854VPklETAp2HFU=;
        b=sG6xh8xQNejGSuKPUa4k/fJ86szxWvQ9HoNdYvHpioZo5m0dRyM6sTVyyY94whVgv6
         N1+sA9Tq1IoCDxCfHehebc2xGyzlY92iQjYq5zxyydxWelux8OI737w5gSXoNGhnDdYC
         1cADmm/gMMohMtZgar4AjsoCdYPEy2nkhEMn3x+/dSO3h7U9aNWqUCAqz+tyUEwSos5f
         OrcBootA7nuW5iqyPB8A0QRDmILWpt5cdql5Dzoi73rt8zP+5aJoYAgxPizkps4OdYzc
         Xr+JSJ9BLolzO0xmo7UAN5qTnU6GFt91wI9B9b5k0gsxWx7KDGIyzaOi8p5Ifz5qI6Or
         0TAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+5C4ydL02isaLKa3zc+GpYQSiiz854VPklETAp2HFU=;
        b=T7Q8qsFfJPNPODOqQqJGp965/en4HXsLBtgV4jx3yz+mah9eU1BRUGYcvZaIznqgY6
         nlXWN9wzGgKOa1wmjIYeFX5yMUgtmIJUcGafnjWWkJuO6y0Ym+IUnDI9wvQPe5870m7Y
         GjD7ilVh4xL34KLjb4IppdNuYNYmsxBBnig+vCjd2DbtL603mjeobbjubX1o/v6yQBM7
         U8KIb3idFQ9eFOFYPY2XSCOEA3iMkMlKvAyV7sMfiAMjrioZMWjkigZbArT+Ip8mauKX
         VJlS2RwM7EU1xy0jHw0rzl0awcD1tBCN505j2MBii2kqztG8pp09JYT1I8Wwejk4rI6n
         GzDg==
X-Gm-Message-State: AO0yUKWqURz0eGjRZ6Ud8jekrBwqnRfwqSIJ2VlrsAvBA/aJs7Bjzy7N
        vqYI/HbfOTPCFKnqHDfrmFKTQg==
X-Google-Smtp-Source: AK7set+/g5vP8p/e6zxCIdQYGAwSA5RSAGBsWkgRow0IIEBh34ietmzBe0bcXc1sCSEXq+DEpAgONw==
X-Received: by 2002:a5d:660f:0:b0:2bf:95cc:744c with SMTP id n15-20020a5d660f000000b002bf95cc744cmr10179895wru.0.1675446285470;
        Fri, 03 Feb 2023 09:44:45 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id z1-20020a5d4c81000000b002bdd8f12effsm2443528wrs.30.2023.02.03.09.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:44:45 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     daniel.lezcano@linaro.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 11/11] thermal/acpi: Use the thermal framework ACPI API
Date:   Fri,  3 Feb 2023 18:44:29 +0100
Message-Id: <20230203174429.3375691-12-daniel.lezcano@linaro.org>
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

From: Daniel Lezcano <daniel.lezcano@kernel.org>

The thermal framework has a set of functions to fill the trip
points. Those functions are already used by the int340x and the quark
Intel's platform.

Reuse these functions in order to consolidate the generic trip points
usage across the thermal ACPI user.

Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 85 +++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 47 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index f89236cd4fcd..5e4d93c67b75 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -259,8 +259,11 @@ static struct thermal_trip *acpi_thermal_trips_alloc_critical(struct acpi_therma
 							      struct thermal_trip *trips,
 							      int *num_trips)
 {
-	acpi_status status = AE_OK;
-	unsigned long long temp;
+	struct thermal_trip trip = {
+		.type = THERMAL_TRIP_CRITICAL,
+	};
+
+	int ret;
 
 	/*
 	 * Module parameters disable the critical trip point
@@ -268,14 +271,12 @@ static struct thermal_trip *acpi_thermal_trips_alloc_critical(struct acpi_therma
 	if (crt < 0)
 		goto out;
 
-	status = acpi_evaluate_integer(tz->device->handle, "_CRT", NULL, &temp);
-	if (ACPI_FAILURE(status)) {
-		acpi_handle_debug(tz->device->handle, "No critical threshold\n");
+	ret = thermal_acpi_critical_trip_temp(tz->device->handle, &trip.temperature);
+	if (ret)
 		goto out;
-	}
-
-	if (temp <= 2732) {
-		pr_info(FW_BUG "Invalid critical threshold (%llu)\n", temp);
+	
+	if (trip.temperature <= 0) {
+		pr_info(FW_BUG "Invalid critical threshold (%d)\n", trip.temperature);
 		goto out;
 	}
 
@@ -283,10 +284,7 @@ static struct thermal_trip *acpi_thermal_trips_alloc_critical(struct acpi_therma
 	if (!trips)
 		goto out;
 
-	memset(&trips[*num_trips], 0, sizeof(*trips));
-
-	trips[*num_trips].temperature = deci_kelvin_to_millicelsius(temp);
-	trips[*num_trips].type = THERMAL_TRIP_CRITICAL;
+	trips[*num_trips] = trip; /* structure copy */
 
 	if (crt > 0)
 		acpi_thermal_trips_override(&trips[*num_trips], crt * MILLI);
@@ -300,23 +298,21 @@ static struct thermal_trip *acpi_thermal_trips_alloc_hot(struct acpi_thermal *tz
 							 struct thermal_trip *trips,
 							 int *num_trips)
 {
-	acpi_status status;
-	unsigned long long temp;
+	struct thermal_trip trip = {
+		.type = THERMAL_TRIP_HOT,
+	};
 
-	status = acpi_evaluate_integer(tz->device->handle, "_HOT", NULL, &temp);
-	if (ACPI_FAILURE(status)) {
-		acpi_handle_debug(tz->device->handle, "No hot threshold\n");
+	int ret;
+
+	ret = thermal_acpi_hot_trip_temp(tz->device->handle, &trip.temperature);
+	if (ret)
 		goto out;
-	}
 
 	trips = krealloc(trips, sizeof(*trips) * (*num_trips + 1), GFP_KERNEL);
 	if (!trips)
 		goto out;
 
-	memset(&trips[*num_trips], 0, sizeof(*trips));
-
-	trips[*num_trips].temperature = deci_kelvin_to_millicelsius(temp);
-	trips[*num_trips].type = THERMAL_TRIP_HOT;
+	trips[*num_trips] = trip; /* structure copy */
 	
 	(*num_trips)++;
 out:
@@ -327,9 +323,12 @@ static struct thermal_trip *acpi_thermal_trips_alloc_passive(struct acpi_thermal
 							     struct thermal_trip *trips,
 							     int *num_trips)
 {
-	struct acpi_handle_list devices;
 	acpi_status status;
-	unsigned long long temp;
+	struct acpi_handle_list devices;
+	struct thermal_trip trip = {
+		.type = THERMAL_TRIP_PASSIVE
+	};
+	int ret;
 
 	/*
 	 * Module parameters disable all passive trip points
@@ -337,26 +336,21 @@ static struct thermal_trip *acpi_thermal_trips_alloc_passive(struct acpi_thermal
 	if (psv < 0)
 		goto out;
 	
-	status = acpi_evaluate_integer(tz->device->handle, "_PSV", NULL, &temp);
-	if (ACPI_FAILURE(status)) {
-		acpi_handle_debug(tz->device->handle, "No passive threshold\n");
+	ret = thermal_acpi_passive_trip_temp(tz->device->handle, &trip.temperature);
+	if (ret)
 		goto out;
-	}
-
+	
 	status = acpi_evaluate_reference(tz->device->handle, "_PSL", NULL, &devices);
 	if (ACPI_FAILURE(status)) {
 		acpi_handle_debug(tz->device->handle, "No passive device associated\n");
 		goto out;
 	}
-	
+
 	trips = krealloc(trips, sizeof(*trips) * (*num_trips + 1), GFP_KERNEL);
 	if (!trips)
 		goto out;
 
-	memset(&trips[*num_trips], 0, sizeof(*trips));
-
-	trips[*num_trips].temperature = deci_kelvin_to_millicelsius(temp);
-	trips[*num_trips].type = THERMAL_TRIP_PASSIVE;
+	trips[*num_trips] = trip; /* structure copy */	
 	
 	(*num_trips)++;
 out:
@@ -367,10 +361,9 @@ static struct thermal_trip *acpi_thermal_trips_alloc_active(struct acpi_thermal
 							    struct thermal_trip *trips,
 							    int *num_trips)
 {
-	struct acpi_handle_list devices;
 	acpi_status status;
-	unsigned long long temp;
-	int i;
+	struct acpi_handle_list devices;
+	int i, ret;
 
 	/*
 	 * Module parameters disable all active trip points
@@ -379,12 +372,13 @@ static struct thermal_trip *acpi_thermal_trips_alloc_active(struct acpi_thermal
 		return trips;
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
+		struct thermal_trip trip = {
+			.type = THERMAL_TRIP_ACTIVE,
+		};
 		char name[5];
 
-		sprintf(name, "_AC%d", i);
-
-		status = acpi_evaluate_integer(tz->device->handle, name, NULL, &temp);
-		if (ACPI_FAILURE(status))
+		ret = thermal_acpi_active_trip_temp(tz->device->handle, i , &trip.temperature);
+		if (ret)
 			break;
 
 		sprintf(name, "_AL%d", i);
@@ -394,16 +388,13 @@ static struct thermal_trip *acpi_thermal_trips_alloc_active(struct acpi_thermal
 			acpi_handle_info(tz->device->handle, "No _AL%d defined for _AC%d\n", i, i);
 			break;
 		}
-
+		
 		trips = krealloc(trips, sizeof(*trips) * (*num_trips + 1), GFP_KERNEL);
 		if (!trips)
 			break;
 
-		memset(&trips[*num_trips], 0, sizeof(*trips));
+		trips[*num_trips] = trip; /* structure copy */	
 
-		trips[*num_trips].temperature = deci_kelvin_to_millicelsius(temp);
-		trips[*num_trips].type = THERMAL_TRIP_ACTIVE;
-	
 		(*num_trips)++;
 	}
 
-- 
2.34.1

