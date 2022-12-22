Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836FE653B43
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 05:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbiLVE0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 23:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbiLVE0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 23:26:48 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E4F26F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 20:26:47 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso4796664pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 20:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=83IiZKKqeyFIPbt60kx1s4S33RFQeqF/INn7EFkiJWE=;
        b=GUVigi1Sp2FNxfUmEOdGyWZf6iA44V655PYUi0Un0GFD69bZQlUYaKNrBrP2bVLzuO
         7gNkN6AcFluR2IVssNsgJtWwWYdorDOcUj/FYEmaRZc9el/7gqtI7F3CI2dbKuXoicFx
         Kb8RgfYmy7ri1Qam18pe/J0cVzhR5MxVetJPk63DtFBrs3xF/PCear9Hji1HqfwbqDN1
         dhqDLr8VSSBZiQz+xsQ1Ai9GEEMI8/oNEFAxsLHXstPAsRTq08iADZKsytScsQtL2DKz
         jqI7LlUN5+ITkNloFHEukMk4fXHHZE9KOTRCKg+KBdTFef5vAP3rTOEXiKYS/s4eV0WV
         u2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83IiZKKqeyFIPbt60kx1s4S33RFQeqF/INn7EFkiJWE=;
        b=zU+LZ9XfpAl8IC1HkqxJgJP026t8J0Od6rQW6CnUYzqBeZPAB4Auku8aanpS2GAOaz
         W739oBc7RJTXidA0q4mjJuxmow5yGkxIYS96qS31bc2yIVVKCAbZj6WuKCRQxoXzoJeB
         3CKr/yHWilAAs4GMx9UbbzDJEK/Be81P0DJcJJJXIJhFY+XzT0HIr2LHfVRxHk5ywqRi
         iK39ob/BvqrePYHVmLhmGOOCIWL8ojz5KcQssmZzgCK/idmVWNRodFrPl/3XCGVy+WHa
         JclbGCT8RZiyHLskE+ETqFZlbOfcHomtJSjFmx6U9vFhlpfZ/WV1Zo7yjfarHK//nr8d
         GE1w==
X-Gm-Message-State: AFqh2kpb2PoKoyEaopw3nwamMFJ4AUVTlApqDPHuH/lL1fcV5XDvrwZq
        0FsH+lCF6+T+Iy23q+Kfv62GfKUvsk3xum2Xy6o=
X-Google-Smtp-Source: AMrXdXtAcLvhmdXv3zALbUM+xSxaidfY2tI4Q/XslneGGdyo2VnpEEJlFzBBZlm2davf3bX6cTTaNw==
X-Received: by 2002:a17:902:d34a:b0:188:5256:bf60 with SMTP id l10-20020a170902d34a00b001885256bf60mr4401845plk.25.1671683206613;
        Wed, 21 Dec 2022 20:26:46 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:56a:a93e:d2b2:b38a:f4a1:ecec])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902e84b00b00183e2a96414sm12250691plg.121.2022.12.21.20.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 20:26:46 -0800 (PST)
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Yong Zhi <yong.zhi@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        "balamurugan . c" <balamurugan.c@intel.com>,
        Libin Yang <libin.yang@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        David Lin <CTLIN0@nuvoton.com>, Brent Lu <brent.lu@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v3] ASoC: Intel: sof_nau8825: add variant with nau8318 amplifier.
Date:   Thu, 22 Dec 2022 12:26:24 +0800
Message-Id: <20221222042624.557869-1-ajye_huang@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the driver data for two nau8318 speaker amplifiers on
SSP1 and nau8825 on SSP0 for ADL platform.

The nau8315 and nau8318 are both Nuvoton Amp chips. They use the same
Amp driver nau8315.c. The acpi_device_id for nau8315 is "NVTN2010",
for nau8318 is "NVTN2012".
The nau8825 is one of Nuvoton headset codec, and its acpi_device_id is
"10508825".

Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 changes from v1->v2:
 * Modify title and add explanations in commit messages .
 * Use new topology file "sof-adl-nau8318-nau8825.tplg" instead of sof-adl-max98360a-nau8825.tplg.
 changes from v2-v3:
 * Modify drv_name string from "adl_nau8318_nau8825" to "adl_nau8318_8825".

 sound/soc/intel/boards/Kconfig                |  1 +
 sound/soc/intel/boards/sof_nau8825.c          | 23 +++++++++++++++++++
 .../intel/common/soc-acpi-intel-adl-match.c   | 12 ++++++++++
 3 files changed, 36 insertions(+)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index a472de1909f4..3f68e9edd853 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -554,6 +554,7 @@ config SND_SOC_INTEL_SOF_NAU8825_MACH
 	select SND_SOC_RT1015P
 	select SND_SOC_MAX98373_I2C
 	select SND_SOC_MAX98357A
