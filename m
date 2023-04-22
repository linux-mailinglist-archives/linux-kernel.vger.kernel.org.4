Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B6B6EBA4B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 18:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjDVQTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 12:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjDVQTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 12:19:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E910D10CC;
        Sat, 22 Apr 2023 09:19:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79F9160F16;
        Sat, 22 Apr 2023 16:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F38FC433EF;
        Sat, 22 Apr 2023 16:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682180357;
        bh=mNEq2JvyNF4r36dWyXbBvmPEIDr/HLHEv4yJZsHawAs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AngX2N56AclFhwRxn86YlERKs+kFsEOI+PLa9F3y7KuP/mJny1/ieHGYuf76/VPa/
         LHzY9qzLOvwWyIaNb4H2+h6mwtCTOtm/wxE7DeDk6fBnoRUSPdNA5z4XykEudv0kf4
         cl0vJbhAgHf96Wi9XbaMKYj36HOrAH+/RIfg5V/resdORqEH0kXg94QyYRfZJzmAHf
         +8clC0y0ra8QphFgr8tQ++kiA3ZEdtawTaXoPEVr+AiMp6h0CaYhl2dl9lNP7RCeq0
         fAXCRNwbQhyKReNQKZPAKogILVEIs7PrKI+vAFNfIpAJgKGMtDDKJmX/Q137B6y91W
         cH0GdePOkOuog==
Date:   Sat, 22 Apr 2023 17:34:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 2/3] iio: potentiometer: Add support for the Renesas
 X9250 potentiometers
Message-ID: <20230422173453.7d083cb4@jic23-huawei>
In-Reply-To: <20230421085245.302169-3-herve.codina@bootlin.com>
References: <20230421085245.302169-1-herve.codina@bootlin.com>
        <20230421085245.302169-3-herve.codina@bootlin.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023 10:52:44 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> The Renesas X9250 integrates four digitally controlled potentiometers.
> On each potentiometer, the X9250T has a 100 kOhms total resistance and
> the X9250U has a 50 kOhms total resistance.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Hi Herve,

Nice clean driver.  Comments are mostly about ways to avoid boilerplate
and simplify the code a bit.

Note that the binding comment on regulators should be matched by
appropriate devm_get_regulator_enabled() calls in here to ensure they 
are turned on.

Jonathan

