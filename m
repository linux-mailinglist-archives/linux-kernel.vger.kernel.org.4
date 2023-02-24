Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14DA6A1B80
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 12:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjBXLiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 06:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjBXLis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 06:38:48 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6F33E634
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 03:38:46 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id p26so11188587wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 03:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oEGDqtr1MO8ofjQLGEKjxybfElMWX+sJVJm1iOsVhc=;
        b=XnVseKxMIZKqwZZxnldVaTj+3QHFKO/dm9tuWBB8qL1T0bb8VsGiO5XTPvGvJhmIRx
         yP4oSM8BLpcD4iyt/N+0FfasYFwS7qecvAbJqOMUfElG1v47xp5ojwMKhSTL0BG/fEE+
         /RC8BEJf3EHGoACjjzQHqoZr7Vy4w1ISYhpoC0x9nHXqFkjxG8E8u4xPwrrpDbNO0UKl
         XLMYfpRUGCWK0rAYN12owXwk1zPuAcozXEy7C+X481kfho7JB291pWbtaQ9nQGnAabUq
         dmqnjC/H1Vq/5e2s3+03ZZZ+diq4YwgqqqHP5Urc1qLfE/nqAHeBIvDYl824ZMLgcX70
         EePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oEGDqtr1MO8ofjQLGEKjxybfElMWX+sJVJm1iOsVhc=;
        b=f2G9MTkBazLjBFIwWDb9KqmPktDs9/B5+Bpnk1Uaqly3mwP0RyjF6XFeVGSzjnAJdE
         nb86m7xuaP5ISiqZOfOwQ8RyUqczeSg9xNVJJVyaq6pL9Qwseynsj6hYsQRPkYJFUZDv
         UhsbUG+Eqb+iK6pR7bmVBEl0d6GskcUuidJUTrbKPgHCooh88OHF2lsvw7Jsem3op5j2
         sBrsaGeghfdRBHagOH8tikvRz6CuTuXV53acuIY9IRHHLmm+J954JQ33V7/qr59Syqg3
         8soYGfJF0kqFaPZUosBAP8MEN6ihhjzRQX/ZdXyyuNZNJvbKNcfSTH4iYiVMAsq9XVXT
         pEHw==
X-Gm-Message-State: AO0yUKW71HuAvXmdBagllNSccX1Ra8jyTsCAiOo1VeyB3HiqwuM+1gHM
        jIMLjJzTXREPTV2OgJjD8BzM4w==
X-Google-Smtp-Source: AK7set/JnNBejXtVhK5kJOxkAtbf53ykasWOr3IJtqCbkk75flWqnQyO4yb3vXcys9CLpZypZj7W6g==
X-Received: by 2002:a05:600c:1652:b0:3e0:c75:7071 with SMTP id o18-20020a05600c165200b003e00c757071mr6880538wmn.5.1677238724927;
        Fri, 24 Feb 2023 03:38:44 -0800 (PST)
Received: from jerome-BL.. (2a02-8440-5241-7427-e801-6f64-356d-2fd7.rev.sfr.net. [2a02:8440:5241:7427:e801:6f64:356d:2fd7])
        by smtp.gmail.com with ESMTPSA id l11-20020adff48b000000b002c592535839sm12769679wro.17.2023.02.24.03.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 03:38:44 -0800 (PST)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, tony@atomide.com,
        lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org, Jerome Neanne <jneanne@baylibre.com>,
        Jonathan Cormier <jcormier@criticallink.com>
Subject: [PATCH 1/2] gpio: tps65219: add GPIO support for TPS65219 PMIC
Date:   Fri, 24 Feb 2023 12:38:36 +0100
Message-Id: <20230224113837.874264-2-jneanne@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230224113837.874264-1-jneanne@baylibre.com>
References: <20230224113837.874264-1-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for TPS65219 PMICs GPIO interface.

3 GPIO pins:
- GPIO0 only is IO but input mode reserved for MULTI_DEVICE_ENABLE usage
- GPIO1 and GPIO2 are Output only and referred as GPO1 and GPO2 in spec

GPIO0 is statically configured as input or output prior to linux boot.
it is used for MULTI_DEVICE_ENABLE function.
This setting is statically configured by NVM.
GPIO0 can't be used as a generic GPIO (specification Table 8-34).
It's either a GPO when MULTI_DEVICE_EN=0
or a GPI when MULTI_DEVICE_EN=1.

