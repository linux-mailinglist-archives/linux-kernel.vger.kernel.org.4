Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE48F64A908
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiLLU7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbiLLU7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:59:03 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE62A17059
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:59:01 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so6345034wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dPwTgj60rD2ScCmM1mcgWB2TrQuz9RZ91iwzhvccN0=;
        b=qEj26m87uBR7HunNW7xPqy/nqdrnjjRX059UddqhJ4MsEidfxF1UoizL4n+xp7djN3
         NrbhamvD4Zu8JDYJarZdwvOa5f6TScKZq55w0VpoClYGl/vDQIFa3oEB2xu74R7VcpHG
         xOvU4Bwos15wSAkmMawgmQOCVDfzlTlbKIrfTHifHaq4fUsRpSakwCqCIZjQeKmiV9VW
         XOhIJsYzdxaUAiW4xq7by98Itvv96fj19uE2J1BrGFjz6lgl7MXvLHHtD5r/+dmKpCH6
         KoNruT9jfmwfJ/NpZ19zChL+T3Anfb1RwMA+x+74/1a8IMCkgk2XUT640m48IR49XBaK
         obdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dPwTgj60rD2ScCmM1mcgWB2TrQuz9RZ91iwzhvccN0=;
        b=HgQmpn5BcTziUc9Rqp8A7gCjseize4/Nw5uNIOXyhK3NiN6fCcsKcRLWYPlntGb0XE
         yKBeQbfY1TsYAyAK/p4CLmsHQjfs/jjV5r13hHWuiMpZhntjZQajl4/dicwXTAowQWxc
         eiFXI+0l9uiZhx49VhJcCcAoT3l2ov5m3UNMpzwgPF9BZY5t8kvAe0uXSKWxxjRa8x7b
         I8y2jwuDU9xrk72CBj0wbj6dF/Ve5GIsVn4qlFEUJjUj36/N2ObHE7d1a6MAYnOBRDTJ
         TSSpmmyuKeaUpXIZ4HjUHOdwGGjRMOKTqPDUkkMnsd5SYyogBc47Ork6j0MCWwBgxB4a
         0unQ==
X-Gm-Message-State: ANoB5plncNRDYpCzdo2owz2EKihLFsajNBTYxpiLr8uhwcaWHtndgHQI
        mZnXjtDsoaYOOZNmRQpy6cY5xw==
X-Google-Smtp-Source: AA0mqf6H9JvOqLzvNzLNx4/Gr0yRURerDP93sdiLL0OHVviHRtKjYoJVlLgCr2BdIRZYZtP2M8s3JA==
X-Received: by 2002:a7b:c406:0:b0:3cf:a0f6:1942 with SMTP id k6-20020a7bc406000000b003cfa0f61942mr14322255wmi.34.1670878740415;
        Mon, 12 Dec 2022 12:59:00 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id t123-20020a1c4681000000b003a3170a7af9sm10537201wma.4.2022.12.12.12.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 12:59:00 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
X-Google-Original-From: Daniel Lezcano <daniel.lezcano@kernel.org>
To:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] thermal/drivers/intel: Use generic trip points int340x
Date:   Mon, 12 Dec 2022 21:58:41 +0100
Message-Id: <20221212205843.3119407-4-daniel.lezcano@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221212205843.3119407-1-daniel.lezcano@kernel.org>
References: <20221212205843.3119407-1-daniel.lezcano@kernel.org>
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

From: Daniel Lezcano <daniel.lezcano@linaro.org>

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 .../int340x_thermal/int340x_thermal_zone.c    | 175 ++++--------------
 .../int340x_thermal/int340x_thermal_zone.h    |  10 +-
 2 files changed, 40 insertions(+), 145 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 228f44260b27..4f2e518caf8d 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -37,65 +37,6 @@ static int int340x_thermal_get_zone_temp(struct thermal_zone_device *zone,
 	return 0;
 }
 
