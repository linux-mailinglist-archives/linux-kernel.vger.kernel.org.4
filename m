Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD7864849A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiLIPFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiLIPFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:05:15 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F40119C23
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:05:14 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id t2so2159697ply.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 07:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bYXaODBVhflASZ7OxFAgzxq0Ral2A1PhxDvbahBGsvE=;
        b=r82KimHTdYUJfTD2kSEU0d5/sHOgGIZebkfojO+q3neNyh7NCtKuRC6Zz3c9PE3ibd
         iKKAoa23sJV2mQfhfpvTYF3KNMr3Tv9e8rwlZLDU7HfYjbDzTMIfDebIPNcK3i4X+wfS
         eN+dv2k74QzCjEokGJya1Z8SrZVl9L0uF5jLW1C7VoJ4neLWAZrfU6vwk9G2Xu5C7fr6
         LWx82xaeXPrR0v1L5jZt4pzQm2pV7naPBPxkZlBlgy0LIMq0u9Yom3PNl8Bs+6DgjcfR
         pBvnf7m0h2TLoQ6wOjt4xRmbJaWUaH0+Y4jobjQRErSRIaKteuBhv4RA+MsUyKLoi3cm
         jnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bYXaODBVhflASZ7OxFAgzxq0Ral2A1PhxDvbahBGsvE=;
        b=NybbFae50IVDB8i7Az9PN2q2Cc6nGuI+B4PRuxj/sqW1r7u/zH3OvkiqzIeAwQadly
         mT2xR7yNOr+2dSHj18E4d98SXbe53vrQaXSulsgZHEY2VuWXOkDkE2uQAwBwLlJjCxlt
         uEoUrpnu9E7WANMdl6LOKnUAqVzsjU2Eb2Uwcn9kPU1WwqANR2CJQWu9zubEATwSJVtu
         0R7xmHeVCL1FWW+5kEjrnukYKSqKzroaF0xjchcdv1sM3QYjjRtFp2w9lRsOgKlbngfZ
         3UAbpto/tatZVjTFDyr/IxJpkSTs5XpImi6UfFt3E6t38ZloRV0a7/9ngijBmFbhT5V5
         E6PA==
X-Gm-Message-State: ANoB5pkkXoqnQYEUEKfyrvLZH/CLZVckEaJnR5saGl5KBnX86MY9FX6F
        2OzP3TO+s2jfdaB3GbSdmkiDuYE3XR8SksA0O/g=
X-Google-Smtp-Source: AA0mqf7P2PScex89JkMHbkg7PXQ7ZPThb0uB4RrC4jJtpuZmE2zqb70l8OWHL1W52fylS8loKkwsEg==
X-Received: by 2002:a17:90a:ba01:b0:218:8263:4aac with SMTP id s1-20020a17090aba0100b0021882634aacmr6258953pjr.17.1670598313688;
        Fri, 09 Dec 2022 07:05:13 -0800 (PST)
Received: from ajye-OMEN-by-HP-Laptop-S.hitronhub.home (123-195-117-216.dynamic.kbronet.com.tw. [123.195.117.216])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090a410200b002187a4dd830sm1267137pjf.46.2022.12.09.07.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 07:05:13 -0800 (PST)
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
Subject: [PATCH v1] ASoC: Intel: sof_nau8825: add support for nau8825 with amp nau8318
Date:   Fri,  9 Dec 2022 23:05:03 +0800
Message-Id: <20221209150503.11875-1-ajye_huang@compal.corp-partner.google.com>
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
And reusing max98360's topology since DAI setting could be leveraged.

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
index 60aee56f94bd..282b9c966ce6 100644
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
+		.sof_tplg_filename = "sof-adl-max98360a-nau8825.tplg",
+	},
 	{
 		.id = "10508825",
 		.drv_name = "sof_nau8825",
-- 
2.25.1

