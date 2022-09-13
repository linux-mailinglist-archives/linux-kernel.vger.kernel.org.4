Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A175B68F9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiIMHuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiIMHua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:50:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C0E220E0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 00:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663055429; x=1694591429;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2z526O3hiioYh4mEY8M/wCC+qpQd8rhTRjBApkgGTdc=;
  b=C/fvwgWwVUC6E20hz4M6enHUqJ9Jh3mcXUcoPnyeaFqqynHwEREHpsae
   1WZkmg4wg+Rhx0gBNc3JdsiwEXaaEoPIVRm31dPe4+lc0lauGrUDT3oEr
   ps/Z/X4aSx60PzI5T6hZ7XljhjIMHdBS5775/7aiA6fYzc3eTTEWn9kx5
   My8Ns0NTNWS+pENgUI0D93AfegQWj3T3Kd5HRB7IOBzaceB8u4nwL0B6V
   proF4B4Dzo1xa2zWakmmZiSH4NXgN6DBQwGkQmKE44s+mldbY80wKvXq0
   8MHqaLZR6gOs9uclC/N1lYosZIjnXRGJX3+tXS0oGYfIWPPXRV6zFSjja
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="359797009"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="359797009"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 00:50:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="678455676"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.25])
  by fmsmga008.fm.intel.com with ESMTP; 13 Sep 2022 00:50:25 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
        Ajye Huang <ajye.huang@gmail.com>,
        Mac Chiang <mac.chiang@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Intel: sof_rt5682: remove SOF_RT1015_SPEAKER_AMP_100FS flag
Date:   Tue, 13 Sep 2022 15:49:06 +0800
Message-Id: <20220913074906.926774-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag could be removed since we now have API to query bclk
fequency setting in the topology. The dai link structure itself also
provides DAI format information instead of figuring it out with fs
number.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/sof_realtek_common.c | 86 +++++++++++----------
 sound/soc/intel/boards/sof_realtek_common.h |  2 +-
 sound/soc/intel/boards/sof_rt5682.c         |  6 +-
 3 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/sound/soc/intel/boards/sof_realtek_common.c b/sound/soc/intel/boards/sof_realtek_common.c
index b9643ca2e2f2..ff2851fc8930 100644
--- a/sound/soc/intel/boards/sof_realtek_common.c
+++ b/sound/soc/intel/boards/sof_realtek_common.c
@@ -253,63 +253,70 @@ EXPORT_SYMBOL_NS(sof_rt1015p_codec_conf, SND_SOC_INTEL_SOF_REALTEK_COMMON);
  * RT1015 audio amplifier
  */
 
+static const struct {
+	unsigned int tx;
+	unsigned int rx;
+} rt1015_tdm_mask[] = {
+	{.tx = 0x0, .rx = 0x1},
+	{.tx = 0x0, .rx = 0x2},
+};
+
 static int rt1015_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_dai_link *dai_link = rtd->dai_link;
 	struct snd_soc_dai *codec_dai;
-	int i, fs = 64, ret;
+	int i, clk_freq, ret;
 
-	for_each_rtd_codec_dais(rtd, i, codec_dai) {
-		ret = snd_soc_dai_set_pll(codec_dai, 0, RT1015_PLL_S_BCLK,
-					  params_rate(params) * fs,
-					  params_rate(params) * 256);
-		if (ret)
-			return ret;
+	clk_freq = sof_dai_get_bclk(rtd);
 
-		ret = snd_soc_dai_set_sysclk(codec_dai, RT1015_SCLK_S_PLL,
-					     params_rate(params) * 256,
-					     SND_SOC_CLOCK_IN);
-		if (ret)
-			return ret;
+	if (clk_freq <= 0) {
+		dev_err(rtd->dev, "fail to get bclk freq, ret %d\n", clk_freq);
+		return -EINVAL;
 	}
 
-	return 0;
-}
-
-static int rt1015_hw_params_pll_and_tdm(struct snd_pcm_substream *substream,
-					 struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
-	struct snd_soc_dai *codec_dai;
-	int i, fs = 100, ret;
-
 	for_each_rtd_codec_dais(rtd, i, codec_dai) {
 		ret = snd_soc_dai_set_pll(codec_dai, 0, RT1015_PLL_S_BCLK,
-					  params_rate(params) * fs,
+					  clk_freq,
 					  params_rate(params) * 256);
-		if (ret)
+		if (ret) {
+			dev_err(codec_dai->dev, "fail to set pll, ret %d\n",
+				ret);
 			return ret;
+		}
 
 		ret = snd_soc_dai_set_sysclk(codec_dai, RT1015_SCLK_S_PLL,
 					     params_rate(params) * 256,
 					     SND_SOC_CLOCK_IN);
-		if (ret)
+		if (ret) {
+			dev_err(codec_dai->dev, "fail to set sysclk, ret %d\n",
+				ret);
 			return ret;
-	}
-	/* rx slot 1 for RT1015_DEV0_NAME */
-	ret = snd_soc_dai_set_tdm_slot(asoc_rtd_to_codec(rtd, 0),
-				       0x0, 0x1, 4, 24);
-	if (ret)
-		return ret;
+		}
 
-	/* rx slot 2 for RT1015_DEV1_NAME */
-	ret = snd_soc_dai_set_tdm_slot(asoc_rtd_to_codec(rtd, 1),
-				       0x0, 0x2, 4, 24);
-	if (ret)
-		return ret;
+		switch (dai_link->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+		case SND_SOC_DAIFMT_DSP_A:
+		case SND_SOC_DAIFMT_DSP_B:
+			/* 4-slot TDM */
+			ret = snd_soc_dai_set_tdm_slot(codec_dai,
+						       rt1015_tdm_mask[i].tx,
+						       rt1015_tdm_mask[i].rx,
+						       4,
+						       params_width(params));
+			if (ret < 0) {
+				dev_err(codec_dai->dev, "fail to set tdm slot, ret %d\n",
+					ret);
+				return ret;
+			}
+			break;
+		default:
+			dev_dbg(codec_dai->dev, "codec is in I2S mode\n");
+			break;
+		}
+	}
 
