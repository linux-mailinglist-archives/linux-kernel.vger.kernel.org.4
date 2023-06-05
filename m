Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AEF722FC0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbjFETYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbjFETYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:24:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4724F100;
        Mon,  5 Jun 2023 12:24:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C944B629BD;
        Mon,  5 Jun 2023 19:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C59C433EF;
        Mon,  5 Jun 2023 19:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685993056;
        bh=/WDyoVWJW0+RL4lZqzCjYAg8N+jMy841frN5yAjoCpo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HgvB8F5Jfmf1m1qTLHtMR8qLMlu+GpubdEHohI8KocZdLlLe457V20z7hB+p/vYKW
         KSNlUncQT1N3JrQDj4KDFhp/tly6TbWsgT8IdbGZ8VzNpFX6pcBWy5x4hRs6zjOmJl
         vuGtUV7+RSHQLhXzM8KT6oPkZu/D2Z67GOYMnzma0F0nW39ZrUPe32NZZHKtNWFoak
         2gEf8416j90jGKQgWz9epB+rFSNKlulLr9aeQgx+RilAKjp2Ogkz3Qa8SPsLAQ38Wv
         vyz+pnMMt0/Vk2ZI1YrVZ+DFdxzdZELtl/dx8xbyEB6qdkiWNsLEoh8tO2NUUN0s7L
         YFPkcjE4GZevg==
Date:   Mon, 5 Jun 2023 20:24:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kim Seer Paller <kimseer.paller@analog.com>
Cc:     <lars@metafoo.de>, <krzysztof.kozlowski@linaro.org>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: max14001: New driver
Message-ID: <20230605202413.5eb0c0f3@jic23-huawei>
In-Reply-To: <20230605130755.92642-3-kimseer.paller@analog.com>
References: <20230605130755.92642-1-kimseer.paller@analog.com>
        <20230605130755.92642-3-kimseer.paller@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2023 21:07:55 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> The MAX14001 is configurable, isolated 10-bit ADCs for multi-range
> binary inputs.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
...

Hi Kim,

A few comments inline.

