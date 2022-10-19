Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3203B604BE3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbiJSPmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiJSPlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:41:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63721BE43D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:38:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9749AB82187
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1A5C433C1;
        Wed, 19 Oct 2022 15:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666193818;
        bh=4n+mBsiEKIemfJ5i92KNqo8iXr+fx/HO1cNz4Vy443U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BF2W+MFV9nfPeIOVwUfakMNwNpLRNe5jIaHXvd6TeHrLR84pMRSisC2gcsFG5KFov
         f1VA+6FgoE/JpmkOFQJrM+W51HpthfpyK0WpXBP9/08SlEH424q6Gfe/J4Y4cZUCWm
         C/ZmXDnjIoikUo0sbtrVYAQB6iAc+95Pew87RZN9nPKcAi+k55OpFOsJ6aopo4qZuL
         NMCETGKlQjkAVpSfN1a3wmnCD3K2GEix/+VTgc9/u7EIXgKt9afpE81FNhpR28kROK
         QLGNgLC4Xu1q2RFra5pLlDWomAOuLEOsp1FCssBhn39qVlB1Gv7CfCGqo9+MiEtoVA
         K8wnm+LQjRhhw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH 09/14] ASoC: remove unused davinci support
Date:   Wed, 19 Oct 2022 17:29:35 +0200
Message-Id: <20221019152947.3857217-10-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221019152947.3857217-1-arnd@kernel.org>
References: <20221019152947.3857217-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The dm644x and dm3xx SoCs have been removed, as have the
da850_evm/da830_evm machines, the remaining machines all use the
DT based probing and do not use the vcif driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/ti/Kconfig        |  40 ------
 sound/soc/ti/Makefile       |   2 -
 sound/soc/ti/davinci-evm.c  | 267 +-----------------------------------
 sound/soc/ti/davinci-vcif.c | 247 ---------------------------------
 4 files changed, 3 insertions(+), 553 deletions(-)
 delete mode 100644 sound/soc/ti/davinci-vcif.c

diff --git a/sound/soc/ti/Kconfig b/sound/soc/ti/Kconfig
index 40110e9a9e8a..593be22503b5 100644
--- a/sound/soc/ti/Kconfig
+++ b/sound/soc/ti/Kconfig
@@ -40,13 +40,6 @@ config SND_SOC_DAVINCI_MCASP
 	  - Keystone devices
 	  - K3 devices (am654, j721e)
 
-config SND_SOC_DAVINCI_VCIF
-	tristate "daVinci Voice Interface (VCIF) support"
-	depends on ARCH_DAVINCI || COMPILE_TEST
-	select SND_SOC_TI_EDMA_PCM
-	help
-	  Say Y or M here if you want audio support via daVinci VCIF.
-
 config SND_SOC_OMAP_DMIC
 	tristate "Digital Microphone Module (DMIC) support"
 	depends on ARCH_OMAP4 || SOC_OMAP5 || COMPILE_TEST && COMMON_CLK
@@ -177,14 +170,6 @@ config SND_SOC_OMAP_OSK5912
 config SND_SOC_DAVINCI_EVM
 	tristate "SoC Audio support for DaVinci EVMs"
 	depends on ARCH_DAVINCI && I2C
-	select SND_SOC_DAVINCI_ASP if MACH_DAVINCI_DM355_EVM
-	select SND_SOC_DAVINCI_ASP if SND_SOC_DM365_AIC3X_CODEC
-	select SND_SOC_DAVINCI_VCIF if SND_SOC_DM365_VOICE_CODEC
-	select SND_SOC_DAVINCI_ASP if MACH_DAVINCI_EVM # DM6446
-	select SND_SOC_DAVINCI_MCASP if MACH_DAVINCI_DM6467_EVM
-	select SND_SOC_SPDIF if MACH_DAVINCI_DM6467_EVM
-	select SND_SOC_DAVINCI_MCASP if MACH_DAVINCI_DA830_EVM
-	select SND_SOC_DAVINCI_MCASP if MACH_DAVINCI_DA850_EVM
 	select SND_SOC_TLV320AIC3X
 	help
 	  Say Y if you want to add support for SoC audio on the following TI
