Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A0B6EF300
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 13:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240519AbjDZLB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 07:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjDZLBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 07:01:55 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CB62694
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 04:01:52 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id rcuDpKT0qFuuVrcuDpbgiJ; Wed, 26 Apr 2023 13:01:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682506911;
        bh=P6l6zetgQcrJakLHGkVzKt0vOihvntcZ5fakSmWckj4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=PMEc6EQZwrcoHkmUPELBMsggN7cgyIcmkBlP420dZSsfD2LFWzC2yoMEIX/BtzafN
         yzv9x8T2KSBN2kryQderxNm0qgN3UNHF1EmkuuF0lC/54uwLDWe6fqaRP/fuQHHbMe
         UJNY3GQG15k35PL95iySi4ZUscH9mGXaA5k8X83gUJSmTADIrCBzsdvOTw1HMm8mEV
         kpdeFsSxuT6dFizpHEQg+ehgVpVpo9OjC+fhmnxgERZhIOcVVglikBxHRIVJUz9RxP
         8u8iIh5syS3fccjH6xvnhnacbRYqBR2G6X/R5NF6G4pE/xBvvjQ4LwGC2MYInWvaeR
         kdQfj9OlKoXHw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 26 Apr 2023 13:01:50 +0200
X-ME-IP: 86.243.2.178
Message-ID: <8ff8025f-bdbb-ec5f-9e2b-a182e3ff2e7d@wanadoo.fr>
Date:   Wed, 26 Apr 2023 13:01:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] hwmon: (max597x) Add Maxim Max597x
Content-Language: fr, en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20230426090356.745979-1-Naresh.Solanki@9elements.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230426090356.745979-1-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26/04/2023 à 11:03, Naresh Solanki a écrit :
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add support for the Maxim Max59x power switch with current/voltage
> monitor.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Hi,

a few nit below, should there be a v2.

CJ

> ---
>   drivers/hwmon/Kconfig   |   9 ++
>   drivers/hwmon/Makefile  |   1 +
>   drivers/hwmon/max597x.c | 212 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 222 insertions(+)
>   create mode 100644 drivers/hwmon/max597x.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 5b3b76477b0e..164d980d9de2 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1097,6 +1097,15 @@ config SENSORS_MAX31760
>   	  This driver can also be built as a module. If so, the module
>   	  will be called max31760.
>   
> +config SENSORS_MAX597X
> +	tristate "Maxim 597x power switch and monitor"
> +	depends on I2C
> +	depends on OF
> +	select MFD_MAX597X
> +	help
> +	  This driver exposes Maxim 5970/5978 voltage/current monitoring
> +	  interface.
> +
>   config SENSORS_MAX6620
>   	tristate "Maxim MAX6620 fan controller"
>   	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 88712b5031c8..720eb7d5fe46 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -142,6 +142,7 @@ obj-$(CONFIG_SENSORS_MAX197)	+= max197.o
>   obj-$(CONFIG_SENSORS_MAX31722)	+= max31722.o
>   obj-$(CONFIG_SENSORS_MAX31730)	+= max31730.o
>   obj-$(CONFIG_SENSORS_MAX31760)  += max31760.o
> +obj-$(CONFIG_SENSORS_MAX597X)	+= max597x.o
>   obj-$(CONFIG_SENSORS_MAX6620)	+= max6620.o
>   obj-$(CONFIG_SENSORS_MAX6621)	+= max6621.o
>   obj-$(CONFIG_SENSORS_MAX6639)	+= max6639.o
> diff --git a/drivers/hwmon/max597x.c b/drivers/hwmon/max597x.c
> new file mode 100644
> index 000000000000..d4d8c2faf55c
> --- /dev/null
> +++ b/drivers/hwmon/max597x.c
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device driver for regulators in MAX5970 and MAX5978 IC
> + *
> + * Copyright (c) 2022 9elements GmbH
> + *
> + * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
> + */
> +
> +#include <linux/hwmon.h>
> +#include <linux/i2c.h>
> +#include <linux/mfd/max597x.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +struct max597x_hwmon {
> +	int num_switches, irng[MAX5970_NUM_SWITCHES], mon_rng[MAX5970_NUM_SWITCHES];

Having 1 item per line is much more usual.