> ---
>  drivers/iio/potentiometer/Kconfig  |  10 ++
>  drivers/iio/potentiometer/Makefile |   1 +
>  drivers/iio/potentiometer/x9250.c  | 234 +++++++++++++++++++++++++++++
>  3 files changed, 245 insertions(+)
>  create mode 100644 drivers/iio/potentiometer/x9250.c
> 
> diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
> index 01dd3f858d99..e6a9a3c67845 100644
> --- a/drivers/iio/potentiometer/Kconfig
> +++ b/drivers/iio/potentiometer/Kconfig
> @@ -136,4 +136,14 @@ config TPL0102
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called tpl0102.
>  
> +config X9250
> +	tristate "Renesas X9250 quad controlled potentiometers"
> +	depends on SPI
> +	help
> +	  Enable support for the Renesas X9250 quad controlled
> +	  potentiometers.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called x9250.
> +
>  endmenu
> diff --git a/drivers/iio/potentiometer/Makefile b/drivers/iio/potentiometer/Makefile
> index 5ebb8e3bbd76..d11fb739176c 100644
> --- a/drivers/iio/potentiometer/Makefile
> +++ b/drivers/iio/potentiometer/Makefile
> @@ -15,3 +15,4 @@ obj-$(CONFIG_MCP4131) += mcp4131.o
>  obj-$(CONFIG_MCP4531) += mcp4531.o
>  obj-$(CONFIG_MCP41010) += mcp41010.o
>  obj-$(CONFIG_TPL0102) += tpl0102.o
> +obj-$(CONFIG_X9250) += x9250.o
> diff --git a/drivers/iio/potentiometer/x9250.c b/drivers/iio/potentiometer/x9250.c
> new file mode 100644
> index 000000000000..c6bc959205a3
> --- /dev/null
> +++ b/drivers/iio/potentiometer/x9250.c
> @@ -0,0 +1,234 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *
> + * x9250.c  --  Renesas X9250 potentiometers IIO driver
> + *
> + * Copyright 2023 CS GROUP France
> + *
> + * Author: Herve Codina <herve.codina@bootlin.com>
> + */
> +
> +#include <linux/iio/iio.h>
> +#include <linux/limits.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +
> +struct x9250_cfg {
> +	int kohms;
> +};
> +
> +struct x9250 {
> +	struct spi_device *spi;
> +	const struct x9250_cfg *cfg;
> +	struct mutex lock; /* Protect tx and rx buffers */
> +	/* Cannot use stack area for SPI (dma-safe memory) */
> +	u8 spi_tx_buf[3] __aligned(IIO_DMA_MINALIGN);
> +	u8 spi_rx_buf[3] __aligned(IIO_DMA_MINALIGN);

Technically you don't need to align the second one.  A particular peripheral
is always assumed to not step on it self.  So as long as only that
peripheral is accessing data in a cacheline then it's fine.

Note that below I suggest you just use spi_write_then_read() for all these
cases allowing  you to drop these and the lock.

> +};
> +
> +#define X9250_ID		0x50
> +#define X9250_CMD_RD_WCR(_p)    (0x90 | (_p))
> +#define X9250_CMD_WR_WCR(_p)    (0xa0 | (_p))
> +
> +static int x9250_write8(struct x9250 *x9250, u8 cmd, u8 val)
> +{
> +	struct spi_transfer xfer = {
> +		.tx_buf = &x9250->spi_tx_buf,
> +		.len = 3,
> +	};
> +	int ret;
> +
> +	BUILD_BUG_ON(sizeof(x9250->spi_tx_buf) < 3);

I don't see an advantage in this check as the buffer
is allocated only a few lines above here and will have size
of 3.

If there were lots of different uses of that buffer
then it would be fair enough, but there aren't.
Anyhow, follow advice below and the buffers go away anyway
making this point irrelevant :)

> +
> +	mutex_lock(&x9250->lock);
> +
> +	x9250->spi_tx_buf[0] = X9250_ID;
> +	x9250->spi_tx_buf[1] = cmd;
> +	x9250->spi_tx_buf[2] = val;
> +
> +	ret = spi_sync_transfer(x9250->spi, &xfer, 1);

Given buffer is small, I'd be tempted to use the 'cheat' approach
of spi_write_then_read() with a 0 sized read.  Avoids the need
for ensuring dma safe buffers etc and having to handle the buffer
locking in your driver.