-	return 0;
+	return ret;
 }
 
 static struct snd_soc_ops rt1015_ops = {
@@ -351,15 +358,12 @@ void sof_rt1015_codec_conf(struct snd_soc_card *card)
 }
 EXPORT_SYMBOL_NS(sof_rt1015_codec_conf, SND_SOC_INTEL_SOF_REALTEK_COMMON);
 
-void sof_rt1015_dai_link(struct snd_soc_dai_link *link, unsigned int fs)
+void sof_rt1015_dai_link(struct snd_soc_dai_link *link)
 {
 	link->codecs = rt1015_components;
 	link->num_codecs = ARRAY_SIZE(rt1015_components);
 	link->init = speaker_codec_init_lr;
 	link->ops = &rt1015_ops;
-
-	if (fs == 100)
-		rt1015_ops.hw_params = rt1015_hw_params_pll_and_tdm;
 }
 EXPORT_SYMBOL_NS(sof_rt1015_dai_link, SND_SOC_INTEL_SOF_REALTEK_COMMON);
 
diff --git a/sound/soc/intel/boards/sof_realtek_common.h b/sound/soc/intel/boards/sof_realtek_common.h
index 778443421090..3ae99d8239e0 100644
--- a/sound/soc/intel/boards/sof_realtek_common.h
+++ b/sound/soc/intel/boards/sof_realtek_common.h
@@ -32,7 +32,7 @@ void sof_rt1015p_codec_conf(struct snd_soc_card *card);
 #define RT1015_DEV0_NAME	"i2c-10EC1015:00"
 #define RT1015_DEV1_NAME	"i2c-10EC1015:01"
 
-void sof_rt1015_dai_link(struct snd_soc_dai_link *link, unsigned int fs);
+void sof_rt1015_dai_link(struct snd_soc_dai_link *link);
 void sof_rt1015_codec_conf(struct snd_soc_card *card);
 
 #define RT1308_CODEC_DAI	"rt1308-aif"
diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 045965312245..7d54b8ed3e83 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -46,7 +46,6 @@
 	((quirk << SOF_RT5682_NUM_HDMIDEV_SHIFT) & SOF_RT5682_NUM_HDMIDEV_MASK)
 #define SOF_RT1011_SPEAKER_AMP_PRESENT		BIT(13)
 #define SOF_RT1015_SPEAKER_AMP_PRESENT		BIT(14)
-#define SOF_RT1015_SPEAKER_AMP_100FS		BIT(15)
 #define SOF_RT1015P_SPEAKER_AMP_PRESENT		BIT(16)
 #define SOF_MAX98373_SPEAKER_AMP_PRESENT	BIT(17)
 #define SOF_MAX98360A_SPEAKER_AMP_PRESENT	BIT(18)
@@ -132,7 +131,6 @@ static const struct dmi_system_id sof_rt5682_quirk_table[] = {
 					SOF_RT5682_SSP_CODEC(0) |
 					SOF_SPEAKER_AMP_PRESENT |
 					SOF_RT1015_SPEAKER_AMP_PRESENT |
-					SOF_RT1015_SPEAKER_AMP_100FS |
 					SOF_RT5682_SSP_AMP(1)),
 	},
 	{
@@ -739,8 +737,7 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
 
 		links[id].id = id;
 		if (sof_rt5682_quirk & SOF_RT1015_SPEAKER_AMP_PRESENT) {
-			sof_rt1015_dai_link(&links[id], (sof_rt5682_quirk &
-					SOF_RT1015_SPEAKER_AMP_100FS) ? 100 : 64);
+			sof_rt1015_dai_link(&links[id]);
 		} else if (sof_rt5682_quirk & SOF_RT1015P_SPEAKER_AMP_PRESENT) {
 			sof_rt1015p_dai_link(&links[id]);
 		} else if (sof_rt5682_quirk & SOF_RT1019_SPEAKER_AMP_PRESENT) {
@@ -1010,7 +1007,6 @@ static const struct platform_device_id board_ids[] = {
 					SOF_RT5682_SSP_CODEC(0) |
 					SOF_SPEAKER_AMP_PRESENT |
 					SOF_RT1015_SPEAKER_AMP_PRESENT |
-					SOF_RT1015_SPEAKER_AMP_100FS |
 					SOF_RT5682_SSP_AMP(1)),
 	},
 	{
-- 
2.25.1

