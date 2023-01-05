Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD03C65F3CB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbjAESe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbjAESdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:33:53 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5ADB9564CE;
        Thu,  5 Jan 2023 10:33:51 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,303,1665414000"; 
   d="scan'208";a="145303727"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Jan 2023 03:33:51 +0900
Received: from mulinux.example.org (unknown [10.226.92.64])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0C00240065A8;
        Fri,  6 Jan 2023 03:33:45 +0900 (JST)
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
Subject: [PATCH v3 2/2] soc: renesas: Add PWC support for RZ/V2M
Date:   Thu,  5 Jan 2023 18:33:19 +0000
Message-Id: <20230105183319.144366-3-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230105183319.144366-1-fabrizio.castro.jz@renesas.com>
References: <20230105183319.144366-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas RZ/V2M External Power Sequence Controller (PWC)
IP is capable of:
* external power supply on/off sequence generation
* on/off signal generation for the LPDDR4 core power supply (LPVDD)
* key input signals processing
* general-purpose output pins

Add the corresponding device driver.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---

v1: In the first version, I had 1 driver for GPIO handling, and 1 driver
    for poweroff handling, both based on syscon to share the mapped
    memory region.
v2: One more driver added to act as MFD core driver. Dropped syscon, and
    dropped the OF compatible string for the GPIO and poweroff drivers.
v3: This new patch merges all the PWC code in 1 new driver.
    It also takes into account the comments received from Bartosz and Geert.
    Since this is a new driver, I have dropped all the Reviewed-by tags
    received on the separated drivers.

 drivers/soc/renesas/Kconfig     |   4 +
 drivers/soc/renesas/Makefile    |   1 +
 drivers/soc/renesas/pwc-rzv2m.c | 141 ++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+)
 create mode 100644 drivers/soc/renesas/pwc-rzv2m.c

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 660498252ec5..4e8b51ba2266 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -330,6 +330,7 @@ config ARCH_R9A09G011
 	bool "ARM64 Platform support for RZ/V2M"
 	select PM
 	select PM_GENERIC_DOMAINS
+	select PWC_RZV2M
 	help
 	  This enables support for the Renesas RZ/V2M SoC.
 
@@ -345,6 +346,9 @@ config ARCH_R9A07G043
 
 endif # RISCV
 
+config PWC_RZV2M
+	bool "Renesas RZ/V2M PWC support" if COMPILE_TEST
+
 config RST_RCAR
 	bool "Reset Controller support for R-Car" if COMPILE_TEST
 
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 535868c9c7e4..6e4e77b0afff 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_ARCH_R9A06G032)	+= r9a06g032-smp.o
 endif
 
 # Family
+obj-$(CONFIG_PWC_RZV2M)		+= pwc-rzv2m.o
 obj-$(CONFIG_RST_RCAR)		+= rcar-rst.o
 obj-$(CONFIG_SYSC_RCAR)		+= rcar-sysc.o
 obj-$(CONFIG_SYSC_RCAR_GEN4)	+= rcar-gen4-sysc.o
diff --git a/drivers/soc/renesas/pwc-rzv2m.c b/drivers/soc/renesas/pwc-rzv2m.c
new file mode 100644
index 000000000000..c83bdbdabb64
--- /dev/null
+++ b/drivers/soc/renesas/pwc-rzv2m.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Renesas Electronics Corporation
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/driver.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+
+#define PWC_PWCRST			0x00
+#define PWC_PWCCKEN			0x04
+#define PWC_PWCCTL			0x50
+#define PWC_GPIO			0x80
+
+#define PWC_PWCRST_RSTSOFTAX		0x1
+#define PWC_PWCCKEN_ENGCKMAIN		0x1
+#define PWC_PWCCTL_PWOFF		0x1
+
+struct rzv2m_pwc_priv {
+	void __iomem *base;
+	struct device *dev;
+	struct gpio_chip gp;
+	DECLARE_BITMAP(ch_en_bits, 2);
+};
+
+static void rzv2m_pwc_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			       int value)
+{
+	struct rzv2m_pwc_priv *priv = gpiochip_get_data(chip);
+	u32 reg;
+
+	/* BIT 16 enables write to BIT 0, and BIT 17 enables write to BIT 1 */
+	reg = BIT(offset + 16);
+	if (value)
+		reg |= BIT(offset);
+
+	writel(reg, priv->base + PWC_GPIO);
+
+	assign_bit(offset, priv->ch_en_bits, value);
+}
+
+static int rzv2m_pwc_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct rzv2m_pwc_priv *priv = gpiochip_get_data(chip);
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
+static int rzv2m_pwc_poweroff(struct sys_off_data *data)
+{
+	struct rzv2m_pwc_priv *priv = data->cb_data;
+
+	writel(PWC_PWCRST_RSTSOFTAX, priv->base + PWC_PWCRST);
+	writel(PWC_PWCCKEN_ENGCKMAIN, priv->base + PWC_PWCCKEN);
+	writel(PWC_PWCCTL_PWOFF, priv->base + PWC_PWCCTL);
+
+	mdelay(150);
+
+	dev_err(priv->dev, "Failed to power off the system");
+
+	return NOTIFY_DONE;
+}
+
+static int rzv2m_pwc_probe(struct platform_device *pdev)
+{
+	struct rzv2m_pwc_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
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
+	priv->gp.fwnode = dev_fwnode(&pdev->dev);
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &priv->gp, priv);
+	if (ret)
+		return ret;
+
+	if (device_property_read_bool(&pdev->dev, "renesas,rzv2m-pwc-power"))
+		ret = devm_register_power_off_handler(&pdev->dev,
+						      rzv2m_pwc_poweroff, priv);
+
+	return ret;
+}
+
+static const struct of_device_id rzv2m_pwc_of_match[] = {
+	{ .compatible = "renesas,rzv2m-pwc" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rzv2m_pwc_of_match);
+
+static struct platform_driver rzv2m_pwc_driver = {
+	.probe = rzv2m_pwc_probe,
+	.driver = {
+		.name = "rzv2m_pwc",
+		.of_match_table = of_match_ptr(rzv2m_pwc_of_match),
+	},
+};
+module_platform_driver(rzv2m_pwc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Fabrizio Castro <castro.fabrizio.jz@renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/V2M PWC driver");
-- 
2.34.1

