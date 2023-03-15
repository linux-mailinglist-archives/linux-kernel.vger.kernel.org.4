Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CC76BAED1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjCOLJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjCOLJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:09:10 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD3780E21;
        Wed, 15 Mar 2023 04:07:15 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j13so2652845pjd.1;
        Wed, 15 Mar 2023 04:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678878431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwZTvG1oeNKrq9Gr/GVv1X6yyECjAkdB1xOqZJhu/cU=;
        b=oW/IVbCLc/UQchYBi+eel5GnHE/DU+fgENzl2b3O5ct8SFP0PFOjL5aICJ35s5/RjT
         Lj0Z+blmtLuRc+I/22KpbW+U8dRZRquEVgfNKKR6W2P3u6uahHTDhxD9t9VmD6dn+hEz
         t5AXcz0CcKr26B7K7/7u++7YMugjxmgu/Z9j+m+iqx2z2iXCZ/f/fChKiaobBfqO7Xm0
         DvXHmVbcYMmBI3k+H10QOnR1bGtbEsOX06Gku/3I4vJLM7w7d52doNkOCDPsrNgQLU2o
         nGbHCZvR8Wv1EDwkaM7grYJXfU/cYlViHF37FiY+VMmDFB/FNnZdYHOeKWhfAGZGxSsG
         8s3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678878431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwZTvG1oeNKrq9Gr/GVv1X6yyECjAkdB1xOqZJhu/cU=;
        b=0GRHbeb3yXQavxpLvPCD4iWI76EXhnzk1tgcufaXs0bIoley9OPH+LoBx3sY4Z9J9q
         bVfiRo0I3ey7ZBqksrkkydUfyRwW6HldyPqJSKl6ybL0IQL0lpSRC+G+gIeQCEW3HeoR
         YcsToiHb9/PWXhMVmq0v6U/zekrW5IqS1gdzS99EW6wlNoGSK7nvZGG5gHVrcC1LjiMz
         I44/o/3NlNzRg+QFPyp7GoxKN8wXZlcZsUSNM6OT2gM9LvhgOoAPFTt7D5AOm0vmyyPM
         osSwBXItIqkCgLtDGq1zeBb+BPi7AwDYxA7/dLT8DQ+PriagrzSOUh6X/mIu2YgDoNWK
         1uaw==
X-Gm-Message-State: AO0yUKW8k2MPTgjLbzS+PkYElbxmg88DEagRrDNz6Cghym9/fnN8Gkq7
        F7uOCMsZE6Y7oNrV8jwYW3wAQfngxi2vkw==
X-Google-Smtp-Source: AK7set8B1yeRbAR/bxeclMZyxkvqmPWoOiUeI4detaa6Tb9v2lPXoAfkRJmqae79j+FcOBacUy2bwA==
X-Received: by 2002:a05:6a21:33a2:b0:cd:97f3:25e1 with SMTP id yy34-20020a056a2133a200b000cd97f325e1mr53363631pzb.51.1678878430945;
        Wed, 15 Mar 2023 04:07:10 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id v4-20020aa78084000000b005892ea4f092sm3337489pff.95.2023.03.15.04.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 04:07:10 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v3 2/4] gpio: loongson1: Introduce ls1x_gpio_chip struct
Date:   Wed, 15 Mar 2023 19:06:48 +0800
Message-Id: <20230315110650.142577-3-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315110650.142577-1-keguang.zhang@gmail.com>
References: <20230315110650.142577-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces and allocates ls1x_gpio_chip struct containing
gpio_chip and reg_base to avoid global gpio_reg_base.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V2 -> V3: Restore the calling of __raw_readl() & __raw_writel()
V1 -> V2: Split this change to a separate patch
---
 drivers/gpio/gpio-loongson1.c | 45 +++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpio-loongson1.c b/drivers/gpio/gpio-loongson1.c
index 8862c9ea0d41..dddfc71f0e10 100644
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
+	__raw_writel(__raw_readl(ls1x_gc->reg_base + GPIO_CFG) | BIT(offset),
+		     ls1x_gc->reg_base + GPIO_CFG);
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
+	__raw_writel(__raw_readl(ls1x_gc->reg_base + GPIO_CFG) & ~BIT(offset),
+		     ls1x_gc->reg_base + GPIO_CFG);
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

