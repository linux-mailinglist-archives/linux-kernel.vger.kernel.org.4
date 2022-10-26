Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC9A60DBF7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiJZHRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiJZHRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:17:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC8DBD65D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 00:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666768626; x=1698304626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=75HpJEzPLn8A5CbuFT1/YZ3tvDRbc53NHO6Z7uVHf2U=;
  b=CC+/7sJlJiABVVh7h+e8fxmj+k+zFyKO5H+5eL83fdsnFEnEb5x4DprY
   iw0R6+Nn9dcEoar1j5d3cwp/vv8/BCK+F7J/eXnYDM5elTabQbvpLPcXK
   FPfxur43dAz8RVd6deFgcqAVMHBiHZU5gI/SOghMOT/ZF1EvMr2RQRg5F
   J/TuhnTfeuIRubY5IlSnGMgxVkmA5EgO4bjFNZ3wVAzFRJpBdxZxMDy/n
   fIkv3EzsiO0TYble6ijT7WBBz06DwZxf554lYY1EN6XB2zU+Nfu7HKxbT
   Wz4V0uUNhpqWE2Bc1tEY3r7bUEW7eoumC9oQFytUbmKe+vWAGODHZJY2Q
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="309568993"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="309568993"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 00:17:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="663096939"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="663096939"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.25])
  by orsmga008.jf.intel.com with ESMTP; 26 Oct 2022 00:17:02 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Brent Lu <brent.lu@intel.com>, linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Yong Zhi <yong.zhi@intel.com>,
        Ajye Huang <ajye.huang@gmail.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Gongjun Song <gongjun.song@intel.com>,
        Muralidhar Reddy <muralidhar.reddy@intel.com>,
        "balamurugan . c" <balamurugan.c@intel.com>,
        Chao Song <chao.song@linux.intel.com>
Subject: [PATCH 2/2] ASoC: Intel: sof_rt5682: quirk auto detection
Date:   Wed, 26 Oct 2022 15:14:09 +0800
Message-Id: <20221026071409.3235144-3-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026071409.3235144-1-brent.lu@intel.com>
References: <20221026071409.3235144-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To get rid of increasing board_ids array with similar quirks for every
new platform, we implement a special board config 'sof_rt5682_auto' to
compose quirk value at runtime. It detects SoC and amplifier type to
determine the quirk value.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/sof_rt5682.c           | 173 +++++++-----------
 .../intel/common/soc-acpi-intel-adl-match.c   |  12 +-
 .../intel/common/soc-acpi-intel-jsl-match.c   |   6 +-
 .../intel/common/soc-acpi-intel-tgl-match.c   |   6 +-
 4 files changed, 77 insertions(+), 120 deletions(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 2358be208c1f..2dfccbaae53c 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -60,6 +60,7 @@
 #define SOF_MAX98390_SPEAKER_AMP_PRESENT	BIT(24)
 #define SOF_MAX98390_TWEETER_SPEAKER_PRESENT	BIT(25)
 #define SOF_RT1019_SPEAKER_AMP_PRESENT	BIT(26)
+#define SOF_RT5682_AUTO_DETECT	BIT(27)
 
 
 /* Default: MCLK on, MCLK 19.2M, SSP0  */
@@ -838,6 +839,65 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
 	return NULL;
 }
 
