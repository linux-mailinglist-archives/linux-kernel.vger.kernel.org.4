Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D2367EB93
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjA0Qvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjA0Qvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:51:41 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07077DBF6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:51:39 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30R9k8LT030633;
        Fri, 27 Jan 2023 10:51:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=TTC47bgNB45idzSbfNOI1xh6OyXSxo6PonYazO3r2IQ=;
 b=W+U8v1iAzlM2Qo3qLFTrqO78YQEbqmtzJjVSU3y26v08lbhWVjctvJvyC2aGbhRISA//
 qLSCeIdyn192e3vX5vNQeSSV9TxsXl4Ppc18JvUrbh0szkYmPdM9anYv/OcuITEy3MgF
 U4XfVhLlQAW1RdM8MA5i2Jmt5TxCafEz2AU/isebaCbZApVKDew6J/2A0hyDxvuU9PPC
 i/kicHTuoIUomp2ctYCkmNV/9SUaSxBiXdyv0NLoszSQT4SlzjK+kL14h2w3CFZRvtI4
 MLdN+RNgBEXDvkNjiJVOwFkdS9KuqQfbUZPWb3/KAaZtN9TNP0CcylYnuN9SmTAH6D1S mQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3n8dbsvrd1-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 10:51:32 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Fri, 27 Jan
 2023 10:51:28 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.7 via Frontend Transport; Fri, 27 Jan 2023 10:51:28 -0600
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D2DD7475;
        Fri, 27 Jan 2023 16:51:28 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 4/8] ASoC: cs42l42: Separate ASP config from PLL config
Date:   Fri, 27 Jan 2023 16:51:07 +0000
Message-ID: <20230127165111.3010960-5-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
References: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TeXrXISvG1BSgFQ0Xsy-DAS6qgxsMEjZ
X-Proofpoint-GUID: TeXrXISvG1BSgFQ0Xsy-DAS6qgxsMEjZ
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

Setup of the ASP (audio serial port) was being done as a side-effect of
cs42l42_pll_config() and forces a restriction on the ratio of sample_rate
to bit_clock that is invalid for Soundwire.

