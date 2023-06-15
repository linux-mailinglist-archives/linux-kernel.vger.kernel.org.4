Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00CE731434
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343585AbjFOJjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245611AbjFOJi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:38:58 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11A623C0D;
        Thu, 15 Jun 2023 02:37:56 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8CxvOrR24pkNIIFAA--.11718S3;
        Thu, 15 Jun 2023 17:37:21 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxCOXO24pkg9EbAA--.13406S3;
        Thu, 15 Jun 2023 17:37:19 +0800 (CST)
Subject: [PATCH v3 3/3] soc: loongson2_pm: add power management support
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230615091757.24686-1-zhuyinbo@loongson.cn>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <968b7c81-a24e-1e0d-31a4-f633a82d17b0@loongson.cn>
Date:   Thu, 15 Jun 2023 17:37:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230615091757.24686-1-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxCOXO24pkg9EbAA--.13406S3
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

 From 6edcb9d6a1b18ccbecaf283b4f543afc9e7126d6 Mon Sep 17 00:00:00 2001
From: Yinbo Zhu <zhuyinbo@loongson.cn>
Date: Tue, 18 Apr 2023 14:18:00 +0800
Subject: [PATCH v3 3/3] soc: loongson2_pm: add power management support

The Loongson-2's power management controller was ACPI, supports ACPI
S2Idle (Suspend To Idle), ACPI S3 (Suspend To RAM), ACPI S4 (Suspend To
Disk), ACPI S5 (Soft Shutdown) and supports multiple wake-up methods
(USB, GMAC, PWRBTN, etc.). This driver was to add power management
controller support that base on dts for Loongson-2 series SoCs.

Signed-off-by: Liu Yun <liuyun@loongson.cn>
Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
  MAINTAINERS                         |   1 +
  drivers/soc/loongson/Kconfig        |  10 ++
  drivers/soc/loongson/Makefile       |   1 +
  drivers/soc/loongson/loongson2_pm.c | 218 ++++++++++++++++++++++++++++
  4 files changed, 230 insertions(+)
  create mode 100644 drivers/soc/loongson/loongson2_pm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bcd05f1fa5c1..7c4ad0cbaeff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12195,6 +12195,7 @@ M:	Yinbo Zhu <zhuyinbo@loongson.cn>
  L:	linux-pm@vger.kernel.org
  S:	Maintained
  F:	Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
+F:	drivers/soc/loongson/loongson2_pm.c

  LOONGSON-2 SOC SERIES PINCTRL DRIVER
  M:	zhanghongchen <zhanghongchen@loongson.cn>
diff --git a/drivers/soc/loongson/Kconfig b/drivers/soc/loongson/Kconfig
index 707f56358dc4..4f3ce9eb7520 100644
--- a/drivers/soc/loongson/Kconfig
+++ b/drivers/soc/loongson/Kconfig
@@ -16,3 +16,13 @@ config LOONGSON2_GUTS
  	 SoCs. Initially only reading SVR and registering soc device are
  	 supported. Other guts accesses, such as reading firmware configuration
  	 by default, should eventually be added into this driver as well.
+
+config LOONGSON2_PM
+	bool "Loongson-2 SoC Power Management Controller Driver"
+	depends on LOONGARCH && OF
+	help
+	 The Loongson-2's power management controller was ACPI, supports ACPI
+	 S2Idle (Suspend To Idle), ACPI S3 (Suspend To RAM), ACPI S4 (Suspend To
+	 Disk), ACPI S5 (Soft Shutdown) and supports multiple wake-up methods
+	 (USB, GMAC, PWRBTN, etc.). This driver was to add power management
+	 controller support that base on dts for Loongson-2 series SoCs.
diff --git a/drivers/soc/loongson/Makefile b/drivers/soc/loongson/Makefile
index 263c486df638..4118f50f55e2 100644
--- a/drivers/soc/loongson/Makefile
+++ b/drivers/soc/loongson/Makefile
@@ -4,3 +4,4 @@
  #

  obj-$(CONFIG_LOONGSON2_GUTS)		+= loongson2_guts.o
