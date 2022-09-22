Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B635E6918
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiIVRDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbiIVRDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:03:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0733EF85B5;
        Thu, 22 Sep 2022 10:03:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FD52B83900;
        Thu, 22 Sep 2022 17:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF130C433C1;
        Thu, 22 Sep 2022 17:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663866214;
        bh=WRNq6+WHdR1qko2/cC0ndi6GC5UYAvF+bVkB7aMjMB4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xk38AY0NGfU/G8tnTRBABF4fIHY6Eh//rTkF1JKOFx5EvOIX4QB9e0c64F+nZ4vvK
         x9kAVgBvJ9rOu0nZ6Bk/B6oJhRsLXEDiqBzJh++thzWmFw42bQgaDTIFSxlmJMBk+s
         ViQAO+salxxiGy3BgEHM7L/Hsdi8rtEQqirFEdM8Y+BxD2Pc2KJS+SSgyCfmjX46vK
         3ehfvRJwk7PTyVVXb0McTnM8qRxVFZDozOEVc2ZGZ6BNcvXQ+RN2wGfzH1dfIKatap
         Vj1mGwYIH4NKkXlC4KhOYNribSLn2eSkyC6uhiWEp+fQdeVAdX3GM8OnazhMnM5UKx
         GGP9pTYK4imJw==
Date:   Thu, 22 Sep 2022 18:03:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Message-ID: <20220922180339.30138141@jic23-huawei>
In-Reply-To: <fe1088cebb0de70bcb99af517004c1816b696825.1663760018.git.mazziesaccount@gmail.com>
References: <cover.1663760018.git.mazziesaccount@gmail.com>
        <fe1088cebb0de70bcb99af517004c1816b696825.1663760018.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Wed, 21 Sep 2022 14:45:35 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> KX022A is a 3-axis Accelerometer from ROHM/Kionix. The senor features
> include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
> tap/motion detection, wake-up & back-to-sleep events, four acceleration
> ranges (2, 4, 8 and 16g) and probably some other cool fatures.
> 
> Add support for the basic accelerometer features such as getting the
> acceleration data via IIO. (raw reads, triggered buffer [data-ready] or
> using the WMI IRQ).
> 
> Important things to be added include the double-tap, motion
> detection and wake-up as well as the runtime power management.
> 
> NOTE: Filling-up the hardware FIFO should be avoided. During my testing
> I noticed that filling up the hardware FIFO might mess-up the sample
> count. My sensor ended up in a state where amount of data in FIFO was
> reported to be 0xff bytes, which equals to 42,5 samples. Specification
> says the FIFO can hold maximum of 41 samples in HiRes mode. Also, at
> least once the FIFO was stuck in a state where reading data from
> hwardware FIFO did not decrease the amount of data reported to be in the
spell check this.

> FIFO - eg. FIFO was "stuck". The code has now an error count and 10
> reads with invalid FIFO data count will cause the fifo contents to be
> dropped.
Ouch - that's nasty.

> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Hi Matti,

A somewhat superficial review as I'm short on time, but wanted to get some
initial comments out to you as I'd started reviewing this yesterday and not
sure when I'd get back to it.

Jonathan

> ---
>  drivers/iio/accel/Kconfig             |   23 +
>  drivers/iio/accel/Makefile            |    3 +
>  drivers/iio/accel/kionix-kx022a-i2c.c |   52 ++
>  drivers/iio/accel/kionix-kx022a-spi.c |   50 ++
>  drivers/iio/accel/kionix-kx022a.c     | 1149 +++++++++++++++++++++++++
>  drivers/iio/accel/kionix-kx022a.h     |   76 ++
>  6 files changed, 1353 insertions(+)
>  create mode 100644 drivers/iio/accel/kionix-kx022a-i2c.c
>  create mode 100644 drivers/iio/accel/kionix-kx022a-spi.c
>  create mode 100644 drivers/iio/accel/kionix-kx022a.c
>  create mode 100644 drivers/iio/accel/kionix-kx022a.h
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 35798712f811..12ad6bcb2c76 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -409,6 +409,29 @@ config IIO_ST_ACCEL_SPI_3AXIS
>  	  To compile this driver as a module, choose M here. The module
>  	  will be called st_accel_spi.
>  
> +config IIO_KX022A
> +	tristate
> +
> +config IIO_KX022A_SPI
> +	tristate "Kionix KX022A tri-axis digital accelerometer"
> +	depends on I2C
> +	select IIO_KX022A
> +	select REGMAP_SPI
> +	help
> +	  Say Y here to enable support for the Kionix KX022A digital tri-axis
> +	  accelerometer connected to I2C interface. See IIO_KX022A_I2C if
> +	  you want to enable support for the KX022A connected via I2C.

I would not bother with the cross reference to the I2C config element.

> +
> +config IIO_KX022A_I2C
> +	tristate "Kionix KX022A tri-axis digital accelerometer"
> +	depends on I2C
> +	select IIO_KX022A
> +	select REGMAP_I2C
> +	help
> +	  Say Y here to enable support for the Kionix KX022A digital tri-axis
> +	  accelerometer connected to I2C interface. See IIO_KX022A_SPI if
> +	  you want to enable support for the KX022A connected via SPI.
> +

> diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
> new file mode 100644
> index 000000000000..2dbf8a33b84b
> --- /dev/null
> +++ b/drivers/iio/accel/kionix-kx022a-i2c.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//

Other than where required for SPDX use the
/*
 * Copyright...
 */
syntax.

