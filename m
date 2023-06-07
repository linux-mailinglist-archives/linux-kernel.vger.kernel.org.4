Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885D772630E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241147AbjFGOjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241134AbjFGOjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:39:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A802172E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 07:39:39 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f7353993cbso5816185e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 07:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686148778; x=1688740778;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrxwmFyl84EkZ99Fi7aHWrEf0BVcmyyx2qC7ribbpYE=;
        b=MD1yb/zVjYTK/SBHZWnmyzNL3CZtADL/Cb+joQntGmNA5DQRSNcfUqx7F04lFIOkam
         uXLLRhYQPetJk9Ib42IvyBqwSMRaRbsFr9OovLT+hE93Swav2FmZT/z0RClccRLI2cKg
         58wyTZfGCOMuK0DyHmgUd9jqQ3biFBkIvB4Wn/9IuMIyUn4onqccKquketS1kA8vFzf0
         Fq5r7CfjBxEl8LQAu9lemU+CNT30F6E6NuVWyrxkpVz5iXqHAL0+Zd+PjV7JGe39cXnu
         ce3N/sNOBT5MwBplvOD8kjniiyGFEOkBX/hUUjUrVvLKWZZTk6D7Wat8xC8IRQPMv2aP
         d6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686148778; x=1688740778;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrxwmFyl84EkZ99Fi7aHWrEf0BVcmyyx2qC7ribbpYE=;
        b=cRF98L4OV0sd1pLlwAURB9mgf+0dqYN/or96nQuLobLPnqTOGR709/C/gQUIIYrOon
         OWps1R9FBR53iV9s89mUi7RJ9UMbUS6LpDI4EdsBzNZIBiJt9c55QQDPj7FP6yNVXBOz
         fZQQtMt2THq97hRDeQxd9Vpcd6EsVzFgaxCe/xfR4vANxo5evTMnP0x2Vh940egc9oBf
         PqaQfTS5AhPvZbJfA16P3PeBTd84+XKcb9i2aVAbKwxB63Dav/fRZWtuo1lJ7EGPgS98
         nb5ahiMamjmJzM7kZtghC/tIVpSEcZSFdkOIDVoansZQAv7gViwgUvFutqhDQZ3YbCvl
         JAWQ==
X-Gm-Message-State: AC+VfDx43T+wmGt5lXg4yiAlGgTVsLdpjCXeZzVY/rNelBNx5PhY+HqS
        EsDdrg/uoXrN39q/FaSk6vyMxs/vzvNcKJ/3ZVJIw/8O
X-Google-Smtp-Source: ACHHUZ7nDMbqJ3wdE7BxYXHpKar9rUZs/F1U9atp2OnxQesIGjiOW5G9mqJVZZDJJ8xPDOK88pjXfQ==
X-Received: by 2002:a7b:c845:0:b0:3f7:2b61:4c98 with SMTP id c5-20020a7bc845000000b003f72b614c98mr4340657wml.13.1686148777845;
        Wed, 07 Jun 2023 07:39:37 -0700 (PDT)
