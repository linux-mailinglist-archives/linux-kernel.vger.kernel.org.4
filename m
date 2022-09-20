Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EA95BE348
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiITKco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiITKb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:31:28 -0400
Received: from mail-m11875.qiye.163.com (mail-m11875.qiye.163.com [115.236.118.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2006F275
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 03:31:26 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11875.qiye.163.com (Hmail) with ESMTPA id 42E5D280BD8;
        Tue, 20 Sep 2022 18:31:24 +0800 (CST)
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     linus.walleij@linaro.org, heiko@sntech.de, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com
Cc:     robert.moore@intel.com, robh@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, rafael@kernel.org,
        Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH 19/20] gpio/rockchip: make GPIO module work well under ACPI enabled
Date:   Tue, 20 Sep 2022 18:31:07 +0800
Message-Id: <20220920103108.23074-20-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920103108.23074-1-jay.xu@rock-chips.com>
References: <20220920103108.23074-1-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSUpJVh5DSUpOGkgeTEtDSFUTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NzY6Fxw4TD0fFBwpVgodLxIy
        GkgaCRpVSlVKTU1ITU1CQ0NPQk1DVTMWGhIXVREaAlUDDjsJFBgQVhgTEgsIVRgUFkVZV1kSC1lB
        WU5DVUlJVUxVSkpPWVdZCAFZQUpLT0lNNwY+
X-HM-Tid: 0a835a73d67c2eb1kusn42e5d280bd8
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO driver for Rockchip GPIO controller is seperated from rockchip
pinctrl driver, at the first version, it keeps things original to make
the patch easy to be reviewed, such as the GPIO driver must work with
the pinctrl dt node to be its parent node.

This patch wants to fix the driver to support ACPI since GPIO controller
should work well during ACPI is enabled.

This patch do changes including:
- only get clocks when is_of_node since ACPI case not need.
- use fwnode instead of of_node
- use private device structure mostly copy from pinctrl
- drop pinctrl related codes, pinctrl self should to find the gpiochip

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 drivers/gpio/gpio-rockchip.c | 205 ++++++++++++++++++++---------------
 1 file changed, 120 insertions(+), 85 deletions(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index a94ebd95d285..01b214b84c71 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -18,20 +18,88 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/regmap.h>
 
-#include "../pinctrl/core.h"
-#include "../pinctrl/pinctrl-rockchip.h"
-
 #define GPIO_TYPE_V1		(0)           /* GPIO Version ID reserved */
 #define GPIO_TYPE_V2		(0x01000C2B)  /* GPIO Version ID 0x01000C2B */
 #define GPIO_TYPE_V2_1		(0x0101157C)  /* GPIO Version ID 0x0101157C */
 
 #define GPIO_MAX_PINS	(32)
 
+/**
+ * struct rockchip_gpio_regs
+ * @port_dr: data register
+ * @port_ddr: data direction register
+ * @int_en: interrupt enable
+ * @int_mask: interrupt mask
+ * @int_type: interrupt trigger type, such as high, low, edge trigger type.
+ * @int_polarity: interrupt polarity enable register
+ * @int_bothedge: interrupt bothedge enable register
+ * @int_status: interrupt status register
+ * @int_rawstatus: int_status = int_rawstatus & int_mask
+ * @debounce: enable debounce for interrupt signal
+ * @dbclk_div_en: enable divider for debounce clock
+ * @dbclk_div_con: setting for divider of debounce clock
+ * @port_eoi: end of interrupt of the port
+ * @ext_port: port data from external
+ * @version_id: controller version register
+ */
+struct rockchip_gpio_regs {
+	u32 port_dr;
+	u32 port_ddr;
+	u32 int_en;
+	u32 int_mask;
+	u32 int_type;
+	u32 int_polarity;
+	u32 int_bothedge;
+	u32 int_status;
+	u32 int_rawstatus;
+	u32 debounce;
+	u32 dbclk_div_en;
+	u32 dbclk_div_con;
+	u32 port_eoi;
+	u32 ext_port;
+	u32 version_id;
+};
+
+/**
+ * struct rockchip_pin_bank
+ * @dev: the pinctrl device bind to the bank
+ * @reg_base: register base of the gpio bank
+ * @clk: clock of the gpio bank
+ * @db_clk: clock of the gpio debounce
+ * @irq: interrupt of the gpio bank
+ * @saved_masks: Saved content of GPIO_INTEN at suspend time.
+ * @pin_base: first pin number
+ * @nr_pins: number of pins in this bank
+ * @name: name of the bank
+ * @bank_num: number of the bank, to account for holes
+ * @domain: irqdomain of the gpio bank
+ * @gpio_chip: gpiolib chip
+ * @grange: gpio range
+ * @slock: spinlock for the gpio bank
+ * @toggle_edge_mode: bit mask to toggle (falling/rising) edge mode
+ */
+struct rockchip_pin_bank {
+	struct gpio_chip		gpio_chip;
+	struct device			*dev;
+	void __iomem			*reg_base;
+	struct clk			*clk;
+	struct clk			*db_clk;
+	int				irq;
+	u32				saved_masks;
+	u32				pin_base;
+	u8				nr_pins;
+	char				*name;
+	u8				bank_num;
+	struct device_node		*of_node;
+	struct irq_domain		*domain;
+	raw_spinlock_t			slock;
+	const struct rockchip_gpio_regs	*gpio_regs;
+	u32				gpio_type;
+	u32				toggle_edge_mode;
+};
+
 static const struct rockchip_gpio_regs gpio_regs_v1 = {
 	.port_dr = 0x00,
 	.port_ddr = 0x04,
@@ -607,35 +675,6 @@ static int rockchip_gpiolib_register(struct rockchip_pin_bank *bank)
 		return ret;
 	}
 
-	/*
-	 * For DeviceTree-supported systems, the gpio core checks the
-	 * pinctrl's device node for the "gpio-ranges" property.
-	 * If it is present, it takes care of adding the pin ranges
-	 * for the driver. In this case the driver can skip ahead.
-	 *
-	 * In order to remain compatible with older, existing DeviceTree
-	 * files which don't set the "gpio-ranges" property or systems that
-	 * utilize ACPI the driver has to call gpiochip_add_pin_range().
-	 */
-	if (!of_property_read_bool(bank->of_node, "gpio-ranges")) {
-		struct device_node *pctlnp = of_get_parent(bank->of_node);
-		struct pinctrl_dev *pctldev = NULL;
-
-		if (!pctlnp)
-			return -ENODATA;
-
-		pctldev = of_pinctrl_get(pctlnp);
-		if (!pctldev)
-			return -ENODEV;
-
-		ret = gpiochip_add_pin_range(gc, dev_name(pctldev->dev), 0,
-					     gc->base, gc->ngpio);
-		if (ret) {
-			dev_err(bank->dev, "Failed to add pin range\n");
-			goto fail;
-		}
-	}
-
 	ret = rockchip_interrupts_register(bank);
 	if (ret) {
 		dev_err(bank->dev, "failed to register interrupt, %d\n", ret);
@@ -650,52 +689,53 @@ static int rockchip_gpiolib_register(struct rockchip_pin_bank *bank)
 	return ret;
 }
 
-static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
+static int rockchip_gpio_set_regs(struct rockchip_pin_bank *bank)
 {
-	int id = 0;
+	struct device *dev = bank->dev;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	int version_id;
+	int ret;
 
-	bank->clk = of_clk_get(bank->of_node, 0);
-	if (IS_ERR(bank->clk))
-		return PTR_ERR(bank->clk);
+	if (is_of_node(fwnode)) {
+		bank->clk = of_clk_get(to_of_node(fwnode), 0);
+		if (IS_ERR(bank->clk))
+			return PTR_ERR(bank->clk);
 
-	clk_prepare_enable(bank->clk);
-	id = readl(bank->reg_base + gpio_regs_v2.version_id);
+		ret = clk_prepare_enable(bank->clk);
+		if (ret < 0)
+			goto put_clk;
+	}
 
-	/* If not gpio v2, that is default to v1. */
-	if (id == GPIO_TYPE_V2 || id == GPIO_TYPE_V2_1) {
+	version_id = readl(bank->reg_base + gpio_regs_v2.version_id);
+	if (version_id == GPIO_TYPE_V2 || version_id == GPIO_TYPE_V2_1) {
 		bank->gpio_regs = &gpio_regs_v2;
 		bank->gpio_type = GPIO_TYPE_V2;
-		bank->db_clk = of_clk_get(bank->of_node, 1);
-		if (IS_ERR(bank->db_clk)) {
-			dev_err(bank->dev, "cannot find debounce clk\n");
-			clk_disable_unprepare(bank->clk);
-			return -EINVAL;
-		}
 	} else {
 		bank->gpio_regs = &gpio_regs_v1;
 		bank->gpio_type = GPIO_TYPE_V1;
 	}
 
-	return 0;
-}
-
-static struct rockchip_pin_bank *
-rockchip_gpio_find_bank(struct pinctrl_dev *pctldev, int id)
-{
-	struct rockchip_pinctrl *info;
-	struct rockchip_pin_bank *bank;
-	int i, found = 0;
+	if (bank->gpio_type == GPIO_TYPE_V2 && is_of_node(fwnode)) {
+		bank->db_clk = of_clk_get(to_of_node(fwnode), 1);
+		if (IS_ERR(bank->db_clk)) {
+			ret = PTR_ERR(bank->db_clk);
+			goto unprepare_clk;
+		}
 
-	info = pinctrl_dev_get_drvdata(pctldev);
-	bank = info->ctrl->pin_banks;
-	for (i = 0; i < info->ctrl->nr_banks; i++, bank++) {
-		if (bank->bank_num == id) {
-			found = 1;
-			break;
+		ret = clk_prepare_enable(bank->db_clk);
+		if (ret < 0) {
+			clk_put(bank->db_clk);
+			goto unprepare_clk;
 		}
 	}
 
-	return found ? bank : NULL;
+	return 0;
+unprepare_clk:
+	clk_disable_unprepare(bank->clk);
+put_clk:
+	clk_put(bank->clk);
+
+	return ret;
 }
 
 static int rockchip_gpio_get_bank_id(struct device *dev)
@@ -724,18 +764,20 @@ static int rockchip_gpio_get_bank_id(struct device *dev)
 static int rockchip_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	struct device_node *pctlnp = of_get_parent(np);
-	struct pinctrl_dev *pctldev = NULL;
-	struct rockchip_pin_bank *bank = NULL;
+	struct rockchip_pin_bank *bank;
 	int ret;
 
-	if (!np || !pctlnp)
-		return -ENODEV;
+	bank = devm_kzalloc(dev, sizeof(*bank), GFP_KERNEL);
+	if (!bank)
+		return -ENOMEM;
+
+	bank->reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(bank->reg_base))
+		return PTR_ERR(bank->reg_base);
 
-	pctldev = of_pinctrl_get(pctlnp);
-	if (!pctldev)
-		return -EPROBE_DEFER;
+	bank->irq = platform_get_irq(pdev, 0);
+	if (bank->irq < 0)
+		return bank->irq;
 
 	ret = rockchip_gpio_get_bank_id(dev);
 	if (ret >= 0)
@@ -744,22 +786,15 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 		goto err;
 
 	bank->dev = dev;
-	bank->of_node = np;
+	bank->pin_base = GPIO_MAX_PINS * bank->bank_num;
+	bank->nr_pins = GPIO_MAX_PINS;
 
 	raw_spin_lock_init(&bank->slock);
 
-	ret = rockchip_get_bank_data(bank);
+	ret = rockchip_gpio_set_regs(bank);
 	if (ret)
 		return ret;
 
-	bank->reg_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(bank->reg_base))
-		return PTR_ERR(bank->reg_base);
-
-	bank->irq = platform_get_irq(pdev, 0);
-	if (bank->irq < 0)
-		return bank->irq;
-
 	ret = rockchip_gpiolib_register(bank);
 	if (ret) {
 		dev_err(bank->dev, "Failed to register gpio %d\n", ret);
-- 
2.25.1