> +// Copyright (C) 2022 ROHM Semiconductors
> +//
> +// ROHM/KIONIX KX022A accelerometer driver
> +
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#include "kionix-kx022a.h"
> +
> +static int kx022a_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct regmap *regmap;
> +	struct device *dev = &i2c->dev;
> +
> +	if (!i2c->irq) {

There look to be 2 interrupt lines, so you need to know which
one this is.  fwnode_irq_get_byname() trying first int1 then
int2 (as only a single one might be mapped).

> +		dev_err(dev, "No IRQ configured\n");
> +		return -EINVAL;
> +	}
> +
> +	regmap = devm_regmap_init_i2c(i2c, &kx022a_regmap);
> +	if (IS_ERR(regmap)) {
> +		dev_err(dev, "Failed to initialize Regmap\n");
> +
> +		return PTR_ERR(regmap);
> +	}
> +
> +	return kx022a_probe_internal(dev, i2c->irq);
> +}
> +
> +static const struct of_device_id kx022a_of_match[] = {
> +	{ .compatible = "kionix,kx022a", },
> +	{ },

No comma on null terminators like this.

> +};
> +MODULE_DEVICE_TABLE(of, kx022a_of_match);
> +
> +static struct i2c_driver kx022a_i2c_driver = {
> +	.driver = {
> +			.name  = "kx022a-i2c",
> +			.of_match_table = kx022a_of_match,
> +		  },
> +	.probe_new    = kx022a_i2c_probe,

I'd avoid tab alignment like this. It breaks far to often
and doesn't really help readability.

> +};
> +
> +module_i2c_driver(kx022a_i2c_driver);
> +
> +MODULE_DESCRIPTION("ROHM/Kionix KX022A accelerometer driver");
> +MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/accel/kionix-kx022a-spi.c b/drivers/iio/accel/kionix-kx022a-spi.c
> new file mode 100644
> index 000000000000..007f4b726d8f
> --- /dev/null
> +++ b/drivers/iio/accel/kionix-kx022a-spi.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Copyright (C) 2022 ROHM Semiconductors
> +//
> +// ROHM/KIONIX KX022A accelerometer driver

Pretty much same comments as for the i2c part.