-static int int340x_thermal_get_trip_temp(struct thermal_zone_device *zone,
-					 int trip, int *temp)
-{
-	struct int34x_thermal_zone *d = zone->devdata;
-	int i;
-
-	if (trip < d->aux_trip_nr)
-		*temp = d->aux_trips[trip];
-	else if (trip == d->crt_trip_id)
-		*temp = d->crt_temp;
-	else if (trip == d->psv_trip_id)
-		*temp = d->psv_temp;
-	else if (trip == d->hot_trip_id)
-		*temp = d->hot_temp;
-	else {
-		for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
-			if (d->act_trips[i].valid &&
-			    d->act_trips[i].id == trip) {
-				*temp = d->act_trips[i].temp;
-				break;
-			}
-		}
-		if (i == INT340X_THERMAL_MAX_ACT_TRIP_COUNT)
-			return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int int340x_thermal_get_trip_type(struct thermal_zone_device *zone,
-					 int trip,
-					 enum thermal_trip_type *type)
-{
-	struct int34x_thermal_zone *d = zone->devdata;
-	int i;
-
-	if (trip < d->aux_trip_nr)
-		*type = THERMAL_TRIP_PASSIVE;
-	else if (trip == d->crt_trip_id)
-		*type = THERMAL_TRIP_CRITICAL;
-	else if (trip == d->hot_trip_id)
-		*type = THERMAL_TRIP_HOT;
-	else if (trip == d->psv_trip_id)
-		*type = THERMAL_TRIP_PASSIVE;
-	else {
-		for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
-			if (d->act_trips[i].valid &&
-			    d->act_trips[i].id == trip) {
-				*type = THERMAL_TRIP_ACTIVE;
-				break;
-			}
-		}
-		if (i == INT340X_THERMAL_MAX_ACT_TRIP_COUNT)
-			return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int int340x_thermal_set_trip_temp(struct thermal_zone_device *zone,
 				      int trip, int temp)
 {
@@ -109,25 +50,6 @@ static int int340x_thermal_set_trip_temp(struct thermal_zone_device *zone,
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
-	d->aux_trips[trip] = temp;
-
-	return 0;
-}
-
-
-static int int340x_thermal_get_trip_hyst(struct thermal_zone_device *zone,
-		int trip, int *temp)
-{
-	struct int34x_thermal_zone *d = zone->devdata;
-	acpi_status status;
-	unsigned long long hyst;
-
-	status = acpi_evaluate_integer(d->adev->handle, "GTSH", NULL, &hyst);
-	if (ACPI_FAILURE(status))
-		*temp = 0;
-	else
-		*temp = hyst * 100;
-
 	return 0;
 }
 
@@ -138,58 +60,36 @@ static void int340x_thermal_critical(struct thermal_zone_device *zone)
 
 static struct thermal_zone_device_ops int340x_thermal_zone_ops = {
 	.get_temp       = int340x_thermal_get_zone_temp,
-	.get_trip_temp	= int340x_thermal_get_trip_temp,
-	.get_trip_type	= int340x_thermal_get_trip_type,
 	.set_trip_temp	= int340x_thermal_set_trip_temp,
-	.get_trip_hyst =  int340x_thermal_get_trip_hyst,
 	.critical	= int340x_thermal_critical,
 };
 
-static int int340x_thermal_get_trip_config(acpi_handle handle, char *name,
-				      int *temp)
-{
-	unsigned long long r;
-	acpi_status status;
-
-	status = acpi_evaluate_integer(handle, name, NULL, &r);
-	if (ACPI_FAILURE(status))
-		return -EIO;
-
-	*temp = deci_kelvin_to_millicelsius(r);
-
-	return 0;
-}
-
 int int340x_thermal_read_trips(struct int34x_thermal_zone *int34x_zone)
 {
-	int trip_cnt = int34x_zone->aux_trip_nr;
-	int i;
+	int trip_cnt;
+	int i, ret;
 
-	int34x_zone->crt_trip_id = -1;
-	if (!int340x_thermal_get_trip_config(int34x_zone->adev->handle, "_CRT",
-					     &int34x_zone->crt_temp))
-		int34x_zone->crt_trip_id = trip_cnt++;
+	trip_cnt = int34x_zone->aux_trip_nr;
+	
+	ret = thermal_acpi_trip_crit(int34x_zone->adev, &int34x_zone->trips[trip_cnt]);
+	if (!ret)
+		trip_cnt++;
 
-	int34x_zone->hot_trip_id = -1;
-	if (!int340x_thermal_get_trip_config(int34x_zone->adev->handle, "_HOT",
-					     &int34x_zone->hot_temp))
-		int34x_zone->hot_trip_id = trip_cnt++;
+	ret = thermal_acpi_trip_hot(int34x_zone->adev, &int34x_zone->trips[trip_cnt]);
+	if (!ret)
+		trip_cnt++;
 
-	int34x_zone->psv_trip_id = -1;
-	if (!int340x_thermal_get_trip_config(int34x_zone->adev->handle, "_PSV",
-					     &int34x_zone->psv_temp))
-		int34x_zone->psv_trip_id = trip_cnt++;
+	ret = thermal_acpi_trip_psv(int34x_zone->adev, &int34x_zone->trips[trip_cnt]);
+	if (!ret)
+		trip_cnt++;
 
 	for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
-		char name[5] = { '_', 'A', 'C', '0' + i, '\0' };
 
-		if (int340x_thermal_get_trip_config(int34x_zone->adev->handle,
-					name,
-					&int34x_zone->act_trips[i].temp))
+		ret = thermal_acpi_trip_act(int34x_zone->adev, &int34x_zone->trips[trip_cnt], i);
+		if (ret)
 			break;
 
-		int34x_zone->act_trips[i].id = trip_cnt++;
-		int34x_zone->act_trips[i].valid = true;
+		trip_cnt++;
 	}
 
 	return trip_cnt;
@@ -208,7 +108,7 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 	acpi_status status;
 	unsigned long long trip_cnt;
 	int trip_mask = 0;
-	int ret;
+	int i, ret;
 
 	int34x_thermal_zone = kzalloc(sizeof(*int34x_thermal_zone),
 				      GFP_KERNEL);
@@ -228,32 +128,33 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 		int34x_thermal_zone->ops->get_temp = get_temp;
 
 	status = acpi_evaluate_integer(adev->handle, "PATC", NULL, &trip_cnt);
-	if (ACPI_FAILURE(status))
-		trip_cnt = 0;
-	else {
-		int i;
-
-		int34x_thermal_zone->aux_trips =
-			kcalloc(trip_cnt,
-				sizeof(*int34x_thermal_zone->aux_trips),
-				GFP_KERNEL);
-		if (!int34x_thermal_zone->aux_trips) {
-			ret = -ENOMEM;
-			goto err_trip_alloc;
-		}
-		trip_mask = BIT(trip_cnt) - 1;
+	if (!ACPI_FAILURE(status)) {
 		int34x_thermal_zone->aux_trip_nr = trip_cnt;
-		for (i = 0; i < trip_cnt; ++i)
-			int34x_thermal_zone->aux_trips[i] = THERMAL_TEMP_INVALID;
+		trip_mask = BIT(trip_cnt) - 1;
 	}
 
+	int34x_thermal_zone->trips = kzalloc(sizeof(*int34x_thermal_zone->trips) *
+					     (INT340X_THERMAL_MAX_TRIP_COUNT + trip_cnt),
+					      GFP_KERNEL);
+	if (!int34x_thermal_zone->trips) {
+		ret = -ENOMEM;
+		goto err_trips_alloc;
+	}
+
+	for (i = 0; i < trip_cnt; ++i) {
+		int34x_thermal_zone->trips[i].hysteresis = thermal_acpi_trip_gtsh(adev);
+		int34x_thermal_zone->trips[i].type = THERMAL_TRIP_PASSIVE;
+		int34x_thermal_zone->trips[i].temperature = THERMAL_TEMP_INVALID;
+	}
+	
 	trip_cnt = int340x_thermal_read_trips(int34x_thermal_zone);
 
 	int34x_thermal_zone->lpat_table = acpi_lpat_get_conversion_table(
 								adev->handle);
 
-	int34x_thermal_zone->zone = thermal_zone_device_register(
+	int34x_thermal_zone->zone = thermal_zone_device_register_with_trips(
 						acpi_device_bid(adev),
+						int34x_thermal_zone->trips,
 						trip_cnt,
 						trip_mask, int34x_thermal_zone,
 						int34x_thermal_zone->ops,
@@ -272,9 +173,9 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 err_enable:
 	thermal_zone_device_unregister(int34x_thermal_zone->zone);
 err_thermal_zone:
+	kfree(int34x_thermal_zone->trips);
 	acpi_lpat_free_conversion_table(int34x_thermal_zone->lpat_table);
-	kfree(int34x_thermal_zone->aux_trips);
-err_trip_alloc:
+err_trips_alloc:
 	kfree(int34x_thermal_zone->ops);
 err_ops_alloc:
 	kfree(int34x_thermal_zone);
@@ -287,7 +188,7 @@ void int340x_thermal_zone_remove(struct int34x_thermal_zone
 {
 	thermal_zone_device_unregister(int34x_thermal_zone->zone);
 	acpi_lpat_free_conversion_table(int34x_thermal_zone->lpat_table);
-	kfree(int34x_thermal_zone->aux_trips);
+	kfree(int34x_thermal_zone->trips);
 	kfree(int34x_thermal_zone->ops);
 	kfree(int34x_thermal_zone);
 }
diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
index e28ab1ba5e06..0c2c8de92014 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
@@ -10,6 +10,7 @@
 #include <acpi/acpi_lpat.h>
 
 #define INT340X_THERMAL_MAX_ACT_TRIP_COUNT	10
+#define INT340X_THERMAL_MAX_TRIP_COUNT INT340X_THERMAL_MAX_ACT_TRIP_COUNT + 3
 
 struct active_trip {
 	int temp;
@@ -19,15 +20,8 @@ struct active_trip {
 
 struct int34x_thermal_zone {
 	struct acpi_device *adev;
-	struct active_trip act_trips[INT340X_THERMAL_MAX_ACT_TRIP_COUNT];
-	unsigned long *aux_trips;
+	struct thermal_trip *trips;
 	int aux_trip_nr;
-	int psv_temp;
-	int psv_trip_id;
-	int crt_temp;
-	int crt_trip_id;
-	int hot_temp;
-	int hot_trip_id;
 	struct thermal_zone_device *zone;
 	struct thermal_zone_device_ops *ops;
 	void *priv_data;
-- 
2.34.1

