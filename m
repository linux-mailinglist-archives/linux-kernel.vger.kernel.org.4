Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C3D5EE91C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbiI1WEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiI1WEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:04:21 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0F7696EC;
        Wed, 28 Sep 2022 15:04:20 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id e18so9324394wmq.3;
        Wed, 28 Sep 2022 15:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=2wqVo0aD55CNjK+hEjl9Jhtj7J/Tr6/AA4pMGSEV/1g=;
        b=KU1oYI3X0FsdCE4047IjtG+VQWOsp23dQ1ziNPvW9YTUtXJgabEeqWTqAfXnORtk7Q
         EgXtEwk7lbwjqPFgg+cMC4IgeJbda9fq7SzSgYlCFtfPJMX7NuKM+LFQ+pTHNQ3MeFK9
         jgS88jZoYJlre/fYBan0YOURD6Scp5FEFXjLTzFVPlQhmsyEJYk0Tff9Bsut8aew+9hx
         L5WKAeV7f/VMlkXKEVA1qoXAx7ml8wcjhgpA+5bZrRzw2vf2ETSiFReCmZWh1M3Cirtq
         Gff1LMaLcri9HXdR38v1ZbHtBO0e61ybtU4mAW21b1ayAXZsjKUmnJ2k3Nl0iX/fbqxt
         uPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=2wqVo0aD55CNjK+hEjl9Jhtj7J/Tr6/AA4pMGSEV/1g=;
        b=R4By1O2vzNRzI7YlTO/ursrDCJECXxNoP1vRcD7CDpPjvl17Tq2XP5wgMTYQVXotJQ
         kdHm2HKYzmkajgILSuLswSG1IAmBc6kUDbvW+A54/cYLDnGFeC/Uctjs+bcotKx3C3wD
         S5dpkn9PneuECf4uR2fVhhe22ZnDo+Wa3u2xBDfXCGJURdoWwzmUvRmUWMj5L7pmS0FD
         VnF59eOX6zu0eO3cyIUBWxlgZ0OHH1ap1jspPc7Bn7Uxkle9gdgfuOojFS1meg4/+D8F
         K3JUenokXRmK/0Sufih9N0V0Rv09yjvCy4wOhtaTIdpaDaqe4iT20Z6Xn1wCDmE5kIGK
         bZEA==
X-Gm-Message-State: ACrzQf1d8CKdC75/IvyFKQ3VMXGeNVv52+y2fCnVJPI1JBbrzn8gpQGA
        4m8S9zSQGfXtpwDg2rT55jY=
X-Google-Smtp-Source: AMsMyM5C5bvoufyf0RMPrn0G1wm8CeA8ImmPUYZ3eH2K2m1PZUZoa1b7sFlsXXS6Dva1sReyJbuqKQ==
X-Received: by 2002:a05:600c:310b:b0:3b4:c618:180d with SMTP id g11-20020a05600c310b00b003b4c618180dmr76898wmo.25.1664402658808;
        Wed, 28 Sep 2022 15:04:18 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d4203000000b0022acb7195aesm5121019wrq.33.2022.09.28.15.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 15:04:18 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: mediatek: mt8186: Fix spelling mistake "slect" -> "select"
Date:   Wed, 28 Sep 2022 23:04:17 +0100
Message-Id: <20220928220417.66799-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some spelling mistakes in dev_err messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/mediatek/mt8186/mt8186-afe-gpio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c b/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
index 274c0c8ec2f2..eda913fa147a 100644
--- a/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
@@ -170,25 +170,25 @@ static int mt8186_afe_gpio_adda_ul(struct device *dev, bool enable)
 	if (enable) {
 		ret = mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_CLK_MISO_ON);
 		if (ret) {
-			dev_err(dev, "%s(), MISO CLK ON slect fail!\n", __func__);
+			dev_err(dev, "%s(), MISO CLK ON select fail!\n", __func__);
 			return ret;
 		}
 
 		ret = mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_DAT_MISO_ON);
 		if (ret) {
-			dev_err(dev, "%s(), MISO DAT ON slect fail!\n", __func__);
+			dev_err(dev, "%s(), MISO DAT ON select fail!\n", __func__);
 			return ret;
 		}
 	} else {
 		ret = mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_DAT_MISO_OFF);
 		if (ret) {
-			dev_err(dev, "%s(), MISO DAT OFF slect fail!\n", __func__);
+			dev_err(dev, "%s(), MISO DAT OFF select fail!\n", __func__);
 			return ret;
 		}
 
 		ret = mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_CLK_MISO_OFF);
 		if (ret) {
-			dev_err(dev, "%s(), MISO CLK OFF slect fail!\n", __func__);
+			dev_err(dev, "%s(), MISO CLK OFF select fail!\n", __func__);
 			return ret;
 		}
 	}
-- 
2.37.1

