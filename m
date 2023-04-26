Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDB46EEE32
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 08:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239531AbjDZGUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 02:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239340AbjDZGUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 02:20:34 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 385952134;
        Tue, 25 Apr 2023 23:20:31 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8BxrOqtwkhkIOcAAA--.1526S3;
        Wed, 26 Apr 2023 14:20:29 +0800 (CST)
Received: from user-pc.202.106.0.20 (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxfbOkwkhk7FE8AA--.16273S2;
        Wed, 26 Apr 2023 14:20:26 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn,
        zhanghongchen <zhanghongchen@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v14 1/2] thermal: loongson-2: add thermal management support
Date:   Wed, 26 Apr 2023 14:20:17 +0800
Message-Id: <20230426062018.19755-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxfbOkwkhk7FE8AA--.16273S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Zr1xur1DXr4xKr45ZFyrJFb_yoWDAryDpF
        W3Ca98GrsrJFsru3Z8ArW8AFs0y3WayFy7XF4xGw1Y9rZ8J343WryktFy8AryxCFyUGFW7
        ZF98KrWUCFWDZ3DanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x
        0EwIxGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xF
        xVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
        JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
        daVFxhVjvjDU0xZFpf9x07jn73kUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the support for Loongson-2 thermal sensor controller,
which can support maximum 4 sensors, each sensor contains a sampling
register and a control register. The sampling register is used to obtain
the temperature in real time, the control register GATE field is used to
set the threshold of high or low temperature, when the input temperature
is higher than the high temperature threshold or lower than the low
temperature threshold, an interrupt will occur.

Signed-off-by: zhanghongchen <zhanghongchen@loongson.cn>
Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
Change in v14:
		1. Add back depends on COMPILE_TEST.
		2. The implementation of devm_thermal_add_hwmon_sysfs has changed in
		   recent community code that cause compile fail issue and this verison
		   add a dev args in devm_thermal_add_hwmon_sysfs to fix compile issue.
Change in v13:
		1. Add a description about that how works the sensor.
		2. Drop the COMPILE_TEST.
		3. Rework the help prograph in LOONGSON2_THERMAL Kconfig.
		4. Drop the 'tzd' 'irq' and 'pdev' element in loongson2_thermal_data.
		5. Drop the reset of variable in loongson2_thermal_set.
		6. Drop the function loongson2_thermal_get_sensor_id.
		7. Drop the function loongson2_thermal_alarm_irq.
		8. Rework the devm_thermal_of_zone_register.
		9. Pass 'tzd' instead of 'data' in devm_request_threaded_irq.
		10. Drop the "data->tzd->tzp->no_hwmon = false".
		11. Drop the loongson2_thermal_remove.
		12. Add the sensor id in the of_device_id data field.
		13. Drop the save and restore function.
Change in v12:
		1. Fixup it about min and max.
		2. Use dev_err_probe replace dev_err in devm_request_threaded_irq context.
Change in v11:
		1. Add min() and max() to replace related code in function
		   loongson2_thermal_set.
		2. Add dev_err_probe to to replace related code for function
		   return value use devm_thermal_of_zone_register.
		3. Replace thermal_add_hwmon_sysfs with devm_thermal_add_hwmon_sysfs
		   and use dev_warn replace dev_err in this context.
Change in v10:
		1. Add all history change log information.
Change in v9:
		1. Switch new API that use devm_thermal_of_zone_register
		   to replace previous interfaces.
		2. Add depend on LOONGARCH || COMPILE_TEST.
Change in v8:
                1. Replace string loongson2/Loongson2/LOONGSON2 with loongson-2/
                   Loongson-2/LOONGSON-2 in Kconfig and commit log and MAINTAINERS
		   files.
Change in v7:
		1. Split the modification of patch 3 and merge it into this patch.
		2. Remove the unless code annotation to fix the compile warning
		   when compile C code with W=1.
