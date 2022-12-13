Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD7E64BF95
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbiLMWoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbiLMWnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:43:47 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25C9B2252A;
        Tue, 13 Dec 2022 14:43:42 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,242,1665414000"; 
   d="scan'208";a="146060139"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Dec 2022 07:43:41 +0900
Received: from mulinux.home (unknown [10.226.93.1])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 326C440F4527;
        Wed, 14 Dec 2022 07:43:35 +0900 (JST)
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
        Jacopo Mondi <jacopo@jmondi.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH 4/5] gpio: Add support for Renesas RZ/V2M PWC
Date:   Tue, 13 Dec 2022 22:43:09 +0000
Message-Id: <20221213224310.543243-5-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221213224310.543243-1-fabrizio.castro.jz@renesas.com>
References: <20221213224310.543243-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RZ/V2M SoC contains an External Power Sequence Controller (PWC)
module. This module provides an external power supply on/off sequence,
on/off signal for the LPDDR4 core power supply, control signals for
external I/O power supplies of the SD host interfaces, and key input
signals.
PWC is essentially a Multi-Function Device (MFD).

The driver just implements the control signals for external I/O
power supplies of the SD host interfaces as gpios, and it relies on
syscon and simple-mfd.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/gpio/Kconfig          |   8 +++
 drivers/gpio/Makefile         |   1 +
 drivers/gpio/gpio-rzv2m-pwc.c | 123 ++++++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+)
 create mode 100644 drivers/gpio/gpio-rzv2m-pwc.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index e6ebc4c90a5d..e016919b9643 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -553,6 +553,14 @@ config GPIO_ROCKCHIP
 	help
 	  Say yes here to support GPIO on Rockchip SoCs.
 
+config GPIO_RZV2M_PWC
+	tristate "Renesas RZ/V2M PWC GPIO support"
+	depends on MFD_SYSCON
+	depends on ARCH_R9A09G011 || COMPILE_TEST
+	help
+	  Say yes here to support the External Power Sequence Controller (PWC)
+	  GPIO controller driver for RZ/V2M devices.
+
 config GPIO_SAMA5D2_PIOBU
 	tristate "SAMA5D2 PIOBU GPIO support"
 	depends on MFD_SYSCON
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 3462a138764a..5f655684603f 100644
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
index 000000000000..672d868cb8c9
--- /dev/null
+++ b/drivers/gpio/gpio-rzv2m-pwc.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ *
+ * GPIO driver for Renesas RZ/V2M External Power Sequence Controller (PWC)
+ */
+
+#include <linux/gpio/driver.h>
+#include <linux/mfd/syscon.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/spinlock.h>
+
+struct rzv2m_pwc_gpio_priv {
+	struct gpio_chip gp;
+	int offset;
+	struct regmap *regmap;
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
+	regmap_write(priv->regmap, priv->offset, reg);
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
+	.label = "rzv2m_pwc_gpio",
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
+	struct rzv2m_pwc_gpio_priv *priv;
+	int err;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+						       "regmap");
+
+	if (IS_ERR(priv->regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->regmap),
+				     "Can't find regmap property");
+
+	err = of_property_read_u32(pdev->dev.of_node, "offset", &priv->offset);
+	if (err)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "Can't find offset property");
+
+	/*
+	 * The register used by this driver cannot be read, therefore set the
+	 * outputs to their default values and initialize priv->ch_en_bits accordingly.
+	 * BIT 16 enables write to BIT 0, BIT 17 enables write to BIT 1, and the
+	 * default value of both BIT 0 and BIT 1 is 0.
+	 */
+	regmap_write(priv->regmap, priv->offset, BIT(17) | BIT(16));
+	bitmap_zero(priv->ch_en_bits, 2);
+
+	priv->gp = rzv2m_pwc_gc;
+	priv->gp.parent = pdev->dev.parent;
+	priv->gp.fwnode = dev_fwnode(&pdev->dev);
+
+	return devm_gpiochip_add_data(&pdev->dev, &priv->gp, priv);
+}
+
+static const struct of_device_id rzv2m_pwc_gpio_of_match[] = {
+	{ .compatible = "renesas,rzv2m-pwc-gpio" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rzv2m_pwc_gpio_of_match);
+
+static struct platform_driver rzv2m_pwc_gpio_driver = {
+	.probe = rzv2m_pwc_gpio_probe,
+	.driver = {
+		.name = "rzv2m_pwc_gpio",
+		.of_match_table = of_match_ptr(rzv2m_pwc_gpio_of_match),
+	},
+};
+module_platform_driver(rzv2m_pwc_gpio_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Fabrizio Castro <castro.fabrizio.jz@renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/V2M PWC GPIO");
-- 
2.34.1

