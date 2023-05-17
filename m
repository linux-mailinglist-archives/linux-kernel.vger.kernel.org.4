Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728C4706159
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjEQHhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjEQHgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:36:46 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1EC3E45;
        Wed, 17 May 2023 00:36:39 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Bxb+sFhGRkm2oJAA--.16153S3;
        Wed, 17 May 2023 15:36:37 +0800 (CST)
Received: from user-pc.202.106.0.20 (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxDbP9g2RkllxlAA--.42661S2;
        Wed, 17 May 2023 15:36:34 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Marc Zyngier <maz@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Baoqi Zhang <zhangbaoqi@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, Yun Liu <liuyun@loongson.cn>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v1 3/3] soc: loongson2_pm: add power management support
Date:   Wed, 17 May 2023 15:36:25 +0800
Message-Id: <20230517073625.32090-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxDbP9g2RkllxlAA--.42661S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3WryUJrWkCr4xGF1xGF17Wrg_yoWfAw4Up3
        yfAay8GFWUGF43Zrn5XryDWF1YyFW3Ga9rJFZrGw1UG3s7Jwn5Wr1UJFyrZr4xAryDJFZr
        Z395CFWUCF4UWFUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bS8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr
        1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkE
        cVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F4
        0Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC
        6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2
        Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWrMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj
        6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
        YxBIdaVFxhVjvjDU0xZFpf9x07jetC7UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Loongson-2's Power Management Controller was ACPI, supports ACPI
S2Idle (Suspend To Idle), ACPI S3 (Suspend To RAM), ACPI S4 (Suspend To
Disk), ACPI S5 (Soft Shutdown) and supports multiple wake-up methods
(USB, GMAC, PWRBTN, etc.). This driver was to add Power Management
Controller support that base on dts for Loongson-2 series SoCs.

Signed-off-by: Liu Yun <liuyun@loongson.cn>
Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
 MAINTAINERS                         |   1 +
 drivers/soc/loongson/Kconfig        |  10 ++
 drivers/soc/loongson/Makefile       |   1 +
 drivers/soc/loongson/loongson2_pm.c | 237 ++++++++++++++++++++++++++++
 4 files changed, 249 insertions(+)
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
index 707f56358dc4..2431a0bcbd84 100644
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
+	 The Loongson-2's Power Management Controller was ACPI, supports ACPI
+	 S2Idle (Suspend To Idle), ACPI S3 (Suspend To RAM), ACPI S4 (Suspend To
+	 Disk), ACPI S5 (Soft Shutdown) and supports multiple wake-up methods
+	 (USB, GMAC, PWRBTN, etc.). This driver was to add Power Management
+	 Controller support that base on dts for Loongson-2 series SoCs.
diff --git a/drivers/soc/loongson/Makefile b/drivers/soc/loongson/Makefile
index 263c486df638..4118f50f55e2 100644
--- a/drivers/soc/loongson/Makefile
+++ b/drivers/soc/loongson/Makefile
@@ -4,3 +4,4 @@
 #
 
 obj-$(CONFIG_LOONGSON2_GUTS)		+= loongson2_guts.o
+obj-$(CONFIG_LOONGSON2_PM)		+= loongson2_pm.o
diff --git a/drivers/soc/loongson/loongson2_pm.c b/drivers/soc/loongson/loongson2_pm.c
new file mode 100644
index 000000000000..e16a94544ed3
--- /dev/null
+++ b/drivers/soc/loongson/loongson2_pm.c
@@ -0,0 +1,237 @@
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
+static void loongson2_pm_irq_enable(void)
+{
+	u16 value;
+
+	value = loongson2_pm_readw(LOONGSON2_PM1_CNT_REG);
+	value |= LOONGSON2_PM1_CNT_INT_EN;
+	loongson2_pm_writew(value, LOONGSON2_PM1_CNT_REG);
+}
+
+static void loongson2_pm_pwrbtn_irq_enable(void)
+{
+	u16 value;
+
+	loongson2_pm_irq_enable();
+
+	value = loongson2_pm_readw(LOONGSON2_PM1_ENA_REG);
+	value |= LOONGSON2_PM1_PWRBTN_EN;
+	loongson2_pm_writew(value, LOONGSON2_PM1_ENA_REG);
+}
+
+static void loongson2_pm_mach_resume(void)
+{
+	loongson_common_resume();
+	loongson2_pm_irq_enable();
+}
+
+static void loongson2_pm_mach_suspend(void)
+{
+	loongson2_pm_status_clear();
+	loongson_common_suspend();
+}
+
+static int loongson2_suspend_enter(suspend_state_t state)
+{
+	loongson2_pm_mach_suspend();
+	loongson_suspend_enter();
+	pm_set_resume_via_firmware();
+	loongson2_pm_mach_resume();
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
+		return !!loongson_sysconf.suspend_addr;
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
+static int loongson2_pm_pwrbtn_init(struct device *dev, int irq)
+{
+	int ret;
+	struct input_dev *pwrbt;
+
+	pwrbt = input_allocate_device();
+	if (!dev)
+		return -ENOMEM;
+
+	pwrbt->name = "Power Button";
+	pwrbt->phys = "pm/button/input0";
+	pwrbt->id.bustype = BUS_HOST;
+	pwrbt->dev.parent = NULL;
+	input_set_capability(pwrbt, EV_KEY, KEY_POWER);
+
+	ret = input_register_device(pwrbt);
+	if (ret)
+		goto free_dev;
+
+	dev_pm_set_wake_irq(&pwrbt->dev, irq);
+	device_set_wakeup_capable(&pwrbt->dev, true);
+	device_set_wakeup_enable(&pwrbt->dev, true);
+
+	loongson2_pm.dev = pwrbt;
+	dev_info(dev, "Power Button: Init successful!\n");
+
+	return 0;
+
+free_dev:
+	input_free_device(pwrbt);
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
+static SIMPLE_DEV_PM_OPS(loongson2_pm_ops, loongson2_pm_suspend, loongson2_pm_resume);
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
+	if (!device_property_read_u32(dev, "suspend-address", &suspend_addr)) {
+		loongson_sysconf.suspend_addr = (u64)phys_to_virt(suspend_addr);
+	} else {
+		dev_err(dev, "No suspend-address, could not support S3!\n");
+		return -EINVAL;
+	}
+
+	if (loongson2_pm_pwrbtn_init(dev, irq))
+		return -EINVAL;
+
+	retval = devm_request_irq(&pdev->dev, irq, loongson2_pm_irq_handler,
+				  IRQF_SHARED, "pm_irq", &loongson2_pm);
+	if (retval)
+		return retval;
+
+	loongson2_pm_pwrbtn_irq_enable();
+	loongson2_pm_status_clear();
+
+	if (loongson_sysconf.suspend_addr)
+		suspend_set_ops(&loongson2_suspend_ops);
+
+	return 0;
+}
+
+static const struct of_device_id loongson2_pm_match[] = {
+	{ .compatible = "loongson,ls2k-pmc", },
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