Change in v6:
		1. NO change, but other patch in this series of patches set has
		   changes.
Change in v5:
		1. NO change, but other patch in this series of patches set has
		   changes.
Change in v4:
		1. Fixup the compatible.
Change in v3:
		1. Add a function to gain sensor id an remove dts id.
Change in v2:
		1. Remove error msg printing when addr ioremap has error.
		2. Make loongson2 thermal driver was built-in by default.
		3. Replace ls2k with loongson2.
		4. Remove CONFIG_PM_SLEEP and set pm function type was
		   __maybe_unused.

 MAINTAINERS                         |   7 ++
 drivers/thermal/Kconfig             |  12 ++
 drivers/thermal/Makefile            |   1 +
 drivers/thermal/loongson2_thermal.c | 166 ++++++++++++++++++++++++++++
 4 files changed, 186 insertions(+)
 create mode 100644 drivers/thermal/loongson2_thermal.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 25a0981c74b6..b3a76acd2caf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12143,6 +12143,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
 F:	drivers/pinctrl/pinctrl-loongson2.c
 
+LOONGSON-2 SOC SERIES THERMAL DRIVER
+M:	zhanghongchen <zhanghongchen@loongson.cn>
+M:	Yinbo Zhu <zhuyinbo@loongson.cn>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	drivers/thermal/loongson2_thermal.c
+
 LOONGSON GPIO DRIVER
 M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-gpio@vger.kernel.org
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 4cd7ab707315..c4de94e972f4 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -502,4 +502,16 @@ config KHADAS_MCU_FAN_THERMAL
 	  If you say yes here you get support for the FAN controlled
 	  by the Microcontroller found on the Khadas VIM boards.
 
+config LOONGSON2_THERMAL
+	tristate "Loongson-2 SoC series thermal driver"
+	depends on LOONGARCH || COMPILE_TEST
+	depends on OF
+	help
+	  Support for Thermal driver found on Loongson-2 SoC series platforms.
+	  The thermal driver realizes get_temp and set_trips function, which
+	  are used to obtain the temperature of the current node and set the
+	  temperature range to trigger the interrupt. When the input temperature
+	  is higher than the high temperature threshold or lower than the low
+	  temperature threshold, the interrupt will occur.
+
 endif
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index eed300e83d48..4edde4df647b 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -62,3 +62,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
 obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
 obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
