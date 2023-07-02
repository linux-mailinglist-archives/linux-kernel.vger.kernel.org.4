Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE07744D55
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 12:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjGBKmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 06:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGBKmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 06:42:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1BC18D;
        Sun,  2 Jul 2023 03:42:31 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qv5Dy5h7rz6J6qN;
        Sun,  2 Jul 2023 18:40:50 +0800 (CST)
Received: from localhost (10.48.51.211) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 2 Jul
 2023 11:42:27 +0100
Date:   Sun, 2 Jul 2023 18:42:22 +0800
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Waqar Hameed <waqar.hameed@axis.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>
Subject: Re: [PATCH 2/2] iio: Add driver for Murata IRS-D200
Message-ID: <20230702184222.000022c9@Huawei.com>
In-Reply-To: <pndilb5xlmt.fsf@axis.com>
References: <cover.1686926857.git.waqarh@axis.com>
        <d2d8f34c09a2ba0504eaba4f451412de41db2f37.1686926857.git.waqarh@axis.com>
        <20230617143508.28309834@jic23-huawei>
        <pndo7lb1mes.fsf@axis.com>
        <20230625120604.3ecc54bf@jic23-huawei>
        <pndilb5xlmt.fsf@axis.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.51.211]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#> >> >> +	if (status & BIT(IRS_INTR_TIMER) && source & BIT(IRS_INTR_TIMER)) {
