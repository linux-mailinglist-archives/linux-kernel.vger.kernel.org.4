Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56D264A90B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiLLU73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiLLU7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:59:03 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE24183A8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:59:02 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so6411917wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcUvjMSvUhi2ASA5ji6Vf5KA1TUeyW5xoEs+0ApDTqU=;
        b=hjmnmQVu2j6CQTfAqyqb6Jo1mrk9Xys/REZ5uB0jR0CEP20u+9VRYxr3k5edoEKI+5
         /lhXTtv+14mK8tAktc/757cHS+bkTEAzb0s82p551ckqt6lwjCK3l1844M+c08koU4il
         zSjMOzuG9Q7ZazIjy8zBO2OJMN5a2FE6zOveiNJYxBP19tflIyQ4xSrufDr8dVX5v6MO
         tOQjNHyKZ+dTPswibdeMjUNm9v6bjYP3KvlLydd++mrfhjJchVxrZmdqWao4ojQ8ijvG
         Bouu72dz9DMjDHpzJlwTmBH5x+hnZbgK+DrYd/fHGUz0a87oXy20D3EYS7Jn/F3QZvnq
         P0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcUvjMSvUhi2ASA5ji6Vf5KA1TUeyW5xoEs+0ApDTqU=;
        b=ipn/9f+wF8HdC7sALHCDcEnbx3iMlkMwt/rgwcWmMB4EJfctffwvl6Hg98mJG2WCVN
         YSpz0+AXcS73wWulG90ab+G17tJLbJJUpoDJT/hi2y6MGPi+pt2vzeYhuaKVeLbjcwMw
         i1iCtknDIk6SCTeeZujlx2loszGmTS66CWQpwc8IJcybhJqMKiWkxGjJuzz3HQ9HyVRh
         O1FvbUaLPam7ilNCcXGqWR+iegKZRXH+4IPuij8AJOuanGpbXtNlkEkoOQUTRED2qAii
         Isf2zPKoTafMy93MyC/yZjwZk74BEF4PKuwttK2TmqMJ4/g2I9/Veac82cHXoUIp/49t
         qyrA==
X-Gm-Message-State: ANoB5pngczFzR1glKnP9qFfpIgL+TDpDZRMAPrPgP0UUfP5sLiAwU5Im
        gJPeiOXiz18DAmP298dJDaH4cw==
X-Google-Smtp-Source: AA0mqf5VBYPgm0onB+SyQgvrccbh2wKHUADfGhuH0e6Su9I2j8upq5c61XbPXTj5dyZ31EUxz4/k4Q==
X-Received: by 2002:a05:600c:354e:b0:3cf:5d41:b748 with SMTP id i14-20020a05600c354e00b003cf5d41b748mr13542381wmq.36.1670878741271;
        Mon, 12 Dec 2022 12:59:01 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id t123-20020a1c4681000000b003a3170a7af9sm10537201wma.4.2022.12.12.12.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 12:59:00 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
X-Google-Original-From: Daniel Lezcano <daniel.lezcano@kernel.org>
To:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] thermal/drivers/intel: Use generic trip points for quark_dts
Date:   Mon, 12 Dec 2022 21:58:42 +0100
Message-Id: <20221212205843.3119407-5-daniel.lezcano@kernel.org>
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
 .../thermal/intel/intel_quark_dts_thermal.c   | 45 ++++++++-----------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/drivers/thermal/intel/intel_quark_dts_thermal.c b/drivers/thermal/intel/intel_quark_dts_thermal.c
index 3eafc6b0e6c3..e1b84ba59a20 100644
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
 
@@ -385,6 +362,20 @@ static struct soc_sensor_entry *alloc_soc_dts(void)
 			goto err_ret;
 	}
 
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
 	aux_entry->tzone = thermal_zone_device_register("quark_dts",
 			QRK_MAX_DTS_TRIPS,
 			wr_mask,
-- 
2.34.1

