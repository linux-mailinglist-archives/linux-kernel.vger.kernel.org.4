Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1190A68D496
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjBGKlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjBGKlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:41:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DB339BB4;
        Tue,  7 Feb 2023 02:40:47 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6E63B6602077;
        Tue,  7 Feb 2023 10:40:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675766425;
        bh=w2ObzR7IDT4IC0wSd5Z9/lp1tPbQEq0Q2kLRDYzUIn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XbS1lEA+Xr+696Yao0xJ2x9whfo+HnZpvR8C6qh5wYR3ondMdr8sxC2iTFmhL6TnP
         Cqs1IoPGcH+fXicaAsPadWOxAgMmh9gJHWZeYp/RjE5plsV//29A3ttPXuz5tltYKF
         UOQuvmJyV8elsLxrowGcloxNr9rcbU7uzNJWjr542gQSEns+Bn/8hU5fBHgI6QAnqm
         LCOZmxhTSUw5zoXjZzd9mscLWJvE5gZIbV7L3/Zc2HCHjsI04A6DLz63p2y6X3bEIz
         Ef9Ay59IAaeYwbnsRMy33UpNCxWrDMSPkoaq7eDsnp05s902RS4k4NY/yK7hi84BIQ
         Es0DKpNDxhAqw==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Lucas Tanure <lucas.tanure@collabora.com>
Subject: [PATCH 1/2] ALSA: cs35l41: Add shared boost feature
Date:   Tue,  7 Feb 2023 10:40:20 +0000
Message-Id: <20230207104021.2842-2-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207104021.2842-1-lucas.tanure@collabora.com>
References: <20230207104021.2842-1-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shared boost allows two amplifiers to share a single boost
circuit by communicating on the MDSYNC bus.
The passive amplifier does not control the boost and receives
data from the active amplifier.

Shared Boost is not supported in HDA Systems.

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 include/sound/cs35l41.h        | 10 +++++-
 sound/pci/hda/cs35l41_hda.c    |  6 ++--
 sound/soc/codecs/cs35l41-lib.c | 56 +++++++++++++++++++++++++++++++++-
 sound/soc/codecs/cs35l41.c     | 21 +++++++++++--
 sound/soc/codecs/cs35l41.h     |  1 +
 5 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index 9ac5918269a5..a034ebe03a0e 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -11,6 +11,7 @@
 #define __CS35L41_H
 
 #include <linux/regmap.h>
+#include <linux/completion.h>
 #include <linux/firmware/cirrus/cs_dsp.h>
 
 #define CS35L41_FIRSTREG		0x00000000
@@ -677,6 +678,7 @@
 
 #define CS35L36_PUP_DONE_IRQ_UNMASK	0x5F
 #define CS35L36_PUP_DONE_IRQ_MASK	0xBF
+#define CS35L41_SYNC_EN_MASK		BIT(8)
 
 #define CS35L41_AMP_SHORT_ERR		0x80000000
 #define CS35L41_BST_SHORT_ERR		0x0100
@@ -686,6 +688,7 @@
 #define CS35L41_BST_DCM_UVP_ERR		0x80
 #define CS35L41_OTP_BOOT_DONE		0x02
 #define CS35L41_PLL_UNLOCK		0x10
+#define CS35L41_PLL_LOCK		BIT(1)
 #define CS35L41_OTP_BOOT_ERR		0x80000000
 
 #define CS35L41_AMP_SHORT_ERR_RLS	0x02
@@ -705,6 +708,8 @@
 #define CS35L41_INT1_MASK_DEFAULT	0x7FFCFE3F
 #define CS35L41_INT1_UNMASK_PUP		0xFEFFFFFF
 #define CS35L41_INT1_UNMASK_PDN		0xFF7FFFFF
+#define CS35L41_INT3_PLL_LOCK_SHIFT	1
+#define CS35L41_INT3_PLL_LOCK_MASK	BIT(CS35L41_INT3_PLL_LOCK_SHIFT)
 
 #define CS35L41_GPIO_DIR_MASK		0x80000000
 #define CS35L41_GPIO_DIR_SHIFT		31
