Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407CB6A84DE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjCBPFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjCBPFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:05:34 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE10303C2;
        Thu,  2 Mar 2023 07:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677769530; x=1709305530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KK4AIe+7Vv+aU8wHv4HOjgFbzka6y1VpUbQbhpno2LI=;
  b=MbWsoHfuNhBaUSAI6z/ClFYhn00SeXPumsNHzTbit9esGm6C1PTeeb/R
   2gFKlJ5lq4yaivRzesJvDSqYQKgqXOxV2HyWrrEyOFsYYETtuefiTmG7a
   IrwQjWdp9DqvtXdPINxM+vm5xor3KUL7ODplA0+Bw5k7pTUIBM4pyWPJS
   aqI9+PjEtBmwyorr5qJGMKrW4I3iesvkZTIFev+XI+epvneGbhO1LNEO+
   w6EGOFNEBPKx0GJrQv6+9KntvCYbhRhCQF1nMy+QGWOsMHg1ZrKvz2aP5
   zwYDYTue6O9FFQRyiVSXBYfPo+Y3DNX6ci+bE4YrRsfUVQxL85VMfyhs3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="421002703"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="421002703"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 07:05:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="705297979"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="705297979"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 02 Mar 2023 07:05:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pXkUh-00EOgw-2R;
        Thu, 02 Mar 2023 17:05:19 +0200
Date:   Thu, 2 Mar 2023 17:05:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: light: Add gain-time-scale helpers
Message-ID: <ZAC7L8NQYgBcBTCF@smile.fi.intel.com>
References: <cover.1677750859.git.mazziesaccount@gmail.com>
 <9895826669118a1aa1db3f85c2610fa759426c33.1677750859.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9895826669118a1aa1db3f85c2610fa759426c33.1677750859.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 12:57:54PM +0200, Matti Vaittinen wrote:
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

Is it intentionally _not_ a kernel doc?

> + * iio_gts_get_gain - Convert scale to total gain

> + * Internal helper for converting scale to total gain.

Otherwise this line should go after the fields, I remember kernel doc warnings
on the similar cases.

> + * @max:	Maximum linearized scale. As an example, when scale is creted in

creted?

IIRC I already pointed out to the very same mistake in your code in the past
(sorry, if my memory doesn't serve me well).

> + *		magnitude of NANOs and max scale is 64.1 - The linearized
> + *		scale is 64 100 000 000.
> + * @scale:	Linearized scale to compte the gain for.
> + *
> + * Return:	(floored) gain corresponding to the scales. -EINVAL if scale

scales? (Plural?)

> + *		is invalid.
> + */

Same remark to all of the comments.

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

> +		while (max - scale > scale * (u64) tmp)

Space is not required after casting.

> +			tmp++;
> +
> +		return tmp + 1;

Wondering why you can't simplify this to

		max -= scale;
		tmp++;

> +	}
> +
> +	while (max > scale * (u64) tmp)
> +		tmp++;
> +
> +	return tmp;
> +}

Missing blank line.

> +/*
> + * gain_get_scale_fraction - get the gain or time based on scale and known one
> + *
> + * Internal helper for computing unknown fraction of total gain.
> + * Compute either gain or time based on scale and either the gain or time
> + * depending on which one is known.
> + *
> + * @max:	Maximum linearized scale. As an example, when scale is creted in

creted?

Is it mistakenly stored in your spellcheck database? Or is it simply
copy'n'paste typo?

> + *		magnitude of NANOs and max scale is 64.1 - The linearized
> + *		scale is 64 100 000 000.
> + * @scale:	Linearized scale to compute the gain/time for.
> + * @known:	Either integration time or gain depending on which one is known
> + * @unknown:	Pointer to variable where the computed gain/time is stored
> + *
> + * Return:	0 on success
> + */

...

> +static const struct iio_itime_sel_mul *
> +			iio_gts_find_itime_by_time(struct iio_gts *gts, int time)

Strange indentation.

Ditto for all these types of cases.

...

> +	*lin_scale = (u64) scale_whole * (u64)scaler + (u64)(scale_nano
> +		     / (NANO / scaler));

Strange indentation. Split on the logical (math) parts better.

...

> +EXPORT_SYMBOL_GPL(iio_init_iio_gts);

I haven't noticed if you put these all exports into a proper namespace.
If no, please do.

...

> +		sort(gains[i], gts->num_hwgain, sizeof(int), iio_gts_gain_cmp,
> +		     NULL);

One line is okay.

...