@@ -196,31 +181,6 @@ config SND_SOC_DAVINCI_EVM
 	  - DM830
 	  - DM850
 
-choice
-	prompt "DM365 codec select"
-	depends on SND_SOC_DAVINCI_EVM
-	depends on MACH_DAVINCI_DM365_EVM
-
-config SND_SOC_DM365_AIC3X_CODEC
-	bool "Audio Codec - AIC3101"
-	help
-	  Say Y if you want to add support for AIC3101 audio codec
-
-config SND_SOC_DM365_VOICE_CODEC
-	bool "Voice Codec - CQ93VC"
-	help
-	  Say Y if you want to add support for SoC On-chip voice codec
-endchoice
-
-config SND_SOC_DM365_SELECT_VOICE_CODECS
-	def_tristate y
-	depends on SND_SOC_DM365_VOICE_CODEC && SND_SOC
-	select MFD_DAVINCI_VOICECODEC
-	select SND_SOC_CQ0093VC
-	help
-	  The is an internal symbol needed to ensure that the codec
-	  and MFD driver can be built as loadable modules if necessary.
-
 config SND_SOC_J721E_EVM
 	tristate "SoC Audio support for j721e EVM"
 	depends on ARCH_K3 || COMPILE_TEST && COMMON_CLK
diff --git a/sound/soc/ti/Makefile b/sound/soc/ti/Makefile
index a21e5b0061de..41cdcaec770d 100644
--- a/sound/soc/ti/Makefile
+++ b/sound/soc/ti/Makefile
@@ -12,14 +12,12 @@ obj-$(CONFIG_SND_SOC_TI_UDMA_PCM) += snd-soc-ti-udma.o
 # CPU DAI drivers
 snd-soc-davinci-asp-objs := davinci-i2s.o
 snd-soc-davinci-mcasp-objs := davinci-mcasp.o
-snd-soc-davinci-vcif-objs := davinci-vcif.o
 snd-soc-omap-dmic-objs := omap-dmic.o
 snd-soc-omap-mcbsp-objs := omap-mcbsp.o omap-mcbsp-st.o
 snd-soc-omap-mcpdm-objs := omap-mcpdm.o
 
 obj-$(CONFIG_SND_SOC_DAVINCI_ASP) += snd-soc-davinci-asp.o
 obj-$(CONFIG_SND_SOC_DAVINCI_MCASP) += snd-soc-davinci-mcasp.o
-obj-$(CONFIG_SND_SOC_DAVINCI_VCIF) += snd-soc-davinci-vcif.o
 obj-$(CONFIG_SND_SOC_OMAP_DMIC) += snd-soc-omap-dmic.o
 obj-$(CONFIG_SND_SOC_OMAP_MCBSP) += snd-soc-omap-mcbsp.o
 obj-$(CONFIG_SND_SOC_OMAP_MCPDM) += snd-soc-omap-mcpdm.o
