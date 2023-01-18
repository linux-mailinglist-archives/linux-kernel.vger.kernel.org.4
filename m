Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF4F672689
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjARSQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjARSQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:16:35 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AF059E5A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:16:33 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so2248221wmq.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FZuxz2Nc/8QrqCzCamHaGIaa6VVO9EC4Sr9XAoWF6pY=;
        b=gkpw9IZzYcl1dAnnjN/nEU/WYiGEqwjyeWRxvrttmz8Pjd7VUHlBIrXHE7G15slK0v
         +KYozqf8E0OWNAZyZFQKiMp4q+OhBYWwC8TltkpP5eQJeyhZudH6WhKZN6QYD6krmp1e
         w18W4n46yQkVCOawNbFlfbdWf5/lcqRzQPhMvMl/H6S2ZZ+TfgVuGYIuCZCcrjrVEETM
         TYwXE+F7+PrNylzMCj3iaAk6Xv1Jrup7ahFxT2VTdmhEUDItNqTWM11dsUzbmZMeulhE
         /kM0nGMN7L0I/YErnvmLcXJt5GOHD9A4sMnjRBrSjfqDYrWoqH4h6K8sVovsFvQYwHua
         uGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZuxz2Nc/8QrqCzCamHaGIaa6VVO9EC4Sr9XAoWF6pY=;
        b=G1985LaJ3nLL1L6TD3OMHjBTacD58VE+IVhVjvMpiGP7J3qdous3Gu1N0j9k6SRy2/
         GFdEeJsxMVbCpD+l7X7lDLT78MWHYNnz0e9NfyL4xR2RZoSLpuZr9x5vcB53Pah2pUCK
         kFuBpKXt76l774VdmgPt298ra8JxulcqP42qljVmxzrj3yfu21q8uREnDslFrM9SnTlD
         xDon9kJCV8k9H2af4wlyONpAPgv5DWiQWm3NAtbA9KTQQq0sLhZevS8CIhNxJYKNSnpn
         rMjhY+/tGcQrOlYFU5fZlcdNj/EO/tufw1V+T4H239LYEYji7LVeMYOew72b2VVTNEIE
         uehQ==
X-Gm-Message-State: AFqh2kr81OFaDwHHbYALglgwaXX7zlyRsGuADxCRVVCv7tOw0ney+xJk
        fAR2SqBUz78/hFuSuZKrPx0yhg==
X-Google-Smtp-Source: AMrXdXt+ChbNmzVtI4RDEGrkLSF2Y3zhi8ybIhr2xSOEdneD4pC+utw+QyexttzlYg2ialdSiQz1fA==
X-Received: by 2002:a05:600c:995:b0:3da:f4f5:ad0e with SMTP id w21-20020a05600c099500b003daf4f5ad0emr7467231wmp.9.1674065791979;
        Wed, 18 Jan 2023 10:16:31 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id c10-20020a05600c0a4a00b003db12112fcfsm2817414wmq.4.2023.01.18.10.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 10:16:31 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH 1/3] thermal/drivers/intel: Use generic trip points for quark_dts
Date:   Wed, 18 Jan 2023 19:16:19 +0100
Message-Id: <20230118181622.33335-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../thermal/intel/intel_quark_dts_thermal.c   | 56 +++++++++----------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/drivers/thermal/intel/intel_quark_dts_thermal.c b/drivers/thermal/intel/intel_quark_dts_thermal.c
index 3eafc6b0e6c3..4e1d1799ec22 100644
--- a/drivers/thermal/intel/intel_quark_dts_thermal.c
+++ b/drivers/thermal/intel/intel_quark_dts_thermal.c
@@ -84,6 +84,7 @@
 #define QRK_DTS_MASK_TP_THRES		0xFF
 #define QRK_DTS_SHIFT_TP		8
 #define QRK_DTS_ID_TP_CRITICAL		0
+#define QRK_DTS_ID_TP_HOT		1
 #define QRK_DTS_SAFE_TP_THRES		105
 
 /* Thermal Sensor Register Lock */
