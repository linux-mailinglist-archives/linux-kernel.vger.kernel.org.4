Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6086073D041
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 13:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjFYLGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 07:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjFYLGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 07:06:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8006AE66;
        Sun, 25 Jun 2023 04:06:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F57360B87;
        Sun, 25 Jun 2023 11:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D884C433C8;
        Sun, 25 Jun 2023 11:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687691162;
        bh=nRAz58J3/qPb9cNUseBEBlsrannStwMZjuycQQ9A+0c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ib2pmM4R8xyzukTLUrAY7eW0YZzpwiRcceu9ReZLn15VFwmRuNYZjoPEr/rbALioD
         kd6sQQApCG2NwnsNouzlmgg49Wyvk9zMJGv6CFGJLOR8fOooD7qdIna2xCW1KKf3eZ
         +ZEEReJITM5WG+R13bduSGJ/PXKhRxMggPlBBhh7g59lD4zvqeJLma19xxi1IaBm45
         982CE/o7cqrhafcxGqyKPm97YPR0RexdJjH6laSOyUtlzxXa5dt375Xdd3z0CgoxVg
         CjTjwrsPylyxhQOWQ2UzI6EK8bYdWQkEUmq46Hrk2h0/Bpw2ogHa8psk4Dl/+xruCD
         K/T+FIC7ZtJPA==
Date:   Sun, 25 Jun 2023 12:06:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Waqar Hameed <waqar.hameed@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>
Subject: Re: [PATCH 2/2] iio: Add driver for Murata IRS-D200
Message-ID: <20230625120604.3ecc54bf@jic23-huawei>
In-Reply-To: <pndo7lb1mes.fsf@axis.com>
References: <cover.1686926857.git.waqarh@axis.com>
        <d2d8f34c09a2ba0504eaba4f451412de41db2f37.1686926857.git.waqarh@axis.com>
        <20230617143508.28309834@jic23-huawei>
        <pndo7lb1mes.fsf@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +stan 0;  
> 
> (What happened here?)

No idea :)

