Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73D55FFF9A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 15:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJPN2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 09:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJPN1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 09:27:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A62B11828;
        Sun, 16 Oct 2022 06:27:51 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id b2so19604728eja.6;
        Sun, 16 Oct 2022 06:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZA0KpJu28BqLozBBPuBVAqokT3cgceSjy1up9PTHuYA=;
        b=d0F1c3o0/2IEmFhVt8sfandi2JGjbMImQOINE1wpmbolCoo4w8vESRTGwbFuJV6AT6
         8g9gz+S9ghdI+OxN6um0jK6bEClWqsHuYTIY/ACG69nrQdne7FtFoiD9zFHUqNQEaFET
         DHSUjKLf5t9dvWjCPCcLSRXUn15x0BVMOHEkFEab/kZdaQVT0jZNVD08WpCKveZSfwd0
         KrWg1qhLMHptUJc9FfQVq9hazG4ojzqqj6t7eq27vQNic0hvIPMEkJC3N3Tos7X8KG6H
         Po909OSaYnkM64TwwkjY2vJ7rFaYMFA3fhO0qyWXTfLud2EMuSOHEeiHL+PjdNcC9e7P
         ya8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZA0KpJu28BqLozBBPuBVAqokT3cgceSjy1up9PTHuYA=;
        b=aG/NbpKZLcEmcagVJJYkc2qp3hifh/SSrphN0Da61waBgXtdj4Bj4nmuv2fz3tlJbg
         S/QY4aIUmf2OSZa9+9IxU6f4uj7wIK5SEYhxtAT7jeJJSQX+PKsPOury2w83xZmd0P0o
         pLCajLHpNREEU/Cg+X+mK1Uc6YR8y+AUoDMiahhXIjjvfc/nsG0v3jdamHB6KoR/f2w9
         pLLawLTMEn7qR47xkzIrJ9AwYlYsgUko8ehzVgsyBeDrIUTK1fFm3FskBQG7NIVqDb6C
         hJ2zj1E+Ukhjha1grTnP7YY64DUX+Q9U7nO62inixh0+X8EkE32raekecOZ4Ry0hkT82
         uEBA==
X-Gm-Message-State: ACrzQf0zC8WmrffvH2GmF30b4IBMfa1ZRfJwlu1rT5SY1MZxDfwm9ZZM
        OLhZjGeMNKkx9Zdh3A4bIFdFuOa58939zA==
X-Google-Smtp-Source: AMsMyM7vJ5B+t/BN2zg5D8USxC98nHmQpUv1w5LlTWAQwcXZawwS7Mn8bvBfRjAvNKqrFrmifJChgQ==
X-Received: by 2002:a17:906:591:b0:73d:c3ef:84ae with SMTP id 17-20020a170906059100b0073dc3ef84aemr5202358ejn.155.1665926870045;
        Sun, 16 Oct 2022 06:27:50 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-39-7-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.7.39])
        by smtp.gmail.com with ESMTPSA id y5-20020aa7ce85000000b0045c72bba0bfsm5572057edv.4.2022.10.16.06.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 06:27:49 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] ASoC: codecs: jz4725b: fix capture selector naming
Date:   Sun, 16 Oct 2022 16:26:45 +0300
Message-Id: <20221016132648.3011729-5-lis8215@gmail.com>
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

At the moment Capture source selector appears on Playback
tab in the alsamixer and has a senseless name.

Let's fix that.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 sound/soc/codecs/jz4725b.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index 4363d898a..d57c2c6a3 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -183,7 +183,7 @@ static SOC_VALUE_ENUM_SINGLE_DECL(jz4725b_codec_adc_src_enum,
 				  jz4725b_codec_adc_src_texts,
 				  jz4725b_codec_adc_src_values);
 static const struct snd_kcontrol_new jz4725b_codec_adc_src_ctrl =
-			SOC_DAPM_ENUM("Route", jz4725b_codec_adc_src_enum);
+	SOC_DAPM_ENUM("ADC Source Capture Route", jz4725b_codec_adc_src_enum);
 
 static const struct snd_kcontrol_new jz4725b_codec_mixer_controls[] = {
 	SOC_DAPM_SINGLE("Line In Bypass", JZ4725B_CODEC_REG_CR1,
@@ -228,7 +228,7 @@ static const struct snd_soc_dapm_widget jz4725b_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_ADC("ADC", "Capture",
 			 JZ4725B_CODEC_REG_PMR1, REG_PMR1_SB_ADC_OFFSET, 1),
 
-	SND_SOC_DAPM_MUX("ADC Source", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_MUX("ADC Source Capture Route", SND_SOC_NOPM, 0, 0,
 			 &jz4725b_codec_adc_src_ctrl),
 
 	/* Mixer */
@@ -287,11 +287,11 @@ static const struct snd_soc_dapm_route jz4725b_codec_dapm_routes[] = {
 	{"Mixer", NULL, "DAC to Mixer"},
 
 	{"Mixer to ADC", NULL, "Mixer"},
-	{"ADC Source", "Mixer", "Mixer to ADC"},
-	{"ADC Source", "Line In", "Line In"},
-	{"ADC Source", "Mic 1", "Mic 1"},
-	{"ADC Source", "Mic 2", "Mic 2"},
-	{"ADC", NULL, "ADC Source"},
+	{"ADC Source Capture Route", "Mixer", "Mixer to ADC"},
+	{"ADC Sourc Capture Routee", "Line In", "Line In"},
+	{"ADC Source Capture Route", "Mic 1", "Mic 1"},
+	{"ADC Source Capture Route", "Mic 2", "Mic 2"},
+	{"ADC", NULL, "ADC Source Capture Route"},
 
 	{"Out Stage", NULL, "Mixer"},
 	{"HP Out", NULL, "Out Stage"},
-- 
2.36.1

