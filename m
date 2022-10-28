Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0083B611939
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiJ1RWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiJ1RWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:22:43 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC0E22B392
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:22:33 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id io19so5393918plb.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBzTxDjyto5LMQswRTp7KBmkgk5W/wTuc9ACHOfSi38=;
        b=JG4Bz2Xt7TpUN2+LJ1cuM3aGSLn5E38fvyTlnpd+HZqOkrNsWQqFfHBJgVet95OwS6
         crQziBTP8KRRFagUdV3nFX/sYlaGGwpBrLhvDsgzADtNGe/mswTcdbOb8Hm8T65tBmg6
         GLSydsw0BnI0Y97y7UjHC+E7D4pR7NMxml6FcUIfnw4SUCxhUAR2U+rX64sxYHyr7+oi
         RWDSqa5SEBX+Ac1hkb9/9xQ7En5Gio0tvG6u329Ow1adVh5L6pg2hf5LGP1gQaqpT42y
         G8bnwgaBo8FdMW5f2poNr3lWbjkQ+FVmDJRd6/oBjmynCxvJKRWsSaVSrFVM8MyX1Gck
         yvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBzTxDjyto5LMQswRTp7KBmkgk5W/wTuc9ACHOfSi38=;
        b=SdTCtY8oEWsjyiHJuJ5JzULfSP6dhnywWfS3KA9CJWCCUOXCBNhPBnh5/RqJCjQ7dI
         TEBvmaKqTkWqA+i09HYoenZcNDF6dP+A0mDapDJQvGLccQ6oisfx89IODMe/sGNdPdr9
         /vtP8mab7y4NmM/Cq9QkSSqehDfziMVxRIqP5vq47Izj3JBuwbj10v0MC2tWnspX9ENE
         moM4lWk4wnDYo3jnx2J9qBvQf63VA4SNoS+KJY2VMh/LNRjhcNUnnr2ssrFnzN6aJHBv
         OE7u2BBio/nIoib3d/lMp5+/v1GIk7vr6bBCXxENjF/I8IsCCzRtrPh13c6UD9VrwDMA
         d82Q==
X-Gm-Message-State: ACrzQf0M/jVu5ZStqf/Q2AQx8C4YBYaq8dlBuLy8GKA1GPp7WcbSPX/A
        s1e+sNNjZLco3tD1+nLcurGSucXpjPZRKQ==
X-Google-Smtp-Source: AMsMyM6DPrBHcZgw0FfDAPonOtDjiUr4/LhdgLvqWh99+d+DYIHGfBg4evRMFrHi+DnkRKoF2rA42A==
X-Received: by 2002:a17:902:da8e:b0:186:9869:adfa with SMTP id j14-20020a170902da8e00b001869869adfamr20040plx.57.1666977752566;
        Fri, 28 Oct 2022 10:22:32 -0700 (PDT)
Received: from localhost.localdomain (118-167-210-30.dynamic-ip.hinet.net. [118.167.210.30])
        by smtp.gmail.com with ESMTPSA id rm10-20020a17090b3eca00b0021282014066sm4604945pjb.9.2022.10.28.10.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 10:22:32 -0700 (PDT)
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        "chunxu . li" <chunxu.li@mediatek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v2 2/2] ASoC: mediatek: mt8186-rt5682: Modify machine driver for two DMICs case
Date:   Sat, 29 Oct 2022 01:22:15 +0800
Message-Id: <20221028172215.1471235-3-ajye_huang@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221028172215.1471235-1-ajye_huang@compal.corp-partner.google.com>
References: <20221028172215.1471235-1-ajye_huang@compal.corp-partner.google.com>
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

Having two DMICs, a front DMIC and a Rear DMIC,
but only host audio input AUX port0 is used for these two Dmics.
A "dmic-gpios" property is used for a mixer control to switch
the dmic signal source between the Front and Rear Dmic.

Refer to this one as an example,
commit 3cfbf07c6d27
("ASoC: qcom: sc7180: Modify machine driver for 2mic")

Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
---
 .../mt8186/mt8186-mt6366-rt1019-rt5682s.c     | 102 +++++++++++++++++-
 1 file changed, 101 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
index 2414c5b77233..b5c25d1247be 100644
--- a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
@@ -7,6 +7,8 @@
 // Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
 //
 
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -39,6 +41,8 @@
 
 struct mt8186_mt6366_rt1019_rt5682s_priv {
 	struct snd_soc_jack headset_jack, hdmi_jack;
+	struct gpio_desc *dmic_sel;
+	int dmic_switch;
 };
 
 /* Headset jack detection DAPM pins */