@@ -104,6 +105,7 @@ struct soc_sensor_entry {
 	u32 store_ptps;
 	u32 store_dts_enable;
 	struct thermal_zone_device *tzone;
+	struct thermal_trip trips[QRK_MAX_DTS_TRIPS];
 };
 
 static struct soc_sensor_entry *soc_dts;
@@ -172,7 +174,7 @@ static int soc_dts_disable(struct thermal_zone_device *tzd)
 	return ret;
 }
 
-static int _get_trip_temp(int trip, int *temp)
+static int get_trip_temp(int trip, int *temp)
 {
 	int status;
 	u32 out;
@@ -197,17 +199,6 @@ static int _get_trip_temp(int trip, int *temp)
 	return 0;
 }
 
-static inline int sys_get_trip_temp(struct thermal_zone_device *tzd,
-				int trip, int *temp)
-{
-	return _get_trip_temp(trip, temp);
-}
-
-static inline int sys_get_crit_temp(struct thermal_zone_device *tzd, int *temp)
-{
-	return _get_trip_temp(QRK_DTS_ID_TP_CRITICAL, temp);
-}
-
 static int update_trip_temp(struct soc_sensor_entry *aux_entry,
 				int trip, int temp)
 {
@@ -262,17 +253,6 @@ static inline int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip,
 	return update_trip_temp(tzd->devdata, trip, temp);
 }
 
-static int sys_get_trip_type(struct thermal_zone_device *thermal,
-		int trip, enum thermal_trip_type *type)
-{
-	if (trip)
-		*type = THERMAL_TRIP_HOT;
-	else
-		*type = THERMAL_TRIP_CRITICAL;
-
-	return 0;
-}
-
 static int sys_get_curr_temp(struct thermal_zone_device *tzd,
 				int *temp)
 {
@@ -315,10 +295,7 @@ static int sys_change_mode(struct thermal_zone_device *tzd,
 
 static struct thermal_zone_device_ops tzone_ops = {
 	.get_temp = sys_get_curr_temp,
-	.get_trip_temp = sys_get_trip_temp,
-	.get_trip_type = sys_get_trip_type,
 	.set_trip_temp = sys_set_trip_temp,
-	.get_crit_temp = sys_get_crit_temp,
 	.change_mode = sys_change_mode,
 };
 
@@ -344,7 +321,7 @@ static void free_soc_dts(struct soc_sensor_entry *aux_entry)
 static struct soc_sensor_entry *alloc_soc_dts(void)
 {
 	struct soc_sensor_entry *aux_entry;
-	int err;
+	int err, temperature;
 	u32 out;
 	int wr_mask;
 
@@ -385,10 +362,27 @@ static struct soc_sensor_entry *alloc_soc_dts(void)
 			goto err_ret;
 	}
 
-	aux_entry->tzone = thermal_zone_device_register("quark_dts",
-			QRK_MAX_DTS_TRIPS,
-			wr_mask,
-			aux_entry, &tzone_ops, NULL, 0, polling_delay);
+	err = get_trip_temp(QRK_DTS_ID_TP_CRITICAL, &temperature);
+	if (err)
+		goto err_ret;
+
+	aux_entry->trips[QRK_DTS_ID_TP_CRITICAL].temperature = temperature;
+	aux_entry->trips[QRK_DTS_ID_TP_CRITICAL].type = THERMAL_TRIP_CRITICAL;
+
+	err = get_trip_temp(QRK_DTS_ID_TP_HOT, &temperature);
+	if (err)
+		goto err_ret;
+
+	aux_entry->trips[QRK_DTS_ID_TP_HOT].temperature = temperature;
+	aux_entry->trips[QRK_DTS_ID_TP_HOT].type = THERMAL_TRIP_HOT;
+
+	aux_entry->tzone =
+		thermal_zone_device_register_with_trips("quark_dts",
+							aux_entry->trips,
+							QRK_MAX_DTS_TRIPS,
+							wr_mask,
+							aux_entry, &tzone_ops,
+							NULL, 0, polling_delay);
 	if (IS_ERR(aux_entry->tzone)) {
 		err = PTR_ERR(aux_entry->tzone);
 		goto err_ret;
-- 
2.34.1

