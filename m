Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A398668BF1B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjBFOAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjBFN7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:59:54 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7280B455
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:59:25 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id y1so10461766wru.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H2y+XDJknOcwfRBv6dQ8rmLVvWFQNePYDISIGK84M7E=;
        b=HBoW2tOCX5h+bh4VaXZepfyv0SRr5TtAQME3Rd8ZevYIeEfXJjiMA2Buxhfgv8MeKZ
         6E2hC/E11hPEvs7fhc+6Omq/9SKWa1sDqQP6R+E0iOZmAN2ORzdMBws+fqXLvYehweBS
         ZU3Tfi7SeVqiTA4RDMynBpgAfEMh+0NYeHL4N2ISzaszrDf1TY5I/qVGkMMu5Pe7TfCZ
         T/B7F/gVbEY5Q0mlUDBLx5yOXM66vFpqZqQCvSg3wlSfmPal8DjhxgPRVLnawtIUbefg
         Rzl1vitaBIt5IqTUb7GRi0Udzyxr1ErWlCwOP0d1SOi4jG1/rpkKsEpp0erxE++A3yXh
         fYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2y+XDJknOcwfRBv6dQ8rmLVvWFQNePYDISIGK84M7E=;
        b=cWisW3VTX/NDBvyIlgL7XeGHFK98OMBDirbMwL5+6Vt9EatZ5mPq7DebVHD25QJ/aq
         p7c8cZNBtcDcyZ0fpTXbS5Ad+1GnTLbOMCtPqlz+bCZC1q+ZCReH2yJYox1VEoPJhw8n
         2jofQyTgFsXGEhF4aQWUcAh71AmBnZZawB2fJPFt5EotNYJlidocdZmCoTVK7ChS6FyZ
         5zQYFV8GZwP8QimXX/jKiDbmKmGPa3NlsbJsPdAMzkhXMillW+7QbtzBkI7J6G8IagqE
         MX/TT4D2eC66uSyuvpL2L99HFrTzjoJRTAsGg0dFUPX9b3kcKOLoIxYQ7QDQkiRnSBqK
         IpfA==
X-Gm-Message-State: AO0yUKX5+UC3i7AM4xu/Q3ciopADsT6kJGPazxHB1O7m/MgZ1mPZNS+Z
        hqp6GJ1Xky/Myaul9S7O7kLbow==
X-Google-Smtp-Source: AK7set/P3LbVKxvVNZKkDh27CL1sRSlnHjJV2RITi1JxQOy2Zc/u96JSQiCrV6clB+56NGbsDkpcZQ==
X-Received: by 2002:a5d:67c2:0:b0:2bf:ee15:ba85 with SMTP id n2-20020a5d67c2000000b002bfee15ba85mr15479757wrw.18.1675691964223;
        Mon, 06 Feb 2023 05:59:24 -0800 (PST)
Received: from linaro.org (wifi-eduroam-trans.univ-tlse3.fr. [195.220.58.237])
        by smtp.gmail.com with ESMTPSA id o5-20020a5d6845000000b002bdff778d87sm8846714wrw.34.2023.02.06.05.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 05:59:23 -0800 (PST)
Date:   Mon, 6 Feb 2023 14:59:21 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
Subject: Re: [PATCH v12 1/2] thermal: loongson-2: add thermal management
 support
Message-ID: <20230206135921.GA15176@linaro.org>
References: <20221114024709.7975-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221114024709.7975-1-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 10:47:08AM +0800, Yinbo Zhu wrote:
> This patch adds the support for Loongson-2 thermal sensor controller,
> which can support maximum 4 sensors.
> 
> It's based on thermal of framework:
>  - Trip points defined in device tree.
>  - Cpufreq as cooling device registered in Loongson-2 cpufreq driver.
>  - Pwm fan as cooling device registered in hwmon pwm-fan driver.
> 

This changelog is not helpful.

