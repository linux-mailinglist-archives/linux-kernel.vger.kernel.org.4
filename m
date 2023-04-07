Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364D76DB269
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjDGSFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjDGSFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:05:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE97C199;
        Fri,  7 Apr 2023 11:04:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56A0464D51;
        Fri,  7 Apr 2023 18:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468ABC433EF;
        Fri,  7 Apr 2023 18:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680890698;
        bh=oqvtN/eGmNQwx1wX8oYy6ARjV3ot4hAZ1vSYDWdUhW0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=piiokn2OqzK+Hnc7/0VdzvybXsIBYlm8Q2g+w1KkMX5mdbVFI1BY1zt6aVQXPwFxD
         /xhmJ3mSrmT5Iu/INHnOrmkTcZZJcb/3808c/sWmChXHkqc+nx8mL1i7a1NB/x2gaJ
         YnssfUTj+lGSj9aVE3bvPjpiR3TpXzRbKH/z18Zt1TgGg2YTfTmnVeSrTkwMMxWXnG
         uWsxejs93mSLaFwYTk17PaokVATqXPnY4JrV9pmIyrS7OUz16XWvElYPa96MUHwKsw
         tf+/NFonvZuj/aP6BURymVeObs9tcp5513jdJS6ACaRuxnd9UPxbvFqWAWB9tV/mHa
         eYz6vQUr7UDuQ==
Date:   Fri, 7 Apr 2023 19:20:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH 2/2] iio: light: Add support for TI OPT4001 light sensor
Message-ID: <20230407192014.5d7d167c@jic23-huawei>
In-Reply-To: <20230323-add-opt4001-driver-v1-2-1451dcc1bc8a@axis.com>
References: <20230323-add-opt4001-driver-v1-0-1451dcc1bc8a@axis.com>
        <20230323-add-opt4001-driver-v1-2-1451dcc1bc8a@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2023 11:07:43 +0200
Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com> wrote:

> This driver uses the continuous mode of the chip and integration
> time can be configured through sysfs.
> The constants for calculating lux value differs between packaging
> so it uses different compatible string for the two versions
> "ti,opt4001-picostar" and "ti,opt4001-sot-5x3" since the device id
> is the same.
> 
> Datasheet: https://www.ti.com/lit/gpn/opt4001
> Signed-off-by: Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
> ---
Hi Stefan,

Various comments inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
> new file mode 100644
> index 000000000000..1ddcb10e997b
> --- /dev/null
> +++ b/drivers/iio/light/opt4001.c
> @@ -0,0 +1,487 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Axis Communications AB
> + *
> + * Datasheet: https://www.ti.com/lit/gpn/opt4001
> + *
> + * Device driver for the Texas Instruments OPT4001.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_device.h>

As below, use property.h functions instead that work for lots of types of
firmware including OF.

> +#include <linux/regmap.h>

..

> +/* OPT4001 constants */
> +#define OPT4001_DEVICE_ID_VAL            0x121
> +/* OPT4001 needs different constants to calculate lux for different packaging */
> +#define OPT4001_PICOSTAR_MUL_CONST       3125
> +#define OPT4001_SOT_5x3_MUL_CONST        4375
> +#define OPT4001_PACKAGE_DIV_CONST        10000000
> +

...


> +
> +/* OPT4001 default values */
> +#define OPT4001_DEFAULT_CONVERSION_TIME OPT4001_CTRL_CONVERSION_800MS
> +
> +struct opt4001_package_const {
I would would include other things about the device variants in here.
If you want the naming to reflect which one of these you have then
a const char *name would make that easy to do.

> +	int mul;
> +	int div;
> +};
> +
> +struct opt4001_settings {
> +	/* Index of the chosen integration time */
> +	u8 int_time;
> +	u8 chip_type;
> +};
> +
> +struct opt4001_chip {
> +	struct opt4001_settings light_settings;
> +	struct regmap *regmap;
> +	struct i2c_client *client;
> +	const struct opt4001_package_const *package_constants;
> +	/*
> +	 * Keep light_settings in sync with hardware state
> +	 * and ensure multiple readers are serialized.
Multiple readers will be serialized with the underlying bus lock.
If you need to handle multiple part accesses together that's
what you should highlight here.

> +	 */
> +	struct mutex als_mutex;
> +};
> +
> +static const struct opt4001_package_const opt4001_sot_5x3_const = {
> +	.mul = OPT4001_SOT_5x3_MUL_CONST,
> +	.div = OPT4001_PACKAGE_DIV_CONST,
> +};
> +
> +static const struct opt4001_package_const opt4001_picostar_const = {
> +	.mul = OPT4001_PICOSTAR_MUL_CONST,

Unless used in multiple places, just having numbers here will be more readable
than giving them names.

> +	.div = OPT4001_PACKAGE_DIV_CONST,
> +};

> +static int opt4001_read_lux_value(struct iio_dev *indio_dev,
> +				  int *val, int *val2)
> +{
> +	struct opt4001_chip *chip = iio_priv(indio_dev);
> +	struct device *dev = &chip->client->dev;
> +	uint light1;
> +	uint light2;
> +	uint msb;
> +	uint lsb;
> +	uint exp;
> +	uint count;
> +	uint crc;
> +	uint calc_crc;

Would prefer fixed width types or unsigned int

> +	unsigned long long lux_raw;

u64 

> +	int ret;
> +
> +	ret = regmap_read(chip->regmap, OPT4001_LIGHT1_MSB, &light1);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to read data bytes");
> +		return ret;
> +	}
> +
> +	ret = regmap_read(chip->regmap, OPT4001_LIGHT1_LSB, &light2);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to read data bytes");
> +		return ret;
> +	}
> +
> +	count = (OPT4001_COUNTER_MASK & light2) >> 4;
> +	exp = (OPT4001_EXPONENT_MASK & light1) >> 12;
> +	crc = (OPT4001_CRC_MASK & light2);