Link: https://www.ti.com/lit/ds/symlink/tps65219.pdf
Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 MAINTAINERS                  |   1 +
 drivers/gpio/Kconfig         |  13 +++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-tps65219.c | 167 +++++++++++++++++++++++++++++++++++
 4 files changed, 182 insertions(+)
 create mode 100644 drivers/gpio/gpio-tps65219.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 468f39a37b33..76ed548cb926 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15330,6 +15330,7 @@ F:	arch/arm/configs/omap2plus_defconfig
 F:	arch/arm/mach-omap2/
 F:	arch/arm/plat-omap/
 F:	drivers/bus/ti-sysc.c
+F:	drivers/gpio/gpio-tps65219.c
 F:	drivers/i2c/busses/i2c-omap.c
 F:	drivers/irqchip/irq-omap-intc.c
 F:	drivers/mfd/*omap*.c
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index ec7cfd4f52b1..a1ccc357e1ac 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1385,6 +1385,19 @@ config GPIO_TPS65218
 	  Select this option to enable GPIO driver for the TPS65218
 	  chip family.
 
+config GPIO_TPS65219
+	tristate "TPS65219 GPIO"
+	depends on MFD_TPS65219
+	help
+	  Select this option to enable GPIO driver for the TPS65219
+	  chip family.
+	  GPIO0 is statically configured as input or output prior to linux boot.
+	  it is used for MULTI_DEVICE_ENABLE function.
+	  This setting is statically configured by NVM.
+	  GPIO0 can't be used as a generic GPIO.
+	  It's either a GPO when MULTI_DEVICE_EN=0
+	  or a GPI when MULTI_DEVICE_EN=1.
+
 config GPIO_TPS6586X
 	bool "TPS6586X GPIO"
 	depends on MFD_TPS6586X
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 010587025fc8..c0f570678db0 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -156,6 +156,7 @@ obj-$(CONFIG_GPIO_TN48M_CPLD)		+= gpio-tn48m.o
 obj-$(CONFIG_GPIO_TPIC2810)		+= gpio-tpic2810.o
 obj-$(CONFIG_GPIO_TPS65086)		+= gpio-tps65086.o
 obj-$(CONFIG_GPIO_TPS65218)		+= gpio-tps65218.o
+obj-$(CONFIG_GPIO_TPS65219)		+= gpio-tps65219.o
 obj-$(CONFIG_GPIO_TPS6586X)		+= gpio-tps6586x.o
 obj-$(CONFIG_GPIO_TPS65910)		+= gpio-tps65910.o
 obj-$(CONFIG_GPIO_TPS65912)		+= gpio-tps65912.o
diff --git a/drivers/gpio/gpio-tps65219.c b/drivers/gpio/gpio-tps65219.c
new file mode 100644
index 000000000000..af8d3f54fc2f
--- /dev/null
+++ b/drivers/gpio/gpio-tps65219.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GPIO driver for TI TPS65219 PMICs
+ *
+ * Copyright (C) 2022 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <linux/gpio/driver.h>
+#include <linux/mfd/tps65219.h>
+
+#define TPS65219_GPIO0_DIR_MASK		BIT(3)
+#define TPS65219_GPIO0_OFFSET		2
+#define TPS65219_GPIO0_IDX		0
+#define TPS65219_GPIO_DIR_IN		1
+#define TPS65219_GPIO_DIR_OUT		0
+
+struct tps65219_gpio {
+	struct gpio_chip gpio_chip;
+	struct tps65219 *tps;
+};
+
+static int tps65219_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	struct tps65219_gpio *gpio = gpiochip_get_data(gc);
+	int ret, val;
+
+	if (offset != TPS65219_GPIO0_IDX)
+		return GPIO_LINE_DIRECTION_OUT;
+
+	ret = regmap_read(gpio->tps->regmap, TPS65219_REG_MFP_1_CONFIG, &val);
+	if (ret)
+		return ret;
+
+	return !!(val & TPS65219_GPIO0_DIR_MASK);
+}
+
+static int tps65219_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct tps65219_gpio *gpio = gpiochip_get_data(gc);
+	int ret, val;
+
+	if (offset != TPS65219_GPIO0_IDX) {
+		dev_err(gpio->tps->dev,
+			"GPIO%d is output only, cannot get\n",
+			offset);
+		return -EOPNOTSUPP;
+	}
+
+	ret = regmap_read(gpio->tps->regmap, TPS65219_REG_MFP_CTRL, &val);
+	if (ret)
+		return ret;
+	dev_warn(gpio->tps->dev,
+		 "GPIO%d = %d, used for MULTI_DEVICE_ENABLE, not as standard GPIO\n",
+		 offset, !!(val & BIT(TPS65219_MFP_GPIO_STATUS_MASK)));
+
+	/* depends on NVM config return error if dir output else the GPIO0 status bit */
+	if (tps65219_gpio_get_direction(gc, offset) == TPS65219_GPIO_DIR_OUT)
+		return -EOPNOTSUPP;
+	return !!(val & BIT(TPS65219_MFP_GPIO_STATUS_MASK));
+}
+
+static void tps65219_gpio_set(struct gpio_chip *gc, unsigned int offset,
+			      int value)
+{
+	struct tps65219_gpio *gpio = gpiochip_get_data(gc);
+
+	if (offset != TPS65219_GPIO0_IDX)
+		regmap_update_bits(gpio->tps->regmap,
+				   TPS65219_REG_GENERAL_CONFIG,
+				   BIT(offset - 1), value ? BIT(offset - 1) : 0);
+	else
+		regmap_update_bits(gpio->tps->regmap,
+				   TPS65219_REG_GENERAL_CONFIG,
+				   BIT(TPS65219_GPIO0_OFFSET),
+				   value ? BIT(TPS65219_GPIO0_OFFSET) : 0);
+}
+
+static int tps65219_gpio_change_direction(struct gpio_chip *gc, unsigned int offset,
+					  unsigned int direction)
+{
+	struct tps65219_gpio *gpio = gpiochip_get_data(gc);
+
+	/* Documentation is stating that GPIO0 direction must not be changed in Linux:
+	 * Table 8-34. MFP_1_CONFIG(3): MULTI_DEVICE_ENABLE,
+	 * Should only be changed in INITIALIZE state (prior to ON Request).
+	 * Set statically by NVM, changing direction in application can cause a hang.
+	 * Below can be used for test purpose only:
+	 * ret = regmap_update_bits(gpio->tps->regmap, TPS65219_REG_MFP_1_CONFIG,
+	 *			 TPS65219_GPIO0_DIR_MASK, direction);
+	 */
+	dev_err(gpio->tps->dev,
+		"GPIO%d direction set by NVM, change to %u failed, not allowed by specification\n",
+		 offset, direction);
+	return -EOPNOTSUPP;
+}
+
+static int tps65219_gpio_direction_input(struct gpio_chip *gc, unsigned int offset)
+{
+	struct tps65219_gpio *gpio = gpiochip_get_data(gc);
+
+	if (offset != TPS65219_GPIO0_IDX) {
+		dev_err(gpio->tps->dev,
+			"GPIO%d is output only, cannot change to input\n",
+			offset);
+		return -EOPNOTSUPP;
+	}
+	if (tps65219_gpio_get_direction(gc, offset) == TPS65219_GPIO_DIR_IN)
+		return 0;
+	return tps65219_gpio_change_direction(gc, offset, TPS65219_GPIO_DIR_IN);
+}
+
+static int tps65219_gpio_direction_output(struct gpio_chip *gc, unsigned int offset,
+					  int value)
+{
+	tps65219_gpio_set(gc, offset, value);
+	if (offset != TPS65219_GPIO0_IDX)
+		return 0;
+
+	if (tps65219_gpio_get_direction(gc, offset) == TPS65219_GPIO_DIR_OUT)
+		return 0;
+	return tps65219_gpio_change_direction(gc, offset, TPS65219_GPIO_DIR_OUT);
+}
+
+static const struct gpio_chip tps65219_gpio_chip = {
+	.label			= "tps65219-gpio",
+	.owner			= THIS_MODULE,
+	.get_direction		= tps65219_gpio_get_direction,
+	.direction_input	= tps65219_gpio_direction_input,
+	.direction_output	= tps65219_gpio_direction_output,
+	.get			= tps65219_gpio_get,
+	.set			= tps65219_gpio_set,
+	.base			= -1,
+	.ngpio			= 3,
+	.can_sleep		= true,
+};
+
+static int tps65219_gpio_probe(struct platform_device *pdev)
+{
+	struct tps65219 *tps = dev_get_drvdata(pdev->dev.parent);
+	struct tps65219_gpio *gpio;
+
+	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
+	if (!gpio)
+		return -ENOMEM;
+
+	gpio->tps = tps;
+	gpio->gpio_chip = tps65219_gpio_chip;
+	gpio->gpio_chip.parent = tps->dev;
+
+	return devm_gpiochip_add_data(&pdev->dev, &gpio->gpio_chip, gpio);
+}
+
+static struct platform_driver tps65219_gpio_driver = {
+	.driver = {.name = "tps65219-gpio",},
+	.probe = tps65219_gpio_probe,
+};
+module_platform_driver(tps65219_gpio_driver);
+
+MODULE_ALIAS("platform:tps65219-gpio");
+MODULE_AUTHOR("Jonathan Cormier <jcormier@criticallink.com>");
+MODULE_DESCRIPTION("TPS65219 GPIO driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

