Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A456C8FFE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 19:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjCYSOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 14:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYSOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 14:14:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A31F65AA;
        Sat, 25 Mar 2023 11:14:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 097A860C88;
        Sat, 25 Mar 2023 18:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49236C433D2;
        Sat, 25 Mar 2023 18:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679768075;
        bh=nwd8uAm6HMt5ANQfErBP2Lg7DNgTd4QirKYb/KLHLbM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AqsLntR+uOq5sRuhLBMb8fIt+PCh4pATRSpPdO5+v8aWTWy2Hgop3T8XwRbhgR+d0
         fHP0EpVDBRAxVSQLf8dZJpbmLElx2hmWPt64LsIoW9i7un7UoJNg2Y0uf2wV11ObUc
         dYafZJmHt7I88JdoMw1KA7utYhaXL2pm6EUxl10qEUgM8MGHIPxneREVvGwVc36yV+
         XKO1zPzV5kuFtwENWhbwU1+LhXVKffWn7ua7yYG2N7q7tC6eJ9Z30ZptqraQARJbOm
         t0zw9u+ODDyG0UEEWdpBt9I9MKJ+8uDTszZL8tSzC1uTpADk1b6N6YaPlqnTmi/J78
         p9v7VJm1WgBnA==
Date:   Sat, 25 Mar 2023 18:29:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 4/8] iio: light: Add gain-time-scale helpers
Message-ID: <20230325182937.3bdc881e@jic23-huawei>
In-Reply-To: <5ba4ab3d-90ab-113e-1b95-86118d3a7392@gmail.com>
References: <cover.1679062529.git.mazziesaccount@gmail.com>
        <e5b93a3d2424b16d842e847c98f05f1a9befb2e1.1679062529.git.mazziesaccount@gmail.com>
        <20230319180828.452a603c@jic23-huawei>
        <5ba4ab3d-90ab-113e-1b95-86118d3a7392@gmail.com>
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

On Mon, 20 Mar 2023 14:01:55 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 3/19/23 20:08, Jonathan Cameron wrote:
> > On Fri, 17 Mar 2023 16:43:23 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> Some light sensors can adjust both the HW-gain and integration time.
> >> There are cases where adjusting the integration time has similar impact
> >> to the scale of the reported values as gain setting has.
> >>
> >> IIO users do typically expect to handle scale by a single writable 'scale'
> >> entry. Driver should then adjust the gain/time accordingly.
> >>
> >> It however is difficult for a driver to know whether it should change
> >> gain or integration time to meet the requested scale. Usually it is
> >> preferred to have longer integration time which usually improves
> >> accuracy, but there may be use-cases where long measurement times can be
> >> an issue. Thus it can be preferable to allow also changing the
> >> integration time - but mitigate the scale impact by also changing the gain
> >> underneath. Eg, if integration time change doubles the measured values,
> >> the driver can reduce the HW-gain to half.
> >>
> >> The theory of the computations of gain-time-scale is simple. However,
> >> some people (undersigned) got that implemented wrong for more than once.
> >>
> >> Add some gain-time-scale helpers in order to not dublicate errors in all
> >> drivers needing these computations.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>  
> > 
> > Whilst you use it in the tests currently I'm not convinced there is a good
> > reason to separate iio_init_iio_gts() from devm_iio_gts_build_avail_tables()
> > as I'd expect them to be called as a pair in all drivers that use this.  
> 
> I was wondering if I should only provide the:
> 
> [devm_]iio_init_iio_gts() and always unconditionally allocate and build 
> the tables inside the initialization routine.
> 
> I don't really care so much about how the tests are done. In my opinion 
> the testability needs should rarely be determining what the production 
> code looks like. In this case it is a waste of time / resources for 
> drivers which do not tell the available scales/times to user-space, or 
> do need some special routine for this. This is why I did make 
> build_avail_tables() optional. Still not sure what would be the best 
> approach though.

Given it should be 'easy to do' after you have this infrastructure, why would
a driver not provide the _available tables?

> 
> > Perhaps it's worth reworking the tests to do that even if it's not strictly
> > necessary for specific tests.
> > 
> > I think a bit more care is need with storage of time (unsigned) + decide
> > whether to allow for negative gains.  
> 
> My approach was just pretty simple "int is big enough for the times" 
> (2000+ seconds when using usec as time units felt like more than enough 
> for light sensors) and "gains are always positive".
> 
> I have not tested the negative gains at all - but I agree this should've 
> been documented. Currently there is no gts-helper users who need 
> negative gain (or large times for that matter) - so I was not handling them.
> 
> I'll try to check what it would mean code-wise if we converted times to 
> unsigned. Negative times make no sense but allowing negative error 
> values is a simple way to go.
> 
> As for the negative gains - I have no problem of someone adding a 
> support for those if needed, but I don't currently see much point in 
> investing time in that...

