Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71826ABFEB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCFMxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCFMxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:53:04 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3005E3B4;
        Mon,  6 Mar 2023 04:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678107182; x=1709643182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RbKUHtHzcKHVa59ymAsKJF2jSVbjpn2iBY52eRzH2p4=;
  b=GnBUpgwwkvr33IEOOGciE07Huly5SYOsWR4O9mo7QQ7YQ2sX99DzZT3R
   IGYfKPOU/tZ46vlywZixRCr+8rARDimYattgcLEBMDPrf7RsY3b5T0c84
   in/4U54Un42Gf9uEW6TpooqdhbSEELTMCJH+aOr/Krp0GhAbS4UxBnl6K
   P5PC69QKoff8Ge/0E5+kKdL48LD9C8+NQPhUC88D5eQDHwbAkjm41XGFK
   3Icr4T1eJrB2AchlF3mj6qPRkFBynnMtsSTICEAIeeLLRV9A2enzhPbRP
   mV38x2N/k9ywvcLnjcR3jNn37aGIxmAvzimsvXeC+NAd1/kHlJM9RbA4P
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="421815526"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="421815526"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 04:53:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="708640569"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="708640569"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 06 Mar 2023 04:52:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pZAKn-00GM8k-1w;
        Mon, 06 Mar 2023 14:52:57 +0200
Date:   Mon, 6 Mar 2023 14:52:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
Message-ID: <ZAXiKfRbsXpHhwAJ@smile.fi.intel.com>
References: <cover.1678093787.git.mazziesaccount@gmail.com>
 <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 11:17:15AM +0200, Matti Vaittinen wrote:
> Some light sensors can adjust both the HW-gain and integration time.
> There are cases where adjusting the integration time has similar impact
> to the scale of the reported values as gain setting has.
> 
> IIO users do typically expect to handle scale by a single writable 'scale'
> entry. Driver should then adjust the gain/time accordingly.
> 
> It however is difficult for a driver to know whether it should change
> gain or integration time to meet the requested scale. Usually it is
> preferred to have longer integration time which usually improves
> accuracy, but there may be use-cases where long measurement times can be
> an issue. Thus it can be preferable to allow also changing the
> integration time - but mitigate the scale impact by also changing the gain
> underneath. Eg, if integration time change doubles the measured values,
> the driver can reduce the HW-gain to half.
> 
> The theory of the computations of gain-time-scale is simple. However,
> some people (undersigned) got that implemented wrong for more than once.
> 
> Add some gain-time-scale helpers in order to not dublicate errors in all
> drivers needing these computations.

...

> +/*

If it's deliberately not a kernel doc, why to bother to have it looking as one?
It's really a provocative to some people who will come with a patches to "fix"
this...

> + * iio_gts_get_gain - Convert scale to total gain
> + *
> + * Internal helper for converting scale to total gain.
> + *
> + * @max:	Maximum linearized scale. As an example, when scale is created
> + *		in magnitude of NANOs and max scale is 64.1 - The linearized
> + *		scale is 64 100 000 000.
> + * @scale:	Linearized scale to compte the gain for.
> + *
> + * Return:	(floored) gain corresponding to the scale. -EINVAL if scale
> + *		is invalid.
> + */
> +static int iio_gts_get_gain(const u64 max, const u64 scale)
> +{
> +	int tmp = 1;
> +
> +	if (scale > max || !scale)
> +		return -EINVAL;
> +
> +	if (U64_MAX - max < scale) {
> +		/* Risk of overflow */
> +		if (max - scale < scale)
> +			return 1;

> +		while (max - scale > scale * (u64)tmp)
> +			tmp++;
> +
> +		return tmp + 1;

Can you wait for the comments to appear a bit longer, please?
I have answered to your query in the previous discussion.

> +	}
> +
> +	while (max > scale * (u64) tmp)

No space for castings?

> +		tmp++;
> +
> +	return tmp;
> +}

...

> +	/*
> +	 * Expect scale to be (mostly) NANO or MICRO. Divide divider instead of
> +	 * multiplication followed by division to avoid overflow

Missing period.

> +	 */
> +	if (scaler > NANO || !scaler)
> +		return -EINVAL;

Shouldn't be OVERFLOW for the first one?

...

> +	*lin_scale = (u64) scale_whole * (u64)scaler +

No space for casting?

> +		     (u64)(scale_nano / (NANO / scaler));

...

> +EXPORT_SYMBOL_NS_GPL(iio_gts_total_gain_to_scale, IIO_GTS_HELPER);

I would say _HELPER part is too much, but fine with me.

...

> +	ret = iio_gts_linearize(max_scale_int, max_scale_nano, NANO,
> +				   &gts->max_scale);
> +	if (ret)
> +		return ret;
> +
> +	gts->hwgain_table = gain_tbl;
> +	gts->num_hwgain = num_gain;
> +	gts->itime_table = tim_tbl;
> +	gts->num_itime = num_times;
> +	gts->per_time_avail_scale_tables = NULL;
> +	gts->avail_time_tables = NULL;
> +	gts->avail_all_scales_table = NULL;
> +	gts->num_avail_all_scales = 0;

