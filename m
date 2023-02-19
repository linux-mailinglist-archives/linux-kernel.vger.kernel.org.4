Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DB369C0DD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 15:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjBSOjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 09:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjBSOi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 09:38:29 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DB5D518
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 06:38:02 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id s17so439807wrt.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 06:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EQdLF9AMmZViuzogdladJM3zlJqNSRkNKe1zS5ZnYI=;
        b=aXegFSIkXQv1JoZZ2ID478L2wamqR2CpXLs41QNJ2HbICfoiWmARjCensgQr0CmSjk
         k38g+ZfDIb5NXJsuotUBK//NWtNqat2AnuwYoIIjdreZoU/JOB/Mbhc4dLjDjNzcs0jC
         Aei2Co1HYM3UiX/wp6UCShQIvKgqBoZRmdsgINIXJxoIKJQnPkHRaQoXZRTIruBdl9ic
         s2+qp6snTrQYSeJrFEgD7ZSbzvBM19JaJXGECoX+A/UpZYXH2n3P0fPkGSqvF/wDPzUW
         6C8qPDIXjaUim9ubsJQZcRHyZM4mm/xKszEwt+LpNsisH+6LwP31rk0/Wl/5MUmKe27k
         y0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EQdLF9AMmZViuzogdladJM3zlJqNSRkNKe1zS5ZnYI=;
        b=USeYi9xxEnn5OM0RwQMjsndJbnf3p+5Ls8pXr+MLaW4B2bP8bKXFEWe94r17ghebqb
         /nbzyxzoVB5bp6pKGIh9LflQCwIFYfKL5bILBHRhQ1lrdxowXUouGG9iNLyvfmsWVhMI
         9I6YUmGnXOTsRyToiM8TYbRmPFWE1+3AIvA8949XyuQ8PpGTbiGR47/51uAxd+7k98kM
         ig8z7oky3ldaeqm3e7qOKjxehJmdlzaNQKyRzQsxtWE/S04yvEj7Zg5OnPbuPIbDipCc
         LmB8Jxh9NozoPUTNKrp4iqolRDmPcLPnGF8T0i1lCksl/ZswV7SMyzKJSjD51tA8C4jb
         P0uQ==
X-Gm-Message-State: AO0yUKWht8r+idh0a3aZs6a+szRXSPQR+NL0UeB0v6gDEaik2c+Ka6zB
        c28V42ST5v3PTxVOR9ipNXAUZw==
X-Google-Smtp-Source: AK7set+K+odTdDXOhAcPev17M1CvFdDyh3vLK9WfS//7AmCsByfmu8ydKgygh0HKTOvtCI7dIvJQug==
X-Received: by 2002:a05:6000:1244:b0:2c5:4f41:d1c1 with SMTP id j4-20020a056000124400b002c54f41d1c1mr1713392wrx.38.1676817481730;
        Sun, 19 Feb 2023 06:38:01 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6f43:b92:7670:463])
        by smtp.gmail.com with ESMTPSA id a18-20020adfe5d2000000b002be505ab59asm86176wrn.97.2023.02.19.06.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 06:38:01 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE),
        linux-omap@vger.kernel.org (open list:TI BANDGAP AND THERMAL DRIVER),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH v1 06/17] thermal: Don't use 'device' internal thermal zone structure field
Date:   Sun, 19 Feb 2023 15:36:46 +0100
Message-Id: <20230219143657.241542-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230219143657.241542-1-daniel.lezcano@linaro.org>
References: <20230219143657.241542-1-daniel.lezcano@linaro.org>
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

Some drivers are directly using the thermal zone's 'device' structure
field.

Use the driver device pointer instead of the thermal zone device when
it is available.

Remove the traces when they are duplicate with the traces in the core
code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/imx_thermal.c                 | 37 ++++---------------
 drivers/thermal/mediatek/lvts_thermal.c       |  4 +-
 drivers/thermal/thermal_hwmon.c               |  4 +-
 .../ti-soc-thermal/ti-thermal-common.c        |  2 +-
 4 files changed, 13 insertions(+), 34 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index f621b778b0f0..ae411477d3db 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -285,13 +285,13 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 		if (data->alarm_temp == trips[IMX_TRIP_CRITICAL].temperature &&
 			*temp < trips[IMX_TRIP_PASSIVE].temperature) {
 			imx_set_alarm_temp(data, trips[IMX_TRIP_PASSIVE].temperature);
-			dev_dbg(&tz->device, "thermal alarm off: T < %d\n",
+			dev_dbg(data->dev, "thermal alarm off: T < %d\n",
 				data->alarm_temp / 1000);
 		}
 	}
 
 	if (*temp != data->last_temp) {
-		dev_dbg(&tz->device, "millicelsius: %d\n", *temp);
+		dev_dbg(data->dev, "millicelsius: %d\n", *temp);
 		data->last_temp = *temp;
 	}
 
