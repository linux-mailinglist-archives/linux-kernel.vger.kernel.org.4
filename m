Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260616A74FC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjCAUQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjCAUPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:15:49 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D52333455
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:15:26 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p26so9365933wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 12:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677701725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZORbJEC0KXh3smLya7JMCOQlYUfz0b2RxRCc6FiOfI=;
        b=w2UyotQBOPnPIAhlCOUiER9zhQqCH46TqU0CF9HwS7QbTpIYPzAjo739J6E6Y4Xbbr
         3GkHyyQede5+mr7z6WWDVYr/j2LDgBfKIoZeYOFBrx/tdh93aSfoo82Pm2chHsXNTAQg
         mEn2oHoSXhE1nUX1R7xwSKWGrDQZgsaG7luLmFFkXlIjBwJddYTdTA8ECkDhyAxbGWe0
         ZYpLeF9ng699Gt1Qw7xB4W+O+hI42kY2PRizitbmBnwKG/REk9RwrvWRUhycvPxaygWV
         FWKlgG1dwX2mcOlofJwfXkaqoEufelrOUXG3B45eVDBxC8Mj+/UvLPeNKNSCjdpONWsO
         K32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677701725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZORbJEC0KXh3smLya7JMCOQlYUfz0b2RxRCc6FiOfI=;
        b=FHa0sCVOUpUTGDUIt1kDaNsAiItbJl/kWexeBE9+6DNG2uJMfUnZxjjNZmPxy4SQPd
         nYC8LgP9bBFcba1/2mSmavuVFR6O0xUG9rc3dvU676sK5CgaQCGau9vKBcx9JjseUp5q
         rsibUA4MVBuCFgJM2TV1vgnzRm09hFa+oxhD6FzLiPNamz0wGhOV1pskzTOP8xO7LNfs
         YWPXb6AEg2CBWO2Z+FBDbMmBVOeUsiQzhb46UO9XRgl/jthxC3OP+c+NP+k7YZ+oDsgN
         AyElZ53EhUDF8JbEwJCPKp8kosBMuk6qwkrC+rTeP5i0p/7GdhxTf+cpWuj6FLlKQVSp
         ZrwA==
X-Gm-Message-State: AO0yUKWP3Ev31TsBBGLzGqKyUsywVY4fVXzp06P6kfJvDTcsD8i+rbUT
        5/ogatEGui+BEuK9OYNWfAOTCQ==
X-Google-Smtp-Source: AK7set82igQXDXQLDcQgalm3MHFmvQbYALKZpjviajKLfGYMlP4HXvFpebv/Sk6+euW4zOjEPAZ1mQ==
X-Received: by 2002:a05:600c:4da3:b0:3ea:e4f8:be09 with SMTP id v35-20020a05600c4da300b003eae4f8be09mr5851796wmp.30.1677701724687;
        Wed, 01 Mar 2023 12:15:24 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6ffe:ce4f:bd31:1e6d])
        by smtp.gmail.com with ESMTPSA id x16-20020a1c7c10000000b003e70a7c1b73sm576546wmc.16.2023.03.01.12.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 12:15:24 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH v5 06/18] thermal: Remove debug or error messages in get_temp() ops
Date:   Wed,  1 Mar 2023 21:14:34 +0100
Message-Id: <20230301201446.3713334-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
References: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
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

Some get_temp() ops implementation are showing an error or a debug
message if the reading of the sensor fails.

The debug message is already displayed from the call site of this
ops. So we can remove it.

On the other side, the error should not be displayed because in
production that can raise tons of messages.

Finally, some drivers are showing a debug message with the
temperature, this is also accessible through the trace from the core
code in the temperature_update() function.

Another benefit is the dev_* messages are accessing the thermal zone
device field from the structure, so we encapsulate even more the code
by preventing these accesses.

