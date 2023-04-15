Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15426E3257
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 18:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjDOQQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 12:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDOQQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 12:16:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800474ECB;
        Sat, 15 Apr 2023 09:16:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ADEE6175C;
        Sat, 15 Apr 2023 16:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2A3C433D2;
        Sat, 15 Apr 2023 16:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681575407;
        bh=cNqkUn8rxHcDofJEGGPH7YoVMx46S0kN4nNgscT0q6I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PtUBrjIe1yBV8TnIdh4DbGT9IjZdzCGDatgPsYk1cW1vb6I63c4SlPN9laAHbXfqs
         AYxS4yfVwg1iRzUWrfHDlO6NOsAc81Bs/CPe097gf+iHhmh+IeOaTBwWt/RqLKelJG
         lXxSP760k2pikiZnADwcFAbj02H5PfaCbCxTuS+KDedIcfUS/Jdtu3SVlJccQlXSCF
         s6GFG/mxDUGMgFck6TDdo084edDsIP68GgAADtewO9KKHfxq5f+GAmigytXYnIrJev
         etxfsofJhuC8/bVXP/oMeGTDvPGU/L4BPDo4WaXsGzLfC8R9tnuTbIB7iNnD6gffRh
         Y51dbvZb99KnQ==
Date:   Sat, 15 Apr 2023 17:16:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kim Seer Paller <kimseer.paller@analog.com>
Cc:     <lars@metafoo.de>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio:adc: add max14001 support
Message-ID: <20230415171648.1a371ee7@jic23-huawei>
In-Reply-To: <20230414103202.21603-1-kimseer.paller@analog.com>
References: <20230414103202.21603-1-kimseer.paller@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kim,

Welcome to IIO.

For patch title, as it's a new driver I'd call that out.
"iio: adc: max14001: New driver

On Fri, 14 Apr 2023 18:32:02 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> Add driver implementation for max14001.
First line doesn't tell us anything so drop that.
> 
> The MAX14001 is configurable, isolated 10-bit ADCs for multi-range
> binary inputs.

This bit is good so keep this alone.

> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
If you are interested in supporting daisy chained operation I'd suggest making
sure to think about that from the start.  It can affect how you design the
driver even if you only plan to add it later.  Daisy chained devices look
like a single device with more channels.


Various comments inline.

Jonathan


> ---
>  MAINTAINERS                |   2 +
>  drivers/iio/adc/Kconfig    |  10 +
>  drivers/iio/adc/Makefile   |   1 +
>  drivers/iio/adc/max14001.c | 369 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 382 insertions(+)
>  create mode 100644 drivers/iio/adc/max14001.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 766847ad2..c0a133e5c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12579,6 +12579,8 @@ L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/dac/adi,max14001.yaml
> +F:	drivers/iio/adc/max14001.c
> +

Only one line between entries.  Be careful to check your patches for this
sort of stray white space change.  This sort of thing adds noise to the patch
that both makes it a tiny bit harder to review and means I'll ask you to
fix it anyway.  Better to get rid of before anyone reviews :)

>  
>  MAXBOTIX ULTRASONIC RANGER IIO DRIVER
>  M:	Andreas Klinger <ak@it-klinger.de>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 45af2302b..af66d1fa8 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -745,6 +745,16 @@ config MAX9611
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called max9611.
>  
> +config MAX14001
> +	tristate "Analog Devices MAX14001 ADC driver"
> +	depends on SPI
> +	help
> +	  Say yes here to build support for Analog Devices MAX14001 Configurable,
> +	  Isolated 10-bit ADCs for Multi-Range Binary Inputs.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called max14001.
> +
>  config MCP320X
>  	tristate "Microchip Technology MCP3x01/02/04/08 and MCP3550/1/3"
>  	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 36c181773..2e3c6f1a7 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -68,6 +68,7 @@ obj-$(CONFIG_MAX11410) += max11410.o
>  obj-$(CONFIG_MAX1241) += max1241.o
>  obj-$(CONFIG_MAX1363) += max1363.o
>  obj-$(CONFIG_MAX9611) += max9611.o
> +obj-$(CONFIG_MAX14001) += max14001.o
>  obj-$(CONFIG_MCP320X) += mcp320x.o
>  obj-$(CONFIG_MCP3422) += mcp3422.o
>  obj-$(CONFIG_MCP3911) += mcp3911.o
> diff --git a/drivers/iio/adc/max14001.c b/drivers/iio/adc/max14001.c
> new file mode 100644
> index 000000000..76ba6f2da
> --- /dev/null
> +++ b/drivers/iio/adc/max14001.c
> @@ -0,0 +1,369 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +/*
> + * Analog Devices MAX14001 ADC driver
> + *
> + * Copyright 2023 Analog Devices Inc.
> + */
> +#include <asm/unaligned.h>
We normally put asm stuff in a separate 'block' (i.e. a blank
line above it) after the linux/ ones

> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +/* MAX14001 Registers Address */
> +#define MAX14001_ADC		0x00
> +#define MAX14001_FADC		0x01
> +#define MAX14001_FLAGS		0x02
> +#define MAX14001_FLTEN		0x03
> +#define MAX14001_THL		0x04
> +#define MAX14001_THU		0x05
> +#define MAX14001_INRR		0x06
> +#define MAX14001_INRT		0x07
> +#define MAX14001_INRP		0x08
> +#define MAX14001_CFG		0x09
> +#define MAX14001_ENBL		0x0A
> +#define MAX14001_ACT		0x0B
> +#define MAX14001_WEN		0x0C
> +#define MAX14001_FLTV		0x13
> +#define MAX14001_THLV		0x14
> +#define MAX14001_THUV		0x15
> +#define MAX14001_INRRV		0x16
> +#define MAX14001_INRTV		0x17
> +#define MAX14001_INRPV		0x18
> +#define MAX14001_CFGV		0x19
> +#define MAX14001_ENBLV		0x1A
> +
> +#define MAX14001_ADDR_MASK	GENMASK(15, 11)
> +#define MAX14001_DATA_MASK	GENMASK(9, 0)
> +#define MAX14001_FILTER_MASK	GENMASK(3, 2)
> +#define MAX14001_CFG_MASK	GENMASK(5, 1)
> +
> +#define MAX14001_LSB_DIV	BIT(10)
> +#define MAX14001_SET_WRITE_BIT	BIT(10)
> +#define MAX14001_WRITE_WEN	0x294
> +
> +/*
> + * Definition used because the latter is not available
> + * in project's source tree.
> + */
> +#define IIO_DMA_MINALIGN	ARCH_KMALLOC_MINALIGN

Remember to drop this from the version you are proposing for upstream.
I'm guessing your local tree predates this definition.

> +
> +struct max14001_state {
> +	struct spi_device	*spi;
> +	/* lock protect agains multiple concurrent accesses */
> +	struct mutex		lock;
> +	int			cfg_value;
> +	int			vref_mv;
> +	bool			use_fadc;
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	__le16			spi_tx_buffer __aligned(IIO_DMA_MINALIGN);
> +	__le16			spi_rx_buffer;
> +};
> +
> +static int max14001_read(struct max14001_state *st,
> +			 unsigned int reg_addr, u16 *data)
> +{
> +	u16 tx = 0;
> +	int ret;
> +
> +	struct spi_transfer xfers[] = {
> +		{
> +			.tx_buf = &st->spi_tx_buffer,
> +			.len = 2,
> +			.cs_change = 1,
> +		}, {
> +			.rx_buf = &st->spi_rx_buffer,
> +			.len = 2,
> +		},
> +	};
> +
> +	tx = FIELD_PREP(MAX14001_ADDR_MASK, reg_addr);
> +	st->spi_tx_buffer = cpu_to_le16(tx);
> +
> +	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> +	if (ret)
> +		return ret;
> +
> +	*data = le16_to_cpu(st->spi_rx_buffer) & MAX14001_DATA_MASK;
> +
> +	return 0;
> +}
> +
> +static int max14001_write(struct max14001_state *st,
> +			  unsigned int reg_addr, u16 data)
> +{
> +	u16 tx;
> +
> +	tx = FIELD_PREP(MAX14001_ADDR_MASK, reg_addr);
> +	tx |= FIELD_PREP(MAX14001_SET_WRITE_BIT, 1);
> +	tx |= FIELD_PREP(MAX14001_DATA_MASK, data);
> +
> +	st->spi_tx_buffer = cpu_to_le16(tx);
> +
> +	return spi_write(st->spi, &st->spi_tx_buffer, 2);

There is a large enough register set here that I'd suggest considering
converting the driver to regmap with the advantage of register caching
and writing of defaults etc + functions to update individual bits etc.
Would need a custom regmap as I don't think any standard SPI options
do the wiggling of the Chip Select that you need for read.


> +}
> +
> +static void max14001_regulator_disable(void *data)
> +{
> +	struct regulator *reg = data;
> +
> +	regulator_disable(reg);
I'd move this function much nearer to where it is called in probe.
> +}
> +
> +static int max14001_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct max14001_state *st = iio_priv(indio_dev);
> +	u16 data;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&st->lock);
> +		ret = max14001_read(st, st->use_fadc ?
> +				    MAX14001_FADC : MAX14001_ADC, &data);
> +		mutex_unlock(&st->lock);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = data;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->vref_mv / 1000;
why /1000?
This scale should be such that when multipled by the raw value the
result is in milivolts. Maybe I'm missing something, but I'm not sure that's
true with this value.

