Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1677126A0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243613AbjEZM3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243466AbjEZM3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:29:23 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A911B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:29:16 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QC2vwT003125;
        Fri, 26 May 2023 07:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=vhdBi80tQTrbC9pnuMymFLkYdlzd+ymyPzVzH7zmeI8=;
 b=EISV7JI+7XXswEfuOLpSwV/IJJQg0PeNxmEHQjeSedWTzFyfkVdm127qsHgFlkr8eCZo
 59MDnUOtM7ioHgT7btepLdHgilISgkbt4hZ812bGl2iEUj0AF8ALE02RPFyjp7gnT7t7
 b7GqsK0OBKIks7dwJGUEcYGCG6beRZMIzGEhZYM4bBKoZXSwkoVbxNdjrJtKmHbEwiRm
 hljHXnr+HND0z9xAsDFqWSz2I5YHHDrR6eA9J3SEuzNvrNF1kBNydH9/A0DKcLO+x10O
 LcOVRlXuNk5SI/d7N6V2KYHdO/9303R26Q/NFlcVWPlmb9owzixVd7JUh4PNlFhlx08B Yw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3qsde8k66w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 07:28:57 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 26 May
 2023 07:28:54 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 26 May 2023 07:28:54 -0500
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.166])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BCDB3B38;
        Fri, 26 May 2023 12:28:54 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>, <broonie@kernel.org>, <perex@perex.cz>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3 01/12] ASoC: cs35l56: Move shared data into a common data structure
Date:   Fri, 26 May 2023 13:28:41 +0100
Message-ID: <20230526122852.4552-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230526122852.4552-1-rf@opensource.cirrus.com>
References: <20230526122852.4552-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QUNgCjzPW_dBkrC8WsY0aK45lv-HKTut
X-Proofpoint-GUID: QUNgCjzPW_dBkrC8WsY0aK45lv-HKTut
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

The ASoC and HDA drivers have structures that contain some of the same
information - instead of maintaining two locations for this data the
drivers should share a common data structure as this will enable common
utility functions to be created.

The first step is to move the location of these members in the ASoC
driver.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
This is identical to V1 except that the 1-line fix for cs35l56_sdw_interrupt()
has been squashed in. So I've included Mark's ack that was conditional on
that squash.
---
 include/sound/cs35l56.h           |  15 +-
 sound/soc/codecs/cs35l56-i2c.c    |  14 +-
 sound/soc/codecs/cs35l56-sdw.c    |  68 ++---
 sound/soc/codecs/cs35l56-shared.c |   6 +-
 sound/soc/codecs/cs35l56-spi.c    |  10 +-
 sound/soc/codecs/cs35l56.c        | 404 +++++++++++++++---------------
 sound/soc/codecs/cs35l56.h        |  13 +-
 7 files changed, 270 insertions(+), 260 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 1f9713d7ca76..3a029c6621c9 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -252,6 +252,19 @@
 #define CS35L56_NUM_BULK_SUPPLIES			3
 #define CS35L56_NUM_DSP_REGIONS				5
 
+struct cs35l56_base {
+	struct device *dev;
+	struct regmap *regmap;
+	int irq;
+	struct mutex irq_lock;
+	u8 rev;
+	bool init_done;
+	bool fw_patched;
+	bool secured;
+	bool can_hibernate;
+	struct gpio_desc *reset_gpio;
+};
+
 extern struct regmap_config cs35l56_regmap_i2c;
 extern struct regmap_config cs35l56_regmap_spi;
 extern struct regmap_config cs35l56_regmap_sdw;
@@ -260,7 +273,7 @@ extern const struct cs_dsp_region cs35l56_dsp1_regions[CS35L56_NUM_DSP_REGIONS];
 extern const char * const cs35l56_tx_input_texts[CS35L56_NUM_INPUT_SRC];
 extern const unsigned int cs35l56_tx_input_values[CS35L56_NUM_INPUT_SRC];
 
-void cs35l56_reread_firmware_registers(struct device *dev, struct regmap *regmap);
+void cs35l56_reread_firmware_registers(struct cs35l56_base *cs35l56_base);
 int cs35l56_get_bclk_freq_id(unsigned int freq);
 void cs35l56_fill_supply_names(struct regulator_bulk_data *data);
 
diff --git a/sound/soc/codecs/cs35l56-i2c.c b/sound/soc/codecs/cs35l56-i2c.c
index 295caad26224..1f430829214b 100644
--- a/sound/soc/codecs/cs35l56-i2c.c
+++ b/sound/soc/codecs/cs35l56-i2c.c
@@ -26,14 +26,14 @@ static int cs35l56_i2c_probe(struct i2c_client *client)
 	if (!cs35l56)
 		return -ENOMEM;
 
-	cs35l56->dev = dev;
-	cs35l56->can_hibernate = true;
+	cs35l56->base.dev = dev;
+	cs35l56->base.can_hibernate = true;
 
 	i2c_set_clientdata(client, cs35l56);
