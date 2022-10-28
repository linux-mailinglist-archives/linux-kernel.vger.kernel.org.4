Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6263C610E66
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiJ1KZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiJ1KZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:25:17 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3817D3C8F7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:25:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso9408153pjg.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUsj9+u75ZiURBRDbzjBcZDwYbW7xC+xuux1Bvrvp1o=;
        b=m/UP4fu4PKx43aYhlz2Rp68oxaguB66SWgjhBVhkhTHKdqmEwNzyWVWP/JjKj9e9MR
         Y9NbqLdrh6vosMJkx4/BbPjlDdoTGOSbLf9YlskUdi2tRYgX1g1CvzAuVyoCi0VkzXRC
         YiJikNgpdC5EnHKpbrhHNkk119Nj3DFsGsE6w+TjxTdDz+6HVs67iFL9qP8jyjb/AORE
         f3P+EGHaIc/diGpmmYEz4CycVYZSvEao+8SdiHCuSm9vC6VKyCeNUY/bjUA93jagvckf
         3An73/Dpsb6QM8WHQVPgptVGjG3555ilgw6nCH2As9aTzF5lO+bKWqXlNOhd+iiecq/a
         GB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUsj9+u75ZiURBRDbzjBcZDwYbW7xC+xuux1Bvrvp1o=;
        b=ABevo+c5vf3ygOnJjrC2CL3b/QdP6sNQfcKTL8Q/iDBFBbgYo+gzMp5qhBZVPH7xlr
         SDodKBlnvnNvapDbxqgROU44WJKJSeEuphJnfNspOgH6yKuXMF+fiU/xi99H2LG2QLLF
         vrWdnf8Z9/f97Mylglj6kDFreCTf1MOjx93ATSF3ZLIApQyyfmYwD0UTESnlAQRNNqyv
         ewWwX1pX5Mcio0kri3hse2l9NuCF99sbUKw7z4XljDOcj7lxyeugsiuiDdidWLS3+B6r
         SwAYC3iXi5hrg2RVmCPOenOYkQmrDTcAgpMg8AJLj5sQUPXPmzh/8WiiBkbFAms2QTCV
         fM4w==
X-Gm-Message-State: ACrzQf0mMVr+6YkE5FhWWTEH1V9O3lxNSizAsBWFGO5yoQ+zJu1hKIo1
        bA3C8usF2Cbj+aj30wbbbuA0wWU+VvNdwg==
X-Google-Smtp-Source: AMsMyM5PF+mfGpOT7qE4MUpscnGJjWoxwCDcOj+0J2CfXJVc05btTeWq4lG3ZKUCtFYAksnUSFF5Nw==
X-Received: by 2002:a17:902:bd8e:b0:178:25ab:56cc with SMTP id q14-20020a170902bd8e00b0017825ab56ccmr53514796pls.86.1666952715118;
        Fri, 28 Oct 2022 03:25:15 -0700 (PDT)
Received: from localhost.localdomain (118-167-210-30.dynamic-ip.hinet.net. [118.167.210.30])
        by smtp.gmail.com with ESMTPSA id o1-20020aa79781000000b0056b6a22d6c9sm2565236pfp.212.2022.10.28.03.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 03:25:14 -0700 (PDT)
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, robh@kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        angelogioacchino.delregno@collabora.corp-partner.google.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v1 2/2] ASoC: dmic: Add optional dmic selection
Date:   Fri, 28 Oct 2022 18:24:50 +0800
Message-Id: <20221028102450.1161382-3-ajye_huang@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221028102450.1161382-1-ajye_huang@compal.corp-partner.google.com>
References: <20221028102450.1161382-1-ajye_huang@compal.corp-partner.google.com>
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

Having two DMICs, a front DMIC and a rear DMIC,
but only host audio input AUX port0 is used for these two Dmics.
A "dmic_sel-gpios" property is used for a mixer control to switch
the dmic signal source between the Front and Rear Dmic.

usage: amixer -c0 cset name='Dmic Mux' 'FrontMic'
usage: amixer -c0 cset name='Dmic Mux' 'RearMic'

Refer to this one as an example,
commit 3cfbf07c6d27
("ASoC: qcom: sc7180: Modify machine driver for 2mic")

Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
---
 sound/soc/codecs/dmic.c | 52 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index 4fd6f97e5a49..5c56fbcdb3e6 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -28,8 +28,50 @@ struct dmic {
 	int wakeup_delay;
 	/* Delay after DMIC mode switch */
 	int modeswitch_delay;
+	struct gpio_desc *dmic_sel;
+	int dmic_switch;
 };
 
+static int dmic_sel_get(struct snd_kcontrol *kcontrol,
+		    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
+	struct dmic *dmic = snd_soc_component_get_drvdata(component);
+
+	ucontrol->value.integer.value[0] = dmic->dmic_switch;
+	return 0;
+}
+
+static int dmic_sel_set(struct snd_kcontrol *kcontrol,
+		    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
+	struct dmic *dmic = snd_soc_component_get_drvdata(component);
+
+	dmic->dmic_switch = ucontrol->value.integer.value[0];
+	if (dmic->dmic_sel) {
+		gpiod_set_value(dmic->dmic_sel, dmic->dmic_switch);
+		dev_info(dapm->dev, "%s value %d\n", __func__, dmic->dmic_switch);
+	} else
+		dev_info(dapm->dev, "%s without dmic_sel-gpios\n", __func__);
+
+	return 0;
+}
+
+static const char * const dmic_mux_text[] = {
+	"FrontMic",
+	"RearMic",
+};
+
+static SOC_ENUM_SINGLE_DECL(dmic_enum,
+			    SND_SOC_NOPM, 0, dmic_mux_text);
+
+static const struct snd_kcontrol_new dmic_mux_control =
+	SOC_DAPM_ENUM_EXT("DMIC Select Mux", dmic_enum,
+			  dmic_sel_get, dmic_sel_set);
+
 static int dmic_daiops_trigger(struct snd_pcm_substream *substream,
 			       int cmd, struct snd_soc_dai *dai)
 {
@@ -115,6 +157,11 @@ static int dmic_component_probe(struct snd_soc_component *component)
 	if (dmic->modeswitch_delay > MAX_MODESWITCH_DELAY)
 		dmic->modeswitch_delay = MAX_MODESWITCH_DELAY;
 
+	dmic->dmic_sel = devm_gpiod_get_optional(component->dev,
+						"dmic_sel", GPIOD_OUT_LOW);
+	if (IS_ERR(dmic->dmic_sel))
+		return PTR_ERR(dmic->dmic_sel);
+
 	snd_soc_component_set_drvdata(component, dmic);
 
 	return 0;
@@ -125,10 +172,15 @@ static const struct snd_soc_dapm_widget dmic_dapm_widgets[] = {
 			       SND_SOC_NOPM, 0, 0, dmic_aif_event,
 			       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_INPUT("DMic"),
+	SND_SOC_DAPM_MIC("DMIC", NULL),
+	SND_SOC_DAPM_MUX("Dmic Mux", SND_SOC_NOPM, 0, 0, &dmic_mux_control),
 };
 
 static const struct snd_soc_dapm_route intercon[] = {
 	{"DMIC AIF", NULL, "DMic"},
+	/* digital mics */
+	{"Dmic Mux", "FrontMic", "DMIC"},
+	{"Dmic Mux", "RearMic", "DMIC"},
 };
 
 static const struct snd_soc_component_driver soc_dmic = {
-- 
2.25.1