+obj-$(CONFIG_LOONGSON2_THERMAL)	+= loongson2_thermal.o
diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
new file mode 100644
index 000000000000..6a338e6e490e
--- /dev/null
+++ b/drivers/thermal/loongson2_thermal.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Author: zhanghongchen <zhanghongchen@loongson.cn>
+ *         Yinbo Zhu <zhuyinbo@loongson.cn>
+ * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
+ */
+
+#include <linux/cpufreq.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/of_device.h>
+#include <linux/thermal.h>
+#include "thermal_hwmon.h"
+
+#define LOONGSON2_SOC_MAX_SENSOR_NUM			4
+
+#define LOONGSON2_TSENSOR_CTRL_HI			0x0
+#define LOONGSON2_TSENSOR_CTRL_LO			0x8
+#define LOONGSON2_TSENSOR_STATUS			0x10
+#define LOONGSON2_TSENSOR_OUT				0x14
+
+struct loongson2_thermal_data {
+	int id;
+	void __iomem *regs;
+};
+
+static int loongson2_thermal_set(struct loongson2_thermal_data *data,
+					int low, int high, bool enable)
+{
+	u64 reg_ctrl = 0;
+	int reg_off = data->id * 2;
+
+	if (low > high)
+		return -EINVAL;
+
+	low = max(low, -40);
+	high = min(high, 125);
+
+	low += 100;
+	high += 100;
+
+	reg_ctrl = low;
+	reg_ctrl |= enable ? 0x100 : 0;
+	writew(reg_ctrl, data->regs + LOONGSON2_TSENSOR_CTRL_LO + reg_off);
+
+	reg_ctrl = high;
+	reg_ctrl |= enable ? 0x100 : 0;
+	writew(reg_ctrl, data->regs + LOONGSON2_TSENSOR_CTRL_HI + reg_off);
+
+	return 0;
+}
+
+static int loongson2_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	u32 reg_val;
+	struct loongson2_thermal_data *data = tz->devdata;
+
+	reg_val = readl(data->regs + LOONGSON2_TSENSOR_OUT);
+	*temp = ((reg_val & 0xff) - 100) * 1000;
+
+	return 0;
+}
+
+static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
+{
+	struct thermal_zone_device *tzd = dev;
+	struct loongson2_thermal_data *data = tzd->devdata;
+
+	/* clear interrupt */
+	writeb(0x3, data->regs + LOONGSON2_TSENSOR_STATUS);
+
+	thermal_zone_device_update(tzd, THERMAL_EVENT_UNSPECIFIED);
+
+	return IRQ_HANDLED;
+}
+
+static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
+{
+	struct loongson2_thermal_data *data = tz->devdata;
+
+	return loongson2_thermal_set(data, low/1000, high/1000, true);
+}
+
+static const struct thermal_zone_device_ops loongson2_of_thermal_ops = {
+	.get_temp = loongson2_thermal_get_temp,
+	.set_trips = loongson2_thermal_set_trips,
+};
+
+static int loongson2_thermal_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct loongson2_thermal_data *data;
+	struct thermal_zone_device *tzd;
+	int ret, irq, i;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->id = (uintptr_t)device_get_match_data(dev);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->regs = devm_ioremap(dev, res->start, resource_size(res));
+	if (IS_ERR(data->regs))
+		return PTR_ERR(data->regs);
+
+	/* get irq */
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	if (data->id > LOONGSON2_SOC_MAX_SENSOR_NUM - 1 || data->id < 0) {
+		dev_err(dev, "sensor id error,must be in <0 ~ %d>\n",
+				LOONGSON2_SOC_MAX_SENSOR_NUM - 1);
+		return -EINVAL;
+	}
+
+	writeb(0xff, data->regs + LOONGSON2_TSENSOR_STATUS);
+
+	loongson2_thermal_set(data, 0, 0, false);
+
+	for (i = 0; i < LOONGSON2_SOC_MAX_SENSOR_NUM; i++) {
+		tzd = devm_thermal_of_zone_register(dev, i, data,
+			&loongson2_of_thermal_ops);
+
+		if (!IS_ERR(tzd))
+			break;
+
+		if (PTR_ERR(tzd) != ENODEV)
+			continue;
+
+		return dev_err_probe(dev, PTR_ERR(tzd), "failed to register");
+	}
+
+	ret = devm_request_threaded_irq(dev, irq, NULL, loongson2_thermal_irq_thread,
+			IRQF_ONESHOT, "loongson2_thermal", tzd);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to request alarm irq\n");
+
+	if (devm_thermal_add_hwmon_sysfs(dev, tzd))
+		dev_warn(dev, "Failed to add hwmon sysfs attributes\n");
+
+	return 0;
+}
+
+static const struct of_device_id of_loongson2_thermal_match[] = {
+	{ .compatible = "loongson,ls2k-thermal", .data = (const void *)0},
+	{ /* end */ }
+};
+MODULE_DEVICE_TABLE(of, of_loongson2_thermal_match);
+
+static struct platform_driver loongson2_thermal_driver = {
+	.driver = {
+		.name		= "loongson2_thermal",
+		.of_match_table = of_loongson2_thermal_match,
+	},
+	.probe	= loongson2_thermal_probe,
+};
+module_platform_driver(loongson2_thermal_driver);
+
+MODULE_DESCRIPTION("Loongson2 thermal driver");
+MODULE_LICENSE("GPL");
-- 
2.20.1

