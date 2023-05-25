Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDECA7110E6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240586AbjEYQ1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240074AbjEYQ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:26:43 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE6C19A
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:26:40 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PEEWVC026032;
        Thu, 25 May 2023 11:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=ppg0+PZKB7EwgPPkxrUAWwZqi0ulP9/yIwPqN9AKEy0=;
 b=H2HcaXebvLNM17AvxCaoQRrEKi46taUxUN1IEGC2NoPmHHy41PgfJV2WPuUA4Wxa1yLT
 XmQddxLY0wBdfgiQEV20JkJjrkGTqr5BR0H+SL9uLf9nfNPYjsdAIKYmchzlcGg0bvGT
 283mCrmGBEtqJFxBSXFGTRi5KVFxWGDNMhjSuHvNE9JCGv3PDf+l3yt9PWWOoFTJZO/T
 qBFn5rGjpkqcZ5I/f2dQhBJJgUjNH7bKQiXt/shlb6qoIsht75XWNqmlMhC+l0Z3BybB
 lagAAf4ecafpilCT49WZyDMMOgbtk51CsFjSlaSF8ANfmolH99mo+imzTRKFWde16Qxv 3Q== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qptmm74vu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:26:26 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 25 May
 2023 11:26:24 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 11:26:24 -0500
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.166])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C47F915B4;
        Thu, 25 May 2023 16:26:23 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>, <broonie@kernel.org>, <perex@perex.cz>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 04/12] ASoC: cs35l56: Move utility functions to shared file
Date:   Thu, 25 May 2023 17:26:10 +0100
Message-ID: <20230525162618.20146-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230525162618.20146-1-rf@opensource.cirrus.com>
References: <20230525162618.20146-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: AV6od07nYkAt-Drf3FfeUorK6PNaeJHT
X-Proofpoint-GUID: AV6od07nYkAt-Drf3FfeUorK6PNaeJHT
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

Move the cs35l56 utility functions into the shared file so they are
available for use in HDA.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 include/sound/cs35l56.h           |   7 +
 sound/soc/codecs/cs35l56-shared.c | 208 ++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l56.c        | 203 -----------------------------
 3 files changed, 215 insertions(+), 203 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 3a029c6621c9..4d270eb23473 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -274,6 +274,13 @@ extern const char * const cs35l56_tx_input_texts[CS35L56_NUM_INPUT_SRC];
 extern const unsigned int cs35l56_tx_input_values[CS35L56_NUM_INPUT_SRC];
 
 void cs35l56_reread_firmware_registers(struct cs35l56_base *cs35l56_base);
+int cs35l56_mbox_send(struct cs35l56_base *cs35l56_base, unsigned int command);
+int cs35l56_wait_for_firmware_boot(struct cs35l56_base *cs35l56_base);
+void cs35l56_wait_min_reset_pulse(void);
+void cs35l56_system_reset(struct cs35l56_base *cs35l56_base, bool is_soundwire);
+int cs35l56_irq_request(struct cs35l56_base *cs35l56_base, int irq);
+irqreturn_t cs35l56_irq(int irq, void *data);
+int cs35l56_is_fw_reload_needed(struct cs35l56_base *cs35l56_base);
 int cs35l56_get_bclk_freq_id(unsigned int freq);
 void cs35l56_fill_supply_names(struct regulator_bulk_data *data);
 
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 0cbaf8c7b05a..93cd898dbab6 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -200,6 +200,214 @@ void cs35l56_reread_firmware_registers(struct cs35l56_base *cs35l56_base)
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_reread_firmware_registers, SND_SOC_CS35L56_SHARED);
 
