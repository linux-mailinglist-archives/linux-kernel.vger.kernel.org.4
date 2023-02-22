Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B4C69F347
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjBVLMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjBVLMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:12:43 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B0B392B2;
        Wed, 22 Feb 2023 03:12:38 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id e9so3333642plh.2;
        Wed, 22 Feb 2023 03:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/59u0aFLCj7mAVvWdqbe9uXAbJQVQlHSWO1sFeKEmaM=;
        b=Io6QEstP+tREfhiRZY4Ocgan+qroAozZmpSWtKekTone0wj/kjzebFvLtX8jDgdvQP
         y4k8UjqMUKVJtfFZDCMTtR/W5dZmODnlOOaXJTpLkH1+0ILNl2CEMiGdxoj67Nl+UuwN
         aVWLfQ3DnP5vF+oy+CHXsJZ0Dyb+CLubY6+761P3UgK4sf+BhBgP6GV9/X9rzb3dFLTG
         1I2A44jclwYgEBKA4mu2JyUSnvwYpHtrsv4m9N89ESr6jVjS6w2V5Wy9pSYUG263GtDe
         GnHLpJnQYaJHJPez5mSGk5+BwhLaOOfJ6+FVlv2sSncv7Hkq8DGMR6dVCbYmZHFrhgN+
         3B4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/59u0aFLCj7mAVvWdqbe9uXAbJQVQlHSWO1sFeKEmaM=;
        b=V7GU8kgt3+I3pMhwea1pZ+dGdUfHXLWDf2czXOmrIfM153EwlrNPXURdb1kkMlcVNs
         DsSNW0cKjfVp36XUbD/af159dIIibZXiIedppLj0KZtYoptRM784fyeNufpxE1N0D+t3
         MFbLthynD2kfRm+igE19dlPksMAbbUJChfgUG2zgX8uaCUN7/+zympmv4L80rbLPKjtw
         LDXLiQqE6XJN0Wk/EZRykFAqJPXB54eqUZg37JpIJjgdzxNnGPEXSnqcZUEBWeM7R4Iv
         IsUZxHzpSlRtwD4LLMYUIpMUrdq5XRsiaIl67gcxAZ8Cr2oqPiyM2eaKW3reU9qUtGtQ
         Qn7g==
X-Gm-Message-State: AO0yUKXn5sQwm3GB79vpUfvqQjsb+SShgUNPV88FkLDY9n24gpzI9kuS
        9j2Q9woSriMixd0RYUIUIHBch64tMb7RDA==
X-Google-Smtp-Source: AK7set8ODvsg9PGkSOZ5l1lt3bU1KfULzoQsu2vqX7fW3MHOKZxbH7yrgsY3CAtZcFphuOyhFF/jew==
X-Received: by 2002:a17:90b:388a:b0:235:82d0:3a36 with SMTP id mu10-20020a17090b388a00b0023582d03a36mr10664926pjb.41.1677064357358;
        Wed, 22 Feb 2023 03:12:37 -0800 (PST)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090a294700b00234899c65e7sm4763228pjf.28.2023.02.22.03.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 03:12:36 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 3/4] gpio: loongson1: Add DT support
Date:   Wed, 22 Feb 2023 19:12:12 +0800
Message-Id: <20230222111213.2241633-4-keguang.zhang@gmail.com>
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

This patch adds DT support for Loongson-1 GPIO driver,
including the following changes.
- Add the of_match_table
- Parse the ngpios property
- Parse the alias id

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 drivers/gpio/gpio-loongson1.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-loongson1.c b/drivers/gpio/gpio-loongson1.c
index b950bcfd78ce..92ad31f61bf0 100644
--- a/drivers/gpio/gpio-loongson1.c
+++ b/drivers/gpio/gpio-loongson1.c
@@ -48,7 +48,10 @@ static void ls1x_gpio_free(struct gpio_chip *gc, unsigned int offset)
 static int ls1x_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *dn = pdev->dev.of_node;
 	struct ls1x_gpio_chip *ls1x_gc;
+	unsigned int ngpios;
+	int id;
 	int ret;
 
 	ls1x_gc = devm_kzalloc(dev, sizeof(*ls1x_gc), GFP_KERNEL);
@@ -59,34 +62,56 @@ static int ls1x_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(ls1x_gc->reg_base))
 		return PTR_ERR(ls1x_gc->reg_base);
 
+	if (of_property_read_u32(dn, "ngpios", &ngpios)) {
+		dev_err(dev, "Missing ngpios OF property\n");
+		return -ENODEV;
+	}
+
+	id = of_alias_get_id(dn, "gpio");
+	if (id < 0) {
+		dev_err(dev, "Couldn't get OF id\n");
+		return id;
+	}
+
 	ret = bgpio_init(&ls1x_gc->gc, dev, 4, ls1x_gc->reg_base + GPIO_DATA,
 			 ls1x_gc->reg_base + GPIO_OUTPUT, NULL,
 			 NULL, ls1x_gc->reg_base + GPIO_DIR, 0);
 	if (ret)
 		goto err;
 
+	ls1x_gc->gc.label = dev_name(&pdev->dev);
+	ls1x_gc->gc.ngpio = ngpios;
 	ls1x_gc->gc.owner = THIS_MODULE;
+	ls1x_gc->gc.parent = dev;
+	ls1x_gc->gc.base = pdev->id * BITS_PER_LONG;
 	ls1x_gc->gc.request = ls1x_gpio_request;
 	ls1x_gc->gc.free = ls1x_gpio_free;
-	ls1x_gc->gc.base = pdev->id * 32;
 
 	ret = devm_gpiochip_add_data(dev, &ls1x_gc->gc, ls1x_gc);
 	if (ret)
 		goto err;
 
 	platform_set_drvdata(pdev, ls1x_gc);
-	dev_info(dev, "Loongson1 GPIO driver registered\n");
+
+	dev_info(dev, "GPIO controller %d registered with %d pins\n", id,
+		 ngpios);
 
 	return 0;
 err:
-	dev_err(dev, "failed to register GPIO device\n");
+	dev_err(dev, "failed to register GPIO controller\n");
 	return ret;
 }
 
+static const struct of_device_id ls1x_gpio_dt_ids[] = {
+	{ .compatible = "loongson,ls1x-gpio", },
+	{ /* sentinel */ }
+};
+
 static struct platform_driver ls1x_gpio_driver = {
 	.probe	= ls1x_gpio_probe,
 	.driver	= {
 		.name	= "ls1x-gpio",
+		.of_match_table = ls1x_gpio_dt_ids,
 	},
 };
 
-- 
2.34.1

