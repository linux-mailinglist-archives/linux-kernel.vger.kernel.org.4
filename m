Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1A9632522
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiKUOIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiKUOIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:08:19 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F97C8444;
        Mon, 21 Nov 2022 06:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669039514; x=1700575514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oQ4BuIaE2yQcAUXa3vjBTCtBIRldNoclxLo47VLLwug=;
  b=AbeYbsEzFZWzdTBEJI3QlvvXT3PFyw9VCr98E6J0dXdEbdpAkYp7IycB
   jtprMxM43kTTxm7VBQ0ztH3a8LPGX8Omz/UuRbpF757Tf+JQgQevpqes3
   C+85leEFYLa20CBI4KqpJeRLmHBnwdI6UITQEiWhnTYmtX79tQWf7Dvmy
   r4iddvA7mtXX4oeIw8j8re4JEuvbpAf/d523vvbSXbII4KsgkyZ9BwFJE
   K95q0jMZBupQt/rgnXpXMte0gifN3rlQ2JEYw0foXxN8KCDy+pxb7CS2D
   n15LyZ4suFW0b3mVStx4bwn84CHbF+NYVy+6yXpKZg4XHuOIHHhw+Pehl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="293270439"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="293270439"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 06:04:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="730015249"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="730015249"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Nov 2022 06:04:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ox7P6-00FIlf-1A;
        Mon, 21 Nov 2022 16:04:08 +0200
Date:   Mon, 21 Nov 2022 16:04:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gerald Loacker <gerald.loacker@wolfvision.net>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH v2 2/2] iio: magnetometer: add ti tmag5273 driver
Message-ID: <Y3uFWH5GV/x7UDcP@smile.fi.intel.com>
References: <20221121123542.1322367-1-gerald.loacker@wolfvision.net>
 <20221121123542.1322367-3-gerald.loacker@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121123542.1322367-3-gerald.loacker@wolfvision.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 01:35:42PM +0100, Gerald Loacker wrote:
> Add support for TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor.
> Additionally to temperature and magnetic X, Y and Z-axes the angle and
> magnitude are reported.
> The sensor is operating in continuous measurement mode and changes to sleep
> mode if not used for 5 seconds.

Thank you for an update! My comments below.
(I believe the next version will be ready for inclusion)

...

> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/pm_runtime.h>

+ Blank line (to make below as an explicit group of headers)

> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

...

> +/*
> + * bits in the TMAG5273_MANUFACTURER_ID_LSB / MSB register
> + * 16-bit read-only unique manufacturer ID

Is it ASCII or not? ('TI' suggests something...)
If it is, please put it in the comments explicitly in ASCII.

> + */
> +#define TMAG5273_MANUFACTURER_ID	 0x5449

...

> +#define TMAG5273_MAG_CH_EN_X_Y_Z	 0x07

This is hexadecimal, while below you are using decimal values.
Also if this is like above, isn't it a bit mask? (Otherwise
using decimal value hints that it's probably not)

...

> +#define TMAG5273_ANGLE_EN_OFF		 0
> +#define TMAG5273_ANGLE_EN_X_Y		 1
> +#define TMAG5273_ANGLE_EN_Y_Z		 2
> +#define TMAG5273_ANGLE_EN_X_Z		 3

...

> +	/*
> +	 * Locks the sensor for exclusive use during a measurement (which
> +	 * involves several register transactions so the regmap lock is not
> +	 * enough) so that measurements get serialized in a first-come-first-
> +	 * serve manner.

It will be better to have 'first-come-first-serve' non-broken between lines.

> +	 */

> +/*
> + * Magnetic resolution in Gauss for different TMAG5273 versions.
> + * Scale[Gauss] = Range[mT] * 1000 / 2^15 * 10, (1 mT = 10 Gauss)
> + * Only version 1 and 2 are valid, version 0 and 3 are reserved.
> + */

...

> +static const struct {
> +	unsigned int scale_int;
> +	unsigned int scale_micro;

Can we have a separate patch to define this one eventually in the (one of) IIO
generic headers? It's a bit pity that every new driver seems to reinvent the
wheel.

> +} tmag5273_scale_table[4][2] = {
> +	{ { 0, 0 }, { 0, 0 } },
> +	{ { 0, 12200 }, { 0, 24400 } },
> +	{ { 0, 40600 }, { 0, 81200 } },
> +	{ { 0, 0 }, { 0, 0 } },
> +};

You probably can reformat there to have fixed-width columns to see better the
pairs of the values. And as I told you before, 4 is not needed (AFAIR, or 2 in
the square brackets).

...

> +	ret = regmap_bulk_read(data->map, TMAG5273_ANGLE_RESULT_MSB, reg_data,
> +			       sizeof(reg_data[0]));

This is strange. The sizeof of a single element is 2, while you define a
pointer to the entire array.

