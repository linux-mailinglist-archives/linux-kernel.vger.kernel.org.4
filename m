Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAD2710F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241548AbjEYPH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjEYPHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:07:32 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEC4A3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:07:30 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PEE1BI025344;
        Thu, 25 May 2023 10:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=eBwdAq8lZQg1yEfXJUU7I54E6UwOgSKapYiE7PVYkIs=;
 b=rGX52YrrVAcMvKP0DUf5L0y8hD/XXzK7+0glyElsb4hQsXBNwhzxbu6jfD+RGfypXqxz
 M3O5HhxzeEY45nX/PJjR//C74fryYubFCAe2IpnesM7tg/Zl9CuU/MvT3FBeZGBeAM6M
 Ukkeh8OjAQ4TuzTSZWagaeTc/tR5UtDjmbCUHS2vZj5qRewOV6meTSqhmXVOTPzuFhDW
 5WXHWBiV15jpXMki0G6D+EshcUkNlBy8zRfFIK9QZJxHhQVMJ8TMPahonER/ATrgfcRt
 UQn7utA5vGsdStf+cm7kOADerUZDvYRYR7PZ1tXCWj963mJMLNGsKtpR3JsayXzsqZjV cQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qptmm70m7-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 10:07:07 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 25 May
 2023 10:07:03 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 10:07:03 -0500
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.166])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 885E611D4;
        Thu, 25 May 2023 15:07:03 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>, <broonie@kernel.org>, <perex@perex.cz>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 06/13] ASoC: cs35l56: Move cs_dsp init into shared library
Date:   Thu, 25 May 2023 16:06:52 +0100
Message-ID: <20230525150659.25409-7-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230525150659.25409-1-rf@opensource.cirrus.com>
References: <20230525150659.25409-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: HA3lLzwnNYLffZRtTB-CgFFdcuXe8dQo
X-Proofpoint-GUID: HA3lLzwnNYLffZRtTB-CgFFdcuXe8dQo
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

Move the code that initialized the struct cs_dsp members
into the shared library so that the HDA driver can use it.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs35l56.h           |  2 +-
 sound/soc/codecs/cs35l56-shared.c | 18 ++++++++++++++++--
 sound/soc/codecs/cs35l56.c        | 11 +----------
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 4a885c2321c1..e97c7ccfc051 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -269,7 +269,6 @@ extern struct regmap_config cs35l56_regmap_i2c;
 extern struct regmap_config cs35l56_regmap_spi;
 extern struct regmap_config cs35l56_regmap_sdw;
 
-extern const struct cs_dsp_region cs35l56_dsp1_regions[CS35L56_NUM_DSP_REGIONS];
 extern const char * const cs35l56_tx_input_texts[CS35L56_NUM_INPUT_SRC];
 extern const unsigned int cs35l56_tx_input_values[CS35L56_NUM_INPUT_SRC];
 
@@ -283,6 +282,7 @@ irqreturn_t cs35l56_irq(int irq, void *data);
 int cs35l56_is_fw_reload_needed(struct cs35l56_base *cs35l56_base);
 int cs35l56_runtime_suspend_common(struct cs35l56_base *cs35l56_base);
 int cs35l56_runtime_resume_common(struct cs35l56_base *cs35l56_base, bool is_soundwire);
+void cs35l56_init_cs_dsp(struct cs35l56_base *cs35l56_base, struct cs_dsp *cs_dsp);
 int cs35l56_get_bclk_freq_id(unsigned int freq);
 void cs35l56_fill_supply_names(struct regulator_bulk_data *data);
 
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 194fa08e1cc2..82e5edef1b3f 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -526,14 +526,28 @@ int cs35l56_runtime_resume_common(struct cs35l56_base *cs35l56_base, bool is_sou
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_runtime_resume_common, SND_SOC_CS35L56_SHARED);
 
-const struct cs_dsp_region cs35l56_dsp1_regions[] = {
+static const struct cs_dsp_region cs35l56_dsp1_regions[] = {
 	{ .type = WMFW_HALO_PM_PACKED,	.base = CS35L56_DSP1_PMEM_0 },
 	{ .type = WMFW_HALO_XM_PACKED,	.base = CS35L56_DSP1_XMEM_PACKED_0 },
 	{ .type = WMFW_HALO_YM_PACKED,	.base = CS35L56_DSP1_YMEM_PACKED_0 },
 	{ .type = WMFW_ADSP2_XM,	.base = CS35L56_DSP1_XMEM_UNPACKED24_0 },
 	{ .type = WMFW_ADSP2_YM,	.base = CS35L56_DSP1_YMEM_UNPACKED24_0 },
 };
-EXPORT_SYMBOL_NS_GPL(cs35l56_dsp1_regions, SND_SOC_CS35L56_SHARED);
+
+void cs35l56_init_cs_dsp(struct cs35l56_base *cs35l56_base, struct cs_dsp *cs_dsp)
+{
+	cs_dsp->num = 1;
+	cs_dsp->type = WMFW_HALO;
+	cs_dsp->rev = 0;
+	cs_dsp->dev = cs35l56_base->dev;
+	cs_dsp->regmap = cs35l56_base->regmap;
+	cs_dsp->base = CS35L56_DSP1_CORE_BASE;
+	cs_dsp->base_sysinfo = CS35L56_DSP1_SYS_INFO_ID;
+	cs_dsp->mem = cs35l56_dsp1_regions;
+	cs_dsp->num_mems = ARRAY_SIZE(cs35l56_dsp1_regions);
+	cs_dsp->no_core_startstop = true;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_init_cs_dsp, SND_SOC_CS35L56_SHARED);
 
 static const u32 cs35l56_bclk_valid_for_pll_freq_table[] = {
 	[0x0C] = 128000,
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index ce8142249f05..8b9b5822d515 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -1019,18 +1019,9 @@ static int cs35l56_dsp_init(struct cs35l56_private *cs35l56)
 	INIT_WORK(&cs35l56->dsp_work, cs35l56_dsp_work);
 
 	dsp = &cs35l56->dsp;
+	cs35l56_init_cs_dsp(&cs35l56->base, &dsp->cs_dsp);
 	dsp->part = "cs35l56";
-	dsp->cs_dsp.num = 1;
-	dsp->cs_dsp.type = WMFW_HALO;
-	dsp->cs_dsp.rev = 0;
 	dsp->fw = 12;
-	dsp->cs_dsp.dev = cs35l56->base.dev;
-	dsp->cs_dsp.regmap = cs35l56->base.regmap;
-	dsp->cs_dsp.base = CS35L56_DSP1_CORE_BASE;
-	dsp->cs_dsp.base_sysinfo = CS35L56_DSP1_SYS_INFO_ID;
-	dsp->cs_dsp.mem = cs35l56_dsp1_regions;
-	dsp->cs_dsp.num_mems = ARRAY_SIZE(cs35l56_dsp1_regions);
-	dsp->cs_dsp.no_core_startstop = true;
 	dsp->wmfw_optional = true;
 
 	dev_dbg(cs35l56->base.dev, "DSP system name: '%s'\n", dsp->system_name);
-- 
2.30.2

