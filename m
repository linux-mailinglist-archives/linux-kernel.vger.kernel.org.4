Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3285BC1DD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 05:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiISDtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 23:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiISDte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 23:49:34 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3338AC1F;
        Sun, 18 Sep 2022 20:49:32 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxkOC+5idjAnQdAA--.45929S4;
        Mon, 19 Sep 2022 11:49:28 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhanghongchen <zhanghongchen@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v1 3/3] thermal: ls2k: add thermal management support
Date:   Mon, 19 Sep 2022 11:49:15 +0800
Message-Id: <20220919034915.26912-3-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220919034915.26912-1-zhuyinbo@loongson.cn>
References: <20220919034915.26912-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxkOC+5idjAnQdAA--.45929S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww4UCrWUGryfGr4DCr4xXrb_yoW3Kr4kpF
        WUGFW5Ar4kKF47JwsrAr1DuFs0yrsFva4UZrZ3u34av3yrJry3Wryktr9YqF9akF9rGF45
        Jrn8tFW5Crs8J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
        kIwI1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
        3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
        WUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
        cVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
        AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZE
        Xa7VUbdOz7UUUUU==
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the support for loongson2k thermal sensor controller,
which can support maximum 3 sensors.

It's based on thermal of framework:
 - Trip points defined in device tree.
 - Cpufreq as cooling device registered in loongson2k cpufreq driver.
 - Pwm fan as cooling device registered in hwmon pwm-fan driver.

Signed-off-by: zhanghongchen <zhanghongchen@loongson.cn>
Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
 drivers/thermal/Kconfig        |  10 ++
 drivers/thermal/Makefile       |   1 +
 drivers/thermal/ls2k_thermal.c | 244 +++++++++++++++++++++++++++++++++
 3 files changed, 255 insertions(+)
 create mode 100644 drivers/thermal/ls2k_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index e052dae614eb..04f5c044bc94 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -504,4 +504,14 @@ config KHADAS_MCU_FAN_THERMAL
 	  If you say yes here you get support for the FAN controlled
 	  by the Microcontroller found on the Khadas VIM boards.
 
+config LOONGSON2K_THERMAL
+	tristate "Loongson 2K SOC series thermal driver"
+	depends on OF
+	default m
+	help
+	  Support for Thermal driver found on Loongson 2K SOC series platforms.
+	  It supports one critical trip point and one passive trip point. The
+	  cpufreq and the pwm fan is used as the cooling device to throttle CPUs
+	  when the passive trip is crossed.
+
 endif
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index def8e1a0399c..5b665b5d7edc 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -61,3 +61,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
 obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
 obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
