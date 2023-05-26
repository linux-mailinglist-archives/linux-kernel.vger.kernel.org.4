Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BF7712697
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjEZM3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243354AbjEZM3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:29:18 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D7E19D
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:29:14 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QC2vwV003125;
        Fri, 26 May 2023 07:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=CXq9mbKlLBRisrpUyaThKs1+eOHnWJtaVQ0ZDo/2FOQ=;
 b=RgwaUL//bwxgf1BlB3Q/W8Mb23+/323+Xyxj3hbZT0bUBVx4946B2JLA4Wcu/KZMJCao
 1bWrbC0QDWslpoasSBeVFPxMKMmAzk6yqsDOsNIEg2+Lmr3jzYrJd7wOFopcHH160Osg
 unYj81tGDXerLG1hpG17H7vg+h7Zr0sVc582o10NTmEFgONPZ+kxM1elKl7M4Ikmtv+Q
 JFBe7Lbm2qEdgolQOg3P5DmhTbPx5wFyhawCrWLocTVSTHDsD+a1gokoOm+L7L9WY1+W
 HFAwYESVVqNoy1vvrbEnJPoOQlh3MREYAARWhGGQVDnhADoMryN6A/BWeU6j60c4sHPk 3A== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3qsde8k66w-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 07:28:59 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 26 May
 2023 07:28:56 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 26 May 2023 07:28:56 -0500
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.166])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BE3D711A8;
        Fri, 26 May 2023 12:28:56 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>, <broonie@kernel.org>, <perex@perex.cz>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3 06/12] ASoC: cs35l56: Move cs_dsp init into shared library
Date:   Fri, 26 May 2023 13:28:46 +0100
Message-ID: <20230526122852.4552-7-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230526122852.4552-1-rf@opensource.cirrus.com>
References: <20230526122852.4552-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -5uoPgngUNFtAR9g4A-opnvCgiOIovCL
X-Proofpoint-GUID: -5uoPgngUNFtAR9g4A-opnvCgiOIovCL
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
Acked-by: Mark Brown <broonie@kernel.org>
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

