Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE91674A147
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbjGFPj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjGFPjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:39:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E14D210A;
        Thu,  6 Jul 2023 08:39:00 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E8B946606FDA;
        Thu,  6 Jul 2023 16:38:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688657938;
        bh=WacfIUeNdJeJtcPmPNQ0pSKzVDsf6GpImx7+e+30RJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZrMy6VaNchQUjyePXEdWQzMsIuLy+SfLkOCIthGiVNDP1xLwjn+UIiCMxs/VFTvsB
         rJ5oyhu+0aCalg8JeiKTfxk3agGNLR6lO6HSEPsUfy2O0dkAT4Fbja3WofOn9MRV1G
         uKcosfLTm4NHDw+9fP1vzSKeGSHoJl4RkwpQq4xrO7eEiVgKdwkmSluC7FMGdXjpwc
         9w3tRfrkIRd/4yOCfZzhHksvVuKrgR0ovL8alTWAt5YyipNAAXq0/KLO2wpy9HZoHj
         OciRd9hLfSkxu6/0VMBcQh3U1wbVw26nuFiyMymbj674IJ3FJZSpsFjNQZ4l5oYxzG
         ApizDTG9DFuSg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 6/6] thermal/drivers/mediatek/lvts_thermal: Manage threshold between sensors
Date:   Thu,  6 Jul 2023 11:37:37 -0400
Message-ID: <20230706153823.201943-7-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706153823.201943-1-nfraprado@collabora.com>
References: <20230706153823.201943-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each LVTS thermal controller can have up to four sensors, each capable
of triggering its own interrupt when its measured temperature crosses
the configured threshold. The threshold for each sensor is handled
separately by the thermal framework, since each one is registered with
its own thermal zone and trips. However, the temperature thresholds are
configured on the controller, and therefore are shared between all
sensors on that controller.

When the temperature measured by the sensors is different enough to
cause the thermal framework to configure different thresholds for each
one, interrupts start triggering on sensors outside the last threshold
configured.

To address the issue, track the thresholds required by each sensor and
only actually set the highest one in the hardware, and disable
interrupts for all sensors outside the current configured range.

Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

(no changes since v2)

Changes in v2:
- Added this commit

 drivers/thermal/mediatek/lvts_thermal.c | 69 +++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 7552e1d59dc9..a2dc33697371 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -67,6 +67,11 @@
 #define LVTS_CALSCALE_CONF			0x300
 #define LVTS_MONINT_CONF			0x8300318C
 
+#define LVTS_MONINT_OFFSET_SENSOR0		0xC
+#define LVTS_MONINT_OFFSET_SENSOR1		0x180
+#define LVTS_MONINT_OFFSET_SENSOR2		0x3000
+#define LVTS_MONINT_OFFSET_SENSOR3		0x3000000
+
 #define LVTS_INT_SENSOR0			0x0009001F
 #define LVTS_INT_SENSOR1			0x001203E0
 #define LVTS_INT_SENSOR2			0x00247C00
@@ -112,6 +117,8 @@ struct lvts_sensor {
 	void __iomem *base;
 	int id;
 	int dt_id;
+	int low_thresh;
+	int high_thresh;
 };
 
 struct lvts_ctrl {
@@ -121,6 +128,8 @@ struct lvts_ctrl {
 	int num_lvts_sensor;
 	int mode;
 	void __iomem *base;
+	int low_thresh;
+	int high_thresh;
 };
 
 struct lvts_domain {
@@ -292,12 +301,66 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 	return 0;
 }
 
+static void lvts_update_irq_mask(struct lvts_ctrl *lvts_ctrl)
+{
+	u32 masks[] = {
+		LVTS_MONINT_OFFSET_SENSOR0,
+		LVTS_MONINT_OFFSET_SENSOR1,
+		LVTS_MONINT_OFFSET_SENSOR2,
+		LVTS_MONINT_OFFSET_SENSOR3,
+	};
+	u32 value = 0;
+	int i;
+
+	value = readl(LVTS_MONINT(lvts_ctrl->base));
+
+	for (i = 0; i < ARRAY_SIZE(masks); i++) {
+		if (lvts_ctrl->sensors[i].high_thresh == lvts_ctrl->high_thresh
+		    && lvts_ctrl->sensors[i].low_thresh == lvts_ctrl->low_thresh)
+			value |= masks[i];
+		else
+			value &= ~masks[i];
+	}
+
+	writel(value, LVTS_MONINT(lvts_ctrl->base));
+}
+
+static bool lvts_should_update_thresh(struct lvts_ctrl *lvts_ctrl, int high)
+{
+	int i;
+
+	if (high > lvts_ctrl->high_thresh)
+		return true;
+
+	for (i = 0; i < lvts_ctrl->num_lvts_sensor; i++)
+		if (lvts_ctrl->sensors[i].high_thresh == lvts_ctrl->high_thresh
+		    && lvts_ctrl->sensors[i].low_thresh == lvts_ctrl->low_thresh)
+			return false;
+
+	return true;
+}
+
 static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
 	struct lvts_sensor *lvts_sensor = thermal_zone_device_priv(tz);
+	struct lvts_ctrl *lvts_ctrl = container_of(lvts_sensor, struct lvts_ctrl, sensors[lvts_sensor->id]);
 	void __iomem *base = lvts_sensor->base;
 	u32 raw_low = lvts_temp_to_raw(low != -INT_MAX ? low : LVTS_MINIMUM_THRESHOLD);
 	u32 raw_high = lvts_temp_to_raw(high);
+	bool should_update_thresh;
+
+	lvts_sensor->low_thresh = low;
+	lvts_sensor->high_thresh = high;
+
+	should_update_thresh = lvts_should_update_thresh(lvts_ctrl, high);
+	if (should_update_thresh) {
+		lvts_ctrl->high_thresh = high;
+		lvts_ctrl->low_thresh = low;
+	}
+	lvts_update_irq_mask(lvts_ctrl);
+
+	if (!should_update_thresh)
+		return 0;
 
 	/*
 	 * Low offset temperature threshold
@@ -521,6 +584,9 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
 		 */
 		lvts_sensor[i].msr = lvts_ctrl_data->mode == LVTS_MSR_IMMEDIATE_MODE ?
 			imm_regs[i] : msr_regs[i];
+
+		lvts_sensor[i].low_thresh = INT_MIN;
+		lvts_sensor[i].high_thresh = INT_MIN;
 	};
 
 	lvts_ctrl->num_lvts_sensor = lvts_ctrl_data->num_lvts_sensor;
@@ -688,6 +754,9 @@ static int lvts_ctrl_init(struct device *dev, struct lvts_domain *lvts_td,
 		 */
 		lvts_ctrl[i].hw_tshut_raw_temp =
 			lvts_temp_to_raw(lvts_data->lvts_ctrl[i].hw_tshut_temp);
+
+		lvts_ctrl[i].low_thresh = INT_MIN;
+		lvts_ctrl[i].high_thresh = INT_MIN;
 	}
 
 	/*
-- 
2.41.0

