Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E987157D1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjE3IAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjE3IAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:00:30 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0250FA
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:00:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6094cb2d2so42982035e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685433625; x=1688025625;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T89fO1iX8dooBAHqyAxjAzopLWomNCu3kMntxjnKti8=;
        b=DiPCoeIM64Gd9saJ1HkPXbYkIomeQl5CiKgkBA4c0LZdBNWGpd1RNXtMfOc+F+v9lA
         xXFsYZlE5f8L62iVTNeRaARGO3aW2iYsB8WEzDu/V+s+8N/qE6EFmuKmsCCS2Y13Y1ZQ
         XcTdx+4SoesTkJuCf9u7fpA6XcTc9LiteBusuYUie3BGtIKZJ5OzMYt8YZioc5arJNp1
         vh9BCeIBRsnIHjKC2pOD7nUI06cckRN8bBynfrysnQvr0Okeq8lnuRYqBXwneuQhDkCf
         n308sp8QqmJjjmKGXjbkLCMf8HjSyEp07ADJeBa8KY3EkPSvazz+Rg/xEWAruvFy7NHb
         Gy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685433625; x=1688025625;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T89fO1iX8dooBAHqyAxjAzopLWomNCu3kMntxjnKti8=;
        b=OZn80C4rFGrzUUaCFsn4oEhXKhKRmBHepWZTNBhBP/lS1qiwLx/uON8gzY7VMEI16n
         bB009R+r6yfeJ5UK6GJS/y4ItLC9JJyjjWNh/aogFr7/Tk55Ck8ptzVAC411CzYcfzVT
         W9skeILDo2qM242LDmLJwjdrlQekrLVFHEWQIFBacwpt2ZTFcFnqj3nvG3qPNv2VmhCL
         ysRABPUNJ85EByV3+P7LwS/gc3htM5Yrd1NvCLTyF91YyrxlDfR6Cia1ujOlFJtsdS0d
         Bu7UVAGWAZ9GS8Rd3qRwdiNqRI1qHA6/eEsRSU11zxt6nYEPWwGGyxORefpkkS6U6hCF
         1NXQ==
X-Gm-Message-State: AC+VfDzzNZLgRb4iOMLB/8Nw0YXcHYw8DvrY1b1NdWzlCW6tN8l1jFVM
        Wv9xciwqz+yD8rQ4rqOxLmD6qSLikxZmeo4glMnFYQ==
X-Google-Smtp-Source: ACHHUZ5tYqYvpO5/2Mh84Xl9HPsN+wlX8jmrBi+E3rUSmNtLMVrzTytmxsTgkjZa4L7CaHGA/mgCqA==
X-Received: by 2002:a1c:f710:0:b0:3f4:2bce:eef8 with SMTP id v16-20020a1cf710000000b003f42bceeef8mr926151wmh.16.1685433624958;
        Tue, 30 May 2023 01:00:24 -0700 (PDT)
Received: from [127.0.1.1] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b003f6050d35c9sm16409978wmc.20.2023.05.30.01.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 01:00:24 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
Date:   Tue, 30 May 2023 09:59:59 +0200
Subject: [PATCH v4 1/2] gpio: tps65219: add GPIO support for TPS65219 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230511-tps65219-add-gpio-support-v4-1-b5d6a764d722@baylibre.com>
References: <20230511-tps65219-add-gpio-support-v4-0-b5d6a764d722@baylibre.com>
In-Reply-To: <20230511-tps65219-add-gpio-support-v4-0-b5d6a764d722@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>
Cc:     khilman@baylibre.com, msp@baylibre.com, francesco@dolcini.it,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>,
        Jerome Neanne <jneanne@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685433622; l=8728;
 i=jneanne@baylibre.com; s=20230511; h=from:subject:message-id;
 bh=8lkoF2Q6EcexrSLp/t/MhnTILTabGq5WU9fo1gYJj6U=;
 b=o6xvJEIXduMBNuzlMSbn/+ju+x0cpAqHGUOkn2bgKS0pRXudK1eTX321Mkh55Mw2NlOIZ6WwJ
 tiN4q176AJvB59LE0mPZYR+0wqI54SHOaSDs662Pg3OSZxnhOc9KlvI
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
- GPIO0 only is IO but input mode reserved for MULTI_DEVICE_ENABLE usage
- GPIO1 and GPIO2 are Output only and referred as GPO1 and GPO2 in spec

GPIO0 is statically configured as input or output prior to Linux boot.
it is used for MULTI_DEVICE_ENABLE function.
This setting is statically configured by NVM.
GPIO0 can't be used as a generic GPIO (specification Table 8-34).
It's either a GPO when MULTI_DEVICE_EN=0 or a GPI when MULTI_DEVICE_EN=1.

Datasheet describes specific usage for non standard GPIO.
Link: https://www.ti.com/lit/ds/symlink/tps65219.pdf

Co-developed-by: Jonathan Cormier <jcormier@criticallink.com>
Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 MAINTAINERS                  |   1 +
 drivers/gpio/Kconfig         |  15 ++++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-tps65219.c | 181 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 198 insertions(+)

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
index 5521f060d58e..337803b3a022 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1440,6 +1440,21 @@ config GPIO_TPS65218
 	  Select this option to enable GPIO driver for the TPS65218
 	  chip family.
 
+config GPIO_TPS65219
+	tristate "TPS65219 GPIO"
+	depends on MFD_TPS65219
+	default MFD_TPS65219
+	help
+	  Select this option to enable GPIO driver for the TPS65219 chip family.
+	  GPIO0 is statically configured as input or output prior to Linux boot.
+	  It is used for MULTI_DEVICE_ENABLE function.
+	  This setting is statically configured by NVM.
+	  GPIO0 can't be used as a generic GPIO.
+	  It's either a GPO when MULTI_DEVICE_EN=0 or a GPI when MULTI_DEVICE_EN=1.
+
+	  This driver can also be built as a module.
+	  If so, the module will be called gpio_tps65219.
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
index 000000000000..0c6ba7021a26
--- /dev/null
+++ b/drivers/gpio/gpio-tps65219.c
@@ -0,0 +1,181 @@
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
+		return -EOPNOTSUPP;
+	}
+
+	ret = regmap_read(gpio->tps->regmap, TPS65219_REG_MFP_CTRL, &val);
+	if (ret)
+		return ret;
+
+	ret = !!(val & BIT(TPS65219_MFP_GPIO_STATUS_MASK));
+	dev_warn(dev, "GPIO%d = %d, MULTI_DEVICE_ENABLE, not a standard GPIO\n", offset, ret);
+
+	/* depends on NVM config return error if dir output else the GPIO0 status bit */
+	if (tps65219_gpio_get_direction(gc, offset) == TPS65219_GPIO_DIR_OUT)
+		return -EOPNOTSUPP;
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
+	 * Table 8-34. MFP_1_CONFIG(3): MULTI_DEVICE_ENABLE,
+	 * Should only be changed in INITIALIZE state (prior to ON Request).
+	 * Set statically by NVM, changing direction in application can cause a hang.
+	 * Below can be used for test purpose only:
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
+	return -EOPNOTSUPP;
+}
+
+static int tps65219_gpio_direction_input(struct gpio_chip *gc, unsigned int offset)
+{
+	struct tps65219_gpio *gpio = gpiochip_get_data(gc);
+	struct device *dev = gpio->tps->dev;
+
+	if (offset != TPS65219_GPIO0_IDX) {
+		dev_err(dev, "GPIO%d is output only, cannot change to input\n", offset);
+		return -EOPNOTSUPP;
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

