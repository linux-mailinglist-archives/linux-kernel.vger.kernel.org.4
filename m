Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B3C6E4B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjDQOPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjDQOPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:15:00 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B985267
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:14:57 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id c9so25671789ejz.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681740896; x=1684332896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l8OjZCSSC//phSuWYvfawiHJ89Dsp2AaxdfcVlgHVfA=;
        b=w/93HIzAuP5t6l+IMz0tDo3YXGzXWUJfwpErdrbZ2jkDH3nOltQcKZOYn6MZ1Ylvl1
         YLolZ3KjnWSSIntWx1g4yDPgdjiqT6I2zzmCX5KJQaQXaq7L1KeNKa/3w2mWAegaasjt
         GWU8XrzdE0Pru49Zd1WhwPo+2oynrKKVG5jGGjYX7k30SB0aWL2mm0mc/6absdit0rpU
         BBAP1E3hWtowRNEii0j1CYtHHW29bvRE0778vJ/k0HYCuNJqW5M39iKouODl141uyHqW
         6pLzU7eyxgPEr7q/m3ltm80htp1o9qRxVwIM7gIQTCZ35T61WGr6juhm5kInRcEn1L7g
         Lr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681740896; x=1684332896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8OjZCSSC//phSuWYvfawiHJ89Dsp2AaxdfcVlgHVfA=;
        b=ghRhpi53pZ7PHmnSKl4Gro8bOoITPto44HlPo2A4W9H2Yrjn7yscHbKolyPfb6eURK
         e/HIS3nXp0TK1UZQTes7yhvY83tgKpbjktTCMdHeIe3qrHdsdLqowQGLBEjtJE9+K9cX
         s0dUuQZXj6NfIkIV3gi5tByWHZarVb0R5UKPhIOt0n/4nA8ZNaRGod1c6+Womqci8c8l
         WjX+8mkTMeEVNoqGbI5hYF6oTKW83/qHSTVJbCGcqjKuUXL0Se3gyIiWx7PLS7u3Wwxl
         3+yVoTJSIVW+kcyEFdbPdjmPSS0IUmzC4r4s9FB6Y8W4gO3SDa4dXdKqELSofVuAWa+S
         t4jA==
X-Gm-Message-State: AAQBX9dUhff9rAMrfpwQWg6NC0e3m4xrSp82dXPRJP5+dilNdQAsXmeT
        Q94u1gGwhyRlXt4g+oSANX+PjA==
X-Google-Smtp-Source: AKy350a2bmRei9A0qs2pgDzWdwVvj/XCBSxX7OL18aPrP8Z+ZGBhJJ5K8guxgj+yHghapBSOeIWGQg==
X-Received: by 2002:a17:907:7e9c:b0:94f:335b:4da0 with SMTP id qb28-20020a1709077e9c00b0094f335b4da0mr6563124ejc.51.1681740895939;
        Mon, 17 Apr 2023 07:14:55 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:96aa:60eb:e021:6511])
        by smtp.gmail.com with ESMTPSA id q6-20020a056402040600b004f9e6495f94sm5832034edv.50.2023.04.17.07.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 07:14:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] ASoC: codecs: wcd9335: Simplify with dev_err_probe
Date:   Mon, 17 Apr 2023 16:14:50 +0200
Message-Id: <20230417141453.919158-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code can be a bit simpler with dev_err_probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd9335.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index d2548fdf9ae5..8bf3510a3ea3 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -5138,20 +5138,17 @@ static int wcd9335_irq_init(struct wcd9335_codec *wcd)
 	 * INTR2 is a subset of first interrupt sources MAD, VBAT, and SVA
 	 */
 	wcd->intr1 = of_irq_get_byname(wcd->dev->of_node, "intr1");
-	if (wcd->intr1 < 0) {
-		if (wcd->intr1 != -EPROBE_DEFER)
-			dev_err(wcd->dev, "Unable to configure IRQ\n");
-
-		return wcd->intr1;
-	}
+	if (wcd->intr1 < 0)
+		return dev_err_probe(wcd->dev, wcd->intr1,
+				     "Unable to configure IRQ\n");
 
 	ret = devm_regmap_add_irq_chip(wcd->dev, wcd->regmap, wcd->intr1,
 				 IRQF_TRIGGER_HIGH, 0,
 				 &wcd9335_regmap_irq1_chip, &wcd->irq_data);
 	if (ret)
-		dev_err(wcd->dev, "Failed to register IRQ chip: %d\n", ret);
+		return dev_err_probe(wcd->dev, ret, "Failed to register IRQ chip\n");
 
-	return ret;
+	return 0;
 }
 
 static int wcd9335_slim_probe(struct slim_device *slim)
@@ -5207,17 +5204,15 @@ static int wcd9335_slim_status(struct slim_device *sdev,
 	slim_get_logical_addr(wcd->slim_ifc_dev);
 
 	wcd->regmap = regmap_init_slimbus(sdev, &wcd9335_regmap_config);
-	if (IS_ERR(wcd->regmap)) {
-		dev_err(dev, "Failed to allocate slim register map\n");
-		return PTR_ERR(wcd->regmap);
-	}
+	if (IS_ERR(wcd->regmap))
+		return dev_err_probe(dev, PTR_ERR(wcd->regmap),
+				     "Failed to allocate slim register map\n");
 
 	wcd->if_regmap = regmap_init_slimbus(wcd->slim_ifc_dev,
 						  &wcd9335_ifc_regmap_config);
-	if (IS_ERR(wcd->if_regmap)) {
-		dev_err(dev, "Failed to allocate ifc register map\n");
-		return PTR_ERR(wcd->if_regmap);
-	}
+	if (IS_ERR(wcd->if_regmap))
+		return dev_err_probe(dev, PTR_ERR(wcd->if_regmap),
+				     "Failed to allocate ifc register map\n");
 
 	ret = wcd9335_bring_up(wcd);
 	if (ret) {
-- 
2.34.1