+static const struct {
+	const u8 id[ACPI_ID_LEN];
+	unsigned long quirk;
+} spk_quirk_map[] = {
+	{.id = "10EC1011", .quirk = SOF_RT1011_SPEAKER_AMP_PRESENT},
+	{.id = "10EC1015", .quirk = SOF_RT1015_SPEAKER_AMP_PRESENT},
+	{.id = "RTL1015", .quirk = SOF_RT1015P_SPEAKER_AMP_PRESENT},
+	{.id = "RTL1019", .quirk = SOF_RT1019_SPEAKER_AMP_PRESENT},
+	{.id = "MX98357A", .quirk = 0},
+	{.id = "MX98360A", .quirk = SOF_MAX98360A_SPEAKER_AMP_PRESENT},
+	{.id = "MX98373", .quirk = SOF_MAX98373_SPEAKER_AMP_PRESENT},
+	{.id = "MX98390", .quirk = SOF_MAX98390_SPEAKER_AMP_PRESENT},
+};
+
+static unsigned long sof_audio_auto_detect(struct device *dev)
+{
+	unsigned long quirk = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(spk_quirk_map); i++) {
+		if (!acpi_dev_present(spk_quirk_map[i].id, NULL, -1))
+			continue;
+
+		dev_dbg(dev, "%s detected\n", spk_quirk_map[i].id);
+		quirk |= spk_quirk_map[i].quirk;
+		quirk |= SOF_SPEAKER_AMP_PRESENT;
+		break;
+	}
+
+	if (soc_intel_is_jsl()) {
+		quirk |= SOF_RT5682_MCLK_EN |
+			 SOF_RT5682_MCLK_24MHZ |
+			 SOF_RT5682_NUM_HDMIDEV(3) |
+			 SOF_RT5682_SSP_CODEC(0);
+
+		if (quirk & SOF_SPEAKER_AMP_PRESENT)
+			quirk |= SOF_RT5682_SSP_AMP(1);
+	} else if (soc_intel_is_tgl()) {
+		quirk |= SOF_RT5682_MCLK_EN |
+			 SOF_RT5682_NUM_HDMIDEV(4) |
+			 SOF_RT5682_SSP_CODEC(0);
+
+		if (quirk & SOF_SPEAKER_AMP_PRESENT)
+			quirk |= SOF_RT5682_SSP_AMP(1);
+	} else if (soc_intel_is_adl() || soc_intel_is_adl_n()) {
+		quirk |= SOF_RT5682_MCLK_EN |
+			 SOF_RT5682_NUM_HDMIDEV(4) |
+			 SOF_RT5682_SSP_CODEC(0) |
+			 SOF_BT_OFFLOAD_SSP(2) |
+			 SOF_SSP_BT_OFFLOAD_PRESENT;
+
+		if (quirk & SOF_SPEAKER_AMP_PRESENT)
+			quirk |= SOF_RT5682_SSP_AMP(1);
+	} else
+		dev_err(dev, "Auto-detect failed due to unknown platform\n");
+
+	return quirk;
+}
+
 static int sof_audio_probe(struct platform_device *pdev)
 {
 	struct snd_soc_dai_link *dai_links;
@@ -855,6 +915,9 @@ static int sof_audio_probe(struct platform_device *pdev)
 
 	dmi_check_system(sof_rt5682_quirk_table);
 
+	if (sof_rt5682_quirk & SOF_RT5682_AUTO_DETECT)
+		sof_rt5682_quirk |= sof_audio_auto_detect(&pdev->dev);
+
 	mach = pdev->dev.platform_data;
 
 	/* A speaker amp might not be present when the quirk claims one is.
@@ -975,43 +1038,8 @@ static const struct platform_device_id board_ids[] = {
 		.name = "sof_rt5682",
 	},
 	{
-		.name = "tgl_mx98357_rt5682",
-		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
-					SOF_RT5682_SSP_CODEC(0) |
-					SOF_SPEAKER_AMP_PRESENT |
-					SOF_RT5682_SSP_AMP(1) |
-					SOF_RT5682_NUM_HDMIDEV(4) |
-					SOF_BT_OFFLOAD_SSP(2) |
-					SOF_SSP_BT_OFFLOAD_PRESENT),
-	},
-	{
-		.name = "jsl_rt5682_rt1015",
-		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
-					SOF_RT5682_MCLK_24MHZ |
-					SOF_RT5682_SSP_CODEC(0) |
-					SOF_SPEAKER_AMP_PRESENT |
-					SOF_RT1015_SPEAKER_AMP_PRESENT |
-					SOF_RT5682_SSP_AMP(1)),
-	},
-	{
-		.name = "tgl_mx98373_rt5682",
-		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
-					SOF_RT5682_SSP_CODEC(0) |
-					SOF_SPEAKER_AMP_PRESENT |
-					SOF_MAX98373_SPEAKER_AMP_PRESENT |
-					SOF_RT5682_SSP_AMP(1) |
-					SOF_RT5682_NUM_HDMIDEV(4) |
-					SOF_BT_OFFLOAD_SSP(2) |
-					SOF_SSP_BT_OFFLOAD_PRESENT),
-	},
-	{
-		.name = "jsl_rt5682_mx98360",
-		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
-					SOF_RT5682_MCLK_24MHZ |
-					SOF_RT5682_SSP_CODEC(0) |
-					SOF_SPEAKER_AMP_PRESENT |
-					SOF_MAX98360A_SPEAKER_AMP_PRESENT |
-					SOF_RT5682_SSP_AMP(1)),
+		.name = "sof_rt5682_auto",
+		.driver_data = (kernel_ulong_t)(SOF_RT5682_AUTO_DETECT),
 	},
 	{
 		.name = "cml_rt1015_rt5682",
@@ -1022,37 +1050,6 @@ static const struct platform_device_id board_ids[] = {
 					SOF_RT1015_SPEAKER_AMP_PRESENT |
 					SOF_RT5682_SSP_AMP(1)),
 	},
-	{
-		.name = "tgl_rt1011_rt5682",
-		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
-					SOF_RT5682_SSP_CODEC(0) |
-					SOF_SPEAKER_AMP_PRESENT |
-					SOF_RT1011_SPEAKER_AMP_PRESENT |
-					SOF_RT5682_SSP_AMP(1) |
-					SOF_RT5682_NUM_HDMIDEV(4) |
-					SOF_BT_OFFLOAD_SSP(2) |
-					SOF_SSP_BT_OFFLOAD_PRESENT),
-	},
-	{
-		.name = "jsl_rt5682_rt1015p",
-		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
-					SOF_RT5682_MCLK_24MHZ |
-					SOF_RT5682_SSP_CODEC(0) |
-					SOF_SPEAKER_AMP_PRESENT |
-					SOF_RT1015P_SPEAKER_AMP_PRESENT |
-					SOF_RT5682_SSP_AMP(1)),
-	},
-	{
-		.name = "adl_mx98373_rt5682",
-		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
-					SOF_RT5682_SSP_CODEC(0) |
-					SOF_SPEAKER_AMP_PRESENT |
-					SOF_MAX98373_SPEAKER_AMP_PRESENT |
-					SOF_RT5682_SSP_AMP(1) |
-					SOF_RT5682_NUM_HDMIDEV(4) |
-					SOF_BT_OFFLOAD_SSP(2) |
-					SOF_SSP_BT_OFFLOAD_PRESENT),
-	},
 	{
 		.name = "adl_mx98357_rt5682",
 		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
@@ -1061,46 +1058,6 @@ static const struct platform_device_id board_ids[] = {
 					SOF_RT5682_SSP_AMP(2) |
 					SOF_RT5682_NUM_HDMIDEV(4)),
 	},
-	{
-		.name = "adl_max98390_rt5682",
-		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
-					SOF_RT5682_SSP_CODEC(0) |
-					SOF_SPEAKER_AMP_PRESENT |
-					SOF_MAX98390_SPEAKER_AMP_PRESENT |
-					SOF_RT5682_SSP_AMP(1) |
-					SOF_RT5682_NUM_HDMIDEV(4) |
-					SOF_BT_OFFLOAD_SSP(2) |
-					SOF_SSP_BT_OFFLOAD_PRESENT),
-	},
-	{
-		.name = "adl_mx98360_rt5682",
-		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
-					SOF_RT5682_SSP_CODEC(0) |
-					SOF_SPEAKER_AMP_PRESENT |
-					SOF_MAX98360A_SPEAKER_AMP_PRESENT |
-					SOF_RT5682_SSP_AMP(1) |
-					SOF_RT5682_NUM_HDMIDEV(4) |
-					SOF_BT_OFFLOAD_SSP(2) |
-					SOF_SSP_BT_OFFLOAD_PRESENT),
-	},
-	{
-		.name = "adl_rt5682",
-		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
-					SOF_RT5682_SSP_CODEC(0) |
-					SOF_RT5682_NUM_HDMIDEV(4) |
-					SOF_BT_OFFLOAD_SSP(2) |
-					SOF_SSP_BT_OFFLOAD_PRESENT),
-	},
-	{
-		.name = "adl_rt1019_rt5682s",
-		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
-					SOF_RT5682_SSP_CODEC(0) |
-					SOF_RT5682S_HEADPHONE_CODEC_PRESENT |
-					SOF_SPEAKER_AMP_PRESENT |
-					SOF_RT1019_SPEAKER_AMP_PRESENT |
-					SOF_RT5682_SSP_AMP(1) |
-					SOF_RT5682_NUM_HDMIDEV(4)),
-	},
 	{
 		.name = "mtl_mx98357_rt5682",
 		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
diff --git a/sound/soc/intel/common/soc-acpi-intel-adl-match.c b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
index 9990d5502d26..598e3d493369 100644
--- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
@@ -448,7 +448,7 @@ static const struct snd_soc_acpi_codecs adl_lt6911_hdmi = {
 struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 	{
 		.comp_ids = &adl_rt5682_rt5682s_hp,
-		.drv_name = "adl_mx98373_rt5682",
+		.drv_name = "sof_rt5682_auto",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &adl_max98373_amp,
 		.sof_tplg_filename = "sof-adl-max98373-rt5682.tplg",
@@ -462,7 +462,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 	},
 	{
 		.comp_ids = &adl_rt5682_rt5682s_hp,
-		.drv_name = "adl_mx98360_rt5682",
+		.drv_name = "sof_rt5682_auto",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &adl_max98360a_amp,
 		.sof_tplg_filename = "sof-adl-max98360a-rt5682.tplg",
@@ -489,8 +489,8 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 		.sof_tplg_filename = "sof-adl-max98360a-nau8825.tplg",
 	},
 	{
-		.id = "RTL5682",
-		.drv_name = "adl_rt1019_rt5682s",
+		.comp_ids = &adl_rt5682_rt5682s_hp,
+		.drv_name = "sof_rt5682_auto",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &adl_rt1019p_amp,
 		.sof_tplg_filename = "sof-adl-rt1019-rt5682.tplg",
@@ -502,14 +502,14 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 	},
 	{
 		.comp_ids = &adl_rt5682_rt5682s_hp,
-		.drv_name = "adl_max98390_rt5682",
+		.drv_name = "sof_rt5682_auto",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &adl_max98390_amp,
 		.sof_tplg_filename = "sof-adl-max98390-rt5682.tplg",
 	},
 	{
 		.comp_ids = &adl_rt5682_rt5682s_hp,
-		.drv_name = "adl_rt5682",
+		.drv_name = "sof_rt5682_auto",
 		.sof_tplg_filename = "sof-adl-rt5682.tplg",
 	},
 	{
diff --git a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
index b95c4b2cda94..1b7e56fa9211 100644
--- a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
@@ -59,21 +59,21 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
 	},
 	{
 		.comp_ids = &rt5682_rt5682s_hp,
-		.drv_name = "jsl_rt5682_rt1015",
+		.drv_name = "sof_rt5682_auto",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &rt1015_spk,
 		.sof_tplg_filename = "sof-jsl-rt5682-rt1015.tplg",
 	},
 	{
 		.comp_ids = &rt5682_rt5682s_hp,
-		.drv_name = "jsl_rt5682_rt1015p",
+		.drv_name = "sof_rt5682_auto",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &rt1015p_spk,
 		.sof_tplg_filename = "sof-jsl-rt5682-rt1015.tplg",
 	},
 	{
 		.comp_ids = &rt5682_rt5682s_hp,
-		.drv_name = "jsl_rt5682_mx98360",
+		.drv_name = "sof_rt5682_auto",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &mx98360a_spk,
 		.sof_tplg_filename = "sof-jsl-rt5682-mx98360a.tplg",
diff --git a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
index ef19150e7b2e..b882deedfab4 100644
--- a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
@@ -376,21 +376,21 @@ static const struct snd_soc_acpi_codecs tgl_lt6911_hdmi = {
 struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_machines[] = {
 	{
 		.comp_ids = &tgl_rt5682_rt5682s_hp,
-		.drv_name = "tgl_mx98357_rt5682",
+		.drv_name = "sof_rt5682_auto",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &tgl_codecs,
 		.sof_tplg_filename = "sof-tgl-max98357a-rt5682.tplg",
 	},
 	{
 		.comp_ids = &tgl_rt5682_rt5682s_hp,
-		.drv_name = "tgl_mx98373_rt5682",
+		.drv_name = "sof_rt5682_auto",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &tgl_max98373_amp,
 		.sof_tplg_filename = "sof-tgl-max98373-rt5682.tplg",
 	},
 	{
 		.comp_ids = &tgl_rt5682_rt5682s_hp,
-		.drv_name = "tgl_rt1011_rt5682",
+		.drv_name = "sof_rt5682_auto",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &tgl_rt1011_amp,
 		.sof_tplg_filename = "sof-tgl-rt1011-rt5682.tplg",
-- 
2.25.1