Please describe how works the sensor. 

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
>                 1. Replace string loongson2/Loongson2/LOONGSON2 with loongson-2/
>                    Loongson-2/LOONGSON-2 in Kconfig and commit log and MAINTAINERS
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
>  MAINTAINERS                         |   7 +
>  drivers/thermal/Kconfig             |  10 ++
>  drivers/thermal/Makefile            |   1 +
>  drivers/thermal/loongson2_thermal.c | 260 ++++++++++++++++++++++++++++
>  4 files changed, 278 insertions(+)
>  create mode 100644 drivers/thermal/loongson2_thermal.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1b391ca7cf91..0d867573fe4c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12013,6 +12013,13 @@ F:	drivers/*/*loongarch*
>  F:	Documentation/loongarch/
>  F:	Documentation/translations/zh_CN/loongarch/
>  
> +LOONGSON-2 SOC SERIES THERMAL DRIVER
> +M:	zhanghongchen <zhanghongchen@loongson.cn>
> +M:	Yinbo Zhu <zhuyinbo@loongson.cn>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/thermal/loongson2_thermal.c
> +
>  LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>  M:	Sathya Prakash <sathya.prakash@broadcom.com>
>  M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index e052dae614eb..93d84bcb16dd 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -504,4 +504,14 @@ config KHADAS_MCU_FAN_THERMAL
>  	  If you say yes here you get support for the FAN controlled
>  	  by the Microcontroller found on the Khadas VIM boards.
>  
> +config LOONGSON2_THERMAL
> +	tristate "Loongson-2 SoC series thermal driver"
> +	depends on LOONGARCH || COMPILE_TEST
> +	depends on OF

Please check commit 8df4ef3eaa62b

> +	help
> +	  Support for Thermal driver found on Loongson-2 SoC series platforms.
> +	  It supports one critical trip point and one passive trip point. The
> +	  cpufreq and the pwm fan is used as the cooling device to throttle
> +	  CPUs when the passive trip is crossed.

The help is misleading. The thermal framework supports the trip points, not the
driver. Also, the cooling devices association is related to the thermal zone,
not the sensor.

>  endif
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 2506c6c8ca83..02f3db809858 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -61,3 +61,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
>  obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
>  obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
>  obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
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

'tzd' won't be needed after taking into account the comments

> +	int irq;

'irq' won't be needed after taking into account the comments

> +	int id;
> +	void __iomem *regs;
> +	struct platform_device *pdev;

'pdev' is not needed

> +	u16 ctrl_low_val;
> +	u16 ctrl_hi_val;

Those fields won't be needed after taking into account the comments

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

Why are those values added to the low and high ? Did you mean low += 0x100 ?

Mind to describe a bit the register layout?

> +	reg_ctrl |= low;

	reg_ctrl = low;

> +	reg_ctrl |= enable ? 0x100 : 0;
> +	writew(reg_ctrl, data->regs + LOONGSON2_TSENSOR_CTRL_LO + reg_off);
> +
> +	reg_ctrl = 0;

No need to reset the variable.

	reg_ctrl = high;

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

Why '-100' ?

Is the unit returned 'degrees' ?

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

This is not needed. Please do not tamper with the OF code in the sensor.

You should know the id in this sensor driver

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

It is not necessary to create a couple of irq callback for this.

Just clear the interrupt in loongson2_thermal_irq_thread() and drop loongson2_thermal_alarm_irq().

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

It would be nicer to use a reset line if it is available

> +	data->tzd = devm_thermal_of_zone_register(&pdev->dev, data->id, data,
> +			&loongson2_of_thermal_ops);
> +	if (IS_ERR(data->tzd))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(data->tzd),
> +				"failed to register");

If you want to not care about the kind of SoC the sensor belongs to, you can
use the return value of devm_thermal_of_zone_register() which returns -ENODEV
and which is not considered as an error.

IOW:

	for (i = 0; i < LOONGSON2_SOC_MAX_SENSOR_NUM; i++) {

		tzd = devm_thermal_of_zone_register(&pdev->dev, i,
			data, &loongson2_of_thermal_ops);
		if (!IS_ERR(tzd))
			break;

		if (PTR_ERR(tzd) != ENODEV)
			continue;

		return dev_err_probe(&pdev->dev, PTR_ERR(tzd),
	                             "failed to register");
	}

> +	ret = devm_request_threaded_irq(dev, data->irq,
> +			loongson2_thermal_alarm_irq, loongson2_thermal_irq_thread,
> +			IRQF_ONESHOT, "loongson2_thermal", data);

Pass 'tzd' instead of 'data'

> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to request alarm irq\n");
> +
> +	/*
> +	 * Thermal_zone doesn't enable hwmon as default,
> +	 * enable it here
> +	 */
> +	data->tzd->tzp->no_hwmon = false;

This is used when registering the thermal zone. Setting it after registering
the thermal zone has no effect. The line can be dropped.

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

The interrupt is disabled with the driver removal as it was registered with the
devres version devm_thermal_of_zone_register()

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_loongson2_thermal_match[] = {
> +	{ .compatible = "loongson,ls2k-thermal",},

You may want to add the sensor id in the data field. Probably depending on the
kind of SoC, one or several sensors will be used. 

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

It is not necessary to save and restore the low and high temperatures for the
$trip points because the thermal framework core code will call at POST_SUSPEND
thermal_zone_device_update() which in turns get the temperature and sets the
trip points.

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
> -- 
> 2.31.1
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
