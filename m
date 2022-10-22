Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E762A608F29
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 21:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiJVTOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 15:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiJVTNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 15:13:36 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2237A1781E0;
        Sat, 22 Oct 2022 12:13:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r8-20020a1c4408000000b003c47d5fd475so7345335wma.3;
        Sat, 22 Oct 2022 12:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iboSBornxxq5IGUmNwjcHJMSvR6JYlZCJH/3I/odZvU=;
        b=oqJu8idVmaPE2LMxcxWsLgGsAW2tGfh5XvsPFHkCPRZyF99ZTJ3OttyzL7xNtIH9Eb
         hDNW79sudExmGZ2fAsl3tOyh572iBMWG7vByO8keqMC/vee9+Z6Qgxnb/9Pcqu+3I7Cl
         6/apLAkn5OENy/0Scvf3Lmeoa+J+9cCBAie9jv64kQnIrXfH51gUV6wcv7ypeN7McqQP
         yvafe8i8aVLjyqdcH5hTEIDPowDKtENQyUHggOTsHeZcDQvfEtQPhoRkxb9TZWuxOIap
         KLmRRdTeVzh94m7uPJZG7oLDb6iwQZFeQbklrUw6DEXSXRWQKKEalzcuIaavw/eZfL6n
         +L4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iboSBornxxq5IGUmNwjcHJMSvR6JYlZCJH/3I/odZvU=;
        b=plCnYe5X5jNODDbYOur9eVIJWdLPn03NXSMmj76oWf11ri7eJQLQc896/MXVoB1Y0y
         bMRDDACfvdbIWKLP4y8gjwdb7Kn4L0d8AVrmc8oais8W1+ptM7aXe4e5R4vILJ3M6tHg
         4q9q8Vt9iIrcSGkoT5Dl9ahMnzAkxowhSkJ5In/FER6Mkr3SSfwrZ7Xous/FZEQy7aVU
         oVEY0LnK4Jr7c7GVADEr5qfsWcHnK4vyrnVqqz9JPNQ07YpIqNswMMoLjhO10Knqb9Mj
         PFYwJ0pUyaWoJ7bJ6q5rtNgC96MQQE4YdATi9+lbSxHsh9JRIKPwkOJHEKTUuqM+0Ykw
         9ciQ==
X-Gm-Message-State: ACrzQf36Wb5OHuoNkEdLJf17tPmnGC4ieGiltoCFjqz7v7QG4K95eiVQ
        R3bL+rq2Nb2bJ7TqcOVHou0=
X-Google-Smtp-Source: AMsMyM70MXJZAWK50FvealyeZjpK7na1yNlXvvbKwBNPVXvZWYif3RfyAo8Mb+sqm4+r2Dm++KIjbg==
X-Received: by 2002:a05:600c:4789:b0:3c4:dbb7:ab0c with SMTP id k9-20020a05600c478900b003c4dbb7ab0cmr17526542wmo.164.1666466012056;
        Sat, 22 Oct 2022 12:13:32 -0700 (PDT)
Received: from localhost (94.197.1.68.threembb.co.uk. [94.197.1.68])
        by smtp.gmail.com with ESMTPSA id k14-20020a05600c1c8e00b003c6bd12ac27sm6489884wms.37.2022.10.22.12.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 12:13:31 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 8/9] ASoC: jz4740-i2s: Move component functions near the component driver
Date:   Sat, 22 Oct 2022 20:13:07 +0100
Message-Id: <20221022191308.82348-9-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221022191308.82348-1-aidanmacdonald.0x0@gmail.com>
References: <20221022191308.82348-1-aidanmacdonald.0x0@gmail.com>
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

