Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5F169E78A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjBUScp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjBUScf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:32:35 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A1D301A0;
        Tue, 21 Feb 2023 10:32:29 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id ee7so5924703edb.2;
        Tue, 21 Feb 2023 10:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lCpP86gR9PkFUN8BPLcadI1otAfEY6NobKYiSJ0+e8=;
        b=mpAJ+X9KuU94JQa7v1MFLP7LPRRK2SWC5sC8arMYBw1H8c9DYwRZJUTnE+em+9mntW
         QLJRTRcAFul/3ZNUZfRtwC2ERxv2X+tQcNLFm6v9ssXcl6cOXy4P7s7R1UcpkXQlcChU
         N9tMOZZ+R4zCuaQCE0pbdyKCICRPgNdaBvEI40fyr7VnwUHXwjuRQ+Vrrgo1+4L0Yx5i
         XK6yV13Rhgtqq4aOPOrJaAmmx+ZXZ98VUqhk8pAKOp7fjcBbpuF8lNmsPOYsUJRpbb7n
         5krWw/CFLj1k9JAUbFwUlr8lH4Y8f3Jt5bedLtnXzZeZGqMya7aKlWIFc3EG9ciKHTEk
         6A4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lCpP86gR9PkFUN8BPLcadI1otAfEY6NobKYiSJ0+e8=;
        b=SgdId51rrUFm6AW+8wFvnq6zgpvEmG6sNW0aofJCgXAp/kWzSybxnquC9RdQw0P2pl
         ZhKnUeaE/07gctFrxT7Lv+UNQ+Uu9YXApVU9ZNIzbmYtXczfpirAzF4WRvvUTCVb3x5/
         iukT6ls9nsKVL+cOaCzkLnrAsO/HaXIWbziDqBs247E6Vj05TAgMOxZlaUoj/3CRj/8J
         pxsCu54L+VCeVNOxXUoMq5/5Xn8vduYbqYkHifQaBWEIJYQS3qGm7svSf94D/e1qvZf7
         ii1oR2UwePNntrl1Gk8ghlGcfT/d/Y++57jlCi59WkWwTHox1OmcjYHOGTJ3J+4Gfeit
         5OBQ==
X-Gm-Message-State: AO0yUKUW9GLXfp3EFrGPAkBgm8gu3/0enw6yk0exJS3+JAMc1aBJdsDm
        a5pH6x3o0pyuvdh+zn/AC8A=
X-Google-Smtp-Source: AK7set/sFJZmQyqzv3hTWw/QfEbYRiDulW0zynpIxce9Xm5NbDjlMzxiKSLomGcCDw682XnJNEAnFQ==
X-Received: by 2002:aa7:d38f:0:b0:4ac:d2cd:81c7 with SMTP id x15-20020aa7d38f000000b004acd2cd81c7mr5883673edq.5.1677004347748;
        Tue, 21 Feb 2023 10:32:27 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id i3-20020a50c3c3000000b004af5aa16fcasm169102edf.66.2023.02.21.10.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:32:27 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v1 04/10] ASoC: tegra: Support RT5631 by machine driver
Date:   Tue, 21 Feb 2023 20:32:05 +0200
Message-Id: <20230221183211.21964-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230221183211.21964-1-clamor95@gmail.com>
References: <20230221183211.21964-1-clamor95@gmail.com>
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

Add Realtek ALC5631/RT5631 codec support to the Tegra ASoC machine driver.
The RT5631 codec is found on devices like ASUS Transformer TF201, TF700T
and other Tegra-based Android tablets.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Ion Agorria <ion@agorria.com>
---
 sound/soc/tegra/Kconfig              |  9 ++++
 sound/soc/tegra/tegra_asoc_machine.c | 74 ++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
index b6712a3d1fa1..ff905e5dcd86 100644
--- a/sound/soc/tegra/Kconfig
+++ b/sound/soc/tegra/Kconfig
@@ -189,6 +189,15 @@ config SND_SOC_TEGRA_AUDIO_GRAPH_CARD
 config SND_SOC_TEGRA_MACHINE_DRV
 	tristate
 
+config SND_SOC_TEGRA_RT5631
+	tristate "SoC Audio support for Tegra boards using an RT5631 codec"
+	depends on SND_SOC_TEGRA && I2C && GPIOLIB
+	select SND_SOC_TEGRA_MACHINE_DRV
+	select SND_SOC_RT5631
+	help
+	  Say Y or M here if you want to add support for SoC audio on Tegra
+	  boards using the RT5631 codec, such as Transformer.
+
 config SND_SOC_TEGRA_RT5640
 	tristate "SoC Audio support for Tegra boards using an RT5640 codec"
 	depends on I2C && GPIOLIB
