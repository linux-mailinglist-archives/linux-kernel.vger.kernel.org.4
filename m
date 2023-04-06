Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583446DA0AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjDFTGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjDFTGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:06:17 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE8D11D;
        Thu,  6 Apr 2023 12:06:15 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-17fcc07d6c4so29354648fac.8;
        Thu, 06 Apr 2023 12:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680807973; x=1683399973;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AJYodcTLPcALK662SKlDIzoKqD7JrUMORbzaOnAztas=;
        b=cn8qaET7sh9bpTUgGj7ZZy6fmONXx7DyOrZ/D00x+5J6ZbEQLQb3h0xWQkIE25ewIO
         UEGNcurztVn8k0l9WqDneovPYeuf4pnFrw1ZGM5vtGojuynCrPix3izFtcAzsNvy4Dgp
         GcswJW206MwAXDf/KH+CFu+Q3jO/z0HG87nuB/Fq9XWtxCZ8STPauQJjCQOi5T6Nb8/b
         Ok0rkjVgpiWZbhHljlepU9yOev0Y1USP/JDE5ucV8o85C1mZD3D0X5ZWPZuQ/iRvEiSE
         QGFJo4N89Xkd8yCAbhAOUcKDVOd3C5K5TkxZO9OFpzgdghC+Jo7hrsx1eFNasjDS6p2I
         hbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807973; x=1683399973;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJYodcTLPcALK662SKlDIzoKqD7JrUMORbzaOnAztas=;
        b=OZtVxzFpAuuWbPSKGpBIY3yc4YL04CkjgZZWO0LgJyRV6d7YQzkEYAjj45kVMEOJAT
         tB5JWcXfVMcvWfGX/4dccrhFtntk3NWTaoam1e2bwe6PMnJ7KLpbKdNW5JSkJmykzIhV
         5kU5phA4g6rsrEdKrIswcDRUvIn9lroRxBJbgI2HzMCIcWQEjVb1Lquni3/j6uv11xLv
         VfOW92pddt+4VKHMsHdlbISuq43aQZ+DKgWcDeE/Wk5n6sphj0lsUf2VW29rseCgU0Xs
         1wvcM2R10SVaqnHFqjHQI5dOgDRRNIMB9MBHbj2cb0UWeOh2qvk8AhUPwMVjomqqld2y
         tNvg==
X-Gm-Message-State: AAQBX9fHUQljKNyb4hVm8/IgTOg75Zy4WAl48NjoXFj1BQPrmwtHSrf0
        6V80luTtvllk15nBL1t36U4=
X-Google-Smtp-Source: AKy350askOlVauI/Pixwj4kEyLed7K1Dqt3pq05UdpkNW/eJhwCDc8vQNyZKEjVlt7cFSwSCTUFCNA==
X-Received: by 2002:a05:6870:e308:b0:183:e8b2:92f6 with SMTP id z8-20020a056870e30800b00183e8b292f6mr62851oad.27.1680807973378;
        Thu, 06 Apr 2023 12:06:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id an19-20020a056871b19300b00183fbbe8cdfsm477217oac.31.2023.04.06.12.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 12:06:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 6 Apr 2023 12:06:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Daniel Matyas <daniel.matyas@analog.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        Vincent Tremblay <vincent@vtremblay.dev>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Greg.Schwendimann@infineon.com" <Greg.Schwendimann@infineon.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: max31827: add MAX31827 driver
Message-ID: <aa5ad0bf-3949-435e-b63d-39db6257c2bf@roeck-us.net>
References: <20230406164331.6557-1-daniel.matyas@analog.com>
 <20230406164331.6557-2-daniel.matyas@analog.com>
 <20230406164331.6557-3-daniel.matyas@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230406164331.6557-3-daniel.matyas@analog.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 07:43:27PM +0300, Daniel Matyas wrote:
> MAX31827 is a low-power temperature switch with I2C interface.
> 
> The device is a ±1°C accuracy from -40°C to +125°C
> (12 bits) local temperature switch and sensor with I2C/SM-
> Bus interface. The combination of small 6-bump wafer-lev-
> el package (WLP) and high accuracy makes this temper-
> ature sensor/switch ideal for a wide range of applications.
> 
> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
> ---
>  MAINTAINERS              |   1 +
>  drivers/hwmon/Kconfig    |  11 ++
>  drivers/hwmon/Makefile   |   1 +
>  drivers/hwmon/max31827.c | 240 +++++++++++++++++++++++++++++++++++++++

Documentation/hwmon/max31727.rst missing.

