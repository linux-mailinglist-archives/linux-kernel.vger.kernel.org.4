Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A2C6C03A0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 18:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCSRxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 13:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjCSRxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 13:53:40 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB051CACA;
        Sun, 19 Mar 2023 10:53:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A44ADCE0F8E;
        Sun, 19 Mar 2023 17:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49B4C4339C;
        Sun, 19 Mar 2023 17:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679248414;
        bh=4jZjtBcQLmXUfFRIxd3wxoMrM8ICSHEQ3qzj3DBAe1I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZNIq0Cc5as48D4+AL2t/E2a7hD/vEkmrdBvYJlqdTD1mpz6mrqJYcsk1AcXz2RFT2
         nzpg68IOfWNhjzEomqbQoHlJOmMw13fad12s8Evszwn5sWhzik06PNXFJPmrXvFhY1
         fg178YnCRjoM6bRmCZ63DyXePbL4oQ57c0GUWgW57MhJoKp0ZciBpgV5n2j9gLSoSO
         MWpS4SPse3bTtlRFZhXBkdXxE4Z1HpWeT4lXtl/Vqrxla6iJn7UT7Ng1KtWdped4x3
         4r/0LJm3SsCBuKb53NCQJP/aGa06/l0lTi/zOMm4fKVYlFV5ubN03+by79crYon+0Q
         iiiYGxJH5ZG6g==
Date:   Sun, 19 Mar 2023 18:08:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 4/8] iio: light: Add gain-time-scale helpers
Message-ID: <20230319180828.452a603c@jic23-huawei>
In-Reply-To: <e5b93a3d2424b16d842e847c98f05f1a9befb2e1.1679062529.git.mazziesaccount@gmail.com>
References: <cover.1679062529.git.mazziesaccount@gmail.com>
        <e5b93a3d2424b16d842e847c98f05f1a9befb2e1.1679062529.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Fri, 17 Mar 2023 16:43:23 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

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
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Whilst you use it in the tests currently I'm not convinced there is a good
reason to separate iio_init_iio_gts() from devm_iio_gts_build_avail_tables()
as I'd expect them to be called as a pair in all drivers that use this.

Perhaps it's worth reworking the tests to do that even if it's not strictly
necessary for specific tests.

I think a bit more care is need with storage of time (unsigned) + decide
whether to allow for negative gains. Whilst they happen I'm not that bothered
if that subtlety becomes a device driver problem when calling this.  I'm not
sure I've seen a sensor that does both positive and negative gains for a single
channel.

