Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBA1745A59
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjGCKe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjGCKex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:34:53 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C169D2;
        Mon,  3 Jul 2023 03:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1688380488;
  x=1719916488;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version;
  bh=GfPT0/TC/mNg+gO3bpiV162OJlaIE47Q1nZ6n4J93PE=;
  b=R7HbGbjQOHX6jj9LtCCivtleo/INXV7pBXLiD+C5DpFHEy9Mddv+47Yu
   ugQdHX1LTa/bA2saPTx8tAwtYmXUA5Iq4FKkbkTD03Yt2q5Rgb95i76Bw
   36PX8cnTkjWaW0JjE1uak3+00CrswCNMo5D3QHtVFK3pcguPngI4LfTWN
   qqzKTmvuJARVtJ4gtAYGSriawDWLz66AiD2+Wr/ftNFkdzFD6Blv3arCm
   12Fb8WPWOCsawX3jX0glLEr2uxxkDKD9SsJ5zWaa2ugH9pcAre9TJVD18
   45vSizkcZ9qpJ59d27U7Yxt/bsMjYXIClIzYg//DJMeFdkq/wNxCgFQhA
   A==;
References: <cover.1686926857.git.waqarh@axis.com>
 <d2d8f34c09a2ba0504eaba4f451412de41db2f37.1686926857.git.waqarh@axis.com>
 <20230617143508.28309834@jic23-huawei> <pndo7lb1mes.fsf@axis.com>
 <20230625120604.3ecc54bf@jic23-huawei> <pndilb5xlmt.fsf@axis.com>
 <20230702184222.000022c9@Huawei.com>
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>
Subject: Re: [PATCH 2/2] iio: Add driver for Murata IRS-D200
Date:   Mon, 3 Jul 2023 10:59:41 +0200
In-Reply-To: <20230702184222.000022c9@Huawei.com>
Message-ID: <pnda5wdxoze.fsf@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2023 at 18:42 +0800 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> #> >> >> +	if (status & BIT(IRS_INTR_TIMER) && source & BIT(IRS_INTR_TIMER)) {
>> >> >> +		iio_push_event(indio_dev,
>> >> >> +			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
>> >> >> +						    IIO_EV_TYPE_CHANGE,
>> >> >> +						    IIO_EV_DIR_NONE),    
>> >> >
>> >> > As below, I'd like more explanation of what this is.
>> >> > I can't find a datasheet to look it up in.    
>> >> 
>> >> This is a timer for the detection event window time, i.e. the signal
>> >> should pass the threshold values within this time in order to get an
>> >> interrupt (`IIO_EV_TYPE_THRESH`).
>> >> 
>> >> You setup the window time (`IIO_EV_INFO_TIMEOUT`), and when this timer
>> >> has expired, you get this interrupt (and thus `IIO_EV_TYPE_CHANGE`). I
>> >> couldn't find any other more fitting value in `enum iio_event_type`.  
>> >
>> > I'm not totally following.   This is some sort of watchdog?  If threshold
>> > not exceeded for N seconds an interrupt occurs?    
>> 
>> Yes, exactly.
>> 
>> > Change is definitely not indicating that, so not appropriate ABI to use.
>> > Timeout currently has a very specific defined meaning and it's not this
>> > (see the ABI docs - to do with adaptive algorithm jumps - we also have
>> > reset_timeout but that's different again).
>> >
>> > This probably needs some new ABI defining.  I'm not sure what will work
>> > best though as it's kind of a 'event did not happen' signal if I've understood
>> > it correctly?  
>> 
>> Yeah, I'm not sure when this interrupt actually could be useful. Maybe
>> when you are testing and calibrating the device, it could help to know
>> that "these particular settings didn't cause the data to pass any
>> thresholds during the window time"?
>> 
>> The alternative would be to just ignore this interrupt and not signaling
>> any events for this. I don't think it would deteriorate the
>> functionality of the device (except the test/calibration situation
>> described above, which obviously _can_ be resolved in user space).
>
> That's probably best way to move forwards with this. Can revisit later
> if it turns out there is an important usecase!

Alright, let's skip this interrupt. However, we still need a way for
users to specify the window time (see answer below).

>> >> >> +			       iio_get_time_ns(indio_dev));
>> >> >> +		clear |= BIT(IRS_INTR_TIMER);
>> >> >> +	}
>> >> >> +
>> >> >> +	if (status & BIT(IRS_INTR_COUNT_THR_OR) &&
>> >> >> +	    source & BIT(IRS_INTR_COUNT_THR_OR)) {
>> >> >> +		/*
>> >> >> +		 * The register value resets to zero after reading. We therefore
>> >> >> +		 * need to read once and manually extract the lower and upper
>> >> >> +		 * count register fields.
>> >> >> +		 */
>> >> >> +		ret = regmap_read(data->regmap, IRS_REG_COUNT, &count);
>> >> >> +		if (ret)
>> >> >> +			dev_err(data->dev, "Could not read count (%d)\n", ret);
>> >> >> +
>> >> >> +		upper_count = IRS_UPPER_COUNT(count);
>> >> >> +		lower_count = IRS_LOWER_COUNT(count);
>> >> >> +
>> >> >> +		/*
>> >> >> +		 * We only check the OR mode to be able to push events for
>> >> >> +		 * rising and falling thresholds. AND mode is covered when both
>> >> >> +		 * upper and lower count is non-zero, and is signaled with
>> >> >> +		 * IIO_EV_DIR_EITHER.    
>> >> >
>> >> > Whey you say AND, you mean that both thresholds have been crossed but also that
>> >> > in that configuration either being crossed would also have gotten us to here?
>> >> > (as opposed to the interrupt only occurring if value is greater than rising threshold
>> >> >  and less than falling threshold?)
>> >> >
>> >> > If it's the first then just report two events.  Either means we don't know, rather
>> >> > than we know both occurred.  We don't document that well though - so something
>> >> > we should improved there. whilst a bit confusing: 
>> >> > https://elixir.bootlin.com/linux/v6.4-rc6/source/Documentation/ABI/testing/sysfs-bus-iio#L792
>> >> > talks about this.
>> >> >
>> >> > The bracketed case is more annoying to deal with so I hope you don't mean that.
>> >> > Whilst we've had sensors that support it in hardware for years, I don't think we
>> >> > ever came up with a usecase that really justified describing it.    
>> >> 
>> >> According to the data sheet (which will hopefully be soon publicly
>> >> available):
>> >> 
>> >> OR-interrupt:  (UPPER_COUNT + LOWER_COUNT >= NR_COUNT)
>> >> 
>> >> AND-interrupt: (UPPER_COUNT + LOWER_COUNT >= NR_COUNT) &&
>> >>                (UPPER_COUNT != 0) && (LOWER_COUNT != 0)
>> >>                
>> >> For example, consider the following situation:
>> >> 
>> >>                                ___
>> >>                               /   \
>> >> -----------------------------3------------------- Upper threshold
>> >>                ___          /       \
>> >> ______        /   \        /         \___________ Data signal
>> >>       \      /     \      /
>> >> -------1------------2---------------------------- Lower threshold
>> >>         \__/         \__/
>> >>         
>> >> When `NR_COUNT` is set to 3, we will get an OR-interrupt on point "3" in
>> >> the graph above. In this case `UPPER_COUNT = 1` and `LOWER_COUNT = 2`.
>> >> 
>> >> When `NR_COUNT` is set to 2, we will get an OR-interrupt on point "2"
>> >> instead. Here `UPPER_COUNT = 0` and `LOWER_COUNT = 2`.
>> >>   
>> >
>> > Thanks.  That is very odd definition of AND.  At least OR is close to normal
>> > though the way count is applied is unusual.  Most common thing similar to that
>> > is what we use period for in IIO - it's same count here, but it resets once
>> > the condition is no longer true.  Here we have a running total...
>> >
>> > Getting this into standard ABI or anything approaching it is going to be tricky.
>> >
>> > Firstly need a concept similar to period but with out the reset. That will at least
>> > allow us to comprehend the counts part.
>> >
>> > Either can then be used for the OR case.  
>> 
>> Are you saying that the current implementation (with manually checking
>> the upper and lower counts only with the OR mode) wouldn't "fit" the
>> current ABI? It does cover the rising and falling directions correctly,
>> no? Could `IIO_EV_DIR_NONE` instead of `IIO_EV_DIR_EITHER` be used to
>> signal "both" then?
>
> The fact it's a running count (so doesn't go back to 0 when threshold is
> not exceeded) is the unusual bit, not the direction.
>
> No on none. That's for channels where there is not concept of direction.
> Either is fine, but we still need to deal with the temporal element being
> different from period.  For that I think we need some new ABI, but
> not sure exactly what it should be.
>
> XXX_runningperiod maybe?  Still measured in seconds, but not resetting
> unlike _period...
>
>> >
>> > The AND case is a mess so for now I'm stuck.  Will think some more on this.
>> > Out of curiosity does the datasheet include why that particular function makes
>> > any sense?  Feels like a rough attempt to approximate something they don't have
>> > hardware resources to actually estimate.  
>> 
>> Unfortunately not. I guess there could be an application where you are
>> only interested if _both_ lower and upper threshold are exceeded. Maybe
>> in order to minimize small "false positives" movements in front of the
>> sensor? But as stated in the comments, one can cover this with only the
>> OR mode (and manually checking the upper and lower count as we do).

Hm, I see. The "cleanest" way is probably to add some new ABIs.

Let's say we add `IIO_EV_INFO_RUNNING_PERIOD` (or something) to be able
to specify the time (in seconds) for the threshold window time
(`irsd200_read/write_timer()`), e.g. `*_thresh_runningperiod`. We then
also need an ABI for specifying the number of threshold counts in this
running period (`irsd200_read/write_nr_count()`, i.e. `NR_COUNT` from
the graph above), e.g. `*_thresh_runningcount` (or something).

This would cover the OR mode. As stated before, the AND mode is much
more complicated, and should maybe considered later (when someone
actually has a use case)? We can signal with the direction to tell if
both thresholds has been passed (either), compared to only exceeding one
of them (rising or falling) in the running period.