> >> >> +		iio_push_event(indio_dev,
> >> >> +			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
> >> >> +						    IIO_EV_TYPE_CHANGE,
> >> >> +						    IIO_EV_DIR_NONE),    
> >> >
> >> > As below, I'd like more explanation of what this is.
> >> > I can't find a datasheet to look it up in.    
> >> 
> >> This is a timer for the detection event window time, i.e. the signal
> >> should pass the threshold values within this time in order to get an
> >> interrupt (`IIO_EV_TYPE_THRESH`).
> >> 
> >> You setup the window time (`IIO_EV_INFO_TIMEOUT`), and when this timer
> >> has expired, you get this interrupt (and thus `IIO_EV_TYPE_CHANGE`). I
> >> couldn't find any other more fitting value in `enum iio_event_type`.  
> >
> > I'm not totally following.   This is some sort of watchdog?  If threshold
> > not exceeded for N seconds an interrupt occurs?    
> 
> Yes, exactly.
> 
> > Change is definitely not indicating that, so not appropriate ABI to use.
> > Timeout currently has a very specific defined meaning and it's not this
> > (see the ABI docs - to do with adaptive algorithm jumps - we also have
> > reset_timeout but that's different again).
> >
> > This probably needs some new ABI defining.  I'm not sure what will work
> > best though as it's kind of a 'event did not happen' signal if I've understood
> > it correctly?  
> 
> Yeah, I'm not sure when this interrupt actually could be useful. Maybe
> when you are testing and calibrating the device, it could help to know
> that "these particular settings didn't cause the data to pass any
> thresholds during the window time"?
> 
> The alternative would be to just ignore this interrupt and not signaling
> any events for this. I don't think it would deteriorate the
> functionality of the device (except the test/calibration situation
> described above, which obviously _can_ be resolved in user space).

That's probably best way to move forwards with this. Can revisit later
if it turns out there is an important usecase!

> 
> >> >> +			       iio_get_time_ns(indio_dev));
> >> >> +		clear |= BIT(IRS_INTR_TIMER);
> >> >> +	}
> >> >> +
> >> >> +	if (status & BIT(IRS_INTR_COUNT_THR_OR) &&
> >> >> +	    source & BIT(IRS_INTR_COUNT_THR_OR)) {
> >> >> +		/*
> >> >> +		 * The register value resets to zero after reading. We therefore
> >> >> +		 * need to read once and manually extract the lower and upper
> >> >> +		 * count register fields.
> >> >> +		 */
> >> >> +		ret = regmap_read(data->regmap, IRS_REG_COUNT, &count);
> >> >> +		if (ret)
> >> >> +			dev_err(data->dev, "Could not read count (%d)\n", ret);
> >> >> +
> >> >> +		upper_count = IRS_UPPER_COUNT(count);
> >> >> +		lower_count = IRS_LOWER_COUNT(count);
> >> >> +
> >> >> +		/*
> >> >> +		 * We only check the OR mode to be able to push events for
> >> >> +		 * rising and falling thresholds. AND mode is covered when both
> >> >> +		 * upper and lower count is non-zero, and is signaled with
> >> >> +		 * IIO_EV_DIR_EITHER.    
> >> >
> >> > Whey you say AND, you mean that both thresholds have been crossed but also that
> >> > in that configuration either being crossed would also have gotten us to here?
> >> > (as opposed to the interrupt only occurring if value is greater than rising threshold
> >> >  and less than falling threshold?)
> >> >
> >> > If it's the first then just report two events.  Either means we don't know, rather
> >> > than we know both occurred.  We don't document that well though - so something
> >> > we should improved there. whilst a bit confusing: 
> >> > https://elixir.bootlin.com/linux/v6.4-rc6/source/Documentation/ABI/testing/sysfs-bus-iio#L792
> >> > talks about this.
> >> >
> >> > The bracketed case is more annoying to deal with so I hope you don't mean that.
> >> > Whilst we've had sensors that support it in hardware for years, I don't think we
> >> > ever came up with a usecase that really justified describing it.    
> >> 
> >> According to the data sheet (which will hopefully be soon publicly
> >> available):
> >> 
> >> OR-interrupt:  (UPPER_COUNT + LOWER_COUNT >= NR_COUNT)
> >> 
> >> AND-interrupt: (UPPER_COUNT + LOWER_COUNT >= NR_COUNT) &&
> >>                (UPPER_COUNT != 0) && (LOWER_COUNT != 0)
> >>                
> >> For example, consider the following situation:
> >> 
> >>                                ___
> >>                               /   \
> >> -----------------------------3------------------- Upper threshold
> >>                ___          /       \
> >> ______        /   \        /         \___________ Data signal
> >>       \      /     \      /
> >> -------1------------2---------------------------- Lower threshold
> >>         \__/         \__/
> >>         
> >> When `NR_COUNT` is set to 3, we will get an OR-interrupt on point "3" in
> >> the graph above. In this case `UPPER_COUNT = 1` and `LOWER_COUNT = 2`.
> >> 
> >> When `NR_COUNT` is set to 2, we will get an OR-interrupt on point "2"
> >> instead. Here `UPPER_COUNT = 0` and `LOWER_COUNT = 2`.
> >>   
> >
> > Thanks.  That is very odd definition of AND.  At least OR is close to normal
> > though the way count is applied is unusual.  Most common thing similar to that
> > is what we use period for in IIO - it's same count here, but it resets once
> > the condition is no longer true.  Here we have a running total...
> >
> > Getting this into standard ABI or anything approaching it is going to be tricky.
> >
> > Firstly need a concept similar to period but with out the reset. That will at least
> > allow us to comprehend the counts part.
> >
> > Either can then be used for the OR case.  
> 
> Are you saying that the current implementation (with manually checking
> the upper and lower counts only with the OR mode) wouldn't "fit" the
> current ABI? It does cover the rising and falling directions correctly,
> no? Could `IIO_EV_DIR_NONE` instead of `IIO_EV_DIR_EITHER` be used to
> signal "both" then?

The fact it's a running count (so doesn't go back to 0 when threshold is
not exceeded) is the unusual bit, not the direction.

No on none. That's for channels where there is not concept of direction.
Either is fine, but we still need to deal with the temporal element being
different from period.  For that I think we need some new ABI, but
not sure exactly what it should be.

XXX_runningperiod maybe?  Still measured in seconds, but not resetting
unlike _period...


> 
> >
> > The AND case is a mess so for now I'm stuck.  Will think some more on this.
> > Out of curiosity does the datasheet include why that particular function makes
> > any sense?  Feels like a rough attempt to approximate something they don't have
> > hardware resources to actually estimate.  
> 
> Unfortunately not. I guess there could be an application where you are
> only interested if _both_ lower and upper threshold are exceeded. Maybe
> in order to minimize small "false positives" movements in front of the
> sensor? But as stated in the comments, one can cover this with only the
> OR mode (and manually checking the upper and lower count as we do).

