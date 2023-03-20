Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105C26C0CCB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjCTJI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjCTJIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:08:53 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76EA5E1B4;
        Mon, 20 Mar 2023 02:08:50 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8DxUOWhIhhkh8UOAA--.21561S3;
        Mon, 20 Mar 2023 17:08:49 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxHuRTIhhk8TIHAA--.29689S3;
        Mon, 20 Mar 2023 17:07:32 +0800 (CST)
Subject: Re: [PATCH v13 1/2] thermal: loongson-2: add thermal management
 support
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, wanghongliang@loongson.cn,
        zhanghongchen <zhanghongchen@loongson.cn>, zhuyinbo@loongson.cn
References: <20230221095355.9799-1-zhuyinbo@loongson.cn>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <7a980426-d6ca-d14c-3b41-62c0fb16440c@loongson.cn>
Date:   Mon, 20 Mar 2023 17:07:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230221095355.9799-1-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxHuRTIhhk8TIHAA--.29689S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWfJFWxJF1DGw4xXr13Kry7trb_yoWDCw1fpF
        W7Ca9xCFZrXFsruwn8Ar18AFs0y3W3tFy7ZFs7Gw15urZ8t343Wry8KFy8ArWxCrWDJF4j
        vF909r4DCFWDu3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487
        Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l42xK82IY6x
        8ErcxFaVAv8VWrMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzgAwDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping ?

ÔÚ 2023/2/21 ÏÂÎç5:53, Yinbo Zhu Ð´µÀ:
> This patch adds the support for Loongson-2 thermal sensor controller,
> which can support maximum 4 sensors, each sensor contains a sampling
> register and a control register. The sampling register is used to obtain
> the temperature in real time, the control register GATE field is used to
> set the threshold of high or low temperature, when the input temperature
> is higher than the high temperature threshold or lower than the low
> temperature threshold, an interrupt will occur.
>
> Signed-off-by: zhanghongchen <zhanghongchen@loongson.cn>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v13:
> 		1. Add a description about that how works the sensor.
> 		2. Drop the COMPILE_TEST.
> 		3. Rework the help prograph in LOONGSON2_THERMAL Kconfig.
> 		4. Drop the 'tzd' 'irq' and 'pdev' element in loongson2_thermal_data.
> 		5. Drop the reset of variable in loongson2_thermal_set.
> 		6. Drop the function loongson2_thermal_get_sensor_id.
> 		7. Drop the function loongson2_thermal_alarm_irq.
> 		8. Rework the devm_thermal_of_zone_register.
> 		9. Pass 'tzd' instead of 'data' in devm_request_threaded_irq.
> 		10. Drop the "data->tzd->tzp->no_hwmon = false".
> 		11. Drop the loongson2_thermal_remove.
> 		12. Add the sensor id in the of_device_id data field.
> 		13. Drop the save and restore function.
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
>   MAINTAINERS                         |   7 ++
>   drivers/thermal/Kconfig             |  11 ++
>   drivers/thermal/Makefile            |   1 +
>   drivers/thermal/loongson2_thermal.c | 167 ++++++++++++++++++++++++++++
>   4 files changed, 186 insertions(+)
>   create mode 100644 drivers/thermal/loongson2_thermal.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 57d1d6ecb33d..54e63f51ae6d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12086,6 +12086,13 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
>   F:	drivers/pinctrl/pinctrl-loongson2.c
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
> index eaeb2b2ee6e9..d4b5ecead80e 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -508,4 +508,15 @@ config KHADAS_MCU_FAN_THERMAL
>   	  If you say yes here you get support for the FAN controlled
>   	  by the Microcontroller found on the Khadas VIM boards.
>   
> +config LOONGSON2_THERMAL
> +	tristate "Loongson-2 SoC series thermal driver"
> +	depends on LOONGARCH && OF
> +	help
> +	  Support for Thermal driver found on Loongson-2 SoC series platforms.
> +	  The thermal driver realizes get_temp and set_trips function, which
> +	  are used to obtain the temperature of the current node and set the
> +	  temperature range to trigger the interrupt. When the input temperature
> +	  is higher than the high temperature threshold or lower than the low
> +	  temperature threshold, the interrupt will occur.
> +
>   endif
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index b9b5dc86f5fd..bfc928f70f6d 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -62,3 +62,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
>   obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
>   obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
>   obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
> +obj-$(CONFIG_LOONGSON2_THERMAL)	+= loongson2_thermal.o
> diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
> new file mode 100644
> index 000000000000..7d5f32f50c0c
> --- /dev/null
> +++ b/drivers/thermal/loongson2_thermal.c
> @@ -0,0 +1,167 @@
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
> +	int id;
> +	void __iomem *regs;
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
> +	low = max(low, -40);
> +	high = min(high, 125);
> +
> +	low += 100;
> +	high += 100;
> +
> +	reg_ctrl = low;
> +	reg_ctrl |= enable ? 0x100 : 0;
> +	writew(reg_ctrl, data->regs + LOONGSON2_TSENSOR_CTRL_LO + reg_off);
> +
> +	reg_ctrl = high;
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
> +static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
> +{
> +	struct thermal_zone_device *tzd = dev;
> +	struct loongson2_thermal_data *data = tzd->devdata;
> +
> +	/* clear interrupt */
> +	writeb(0x3, data->regs + LOONGSON2_TSENSOR_STATUS);
> +
> +	thermal_zone_device_update(tzd, THERMAL_EVENT_UNSPECIFIED);
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
> +	struct thermal_zone_device *tzd;
> +	int ret, irq, i;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->id = (uintptr_t)device_get_match_data(dev);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->regs = devm_ioremap(dev, res->start, resource_size(res));
> +	if (IS_ERR(data->regs))
> +		return PTR_ERR(data->regs);
> +
> +	/* get irq */
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
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
> +	for (i = 0; i < LOONGSON2_SOC_MAX_SENSOR_NUM; i++) {
> +		tzd = devm_thermal_of_zone_register(&pdev->dev, i,
> +		    data, &loongson2_of_thermal_ops);
> +
> +		if (!IS_ERR(tzd))
> +			break;
> +
> +		if (PTR_ERR(tzd) != ENODEV)
> +			continue;
> +
> +		return dev_err_probe(&pdev->dev, PTR_ERR(tzd),
> +				     "failed to register");
> +	}
> +
> +	ret = devm_request_threaded_irq(dev, irq, NULL, loongson2_thermal_irq_thread,
> +			IRQF_ONESHOT, "loongson2_thermal", tzd);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to request alarm irq\n");
> +
> +	if (devm_thermal_add_hwmon_sysfs(tzd))
> +		dev_warn(&pdev->dev, "Failed to add hwmon sysfs attributes\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_loongson2_thermal_match[] = {
> +	{ .compatible = "loongson,ls2k-thermal", .data = (const void *)0},
> +	{ /* end */ }
> +};
> +MODULE_DEVICE_TABLE(of, of_loongson2_thermal_match);
> +
> +static struct platform_driver loongson2_thermal_driver = {
> +	.driver = {
> +		.name		= "loongson2_thermal",
> +		.of_match_table = of_loongson2_thermal_match,
> +	},
> +	.probe	= loongson2_thermal_probe,
> +};
> +module_platform_driver(loongson2_thermal_driver);
> +
> +MODULE_DESCRIPTION("Loongson2 thermal driver");
> +MODULE_LICENSE("GPL");