diff --git a/sound/soc/tegra/tegra_asoc_machine.c b/sound/soc/tegra/tegra_asoc_machine.c
index 78faa8bcae27..607800ec07a6 100644
--- a/sound/soc/tegra/tegra_asoc_machine.c
+++ b/sound/soc/tegra/tegra_asoc_machine.c
@@ -51,6 +51,17 @@ static struct snd_soc_jack_gpio tegra_machine_headset_jack_gpio = {
 };
 
 /* Mic Jack */
+static int headset_check(void *data)
+{
+	struct tegra_machine *machine = (struct tegra_machine *)data;
+
+	/* Detect mic insertion only if 3.5 jack is in */
+	if (gpiod_get_value_cansleep(machine->gpiod_hp_det) &&
+	    gpiod_get_value_cansleep(machine->gpiod_mic_det))
+		return SND_JACK_MICROPHONE;
+
+	return 0;
+}
 
 static struct snd_soc_jack tegra_machine_mic_jack;
 
@@ -183,8 +194,15 @@ int tegra_asoc_machine_init(struct snd_soc_pcm_runtime *rtd)
 			return err;
 		}
 
+		tegra_machine_mic_jack_gpio.data = machine;
 		tegra_machine_mic_jack_gpio.desc = machine->gpiod_mic_det;
 
+		if (of_property_read_bool(card->dev->of_node,
+					  "nvidia,coupled-mic-hp-det")) {
+			tegra_machine_mic_jack_gpio.desc = machine->gpiod_hp_det;
+			tegra_machine_mic_jack_gpio.jack_status_check = headset_check;
+		};
+
 		err = snd_soc_jack_add_gpios(&tegra_machine_mic_jack, 1,
 					     &tegra_machine_mic_jack_gpio);
 		if (err)
@@ -238,6 +256,27 @@ static unsigned int tegra_machine_mclk_rate_12mhz(unsigned int srate)
 	return mclk;
 }
 
+static unsigned int tegra_machine_mclk_rate_6mhz(unsigned int srate)
+{
+	unsigned int mclk;
+
+	switch (srate) {
+	case 64000:
+	case 88200:
+	case 96000:
+		mclk = 128 * srate;
+		break;
+	default:
+		mclk = 256 * srate;
+		break;
+	}
+	/* FIXME: Codec only requires >= 3MHz if OSR==0 */
+	while (mclk < 6000000)
+		mclk *= 2;
+
+	return mclk;
+}
+
 static int tegra_machine_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params)
 {
@@ -865,6 +904,40 @@ static const struct tegra_asoc_data tegra_rt5632_data = {
 	.add_headset_jack = true,
 };
 
+/* RT5631 machine */
+
+SND_SOC_DAILINK_DEFS(rt5631_hifi,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "rt5631-hifi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+static struct snd_soc_dai_link tegra_rt5631_dai = {
+	.name = "RT5631",
+	.stream_name = "RT5631 PCM",
+	.init = tegra_asoc_machine_init,
+	.dai_fmt = SND_SOC_DAIFMT_I2S |
+		   SND_SOC_DAIFMT_NB_NF |
+		   SND_SOC_DAIFMT_CBS_CFS,
+	SND_SOC_DAILINK_REG(rt5631_hifi),
+};
+
+static struct snd_soc_card snd_soc_tegra_rt5631 = {
+	.components = "codec:rt5631",
+	.dai_link = &tegra_rt5631_dai,
+	.num_links = 1,
+	.fully_routed = true,
+};
+
+static const struct tegra_asoc_data tegra_rt5631_data = {
+	.mclk_rate = tegra_machine_mclk_rate_6mhz,
+	.card = &snd_soc_tegra_rt5631,
+	.add_common_dapm_widgets = true,
+	.add_common_controls = true,
+	.add_common_snd_ops = true,
+	.add_mic_jack = true,
+	.add_hp_jack = true,
+};
+
 static const struct of_device_id tegra_machine_of_match[] = {
 	{ .compatible = "nvidia,tegra-audio-trimslice", .data = &tegra_trimslice_data },
 	{ .compatible = "nvidia,tegra-audio-max98090", .data = &tegra_max98090_data },
@@ -874,6 +947,7 @@ static const struct of_device_id tegra_machine_of_match[] = {
 	{ .compatible = "nvidia,tegra-audio-rt5677", .data = &tegra_rt5677_data },
 	{ .compatible = "nvidia,tegra-audio-rt5640", .data = &tegra_rt5640_data },
 	{ .compatible = "nvidia,tegra-audio-alc5632", .data = &tegra_rt5632_data },
+	{ .compatible = "nvidia,tegra-audio-rt5631", .data = &tegra_rt5631_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tegra_machine_of_match);
-- 
2.37.2

