Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679A862D490
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbiKQICk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiKQICh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:02:37 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 427BADF57;
        Thu, 17 Nov 2022 00:02:34 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8AxbdqY6nVjHzcIAA--.23520S3;
        Thu, 17 Nov 2022 16:02:32 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx9VaV6nVjCM8VAA--.39038S2;
        Thu, 17 Nov 2022 16:02:31 +0800 (CST)
Subject: Re: [PATCH v12 1/2] thermal: loongson-2: add thermal management
 support
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
References: <20221114024709.7975-1-zhuyinbo@loongson.cn>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <7573d427-a830-4da3-c016-3c6bbec2563e@loongson.cn>
Date:   Thu, 17 Nov 2022 16:02:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221114024709.7975-1-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx9VaV6nVjCM8VAA--.39038S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvAXoWfGFW3WFWkGw13try5try7KFg_yoW8Jr1rZo
        WfJr1v9F4Syr1IyFyqqryUJFyaqa4UZ3W3ZFySkrs0qFWFqwn8ZrW5Gr43GF1rua1rtr47
        JFy2ga1rXF4ft395n29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUvI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFV
        AK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_Gc
        Wl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487
        Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxAIw28IcV
        Cjz48v1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
        MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
        1lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1U
        MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07joWlkUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maintainer,

Could you help me merge my patch?

