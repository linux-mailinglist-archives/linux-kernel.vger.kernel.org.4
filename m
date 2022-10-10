Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88565FA3CA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJJSzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiJJSy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:54:58 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137A7193C3;
        Mon, 10 Oct 2022 11:54:55 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id iv17so7348551wmb.4;
        Mon, 10 Oct 2022 11:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L39wW3Ty3Fj+0JLtrs7YSIDPOeSCl+TCC41j4zAWphE=;
        b=C7MpUAIQctHk+ifGp0VzsVKX9t/MFfnULTgkEAuStRRakWYK8Mw1BVeuL7cqSfmaB6
         QhyOsa3zziXnR6IClSM2oJkLcKpZxa9236I/u3+ZKUj1ydS8QmJEYFrfBsEClD7pazBq
         73JjufZlIqQ1gY17ITztN/8b23ZWoIzJ24qUyi0FHef7vb/1GPh2PFObQfDuu2XXu0UF
         bJSDs+YIbONzJ29E/mboAu2amkTRdH17o+6bcKyx47oNpKoZ0YfhHwG4HEr/VCz08EeZ
         TMLrrJzHhGb+XROQl1NLDHGNnlRKjcJ0UCNBTvKZhLzSYShpoZo2NLxZwVaLEBQxk9xG
         mmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L39wW3Ty3Fj+0JLtrs7YSIDPOeSCl+TCC41j4zAWphE=;
        b=6NSzadSqKNxVp5YeB+nQs9RSEBF3w1f9NLBzvGb9EcYzpKX7DXR86rRmPyx6IA3cwy
         Mm9FidYIexV9WUKWXjDPI2tw4N6WGP8kF5WgEO6O0VDkOySLP9QhtrStT/ja9m/JM+OG
         ZrQsSD3c3TGM0a90YcnpxynkKQMyACTCoPcBbCEKa/8GXdvphnJ6WDdFMb561YxZ6OuA
         N3Uxu+Hv+uuItUoYY3ozGZmX6G+dam8ER6KzZh7/ScEO4JIwpVGOsby3SabT8eDxrrvm
         X0zv1VD59UQpyL4yfCKj58I+fBPgPoSzgsNnpzPZufyVakgBG5jjC0qRO9usIVgFqQyt
         FeGA==
X-Gm-Message-State: ACrzQf1FAP4X2OXv1i22Xcy/Wrh7c44+iQqD0tbjcJxJSm8VrhTMT/vO
        N2NHQstGiorKzSDrZ1DL7hw=
X-Google-Smtp-Source: AMsMyM5B6Kt13iU+echB0LPxg4MSMh3BueR2p/vnvZZ3+hx+pr/e4iXGHwklRKON1cMMW5NVrprGfg==
X-Received: by 2002:a05:600c:474c:b0:3bd:e9d7:f793 with SMTP id w12-20020a05600c474c00b003bde9d7f793mr13790967wmo.30.1665428094129;
        Mon, 10 Oct 2022 11:54:54 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-126-34-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.34.126])
        by smtp.gmail.com with ESMTPSA id y2-20020a5d6142000000b00230c9d427f9sm2082272wrt.53.2022.10.10.11.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:54:53 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] ASoC: codecs: jz4725b: use right control for Capture Volume
Date:   Mon, 10 Oct 2022 21:54:20 +0300
Message-Id: <20221010185423.3167208-4-lis8215@gmail.com>
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

Line In Bypass control is used as Master Capture at the moment
this is completely incorrect.

Current control routed to Mixer instead of ADC, thus can't affect
Capture path. ADC control shall be used instead.

ADC volume control parameters are different, so the patch fixes that
as well. Manual says (16.6.3.2 Programmable input attenuation amplifier:
PGATM) that gain varies in range 0dB..22.5dB with 1.5dB step.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 sound/soc/codecs/jz4725b.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index 72549ee2e..4363d898a 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -136,13 +136,16 @@ enum {
 #define REG_CGR3_GO1L_OFFSET		0
 #define REG_CGR3_GO1L_MASK		(0x1f << REG_CGR3_GO1L_OFFSET)
 
+#define REG_CGR10_GIL_OFFSET		0
+#define REG_CGR10_GIR_OFFSET		4
+
 struct jz_icdc {
 	struct regmap *regmap;
 	void __iomem *base;
 	struct clk *clk;
 };
 
-static const SNDRV_CTL_TLVD_DECLARE_DB_LINEAR(jz4725b_line_tlv, -1500, 600);
+static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(jz4725b_adc_tlv,     0, 150, 0);
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(jz4725b_dac_tlv, -2250, 150, 0);
 
 static const struct snd_kcontrol_new jz4725b_codec_controls[] = {
@@ -151,11 +154,11 @@ static const struct snd_kcontrol_new jz4725b_codec_controls[] = {
 		       REG_CGR1_GODL_OFFSET,
 		       REG_CGR1_GODR_OFFSET,
 		       0xf, 1, jz4725b_dac_tlv),
-	SOC_DOUBLE_R_TLV("Master Capture Volume",
-			 JZ4725B_CODEC_REG_CGR3,
-			 JZ4725B_CODEC_REG_CGR2,
-			 REG_CGR2_GO1R_OFFSET,
-			 0x1f, 1, jz4725b_line_tlv),
+	SOC_DOUBLE_TLV("Master Capture Volume",
+		       JZ4725B_CODEC_REG_CGR10,
+		       REG_CGR10_GIL_OFFSET,
+		       REG_CGR10_GIR_OFFSET,
+		       0xf, 0, jz4725b_adc_tlv),
 
 	SOC_SINGLE("Master Playback Switch", JZ4725B_CODEC_REG_CR1,
 		   REG_CR1_DAC_MUTE_OFFSET, 1, 1),
-- 
2.36.1

