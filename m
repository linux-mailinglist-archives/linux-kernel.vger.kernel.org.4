Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D6B5FA3CD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiJJSzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiJJSzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:55:02 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C139A1FCEA;
        Mon, 10 Oct 2022 11:55:01 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bu30so18305366wrb.8;
        Mon, 10 Oct 2022 11:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0HKAhNdOKF1crgdkmfV9uw0DtKONIzdjDGfK2eaD40=;
        b=g6GYJi+i1RYgpcsc2FaPpiuxZz2OwbN4bkiNrA3qiCo061dhszzksEbCyV8xT2iRXg
         V0JoehCp9TO8iUWzX/yS1peMDKGQ++SyIFfYyZj7rvwD8afHP/2DSSwo9b1VIg8KxQqu
         MXzKq14gqz+zmaOouTfag3SRrcKDZiND9OfgnTRammxj6vrm6bg+pxT4UY+ZaCTV1J7a
         Bx1bgPe1cXG3dgK+hPOj9caNLrvWT3V3JnIGv9BmTBngK+zQLAYisVE7Fr2gskPH0sOh
         xvRwOoPkrYNl4oWcWjSQf85y+WGi1mLAaU76Tv/2oXNfX+QNP8wOtzooRkvKlkAa1hyJ
         0DHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0HKAhNdOKF1crgdkmfV9uw0DtKONIzdjDGfK2eaD40=;
        b=D37muxHsAMyXFyMUg2AqLIVttn8eptPBrUP4rSo9gEME7Wwob9gy1zUK7djVDb1O4c
         2MgKiAQviZAmnUoAWxbTmyiHkK3Hf31c5JvTzJshPe/IZZVWhgupavjIyc14lDb7E0Vv
         mTcHW3fphKjg7SjgasZAvtgI7CfxjwyFit8n178PNcrk5Jmwc0k381uagunA0Cc2wsD/
         xgJf2vHP/lKG4dNyWRASTEvVz5Sz6lfPSlxsFd6G6co2Suxo4qp4xocIqrcXqb3HqQBZ
         xtPi6AFaGh8/m8pxNGzI4VufDuklX1XJS6/OkW+PIJmi3GpDET4F4UtCtPktL+B7HzFc
         dK0A==
X-Gm-Message-State: ACrzQf1Meoj+isPMS+rrymvjaZvpokfRZ3wIPGoD+AOsWpJKTaiGIalB
        NhGhrSn0/AmUHiybfum/EfUd1eZjS69+Og==
X-Google-Smtp-Source: AMsMyM7M6A5MM0GdcXezHZYlOJYNlypNddtCR4gt9oyL9mZKAIqhFKcbNCwVzt0j7ZDFVe7Wky4s3g==
X-Received: by 2002:a5d:64af:0:b0:230:1aca:634 with SMTP id m15-20020a5d64af000000b002301aca0634mr5920199wrp.74.1665428099994;
        Mon, 10 Oct 2022 11:54:59 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-126-34-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.34.126])
        by smtp.gmail.com with ESMTPSA id y2-20020a5d6142000000b00230c9d427f9sm2082272wrt.53.2022.10.10.11.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:54:59 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] ASoC: codecs: jz4725b: add missed Mixer inputs
Date:   Mon, 10 Oct 2022 21:54:23 +0300
Message-Id: <20221010185423.3167208-7-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221010185423.3167208-1-lis8215@gmail.com>
References: <Y0P/u4pJT8rup8Za@sirena.org.uk>
 <20221010185423.3167208-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Mixer couples analog input from 4 sources (DAC, Line In, Mic 1,
 Mic 2) each input has its own gain & mute controls.

At the moment only DAC is implemented fully and Line In path can be
switched on/off. The patch implements Mic 1 and Mic 2 paths and fully
implements Line In path.

