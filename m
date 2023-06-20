Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3057D736120
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 03:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjFTB36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 21:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjFTB3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 21:29:54 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48D4B1A7;
        Mon, 19 Jun 2023 18:29:51 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8DxTusNAZFkHwMHAA--.14343S3;
        Tue, 20 Jun 2023 09:29:49 +0800 (CST)
Received: from user-pc.202.106.0.20 (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxFOQJAZFkEQIhAA--.27139S2;
        Tue, 20 Jun 2023 09:29:48 +0800 (CST)
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
Subject: [PATCH v15 1/2] thermal: loongson-2: add thermal management support
Date:   Tue, 20 Jun 2023 09:29:43 +0800
Message-Id: <20230620012944.28877-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxFOQJAZFkEQIhAA--.27139S2
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

This patch adds the support for Loongson-2 thermal sensor controller,
which can support maximum four sensor selectors that corresponding to four
sets of thermal control registers and one set of sampling register. The
sensor selector can selector a speific thermal sensor as temperature input.
The sampling register is used to obtain the temperature in real time, the
control register GATE field is used to set the threshold of high or low
temperature, when the input temperature is higher than the high temperature
threshold or lower than the low temperature threshold, an interrupt will
occur.

Signed-off-by: zhanghongchen <zhanghongchen@loongson.cn>
Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
Change in v15:
		1. Remove the unused head file.
		2. Remove the invalid conditions that such as (low > high).
		3. Use the clamp() to replace max() and min().
		4. Use the macros to replace some constant.
		5. Use the struct data point as data field of of_device_id.
		6. Use the thermal_sensor_sel to replace the sensor id.
		7. Use the thermal_zone_device_priv to replace tz->devdata.
		8. Reword the commit log information.
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
 drivers/thermal/loongson2_thermal.c | 170 ++++++++++++++++++++++++++++
 4 files changed, 190 insertions(+)
 create mode 100644 drivers/thermal/loongson2_thermal.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a91f14cad2e..f9277fa2a728 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12198,6 +12198,13 @@ S:	Maintained
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
index 058664bc3ec0..c934cab309ae 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -63,3 +63,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
 obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
 obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
+obj-$(CONFIG_LOONGSON2_THERMAL)	+= loongson2_thermal.o
diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
new file mode 100644
index 000000000000..2be8e0f5fea3
--- /dev/null
+++ b/drivers/thermal/loongson2_thermal.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Author: zhanghongchen <zhanghongchen@loongson.cn>
+ *         Yinbo Zhu <zhuyinbo@loongson.cn>
+ * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
+ */
+
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+#include <linux/units.h>
+#include "thermal_hwmon.h"
+
+#define LOONGSON2_MAX_SENSOR_SEL_NUM			3
+
+#define LOONGSON2_THSENS_CTRL_HI_REG			0x0
+#define LOONGSON2_THSENS_CTRL_LOW_REG			0x8
+#define LOONGSON2_THSENS_STATUS_REG			0x10
+#define LOONGSON2_THSENS_OUT_REG			0x14
+
+#define LOONGSON2_THSENS_INT_LO				BIT(0)
+#define LOONGSON2_THSENS_INT_HIGH			BIT(1)
+#define LOONGSON2_THSENS_OUT_MASK			0xFF
+
+struct loongson2_thermal_chip_data {
+	unsigned int	thermal_sensor_sel;
+};
+
+struct loongson2_thermal_data {
+	void __iomem	*regs;
+	const struct loongson2_thermal_chip_data *chip_data;
+};
+
+static int loongson2_thermal_set(struct loongson2_thermal_data *data,
+					int low, int high, bool enable)
+{
+	u64 reg_ctrl = 0;
+	int reg_off = data->chip_data->thermal_sensor_sel * 2;
+
+	low = clamp(-40, low, high);
+	high = clamp(125, low, high);
+
+	low += HECTO;
+	high += HECTO;
+
+	reg_ctrl = low;
+	reg_ctrl |= enable ? 0x100 : 0;
+	writew(reg_ctrl, data->regs + LOONGSON2_THSENS_CTRL_LOW_REG + reg_off);
+
+	reg_ctrl = high;
+	reg_ctrl |= enable ? 0x100 : 0;
+	writew(reg_ctrl, data->regs + LOONGSON2_THSENS_CTRL_HI_REG + reg_off);
+
+	return 0;
+}
+
+static int loongson2_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	u32 reg_val;
+	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
+
+	reg_val = readl(data->regs + LOONGSON2_THSENS_OUT_REG);
+	*temp = ((reg_val & LOONGSON2_THSENS_OUT_MASK) - HECTO) * KILO;
+
+	return 0;
+}
+
+static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
+{
+	struct thermal_zone_device *tzd = dev;
+	struct loongson2_thermal_data *data = thermal_zone_device_priv(tzd);
+
+	writeb(LOONGSON2_THSENS_INT_LO | LOONGSON2_THSENS_INT_HIGH, data->regs +
+		LOONGSON2_THSENS_STATUS_REG);
+
+	thermal_zone_device_update(tzd, THERMAL_EVENT_UNSPECIFIED);
+
+	return IRQ_HANDLED;
+}
+
+static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
+{
+	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
+
+	return loongson2_thermal_set(data, low/MILLI, high/MILLI, true);
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
+	struct loongson2_thermal_data *data;
+	struct thermal_zone_device *tzd;
+	int ret, irq, i;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->chip_data = device_get_match_data(dev);
+
+	data->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(data->regs))
+		return PTR_ERR(data->regs);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	writeb(LOONGSON2_THSENS_INT_LO | LOONGSON2_THSENS_INT_HIGH, data->regs +
+		LOONGSON2_THSENS_STATUS_REG);
+
+	loongson2_thermal_set(data, 0, 0, false);
+
+	for (i = 0; i <= LOONGSON2_MAX_SENSOR_SEL_NUM; i++) {
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
+static const struct loongson2_thermal_chip_data loongson2_thermal_ls2k1000_data = {
+	.thermal_sensor_sel = 0,
+};
+
+static const struct of_device_id of_loongson2_thermal_match[] = {
+	{
+		.compatible = "loongson,ls2k1000-thermal",
+		.data = &loongson2_thermal_ls2k1000_data,
+	},
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

