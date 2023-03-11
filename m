Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AC66B5FE4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 19:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCKS5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 13:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCKS5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 13:57:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E9346155;
        Sat, 11 Mar 2023 10:57:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EFDAB8068D;
        Sat, 11 Mar 2023 18:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC3DC433EF;
        Sat, 11 Mar 2023 18:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678561034;
        bh=wg33YK0h6t1rgG7Yxr4msszRqOQ0AYH3v0t/NGkFtRc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OpWz9dlpyER4mIPb4PlkdRzF63+Cy3tni7aR50Od95Z/NfEzUax0Ovm4Ogd3Q3gzA
         9KqCioj1UezWa4z/YhUxJ3O+ft8UnaW6y67AKYJ7izpyW08eQ1FO1Xi52EMMucstcN
         F6gKvrvmhccfhr98VRkCH/7bDZef/BPpZKd0NEwAT2JRJuPCZLneP3edgkQozBp86I
         lpLMrRZjZvsEae0N6rpfU1VwbQ9ICJWscNnzAbdIioJakDMKqFlAu28p4+NTuC0KME
         HZ61vctyOeC0uXqLLn0geaGQ1HMpgnaMq8DASuCRC/yOhsvrve3H7UR5GvO9my2o71
         J4SBlchu3H0Fw==
Date:   Sat, 11 Mar 2023 18:57:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] iio: dac: cio-dac: Migrate to the regmap API
Message-ID: <20230311185719.7af38a8a@jic23-huawei>
In-Reply-To: <20230311140218.74920-1-william.gray@linaro.org>
References: <20230311140218.74920-1-william.gray@linaro.org>
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

On Sat, 11 Mar 2023 09:02:18 -0500
William Breathitt Gray <william.gray@linaro.org> wrote:

> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

Trivial question inline about the includes changes, otherwise looks good to me.

I'm not that fussed about the includes if there is nothing else requiring
a v3, but obviously want to give it a little time for others to comment.

Jonathan

> ---
> Changes in v2:
>  - Remove DAC initialization to 0V in cio_dio_probe() as superfluous now
>    that the chan_out_states buffer is gone
> 
>  drivers/iio/dac/Kconfig   |  1 +
>  drivers/iio/dac/cio-dac.c | 66 ++++++++++++++++++++++++++-------------
>  2 files changed, 46 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index d3f90cf86143..3acd9c3f388e 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -277,6 +277,7 @@ config CIO_DAC
>  	tristate "Measurement Computing CIO-DAC IIO driver"
>  	depends on X86 && (ISA_BUS || PC104)
>  	select ISA_BUS_API
> +	select REGMAP_MMIO
>  	help
>  	  Say yes here to build support for the Measurement Computing CIO-DAC
>  	  analog output device family (CIO-DAC16, CIO-DAC08, PC104-DAC06). The
> diff --git a/drivers/iio/dac/cio-dac.c b/drivers/iio/dac/cio-dac.c
> index 791dd999cf29..759833a6bd29 100644
> --- a/drivers/iio/dac/cio-dac.c
> +++ b/drivers/iio/dac/cio-dac.c
> @@ -6,16 +6,15 @@
>   * This driver supports the following Measurement Computing devices: CIO-DAC16,
>   * CIO-DAC06, and PC104-DAC06.
>   */
> -#include <linux/bitops.h>
> +#include <linux/bits.h>

I'm not immediately spotting why this change is part of the regmap
conversion.

It may well make sense, but if unrelated, should probably be in a different patch.

