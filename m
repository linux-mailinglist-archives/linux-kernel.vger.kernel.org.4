Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB406C906B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 20:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCYTVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 15:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCYTVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 15:21:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD26137;
        Sat, 25 Mar 2023 12:21:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CD6460CF7;
        Sat, 25 Mar 2023 19:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D0AC433EF;
        Sat, 25 Mar 2023 19:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679772098;
        bh=6xCaygKTpM7f2IXd1A2Yon4aW1OSBIDkSxs37Hy1ziw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aW7yWjYzOyw6MWMqTSplKgJOnqiDxMG1L2e0Ddr30DjnMS0vltB9Tg/bMRgRJNvLT
         6KKgy5Ql1RpFFsA+XYQ+UfubLPAcdrRE4VM5iWNUHglCXyCMgiTWeajVvAYBpXBilE
         4kXcFTWBo0Obf8KoZcvSxvJVdDEoUWAD8rE7hU/fg5VxzqhQj95eoLou+aSvzH7vHA
         SOHxf8ODWrq3E4acFc4ymwJTxyqw8BYxLobnnvf1b3s/VfBWXw5EdNPwf1cKawhHqU
         dn7zm7mIcSt645xVQx6n85WdDF/64hcWQVnXOMJmK9MZVtC+1ger2GOqj2exYKd9ie
         ARXcwL90rn1Fg==
Date:   Sat, 25 Mar 2023 19:36:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Lee Jones <lee@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: max597x: Add support for max597x
Message-ID: <20230325193640.3dc8b330@jic23-huawei>
In-Reply-To: <20230323194550.1914725-1-Naresh.Solanki@9elements.com>
References: <20230323194550.1914725-1-Naresh.Solanki@9elements.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 20:45:48 +0100
Naresh Solanki <naresh.solanki@9elements.com> wrote:

> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> max597x has 10bit ADC for voltage & current monitoring.
> Use iio framework to expose the same in sysfs.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

I'm not a fan of wild cards in driver names. This doesn't
for example support the max5974, max5971 etc

Much better to name it after one of the supported parts.
Obviously can't do much about the mfd driver now, but I'd prefer
not to carry that through to the IIO driver if possible.

One concern I have here is that from the max5978 datasheet I see
this device supports features that are very much directed at hwmon
type usecases.  In particular warning and critical threshold detection.
We don't support multiple thresholds (in same direction) for a single
channel via IIO.  If you want those features in the future you may want
to consider using the hwmon subsystem.

We tend to be flexible with devices that sit near the boundary of IIO
and hwmon because we can bridge many of the features using the iio-hwmon
bridge driver.  That doesn't work for more complex event handling and
I suspect some of the other features this device provides.
  
> ...
> Changes in V2:
> - Remove fallthrough
> - Use pdev->dev instead of i2c->dev
> - Init indio_dev->name based on device type.
> ---
>  drivers/iio/adc/Kconfig       |  15 ++++
>  drivers/iio/adc/Makefile      |   1 +
>  drivers/iio/adc/max597x-iio.c | 152 ++++++++++++++++++++++++++++++++++
>  3 files changed, 168 insertions(+)
>  create mode 100644 drivers/iio/adc/max597x-iio.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 45af2302be53..0d1a3dea0b7d 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -735,6 +735,21 @@ config MAX1363
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called max1363.
>  
> +config MAX597X_IIO
> +	tristate "Maxim 597x power switch and monitor"
> +	depends on I2C && OF
> +	select MFD_MAX597X
> +	help
> +	  This driver enables support for the Maxim 597x smart switch and
> +	  voltage/current monitoring interface using the Industrial I/O (IIO)
> +	  framework. The Maxim 597x is a power switch and monitor that can
> +	  provide voltage and current measurements via the I2C bus. Enabling
> +	  this driver will allow user space applications to read the voltage
> +	  and current measurements using IIO interfaces.

Call out the actual part numbers supported in this help text to make it easy
to grep for them.

> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called max597x-iio.
> +

...


> +
> +static int max597x_iio_read_raw(struct iio_dev *iio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long info)
> +{
> +	int ret;
> +	struct max597x_iio *data = iio_priv(iio_dev);
> +	unsigned int reg_l, reg_h;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_read(data->regmap, chan->address, &reg_l);
> +		if (ret < 0)
> +			return ret;
> +		ret = regmap_read(data->regmap, chan->address - 1, &reg_h);
> +		if (ret < 0)
> +			return ret;
> +		*val = (reg_h << 2) | (reg_l & 3);

I replied late to previous patch, but I'd prefer to see a bulk read if
possible.  It might ensure a matched pair, or if not reduce the chance of
tearing (when reg_l & 3 transitions from 3 to 0 for example and
reg_h & 1 is going from 0 to 1)

You could try a repeated read if the sampling rate is fairly low as
simply getting same high bits on either side of the low bit read is probably
enough to say tearing didn't happen.

> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +
> +		switch (chan->address) {
> +		case MAX5970_REG_CURRENT_L(0):
> +		case MAX5970_REG_CURRENT_L(1):
> +			/* in A, convert to mA */
> +			*val = data->irng[chan->channel] * 1000;
> +			*val2 =
> +			    data->shunt_micro_ohms[chan->channel] * ADC_MASK;
Don't worry about 80 char limit when it hurts readability.  Just put that
on one line.

> +			return IIO_VAL_FRACTIONAL;
> +
> +		case MAX5970_REG_VOLTAGE_L(0):
> +		case MAX5970_REG_VOLTAGE_L(1):
> +			/* in uV, convert to mV */
> +			*val = data->mon_rng[chan->channel];
> +			*val2 = ADC_MASK * 1000;
> +			return IIO_VAL_FRACTIONAL;
> +		}
> +
> +		break;
> +	}
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info max597x_adc_iio_info = {
> +	.read_raw = &max597x_iio_read_raw,
> +};
> +
> +static int max597x_iio_probe(struct platform_device *pdev)
> +{
> +	struct max597x_data *max597x = dev_get_drvdata(pdev->dev.parent);
> +	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	struct iio_dev *indio_dev;
> +	struct max597x_iio *priv;
> +	int ret, i;
> +
> +	if (!regmap)
> +		return -EPROBE_DEFER;
> +
> +	if (!max597x || !max597x->num_switches)
> +		return -EPROBE_DEFER;
> +
> +	/* registering iio */

Comment doesn't add anything is is wrong anyway as this doesn't do the
majority of the registration. Dropt he comment.

> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
> +	if (!indio_dev)
> +		return dev_err_probe(&pdev->dev, -ENOMEM,
> +				     "failed to allocate iio device\n");

...

