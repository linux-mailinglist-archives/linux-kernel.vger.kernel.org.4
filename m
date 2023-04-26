Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2182F6EF68B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241441AbjDZOff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241471AbjDZOfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:35:21 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699905FC0;
        Wed, 26 Apr 2023 07:35:07 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b64a32fd2so9212323b3a.2;
        Wed, 26 Apr 2023 07:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682519707; x=1685111707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6r2vGi6GBK2UfDDfSgYbb13NcTa7/Tw65f7HgEsxhG8=;
        b=ZpLqAOqCfJilIbR8HOVkztrS1CEU9Uhg0SLq74G18C1vePCXMXJ+4Xfvim2nOCb9t/
         NmuF+luDaOTEySUqnjwF2m/B+s0/xamgeyYhYlG6CPQcRkhXOBhFeCGEaI8WE2OSYg15
         O8VJmZMKpzFQ4gb+zX+F8ZiGYjHqgwLSdI9or6X+ShtmulToca7uazb23wrfisiQ8RsB
         0nJtrMYRzxKSb8DFIbdOiLL8BqN2xNaCk57Zx+9EVfVJFhz9igKUlyJdV9nvzcfTZ8u/
         xk9pSb+k6JMO4jB9GmRxVY4a3sIl/rV6S9xkePtL0QsJEXR+rp6DTVn8ku6X5GIPCry0
         EEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682519707; x=1685111707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6r2vGi6GBK2UfDDfSgYbb13NcTa7/Tw65f7HgEsxhG8=;
        b=Wd/KbUGd+XN7pefyMrFZZ+0Hm1HvWLwDCbmeBqBJGSO27kBdEYMRn/nZeNlvt+HnSo
         azHuoNtFXGtvrW9fTiD+iSH+aZGEoRxncT7eq9bx9+domFk6CePHDdYpoc16TjFuMSQS
         RQh+waYc/xxQwR1MQyGU0RlCj4FUrWNOMeIAHGXRNmGKS8x+NV74cDyBgos6A+AGTH2B
         HpwMcwIRduttAuGp71yj597Fln6K4zrw8f05i6z5nQOYqu9y7PSJvjrfAcamhzBySu7P
         GC9DKqTa/gUNMVXGVAHcz+pjamD8GpNOmFz/18VaNoOMfh5SPijvQ5BTkXT34pKa8Pve
         P0jg==
X-Gm-Message-State: AAQBX9fs+T862kOtxuiYW4xWeSzMiDEaTHFbndjfEovGYpNAMUNiGc+A
        H7x0RVUg8yUBGjQLxfU7AKard0m5h+k=
X-Google-Smtp-Source: AKy350a4ClgPAeyF5kk5lv0F71J4C2/9Ofav2r+nklj9lekBxGNVHcQ/JRajMKsl4BbNNF3mxS3iWw==
X-Received: by 2002:a05:6a20:7f9f:b0:ec:6882:f04b with SMTP id d31-20020a056a207f9f00b000ec6882f04bmr26208278pzj.8.1682519706755;
        Wed, 26 Apr 2023 07:35:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l26-20020a635b5a000000b0051416609fb7sm9616831pgm.61.2023.04.26.07.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 07:35:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 26 Apr 2023 07:35:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: (max597x) Add Maxim Max597x
Message-ID: <2579ed08-b21d-489e-8a40-8310efdfa1c4@roeck-us.net>
References: <20230426090356.745979-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426090356.745979-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 11:03:55AM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add support for the Maxim Max59x power switch with current/voltage
> monitor.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Please no wildcards in file names or descriptions for hwmon drivers,
much less dual-digit wildcards.

This patch does not add support for MAX597{0..9} (and much less for
MAX59{00..99}), only for MAX5970 and MAX5978. For example, it does not
and never will support MAX5977 because that chip does not have an I2C
interface, or MAX5974 which happens to be a PWM controller.

Pick one of {5970,5978} for the file name, and mention both in
descriptions. Yes, I understand, this was accepted with wildcard
in mfd and regulator subsystems, but that doesn't make it acceptable
here.

Either case, what does this driver provide that isn't already
available through drivers/regulator/max597x-regulator.c ?
As written, the driver doesn't support any of the limit or alarm
registers, and there seems to be quite some overlap with the regulator
driver in terms of functionality. Please explore if that is acceptable
for the regulator subsystem. If it is not, come back and we can continue
discussing feasibility as separate hwmon driver. 

