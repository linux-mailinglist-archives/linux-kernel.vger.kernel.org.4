Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0D26C02F9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 17:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjCSQFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 12:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCSQFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 12:05:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0860F1DB90;
        Sun, 19 Mar 2023 09:05:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86815610A7;
        Sun, 19 Mar 2023 16:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74727C433EF;
        Sun, 19 Mar 2023 16:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679241936;
        bh=s/Yr+vosYw4VljXErsjkYfw8OlLLi+PjAivbmcvw32k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q0/kMJ7boFt7LSygKMYz9IIF8B1yfaaZRbyvBdoX2D+ZnFo//WB06/HvZQoEFoAHK
         1+SodUtf1PpOQgrTPj5PucVMRQs3THNzv2NGPZ/dFDtF8TMR8OKBn3wlzeZMhvyYdY
         0PImdgWa4geJDJCz5b6C9g8PjasdYhZfb/u0i2TLxXzVtj01tvOk69dtnMiu3J1tgK
         L+lIdpuFmItOoFgCerbTTYsIc/yU3jZ1XQxkrasPX6rOvN/xuZoaaJLssp0LDPlZFc
         zg2dzOzzVHV/pPQGVdhhUp99b1Tvd0tWAPw9Fu5iIGes+7OvqSEcllI3c6Tr7K67zN
         mQgagi9lOi9VA==
Date:   Sun, 19 Mar 2023 16:20:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     mazziesaccount@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: accel: kionix-kx022a: Add chip_info structure
Message-ID: <20230319162030.318918b8@jic23-huawei>
In-Reply-To: <3ddca10a4c03c3a64afb831cc9dd1e01fe89d305.1679009443.git.mehdi.djait.k@gmail.com>
References: <cover.1679009443.git.mehdi.djait.k@gmail.com>
        <3ddca10a4c03c3a64afb831cc9dd1e01fe89d305.1679009443.git.mehdi.djait.k@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023 00:48:36 +0100
Mehdi Djait <mehdi.djait.k@gmail.com> wrote:

> Refactor the kx022a driver implementation to make it more
> generic and extensible.
> Add the chip_info structure will to the driver's private
> data to hold all the device specific infos.
> Move the enum, struct and constants definitions to the header
> file.

You also introduce an i2c_device_id table

Without that I think module autoloading will be broken anyway so that's
definitely a good thing to add.


A few comments inline.  Mostly around reducing the name changes.
Wild cards (or simply shorted 'generic' prefixes like KX_)
almost always bite back in the long run.  Hence we generally just try
to name things after the first device that they were relevant to.

Thanks,

Jonathan