Manual states that these controls (16.6.3.3 Programmable attenuation:
GOi) gain varies from -22.5dB to +6.0dB with 1.5dB step. Also there's
extra values below the minimum, but they behave the same as the minimum
value.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 sound/soc/codecs/jz4725b.c | 42 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index 6614c5e37..22763bb1e 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -136,6 +136,18 @@ enum {
 #define REG_CGR3_GO1L_OFFSET		0
 #define REG_CGR3_GO1L_MASK		(0x1f << REG_CGR3_GO1L_OFFSET)
 
+#define REG_CGR4_GO2R_OFFSET		0
+#define REG_CGR4_GO2R_MASK		(0x1f << REG_CGR4_GO2R_OFFSET)
+
+#define REG_CGR5_GO2L_OFFSET		0
+#define REG_CGR5_GO2L_MASK		(0x1f << REG_CGR5_GO2L_OFFSET)
+
+#define REG_CGR6_GO3R_OFFSET		0
+#define REG_CGR6_GO3R_MASK		(0x1f << REG_CGR6_GO3R_OFFSET)
+
+#define REG_CGR7_GO3L_OFFSET		0
+#define REG_CGR7_GO3L_MASK		(0x1f << REG_CGR7_GO3L_OFFSET)
+
 #define REG_CGR8_GOR_OFFSET		0
 #define REG_CGR8_GOR_MASK		(0x1f << REG_CGR8_GOR_OFFSET)
 
@@ -153,6 +165,11 @@ struct jz_icdc {
 
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(jz4725b_adc_tlv,     0, 150, 0);
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(jz4725b_dac_tlv, -2250, 150, 0);
+static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(jz4725b_mix_tlv,
+	 0, 11, TLV_DB_SCALE_ITEM(-2250,   0, 0),
+	12, 31, TLV_DB_SCALE_ITEM(-2250, 150, 0),
+);
+
 static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(jz4725b_out_tlv,
 	 0, 11, TLV_DB_SCALE_ITEM(-3350, 200, 0),
 	12, 23, TLV_DB_SCALE_ITEM(-1050, 100, 0),
@@ -170,6 +187,21 @@ static const struct snd_kcontrol_new jz4725b_codec_controls[] = {
 		       REG_CGR10_GIL_OFFSET,
 		       REG_CGR10_GIR_OFFSET,
 		       0xf, 0, jz4725b_adc_tlv),
+	SOC_DOUBLE_R_TLV("Mixer Line In Bypass Playback Volume",
+			 JZ4725B_CODEC_REG_CGR3,
+			 JZ4725B_CODEC_REG_CGR2,
+			 REG_CGR2_GO1R_OFFSET,
+			 0x1f, 1, jz4725b_mix_tlv),
+	SOC_DOUBLE_R_TLV("Mixer Mic 1 Bypass Playback Volume",
+			 JZ4725B_CODEC_REG_CGR5,
+			 JZ4725B_CODEC_REG_CGR4,
+			 REG_CGR4_GO2R_OFFSET,
+			 0x1f, 1, jz4725b_mix_tlv),
+	SOC_DOUBLE_R_TLV("Mixer Mic 2 Bypass Playback Volume",
+			 JZ4725B_CODEC_REG_CGR7,
+			 JZ4725B_CODEC_REG_CGR6,
+			 REG_CGR6_GO3R_OFFSET,
+			 0x1f, 1, jz4725b_mix_tlv),
 
 	SOC_DOUBLE_R_TLV("Master Playback Volume",
 			 JZ4725B_CODEC_REG_CGR9,
@@ -203,8 +235,12 @@ static const struct snd_kcontrol_new jz4725b_codec_adc_src_ctrl =
 	SOC_DAPM_ENUM("ADC Source Capture Route", jz4725b_codec_adc_src_enum);
 
 static const struct snd_kcontrol_new jz4725b_codec_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Line In Bypass", JZ4725B_CODEC_REG_CR1,
+	SOC_DAPM_SINGLE("Line In Bypass Playback Switch", JZ4725B_CODEC_REG_CR1,
 			REG_CR1_BYPASS_OFFSET, 1, 0),
+	SOC_DAPM_SINGLE("Mic 1 Bypass Playback Switch", JZ4725B_CODEC_REG_CR3,
+			REG_CR3_SIDETONE1_OFFSET, 1, 0),
+	SOC_DAPM_SINGLE("Mic 2 Bypass Playback Switch", JZ4725B_CODEC_REG_CR3,
+			REG_CR3_SIDETONE2_OFFSET, 1, 0),
 };
 
 static int jz4725b_out_stage_enable(struct snd_soc_dapm_widget *w,
@@ -299,7 +335,9 @@ static const struct snd_soc_dapm_route jz4725b_codec_dapm_routes[] = {
 	{"Line In", NULL, "LLINEIN"},
 	{"Line In", NULL, "RLINEIN"},
 
-	{"Mixer", "Line In Bypass", "Line In"},
+	{"Mixer", "Mic 1 Bypass Playback Switch", "Mic 1"},
+	{"Mixer", "Mic 2 Bypass Playback Switch", "Mic 2"},
+	{"Mixer", "Line In Bypass Playback Switch", "Line In"},
 	{"DAC to Mixer", NULL, "DAC"},
 	{"Mixer", NULL, "DAC to Mixer"},
 
-- 
2.36.1