>  4 files changed, 253 insertions(+)
>  create mode 100644 drivers/hwmon/max31827.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 549cea6bc340..63c17195a99b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12541,6 +12541,7 @@ L:	linux-hwmon@vger.kernel.org
>  S:	Supported
>  W:	http://ez.analog.com/community/linux-device-drivers
>  F:	Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> +F:	drivers/hwmon/max31827.c
>  
>  MAX6650 HARDWARE MONITOR AND FAN CONTROLLER DRIVER
>  L:	linux-hwmon@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 5b3b76477b0e..80c44a787d42 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2401,4 +2401,15 @@ config SENSORS_ASUS_EC
>  
>  endif # ACPI
>  
> +config MAX31827
> +	tristate "MAX31827 low-power temperature switch"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  If you say yes here you get support for MAX31827
> +	  low-power temperature switch and sensor connected with I2C.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called max31827.
> +
>  endif # HWMON
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 88712b5031c8..d00f0a1e73f6 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -224,3 +224,4 @@ obj-$(CONFIG_PMBUS)		+= pmbus/
>  
>  ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
>  
> +obj-$(CONFIG_MAX31827) += max31827.o
> diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
> new file mode 100644
> index 000000000000..1c79bcf12d78
> --- /dev/null
> +++ b/drivers/hwmon/max31827.c
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * max31827.c - Support for Maxim Low-Power Switch
> + *
> + * Copyright (c) 2023 Daniel Matyas <daniel.matyas@analog.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/device.h>
> +#include <linux/of.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>

Not needed.

> +
> +#define MAX31827_T_REG				0x0
> +#define MAX31827_CONFIGURATION_REG              0x2
> +#define MAX31827_TH_REG                         0x4
> +#define MAX31827_TL_REG                         0x6
> +#define MAX31827_TH_HYST_REG                    0x8
> +#define MAX31827_TL_HYST_REG                    0xA
> +
> +#define MAX31827_CONFIGURATION_1SHOT_MASK	BIT(0)
> +#define MAX31827_CONFIGURATION_CNV_RATE_MASK    GENMASK(3, 1)
> +#define MAX31827_CONFIGURATION_RESOL_MASK       GENMASK(7, 6)
> +#define MAX31827_CONFIGURATION_U_TEMP_STAT_MASK BIT(14)
> +#define MAX31827_CONFIGURATION_O_TEMP_STAT_MASK BIT(15)
> +
> +#define MAX31827_CNV_SHUTDOWN			0x0
> +#define MAX31827_CNV_1_DIV_64_HZ		0x1
> +#define MAX31827_CNV_1_DIV_32_HZ		0x2
> +#define MAX31827_CNV_1_DIV_16_HZ		0x3
> +#define MAX31827_CNV_1_DIV_4_HZ			0x4
> +#define MAX31827_CNV_1_HZ			0x5
> +#define MAX31827_CNV_4_HZ			0x6
> +#define MAX31827_CNV_8_HZ			0x7
> +

Most of the above defines are not used.

> +#define MAX31827_1SHOT_EN(x)			((x) ? BIT(0) : 0)

x is either 0 or 1. This macro does not add any value.