@@ -743,6 +748,8 @@ enum cs35l41_boost_type {
 	CS35L41_INT_BOOST,
 	CS35L41_EXT_BOOST,
 	CS35L41_EXT_BOOST_NO_VSPK_SWITCH,
+	CS35L41_SHD_BOOST_ACTV,
+	CS35L41_SHD_BOOST_PASS,
 };
 
 enum cs35l41_clk_ids {
@@ -891,6 +898,7 @@ int cs35l41_exit_hibernate(struct device *dev, struct regmap *regmap);
 int cs35l41_init_boost(struct device *dev, struct regmap *regmap,
 		       struct cs35l41_hw_cfg *hw_cfg);
 bool cs35l41_safe_reset(struct regmap *regmap, enum cs35l41_boost_type b_type);
-int cs35l41_global_enable(struct regmap *regmap, enum cs35l41_boost_type b_type, int enable);
+int cs35l41_global_enable(struct regmap *regmap, enum cs35l41_boost_type b_type, int enable,
+			  struct completion *pll_lock);
 
 #endif /* __CS35L41_H */
diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index f7815ee24f83..38c0079ef303 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -515,13 +515,13 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 		break;
 	case HDA_GEN_PCM_ACT_PREPARE:
 		mutex_lock(&cs35l41->fw_mutex);
-		ret = cs35l41_global_enable(reg, cs35l41->hw_cfg.bst_type, 1);
+		ret = cs35l41_global_enable(reg, cs35l41->hw_cfg.bst_type, 1, NULL);
 		mutex_unlock(&cs35l41->fw_mutex);
 		break;
 	case HDA_GEN_PCM_ACT_CLEANUP:
 		mutex_lock(&cs35l41->fw_mutex);
 		regmap_multi_reg_write(reg, cs35l41_hda_mute, ARRAY_SIZE(cs35l41_hda_mute));
-		ret = cs35l41_global_enable(reg, cs35l41->hw_cfg.bst_type, 0);
+		ret = cs35l41_global_enable(reg, cs35l41->hw_cfg.bst_type, 0, NULL);
 		mutex_unlock(&cs35l41->fw_mutex);
 		break;
 	case HDA_GEN_PCM_ACT_CLOSE:
@@ -673,7 +673,7 @@ static int cs35l41_runtime_suspend(struct device *dev)
 	if (cs35l41->playback_started) {
 		regmap_multi_reg_write(cs35l41->regmap, cs35l41_hda_mute,
 				       ARRAY_SIZE(cs35l41_hda_mute));
-		cs35l41_global_enable(cs35l41->regmap, cs35l41->hw_cfg.bst_type, 0);
+		cs35l41_global_enable(cs35l41->regmap, cs35l41->hw_cfg.bst_type, 0, NULL);
 		regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2,
 				   CS35L41_AMP_EN_MASK, 0 << CS35L41_AMP_EN_SHIFT);
 		if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST)
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index 04be71435491..aedd81a766a7 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -1114,12 +1114,31 @@ static const struct reg_sequence cs35l41_reset_to_safe[] = {
 	{ 0x00000040,			0x00000033 },
 };
 
