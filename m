Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DD5710F1F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241631AbjEYPHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241436AbjEYPHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:07:32 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C8419C
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:07:30 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PEE1Bu025343;
        Thu, 25 May 2023 10:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=vGZ4E6xL9bFiIIDV8n+cKVa4IEGlsQpOrZNWGpDW7jc=;
 b=DUpDh5I1DHSjbOwZwhosiJRytqz9IsS7lC4/4LlLl0CGAJdRsrYU7SKOEGWxEN7oTas0
 Pks1CcE1gy3lJh3Ca/xZ5OlT393FocxJEuqnykVlR4RpFvlbXgBudOkh9PIW1VPE1Wxd
 zJ62Hlq+cyFxCsW3k7INWHl9R5ZSHVvT/p7c43aq37I/8ExGJzcD1Ze941RiT2wj7acm
 DJXOZtEm52r/IcOuj3FxBJRFs3zuPcsbNRyhQvLnf3cJdmtN1fTZQGYcpxs/uaEcXpGV
 euRvwcu1CzqIg9yHfp0sHDycdZDJBjvvSI8s1CnSMKZG5yuibobDxSMNLk/vvRnA751r gA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qptmm70m4-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 10:07:07 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 25 May
 2023 10:07:04 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 25 May 2023 10:07:04 -0500
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.166])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E613415B4;
        Thu, 25 May 2023 15:07:03 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>, <broonie@kernel.org>, <perex@perex.cz>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 07/13] ASoC: cs35l56: Move part of cs35l56_init() to shared library
Date:   Thu, 25 May 2023 16:06:53 +0100
Message-ID: <20230525150659.25409-8-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230525150659.25409-1-rf@opensource.cirrus.com>
References: <20230525150659.25409-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Zy4Oz4us7IFd38yWlD-FoRnyecm1Ub_7
X-Proofpoint-GUID: Zy4Oz4us7IFd38yWlD-FoRnyecm1Ub_7
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

Part of the initialization code in cs35l56_init() can be re-used
by the HDA driver so move it into a new function in the shared
library.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs35l56.h           |  1 +
 sound/soc/codecs/cs35l56-shared.c | 79 +++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l56.c        | 71 +--------------------------
 3 files changed, 82 insertions(+), 69 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index e97c7ccfc051..489a61f84325 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -283,6 +283,7 @@ int cs35l56_is_fw_reload_needed(struct cs35l56_base *cs35l56_base);
 int cs35l56_runtime_suspend_common(struct cs35l56_base *cs35l56_base);
 int cs35l56_runtime_resume_common(struct cs35l56_base *cs35l56_base, bool is_soundwire);
 void cs35l56_init_cs_dsp(struct cs35l56_base *cs35l56_base, struct cs_dsp *cs_dsp);
+int cs35l56_hw_init(struct cs35l56_base *cs35l56_base);
 int cs35l56_get_bclk_freq_id(unsigned int freq);
 void cs35l56_fill_supply_names(struct regulator_bulk_data *data);
 
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 82e5edef1b3f..e3b935bd9037 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -549,6 +549,85 @@ void cs35l56_init_cs_dsp(struct cs35l56_base *cs35l56_base, struct cs_dsp *cs_ds
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_init_cs_dsp, SND_SOC_CS35L56_SHARED);
 