> >> +}
> >> +
> >> +static int irsd200_write_data_rate(struct irsd200_data *data, int val)
> >> +{
> >> +	size_t idx;
> >> +	int ret;
> >> +
> >> +	for (idx = 0; idx < ARRAY_SIZE(irsd200_data_rates); ++idx) {
> >> +		if (irsd200_data_rates[idx] == val)
> >> +			break;
> >> +	}
> >> +
> >> +	if (idx == ARRAY_SIZE(irsd200_data_rates))
> >> +		return -ERANGE;
> >> +
> >> +	ret = regmap_write(data->regmap, IRS_REG_DATA_RATE, idx);
> >> +	if (ret < 0) {
> >> +		dev_err(data->dev, "Could not write data rate (%d)\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	/* Data sheet says the device needs 3 seconds of settling time. */
> >> +	ssleep(3);  
> > You aren't preventing other userspace reads / writes during that time so
> > this is a light protection at best.  
> 
> Yes, we aren't preventing anything. The hardware actually operates
> without any "errors" during this period (e.g. buffer data and events
> keep arriving). 
> 
> This is more of a guarantee that "within 3 s, the new data rate should
> be in effect". When I think about it, we should maybe just remove this
> sleep?
Interesting corner case.  I'd keep as you have it but add a little
more documentation as why.  Having this sleep will make it easy for a single
thread in userspace to get what it expects.

> 
> >> +
> >> +	return 0;
> >> +}
...

> >> +static int irsd200_write_hp_filter(struct irsd200_data *data, int val, int val2)
> >> +{
> >> +	size_t idx;
> >> +	int ret;
> >> +
> >> +	/* Truncate fractional part to one digit. */
> >> +	val2 /= 100000;
> >> +
> >> +	for (idx = 0; idx < ARRAY_SIZE(irsd200_hp_filter_freq); ++idx) {
> >> +		if (irsd200_hp_filter_freq[idx] == val2)
> >> +			break;
> >> +	}
> >> +
> >> +	if (idx == ARRAY_SIZE(irsd200_hp_filter_freq) || val != 0)
> >> +		return -ERANGE;
> >> +
> >> +	ret = regmap_field_write(data->regfields[IRS_REGF_HP_FILTER], idx);
> >> +	if (ret < 0) {  
> >
> > For regmap calls, they are (I think) all documented as returning 0 for success
> > and negative otherwise.  That lets you both check the simpler if (ret) and ...  
> 
> Maybe it _is_ too defensive here. However, I have encountered APIs where
> positive values can/has been returned (due to debug/testing or just plain
> slip ups), without any actual errors. 
> 
> However, let's trust `regmap` then. I can change to only look for `if
> (ret)` everywhere.

Indeed there are interfaces where you can get positive values.
Regmap docs specifically say they won't though so we can rely on it.

> 
> >  
> >> +		dev_err(data->dev, "Could not write hp filter frequency (%d)\n",
> >> +			ret);
> >> +		return ret;  
> >
> > drop this return ret out of the if block here.
> >
> > In general being able to ignore possibility of ret > 0 simplifies handling.  
> 
> I try to be consistent and it also "helps" the next person potentially
> adding code after the `if`-statement and forgetting about adding
> `return`. We can drop the `return here, but then we should do the same
> in other places with a check just before the last `return` (like
> `irsd200_write_timer()`, `irsd200_read_nr_count()`,
> `irsd200_write_nr_count()` and many more), right?

I don't feel particulartly strongly about this, but there are scripts
that get used to scan for this pattern to simplify the code.

Sure on the other cases. I don't tend to try and label all cases of things
pointed out, just pick on one and rely on the patch author to generalise.

> 
> [...]
> 
> >> +
> >> +static int irsd200_write_event(struct iio_dev *indio_dev,
> >> +			       const struct iio_chan_spec *chan,
> >> +			       enum iio_event_type type,
> >> +			       enum iio_event_direction dir,
> >> +			       enum iio_event_info info, int val, int val2)
> >> +{
> >> +	struct irsd200_data *data = iio_priv(indio_dev);
> >> +
> >> +	switch (info) {
> >> +	case IIO_EV_INFO_VALUE:
> >> +		return irsd200_write_threshold(data, dir, val);
> >> +	case IIO_EV_INFO_TIMEOUT:
> >> +		return irsd200_write_timer(data, val, val2);
> >> +	case IIO_EV_INFO_PERIOD:
> >> +		return irsd200_write_nr_count(data, val);
> >> +	case IIO_EV_INFO_LOW_PASS_FILTER_3DB:
> >> +		return irsd200_write_lp_filter(data, val);
> >> +	case IIO_EV_INFO_HIGH_PASS_FILTER_3DB:
> >> +		return irsd200_write_hp_filter(data, val, val2);  
> >
> > Just to check - filtering is only on the data being used for events? Not
> > on the direct readback of the data?  Whilst that happens, it's not all that
> > common - hence the check.  
> 
> Well spotted! It actually made think here! :)
> 
> I do think it applies to the raw data (as well). Comparing that to
> `IIO_CHAN_INFO_SAMP_FREQ` (which also affects the events) we should
> therefore probably move the filtering to `struct iio_chan_spec
> irsd200_channels`, right?

Yes.

> >> +static irqreturn_t irsd200_irq_thread(int irq, void *dev_id)
> >> +{
> >> +	struct iio_dev *indio_dev = dev_id;
> >> +	struct irsd200_data *data = iio_priv(indio_dev);
> >> +	enum iio_event_direction dir;
> >> +	unsigned int lower_count;
> >> +	unsigned int upper_count;
> >> +	unsigned int status = 0;
> >> +	unsigned int source = 0;
> >> +	unsigned int clear = 0;
> >> +	unsigned int count = 0;
> >> +	int ret;
> >> +
> >> +	ret = regmap_read(data->regmap, IRS_REG_INTR, &source);
> >> +	if (ret) {
> >> +		dev_err(data->dev, "Could not read interrupt source (%d)\n",
> >> +			ret);
> >> +		return IRQ_NONE;
> >> +	}
> >> +
> >> +	ret = regmap_read(data->regmap, IRS_REG_STATUS, &status);
> >> +	if (ret) {
> >> +		dev_err(data->dev, "Could not acknowledge interrupt (%d)\n",
> >> +			ret);
> >> +		return IRQ_NONE;
> >> +	}
> >> +
> >> +	if (status & BIT(IRS_INTR_DATA) && iio_buffer_enabled(indio_dev)) {
> >> +		iio_trigger_poll_nested(indio_dev->trig);
> >> +		clear |= BIT(IRS_INTR_DATA);
> >> +	}
> >> +
> >> +	if (status & BIT(IRS_INTR_TIMER) && source & BIT(IRS_INTR_TIMER)) {
> >> +		iio_push_event(indio_dev,
> >> +			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
> >> +						    IIO_EV_TYPE_CHANGE,
> >> +						    IIO_EV_DIR_NONE),  
> >
> > As below, I'd like more explanation of what this is.
> > I can't find a datasheet to look it up in.  
> 
> This is a timer for the detection event window time, i.e. the signal
> should pass the threshold values within this time in order to get an
> interrupt (`IIO_EV_TYPE_THRESH`).
> 
> You setup the window time (`IIO_EV_INFO_TIMEOUT`), and when this timer
> has expired, you get this interrupt (and thus `IIO_EV_TYPE_CHANGE`). I
> couldn't find any other more fitting value in `enum iio_event_type`.

I'm not totally following.   This is some sort of watchdog?  If threshold
not exceeded for N seconds an interrupt occurs?  

Change is definitely not indicating that, so not appropriate ABI to use.
Timeout currently has a very specific defined meaning and it's not this
(see the ABI docs - to do with adaptive algorithm jumps - we also have
reset_timeout but that's different again).

This probably needs some new ABI defining.  I'm not sure what will work
best though as it's kind of a 'event did not happen' signal if I've understood
it correctly?

> 
> >> +			       iio_get_time_ns(indio_dev));
> >> +		clear |= BIT(IRS_INTR_TIMER);
> >> +	}
> >> +
> >> +	if (status & BIT(IRS_INTR_COUNT_THR_OR) &&
> >> +	    source & BIT(IRS_INTR_COUNT_THR_OR)) {
> >> +		/*
> >> +		 * The register value resets to zero after reading. We therefore
> >> +		 * need to read once and manually extract the lower and upper
> >> +		 * count register fields.
> >> +		 */
> >> +		ret = regmap_read(data->regmap, IRS_REG_COUNT, &count);
> >> +		if (ret)
> >> +			dev_err(data->dev, "Could not read count (%d)\n", ret);
> >> +
> >> +		upper_count = IRS_UPPER_COUNT(count);
> >> +		lower_count = IRS_LOWER_COUNT(count);
> >> +
> >> +		/*
> >> +		 * We only check the OR mode to be able to push events for
> >> +		 * rising and falling thresholds. AND mode is covered when both
> >> +		 * upper and lower count is non-zero, and is signaled with
> >> +		 * IIO_EV_DIR_EITHER.  
> >
> > Whey you say AND, you mean that both thresholds have been crossed but also that
> > in that configuration either being crossed would also have gotten us to here?
> > (as opposed to the interrupt only occurring if value is greater than rising threshold
> >  and less than falling threshold?)
> >
> > If it's the first then just report two events.  Either means we don't know, rather
> > than we know both occurred.  We don't document that well though - so something
> > we should improved there. whilst a bit confusing: 
> > https://elixir.bootlin.com/linux/v6.4-rc6/source/Documentation/ABI/testing/sysfs-bus-iio#L792
> > talks about this.
> >
> > The bracketed case is more annoying to deal with so I hope you don't mean that.
> > Whilst we've had sensors that support it in hardware for years, I don't think we
> > ever came up with a usecase that really justified describing it.  
> 
> According to the data sheet (which will hopefully be soon publicly
> available):
> 
> OR-interrupt:  (UPPER_COUNT + LOWER_COUNT >= NR_COUNT)
> 
> AND-interrupt: (UPPER_COUNT + LOWER_COUNT >= NR_COUNT) &&
>                (UPPER_COUNT != 0) && (LOWER_COUNT != 0)
>                
> For example, consider the following situation:
> 
>                                ___
>                               /   \
> -----------------------------3------------------- Upper threshold
>                ___          /       \
> ______        /   \        /         \___________ Data signal
>       \      /     \      /
> -------1------------2---------------------------- Lower threshold
>         \__/         \__/
>         
> When `NR_COUNT` is set to 3, we will get an OR-interrupt on point "3" in
> the graph above. In this case `UPPER_COUNT = 1` and `LOWER_COUNT = 2`.
> 
> When `NR_COUNT` is set to 2, we will get an OR-interrupt on point "2"
> instead. Here `UPPER_COUNT = 0` and `LOWER_COUNT = 2`.
> 

Thanks.  That is very odd definition of AND.  At least OR is close to normal
though the way count is applied is unusual.  Most common thing similar to that
is what we use period for in IIO - it's same count here, but it resets once
the condition is no longer true.  Here we have a running total...

Getting this into standard ABI or anything approaching it is going to be tricky.

Firstly need a concept similar to period but with out the reset. That will at least
allow us to comprehend the counts part.

Either can then be used for the OR case.

The AND case is a mess so for now I'm stuck.  Will think some more on this.
Out of curiosity does the datasheet include why that particular function makes
any sense?  Feels like a rough attempt to approximate something they don't have
hardware resources to actually estimate.

Jonathan
