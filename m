Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18775FFF99
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 15:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJPN2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 09:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiJPN1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 09:27:50 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12FC2AC4;
        Sun, 16 Oct 2022 06:27:49 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ot12so19656393ejb.1;
        Sun, 16 Oct 2022 06:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L39wW3Ty3Fj+0JLtrs7YSIDPOeSCl+TCC41j4zAWphE=;
        b=UbYHy/nX1Hbr3bCvUqAAtrbIHZ3vBejD2D7anTDSYRhHg8ljKzyf5t1oyeRScnEwYx
         5U/lzKQ7sZdR4ZF1fWMWL1iraSVU5nUKfyEiGYP7dCXc6ywqFWFzhJxwjuzSvqVLY4Kn
         3choB2XDXwSuWZthpBlk6N8xkz+iRqkS1PkKyNT6niCYPUF7kCuGKX9QFMfKCymlwm6f
         vM8e6NowPsXsujD1xhH3avFQQwzIQftlgKkYQg3MTz1uw80N7Ux0WDgm89aKuY0mJcpD
         PgkbAvm1ClCUUxX9NZrrkX5cZiPmNOQJkkzTdA9bRIl1xDw8wBkzZgAHiSx6A/qkxUmS
         WdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L39wW3Ty3Fj+0JLtrs7YSIDPOeSCl+TCC41j4zAWphE=;
        b=We+IvE9UZMfvKp1GE4FiYvKdCnSVfUnQdygGzL+0OnLmn1I3l4qz/X9D1cqvQkHDpS
         yarRg1uawA6vl4AUisSGwGPFwqm8RW+JR2kJCZLSXrFZ/BN5riu6YHO6Zkm3QnqxzU10
         X1Vl38FxsdKVr9OoM/WiM4imS9my/44hv/rXDlR3xzX9Kgkc30AbT+ndq4cL2jOsu70a
         a7MzjaBkGg+qzB9r020jYOxV0tsof3f/V2d++d39bRt/daIn502pUbLOYgI5+FzQopFv
         MwXVR52LMsUexdb0YhNiU8IQwOnevGYFqUtIqG08aIMCYFC4xqZEeIKc9ricXQIW4FLX
         nj9A==
X-Gm-Message-State: ACrzQf1vWxtZE8DAgdH0rRXlcE08OzSFH6E5SrODizE2pBtLbklfg2Ij
        Lgo5N9vzjauBEu88mMU4yUQ=
X-Google-Smtp-Source: AMsMyM55uI+TT2fahU0qyT+j83wICSjPO032S1YhR3CTKQ8pF0af2fSqEafbJgV6z99v5Q//2kDhbQ==
X-Received: by 2002:a17:907:845:b0:731:2f6c:6dbd with SMTP id ww5-20020a170907084500b007312f6c6dbdmr5069253ejb.551.1665926868234;
        Sun, 16 Oct 2022 06:27:48 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-39-7-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.7.39])
        by smtp.gmail.com with ESMTPSA id y5-20020aa7ce85000000b0045c72bba0bfsm5572057edv.4.2022.10.16.06.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 06:27:47 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] ASoC: codecs: jz4725b: use right control for Capture Volume
Date:   Sun, 16 Oct 2022 16:26:44 +0300
Message-Id: <20221016132648.3011729-4-lis8215@gmail.com>
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