+static const struct reg_sequence cs35l41_actv_seq[] = {
+	/* SYNC_BST_CTL_RX_EN = 0; SYNC_BST_CTL_TX_EN = 1 */
+	{CS35L41_MDSYNC_EN,        0x00001000},
+	/* BST_CTL_SEL = CLASSH */
+	{CS35L41_BSTCVRT_VCTRL2,    0x00000001},
+};
+
+static const struct reg_sequence cs35l41_pass_seq[] = {
+	/* SYNC_BST_CTL_RX_EN = 1; SYNC_BST_CTL_TX_EN = 0 */
+	{CS35L41_MDSYNC_EN,        0x00002000},
+	/* BST_EN = 0 */
+	{CS35L41_PWR_CTRL2,        0x00003300},
+	/* BST_CTL_SEL = MDSYNC */
+	{CS35L41_BSTCVRT_VCTRL2,    0x00000002},
+};
+
 int cs35l41_init_boost(struct device *dev, struct regmap *regmap,
 		       struct cs35l41_hw_cfg *hw_cfg)
 {
 	int ret;
 
 	switch (hw_cfg->bst_type) {
+	case CS35L41_SHD_BOOST_ACTV:
+		regmap_multi_reg_write(regmap, cs35l41_actv_seq, ARRAY_SIZE(cs35l41_actv_seq));
+		fallthrough;
 	case CS35L41_INT_BOOST:
 		ret = cs35l41_boost_config(dev, regmap, hw_cfg->bst_ind,
 					   hw_cfg->bst_cap, hw_cfg->bst_ipk);
@@ -1138,6 +1157,9 @@ int cs35l41_init_boost(struct device *dev, struct regmap *regmap,
 		ret = regmap_update_bits(regmap, CS35L41_PWR_CTRL2, CS35L41_BST_EN_MASK,
 					 CS35L41_BST_DIS_FET_OFF << CS35L41_BST_EN_SHIFT);
 		break;
+	case CS35L41_SHD_BOOST_PASS:
+		regmap_multi_reg_write(regmap, cs35l41_pass_seq, ARRAY_SIZE(cs35l41_pass_seq));
+		break;
 	default:
 		dev_err(dev, "Boost type %d not supported\n", hw_cfg->bst_type);
 		ret = -EINVAL;
@@ -1165,11 +1187,43 @@ bool cs35l41_safe_reset(struct regmap *regmap, enum cs35l41_boost_type b_type)
 }
 EXPORT_SYMBOL_GPL(cs35l41_safe_reset);
 
-int cs35l41_global_enable(struct regmap *regmap, enum cs35l41_boost_type b_type, int enable)
+static const struct reg_sequence cs35l41_shd_boost_seq[] = {
+	{CS35L41_PWR_CTRL3,	0x01000110},
+	{CS35L41_PWR_CTRL1,	0x00000000, 3000 },
+	{CS35L41_PWR_CTRL1,	0x00000001, 3000 },
+};
+
+int cs35l41_global_enable(struct regmap *regmap, enum cs35l41_boost_type b_type, int enable,
+			  struct completion *pll_lock)
 {
 	int ret;
+	unsigned int gpio1;
 
 	switch (b_type) {
+	case CS35L41_SHD_BOOST_ACTV:
+	case CS35L41_SHD_BOOST_PASS:
+		regmap_update_bits(regmap, CS35L41_PWR_CTRL3, CS35L41_SYNC_EN_MASK, 0);
+
+		gpio1 = enable ? CS35L41_GPIO1_MDSYNC : CS35L41_GPIO1_HIZ;
+		regmap_update_bits(regmap, CS35L41_GPIO_PAD_CONTROL, CS35L41_GPIO1_CTRL_MASK,
+				   gpio1 << CS35L41_GPIO1_CTRL_SHIFT);
+
+		ret = regmap_update_bits(regmap, CS35L41_PWR_CTRL1, CS35L41_GLOBAL_EN_MASK,
+					 enable << CS35L41_GLOBAL_EN_SHIFT);
+		usleep_range(3000, 3100);
+		if (!enable)
+			break;
+
+		if (!pll_lock)
+			return -EINVAL;
+
+		ret = wait_for_completion_timeout(pll_lock, msecs_to_jiffies(1000));
+		if (ret == 0)
+			ret = -ETIMEDOUT;
+		else
+			regmap_multi_reg_write(regmap, cs35l41_shd_boost_seq,
+					       ARRAY_SIZE(cs35l41_shd_boost_seq));
+		break;
 	case CS35L41_INT_BOOST:
 		ret = regmap_update_bits(regmap, CS35L41_PWR_CTRL1, CS35L41_GLOBAL_EN_MASK,
 					 enable << CS35L41_GLOBAL_EN_SHIFT);
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index c223d83e02cf..40c0620d8a7a 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -483,6 +483,11 @@ static irqreturn_t cs35l41_irq(int irq, void *data)
 		ret = IRQ_HANDLED;
 	}
 
+	if (status[2] & CS35L41_PLL_LOCK) {
+		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS3, CS35L41_PLL_LOCK);
+		complete(&cs35l41->pll_lock);
+	}
+
 done:
 	pm_runtime_mark_last_busy(cs35l41->dev);
 	pm_runtime_put_autosuspend(cs35l41->dev);
@@ -520,10 +525,12 @@ static int cs35l41_main_amp_event(struct snd_soc_dapm_widget *w,
 						cs35l41_pup_patch,
 						ARRAY_SIZE(cs35l41_pup_patch));
 
-		cs35l41_global_enable(cs35l41->regmap, cs35l41->hw_cfg.bst_type, 1);
+		cs35l41_global_enable(cs35l41->regmap, cs35l41->hw_cfg.bst_type, 1,
+				      &cs35l41->pll_lock);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		cs35l41_global_enable(cs35l41->regmap, cs35l41->hw_cfg.bst_type, 0);
+		cs35l41_global_enable(cs35l41->regmap, cs35l41->hw_cfg.bst_type, 0,
+				      &cs35l41->pll_lock);
 
 		ret = regmap_read_poll_timeout(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
 					       val, val &  CS35L41_PDN_DONE_MASK,
@@ -1280,6 +1287,10 @@ int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *
 	/* Set interrupt masks for critical errors */
 	regmap_write(cs35l41->regmap, CS35L41_IRQ1_MASK1,
 		     CS35L41_INT1_MASK_DEFAULT);
+	if (cs35l41->hw_cfg.bst_type == CS35L41_SHD_BOOST_PASS ||
+	    cs35l41->hw_cfg.bst_type == CS35L41_SHD_BOOST_ACTV)
+		regmap_update_bits(cs35l41->regmap, CS35L41_IRQ1_MASK3, CS35L41_INT3_PLL_LOCK_MASK,
+				   0 << CS35L41_INT3_PLL_LOCK_SHIFT);
 
 	ret = devm_request_threaded_irq(cs35l41->dev, cs35l41->irq, NULL, cs35l41_irq,
 					IRQF_ONESHOT | IRQF_SHARED | irq_pol,
@@ -1303,6 +1314,8 @@ int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *
 	if (ret < 0)
 		goto err;
 
+	init_completion(&cs35l41->pll_lock);
+
 	pm_runtime_set_autosuspend_delay(cs35l41->dev, 3000);
 	pm_runtime_use_autosuspend(cs35l41->dev);
 	pm_runtime_mark_last_busy(cs35l41->dev);
@@ -1345,6 +1358,10 @@ void cs35l41_remove(struct cs35l41_private *cs35l41)
 	pm_runtime_disable(cs35l41->dev);
 
 	regmap_write(cs35l41->regmap, CS35L41_IRQ1_MASK1, 0xFFFFFFFF);
+	if (cs35l41->hw_cfg.bst_type == CS35L41_SHD_BOOST_PASS ||
+	    cs35l41->hw_cfg.bst_type == CS35L41_SHD_BOOST_ACTV)
+		regmap_update_bits(cs35l41->regmap, CS35L41_IRQ1_MASK3, CS35L41_INT3_PLL_LOCK_MASK,
+				   1 << CS35L41_INT3_PLL_LOCK_SHIFT);
 	kfree(cs35l41->dsp.system_name);
 	wm_adsp2_remove(&cs35l41->dsp);
 	cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type);
diff --git a/sound/soc/codecs/cs35l41.h b/sound/soc/codecs/cs35l41.h
index c85cbc1dd333..34d967d4372b 100644
--- a/sound/soc/codecs/cs35l41.h
+++ b/sound/soc/codecs/cs35l41.h
@@ -33,6 +33,7 @@ struct cs35l41_private {
 	int irq;
 	/* GPIO for /RST */
 	struct gpio_desc *reset_gpio;
+	struct completion pll_lock;
 };
 
 int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *hw_cfg);
-- 
2.39.1

