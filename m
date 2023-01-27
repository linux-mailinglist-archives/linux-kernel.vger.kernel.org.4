Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C09F67EB8F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbjA0Qvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjA0Qvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:51:40 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086887DBD6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:51:38 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30R9k8LP030633;
        Fri, 27 Jan 2023 10:51:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=gzww93MA3M79V6JYJ0KSkJ/wBLiBFaVv6r0gK+hWsXw=;
 b=EIRhEgaJzWmHA5zR66SR2EivoiTvbu5HCfUR7KZUZF7clFQBcv7jJGGSS9Fk/GfqAtD/
 OcZmegfmh5bC8RKPueKjJFAURrEd7+3nj0r5p1DiegppKnqj50MPdktLOZMYxV0qgQ6+
 +sATVnPN+4tEk6g0GyRsxaIWh7uDQMS9v0d03JyDslDHpf38awUHnISDLYeTTrDF9Zsh
 z50lTH2EjbaWaA/KOGgRWdHZH/7Kn9+eU1YFxiHrtPXQTlZYivXW3RvarMRDLmRB/+UJ
 cI8KYh2oyLU5fEMbetsvI/3aVclUvjKrU1ZxQItoj1c9hZCcyxeHFyScIIFYH2UTWNdQ Tw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3n8dbsvrd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 10:51:30 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Fri, 27 Jan
 2023 10:51:29 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Fri, 27 Jan 2023 10:51:29 -0600
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 05A7311D6;
        Fri, 27 Jan 2023 16:51:29 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 5/8] ASoC: cs42l42: Export some functions for SoundWire
Date:   Fri, 27 Jan 2023 16:51:08 +0000
Message-ID: <20230127165111.3010960-6-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
References: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MWrLG6xNTkMsmJ1yAyy9tnEMFXowVR19
X-Proofpoint-GUID: MWrLG6xNTkMsmJ1yAyy9tnEMFXowVR19
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

Export functions that will be needed by a SoundWire module.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 14 +++++++++-----
 sound/soc/codecs/cs42l42.h |  5 +++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index d81c6eb1c1e59..cefefd7061689 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -653,8 +653,8 @@ static const struct cs42l42_pll_params pll_ratio_table[] = {
 	{ 24576000, 1, 0x03, 0x40, 0x000000, 0x03, 0x10, 12288000, 128, 1}
 };
 
-static int cs42l42_pll_config(struct snd_soc_component *component, unsigned int clk,
-			      unsigned int sample_rate)
+int cs42l42_pll_config(struct snd_soc_component *component, unsigned int clk,
+		       unsigned int sample_rate)
 {
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
 	int i;
@@ -740,8 +740,9 @@ static int cs42l42_pll_config(struct snd_soc_component *component, unsigned int
 
 	return -EINVAL;
 }
+EXPORT_SYMBOL_NS_GPL(cs42l42_pll_config, SND_SOC_CS42L42_CORE);
 
-static void cs42l42_src_config(struct snd_soc_component *component, unsigned int sample_rate)
+void cs42l42_src_config(struct snd_soc_component *component, unsigned int sample_rate)
 {
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
 	unsigned int fs;
@@ -773,6 +774,7 @@ static void cs42l42_src_config(struct snd_soc_component *component, unsigned int
 				      CS42L42_CLK_OASRC_SEL_MASK,
 				      fs << CS42L42_CLK_OASRC_SEL_SHIFT);
 }
+EXPORT_SYMBOL_NS_GPL(cs42l42_src_config, SND_SOC_CS42L42_CORE);
 
 static int cs42l42_asp_config(struct snd_soc_component *component,
 			      unsigned int sclk, unsigned int sample_rate)
@@ -1013,7 +1015,7 @@ static int cs42l42_set_bclk_ratio(struct snd_soc_dai *dai,
 	return 0;
 }
 
-static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
+int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 {
 	struct snd_soc_component *component = dai->component;
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
@@ -1106,6 +1108,7 @@ static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cs42l42_mute_stream, SND_SOC_CS42L42_CORE);
 
 #define CS42L42_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
 			 SNDRV_PCM_FMTBIT_S24_LE |\
@@ -1648,7 +1651,7 @@ static const struct cs42l42_irq_params irq_params_table[] = {
 		CS42L42_TSRS_PLUG_VAL_MASK}
 };
 
-static irqreturn_t cs42l42_irq_thread(int irq, void *data)
+irqreturn_t cs42l42_irq_thread(int irq, void *data)
 {
 	struct cs42l42_private *cs42l42 = (struct cs42l42_private *)data;
 	unsigned int stickies[12];
@@ -1765,6 +1768,7 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL_NS_GPL(cs42l42_irq_thread, SND_SOC_CS42L42_CORE);
 
 static void cs42l42_set_interrupt_masks(struct cs42l42_private *cs42l42)
 {
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 17aab06adc8e6..ef8219f489100 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -61,6 +61,11 @@ extern struct snd_soc_dai_driver cs42l42_dai;
 bool cs42l42_readable_register(struct device *dev, unsigned int reg);
 bool cs42l42_volatile_register(struct device *dev, unsigned int reg);
 
+int cs42l42_pll_config(struct snd_soc_component *component,
+		       unsigned int clk, unsigned int sample_rate);
+void cs42l42_src_config(struct snd_soc_component *component, unsigned int sample_rate);
+int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream);
+irqreturn_t cs42l42_irq_thread(int irq, void *data);
 int cs42l42_suspend(struct device *dev);
 int cs42l42_resume(struct device *dev);
 void cs42l42_resume_restore(struct device *dev);
-- 
2.34.1

