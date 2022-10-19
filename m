Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64509604B27
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbiJSPWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbiJSPWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:22:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E1F1D63B5;
        Wed, 19 Oct 2022 08:15:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91C21B8223A;
        Wed, 19 Oct 2022 15:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2D8C433C1;
        Wed, 19 Oct 2022 15:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666192466;
        bh=oHhISD/CzMUmkWxHqFyoeUe7ZEcONDoFgdgwOoTRBYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=imyorfygSIZT3yoeStIWjdN3TSeMWYmRlMZ5hnwx97K39seFcDJYd12q38IubJHar
         1qrliULXdMJdBzD5H0lBgje3cgh9fKgzmKm4mmkoitABTbXSrSenqG4Du4mGdkCj6R
         Wn6IkxkwMKWuT548PQqxHvxw/bhQ29df97xDZuYoLgvpp+0D/u8+7i/dReAFeNWd+U
         mmLXsM3WmS/lCICWEOP6bwONhJVCnEU8Bsnrde/lmLFVsqZr//Su2g18+OPbQpY1Zl
         OjFSCLOTXrexFqt3heo6E0QaYXRZJcmJO+mewQ7KPxHOke+LQVWjIHVJm+vd5vyluI
         5VpU7GS7gJshA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Lennert Buytenhek <buytenh@wantstofly.org>,
        linux-gpio@vger.kernel.org
Subject: [PATCH 11/17] gpio: remove iop driver
Date:   Wed, 19 Oct 2022 17:03:33 +0200
Message-Id: <20221019150410.3851944-11-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221019150410.3851944-1-arnd@kernel.org>
References: <20221019144119.3848027-1-arnd@kernel.org>
 <20221019150410.3851944-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The iop32x platform was removed, and its gpio driver is now
orphaned.

Cc: Lennert Buytenhek <buytenh@wantstofly.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/Kconfig    | 10 -------
 drivers/gpio/Makefile   |  1 -
 drivers/gpio/gpio-iop.c | 59 -----------------------------------------
 3 files changed, 70 deletions(-)
 delete mode 100644 drivers/gpio/gpio-iop.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index a01af1180616..30a2b4214472 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -345,16 +345,6 @@ config GPIO_IMX_SCU
        def_bool y
        depends on IMX_SCU
 
-config GPIO_IOP
-	tristate "Intel IOP GPIO"
-	depends on ARCH_IOP32X || COMPILE_TEST
-	select GPIO_GENERIC
-	help
-	  Say yes here to support the GPIO functionality of a number of Intel
-	  IOP32X or IOP33X series of chips.
-
-	  If unsure, say N.
-
 config GPIO_IXP4XX
 	bool "Intel IXP4xx GPIO"
 	depends on ARCH_IXP4XX
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 29e3beb6548c..b8c2ebc4bc87 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -70,7 +70,6 @@ obj-$(CONFIG_GPIO_I8255)		+= gpio-i8255.o
 obj-$(CONFIG_GPIO_ICH)			+= gpio-ich.o
 obj-$(CONFIG_GPIO_IDT3243X)		+= gpio-idt3243x.o
 obj-$(CONFIG_GPIO_IMX_SCU)		+= gpio-imx-scu.o
-obj-$(CONFIG_GPIO_IOP)			+= gpio-iop.o
 obj-$(CONFIG_GPIO_IT87)			+= gpio-it87.o
 obj-$(CONFIG_GPIO_IXP4XX)		+= gpio-ixp4xx.o
 obj-$(CONFIG_GPIO_JANZ_TTL)		+= gpio-janz-ttl.o
diff --git a/drivers/gpio/gpio-iop.c b/drivers/gpio/gpio-iop.c
deleted file mode 100644
index 7390b5ca09e3..000000000000
--- a/drivers/gpio/gpio-iop.c
+++ /dev/null
@@ -1,59 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * arch/arm/plat-iop/gpio.c
- * GPIO handling for Intel IOP3xx processors.
- *
- * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
- */
-
-#include <linux/err.h>
-#include <linux/module.h>
-#include <linux/gpio/driver.h>
-#include <linux/platform_device.h>
-
-#define IOP3XX_GPOE	0x0000
-#define IOP3XX_GPID	0x0004
-#define IOP3XX_GPOD	0x0008
-
-static int iop3xx_gpio_probe(struct platform_device *pdev)
-{
-	struct gpio_chip *gc;
-	void __iomem *base;
-	int err;
-
-	gc = devm_kzalloc(&pdev->dev, sizeof(*gc), GFP_KERNEL);
-	if (!gc)
-		return -ENOMEM;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	err = bgpio_init(gc, &pdev->dev, 1, base + IOP3XX_GPID,
-			 base + IOP3XX_GPOD, NULL, NULL, base + IOP3XX_GPOE, 0);
-	if (err)
-		return err;
-
-	gc->base = 0;
-	gc->owner = THIS_MODULE;
-	gc->label = "gpio-iop";
-
-	return devm_gpiochip_add_data(&pdev->dev, gc, NULL);
-}
-
-static struct platform_driver iop3xx_gpio_driver = {
-	.driver = {
-		.name = "gpio-iop",
-	},
-	.probe = iop3xx_gpio_probe,
-};
-
-static int __init iop3xx_gpio_init(void)
-{
-	return platform_driver_register(&iop3xx_gpio_driver);
-}
-arch_initcall(iop3xx_gpio_init);
-
-MODULE_DESCRIPTION("GPIO handling for Intel IOP3xx processors");
-MODULE_AUTHOR("Lennert Buytenhek <buytenh@wantstofly.org>");
-MODULE_LICENSE("GPL");
-- 
2.29.2