Remove those messages.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com> #Armada
Acked-by: Florian Fainelli <f.fainelli@gmail.com> #brcmstb_thermal.c
---
 drivers/thermal/armada_thermal.c           | 10 ++--------
 drivers/thermal/broadcom/brcmstb_thermal.c |  4 +---
 drivers/thermal/dove_thermal.c             |  5 +----
 drivers/thermal/hisi_thermal.c             |  3 ---
 drivers/thermal/imx_sc_thermal.c           |  5 +----
 drivers/thermal/imx_thermal.c              |  4 +---
 drivers/thermal/kirkwood_thermal.c         |  5 +----
 drivers/thermal/max77620_thermal.c         |  4 +---
 drivers/thermal/rockchip_thermal.c         |  3 ---
 drivers/thermal/st/st_thermal.c            |  3 ---
 drivers/thermal/thermal-generic-adc.c      |  5 ++---
 11 files changed, 10 insertions(+), 41 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index ebd606861a61..0e8dfa6a7757 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -360,11 +360,8 @@ static int armada_select_channel(struct armada_thermal_priv *priv, int channel)
 	 * we must absolutely wait for the sensor validity bit to ensure we read
 	 * actual data.
 	 */
-	if (armada_wait_sensor_validity(priv)) {
-		dev_err(priv->dev,
-			"Temperature sensor reading not valid\n");
+	if (armada_wait_sensor_validity(priv))
 		return -EIO;
-	}
 
 	return 0;
 }