> +
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +#include "kionix-kx022a.h"
> +
> +static int kx022a_spi_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct regmap *regmap;
> +
> +	if (!spi->irq) {
> +		dev_err(dev, "No IRQ configured\n");
> +		return -EINVAL;
> +	}
> +
> +	regmap = devm_regmap_init_spi(spi, &kx022a_regmap);
> +	if (IS_ERR(regmap)) {
> +		dev_err(dev, "Failed to initialize Regmap\n");
> +
> +		return PTR_ERR(regmap);
> +	}
> +	return kx022a_probe_internal(dev, spi->irq);
> +}
> +
> +static const struct of_device_id kx022a_of_match[] = {
> +	{ .compatible = "kionix,kx022a", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, kx022a_of_match);
> +
> +static struct spi_driver kx022a_spi_driver = {
> +	.driver = {
> +		.name   = "kx022a-spi",
> +	},
> +	.probe	= kx022a_spi_probe,
> +};
> +
> +module_spi_driver(kx022a_spi_driver);
> +
> +MODULE_DESCRIPTION("ROHM/Kionix kx022A accelerometer driver");
> +MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> new file mode 100644
> index 000000000000..9f9e0d7efc09
> --- /dev/null
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -0,0 +1,1149 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Copyright (C) 2022 ROHM Semiconductors
> +//
> +// ROHM/KIONIX KX022A accelerometer driver
> +
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +
> +#include "kionix-kx022a.h"
> +
> +/*
> + * Threshold for deciding our HW fifo is unrecoverably corrupt and should be
> + * cleared
> + */
> +#define KXO22A_FIFO_ERR_THRESHOLD 10
> +#define KX022A_FIFO_LENGTH 41
> +/* 3 axis, 2 bytes of data for each of the axis */
> +#define KX022A_FIFO_SAMPLES_SIZE_BYTES 6
> +#define KX022A_FIFO_MAX_BYTES (KX022A_FIFO_LENGTH *			\
> +			       KX022A_FIFO_SAMPLES_SIZE_BYTES)
> +
> +#define MIN_ODR_INTERVAL_MS 5
> +#define MAX_ODR_INTERVAL_MS 1280
> +#define NUM_SUPPORTED_ODR 9
> +
> +enum {
> +	KX022A_STATE_SAMPLE,
> +	KX022A_STATE_FIFO,
> +};
> +
> +/* Regmap configs */
> +static const struct regmap_range kx022a_volatile_ranges[] = {
> +	{
> +		.range_min = KX022A_REG_XHP_L,
> +		.range_max = KX022A_REG_COTR,
> +	}, {
> +		.range_min = KX022A_REG_TSCP,
> +		.range_max = KX022A_REG_INT_REL,
> +	}, {
> +		.range_min = KX022A_REG_BUF_STATUS_1,
> +		.range_max = KX022A_REG_BUF_READ,
> +	},
> +};
> +
> +static const struct regmap_access_table kx022a_volatile_regs = {
> +	.yes_ranges = &kx022a_volatile_ranges[0],
> +	.n_yes_ranges = ARRAY_SIZE(kx022a_volatile_ranges),
> +};
> +
> +static const struct regmap_range kx022a_precious_ranges[] = {
> +	{
> +		.range_min = KX022A_REG_INT_REL,
> +		.range_max = KX022A_REG_INT_REL,
> +	},
> +};
> +
> +static const struct regmap_access_table kx022a_precious_regs = {
> +	.yes_ranges = &kx022a_precious_ranges[0],
> +	.n_yes_ranges = ARRAY_SIZE(kx022a_precious_ranges),
> +};
> +
> +/*
> + * The HW does not set WHO_AM_I reg as read-only but we don't want to write it
> + * so we still include it in the read-only ranges.
> + */
> +static const struct regmap_range kx022a_read_only_ranges[] = {
> +	{
> +		.range_min = KX022A_REG_XHP_L,
> +		.range_max = KX022A_REG_INT_REL,
> +	}, {
> +		.range_min = KX022A_REG_BUF_STATUS_1,
> +		.range_max = KX022A_REG_BUF_STATUS_2,
> +	}, {
> +		.range_min = KX022A_REG_BUF_READ,
> +		.range_max = KX022A_REG_BUF_READ,
> +	},
> +};
> +
> +static const struct regmap_access_table kx022a_ro_regs = {
> +	.no_ranges = &kx022a_read_only_ranges[0],
> +	.n_no_ranges = ARRAY_SIZE(kx022a_read_only_ranges),
> +};
> +
> +static const struct regmap_range kx022a_write_only_ranges[] = {
> +	{
> +		.range_min = KX022A_REG_BTS_WUF_TH,
> +		.range_max = KX022A_REG_BTS_WUF_TH,
> +	}, {
> +		.range_min = KX022A_REG_MAN_WAKE,
> +		.range_max = KX022A_REG_MAN_WAKE,
> +	}, {
> +		.range_min = KX022A_REG_SELF_TEST,
> +		.range_max = KX022A_REG_SELF_TEST,
> +	}, {
> +		.range_min = KX022A_REG_BUF_CLEAR,
> +		.range_max = KX022A_REG_BUF_CLEAR,
> +	},
> +};
> +
> +static const struct regmap_access_table kx022a_wo_regs = {
> +	.no_ranges = &kx022a_write_only_ranges[0],
> +	.n_no_ranges = ARRAY_SIZE(kx022a_write_only_ranges),
> +};
> +
> +static const struct regmap_range kx022a_noinc_read_ranges[] = {
> +	{
> +		.range_min = KX022A_REG_BUF_READ,
> +		.range_max = KX022A_REG_BUF_READ,
> +	},
> +};
> +
> +static const struct regmap_access_table kx022a_nir_regs = {
> +	.yes_ranges = &kx022a_noinc_read_ranges[0],
> +	.n_yes_ranges = ARRAY_SIZE(kx022a_noinc_read_ranges),
> +};
> +
> +const struct regmap_config kx022a_regmap = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.volatile_table = &kx022a_volatile_regs,
> +	.rd_table = &kx022a_wo_regs,
> +	.wr_table = &kx022a_ro_regs,
> +	.rd_noinc_table = &kx022a_nir_regs,
> +	.precious_table = &kx022a_precious_regs,
> +	.max_register = KX022A_MAX_REGISTER,
> +	.cache_type = REGCACHE_RBTREE,
> +};
> +EXPORT_SYMBOL_GPL(kx022a_regmap);
> +
> +struct kx022a_data;
> +
> +struct kx022a_trigger {

Unusual structure. IIRC we normally just squash this stuff into
the iio_priv structure and set the trigger devdata to the iio_dev.
I haven't really thought about the advantages of this way around
but can see a disadvantage is you get circular pointer loops
this way.

> +	struct kx022a_data *data;

Looks like you can get to the data pointer via a container_of()
so do that instead of carrying a pointer to the containing structure.

> +	struct iio_trigger *indio_trig;
> +	bool enabled;
> +	const char *name;
> +};
> +
> +struct kx022a_data {
> +	int irq;
> +	struct regmap *regmap;
> +	struct kx022a_trigger trigger;
> +	struct device *dev;
> +	unsigned int g_range;
> +	struct mutex mutex;
> +	unsigned int state;
> +
> +	int64_t timestamp, old_timestamp;
> +	unsigned int odr_ns;
> +
> +	struct iio_mount_matrix orientation;
> +	u8 watermark;
> +	/* 3 x 16bit accel data + timestamp */
> +	s16 buffer[8];
> +	struct {
> +		__le16 channels[3];
> +		s64 ts __aligned(8);
> +	} scan;
> +};
> +
> +static const struct iio_mount_matrix *
> +kx022a_get_mount_matrix(const struct iio_dev *idev,
> +			const struct iio_chan_spec *chan)
> +{
> +	struct kx022a_data *data = iio_priv(idev);
> +
> +	return &data->orientation;
> +}
> +
> +enum {
> +	AXIS_X,
> +	AXIS_Y,
> +	AXIS_Z,
> +	AXIS_MAX,
> +};
> +
> +static const unsigned long kx022a_scan_masks[] = {
> +					BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
> +					0};
> +
> +static const struct iio_chan_spec_ext_info kx022a_ext_info[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, kx022a_get_mount_matrix),
> +	{ },
> +};
> +
> +#define KX022A_ACCEL_CHAN(axis, index)						\
> +	{								\
> +		.type = IIO_ACCEL,					\
> +		.modified = 1,						\
> +		.channel2 = IIO_MOD_##axis,				\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> +					BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +		.ext_info = kx022a_ext_info,				\
> +		.address = KX022A_REG_##axis##OUT_L,				\
> +		.scan_index = index,					\
> +		.scan_type = {                                          \
> +			.sign = 's',					\
> +			.realbits = 16,					\
> +			.storagebits = 16,				\
> +			.shift = 0,					\

shift = 0 is 'obvious' default, so don't bother providing it explicitly.


> +			.endianness = IIO_LE,				\
> +		},							\
> +	}
> +
> +static const struct iio_chan_spec kx022a_channels[] = {
> +	KX022A_ACCEL_CHAN(X, 0),
> +	KX022A_ACCEL_CHAN(Y, 1),
> +	KX022A_ACCEL_CHAN(Z, 2),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
> +/*
> + * The sensor HW can support ODR up to 1600 Hz - which is beyond what most of
> + * Linux CPUs can handle w/o dropping samples. Also, the low power mode is not
> + * available for higher sample rates. Thus the driver only supports 200 Hz and
> + * slower ODRs. Slowest being 0.78 Hz
> + */
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("0.78 1.563 3.125 6.25 12.5 25 50 100 200");
> +static IIO_CONST_ATTR(scale_available,
> +		      "598.550415 1197.10083 2394.20166 4788.40332");
> +
> +static struct attribute *kx022a_attributes[] = {
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	&iio_const_attr_scale_available.dev_attr.attr,

Use the read_avail() callback instead of doing these as attributes.
That makes the values available to consumer drivers...

> +	NULL,
> +};
> +
> +static const struct attribute_group kx022a_attrs_group = {
> +	.attrs = kx022a_attributes,
> +};
> +
> +struct kx022a_tuple {
> +	int val;
> +	int val2;
> +};
> +
> +/*
> + * range is typically +-2G/4G/8G/16G, distributed over the amount of bits.
> + * The scale table can be calculated using
> + *	(range / 2^bits) * g = (range / 2^bits) * 9.80665 m/s^2
> + *	=> KX022A uses 16 bit (HiRes mode - assume the low 8 bits are zeroed
> + *	in low-power mode(?) )
> + *	=> +/-2G  => 4 / 2^16 * 9,80665 * 10^6 (to scale to micro)
> + *	=> +/-2G  - 598.550415
> + *	   +/-4G  - 1197.10083
> + *	   +/-8G  - 2394.20166
> + *	   +/-16G - 4788.40332
> + */
> +static const struct kx022a_tuple kx022a_scale_table[] = {
> +	{ 598, 550415 }, { 1197, 100830 }, { 2394, 201660 }, { 4788, 403320 }

Burn some lines with one pair per line as it is more readable.

> +};
> +
> +/*
> + * ODR (output data rate) table. First value represents the integer portion of
> + * frequency (Hz), and the second value is the decimal part (uHz).
> + * Eg, 0.78 Hz, 1.563 Hz, ...
> + */
> +#define KX922A_DEFAULT_PERIOD 20000000
> +static const struct kx022a_tuple kx022a_accel_samp_freq_table[] = {
> +	{ 0, 780000 }, { 1, 563000 }, { 3, 125000 }, { 6, 250000 },
> +	{ 12, 500000 }, { 25, 0 }, { 50, 0 }, { 100, 0 }, { 200, 0 }
> +};

Spend the lines and have one entry pair per line as more readable.

> +static const unsigned int kx022a_odrs[] = { 1282051282, 639795266, 320000000,
> +	 160000000, 80000000, 40000000, 20000000, 10000000, 5000000 };

where we have lots of zeros useful to use the MEGA etc defines in units.h


> +
> +/* Find index of tuple matching the given values */
> +static int kx022a_find_tuple_index(const struct kx022a_tuple *tuples, int n,
> +				   int val, int val2)
> +{
> +	while (n-- > 0)
> +		if (val == tuples[n].val && tuples[n].val2 == val2)
> +			return n;
> +
> +	return -EINVAL;
> +}
> +
> +static void kx022a_reg2freq(unsigned int val,  int *val1, int *val2)
> +{
> +	*val1 = kx022a_accel_samp_freq_table[val & KX022A_MASK_ODR].val;
> +	*val2 = kx022a_accel_samp_freq_table[val & KX022A_MASK_ODR].val2;
> +}
> +
> +static void kx022a_reg2scale(unsigned int val, unsigned int *val1,
> +			     unsigned int *val2)
> +{
> +	val &= KX022A_MASK_GSEL;
> +	val >>= KX022A_GSEL_SHIFT;
> +
> +	*val1 = kx022a_scale_table[val].val;
> +	*val2 = kx022a_scale_table[val].val2;
> +}
> +
> +static int __kx022a_turn_on_unlocked(struct kx022a_data *data)
> +{
> +	int ret;
> +
> +	ret = regmap_set_bits(data->regmap, KX022A_REG_CNTL, KX022A_MASK_PC1);
> +	if (ret)
> +		dev_err(data->dev, "Turn ON fail %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int __kx022a_turn_off_unlocked(struct kx022a_data *data)
> +{
> +	int ret;
> +
> +	ret = regmap_clear_bits(data->regmap, KX022A_REG_CNTL, KX022A_MASK_PC1);
> +	if (ret)
> +		dev_err(data->dev, "Turn OFF fail %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int kx022a_turn_off_lock(struct kx022a_data *data)
> +{
> +	int ret;

As below, I'm not convinced this wrapper is worthwhile

> +
> +	mutex_lock(&data->mutex);
> +	ret = __kx022a_turn_off_unlocked(data);
> +	if (ret)
> +		mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static int kx022a_turn_on_unlock(struct kx022a_data *data)
> +{
> +	int ret;
> +
This is not used enough that I can see a strong reason for the
wrapper.  Just put the two calls inline and rename the unlocked case.

> +	ret = __kx022a_turn_on_unlocked(data);
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static int kx022a_write_raw(struct iio_dev *idev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct kx022a_data *data = iio_priv(idev);
> +	int ret;
> +
> +	/*
> +	 * We should not allow changing scale or frequency when FIFO is running
> +	 * as it will mess the timestamp/scale for samples existing in the
> +	 * buffer. If this turns out to be an issue we can later change logic
> +	 * to internally flush the fifo before reconfiguring so the samples in
> +	 * fifo keep matching the freq/scale settings. (Such setup could cause
> +	 * issues if users trust the watermark to be reached within known
> +	 * time-limit).
> +	 */
> +	mutex_lock(&data->mutex);
> +	if (iio_buffer_enabled(idev)) {

As below - do this with iio_device_claim_direct_mode() before taking the mutex.
It's the standard way to avoid the races and prevent access when buffers are enabled
(if they are - you can't claim direct mode).

> +		ret = -EBUSY;
> +		goto unlock_out;
> +	}
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = kx022a_find_tuple_index(&kx022a_accel_samp_freq_table[0],
> +					      ARRAY_SIZE(kx022a_accel_samp_freq_table),
> +					      val, val2);
> +		/* Configure if we found valid ODR */
> +		if (ret >= 0) {
> +			int odr = ret;
> +
> +			ret = __kx022a_turn_off_unlocked(data);
> +			if (ret)
> +				goto unlock_out;
> +
> +			ret = regmap_update_bits(data->regmap, KX022A_REG_ODCNTL,
> +						 KX022A_MASK_ODR, odr);
> +			data->odr_ns = kx022a_odrs[odr];
> +			__kx022a_turn_on_unlocked(data);
> +		}
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = kx022a_find_tuple_index(&kx022a_scale_table[0],
> +					      ARRAY_SIZE(kx022a_scale_table),
> +					      val, val2);
> +		/* Configure if we found valid scale */
> +		if (ret >= 0) {
> +			ret = __kx022a_turn_off_unlocked(data);
> +			if (ret)
> +				goto unlock_out;
> +
> +			ret = regmap_update_bits(data->regmap, KX022A_REG_CNTL,
> +						 KX022A_MASK_GSEL,
> +						 ret << KX022A_GSEL_SHIFT);
> +			__kx022a_turn_on_unlocked(data);
> +		}
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +unlock_out:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static int kx022a_fifo_set_wmi(struct kx022a_data *data)
> +{
> +	u8 threshold;
> +
> +	threshold = data->watermark;
> +
> +	return regmap_update_bits(data->regmap, KX022A_REG_BUF_CNTL1,
> +				  KX022A_MASK_WM_TH, threshold);
> +}
> +
> +static int kx022a_fifo_report_data(struct kx022a_data *data, void *buffer,
> +				   int samples)
> +{

I would just put this code inline at the single call site.

> +	int ret, fifo_bytes;
> +
> +	fifo_bytes = samples * KX022A_FIFO_SAMPLES_SIZE_BYTES;
> +	ret = regmap_noinc_read(data->regmap, KX022A_REG_BUF_READ,
> +			       buffer, fifo_bytes);
> +	if (ret)
> +		dev_err(data->dev, "FIFO read failed %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int kx022a_get_axis(struct kx022a_data *data,
> +			   struct iio_chan_spec const *chan,
> +			   int *val)
> +{
> +	u16 raw_val;
> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, chan->address, &raw_val,
> +			       sizeof(raw_val));

Bulk reads for SPI still require dma safe buffers. Long story but
The short version is today regmap happens to always use bounce buffers
for SPI (or it did last time I looked at it). However there is no
guarantee on that in future.  As such you need to use a buffer
that is  __aligned(IIO_DMA_MINALIGN);
Easiest option is to put one at the end of the iio_priv() structure.

> +	if (ret)
> +		return ret;
> +	*val = raw_val;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int kx022a_read_raw(struct iio_dev *idev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct kx022a_data *data = iio_priv(idev);
> +	unsigned int regval;
> +	int ret = -EINVAL;
> +
> +	mutex_lock(&data->mutex);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (iio_buffer_enabled(idev)) {

Claim direct mode as standard way to avoid racing in read_raw.
Note you should be very careful on locking order as well.
Claim direct mode first then take any other locks.


> +			ret = -EBUSY;
> +			goto error_ret;
> +		}
> +
> +		ret = kx022a_get_axis(data, chan, val);
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +	{

Brackets don't add anything here as not defining scope of anything.

> +		ret = regmap_read(data->regmap, KX022A_REG_ODCNTL, &regval);
> +		if (ret)
> +			goto error_ret;
> +
> +		if ((regval & KX022A_MASK_ODR) >
> +		    ARRAY_SIZE(kx022a_accel_samp_freq_table)) {
> +			dev_err(data->dev, "Invalid ODR\n");
> +			ret = -EINVAL;
> +			goto error_ret;
> +		}
> +
> +		kx022a_reg2freq(regval, val, val2);
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +
> +		break;
> +	}
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = regmap_read(data->regmap, KX022A_REG_CNTL, &regval);
> +		if (ret < 0)
> +			goto error_ret;
> +
> +		kx022a_reg2scale(regval, val, val2);
> +
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
> +	}
> +
> +error_ret:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +};
> +
> +static int kx022a_validate_trigger(struct iio_dev *idev,
> +				   struct iio_trigger *trig)
> +{
> +	struct kx022a_data *data = iio_priv(idev);
> +
> +	if (data->trigger.indio_trig == trig)
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +static int kx022a_set_watermark(struct iio_dev *idev, unsigned int val)
> +{
> +	struct kx022a_data *data = iio_priv(idev);
> +
> +	if (val > KX022A_FIFO_LENGTH)
> +		val = KX022A_FIFO_LENGTH;
> +
> +	mutex_lock(&data->mutex);
> +	data->watermark = val;
> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
> +
> +static ssize_t kx022a_get_fifo_state(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	struct iio_dev *idev = dev_to_iio_dev(dev);
> +	struct kx022a_data *data = iio_priv(idev);
> +	bool state;
> +
> +	mutex_lock(&data->mutex);
> +	state = data->state;
> +	mutex_unlock(&data->mutex);
> +
> +	return sprintf(buf, "%d\n", state);
> +}
> +
> +static ssize_t kx022a_get_fifo_watermark(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct iio_dev *idev = dev_to_iio_dev(dev);
> +	struct kx022a_data *data = iio_priv(idev);
> +	int wm;
> +
> +	mutex_lock(&data->mutex);
> +	wm = data->watermark;
> +	mutex_unlock(&data->mutex);
> +
> +	return sprintf(buf, "%d\n", wm);
> +}
> +
> +static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
> +		       kx022a_get_fifo_state, NULL, 0);
> +static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
> +		       kx022a_get_fifo_watermark, NULL, 0);
> +
> +static const struct attribute *kx022a_fifo_attributes[] = {
> +	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
> +	NULL,
> +};
> +
> +static int kx022a_drop_fifo_contents(struct kx022a_data *data)
> +{
> +	/*
> +	 * We must clear the old time-stamp to avoid computing the timestamps
> +	 * based on samples acquired when buffer was last enabled
> +	 */
> +	data->timestamp = 0;
> +
> +	return regmap_write(data->regmap, KX022A_REG_BUF_CLEAR, 0xff);
> +}
> +
> +static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
> +			       bool irq)
> +{
> +	struct kx022a_data *data = iio_priv(idev);
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret, i;
> +	int count, fifo_bytes;
> +	u16 buffer[KX022A_FIFO_LENGTH * 3];
> +	int64_t tstamp;
> +	uint64_t sample_period;
> +	static int err_ctr;
> +
> +	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
> +	if (ret < 0) {
> +		dev_err(dev, "Error reading buffer status\n");
> +		return ret;
> +	}
> +
> +	/* Let's not owerflow if we for some reason get bogus value from i2c */

overflow. Make sure to spell check.

> +	if (fifo_bytes > KX022A_FIFO_MAX_BYTES) {
> +		/*
> +		 * I've observed a strange behaviour where FIFO may get stuck if
> +		 * samples are not read out fast enough. By 'stuck' I mean
> +		 * situation where amount of data adverticed by the STATUS_1
> +		 * reg is 255 - which equals to 42,5 (sic!) samples and by
> +		 * my experimenting there are situations where reading the
> +		 * FIFO buffer does not decrease the data count but the same
> +		 * fifo sample level (255 bytes of data) is reported
> +		 */
> +		err_ctr++;
> +		dev_warn(data->dev, "Bad amount of data %u\n", fifo_bytes);
> +		fifo_bytes = KX022A_FIFO_MAX_BYTES;
> +	} else if (fifo_bytes % KX022A_FIFO_SAMPLES_SIZE_BYTES) {
> +		err_ctr++;
> +		dev_err(data->dev, "Bad FIFO alignment. Data may be corrupt\n");
> +	} else {
> +		err_ctr = 0;
> +	}
> +
> +	if (err_ctr > KXO22A_FIFO_ERR_THRESHOLD) {
> +		__kx022a_turn_off_unlocked(data);
> +		kx022a_drop_fifo_contents(data);
> +		__kx022a_turn_on_unlocked(data);
> +
> +		err_ctr = 0;
> +
> +		return -EINVAL;
> +	}
> +
> +	count = fifo_bytes / KX022A_FIFO_SAMPLES_SIZE_BYTES;
> +	if (!count)
> +		return 0;
> +
> +	/*
> +	 * If we are being called from IRQ handler we know the stored timestamp
> +	 * is fairly accurate for the last stored sample. Otherwise, if we are
> +	 * called as a result of a read operation from userspace and hence
> +	 * before the watermark interrupt was triggered, take a timestamp
> +	 * now. We can fall anywhere in between two samples so the error in this
> +	 * case is at most one sample period.
> +	 */
> +	if (!irq) {
> +		data->old_timestamp = data->timestamp;
> +		data->timestamp = iio_get_time_ns(idev);
> +	}
> +
> +	/*
> +	 * Approximate timestamps for each of the sample based on the sampling
> +	 * frequency, timestamp for last sample and number of samples.
> +	 *
> +	 * We'd better not use the current bandwidth settings to compute the
> +	 * sample period. The real sample rate varies with the device and
> +	 * small variation adds when we store a large number of samples.
> +	 *
> +	 * To avoid this issue we compute the actual sample period ourselves
> +	 * based on the timestamp delta between the last two flush operations.
> +	 */
> +	if (data->old_timestamp) {
> +		sample_period = (data->timestamp - data->old_timestamp);
> +		do_div(sample_period, count);
> +	} else {
> +		sample_period = data->odr_ns;
> +	}
> +	tstamp = data->timestamp - (count - 1) * sample_period;
> +
> +	if (samples && count > samples) {
> +		/*
> +		 * Here we leave some old samples to the buffer. We need to
> +		 * adjust the timestamp to match the first sample in the buffer
> +		 * or we will miscalculate the sample_period at next round.
> +		 */
> +		data->timestamp -= (count - samples) * sample_period;
> +		count = samples;
> +	}
> +
> +	ret = kx022a_fifo_report_data(data, buffer, count);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < count; i++) {
> +		int bit;
> +		u16 *samples = &buffer[i * 3];
> +
> +		for_each_set_bit(bit, idev->active_scan_mask, AXIS_MAX)
> +			memcpy(&data->scan.channels[bit], &samples[bit],
> +			       sizeof(data->scan.channels[0]));
> +
> +		iio_push_to_buffers_with_timestamp(idev, &data->scan, tstamp);
> +
> +		tstamp += sample_period;
> +	}
> +
> +	return count;
> +}
> +
> +static int kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples)
> +{
> +	struct kx022a_data *data = iio_priv(idev);
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +	ret = __kx022a_fifo_flush(idev, samples, false);
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static const struct iio_info kx022a_info = {
> +	.read_raw = &kx022a_read_raw,
> +	.write_raw = &kx022a_write_raw,
> +	.attrs = &kx022a_attrs_group,
> +
> +	.validate_trigger	= kx022a_validate_trigger,
> +	.hwfifo_set_watermark	= kx022a_set_watermark,
> +	.hwfifo_flush_to_buffer	= kx022a_fifo_flush,
> +};
> +
> +static int kx022a_set_drdy_irq(struct kx022a_data *data, bool en)
> +{
> +	if (en)
> +		return regmap_set_bits(data->regmap, KX022A_REG_CNTL,
> +				       KX022A_MASK_DRDY);
> +
> +	return regmap_clear_bits(data->regmap, KX022A_REG_CNTL,
> +				 KX022A_MASK_DRDY);
> +}
> +
> +static int kx022a_prepare_irq_pin(struct kx022a_data *data)
> +{
> +	/* Enable IRQ1 pin. Set polarity to active low */

Must either handle both pins or at least know if it is irq2 and
treat that as no irq for now.

> +	int mask = KX022A_MASK_IEN1 | KX022A_MASK_IPOL1 |
> +		   KX022A_MASK_ITYP;
> +	int val = KX022A_MASK_IEN1 | KX022A_IPOL_LOW |
> +		  KX022A_ITYP_LEVEL;
> +	int ret;
> +
> +	ret = regmap_update_bits(data->regmap, KX022A_REG_INC1, mask, val);
> +	if (ret)
> +		return ret;
> +
> +	mask = KX022A_MASK_INS2_DRDY | KX122_MASK_INS2_WMI;
> +
> +	return regmap_set_bits(data->regmap, KX022A_REG_INC4, mask);
> +}
> +
> +static int kx022a_fifo_disable(struct kx022a_data *data)
> +{
> +	int ret = 0;
> +
> +	/* PC1 to 0 */
?  No idea what that means...

> +	ret = kx022a_turn_off_lock(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_clear_bits(data->regmap, KX022A_REG_INC4,
> +				KX022A_MASK_WMI1);
> +	if (ret)
> +		goto unlock_out;
> +
> +	/* disable buffer */
> +	ret = regmap_clear_bits(data->regmap, KX022A_REG_BUF_CNTL2,
> +				KX022A_MASK_BUF_EN);
> +	if (ret)
> +		goto unlock_out;
> +
> +	data->state &= (~KX022A_STATE_FIFO);
> +
> +	kx022a_drop_fifo_contents(data);
> +
> +	return kx022a_turn_on_unlock(data);
> +
> +unlock_out:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static int kx022a_buffer_predisable(struct iio_dev *idev)
> +{
> +	struct kx022a_data *data = iio_priv(idev);
> +
> +	if (iio_device_get_current_mode(idev) == INDIO_BUFFER_TRIGGERED)
> +		return 0;
> +
> +	return kx022a_fifo_disable(data);
> +}
> +
> +static int kx022a_fifo_enable(struct kx022a_data *data)
> +{
> +	int ret = 0;
> +
> +	ret = kx022a_turn_off_lock(data);
> +	if (ret)
> +		return ret;
> +
> +	/* Write WMI to HW */

Where WMI is?

> +	ret = kx022a_fifo_set_wmi(data);
> +	if (ret)
> +		goto unlock_out;
> +
> +	/* Enable buffer */
> +	ret = regmap_set_bits(data->regmap, KX022A_REG_BUF_CNTL2,
> +			      KX022A_MASK_BUF_EN);
> +	if (ret)
> +		goto unlock_out;
> +
> +	data->state |= KX022A_STATE_FIFO;
> +	ret = regmap_set_bits(data->regmap, KX022A_REG_INC4,
> +			      KX022A_MASK_WMI1);
> +	if (ret)
> +		goto unlock_out;
> +
> +	return kx022a_turn_on_unlock(data);
> +
> +unlock_out:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static int kx022a_buffer_postenable(struct iio_dev *idev)
> +{
> +	struct kx022a_data *data = iio_priv(idev);
> +
> +	/*
> +	 * If we use triggers, then the IRQs should be handled by trigger
> +	 * enable and buffer is not used but we just add results to buffer
> +	 * when data-ready triggers.

That comment needs rewriting given you have two buffers and I think they
are very different things..

> +	 */
> +	if (iio_device_get_current_mode(idev) == INDIO_BUFFER_TRIGGERED)
> +		return 0;
> +
> +	return kx022a_fifo_enable(data);
> +}
> +
> +static const struct iio_buffer_setup_ops kx022a_buffer_ops = {
> +	.postenable = kx022a_buffer_postenable,
> +	.predisable = kx022a_buffer_predisable,
> +};
> +
> +static irqreturn_t kx022a_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *idev = pf->indio_dev;
> +	struct kx022a_data *data = iio_priv(idev);
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +	ret = regmap_bulk_read(data->regmap, KX022A_REG_XOUT_L, data->buffer,
> +			       KX022A_FIFO_SAMPLES_SIZE_BYTES);
> +	if (ret < 0)
> +		goto err_read;
> +
> +	iio_push_to_buffers_with_timestamp(idev, data->buffer, pf->timestamp);
> +err_read:
> +	mutex_unlock(&data->mutex);
> +	iio_trigger_notify_done(idev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/* Get timestamps and wake the thread if we need to read data */
> +static irqreturn_t kx022a_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *idev = private;
> +	struct kx022a_data *data = iio_priv(idev);
> +	bool ack = false;
> +
> +	data->old_timestamp = data->timestamp;
> +	data->timestamp = iio_get_time_ns(idev);
> +
> +	if (data->trigger.enabled) {
> +		iio_trigger_poll(data->trigger.indio_trig);
> +		ack = true;
> +	}
> +
> +	if (data->state & KX022A_STATE_FIFO)
> +		return IRQ_WAKE_THREAD;
> +
> +	if (ack) {
> +		/*
> +		 * The IRQ is not acked until data is read. We need to disable
> +		 * the IRQ in order to schedule the trigger thread. Enabling
> +		 * is done in reenable.

I'm a little confused at what is going on here, but a common solution to situations
like this is to handling to use iio_trigger_poll_chained() from the thread and
a IRQF_ONESHOT irq.  Thus the interrupt will remain masked until the trigger
consumers are all done.

> +		 *
> +		 * It would be possible to set the IRQ to 50uS pulse. If we are
> +		 * losing data due to the disabled IRQ we can evaluate the
> +		 * option of using edge triggered IRQs with the pulse mode.
> +		 */
> +		disable_irq_nosync(irq);
> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_NONE;
> +}
> +
> +/* Read the data from the fifo and fill IIO buffers */
> +static irqreturn_t kx022a_irq_thread_handler(int irq, void *private)
> +{
> +	struct iio_dev *idev = private;
> +	struct kx022a_data *data = iio_priv(idev);
> +	bool ack = false;
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +
> +	if (data->state & KX022A_STATE_FIFO) {
> +		ret = __kx022a_fifo_flush(idev, KX022A_FIFO_LENGTH, true);
> +		if (ret > 0)
> +			ack = true;
> +	}
> +	/*
> +	 * WMI and data-ready IRQs are acked when results are read. If we add
> +	 * TILT/WAKE or other IRQs - then we may need to implement the acking
> +	 * (which is racy).

I'm not even going to ask for more info at this stage but that sound worrying.

> +	 */
> +	if (ack)
> +		ret = IRQ_HANDLED;
> +	else
> +		ret = IRQ_NONE;
> +
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static int kx022a_trigger_set_state(struct iio_trigger *trig,
> +				    bool state)
> +{
> +	struct kx022a_trigger *t = iio_trigger_get_drvdata(trig);
> +	struct kx022a_data *data = t->data;
> +	int ret = 0;
> +
> +	mutex_lock(&data->mutex);
> +
> +	if (t->enabled == state)
> +		goto unlock_out;
> +
> +	ret = __kx022a_turn_off_unlocked(data);
> +	if (ret)
> +		goto unlock_out;
> +
> +	t->enabled = state;
> +	ret = kx022a_set_drdy_irq(data, state);
> +	if (ret)
> +		goto unlock_out;
> +
> +	ret = __kx022a_turn_on_unlocked(data);
> +
> +unlock_out:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}

blank line between functions.

> +static void kx022a_trig_reen(struct iio_trigger *trig)
> +{
> +	struct kx022a_trigger *t = iio_trigger_get_drvdata(trig);

Mentioned above, but I really don't like the pointer loops between
the trigger and main _data structure.

> +	struct kx022a_data *data = t->data;
> +
> +	enable_irq(data->irq);
> +}
> +
> +static const struct iio_trigger_ops kx022a_trigger_ops = {
> +	.set_trigger_state = kx022a_trigger_set_state,
> +	.reenable = kx022a_trig_reen,
> +};
> +
> +static int kx022a_chip_init(struct kx022a_data *data)
> +{
> +	int ret, dummy;
> +
> +	/*
> +	 * Disable IRQs because if the IRQs are left on (for example by
> +	 * a shutdown which did not deactivate the accelerometer) we do
> +	 * most probably end up flooding the system with unhandled IRQs
> +	 * and get the line disabled from SOC side.
> +	 */
> +	ret = regmap_write(data->regmap, KX022A_REG_INC4, 0);

Unusual to do this rather than a reset.  Quick look suggests there is
a suitable software reset (CNTL2)

> +	if (ret) {
> +		dev_err(data->dev, "Failed to init IRQ states\n");
> +		return ret;
> +	}
> +
> +	ret = kx022a_set_drdy_irq(data, false);
> +	if (ret) {
> +		dev_err(data->dev, "Failed to init DRDY\n");
> +		return ret;
> +	}
> +
> +	/* Clear any pending IRQs */
> +	ret = regmap_read(data->regmap, KX022A_REG_INT_REL, &dummy);
> +	if (ret) {
> +		dev_err(data->dev, "Failed to ACK IRQs\n");
> +		return ret;
> +	}
> +	/* set data res 16bit */
> +	ret = regmap_set_bits(data->regmap, KX022A_REG_BUF_CNTL2,
> +			      KX022A_MASK_BRES);

Can we have a _BRES_16 to make this self documenting?

> +	if (ret) {
> +		dev_err(data->dev, "Failed to set data resolution\n");
> +		return ret;
> +	}
> +
> +	ret = kx022a_prepare_irq_pin(data);
> +	if (ret) {
> +		dev_err(data->dev, "Failed to configure IRQ pin\n");
> +		return ret;
> +	}
> +
> +	/* disable buffer */

consistent capitalisation of comments...

> +	ret = regmap_clear_bits(data->regmap, KX022A_REG_BUF_CNTL2,
> +			      KX022A_MASK_BUF_EN);
> +	if (ret)
> +		return ret;
> +
> +	return kx022a_drop_fifo_contents(data);
> +}
> +
> +int kx022a_probe_internal(struct device *dev, int irq)
> +{
> +	static const char * const regulator_names[] = {"io_vdd", "vdd"};
> +	struct iio_trigger *indio_trig;
> +	struct kx022a_data *data;
> +	struct regmap *regmap;
> +	unsigned int chip_id;
> +	struct iio_dev *idev;
> +	int ret;
> +
> +	if (WARN_ON(!dev))
> +		return -ENODEV;
> +
> +	regmap = dev_get_regmap(dev, NULL);
> +	if (!regmap) {
> +		dev_err(dev, "no regmap\n");

Use dev_err_probe() for all dev_err() stuff in probe paths.
It ends up cleaner and we don't care about the tiny overhead
of checking for deferred.

> +
> +		return -EINVAL;
> +	}
> +
> +	idev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!idev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(idev);
> +
> +	/*
> +	 * VDD is the analog and digital domain voltage supply
> +	 * IO_VDD is the digital I/O voltage supply
> +	 */
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
> +					     regulator_names);
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable regulator\n");
> +
> +	ret = regmap_read(regmap, KX022A_REG_WHO, &chip_id);
> +	if (ret) {
> +		dev_err(dev, "Failed to access sensor\n");
> +		return ret;
> +	}
> +
> +	if (chip_id != KX022A_ID) {
> +		dev_err(dev, "unsupported device 0x%x\n", chip_id);
> +		return -EINVAL;
> +	}
> +
> +	data->regmap = regmap;
> +	data->dev = dev;
> +	data->irq = irq;
> +	data->odr_ns = KX922A_DEFAULT_PERIOD;
> +	mutex_init(&data->mutex);
> +
> +	idev->channels = kx022a_channels;
> +	idev->num_channels = ARRAY_SIZE(kx022a_channels);
> +	idev->name = "kx022-accel";
> +	idev->info = &kx022a_info;
> +	idev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> +	idev->available_scan_masks = kx022a_scan_masks;
> +
> +	/* Read the mounting matrix, if present */
> +	ret = iio_read_mount_matrix(dev, &data->orientation);
> +	if (ret)
> +		return ret;
> +
> +	/* The sensor must be turned off for configuration */
> +	ret = kx022a_turn_off_lock(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = kx022a_chip_init(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = kx022a_turn_on_unlock(data);
> +	if (ret)
> +		return ret;
> +
> +	udelay(100);
> +
> +	ret = iio_triggered_buffer_setup_ext(idev,

devm_

> +					     &iio_pollfunc_store_time,
> +					     kx022a_trigger_handler,
> +					     IIO_BUFFER_DIRECTION_IN,
> +					     &kx022a_buffer_ops,
> +					     kx022a_fifo_attributes);
> +
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "iio_triggered_buffer_setup_ext FAIL %d\n",
> +				     ret);
> +
> +	indio_trig = devm_iio_trigger_alloc(dev, "%sdata-rdy-dev%d", idev->name,
> +					    iio_device_id(idev));
> +	if (!indio_trig)
> +		return -ENOMEM;
> +
> +	data->trigger.indio_trig = indio_trig;
> +
> +	indio_trig->ops = &kx022a_trigger_ops;
> +	data->trigger.data = data;
> +	iio_trigger_set_drvdata(indio_trig, &data->trigger);
> +
> +	ret = iio_trigger_register(indio_trig);

Don't mix devm and non devm allocation / registration.

> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "Trigger registration failed\n");
> +
> +	ret = devm_iio_device_register(data->dev, idev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Unable to register iio device\n");
> +
> +	ret = devm_request_threaded_irq(data->dev, irq, kx022a_irq_handler,
> +					&kx022a_irq_thread_handler,
> +					IRQF_ONESHOT, "kx022", idev);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(kx022a_probe_internal);
> +
> +MODULE_DESCRIPTION("ROHM/Kionix KX022A accelerometer driver");
> +MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
> new file mode 100644
> index 000000000000..ec89e46c6ca8
> --- /dev/null
> +++ b/drivers/iio/accel/kionix-kx022a.h
> @@ -0,0 +1,76 @@

...

> +#define KX022A_REG_INC4		0x1f
> +#define KX022A_MASK_WMI1	BIT(5)
> +
> +#define KX022A_REG_SELF_TEST	0x60
> +#define KX022A_MAX_REGISTER	0x60
> +

Use a forward definition for struct device
rather than including the header.

> +int kx022a_probe_internal(struct device *dev, int irq);
> +extern const struct regmap_config kx022a_regmap;
> +
> +#endif