> diff --git a/drivers/iio/adc/max14001.c b/drivers/iio/adc/max14001.c
> new file mode 100644
> index 000000000..7c5272756
> --- /dev/null
> +++ b/drivers/iio/adc/max14001.c
> @@ -0,0 +1,333 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +/*
> + * Analog Devices MAX14001 ADC driver
> + *
> + * Copyright 2023 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitrev.h>
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include <asm/unaligned.h>
> +
> +/* MAX14001 Registers Address */
> +#define MAX14001_ADC			0x00
> +#define MAX14001_FADC			0x01
> +#define MAX14001_FLAGS			0x02
> +#define MAX14001_FLTEN			0x03
> +#define MAX14001_THL			0x04
> +#define MAX14001_THU			0x05
> +#define MAX14001_INRR			0x06
> +#define MAX14001_INRT			0x07
> +#define MAX14001_INRP			0x08
> +#define MAX14001_CFG			0x09
> +#define MAX14001_ENBL			0x0A
> +#define MAX14001_ACT			0x0B
> +#define MAX14001_WEN			0x0C
> +
> +#define MAX14001_VERIFICATION_REG(x)	((x) + 0x10)
> +
> +#define MAX14001_CFG_EXRF		BIT(5)
> +
> +#define MAX14001_ADDR_MASK		GENMASK(15, 11)
> +#define MAX14001_DATA_MASK		GENMASK(9, 0)
> +#define MAX14001_FILTER_MASK		GENMASK(3, 2)
> +
> +#define MAX14001_SET_WRITE_BIT		BIT(10)
> +#define MAX14001_WRITE_WEN		0x294
> +
> +struct max14001_state {
> +	struct spi_device	*spi;
> +	/* lock protect agains multiple concurrent accesses */

To what?  Here I suspect it's RMW sequence on device and perhaps
more importantly the buffers below.

> +	struct mutex		lock;
> +	struct regmap		*regmap;
> +	int			vref_mv;
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.

You are looking at an old kernel I guess - we fixed all of these - and
introduced IIO_DMA_MINALIGN for __aligned(IIO_DMA_MINALIGN) to make
it easier to fix any such problems in future.

Upshot is that ___cacheline_aligned aligns to the l1 cacheline length.
Some fun systems (such as the big servers I use in my dayjob) have higher
cacheline sizes for their larger / further from CPU caches.
One group of SoCs out there is known to both do non coherent DMA and have
a larger line size for the bit relevant to that than ___cacheline_aligned
gives you. So on that rare platform this is currently broken.
 
> +	 */
> +	__be16			spi_tx_buffer ____cacheline_aligned;
> +	__be16			spi_rx_buffer;
> +};
> +
> +static int max14001_read(void *context, unsigned int reg_addr,
> +					unsigned int *data)
> +{
> +	struct max14001_state *st = context;
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
> +	st->spi_tx_buffer = bitrev16(cpu_to_be16(tx));
> +
> +	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> +	if (ret)
> +		return ret;
> +
> +	*data = bitrev16(be16_to_cpu(st->spi_rx_buffer)) & MAX14001_DATA_MASK;
> +
> +	return 0;
> +}
> +
> +static int max14001_write(void *context, unsigned int reg_addr,
> +					unsigned int data)
> +{
> +	struct max14001_state *st = context;
> +	u16 tx = 0;
> +
> +	tx = FIELD_PREP(MAX14001_ADDR_MASK, reg_addr);
> +	tx |= FIELD_PREP(MAX14001_SET_WRITE_BIT, 1);
> +	tx |= FIELD_PREP(MAX14001_DATA_MASK, data);
> +
> +	st->spi_tx_buffer = bitrev16(cpu_to_be16(tx));
> +
> +	return spi_write(st->spi, &st->spi_tx_buffer, 2);
> +}
> +
> +static int max14001_write_verification_reg(struct max14001_state *st,
> +				     unsigned int reg_addr)
> +{
> +	unsigned int reg_data;
> +	int ret;
> +
> +	ret = max14001_read(st, reg_addr, &reg_data);
> +	if (ret)
> +		return ret;
> +
> +	return max14001_write(st, MAX14001_VERIFICATION_REG(reg_addr),
> +				reg_data);

Even though this is a bit unusual, I'd still expect this to use
the regmap_read / regmap_write interfaces not directly use the callbacks.

> +}
> +
> +static int max14001_reg_update(struct max14001_state *st,
> +				unsigned int reg_addr,
> +				unsigned int mask,
> +				unsigned int val)
> +{
> +	int ret;
> +
> +	/* Enable SPI Registers Write */
> +	ret = max14001_write(st, MAX14001_WEN, MAX14001_WRITE_WEN);

Mixing regmap and non regmap rather defeats the point of
having a standard interface.  Use regmap_read and regmap_write
throughout or not at all.

> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->regmap, reg_addr, mask, val);
> +	if (ret)
> +		return ret;
> +
> +	ret = max14001_write_verification_reg(st, reg_addr);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable SPI Registers Write */
> +	return max14001_write(st, MAX14001_WEN, 0);
> +}
> +
> +static int max14001_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct max14001_state *st = iio_priv(indio_dev);
> +	unsigned int data;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&st->lock);
> +		ret = max14001_read(st, MAX14001_ADC, &data);
> +		mutex_unlock(&st->lock);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = data;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->vref_mv;
> +		*val2 = 10;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct regmap_config max14001_regmap_config = {
> +	.reg_read = max14001_read,
> +	.reg_write = max14001_write,

I'd keep this up by the callbacks, so all the regmap setup stuff
is in one place.

> +};
> +
> +static const struct iio_info max14001_info = {
> +	.read_raw = max14001_read_raw,
> +};
> +

...

> +static int max14001_probe(struct spi_device *spi)
> +{

...

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
> +		/* enable external voltage reference */

use external voltage reference?

It's enabled by the regulator_enable() above, not this line.

> +		ret = max14001_reg_update(st, MAX14001_CFG,
> +					  MAX14001_CFG_EXRF, 1);
> +
> +		ret = regulator_get_voltage(vref);
> +		if (ret < 0)
> +			return dev_err_probe(&spi->dev, ret,
> +					     "Failed to get vref\n");
> +
> +		st->vref_mv = ret / 1000;
> +	}
> +
> +	mutex_init(&st->lock);
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}