diff --git a/sound/soc/ti/davinci-evm.c b/sound/soc/ti/davinci-evm.c
index 68d69e32681a..983d69b951b0 100644
--- a/sound/soc/ti/davinci-evm.c
+++ b/sound/soc/ti/davinci-evm.c
@@ -138,214 +138,6 @@ static int evm_aic3x_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-/* davinci-evm digital audio interface glue - connects codec <--> CPU */
-SND_SOC_DAILINK_DEFS(dm6446,
-	DAILINK_COMP_ARRAY(COMP_CPU("davinci-mcbsp")),
-	DAILINK_COMP_ARRAY(COMP_CODEC("tlv320aic3x-codec.1-001b",
-				      "tlv320aic3x-hifi")),
-	DAILINK_COMP_ARRAY(COMP_PLATFORM("davinci-mcbsp")));
-
-static struct snd_soc_dai_link dm6446_evm_dai = {
-	.name = "TLV320AIC3X",
-	.stream_name = "AIC3X",
-	.init = evm_aic3x_init,
-	.ops = &evm_ops,
-	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
-		   SND_SOC_DAIFMT_IB_NF,
-	SND_SOC_DAILINK_REG(dm6446),
-};
-
-SND_SOC_DAILINK_DEFS(dm355,
-	DAILINK_COMP_ARRAY(COMP_CPU("davinci-mcbsp.1")),
-	DAILINK_COMP_ARRAY(COMP_CODEC("tlv320aic3x-codec.1-001b",
-				      "tlv320aic3x-hifi")),
-	DAILINK_COMP_ARRAY(COMP_PLATFORM("davinci-mcbsp.1")));
-
-static struct snd_soc_dai_link dm355_evm_dai = {
-	.name = "TLV320AIC3X",
-	.stream_name = "AIC3X",
-	.init = evm_aic3x_init,
-	.ops = &evm_ops,
-	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
-		   SND_SOC_DAIFMT_IB_NF,
-	SND_SOC_DAILINK_REG(dm355),
-};
-
-#ifdef CONFIG_SND_SOC_DM365_AIC3X_CODEC
-SND_SOC_DAILINK_DEFS(dm365,
-	DAILINK_COMP_ARRAY(COMP_CPU("davinci-mcbsp")),
-	DAILINK_COMP_ARRAY(COMP_CODEC("tlv320aic3x-codec.1-0018",
-				      "tlv320aic3x-hifi")),
-	DAILINK_COMP_ARRAY(COMP_PLATFORM("davinci-mcbsp")));
-#elif defined(CONFIG_SND_SOC_DM365_VOICE_CODEC)
-SND_SOC_DAILINK_DEFS(dm365,
-	DAILINK_COMP_ARRAY(COMP_CPU("davinci-vcif")),
-	DAILINK_COMP_ARRAY(COMP_CODEC("cq93vc-codec", "cq93vc-hifi")),
-	DAILINK_COMP_ARRAY(COMP_PLATFORM("davinci-vcif")));
-#endif
-
-static struct snd_soc_dai_link dm365_evm_dai = {
-#ifdef CONFIG_SND_SOC_DM365_AIC3X_CODEC
-	.name = "TLV320AIC3X",
-	.stream_name = "AIC3X",
-	.init = evm_aic3x_init,
-	.ops = &evm_ops,
-	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
-		   SND_SOC_DAIFMT_IB_NF,
-	SND_SOC_DAILINK_REG(dm365),
-#elif defined(CONFIG_SND_SOC_DM365_VOICE_CODEC)
-	.name = "Voice Codec - CQ93VC",
-	.stream_name = "CQ93",
-	SND_SOC_DAILINK_REG(dm365),
-#endif
-};
-
-SND_SOC_DAILINK_DEFS(dm6467_aic3x,
-	DAILINK_COMP_ARRAY(COMP_CPU("davinci-mcasp.0")),
-	DAILINK_COMP_ARRAY(COMP_CODEC("tlv320aic3x-codec.0-001a",
-				      "tlv320aic3x-hifi")),
-	DAILINK_COMP_ARRAY(COMP_PLATFORM("davinci-mcasp.0")));
-
-SND_SOC_DAILINK_DEFS(dm6467_spdif,
-	DAILINK_COMP_ARRAY(COMP_CPU("davinci-mcasp.1")),
-	DAILINK_COMP_ARRAY(COMP_CODEC("spdif_dit", "dit-hifi")),
-	DAILINK_COMP_ARRAY(COMP_PLATFORM("davinci-mcasp.1")));
-
-static struct snd_soc_dai_link dm6467_evm_dai[] = {
-	{
-		.name = "TLV320AIC3X",
-		.stream_name = "AIC3X",
-		.init = evm_aic3x_init,
-		.ops = &evm_ops,
-		.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
-			   SND_SOC_DAIFMT_IB_NF,
-		SND_SOC_DAILINK_REG(dm6467_aic3x),
-	},
-	{
-		.name = "McASP",
-		.stream_name = "spdif",
-		.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
-			   SND_SOC_DAIFMT_IB_NF,
-		SND_SOC_DAILINK_REG(dm6467_spdif),
-	},
-};
-
-SND_SOC_DAILINK_DEFS(da830,
-	DAILINK_COMP_ARRAY(COMP_CPU("davinci-mcasp.1")),
-	DAILINK_COMP_ARRAY(COMP_CODEC("tlv320aic3x-codec.1-0018",
-				      "tlv320aic3x-hifi")),
-	DAILINK_COMP_ARRAY(COMP_PLATFORM("davinci-mcasp.1")));
-
-static struct snd_soc_dai_link da830_evm_dai = {
-	.name = "TLV320AIC3X",
-	.stream_name = "AIC3X",
-	.init = evm_aic3x_init,
-	.ops = &evm_ops,
-	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
-		   SND_SOC_DAIFMT_IB_NF,
-	SND_SOC_DAILINK_REG(da830),
-};
-
-SND_SOC_DAILINK_DEFS(da850,
-	DAILINK_COMP_ARRAY(COMP_CPU("davinci-mcasp.0")),
-	DAILINK_COMP_ARRAY(COMP_CODEC("tlv320aic3x-codec.1-0018",
-				      "tlv320aic3x-hifi")),
-	DAILINK_COMP_ARRAY(COMP_PLATFORM("davinci-mcasp.0")));
-
-static struct snd_soc_dai_link da850_evm_dai = {
-	.name = "TLV320AIC3X",
-	.stream_name = "AIC3X",
-	.init = evm_aic3x_init,
-	.ops = &evm_ops,
-	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
-		   SND_SOC_DAIFMT_IB_NF,
-	SND_SOC_DAILINK_REG(da850),
-};
-
-/* davinci dm6446 evm audio machine driver */
-/*
- * ASP0 in DM6446 EVM is clocked by U55, as configured by
- * board-dm644x-evm.c using GPIOs from U18.  There are six
- * options; here we "know" we use a 48 KHz sample rate.
- */
-static struct snd_soc_card_drvdata_davinci dm6446_snd_soc_card_drvdata = {
-	.sysclk = 12288000,
-};
-
-static struct snd_soc_card dm6446_snd_soc_card_evm = {
-	.name = "DaVinci DM6446 EVM",
-	.owner = THIS_MODULE,
-	.dai_link = &dm6446_evm_dai,
-	.num_links = 1,
-	.drvdata = &dm6446_snd_soc_card_drvdata,
-};
-
-/* davinci dm355 evm audio machine driver */
-/* ASP1 on DM355 EVM is clocked by an external oscillator */
-static struct snd_soc_card_drvdata_davinci dm355_snd_soc_card_drvdata = {
-	.sysclk = 27000000,
-};
-
-static struct snd_soc_card dm355_snd_soc_card_evm = {
-	.name = "DaVinci DM355 EVM",
-	.owner = THIS_MODULE,
-	.dai_link = &dm355_evm_dai,
-	.num_links = 1,
-	.drvdata = &dm355_snd_soc_card_drvdata,
-};
-
-/* davinci dm365 evm audio machine driver */
-static struct snd_soc_card_drvdata_davinci dm365_snd_soc_card_drvdata = {
-	.sysclk = 27000000,
-};
-
-static struct snd_soc_card dm365_snd_soc_card_evm = {
-	.name = "DaVinci DM365 EVM",
-	.owner = THIS_MODULE,
-	.dai_link = &dm365_evm_dai,
-	.num_links = 1,
-	.drvdata = &dm365_snd_soc_card_drvdata,
-};
-
-/* davinci dm6467 evm audio machine driver */
-static struct snd_soc_card_drvdata_davinci dm6467_snd_soc_card_drvdata = {
-	.sysclk = 27000000,
-};
-
-static struct snd_soc_card dm6467_snd_soc_card_evm = {
-	.name = "DaVinci DM6467 EVM",
-	.owner = THIS_MODULE,
-	.dai_link = dm6467_evm_dai,
-	.num_links = ARRAY_SIZE(dm6467_evm_dai),
-	.drvdata = &dm6467_snd_soc_card_drvdata,
-};
-
-static struct snd_soc_card_drvdata_davinci da830_snd_soc_card_drvdata = {
-	.sysclk = 24576000,
-};
-
-static struct snd_soc_card da830_snd_soc_card = {
-	.name = "DA830/OMAP-L137 EVM",
-	.owner = THIS_MODULE,
-	.dai_link = &da830_evm_dai,
-	.num_links = 1,
-	.drvdata = &da830_snd_soc_card_drvdata,
-};
-
-static struct snd_soc_card_drvdata_davinci da850_snd_soc_card_drvdata = {
-	.sysclk = 24576000,
-};
-
-static struct snd_soc_card da850_snd_soc_card = {
-	.name = "DA850/OMAP-L138 EVM",
-	.owner = THIS_MODULE,
-	.dai_link = &da850_evm_dai,
-	.num_links = 1,
-	.drvdata = &da850_snd_soc_card_drvdata,
-};
-
-#if defined(CONFIG_OF)
-
 /*
  * The struct is used as place holder. It will be completely
  * filled with data from dt node.
@@ -461,71 +253,18 @@ static struct platform_driver davinci_evm_driver = {
 	.driver		= {
 		.name	= "davinci_evm",
 		.pm	= &snd_soc_pm_ops,
-		.of_match_table = of_match_ptr(davinci_evm_dt_ids),
+		.of_match_table = davinci_evm_dt_ids,
 	},
 };
-#endif
-
-static struct platform_device *evm_snd_device;
 
 static int __init evm_init(void)
 {
-	struct snd_soc_card *evm_snd_dev_data;
-	int index;
-	int ret;
-
-	/*
-	 * If dtb is there, the devices will be created dynamically.
-	 * Only register platfrom driver structure.
-	 */
-#if defined(CONFIG_OF)
-	if (of_have_populated_dt())
-		return platform_driver_register(&davinci_evm_driver);
-#endif
-
-	if (machine_is_davinci_evm()) {
-		evm_snd_dev_data = &dm6446_snd_soc_card_evm;
-		index = 0;
-	} else if (machine_is_davinci_dm355_evm()) {
-		evm_snd_dev_data = &dm355_snd_soc_card_evm;
-		index = 1;
-	} else if (machine_is_davinci_dm365_evm()) {
-		evm_snd_dev_data = &dm365_snd_soc_card_evm;
-		index = 0;
-	} else if (machine_is_davinci_dm6467_evm()) {
-		evm_snd_dev_data = &dm6467_snd_soc_card_evm;
-		index = 0;
-	} else if (machine_is_davinci_da830_evm()) {
-		evm_snd_dev_data = &da830_snd_soc_card;
-		index = 1;
-	} else if (machine_is_davinci_da850_evm()) {
-		evm_snd_dev_data = &da850_snd_soc_card;
-		index = 0;
-	} else
-		return -EINVAL;
-
-	evm_snd_device = platform_device_alloc("soc-audio", index);
-	if (!evm_snd_device)
-		return -ENOMEM;
-
-	platform_set_drvdata(evm_snd_device, evm_snd_dev_data);
-	ret = platform_device_add(evm_snd_device);
-	if (ret)
-		platform_device_put(evm_snd_device);
-
-	return ret;
+	return platform_driver_register(&davinci_evm_driver);
 }
 
 static void __exit evm_exit(void)
 {
-#if defined(CONFIG_OF)
-	if (of_have_populated_dt()) {
-		platform_driver_unregister(&davinci_evm_driver);
-		return;
-	}
-#endif
-
-	platform_device_unregister(evm_snd_device);
+	platform_driver_unregister(&davinci_evm_driver);
 }
 
 module_init(evm_init);
