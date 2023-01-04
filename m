Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A373A65DFE4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 23:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240602AbjADWV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 17:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240575AbjADWVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 17:21:52 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3263FA0C
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 14:21:39 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h16so34421614wrz.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 14:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRpdkBF8vlGiGm4/xH4GyWurcWx8IXmtNRmJ/fowJgo=;
        b=U1TlV6bPwS2xr8bte26ZQ/I/hC7qBxWB48u9HAuWnIMZ6kOb4GWr8zRhd0TM3ixAd0
         9TCHr0a/AWUOKr0+LgpJoiqnJdvJhiF7v59qH8NcrTRGrUP62/0vNPiZgrb3c2PAewIV
         S8dG01KDfyOsKY4B1bjJOqiJ15S137i4aD8UxRLZNMinK8HOPmXMUaO16ASzeqS/tBDo
         SXiJASblRvnZZgj2C0HmqZPlCPIPb2uU0H37BmtgG+oqycWmkgMO2WpN7VlbwMxf2i2F
         H9mX9Ex2CeHFcLIpQYYKU/akSRqRmUIKAdw8q6tCiyro/Elas6i7UelRdxBj2tl2E38L
         zJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRpdkBF8vlGiGm4/xH4GyWurcWx8IXmtNRmJ/fowJgo=;
        b=rUSA7Ka4Q5CeXQ3EGnd93Kc4foNnSKKi6r3aLpbaj4vYVui1JOLDUON/kBTlHh/1LI
         R6/yC6HyuD/iINoHKPFrnrNBIH1LU+iLlYrcz0yoNAKVef6wqfsRgn68ganSzlpT8Qwg
         QQQUvfkVLU/sy4DGovdxeLMEXdrYd6o8jKVH4lv9CJEpHW7fID05fCNKpwlKvJYa/qRD
         nNCNL1BoW508Ka2JXudi4iWiKtklrPn4IDcdi/yo+S2jn/q4HSirUudMgAGlb91bqZFH
         I9cE8flykS/azFwrqtRniDsSH5mCDUPvEgfyC39C1urqaEoaHGTfoBQM1C9AYM2jONi8
         V4CA==
X-Gm-Message-State: AFqh2kqr2qKDUQrEI6icQRfRLJN1qlTZXROsZKTJW8fIXKa/lPx4ZJK1
        0YExVRwqFNqbWhaGaC8IyqRk3g==
X-Google-Smtp-Source: AMrXdXvudSgrHA0bF9cLFrhsDk49195ij1qrEoCSBBhRt+S9HpMnEjr4GcEMytg5IE+c9xBNbC8qBg==
X-Received: by 2002:adf:d084:0:b0:278:29ac:f894 with SMTP id y4-20020adfd084000000b0027829acf894mr22530677wrh.64.1672870897920;
        Wed, 04 Jan 2023 14:21:37 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l7-20020adfc787000000b002238ea5750csm42430278wrg.72.2023.01.04.14.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 14:21:37 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
X-Google-Original-From: Daniel Lezcano <daniel.lezcano@kernel.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, rui.zhang@intel.com,
        christophe.jaillet@wanadoo.fr, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v3 3/3] thermal/drivers/intel: Use generic trip points int340x
Date:   Wed,  4 Jan 2023 23:21:27 +0100
Message-Id: <20230104222127.2364396-4-daniel.lezcano@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230104222127.2364396-1-daniel.lezcano@kernel.org>
References: <20230104222127.2364396-1-daniel.lezcano@kernel.org>
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

From: Daniel Lezcano <daniel.lezcano@linaro.org>

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert the ops content logic into generic trip points and register
them with the thermal zone.

In order to consolidate the code, use the ACPI thermal framework API
to fill the generic trip point from the ACPI tables.

It has been tested on a Intel i7-8650U - x280 with the INT3400, the
PCH, ACPITZ, and x86_pkg_temp. No regression observed so far.

Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
   V3:
      - The driver Kconfig option selects CONFIG_THERMAL_ACPI
      - Change the initialization to use GTSH for the hysteresis on
        all the trip points

Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/thermal/intel/int340x_thermal/Kconfig |   1 +
 .../int340x_thermal/int340x_thermal_zone.c    | 177 ++++--------------
 .../int340x_thermal/int340x_thermal_zone.h    |  10 +-
 3 files changed, 43 insertions(+), 145 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig b/drivers/thermal/intel/int340x_thermal/Kconfig
index 5d046de96a5d..b7072d37101d 100644
--- a/drivers/thermal/intel/int340x_thermal/Kconfig
+++ b/drivers/thermal/intel/int340x_thermal/Kconfig
@@ -9,6 +9,7 @@ config INT340X_THERMAL
 	select THERMAL_GOV_USER_SPACE
 	select ACPI_THERMAL_REL
 	select ACPI_FAN
+	select THERMAL_ACPI
 	select INTEL_SOC_DTS_IOSF_CORE
 	select PROC_THERMAL_MMIO_RAPL if POWERCAP
 	help
diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 228f44260b27..626b33253153 100644
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
+
+	trip_cnt = int34x_zone->aux_trip_nr;
 
-	int34x_zone->crt_trip_id = -1;
-	if (!int340x_thermal_get_trip_config(int34x_zone->adev->handle, "_CRT",
-					     &int34x_zone->crt_temp))
-		int34x_zone->crt_trip_id = trip_cnt++;
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
@@ -228,32 +128,35 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
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
+	}
+
+	int34x_thermal_zone->trips = kzalloc(sizeof(*int34x_thermal_zone->trips) *
+					     (INT340X_THERMAL_MAX_TRIP_COUNT + trip_cnt),
+					      GFP_KERNEL);
+	if (!int34x_thermal_zone->trips) {
+		ret = -ENOMEM;
+		goto err_trips_alloc;
 	}
 
 	trip_cnt = int340x_thermal_read_trips(int34x_thermal_zone);
 
+	for (i = 0; i < trip_cnt; ++i)
+		int34x_thermal_zone->trips[i].hysteresis = thermal_acpi_trip_gtsh(adev);
+
+	for (i = 0; i < int34x_thermal_zone->aux_trip_nr; i++) {
+		int34x_thermal_zone->trips[i].type = THERMAL_TRIP_PASSIVE;
+		int34x_thermal_zone->trips[i].temperature = THERMAL_TEMP_INVALID;
+	}
+	
 	int34x_thermal_zone->lpat_table = acpi_lpat_get_conversion_table(
 								adev->handle);
 
-	int34x_thermal_zone->zone = thermal_zone_device_register(
+	int34x_thermal_zone->zone = thermal_zone_device_register_with_trips(
 						acpi_device_bid(adev),
+						int34x_thermal_zone->trips,
 						trip_cnt,
 						trip_mask, int34x_thermal_zone,
 						int34x_thermal_zone->ops,
@@ -272,9 +175,9 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
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
@@ -287,7 +190,7 @@ void int340x_thermal_zone_remove(struct int34x_thermal_zone
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

