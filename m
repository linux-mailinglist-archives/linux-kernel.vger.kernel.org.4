Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E61710F24
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241511AbjEYPIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241471AbjEYPHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:07:35 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB92199
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:07:32 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PEE1BH025344;
        Thu, 25 May 2023 10:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=YTFWU+MhIORTvxxidwK1NyZQlYDjXyonRb28HJ1jWEo=;
 b=p5d4V2Rm6DkzOAx/sp7YqniUj1fo943ZxdY0MQisA2W7b6bgPnks8lGYyzb5p3QJ/rJf
 EyTa1Ftg3+BVDcfajTLjBXDRuh0X2McEr9I9e6liubtSTNq8tEZXFEqt7F97NmSsVuIU
 fmIp8lvNER4dYjMqcHoWcB+GFe9osN72ITG2Q6pIbF1Buk8H0Ap827i5mRkr2eQzGlna
 Dex5u2CYnAnym3tmSGfNskwsqbr1/0UrV/lGDZiaV6ekYLVOe3CcOaqIL6oTo19TUN8f
 xJ9m/o6cXmunWk3WbOokj2VSsWWdOExWt0ZJkdOxtq2AH1bs5OxH7IhMfIZrICiN67Eu qw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qptmm70m7-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 10:07:06 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 25 May
 2023 10:07:03 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 10:07:03 -0500
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.166])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 260B015B4;
        Thu, 25 May 2023 15:07:03 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>, <broonie@kernel.org>, <perex@perex.cz>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 05/13] ASoC: cs35l56: Move runtime suspend/resume to shared library
Date:   Thu, 25 May 2023 16:06:51 +0100
Message-ID: <20230525150659.25409-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230525150659.25409-1-rf@opensource.cirrus.com>
References: <20230525150659.25409-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6Ue6YrMAH2QxjrErGvGGc8tXD-n3GX8m
X-Proofpoint-GUID: 6Ue6YrMAH2QxjrErGvGGc8tXD-n3GX8m
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

The majority of runtime_suspend and runtime_resume handling
doesn't have anything specific to the ASoC driver, so can be
shared by the HDA driver. Move this code into the shared
library.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs35l56.h           |   2 +
 sound/soc/codecs/cs35l56-sdw.c    |   4 +-
 sound/soc/codecs/cs35l56-shared.c | 118 +++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l56.c        | 120 +-----------------------------
 sound/soc/codecs/cs35l56.h        |   2 -
 5 files changed, 126 insertions(+), 120 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 4d270eb23473..4a885c2321c1 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -281,6 +281,8 @@ void cs35l56_system_reset(struct cs35l56_base *cs35l56_base, bool is_soundwire);
 int cs35l56_irq_request(struct cs35l56_base *cs35l56_base, int irq);
 irqreturn_t cs35l56_irq(int irq, void *data);
 int cs35l56_is_fw_reload_needed(struct cs35l56_base *cs35l56_base);
+int cs35l56_runtime_suspend_common(struct cs35l56_base *cs35l56_base);
+int cs35l56_runtime_resume_common(struct cs35l56_base *cs35l56_base, bool is_soundwire);
 int cs35l56_get_bclk_freq_id(unsigned int freq);
 void cs35l56_fill_supply_names(struct regulator_bulk_data *data);
 
diff --git a/sound/soc/codecs/cs35l56-sdw.c b/sound/soc/codecs/cs35l56-sdw.c
index e6c9e8bce22c..09d255cc7652 100644
--- a/sound/soc/codecs/cs35l56-sdw.c
+++ b/sound/soc/codecs/cs35l56-sdw.c
@@ -424,7 +424,7 @@ static int __maybe_unused cs35l56_sdw_runtime_suspend(struct device *dev)
 	if (!cs35l56->base.init_done)
 		return 0;
 
-	return cs35l56_runtime_suspend(dev);
+	return cs35l56_runtime_suspend_common(&cs35l56->base);
 }
 
 static int __maybe_unused cs35l56_sdw_runtime_resume(struct device *dev)