+	select SND_SOC_NAU8315
 	select SND_SOC_DMIC
 	select SND_SOC_HDAC_HDMI
 	select SND_SOC_INTEL_HDA_DSP_COMMON
diff --git a/sound/soc/intel/boards/sof_nau8825.c b/sound/soc/intel/boards/sof_nau8825.c
index 27880224359d..78d84527081a 100644
--- a/sound/soc/intel/boards/sof_nau8825.c
+++ b/sound/soc/intel/boards/sof_nau8825.c
@@ -48,6 +48,7 @@
 #define SOF_MAX98373_SPEAKER_AMP_PRESENT	BIT(15)
 #define SOF_MAX98360A_SPEAKER_AMP_PRESENT	BIT(16)
 #define SOF_RT1015P_SPEAKER_AMP_PRESENT	BIT(17)
+#define SOF_NAU8318_SPEAKER_AMP_PRESENT	BIT(18)
 
 static unsigned long sof_nau8825_quirk = SOF_NAU8825_SSP_CODEC(0);
 
@@ -338,6 +339,13 @@ static struct snd_soc_dai_link_component rt1019p_component[] = {
 	}
 };
 
+static struct snd_soc_dai_link_component nau8318_components[] = {
+	{
+		.name = "NVTN2012:00",
+		.dai_name = "nau8315-hifi",
+	}
+};
+
 static struct snd_soc_dai_link_component dummy_component[] = {
 	{
 		.name = "snd-soc-dummy",
@@ -486,6 +494,11 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
 			max_98360a_dai_link(&links[id]);
 		} else if (sof_nau8825_quirk & SOF_RT1015P_SPEAKER_AMP_PRESENT) {
 			sof_rt1015p_dai_link(&links[id]);
+		} else if (sof_nau8825_quirk &
+				SOF_NAU8318_SPEAKER_AMP_PRESENT) {
+			links[id].codecs = nau8318_components;
+			links[id].num_codecs = ARRAY_SIZE(nau8318_components);
+			links[id].init = speaker_codec_init;
 		} else {
 			goto devm_err;
 		}
@@ -657,6 +670,16 @@ static const struct platform_device_id board_ids[] = {
 					SOF_BT_OFFLOAD_SSP(2) |
 					SOF_SSP_BT_OFFLOAD_PRESENT),
 	},
+	{
+		.name = "adl_nau8318_8825",
+		.driver_data = (kernel_ulong_t)(SOF_NAU8825_SSP_CODEC(0) |
+					SOF_SPEAKER_AMP_PRESENT |
+					SOF_NAU8318_SPEAKER_AMP_PRESENT |
+					SOF_NAU8825_SSP_AMP(1) |
+					SOF_NAU8825_NUM_HDMIDEV(4) |
+					SOF_BT_OFFLOAD_SSP(2) |
+					SOF_SSP_BT_OFFLOAD_PRESENT),
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, board_ids);
diff --git a/sound/soc/intel/common/soc-acpi-intel-adl-match.c b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
index 60aee56f94bd..b1c0a89a8787 100644
--- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
@@ -450,6 +450,11 @@ static const struct snd_soc_acpi_codecs adl_lt6911_hdmi = {
 	.codecs = {"INTC10B0"}
 };
 
+static const struct snd_soc_acpi_codecs adl_nau8318_amp = {
+	.num_codecs = 1,
+	.codecs = {"NVTN2012"}
+};
+
 struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 	{
 		.comp_ids = &adl_rt5682_rt5682s_hp,
@@ -507,6 +512,13 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 		.quirk_data = &adl_rt1015p_amp,
 		.sof_tplg_filename = "sof-adl-rt1015-nau8825.tplg",
 	},
+	{
+		.id = "10508825",
+		.drv_name = "adl_nau8318_8825",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &adl_nau8318_amp,
+		.sof_tplg_filename = "sof-adl-nau8318-nau8825.tplg",
+	},
 	{
 		.id = "10508825",
 		.drv_name = "sof_nau8825",
-- 
2.25.1