+int cs35l56_mbox_send(struct cs35l56_base *cs35l56_base, unsigned int command)
+{
+	unsigned int val;
+	int ret;
+
+	regmap_write(cs35l56_base->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1, command);
+	ret = regmap_read_poll_timeout(cs35l56_base->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1,
+				       val, (val == 0),
+				       CS35L56_MBOX_POLL_US, CS35L56_MBOX_TIMEOUT_US);
+	if (ret) {
+		dev_warn(cs35l56_base->dev, "MBOX command %#x failed: %d\n", command, ret);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_mbox_send, SND_SOC_CS35L56_SHARED);
+
+int cs35l56_wait_for_firmware_boot(struct cs35l56_base *cs35l56_base)
+{
+	unsigned int reg;
+	unsigned int val;
+	int ret;
+
+	if (cs35l56_base->rev < CS35L56_REVID_B0)
+		reg = CS35L56_DSP1_HALO_STATE_A1;
+	else
+		reg = CS35L56_DSP1_HALO_STATE;
+
+	ret = regmap_read_poll_timeout(cs35l56_base->regmap, reg,
+				       val,
+				       (val < 0xFFFF) && (val >= CS35L56_HALO_STATE_BOOT_DONE),
+				       CS35L56_HALO_STATE_POLL_US,
+				       CS35L56_HALO_STATE_TIMEOUT_US);
+
+	if ((ret < 0) && (ret != -ETIMEDOUT)) {
+		dev_err(cs35l56_base->dev, "Failed to read HALO_STATE: %d\n", ret);
+		return ret;
+	}
+
+	if ((ret == -ETIMEDOUT) || (val != CS35L56_HALO_STATE_BOOT_DONE)) {
+		dev_err(cs35l56_base->dev, "Firmware boot fail: HALO_STATE=%#x\n", val);
+		return -EIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_wait_for_firmware_boot, SND_SOC_CS35L56_SHARED);
+
+void cs35l56_wait_min_reset_pulse(void)
+{
+	/* Satisfy minimum reset pulse width spec */
+	usleep_range(CS35L56_RESET_PULSE_MIN_US, 2 * CS35L56_RESET_PULSE_MIN_US);
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_wait_min_reset_pulse, SND_SOC_CS35L56_SHARED);
+
+static const struct reg_sequence cs35l56_system_reset_seq[] = {
+	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_SYSTEM_RESET),
+};
+
+void cs35l56_system_reset(struct cs35l56_base *cs35l56_base, bool is_soundwire)
+{
+	/*
+	 * Must enter cache-only first so there can't be any more register
+	 * accesses other than the controlled system reset sequence below.
+	 */
+	regcache_cache_only(cs35l56_base->regmap, true);
+	regmap_multi_reg_write_bypassed(cs35l56_base->regmap,
+					cs35l56_system_reset_seq,
+					ARRAY_SIZE(cs35l56_system_reset_seq));
+
+	/* On SoundWire the registers won't be accessible until it re-enumerates. */
+	if (is_soundwire)
+		return;
+
+	usleep_range(CS35L56_CONTROL_PORT_READY_US, CS35L56_CONTROL_PORT_READY_US + 400);
+	regcache_cache_only(cs35l56_base->regmap, false);
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_system_reset, SND_SOC_CS35L56_SHARED);
+
+int cs35l56_irq_request(struct cs35l56_base *cs35l56_base, int irq)
+{
+	int ret;
+
+	if (!irq)
+		return 0;
+
+	ret = devm_request_threaded_irq(cs35l56_base->dev, irq, NULL, cs35l56_irq,
+					IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_LOW,
+					"cs35l56", cs35l56_base);
+	if (!ret)
+		cs35l56_base->irq = irq;
+	else
+		dev_err(cs35l56_base->dev, "Failed to get IRQ: %d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_irq_request, SND_SOC_CS35L56_SHARED);
+
+irqreturn_t cs35l56_irq(int irq, void *data)
+{
+	struct cs35l56_base *cs35l56_base = data;
+	unsigned int status1 = 0, status8 = 0, status20 = 0;
+	unsigned int mask1, mask8, mask20;
+	unsigned int val;
+	int rv;
+
+	irqreturn_t ret = IRQ_NONE;
+
+	if (!cs35l56_base->init_done)
+		return IRQ_NONE;
+
+	mutex_lock(&cs35l56_base->irq_lock);
+
+	rv = pm_runtime_resume_and_get(cs35l56_base->dev);
+	if (rv < 0) {
+		dev_err(cs35l56_base->dev, "irq: failed to get pm_runtime: %d\n", rv);
+		goto err_unlock;
+	}
+
+	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_STATUS, &val);
+	if ((val & CS35L56_IRQ1_STS_MASK) == 0) {
+		dev_dbg(cs35l56_base->dev, "Spurious IRQ: no pending interrupt\n");
+		goto err;
+	}
+
+	/* Ack interrupts */
+	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_EINT_1, &status1);
+	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_MASK_1, &mask1);
+	status1 &= ~mask1;
+	regmap_write(cs35l56_base->regmap, CS35L56_IRQ1_EINT_1, status1);
+
+	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_EINT_8, &status8);
+	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_MASK_8, &mask8);
+	status8 &= ~mask8;
+	regmap_write(cs35l56_base->regmap, CS35L56_IRQ1_EINT_8, status8);
+
+	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_EINT_20, &status20);
+	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_MASK_20, &mask20);
+	status20 &= ~mask20;
+	/* We don't want EINT20 but they default to unmasked: force mask */
+	regmap_write(cs35l56_base->regmap, CS35L56_IRQ1_MASK_20, 0xffffffff);
+
+	dev_dbg(cs35l56_base->dev, "%s: %#x %#x\n", __func__, status1, status8);
+
+	/* Check to see if unmasked bits are active */
+	if (!status1 && !status8 && !status20)
+		goto err;
+
+	if (status1 & CS35L56_AMP_SHORT_ERR_EINT1_MASK)
+		dev_crit(cs35l56_base->dev, "Amp short error\n");
+
+	if (status8 & CS35L56_TEMP_ERR_EINT1_MASK)
+		dev_crit(cs35l56_base->dev, "Overtemp error\n");
+
+	ret = IRQ_HANDLED;
+
+err:
+	pm_runtime_put(cs35l56_base->dev);
+err_unlock:
+	mutex_unlock(&cs35l56_base->irq_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_irq, SND_SOC_CS35L56_SHARED);
+
+int cs35l56_is_fw_reload_needed(struct cs35l56_base *cs35l56_base)
+{
+	unsigned int val;
+	int ret;
+
+	/* Nothing to re-patch if we haven't done any patching yet. */
+	if (!cs35l56_base->fw_patched)
+		return false;
+
+	/*
+	 * If we have control of RESET we will have asserted it so the firmware
+	 * will need re-patching.
+	 */
+	if (cs35l56_base->reset_gpio)
+		return true;
+
+	/*
+	 * In secure mode FIRMWARE_MISSING is cleared by the BIOS loader so
+	 * can't be used here to test for memory retention.
+	 * Assume that tuning must be re-loaded.
+	 */
+	if (cs35l56_base->secured)
+		return true;
+
+	ret = pm_runtime_resume_and_get(cs35l56_base->dev);
+	if (ret) {
+		dev_err(cs35l56_base->dev, "Failed to runtime_get: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_read(cs35l56_base->regmap, CS35L56_PROTECTION_STATUS, &val);
+	if (ret)
+		dev_err(cs35l56_base->dev, "Failed to read PROTECTION_STATUS: %d\n", ret);
+	else
+		ret = !!(val & CS35L56_FIRMWARE_MISSING);
+
+	pm_runtime_put_autosuspend(cs35l56_base->dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_is_fw_reload_needed, SND_SOC_CS35L56_SHARED);
+
 const struct cs_dsp_region cs35l56_dsp1_regions[] = {
 	{ .type = WMFW_HALO_PM_PACKED,	.base = CS35L56_DSP1_PMEM_0 },
 	{ .type = WMFW_HALO_XM_PACKED,	.base = CS35L56_DSP1_XMEM_PACKED_0 },
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 48e856583477..c1c7b7e408c3 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -34,23 +34,6 @@
 static int cs35l56_dsp_event(struct snd_soc_dapm_widget *w,
 			     struct snd_kcontrol *kcontrol, int event);
 
-static int cs35l56_mbox_send(struct cs35l56_base *cs35l56_base, unsigned int command)
-{
-	unsigned int val;
-	int ret;
-
-	regmap_write(cs35l56_base->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1, command);
-	ret = regmap_read_poll_timeout(cs35l56_base->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1,
-				       val, (val == 0),
-				       CS35L56_MBOX_POLL_US, CS35L56_MBOX_TIMEOUT_US);
-	if (ret) {
-		dev_warn(cs35l56_base->dev, "MBOX command %#x failed: %d\n", command, ret);
-		return ret;
-	}
-
-	return 0;
-}
-
 static void cs35l56_wait_dsp_ready(struct cs35l56_private *cs35l56)
 {
 	/* Wait for patching to complete */
@@ -315,92 +298,6 @@ static int cs35l56_dsp_event(struct snd_soc_dapm_widget *w,
 	return wm_adsp_event(w, kcontrol, event);
 }
 
-irqreturn_t cs35l56_irq(int irq, void *data)
-{
-	struct cs35l56_base *cs35l56_base = data;
-	unsigned int status1 = 0, status8 = 0, status20 = 0;
-	unsigned int mask1, mask8, mask20;
-	unsigned int val;
-	int rv;
-
-	irqreturn_t ret = IRQ_NONE;
-
-	if (!cs35l56_base->init_done)
-		return IRQ_NONE;
-
-	mutex_lock(&cs35l56_base->irq_lock);
-
-	rv = pm_runtime_resume_and_get(cs35l56_base->dev);
-	if (rv < 0) {
-		dev_err(cs35l56_base->dev, "irq: failed to get pm_runtime: %d\n", rv);
-		goto err_unlock;
-	}
-
-	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_STATUS, &val);
-	if ((val & CS35L56_IRQ1_STS_MASK) == 0) {
-		dev_dbg(cs35l56_base->dev, "Spurious IRQ: no pending interrupt\n");
-		goto err;
-	}
-
-	/* Ack interrupts */
-	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_EINT_1, &status1);
-	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_MASK_1, &mask1);
-	status1 &= ~mask1;
-	regmap_write(cs35l56_base->regmap, CS35L56_IRQ1_EINT_1, status1);
-
-	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_EINT_8, &status8);
-	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_MASK_8, &mask8);
-	status8 &= ~mask8;
-	regmap_write(cs35l56_base->regmap, CS35L56_IRQ1_EINT_8, status8);
-
-	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_EINT_20, &status20);
-	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_MASK_20, &mask20);
-	status20 &= ~mask20;
-	/* We don't want EINT20 but they default to unmasked: force mask */
-	regmap_write(cs35l56_base->regmap, CS35L56_IRQ1_MASK_20, 0xffffffff);
-
-	dev_dbg(cs35l56_base->dev, "%s: %#x %#x\n", __func__, status1, status8);
-
-	/* Check to see if unmasked bits are active */
-	if (!status1 && !status8 && !status20)
-		goto err;
-
-	if (status1 & CS35L56_AMP_SHORT_ERR_EINT1_MASK)
-		dev_crit(cs35l56_base->dev, "Amp short error\n");
-
-	if (status8 & CS35L56_TEMP_ERR_EINT1_MASK)
-		dev_crit(cs35l56_base->dev, "Overtemp error\n");
-
-	ret = IRQ_HANDLED;
-
-err:
-	pm_runtime_put(cs35l56_base->dev);
-err_unlock:
-	mutex_unlock(&cs35l56_base->irq_lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_NS_GPL(cs35l56_irq, SND_SOC_CS35L56_CORE);
-
-int cs35l56_irq_request(struct cs35l56_base *cs35l56_base, int irq)
-{
-	int ret;
-
-	if (!irq)
-		return 0;
-
-	ret = devm_request_threaded_irq(cs35l56_base->dev, irq, NULL, cs35l56_irq,
-					IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_LOW,
-					"cs35l56", cs35l56_base);
-	if (!ret)
-		cs35l56_base->irq = irq;
-	else
-		dev_err(cs35l56_base->dev, "Failed to get IRQ: %d\n", ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_NS_GPL(cs35l56_irq_request, SND_SOC_CS35L56_CORE);
-
 static int cs35l56_asp_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
 	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(codec_dai->component);
@@ -765,65 +662,6 @@ static struct snd_soc_dai_driver cs35l56_dai[] = {
 	}
 };
 
-static int cs35l56_wait_for_firmware_boot(struct cs35l56_base *cs35l56_base)
-{
-	unsigned int reg;
-	unsigned int val;
-	int ret;
-
-	if (cs35l56_base->rev < CS35L56_REVID_B0)
-		reg = CS35L56_DSP1_HALO_STATE_A1;
-	else
-		reg = CS35L56_DSP1_HALO_STATE;
-
-	ret = regmap_read_poll_timeout(cs35l56_base->regmap, reg,
-				       val,
-				       (val < 0xFFFF) && (val >= CS35L56_HALO_STATE_BOOT_DONE),
-				       CS35L56_HALO_STATE_POLL_US,
-				       CS35L56_HALO_STATE_TIMEOUT_US);
-
-	if ((ret < 0) && (ret != -ETIMEDOUT)) {
-		dev_err(cs35l56_base->dev, "Failed to read HALO_STATE: %d\n", ret);
-		return ret;
-	}
-
-	if ((ret == -ETIMEDOUT) || (val != CS35L56_HALO_STATE_BOOT_DONE)) {
-		dev_err(cs35l56_base->dev, "Firmware boot fail: HALO_STATE=%#x\n", val);
-		return -EIO;
-	}
-
-	return 0;
-}
-
-static inline void cs35l56_wait_min_reset_pulse(void)
-{
-	/* Satisfy minimum reset pulse width spec */
-	usleep_range(CS35L56_RESET_PULSE_MIN_US, 2 * CS35L56_RESET_PULSE_MIN_US);
-}
-
-static const struct reg_sequence cs35l56_system_reset_seq[] = {
-	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_SYSTEM_RESET),
-};
-
-static void cs35l56_system_reset(struct cs35l56_base *cs35l56_base, bool is_soundwire)
-{
-	/*
-	 * Must enter cache-only first so there can't be any more register
-	 * accesses other than the controlled system reset sequence below.
-	 */
-	regcache_cache_only(cs35l56_base->regmap, true);
-	regmap_multi_reg_write_bypassed(cs35l56_base->regmap,
-					cs35l56_system_reset_seq,
-					ARRAY_SIZE(cs35l56_system_reset_seq));
-
-	/* On SoundWire the registers won't be accessible until it re-enumerates. */
-	if (is_soundwire)
-		return;
-
-	usleep_range(CS35L56_CONTROL_PORT_READY_US, CS35L56_CONTROL_PORT_READY_US + 400);
-	regcache_cache_only(cs35l56_base->regmap, false);
-}
-
 static void cs35l56_secure_patch(struct cs35l56_private *cs35l56)
 {
 	int ret;
@@ -1140,47 +978,6 @@ int cs35l56_runtime_resume_common(struct cs35l56_private *cs35l56)
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_runtime_resume_common, SND_SOC_CS35L56_CORE);
 
-static int cs35l56_is_fw_reload_needed(struct cs35l56_base *cs35l56_base)
-{
-	unsigned int val;
-	int ret;
-
-	/* Nothing to re-patch if we haven't done any patching yet. */
-	if (!cs35l56_base->fw_patched)
-		return false;
-
-	/*
-	 * If we have control of RESET we will have asserted it so the firmware
-	 * will need re-patching.
-	 */
-	if (cs35l56_base->reset_gpio)
-		return true;
-
-	/*
-	 * In secure mode FIRMWARE_MISSING is cleared by the BIOS loader so
-	 * can't be used here to test for memory retention.
-	 * Assume that tuning must be re-loaded.
-	 */
-	if (cs35l56_base->secured)
-		return true;
-
-	ret = pm_runtime_resume_and_get(cs35l56_base->dev);
-	if (ret) {
-		dev_err(cs35l56_base->dev, "Failed to runtime_get: %d\n", ret);
-		return ret;
-	}
-
-	ret = regmap_read(cs35l56_base->regmap, CS35L56_PROTECTION_STATUS, &val);
-	if (ret)
-		dev_err(cs35l56_base->dev, "Failed to read PROTECTION_STATUS: %d\n", ret);
-	else
-		ret = !!(val & CS35L56_FIRMWARE_MISSING);
-
-	pm_runtime_put_autosuspend(cs35l56_base->dev);
-
-	return ret;
-}
-
 int cs35l56_system_suspend(struct device *dev)
 {
 	struct cs35l56_private *cs35l56 = dev_get_drvdata(dev);
-- 
2.30.2