@@ -441,7 +441,7 @@ static int __maybe_unused cs35l56_sdw_runtime_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	ret = cs35l56_runtime_resume_common(cs35l56);
+	ret = cs35l56_runtime_resume_common(&cs35l56->base, true);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 93cd898dbab6..194fa08e1cc2 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -408,6 +408,124 @@ int cs35l56_is_fw_reload_needed(struct cs35l56_base *cs35l56_base)
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_is_fw_reload_needed, SND_SOC_CS35L56_SHARED);
 
+static const struct reg_sequence cs35l56_hibernate_seq[] = {
+	/* This must be the last register access */
+	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_HIBERNATE_NOW),
+};
+
+static const struct reg_sequence cs35l56_hibernate_wake_seq[] = {
+	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_WAKEUP),
+};
+
+int cs35l56_runtime_suspend_common(struct cs35l56_base *cs35l56_base)
+{
+	unsigned int val;
+	int ret;
+
+	if (!cs35l56_base->init_done)
+		return 0;
+
+	/* Firmware must have entered a power-save state */
+	ret = regmap_read_poll_timeout(cs35l56_base->regmap,
+				       CS35L56_TRANSDUCER_ACTUAL_PS,
+				       val, (val >= CS35L56_PS3),
+				       CS35L56_PS3_POLL_US,
+				       CS35L56_PS3_TIMEOUT_US);
+	if (ret)
+		dev_warn(cs35l56_base->dev, "PS3 wait failed: %d\n", ret);
+
+	/* Clear BOOT_DONE so it can be used to detect a reboot */
+	regmap_write(cs35l56_base->regmap, CS35L56_IRQ1_EINT_4, CS35L56_OTP_BOOT_DONE_MASK);
+
+	if (!cs35l56_base->can_hibernate) {
+		regcache_cache_only(cs35l56_base->regmap, true);
+		dev_dbg(cs35l56_base->dev, "Suspended: no hibernate");
+
+		return 0;
+	}
+
+	/*
+	 * Enable auto-hibernate. If it is woken by some other wake source
+	 * it will automatically return to hibernate.
+	 */
+	cs35l56_mbox_send(cs35l56_base, CS35L56_MBOX_CMD_ALLOW_AUTO_HIBERNATE);
+
+	/*
+	 * Must enter cache-only first so there can't be any more register
+	 * accesses other than the controlled hibernate sequence below.
+	 */
+	regcache_cache_only(cs35l56_base->regmap, true);
+
+	regmap_multi_reg_write_bypassed(cs35l56_base->regmap,
+					cs35l56_hibernate_seq,
+					ARRAY_SIZE(cs35l56_hibernate_seq));
+
+	dev_dbg(cs35l56_base->dev, "Suspended: hibernate");
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_runtime_suspend_common, SND_SOC_CS35L56_SHARED);
+
+int cs35l56_runtime_resume_common(struct cs35l56_base *cs35l56_base, bool is_soundwire)
+{
+	unsigned int val;
+	int ret;
+
+	if (!cs35l56_base->init_done)
+		return 0;
+
+	if (!cs35l56_base->can_hibernate)
+		goto out_sync;
+
+	if (!is_soundwire) {
+		/*
+		 * Dummy transaction to trigger I2C/SPI auto-wake. This will NAK on I2C.
+		 * Must be done before releasing cache-only.
+		 */
+		regmap_multi_reg_write_bypassed(cs35l56_base->regmap,
+						cs35l56_hibernate_wake_seq,
+						ARRAY_SIZE(cs35l56_hibernate_wake_seq));
+
+		usleep_range(CS35L56_CONTROL_PORT_READY_US,
+			     CS35L56_CONTROL_PORT_READY_US + 400);
+	}
+
+out_sync:
+	regcache_cache_only(cs35l56_base->regmap, false);
+
+	ret = cs35l56_wait_for_firmware_boot(cs35l56_base);
+	if (ret) {
+		dev_err(cs35l56_base->dev, "Hibernate wake failed: %d\n", ret);
+		goto err;
+	}
+
+	ret = cs35l56_mbox_send(cs35l56_base, CS35L56_MBOX_CMD_PREVENT_AUTO_HIBERNATE);
+	if (ret)
+		goto err;
+
+	/* BOOT_DONE will be 1 if the amp reset */
+	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_EINT_4, &val);
+	if (val & CS35L56_OTP_BOOT_DONE_MASK) {
+		dev_dbg(cs35l56_base->dev, "Registers reset in suspend\n");
+		regcache_mark_dirty(cs35l56_base->regmap);
+	}
+
+	regcache_sync(cs35l56_base->regmap);
+
+	dev_dbg(cs35l56_base->dev, "Resumed");
+
+	return 0;
+
+err:
+	regmap_write(cs35l56_base->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1,
+		     CS35L56_MBOX_CMD_HIBERNATE_NOW);
+
+	regcache_cache_only(cs35l56_base->regmap, true);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_runtime_resume_common, SND_SOC_CS35L56_SHARED);
+
 const struct cs_dsp_region cs35l56_dsp1_regions[] = {
 	{ .type = WMFW_HALO_PM_PACKED,	.base = CS35L56_DSP1_PMEM_0 },
 	{ .type = WMFW_HALO_XM_PACKED,	.base = CS35L56_DSP1_XMEM_PACKED_0 },
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index c1c7b7e408c3..ce8142249f05 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -852,132 +852,20 @@ static const struct snd_soc_component_driver soc_component_dev_cs35l56 = {
 	.suspend_bias_off = 1, /* see cs35l56_system_resume() */
 };
 
-static const struct reg_sequence cs35l56_hibernate_seq[] = {
-	/* This must be the last register access */
-	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_HIBERNATE_NOW),
-};
-
-static const struct reg_sequence cs35l56_hibernate_wake_seq[] = {
-	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_WAKEUP),
-};
-
-int cs35l56_runtime_suspend(struct device *dev)
+static int __maybe_unused cs35l56_runtime_suspend_i2c_spi(struct device *dev)
 {
 	struct cs35l56_private *cs35l56 = dev_get_drvdata(dev);
-	unsigned int val;
-	int ret;
 
-	if (!cs35l56->base.init_done)
-		return 0;
-
-	/* Firmware must have entered a power-save state */
-	ret = regmap_read_poll_timeout(cs35l56->base.regmap,
-				       CS35L56_TRANSDUCER_ACTUAL_PS,
-				       val, (val >= CS35L56_PS3),
-				       CS35L56_PS3_POLL_US,
-				       CS35L56_PS3_TIMEOUT_US);
-	if (ret)
-		dev_warn(cs35l56->base.dev, "PS3 wait failed: %d\n", ret);
-
-	/* Clear BOOT_DONE so it can be used to detect a reboot */
-	regmap_write(cs35l56->base.regmap, CS35L56_IRQ1_EINT_4, CS35L56_OTP_BOOT_DONE_MASK);
-
-	if (!cs35l56->base.can_hibernate) {
-		regcache_cache_only(cs35l56->base.regmap, true);
-		dev_dbg(dev, "Suspended: no hibernate");
-
-		return 0;
-	}
-
-	/*
-	 * Enable auto-hibernate. If it is woken by some other wake source
-	 * it will automatically return to hibernate.
-	 */
-	cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_ALLOW_AUTO_HIBERNATE);
-
-	/*
-	 * Must enter cache-only first so there can't be any more register
-	 * accesses other than the controlled hibernate sequence below.
-	 */
-	regcache_cache_only(cs35l56->base.regmap, true);
-
-	regmap_multi_reg_write_bypassed(cs35l56->base.regmap,
-					cs35l56_hibernate_seq,
-					ARRAY_SIZE(cs35l56_hibernate_seq));
-
-	dev_dbg(dev, "Suspended: hibernate");
-
-	return 0;
+	return cs35l56_runtime_suspend_common(&cs35l56->base);
 }