-	cs35l56->regmap = devm_regmap_init_i2c(client, regmap_config);
-	if (IS_ERR(cs35l56->regmap)) {
-		ret = PTR_ERR(cs35l56->regmap);
-		return dev_err_probe(cs35l56->dev, ret, "Failed to allocate register map\n");
+	cs35l56->base.regmap = devm_regmap_init_i2c(client, regmap_config);
+	if (IS_ERR(cs35l56->base.regmap)) {
+		ret = PTR_ERR(cs35l56->base.regmap);
+		return dev_err_probe(cs35l56->base.dev, ret, "Failed to allocate register map\n");
 	}
 
 	ret = cs35l56_common_probe(cs35l56);
@@ -42,7 +42,7 @@ static int cs35l56_i2c_probe(struct i2c_client *client)
 
 	ret = cs35l56_init(cs35l56);
 	if (ret == 0)
-		ret = cs35l56_irq_request(cs35l56, client->irq);
+		ret = cs35l56_irq_request(&cs35l56->base, client->irq);
 	if (ret < 0)
 		cs35l56_remove(cs35l56);
 
diff --git a/sound/soc/codecs/cs35l56-sdw.c b/sound/soc/codecs/cs35l56-sdw.c
index 2cde78605ba9..98be005b8787 100644
--- a/sound/soc/codecs/cs35l56-sdw.c
+++ b/sound/soc/codecs/cs35l56-sdw.c
@@ -166,13 +166,13 @@ static void cs35l56_sdw_init(struct sdw_slave *peripheral)
 	struct cs35l56_private *cs35l56 = dev_get_drvdata(&peripheral->dev);
 	int ret;
 
-	pm_runtime_get_noresume(cs35l56->dev);
+	pm_runtime_get_noresume(cs35l56->base.dev);
 
-	regcache_cache_only(cs35l56->regmap, false);
+	regcache_cache_only(cs35l56->base.regmap, false);
 
 	ret = cs35l56_init(cs35l56);
 	if (ret < 0) {
-		regcache_cache_only(cs35l56->regmap, true);
+		regcache_cache_only(cs35l56->base.regmap, true);
 		goto out;
 	}
 
@@ -180,15 +180,15 @@ static void cs35l56_sdw_init(struct sdw_slave *peripheral)
 	 * cs35l56_init can return with !init_done if it triggered
 	 * a soft reset.
 	 */
-	if (cs35l56->init_done) {
+	if (cs35l56->base.init_done) {
 		/* Enable SoundWire interrupts */
 		sdw_write_no_pm(peripheral, CS35L56_SDW_GEN_INT_MASK_1,
 				CS35L56_SDW_INT_MASK_CODEC_IRQ);
 	}
 
 out:
-	pm_runtime_mark_last_busy(cs35l56->dev);
-	pm_runtime_put_autosuspend(cs35l56->dev);
+	pm_runtime_mark_last_busy(cs35l56->base.dev);
+	pm_runtime_put_autosuspend(cs35l56->base.dev);
 }
 
 static int cs35l56_sdw_interrupt(struct sdw_slave *peripheral,
@@ -198,7 +198,7 @@ static int cs35l56_sdw_interrupt(struct sdw_slave *peripheral,
 
 	/* SoundWire core holds our pm_runtime when calling this function. */
 
-	dev_dbg(cs35l56->dev, "int control_port=%#x\n", status->control_port);
+	dev_dbg(cs35l56->base.dev, "int control_port=%#x\n", status->control_port);
 
 	if ((status->control_port & SDW_SCP_INT1_IMPL_DEF) == 0)
 		return 0;
@@ -207,7 +207,7 @@ static int cs35l56_sdw_interrupt(struct sdw_slave *peripheral,
 	 * Prevent bus manager suspending and possibly issuing a
 	 * bus-reset before the queued work has run.
 	 */
-	pm_runtime_get_noresume(cs35l56->dev);
+	pm_runtime_get_noresume(cs35l56->base.dev);
 
 	/*
 	 * Mask and clear until it has been handled. The read of GEN_INT_STAT_1
@@ -230,14 +230,14 @@ static void cs35l56_sdw_irq_work(struct work_struct *work)
 						       struct cs35l56_private,
 						       sdw_irq_work);
 
-	cs35l56_irq(-1, cs35l56);
+	cs35l56_irq(-1, &cs35l56->base);
 
 	/* unmask interrupts */
 	if (!cs35l56->sdw_irq_no_unmask)
 		sdw_write_no_pm(cs35l56->sdw_peripheral, CS35L56_SDW_GEN_INT_MASK_1,
 				CS35L56_SDW_INT_MASK_CODEC_IRQ);
 
-	pm_runtime_put_autosuspend(cs35l56->dev);
+	pm_runtime_put_autosuspend(cs35l56->base.dev);
 }
 
 static int cs35l56_sdw_read_prop(struct sdw_slave *peripheral)
@@ -246,7 +246,7 @@ static int cs35l56_sdw_read_prop(struct sdw_slave *peripheral)
 	struct sdw_slave_prop *prop = &peripheral->prop;
 	struct sdw_dpn_prop *ports;
 
-	ports = devm_kcalloc(cs35l56->dev, 2, sizeof(*ports), GFP_KERNEL);
+	ports = devm_kcalloc(cs35l56->base.dev, 2, sizeof(*ports), GFP_KERNEL);
 	if (!ports)
 		return -ENOMEM;
 
@@ -279,17 +279,17 @@ static int cs35l56_sdw_update_status(struct sdw_slave *peripheral,
 
 	switch (status) {
 	case SDW_SLAVE_ATTACHED:
-		dev_dbg(cs35l56->dev, "%s: ATTACHED\n", __func__);
+		dev_dbg(cs35l56->base.dev, "%s: ATTACHED\n", __func__);
 		if (cs35l56->sdw_attached)
 			break;
 
-		if (!cs35l56->init_done || cs35l56->soft_resetting)
+		if (!cs35l56->base.init_done || cs35l56->soft_resetting)
 			cs35l56_sdw_init(peripheral);
 
 		cs35l56->sdw_attached = true;
 		break;
 	case SDW_SLAVE_UNATTACHED:
-		dev_dbg(cs35l56->dev, "%s: UNATTACHED\n", __func__);
+		dev_dbg(cs35l56->base.dev, "%s: UNATTACHED\n", __func__);
 		cs35l56->sdw_attached = false;
 		break;
 	default:
@@ -305,7 +305,7 @@ static int cs35l56_a1_kick_divider(struct cs35l56_private *cs35l56,
 	unsigned int curr_scale_reg, next_scale_reg;
 	int curr_scale, next_scale, ret;
 
-	if (!cs35l56->init_done)
+	if (!cs35l56->base.init_done)
 		return 0;
 
 	if (peripheral->bus->params.curr_bank) {
@@ -324,13 +324,13 @@ static int cs35l56_a1_kick_divider(struct cs35l56_private *cs35l56,
 	 */
 	curr_scale = sdw_read_no_pm(peripheral, curr_scale_reg);
 	if (curr_scale < 0) {
-		dev_err(cs35l56->dev, "Failed to read current clock scale: %d\n", curr_scale);
+		dev_err(cs35l56->base.dev, "Failed to read current clock scale: %d\n", curr_scale);
 		return curr_scale;
 	}
 
 	next_scale = sdw_read_no_pm(peripheral, next_scale_reg);
 	if (next_scale < 0) {
-		dev_err(cs35l56->dev, "Failed to read next clock scale: %d\n", next_scale);
+		dev_err(cs35l56->base.dev, "Failed to read next clock scale: %d\n", next_scale);
 		return next_scale;
 	}
 
@@ -338,7 +338,8 @@ static int cs35l56_a1_kick_divider(struct cs35l56_private *cs35l56,
 		next_scale = cs35l56->old_sdw_clock_scale;
 		ret = sdw_write_no_pm(peripheral, next_scale_reg, next_scale);
 		if (ret < 0) {
-			dev_err(cs35l56->dev, "Failed to modify current clock scale: %d\n", ret);
+			dev_err(cs35l56->base.dev, "Failed to modify current clock scale: %d\n",
+				ret);
 			return ret;
 		}
 	}
@@ -346,11 +347,11 @@ static int cs35l56_a1_kick_divider(struct cs35l56_private *cs35l56,
 	cs35l56->old_sdw_clock_scale = curr_scale;
 	ret = sdw_write_no_pm(peripheral, curr_scale_reg, CS35L56_SDW_INVALID_BUS_SCALE);
 	if (ret < 0) {
-		dev_err(cs35l56->dev, "Failed to modify current clock scale: %d\n", ret);
+		dev_err(cs35l56->base.dev, "Failed to modify current clock scale: %d\n", ret);
 		return ret;
 	}
 
-	dev_dbg(cs35l56->dev, "Next bus scale: %#x\n", next_scale);
+	dev_dbg(cs35l56->base.dev, "Next bus scale: %#x\n", next_scale);
 
 	return 0;
 }
@@ -362,9 +363,10 @@ static int cs35l56_sdw_bus_config(struct sdw_slave *peripheral,
 	int sclk;
 
 	sclk = params->curr_dr_freq / 2;
-	dev_dbg(cs35l56->dev, "%s: sclk=%u c=%u r=%u\n", __func__, sclk, params->col, params->row);
+	dev_dbg(cs35l56->base.dev, "%s: sclk=%u c=%u r=%u\n",
+		__func__, sclk, params->col, params->row);
 
-	if (cs35l56->rev < 0xb0)
+	if (cs35l56->base.rev < 0xb0)
 		return cs35l56_a1_kick_divider(cs35l56, peripheral);
 
 	return 0;
@@ -376,7 +378,7 @@ static int __maybe_unused cs35l56_sdw_clk_stop(struct sdw_slave *peripheral,
 {
 	struct cs35l56_private *cs35l56 = dev_get_drvdata(&peripheral->dev);
 
-	dev_dbg(cs35l56->dev, "%s: mode:%d type:%d\n", __func__, mode, type);
+	dev_dbg(cs35l56->base.dev, "%s: mode:%d type:%d\n", __func__, mode, type);
 
 	return 0;
 }
@@ -397,10 +399,10 @@ static int __maybe_unused cs35l56_sdw_handle_unattach(struct cs35l56_private *cs
 
 	if (peripheral->unattach_request) {
 		/* Cannot access registers until bus is re-initialized. */
-		dev_dbg(cs35l56->dev, "Wait for initialization_complete\n");
+		dev_dbg(cs35l56->base.dev, "Wait for initialization_complete\n");
 		if (!wait_for_completion_timeout(&peripheral->initialization_complete,
 						 msecs_to_jiffies(5000))) {
-			dev_err(cs35l56->dev, "initialization_complete timed out\n");
+			dev_err(cs35l56->base.dev, "initialization_complete timed out\n");
 			return -ETIMEDOUT;
 		}
 
@@ -419,7 +421,7 @@ static int __maybe_unused cs35l56_sdw_runtime_suspend(struct device *dev)
 {
 	struct cs35l56_private *cs35l56 = dev_get_drvdata(dev);
 
-	if (!cs35l56->init_done)
+	if (!cs35l56->base.init_done)
 		return 0;
 
 	return cs35l56_runtime_suspend(dev);
@@ -432,7 +434,7 @@ static int __maybe_unused cs35l56_sdw_runtime_resume(struct device *dev)
 
 	dev_dbg(dev, "Runtime resume\n");
 
-	if (!cs35l56->init_done)
+	if (!cs35l56->base.init_done)
 		return 0;
 
 	ret = cs35l56_sdw_handle_unattach(cs35l56);
@@ -454,7 +456,7 @@ static int __maybe_unused cs35l56_sdw_system_suspend(struct device *dev)
 {
 	struct cs35l56_private *cs35l56 = dev_get_drvdata(dev);
 
-	if (!cs35l56->init_done)
+	if (!cs35l56->base.init_done)
 		return 0;
 
 	/*
@@ -493,21 +495,21 @@ static int cs35l56_sdw_probe(struct sdw_slave *peripheral, const struct sdw_devi
 	if (!cs35l56)
 		return -ENOMEM;
 
-	cs35l56->dev = dev;
+	cs35l56->base.dev = dev;
 	cs35l56->sdw_peripheral = peripheral;
 	INIT_WORK(&cs35l56->sdw_irq_work, cs35l56_sdw_irq_work);
 
 	dev_set_drvdata(dev, cs35l56);
 
-	cs35l56->regmap = devm_regmap_init(dev, &cs35l56_regmap_bus_sdw,
+	cs35l56->base.regmap = devm_regmap_init(dev, &cs35l56_regmap_bus_sdw,
 					   peripheral, &cs35l56_regmap_sdw);
-	if (IS_ERR(cs35l56->regmap)) {
-		ret = PTR_ERR(cs35l56->regmap);
+	if (IS_ERR(cs35l56->base.regmap)) {
+		ret = PTR_ERR(cs35l56->base.regmap);
 		return dev_err_probe(dev, ret, "Failed to allocate register map\n");
 	}
 
 	/* Start in cache-only until device is enumerated */
-	regcache_cache_only(cs35l56->regmap, true);
+	regcache_cache_only(cs35l56->base.regmap, true);
 
 	ret = cs35l56_common_probe(cs35l56);
 	if (ret != 0)
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 60da8c75b7b9..0cbaf8c7b05a 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -187,14 +187,14 @@ static const u32 cs35l56_firmware_registers[] = {
 	CS35L56_MAIN_POSTURE_NUMBER,
 };
 
-void cs35l56_reread_firmware_registers(struct device *dev, struct regmap *regmap)
+void cs35l56_reread_firmware_registers(struct cs35l56_base *cs35l56_base)
 {
 	int i;
 	unsigned int val;
 
 	for (i = 0; i < ARRAY_SIZE(cs35l56_firmware_registers); i++) {
-		regmap_read(regmap, cs35l56_firmware_registers[i], &val);
-		dev_dbg(dev, "%s: %d: %#x: %#x\n", __func__,
+		regmap_read(cs35l56_base->regmap, cs35l56_firmware_registers[i], &val);
+		dev_dbg(cs35l56_base->dev, "%s: %d: %#x: %#x\n", __func__,
 			i, cs35l56_firmware_registers[i], val);
 	}
 }
diff --git a/sound/soc/codecs/cs35l56-spi.c b/sound/soc/codecs/cs35l56-spi.c
index 996aab10500e..2057fce435be 100644
--- a/sound/soc/codecs/cs35l56-spi.c
+++ b/sound/soc/codecs/cs35l56-spi.c
@@ -25,13 +25,13 @@ static int cs35l56_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	spi_set_drvdata(spi, cs35l56);
-	cs35l56->regmap = devm_regmap_init_spi(spi, regmap_config);
-	if (IS_ERR(cs35l56->regmap)) {
-		ret = PTR_ERR(cs35l56->regmap);
+	cs35l56->base.regmap = devm_regmap_init_spi(spi, regmap_config);
+	if (IS_ERR(cs35l56->base.regmap)) {
+		ret = PTR_ERR(cs35l56->base.regmap);
 		return dev_err_probe(&spi->dev, ret, "Failed to allocate register map\n");
 	}
 
-	cs35l56->dev = &spi->dev;
+	cs35l56->base.dev = &spi->dev;
 
 	ret = cs35l56_common_probe(cs35l56);
 	if (ret != 0)
@@ -39,7 +39,7 @@ static int cs35l56_spi_probe(struct spi_device *spi)
 
 	ret = cs35l56_init(cs35l56);
 	if (ret == 0)
-		ret = cs35l56_irq_request(cs35l56, spi->irq);
+		ret = cs35l56_irq_request(&cs35l56->base, spi->irq);
 	if (ret < 0)
 		cs35l56_remove(cs35l56);
 
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 3c07bd1e959e..4d41c4b040a4 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -34,17 +34,17 @@
 static int cs35l56_dsp_event(struct snd_soc_dapm_widget *w,
 			     struct snd_kcontrol *kcontrol, int event);
 
-static int cs35l56_mbox_send(struct cs35l56_private *cs35l56, unsigned int command)
+static int cs35l56_mbox_send(struct cs35l56_base *cs35l56_base, unsigned int command)
 {
 	unsigned int val;
 	int ret;
 
-	regmap_write(cs35l56->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1, command);
-	ret = regmap_read_poll_timeout(cs35l56->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1,
+	regmap_write(cs35l56_base->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1, command);
+	ret = regmap_read_poll_timeout(cs35l56_base->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1,
 				       val, (val == 0),
 				       CS35L56_MBOX_POLL_US, CS35L56_MBOX_TIMEOUT_US);
 	if (ret) {
-		dev_warn(cs35l56->dev, "MBOX command %#x failed: %d\n", command, ret);
+		dev_warn(cs35l56_base->dev, "MBOX command %#x failed: %d\n", command, ret);
 		return ret;
 	}
 
@@ -174,25 +174,25 @@ static int cs35l56_play_event(struct snd_soc_dapm_widget *w,
 	unsigned int val;
 	int ret;
 
-	dev_dbg(cs35l56->dev, "play: %d\n", event);
+	dev_dbg(cs35l56->base.dev, "play: %d\n", event);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		/* Don't wait for ACK, we check in POST_PMU that it completed */
-		return regmap_write(cs35l56->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1,
+		return regmap_write(cs35l56->base.regmap, CS35L56_DSP_VIRTUAL1_MBOX_1,
 				    CS35L56_MBOX_CMD_AUDIO_PLAY);
 	case SND_SOC_DAPM_POST_PMU:
 		/* Wait for firmware to enter PS0 power state */
-		ret = regmap_read_poll_timeout(cs35l56->regmap,
+		ret = regmap_read_poll_timeout(cs35l56->base.regmap,
 					       CS35L56_TRANSDUCER_ACTUAL_PS,
 					       val, (val == CS35L56_PS0),
 					       CS35L56_PS0_POLL_US,
 					       CS35L56_PS0_TIMEOUT_US);
 		if (ret)
-			dev_err(cs35l56->dev, "PS0 wait failed: %d\n", ret);
+			dev_err(cs35l56->base.dev, "PS0 wait failed: %d\n", ret);
 		return ret;
 	case SND_SOC_DAPM_POST_PMD:
-		return cs35l56_mbox_send(cs35l56, CS35L56_MBOX_CMD_AUDIO_PAUSE);
+		return cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_AUDIO_PAUSE);
 	default:
 		return 0;
 	}
@@ -310,14 +310,14 @@ static int cs35l56_dsp_event(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
 
-	dev_dbg(cs35l56->dev, "%s: %d\n", __func__, event);
+	dev_dbg(cs35l56->base.dev, "%s: %d\n", __func__, event);
 
 	return wm_adsp_event(w, kcontrol, event);
 }
 
 irqreturn_t cs35l56_irq(int irq, void *data)
 {
-	struct cs35l56_private *cs35l56 = data;
+	struct cs35l56_base *cs35l56_base = data;
 	unsigned int status1 = 0, status8 = 0, status20 = 0;
 	unsigned int mask1, mask8, mask20;
 	unsigned int val;
@@ -325,77 +325,77 @@ irqreturn_t cs35l56_irq(int irq, void *data)
 
 	irqreturn_t ret = IRQ_NONE;
 
-	if (!cs35l56->init_done)
+	if (!cs35l56_base->init_done)
 		return IRQ_NONE;
 
-	mutex_lock(&cs35l56->irq_lock);
+	mutex_lock(&cs35l56_base->irq_lock);
 
-	rv = pm_runtime_resume_and_get(cs35l56->dev);
+	rv = pm_runtime_resume_and_get(cs35l56_base->dev);
 	if (rv < 0) {
-		dev_err(cs35l56->dev, "irq: failed to get pm_runtime: %d\n", rv);
+		dev_err(cs35l56_base->dev, "irq: failed to get pm_runtime: %d\n", rv);
 		goto err_unlock;
 	}
 
-	regmap_read(cs35l56->regmap, CS35L56_IRQ1_STATUS, &val);
+	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_STATUS, &val);
 	if ((val & CS35L56_IRQ1_STS_MASK) == 0) {
-		dev_dbg(cs35l56->dev, "Spurious IRQ: no pending interrupt\n");
+		dev_dbg(cs35l56_base->dev, "Spurious IRQ: no pending interrupt\n");
 		goto err;
 	}
 
 	/* Ack interrupts */
-	regmap_read(cs35l56->regmap, CS35L56_IRQ1_EINT_1, &status1);
-	regmap_read(cs35l56->regmap, CS35L56_IRQ1_MASK_1, &mask1);
+	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_EINT_1, &status1);
+	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_MASK_1, &mask1);
 	status1 &= ~mask1;
-	regmap_write(cs35l56->regmap, CS35L56_IRQ1_EINT_1, status1);
+	regmap_write(cs35l56_base->regmap, CS35L56_IRQ1_EINT_1, status1);
 
-	regmap_read(cs35l56->regmap, CS35L56_IRQ1_EINT_8, &status8);
-	regmap_read(cs35l56->regmap, CS35L56_IRQ1_MASK_8, &mask8);
+	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_EINT_8, &status8);
+	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_MASK_8, &mask8);
 	status8 &= ~mask8;
-	regmap_write(cs35l56->regmap, CS35L56_IRQ1_EINT_8, status8);
+	regmap_write(cs35l56_base->regmap, CS35L56_IRQ1_EINT_8, status8);
 
-	regmap_read(cs35l56->regmap, CS35L56_IRQ1_EINT_20, &status20);
-	regmap_read(cs35l56->regmap, CS35L56_IRQ1_MASK_20, &mask20);
+	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_EINT_20, &status20);
+	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_MASK_20, &mask20);
 	status20 &= ~mask20;
 	/* We don't want EINT20 but they default to unmasked: force mask */
-	regmap_write(cs35l56->regmap, CS35L56_IRQ1_MASK_20, 0xffffffff);
+	regmap_write(cs35l56_base->regmap, CS35L56_IRQ1_MASK_20, 0xffffffff);
 
-	dev_dbg(cs35l56->dev, "%s: %#x %#x\n", __func__, status1, status8);
+	dev_dbg(cs35l56_base->dev, "%s: %#x %#x\n", __func__, status1, status8);
 
 	/* Check to see if unmasked bits are active */
 	if (!status1 && !status8 && !status20)
 		goto err;
 
 	if (status1 & CS35L56_AMP_SHORT_ERR_EINT1_MASK)
-		dev_crit(cs35l56->dev, "Amp short error\n");
+		dev_crit(cs35l56_base->dev, "Amp short error\n");
 
 	if (status8 & CS35L56_TEMP_ERR_EINT1_MASK)
-		dev_crit(cs35l56->dev, "Overtemp error\n");
+		dev_crit(cs35l56_base->dev, "Overtemp error\n");
 
 	ret = IRQ_HANDLED;
 
 err:
-	pm_runtime_put(cs35l56->dev);
+	pm_runtime_put(cs35l56_base->dev);
 err_unlock:
-	mutex_unlock(&cs35l56->irq_lock);
+	mutex_unlock(&cs35l56_base->irq_lock);
 
 	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_irq, SND_SOC_CS35L56_CORE);
 
-int cs35l56_irq_request(struct cs35l56_private *cs35l56, int irq)
+int cs35l56_irq_request(struct cs35l56_base *cs35l56_base, int irq)
 {
 	int ret;
 
 	if (!irq)
 		return 0;
 
-	ret = devm_request_threaded_irq(cs35l56->dev, irq, NULL, cs35l56_irq,
+	ret = devm_request_threaded_irq(cs35l56_base->dev, irq, NULL, cs35l56_irq,
 					IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_LOW,
-					"cs35l56", cs35l56);
+					"cs35l56", cs35l56_base);
 	if (!ret)
-		cs35l56->irq = irq;
+		cs35l56_base->irq = irq;
 	else
-		dev_err(cs35l56->dev, "Failed to get IRQ: %d\n", ret);
+		dev_err(cs35l56_base->dev, "Failed to get IRQ: %d\n", ret);
 
 	return ret;
 }
@@ -406,13 +406,13 @@ static int cs35l56_asp_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int f
 	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(codec_dai->component);
 	unsigned int val;
 
-	dev_dbg(cs35l56->dev, "%s: %#x\n", __func__, fmt);
+	dev_dbg(cs35l56->base.dev, "%s: %#x\n", __func__, fmt);
 
 	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
 	case SND_SOC_DAIFMT_CBC_CFC:
 		break;
 	default:
-		dev_err(cs35l56->dev, "Unsupported clock source mode\n");
+		dev_err(cs35l56->base.dev, "Unsupported clock source mode\n");
 		return -EINVAL;
 	}
 
@@ -426,7 +426,7 @@ static int cs35l56_asp_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int f
 		cs35l56->tdm_mode = false;
 		break;
 	default:
-		dev_err(cs35l56->dev, "Unsupported DAI format\n");
+		dev_err(cs35l56->base.dev, "Unsupported DAI format\n");
 		return -EINVAL;
 	}
 
@@ -443,18 +443,18 @@ static int cs35l56_asp_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int f
 	case SND_SOC_DAIFMT_NB_NF:
 		break;
 	default:
-		dev_err(cs35l56->dev, "Invalid clock invert\n");
+		dev_err(cs35l56->base.dev, "Invalid clock invert\n");
 		return -EINVAL;
 	}
 
-	regmap_update_bits(cs35l56->regmap,
+	regmap_update_bits(cs35l56->base.regmap,
 			   CS35L56_ASP1_CONTROL2,
 			   CS35L56_ASP_FMT_MASK |
 			   CS35L56_ASP_BCLK_INV_MASK | CS35L56_ASP_FSYNC_INV_MASK,
 			   val);
 
 	/* Hi-Z DOUT in unused slots and when all TX are disabled */
-	regmap_update_bits(cs35l56->regmap, CS35L56_ASP1_CONTROL3,
+	regmap_update_bits(cs35l56->base.regmap, CS35L56_ASP1_CONTROL3,
 			   CS35L56_ASP1_DOUT_HIZ_CTRL_MASK,
 			   CS35L56_ASP_UNUSED_HIZ_OFF_HIZ);
 
@@ -485,7 +485,7 @@ static void cs35l56_set_asp_slot_positions(struct cs35l56_private *cs35l56,
 		channel_shift += 8;
 	}
 
-	regmap_write(cs35l56->regmap, reg, reg_val);
+	regmap_write(cs35l56->base.regmap, reg, reg_val);
 }
 
 static int cs35l56_asp_dai_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
@@ -494,20 +494,20 @@ static int cs35l56_asp_dai_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx
 	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(dai->component);
 
 	if ((slots == 0) || (slot_width == 0)) {
-		dev_dbg(cs35l56->dev, "tdm config cleared\n");
+		dev_dbg(cs35l56->base.dev, "tdm config cleared\n");
 		cs35l56->asp_slot_width = 0;
 		cs35l56->asp_slot_count = 0;
 		return 0;
 	}
 
 	if (slot_width > (CS35L56_ASP_RX_WIDTH_MASK >> CS35L56_ASP_RX_WIDTH_SHIFT)) {
-		dev_err(cs35l56->dev, "tdm invalid slot width %d\n", slot_width);
+		dev_err(cs35l56->base.dev, "tdm invalid slot width %d\n", slot_width);
 		return -EINVAL;
 	}
 
 	/* More than 32 slots would give an unsupportable BCLK frequency */
 	if (slots > 32) {
-		dev_err(cs35l56->dev, "tdm invalid slot count %d\n", slots);
+		dev_err(cs35l56->base.dev, "tdm invalid slot count %d\n", slots);
 		return -EINVAL;
 	}
 
@@ -524,7 +524,7 @@ static int cs35l56_asp_dai_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx
 	cs35l56_set_asp_slot_positions(cs35l56, CS35L56_ASP1_FRAME_CONTROL1, rx_mask);
 	cs35l56_set_asp_slot_positions(cs35l56, CS35L56_ASP1_FRAME_CONTROL5, tx_mask);
 
-	dev_dbg(cs35l56->dev, "tdm slot width: %u count: %u tx_mask: %#x rx_mask: %#x\n",
+	dev_dbg(cs35l56->base.dev, "tdm slot width: %u count: %u tx_mask: %#x rx_mask: %#x\n",
 		cs35l56->asp_slot_width, cs35l56->asp_slot_count, tx_mask, rx_mask);
 
 	return 0;
@@ -544,7 +544,8 @@ static int cs35l56_asp_dai_hw_params(struct snd_pcm_substream *substream,
 	else
 		asp_width = asp_wl;
 
-	dev_dbg(cs35l56->dev, "%s: wl=%d, width=%d, rate=%d", __func__, asp_wl, asp_width, rate);
+	dev_dbg(cs35l56->base.dev, "%s: wl=%d, width=%d, rate=%d",
+		__func__, asp_wl, asp_width, rate);
 
 	if (!cs35l56->sysclk_set) {
 		unsigned int slots = cs35l56->asp_slot_count;
@@ -562,26 +563,26 @@ static int cs35l56_asp_dai_hw_params(struct snd_pcm_substream *substream,
 		bclk_freq = asp_width * slots * rate;
 		freq_id = cs35l56_get_bclk_freq_id(bclk_freq);
 		if (freq_id < 0) {
-			dev_err(cs35l56->dev, "%s: Invalid BCLK %u\n", __func__, bclk_freq);
+			dev_err(cs35l56->base.dev, "%s: Invalid BCLK %u\n", __func__, bclk_freq);
 			return -EINVAL;
 		}
 
-		regmap_update_bits(cs35l56->regmap, CS35L56_ASP1_CONTROL1,
+		regmap_update_bits(cs35l56->base.regmap, CS35L56_ASP1_CONTROL1,
 				   CS35L56_ASP_BCLK_FREQ_MASK,
 				   freq_id << CS35L56_ASP_BCLK_FREQ_SHIFT);
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		regmap_update_bits(cs35l56->regmap, CS35L56_ASP1_CONTROL2,
+		regmap_update_bits(cs35l56->base.regmap, CS35L56_ASP1_CONTROL2,
 				   CS35L56_ASP_RX_WIDTH_MASK, asp_width <<
 				   CS35L56_ASP_RX_WIDTH_SHIFT);
-		regmap_update_bits(cs35l56->regmap, CS35L56_ASP1_DATA_CONTROL5,
+		regmap_update_bits(cs35l56->base.regmap, CS35L56_ASP1_DATA_CONTROL5,
 				   CS35L56_ASP_RX_WL_MASK, asp_wl);
 	} else {
-		regmap_update_bits(cs35l56->regmap, CS35L56_ASP1_CONTROL2,
+		regmap_update_bits(cs35l56->base.regmap, CS35L56_ASP1_CONTROL2,
 				   CS35L56_ASP_TX_WIDTH_MASK, asp_width <<
 				   CS35L56_ASP_TX_WIDTH_SHIFT);
-		regmap_update_bits(cs35l56->regmap, CS35L56_ASP1_DATA_CONTROL1,
+		regmap_update_bits(cs35l56->base.regmap, CS35L56_ASP1_DATA_CONTROL1,
 				   CS35L56_ASP_TX_WL_MASK, asp_wl);
 	}
 
@@ -603,7 +604,7 @@ static int cs35l56_asp_dai_set_sysclk(struct snd_soc_dai *dai,
 	if (freq_id < 0)
 		return freq_id;
 
-	regmap_update_bits(cs35l56->regmap, CS35L56_ASP1_CONTROL1,
+	regmap_update_bits(cs35l56->base.regmap, CS35L56_ASP1_CONTROL1,
 			   CS35L56_ASP_BCLK_FREQ_MASK,
 			   freq_id << CS35L56_ASP_BCLK_FREQ_SHIFT);
 	cs35l56->sysclk_set = true;
@@ -646,9 +647,9 @@ static int cs35l56_sdw_dai_hw_params(struct snd_pcm_substream *substream,
 	struct sdw_port_config pconfig;
 	int ret;
 
-	dev_dbg(cs35l56->dev, "%s: rate %d\n", __func__, params_rate(params));
+	dev_dbg(cs35l56->base.dev, "%s: rate %d\n", __func__, params_rate(params));
 
-	if (!cs35l56->init_done)
+	if (!cs35l56->base.init_done)
 		return -ENODEV;
 
 	if (!sdw_stream)
@@ -764,30 +765,30 @@ static struct snd_soc_dai_driver cs35l56_dai[] = {
 	}
 };
 
-static int cs35l56_wait_for_firmware_boot(struct cs35l56_private *cs35l56)
+static int cs35l56_wait_for_firmware_boot(struct cs35l56_base *cs35l56_base)
 {
 	unsigned int reg;
 	unsigned int val;
 	int ret;
 
-	if (cs35l56->rev < CS35L56_REVID_B0)
+	if (cs35l56_base->rev < CS35L56_REVID_B0)
 		reg = CS35L56_DSP1_HALO_STATE_A1;
 	else
 		reg = CS35L56_DSP1_HALO_STATE;
 
-	ret = regmap_read_poll_timeout(cs35l56->regmap, reg,
+	ret = regmap_read_poll_timeout(cs35l56_base->regmap, reg,
 				       val,
 				       (val < 0xFFFF) && (val >= CS35L56_HALO_STATE_BOOT_DONE),
 				       CS35L56_HALO_STATE_POLL_US,
 				       CS35L56_HALO_STATE_TIMEOUT_US);
 
 	if ((ret < 0) && (ret != -ETIMEDOUT)) {
-		dev_err(cs35l56->dev, "Failed to read HALO_STATE: %d\n", ret);
+		dev_err(cs35l56_base->dev, "Failed to read HALO_STATE: %d\n", ret);
 		return ret;
 	}
 
 	if ((ret == -ETIMEDOUT) || (val != CS35L56_HALO_STATE_BOOT_DONE)) {
-		dev_err(cs35l56->dev, "Firmware boot fail: HALO_STATE=%#x\n", val);
+		dev_err(cs35l56_base->dev, "Firmware boot fail: HALO_STATE=%#x\n", val);
 		return -EIO;
 	}
 
@@ -812,8 +813,8 @@ static void cs35l56_system_reset(struct cs35l56_private *cs35l56)
 	 * Must enter cache-only first so there can't be any more register
 	 * accesses other than the controlled system reset sequence below.
 	 */
-	regcache_cache_only(cs35l56->regmap, true);
-	regmap_multi_reg_write_bypassed(cs35l56->regmap,
+	regcache_cache_only(cs35l56->base.regmap, true);
+	regmap_multi_reg_write_bypassed(cs35l56->base.regmap,
 					cs35l56_system_reset_seq,
 					ARRAY_SIZE(cs35l56_system_reset_seq));
 
@@ -822,7 +823,7 @@ static void cs35l56_system_reset(struct cs35l56_private *cs35l56)
 		return;
 
 	usleep_range(CS35L56_CONTROL_PORT_READY_US, CS35L56_CONTROL_PORT_READY_US + 400);
-	regcache_cache_only(cs35l56->regmap, false);
+	regcache_cache_only(cs35l56->base.regmap, false);
 }
 
 static void cs35l56_secure_patch(struct cs35l56_private *cs35l56)
@@ -832,9 +833,9 @@ static void cs35l56_secure_patch(struct cs35l56_private *cs35l56)
 	/* Use wm_adsp to load and apply the firmware patch and coefficient files */
 	ret = wm_adsp_power_up(&cs35l56->dsp);
 	if (ret)
-		dev_dbg(cs35l56->dev, "%s: wm_adsp_power_up ret %d\n", __func__, ret);
+		dev_dbg(cs35l56->base.dev, "%s: wm_adsp_power_up ret %d\n", __func__, ret);
 	else
-		cs35l56_mbox_send(cs35l56, CS35L56_MBOX_CMD_AUDIO_REINIT);
+		cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_AUDIO_REINIT);
 }
 
 static void cs35l56_patch(struct cs35l56_private *cs35l56)
@@ -857,31 +858,31 @@ static void cs35l56_patch(struct cs35l56_private *cs35l56)
 		flush_work(&cs35l56->sdw_irq_work);
 	}
 
-	ret = cs35l56_mbox_send(cs35l56, CS35L56_MBOX_CMD_SHUTDOWN);
+	ret = cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_SHUTDOWN);
 	if (ret)
 		goto err;
 
-	if (cs35l56->rev < CS35L56_REVID_B0)
+	if (cs35l56->base.rev < CS35L56_REVID_B0)
 		reg = CS35L56_DSP1_PM_CUR_STATE_A1;
 	else
 		reg = CS35L56_DSP1_PM_CUR_STATE;
 
-	ret = regmap_read_poll_timeout(cs35l56->regmap, reg,
+	ret = regmap_read_poll_timeout(cs35l56->base.regmap, reg,
 				       val, (val == CS35L56_HALO_STATE_SHUTDOWN),
 				       CS35L56_HALO_STATE_POLL_US,
 				       CS35L56_HALO_STATE_TIMEOUT_US);
 	if (ret < 0)
-		dev_err(cs35l56->dev, "Failed to poll PM_CUR_STATE to 1 is %d (ret %d)\n",
+		dev_err(cs35l56->base.dev, "Failed to poll PM_CUR_STATE to 1 is %d (ret %d)\n",
 			val, ret);
 
 	/* Use wm_adsp to load and apply the firmware patch and coefficient files */
 	ret = wm_adsp_power_up(&cs35l56->dsp);
 	if (ret) {
-		dev_dbg(cs35l56->dev, "%s: wm_adsp_power_up ret %d\n", __func__, ret);
+		dev_dbg(cs35l56->base.dev, "%s: wm_adsp_power_up ret %d\n", __func__, ret);
 		goto err;
 	}
 
-	mutex_lock(&cs35l56->irq_lock);
+	mutex_lock(&cs35l56->base.irq_lock);
 
 	init_completion(&cs35l56->init_completion);
 
@@ -895,18 +896,20 @@ static void cs35l56_patch(struct cs35l56_private *cs35l56)
 		 */
 		if (!wait_for_completion_timeout(&cs35l56->init_completion,
 						 msecs_to_jiffies(5000))) {
-			dev_err(cs35l56->dev, "%s: init_completion timed out (SDW)\n", __func__);
+			dev_err(cs35l56->base.dev, "%s: init_completion timed out (SDW)\n",
+				__func__);
 			goto err_unlock;
 		}
 	} else if (cs35l56_init(cs35l56)) {
 		goto err_unlock;
 	}
 
-	regmap_clear_bits(cs35l56->regmap, CS35L56_PROTECTION_STATUS, CS35L56_FIRMWARE_MISSING);
-	cs35l56->fw_patched = true;
+	regmap_clear_bits(cs35l56->base.regmap, CS35L56_PROTECTION_STATUS,
+			  CS35L56_FIRMWARE_MISSING);
+	cs35l56->base.fw_patched = true;
 
 err_unlock:
-	mutex_unlock(&cs35l56->irq_lock);
+	mutex_unlock(&cs35l56->base.irq_lock);
 err:
 	/* Re-enable SoundWire interrupts */
 	if (cs35l56->sdw_peripheral) {
@@ -922,10 +925,10 @@ static void cs35l56_dsp_work(struct work_struct *work)
 						       struct cs35l56_private,
 						       dsp_work);
 
-	if (!cs35l56->init_done)
+	if (!cs35l56->base.init_done)
 		return;
 
-	pm_runtime_get_sync(cs35l56->dev);
+	pm_runtime_get_sync(cs35l56->base.dev);
 
 	/*
 	 * When the device is running in secure mode the firmware files can
@@ -933,13 +936,13 @@ static void cs35l56_dsp_work(struct work_struct *work)
 	 * shutdown the firmware to apply them and can use the lower cost
 	 * reinit sequence instead.
 	 */
-	if (cs35l56->secured)
+	if (cs35l56->base.secured)
 		cs35l56_secure_patch(cs35l56);
 	else
 		cs35l56_patch(cs35l56);
 
-	pm_runtime_mark_last_busy(cs35l56->dev);
-	pm_runtime_put_autosuspend(cs35l56->dev);
+	pm_runtime_mark_last_busy(cs35l56->base.dev);
+	pm_runtime_put_autosuspend(cs35l56->base.dev);
 }
 
 static int cs35l56_component_probe(struct snd_soc_component *component)
@@ -951,16 +954,16 @@ static int cs35l56_component_probe(struct snd_soc_component *component)
 
 	if (!wait_for_completion_timeout(&cs35l56->init_completion,
 					 msecs_to_jiffies(5000))) {
-		dev_err(cs35l56->dev, "%s: init_completion timed out\n", __func__);
+		dev_err(cs35l56->base.dev, "%s: init_completion timed out\n", __func__);
 		return -ENODEV;
 	}
 
 	cs35l56->component = component;
 	wm_adsp2_component_probe(&cs35l56->dsp, component);
 
-	debugfs_create_bool("init_done", 0444, debugfs_root, &cs35l56->init_done);
-	debugfs_create_bool("can_hibernate", 0444, debugfs_root, &cs35l56->can_hibernate);
-	debugfs_create_bool("fw_patched", 0444, debugfs_root, &cs35l56->fw_patched);
+	debugfs_create_bool("init_done", 0444, debugfs_root, &cs35l56->base.init_done);
+	debugfs_create_bool("can_hibernate", 0444, debugfs_root, &cs35l56->base.can_hibernate);
+	debugfs_create_bool("fw_patched", 0444, debugfs_root, &cs35l56->base.fw_patched);
 
 	queue_work(cs35l56->dsp_wq, &cs35l56->dsp_work);
 
@@ -1027,23 +1030,23 @@ int cs35l56_runtime_suspend(struct device *dev)
 	unsigned int val;
 	int ret;
 
-	if (!cs35l56->init_done)
+	if (!cs35l56->base.init_done)
 		return 0;
 
 	/* Firmware must have entered a power-save state */
-	ret = regmap_read_poll_timeout(cs35l56->regmap,
+	ret = regmap_read_poll_timeout(cs35l56->base.regmap,
 				       CS35L56_TRANSDUCER_ACTUAL_PS,
 				       val, (val >= CS35L56_PS3),
 				       CS35L56_PS3_POLL_US,
 				       CS35L56_PS3_TIMEOUT_US);
 	if (ret)
-		dev_warn(cs35l56->dev, "PS3 wait failed: %d\n", ret);
+		dev_warn(cs35l56->base.dev, "PS3 wait failed: %d\n", ret);
 
 	/* Clear BOOT_DONE so it can be used to detect a reboot */
-	regmap_write(cs35l56->regmap, CS35L56_IRQ1_EINT_4, CS35L56_OTP_BOOT_DONE_MASK);
+	regmap_write(cs35l56->base.regmap, CS35L56_IRQ1_EINT_4, CS35L56_OTP_BOOT_DONE_MASK);
 
-	if (!cs35l56->can_hibernate) {
-		regcache_cache_only(cs35l56->regmap, true);
+	if (!cs35l56->base.can_hibernate) {
+		regcache_cache_only(cs35l56->base.regmap, true);
 		dev_dbg(dev, "Suspended: no hibernate");
 
 		return 0;
@@ -1053,15 +1056,15 @@ int cs35l56_runtime_suspend(struct device *dev)
 	 * Enable auto-hibernate. If it is woken by some other wake source
 	 * it will automatically return to hibernate.
 	 */
-	cs35l56_mbox_send(cs35l56, CS35L56_MBOX_CMD_ALLOW_AUTO_HIBERNATE);
+	cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_ALLOW_AUTO_HIBERNATE);
 
 	/*
 	 * Must enter cache-only first so there can't be any more register
 	 * accesses other than the controlled hibernate sequence below.
 	 */
-	regcache_cache_only(cs35l56->regmap, true);
+	regcache_cache_only(cs35l56->base.regmap, true);
 
-	regmap_multi_reg_write_bypassed(cs35l56->regmap,
+	regmap_multi_reg_write_bypassed(cs35l56->base.regmap,
 					cs35l56_hibernate_seq,
 					ARRAY_SIZE(cs35l56_hibernate_seq));
 
@@ -1075,7 +1078,7 @@ static int __maybe_unused cs35l56_runtime_resume_i2c_spi(struct device *dev)
 {
 	struct cs35l56_private *cs35l56 = dev_get_drvdata(dev);
 
-	if (!cs35l56->init_done)
+	if (!cs35l56->base.init_done)
 		return 0;
 
 	return cs35l56_runtime_resume_common(cs35l56);
@@ -1086,7 +1089,7 @@ int cs35l56_runtime_resume_common(struct cs35l56_private *cs35l56)
 	unsigned int val;
 	int ret;
 
-	if (!cs35l56->can_hibernate)
+	if (!cs35l56->base.can_hibernate)
 		goto out_sync;
 
 	if (!cs35l56->sdw_peripheral) {
@@ -1094,7 +1097,7 @@ int cs35l56_runtime_resume_common(struct cs35l56_private *cs35l56)
 		 * Dummy transaction to trigger I2C/SPI auto-wake. This will NAK on I2C.
 		 * Must be done before releasing cache-only.
 		 */
-		regmap_multi_reg_write_bypassed(cs35l56->regmap,
+		regmap_multi_reg_write_bypassed(cs35l56->base.regmap,
 						cs35l56_hibernate_wake_seq,
 						ARRAY_SIZE(cs35l56_hibernate_wake_seq));
 
@@ -1103,36 +1106,36 @@ int cs35l56_runtime_resume_common(struct cs35l56_private *cs35l56)
 	}
 
 out_sync:
-	regcache_cache_only(cs35l56->regmap, false);
+	regcache_cache_only(cs35l56->base.regmap, false);
 
-	ret = cs35l56_wait_for_firmware_boot(cs35l56);
+	ret = cs35l56_wait_for_firmware_boot(&cs35l56->base);
 	if (ret) {
-		dev_err(cs35l56->dev, "Hibernate wake failed: %d\n", ret);
+		dev_err(cs35l56->base.dev, "Hibernate wake failed: %d\n", ret);
 		goto err;
 	}
 
-	ret = cs35l56_mbox_send(cs35l56, CS35L56_MBOX_CMD_PREVENT_AUTO_HIBERNATE);
+	ret = cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_PREVENT_AUTO_HIBERNATE);
 	if (ret)
 		goto err;
 
 	/* BOOT_DONE will be 1 if the amp reset */
-	regmap_read(cs35l56->regmap, CS35L56_IRQ1_EINT_4, &val);
+	regmap_read(cs35l56->base.regmap, CS35L56_IRQ1_EINT_4, &val);
 	if (val & CS35L56_OTP_BOOT_DONE_MASK) {
-		dev_dbg(cs35l56->dev, "Registers reset in suspend\n");
-		regcache_mark_dirty(cs35l56->regmap);
+		dev_dbg(cs35l56->base.dev, "Registers reset in suspend\n");
+		regcache_mark_dirty(cs35l56->base.regmap);
 	}
 
-	regcache_sync(cs35l56->regmap);
+	regcache_sync(cs35l56->base.regmap);
 
-	dev_dbg(cs35l56->dev, "Resumed");
+	dev_dbg(cs35l56->base.dev, "Resumed");
 
 	return 0;
 
 err:
-	regmap_write(cs35l56->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1,
+	regmap_write(cs35l56->base.regmap, CS35L56_DSP_VIRTUAL1_MBOX_1,
 		     CS35L56_MBOX_CMD_HIBERNATE_NOW);
 
-	regcache_cache_only(cs35l56->regmap, true);
+	regcache_cache_only(cs35l56->base.regmap, true);
 
 	return ret;
 }
@@ -1144,14 +1147,14 @@ static int cs35l56_is_fw_reload_needed(struct cs35l56_private *cs35l56)
 	int ret;
 
 	/* Nothing to re-patch if we haven't done any patching yet. */
-	if (!cs35l56->fw_patched)
+	if (!cs35l56->base.fw_patched)
 		return false;
 
 	/*
 	 * If we have control of RESET we will have asserted it so the firmware
 	 * will need re-patching.
 	 */
-	if (cs35l56->reset_gpio)
+	if (cs35l56->base.reset_gpio)
 		return true;
 
 	/*
@@ -1159,22 +1162,22 @@ static int cs35l56_is_fw_reload_needed(struct cs35l56_private *cs35l56)
 	 * can't be used here to test for memory retention.
 	 * Assume that tuning must be re-loaded.
 	 */
-	if (cs35l56->secured)
+	if (cs35l56->base.secured)
 		return true;
 
-	ret = pm_runtime_resume_and_get(cs35l56->dev);
+	ret = pm_runtime_resume_and_get(cs35l56->base.dev);
 	if (ret) {
-		dev_err(cs35l56->dev, "Failed to runtime_get: %d\n", ret);
+		dev_err(cs35l56->base.dev, "Failed to runtime_get: %d\n", ret);
 		return ret;
 	}
 
-	ret = regmap_read(cs35l56->regmap, CS35L56_PROTECTION_STATUS, &val);
+	ret = regmap_read(cs35l56->base.regmap, CS35L56_PROTECTION_STATUS, &val);
 	if (ret)
-		dev_err(cs35l56->dev, "Failed to read PROTECTION_STATUS: %d\n", ret);
+		dev_err(cs35l56->base.dev, "Failed to read PROTECTION_STATUS: %d\n", ret);
 	else
 		ret = !!(val & CS35L56_FIRMWARE_MISSING);
 
-	pm_runtime_put_autosuspend(cs35l56->dev);
+	pm_runtime_put_autosuspend(cs35l56->base.dev);
 
 	return ret;
 }
@@ -1194,8 +1197,8 @@ int cs35l56_system_suspend(struct device *dev)
 	 * clear it. Prevent this race by temporarily disabling the parent irq
 	 * until we reach _no_irq.
 	 */
-	if (cs35l56->irq)
-		disable_irq(cs35l56->irq);
+	if (cs35l56->base.irq)
+		disable_irq(cs35l56->base.irq);
 
 	return pm_runtime_force_suspend(dev);
 }
@@ -1212,8 +1215,8 @@ int cs35l56_system_suspend_late(struct device *dev)
 	 * RESET is usually shared by all amps so it must not be asserted until
 	 * all driver instances have done their suspend() stage.
 	 */
-	if (cs35l56->reset_gpio) {
-		gpiod_set_value_cansleep(cs35l56->reset_gpio, 0);
+	if (cs35l56->base.reset_gpio) {
+		gpiod_set_value_cansleep(cs35l56->base.reset_gpio, 0);
 		cs35l56_wait_min_reset_pulse();
 	}
 
@@ -1230,8 +1233,8 @@ int cs35l56_system_suspend_no_irq(struct device *dev)
 	dev_dbg(dev, "system_suspend_no_irq\n");
 
 	/* Handlers are now disabled so the parent IRQ can safely be re-enabled. */
-	if (cs35l56->irq)
-		enable_irq(cs35l56->irq);
+	if (cs35l56->base.irq)
+		enable_irq(cs35l56->base.irq);
 
 	return 0;
 }
@@ -1250,8 +1253,8 @@ int cs35l56_system_resume_no_irq(struct device *dev)
 	 * clear it, until it has fully resumed. Prevent this race by temporarily
 	 * disabling the parent irq until we complete resume().
 	 */
-	if (cs35l56->irq)
-		disable_irq(cs35l56->irq);
+	if (cs35l56->base.irq)
+		disable_irq(cs35l56->base.irq);
 
 	return 0;
 }
@@ -1265,8 +1268,8 @@ int cs35l56_system_resume_early(struct device *dev)
 	dev_dbg(dev, "system_resume_early\n");
 
 	/* Ensure a spec-compliant RESET pulse. */
-	if (cs35l56->reset_gpio) {
-		gpiod_set_value_cansleep(cs35l56->reset_gpio, 0);
+	if (cs35l56->base.reset_gpio) {
+		gpiod_set_value_cansleep(cs35l56->base.reset_gpio, 0);
 		cs35l56_wait_min_reset_pulse();
 	}
 
@@ -1278,7 +1281,7 @@ int cs35l56_system_resume_early(struct device *dev)
 	}
 
 	/* Release shared RESET before drivers start resume(). */
-	gpiod_set_value_cansleep(cs35l56->reset_gpio, 1);
+	gpiod_set_value_cansleep(cs35l56->base.reset_gpio, 1);
 
 	return 0;
 }
@@ -1293,8 +1296,8 @@ int cs35l56_system_resume(struct device *dev)
 
 	/* Undo pm_runtime_force_suspend() before re-enabling the irq */
 	ret = pm_runtime_force_resume(dev);
-	if (cs35l56->irq)
-		enable_irq(cs35l56->irq);
+	if (cs35l56->base.irq)
+		enable_irq(cs35l56->base.irq);
 
 	if (ret)
 		return ret;
@@ -1304,11 +1307,11 @@ int cs35l56_system_resume(struct device *dev)
 		return 0;
 
 	ret = cs35l56_is_fw_reload_needed(cs35l56);
-	dev_dbg(cs35l56->dev, "fw_reload_needed: %d\n", ret);
+	dev_dbg(cs35l56->base.dev, "fw_reload_needed: %d\n", ret);
 	if (ret < 1)
 		return ret;
 
-	cs35l56->fw_patched = false;
+	cs35l56->base.fw_patched = false;
 	queue_work(cs35l56->dsp_wq, &cs35l56->dsp_work);
 
 	/*
@@ -1337,8 +1340,8 @@ static int cs35l56_dsp_init(struct cs35l56_private *cs35l56)
 	dsp->cs_dsp.type = WMFW_HALO;
 	dsp->cs_dsp.rev = 0;
 	dsp->fw = 12;
-	dsp->cs_dsp.dev = cs35l56->dev;
-	dsp->cs_dsp.regmap = cs35l56->regmap;
+	dsp->cs_dsp.dev = cs35l56->base.dev;
+	dsp->cs_dsp.regmap = cs35l56->base.regmap;
 	dsp->cs_dsp.base = CS35L56_DSP1_CORE_BASE;
 	dsp->cs_dsp.base_sysinfo = CS35L56_DSP1_SYS_INFO_ID;
 	dsp->cs_dsp.mem = cs35l56_dsp1_regions;
@@ -1346,11 +1349,11 @@ static int cs35l56_dsp_init(struct cs35l56_private *cs35l56)
 	dsp->cs_dsp.no_core_startstop = true;
 	dsp->wmfw_optional = true;
 
-	dev_dbg(cs35l56->dev, "DSP system name: '%s'\n", dsp->system_name);
+	dev_dbg(cs35l56->base.dev, "DSP system name: '%s'\n", dsp->system_name);
 
 	ret = wm_halo_init(dsp);
 	if (ret != 0) {
-		dev_err(cs35l56->dev, "wm_halo_init failed\n");
+		dev_err(cs35l56->base.dev, "wm_halo_init failed\n");
 		return ret;
 	}
 
@@ -1359,7 +1362,7 @@ static int cs35l56_dsp_init(struct cs35l56_private *cs35l56)
 
 static int cs35l56_acpi_get_name(struct cs35l56_private *cs35l56)
 {
-	acpi_handle handle = ACPI_HANDLE(cs35l56->dev);
+	acpi_handle handle = ACPI_HANDLE(cs35l56->base.dev);
 	const char *sub;
 
 	/* If there is no ACPI_HANDLE, there is no ACPI for this system, return 0 */
@@ -1376,7 +1379,7 @@ static int cs35l56_acpi_get_name(struct cs35l56_private *cs35l56)
 	}
 
 	cs35l56->dsp.system_name = sub;
-	dev_dbg(cs35l56->dev, "Subsystem ID: %s\n", cs35l56->dsp.system_name);
+	dev_dbg(cs35l56->base.dev, "Subsystem ID: %s\n", cs35l56->dsp.system_name);
 
 	return 0;
 }
@@ -1386,38 +1389,39 @@ int cs35l56_common_probe(struct cs35l56_private *cs35l56)
 	int ret;
 
 	init_completion(&cs35l56->init_completion);
-	mutex_init(&cs35l56->irq_lock);
+	mutex_init(&cs35l56->base.irq_lock);
 
-	dev_set_drvdata(cs35l56->dev, cs35l56);
+	dev_set_drvdata(cs35l56->base.dev, cs35l56);
 
 	cs35l56_fill_supply_names(cs35l56->supplies);
-	ret = devm_regulator_bulk_get(cs35l56->dev, ARRAY_SIZE(cs35l56->supplies),
+	ret = devm_regulator_bulk_get(cs35l56->base.dev, ARRAY_SIZE(cs35l56->supplies),
 				      cs35l56->supplies);
 	if (ret != 0)
-		return dev_err_probe(cs35l56->dev, ret, "Failed to request supplies\n");
+		return dev_err_probe(cs35l56->base.dev, ret, "Failed to request supplies\n");
 
 	/* Reset could be controlled by the BIOS or shared by multiple amps */
-	cs35l56->reset_gpio = devm_gpiod_get_optional(cs35l56->dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(cs35l56->reset_gpio)) {
-		ret = PTR_ERR(cs35l56->reset_gpio);
+	cs35l56->base.reset_gpio = devm_gpiod_get_optional(cs35l56->base.dev, "reset",
+							   GPIOD_OUT_LOW);
+	if (IS_ERR(cs35l56->base.reset_gpio)) {
+		ret = PTR_ERR(cs35l56->base.reset_gpio);
 		/*
 		 * If RESET is shared the first amp to probe will grab the reset
 		 * line and reset all the amps
 		 */
 		if (ret != -EBUSY)
-			return dev_err_probe(cs35l56->dev, ret, "Failed to get reset GPIO\n");
+			return dev_err_probe(cs35l56->base.dev, ret, "Failed to get reset GPIO\n");
 
-		dev_info(cs35l56->dev, "Reset GPIO busy, assume shared reset\n");
-		cs35l56->reset_gpio = NULL;
+		dev_info(cs35l56->base.dev, "Reset GPIO busy, assume shared reset\n");
+		cs35l56->base.reset_gpio = NULL;
 	}
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(cs35l56->supplies), cs35l56->supplies);
 	if (ret != 0)
-		return dev_err_probe(cs35l56->dev, ret, "Failed to enable supplies\n");
+		return dev_err_probe(cs35l56->base.dev, ret, "Failed to enable supplies\n");
 
-	if (cs35l56->reset_gpio) {
+	if (cs35l56->base.reset_gpio) {
 		cs35l56_wait_min_reset_pulse();
-		gpiod_set_value_cansleep(cs35l56->reset_gpio, 1);
+		gpiod_set_value_cansleep(cs35l56->base.reset_gpio, 1);
 	}
 
 	ret = cs35l56_acpi_get_name(cs35l56);
@@ -1426,22 +1430,22 @@ int cs35l56_common_probe(struct cs35l56_private *cs35l56)
 
 	ret = cs35l56_dsp_init(cs35l56);
 	if (ret < 0) {
-		dev_err_probe(cs35l56->dev, ret, "DSP init failed\n");
+		dev_err_probe(cs35l56->base.dev, ret, "DSP init failed\n");
 		goto err;
 	}
 
-	ret = devm_snd_soc_register_component(cs35l56->dev,
+	ret = devm_snd_soc_register_component(cs35l56->base.dev,
 					      &soc_component_dev_cs35l56,
 					      cs35l56_dai, ARRAY_SIZE(cs35l56_dai));
 	if (ret < 0) {
-		dev_err_probe(cs35l56->dev, ret, "Register codec failed\n");
+		dev_err_probe(cs35l56->base.dev, ret, "Register codec failed\n");
 		goto err;
 	}
 
 	return 0;
 
 err:
-	gpiod_set_value_cansleep(cs35l56->reset_gpio, 0);
+	gpiod_set_value_cansleep(cs35l56->base.reset_gpio, 0);
 	regulator_bulk_disable(ARRAY_SIZE(cs35l56->supplies), cs35l56->supplies);
 
 	return ret;
@@ -1460,20 +1464,20 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 	if (cs35l56->soft_resetting)
 		goto post_soft_reset;
 
-	if (cs35l56->init_done)
+	if (cs35l56->base.init_done)
 		return 0;
 
-	pm_runtime_set_autosuspend_delay(cs35l56->dev, 100);
-	pm_runtime_use_autosuspend(cs35l56->dev);
-	pm_runtime_set_active(cs35l56->dev);
-	pm_runtime_enable(cs35l56->dev);
+	pm_runtime_set_autosuspend_delay(cs35l56->base.dev, 100);
+	pm_runtime_use_autosuspend(cs35l56->base.dev);
+	pm_runtime_set_active(cs35l56->base.dev);
+	pm_runtime_enable(cs35l56->base.dev);
 
 	/*
 	 * If the system is not using a reset_gpio then issue a
 	 * dummy read to force a wakeup.
 	 */
-	if (!cs35l56->reset_gpio)
-		regmap_read(cs35l56->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1, &devid);
+	if (!cs35l56->base.reset_gpio)
+		regmap_read(cs35l56->base.regmap, CS35L56_DSP_VIRTUAL1_MBOX_1, &devid);
 
 	/* Wait for control port to be ready (datasheet tIRS). */
 	usleep_range(CS35L56_CONTROL_PORT_READY_US,
@@ -1484,20 +1488,20 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 	 * devices so the REVID needs to be determined before waiting for the
 	 * firmware to boot.
 	 */
-	ret = regmap_read(cs35l56->regmap, CS35L56_REVID, &revid);
+	ret = regmap_read(cs35l56->base.regmap, CS35L56_REVID, &revid);
 	if (ret < 0) {
-		dev_err(cs35l56->dev, "Get Revision ID failed\n");
+		dev_err(cs35l56->base.dev, "Get Revision ID failed\n");
 		return ret;
 	}
-	cs35l56->rev = revid & (CS35L56_AREVID_MASK | CS35L56_MTLREVID_MASK);
+	cs35l56->base.rev = revid & (CS35L56_AREVID_MASK | CS35L56_MTLREVID_MASK);
 
-	ret = cs35l56_wait_for_firmware_boot(cs35l56);
+	ret = cs35l56_wait_for_firmware_boot(&cs35l56->base);
 	if (ret)
 		return ret;
 
-	ret = regmap_read(cs35l56->regmap, CS35L56_DEVID, &devid);
+	ret = regmap_read(cs35l56->base.regmap, CS35L56_DEVID, &devid);
 	if (ret < 0) {
-		dev_err(cs35l56->dev, "Get Device ID failed\n");
+		dev_err(cs35l56->base.dev, "Get Device ID failed\n");
 		return ret;
 	}
 	devid &= CS35L56_DEVID_MASK;
@@ -1506,50 +1510,50 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 	case 0x35A56:
 		break;
 	default:
-		dev_err(cs35l56->dev, "Unknown device %x\n", devid);
+		dev_err(cs35l56->base.dev, "Unknown device %x\n", devid);
 		return ret;
 	}
 
-	ret = regmap_read(cs35l56->regmap, CS35L56_DSP_RESTRICT_STS1, &secured);
+	ret = regmap_read(cs35l56->base.regmap, CS35L56_DSP_RESTRICT_STS1, &secured);
 	if (ret) {
-		dev_err(cs35l56->dev, "Get Secure status failed\n");
+		dev_err(cs35l56->base.dev, "Get Secure status failed\n");
 		return ret;
 	}
 
 	/* When any bus is restricted treat the device as secured */
 	if (secured & CS35L56_RESTRICTED_MASK)
-		cs35l56->secured = true;
+		cs35l56->base.secured = true;
 
-	ret = regmap_read(cs35l56->regmap, CS35L56_OTPID, &otpid);
+	ret = regmap_read(cs35l56->base.regmap, CS35L56_OTPID, &otpid);
 	if (ret < 0) {
-		dev_err(cs35l56->dev, "Get OTP ID failed\n");
+		dev_err(cs35l56->base.dev, "Get OTP ID failed\n");
 		return ret;
 	}
 
-	dev_info(cs35l56->dev, "Cirrus Logic CS35L56%s Rev %02X OTP%d\n",
-		 cs35l56->secured ? "s" : "", cs35l56->rev, otpid);
+	dev_info(cs35l56->base.dev, "Cirrus Logic CS35L56%s Rev %02X OTP%d\n",
+		 cs35l56->base.secured ? "s" : "", cs35l56->base.rev, otpid);
 
 	/* Populate the DSP information with the revision and security state */
-	cs35l56->dsp.part = devm_kasprintf(cs35l56->dev, GFP_KERNEL, "cs35l56%s-%02x",
-					   cs35l56->secured ? "s" : "", cs35l56->rev);
+	cs35l56->dsp.part = devm_kasprintf(cs35l56->base.dev, GFP_KERNEL, "cs35l56%s-%02x",
+					   cs35l56->base.secured ? "s" : "", cs35l56->base.rev);
 	if (!cs35l56->dsp.part)
 		return -ENOMEM;
 
 	/* Wake source and *_BLOCKED interrupts default to unmasked, so mask them */
-	regmap_write(cs35l56->regmap, CS35L56_IRQ1_MASK_20, 0xffffffff);
-	regmap_update_bits(cs35l56->regmap, CS35L56_IRQ1_MASK_1,
+	regmap_write(cs35l56->base.regmap, CS35L56_IRQ1_MASK_20, 0xffffffff);
+	regmap_update_bits(cs35l56->base.regmap, CS35L56_IRQ1_MASK_1,
 			   CS35L56_AMP_SHORT_ERR_EINT1_MASK,
 			   0);
-	regmap_update_bits(cs35l56->regmap, CS35L56_IRQ1_MASK_8,
+	regmap_update_bits(cs35l56->base.regmap, CS35L56_IRQ1_MASK_8,
 			   CS35L56_TEMP_ERR_EINT1_MASK,
 			   0);
 
-	if (!cs35l56->reset_gpio) {
-		dev_dbg(cs35l56->dev, "No reset gpio: using soft reset\n");
+	if (!cs35l56->base.reset_gpio) {
+		dev_dbg(cs35l56->base.dev, "No reset gpio: using soft reset\n");
 		cs35l56_system_reset(cs35l56);
 		if (cs35l56->sdw_peripheral) {
 			/* Keep alive while we wait for re-enumeration */
-			pm_runtime_get_noresume(cs35l56->dev);
+			pm_runtime_get_noresume(cs35l56->base.dev);
 			return 0;
 		}
 	}
@@ -1559,29 +1563,29 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 		cs35l56->soft_resetting = false;
 
 		/* Done re-enumerating after one-time init so release the keep-alive */
-		if (cs35l56->sdw_peripheral && !cs35l56->init_done)
-			pm_runtime_put_noidle(cs35l56->dev);
+		if (cs35l56->sdw_peripheral && !cs35l56->base.init_done)
+			pm_runtime_put_noidle(cs35l56->base.dev);
 
-		regcache_mark_dirty(cs35l56->regmap);
-		ret = cs35l56_wait_for_firmware_boot(cs35l56);
+		regcache_mark_dirty(cs35l56->base.regmap);
+		ret = cs35l56_wait_for_firmware_boot(&cs35l56->base);
 		if (ret)
 			return ret;
 
-		dev_dbg(cs35l56->dev, "Firmware rebooted after soft reset\n");
+		dev_dbg(cs35l56->base.dev, "Firmware rebooted after soft reset\n");
 	}
 
 	/* Disable auto-hibernate so that runtime_pm has control */
-	ret = cs35l56_mbox_send(cs35l56, CS35L56_MBOX_CMD_PREVENT_AUTO_HIBERNATE);
+	ret = cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_PREVENT_AUTO_HIBERNATE);
 	if (ret)
 		return ret;
 
 	/* Populate soft registers in the regmap cache */
-	cs35l56_reread_firmware_registers(cs35l56->dev, cs35l56->regmap);
+	cs35l56_reread_firmware_registers(&cs35l56->base);
 
 	/* Registers could be dirty after soft reset or SoundWire enumeration */
-	regcache_sync(cs35l56->regmap);
+	regcache_sync(cs35l56->base.regmap);
 
-	cs35l56->init_done = true;
+	cs35l56->base.init_done = true;
 	complete(&cs35l56->init_completion);
 
 	return 0;
@@ -1590,26 +1594,26 @@ EXPORT_SYMBOL_NS_GPL(cs35l56_init, SND_SOC_CS35L56_CORE);
 
 void cs35l56_remove(struct cs35l56_private *cs35l56)
 {
-	cs35l56->init_done = false;
+	cs35l56->base.init_done = false;
 
 	/*
 	 * WAKE IRQs unmask if CS35L56 hibernates so free the handler to
 	 * prevent it racing with remove().
 	 */
-	if (cs35l56->irq)
-		devm_free_irq(cs35l56->dev, cs35l56->irq, cs35l56);
+	if (cs35l56->base.irq)
+		devm_free_irq(cs35l56->base.dev, cs35l56->base.irq, cs35l56);
 
 	flush_workqueue(cs35l56->dsp_wq);
 	destroy_workqueue(cs35l56->dsp_wq);
 
-	pm_runtime_suspend(cs35l56->dev);
-	pm_runtime_disable(cs35l56->dev);
+	pm_runtime_suspend(cs35l56->base.dev);
+	pm_runtime_disable(cs35l56->base.dev);
 
-	regcache_cache_only(cs35l56->regmap, true);
+	regcache_cache_only(cs35l56->base.regmap, true);
 
 	kfree(cs35l56->dsp.system_name);
 
-	gpiod_set_value_cansleep(cs35l56->reset_gpio, 0);
+	gpiod_set_value_cansleep(cs35l56->base.reset_gpio, 0);
 	regulator_bulk_disable(ARRAY_SIZE(cs35l56->supplies), cs35l56->supplies);
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_remove, SND_SOC_CS35L56_CORE);
diff --git a/sound/soc/codecs/cs35l56.h b/sound/soc/codecs/cs35l56.h
index 1f7894662fcb..f39f8fa9e37e 100644
--- a/sound/soc/codecs/cs35l56.h
+++ b/sound/soc/codecs/cs35l56.h
@@ -32,26 +32,17 @@ struct sdw_slave;
 
 struct cs35l56_private {
 	struct wm_adsp dsp; /* must be first member */
+	struct cs35l56_base base;
 	struct work_struct dsp_work;
 	struct workqueue_struct *dsp_wq;
-	struct mutex irq_lock;
 	struct snd_soc_component *component;
-	struct device *dev;
-	struct regmap *regmap;
 	struct regulator_bulk_data supplies[CS35L56_NUM_BULK_SUPPLIES];
-	int irq;
 	struct sdw_slave *sdw_peripheral;
-	u8 rev;
 	struct work_struct sdw_irq_work;
-	bool secured;
 	bool sdw_irq_no_unmask;
 	bool soft_resetting;
-	bool init_done;
 	bool sdw_attached;
-	bool fw_patched;
-	bool can_hibernate;
 	struct completion init_completion;
-	struct gpio_desc *reset_gpio;
 
 	u32 rx_mask;
 	u32 tx_mask;
@@ -73,7 +64,7 @@ int cs35l56_system_resume_no_irq(struct device *dev);
 int cs35l56_system_resume_early(struct device *dev);
 int cs35l56_system_resume(struct device *dev);
 irqreturn_t cs35l56_irq(int irq, void *data);
-int cs35l56_irq_request(struct cs35l56_private *cs35l56, int irq);
+int cs35l56_irq_request(struct cs35l56_base *cs35l56_base, int irq);
 int cs35l56_common_probe(struct cs35l56_private *cs35l56);
 int cs35l56_init(struct cs35l56_private *cs35l56);
 void cs35l56_remove(struct cs35l56_private *cs35l56);
-- 
2.30.2