+int cs35l56_hw_init(struct cs35l56_base *cs35l56_base)
+{
+	int ret;
+	unsigned int devid, revid, otpid, secured;
+
+	/*
+	 * If the system is not using a reset_gpio then issue a
+	 * dummy read to force a wakeup.
+	 */
+	if (!cs35l56_base->reset_gpio)
+		regmap_read(cs35l56_base->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1, &devid);
+
+	/* Wait for control port to be ready (datasheet tIRS). */
+	usleep_range(CS35L56_CONTROL_PORT_READY_US,
+		     CS35L56_CONTROL_PORT_READY_US + 400);
+
+	/*
+	 * The HALO_STATE register is in different locations on Ax and B0
+	 * devices so the REVID needs to be determined before waiting for the
+	 * firmware to boot.
+	 */
+	ret = regmap_read(cs35l56_base->regmap, CS35L56_REVID, &revid);
+	if (ret < 0) {
+		dev_err(cs35l56_base->dev, "Get Revision ID failed\n");
+		return ret;
+	}
+	cs35l56_base->rev = revid & (CS35L56_AREVID_MASK | CS35L56_MTLREVID_MASK);
+
+	ret = cs35l56_wait_for_firmware_boot(cs35l56_base);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(cs35l56_base->regmap, CS35L56_DEVID, &devid);
+	if (ret < 0) {
+		dev_err(cs35l56_base->dev, "Get Device ID failed\n");
+		return ret;
+	}
+	devid &= CS35L56_DEVID_MASK;
+
+	switch (devid) {
+	case 0x35A56:
+		break;
+	default:
+		dev_err(cs35l56_base->dev, "Unknown device %x\n", devid);
+		return ret;
+	}
+
+	ret = regmap_read(cs35l56_base->regmap, CS35L56_DSP_RESTRICT_STS1, &secured);
+	if (ret) {
+		dev_err(cs35l56_base->dev, "Get Secure status failed\n");
+		return ret;
+	}
+
+	/* When any bus is restricted treat the device as secured */
+	if (secured & CS35L56_RESTRICTED_MASK)
+		cs35l56_base->secured = true;
+
+	ret = regmap_read(cs35l56_base->regmap, CS35L56_OTPID, &otpid);
+	if (ret < 0) {
+		dev_err(cs35l56_base->dev, "Get OTP ID failed\n");
+		return ret;
+	}
+
+	dev_info(cs35l56_base->dev, "Cirrus Logic CS35L56%s Rev %02X OTP%d\n",
+		 cs35l56_base->secured ? "s" : "", cs35l56_base->rev, otpid);
+
+	/* Wake source and *_BLOCKED interrupts default to unmasked, so mask them */
+	regmap_write(cs35l56_base->regmap, CS35L56_IRQ1_MASK_20, 0xffffffff);
+	regmap_update_bits(cs35l56_base->regmap, CS35L56_IRQ1_MASK_1,
+			   CS35L56_AMP_SHORT_ERR_EINT1_MASK,
+			   0);
+	regmap_update_bits(cs35l56_base->regmap, CS35L56_IRQ1_MASK_8,
+			   CS35L56_TEMP_ERR_EINT1_MASK,
+			   0);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_hw_init, SND_SOC_CS35L56_SHARED);
+
 static const u32 cs35l56_bclk_valid_for_pll_freq_table[] = {
 	[0x0C] = 128000,
 	[0x0F] = 256000,
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 8b9b5822d515..f472bde6d21a 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -1130,7 +1130,6 @@ EXPORT_SYMBOL_NS_GPL(cs35l56_common_probe, SND_SOC_CS35L56_CORE);
 int cs35l56_init(struct cs35l56_private *cs35l56)
 {
 	int ret;
-	unsigned int devid, revid, otpid, secured;
 
 	/*
 	 * Check whether the actions associated with soft reset or one time
@@ -1147,66 +1146,9 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 	pm_runtime_set_active(cs35l56->base.dev);
 	pm_runtime_enable(cs35l56->base.dev);
 
-	/*
-	 * If the system is not using a reset_gpio then issue a
-	 * dummy read to force a wakeup.
-	 */
-	if (!cs35l56->base.reset_gpio)
-		regmap_read(cs35l56->base.regmap, CS35L56_DSP_VIRTUAL1_MBOX_1, &devid);
-
-	/* Wait for control port to be ready (datasheet tIRS). */
-	usleep_range(CS35L56_CONTROL_PORT_READY_US,
-		     CS35L56_CONTROL_PORT_READY_US + 400);
-
-	/*
-	 * The HALO_STATE register is in different locations on Ax and B0
-	 * devices so the REVID needs to be determined before waiting for the
-	 * firmware to boot.
-	 */
-	ret = regmap_read(cs35l56->base.regmap, CS35L56_REVID, &revid);
-	if (ret < 0) {
-		dev_err(cs35l56->base.dev, "Get Revision ID failed\n");
+	ret = cs35l56_hw_init(&cs35l56->base);
+	if (ret < 0)
 		return ret;
-	}
-	cs35l56->base.rev = revid & (CS35L56_AREVID_MASK | CS35L56_MTLREVID_MASK);
-
-	ret = cs35l56_wait_for_firmware_boot(&cs35l56->base);
-	if (ret)
-		return ret;
-
-	ret = regmap_read(cs35l56->base.regmap, CS35L56_DEVID, &devid);
-	if (ret < 0) {
-		dev_err(cs35l56->base.dev, "Get Device ID failed\n");
-		return ret;
-	}
-	devid &= CS35L56_DEVID_MASK;
-
-	switch (devid) {
-	case 0x35A56:
-		break;
-	default:
-		dev_err(cs35l56->base.dev, "Unknown device %x\n", devid);
-		return ret;
-	}
-
-	ret = regmap_read(cs35l56->base.regmap, CS35L56_DSP_RESTRICT_STS1, &secured);
-	if (ret) {
-		dev_err(cs35l56->base.dev, "Get Secure status failed\n");
-		return ret;
-	}
-
-	/* When any bus is restricted treat the device as secured */
-	if (secured & CS35L56_RESTRICTED_MASK)
-		cs35l56->base.secured = true;
-
-	ret = regmap_read(cs35l56->base.regmap, CS35L56_OTPID, &otpid);
-	if (ret < 0) {
-		dev_err(cs35l56->base.dev, "Get OTP ID failed\n");
-		return ret;
-	}
-
-	dev_info(cs35l56->base.dev, "Cirrus Logic CS35L56%s Rev %02X OTP%d\n",
-		 cs35l56->base.secured ? "s" : "", cs35l56->base.rev, otpid);
 
 	/* Populate the DSP information with the revision and security state */
 	cs35l56->dsp.part = devm_kasprintf(cs35l56->base.dev, GFP_KERNEL, "cs35l56%s-%02x",
@@ -1214,15 +1156,6 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 	if (!cs35l56->dsp.part)
 		return -ENOMEM;
 
-	/* Wake source and *_BLOCKED interrupts default to unmasked, so mask them */
-	regmap_write(cs35l56->base.regmap, CS35L56_IRQ1_MASK_20, 0xffffffff);
-	regmap_update_bits(cs35l56->base.regmap, CS35L56_IRQ1_MASK_1,
-			   CS35L56_AMP_SHORT_ERR_EINT1_MASK,
-			   0);
-	regmap_update_bits(cs35l56->base.regmap, CS35L56_IRQ1_MASK_8,
-			   CS35L56_TEMP_ERR_EINT1_MASK,
-			   0);
-
 	if (!cs35l56->base.reset_gpio) {
 		dev_dbg(cs35l56->base.dev, "No reset gpio: using soft reset\n");
 		cs35l56->soft_resetting = true;
-- 
2.30.2