> +
> +	mutex_unlock(&x9250->lock);
> +
> +	return ret;
> +}
> +
> +static int x9250_read8(struct x9250 *x9250, u8 cmd, u8 *val)
> +{
> +	struct spi_transfer xfer = {
> +		.tx_buf = &x9250->spi_tx_buf,
> +		.rx_buf = &x9250->spi_rx_buf,
> +		.len = 3,
> +	};
> +	int ret;
> +
> +	BUILD_BUG_ON(sizeof(x9250->spi_tx_buf) < 3);
> +	BUILD_BUG_ON(sizeof(x9250->spi_rx_buf) < 3);
> +
> +	mutex_lock(&x9250->lock);
> +
> +	x9250->spi_tx_buf[0] = X9250_ID;
> +	x9250->spi_tx_buf[1] = cmd;
> +
> +	ret = spi_sync_transfer(x9250->spi, &xfer, 1);
> +	if (ret)
> +		goto end;
> +
> +	*val = x9250->spi_rx_buf[2];

Cleaner as an spi_write_then_read() as transfer is not actually
duplex.  + then you don't need to bother with your own locks
for the buffer. The spi core can do that for you (and provide
DMA safe buffers as needed).


> +	ret = 0;
> +end:
> +	mutex_unlock(&x9250->lock);
> +	return ret;
> +}
> +
> +#define X9250_CHANNEL(ch) {						\
> +	.type = IIO_RESISTANCE,						\
> +	.indexed = 1,							\
> +	.output = 1,							\
> +	.channel = (ch),						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_RAW),	\
> +}
> +
> +static const struct iio_chan_spec x9250_channels[] = {
> +	X9250_CHANNEL(0),
> +	X9250_CHANNEL(1),
> +	X9250_CHANNEL(2),
> +	X9250_CHANNEL(3),
> +};
> +
> +static int x9250_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			  int *val, int *val2, long mask)
> +{
> +	struct x9250 *x9250 = iio_priv(indio_dev);
> +	int ch = chan->channel;
> +	int ret;
> +	u8 v;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = x9250_read8(x9250, X9250_CMD_RD_WCR(ch), &v);
> +		if (ret)
> +			return ret;
> +		*val = v;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 1000 * x9250->cfg->kohms;
> +		*val2 = U8_MAX;
> +		return IIO_VAL_FRACTIONAL;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int x9250_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			    const int **vals, int *type, int *length, long mask)
> +{
> +	static const int range[] = {0, 1, 255}; /* min, step, max */
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		*length = ARRAY_SIZE(range);
> +		*vals = range;
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_RANGE;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int x9250_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			   int val, int val2, long mask)
> +{
> +	struct x9250 *x9250 = iio_priv(indio_dev);
> +	int ch = chan->channel;
> +
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	if (val > U8_MAX || val < 0)
> +		return -EINVAL;
> +
> +	return x9250_write8(x9250, X9250_CMD_WR_WCR(ch), val);
> +}
> +
> +static const struct iio_info x9250_info = {
> +	.read_raw = x9250_read_raw,
> +	.read_avail = x9250_read_avail,
> +	.write_raw = x9250_write_raw,
> +};
> +
> +enum x9250_type {
> +	X9250T,
> +	X9250U,
> +};
> +
> +static const struct x9250_cfg x9250_cfg[] = {
> +	[X9250T] = { .kohms =  100, },
> +	[X9250U] = { .kohms =  50, },
> +};
> +
> +static int x9250_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct x9250 *x9250;
> +	int ret;
> +
> +	spi->bits_per_word = 8;

This is configuring it to the default value.  You shouldn't need to
call spi_setup() explicitly. It will already have been called by
the spi subsystem as part of adding the device.  If you feel this
has important documentation value, then I don't mind it. However
we rarely do this unless we need to choose a non default value.


> +	ret = spi_setup(spi);
> +	if (ret < 0)
> +		return ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*x9250));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	x9250 = iio_priv(indio_dev);
> +	x9250->spi = spi;
> +	x9250->cfg = device_get_match_data(&spi->dev);
> +	if (!x9250->cfg)
> +		x9250->cfg = &x9250_cfg[spi_get_device_id(spi)->driver_data];
> +
> +	mutex_init(&x9250->lock);
> +
> +	indio_dev->info = &x9250_info;
> +	indio_dev->channels = x9250_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(x9250_channels);
> +	indio_dev->name = spi_get_device_id(spi)->name;

Not relying on that preferred because the two tables may get out
of sync and spi_get_device_id() fail to match as a result.

Put a const char *name  in the x9250 structure and repeat
the names there.  Let the compiler do the magic of fusing the
identical strings if it can.


> +
> +	spi_set_drvdata(spi, indio_dev);

Why?  Nothing seems to use it that I can see.

> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static const struct of_device_id x9250_of_match[] = {
> +	{ .compatible = "renesas,x9250t", &x9250_cfg[X9250T]},
> +	{ .compatible = "renesas,x9250u", &x9250_cfg[X9250U]},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, x9250_of_match);
> +
> +static const struct spi_device_id x9250_id_table[] = {
> +	{ "x9250t", X9250T },
> +	{ "x9250u", X9250U },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, x9250_id_table);
> +
> +static struct spi_driver x9250_spi_driver = {
> +	.driver  = {
> +		.name   = "x9250",

I'd stick to a single space before the =
It just ends up messy if you attempt to align things with
extra spaces.

> +		.of_match_table = x9250_of_match,
> +	},
> +	.id_table = x9250_id_table,
> +	.probe  = x9250_probe,
> +};
> +
> +module_spi_driver(x9250_spi_driver);
> +
> +MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>");
> +MODULE_DESCRIPTION("X9250 ALSA SoC driver");
> +MODULE_LICENSE("GPL");