> +	all_gains = kcalloc(gts->num_itime * gts->num_hwgain, sizeof(int),

Something from overflow.h is very suitable here.

> +			    GFP_KERNEL);
> +	if (!all_gains)
> +		return -ENOMEM;

...

> +	memcpy(all_gains, gains[gts->num_itime - 1], gts->num_hwgain * sizeof(int));

Maybe it's better to have a temporary which will be calculated as array_size()
for allocation and reused here?

...

> +	for (i = gts->num_itime - 2; i >= 0; i--)

Yeah, if you put this into temporary, like

	i = gts->num_itime - 1;

this becomes

	while (i--) {

Note, you missed {} for better reading.

Note, you may re-use that i (maybe renamed to something better in the memcpy()
above as well).

> +		for (j = 0; j < gts->num_hwgain; j++) {
> +			int candidate = gains[i][j];
> +			int chk;
> +
> +			if (candidate > all_gains[new_idx - 1]) {
> +				all_gains[new_idx] = candidate;
> +				new_idx++;
> +
> +				continue;
> +			}
> +			for (chk = 0; chk < new_idx; chk++)
> +				if (candidate <= all_gains[chk])
> +					break;
> +
> +			if (candidate == all_gains[chk])
> +				continue;
> +
> +			memmove(&all_gains[chk + 1], &all_gains[chk],
> +				(new_idx - chk) * sizeof(int));
> +			all_gains[chk] = candidate;
> +			new_idx++;
> +		}

...

> +	gts->avail_all_scales_table = kcalloc(gts->num_avail_all_scales,
> +					      2 * sizeof(int), GFP_KERNEL);
> +	if (!gts->avail_all_scales_table)
> +		ret = -ENOMEM;
> +	else
> +		for (i = 0; !ret && i < gts->num_avail_all_scales; i++)

Much easier to read if you move this...

> +			ret = iio_gts_total_gain_to_scale(gts, all_gains[i],
> +					&gts->avail_all_scales_table[i * 2],
> +					&gts->avail_all_scales_table[i * 2 + 1]);

...here as

		if (ret)
			break;

> +	kfree(all_gains);
> +	if (ret && gts->avail_all_scales_table)
> +		kfree(gts->avail_all_scales_table);
> +
> +	return ret;

But Wouldn't be better to use goto labels?

...

> +	while (i) {

Instead of doing standard

	while (i--) {

> +		/*
> +		 * It does not matter if i'th alloc was not succesfull as
> +		 * kfree(NULL) is safe.
> +		 */

You add this comment, ...

> +		kfree(per_time_gains[i]);
> +		kfree(per_time_scales[i]);

...an additional loop, ...

> +
> +		i--;

...and a line of code.

> +	}

Why?

> +	for (i = gts->num_itime - 1; i >= 0; i--) {

	i = gts->num_itime;

	while (i--) {

> +		int new = gts->itime_table[i].time_us;
> +
> +		if (times[idx] < new) {
> +			times[idx++] = new;
> +			continue;
> +		}
> +
> +		for (j = 0; j <= idx; j++) {
> +			if (times[j] > new) {
> +				memmove(&times[j + 1], &times[j], (idx - j) * sizeof(int));
> +				times[j] = new;
> +				idx++;
> +			}
> +		}
> +	}

...

> +void iio_gts_purge_avail_time_table(struct iio_gts *gts)
> +{
> +	if (gts->num_avail_time_tables) {

	if (!...)
		return;

> +		kfree(gts->avail_time_tables);
> +		gts->avail_time_tables = NULL;
> +		gts->num_avail_time_tables = 0;
> +	}
> +}

...

> +			if (!diff) {

Why not positive conditional?

			if (diff) {
				...
			} else {
				...
			}

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

...

> +	ret = gain_get_scale_fraction(gts->max_scale, scale_linear, mul, gain);

> +

Redundant blank line.

> +	if (ret || !iio_gts_valid_gain(gts, *gain))

Why error code is shadowed?

> +		return -EINVAL;
> +

...

> +	ret = iio_gts_get_scale_linear(gts, old_gain, itime_old->time_us,
> +				       &scale);

Single line if fine.

> +	if (ret)
> +		return ret;
> +
> +	ret = gain_get_scale_fraction(gts->max_scale, scale, itime_new->mul,
> +				      new_gain);

Ditto.

> +	if (ret)
> +		return -EINVAL;

...

> +#ifndef __GAIN_TIME_SCALE_HELPER__
> +#define __GAIN_TIME_SCALE_HELPER__

__IIO_... ?

Missing types.h (at least, haven't checked for more).

Missing some forward declarations, at least for struct device.

-- 
With Best Regards,
Andy Shevchenko