So, the

	ret = regmap_bulk_read(data->map, TMAG5273_ANGLE_RESULT_MSB, &reg_data[0],
			       sizeof(reg_data[0]));

will show better the intention.

...

> +			*length = ARRAY_SIZE(
> +				       tmag5273_scale_table[data->version]) * 2;

Ugly indentation. Better

			*length =
				ARRAY_SIZE(tmag5273_scale_table[data->version]) * 2;

or

			*length = 2 *
				ARRAY_SIZE(tmag5273_scale_table[data->version]);

...

> +		ret = tmag5273_get_measure(data, &t, &x, &y, &z, &angle,
> +					   &magnitude);

I would use one line for this, but it's up to you (I think that Jonathan
wouldn't mind either choice).

...

> +	default:
> +		/* Unknown request */

Useless comment ?

> +		return -EINVAL;
> +	}

...

> +			for (i = 0; i < ARRAY_SIZE(tmag5273_scale_table[0]);
> +			     i++) {

I would definitely go with one line here.

> +				if (tmag5273_scale_table[data->version][i]
> +					    .scale_micro == val2)

Ugly indentation.

> +					break;
> +			}

...

> +			ret = regmap_update_bits(

Try to reformat all these left open parentheses.

> +				data->map, TMAG5273_SENSOR_CONFIG_2,
> +				TMAG5273_Z_RANGE_MASK | TMAG5273_X_Y_RANGE_MASK,
> +				data->scale_index == MAGN_LOW ? 0 :
> +					(TMAG5273_Z_RANGE_MASK |
> +					 TMAG5273_X_Y_RANGE_MASK));

Do you need parentheses here?

...

> +#define TMAG5273_AXIS_CHANNEL(axis, index)                                   \
> +	{                                                                    \
> +		.type = IIO_MAGN,                                            \
> +		.modified = 1,                                               \
> +		.channel2 = IIO_MOD_##axis,                                  \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |               \
> +				      BIT(IIO_CHAN_INFO_SCALE),              \
> +		.info_mask_shared_by_type_available =                        \
> +				      BIT(IIO_CHAN_INFO_SCALE),              \
> +		.info_mask_shared_by_all =                                   \
> +				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
> +		.info_mask_shared_by_all_available =                         \
> +				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
> +		.address = index,                                            \
> +		.scan_index = index,                                         \
> +		.scan_type = {                                               \
> +			.sign = 's',                                         \
> +			.realbits = 16,                                      \
> +			.storagebits = 16,                                   \
> +			.endianness = IIO_CPU,                               \
> +		},                                                           \
> +	}

Why not using TABs for the formatting trailing \:s?

...

> +	if (!device_property_read_string(data->dev, "ti,angle-measurement",
> +					 &angle_measurement)) {
> +		if (!strcmp(angle_measurement, "off"))
> +			data->angle_measurement = TMAG5273_ANGLE_EN_OFF;
> +		else if (!strcmp(angle_measurement, "x-y"))
> +			data->angle_measurement = TMAG5273_ANGLE_EN_X_Y;
> +		else if (!strcmp(angle_measurement, "y-z"))
> +			data->angle_measurement = TMAG5273_ANGLE_EN_Y_Z;
> +		else if (!strcmp(angle_measurement, "x-z"))
> +			data->angle_measurement = TMAG5273_ANGLE_EN_X_Z;
> +		else
> +			dev_warn(data->dev,
> +				 "failed to read angle-measurement\n");

Can't you use match_string()?

And you actually can do a bit differently, can you?

	angle_measurement = "...default...";
	if (device_property_...)
		dev_warn(data->dev, "failed to read angle-measurement\n");
	ret = match_string();
	if (ret < 0)
		dev_warn(data->dev, "invalid angle-measurement value\n");
	else
		data->angle_measurement = ret;

> +	}

...

> +	switch (data->devid) {
> +	case TMAG5273_MANUFACTURER_ID:
> +		snprintf(data->name, sizeof(data->name), "tmag5273x%1u",

There is a difference between %1u and %.1u. And I believe you wanted the
latter, but...

> +			 data->version);
> +		if (data->version < 1 || data->version > 2)
> +			dev_warn(data->dev, "Unsupported device version 0x%x\n",
> +				 data->version);

...with the current approach you may replace above with

			dev_warn(data->dev, "Unsupported device %s\n", data->name);

> +		break;
> +	default:
> +		dev_warn(data->dev, "Unknown device ID 0x%x\n", data->devid);
> +		break;
> +	}

...

> +	struct iio_dev *indio_dev;
> +	struct device *dev = &i2c->dev;
> +	struct tmag5273_data *data;
> +	int ret;

In reversed xmas tree order it would look a bit better:

	struct device *dev = &i2c->dev;
	struct tmag5273_data *data;
	struct iio_dev *indio_dev;
	int ret;

-- 
With Best Regards,
Andy Shevchenko