Thanks
Yinbo.
ÔÚ 2022/11/14 ÉÏÎç10:47, Yinbo Zhu Ð´µÀ:
> This patch adds the support for Loongson-2 thermal sensor controller,
> which can support maximum 4 sensors.
> 
> It's based on thermal of framework:
>   - Trip points defined in device tree.
>   - Cpufreq as cooling device registered in Loongson-2 cpufreq driver.
>   - Pwm fan as cooling device registered in hwmon pwm-fan driver.
> 
> Signed-off-by: zhanghongchen <zhanghongchen@loongson.cn>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v12:
> 		1. Fixup it about min and max.
> 		2. Use dev_err_probe replace dev_err in devm_request_threaded_irq context.
> Change in v11:
> 		1. Add min() and max() to replace related code in function
> 		   loongson2_thermal_set.
> 		2. Add dev_err_probe to to replace related code for function
> 		   return value use devm_thermal_of_zone_register.
> 		3. Replace thermal_add_hwmon_sysfs with devm_thermal_add_hwmon_sysfs
> 		   and use dev_warn replace dev_err in this context.
> Change in v10:
> 		1. Add all history change log information.
> Change in v9:
> 		1. Switch new API that use devm_thermal_of_zone_register
> 		   to replace previous interfaces.
> 		2. Add depend on LOONGARCH || COMPILE_TEST.
> Change in v8:
>                  1. Replace string loongson2/Loongson2/LOONGSON2 with loongson-2/
>                     Loongson-2/LOONGSON-2 in Kconfig and commit log and MAINTAINERS
> 		   files.
> Change in v7:
> 		1. Split the modification of patch 3 and merge it into this patch.
> 		2. Remove the unless code annotation to fix the compile warning
> 		   when compile C code with W=1.
> Change in v6:
> 		1. NO change, but other patch in this series of patches set has
> 		   changes.
> Change in v5:
> 		1. NO change, but other patch in this series of patches set has
> 		   changes.
> Change in v4:
> 		1. Fixup the compatible.
> Change in v3:
> 		1. Add a function to gain sensor id an remove dts id.
> Change in v2:
> 		1. Remove error msg printing when addr ioremap has error.
> 		2. Make loongson2 thermal driver was built-in by default.
> 		3. Replace ls2k with loongson2.
> 		4. Remove CONFIG_PM_SLEEP and set pm function type was
> 		   __maybe_unused.
> 
>   MAINTAINERS                         |   7 +
>   drivers/thermal/Kconfig             |  10 ++
>   drivers/thermal/Makefile            |   1 +
>   drivers/thermal/loongson2_thermal.c | 260 ++++++++++++++++++++++++++++
>   4 files changed, 278 insertions(+)
>   create mode 100644 drivers/thermal/loongson2_thermal.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1b391ca7cf91..0d867573fe4c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12013,6 +12013,13 @@ F:	drivers/*/*loongarch*
>   F:	Documentation/loongarch/
>   F:	Documentation/translations/zh_CN/loongarch/
>   
> +LOONGSON-2 SOC SERIES THERMAL DRIVER
> +M:	zhanghongchen <zhanghongchen@loongson.cn>
> +M:	Yinbo Zhu <zhuyinbo@loongson.cn>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/thermal/loongson2_thermal.c
> +
>   LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>   M:	Sathya Prakash <sathya.prakash@broadcom.com>
>   M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index e052dae614eb..93d84bcb16dd 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -504,4 +504,14 @@ config KHADAS_MCU_FAN_THERMAL
>   	  If you say yes here you get support for the FAN controlled
>   	  by the Microcontroller found on the Khadas VIM boards.
>   
> +config LOONGSON2_THERMAL
> +	tristate "Loongson-2 SoC series thermal driver"
> +	depends on LOONGARCH || COMPILE_TEST
> +	depends on OF
> +	help
> +	  Support for Thermal driver found on Loongson-2 SoC series platforms.
> +	  It supports one critical trip point and one passive trip point. The
> +	  cpufreq and the pwm fan is used as the cooling device to throttle
> +	  CPUs when the passive trip is crossed.
> +
>   endif
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 2506c6c8ca83..02f3db809858 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -61,3 +61,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
>   obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
>   obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
>   obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
> +obj-$(CONFIG_LOONGSON2_THERMAL)	+= loongson2_thermal.o
> diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
> new file mode 100644
> index 000000000000..2d495469e8dd
> --- /dev/null
> +++ b/drivers/thermal/loongson2_thermal.c
> @@ -0,0 +1,260 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Author: zhanghongchen <zhanghongchen@loongson.cn>
> + *         Yinbo Zhu <zhuyinbo@loongson.cn>
> + * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/cpufreq.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/of_device.h>
> +#include <linux/thermal.h>
> +#include "thermal_hwmon.h"
> +
> +#define LOONGSON2_SOC_MAX_SENSOR_NUM			4
> +
> +#define LOONGSON2_TSENSOR_CTRL_HI			0x0
> +#define LOONGSON2_TSENSOR_CTRL_LO			0x8
> +#define LOONGSON2_TSENSOR_STATUS			0x10
> +#define LOONGSON2_TSENSOR_OUT				0x14
> +
> +struct loongson2_thermal_data {
> +	struct thermal_zone_device *tzd;
> +	int irq;
> +	int id;
> +	void __iomem *regs;
> +	struct platform_device *pdev;
> +	u16 ctrl_low_val;
> +	u16 ctrl_hi_val;
> +};
> +
> +static int loongson2_thermal_set(struct loongson2_thermal_data *data,
> +					int low, int high, bool enable)
> +{
> +	u64 reg_ctrl = 0;
> +	int reg_off = data->id * 2;
> +
> +	if (low > high)
> +		return -EINVAL;
> +
> +	low = max(low, -100);
> +	high = min(high, 155);
> +
> +	low += 100;
> +	high += 100;
> +
> +	reg_ctrl |= low;
> +	reg_ctrl |= enable ? 0x100 : 0;
> +	writew(reg_ctrl, data->regs + LOONGSON2_TSENSOR_CTRL_LO + reg_off);
> +
> +	reg_ctrl = 0;
> +	reg_ctrl |= high;
> +	reg_ctrl |= enable ? 0x100 : 0;
> +	writew(reg_ctrl, data->regs + LOONGSON2_TSENSOR_CTRL_HI + reg_off);
> +
> +	return 0;
> +}
> +
> +static int loongson2_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> +{
> +	u32 reg_val;
> +	struct loongson2_thermal_data *data = tz->devdata;
> +
> +	reg_val = readl(data->regs + LOONGSON2_TSENSOR_OUT);
> +	*temp = ((reg_val & 0xff) - 100) * 1000;
> +
> +	return 0;
> +}
> +
> +static int loongson2_thermal_get_sensor_id(void)
> +{
> +	int ret, id;
> +	struct of_phandle_args sensor_specs;
> +	struct device_node *np, *sensor_np;
> +
> +	np = of_find_node_by_name(NULL, "thermal-zones");
> +	if (!np)
> +		return -ENODEV;
> +
> +	sensor_np = of_get_next_child(np, NULL);
> +	ret = of_parse_phandle_with_args(sensor_np, "thermal-sensors",
> +			"#thermal-sensor-cells",
> +			0, &sensor_specs);
> +	if (ret) {
> +		of_node_put(np);
> +		of_node_put(sensor_np);
> +		return ret;
> +	}
> +
> +	if (sensor_specs.args_count >= 1) {
> +		id = sensor_specs.args[0];
> +		WARN(sensor_specs.args_count > 1,
> +				"%s: too many cells in sensor specifier %d\n",
> +				sensor_specs.np->name, sensor_specs.args_count);
> +	} else {
> +		id = 0;
> +	}
> +
> +	of_node_put(np);
> +	of_node_put(sensor_np);
> +
> +	return id;
> +}
> +
> +static irqreturn_t loongson2_thermal_alarm_irq(int irq, void *dev)
> +{
> +	struct loongson2_thermal_data *data = dev;
> +
> +	/* clear interrupt */
> +	writeb(0x3, data->regs + LOONGSON2_TSENSOR_STATUS);
> +
> +	disable_irq_nosync(irq);
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
> +{
> +	struct loongson2_thermal_data *data = dev;
> +
> +	thermal_zone_device_update(data->tzd,
> +				   THERMAL_EVENT_UNSPECIFIED);
> +	enable_irq(data->irq);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
> +{
> +	struct loongson2_thermal_data *data = tz->devdata;
> +
> +	return loongson2_thermal_set(data, low/1000, high/1000, true);
> +}
> +
> +static const struct thermal_zone_device_ops loongson2_of_thermal_ops = {
> +	.get_temp = loongson2_thermal_get_temp,
> +	.set_trips = loongson2_thermal_set_trips,
> +};
> +
> +static int loongson2_thermal_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	struct loongson2_thermal_data *data;
> +	int ret;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->pdev = pdev;
> +	platform_set_drvdata(pdev, data);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->regs = devm_ioremap(dev, res->start, resource_size(res));
> +	if (IS_ERR(data->regs))
> +		return PTR_ERR(data->regs);
> +
> +	/* get irq */
> +	data->irq = platform_get_irq(pdev, 0);
> +	if (data->irq < 0)
> +		return data->irq;
> +
> +	/* get id */
> +	data->id = loongson2_thermal_get_sensor_id();
> +	if (data->id > LOONGSON2_SOC_MAX_SENSOR_NUM - 1 || data->id < 0) {
> +		dev_err(dev, "sensor id error,must be in <0 ~ %d>\n",
> +				LOONGSON2_SOC_MAX_SENSOR_NUM - 1);
> +		return -EINVAL;
> +	}
> +
> +	writeb(0xff, data->regs + LOONGSON2_TSENSOR_STATUS);
> +
> +	loongson2_thermal_set(data, 0, 0, false);
> +
> +	data->tzd = devm_thermal_of_zone_register(&pdev->dev, data->id, data,
> +			&loongson2_of_thermal_ops);
> +	if (IS_ERR(data->tzd))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(data->tzd),
> +				"failed to register");
> +
> +	ret = devm_request_threaded_irq(dev, data->irq,
> +			loongson2_thermal_alarm_irq, loongson2_thermal_irq_thread,
> +			IRQF_ONESHOT, "loongson2_thermal", data);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to request alarm irq\n");
> +
> +	/*
> +	 * Thermal_zone doesn't enable hwmon as default,
> +	 * enable it here
> +	 */
> +	data->tzd->tzp->no_hwmon = false;
> +	if (devm_thermal_add_hwmon_sysfs(data->tzd))
> +		dev_warn(&pdev->dev, "Failed to add hwmon sysfs attributes\n");
> +
> +	return 0;
> +}
> +
> +static int loongson2_thermal_remove(struct platform_device *pdev)
> +{
> +	struct loongson2_thermal_data *data = platform_get_drvdata(pdev);
> +	int reg_off = data->id * 2;
> +
> +	/* disable interrupt */
> +	writew(0, data->regs + LOONGSON2_TSENSOR_CTRL_LO + reg_off);
> +	writew(0, data->regs + LOONGSON2_TSENSOR_CTRL_HI + reg_off);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_loongson2_thermal_match[] = {
> +	{ .compatible = "loongson,ls2k-thermal",},
> +	{ /* end */ }
> +};
> +MODULE_DEVICE_TABLE(of, of_loongson2_thermal_match);
> +
> +static int __maybe_unused loongson2_thermal_suspend(struct device *dev)
> +{
> +	struct loongson2_thermal_data *data = dev_get_drvdata(dev);
> +	int reg_off = data->id * 2;
> +
> +	data->ctrl_low_val = readw(data->regs + LOONGSON2_TSENSOR_CTRL_LO + reg_off);
> +	data->ctrl_hi_val = readw(data->regs + LOONGSON2_TSENSOR_CTRL_HI + reg_off);
> +
> +	writew(0, data->regs + LOONGSON2_TSENSOR_CTRL_LO + reg_off);
> +	writew(0, data->regs + LOONGSON2_TSENSOR_CTRL_HI + reg_off);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused loongson2_thermal_resume(struct device *dev)
> +{
> +	struct loongson2_thermal_data *data = dev_get_drvdata(dev);
> +	int reg_off = data->id * 2;
> +
> +	writew(data->ctrl_low_val, data->regs + LOONGSON2_TSENSOR_CTRL_LO + reg_off);
> +	writew(data->ctrl_hi_val, data->regs + LOONGSON2_TSENSOR_CTRL_HI + reg_off);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(loongson2_thermal_pm_ops,
> +			 loongson2_thermal_suspend, loongson2_thermal_resume);
> +
> +static struct platform_driver loongson2_thermal_driver = {
> +	.driver = {
> +		.name		= "loongson2_thermal",
> +		.pm = &loongson2_thermal_pm_ops,
> +		.of_match_table = of_loongson2_thermal_match,
> +	},
> +	.probe	= loongson2_thermal_probe,
> +	.remove	= loongson2_thermal_remove,
> +};
> +module_platform_driver(loongson2_thermal_driver);
> +
> +MODULE_DESCRIPTION("Loongson2 thermal driver");
> +MODULE_LICENSE("GPL");
> 