FIELD_GET() for all these so no need to go look to see
if the field is aligned to LSB.

> +	msb = (OPT4001_MSB_MASK & light1);
> +	lsb = (OPT4001_LSB_MASK & light2) >> 8;
> +	lux_raw = (msb << 8) + lsb;
> +	calc_crc = opt4001_calculate_crc(exp, lux_raw, count);
> +	if (calc_crc != crc)
> +		return -EIO;
> +
> +	lux_raw = lux_raw << exp;
> +	lux_raw = lux_raw * chip->package_constants->mul;
> +	*val = div_u64_rem(lux_raw, chip->package_constants->div, val2);
> +	*val2 = *val2 * 100;
> +
> +	return IIO_VAL_INT_PLUS_NANO;
> +}


...


> +
> +static int opt4001_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct opt4001_chip *chip = iio_priv(indio_dev);
> +	int int_time;
> +	int ret = 0;

Set in all paths that I can see so don't set it here.


> +
> +	mutex_lock(&chip->als_mutex);

Might as well move the mutex into the case statement and simplify things
a little.

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		int_time = opt4001_als_time_to_index(val2);
> +		if (int_time < 0) {
> +			ret = int_time;
> +		} else {
> +			chip->light_settings.int_time = int_time;
> +			ret = opt4001_set_conf(chip);
> +		}
> +
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +
> +	mutex_unlock(&chip->als_mutex);
> +	return ret;
> +}
...

 +/*
> + * The compatible string determines which constants to use depending on
> + * opt4001 packaging
> + */
> +static const struct of_device_id opt4001_of_match[] = {
> +	{ .compatible = "ti,opt4001-sot-5x3", .data = &opt4001_sot_5x3_const},
> +	{ .compatible = "ti,opt4001-picostar", .data = &opt4001_picostar_const},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, opt4001_of_match);
> +
> +static int opt4001_probe(struct i2c_client *client)
> +{
> +	struct opt4001_chip *chip;
> +	struct iio_dev *indio_dev;
> +	const struct of_device_id *of_id;
> +	int ret;
> +	uint dev_id;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	chip = iio_priv(indio_dev);
> +
> +	chip->regmap = devm_regmap_init_i2c(client, &opt4001_regmap_config);
> +	if (IS_ERR(chip->regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(chip->regmap),
> +				     "regmap initialization failed\n");
> +
> +	i2c_set_clientdata(client, indio_dev);

Don't think you'll need this after taking the remainder of remove over to
devm_ automatic unwinding.

> +	chip->client = client;
> +
> +	indio_dev->info = &opt4001_info_no_irq;
> +
> +	mutex_init(&chip->als_mutex);
> +
> +	ret = regmap_reinit_cache(chip->regmap, &opt4001_regmap_config);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "failed to reinit regmap cache\n");
> +
> +	ret = regmap_read(chip->regmap, OPT4001_DEVICE_ID, &dev_id);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
> +			"Failed to read the device ID register\n");
> +
> +	dev_id = FIELD_GET(OPT4001_DEVICE_ID_MASK, dev_id);
> +	if (dev_id != OPT4001_DEVICE_ID_VAL) {
> +		dev_err(&client->dev, "Device ID: %#04x unknown\n", dev_id);
> +		return -EINVAL;
> +	}
> +
> +	indio_dev->channels = opt4001_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(opt4001_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->name = chip->client->name;

I'd prefer to see the string obtained from the 'package constants' (renamed
to reflect it covers other details of the chip. That tends to remove any
risk of things getting out of sync.


> +
> +	of_id = of_match_device(of_match_ptr(opt4001_of_match), &client->dev);

device_get_match_data() from property.h


> +	chip->package_constants = of_id->data;
> +
> +	ret = opt4001_load_defaults(chip);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to set sensor defaults\n");

I assume load defaults powers up the chip. If so, you should
register a callback to power it down here (see below)

> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static void opt4001_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct opt4001_chip *chip = iio_priv(indio_dev);
> +
> +	opt4001_power_down(chip);

If that's all that needs doing, can we use a devm_add_action_or_reset()
registered custom handler to power this off.

Note that currently you turn the chip off before the userspace interfaces
are removed which is a race we should close. Take things fully devm
managed and that should be automatic.

> +}
> +
> +static struct i2c_driver opt4001_driver = {
> +	.driver = {
> +		.name = "opt4001",
> +		.of_match_table = of_match_ptr(opt4001_of_match),

Don't use of_match_ptr().

Multiple reasons.
1) Will result in unused variable warnings if DT support not built.
2) Prevents other firmware registration paths (in particular ACPI PRP0001
   which uses this from non OF firmware).

> +	},
> +	.probe_new = opt4001_probe,
> +	.remove = opt4001_remove

Add an i2c_device_id table as well as the of one and MODULE_DEVICE_TABLE
for that. I think some auto probing of the driver still needs that.

> +};
> +module_i2c_driver(opt4001_driver);
> +
> +MODULE_AUTHOR("Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>");
> +MODULE_DESCRIPTION("Texas Instruments opt4001 ambient light sensor driver");
> +MODULE_LICENSE("GPL");
> 

