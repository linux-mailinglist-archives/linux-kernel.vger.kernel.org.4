Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF32747E91
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjGEHuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjGEHui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:50:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8519612B;
        Wed,  5 Jul 2023 00:50:33 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QwsFd2FrMz67Lvc;
        Wed,  5 Jul 2023 15:47:33 +0800 (CST)
Received: from localhost (10.34.206.101) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 5 Jul
 2023 08:50:29 +0100
Date:   Wed, 5 Jul 2023 15:50:24 +0800
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Waqar Hameed <waqar.hameed@axis.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>
Subject: Re: [PATCH 2/2] iio: Add driver for Murata IRS-D200
Message-ID: <20230705155024.00004362@Huawei.com>
In-Reply-To: <pnda5wdxoze.fsf@axis.com>
References: <cover.1686926857.git.waqarh@axis.com>
        <d2d8f34c09a2ba0504eaba4f451412de41db2f37.1686926857.git.waqarh@axis.com>
        <20230617143508.28309834@jic23-huawei>
        <pndo7lb1mes.fsf@axis.com>
        <20230625120604.3ecc54bf@jic23-huawei>
        <pndilb5xlmt.fsf@axis.com>
        <20230702184222.000022c9@Huawei.com>
        <pnda5wdxoze.fsf@axis.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.34.206.101]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2023 10:59:41 +0200
Waqar Hameed <waqar.hameed@axis.com> wrote:

