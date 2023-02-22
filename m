Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE6769F343
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjBVLMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjBVLMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:12:35 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC01211D6;
        Wed, 22 Feb 2023 03:12:33 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so193052pja.5;
        Wed, 22 Feb 2023 03:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azrsxJplJ+DgLt389DwS68lqZLzLGhDWxaz1QQlD5Js=;
        b=jlrCfPyouseNbDppeJ5IFeloNRVnhiC8a3VC41uf0HyVPqwLDfe2QHIDNGPjKmgXof
         BuvKIAtVb5Qt4xHLLdO1zK970/o2Ejs01C5pe9qcZE7Z2l7fHOXsiIOHjzebK27g109U
         cZ3DWSwUHL27o1DBCTJAI2eYYYgSIkGWa2Ot/squXRn3amq1u8ZI8gzIIGOsq5Q1iQ6v
         gOg6ppDLhJR+EV38vXS9mtznCRX6GTQz2jbsf2jx6dh86mx3f/D9q0wGbm9vd37FNP6O
         Riz3FqtmuShyNZqgp2cQ1n0IS1lNqNVgN7j0xSAFAtLtdqTg7SS5q7nwCdfmMv0KSTsQ
         gXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azrsxJplJ+DgLt389DwS68lqZLzLGhDWxaz1QQlD5Js=;
        b=yIHD3AlV2Yrjq5aQIduMzVtPh3/nbvgbxS0aL0UmBV4rlRyucfKAY7VEqnJM4MacOO
         QhmJuDAnNSk2D65q3+nP98bqYXggHYSWVVrcu7/SoBO/ZEUiYpVpf4DzICLcF1sSndtp
         dMmK6nXWW/Ij+iaydb3AZdmdCVAZPH2G5R0L1OX36xSDz/UCKcrOIgj/U3vORgXhJgi/
         ejNn+ak8cjgweQs0pE2tZWjXSTlSmollLzGJ07XC/Dv9KGiCw1CjcK4SAw6S2mnFlr0A
         Nl3FdeJrZBuFSY7DMq19dk0UESU4VYwjZXMq8s+haUAvuNF4XU5fVLnvlqiLCUL8Ovk8
         eF6Q==
X-Gm-Message-State: AO0yUKVQIvQvveJEf8X8TzPezjjqgjJCUg/bY3Oc0sVQgB6ihgVbnIJ2
        X8hIxHprptOSDjZES6V9WGCM2TFjo8Q=
X-Google-Smtp-Source: AK7set8gMx4PNKWM2ER+1oMD8et/3evsiduBobQ1yJDBpcbF1j5RyVXJolmLWHSzgPbF7+KJP476xA==
X-Received: by 2002:a17:90a:4d88:b0:234:17b:ae2b with SMTP id m8-20020a17090a4d8800b00234017bae2bmr9789396pjh.13.1677064352955;
        Wed, 22 Feb 2023 03:12:32 -0800 (PST)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090a294700b00234899c65e7sm4763228pjf.28.2023.02.22.03.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 03:12:32 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 2/4] gpio: loongson1: Introduce ls1x_gpio_chip struct
Date:   Wed, 22 Feb 2023 19:12:11 +0800
Message-Id: <20230222111213.2241633-3-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222111213.2241633-1-keguang.zhang@gmail.com>
References: <20230222111213.2241633-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce and allocate ls1x_gpio_chip struct containing
gpio_chip and reg_base to avoid global gpio_reg_base.

Use readl() & writel() instead of __raw_readl() & __raw_writel().

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 drivers/gpio/gpio-loongson1.c | 45 +++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpio-loongson1.c b/drivers/gpio/gpio-loongson1.c
index 7ecbc43f8b38..b950bcfd78ce 100644
--- a/drivers/gpio/gpio-loongson1.c
+++ b/drivers/gpio/gpio-loongson1.c
@@ -16,15 +16,19 @@
 #define GPIO_DATA		0x20
 #define GPIO_OUTPUT		0x30
 
-static void __iomem *gpio_reg_base;
+struct ls1x_gpio_chip {
+	struct gpio_chip gc;
+	void __iomem *reg_base;
+};
 
 static int ls1x_gpio_request(struct gpio_chip *gc, unsigned int offset)
 {
+	struct ls1x_gpio_chip *ls1x_gc = gpiochip_get_data(gc);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
-	__raw_writel(__raw_readl(gpio_reg_base + GPIO_CFG) | BIT(offset),
-		     gpio_reg_base + GPIO_CFG);
+	writel(readl(ls1x_gc->reg_base + GPIO_CFG) | BIT(offset),
+	       ls1x_gc->reg_base + GPIO_CFG);
 	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 
 	return 0;
@@ -32,44 +36,45 @@ static int ls1x_gpio_request(struct gpio_chip *gc, unsigned int offset)
 
 static void ls1x_gpio_free(struct gpio_chip *gc, unsigned int offset)
 {
+	struct ls1x_gpio_chip *ls1x_gc = gpiochip_get_data(gc);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
-	__raw_writel(__raw_readl(gpio_reg_base + GPIO_CFG) & ~BIT(offset),
-		     gpio_reg_base + GPIO_CFG);
+	writel(readl(ls1x_gc->reg_base + GPIO_CFG) & ~BIT(offset),
+	       ls1x_gc->reg_base + GPIO_CFG);
 	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
 static int ls1x_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct gpio_chip *gc;
+	struct ls1x_gpio_chip *ls1x_gc;
 	int ret;
 
-	gc = devm_kzalloc(dev, sizeof(*gc), GFP_KERNEL);
-	if (!gc)
+	ls1x_gc = devm_kzalloc(dev, sizeof(*ls1x_gc), GFP_KERNEL);
+	if (!ls1x_gc)
 		return -ENOMEM;
 
-	gpio_reg_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(gpio_reg_base))
-		return PTR_ERR(gpio_reg_base);
+	ls1x_gc->reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ls1x_gc->reg_base))
+		return PTR_ERR(ls1x_gc->reg_base);
 
-	ret = bgpio_init(gc, dev, 4, gpio_reg_base + GPIO_DATA,
-			 gpio_reg_base + GPIO_OUTPUT, NULL,
-			 NULL, gpio_reg_base + GPIO_DIR, 0);
+	ret = bgpio_init(&ls1x_gc->gc, dev, 4, ls1x_gc->reg_base + GPIO_DATA,
+			 ls1x_gc->reg_base + GPIO_OUTPUT, NULL,
+			 NULL, ls1x_gc->reg_base + GPIO_DIR, 0);
 	if (ret)
 		goto err;
 
-	gc->owner = THIS_MODULE;
-	gc->request = ls1x_gpio_request;
-	gc->free = ls1x_gpio_free;
-	gc->base = pdev->id * 32;
+	ls1x_gc->gc.owner = THIS_MODULE;
+	ls1x_gc->gc.request = ls1x_gpio_request;
+	ls1x_gc->gc.free = ls1x_gpio_free;
+	ls1x_gc->gc.base = pdev->id * 32;
 
-	ret = devm_gpiochip_add_data(dev, gc, NULL);
+	ret = devm_gpiochip_add_data(dev, &ls1x_gc->gc, ls1x_gc);
 	if (ret)
 		goto err;
 
-	platform_set_drvdata(pdev, gc);
+	platform_set_drvdata(pdev, ls1x_gc);
 	dev_info(dev, "Loongson1 GPIO driver registered\n");
 
 	return 0;
-- 
2.34.1

