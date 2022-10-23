Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2330F6093F5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 16:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiJWOeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 10:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiJWOdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 10:33:46 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF98625F9;
        Sun, 23 Oct 2022 07:33:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id jb18so1680273wmb.4;
        Sun, 23 Oct 2022 07:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iboSBornxxq5IGUmNwjcHJMSvR6JYlZCJH/3I/odZvU=;
        b=a0DWRLL2JY+JO6dqzjcB2ClTvgkWANjY32AL4ej94RFeRL2DR4yLJU5Ipl7ijWc5+Q
         HvylTzAJXnREsUmtZnWTse1fmSC3mej7u2CcEQMxQ25Dr9o7Tlar6iRmG4G2DSpUHDQy
         xZ0YThOx9tX3gALv7DdT/TOjk/O4nF04jN491r7vLGOUFJEKVpZYdcBf24sHLLJ0QoVX
         5VyChncf0aZGHuAsLJXRl+eiMa/gWfBVcvFe4h/Vp7ILOca0BIPmaLz2pc8xuqEKoI66
         axspR8iYJhkvddtzbSVExcoGoTQXf4PjmoUAGtDIormS5Uoc/tvOdFl0maAcEOZFI8GV
         h7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iboSBornxxq5IGUmNwjcHJMSvR6JYlZCJH/3I/odZvU=;
        b=ZI9waAoFpyi59H5jZ0C0Cf2fUwSFa5TtFzMYLatNBIh8QxSRDdpJA4odM4M7xiiVRq
         /a2uqTtwl3cqzw0E0fYKe5wd+sANbNHBaQ0T5hgIl8gS+yooBW85+NsUbsl8yTReckok
         V1dyJnrjgZMjSG7iDtUmQie9XK/mWow64VIQ7N2pkvKwhuo5FiFMiLWY6fZQe7SEgVuS
         gXbg8pc877qKiObbnl9/DN/2y0a49BbwgCoGYzPWrImqDdQN3PGZYMRfkG7SUsvgfKYS
         6zxa1Jcc6P3u4wc8rVPztTHqmhZD4gN5TMeYlQLptr0FOieVHtfmuiqtOSnou1J+BLc6
         0pEQ==
X-Gm-Message-State: ACrzQf1/0pIpn+jQmHmisEjYW0OXi+osj21CCYZZpCGvAD6BT4tSbYvc
        z5C6Bia7d5feSmBqzYiOGVDJy1Inv9Y=
X-Google-Smtp-Source: AMsMyM7DlAGa7a2TLSa3QPg8ZAlyQYGmx4u/u3+GoUMF45yau24RIk4RLOslbpLSt+vgtP9nqoRrTA==
X-Received: by 2002:a05:600c:3147:b0:3c6:f871:1fec with SMTP id h7-20020a05600c314700b003c6f8711fecmr19700599wmo.71.1666535621633;
        Sun, 23 Oct 2022 07:33:41 -0700 (PDT)
Received: from localhost (94.197.10.75.threembb.co.uk. [94.197.10.75])
        by smtp.gmail.com with ESMTPSA id b13-20020a5d4d8d000000b0023660f6cecfsm3702290wru.80.2022.10.23.07.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 07:33:41 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 8/9] ASoC: jz4740-i2s: Move component functions near the component driver
Date:   Sun, 23 Oct 2022 15:33:27 +0100
Message-Id: <20221023143328.160866-9-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221023143328.160866-1-aidanmacdonald.0x0@gmail.com>
References: <20221023143328.160866-1-aidanmacdonald.0x0@gmail.com>
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

Move the component suspend/resume functions near the definition
of the component driver to emphasize that they're unrelated to
the DAI functions.

Acked-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 72 +++++++++++++++++------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 201368f828ff..ac04b17c2787 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -302,42 +302,6 @@ static int jz4740_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	return ret;
 }
 
-static int jz4740_i2s_suspend(struct snd_soc_component *component)
-{
-	struct jz4740_i2s *i2s = snd_soc_component_get_drvdata(component);
-
-	if (snd_soc_component_active(component)) {
-		regmap_clear_bits(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_ENABLE);
-		clk_disable_unprepare(i2s->clk_i2s);
-	}
-
-	clk_disable_unprepare(i2s->clk_aic);
-
-	return 0;
-}
-
-static int jz4740_i2s_resume(struct snd_soc_component *component)
-{
-	struct jz4740_i2s *i2s = snd_soc_component_get_drvdata(component);
-	int ret;
-
-	ret = clk_prepare_enable(i2s->clk_aic);
-	if (ret)
-		return ret;
-
-	if (snd_soc_component_active(component)) {
-		ret = clk_prepare_enable(i2s->clk_i2s);
-		if (ret) {
-			clk_disable_unprepare(i2s->clk_aic);
-			return ret;
-		}
-
-		regmap_set_bits(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_ENABLE);
-	}
-
-	return 0;
-}
-
 static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
@@ -454,6 +418,42 @@ static const struct i2s_soc_info jz4780_i2s_soc_info = {
 	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
 };
 
+static int jz4740_i2s_suspend(struct snd_soc_component *component)
+{
+	struct jz4740_i2s *i2s = snd_soc_component_get_drvdata(component);
+
+	if (snd_soc_component_active(component)) {
+		regmap_clear_bits(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_ENABLE);
+		clk_disable_unprepare(i2s->clk_i2s);
+	}
+
+	clk_disable_unprepare(i2s->clk_aic);
+
+	return 0;
+}
+
+static int jz4740_i2s_resume(struct snd_soc_component *component)
+{
+	struct jz4740_i2s *i2s = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	ret = clk_prepare_enable(i2s->clk_aic);
+	if (ret)
+		return ret;
+
+	if (snd_soc_component_active(component)) {
+		ret = clk_prepare_enable(i2s->clk_i2s);
+		if (ret) {
+			clk_disable_unprepare(i2s->clk_aic);
+			return ret;
+		}
+
+		regmap_set_bits(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_ENABLE);
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_component_driver jz4740_i2s_component = {
 	.name			= "jz4740-i2s",
 	.suspend		= jz4740_i2s_suspend,
-- 
2.38.1