@@ -402,11 +399,8 @@ static int armada_get_temp_legacy(struct thermal_zone_device *thermal,
 	int ret;
 
 	/* Valid check */
-	if (!armada_is_valid(priv)) {
-		dev_err(priv->dev,
-			"Temperature sensor reading not valid\n");
+	if (!armada_is_valid(priv))
 		return -EIO;
-	}
 
 	/* Do the actual reading */
 	ret = armada_read_sensor(priv, temp);
diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 60173cc83c46..72d1dbe60b8f 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -158,10 +158,8 @@ static int brcmstb_get_temp(struct thermal_zone_device *tz, int *temp)
 
 	val = __raw_readl(priv->tmon_base + AVS_TMON_STATUS);
 
-	if (!(val & AVS_TMON_STATUS_valid_msk)) {
-		dev_err(priv->dev, "reading not valid\n");
+	if (!(val & AVS_TMON_STATUS_valid_msk))
 		return -EIO;
-	}
 
 	val = (val & AVS_TMON_STATUS_data_msk) >> AVS_TMON_STATUS_data_shift;
 
diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
index 6db1882e8229..9954040d1d2c 100644
--- a/drivers/thermal/dove_thermal.c
+++ b/drivers/thermal/dove_thermal.c
@@ -91,11 +91,8 @@ static int dove_get_temp(struct thermal_zone_device *thermal,
 
 	/* Valid check */
 	reg = readl_relaxed(priv->control + PMU_TEMP_DIOD_CTRL1_REG);
-	if ((reg & PMU_TDC1_TEMP_VALID_MASK) == 0x0) {
-		dev_err(&thermal->device,
-			"Temperature sensor reading not valid\n");
+	if ((reg & PMU_TDC1_TEMP_VALID_MASK) == 0x0)
 		return -EIO;
-	}
 
 	/*
 	 * Calculate temperature. According to Marvell internal
diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index f3a374266fa0..0d135b8a5b62 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -436,9 +436,6 @@ static int hisi_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 
 	*temp = data->ops->get_temp(sensor);
 
-	dev_dbg(&data->pdev->dev, "tzd=%p, id=%d, temp=%d, thres=%d\n",
-		sensor->tzd, sensor->id, *temp, sensor->thres_temp);
-
 	return 0;
 }
 
diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index ddde4bdfc94a..2d7a6bd2846b 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -58,11 +58,8 @@ static int imx_sc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 	hdr->size = 2;
 
 	ret = imx_scu_call_rpc(thermal_ipc_handle, &msg, true);
-	if (ret) {
-		dev_err(&sensor->tzd->device, "read temp sensor %d failed, ret %d\n",
-			sensor->resource_id, ret);
+	if (ret)
 		return ret;
-	}
 
 	*temp = msg.data.resp.celsius * 1000 + msg.data.resp.tenths * 100;
 
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index a22b8086a209..a0b8de269986 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -265,10 +265,8 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 
 	regmap_read(map, soc_data->temp_data, &val);
 
-	if ((val & soc_data->temp_valid_mask) == 0) {
-		dev_dbg(&tz->device, "temp measurement never finished\n");
+	if ((val & soc_data->temp_valid_mask) == 0)
 		return -EAGAIN;
-	}
 
 	n_meas = (val & soc_data->temp_value_mask)
 		>> soc_data->temp_value_shift;
diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
index 92b3ce426b9d..668747bd86ef 100644
--- a/drivers/thermal/kirkwood_thermal.c
+++ b/drivers/thermal/kirkwood_thermal.c
@@ -33,11 +33,8 @@ static int kirkwood_get_temp(struct thermal_zone_device *thermal,
 
 	/* Valid check */
 	if (!((reg >> KIRKWOOD_THERMAL_VALID_OFFSET) &
-	    KIRKWOOD_THERMAL_VALID_MASK)) {
-		dev_err(&thermal->device,
-			"Temperature sensor reading not valid\n");
+	    KIRKWOOD_THERMAL_VALID_MASK))
 		return -EIO;
-	}
 
 	/*
 	 * Calculate temperature. According to Marvell internal
diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index bf1679765f1b..61c7622d9945 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -51,10 +51,8 @@ static int max77620_thermal_read_temp(struct thermal_zone_device *tz, int *temp)
 	int ret;
 
 	ret = regmap_read(mtherm->rmap, MAX77620_REG_STATLBT, &val);
-	if (ret < 0) {
-		dev_err(mtherm->dev, "Failed to read STATLBT: %d\n", ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	if (val & MAX77620_IRQ_TJALRM2_MASK)
 		*temp = MAX77620_TJALARM2_TEMP;
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 8a51eb26e798..71e533df563a 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1233,9 +1233,6 @@ static int rockchip_thermal_get_temp(struct thermal_zone_device *tz, int *out_te
 
 	retval = tsadc->get_temp(&tsadc->table,
 				 sensor->id, thermal->regs, out_temp);
-	dev_dbg(&thermal->pdev->dev, "sensor %d - temp: %d, retval: %d\n",
-		sensor->id, *out_temp, retval);
-
 	return retval;
 }
 
diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
index 6ed393218eb8..2d3042098445 100644
--- a/drivers/thermal/st/st_thermal.c
+++ b/drivers/thermal/st/st_thermal.c
@@ -109,7 +109,6 @@ static int st_thermal_calibration(struct st_thermal_sensor *sensor)
 static int st_thermal_get_temp(struct thermal_zone_device *th, int *temperature)
 {
 	struct st_thermal_sensor *sensor = thermal_zone_device_priv(th);
-	struct device *dev = sensor->dev;
 	unsigned int temp;
 	unsigned int overflow;
 	int ret;
@@ -127,8 +126,6 @@ static int st_thermal_get_temp(struct thermal_zone_device *th, int *temperature)
 	temp += sensor->cdata->temp_adjust_val;
 	temp = mcelsius(temp);
 
-	dev_dbg(dev, "temperature: %d\n", temp);
-
 	*temperature = temp;
 
 	return 0;
diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index 2c283e762d81..017b0ce52122 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -59,10 +59,9 @@ static int gadc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 	int ret;
 
 	ret = iio_read_channel_processed(gti->channel, &val);
-	if (ret < 0) {
-		dev_err(gti->dev, "IIO channel read failed %d\n", ret);
+	if (ret < 0)
 		return ret;
-	}
+
 	*temp = gadc_thermal_adc_to_temp(gti, val);
 
 	return 0;
-- 
2.34.1