@@ -68,6 +72,94 @@ static struct snd_soc_codec_conf mt8186_mt6366_rt1019_rt5682s_codec_conf[] = {
 	},
 };
 
+static int dmic_get(struct snd_kcontrol *kcontrol,
+		    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct mtk_soc_card_data *soc_card_data =
+		snd_soc_card_get_drvdata(dapm->card);
+	struct mt8186_mt6366_rt1019_rt5682s_priv *priv = soc_card_data->mach_priv;
+
+	ucontrol->value.integer.value[0] = priv->dmic_switch;
+	return 0;
+}
+
+static int dmic_set(struct snd_kcontrol *kcontrol,
+		    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct mtk_soc_card_data *soc_card_data =
+		snd_soc_card_get_drvdata(dapm->card);
+	struct mt8186_mt6366_rt1019_rt5682s_priv *priv = soc_card_data->mach_priv;
+
+	priv->dmic_switch = ucontrol->value.integer.value[0];
+	if (priv->dmic_sel) {
+		gpiod_set_value(priv->dmic_sel, priv->dmic_switch);
+		dev_info(dapm->card->dev, "dmic_set_value %d\n",
+		priv->dmic_switch);
+	}
+	return 0;
+}
+
+static const char * const dmic_mux_text[] = {
+	"FrontMic",
+	"RearMic",
+};
+
+static SOC_ENUM_SINGLE_DECL(mt8186_dmic_enum,
+			    SND_SOC_NOPM, 0, dmic_mux_text);
+
+static const struct snd_kcontrol_new mt8186_dmic_mux_control =
+	SOC_DAPM_ENUM_EXT("DMIC Select Mux", mt8186_dmic_enum,
+			  dmic_get, dmic_set);
+
+static const struct snd_soc_dapm_widget dmic_widgets[] = {
+	SND_SOC_DAPM_MIC("DMIC", NULL),
+	SND_SOC_DAPM_MUX("Dmic Mux", SND_SOC_NOPM, 0, 0, &mt8186_dmic_mux_control),
+};
+
+static const struct snd_soc_dapm_route dmic_map[] = {
+	/* digital mics */
+	{"Dmic Mux", "FrontMic", "DMIC"},
+	{"Dmic Mux", "RearMic", "DMIC"},
+};
+
+static int primary_codec_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(card);
+	struct mt8186_mt6366_rt1019_rt5682s_priv *priv = soc_card_data->mach_priv;
+	int ret;
+
+	ret = mt8186_mt6366_init(rtd);
+
+	if (ret) {
+		dev_err(card->dev, "mt8186_mt6366_init failed: %d\n", ret);
+		return ret;
+	}
+
+	if (!priv->dmic_sel) {
+		dev_info(card->dev, "dmic_sel is null\n");
+		return ret;
+	}
+
+	ret = snd_soc_dapm_new_controls(&card->dapm, dmic_widgets,
+					ARRAY_SIZE(dmic_widgets));
+	if (ret) {
+		dev_err(card->dev, "DMic widget addition failed: %d\n", ret);
+		/* Don't need to add routes if widget addition failed */
+		return ret;
+	}
+
+	ret = snd_soc_dapm_add_routes(&card->dapm, dmic_map,
+				      ARRAY_SIZE(dmic_map));
+
+	if (ret)
+		dev_err(card->dev, "DMic map addition failed: %d\n", ret);
+
+	return ret;
+}
+
 static int mt8186_rt5682s_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_component *cmpnt_afe =
@@ -775,7 +867,7 @@ static struct snd_soc_dai_link mt8186_mt6366_rt1019_rt5682s_dai_links[] = {
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 		.ignore_suspend = 1,
-		.init = mt8186_mt6366_init,
+		.init = primary_codec_init,
 		SND_SOC_DAILINK_REG(adda),
 	},
 	{
@@ -1015,6 +1107,14 @@ static int mt8186_mt6366_rt1019_rt5682s_dev_probe(struct platform_device *pdev)
 
 	soc_card_data->mach_priv = mach_priv;
 
+	mach_priv->dmic_sel = devm_gpiod_get_optional(&pdev->dev,
+						"dmic", GPIOD_OUT_LOW);
+	if (IS_ERR(mach_priv->dmic_sel)) {
+		dev_err(&pdev->dev, "DMIC gpio failed err=%ld\n",
+			PTR_ERR(mach_priv->dmic_sel));
+		return PTR_ERR(mach_priv->dmic_sel);
+	}
+
 	adsp_node = of_parse_phandle(pdev->dev.of_node, "mediatek,adsp", 0);
 	if (adsp_node) {
 		struct mtk_sof_priv *sof_priv;
-- 
2.25.1