> +	struct regmap *regmap;
> +};
> +
> +static int max597x_read_reg(struct max597x_hwmon *ddata, int reg, int range, long *val)
> +{
> +	u8 reg_data[2];
> +	int ret;
> +
> +	ret = regmap_bulk_read(ddata->regmap, reg, &reg_data[0], 2);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = (reg_data[0] << 2) | (reg_data[1] & 3);
> +	*val = *val * range;
> +	/*
> +	 * From datasheet, the range is fractionally less.
> +	 * To compensate that, divide with 1033 number.
> +	 */
> +	*val = *val / 1033;
> +
> +	return 0;
> +}
> +
> +static int max597x_read(struct device *dev, enum hwmon_sensor_types type,
> +			u32 attr, int channel, long *val)
> +{
> +	struct max597x_hwmon *ddata = dev_get_drvdata(dev);
> +	int ret;
> +
> +	switch (type) {
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_input:
> +			ret = max597x_read_reg(ddata, MAX5970_REG_CURRENT_H(channel),
> +					       ddata->irng[channel], val);
> +			if (ret < 0)
> +				return ret;
> +
> +			return 0;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_input:
> +			ret = max597x_read_reg(ddata, MAX5970_REG_VOLTAGE_H(channel),
> +					       ddata->mon_rng[channel], val);
> +			if (ret < 0)
> +				return ret;
> +			return 0;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +	return -EOPNOTSUPP;
> +}
> +
> +static umode_t max597x_is_visible(const void *data,
> +				  enum hwmon_sensor_types type,
> +				  u32 attr, int channel)
> +{
> +	struct max597x_hwmon *ddata = (struct max597x_hwmon *)data;
> +
> +	if (channel >= ddata->num_switches)
> +		return 0;
> +
> +	switch (type) {
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_input:
> +			return 0444;
> +		}
> +		break;
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_input:
> +			return 0444;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static const struct hwmon_ops max597x_hwmon_ops = {
> +	.is_visible = max597x_is_visible,
> +	.read = max597x_read,
> +};
> +
> +#define HWMON_CURRENT	HWMON_C_INPUT
> +#define HWMON_VOLTAGE	HWMON_I_INPUT
> +
> +static const struct hwmon_channel_info *max597x_info[] = {
> +	HWMON_CHANNEL_INFO(in, HWMON_VOLTAGE, HWMON_VOLTAGE),
> +	HWMON_CHANNEL_INFO(curr, HWMON_CURRENT, HWMON_CURRENT),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info max597x_chip_info = {
> +	.ops = &max597x_hwmon_ops,
> +	.info = max597x_info,
> +};
> +
> +static int max597x_adc_range(struct regmap *regmap, const int ch,
> +			     u32 *irng, u32 *mon_rng)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	/* Decode current ADC range */
> +	ret = regmap_read(regmap, MAX5970_REG_STATUS2, &reg);
> +	if (ret)
> +		return ret;
> +	switch (MAX5970_IRNG(reg, ch)) {
> +	case 0:
> +		*irng = 100000;	/* 100 mV */
> +		break;
> +	case 1:
> +		*irng = 50000;	/* 50 mV */
> +		break;
> +	case 2:
> +		*irng = 25000;	/* 25 mV */
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Decode current voltage monitor range */
> +	ret = regmap_read(regmap, MAX5970_REG_MON_RANGE, &reg);
> +	if (ret)
> +		return ret;
> +
> +	*mon_rng = MAX5970_MON_MAX_RANGE_UV >> MAX5970_MON(reg, ch);
> +	*mon_rng /= 1000; /* uV to mV */
> +
> +	return 0;
> +}
> +
> +static int max597x_sensor_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct i2c_client *i2c = to_i2c_client(pdev->dev.parent);
> +	struct max597x_hwmon *ddata;
> +	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	struct device *hwmon_dev;
> +	int err;
> +
> +	if (!regmap)
> +		return -EPROBE_DEFER;
> +
> +	ddata = devm_kzalloc(dev, sizeof(struct max597x_hwmon), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	if (of_device_is_compatible(i2c->dev.of_node, "maxim,max5978"))
> +		ddata->num_switches = MAX597x_TYPE_MAX5978;
> +	else if (of_device_is_compatible(i2c->dev.of_node, "maxim,max5970"))
> +		ddata->num_switches = MAX597x_TYPE_MAX5970;
> +	else
> +		return -ENODEV;
> +
> +	ddata->regmap = regmap;
> +
> +	for (int i = 0; i < ddata->num_switches; i++) {

This is unusual to define 'i' within a 'for' loop.

> +		err = max597x_adc_range(regmap, i, &ddata->irng[i], &ddata->mon_rng[i]);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev,
> +							 "max597x_hwmon", ddata,
> +							 &max597x_chip_info, NULL);
> +

Unneeded empty line.

> +	if (IS_ERR(hwmon_dev)) {
> +		err = PTR_ERR(hwmon_dev);
> +		dev_err(dev, "Unable to register hwmon device, returned %d\n", err);
> +		return err;

return dev_err_probe()?

CJ

> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver max597x_sensor_driver = {
> +	.probe = max597x_sensor_probe,
> +	.driver = {
> +		.name = "max597x-hwmon",
> +	},
> +};
> +module_platform_driver(max597x_sensor_driver);
> +
> +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
> +MODULE_DESCRIPTION("MAX5970_hot-swap controller driver");
> +MODULE_LICENSE("GPL v2");
> 
> base-commit: b4c288cfd2f84c44994330c408e14645d45dee5b