@@ -367,36 +367,16 @@ static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip,
 static int imx_bind(struct thermal_zone_device *tz,
 		    struct thermal_cooling_device *cdev)
 {
-	int ret;
-
-	ret = thermal_zone_bind_cooling_device(tz, IMX_TRIP_PASSIVE, cdev,
-					       THERMAL_NO_LIMIT,
-					       THERMAL_NO_LIMIT,
-					       THERMAL_WEIGHT_DEFAULT);
-	if (ret) {
-		dev_err(&tz->device,
-			"binding zone %s with cdev %s failed:%d\n",
-			tz->type, cdev->type, ret);
-		return ret;
-	}
-
-	return 0;
+	return thermal_zone_bind_cooling_device(tz, IMX_TRIP_PASSIVE, cdev,
+						THERMAL_NO_LIMIT,
+						THERMAL_NO_LIMIT,
+						THERMAL_WEIGHT_DEFAULT);
 }
 
 static int imx_unbind(struct thermal_zone_device *tz,
 		      struct thermal_cooling_device *cdev)
 {
-	int ret;
-
-	ret = thermal_zone_unbind_cooling_device(tz, IMX_TRIP_PASSIVE, cdev);
-	if (ret) {
-		dev_err(&tz->device,
-			"unbinding zone %s with cdev %s failed:%d\n",
-			tz->type, cdev->type, ret);
-		return ret;
-	}
-
-	return 0;
+	return thermal_zone_unbind_cooling_device(tz, IMX_TRIP_PASSIVE, cdev);
 }
 
 static struct thermal_zone_device_ops imx_tz_ops = {
@@ -558,8 +538,7 @@ static irqreturn_t imx_thermal_alarm_irq_thread(int irq, void *dev)
 {
 	struct imx_thermal_data *data = dev;
 
-	dev_dbg(&data->tz->device, "THERMAL ALARM: T > %d\n",
-		data->alarm_temp / 1000);
+	dev_dbg(data->dev, "THERMAL ALARM: T > %d\n", data->alarm_temp / 1000);
 
 	thermal_zone_device_update(data->tz, THERMAL_EVENT_UNSPECIFIED);
 
diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 86d280187c83..a65a81114cc5 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -305,7 +305,7 @@ static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
 	 * 14-0 : Raw temperature for threshold
 	 */
 	if (low != -INT_MAX) {
-		dev_dbg(&tz->device, "Setting low limit temperature interrupt: %d\n", low);
+		pr_debug("%s: Setting low limit temperature interrupt: %d\n", tz->type, low);
 		writel(raw_low, LVTS_H2NTHRE(base));
 	}
 
@@ -318,7 +318,7 @@ static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
 	 *
 	 * 14-0 : Raw temperature for threshold
 	 */
-	dev_dbg(&tz->device, "Setting high limit temperature interrupt: %d\n", high);
+	pr_debug("%s: Setting high limit temperature interrupt: %d\n", tz->type, high);
 	writel(raw_high, LVTS_HTHRE(base));
 
 	return 0;
diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index 964db7941e31..bc02095b314c 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -228,14 +228,14 @@ void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 	hwmon = thermal_hwmon_lookup_by_type(tz);
 	if (unlikely(!hwmon)) {
 		/* Should never happen... */
-		dev_dbg(&tz->device, "hwmon device lookup failed!\n");
+		dev_dbg(hwmon->device, "hwmon device lookup failed!\n");
 		return;
 	}
 
 	temp = thermal_hwmon_lookup_temp(hwmon, tz);
 	if (unlikely(!temp)) {
 		/* Should never happen... */
-		dev_dbg(&tz->device, "temperature input lookup failed!\n");
+		dev_dbg(hwmon->device, "temperature input lookup failed!\n");
 		return;
 	}
 
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 9fb1ca5e39f6..8586cfe92df6 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -43,7 +43,7 @@ static void ti_thermal_work(struct work_struct *work)
 
 	thermal_zone_device_update(data->ti_thermal, THERMAL_EVENT_UNSPECIFIED);
 
-	dev_dbg(&data->ti_thermal->device, "updated thermal zone %s\n",
+	dev_dbg(data->bgp->dev, "updated thermal zone %s\n",
 		data->ti_thermal->type);
 }
 
-- 
2.34.1