> 
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> ---
>  drivers/iio/accel/kionix-kx022a-i2c.c |  19 +-
>  drivers/iio/accel/kionix-kx022a-spi.c |  22 +-
>  drivers/iio/accel/kionix-kx022a.c     | 289 ++++++++++++--------------
>  drivers/iio/accel/kionix-kx022a.h     | 128 ++++++++++--
>  4 files changed, 274 insertions(+), 184 deletions(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
> index e6fd02d931b6..21c4c0ae1a68 100644
> --- a/drivers/iio/accel/kionix-kx022a-i2c.c
> +++ b/drivers/iio/accel/kionix-kx022a-i2c.c
> @@ -15,23 +15,35 @@
>  static int kx022a_i2c_probe(struct i2c_client *i2c)
>  {
>  	struct device *dev = &i2c->dev;
> +	struct kx022a_chip_info *chip_info;
>  	struct regmap *regmap;
> +	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
>  
>  	if (!i2c->irq) {
>  		dev_err(dev, "No IRQ configured\n");
>  		return -EINVAL;
>  	}
>  
> -	regmap = devm_regmap_init_i2c(i2c, &kx022a_regmap);
> +	chip_info = device_get_match_data(&i2c->dev);
> +	if (!chip_info)
> +		chip_info = (const struct kx022a_chip_info *) id->driver_data;

Get id only if the device_get_match_data() fails.

	if (!chip_info) {
		const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
		chip_info = (const struct kx...)
	}	

> +
> +	regmap = devm_regmap_init_i2c(i2c, chip_info->regmap_config);
>  	if (IS_ERR(regmap))
>  		return dev_err_probe(dev, PTR_ERR(regmap),
>  				     "Failed to initialize Regmap\n");
>  
> -	return kx022a_probe_internal(dev);
> +	return kx022a_probe_internal(dev, chip_info);
>  }
>  
> +static const struct i2c_device_id kx022a_i2c_id[] = {
> +	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx_chip_info[KX022A] },
If there are a small set and we aren't ever going to index the chip_info structure
we might be better off not bothering with the enum and instead using a separate
instance of the structure for each chip.

	.driver_data = (kernel_ulong_t)&kx022a_chip_info, 
etc.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, kx022a_i2c_id);
> +
>  static const struct of_device_id kx022a_of_match[] = {
> -	{ .compatible = "kionix,kx022a", },
> +	{ .compatible = "kionix,kx022a", .data = &kx_chip_info[KX022A] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, kx022a_of_match);
> @@ -42,6 +54,7 @@ static struct i2c_driver kx022a_i2c_driver = {
>  		.of_match_table = kx022a_of_match,
>  	  },
>  	.probe_new    = kx022a_i2c_probe,
> +	.id_table     = kx022a_i2c_id,
>  };
>  module_i2c_driver(kx022a_i2c_driver);
>  
> diff --git a/drivers/iio/accel/kionix-kx022a-spi.c b/drivers/iio/accel/kionix-kx022a-spi.c
> index 9cd047f7b346..ec076af0f261 100644
> --- a/drivers/iio/accel/kionix-kx022a-spi.c
> +++ b/drivers/iio/accel/kionix-kx022a-spi.c
> @@ -15,40 +15,46 @@
>  static int kx022a_spi_probe(struct spi_device *spi)
>  {
>  	struct device *dev = &spi->dev;
> +	struct kx022a_chip_info *chip_info;
>  	struct regmap *regmap;
> +	const struct spi_device_id *id = spi_get_device_id(spi);
>  
>  	if (!spi->irq) {
>  		dev_err(dev, "No IRQ configured\n");
>  		return -EINVAL;
>  	}
>  
> -	regmap = devm_regmap_init_spi(spi, &kx022a_regmap);
> +	chip_info = device_get_match_data(&spi->dev);
> +	if (!chip_info)
As above. Get the id only if we are going to use it.

> +		chip_info = (const struct kx022a_chip_info *) id->driver_data;
> +
> +	regmap = devm_regmap_init_spi(spi, chip_info->regmap_config);
>  	if (IS_ERR(regmap))
>  		return dev_err_probe(dev, PTR_ERR(regmap),
>  				     "Failed to initialize Regmap\n");
>  
> -	return kx022a_probe_internal(dev);
> +	return kx022a_probe_internal(dev, chip_info);
>  }
>  
> -static const struct spi_device_id kx022a_id[] = {
> -	{ "kx022a" },
> +static const struct spi_device_id kx022a_spi_id[] = {
> +	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx_chip_info[KX022A] },
>  	{ }
>  };
> -MODULE_DEVICE_TABLE(spi, kx022a_id);
> +MODULE_DEVICE_TABLE(spi, kx022a_spi_id);
>  
>  static const struct of_device_id kx022a_of_match[] = {
> -	{ .compatible = "kionix,kx022a", },
> +	{ .compatible = "kionix,kx022a", .data = &kx_chip_info[KX022A] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, kx022a_of_match);
>  
>  static struct spi_driver kx022a_spi_driver = {
>  	.driver = {
> -		.name   = "kx022a-spi",
> +		.name	= "kx022a-spi",
>  		.of_match_table = kx022a_of_match,
>  	},
>  	.probe = kx022a_spi_probe,
> -	.id_table = kx022a_id,
> +	.id_table = kx022a_spi_id,
>  };
>  module_spi_driver(kx022a_spi_driver);
>  
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index 8dac0337c249..27e8642aa8f5 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -26,29 +26,7 @@
..

> -#define KX022A_ACCEL_CHAN(axis, index)				\
> +#define KX022A_ACCEL_CHAN(axis, index, device)			\
>  {								\
>  	.type = IIO_ACCEL,					\
>  	.modified = 1,						\
> @@ -220,7 +158,7 @@ static const struct iio_chan_spec_ext_info kx022a_ext_info[] = {
>  				BIT(IIO_CHAN_INFO_SCALE) |	\
>  				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
>  	.ext_info = kx022a_ext_info,				\
> -	.address = KX022A_REG_##axis##OUT_L,			\
> +	.address = device##_REG_##axis##OUT_L,			\

I'm not particularly keen on this because it is hard to search for.
It wasn't great before, but it's getting worse.

Perhaps just put the fully defined address in as a parameter to the macro.

>  	.scan_index = index,					\
>  	.scan_type = {                                          \
>  		.sign = 's',					\
> @@ -231,9 +169,9 @@ static const struct iio_chan_spec_ext_info kx022a_ext_info[] = {
>  }
>  
>  static const struct iio_chan_spec kx022a_channels[] = {
> -	KX022A_ACCEL_CHAN(X, 0),
> -	KX022A_ACCEL_CHAN(Y, 1),
> -	KX022A_ACCEL_CHAN(Z, 2),
> +	KX022A_ACCEL_CHAN(X, 0, KX022A),
> +	KX022A_ACCEL_CHAN(Y, 1, KX022A),
> +	KX022A_ACCEL_CHAN(Z, 2, KX022A),
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
>  
> @@ -286,6 +224,34 @@ static const int kx022a_scale_table[][2] = {
>  	{ 4788, 403320 },
>  };
>  
> +const struct kx022a_chip_info kx_chip_info[] = {
> +	[KX022A] = {
> +		.name		  = "kx022a",
> +		.type		  = KX022A,
> +		.regmap_config	  = &kx022a_regmap_config,
> +		.channels	  = kx022a_channels,
> +		.num_channels	  = ARRAY_SIZE(kx022a_channels),
> +		.fifo_length	  = KX022A_FIFO_LENGTH,
> +		.who		  = KX022A_REG_WHO,
> +		.id		  = KX022A_ID,
> +		.cntl		  = KX022A_REG_CNTL,
> +		.cntl2		  = KX022A_REG_CNTL2,
> +		.odcntl		  = KX022A_REG_ODCNTL,
> +		.buf_cntl1	  = KX022A_REG_BUF_CNTL1,
> +		.buf_cntl2	  = KX022A_REG_BUF_CNTL2,
> +		.buf_clear	  = KX022A_REG_BUF_CLEAR,
> +		.buf_status1	  = KX022A_REG_BUF_STATUS_1,
> +		.buf_smp_lvl_mask = KX022A_MASK_BUF_SMP_LVL,
> +		.buf_read	  = KX022A_REG_BUF_READ,
> +		.inc1		  = KX022A_REG_INC1,
> +		.inc4		  = KX022A_REG_INC4,
> +		.inc5		  = KX022A_REG_INC5,
> +		.inc6		  = KX022A_REG_INC6,
> +		.xout_l		  = KX022A_REG_XOUT_L,
> +	},
> +};
> +EXPORT_SYMBOL_NS_GPL(kx_chip_info, IIO_KX022A);

...

>  
> +static int kx022a_get_fifo_bytes(struct kx022a_data *data)

Factoring this out looks like an unrelated change.  Fine to do it but should be a
separate patch.

If you need a device type specific version of this add a function pointer
to your chip_info structure.  Given you don't add one for the next patch
I think this is just refactoring and so fine to do, but needs to be in a separate
patch from this one with a description that says why you are doing it.

> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	__le16 buf_status;
> +	int ret, fifo_bytes;
> +
> +	ret = regmap_bulk_read(data->regmap, data->chip_info->buf_status1, &buf_status, sizeof(buf_status));
> +	if (ret) {
> +		dev_err(dev, "Error reading buffer status\n");
> +		return ret;
> +	}
> +
> +	buf_status &= data->chip_info->buf_smp_lvl_mask;
> +	fifo_bytes = le16_to_cpu(buf_status);
> +
> +	/*
> +	 * The KX022A has FIFO which can store 43 samples of HiRes data from 2
> +	 * channels. This equals to 43 (samples) * 3 (channels) * 2 (bytes/sample) to
> +	 * 258 bytes of sample data. The quirk to know is that the amount of bytes in
> +	 * the FIFO is advertised via 8 bit register (max value 255). The thing to note
> +	 * is that full 258 bytes of data is indicated using the max value 255.
> +	 */
> +	if (data->chip_info->type == KX022A && fifo_bytes == KX022A_FIFO_FULL_VALUE)
> +		fifo_bytes = KX022A_FIFO_MAX_BYTES;
> +
> +	if (fifo_bytes % KX_FIFO_SAMPLES_SIZE_BYTES)
> +		dev_warn(data->dev, "Bad FIFO alignment. Data may be corrupt\n");
> +
> +	return fifo_bytes;
> +}
> +
>  static int kx022a_drop_fifo_contents(struct kx022a_data *data)
>  {
>  	/*
> @@ -593,35 +588,22 @@ static int kx022a_drop_fifo_contents(struct kx022a_data *data)
>  	 */
>  	data->timestamp = 0;
>  
> -	return regmap_write(data->regmap, KX022A_REG_BUF_CLEAR, 0x0);
> +	return regmap_write(data->regmap, data->chip_info->buf_clear, 0x0);
>  }
>  
>  static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
>  			       bool irq)
>  {
>  	struct kx022a_data *data = iio_priv(idev);
> -	struct device *dev = regmap_get_device(data->regmap);
> -	__le16 buffer[KX022A_FIFO_LENGTH * 3];
> +	__le16 buffer[data->chip_info->fifo_length * 3];
>  	uint64_t sample_period;
>  	int count, fifo_bytes;
>  	bool renable = false;
>  	int64_t tstamp;
>  	int ret, i;
>  
> -	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
> -	if (ret) {
> -		dev_err(dev, "Error reading buffer status\n");
> -		return ret;
> -	}
> -
> -	/* Let's not overflow if we for some reason get bogus value from i2c */
> -	if (fifo_bytes == KX022A_FIFO_FULL_VALUE)
> -		fifo_bytes = KX022A_FIFO_MAX_BYTES;
> -
> -	if (fifo_bytes % KX022A_FIFO_SAMPLES_SIZE_BYTES)
> -		dev_warn(data->dev, "Bad FIFO alignment. Data may be corrupt\n");
> -
> -	count = fifo_bytes / KX022A_FIFO_SAMPLES_SIZE_BYTES;
> +	fifo_bytes = kx022a_get_fifo_bytes(data);
> +	count = fifo_bytes / KX_FIFO_SAMPLES_SIZE_BYTES;
>  	if (!count)
>  		return 0;
...

>  
> @@ -969,25 +949,25 @@ static int kx022a_chip_init(struct kx022a_data *data)
>  	 */
>  	msleep(1);
>  
> -	ret = regmap_read_poll_timeout(data->regmap, KX022A_REG_CNTL2, val,
> -				       !(val & KX022A_MASK_SRST),
> -				       KX022A_SOFT_RESET_WAIT_TIME_US,
> -				       KX022A_SOFT_RESET_TOTAL_WAIT_TIME_US);
> +	ret = regmap_read_poll_timeout(data->regmap, data->chip_info->cntl2, val,
> +				       !(val & KX_MASK_SRST),
> +				       KX_SOFT_RESET_WAIT_TIME_US,
> +				       KX_SOFT_RESET_TOTAL_WAIT_TIME_US);

Where ever there are lots of accesses to data->chip_info I'd add
a local chip_info variable to improve readabilty a bit. Might be
worth doing the same with regmap (in a different patch)

>  	if (ret) {
>  		dev_err(data->dev, "Sensor reset %s\n",
> -			val & KX022A_MASK_SRST ? "timeout" : "fail#");
> +			val & KX_MASK_SRST ? "timeout" : "fail#");
>  		return ret;
>  	}
>  
> -	ret = regmap_reinit_cache(data->regmap, &kx022a_regmap);
> +	ret = regmap_reinit_cache(data->regmap, data->chip_info->regmap_config);
>  	if (ret) {
>  		dev_err(data->dev, "Failed to reinit reg cache\n");
>  		return ret;
>  	}
>  
>  	/* set data res 16bit */
> -	ret = regmap_set_bits(data->regmap, KX022A_REG_BUF_CNTL2,
> -			      KX022A_MASK_BRES16);
> +	ret = regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
> +			      KX_MASK_BRES16);
>  	if (ret) {
>  		dev_err(data->dev, "Failed to set data resolution\n");
>  		return ret;
> @@ -996,7 +976,7 @@ static int kx022a_chip_init(struct kx022a_data *data)
>  	return kx022a_prepare_irq_pin(data);
>  }
>  
> -int kx022a_probe_internal(struct device *dev)
> +int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info)
>  {
>  	static const char * const regulator_names[] = {"io-vdd", "vdd"};
>  	struct iio_trigger *indio_trig;
> @@ -1023,6 +1003,7 @@ int kx022a_probe_internal(struct device *dev)
>  		return -ENOMEM;
>  
>  	data = iio_priv(idev);
> +	data->chip_info = chip_info;
>  
>  	/*
>  	 * VDD is the analog and digital domain voltage supply and
> @@ -1033,37 +1014,37 @@ int kx022a_probe_internal(struct device *dev)
>  	if (ret && ret != -ENODEV)
>  		return dev_err_probe(dev, ret, "failed to enable regulator\n");
>  
> -	ret = regmap_read(regmap, KX022A_REG_WHO, &chip_id);
> +	ret = regmap_read(regmap, data->chip_info->who, &chip_id);

I think  you have chip_info available as a local variable.
Use that in this function to shorten lines with no loss of readability.

>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to access sensor\n");
>  
> -	if (chip_id != KX022A_ID) {
> +	if (chip_id != data->chip_info->id) {

Recently we've tried to avoid introduce error returns on a failure to match
and instead just warn and go ahead with assumption that we have a correct
dt-binding telling us that some new device with a different ID is backwards
compatible with the old one.  Obviously not part of this patch though but
something to think about later (if you don't do it later in this series).

>  		dev_err(dev, "unsupported device 0x%x\n", chip_id);
>  		return -EINVAL;
>  	}

...


>  
>  	data->regmap = regmap;
>  	data->dev = dev;
>  	data->irq = irq;
> -	data->odr_ns = KX022A_DEFAULT_PERIOD_NS;
> +	data->odr_ns = KX_DEFAULT_PERIOD_NS;
>  	mutex_init(&data->mutex);
>  
> -	idev->channels = kx022a_channels;
> -	idev->num_channels = ARRAY_SIZE(kx022a_channels);
> -	idev->name = "kx022-accel";

Ah. Missed this naming in original driver review.  We only normally
postfix with accel in devices that have multiple sensors with separate
drivers. Don't think that is true of the kx022a.
It's ABI so we are stuck with it, but avoid repeating that issue
for new devices.

> +	idev->channels = data->chip_info->channels;
> +	idev->num_channels = data->chip_info->num_channels;
> +	idev->name = data->chip_info->name;
>  	idev->info = &kx022a_info;
>  	idev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
>  	idev->available_scan_masks = kx022a_scan_masks;
> @@ -1112,7 +1093,7 @@ int kx022a_probe_internal(struct device *dev)
>  	 * No need to check for NULL. request_threaded_irq() defaults to
>  	 * dev_name() should the alloc fail.
>  	 */
> -	name = devm_kasprintf(data->dev, GFP_KERNEL, "%s-kx022a",
> +	name = devm_kasprintf(data->dev, GFP_KERNEL, "%s-accel",
>  			      dev_name(data->dev));

Why name change here?  It's not particularly important but if we can avoid
it that would be a nice to have.

>  
>  	ret = devm_request_threaded_irq(data->dev, irq, kx022a_irq_handler,
> diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
> index 12424649d438..3bb40e9f5613 100644
> --- a/drivers/iio/accel/kionix-kx022a.h
> +++ b/drivers/iio/accel/kionix-kx022a.h
> @@ -11,24 +11,48 @@
>  #include <linux/bits.h>
>  #include <linux/regmap.h>
>  
> +#include <linux/iio/iio.h>
> +
> +/* Common for all supported devices */
> +#define KX_FIFO_SAMPLES_SIZE_BYTES	    6
Even if they are used across multiple parts, don't rename them to
be generic.  It almost always causes churn / name clashes etc.

It is absolutely fine to have driver specific naming that is based
on the first supported part rather than trying to make it cover them
all.

> +#define KX_SOFT_RESET_WAIT_TIME_US	    (5 * USEC_PER_MSEC)
> +#define KX_SOFT_RESET_TOTAL_WAIT_TIME_US    (500 * USEC_PER_MSEC)
> +#define KX_DEFAULT_PERIOD_NS		    (20 * NSEC_PER_MSEC)
> +#define KX_MASK_GSEL			    GENMASK(4, 3)
> +#define KX_MASK_ODR			    GENMASK(3, 0)
> +#define KX_MASK_WM_TH			    GENMASK(6, 0)
> +#define KX_GSEL_SHIFT			    3
> +#define KX_MASK_IEN			    BIT(5)
> +#define KX_MASK_DRDY			    BIT(5)
> +#define KX_MASK_PC1			    BIT(7)
> +#define KX_MASK_IPOL			    BIT(4)
> +#define KX_IPOL_LOW			    0
> +#define KX_MASK_ITYP			    BIT(3)
> +#define KX_ITYP_LEVEL			    0
> +#define KX_MASK_INS2_DRDY		    BIT(4)
> +#define KX_MASK_WMI			    BIT(5)
> +#define KX_MASK_BUF_EN			    BIT(7)
> +#define KX_MASK_SRST			    BIT(7)
> +#define KX_MASK_BRES16			    BIT(6)
> +
> +
>  #define KX022A_REG_WHO		0x0f
>  #define KX022A_ID		0xc8
>  
> +#define KX022A_FIFO_LENGTH	43
> +#define KX022A_FIFO_FULL_VALUE	255
> +#define KX022A_FIFO_MAX_BYTES					\
> +	 (KX022A_FIFO_LENGTH * KX_FIFO_SAMPLES_SIZE_BYTES)
> +
>  #define KX022A_REG_CNTL2	0x19
> -#define KX022A_MASK_SRST	BIT(7)
>  #define KX022A_REG_CNTL		0x18
> -#define KX022A_MASK_PC1		BIT(7)
>  #define KX022A_MASK_RES		BIT(6)
> -#define KX022A_MASK_DRDY	BIT(5)
> -#define KX022A_MASK_GSEL	GENMASK(4, 3)
> -#define KX022A_GSEL_SHIFT	3
>  #define KX022A_GSEL_2		0x0
>  #define KX022A_GSEL_4		BIT(3)
>  #define KX022A_GSEL_8		BIT(4)
>  #define KX022A_GSEL_16		GENMASK(4, 3)
>  
>  #define KX022A_REG_INS2		0x13
> -#define KX022A_MASK_INS2_DRDY	BIT(4)
>  #define KX122_MASK_INS2_WMI	BIT(5)
>  
>  #define KX022A_REG_XHP_L	0x0
> @@ -45,38 +69,104 @@
>  #define KX022A_REG_MAN_WAKE	0x2c
>  
>  #define KX022A_REG_BUF_CNTL1	0x3a
> -#define KX022A_MASK_WM_TH	GENMASK(6, 0)
>  #define KX022A_REG_BUF_CNTL2	0x3b
> -#define KX022A_MASK_BUF_EN	BIT(7)
> -#define KX022A_MASK_BRES16	BIT(6)
>  #define KX022A_REG_BUF_STATUS_1	0x3c
>  #define KX022A_REG_BUF_STATUS_2	0x3d
> +#define KX022A_MASK_BUF_SMP_LVL GENMASK(6, 0)
>  #define KX022A_REG_BUF_CLEAR	0x3e
>  #define KX022A_REG_BUF_READ	0x3f
> -#define KX022A_MASK_ODR		GENMASK(3, 0)
>  #define KX022A_ODR_SHIFT	3
>  #define KX022A_FIFO_MAX_WMI_TH	41
>  
>  #define KX022A_REG_INC1		0x1c
>  #define KX022A_REG_INC5		0x20
>  #define KX022A_REG_INC6		0x21
> -#define KX022A_MASK_IEN		BIT(5)
> -#define KX022A_MASK_IPOL	BIT(4)
>  #define KX022A_IPOL_LOW		0
> -#define KX022A_IPOL_HIGH	KX022A_MASK_IPOL1
> -#define KX022A_MASK_ITYP	BIT(3)
> -#define KX022A_ITYP_PULSE	KX022A_MASK_ITYP
> -#define KX022A_ITYP_LEVEL	0
> +#define KX022A_IPOL_HIGH	KX_MASK_IPOL
> +#define KX022A_ITYP_PULSE	KX_MASK_ITYP
>  
>  #define KX022A_REG_INC4		0x1f
> -#define KX022A_MASK_WMI		BIT(5)
>  
>  #define KX022A_REG_SELF_TEST	0x60
>  #define KX022A_MAX_REGISTER	0x60
>  
> +enum kx022a_device_type {
> +	KX022A,
> +};

As below. I'd avoid using the enum unless needed.
That can make sense where a driver supports lots of devices but I don't think
it does here.

> +
> +enum {
> +	KX_STATE_SAMPLE,
> +	KX_STATE_FIFO,
> +};
> +
> +enum {
> +	AXIS_X,
> +	AXIS_Y,
> +	AXIS_Z,
> +	AXIS_MAX
> +};
> +
>  struct device;
>  
> -int kx022a_probe_internal(struct device *dev);
> -extern const struct regmap_config kx022a_regmap;
> +struct kx022a_chip_info {
> +	const char *name;
> +	enum kx022a_device_type type;
> +	const struct regmap_config *regmap_config;
> +	const struct iio_chan_spec *channels;
> +	unsigned int num_channels;
> +	unsigned int fifo_length;
> +	u8 who;
Some of these are no immediately obvious so either rename the
field so it is more obvious what it is, or add comments.

> +	u8 id;
> +	u8 cntl;
> +	u8 cntl2;
> +	u8 odcntl;
> +	u8 buf_cntl1;
> +	u8 buf_cntl2;
> +	u8 buf_clear;
> +	u8 buf_status1;
> +	u16 buf_smp_lvl_mask;
> +	u8 buf_read;
> +	u8 inc1;
> +	u8 inc4;
> +	u8 inc5;
> +	u8 inc6;
> +	u8 xout_l;
> +};
> +
> +struct kx022a_data {

Why move this to the header?  Unless there is a strong reason
I'd prefer this to stay down in the .c file.


> +	const struct kx022a_chip_info *chip_info;
> +	struct regmap *regmap;
> +	struct iio_trigger *trig;
> +	struct device *dev;
> +	struct iio_mount_matrix orientation;
> +	int64_t timestamp, old_timestamp;
> +
> +	int irq;
> +	int inc_reg;
> +	int ien_reg;
> +
> +	unsigned int state;
> +	unsigned int odr_ns;
> +
> +	bool trigger_enabled;
> +	/*
> +	 * Prevent toggling the sensor stby/active state (PC1 bit) in the
> +	 * middle of a configuration, or when the fifo is enabled. Also,
> +	 * protect the data stored/retrieved from this structure from
> +	 * concurrent accesses.
> +	 */
> +	struct mutex mutex;
> +	u8 watermark;
> +
> +	/* 3 x 16bit accel data + timestamp */
> +	__le16 buffer[8] __aligned(IIO_DMA_MINALIGN);
> +	struct {
> +		__le16 channels[3];
> +		s64 ts __aligned(8);
> +	} scan;
> +};
> +
> +int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info);
> +extern const struct kx022a_chip_info kx_chip_info[];
As mentioned in the bus specific driver, given there is a small set and we need the enum
just to index this, I'd just have one per supported device.

extern const struct kx022a_chip_info kx022a_chip_info;
extern const struct kx022a_chip_info kx321_chip_info;

etc


>  
>  #endif