> +
> +struct max31827_state {
> +	struct regmap *regmap;
> +	struct i2c_client *client;

Not used anywhere.

> +};
> +
> +static const struct regmap_config max31827_regmap = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.max_register = 0xA,
> +};
> +
> +static umode_t max31827_is_visible(const void *state,
> +				   enum hwmon_sensor_types type,
> +				   u32 attr, int channel)
> +{
> +	if (type == hwmon_temp) {
> +		switch (attr) {
> +		case hwmon_temp_enable:
> +		case hwmon_temp_max:
> +		case hwmon_temp_min:
> +		case hwmon_temp_max_hyst:
> +		case hwmon_temp_min_hyst:
> +			return 0644;
> +		case hwmon_temp_input:
> +			return 0444;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
> +			 u32 attr, int channel, long *val)
> +{
> +	struct max31827_state *st;
> +	unsigned int uval;
> +	int ret;
> +
> +	st = dev_get_drvdata(dev);

Please be consistent: Either assign in the declaration, or later,
but don't mix the two.

> +	if (IS_ERR(st))
> +		return PTR_ERR(st);

Unnecessary check.

> +
> +	if (type != hwmon_temp)
> +		return -EOPNOTSUPP;
> +
> +	switch (attr) {
> +	case hwmon_temp_enable:
> +		ret = regmap_read(st->regmap, MAX31827_CONFIGURATION_REG, &uval);
> +		uval  = FIELD_GET(MAX31827_CONFIGURATION_1SHOT_MASK, uval);

This is an ABI abuse. hwmon_temp_enable is expected to enable / disable the sensor
(here: set conversion rate to 0), not to set 1-shot mode or to trigger a single
conversion.

If your application mandates 1-shot mode, do it properly. Implement continuous mode
by default, have the _enable attribute disable the sensor as per ABI, and, if disabled,
trigger one-shot mode when reading the temperature and let it wait until a temperature
measurement is available. I'd strongly suggest to skip that and use a conversion rate
of 1 / 64 seconds instead to keep the code simple.

You might also want to consider implementing the update_interval attribute
to let the user configure the conversion rate.

> +		break;
> +
> +	case hwmon_temp_input:
> +		ret = regmap_read(st->regmap, MAX31827_T_REG, &uval);
> +		break;
> +
> +	case hwmon_temp_max:
> +		ret = regmap_read(st->regmap, MAX31827_TH_REG, &uval);
> +		break;
> +
> +	case hwmon_temp_max_hyst:
> +		ret = regmap_read(st->regmap, MAX31827_TH_HYST_REG, &uval);
> +		break;
> +	case hwmon_temp_min:
> +		ret = regmap_read(st->regmap, MAX31827_TL_REG, &uval);
> +		break;
> +
> +	case hwmon_temp_min_hyst:
> +		ret = regmap_read(st->regmap, MAX31827_TL_HYST_REG, &uval);
> +		break;
> +

Why no alarm attribute suppport ?

> +	default:
> +		ret = -EOPNOTSUPP;
> +	}
> +
> +	if (ret)
> +		return ret;
> +
> +	*val = uval;
> +
> +	return 0;
> +}
> +
> +static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
> +			  u32 attr, int channel, long val)
> +{
> +	struct max31827_state *st = dev_get_drvdata(dev);
> +
> +	if (IS_ERR(st))
> +		return PTR_ERR(st);

Unnecessary check.

> +
> +	switch (attr) {
> +	case hwmon_temp_enable:
> +		if (val >> 1)
> +			return -EOPNOTSUPP;
> +
> +		return regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
> +					  MAX31827_CONFIGURATION_1SHOT_MASK,
> +					  MAX31827_1SHOT_EN(val));
> +
> +	case hwmon_temp_max:
> +		return regmap_write(st->regmap, MAX31827_TH_REG, val);
> +
> +	case hwmon_temp_max_hyst:
> +		return regmap_write(st->regmap, MAX31827_TH_HYST_REG, val);

Datasheet:

"
Before the register values are changed over I2C, the part has to be placed in Shutdown mode. Refer to the Configuration/
Status Register Conversion Rate field for details. Operation in automatic mode can resume after the register update.
"

Yes, I understand, the driver currently always operates in shutdown/1-shot
mode, but as mentioned above that is unacceptable.

> +
> +	case hwmon_temp_min:
> +		return regmap_write(st->regmap, MAX31827_TL_REG, val);
> +
> +	case hwmon_temp_min_hyst:
> +		return regmap_write(st->regmap, MAX31827_TL_HYST_REG, val);
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int max31827_init_client(struct max31827_state *st)
> +{
> +	return regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
> +				 MAX31827_CONFIGURATION_CNV_RATE_MASK |
> +				 MAX31827_CONFIGURATION_1SHOT_MASK,
> +				 MAX31827_1SHOT_EN(1));

More ABI abuse. This configures the driver (hard) for 1-shot mode,
and assumes that a conversion is triggered by writing into the _enable
attribute. Sorry, this is unacceptable.

> +}
> +
> +static const struct hwmon_channel_info *max31827_info[] = {
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_ENABLE | HWMON_T_INPUT | HWMON_T_MIN |
> +			   HWMON_T_MIN_HYST | HWMON_T_MAX | HWMON_T_MAX_HYST),
> +	NULL,
> +};
> +
> +static const struct hwmon_ops max31827_hwmon_ops = {
> +	.is_visible = max31827_is_visible,
> +	.read = max31827_read,
> +	.write = max31827_write,
> +};
> +
> +static const struct hwmon_chip_info max31827_chip_info = {
> +	.ops = &max31827_hwmon_ops,
> +	.info = max31827_info,
> +};
> +
> +static int max31827_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct device *hwmon_dev;
> +	struct max31827_state *st;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> +		return -EOPNOTSUPP;
> +
> +	st = devm_kzalloc(dev, sizeof(struct max31827_state), GFP_KERNEL);
> +	if (!st)
> +		return -ENOMEM;
> +
> +	st->client = client;
> +
> +	st->regmap = devm_regmap_init_i2c(client, &max31827_regmap);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "Failed to allocate regmap: %ld\n",
> +				     PTR_ERR(st->regmap));

dev_err_probe() already displays an error text.

> +
> +	ret = max31827_init_client(st);
> +	if (ret)
> +		return ret;
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, st,
> +							 &max31827_chip_info,
> +							 NULL);
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct i2c_device_id max31827_i2c_ids[] = {
> +	{ .name = "max31827" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max31827_i2c_ids);
> +
> +static const struct of_device_id max31827_of_match[] = {
> +	{ .compatible = "max31827" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max31827_of_match);
> +
> +static struct i2c_driver max31827_driver = {
> +	.class = I2C_CLASS_HWMON,
> +	.driver = {
> +		.name = "max31827",
> +		.of_match_table = max31827_of_match,
> +	},
> +	.probe_new = max31827_probe,
> +	.id_table = max31827_i2c_ids,
> +};
> +module_i2c_driver(max31827_driver);
> +
> +MODULE_AUTHOR("Daniel Matyas <daniel.matyas@analog.com>");
> +MODULE_DESCRIPTION("Maxim MAX31827 low-power temperature switch driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.34.1
> 