+obj-$(CONFIG_LOONGSON2_PM)		+= loongson2_pm.o
diff --git a/drivers/soc/loongson/loongson2_pm.c 
b/drivers/soc/loongson/loongson2_pm.c
new file mode 100644
index 000000000000..287828413d72
--- /dev/null
+++ b/drivers/soc/loongson/loongson2_pm.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Loongson-2 PM Support
+ *
+ * Copyright (C) 2023 Loongson Technology Corporation Limited
+ */
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/suspend.h>
+#include <linux/interrupt.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/platform_device.h>
+#include <asm/bootinfo.h>
+#include <asm/suspend.h>
+
+#define LOONGSON2_PM1_CNT_REG		0x14
+#define LOONGSON2_PM1_STS_REG		0x0c
+#define LOONGSON2_PM1_ENA_REG		0x10
+#define LOONGSON2_GPE0_STS_REG		0x28
+#define LOONGSON2_GPE0_ENA_REG		0x2c
+
+#define LOONGSON2_PM1_PWRBTN_STS	BIT(8)
+#define LOONGSON2_PM1_PCIEXP_WAKE_STS	BIT(14)
+#define LOONGSON2_PM1_WAKE_STS		BIT(15)
+#define LOONGSON2_PM1_CNT_INT_EN	BIT(0)
+#define LOONGSON2_PM1_PWRBTN_EN		LOONGSON2_PM1_PWRBTN_STS
+
+static struct loongson2_pm {
+	void __iomem			*base;
+	struct input_dev		*dev;
+	bool				suspended;
+} loongson2_pm;
+
+#define loongson2_pm_readw(reg)		readw(loongson2_pm.base + reg)
+#define loongson2_pm_readl(reg)		readl(loongson2_pm.base + reg)
+#define loongson2_pm_writew(val, reg)	writew(val, loongson2_pm.base + reg)
+#define loongson2_pm_writel(val, reg)	writel(val, loongson2_pm.base + reg)
+
+static void loongson2_pm_status_clear(void)
+{
+	u16 value;
+
+	value = loongson2_pm_readw(LOONGSON2_PM1_STS_REG);
+	value |= (LOONGSON2_PM1_PWRBTN_STS | LOONGSON2_PM1_PCIEXP_WAKE_STS |
+		  LOONGSON2_PM1_WAKE_STS);
+	loongson2_pm_writew(value, LOONGSON2_PM1_STS_REG);
+	loongson2_pm_writel(loongson2_pm_readl(LOONGSON2_GPE0_STS_REG),
+			    LOONGSON2_GPE0_STS_REG);
+}
+
+static void loongson2_power_button_irq_enable(void)
+{
+	u16 value;
+
+	value = loongson2_pm_readw(LOONGSON2_PM1_CNT_REG);
+	value |= LOONGSON2_PM1_CNT_INT_EN;
+	loongson2_pm_writew(value, LOONGSON2_PM1_CNT_REG);
+
+	value = loongson2_pm_readw(LOONGSON2_PM1_ENA_REG);
+	value |= LOONGSON2_PM1_PWRBTN_EN;
+	loongson2_pm_writew(value, LOONGSON2_PM1_ENA_REG);
+}
+
+static int loongson2_suspend_enter(suspend_state_t state)
+{
+	loongson2_pm_status_clear();
+	loongarch_common_suspend();
+	loongarch_suspend_enter();
+	loongarch_common_resume();
+	loongson2_power_button_irq_enable();
+	pm_set_resume_via_firmware();
+
+	return 0;
+}
+
+static int loongson2_suspend_begin(suspend_state_t state)
+{
+	pm_set_suspend_via_firmware();
+
+	return 0;
+}
+
+static int loongson2_suspend_valid_state(suspend_state_t state)
+{
+	if (state == PM_SUSPEND_MEM)
+		return 1;
+
+	return 0;
+}
+
+static const struct platform_suspend_ops loongson2_suspend_ops = {
+	.valid	= loongson2_suspend_valid_state,
+	.begin	= loongson2_suspend_begin,
+	.enter	= loongson2_suspend_enter,
+};
+
+static int loongson2_power_button_init(struct device *dev, int irq)
+{
+	int ret;
+	struct input_dev *button;
+
+	button = input_allocate_device();
+	if (!dev)
+		return -ENOMEM;
+
+	button->name = "Power Button";
+	button->phys = "pm/button/input0";
+	button->id.bustype = BUS_HOST;
+	button->dev.parent = NULL;
+	input_set_capability(button, EV_KEY, KEY_POWER);
+
+	ret = input_register_device(button);
+	if (ret)
+		goto free_dev;
+
+	dev_pm_set_wake_irq(&button->dev, irq);
+	device_set_wakeup_capable(&button->dev, true);
+	device_set_wakeup_enable(&button->dev, true);
+
+	loongson2_pm.dev = button;
+	dev_info(dev, "Power Button: Init successful!\n");
+
+	return 0;
+
+free_dev:
+	input_free_device(button);
+
+	return ret;
+}
+
+static irqreturn_t loongson2_pm_irq_handler(int irq, void *dev_id)
+{
+	u16 status = loongson2_pm_readw(LOONGSON2_PM1_STS_REG);
+
+	if (!loongson2_pm.suspended && (status & LOONGSON2_PM1_PWRBTN_STS)) {
+		pr_info("Power Button pressed...\n");
+		input_report_key(loongson2_pm.dev, KEY_POWER, 1);
+		input_sync(loongson2_pm.dev);
+		input_report_key(loongson2_pm.dev, KEY_POWER, 0);
+		input_sync(loongson2_pm.dev);
+	}
+
+	loongson2_pm_status_clear();
+
+	return IRQ_HANDLED;
+}
+
+static int __maybe_unused loongson2_pm_suspend(struct device *dev)
+{
+	loongson2_pm.suspended = true;
+
+	return 0;
+}
+
+static int __maybe_unused loongson2_pm_resume(struct device *dev)
+{
+	loongson2_pm.suspended = false;
+
+	return 0;
+}
+static SIMPLE_DEV_PM_OPS(loongson2_pm_ops, loongson2_pm_suspend, 
loongson2_pm_resume);
+
+static int loongson2_pm_probe(struct platform_device *pdev)
+{
+	int irq, retval;
+	u32 suspend_addr;
+	struct device *dev = &pdev->dev;
+
+	loongson2_pm.base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(loongson2_pm.base))
+		return PTR_ERR(loongson2_pm.base);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	if (!device_property_read_u32(dev, "suspend-address", &suspend_addr))
+		loongson_sysconf.suspend_addr = (u64)phys_to_virt(suspend_addr);
+	else
+		dev_err(dev, "No suspend-address, could not support S3!\n");
+
+	if (loongson2_power_button_init(dev, irq))
+		return -EINVAL;
+
+	retval = devm_request_irq(&pdev->dev, irq, loongson2_pm_irq_handler,
+				  IRQF_SHARED, "pm_irq", &loongson2_pm);
+	if (retval)
+		return retval;
+
+	loongson2_power_button_irq_enable();
+	loongson2_pm_status_clear();
+
+	if (loongson_sysconf.suspend_addr)
+		suspend_set_ops(&loongson2_suspend_ops);
+
+	return 0;
+}
+
+static const struct of_device_id loongson2_pm_match[] = {
+	{ .compatible = "loongson,ls2k1000-pmc", },
+	{},
+};
+
+static struct platform_driver loongson2_pm_driver = {
+	.driver = {
+		.name = "ls2k-pm",
+		.pm = &loongson2_pm_ops,
+		.of_match_table = loongson2_pm_match,
+	},
+	.probe = loongson2_pm_probe,
+};
+module_platform_driver(loongson2_pm_driver);
+
+MODULE_DESCRIPTION("Loongson-2 PM driver");
+MODULE_LICENSE("GPL");
-- 
2.20.1

