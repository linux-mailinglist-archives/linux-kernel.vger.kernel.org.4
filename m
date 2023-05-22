Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FFA70B904
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjEVJdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjEVJdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:33:33 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1989AB7;
        Mon, 22 May 2023 02:33:30 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8DxRunpNmtkBeIKAA--.18404S3;
        Mon, 22 May 2023 17:33:29 +0800 (CST)
Received: from user-pc.202.106.0.20 (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxkrDiNmtkAuRuAA--.55569S2;
        Mon, 22 May 2023 17:33:27 +0800 (CST)
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
Subject: [PATCH v2 3/3] soc: loongson2_pm: add power management support
Date:   Mon, 22 May 2023 17:33:20 +0800
Message-Id: <20230522093320.7176-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxkrDiNmtkAuRuAA--.55569S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3WryUJrWkCry5Gw48CFWxJFb_yoWfAFWUp3
        yfAay8GFWUGF43Zrs5XryDWr1YyFW3Ga9rJFZrGw1UG3s7Jwn5Wr1UJFyrZr4xAryDJFZr
        Z395CFWUCF4UWFUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0ow
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE
        52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
        AKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
        67AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7
        JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxU2iFxUUUUU
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
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
 drivers/soc/loongson/loongson2_pm.c | 235 ++++++++++++++++++++++++++++
 4 files changed, 247 insertions(+)
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
index 000000000000..cd96a1ebbb6c
--- /dev/null
+++ b/drivers/soc/loongson/loongson2_pm.c
@@ -0,0 +1,235 @@
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
+	if (!device_property_read_u32(dev, "suspend-address", &suspend_addr))
+		loongson_sysconf.suspend_addr = (u64)phys_to_virt(suspend_addr);
+	else
+		dev_err(dev, "No suspend-address, could not support S3!\n");
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

