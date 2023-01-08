Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE95661528
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 13:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjAHMpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 07:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAHMpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 07:45:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256D3D10A;
        Sun,  8 Jan 2023 04:45:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF453B80915;
        Sun,  8 Jan 2023 12:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C47C433D2;
        Sun,  8 Jan 2023 12:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673181935;
        bh=c8/yAQKp2RdBhEg7pLBUG5abYYdF1/HMMaszcybN5bc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C4yC2GWtQjyL0wh1grKWQaFtNj1CiZRcN2ncc06xFgOV6AIF8PW40YQCgRM1Lg+PW
         RjiyVsC0ZLKqzX9i4bxlbGBuSDrHLwkLJ12oU/fseKZPgF7xdRAGHLiHXvybdZNFDU
         UamAKClML2JOxYW0eFOFUwiW99mPy9aC1HO+ZjPidVq7DWgrqbScVr9xNcO/8I2kfq
         Jd7eCvV4A2IjwqmYnDnC1A9AEE/FO/o4NFuRiW0dOdtwITBT6u4Eeu1ZRIq7TXQxnh
         HsGExFxCsJZcxEkVA/xSr+W5mZXAy8mGWMae5WOemCJZMopLuDAs5h82T7CadNgQEu
         E7HFfKaKn6igw==
Date:   Sun, 8 Jan 2023 12:59:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrew Hepp <andrew.hepp@ahepp.dev>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: Add MCP9600 thermocouple EMF
 converter driver
Message-ID: <20230108125904.620aaa69@jic23-huawei>
In-Reply-To: <20230104113612.4732-1-andrew.hepp@ahepp.dev>
References: <20230104113612.4732-1-andrew.hepp@ahepp.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  4 Jan 2023 03:36:12 -0800
Andrew Hepp <andrew.hepp@ahepp.dev> wrote:

> From: "Andrew.Hepp" <andrew.hepp@ahepp.dev>
> 
> Add support for the MCP9600 thermocouple EMF converter.
> 
> Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/MCP960X-Data-Sheet-20005426.pdf
> Signed-off-by: Andrew Hepp <andrew.hepp@ahepp.dev>

Hi Andrew. Welcome to IIO.


As you will have seen from the build bot errors, there have been some changes
in the i2c subsystem to get rid of the pointless return value.

A nice little driver.  A few comments inline.

Thanks,

Jonathan

> ---
>  drivers/iio/temperature/Kconfig   |  10 ++
>  drivers/iio/temperature/Makefile  |   1 +
>  drivers/iio/temperature/mcp9600.c | 174 ++++++++++++++++++++++++++++++
>  3 files changed, 185 insertions(+)
>  create mode 100644 drivers/iio/temperature/mcp9600.c
> 
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index ed384f33e0c7..ea2ce364b2e9 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -158,4 +158,14 @@ config MAX31865
>  	  This driver can also be build as a module. If so, the module
>  	  will be called max31865.
>  
> +config MCP9600
> +	tristate "MCP9600 thermocouple EMF converter"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for MCP9600
> +	  thermocouple EMF converter connected via I2C.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called mcp9600.
> +
>  endmenu
> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> index dfec8c6d3019..9330d4a39598 100644
> --- a/drivers/iio/temperature/Makefile
> +++ b/drivers/iio/temperature/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
>  obj-$(CONFIG_MAX30208) += max30208.o
>  obj-$(CONFIG_MAX31856) += max31856.o
>  obj-$(CONFIG_MAX31865) += max31865.o
> +obj-$(CONFIG_MCP9600) += mcp9600.o
>  obj-$(CONFIG_MLX90614) += mlx90614.o
>  obj-$(CONFIG_MLX90632) += mlx90632.o
>  obj-$(CONFIG_TMP006) += tmp006.o
> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> new file mode 100644
> index 000000000000..2c1c4bb5e1c3
> --- /dev/null
> +++ b/drivers/iio/temperature/mcp9600.c
> @@ -0,0 +1,174 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * mcp9600.c - Support for Microchip MCP9600 thermocouple EMF converter
> + *
> + * Copyright (c) 2022 Andrew Hepp
> + * Author: <andrew.hepp@ahepp.dev>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

I doubt you need iio/sysfs.h - it's only normally relevant for custom attributes
and we try to avoid those wherever we possibly can.