Move the ASP setup into a dedicated function.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 81 +++++++++++++++++++++-----------------
 sound/soc/codecs/cs42l42.h |  1 -
 2 files changed, 44 insertions(+), 38 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 939f8bcc222c0..d81c6eb1c1e59 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -658,7 +658,6 @@ static int cs42l42_pll_config(struct snd_soc_component *component, unsigned int
 {
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
 	int i;
-	u32 fsync;
 
 	/* Don't reconfigure if there is an audio stream running */
 	if (cs42l42->stream_use) {
@@ -684,40 +683,6 @@ static int cs42l42_pll_config(struct snd_soc_component *component, unsigned int
 					(pll_ratio_table[i].mclk_int !=
 					24000000)) <<
 					CS42L42_INTERNAL_FS_SHIFT);
-
-			/* Set up the LRCLK */
-			fsync = clk / cs42l42->srate;
-			if (((fsync * cs42l42->srate) != clk)
-				|| ((fsync % 2) != 0)) {
-				dev_err(component->dev,
-					"Unsupported sclk %d/sample rate %d\n",
-					clk,
-					cs42l42->srate);
-				return -EINVAL;
-			}
-			/* Set the LRCLK period */
-			snd_soc_component_update_bits(component,
-					CS42L42_FSYNC_P_LOWER,
-					CS42L42_FSYNC_PERIOD_MASK,
-					CS42L42_FRAC0_VAL(fsync - 1) <<
-					CS42L42_FSYNC_PERIOD_SHIFT);
-			snd_soc_component_update_bits(component,
-					CS42L42_FSYNC_P_UPPER,
-					CS42L42_FSYNC_PERIOD_MASK,
-					CS42L42_FRAC1_VAL(fsync - 1) <<
-					CS42L42_FSYNC_PERIOD_SHIFT);
-			/* Set the LRCLK to 50% duty cycle */
-			fsync = fsync / 2;
-			snd_soc_component_update_bits(component,
-					CS42L42_FSYNC_PW_LOWER,
-					CS42L42_FSYNC_PULSE_WIDTH_MASK,
-					CS42L42_FRAC0_VAL(fsync - 1) <<
-					CS42L42_FSYNC_PULSE_WIDTH_SHIFT);
-			snd_soc_component_update_bits(component,
-					CS42L42_FSYNC_PW_UPPER,
-					CS42L42_FSYNC_PULSE_WIDTH_MASK,
-					CS42L42_FRAC1_VAL(fsync - 1) <<
-					CS42L42_FSYNC_PULSE_WIDTH_SHIFT);
 			if (pll_ratio_table[i].mclk_src_sel == 0) {
 				/* Pass the clock straight through */
 				snd_soc_component_update_bits(component,
@@ -809,6 +774,46 @@ static void cs42l42_src_config(struct snd_soc_component *component, unsigned int
 				      fs << CS42L42_CLK_OASRC_SEL_SHIFT);
 }
 
+static int cs42l42_asp_config(struct snd_soc_component *component,
+			      unsigned int sclk, unsigned int sample_rate)
+{
+	u32 fsync = sclk / sample_rate;
+
+	/* Set up the LRCLK */
+	if (((fsync * sample_rate) != sclk) || ((fsync % 2) != 0)) {
+		dev_err(component->dev,
+			"Unsupported sclk %d/sample rate %d\n",
+			sclk,
+			sample_rate);
+		return -EINVAL;
+	}
+	/* Set the LRCLK period */
+	snd_soc_component_update_bits(component,
+				      CS42L42_FSYNC_P_LOWER,
+				      CS42L42_FSYNC_PERIOD_MASK,
+				      CS42L42_FRAC0_VAL(fsync - 1) <<
+				      CS42L42_FSYNC_PERIOD_SHIFT);
+	snd_soc_component_update_bits(component,
+				      CS42L42_FSYNC_P_UPPER,
+				      CS42L42_FSYNC_PERIOD_MASK,
+				      CS42L42_FRAC1_VAL(fsync - 1) <<
+				      CS42L42_FSYNC_PERIOD_SHIFT);
+	/* Set the LRCLK to 50% duty cycle */
+	fsync = fsync / 2;
+	snd_soc_component_update_bits(component,
+				      CS42L42_FSYNC_PW_LOWER,
+				      CS42L42_FSYNC_PULSE_WIDTH_MASK,
+				      CS42L42_FRAC0_VAL(fsync - 1) <<
+				      CS42L42_FSYNC_PULSE_WIDTH_SHIFT);
+	snd_soc_component_update_bits(component,
+				      CS42L42_FSYNC_PW_UPPER,
+				      CS42L42_FSYNC_PULSE_WIDTH_MASK,
+				      CS42L42_FRAC1_VAL(fsync - 1) <<
+				      CS42L42_FSYNC_PULSE_WIDTH_SHIFT);
+
+	return 0;
+}
+
 static int cs42l42_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = codec_dai->component;
@@ -904,8 +909,6 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
 	unsigned int bclk;
 	int ret;
 
-	cs42l42->srate = params_rate(params);
-
 	if (cs42l42->bclk_ratio) {
 		/* machine driver has set the BCLK/samp-rate ratio */
 		bclk = cs42l42->bclk_ratio * params_rate(params);
@@ -966,6 +969,10 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (ret)
 		return ret;
 
+	ret = cs42l42_asp_config(component, bclk, sample_rate);
+	if (ret)
+		return ret;
+
 	cs42l42_src_config(component, sample_rate);
 
 	return 0;
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index a721366641127..17aab06adc8e6 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -36,7 +36,6 @@ struct  cs42l42_private {
 	int pll_config;
 	u32 sclk;
 	u32 bclk_ratio;
-	u32 srate;
 	u8 plug_state;
 	u8 hs_type;
 	u8 ts_inv;
-- 
2.34.1

