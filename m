Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54756A350B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 23:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjBZW4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 17:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjBZWzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 17:55:50 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F55C16E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:55:17 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso2501485wmb.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNKZqTSfik6kbKLTg6DAWWxGUvdMh+G/qh4G7aDUg+w=;
        b=M+kajm71sV2/+hG0mzVDxeFBLGVBb3eqiFilcuXFmZah1cJmbp/LNKdf0gLj3siBVs
         uks2L8ORHstwNxGgJ/YT5p6LjlPK437wUX0UUc2WbZrxyqHvkAUNxny1dfLi+Nh0+D4u
         2PIS6jADXN9arxgZzFXaebMexqLRQVZnaOlkcISCMFAVVNU7SBVk9nKBYMoUuFhTvxnB
         msKqCdsQcHuiJ63mTRxiP7zb7zzLovtxG+bXWsmw9Qq1wjetOg50yv/1GoYBlZEods72
         ov2/j04v003tOgp+HP7/DfOObSfUmWoFxm6lm9jbvnhjV20vXIeXsHJ16FoHu1NVaF31
         SL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNKZqTSfik6kbKLTg6DAWWxGUvdMh+G/qh4G7aDUg+w=;
        b=PN31iORroToXa2VRwgUq4WiatJ14E98Jhboi97Ut+XCyYrNTBOnAeFThE/ENRGJK4x
         +emWXoJRXVlyUzja4IOW7h2NxLwkO5pN+EpJdNdOWSvjs8S/Prm51gqKnvTXq7R5NLrP
         8bpEzYifm6tovQNN8FiIz4sIyA2WWqNfNHrgdbYQss1Zmiartr2uQD6I53w8ekv4dbfn
         FFB+tnn+86KM82Jf1DMU3hU3QLXx/ftC8nuTnMsBjaYVbwSmj8N9BScwjsA7Rzjr92AC
         QrBcmWNgj4wIonS325fJu46onRt5N9cqSpUdUqTzn9jeBy0kmR5mNuGon/AKHFiIkskW
         MdUQ==
X-Gm-Message-State: AO0yUKWOA9d5nH5bb1n0sgWkFwbW5HOaDh7lnBJP7sKLDF4LDgXUlSAw
        1K7mhVu5lz31hw950G2H9wKIZw==
X-Google-Smtp-Source: AK7set9yhUeUPczs1y3Fjd0Ipo0YnFYlSjqY3nk52V0f8co+tkhywSSDuqGBW9YVYPnt+xnW3bU0Kg==
X-Received: by 2002:a05:600c:a293:b0:3eb:2b88:5af2 with SMTP id hu19-20020a05600ca29300b003eb2b885af2mr6384327wmb.20.1677452106844;
        Sun, 26 Feb 2023 14:55:06 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:8baa:6b32:391b:62de])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b003eb369abd92sm6138074wms.2.2023.02.26.14.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 14:55:06 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balsam CHIHI <bchihi@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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
        Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        Ido Schimmel <idosch@nvidia.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE),
        linux-omap@vger.kernel.org (open list:TI BANDGAP AND THERMAL DRIVER),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH v3 09/20] thermal: Don't use 'device' internal thermal zone structure field
Date:   Sun, 26 Feb 2023 23:53:55 +0100
Message-Id: <20230226225406.979703-10-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226225406.979703-1-daniel.lezcano@linaro.org>
References: <20230226225406.979703-1-daniel.lezcano@linaro.org>
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
Reviewed-by: Balsam CHIHI <bchihi@baylibre.com> #Mediatek LVTS
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> #MediaTek LVTS
---
 drivers/thermal/imx_thermal.c                 | 37 ++++---------------
 drivers/thermal/mediatek/lvts_thermal.c       |  4 +-
 drivers/thermal/thermal_hwmon.c               |  4 +-
 .../ti-soc-thermal/ti-thermal-common.c        |  2 +-
 4 files changed, 13 insertions(+), 34 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index a0b8de269986..c3136978adee 100644
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
index fb4b1b4db245..beb835d644e2 100644
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
index 216b29068b08..060f46cea5ff 100644
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