> 
> ---
> Currently it is only BU27034 using these in this series. I am however working
> with drivers for RGB sensors BU27008 and BU27010 which have similar
> [gain - integration time - scale] - relation. I hope sending those
> follows soon after the BU27034 is done.
> 
> Changes:
> v3 => v4:
> - doc styling
> - use memset to zero the helper struct at init
> - drop unnecessary min calculation at iio_find_closest_gain_low()
> - use namespace to all exports
> - many minor stylings
> - make available outside iio/light (move code to drivers/iio and move the
>   header under include
> - rename to look like other files under drivers/iio (s/iio/industrialio)

Ah. I've always regretted not using iio_ for the prefix on those so I'm fine
if you would prefer to stick to iio_


> - drop unused functions
> - don't export only internally used functions and make them static
>   Note, I decided to keep iio_gts_total_gain_to_scale() exported as it is
>   currently needed by the tests outside the helpers.
> 
> v2 => v3: (mostly fixes based on review by Andy)
> - Fix typos
> - Styling fixes
> - Use namespace for exported symbols
> - Protect allocs against argument overflow
> - Fix include protection name
> - add types.h inclusion and struct device forward declaration
> 
> RFCv1 => v2:
> - fix include guardian
> - Improve kernel doc for iio_init_iio_gts.
> - Add iio_gts_scale_to_total_gain
> - Add iio_gts_total_gain_to_scale
> - Fix review comments from Jonathan
>   - add documentation to few functions
>   - replace 0xffffffffffffffffLLU by U64_MAX
>   - some styling fixes
>   - drop unnecessary NULL checks
>   - order function arguments by  in / out purpose
>   - drop GAIN_SCALE_ITIME_MS()
> - Add helpers for available scales and times
> - Rename to iio-gts-helpers

> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> new file mode 100644
> index 000000000000..9494ea7cdbcf
> --- /dev/null
> +++ b/drivers/iio/industrialio-gts-helper.c
> @@ -0,0 +1,990 @@
...

> +
> +static const struct iio_itime_sel_mul *
> +iio_gts_find_itime_by_time(struct iio_gts *gts, int time)

Time going to be positive (I hope!)
So as below, I'd make all time values unsigned.

> +{
> +	int i;
> +
> +	if (!gts->num_itime)
> +		return NULL;
> +
> +	for (i = 0; i < gts->num_itime; i++)
> +		if (gts->itime_table[i].time_us == time)
> +			return &gts->itime_table[i];
> +
> +	return NULL;
> +}

...

> +/**
> + * iio_gts_purge_avail_scale_table - free-up the available scale tables
> + * @gts:	Gain time scale descriptor
> + *
> + * Free the space reserved by iio_gts_build_avail_scale_table(). Please note
> + * that the helpers for getting available scales like the
> + * iio_gts_all_avail_scales() are not usable after this call. Thus, this should
> + * be only called after these helpers can no longer be called (Eg. after
> + * the iio-device has been deregistered).

Whilst I'm not that keen on the comment in general, if you really really want to
have it we need to figure out one place to put it rather than lots of duplicates.

> + */
...


> +static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
> +{
> +	int ret, i, j, new_idx, time_idx;
> +	int *all_gains;
> +	size_t gain_bytes;
> +
> +	for (i = 0; i < gts->num_itime; i++) {
> +		/*
> +		 * Sort the tables for nice output and for easier finding of
> +		 * unique values.
> +		 */
> +		sort(gains[i], gts->num_hwgain, sizeof(int), iio_gts_gain_cmp,
> +		     NULL);
> +
> +		/* Convert gains to scales */
> +		for (j = 0; j < gts->num_hwgain; j++) {
> +			ret = iio_gts_total_gain_to_scale(gts, gains[i][j],
> +							  &scales[i][2 * j],
> +							  &scales[i][2 * j + 1]);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	gain_bytes = array_size(gts->num_hwgain, sizeof(int));
> +	all_gains = kcalloc(gts->num_itime, gain_bytes, GFP_KERNEL);
> +	if (!all_gains)
> +		return -ENOMEM;
> +
> +	/*
> +	 * We assume all the gains for same integration time were unique.
> +	 * It is likely the first time table had greatest time multiplier as
> +	 * the times are in the order of preference and greater times are
> +	 * usually preferred. Hence we start from the last table which is likely
> +	 * to have the smallest total gains.
> +	 */
> +	time_idx = gts->num_itime - 1;
> +	memcpy(all_gains, gains[time_idx], gain_bytes);
> +	new_idx = gts->num_hwgain;
> +
> +	while (time_idx--) {
> +		for (j = 0; j < gts->num_hwgain; j++) {
> +			int candidate = gains[time_idx][j];
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
> +	}
> +
> +	gts->num_avail_all_scales = new_idx;
> +	gts->avail_all_scales_table = kcalloc(gts->num_avail_all_scales,
> +					      2 * sizeof(int), GFP_KERNEL);
> +	if (!gts->avail_all_scales_table)
> +		ret = -ENOMEM;
> +	else
> +		for (i = 0; !ret && i < gts->num_avail_all_scales; i++)
> +			ret = iio_gts_total_gain_to_scale(gts, all_gains[i],
> +					&gts->avail_all_scales_table[i * 2],
> +					&gts->avail_all_scales_table[i * 2 + 1]);
> +
> +	kfree(all_gains);
> +	if (ret)
> +		kfree(gts->avail_all_scales_table);

This is getting too clever.  I'd have an error handling block and gotos
even though it duplicates one line.  
> +
> +	return ret;
> +}
> +
> +/**
> + * iio_gts_build_avail_scale_table - create tables of available scales
> + * @gts:	Gain time scale descriptor
> + *
> + * Build the tables which can represent the available scales based on the
> + * originally given gain and time tables. When both time and gain tables are
> + * given this results:
> + * 1. A set of tables representing available scales for each supported
> + *    integration time.
> + * 2. A single table listing all the unique scales that any combination of
> + *    supported gains and times can provide.
> + *
> + * NOTE: Space allocated for the tables must be freed using
> + * iio_gts_purge_avail_scale_table() when the tables are no longer needed.
> + *
> + * Return: 0 on success.
> + */
> +static int iio_gts_build_avail_scale_table(struct iio_gts *gts)
> +{
> +	int **per_time_gains, **per_time_scales, i, j, ret = -ENOMEM;
> +
> +	per_time_gains = kcalloc(gts->num_itime, sizeof(int *), GFP_KERNEL);

As per other thread, I much prefer reviewing code with sizeof(*per_time_gains)
as it requires fewer brain cells.

> +	if (!per_time_gains)
> +		return ret;
> +
> +	per_time_scales = kcalloc(gts->num_itime, sizeof(int *), GFP_KERNEL);
> +	if (!per_time_scales)
> +		goto free_gains;
> +
> +	for (i = 0; i < gts->num_itime; i++) {
> +		per_time_scales[i] = kcalloc(gts->num_hwgain, 2 * sizeof(int),
> +					     GFP_KERNEL);
> +		if (!per_time_scales[i])
> +			goto err_free_out;
> +
> +		per_time_gains[i] = kcalloc(gts->num_hwgain, sizeof(int),
> +					    GFP_KERNEL);
> +		if (!per_time_gains[i])
> +			goto err_free_scale_out;

As below. I'd put kfree(per_time_scales[i]); here to simplify the paths to
the error handling block.

> +
> +
> +		for (j = 0; j < gts->num_hwgain; j++)
> +			per_time_gains[i][j] = gts->hwgain_table[j].gain *
> +					       gts->itime_table[i].mul;
> +	}
> +
> +	ret = gain_to_scaletables(gts, per_time_gains, per_time_scales);
> +	if (ret)
> +		goto err_free_out;

I'm not a fan of dancing backwards and forwards with exit paths. As such I'd move
the kfree(per_time_scales[i]) to the one condition where it matters above.

> +
> +	kfree(per_time_gains);
> +	gts->per_time_avail_scale_tables = per_time_scales;
> +
> +	return 0;
> +
> +err_free_scale_out:
> +	kfree(per_time_scales[i]);
> +err_free_out:
> +	for (i--; i; i--) {
> +		kfree(per_time_scales[i]);
> +		kfree(per_time_gains[i]);
> +	}
> +	kfree(per_time_scales);
> +free_gains:
> +	kfree(per_time_gains);
> +
> +	return ret;
> +}
> +
> +/**
> + * iio_gts_build_avail_time_table - build table of available integration times
> + * @gts:	Gain time scale descriptor
> + *
> + * Build the table which can represent the available times to be returned
> + * to users using the read_avail-callback.
> + *
> + * NOTE: Space allocated for the tables must be freed using
> + * iio_gts_purge_avail_time_table() when the tables are no longer needed.
> + *
> + * Return: 0 on success.
> + */
> +static int iio_gts_build_avail_time_table(struct iio_gts *gts)
> +{
> +	int *times, i, j, idx = 0;
> +
> +	if (!gts->num_itime)
> +		return 0;
> +
> +	times = kcalloc(gts->num_itime, sizeof(int), GFP_KERNEL);
> +	if (!times)
> +		return -ENOMEM;
> +
> +	for (i = gts->num_itime - 1; i >= 0; i--) {
> +		int new = gts->itime_table[i].time_us;
> +

This looks like a sort routine.  Don't we have something generic that will work?

> +		if (times[idx] < new) {
> +			times[idx++] = new;
> +			continue;
> +		}
> +
> +		for (j = 0; j <= idx; j++) {
> +			if (times[j] > new) {
> +				memmove(&times[j + 1], &times[j],
> +					(idx - j) * sizeof(int));
> +				times[j] = new;
> +				idx++;
> +			}
> +		}
> +	}
> +	gts->avail_time_tables = times;
> +	/*
> +	 * This is just to survive a unlikely corner-case where times in the
> +	 * given time table were not unique. Else we could just trust the
> +	 * gts->num_itime.

If integration times aren't unique I'd count it as driver bug and error out
/scream.  Papering over things like this just make code harder to review
to deal with what is probably a driver bug.

> +	 */
> +	gts->num_avail_time_tables = idx;
> +
> +	return 0;
> +}

...

> +/**
> + * iio_gts_purge_avail_tables - free-up the availability tables
> + * @gts:	Gain time scale descriptor
> + *
> + * Free the space reserved by iio_gts_build_avail_tables(). Frees both the
> + * integration time and scale tables.
> + *
> + * Note  that the helpers for getting available integration times or scales
> + * like the iio_gts_avail_times() are not usable after this call. Thus, this
> + * should be only called after these helpers can no longer be called (Eg.
> + * after the iio-device has been deregistered).
As below, I'm not sure the note adds much over normal use after free...
Also different formatting to the one below.

> + */
> +static void iio_gts_purge_avail_tables(struct iio_gts *gts)
> +{
> +	iio_gts_purge_avail_time_table(gts);
> +	iio_gts_purge_avail_scale_table(gts);
> +}
> +
> +static void devm_iio_gts_avail_all_drop(void *res)
> +{
> +	iio_gts_purge_avail_tables(res);
> +}
> +
> +/**
> + * devm_iio_gts_build_avail_tables - manged add availability tables
> + * @dev:	Pointer to the device whose lifetime tables are bound
> + * @gts:	Gain time scale descriptor
> + *
> + * Build the tables which can represent the available scales and available
> + * integration times. Availability tables are built based on the originally
> + * given gain and given time tables.
> + *
> + * When both time and gain tables are
> + * given this results:

odd line break.

> + * 1. A set of sorted tables representing available scales for each supported
> + *    integration time.
> + * 2. A single sorted table listing all the unique scales that any combination
> + *    of supported gains and times can provide.
> + * 3. A sorted table of supported integration times
> + *
> + * After these tables are built one can use the iio_gts_all_avail_scales(),
> + * iio_gts_avail_scales_for_time() and iio_gts_avail_times() helpers to
> + * implement the read_avail opeations.
> + *
> + * The tables are automatically released upon device detach.
> + *
> + * NOTE: after the tables have been purged, the helpers for getting
> + * available scales / integration times are no longer usable. Care must be
> + * taken that unwinding is done in correct order (iio device is deregistered
> + * prior purging the tables).

Hmm. I think this note is calling out one potential path (even if it's the most
common one). I'd not bother with it as a driver should use no resources after
they've been freed and this is typically one of many.

> + *
> + * Return: 0 on success.
> + */
> +int devm_iio_gts_build_avail_tables(struct device *dev, struct iio_gts *gts)
> +{
> +	int ret;
> +
> +	ret = iio_gts_build_avail_tables(gts);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, devm_iio_gts_avail_all_drop, gts);
> +}
> +EXPORT_SYMBOL_GPL(devm_iio_gts_build_avail_tables);

> +/**
> + * iio_gts_valid_time - check if given integration time is valid
> + * @gts:	Gain time scale descriptor
> + * @time_us:	Integration time to check
> + *
> + * Return:	True if given time is supported by device. False if not.
> + */
> +bool iio_gts_valid_time(struct iio_gts *gts, int time_us)
> +{
> +	return iio_gts_find_itime_by_time(gts, time_us);
I'd make this a little more explicit as implicit casting pointer to bool is
rather unusual.
	!= NULL; maybe?

	
> +}
> +EXPORT_SYMBOL_GPL(iio_gts_valid_time);
> +
> +int iio_gts_find_sel_by_gain(struct iio_gts *gts, int gain)
> +{
> +	int i;
> +
> +	for (i = 0; i < gts->num_hwgain; i++)
> +		if (gts->hwgain_table[i].gain == gain)
> +			return gts->hwgain_table[i].sel;
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(iio_gts_find_sel_by_gain);
> +
> +bool iio_gts_valid_gain(struct iio_gts *gts, int gain)
> +{
> +	return iio_gts_find_sel_by_gain(gts, gain) >= 0;
> +}
> +EXPORT_SYMBOL_GPL(iio_gts_valid_gain);

For the _valid_xxx functions, I wonder if you shouldn't just
push them to the header as static inline

> +
> +int iio_gts_find_gain_by_sel(struct iio_gts *gts, int sel)
> +{
> +	int i;
> +
> +	for (i = 0; i < gts->num_hwgain; i++)
> +		if (gts->hwgain_table[i].sel == sel)
> +			return gts->hwgain_table[i].gain;
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(iio_gts_find_gain_by_sel);
> +
> +int iio_gts_get_min_gain(struct iio_gts *gts)

Could just use min = INT_MAX;
(indirectly from linux/limits.h, it's actually in vdso/limits.h
but should not include that directly I think)
then I don't hink you need the special casing for the
first entry.

> +{
> +	int i, min = -EINVAL;
> +
> +	for (i = 0; i < gts->num_hwgain; i++) {
> +		int gain = gts->hwgain_table[i].gain;
> +
> +		if (min == -EINVAL)
> +			min = gain;
> +		else
> +			min = min(min, gain);
> +	}
> +
> +	return min;
> +}
> +EXPORT_SYMBOL_GPL(iio_gts_get_min_gain);
> +
> +/**
> + * iio_find_closest_gain_low - Find the closest lower matching gain
> + * @gts:	Gain time scale descriptor
> + * @gain:	reference gain for which the closest match is searched
> + * @in_range:	indicate if the reference gain was actually in the range of
> + *		supported gains.
> + *
> + * Search for closest supported gain that is lower than or equal to the
> + * gain given as a parameter. This is usable for drivers which do not require
> + * user to request exact matching gain but rather fo rounding to a supported
> + * gain value which is equal or lower (setting lower gain is typical for
> + * avoiding saturation)
> + *
> + * Return:	The closest matching supported gain or -EINVAL is reference

Maybe just say @gain was smaller.  reference gain does not have clear meaning to me.

> + *		gain was smaller than the smallest supported gain.
> + */
> +int iio_find_closest_gain_low(struct iio_gts *gts, int gain, bool *in_range)
> +{
> +	int i, diff = 0;
> +	int best = -1;
> +
> +	*in_range = false;
> +
> +	for (i = 0; i < gts->num_hwgain; i++) {
> +		/*
> +		 * It is not expected this function is called for an exactly
> +		 * matching gain.
I'd not mark it unlikely even so (or comment on it).
This is unlikely to be a particularly hot path so this unlikely() seems like a
premature optimization which adds complexity to the code.

> +		 */
> +		if (unlikely(gain == gts->hwgain_table[i].gain)) {
> +			*in_range = true;
> +			return gain;
> +		}
> +
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
> +}
> +EXPORT_SYMBOL_GPL(iio_find_closest_gain_low);


...


> +/*
> + * iio_gts_find_gain_sel_for_scale_using_time - Fetch gain selector.
> + * See iio_gts_find_gain_for_scale_using_time() for more information

This is exported, so I'd rather see kernel-doc style comments.

> + */
> +int iio_gts_find_gain_sel_for_scale_using_time(struct iio_gts *gts, int time_sel,
> +					       int scale_int, int scale_nano,
> +					       int *gain_sel)
> +{
> +	int gain, ret;
> +
> +	ret = iio_gts_find_gain_for_scale_using_time(gts, time_sel, scale_int,
> +						     scale_nano, &gain);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_gts_find_sel_by_gain(gts, gain);
> +	if (ret < 0)
> +		return ret;
> +
> +	*gain_sel = ret;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iio_gts_find_gain_sel_for_scale_using_time);
> +
> +int iio_gts_find_int_time_by_sel(struct iio_gts *gts, int sel)
> +{
> +	const struct iio_itime_sel_mul *itime;
> +
> +	itime = iio_gts_find_itime_by_sel(gts, sel);
> +	if (!itime)
> +		return -EINVAL;
> +
> +	return itime->time_us;

Currently can be negative.  Even when you stop that being the case
by makign time unsigned, you need to be careful with ranges here.
You may be better off separating the error handling from the values
to avoid any issues even though that makes it a little harder to use.

> +}
> +EXPORT_SYMBOL_GPL(iio_gts_find_int_time_by_sel);
> +
> +int iio_gts_find_sel_by_int_time(struct iio_gts *gts, int time)
> +{
> +	const struct iio_itime_sel_mul *itime;
> +
> +	itime = iio_gts_find_itime_by_time(gts, time);
> +	if (!itime)
> +		return -EINVAL;
> +
> +	return itime->sel;

itime->sel can be negative.  I wonder if you should just make that
u16 so that you can always return it as a positive integer but
having it as unsigned in the structure.

Otherwise you need to add some docs on those limits and probably
sanity check them during the _init()


> +}
> +EXPORT_SYMBOL_GPL(iio_gts_find_sel_by_int_time);
> +
> +static int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time)
> +{
> +	const struct iio_itime_sel_mul *itime;
> +
> +	if (!iio_gts_valid_gain(gts, gain))
> +		return -EINVAL;
> +
> +	if (!gts->num_itime)
> +		return gain;
> +
> +	itime = iio_gts_find_itime_by_time(gts, time);
> +	if (!itime)
> +		return -EINVAL;
> +
> +	return gain * itime->mul;

Check for overflow perhaps?

> +}
> +
> +static int iio_gts_get_scale_linear(struct iio_gts *gts, int gain, int time,
> +				    u64 *scale)
> +{
> +	int total_gain;
> +	u64 tmp
> +
> +	total_gain = iio_gts_get_total_gain(gts, gain, time);
> +	if (total_gain < 0)
> +		return total_gain;
> +
> +	tmp = gts->max_scale;
> +
> +	do_div(tmp, total_gain);
> +
> +	*scale = tmp;
> +
> +	return 0;
> +}
> +
> +int iio_gts_get_scale(struct iio_gts *gts, int gain, int time, int *scale_int,
> +		      int *scale_nano)
> +{
> +	u64 lin_scale;
> +	int ret;
> +
> +	ret = iio_gts_get_scale_linear(gts, gain, time, &lin_scale);
> +	if (ret)
> +		return ret;
> +
> +	return iio_gts_delinearize(lin_scale, NANO, scale_int, scale_nano);
> +}
> +EXPORT_SYMBOL_GPL(iio_gts_get_scale);

It is good practice to add kernel-doc for all the exported functions,
even if some of them will be fairly obvious.  In this case the function
definition doesn't make it clear how time and gain are specified.
usecs? an index into a set of provided values?

If you can make the units explicit in the parameter that's even better.
I will note that negative times seem unlikely so maybe that should always
be unsigned?  gain probably can be negative even if that's unusual.
That may lead to problems though as lin_scale is in turn unsigned.

> +
> +/**
> + * iio_gts_find_new_gain_sel_by_old_gain_time - compensate time change

compensate for time change

> + * @gts:		Gain time scale descriptor
> + * @old_gain:		Previously set gain
> + * @old_time_sel:	Selector corresponding previously set time
> + * @new_time_sel:	Selector corresponding new time to be set
> + * @new_gain:		Pointer to value where new gain is to be written
> + *
> + * We may want to mitigate the scale change caused by setting a new integration
> + * time (for a light sensor) by also updating the (HW)gain. This helper computes
> + * new gain value to maintain the scale with new integration time.
> + *
> + * Return: 0 on success. -EINVAL if gain matching the new time is not found.
> + */
> +int iio_gts_find_new_gain_sel_by_old_gain_time(struct iio_gts *gts,
> +					       int old_gain, int old_time_sel,
> +					       int new_time_sel, int *new_gain)
> +{
> +	const struct iio_itime_sel_mul *itime_old, *itime_new;
> +	u64 scale;
> +	int ret;
> +
> +	itime_old = iio_gts_find_itime_by_sel(gts, old_time_sel);
> +	if (!itime_old)
> +		return -EINVAL;
> +
> +	itime_new = iio_gts_find_itime_by_sel(gts, new_time_sel);
> +	if (!itime_new)
> +		return -EINVAL;
> +
> +	ret = iio_gts_get_scale_linear(gts, old_gain, itime_old->time_us,
> +				       &scale);
> +	if (ret)
> +		return ret;
> +
> +	ret = gain_get_scale_fraction(gts->max_scale, scale, itime_new->mul,
> +				      new_gain);
> +	if (ret)
> +		return -EINVAL;
> +
> +	if (!iio_gts_valid_gain(gts, *new_gain))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iio_gts_find_new_gain_sel_by_old_gain_time);