> +		*val2 = MAX14001_LSB_DIV;
> +
> +		return IIO_VAL_FRACTIONAL;

IIO_VAL_FRACTIONAL_LOG2 and then you can put the 10 here and avoid the
LSB_DIV define for what is a 'real' number.


> +
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = (st->vref_mv / 1000) / 2;

mv / 1000 == Volts, so this is half the voltage in volts?
I don't follow how that is relevant in offset.  
I can't find a clear statement in the datasheet, but from
the Electrical characteristics table, it looks to me like
there is no offset.

> +
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info max14001_info = {
> +	.read_raw = max14001_read_raw,
> +};
> +
> +static const struct iio_chan_spec max14001_channels[] = {
> +	{
> +		.type = IIO_VOLTAGE,
> +		.channel = 0,

.indexed = 1
As you may want to support daisy chaining later.

> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +		BIT(IIO_CHAN_INFO_SCALE) |
> +		BIT(IIO_CHAN_INFO_OFFSET),
> +	}
> +};
> +
> +static void max14001_fw_parse(struct max14001_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	int filter;
> +
> +	st->use_fadc = device_property_read_bool(dev, "adi,use-fadc");
> +
> +	if (device_property_read_bool(dev, "adi,inrush-mode"))
> +		st->cfg_value |= BIT(1);

These BIT(x) should be named (i.e. use a DEFINE for the mask of the bit
and a FIELD_PREP(mask, 1) here where hopefully the naming will clearly
indicate what is being turned on.

The advantage of that is it puts all the register definitions together
at the top of the file, allowing easy checking against the datasheet +
ensure consistency over multiple uses (if that happens).

> +
> +	if (device_property_read_bool(dev, "adi,current-source"))
> +		st->cfg_value |= BIT(4);
> +
> +	if (!device_property_read_u32(dev, "adi,filter", &filter)) {
> +		if (filter > 3)
> +			dev_err_probe(dev, -EINVAL, "Invalid filter value\n");
> +
> +		st->cfg_value |= FIELD_PREP(MAX14001_FILTER_MASK, filter);

This is a good example of what I want for the other properties.

I'm ignoring here that this should probably be a userspace ABI controlled thing, not
 a firmware provided constant value - see thread on the DT binding.

Note that I now have datasheet open and it's a moving average which makes it
low pass filter with controllable 3DB point.   I'm not sure there is utility
in providing access to the unfiltered input btw given the filter can be turned
off anyway.

> +	}
> +}
> +
> +static int max14001_config_init(struct max14001_state *st)
> +{
> +	u16 data, reg_flten, reg_cfg;
> +	int ret, i;
> +
> +	/* Enable SPI Registers Write */
> +	ret = max14001_write(st, MAX14001_WEN, MAX14001_WRITE_WEN);
> +	if (ret)
> +		return ret;
> +
> +	/* Software Reset */

With a suitable define for bit 7 this will become obvious.
If you can make that the case for a given comment it is always good to
do so.  Comments that add little info are just things that can become
out of date as code moves around or changes.

> +	ret = max14001_write(st, MAX14001_ACT, BIT(7));
> +	if (ret)
> +		return ret;
> +
> +	msleep(100);
> +
> +	/* Read to clear FLAGS */
> +	ret = max14001_read(st, MAX14001_FLAGS, &data);
> +	if (ret)
> +		return ret;
> +
> +	/* Clear Faults */

Disable Faults perhaps?
However this does a lot more than that.  It would be good to
describe the rest of the registers this is setting to 0.

One of the registers is already 0 after the reset.


> +	for (i = MAX14001_FLTEN; i <= MAX14001_ACT; i++) {
> +		ret = max14001_write(st, i, 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i = MAX14001_FLTV; i <= MAX14001_ENBLV; i++) {
> +		ret = max14001_write(st, i, 0);

More comments needed here on what is being written.

> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = max14001_read(st, MAX14001_FLTEN, &reg_flten);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable Memory Validation Flag */
> +	ret = max14001_write(st, MAX14001_FLTEN, reg_flten | BIT(7));

BIT(7) in the datasheet I found is EFET not EMV that I think you were
aiming for.

> +	if (ret)
> +		return ret;
> +

Comment on why this needs writing as well.

> +	ret = max14001_write(st, MAX14001_FLTV, reg_flten | BIT(7));
> +	if (ret)
> +		return ret;
> +
> +	/* Read to clear FLAGS */

Statement here on why it might be set.  This verification register
stuff is unusual enough that pointing out what is happening is a good
idea.  Or consider wrapping them up in a function that writes both
and clears the flag.  The second registers is at the same offset
in all cases, so you could just pass in address of first one and
compute the second inside the function.  That would allow you to
document this dance in a single location.

I'm not convinced a flag will be set though as EMV isn't set.

> +	ret = max14001_read(st, MAX14001_FLAGS, &data);
> +	if (ret)
> +		return ret;
> +
> +	ret = max14001_read(st, MAX14001_CFG, &reg_cfg);
> +	if (ret)
> +		return ret;
> +
> +	/* Set configuration register controls */
> +	ret = max14001_write(st, MAX14001_CFG, st->cfg_value |
> +				FIELD_PREP(MAX14001_CFG_MASK, reg_cfg));
> +	if (ret)
> +		return ret;
> +
> +	ret = max14001_write(st, MAX14001_CFGV, st->cfg_value |
> +				FIELD_PREP(MAX14001_CFG_MASK, reg_cfg));
> +	if (ret)
> +		return ret;
> +
> +	/* Enable field side current sink */
> +	ret = max14001_write(st, MAX14001_ENBL, 0x010);
> +	if (ret)
> +		return ret;
> +
> +	ret = max14001_write(st, MAX14001_ENBLV, 0x010);
> +	if (ret)
> +		return ret;
> +
> +	/* Read to clear FLAGS */
> +	ret = max14001_read(st, MAX14001_FLAGS, &data);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable SPI Registers Write */
> +	return max14001_write(st, MAX14001_WEN, 0);
> +}
> +
> +static int max14001_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct max14001_state *st;
> +	struct regulator *vref;
> +
No blank line here.  Keep all the definitions together in a single block.
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +
> +	indio_dev->name = "max14001";
> +	indio_dev->info = &max14001_info;
> +	indio_dev->channels = max14001_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max14001_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	vref = devm_regulator_get_optional(&spi->dev, "vref");
> +	if (IS_ERR(vref)) {
> +		if (PTR_ERR(vref) != -ENODEV)
> +			return dev_err_probe(&spi->dev, PTR_ERR(vref),
> +					     "Failed to get vref regulator");
> +
> +		/* internal reference */
> +		st->vref_mv = 1250;
> +	} else {
> +		ret = regulator_enable(vref);
> +		if (ret)
> +			return dev_err_probe(&spi->dev, ret,
> +					"Failed to enable vref regulators\n");
> +
> +		ret = devm_add_action_or_reset(&spi->dev,
> +					       max14001_regulator_disable,
> +					       vref);
> +		if (ret)
> +			return ret;
> +
> +		/* external voltage reference enabled */
> +		st->cfg_value |= BIT(5);
> +
> +		ret = regulator_get_voltage(vref);
> +		if (ret < 0)
> +			return dev_err_probe(&spi->dev, ret,
> +					     "Failed to get vref\n");
> +
> +		st->vref_mv = ret / 1000;
> +	}
> +
> +	max14001_fw_parse(st);
> +
> +	ret = max14001_config_init(st);
> +	if (ret)
> +		return ret;
> +
> +	mutex_init(&st->lock);
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static const struct spi_device_id max14001_id[] = {
> +	{ "max14001", 0 },

Don't bother setting the data here.  We don't use it (and default
is 0 anyway as C guarantees to fill that in for you).

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, max14001_id);
> +
> +static const struct of_device_id max14001_of_match[] = {
> +	{ .compatible = "adi,max14001" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max14001_of_match);
> +
> +static struct spi_driver max14001_driver = {
> +	.driver = {
> +		.name = "max14001",
> +		.of_match_table = max14001_of_match,
> +	},
> +	.probe = max14001_probe,
> +	.id_table = max14001_id,
> +};
> +module_spi_driver(max14001_driver);
> +
> +MODULE_AUTHOR("Kim Seer Paller");
> +MODULE_DESCRIPTION("MAX14001 ADC driver");
> +MODULE_LICENSE("GPL");

