Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F2764EE26
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiLPPt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiLPPty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:49:54 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8C150D6A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:49:52 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id 4so2722982plj.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x3qpEO5lHSZJwEeaighoCmCCXRBl2IrYmRYFiqgKpIw=;
        b=ALUB5kNDC2Ru+bNPAbdn8rSB56VCGbnjykUtqJIjZAZM36nSTuFjrrI1kQ4eiJy0lV
         AX36TnHO8u682Jt1uLYulk7vhIi8OsAXZtdccQAASLLzEJnexixvrjv29NV499gL/zSi
         Xis1yOCWUu3LXS9HHogIxskSZhuxtIVDmVSGXV/b/Ol13T8BKNfqzROLB5CJiWngaZwy
         fpEKb/j1dYSd71o0q1eptDRJz052ELBNEStfj7nqIi1oqfc/jicNQQd7g+lRZYEB2Jh4
         B7DCRVDEVZ3YsM36WVdLuMEm6C1acU4YIeZEBQTBg0sAFF+8l2arzfFJeYoMh+SYS0ik
         oR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x3qpEO5lHSZJwEeaighoCmCCXRBl2IrYmRYFiqgKpIw=;
        b=OiM54KAXvLSVmyYxD1zTUtIhVJNMtF1wFeF+FsRyYX9j04VnSKl//QD3F2TGEFbpUr
         gm3qkWCkyI5sQ+KFpvkHeNnpQQsHtIr6QnoC5kYbvF/XDFHPNOeUBdl/Q8ryIasGGkYE
         eIEvPjlT0oRwI0EkcIWOiOBjMv7+wQIecNo0yI2w/EvohbNmSrZk4/FQ5iHqUJCnXWtT
         y2uatc/Kn55sdWSbiXmHICsDEHM/SOJUhjgLNXG5OpwZH95vb7hX4ZW9+GQw2xKLOK4E
         oy65qSoowT8bq8o+hq5uORIp3xYN16ElDOOkP7wsfBkKg+sTPKWS0bb05ZWHHcjtV0P6
         NHOA==
X-Gm-Message-State: ANoB5pnWAERNTZCE7IpSQcWip8Cxrb5w0BuY/Mcwrww/qVEs4vh4tIZM
        p6xXcOs1U6hJmPba5zN5NK7zFbCxmG0hItYqgz4=
X-Google-Smtp-Source: AA0mqf75RsyhgBAwKuey2DzSvP1/d3AiH7wmMlxnJig/9nbHpTV/V0QPqvnwI/rvRwkbg/5fUS4aIw==
X-Received: by 2002:a17:903:1209:b0:186:7608:1880 with SMTP id l9-20020a170903120900b0018676081880mr45954540plh.36.1671205792024;
        Fri, 16 Dec 2022 07:49:52 -0800 (PST)
Received: from ajye-OMEN-by-HP-Laptop-S.hitronhub.home (123-195-117-216.dynamic.kbronet.com.tw. [123.195.117.216])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902d4c100b0017f7c4e260fsm1797897plg.150.2022.12.16.07.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 07:49:51 -0800 (PST)
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
        Muralidhar Reddy <muralidhar.reddy@intel.com>,
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
Subject: [PATCH v2] ASoC: Intel: sof_nau8825: add variant with nau8318 amplifier.
Date:   Fri, 16 Dec 2022 23:49:38 +0800
Message-Id: <20221216154938.9426-1-ajye_huang@compal.corp-partner.google.com>
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
---

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
index 27880224359d..0936450be153 100644
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
+		.name = "adl_nau8318_nau8825",
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
index 60aee56f94bd..1a69cd8c5e18 100644
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
+		.drv_name = "adl_nau8318_nau8825",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &adl_nau8318_amp,
+		.sof_tplg_filename = "sof-adl-nau8318-nau8825.tplg",
+	},
 	{
 		.id = "10508825",
 		.drv_name = "sof_nau8825",
-- 
2.25.1

