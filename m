Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025F76E5AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjDRHqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDRHqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:46:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E74A8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:46:35 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id kt6so32657617ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681803994; x=1684395994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r75opw4l+CuhzHbMethMKplabYX6RCoTnwLJOAhIH2w=;
        b=xeUihBhxZpDw3QqpfDYWEsAjDVqperPh1t0wYprp0Xc0pDzXU2RUtVLV2Chco6lXQK
         y1zWf41LzWNQtKtfmvytgrSHu0h+8uazuqfDTa2UZ41gEwWWpIFWLsZ3G2WN57BBMsne
         nxNO0QoCslwB2reV1GDhXcC5FgpU1xblug5Q1r4ftpH+Kedkxx7XiA9mt8kjYsvT1MZT
         As7eLuhzgixF+k/fPGNbRltr52nKQzkj7hsl2ExdutdlE3tprI0kuflQ1cozOYV6cM1q
         PzG8I4ZtecLXmjLXDII8fBgK4Y7aoXGV8AYqqbmWRwv+oTqmVUo+zAJj/AbXULdhn7n6
         8HWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681803994; x=1684395994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r75opw4l+CuhzHbMethMKplabYX6RCoTnwLJOAhIH2w=;
        b=lHntYhG6bjz1/lbFif0y+sM2BvKTWfARN05FUopqsp9oHeUy22m815sVdxj0Uxnd1r
         VkSLvNxKu3JPxDlNc7JnBdxxvfyndR6fAh0+Y1GZdN3opdHDeQN9g7cNVzIQbBHCiWJZ
         g3i2UgcMs+yyfoc3AYu5hvF+iSHlzZEeISXiVLtsH7Xmjlf4zU7lw5L9Frx9RapxA048
         izU5yAKiGqICQMqcnMn4CR5xjDXCE2yXRHDUVu3zAU+cqUO3o21QX4TYtEOnvNqDovwq
         3NN8oYhwg3WIBJLfJKlNVrcBQTFwtvpZh4ecFB+edFV0AY24Pc2e8PqcS4fNVeddtlXH
         pVyw==
X-Gm-Message-State: AAQBX9d4y6ERQaXhk3dv/pdKeBd4/SUH251bj2soGOWIrXmbGxu8Dkav
        r+sEKLuIR8S4emeP99VGXqwgXw==
X-Google-Smtp-Source: AKy350Z/p8EIAtZAxXyH27eboA35NbIl/kTqGzUgL6dzF9dIDkVlpNY2VfIyskViVRSjKS33fHEUhw==
X-Received: by 2002:a17:907:6d24:b0:94f:395b:df1b with SMTP id sa36-20020a1709076d2400b0094f395bdf1bmr8173936ejc.21.1681803993713;
        Tue, 18 Apr 2023 00:46:33 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id sa39-20020a1709076d2700b0094f410225c7sm3731993ejc.169.2023.04.18.00.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 00:46:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/4] ASoC: codecs: wcd9335: Simplify with dev_err_probe
Date:   Tue, 18 Apr 2023 09:46:27 +0200
Message-Id: <20230418074630.8681-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace dev_err() in probe() path with dev_err_probe() to:
1. Make code a bit simpler and easier to read,
2. Do not print messages on deferred probe.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Re-write commit msg.
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