-EXPORT_SYMBOL_NS_GPL(cs35l56_runtime_suspend, SND_SOC_CS35L56_CORE);
 
 static int __maybe_unused cs35l56_runtime_resume_i2c_spi(struct device *dev)
 {
 	struct cs35l56_private *cs35l56 = dev_get_drvdata(dev);
 
-	if (!cs35l56->base.init_done)
-		return 0;
-
-	return cs35l56_runtime_resume_common(cs35l56);
+	return cs35l56_runtime_resume_common(&cs35l56->base, false);
 }
 
-int cs35l56_runtime_resume_common(struct cs35l56_private *cs35l56)
-{
-	unsigned int val;
-	int ret;
-
-	if (!cs35l56->base.can_hibernate)
-		goto out_sync;
-
-	if (!cs35l56->sdw_peripheral) {
-		/*
-		 * Dummy transaction to trigger I2C/SPI auto-wake. This will NAK on I2C.
-		 * Must be done before releasing cache-only.
-		 */
-		regmap_multi_reg_write_bypassed(cs35l56->base.regmap,
-						cs35l56_hibernate_wake_seq,
-						ARRAY_SIZE(cs35l56_hibernate_wake_seq));
-
-		usleep_range(CS35L56_CONTROL_PORT_READY_US,
-			     CS35L56_CONTROL_PORT_READY_US + 400);
-	}
-
-out_sync:
-	regcache_cache_only(cs35l56->base.regmap, false);
-
-	ret = cs35l56_wait_for_firmware_boot(&cs35l56->base);
-	if (ret) {
-		dev_err(cs35l56->base.dev, "Hibernate wake failed: %d\n", ret);
-		goto err;
-	}
-
-	ret = cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_PREVENT_AUTO_HIBERNATE);
-	if (ret)
-		goto err;
-
-	/* BOOT_DONE will be 1 if the amp reset */
-	regmap_read(cs35l56->base.regmap, CS35L56_IRQ1_EINT_4, &val);
-	if (val & CS35L56_OTP_BOOT_DONE_MASK) {
-		dev_dbg(cs35l56->base.dev, "Registers reset in suspend\n");
-		regcache_mark_dirty(cs35l56->base.regmap);
-	}
-
-	regcache_sync(cs35l56->base.regmap);
-
-	dev_dbg(cs35l56->base.dev, "Resumed");
-
-	return 0;
-
-err:
-	regmap_write(cs35l56->base.regmap, CS35L56_DSP_VIRTUAL1_MBOX_1,
-		     CS35L56_MBOX_CMD_HIBERNATE_NOW);
-
-	regcache_cache_only(cs35l56->base.regmap, true);
-
-	return ret;
-}
-EXPORT_SYMBOL_NS_GPL(cs35l56_runtime_resume_common, SND_SOC_CS35L56_CORE);
-
 int cs35l56_system_suspend(struct device *dev)
 {
 	struct cs35l56_private *cs35l56 = dev_get_drvdata(dev);
@@ -1416,7 +1304,7 @@ void cs35l56_remove(struct cs35l56_private *cs35l56)
 EXPORT_SYMBOL_NS_GPL(cs35l56_remove, SND_SOC_CS35L56_CORE);
 
 const struct dev_pm_ops cs35l56_pm_ops_i2c_spi = {
-	SET_RUNTIME_PM_OPS(cs35l56_runtime_suspend, cs35l56_runtime_resume_i2c_spi, NULL)
+	SET_RUNTIME_PM_OPS(cs35l56_runtime_suspend_i2c_spi, cs35l56_runtime_resume_i2c_spi, NULL)
 	SYSTEM_SLEEP_PM_OPS(cs35l56_system_suspend, cs35l56_system_resume)
 	LATE_SYSTEM_SLEEP_PM_OPS(cs35l56_system_suspend_late, cs35l56_system_resume_early)
 	NOIRQ_SYSTEM_SLEEP_PM_OPS(cs35l56_system_suspend_no_irq, cs35l56_system_resume_no_irq)
diff --git a/sound/soc/codecs/cs35l56.h b/sound/soc/codecs/cs35l56.h
index f39f8fa9e37e..8159c3e217d9 100644
--- a/sound/soc/codecs/cs35l56.h
+++ b/sound/soc/codecs/cs35l56.h
@@ -55,8 +55,6 @@ struct cs35l56_private {
 
 extern const struct dev_pm_ops cs35l56_pm_ops_i2c_spi;
 
-int cs35l56_runtime_suspend(struct device *dev);
-int cs35l56_runtime_resume_common(struct cs35l56_private *cs35l56);
 int cs35l56_system_suspend(struct device *dev);
 int cs35l56_system_suspend_late(struct device *dev);
 int cs35l56_system_suspend_no_irq(struct device *dev);
-- 
2.30.2

