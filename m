Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BAA69E6FB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjBUSIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjBUSIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:08:06 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018B4303CD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:07:42 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o4-20020a05600c4fc400b003e1f5f2a29cso4347279wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybdI0IDIbs7xxv4O7dmGIc6IrVak05gnBssoGsWFttI=;
        b=S3JYs/V/QkQilYyWNhAR1x5Law7jkReK1KkgupaWXXQnXpVXqCTHaJnv9gYFr65fM8
         D34fnRLoPJCAp02cGXYTXeaixJdRCExsJiGXGcCixIoqojKZJatk2s1Kmo0aGYi2yQPq
         frkyGKmQvvi0qQwv4Himto9dzx/M1Lw04bfla0j77rnuJdpNxl/zTjVsloO+wdVJLYCh
         oOQrCxN5/fy2LUXBYUzo4Or5a+t9v3fgoPnWcAAVrWYCxJr3j7eWBW40LfLxQl+PXZLa
         JyXsz5z2MiLrouO2c+izzWoQlbCPF9KJCnnNwO1LIpARMNy5Cp8t8Da0V0uFwWzNwCaN
         P8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybdI0IDIbs7xxv4O7dmGIc6IrVak05gnBssoGsWFttI=;
        b=Z2VvP06r/E7x7TEH0L7MfI2Q8XOprK5k0jUGzBPutUHUNwC13apDjK6Hk4E5VkC/CL
         IfqyKuzZ2YFlv+0As/ym5u8m8DOVWWChwuzvfPO9qH4ESTjI/ypK3zggn+hzPQ/TRL4Y
         UFqK0kdNuvJ7BPXfkhDFkcbszHZO1/Oj8YzH+DeKEOhSzbFVJEkwhd2uiKVk8r1LHDSG
         NdU+vFugPX2siK20UHmg/H5TMRXVfwE+7djkeFBB+w2wO9PzeRkhpJn4yRHdPEovKXUa
         nRjqAzUcr9SPFxjk4YUA0bIRRPyqSBAKaH/UzbXruyn/9tUj+mvVf3sGgtsxyhqrDbja
         sqjg==
X-Gm-Message-State: AO0yUKVkEz/sdaGppOIIzM7/CVsO0Swxtc3L0fN+N3ZbDTWiQgL9ZbtR
        3Ph3cgFBCYjqTLr9ZU7LeB4ZAA==
X-Google-Smtp-Source: AK7set8Fc5D0Y2rFo7dzFnRmFcTUeKLqk0/kpXI6eownDWC3yz2ZFcrOUA6dU0PWDttIcQhPq3wAdA==
X-Received: by 2002:a05:600c:2ad6:b0:3df:f2a5:49e0 with SMTP id t22-20020a05600c2ad600b003dff2a549e0mr5089896wme.40.1677002861334;
        Tue, 21 Feb 2023 10:07:41 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1e9:315c:bb40:e382])
        by smtp.gmail.com with ESMTPSA id c128-20020a1c3586000000b003e21558ee9dsm5107815wma.2.2023.02.21.10.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:07:41 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH v2 03/16] thermal: Remove debug or error messages in get_temp() ops
Date:   Tue, 21 Feb 2023 19:06:57 +0100
Message-Id: <20230221180710.2781027-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
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
 drivers/thermal/st/st_thermal.c            |  2 --
 drivers/thermal/thermal-generic-adc.c      |  5 ++---
 11 files changed, 10 insertions(+), 40 deletions(-)

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
index 1009f08e64e3..4d39626a4345 100644
--- a/drivers/thermal/st/st_thermal.c
+++ b/drivers/thermal/st/st_thermal.c
@@ -127,8 +127,6 @@ static int st_thermal_get_temp(struct thermal_zone_device *th, int *temperature)
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