diff --git a/sound/soc/ti/davinci-vcif.c b/sound/soc/ti/davinci-vcif.c
deleted file mode 100644
index 36fa97e2b9e2..000000000000
--- a/sound/soc/ti/davinci-vcif.c
+++ /dev/null
@@ -1,247 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * ALSA SoC Voice Codec Interface for TI DAVINCI processor
- *
- * Copyright (C) 2010 Texas Instruments.
- *
- * Author: Miguel Aguilar <miguel.aguilar@ridgerun.com>
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/io.h>
-#include <linux/mfd/davinci_voicecodec.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/initval.h>
-#include <sound/soc.h>
-#include <sound/dmaengine_pcm.h>
-
-#include "edma-pcm.h"
-#include "davinci-i2s.h"
-
-#define MOD_REG_BIT(val, mask, set) do { \
-	if (set) { \
-		val |= mask; \
-	} else { \
-		val &= ~mask; \
-	} \
-} while (0)
-
-struct davinci_vcif_dev {
-	struct davinci_vc *davinci_vc;
-	struct snd_dmaengine_dai_dma_data dma_data[2];
-	int dma_request[2];
-};
-
-static void davinci_vcif_start(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
-	struct davinci_vcif_dev *davinci_vcif_dev =
-			snd_soc_dai_get_drvdata(asoc_rtd_to_cpu(rtd, 0));
-	struct davinci_vc *davinci_vc = davinci_vcif_dev->davinci_vc;
-	u32 w;
-
-	/* Start the sample generator and enable transmitter/receiver */
-	w = readl(davinci_vc->base + DAVINCI_VC_CTRL);
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RSTDAC, 0);
-	else
-		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RSTADC, 0);
-
-	writel(w, davinci_vc->base + DAVINCI_VC_CTRL);
-}
-
-static void davinci_vcif_stop(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
-	struct davinci_vcif_dev *davinci_vcif_dev =
-			snd_soc_dai_get_drvdata(asoc_rtd_to_cpu(rtd, 0));
-	struct davinci_vc *davinci_vc = davinci_vcif_dev->davinci_vc;
-	u32 w;
-
-	/* Reset transmitter/receiver and sample rate/frame sync generators */
-	w = readl(davinci_vc->base + DAVINCI_VC_CTRL);
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RSTDAC, 1);
-	else
-		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RSTADC, 1);
-
-	writel(w, davinci_vc->base + DAVINCI_VC_CTRL);
-}
-
-static int davinci_vcif_hw_params(struct snd_pcm_substream *substream,
-				  struct snd_pcm_hw_params *params,
-				  struct snd_soc_dai *dai)
-{
-	struct davinci_vcif_dev *davinci_vcif_dev = snd_soc_dai_get_drvdata(dai);
-	struct davinci_vc *davinci_vc = davinci_vcif_dev->davinci_vc;
-	u32 w;
-
-	/* Restart the codec before setup */
-	davinci_vcif_stop(substream);
-	davinci_vcif_start(substream);
-
-	/* General line settings */
-	writel(DAVINCI_VC_CTRL_MASK, davinci_vc->base + DAVINCI_VC_CTRL);
-
-	writel(DAVINCI_VC_INT_MASK, davinci_vc->base + DAVINCI_VC_INTCLR);
-
-	writel(DAVINCI_VC_INT_MASK, davinci_vc->base + DAVINCI_VC_INTEN);
-
-	w = readl(davinci_vc->base + DAVINCI_VC_CTRL);
-
-	/* Determine xfer data type */
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_U8:
-		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RD_BITS_8 |
-			    DAVINCI_VC_CTRL_RD_UNSIGNED |
-			    DAVINCI_VC_CTRL_WD_BITS_8 |
-			    DAVINCI_VC_CTRL_WD_UNSIGNED, 1);
-		break;
-	case SNDRV_PCM_FORMAT_S8:
-		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RD_BITS_8 |
-			    DAVINCI_VC_CTRL_WD_BITS_8, 1);
-
-		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RD_UNSIGNED |
-			    DAVINCI_VC_CTRL_WD_UNSIGNED, 0);
-		break;
-	case SNDRV_PCM_FORMAT_S16_LE:
-		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RD_BITS_8 |
-			    DAVINCI_VC_CTRL_RD_UNSIGNED |
-			    DAVINCI_VC_CTRL_WD_BITS_8 |
-			    DAVINCI_VC_CTRL_WD_UNSIGNED, 0);
-		break;
-	default:
-		printk(KERN_WARNING "davinci-vcif: unsupported PCM format");
-		return -EINVAL;
-	}
-
-	writel(w, davinci_vc->base + DAVINCI_VC_CTRL);
-
-	return 0;
-}
-
-static int davinci_vcif_trigger(struct snd_pcm_substream *substream, int cmd,
-				struct snd_soc_dai *dai)
-{
-	int ret = 0;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		davinci_vcif_start(substream);
-		break;
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		davinci_vcif_stop(substream);
-		break;
-	default:
-		ret = -EINVAL;
-	}
-
-	return ret;
-}
-
-#define DAVINCI_VCIF_RATES	SNDRV_PCM_RATE_8000_48000
-
-static const struct snd_soc_dai_ops davinci_vcif_dai_ops = {
-	.trigger	= davinci_vcif_trigger,
-	.hw_params	= davinci_vcif_hw_params,
-};
-
-static int davinci_vcif_dai_probe(struct snd_soc_dai *dai)
-{
-	struct davinci_vcif_dev *dev = snd_soc_dai_get_drvdata(dai);
-
-	dai->playback_dma_data = &dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK];
-	dai->capture_dma_data = &dev->dma_data[SNDRV_PCM_STREAM_CAPTURE];
-
-	return 0;
-}
-
-static struct snd_soc_dai_driver davinci_vcif_dai = {
-	.probe = davinci_vcif_dai_probe,
-	.playback = {
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = DAVINCI_VCIF_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-	.capture = {
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = DAVINCI_VCIF_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-	.ops = &davinci_vcif_dai_ops,
-
-};
-
-static const struct snd_soc_component_driver davinci_vcif_component = {
-	.name			= "davinci-vcif",
-	.legacy_dai_naming	= 1,
-};
-
-static int davinci_vcif_probe(struct platform_device *pdev)
-{
-	struct davinci_vc *davinci_vc = pdev->dev.platform_data;
-	struct davinci_vcif_dev *davinci_vcif_dev;
-	int ret;
-
-	davinci_vcif_dev = devm_kzalloc(&pdev->dev,
-					sizeof(struct davinci_vcif_dev),
-					GFP_KERNEL);
-	if (!davinci_vcif_dev)
-		return -ENOMEM;
-
-	/* DMA tx params */
-	davinci_vcif_dev->davinci_vc = davinci_vc;
-	davinci_vcif_dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK].filter_data =
-				&davinci_vc->davinci_vcif.dma_tx_channel;
-	davinci_vcif_dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK].addr =
-				davinci_vc->davinci_vcif.dma_tx_addr;
-
-	/* DMA rx params */
-	davinci_vcif_dev->dma_data[SNDRV_PCM_STREAM_CAPTURE].filter_data =
-				&davinci_vc->davinci_vcif.dma_rx_channel;
-	davinci_vcif_dev->dma_data[SNDRV_PCM_STREAM_CAPTURE].addr =
-				davinci_vc->davinci_vcif.dma_rx_addr;
-
-	dev_set_drvdata(&pdev->dev, davinci_vcif_dev);
-
-	ret = devm_snd_soc_register_component(&pdev->dev,
-					      &davinci_vcif_component,
-					      &davinci_vcif_dai, 1);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "could not register dai\n");
-		return ret;
-	}
-
-	ret = edma_pcm_platform_register(&pdev->dev);
-	if (ret) {
-		dev_err(&pdev->dev, "register PCM failed: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-static struct platform_driver davinci_vcif_driver = {
-	.probe		= davinci_vcif_probe,
-	.driver		= {
-		.name	= "davinci-vcif",
-	},
-};
-
-module_platform_driver(davinci_vcif_driver);
-
-MODULE_AUTHOR("Miguel Aguilar");
-MODULE_DESCRIPTION("Texas Instruments DaVinci ASoC Voice Codec Interface");
-MODULE_LICENSE("GPL");
-- 
2.29.2

