Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11896115D0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiJ1P1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiJ1P0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:26:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9AB1CF54B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:26:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id q9so13838361ejd.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYAU7odEMWKCjcropggkZQwO0OXnOT7Nxlue1f2Igjw=;
        b=N4qct+2/SkZTJmUhVNcb4x9h7lglsGkPGesm5ETCb6oDXj/896682W1IKcdN13TLcG
         gbEtaMgVEyleOH1zypX/bT1pazrPuMqQPG5xvSv2qzdZvL+olVF/KWwtwno67arAzTkL
         W3K4jUtGoo3rlzaDH5gok3XY0vEyMjSuHY5fM5MRm6iD2G5SkAdWW7k4zv9U0+pP97HT
         uo0nP/LOksN6bp8kC4OfFV2xDijskpC/DXBwG0FeSQU97vxR09Cjo1eHTCFA85h8ArXI
         s1aKN9+FHg9TcVnM4ILkZaZb96o1MkKsTKtaEvRHhjqMVKYr8i1XIlAiLkmu+lE8P1oO
         EArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYAU7odEMWKCjcropggkZQwO0OXnOT7Nxlue1f2Igjw=;
        b=Kwijpcp0Kdt7ENfkV6yKacShA3v4HpngglV+dk+2UebIg8vyvhrgTBDWIysNAgY4Vl
         XXzqNsnf7UE9WaPI1aJHeSnAs2DQeCceMuavVxAwL7SeDAXFvXvYQh0vhqW2DGzdZOt4
         WKuPeu5L7Vgbvl79GxFu5AIVz3FLTnDfZjzalL/Km773GAfGfy/0tfXxex5X6hCTmHc4
         26otWhlREfx6RPRk6tVaFmZNgxmaANKwqiPJpOerSgbHwsuu5SRpPKGSlcXe7nJHqH5d
         blR8/FkIyAivBi+NOGR1+B+tEdkaZ1zPUsQTQPNQutRDtibGo7df6zvuAnRMpOzxQC+4
         WPbw==
X-Gm-Message-State: ACrzQf3TuWCL9w6ozIDDmbAzEwCdblfTtE/+IchZjYMVhZfxFTNyKGRL
        g1gi4hIe4u68dg9FB2Wx/mGfew==
X-Google-Smtp-Source: AMsMyM4W1T435LCEpPz8XnDAEEj28TglPOt1WbD5txMFkIDdY7TDsPUrl+yprTOYVSDAYlOwSgOmjQ==
X-Received: by 2002:a17:906:30c5:b0:782:707:9e2d with SMTP id b5-20020a17090630c500b0078207079e2dmr46375763ejb.286.1666970810840;
        Fri, 28 Oct 2022 08:26:50 -0700 (PDT)
Received: from dtpc.zanders.be (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906319100b00730df07629fsm2349839ejy.174.2022.10.28.08.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:26:50 -0700 (PDT)
From:   Maarten Zanders <maarten.zanders@mind.be>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Maarten Zanders <maarten.zanders@mind.be>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ASoC: adau1372: fix mclk
Date:   Fri, 28 Oct 2022 17:26:23 +0200
Message-Id: <20221028152626.109603-2-maarten.zanders@mind.be>
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

"mclk" is retrieved from the configuration and assigned to adau1372->clk.
However adau1372->mclk (==NULL) is used for clk_prepare_enable() and
clk_disable_unprepare() which don't have any effect.

Remove .clk from struct adau1372 and use .mclk throughout.
This change ensures that the input clock is switched on/off when the
bias level is changed.

Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
---
 sound/soc/codecs/adau1372.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/adau1372.c b/sound/soc/codecs/adau1372.c
index a9f89e8565ec..00d0825e193b 100644
--- a/sound/soc/codecs/adau1372.c
+++ b/sound/soc/codecs/adau1372.c
@@ -25,7 +25,6 @@
 #include "adau-utils.h"
 
 struct adau1372 {
-	struct clk *clk;
 	struct regmap *regmap;
 	void (*switch_mode)(struct device *dev);
 	bool use_pll;
@@ -925,9 +924,9 @@ int adau1372_probe(struct device *dev, struct regmap *regmap,
 	if (!adau1372)
 		return -ENOMEM;
 
-	adau1372->clk = devm_clk_get(dev, "mclk");
-	if (IS_ERR(adau1372->clk))
-		return PTR_ERR(adau1372->clk);
+	adau1372->mclk = devm_clk_get(dev, "mclk");
+	if (IS_ERR(adau1372->mclk))
+		return PTR_ERR(adau1372->mclk);
 
 	adau1372->pd_gpio = devm_gpiod_get_optional(dev, "powerdown", GPIOD_OUT_HIGH);
 	if (IS_ERR(adau1372->pd_gpio))
@@ -947,7 +946,7 @@ int adau1372_probe(struct device *dev, struct regmap *regmap,
 	 * 12.288MHz. Automatically choose a valid configuration from the
 	 * external clock.
 	 */
-	rate = clk_get_rate(adau1372->clk);
+	rate = clk_get_rate(adau1372->mclk);
 
 	switch (rate) {
 	case 12288000:
-- 
2.37.3

