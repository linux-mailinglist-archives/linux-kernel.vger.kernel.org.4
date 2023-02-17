Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4904E69AB8B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 13:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjBQMa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 07:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjBQMaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 07:30:23 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F0C6604B;
        Fri, 17 Feb 2023 04:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676637022; x=1708173022;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uB5GE4aij19r/69QX6c+gXXG7g+WqFcxiBif/JrCZgk=;
  b=nooexdakomLcn2QsFRSD9Z1r3VRZWHbWxnIwkZ9MSdlxxTEBaWpcNseW
   N5X/rOJL3Oxt/C4Yin6GMiMB9tY91YscMXcXqurgSf2ixUX5/mRXQ7MHJ
   A8N3Ne4LFDxD6Q2oWNkmo0WjSbsHfp2Aq8mTcRF+I09A34nijdpLdx4wL
   MBdWYDFvFuRXOQGNk+y8RNT3Ggnj4TwZP1SILZKMaRyh4CFmmOhUaOqro
   EUsGHYomjZaZt0tIB4CxLQNFjjNWETIzMLCQn5nUgDfQwJNnSy1x5Fs/9
   yEOU3zHGXgNjKReBroYn5ervMLeDt1fHCrhD1YhzPMAw0Xw4P3VzrIjFl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="394452589"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="394452589"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 04:30:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="700889417"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="700889417"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 17 Feb 2023 04:30:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pSzsF-008CTf-2C;
        Fri, 17 Feb 2023 14:29:59 +0200
Date:   Fri, 17 Feb 2023 14:29:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: Add driver for TI ADS1100 and ADS1000 chips
Message-ID: <Y+9zR3bhlEMuma66@smile.fi.intel.com>
References: <20230217093128.8344-1-mike.looijmans@topic.nl>
 <20230217093128.8344-2-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217093128.8344-2-mike.looijmans@topic.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 10:31:28AM +0100, Mike Looijmans wrote:
> The ADS1100 is a 16-bit ADC (at 8 samples per second).
> The ADS1000 is similar, but has a fixed data rate.

Any Datasheet link available?

> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

...

> +#define ADS1100_DR_MASK		(BIT(3) | BIT(2))

GENMASK()

...

> +#define ADS1100_PGA_MASK	(BIT(1) | BIT(0))

Ditto.

...

> +static const int ads1100_data_rate[] = {128, 32, 16, 8};
> +static const int ads1100_data_rate_scale[] = {2048, 8192, 16384, 32768};
> +static const int ads1100_gain[] = {1, 2, 4, 8};

Do you need all of them as tables? They all can be derived from a single table
or without any table at all (just three values).

...

> +static const struct iio_chan_spec ads1100_channel = {
> +	.type = IIO_VOLTAGE,

> +	.differential = 0,
> +	.indexed = 0,

No need.

> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	.info_mask_shared_by_all =
> +				BIT(IIO_CHAN_INFO_SCALE) |
> +				BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.info_mask_shared_by_all_available =
> +				BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.scan_type = {
> +		.sign = 's',
> +		.realbits = 16,
> +		.storagebits = 16,

> +		.shift = 0,

No need.

> +		.endianness = IIO_CPU,
> +	},
> +	.datasheet_name = "AIN",
> +};

...

> +	u8 config = (data->config & ~mask) | value;

Traditional pattern is

	u8 config = (data->config & ~mask) | (value & mask);


> +#ifdef CONFIG_PM

Why?

> +static int ads1100_set_power_state(struct ads1100_data *data, bool on)
> +{
> +	int ret;
> +	struct device *dev = &data->client->dev;
> +
> +	if (on) {
> +		ret = pm_runtime_resume_and_get(dev);
> +	} else {
> +		pm_runtime_mark_last_busy(dev);

> +		ret = pm_runtime_put_autosuspend(dev);

Yes, in !CONFIG_PM this will return an error, but why do you care?

> +	}
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +#else /* !CONFIG_PM */
> +
> +static int ads1100_set_power_state(struct ads1100_data *data, bool on)
> +{
> +	return 0;
> +}
> +
> +#endif /* !CONFIG_PM */

...

> +static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int *val)
> +{
> +	int ret;

> +	u8 buffer[2];

__be16 buffer;

> +
> +	if (chan != 0)
> +		return -EINVAL;
> +
> +	ret = i2c_master_recv(data->client, buffer, sizeof(buffer));
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> +		return ret;
> +	}
> +
> +	*val = (s16)(((u16)buffer[0] << 8) | buffer[1]);

	(s16)be16_to_cpu();

But (s16) looks suspicious. Should you use sign_extend32()?

> +	return 0;
> +}

...

> +static int ads1100_set_gain(struct ads1100_data *data, int gain)
> +{

> +	int i;

unsigned

> +	for (i = 0; i < ARRAY_SIZE(ads1100_gain); ++i) {

Pre-increment in the loops is non-standard in the kernel.
Why do you need that?

> +		if (ads1100_gain[i] == gain) {
> +			return ads1100_set_config_bits(
> +						data, ADS1100_PGA_MASK, i);

Strange indentation.

> +		}
> +	}
> +
> +	return -EINVAL;
> +}

...

> +static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)

Same comments as per above.

...

> +	dev_info(&data->client->dev, "%s %ld\n", __func__, mask);

Useless noise in the logs.

...

> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to register IIO device\n");
> +		return ret;

return dev_err_probe();

> +	}

...

> +#ifdef CONFIG_PM

Drop it and use proper macros below.

> +#endif

...

> +static const struct dev_pm_ops ads1100_pm_ops = {
> +	SET_RUNTIME_PM_OPS(ads1100_runtime_suspend,
> +			   ads1100_runtime_resume, NULL)
> +};

...here and...

...

> +		.pm = &ads1100_pm_ops,

...here.

...

> +

Redundant blank line.

> +module_i2c_driver(ads1100_driver);

-- 
With Best Regards,
Andy Shevchenko


