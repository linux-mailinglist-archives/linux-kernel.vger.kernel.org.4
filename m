Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17F57204D9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbjFBOtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbjFBOtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:49:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8CEE49;
        Fri,  2 Jun 2023 07:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685717355; x=1717253355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YPUlxeS32cApP+ZDIUHR9khrq40A8i+TVQo/LyymAAg=;
  b=iSIFuCLsrzjIhWQBq0iHm1gHLZ5Fe81EIAgx/XJKBBeb5h4s9L/vuxNi
   sxbmnLW1Vnpkz3AhKgcybk4fgrK2BzmQ+6gqei9fF0FkGprGa9olHloGP
   xbX4agugBUo/X5HDCdot1VlKxug48zEhqKIluLCyE89uT7YoWFAMR3dwT
   YiFJ9I1SCjzWW4pXvbbWu+vcrodW4esE9qEgmGm+AmQvW+g9TyP3NlnQ/
   4FFQHCk5TwMl0rQbmioL314poFzQMNdXl10QfJc4pI33sR3WqYza4DiSN
   rNi+V4AieD9jdYVpu8Wv6UVZyzPUrz4tEzMO9KgE1ijDl4a/VnxI/bOWP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="353378802"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="353378802"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 07:49:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="772905903"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="772905903"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jun 2023 07:49:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q565Q-000fQj-0X;
        Fri, 02 Jun 2023 17:49:04 +0300
Date:   Fri, 2 Jun 2023 17:49:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Maksim Kiselev <bigunclemax@gmail.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/3] iio: adc: Add Allwinner D1/T113s/R329/T507 SoCs
 GPADC
Message-ID: <ZHoBXxM80aqvLZNt@smile.fi.intel.com>
References: <20230601223104.1243871-1-bigunclemax@gmail.com>
 <20230601223104.1243871-2-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601223104.1243871-2-bigunclemax@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 01:30:39AM +0300, Maksim Kiselev wrote:
> From: Maxim Kiselev <bigunclemax@gmail.com>
> 
> The General Purpose ADC (GPADC) can convert the external signal into
> a certain proportion of digital value, to realize the measurement of
> analog signal, which can be applied to power detection and key detection.
> 
> Theoretically, this ADC can support up to 16 channels. All SoCs below
> contain this GPADC IP. The only difference between them is the number
> of available channels:
> 
>  T113 - 1 channel
>  D1   - 2 channels
>  R329 - 4 channels
>  T507 - 4 channels

...

> +struct sun20i_gpadc_iio {
> +	struct regmap		*regmap;
> +	struct completion	completion;
> +	struct mutex		lock;

The locks should be explained (what are they for? what do they protect?).

> +	int			lastch;
> +};

...

> +static const struct regmap_config sun20i_gpadc_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.fast_io = true,

I forgot if I asked about regmap lock do you need it?

> +};

...

> +	if (!wait_for_completion_timeout(&info->completion,
> +					 msecs_to_jiffies(100))) {

Dunno if it's better to have this parameter to be defined with self-explanatory
name.

> +		ret = -ETIMEDOUT;
> +		goto err;
> +	}

...

> +err:

err_unlock:

> +	mutex_unlock(&info->lock);
> +
> +	return ret;

...

> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = sun20i_gpadc_adc_read(info, chan, val);
> +		return ret;

		return sun...;

> +	case IIO_CHAN_INFO_SCALE:
> +		/* value in mv = 1800mV / 4096 raw */
> +		*val = 1800;
> +		*val2 = 12;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}

...

> +	if (num_channels > SUN20I_GPADC_MAX_CHANNELS) {
> +		dev_err(dev, "num of channel children out of range");
> +		return -EINVAL;
> +	}

Is it really critical error?

...

> +	channels = devm_kcalloc(dev, num_channels,
> +				sizeof(*channels), GFP_KERNEL);

At least one more parameter can be located on the previous line.

> +	if (!channels)
> +		return -ENOMEM;

...

> +err_child_out:

err_put_child:

The goto labels should be self-explanatory of what to expect when goto.

> +	fwnode_handle_put(node);
> +
> +	return ret;

...

> +	ret = devm_request_irq(dev, irq, sun20i_gpadc_irq_handler,
> +			       0, dev_name(dev), info);
> +	if (ret < 0)

Here...

> +		return dev_err_probe(dev, ret,
> +				     "failed requesting irq %d\n", irq);

...

> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret < 0)

...and here, do the positive returned values even possible?

> +		return dev_err_probe(dev, ret,
> +				     "could not register the device\n");

...

> +	{ .compatible = "allwinner,sun20i-d1-gpadc", },

Inner comma is not needed.

-- 
With Best Regards,
Andy Shevchenko


