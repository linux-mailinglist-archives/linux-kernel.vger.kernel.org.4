Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE4274EA6B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjGKJ1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjGKJ0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:26:46 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 297E12123;
        Tue, 11 Jul 2023 02:23:39 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8Cx2eqaH61kr3MDAA--.4703S3;
        Tue, 11 Jul 2023 17:23:38 +0800 (CST)
Received: from user-pc.202.106.0.20 (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax3c6RH61kf3MoAA--.49398S2;
        Tue, 11 Jul 2023 17:23:38 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH] gpio: loongson: add firmware offset parse support
Date:   Tue, 11 Jul 2023 17:23:28 +0800
Message-Id: <20230711092328.26598-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax3c6RH61kf3MoAA--.49398S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms contain multiple GPIO chips that with different offset
addresses, if using acpi_device_id or of_device_id's data domain to
initialize GPIO chip and different compatibles need to be added, but
this addition is unnecessary because these GPIO chips are compatible
with each other. Therefore, this driver adds support for parsing the
necessary offset elements of GPIO chips from firmware to fix such
issue.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
 drivers/gpio/gpio-loongson-64bit.c | 71 +++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-loongson-64bit.c b/drivers/gpio/gpio-loongson-64bit.c
index 06213bbfabdd..7f92cb6205b2 100644
--- a/drivers/gpio/gpio-loongson-64bit.c
+++ b/drivers/gpio/gpio-loongson-64bit.c
@@ -26,6 +26,7 @@ struct loongson_gpio_chip_data {
 	unsigned int		conf_offset;
 	unsigned int		out_offset;
 	unsigned int		in_offset;
+	unsigned int		inten_offset;
 };
 
 struct loongson_gpio_chip {
@@ -117,7 +118,17 @@ static void loongson_gpio_set(struct gpio_chip *chip, unsigned int pin, int valu
 
 static int loongson_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
 {
+	unsigned int u;
 	struct platform_device *pdev = to_platform_device(chip->parent);
+	struct loongson_gpio_chip *lgpio = to_loongson_gpio_chip(chip);
+
+	if (lgpio->chip_data->mode == BIT_CTRL_MODE) {
+		u = readl(lgpio->reg_base + lgpio->chip_data->inten_offset + offset / 32 * 4);
+		u |= BIT(offset % 32);
+		writel(u, lgpio->reg_base + lgpio->chip_data->inten_offset + offset / 32 * 4);
+	} else {
+		writeb(1, lgpio->reg_base + lgpio->chip_data->inten_offset + offset);
+	}
 
 	return platform_get_irq(pdev, offset);
 }
@@ -127,11 +138,30 @@ static int loongson_gpio_init(struct device *dev, struct loongson_gpio_chip *lgp
 {
 	int ret;
 	u32 ngpios;
+	unsigned int io_width;
 
 	lgpio->reg_base = reg_base;
+	if (device_property_read_u32(dev, "ngpios", &ngpios) || !ngpios)
+		return -EINVAL;
+
+	ret = DIV_ROUND_UP(ngpios, 8);
+	switch (ret) {
+	case 1 ... 2:
+		io_width = ret;
+		break;
+	case 3 ... 4:
+		io_width = 0x4;
+		break;
+	case 5 ... 8:
+		io_width = 0x8;
+		break;
+	default:
+		dev_err(dev, "unsupported io width\n");
+		return -EINVAL;
+	}
 
 	if (lgpio->chip_data->mode == BIT_CTRL_MODE) {
-		ret = bgpio_init(&lgpio->chip, dev, 8,
+		ret = bgpio_init(&lgpio->chip, dev, io_width,
 				lgpio->reg_base + lgpio->chip_data->in_offset,
 				lgpio->reg_base + lgpio->chip_data->out_offset,
 				NULL, NULL,
@@ -151,16 +181,35 @@ static int loongson_gpio_init(struct device *dev, struct loongson_gpio_chip *lgp
 		spin_lock_init(&lgpio->lock);
 	}
 
-	device_property_read_u32(dev, "ngpios", &ngpios);
-
-	lgpio->chip.can_sleep = 0;
 	lgpio->chip.ngpio = ngpios;
-	lgpio->chip.label = lgpio->chip_data->label;
-	lgpio->chip.to_irq = loongson_gpio_to_irq;
+	lgpio->chip.can_sleep = 0;
+	if (lgpio->chip_data->label)
+		lgpio->chip.label = lgpio->chip_data->label;
+	else
+		lgpio->chip.label = kstrdup(to_platform_device(dev)->name, GFP_KERNEL);
+
+	if (lgpio->chip_data->inten_offset)
+		lgpio->chip.to_irq = loongson_gpio_to_irq;
 
 	return devm_gpiochip_add_data(dev, &lgpio->chip, lgpio);
 }
 
+static int loongson_gpio_get_props(struct device *dev,
+				    struct loongson_gpio_chip *lgpio)
+{
+	const struct loongson_gpio_chip_data *d = lgpio->chip_data;
+
+	if (device_property_read_u32(dev, "loongson,gpio-conf-offset", (u32 *)&d->conf_offset)
+	    || device_property_read_u32(dev, "loongson,gpio-in-offset", (u32 *)&d->in_offset)
+	    || device_property_read_u32(dev, "loongson,gpio-out-offset", (u32 *)&d->out_offset)
+	    || device_property_read_u32(dev, "loongson,gpio-ctrl-mode", (u32 *)&d->mode))
+		return -EINVAL;
+
+	device_property_read_u32(dev, "loongson,gpio-inten-offset", (u32 *)&d->inten_offset);
+
+	return 0;
+}
+
 static int loongson_gpio_probe(struct platform_device *pdev)
 {
 	void __iomem *reg_base;
@@ -172,7 +221,12 @@ static int loongson_gpio_probe(struct platform_device *pdev)
 	if (!lgpio)
 		return -ENOMEM;
 
-	lgpio->chip_data = device_get_match_data(dev);
+	lgpio->chip_data = devm_kzalloc(dev, sizeof(*lgpio->chip_data), GFP_KERNEL);
+	if (!lgpio->chip_data)
+		return -ENOMEM;
+
+	if (loongson_gpio_get_props(dev, lgpio))
+		lgpio->chip_data = device_get_match_data(dev);
 
 	reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg_base))
@@ -215,6 +269,9 @@ static const struct acpi_device_id loongson_gpio_acpi_match[] = {
 		.id = "LOON0002",
 		.driver_data = (kernel_ulong_t)&loongson_gpio_ls7a_data,
 	},
+	{
+		.id = "LOON0007",
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, loongson_gpio_acpi_match);
-- 
2.31.1

