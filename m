Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27946A82CB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjCBMxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCBMxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:53:15 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9B921958;
        Thu,  2 Mar 2023 04:53:03 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id n6so16037125plf.5;
        Thu, 02 Mar 2023 04:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTlG/HavU64jt/5bxFZVCvJJZA+o1I3CZfepDCCo+0s=;
        b=JzAhYLNxMLvZXlb9cW1eYkvy0Z+oYfKiK/HcOzu1x/4L3xIIq9/NPDoRXeF6AZ8bVG
         grQBSinQCoKZ5WdKilRNWSICo/juzj0gLFysU6vPORjtslv9oX+nQty3Uj5U8eZydM6t
         FqykxYDc1P4o5HOD17yh8rmjOoFKF2wRnRa+WSnXSYwTc2ewKMbselTSi8GvrcYIA8Rz
         qricXzRCyROjW7DL6TEp+plDQzwercRBXmXPPeZDtCa3nZOlSuBnUr0cJVNJ0u3W9tIe
         WeGsiWl/9I6tqSthPq9S+pKBrB7ltRNpXbticSZyBC36ZyVzkA9ySLdgUF3J1/IpmP08
         zoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTlG/HavU64jt/5bxFZVCvJJZA+o1I3CZfepDCCo+0s=;
        b=r7r3eFZuc+EKtR6we4sZu3+2vB8viWf0HiTR+TOcnLvfuU7rLBKKWVJZJ4u5q1J5su
         MJbrAfKzjwsozM3mKWrxJRpNUBwi//fcjC7cnt1rRX5AC6ZU++OPq8bFW5mMx67j4tby
         mEbcAmL9qbAa6120AjMTZl5W2/3bb2KfjKfFvLslfimsLOWiiJ7RfPPaRnbVRj8SKEUX
         pc45FxXCNJJHBat8z990bWwlJqzJ4qWnFcG3ymOJSlXC/c84lJ/OOmCjLgSC29bwEju/
         6Bf12s+Bkr1zX9C9yzP8miCd9bJxHQkZa1x87Byf0KXmLW+ZGQ86llgLeVfw+mhNfFEA
         ER3g==
X-Gm-Message-State: AO0yUKXTs6DNpwebsu4vZCmweIDgNqGAhgR0rhxGJhgv7fJPQgeQd6LW
        wb7TYh63i733QP2ZKQ9sH8q0oLdVpXP48Q==
X-Google-Smtp-Source: AK7set8CvC//mEhCspT+FY5Y7s/4F36pQhRvOCU4ivGxfv87lnDgys0XFuWeFtK54Ea2QfCFS470kw==
X-Received: by 2002:a05:6a21:99a5:b0:b6:99a4:66bd with SMTP id ve37-20020a056a2199a500b000b699a466bdmr12347441pzb.38.1677761582805;
        Thu, 02 Mar 2023 04:53:02 -0800 (PST)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([223.85.203.147])
        by smtp.gmail.com with ESMTPSA id j7-20020a62e907000000b005aa60d8545esm9791955pfh.61.2023.03.02.04.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 04:53:02 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v2 4/5] gpio: loongson1: Add DT support
Date:   Thu,  2 Mar 2023 20:52:14 +0800
Message-Id: <20230302125215.214014-5-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230302125215.214014-1-keguang.zhang@gmail.com>
References: <20230302125215.214014-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
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

This patch adds DT support for Loongson-1 GPIO driver.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V1 -> V2: Let gpiolib parse ngpios property
          Remove unnecessary alias id parsing
          Remove superfluous initialization done by bgpio_init()
          Add MODULE_DEVICE_TABLE()
          Other minor fixes
---
 drivers/gpio/gpio-loongson1.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-loongson1.c b/drivers/gpio/gpio-loongson1.c
index 3ac9e49e7efb..94ac0ccb450f 100644
--- a/drivers/gpio/gpio-loongson1.c
+++ b/drivers/gpio/gpio-loongson1.c
@@ -68,25 +68,38 @@ static int ls1x_gpio_probe(struct platform_device *pdev)
 	ls1x_gc->gc.owner = THIS_MODULE;
 	ls1x_gc->gc.request = ls1x_gpio_request;
 	ls1x_gc->gc.free = ls1x_gpio_free;
-	ls1x_gc->gc.base = pdev->id * 32;
+	/*
+	 * Clear ngpio to let gpiolib get the correct number
+	 * by reading ngpios property
+	 */
+	ls1x_gc->gc.ngpio = 0;
 
 	ret = devm_gpiochip_add_data(dev, &ls1x_gc->gc, ls1x_gc);
 	if (ret)
 		goto err;
 
 	platform_set_drvdata(pdev, ls1x_gc);
-	dev_info(dev, "Loongson1 GPIO driver registered\n");
+
+	dev_info(dev, "GPIO controller registered with %d pins\n",
+		 ls1x_gc->gc.ngpio);
 
 	return 0;
 err:
-	dev_err(dev, "failed to register GPIO device\n");
+	dev_err(dev, "failed to register GPIO controller\n");
 	return ret;
 }
 
+static const struct of_device_id ls1x_gpio_dt_ids[] = {
+	{ .compatible = "loongson,ls1x-gpio" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ls1x_gpio_dt_ids);
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