>  #include <linux/device.h>
> -#include <linux/errno.h>
> +#include <linux/err.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/types.h>
> -#include <linux/io.h>
> -#include <linux/ioport.h>
>  #include <linux/isa.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> +#include <linux/regmap.h>
>  #include <linux/types.h>
>  
>  #define CIO_DAC_NUM_CHAN 16
> @@ -35,25 +34,51 @@ static unsigned int num_cio_dac;
>  module_param_hw_array(base, uint, ioport, &num_cio_dac, 0);
>  MODULE_PARM_DESC(base, "Measurement Computing CIO-DAC base addresses");
>  
> +#define CIO_DAC_BASE 0x00
> +#define CIO_DAC_CHANNEL_STRIDE 2
> +
> +static bool cio_dac_precious_reg(struct device *dev, unsigned int reg)
> +{
> +	/*
> +	 * All registers are considered precious; if the XFER jumper is set on
> +	 * the device, then no update occurs until a DAC register is read.
> +	 */
> +	return true;
> +}
> +
> +static const struct regmap_config cio_dac_regmap_config = {
> +	.reg_bits = 16,
> +	.reg_stride = 2,
> +	.val_bits = 16,
> +	.io_port = true,
> +	.max_register = 0x1F,
> +	.precious_reg = cio_dac_precious_reg,
> +};
> +
>  /**
>   * struct cio_dac_iio - IIO device private data structure
> - * @chan_out_states:	channels' output states
> - * @base:		base memory address of the DAC device
> + * @map: Regmap for the device
>   */
>  struct cio_dac_iio {
> -	int chan_out_states[CIO_DAC_NUM_CHAN];
> -	u16 __iomem *base;
> +	struct regmap *map;
>  };
>  
>  static int cio_dac_read_raw(struct iio_dev *indio_dev,
>  	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
>  {
>  	struct cio_dac_iio *const priv = iio_priv(indio_dev);
> +	const unsigned int offset = chan->channel * CIO_DAC_CHANNEL_STRIDE;
> +	int err;
> +	unsigned int dac_val;
>  
>  	if (mask != IIO_CHAN_INFO_RAW)
>  		return -EINVAL;
>  
> -	*val = priv->chan_out_states[chan->channel];
> +	err = regmap_read(priv->map, CIO_DAC_BASE + offset, &dac_val);
> +	if (err)
> +		return err;
> +
> +	*val = dac_val;
>  
>  	return IIO_VAL_INT;
>  }
> @@ -62,6 +87,7 @@ static int cio_dac_write_raw(struct iio_dev *indio_dev,
>  	struct iio_chan_spec const *chan, int val, int val2, long mask)
>  {
>  	struct cio_dac_iio *const priv = iio_priv(indio_dev);
> +	const unsigned int offset = chan->channel * CIO_DAC_CHANNEL_STRIDE;
>  
>  	if (mask != IIO_CHAN_INFO_RAW)
>  		return -EINVAL;
> @@ -70,10 +96,7 @@ static int cio_dac_write_raw(struct iio_dev *indio_dev,
>  	if ((unsigned int)val > 65535)
>  		return -EINVAL;
>  
> -	priv->chan_out_states[chan->channel] = val;
> -	iowrite16(val, priv->base + chan->channel);
> -
> -	return 0;
> +	return regmap_write(priv->map, CIO_DAC_BASE + offset, val);
>  }
>  
>  static const struct iio_info cio_dac_info = {
> @@ -92,7 +115,7 @@ static int cio_dac_probe(struct device *dev, unsigned int id)
>  {
>  	struct iio_dev *indio_dev;
>  	struct cio_dac_iio *priv;
> -	unsigned int i;
> +	void __iomem *regs;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
>  	if (!indio_dev)
> @@ -105,21 +128,22 @@ static int cio_dac_probe(struct device *dev, unsigned int id)
>  		return -EBUSY;
>  	}
>  
> -	priv = iio_priv(indio_dev);
> -	priv->base = devm_ioport_map(dev, base[id], CIO_DAC_EXTENT);
> -	if (!priv->base)
> +	regs = devm_ioport_map(dev, base[id], CIO_DAC_EXTENT);
> +	if (!regs)
>  		return -ENOMEM;
>  
> +	priv = iio_priv(indio_dev);
> +	priv->map = devm_regmap_init_mmio(dev, regs, &cio_dac_regmap_config);
> +	if (IS_ERR(priv->map))
> +		return dev_err_probe(dev, PTR_ERR(priv->map),
> +				     "Unable to initialize register map\n");
> +
>  	indio_dev->info = &cio_dac_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = cio_dac_channels;
>  	indio_dev->num_channels = CIO_DAC_NUM_CHAN;
>  	indio_dev->name = dev_name(dev);
>  
> -	/* initialize DAC outputs to 0V */
> -	for (i = 0; i < CIO_DAC_NUM_CHAN; i++)
> -		iowrite16(0, priv->base + i);
> -
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  
> 
> base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6