Just wondering why we can't simply

	memset(0)

beforehand and drop all these 0 assignments?

...

> +		/*
> +		 * Sort the tables for nice output and for easier finding of
> +		 * unique values

Missing period. Please, check the style of multi-line comments. I believe it's
even mentioned in the documentation.

> +		 */

...

> +		sort(gains[i], gts->num_hwgain, sizeof(int), iio_gts_gain_cmp,
> +		     NULL);

One line reads better?

...

> +	if (ret && gts->avail_all_scales_table)

In one case you commented that free(NULL) is okay, in the other, you add
a duplicative check. Why?

> +		kfree(gts->avail_all_scales_table);

...

> +	per_time_gains = kcalloc(gts->num_itime, sizeof(int *), GFP_KERNEL);

sizeof(type) is error prone in comparison to sizeof(*var).

> +	if (!per_time_gains)
> +		return ret;
> +
> +	per_time_scales = kcalloc(gts->num_itime, sizeof(int *), GFP_KERNEL);

Ditto.

> +	if (!per_time_scales)
> +		goto free_gains;

...

> +err_free_out:
> +	while (i) {
> +		/*
> +		 * It does not matter if i'th alloc was not succesfull as
> +		 * kfree(NULL) is safe.
> +		 */

Instead, can be just a free of the known allocated i:th member first followed
by traditional pattern. In that case comment will become redundant.

> +		kfree(per_time_scales[i]);
> +		kfree(per_time_gains[i]);
> +
> +		i--;
> +	}

...

> +	for (i = gts->num_itime - 1; i >= 0; i--) {

	while (i--) {

makes it easier to parse.

> +/**
> + * iio_gts_all_avail_scales - helper for listing all available scales
> + * @gts:	Gain time scale descriptor
> + * @vals:	Returned array of supported scales
> + * @type:	Type of returned scale values
> + * @length:	Amount of returned values in array
> + *
> + * Returns a value suitable to be returned from read_avail or a negative error

Missing a return section. Have you run kernel doc to validate this?
Missing period.

Seems these problems occur in many function descriptions.

> + */

...

> +	/*
> +	 * Using this function prior building the tables is a driver-error
> +	 * which should be fixed when the driver is tested for a first time

Missing period.

> +	 */
> +	if (WARN_ON(!gts->num_avail_all_scales))

Does this justify panic? Note, that any WARN() can become an Oops followed by
panic and reboot.

> +		return -EINVAL;

...

> +	for (i = 0; i < gts->num_hwgain; i++) {
> +		/*
> +		 * It is not expected this function is called for an exactly
> +		 * matching gain.
> +		 */
> +		if (unlikely(gain == gts->hwgain_table[i].gain)) {
> +			*in_range = true;
> +			return gain;
> +		}

> +		if (!min)
> +			min = gts->hwgain_table[i].gain;
> +		else
> +			min = min(min, gts->hwgain_table[i].gain);

I was staring at this and have got no clue why it's not a dead code.

> +		if (gain > gts->hwgain_table[i].gain) {
> +			if (!diff) {
> +				diff = gain - gts->hwgain_table[i].gain;
> +				best = i;
> +			} else {
> +				int tmp = gain - gts->hwgain_table[i].gain;
> +
> +				if (tmp < diff) {
> +					diff = tmp;
> +					best = i;
> +				}
> +			}

			int tmp = gain - gts->hwgain_table[i].gain;

			if (!diff || tmp < diff) {
				diff = tmp;
				best = i;
			}

?

Or did you miss using 'min'? (And I'm wondering how variable name and min()
macro are not conflicting with each other.

> +		} else {
> +			/*
> +			 * We found valid hwgain which is greater than
> +			 * reference. So, unless we return a failure below we
> +			 * will have found an in-range gain
> +			 */
> +			*in_range = true;
> +		}
> +	}
> +	/* The requested gain was smaller than anything we support */
> +	if (!diff) {
> +		*in_range = false;
> +
> +		return -EINVAL;
> +	}
> +
> +	return gts->hwgain_table[best].gain;

...

> +	ret = iio_gts_get_scale_linear(gts, old_gain, itime_old->time_us,
> +				       &scale);

Still can be one line.

> +	if (ret)
> +		return ret;
> +
> +	ret = gain_get_scale_fraction(gts->max_scale, scale, itime_new->mul,
> +				      new_gain);

Ditto.

> +	if (ret)
> +		return -EINVAL;

...

> +++ b/drivers/iio/light/iio-gts-helper.h

Is it _only_ for a Light type of sensors?

...

> +#ifndef __IIO_GTS_HELPER__
> +#define __IIO_GTS_HELPER__

If yes, perhaps adding LIGHT here?

-- 
With Best Regards,
Andy Shevchenko


