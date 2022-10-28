Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B096115D1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiJ1P1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiJ1P04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:26:56 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B091CF56A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:26:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id f27so13769044eje.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLsw+iN8jpJl9FHuzYsNNqJNfmeMGSrcPtNG/wbe8TE=;
        b=EuqLHIacnhZIvU2B46I6TgVFg7XuOAx4Nvgd4xed1aECAOsYi8YmKNhhzxZzDwE0zP
         zHcoIa7ttY6R0Hae+7JQ59m21JEFYFNadu7wUJSW2S6qAbe8qFlHan6TYxl+KiHTeC7l
         z/yIQjFKeSn38ut/Kvd1aM8redbgqqGnYscyt8fDc8XvQUZ2fRNO30AjWAH78blaeiuL
         ck3u9aDzCZd9jBoct8NexLa0AbYyXX+oHjMNtx70tQD+70XE/VagDl92yY2DFXTgW+O1
         pkq2CviPYMfm9yf2Rp65/uVHMI6BGKYtMCQDAQ17bAk5LngNeQeVP8ZJ5gvD70qBrEVB
         an2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLsw+iN8jpJl9FHuzYsNNqJNfmeMGSrcPtNG/wbe8TE=;
        b=dSNSWH3A1Sfi5eddVWHoi8soSymgeD6sAQ11Qksy51Sa/+4hLVBeFiOVm/1y8GijJR
         0BLbP8Zk7GeNtcpiWZJLdNH+fhp861XNGl0UTqt1QOHwqgQaUxxsmdPAmFv9unXqK6Tq
         vp+Nrz+hPNEPV7Zmb9pl5UYYPTN8UuI/JZr5lGC+v0P6uzWoVBD1Yo6yWeIa6xLy38NL
         /Ec5CaFKp3OxeArqOSuHmNrQYIw5eKya3/aIzjjtuTpUEyQCN1G1BLh7H7KDRiXrpQtU
         uvEnDu3mnq4G/pUAkwoG0XGcx60ip7Anv5UBS+F+LCeAYDWo1fLCzImZkWAlm0vBJOJi
         4/Fw==
X-Gm-Message-State: ACrzQf295QscWw/z7aeOMVMF9Zitxocj2XlOgzc/Vx+KYimFxgPzEXhS
        fxAD9aQJ5wwjppc8x++qt0oLRA==
X-Google-Smtp-Source: AMsMyM5YKp142ssImrqyoaxRTpa8mAxOIIlTKUWb2Y2mcX9lTDP2Y/CP2TRhAuarq2nTy03foaT+/A==
X-Received: by 2002:a17:907:2cd9:b0:78d:9f4c:9cff with SMTP id hg25-20020a1709072cd900b0078d9f4c9cffmr47298639ejc.345.1666970814476;
        Fri, 28 Oct 2022 08:26:54 -0700 (PDT)
Received: from dtpc.zanders.be (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906319100b00730df07629fsm2349839ejy.174.2022.10.28.08.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:26:54 -0700 (PDT)
From:   Maarten Zanders <maarten.zanders@mind.be>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Maarten Zanders <maarten.zanders@mind.be>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ASoC: adau1372: correct PGA enable & mute bit
Date:   Fri, 28 Oct 2022 17:26:25 +0200
Message-Id: <20221028152626.109603-4-maarten.zanders@mind.be>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028152626.109603-1-maarten.zanders@mind.be>
References: <20221028152626.109603-1-maarten.zanders@mind.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DAPM control for PGAx uses the PGA mute bit for
power management. This bit is active high but is set to
non-inverted (ie when powering, it will mute).
The ALSA control "PGA x Capture Switch" uses the active
high PGA_ENx bit, but is set to inverted. So when
enabling this switch, the PGA gets disabled.

To correct the behaviour, invert both these bits.

Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
---
 sound/soc/codecs/adau1372.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/adau1372.c b/sound/soc/codecs/adau1372.c
index 6b35981c8777..c5e0f10e6982 100644
--- a/sound/soc/codecs/adau1372.c
+++ b/sound/soc/codecs/adau1372.c
@@ -206,10 +206,10 @@ static const struct snd_kcontrol_new adau1372_controls[] = {
 		       2, 1, 0, adau1372_pga_boost_tlv),
 	SOC_SINGLE_TLV("PGA 3 Boost Capture Volume", ADAU1372_REG_PGA_BOOST,
 		       3, 1, 0, adau1372_pga_boost_tlv),
-	SOC_SINGLE("PGA 0 Capture Switch", ADAU1372_REG_PGA_CTRL(0), 7, 1, 1),
-	SOC_SINGLE("PGA 1 Capture Switch", ADAU1372_REG_PGA_CTRL(1), 7, 1, 1),
-	SOC_SINGLE("PGA 2 Capture Switch", ADAU1372_REG_PGA_CTRL(2), 7, 1, 1),
-	SOC_SINGLE("PGA 3 Capture Switch", ADAU1372_REG_PGA_CTRL(3), 7, 1, 1),
+	SOC_SINGLE("PGA 0 Capture Switch", ADAU1372_REG_PGA_CTRL(0), 7, 1, 0),
+	SOC_SINGLE("PGA 1 Capture Switch", ADAU1372_REG_PGA_CTRL(1), 7, 1, 0),
+	SOC_SINGLE("PGA 2 Capture Switch", ADAU1372_REG_PGA_CTRL(2), 7, 1, 0),
+	SOC_SINGLE("PGA 3 Capture Switch", ADAU1372_REG_PGA_CTRL(3), 7, 1, 0),
 
 	SOC_SINGLE_TLV("DAC 0 Playback Volume", ADAU1372_REG_DAC_VOL(0),
 		       0, 0xff, 1, adau1372_digital_tlv),
@@ -369,10 +369,10 @@ static const struct snd_soc_dapm_widget adau1372_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("MICBIAS0", ADAU1372_REG_MICBIAS, 4, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("MICBIAS1", ADAU1372_REG_MICBIAS, 5, 0, NULL, 0),
 
-	SND_SOC_DAPM_PGA("PGA0", ADAU1372_REG_PGA_CTRL(0), 6, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("PGA1", ADAU1372_REG_PGA_CTRL(1), 6, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("PGA2", ADAU1372_REG_PGA_CTRL(2), 6, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("PGA3", ADAU1372_REG_PGA_CTRL(3), 6, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("PGA0", ADAU1372_REG_PGA_CTRL(0), 6, 1, NULL, 0),
+	SND_SOC_DAPM_PGA("PGA1", ADAU1372_REG_PGA_CTRL(1), 6, 1, NULL, 0),
+	SND_SOC_DAPM_PGA("PGA2", ADAU1372_REG_PGA_CTRL(2), 6, 1, NULL, 0),
+	SND_SOC_DAPM_PGA("PGA3", ADAU1372_REG_PGA_CTRL(3), 6, 1, NULL, 0),
 	SND_SOC_DAPM_ADC("ADC0", NULL, ADAU1372_REG_ADC_CTRL2, 0, 0),
 	SND_SOC_DAPM_ADC("ADC1", NULL, ADAU1372_REG_ADC_CTRL2, 1, 0),
 	SND_SOC_DAPM_ADC("ADC2", NULL, ADAU1372_REG_ADC_CTRL3, 0, 0),
-- 
2.37.3