Received: from [127.0.1.1] (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c021800b003f7ea771b5dsm2380720wmi.1.2023.06.07.07.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 07:39:37 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
Date:   Wed, 07 Jun 2023 16:39:31 +0200
Subject: [PATCH v5 1/2] gpio: tps65219: add GPIO support for TPS65219 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230511-tps65219-add-gpio-support-v5-1-ebb94281c854@baylibre.com>
References: <20230511-tps65219-add-gpio-support-v5-0-ebb94281c854@baylibre.com>
In-Reply-To: <20230511-tps65219-add-gpio-support-v5-0-ebb94281c854@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>
Cc:     khilman@baylibre.com, msp@baylibre.com, francesco@dolcini.it,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>,
        Jerome Neanne <jneanne@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686148775; l=8835;
 i=jneanne@baylibre.com; s=20230511; h=from:subject:message-id;
 bh=7Z2jhHXDBqlqeVh9K6h13IPtJSbJ7CGix7zSNhqQauk=;
 b=RLNM5Gff7cjuJMhzrrbQGWXvFFYNMmc8/z/nsb1ypN5Eqq2KeRUcKuM4dV39JbfL1Zg4hSge/
 UgAOfSM0DfqDvVDYYCiMX/0Y1g1FJ3ZsKQWU8j9XeLEfynSCU0ikHO5
X-Developer-Key: i=jneanne@baylibre.com; a=ed25519;
 pk=5rvbqNoG+28jQjC9/50ToY7TgKWf9rJukuCI8b6jkUo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for TPS65219 PMICs GPIO interface.

3 GPIO pins:
- GPIO0 only is IO but input mode reserved for MULTI_DEVICE_ENABLE usage.
- GPIO1 and GPIO2 are Output only and referred as GPO1 and GPO2 in spec.

GPIO0 is statically configured as input or output prior to Linux boot.
it is used for MULTI_DEVICE_ENABLE function.
This setting is statically configured by NVM.
GPIO0 can't be used as a generic GPIO (specification Table 8-34).
It's either a GPO when MULTI_DEVICE_EN=0 or a GPI when MULTI_DEVICE_EN=1.

Datasheet describes specific usage for non standard GPIO.

Datasheet: https://www.ti.com/lit/ds/symlink/tps65219.pdf
Co-developed-by: Jonathan Cormier <jcormier@criticallink.com>
Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 MAINTAINERS                  |   1 +
 drivers/gpio/Kconfig         |  16 ++++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-tps65219.c | 185 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 203 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c0cde28c62c6..d912b7465e84 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15398,6 +15398,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
 F:	arch/arm/configs/omap2plus_defconfig
 F:	arch/arm/mach-omap2/
 F:	drivers/bus/ti-sysc.c
+F:	drivers/gpio/gpio-tps65219.c
 F:	drivers/i2c/busses/i2c-omap.c
 F:	drivers/irqchip/irq-omap-intc.c
 F:	drivers/mfd/*omap*.c
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 5521f060d58e..047af064335d 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1440,6 +1440,22 @@ config GPIO_TPS65218
 	  Select this option to enable GPIO driver for the TPS65218
 	  chip family.
 
+config GPIO_TPS65219
+	tristate "TPS65219 GPIO"
+	depends on MFD_TPS65219
+	default MFD_TPS65219
+	help
+	  Select this option to enable GPIO driver for the TPS65219 chip
+	  family.
+	  GPIO0 is statically configured as either input or output prior to
+	  Linux boot. It is used for MULTI_DEVICE_ENABLE function. This setting
+	  is statically configured by NVM. GPIO0 can't be used as a generic
+	  GPIO. It's either a GPO when MULTI_DEVICE_EN=0 or a GPI when
+	  MULTI_DEVICE_EN=1.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called gpio_tps65219.
+
 config GPIO_TPS6586X
 	bool "TPS6586X GPIO"
 	depends on MFD_TPS6586X
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 20036af3acb1..7843b16f5d59 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -160,6 +160,7 @@ obj-$(CONFIG_GPIO_TN48M_CPLD)		+= gpio-tn48m.o
 obj-$(CONFIG_GPIO_TPIC2810)		+= gpio-tpic2810.o
 obj-$(CONFIG_GPIO_TPS65086)		+= gpio-tps65086.o
 obj-$(CONFIG_GPIO_TPS65218)		+= gpio-tps65218.o
+obj-$(CONFIG_GPIO_TPS65219)		+= gpio-tps65219.o
 obj-$(CONFIG_GPIO_TPS6586X)		+= gpio-tps6586x.o
 obj-$(CONFIG_GPIO_TPS65910)		+= gpio-tps65910.o
 obj-$(CONFIG_GPIO_TPS65912)		+= gpio-tps65912.o
diff --git a/drivers/gpio/gpio-tps65219.c b/drivers/gpio/gpio-tps65219.c
new file mode 100644
index 000000000000..7b38aa360112
--- /dev/null
+++ b/drivers/gpio/gpio-tps65219.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GPIO driver for TI TPS65219 PMICs
+ *
+ * Copyright (C) 2022 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include <linux/bits.h>
+#include <linux/gpio/driver.h>
+#include <linux/mfd/tps65219.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
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
+	struct device *dev = gpio->tps->dev;
+	int ret, val;
+
+	if (offset != TPS65219_GPIO0_IDX) {
+		dev_err(dev, "GPIO%d is output only, cannot get\n", offset);
+		return -ENOTSUPP;
+	}
+
+	ret = regmap_read(gpio->tps->regmap, TPS65219_REG_MFP_CTRL, &val);
+	if (ret)
+		return ret;
+
+	ret = !!(val & BIT(TPS65219_MFP_GPIO_STATUS_MASK));
+	dev_warn(dev, "GPIO%d = %d, MULTI_DEVICE_ENABLE, not a standard GPIO\n", offset, ret);
+
+	/*
+	 * Depending on NVM config, return an error if direction is output, otherwise the GPIO0
+	 * status bit.
+	 */
+
+	if (tps65219_gpio_get_direction(gc, offset) == TPS65219_GPIO_DIR_OUT)
+		return -ENOTSUPP;
+
+	return ret;
+}
+
+static void tps65219_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
+{
+	struct tps65219_gpio *gpio = gpiochip_get_data(gc);
+	struct device *dev = gpio->tps->dev;
+	int v, mask, bit;
+
+	bit = (offset == TPS65219_GPIO0_IDX) ? TPS65219_GPIO0_OFFSET : offset - 1;
+
+	mask = BIT(bit);
+	v = value ? mask : 0;
+
+	if (regmap_update_bits(gpio->tps->regmap, TPS65219_REG_GENERAL_CONFIG, mask, v))
+		dev_err(dev, "GPIO%d, set to value %d failed.\n", offset, value);
+}
+
+static int tps65219_gpio_change_direction(struct gpio_chip *gc, unsigned int offset,
+					  unsigned int direction)
+{
+	struct tps65219_gpio *gpio = gpiochip_get_data(gc);
+	struct device *dev = gpio->tps->dev;
+
+	/*
+	 * Documentation is stating that GPIO0 direction must not be changed in Linux:
+	 * Table 8-34. MFP_1_CONFIG(3): MULTI_DEVICE_ENABLE, should only be changed in INITIALIZE
+	 * state (prior to ON Request).
+	 * Set statically by NVM, changing direction in application can cause a hang.
+	 * Below can be used for test purpose only.
+	 */
+
+	if (IS_ENABLED(CONFIG_DEBUG_GPIO)) {
+		int ret = regmap_update_bits(gpio->tps->regmap, TPS65219_REG_MFP_1_CONFIG,
+					     TPS65219_GPIO0_DIR_MASK, direction);
+		if (ret) {
+			dev_err(dev,
+				"GPIO DEBUG enabled: Fail to change direction to %u for GPIO%d.\n",
+				direction, offset);
+			return ret;
+		}
+	}
+
+	dev_err(dev,
+		"GPIO%d direction set by NVM, change to %u failed, not allowed by specification\n",
+		 offset, direction);
+
+	return -ENOTSUPP;
+}
+
+static int tps65219_gpio_direction_input(struct gpio_chip *gc, unsigned int offset)
+{
+	struct tps65219_gpio *gpio = gpiochip_get_data(gc);
+	struct device *dev = gpio->tps->dev;
+
+	if (offset != TPS65219_GPIO0_IDX) {
+		dev_err(dev, "GPIO%d is output only, cannot change to input\n", offset);
+		return -ENOTSUPP;
+	}
+
+	if (tps65219_gpio_get_direction(gc, offset) == TPS65219_GPIO_DIR_IN)
+		return 0;
+
+	return tps65219_gpio_change_direction(gc, offset, TPS65219_GPIO_DIR_IN);
+}
+
+static int tps65219_gpio_direction_output(struct gpio_chip *gc, unsigned int offset, int value)
+{
+	tps65219_gpio_set(gc, offset, value);
+	if (offset != TPS65219_GPIO0_IDX)
+		return 0;
+
+	if (tps65219_gpio_get_direction(gc, offset) == TPS65219_GPIO_DIR_OUT)
+		return 0;
+
+	return tps65219_gpio_change_direction(gc, offset, TPS65219_GPIO_DIR_OUT);
+}
+
+static const struct gpio_chip tps65219_template_chip = {
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
+	gpio->gpio_chip = tps65219_template_chip;
+	gpio->gpio_chip.parent = tps->dev;
+
+	return devm_gpiochip_add_data(&pdev->dev, &gpio->gpio_chip, gpio);
+}
+
+static struct platform_driver tps65219_gpio_driver = {
+	.driver = {
+		.name = "tps65219-gpio",
+	},
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

