Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80766653813
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 22:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbiLUVKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 16:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbiLUVJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 16:09:55 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D54E427174;
        Wed, 21 Dec 2022 13:09:50 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,263,1665414000"; 
   d="scan'208";a="146995954"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 22 Dec 2022 06:09:50 +0900
Received: from mulinux.example.org (unknown [10.226.92.211])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 86F4040DC546;
        Thu, 22 Dec 2022 06:09:45 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH v2 3/4] gpio: Add support for the Renesas RZ/V2M PWC GPIOs
Date:   Wed, 21 Dec 2022 21:09:16 +0000
Message-Id: <20221221210917.458537-4-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221221210917.458537-1-fabrizio.castro.jz@renesas.com>
References: <20221221210917.458537-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RZ/V2M SoC contains an External Power Sequence Controller
(PWC) module. The PWC module provides an external power supply
on/off sequence, on/off signal for the LPDDR4 core power supply,
General-Purpose Outputs, and key input signals.

Add a driver for controlling the General-Purpose Outputs.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---

v1->v2: Dropped OF match table and syscon as a result of the change in
        DT model

 drivers/gpio/Kconfig          |  10 ++++
 drivers/gpio/Makefile         |   1 +
 drivers/gpio/gpio-rzv2m-pwc.c | 105 ++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+)
 create mode 100644 drivers/gpio/gpio-rzv2m-pwc.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index ec7cfd4f52b1..4c77fb6966e0 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -553,6 +553,16 @@ config GPIO_ROCKCHIP
 	help
 	  Say yes here to support GPIO on Rockchip SoCs.
 
+config GPIO_RZV2M_PWC
+	tristate "Renesas RZ/V2M PWC GPIO support"
+	depends on MFD_RZV2M_PWC_CORE || COMPILE_TEST
+	help
+	  Say yes here to support the External Power Sequence Controller (PWC)
+	  GPIO controller driver for RZ/V2M devices.
+
+	  The PWSDxSEL pins can be used as General-Purpose Ouputs.
+	  Their output is low by default.
+
 config GPIO_SAMA5D2_PIOBU
 	tristate "SAMA5D2 PIOBU GPIO support"
 	depends on MFD_SYSCON
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 010587025fc8..a5c159ae9db5 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -132,6 +132,7 @@ obj-$(CONFIG_GPIO_RDC321X)		+= gpio-rdc321x.o
 obj-$(CONFIG_GPIO_REALTEK_OTTO)		+= gpio-realtek-otto.o
 obj-$(CONFIG_GPIO_REG)			+= gpio-reg.o
 obj-$(CONFIG_GPIO_ROCKCHIP)	+= gpio-rockchip.o
+obj-$(CONFIG_GPIO_RZV2M_PWC)		+= gpio-rzv2m-pwc.o
 obj-$(CONFIG_ARCH_SA1100)		+= gpio-sa1100.o
 obj-$(CONFIG_GPIO_SAMA5D2_PIOBU)	+= gpio-sama5d2-piobu.o
 obj-$(CONFIG_GPIO_SCH311X)		+= gpio-sch311x.o
diff --git a/drivers/gpio/gpio-rzv2m-pwc.c b/drivers/gpio/gpio-rzv2m-pwc.c
new file mode 100644
index 000000000000..19bdb949b3d3
--- /dev/null
+++ b/drivers/gpio/gpio-rzv2m-pwc.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ *
+ * GPIO driver for Renesas RZ/V2M External Power Sequence Controller (PWC)
+ */
+
+#include <linux/gpio/driver.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include "../mfd/rzv2m-pwc.h"
+
+struct rzv2m_pwc_gpio_priv {
+	void __iomem *base;
+	struct gpio_chip gp;
+	DECLARE_BITMAP(ch_en_bits, 2);
+};
+
+static void rzv2m_pwc_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			       int value)
+{
+	struct rzv2m_pwc_gpio_priv *priv = gpiochip_get_data(chip);
+	u32 reg;
+
+	/* BIT 16 enables write to BIT 0, and BIT 17 enables write to BIT 1 */
+	reg = BIT(offset + 16);
+	if (value)
+		reg |= BIT(offset);
+
+	writel(reg, priv->base + PWC_GPIO);
+
+	if (value)
+		set_bit(offset, priv->ch_en_bits);
+	else
+		clear_bit(offset, priv->ch_en_bits);
+}
+
+static int rzv2m_pwc_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct rzv2m_pwc_gpio_priv *priv = gpiochip_get_data(chip);
+
+	return test_bit(offset, priv->ch_en_bits);
+}
+
+static int rzv2m_pwc_gpio_direction_output(struct gpio_chip *gc,
+					   unsigned int nr, int value)
+{
+	if (nr > 1)
+		return -EINVAL;
+
+	rzv2m_pwc_gpio_set(gc, nr, value);
+
+	return 0;
+}
+
+static const struct gpio_chip rzv2m_pwc_gc = {
+	.label = "gpio_rzv2m_pwc",
+	.owner = THIS_MODULE,
+	.get = rzv2m_pwc_gpio_get,
+	.set = rzv2m_pwc_gpio_set,
+	.direction_output = rzv2m_pwc_gpio_direction_output,
+	.can_sleep = false,
+	.ngpio = 2,
+	.base = -1,
+};
+
+static int rzv2m_pwc_gpio_probe(struct platform_device *pdev)
+{
+	struct rzv2m_pwc_priv *pdata = dev_get_drvdata(pdev->dev.parent);
+	struct rzv2m_pwc_gpio_priv *priv;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = pdata->base;
+	/*
+	 * The register used by this driver cannot be read, therefore set the
+	 * outputs to their default values and initialize priv->ch_en_bits
+	 * accordingly. BIT 16 enables write to BIT 0, BIT 17 enables write to
+	 * BIT 1, and the default value of both BIT 0 and BIT 1 is 0.
+	 */
+	writel(BIT(17) | BIT(16), priv->base + PWC_GPIO);
+	bitmap_zero(priv->ch_en_bits, 2);
+
+	priv->gp = rzv2m_pwc_gc;
+	priv->gp.parent = pdev->dev.parent;
+	priv->gp.fwnode = dev_fwnode(pdev->dev.parent);
+
+	return devm_gpiochip_add_data(&pdev->dev, &priv->gp, priv);
+}
+
+static struct platform_driver rzv2m_pwc_gpio_driver = {
+	.probe = rzv2m_pwc_gpio_probe,
+	.driver = {
+		.name = "gpio_rzv2m_pwc",
+	},
+};
+module_platform_driver(rzv2m_pwc_gpio_driver);
+
+MODULE_ALIAS("platform:gpio_rzv2m_pwc");
+MODULE_SOFTDEP("pre: rzv2m_pwc");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Fabrizio Castro <castro.fabrizio.jz@renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/V2M PWC GPIO");
-- 
2.34.1