> On Sun, Jul 02, 2023 at 18:42 +0800 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
>  [...]  
> >> >> >
> >> >> > As below, I'd like more explanation of what this is.
> >> >> > I can't find a datasheet to look it up in.      
> >> >> 
> >> >> This is a timer for the detection event window time, i.e. the signal
> >> >> should pass the threshold values within this time in order to get an
> >> >> interrupt (`IIO_EV_TYPE_THRESH`).
> >> >> 
> >> >> You setup the window time (`IIO_EV_INFO_TIMEOUT`), and when this timer
> >> >> has expired, you get this interrupt (and thus `IIO_EV_TYPE_CHANGE`). I
> >> >> couldn't find any other more fitting value in `enum iio_event_type`.    
> >> >
> >> > I'm not totally following.   This is some sort of watchdog?  If threshold
> >> > not exceeded for N seconds an interrupt occurs?      
> >> 
> >> Yes, exactly.
> >>   
> >> > Change is definitely not indicating that, so not appropriate ABI to use.
> >> > Timeout currently has a very specific defined meaning and it's not this
> >> > (see the ABI docs - to do with adaptive algorithm jumps - we also have
> >> > reset_timeout but that's different again).
> >> >
> >> > This probably needs some new ABI defining.  I'm not sure what will work
> >> > best though as it's kind of a 'event did not happen' signal if I've understood
> >> > it correctly?    
> >> 
> >> Yeah, I'm not sure when this interrupt actually could be useful. Maybe
> >> when you are testing and calibrating the device, it could help to know
> >> that "these particular settings didn't cause the data to pass any
> >> thresholds during the window time"?
> >> 
> >> The alternative would be to just ignore this interrupt and not signaling
> >> any events for this. I don't think it would deteriorate the
> >> functionality of the device (except the test/calibration situation
> >> described above, which obviously _can_ be resolved in user space).  
> >
> > That's probably best way to move forwards with this. Can revisit later
> > if it turns out there is an important usecase!  
> 
> Alright, let's skip this interrupt. However, we still need a way for
> users to specify the window time (see answer below).
> 
> >> >> >> +			       iio_get_time_ns(indio_dev));
> >> >> >> +		clear |= BIT(IRS_INTR_TIMER);
> >> >> >> +	}
> >> >> >> +
> >> >> >> +	if (status & BIT(IRS_INTR_COUNT_THR_OR) &&
> >> >> >> +	    source & BIT(IRS_INTR_COUNT_THR_OR)) {
> >> >> >> +		/*
> >> >> >> +		 * The register value resets to zero after reading. We therefore
> >> >> >> +		 * need to read once and manually extract the lower and upper
> >> >> >> +		 * count register fields.
> >> >> >> +		 */
> >> >> >> +		ret = regmap_read(data->regmap, IRS_REG_COUNT, &count);
> >> >> >> +		if (ret)
> >> >> >> +			dev_err(data->dev, "Could not read count (%d)\n", ret);
> >> >> >> +
> >> >> >> +		upper_count = IRS_UPPER_COUNT(count);
> >> >> >> +		lower_count = IRS_LOWER_COUNT(count);
> >> >> >> +
> >> >> >> +		/*
> >> >> >> +		 * We only check the OR mode to be able to push events for
> >> >> >> +		 * rising and falling thresholds. AND mode is covered when both
> >> >> >> +		 * upper and lower count is non-zero, and is signaled with
> >> >> >> +		 * IIO_EV_DIR_EITHER.      
> >> >> >
> >> >> > Whey you say AND, you mean that both thresholds have been crossed but also that
> >> >> > in that configuration either being crossed would also have gotten us to here?
> >> >> > (as opposed to the interrupt only occurring if value is greater than rising threshold
> >> >> >  and less than falling threshold?)
> >> >> >
> >> >> > If it's the first then just report two events.  Either means we don't know, rather
> >> >> > than we know both occurred.  We don't document that well though - so something
> >> >> > we should improved there. whilst a bit confusing: 
> >> >> > https://elixir.bootlin.com/linux/v6.4-rc6/source/Documentation/ABI/testing/sysfs-bus-iio#L792
> >> >> > talks about this.
> >> >> >
> >> >> > The bracketed case is more annoying to deal with so I hope you don't mean that.
> >> >> > Whilst we've had sensors that support it in hardware for years, I don't think we
> >> >> > ever came up with a usecase that really justified describing it.      
> >> >> 
> >> >> According to the data sheet (which will hopefully be soon publicly
> >> >> available):
> >> >> 
> >> >> OR-interrupt:  (UPPER_COUNT + LOWER_COUNT >= NR_COUNT)
> >> >> 
> >> >> AND-interrupt: (UPPER_COUNT + LOWER_COUNT >= NR_COUNT) &&
> >> >>                (UPPER_COUNT != 0) && (LOWER_COUNT != 0)
> >> >>                
> >> >> For example, consider the following situation:
> >> >> 
> >> >>                                ___
> >> >>                               /   \
> >> >> -----------------------------3------------------- Upper threshold
> >> >>                ___          /       \
> >> >> ______        /   \        /         \___________ Data signal
> >> >>       \      /     \      /
> >> >> -------1------------2---------------------------- Lower threshold
> >> >>         \__/         \__/
> >> >>         
> >> >> When `NR_COUNT` is set to 3, we will get an OR-interrupt on point "3" in
> >> >> the graph above. In this case `UPPER_COUNT = 1` and `LOWER_COUNT = 2`.
> >> >> 
> >> >> When `NR_COUNT` is set to 2, we will get an OR-interrupt on point "2"
> >> >> instead. Here `UPPER_COUNT = 0` and `LOWER_COUNT = 2`.
> >> >>     
> >> >
> >> > Thanks.  That is very odd definition of AND.  At least OR is close to normal
> >> > though the way count is applied is unusual.  Most common thing similar to that
> >> > is what we use period for in IIO - it's same count here, but it resets once
> >> > the condition is no longer true.  Here we have a running total...
> >> >
> >> > Getting this into standard ABI or anything approaching it is going to be tricky.
> >> >
> >> > Firstly need a concept similar to period but with out the reset. That will at least
> >> > allow us to comprehend the counts part.
> >> >
> >> > Either can then be used for the OR case.    
> >> 
> >> Are you saying that the current implementation (with manually checking
> >> the upper and lower counts only with the OR mode) wouldn't "fit" the
> >> current ABI? It does cover the rising and falling directions correctly,
> >> no? Could `IIO_EV_DIR_NONE` instead of `IIO_EV_DIR_EITHER` be used to
> >> signal "both" then?  
> >
> > The fact it's a running count (so doesn't go back to 0 when threshold is
> > not exceeded) is the unusual bit, not the direction.
> >
> > No on none. That's for channels where there is not concept of direction.
> > Either is fine, but we still need to deal with the temporal element being
> > different from period.  For that I think we need some new ABI, but
> > not sure exactly what it should be.
> >
> > XXX_runningperiod maybe?  Still measured in seconds, but not resetting
> > unlike _period...
> >  
> >> >
> >> > The AND case is a mess so for now I'm stuck.  Will think some more on this.
> >> > Out of curiosity does the datasheet include why that particular function makes
> >> > any sense?  Feels like a rough attempt to approximate something they don't have
> >> > hardware resources to actually estimate.    
> >> 
> >> Unfortunately not. I guess there could be an application where you are
> >> only interested if _both_ lower and upper threshold are exceeded. Maybe
> >> in order to minimize small "false positives" movements in front of the
> >> sensor? But as stated in the comments, one can cover this with only the
> >> OR mode (and manually checking the upper and lower count as we do).  
> 
> Hm, I see. The "cleanest" way is probably to add some new ABIs.
> 
> Let's say we add `IIO_EV_INFO_RUNNING_PERIOD` (or something) to be able
> to specify the time (in seconds) for the threshold window time
> (`irsd200_read/write_timer()`), e.g. `*_thresh_runningperiod`. We then
> also need an ABI for specifying the number of threshold counts in this
> running period (`irsd200_read/write_nr_count()`, i.e. `NR_COUNT` from
> the graph above), e.g. `*_thresh_runningcount` (or something).

Agreed.  The name may need some refinement, but this seems a good place
to start.

> 
> This would cover the OR mode. As stated before, the AND mode is much
> more complicated, and should maybe considered later (when someone
> actually has a use case)? We can signal with the direction to tell if
> both thresholds has been passed (either), compared to only exceeding one
> of them (rising or falling) in the running period.

Using either to define that both things happened would be non intuitive.
Let's resolve that question if / when it matters.

Thanks,

Jonathan