> ---
>  drivers/hwmon/Kconfig   |   9 ++
>  drivers/hwmon/Makefile  |   1 +
>  drivers/hwmon/max597x.c | 212 ++++++++++++++++++++++++++++++++++++++++

Documentation missing.

>  3 files changed, 222 insertions(+)
>  create mode 100644 drivers/hwmon/max597x.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 5b3b76477b0e..164d980d9de2 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1097,6 +1097,15 @@ config SENSORS_MAX31760
>  	  This driver can also be built as a module. If so, the module
>  	  will be called max31760.
>  
> +config SENSORS_MAX597X
> +	tristate "Maxim 597x power switch and monitor"
> +	depends on I2C
> +	depends on OF
> +	select MFD_MAX597X

That should be "depends on".

> +	help
> +	  This driver exposes Maxim 5970/5978 voltage/current monitoring
> +	  interface.
> +
>  config SENSORS_MAX6620
>  	tristate "Maxim MAX6620 fan controller"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 88712b5031c8..720eb7d5fe46 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -142,6 +142,7 @@ obj-$(CONFIG_SENSORS_MAX197)	+= max197.o
>  obj-$(CONFIG_SENSORS_MAX31722)	+= max31722.o
>  obj-$(CONFIG_SENSORS_MAX31730)	+= max31730.o
>  obj-$(CONFIG_SENSORS_MAX31760)  += max31760.o
> +obj-$(CONFIG_SENSORS_MAX597X)	+= max597x.o
>  obj-$(CONFIG_SENSORS_MAX6620)	+= max6620.o
>  obj-$(CONFIG_SENSORS_MAX6621)	+= max6621.o
>  obj-$(CONFIG_SENSORS_MAX6639)	+= max6639.o
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

Where in the datasheet, and why is this conversion not needed in the
regulator driver ?

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

max597x_read_reg() returns a negative value or 0. Why not just return it ?

The regulator driver takes shunt resistor values into account.

Again, I think it would make much more sense to add hwmon support
to the regulator driver than having a separate driver since there
is lots of overlap. For example, the regulator driver already
sets and monitors limits.

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

Please add missing default: cases as reported by 0-day.

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

Please drop and use HWMON_C_INPUT as well as HWMON_I_INPUT
directly.

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

That function also exists on the regulator driver.

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

Since the parent driver is a mfd driver, I'd assume that this driver
should be instantiated from there, and I don't see why probe would ever
have to be deferred. Please explain how that can happen.

> +
> +	ddata = devm_kzalloc(dev, sizeof(struct max597x_hwmon), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	if (of_device_is_compatible(i2c->dev.of_node, "maxim,max5978"))
> +		ddata->num_switches = MAX597x_TYPE_MAX5978;
> +	else if (of_device_is_compatible(i2c->dev.of_node, "maxim,max5970"))
> +		ddata->num_switches = MAX597x_TYPE_MAX5970;

Uuh, no. That is just accidentally correct, based on

enum max597x_chip_type {
        MAX597x_TYPE_MAX5978 = 1,
        MAX597x_TYPE_MAX5970,
};

The assumption that the numeric chip type matches the number of channels
it supports is as wrong as it can be. There are defines for the number
of channels. I am pretty much completely at loss why they are not used.
Tha same applies for the regulator driver, of course.

> +	else
> +		return -ENODEV;
> +
> +	ddata->regmap = regmap;
> +
> +	for (int i = 0; i < ddata->num_switches; i++) {
> +		err = max597x_adc_range(regmap, i, &ddata->irng[i], &ddata->mon_rng[i]);
> +		if (err < 0)
> +			return err;

Why no error message here but one below ? I am not in favor of error
messages in the probe function, but if you use them please be consistent.

> +	}
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev,
> +							 "max597x_hwmon", ddata,
> +							 &max597x_chip_info, NULL);
> +
> +	if (IS_ERR(hwmon_dev)) {
> +		err = PTR_ERR(hwmon_dev);
> +		dev_err(dev, "Unable to register hwmon device, returned %d\n", err);

Use dev_err_probe()

> +		return err;
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
> -- 
> 2.39.1
> 
