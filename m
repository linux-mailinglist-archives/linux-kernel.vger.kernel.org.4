Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F836AFFDD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCHHgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjCHHfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:35:39 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F420768F;
        Tue,  7 Mar 2023 23:35:34 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i34so62023467eda.7;
        Tue, 07 Mar 2023 23:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678260932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwmnzBCq63isuXl3Q6C2EI4fASZ8/CUk+jrNqzYxJ44=;
        b=VbzEV/VvOn0aSQHQgw9+0pNrIzr+/yH5ubUhN1HKeSmTXf94BdvU0QAKeTG/UexecP
         ZICikcpLbHW2e0fYNwJ1vyGRLpXhwmMMlXD9YP4uO+DI5vvTfwVk203z/MAYV7iNWyaM
         LzAP5cU4wfatBnoKPgcGA8qelmXohuXnpZcu1lSeTbjjW3JnQg7Lwe2dS93Db7T778FE
         cBvDSoBmgp6dMUeoYjAojgWZRchmdsvquJU223oHpOImJgsuy1k8R4gIJQ1WmoZmx8pJ
         N8S7zxDTRsGGvpgIvE+YkAOd2Hsg6lQsjUcJTHv2ZjlZBM3GeR1S2dA9jZ8xNEj38m4l
         TbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678260932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwmnzBCq63isuXl3Q6C2EI4fASZ8/CUk+jrNqzYxJ44=;
        b=QRoaVuvEejaXxFL2QIvvozunDgJzuBpF7ocfTTsI6MnpkT1KPvjWGZULa9UK8gDiEq
         Uhz7WnvmXhp5dukvcWWMNNI8cJrHLwSM2XJLu6zPSDQtbOtQJV21C3u34HGCQPdzz5BQ
         sjXLBNhWZTdwpwe45/RcNCkw0ibJ2fZrkWwQxs4d6ItgC76j1tHkipLhzKBVGZ08Xi3d
         TW43zwxj+ZCQraDrPPtRrbaOrxLsgqYUlKvuSV3SsDD5NfJmrT4amUOjjQR+776P11W3
         +P3mH8YaaMHkmagD5iqPx9mxc3p/u6dmy+J1c1GlBDXfRcJys6v5LD9JfBOvtLxDNMyv
         wghA==
X-Gm-Message-State: AO0yUKW7lnkhdWkFF+bhVImY7MbB6uzEWL0lIB9d+CP3NP5xDv52hSr6
        FN3EdzqZcfYJZZyC7Nn0txop5dkczr0=
X-Google-Smtp-Source: AK7set8yXe5XLI1jn/5JXFxjt5s2N24GAa37Qe0PvcVxhvZdWMgW9+5PjfaVT0zEhW3uEJtj78YZ1w==
X-Received: by 2002:a17:907:6f18:b0:8f8:5779:f1af with SMTP id sy24-20020a1709076f1800b008f85779f1afmr18421549ejc.15.1678260932432;
        Tue, 07 Mar 2023 23:35:32 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id h15-20020a1709062dcf00b008dffda52d71sm7051880eji.124.2023.03.07.23.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 23:35:32 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v2 8/8] ASoC: tegra: Support MAX9808x by machine driver
Date:   Wed,  8 Mar 2023 09:35:02 +0200
Message-Id: <20230308073502.5421-9-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230308073502.5421-1-clamor95@gmail.com>
References: <20230308073502.5421-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Maxim MAX9808x codec support to the Tegra ASoC machine driver.
This codec is found on LG T30 devices like Optimus 4X HD and
Optimus Vu.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 sound/soc/tegra/Kconfig              |  9 ++++++
 sound/soc/tegra/tegra_asoc_machine.c | 46 +++++++++++++++++++++++++---
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
index ff905e5dcd86..950f490b8d54 100644
--- a/sound/soc/tegra/Kconfig
+++ b/sound/soc/tegra/Kconfig
@@ -263,6 +263,15 @@ config SND_SOC_TEGRA_MAX98090
 	  Say Y or M here if you want to add support for SoC audio on Tegra
 	  boards using the MAX98090 codec, such as Venice2.
 
+config SND_SOC_TEGRA_MAX98088
+	tristate "SoC Audio support for Tegra boards using a MAX9808x codec"
+	depends on I2C && GPIOLIB
+	select SND_SOC_TEGRA_MACHINE_DRV
+	select SND_SOC_MAX98088
+	help
+	  Say Y or M here if you want to add support for SoC audio on Tegra
+	  boards using the MAX98088 codec, such as LG X3.
+
 config SND_SOC_TEGRA_RT5677
 	tristate "SoC Audio support for Tegra boards using a RT5677 codec"
 	depends on I2C && GPIOLIB
