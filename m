Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4416166AC81
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 17:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjANQPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 11:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjANQPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 11:15:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C69193E2;
        Sat, 14 Jan 2023 08:15:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE021B80927;
        Sat, 14 Jan 2023 16:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C809CC433EF;
        Sat, 14 Jan 2023 16:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673712904;
        bh=1onBvZ37BqCGFzArmhBQuOyLEAPKwdxBLbeO+5RsKO4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XK+Dn+j5HQ4ca2WN1zwqnb4Q810WDEvmNLtKecGVTaYhnPehJYYfnuMwoXIh4k477
         tdQtO7FM4LnDnMKOktFjGpItYWzoogYhJgR9SAo1exOcTL7lYef7XNgFaq7kLtMOnr
         hDssJ1ezAJtKQxS4DJtZIAkJQbMgL+jPOT2V6e7DGslnfTiUUH/Z3h/2Ml/uUDYvgH
         bpKEHLHVOswwFfVr5KJgFgOv7R+tfeciEu2f4zEujStDCKZzCA2Ff31VGepZ2pZnze
         lguh1HcWRfkin3DaRlAOMBVSqhPdGecNhaRMTihiMKoi3Iu+h1PyBL7a7uEfyEvKps
         mT3z8kbGTgFKw==
Date:   Sat, 14 Jan 2023 16:28:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     hvilleneuve@dimonoff.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: adc: ti-ads7924: add Texas Instruments
 ADS7924 driver
Message-ID: <20230114162841.41358640@jic23-huawei>
In-Reply-To: <20230113194959.3276433-2-hugo@hugovil.com>
References: <20230113194959.3276433-1-hugo@hugovil.com>
        <20230113194959.3276433-2-hugo@hugovil.com>
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

On Fri, 13 Jan 2023 14:49:58 -0500
Hugo Villeneuve <hugo@hugovil.com> wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> The Texas Instruments ADS7924 is a 4 channels, 12-bit analog to
> digital converter (ADC) with an I2C interface.
> 
> Datasheet: https://www.ti.com/lit/gpn/ads7924

This counts as a normal tag, so there shouldn't be blank line between
it and the SOB.

A few other small things inline noticed on this read through.
I can fix these up whilst applying if nothing else comes up for v3
and DT binding reviewers are happy.  If you are doing a v4 for
other reasons, please address these comments in that.

Jonathan



> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
...
> diff --git a/drivers/iio/adc/ti-ads7924.c b/drivers/iio/adc/ti-ads7924.c
> new file mode 100644
> index 000000000000..c24fae4ef8e0
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads7924.c
> @@ -0,0 +1,474 @@

...

> +static int ads7924_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	int ret, vref_uv;
> +	struct ads7924_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&data->lock);
> +		ret = ads7924_get_adc_result(data, chan, val);
> +		mutex_unlock(&data->lock);
> +		if (ret < 0)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		vref_uv = regulator_get_voltage(data->vref_reg);
> +		if (vref_uv < 0)
> +			return -EINVAL;

Better to return the error value from regulator_get_voltage() rather
than replace it with -EINVAL.

> +
> +		*val =  vref_uv / 1000; /* Convert reg voltage to mV */
> +		*val2 = ADS7924_BITS;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info ads7924_info = {
> +	.read_raw = ads7924_read_raw,
> +};
> +
> +static int ads7924_get_channels_config(struct i2c_client *client,
> +				       struct iio_dev *indio_dev)
> +{
> +	struct ads7924_data *priv = iio_priv(indio_dev);
> +	struct device *dev = priv->dev;
> +	struct fwnode_handle *node;
> +	int num_channels = 0;
> +
> +	device_for_each_child_node(dev, node) {
> +		u32 pval;
> +		unsigned int channel;
> +
> +		if (fwnode_property_read_u32(node, "reg", &pval)) {
> +			dev_err(dev, "invalid reg on %pfw\n", node);
> +			continue;
> +		}
> +
> +		channel = pval;
> +		if (channel >= ADS7924_CHANNELS) {
> +			dev_err(dev, "invalid channel index %d on %pfw\n",
> +				channel, node);
> +			continue;
> +		}
> +
> +		num_channels++;
> +	}
> +
> +	if (num_channels <= 0)

How would it be less than 0?  if (!num_channels) works fine I think.

> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int ads7924_set_conv_mode(struct ads7924_data *data, int mode)
> +{
> +	int ret;
> +	unsigned int mode_field;
> +	struct device *dev = data->dev;
> +
> +	/*
> +	 * When switching between modes, be sure to first select the Awake mode
> +	 * and then switch to the desired mode. This procedure ensures the
> +	 * internal control logic is properly synchronized.
> +	 */
> +	if (mode != ADS7924_MODECNTRL_IDLE) {
> +		mode_field = FIELD_PREP(ADS7924_MODECNTRL_MODE_MASK,
> +					ADS7924_MODECNTRL_AWAKE);
> +
> +		ret = regmap_update_bits(data->regmap, ADS7924_MODECNTRL_REG,
> +					 ADS7924_MODECNTRL_MODE_MASK,
> +					 mode_field);
> +		if (ret) {
> +			dev_warn(dev, "failed to set awake mode (%pe)\n",
> +				 ERR_PTR(ret));

As below.

> +			return ret;
> +		}
> +	}
> +
> +	mode_field = FIELD_PREP(ADS7924_MODECNTRL_MODE_MASK, mode);
> +
> +	ret = regmap_update_bits(data->regmap, ADS7924_MODECNTRL_REG,
> +				 ADS7924_MODECNTRL_MODE_MASK, mode_field);
> +	if (ret)
> +		dev_warn(dev, "failed to set mode %d (%pe)\n", mode,
> +			 ERR_PTR(ret));

Why warning? Seems like a fairly critical error to me.
dev_err() more appropriate perhaps.

> +
> +	return ret;
> +}
> +

