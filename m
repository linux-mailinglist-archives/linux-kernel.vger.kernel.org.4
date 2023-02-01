Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE55B687108
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 23:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjBAWgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 17:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAWgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 17:36:43 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD55E4C16
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 14:36:41 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t7so150393wrp.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 14:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O3cdoduGIOs+WYLZ/KKSQFCR2wNSBYmRF9c/LvnjTJs=;
        b=yK3EzAi/JrUjXIQ1Cc0UQ5dT8Qgqp9WXd29FN474fjSyYpBNYW9rBrLZToKxvBVh6u
         ebGKN/7ODrpJpDeGGyJvSycvmjBpsHnIDvRCJLuqSAo8S9C842LzyHeuWXeIlIpVJTF6
         UfTzo2XzWyNROjVvcsGYpzg475y7E0formPr63RmkShQkdwjp/Nh7LS28wvH/TpCHe4a
         XEt97BU0Kg7zFdq6IHHTp+RfhoMkVtUK/VIsLKCt71newni06RnQ7cIAfFRLwI8UCQps
         2Xwxg9rllZCRIQDlmmBcxyYnKaqV8FAXtpfMfWUtZMN9WNmRJgfGwDrsK/7FsjtiUuzk
         HD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O3cdoduGIOs+WYLZ/KKSQFCR2wNSBYmRF9c/LvnjTJs=;
        b=nUgno1lf7ZPLUTqP513lKLnOW7dC9km9T1yzRimx5CC/Qdm16CHMCdySEA94PeBE0o
         pGUNFX1+NJg9XKbQgkdMRF8btQLHl4FbszE7ckB4/maNEKHt01yU9gWixoNykvCZ2H3t
         dMsbvVGoq5yB4NkkyZthSOnVcss1k/LDxQGHMP23BS2xzwiSW2vCLDxlnh5lEQCHHUZO
         2NZRvJdBbzELJvMZfwTMJQeiJMYaSoI61Yicco1oiIm71nVWY/OOyv8F9ErZyP4b2eWD
         Bp1pQpDClyhE7iLnh6cTrXian+wguWzdSAId+j5FBsW3H+IAbl4qlor+1r3H/Eh6azi7
         8/xQ==
X-Gm-Message-State: AO0yUKVqyRXMFRRN8Vhz3EyL806ciqRHYIl4/XcFfETKXbk1ebUcGFvV
        tSrFOSj7Peaq7+upRc1LR2qXzQ==
X-Google-Smtp-Source: AK7set8qEA0wvrtW+7mVp1R7TMGSPk2nqUldEup5U1CYdOJ08eb2O9h3axdglAI1EpkplBPlb6uGVA==
X-Received: by 2002:a5d:5643:0:b0:2c0:227d:ca48 with SMTP id j3-20020a5d5643000000b002c0227dca48mr3466187wrw.63.1675291000267;
        Wed, 01 Feb 2023 14:36:40 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d6542000000b00267bcb1bbe5sm18264819wrv.56.2023.02.01.14.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 14:36:39 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2] thermal/drivers/intel: Use generic trip points for quark_dts
Date:   Wed,  1 Feb 2023 23:36:16 +0100
Message-Id: <20230201223617.1306964-1-daniel.lezcano@linaro.org>
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

Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---

This patch applies on top of linux-pm/linux-next

 V2:
   - Changed get_trip_temp() to return THERMAL_TEMP_INVALID
   - Register unconditonnaly the thermal trips
   - Fixed thermal_zone_device_register() call replaced by the
     _with_trips() version

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../thermal/intel/intel_quark_dts_thermal.c   | 55 +++++++------------
 1 file changed, 20 insertions(+), 35 deletions(-)

diff --git a/drivers/thermal/intel/intel_quark_dts_thermal.c b/drivers/thermal/intel/intel_quark_dts_thermal.c
index 3eafc6b0e6c3..97b843fa7568 100644
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
@@ -172,9 +174,9 @@ static int soc_dts_disable(struct thermal_zone_device *tzd)
 	return ret;
 }
 
-static int _get_trip_temp(int trip, int *temp)
+static int get_trip_temp(int trip)
 {
-	int status;
+	int status, temp;
 	u32 out;
 
 	mutex_lock(&dts_update_mutex);
@@ -183,7 +185,7 @@ static int _get_trip_temp(int trip, int *temp)
 	mutex_unlock(&dts_update_mutex);
 
 	if (status)
-		return status;
+		return THERMAL_TEMP_INVALID;
 
 	/*
 	 * Thermal Sensor Programmable Trip Point Register has 8-bit
@@ -191,21 +193,10 @@ static int _get_trip_temp(int trip, int *temp)
 	 * thresholds. The threshold value is always offset by its
 	 * temperature base (50 degree Celsius).
 	 */
-	*temp = (out >> (trip * QRK_DTS_SHIFT_TP)) & QRK_DTS_MASK_TP_THRES;
-	*temp -= QRK_DTS_TEMP_BASE;
+	temp = (out >> (trip * QRK_DTS_SHIFT_TP)) & QRK_DTS_MASK_TP_THRES;
+	temp -= QRK_DTS_TEMP_BASE;
 
-	return 0;
-}
-
-static inline int sys_get_trip_temp(struct thermal_zone_device *tzd,
-				int trip, int *temp)
-{
-	return _get_trip_temp(trip, temp);
-}
-
-static inline int sys_get_crit_temp(struct thermal_zone_device *tzd, int *temp)
-{
-	return _get_trip_temp(QRK_DTS_ID_TP_CRITICAL, temp);
+	return temp;
 }
 
 static int update_trip_temp(struct soc_sensor_entry *aux_entry,
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
 
@@ -385,10 +362,18 @@ static struct soc_sensor_entry *alloc_soc_dts(void)
 			goto err_ret;
 	}
 
-	aux_entry->tzone = thermal_zone_device_register("quark_dts",
-			QRK_MAX_DTS_TRIPS,
-			wr_mask,
-			aux_entry, &tzone_ops, NULL, 0, polling_delay);
+	aux_entry->trips[QRK_DTS_ID_TP_CRITICAL].temperature = get_trip_temp(QRK_DTS_ID_TP_CRITICAL);
+	aux_entry->trips[QRK_DTS_ID_TP_CRITICAL].type = THERMAL_TRIP_CRITICAL;
+
+	aux_entry->trips[QRK_DTS_ID_TP_HOT].temperature = get_trip_temp(QRK_DTS_ID_TP_HOT);
+	aux_entry->trips[QRK_DTS_ID_TP_HOT].type = THERMAL_TRIP_HOT;
+
+	aux_entry->tzone = thermal_zone_device_register_with_trips("quark_dts",
+								   aux_entry->trips,
+								   QRK_MAX_DTS_TRIPS,
+								   wr_mask,
+								   aux_entry, &tzone_ops,
+								   NULL, 0, polling_delay);
 	if (IS_ERR(aux_entry->tzone)) {
 		err = PTR_ERR(aux_entry->tzone);
 		goto err_ret;
-- 
2.34.1