diff --git a/sound/soc/tegra/tegra_asoc_machine.c b/sound/soc/tegra/tegra_asoc_machine.c
index 020f03349373..cc08325d523b 100644
--- a/sound/soc/tegra/tegra_asoc_machine.c
+++ b/sound/soc/tegra/tegra_asoc_machine.c
@@ -86,11 +86,11 @@ static int tegra_machine_event(struct snd_soc_dapm_widget *w,
 		gpiod_set_value_cansleep(machine->gpiod_spkr_en,
 					 SND_SOC_DAPM_EVENT_ON(event));
 
-	if (!strcmp(w->name, "Mic Jack"))
+	if (!strcmp(w->name, "Mic Jack") || !strcmp(w->name, "Headset Mic"))
 		gpiod_set_value_cansleep(machine->gpiod_ext_mic_en,
 					 SND_SOC_DAPM_EVENT_ON(event));
 
-	if (!strcmp(w->name, "Int Mic"))
+	if (!strcmp(w->name, "Int Mic") || !strcmp(w->name, "Internal Mic 2"))
 		gpiod_set_value_cansleep(machine->gpiod_int_mic_en,
 					 SND_SOC_DAPM_EVENT_ON(event));
 
@@ -108,11 +108,12 @@ static const struct snd_soc_dapm_widget tegra_machine_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("Headphones", NULL),
 	SND_SOC_DAPM_SPK("Speakers", tegra_machine_event),
 	SND_SOC_DAPM_SPK("Int Spk", tegra_machine_event),
+	SND_SOC_DAPM_SPK("Earpiece", NULL),
 	SND_SOC_DAPM_MIC("Int Mic", tegra_machine_event),
 	SND_SOC_DAPM_MIC("Mic Jack", tegra_machine_event),
 	SND_SOC_DAPM_MIC("Internal Mic 1", NULL),
-	SND_SOC_DAPM_MIC("Internal Mic 2", NULL),
-	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Internal Mic 2", tegra_machine_event),
+	SND_SOC_DAPM_MIC("Headset Mic", tegra_machine_event),
 	SND_SOC_DAPM_MIC("Digital Mic", NULL),
 	SND_SOC_DAPM_MIC("Mic", NULL),
 	SND_SOC_DAPM_LINE("Line In Jack", NULL),
@@ -123,6 +124,7 @@ static const struct snd_soc_dapm_widget tegra_machine_dapm_widgets[] = {
 static const struct snd_kcontrol_new tegra_machine_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Speakers"),
 	SOC_DAPM_PIN_SWITCH("Int Spk"),
+	SOC_DAPM_PIN_SWITCH("Earpiece"),
 	SOC_DAPM_PIN_SWITCH("Int Mic"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 	SOC_DAPM_PIN_SWITCH("Internal Mic 1"),
@@ -718,6 +720,40 @@ static const struct tegra_asoc_data tegra_max98090_data = {
 	.add_hp_jack = true,
 };
 
+/* MAX98088 machine */
+
+SND_SOC_DAILINK_DEFS(max98088_hifi,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "HiFi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+static struct snd_soc_dai_link tegra_max98088_dai = {
+	.name = "MAX98088",
+	.stream_name = "MAX98088 PCM",
+	.init = tegra_asoc_machine_init,
+	.dai_fmt = SND_SOC_DAIFMT_I2S |
+		   SND_SOC_DAIFMT_NB_NF |
+		   SND_SOC_DAIFMT_CBS_CFS,
+	SND_SOC_DAILINK_REG(max98088_hifi),
+};
+
+static struct snd_soc_card snd_soc_tegra_max98088 = {
+	.components = "codec:max98088",
+	.dai_link = &tegra_max98088_dai,
+	.num_links = 1,
+	.fully_routed = true,
+};
+
+static const struct tegra_asoc_data tegra_max98088_data = {
+	.mclk_rate = tegra_machine_mclk_rate_12mhz,
+	.card = &snd_soc_tegra_max98088,
+	.add_common_dapm_widgets = true,
+	.add_common_controls = true,
+	.add_common_snd_ops = true,
+	.add_mic_jack = true,
+	.add_hp_jack = true,
+};
+
 /* SGTL5000 machine */
 
 SND_SOC_DAILINK_DEFS(sgtl5000_hifi,
@@ -946,6 +982,8 @@ static const struct tegra_asoc_data tegra_rt5631_data = {
 static const struct of_device_id tegra_machine_of_match[] = {
 	{ .compatible = "nvidia,tegra-audio-trimslice", .data = &tegra_trimslice_data },
 	{ .compatible = "nvidia,tegra-audio-max98090", .data = &tegra_max98090_data },
+	{ .compatible = "nvidia,tegra-audio-max98088", .data = &tegra_max98088_data },
+	{ .compatible = "nvidia,tegra-audio-max98089", .data = &tegra_max98088_data },
 	{ .compatible = "nvidia,tegra-audio-sgtl5000", .data = &tegra_sgtl5000_data },
 	{ .compatible = "nvidia,tegra-audio-wm9712", .data = &tegra_wm9712_data },
 	{ .compatible = "nvidia,tegra-audio-wm8753", .data = &tegra_wm8753_data },
-- 
2.37.2

