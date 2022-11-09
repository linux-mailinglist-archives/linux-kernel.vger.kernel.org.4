Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D425C62304A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiKIQiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiKIQhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:37:54 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F225C1AF15
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 08:37:52 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id h12so26446528ljg.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 08:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=igRKNWyl8eDcyN8ADQ2CerDEG1C252RVqSCCLSg5/ao=;
        b=c8cubEf64QS6Q+U7fjrB+sIgZfWpFGaA+TPPDL5rMINY4WnVsrYg+9VxrJGUnDXAj4
         rbypuF9VW/blvVOH6DlIlBmSa9Rwnll/hVweaPQAt47UdGom8Mpn8X/W36GkafxS0OYJ
         uTMVTwDlWWmZnefNk8kkYKgcNSmsp229Fxfdcb0vJqTH7Js/rnR5sYK8bonAf+0o4Uhl
         YCH72dy/hTASWhV1oFZWe7iX6wgdm/EEOJkRDmK9pbzLGGfsHn52tEOXoMl9ukQjWCP7
         aZFGOX7aErHbMVFB7mea/c15hZt3IR3WaicKMIUMbuVjsouDXd++DKA8b7VObhnfIPIE
         GJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igRKNWyl8eDcyN8ADQ2CerDEG1C252RVqSCCLSg5/ao=;
        b=zQTjy6NOsY9ITn/w3Zyhmuy9fOCjgs1J5VASNJiZJBYDZtpwi+uHhdoWA9LMJNJeZX
         FlxiRAvBWWDYMb7gbYGaTeFXLEIVPF5sTtJAGHpIZ6d1SiwepqOYPVAWcnGp45qpS5eo
         5IUovEKCU91U+cSy1qIJJvuv3RfcKPUs7k2orNQ/6MAGdgY9Az5qlWedASTb5HbCxXdF
         6bgyDNj+e5x0S2fRjSSR9V6aZ0BJaK2Q1BuGpkqHsHtrbLBxbNJnd82zB/V8hsL+fSEr
         SUaKGlh+AVh+X1//MBsJd4H5e6SPPjHeCfO4HdstwcBtFGppYRlQNAIVyRDgQMhYHV1e
         YhqQ==
X-Gm-Message-State: ACrzQf0fbhkwCYFwLj19nb4TY5qNUmjEc1KiYiEaIxpkHgn9osy0t+wU
        B4X/i4KGRuLKOF+6RwjtNuGLkw==
X-Google-Smtp-Source: AMsMyM5nTgoZ2joUXWj6vhYWVGTA6I/LsWqnQ2kSEQTKAr2tKLCopqfnlSgbt4Ji+5RZx9Eyw6R4rw==
X-Received: by 2002:a05:651c:12c8:b0:277:75bb:429f with SMTP id 8-20020a05651c12c800b0027775bb429fmr6576554lje.387.1668011869798;
        Wed, 09 Nov 2022 08:37:49 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id p1-20020a2e8041000000b00277129b4a10sm2222091ljg.86.2022.11.09.08.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 08:37:49 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: codecs: wsa883x: Use proper shutdown GPIO values
Date:   Wed,  9 Nov 2022 17:37:40 +0100
Message-Id: <20221109163740.1158785-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shutdown GPIO is active_low (sd_n), but this depends on actual board
layout.  Linux drivers should only care about logical state, where high
(1) means shutdown and low (0) means do not shutdown.

Invert the GPIO to match logical value.

Fixes: 43b8c7dc85a1 ("ASoC: codecs: add wsa883x amplifier support")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wsa883x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index c7b10bbfba7e..77a7dd3cf495 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -1392,7 +1392,7 @@ static int wsa883x_probe(struct sdw_slave *pdev,
 	}
 
 	wsa883x->sd_n = devm_gpiod_get_optional(&pdev->dev, "powerdown",
-						GPIOD_FLAGS_BIT_NONEXCLUSIVE);
+						GPIOD_FLAGS_BIT_NONEXCLUSIVE | GPIOD_OUT_HIGH);
 	if (IS_ERR(wsa883x->sd_n)) {
 		dev_err(&pdev->dev, "Shutdown Control GPIO not found\n");
 		ret = PTR_ERR(wsa883x->sd_n);
@@ -1411,7 +1411,7 @@ static int wsa883x_probe(struct sdw_slave *pdev,
 	pdev->prop.simple_clk_stop_capable = true;
 	pdev->prop.sink_dpn_prop = wsa_sink_dpn_prop;
 	pdev->prop.scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
-	gpiod_direction_output(wsa883x->sd_n, 1);
+	gpiod_direction_output(wsa883x->sd_n, 0);
 
 	wsa883x->regmap = devm_regmap_init_sdw(pdev, &wsa883x_regmap_config);
 	if (IS_ERR(wsa883x->regmap)) {
-- 
2.34.1