+obj-$(CONFIG_LOONGSON2K_THERMAL)	+= ls2k_thermal.o
diff --git a/drivers/thermal/ls2k_thermal.c b/drivers/thermal/ls2k_thermal.c
new file mode 100644
index 000000000000..13d1345d3b06
--- /dev/null
+++ b/drivers/thermal/ls2k_thermal.c
@@ -0,0 +1,244 @@
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
+#define LS2K_SOC_DEFAULT_SENSOR			0
+#define LS2K_SOC_MAX_SENSOR_NUM			3
+
+#define LS2K_TSENSOR_CTRL_HI			0x0
+#define LS2K_TSENSOR_CTRL_LO			0x8
+#define LS2K_TSENSOR_STATUS			0x10
+#define LS2K_TSENSOR_OUT			0x14
+
+struct ls2k_thermal_data {
+	struct thermal_zone_device *tzd;
+	int irq;
+	int id;
+	void __iomem *regs;
+	struct platform_device *pdev;
+	u16 ctrl_low_val;
+	u16 ctrl_hi_val;
+};
+
+/**
+ * @low : temperature in degree
+ * @high: temperature in degree
+ */
+static int ls2k_tsensor_set(struct ls2k_thermal_data *data,
+					int low, int high, bool enable)
+{
+	u64 reg_ctrl = 0;
+	int reg_off = data->id * 2;
+
+	if (low > high)
+		return -EINVAL;
+
+	low = low < -100 ? -100 : low;
+	high = high > 155 ? 155 : high;
+
+	low += 100;
+	high += 100;
+
+	reg_ctrl |= low;
+	reg_ctrl |= enable ? 0x100 : 0;
+	writew(reg_ctrl, data->regs + LS2K_TSENSOR_CTRL_LO + reg_off);
+
+	reg_ctrl = 0;
+	reg_ctrl |= high;
+	reg_ctrl |= enable ? 0x100 : 0;
+	writew(reg_ctrl, data->regs + LS2K_TSENSOR_CTRL_HI + reg_off);
+
+	return 0;
+}
+
+static int ls2k_thermal_get_temp(void *__data, int *temp)
+{
+	struct ls2k_thermal_data *data = __data;
+	u32 reg_val;
+
+	reg_val = readl(data->regs + LS2K_TSENSOR_OUT);
+	*temp = ((reg_val & 0xff) - 100) * 1000;
+
+	return 0;
+}
+
+static irqreturn_t ls2k_thermal_alarm_irq(int irq, void *dev)
+{
+	struct ls2k_thermal_data *data = dev;
+
+	/* clear interrupt */
+	writeb(0x3, data->regs + LS2K_TSENSOR_STATUS);
+
+	disable_irq_nosync(irq);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t ls2k_thermal_irq_thread(int irq, void *dev)
+{
+	struct ls2k_thermal_data *data = dev;
+
+	thermal_zone_device_update(data->tzd,
+				   THERMAL_EVENT_UNSPECIFIED);
+	enable_irq(data->irq);
+
+	return IRQ_HANDLED;
+}
+
+static int ls2k_thermal_set_trips(void *data, int low, int high)
+{
+	return ls2k_tsensor_set(data, low/1000, high/1000, true);
+}
+
+static const struct thermal_zone_of_device_ops ls2k_of_thermal_ops = {
+	.get_temp = ls2k_thermal_get_temp,
+	.set_trips = ls2k_thermal_set_trips,
+};
+
+static int ls2k_thermal_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct ls2k_thermal_data *data;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->pdev = pdev;
+	platform_set_drvdata(pdev, data);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->regs = devm_ioremap(dev, res->start, resource_size(res));
+	if (IS_ERR(data->regs)) {
+		dev_err(dev, "failed to get io address\n");
+		return PTR_ERR(data->regs);
+	}
+
+	/* get irq */
+	data->irq = platform_get_irq(pdev, 0);
+	if (data->irq < 0)
+		return data->irq;
+
+	/* get id */
+	if (of_property_read_u32(dev->of_node, "id", &data->id)) {
+		dev_err(dev, "not found id property!\n");
+		data->id = LS2K_SOC_DEFAULT_SENSOR;
+	}
+
+	if (data->id > LS2K_SOC_MAX_SENSOR_NUM) {
+		dev_err(dev, "sensor id error,must be in <0 ~ %d>\n",
+				LS2K_SOC_MAX_SENSOR_NUM);
+		return -EINVAL;
+	}
+
+	writeb(0xff, data->regs + LS2K_TSENSOR_STATUS);
+
+	ls2k_tsensor_set(data, 0, 0, false);
+
+	data->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
+							   data->id, data,
+							   &ls2k_of_thermal_ops);
+	if (IS_ERR(data->tzd)) {
+		ret = PTR_ERR(data->tzd);
+		data->tzd = NULL;
+		dev_err(&pdev->dev, "failed to register %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_request_threaded_irq(dev, data->irq,
+			ls2k_thermal_alarm_irq, ls2k_thermal_irq_thread,
+			IRQF_ONESHOT, "ls2k_thermal", data);
+	if (ret < 0) {
+		dev_err(dev, "failed to request alarm irq: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Thermal_zone doesn't enable hwmon as default,
+	 * enable it here
+	 */
+	data->tzd->tzp->no_hwmon = false;
+	ret = thermal_add_hwmon_sysfs(data->tzd);
+	if (ret) {
+		dev_err(dev, "failed to add hwmon sysfs interface %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+int ls2k_thermal_remove(struct platform_device *pdev)
+{
+	struct ls2k_thermal_data *data = platform_get_drvdata(pdev);
+	int reg_off = data->id * 2;
+
+	/* disable interrupt */
+	writew(0, data->regs + LS2K_TSENSOR_CTRL_LO + reg_off);
+	writew(0, data->regs + LS2K_TSENSOR_CTRL_HI + reg_off);
+
+	return 0;
+}
+
+static const struct of_device_id of_ls2k_thermal_match[] = {
+	{ .compatible = "loongson,2k-tsensor",},
+	{ /* end */ }
+};
+MODULE_DEVICE_TABLE(of, of_ls2k_thermal_match);
+
+#ifdef CONFIG_PM_SLEEP
+static int ls2k_thermal_suspend(struct device *dev)
+{
+	struct ls2k_thermal_data *data = dev_get_drvdata(dev);
+	int reg_off = data->id * 2;
+
+	data->ctrl_low_val = readw(data->regs + LS2K_TSENSOR_CTRL_LO + reg_off);
+	data->ctrl_hi_val = readw(data->regs + LS2K_TSENSOR_CTRL_HI + reg_off);
+
+	writew(0, data->regs + LS2K_TSENSOR_CTRL_LO + reg_off);
+	writew(0, data->regs + LS2K_TSENSOR_CTRL_HI + reg_off);
+
+	return 0;
+}
+
+static int ls2k_thermal_resume(struct device *dev)
+{
+	struct ls2k_thermal_data *data = dev_get_drvdata(dev);
+	int reg_off = data->id * 2;
+
+	writew(data->ctrl_low_val, data->regs + LS2K_TSENSOR_CTRL_LO + reg_off);
+	writew(data->ctrl_hi_val, data->regs + LS2K_TSENSOR_CTRL_HI + reg_off);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(ls2k_thermal_pm_ops,
+			 ls2k_thermal_suspend, ls2k_thermal_resume);
+#endif
+
+static struct platform_driver ls2k_thermal_driver = {
+	.driver = {
+		.name		= "ls2k_thermal",
+#ifdef CONFIG_PM_SLEEP
+		.pm = &ls2k_thermal_pm_ops,
+#endif
+		.of_match_table = of_ls2k_thermal_match,
+	},
+	.probe	= ls2k_thermal_probe,
+	.remove	= ls2k_thermal_remove,
+};
+module_platform_driver(ls2k_thermal_driver);
-- 
2.31.1

