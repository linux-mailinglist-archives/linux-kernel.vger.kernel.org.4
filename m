Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9CB5FFF9D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 15:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJPN2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 09:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJPN2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 09:28:05 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875BB17898;
        Sun, 16 Oct 2022 06:27:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y14so19563028ejd.9;
        Sun, 16 Oct 2022 06:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+d4zYZ2OcrExgu67AwFyCEVw5ZLbwcKQnaxEzIUbSA=;
        b=mMrjWmGOWPj+C9rRMvyoO46WUEnlfRtEdLgPUR+JGPnHwMPR8SDTdC/OMHqnsvlbsO
         uAwIB6Dii987acRt1fXMF5i0TMU353WzTrDYcnBf1Qy61/5fTgyC8ZS8q1Hmwna9zEgw
         nSx2+QuChjF4E/rqYhj+nfwQ4DnUPgSrjHvw5J0li9Xq4Pk8Ki+MDQU4fkddJfQQBRGN
         sMj6I/x54DLEW1hPsx03ZHWgDNs1SMxzWIZ7iOc/RFOv0ZhVw3EdwsHqdVzXP+4Hh6Kx
         Ikr4iJKaEMbWgE/CeGhUWMVACdvtHreTDJOj+9pdQ5Uq29sHodsIf3dVM08LZqBjQtQk
         ho6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+d4zYZ2OcrExgu67AwFyCEVw5ZLbwcKQnaxEzIUbSA=;
        b=nRDj5lvZWKQnzdJj79gBwcgVxXt/l2/ql7x5NsA6aL3j7WYHvmdN9bU+QDHlochlSF
         +R/hXj/EpaRtR2HGaBhSl7tFQF90h535Oj7VIFlB6z6WZWDTMpDp9nPM3l1jcR+4jSmz
         EXRa3fiEix/N7JezGxvjhx3WF6D+jh2ZMJv70h7sLX2qMKkgXJTtkwvQh7nVFNe0nAD0
         Gsd9Xd0w3Gg+jZYxPr7lHYA+GAytoFLvvxdzYiv6yVuHdgEslhIyKW8YgdMr6+e96GaA
         aw4nFVJ+MgO7uUPuM2yrhwPBLY/pNgpwFTMuWceOBT0r/n0Arljx97sPPO2R3+VtlgEn
         jMwg==
X-Gm-Message-State: ACrzQf0CtGMSjEpukQKBZ5A6qu+OCbOxg+LM23iUBP+5hm3J+MGfEy7n
        UvARD1Jjyly0ILpqnfufuf4=
X-Google-Smtp-Source: AMsMyM5dMNtbDLm6MEm7cnMuWNaK+QO5ZZ+c9vzpWV5tcd39S+YzfLjNrzXGd0ed3T23TkI0TChLQQ==
X-Received: by 2002:a17:906:8479:b0:78d:cf17:2d70 with SMTP id hx25-20020a170906847900b0078dcf172d70mr5129252ejc.319.1665926874773;
        Sun, 16 Oct 2022 06:27:54 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-39-7-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.7.39])
        by smtp.gmail.com with ESMTPSA id y5-20020aa7ce85000000b0045c72bba0bfsm5572057edv.4.2022.10.16.06.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 06:27:54 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/7] ASoC: codecs: jz4725b: add missed Mixer inputs
Date:   Sun, 16 Oct 2022 16:26:47 +0300
Message-Id: <20221016132648.3011729-7-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221016132648.3011729-1-lis8215@gmail.com>
References: <20221016132648.3011729-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index c39398e0a..52b2bb95b 100644
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