> +
> +/* MCP9600 registers */
> +#define MCP9600_HOT_JUNCTION 0x0
> +#define MCP9600_COLD_JUNCTION 0x2
> +#define MCP9600_DEVICE_ID 0x20
> +
> +/* MCP9600 device id value */
> +#define MCP9600_DEVICE_ID_MCP9600 0x40
> +
> +static const struct iio_chan_spec mcp9600_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.address = MCP9600_HOT_JUNCTION,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 's',
You aren't currently providing buffered access, (and may well never
do so for a slowish temperature driver).  That means scan_* aren't used
by the IIO core.  Hence don't bother initializing them.
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.shift = 0,
For 'obviously' defaults of 0 like shift, don't initialize them. 
> +			.endianness = IIO_BE,
> +		},
> +	},
> +	{
> +		.type = IIO_TEMP,
> +		.address = MCP9600_COLD_JUNCTION,
> +		.channel2 = IIO_MOD_TEMP_AMBIENT,
> +		.modified = 1,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 1,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 13,
> +			.storagebits = 16,
> +			.shift = 0,
> +			.endianness = IIO_BE,
> +		},
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(2),
> +};
> +


> +static int mcp9600_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct mcp9600_data *data = iio_priv(indio_dev);
> +	int ret = -EINVAL;

In all cases here you can simply return directly. That gives
more readable code as we don't have to go look for any cleanup.

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);

As you aren't providing buffered support, it doesn't make sense
to lock the device in direct_mode. 

I assume the aim here is serialize access to the device?
If so, then you can't rely on claim_direct_mode for it anyway
(it's an implementation detail that it currently includes a lock)
and so you need to use a locally defined mutex.

> +		if (ret)
> +			return ret;
> +
> +		ret = mcp9600_read(data, chan, val);
> +		iio_device_release_direct_mode(indio_dev);
> +		if (!ret)
> +			return IIO_VAL_INT;
Better to always have errors out of line.
		if (ret)
			return ret;

		return IIO_VAL_INT;
> +
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 62;
> +		*val2 = 500000;
> +		ret = IIO_VAL_INT_PLUS_MICRO;
		return IIO_VAL_INT_PLUS_MICRO;

	default:
		return -EINVAL;
	}
}
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct iio_info mcp9600_info = {
> +	.read_raw = mcp9600_read_raw,
> +};
> +
> +static int mcp9600_probe(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct mcp9600_data *data;
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, MCP9600_DEVICE_ID);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != MCP9600_DEVICE_ID_MCP9600)
> +		return -ENODEV;
So we traditionally had a lot of this sort of protections in IIO.
Turned out we were doing it wrong because they break use of fallback
compatibles in Device tree.  The idea there is that a new part might be
released which is fully backwards compatible (it might have new features).
If that happens, a fallback compatible is added after the device specific
one.  That allows the new device tree / device to use an old kernel.

However, we have a lot of cases in IIO where wrong devices are mounted
on devices without DT being updated.  The compromise we reached was
to just warn on device ID mismatches rather than fail to probe.
	if (ret != MCP9600_DEVICE_ID_MCP9600)
		dev_warn(&client->dev, "Expected ID %x, got %x\n");

then carry on regardless.

> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +
> +	i2c_set_clientdata(client, indio_dev);
You probably won't need this once remove is gone. See below.

> +	indio_dev->info = &mcp9600_info;
> +	indio_dev->name = "mcp9600";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = mcp9600_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mcp9600_channels);
> +
> +	return iio_device_register(indio_dev);
> +}
> +
> +static int mcp9600_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	printk(KERN_ALERT "mcp9600_remove\n");

This sort of print is fine when writing a driver, but it's just
noise once you reach submission.  So remember to go through your
driver and remove prints like this.

> +
> +	indio_dev = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);

Use devm_iio_device_register() and let the device managed framework
do this for you.   Once that change is made there will be no point
in having a remove() callback at all - so get rid of it.

> +	return 0;
> +}
> +
> +static const struct i2c_device_id mcp9600_id[] = { { "mcp9600" }, {} };

Easier to read null terminated arrays like this if done in the multi
line format you've used for of_device_id table below.

> +MODULE_DEVICE_TABLE(i2c, mcp9600_id);
> +
> +static const struct of_device_id mcp9600_of_match[] = {
> +	{ .compatible = "microchip,mcp9600" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mcp9600_of_match);
> +
> +static struct i2c_driver mcp9600_driver = {
> +	.driver = {
> +		.name = "mcp9600",
> +		.of_match_table = mcp9600_of_match,
> +	},
> +	.probe_new = mcp9600_probe,
> +	.remove = mcp9600_remove,
> +	.id_table = mcp9600_id
> +};
> +module_i2c_driver(mcp9600_driver);
> +
> +MODULE_AUTHOR("Andrew Hepp <andrew.hepp@ahepp.dev>");
> +MODULE_DESCRIPTION("Microchip MCP9600 thermocouple EMF converter driver");
> +MODULE_LICENSE("GPL");