I'm fine with keeping them all signed, but you probably need some checks
to ensure the data provided isn't negative.

> 
> > Whilst they happen I'm not that bothered
> > if that subtlety becomes a device driver problem when calling this.  I'm not
> > sure I've seen a sensor that does both positive and negative gains for a single
> > channel.  
> 
> I agree. If driver needs negative gains, then the driver needs to deal 
> with it. I have no objections if driver authors want to improve these 
> helpers by adding support for negative gains, but if they don't, then 
> they have the exactly same problem they would have without these helpers :)
> 
> >> ---
> >> Currently it is only BU27034 using these in this series. I am however working
> >> with drivers for RGB sensors BU27008 and BU27010 which have similar
> >> [gain - integration time - scale] - relation. I hope sending those
> >> follows soon after the BU27034 is done.
> >>
> >> Changes:
> >> v3 => v4:
> >> - doc styling
> >> - use memset to zero the helper struct at init
> >> - drop unnecessary min calculation at iio_find_closest_gain_low()
> >> - use namespace to all exports
> >> - many minor stylings
> >> - make available outside iio/light (move code to drivers/iio and move the
> >>    header under include
> >> - rename to look like other files under drivers/iio (s/iio/industrialio)  
> > 
> > Ah. I've always regretted not using iio_ for the prefix on those so I'm fine
> > if you would prefer to stick to iio_  
> 
> I do like iio better. However, I think we should have common prefix for 
> these files. Having both iio- and industrialio- will be confusing for 
> newcomers. If I saw just one iio- prefixed file I would have assumed it 
> is for a specific use, not for common use as the other "IIO-core" files.
> 
> One option would be converting all these industrialio-*.c files to 
> iio_*.c - but I am not sure if it is worth the hassle.

It gets messy because then you have to fix up the module names. People get
annoyed if those change.


...

> >   
> >> +/**
> >> + * iio_gts_purge_avail_scale_table - free-up the available scale tables
> >> + * @gts:	Gain time scale descriptor
> >> + *
> >> + * Free the space reserved by iio_gts_build_avail_scale_table(). Please note
> >> + * that the helpers for getting available scales like the
> >> + * iio_gts_all_avail_scales() are not usable after this call. Thus, this should
> >> + * be only called after these helpers can no longer be called (Eg. after
> >> + * the iio-device has been deregistered).  
> > 
> > Whilst I'm not that keen on the comment in general, if you really really want to
> > have it we need to figure out one place to put it rather than lots of duplicates.  
> 
> I have seen way too many bugs with the unwinding errors. Usually with 
> the IRQs but also when user-space has access to driver stuff. I placed 
> this comment here hoping it would prevent at least one such bug as those 
> tend to be really nasty to debug. If we avoid one, it is well worth of 
> few lines of comment (IMO).

I'd argue this particular code doesn't have the subtleties that irqs and stuff
directly accessed from userspace has (where such comments would sometimes be
helpful!).  Meh I don't care that much.


> >> +
> >> +/**
> >> + * iio_gts_build_avail_scale_table - create tables of available scales
> >> + * @gts:	Gain time scale descriptor
> >> + *
> >> + * Build the tables which can represent the available scales based on the
> >> + * originally given gain and time tables. When both time and gain tables are
> >> + * given this results:
> >> + * 1. A set of tables representing available scales for each supported
> >> + *    integration time.
> >> + * 2. A single table listing all the unique scales that any combination of
> >> + *    supported gains and times can provide.
> >> + *
> >> + * NOTE: Space allocated for the tables must be freed using
> >> + * iio_gts_purge_avail_scale_table() when the tables are no longer needed.
> >> + *
> >> + * Return: 0 on success.
> >> + */
> >> +static int iio_gts_build_avail_scale_table(struct iio_gts *gts)
> >> +{
> >> +	int **per_time_gains, **per_time_scales, i, j, ret = -ENOMEM;
> >> +
> >> +	per_time_gains = kcalloc(gts->num_itime, sizeof(int *), GFP_KERNEL);  
> > 
> > As per other thread, I much prefer reviewing code with sizeof(*per_time_gains)
> > as it requires fewer brain cells.  
> 
> Hm. I think it depends on whether one wants to understand how many bytes 
> the sizeof() is actually referring. Well, again, I guess I have no 
> choice here.

Why would one care?  You care about the number of objects, for a kcalloc call
but the size is rarely useful to have immediately visible.


> >> +
> >> +/**
> >> + * iio_gts_build_avail_time_table - build table of available integration times
> >> + * @gts:	Gain time scale descriptor
> >> + *
> >> + * Build the table which can represent the available times to be returned
> >> + * to users using the read_avail-callback.
> >> + *
> >> + * NOTE: Space allocated for the tables must be freed using
> >> + * iio_gts_purge_avail_time_table() when the tables are no longer needed.
> >> + *
> >> + * Return: 0 on success.
> >> + */
> >> +static int iio_gts_build_avail_time_table(struct iio_gts *gts)
> >> +{
> >> +	int *times, i, j, idx = 0;
> >> +
> >> +	if (!gts->num_itime)
> >> +		return 0;
> >> +
> >> +	times = kcalloc(gts->num_itime, sizeof(int), GFP_KERNEL);
> >> +	if (!times)
> >> +		return -ENOMEM;
> >> +
> >> +	for (i = gts->num_itime - 1; i >= 0; i--) {
> >> +		int new = gts->itime_table[i].time_us;
> >> +  
> > 
> > This looks like a sort routine.  Don't we have something generic that will work?  
> 
> I think this is "combine and sort many tables into one while dropping 
> duplicates". I must admit I don't know what sort routines we have 
> in-kernel. If we have one which removes duplicates, then we could 
> probably copy all the tables into one array and run such sort on it.
> 
> Or then we can leave this as is and add a comment about telling is going 
> on here :)

Perfect.

> 
> >   
> >> +		if (times[idx] < new) {
> >> +			times[idx++] = new;
> >> +			continue;
> >> +		}
> >> +
> >> +		for (j = 0; j <= idx; j++) {
> >> +			if (times[j] > new) {
> >> +				memmove(&times[j + 1], &times[j],
> >> +					(idx - j) * sizeof(int));
> >> +				times[j] = new;
> >> +				idx++;
> >> +			}
> >> +		}
> >> +	}
> >> +	gts->avail_time_tables = times;
> >> +	/*
> >> +	 * This is just to survive a unlikely corner-case where times in the
> >> +	 * given time table were not unique. Else we could just trust the
> >> +	 * gts->num_itime.  
> > 
> > If integration times aren't unique I'd count it as driver bug and error out
> > /scream.  Papering over things like this just make code harder to review
> > to deal with what is probably a driver bug.  
> 
> I am not entirely sure. I don't know the sensor ICs in details, but I've 
> seen plenty of other ICs where we may have different register values 
> that mean same physical measure. One such example is almost all ROHM 
> PMICs, where we often see voltage selection registers like:

> 
> register val 0 to <foo>:
>   - 1.0V + (val * 10 mV)
> register val <A> to <MAX>:
>   - 3.3 V
> 
> If we have similar registers for the time, then it may be good idea to 
> accept selectors A...MAX to have the same time. This allows the 
> gts-helpers to be used to convert the register values to times also for 
> such devices. If we don't allow same times to be in the tables, then 
> there may be unknown but valid register values read from the IC.

That I agree with.  Should the driver support more that one such option.
No it shouldn't.   Snarky comments about repeated values are fine ;)
I'd argue the driver has a bug if it hasn't hammered the device into a
known state (typically via a documented reset value).   We always have
fun corners where devices will accept reserved values and driver very
rarely handle reading them back right - because we arrange that they are
definitely not set by resetting the device.



> >> +
> >> +int iio_gts_find_gain_by_sel(struct iio_gts *gts, int sel)
> >> +{
> >> +	int i;
> >> +
> >> +	for (i = 0; i < gts->num_hwgain; i++)
> >> +		if (gts->hwgain_table[i].sel == sel)
> >> +			return gts->hwgain_table[i].gain;
> >> +
> >> +	return -EINVAL;
> >> +}
> >> +EXPORT_SYMBOL_GPL(iio_gts_find_gain_by_sel);
> >> +
> >> +int iio_gts_get_min_gain(struct iio_gts *gts)  
> > 
> > Could just use min = INT_MAX;
> > (indirectly from linux/limits.h, it's actually in vdso/limits.h
> > but should not include that directly I think)
> > then I don't hink you need the special casing for the
> > first entry.  
> 
> Hmm. I guess you think we don't need to handle case num_hwgain == 0 here 
> as it should be checked in the initialization routine. Not sure what to 
> think about it.

Yup. Using this code without having multiple hardware gains would be odd.
Even if you did I still feel that num_hwgain == 1 would be correct setting.


....

> > 
> > Currently can be negative.  Even when you stop that being the case
> > by makign time unsigned, you need to be careful with ranges here.
> > You may be better off separating the error handling from the values
> > to avoid any issues even though that makes it a little harder to use.  
> 
> Yes. As I wrote above, I thought that the driver author needs to ensure 
> the valid times would always be positive. I was guessing usec is going 
> to be used as unit for most cases and 2000+ seconds is probably 
> sufficient. But yes, I guess I should have documented this.

Why not just check this at init?  Otherwise this will be a tricky bug
to track down. Documentation is good, but code that tells you no is even
better.

> 
> Hmm. Do you think we should support times larger than can be represented 
> by signed int? I'd rather not support that if it is not needed as it 
> will make this quite a bit more complex.

Probably not - if needed by someone else they can add it.

> 
> >> +}
> >> +EXPORT_SYMBOL_GPL(iio_gts_find_int_time_by_sel);
> >> +
> >> +int iio_gts_find_sel_by_int_time(struct iio_gts *gts, int time)
> >> +{
> >> +	const struct iio_itime_sel_mul *itime;
> >> +
> >> +	itime = iio_gts_find_itime_by_time(gts, time);
> >> +	if (!itime)
> >> +		return -EINVAL;
> >> +
> >> +	return itime->sel;  
> > 
> > itime->sel can be negative.  I wonder if you should just make that
> > u16 so that you can always return it as a positive integer but
> > having it as unsigned in the structure.  
> 
> Here I did the same assumption of sel sizes. I don't expect we to see 32 
> bit selectors. To tell the truth, I just followed the linear_ranges 
> logic which is heavily used in the regulator drivers.
> 
> > Otherwise you need to add some docs on those limits and probably
> > sanity check them during the _init()  
> 
> I am almost certain the sanity check is going to be an overkill, but it 
> sure is doable. The onlu corner case I can think of is if register 
> really accepts the time itself as a "selector" - but even then having 
> such large values they would use the whole 32bits would be unlikely.

I'd be fine with clear documentation of the limits, but it it's trivial
to check they are being obeyed, that makes for an easier to use bit
of code.

> 
> >> +}
> >> +EXPORT_SYMBOL_GPL(iio_gts_find_sel_by_int_time);
> >> +
> >> +static int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time)
> >> +{
> >> +	const struct iio_itime_sel_mul *itime;
> >> +
> >> +	if (!iio_gts_valid_gain(gts, gain))
> >> +		return -EINVAL;
> >> +
> >> +	if (!gts->num_itime)
> >> +		return gain;
> >> +
> >> +	itime = iio_gts_find_itime_by_time(gts, time);
> >> +	if (!itime)
> >> +		return -EINVAL;
> >> +
> >> +	return gain * itime->mul;  
> > 
> > Check for overflow perhaps?  
> 
> I think that if we want to add the overflow checks, we should do that 
> already in init. That way we can check all the combinations before they 
> are used - so that the driver authors get the errors even if they did 
> not test all the times/gains their HW is supporting. I am not really 
> convinced it's worth though.

Gains can get very very large, so in this one case I'd check it. Fine
to do it at init though.  Note the large gains sometimes come about because
SI units sometimes mean the obvious base unit is very small or very big.



> 
> > If you can make the units explicit in the parameter that's even better.  
> 
> My very initial idea was that the driver should know the units and that 
> these helpers would do no unit conversions. I am unsure what road to 
> take here now. I kind of like fixing the units - but on the other hand, 
> allowing driver authors to decide the units makes this more flexible (as 
> units can be chosen so that times won't overflow).
> 
> OTOH, now that there is the iio_gts_avail_times() - helper, it would be 
> good to have the returned times in correct units. I guess we have same 
> integration-time unit specified for all types of sensors? If yes, then 
> it would be cleanest to require units in this format, especially if it 
> is not likely to cause problems with the overflows.
> 
> > I will note that negative times seem unlikely so maybe that should always
> > be unsigned?  gain probably can be negative even if that's unusual.
> > That may lead to problems though as lin_scale is in turn unsigned.  
> 
> Yes. I plan to support only positive gains. At least for now.
> 
> >   
> >> +
> >> +/**
> >> + * iio_gts_find_new_gain_sel_by_old_gain_time - compensate time change  
> > 
> > compensate for time change  
> 
> thanks :)
> 
> Oh, and by the way - I appreciate the review and suggestions even when I 
> do not always agree with them. So, thanks again for all the effort!

No problem

J
> 
> Yours,
> 	-- Matti
> 

