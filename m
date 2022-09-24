Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84785E8DC5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 17:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbiIXPRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 11:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIXPRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 11:17:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18654AE87F;
        Sat, 24 Sep 2022 08:17:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C2D0612E3;
        Sat, 24 Sep 2022 15:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BF5C433C1;
        Sat, 24 Sep 2022 15:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664032636;
        bh=w0l8S3HwTEScT0gFRXcTf9BVJs/08E/LSV14R+aInFg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RWuXI5pqW6NfVSK07xEIbINj6lU/KVlXAmlPUzFsLa3ByGaeWpB5rbFm3PoeJTP4+
         NGfxOv5jrPKWSt6nxNedwhqsdiZlbpVqVfhpfadsqd2uc0mmKlm5G/s4WsVwlIJBlr
         DdviFjhngaGsodAl12+4bS5F270OPcTAh23+z8xHSL+1/DCJVQVyeIm0HMI2XWVqZH
         o5TLsEXMyjt60R8ZCK+4rhv0rBf39z23GQ945XTplXOmRw+k2SMYlaqj1YznHAoBln
         TbdhWcf57GGHKsk3ndlK+lympDxHoyGpQMj7jktB7m6inSkNOit2I2Nzf6D/lD5Z4b
         Y1eCdc1g0KIcg==
Date:   Sat, 24 Sep 2022 16:17:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Message-ID: <20220924161722.6d3e165c@jic23-huawei>
In-Reply-To: <f0ef546a-0ec2-2a52-8f12-8f218960f177@gmail.com>
References: <cover.1663760018.git.mazziesaccount@gmail.com>
        <fe1088cebb0de70bcb99af517004c1816b696825.1663760018.git.mazziesaccount@gmail.com>
        <20220922180339.30138141@jic23-huawei>
        <f0ef546a-0ec2-2a52-8f12-8f218960f177@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Fri, 23 Sep 2022 09:31:12 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 9/22/22 20:03, Jonathan Cameron wrote:
> > On Wed, 21 Sep 2022 14:45:35 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> KX022A is a 3-axis Accelerometer from ROHM/Kionix. The senor features
> >> include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
> >> tap/motion detection, wake-up & back-to-sleep events, four acceleration
> >> ranges (2, 4, 8 and 16g) and probably some other cool fatures.
> >>
> >> Add support for the basic accelerometer features such as getting the
> >> acceleration data via IIO. (raw reads, triggered buffer [data-ready] or
> >> using the WMI IRQ).
> >>
> >> Important things to be added include the double-tap, motion
> >> detection and wake-up as well as the runtime power management.
> >>
> >> NOTE: Filling-up the hardware FIFO should be avoided. During my testing
> >> I noticed that filling up the hardware FIFO might mess-up the sample
> >> count. My sensor ended up in a state where amount of data in FIFO was
> >> reported to be 0xff bytes, which equals to 42,5 samples. Specification
> >> says the FIFO can hold maximum of 41 samples in HiRes mode. Also, at
> >> least once the FIFO was stuck in a state where reading data from
> >> hwardware FIFO did not decrease the amount of data reported to be in the  
> > spell check this.
> >   
> >> FIFO - eg. FIFO was "stuck". The code has now an error count and 10
> >> reads with invalid FIFO data count will cause the fifo contents to be
> >> dropped.  
> > Ouch - that's nasty.  
> 
> Indeed it is. As this commit states, this is pretty initial support for 
> the accelerometer. I want to enable people to do basic experimenting and 
> also use the component to some slow ODR solutions. Besides, having even 
> a basic support in-tree enable people to add further improvements :) So, 
> I am hoping / expecting to see improvements added also by other people 
> using this. I think that after this initial support many people still 
> _need_ for example the runtime PM. Maybe we will also end up with some 
> nicer solution to the FIFO issues.

My initial gut feeling is that, if that fifo issue doesn't have a clean
solution, we don't don't support the fifo (by default anyway -
could have a module parameter or something to turn it on).  Late handling
of interrupts is something that can happen for lots of reasons. It should
never be fatal!

> 
> Oh, please note that the patch is no longer complete. I've "snipped" 
> unrelated pieces when replying to Jonathan. I did also just silently 
> ignore the comments which I simply agree with.

Exactly as it should be!  Thanks for taking the time to do that.

> 
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>  
> > 
> > Hi Matti,
> > 
> > A somewhat superficial review as I'm short on time, but wanted to get some
> > initial comments out to you as I'd started reviewing this yesterday and not
> > sure when I'd get back to it.  
> 
> No problem Jonathan. I appreciate the feedback - and even if the review 
> has not been completed the initial feedback will already allow me to 
> rework :) I won't go anywhere so you can for sure send me more comments 
> during the coming new iterations.
> 
> Besides, I appreciate your engagement even more as some maintainers do 
> not have the time to look at the RFC patches at all. Getting even 
> initial feedback this quickly is much more than I expected! So, thanks!

I only get to RFCs because of the help others give with review of IIO
patches which means I'm not always completely snowed under!

> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +//  
> > 
> > Other than where required for SPDX use the
> > /*
> >   * Copyright...
> >   */
> > syntax.  
> 
> No problem. Some maintainers prefer having the top of the file comment 
> block looking coherent and it also pleases my eye more. Still, can be 
> changed to suit the IIO-style.

IIO style well predates SPDX in the kernel (and maybe in general!) :)

> 
> >   
> >> +// Copyright (C) 2022 ROHM Semiconductors
> >> +//
> >> +// ROHM/KIONIX KX022A accelerometer driver
> >> +  
> 
> >> +static int kx022a_i2c_probe(struct i2c_client *i2c)
> >> +{
> >> +	struct regmap *regmap;
> >> +	struct device *dev = &i2c->dev;
> >> +
> >> +	if (!i2c->irq) {  
> > 
> > There look to be 2 interrupt lines, so you need to know which
> > one this is.  fwnode_irq_get_byname() trying first int1 then
> > int2 (as only a single one might be mapped).  
> 
> Seems like you know the Kionix component(s).

Last one I had was a kxsd9 which was over 10 years ago!  Just get used
to looking through datasheets for things that we have gotten wrong before :)

> Cool! My idea is initially 
> to only support a fixed configuration with IRQ connected to the IRQ1 
> pin. The support for the second IRQ can be added when needed. I think 
> it's better to have at first something working and add features 
> iteratively when needed. I do also believe that people who add support 
> to IRQ2-pin should also be testing this. I have currently only IRQ1 
> connected.
> 
> Would a comment explaining this do?
Hmm. Binding still needs to support either interrupt, but if the driver
doesn't that's just a feature to add. Normally it's pretty simple to
do irq1 or irq2 though...
irq1 and irq2 is of course much harder!

> 
> You made me think that this should probably be explained in the 
> dt-bindings already. I need to add the irq-names and mention that if the 
> irq-names is not populated it is assumed (only) the IRQ1 is used.

New binding. Just insist that interrupt-names is provided :)
Makes for simpler code and would be good practice anyway I think.

> 
...
> 
> >> +
> >> +struct kx022a_data;
> >> +
> >> +struct kx022a_trigger {  
> > 
> > Unusual structure. IIRC we normally just squash this stuff into
> > the iio_priv structure and set the trigger devdata to the iio_dev.
> > I haven't really thought about the advantages of this way around
> > but can see a disadvantage is you get circular pointer loops
> > this way.  
> 
> I'd better admit I didn't invent this myself. I stole big parts of the 
> logic from the bmc150-accel-core.c which supports multiple triggers. (By 
> the way, I should probably metion that in the commit message). All 
> triggers are in an array - so if you only get the trigger pointer to one 
> of the triggers in the array, then calculating the start of the 
> containing struct becomes non trivial.
> 
> This does not apply to this driver now as we only support the data-ready 
> trigger so I can change this. OTOH, reading the list of features KX022A 
> hardware provides - I wouldn't be surprized to see a new trigger(s) in 
> the future. It'd be nice to get support for different modes like for 
> example capturing N events that were stored prior certain movement. 

That stuff is hard to do in a generic enough way that standard software
can support it.  Still I'd be interested to see a proposal.  It's a subset
of what impact sensors tend to do.

> These might be best implemented with triggers. What is your adviece - is 
> it worth trying to keep adding new trigger(s) as a low-hanging fruit - 
> or is it just better to make the current (limited) implementation as 
> simple as possible?

Simple first.   Different matter if you add the other triggers later in
the same patch series, but history says half the interesting features
we plan to add never get added.

> 



> >> +static int kx022a_turn_on_unlock(struct kx022a_data *data)
> >> +{
> >> +	int ret;
> >> +  
> > This is not used enough that I can see a strong reason for the
> > wrapper.  Just put the two calls inline and rename the unlocked case.
> >   
> 
> I kind of see the value of the wrappers as it documents the purpose of 
> locking. It's kind of a wake-up that we really want to keep the access 
> locked during sensor 'shut-down'. I don't know how other sensors work 
> but for me the Kionix sensors requiring the sensor to be "turned off" 
> for the duration of pretty much _any_ configurations was a surprize... 

That's unusual in remotely modern devices.  It was more common some years
back to have restrictions like that.  Often I suspect the device was fine
but no one wanted to test all the corner cases of making changes whilst
it was running so they made it impossible to hit them.


> Again, I think this will be required for _all_ new configuration code we 
> add in the driver.

ok. Maybe rename the mutex to make it self describing?  Mind you I can't
think of a good name.  interlock would probably be a bit confusing though
that's what it would be called if it was on a heavy bit of machinery!

> 
> >> +	ret = __kx022a_turn_on_unlocked(data);
> >> +	mutex_unlock(&data->mutex);
> >> +
> >> +	return ret;
> >> +}

...


...

> >> +	/*
> >> +	 * Approximate timestamps for each of the sample based on the sampling
> >> +	 * frequency, timestamp for last sample and number of samples.
> >> +	 *
> >> +	 * We'd better not use the current bandwidth settings to compute the
> >> +	 * sample period. The real sample rate varies with the device and
> >> +	 * small variation adds when we store a large number of samples.
> >> +	 *
> >> +	 * To avoid this issue we compute the actual sample period ourselves
> >> +	 * based on the timestamp delta between the last two flush operations.
> >> +	 */
> >> +	if (data->old_timestamp) {
> >> +		sample_period = (data->timestamp - data->old_timestamp);
> >> +		do_div(sample_period, count);
> >> +	} else {
> >> +		sample_period = data->odr_ns;
> >> +	}
> >> +	tstamp = data->timestamp - (count - 1) * sample_period;
> >> +
> >> +	if (samples && count > samples) {
> >> +		/*
> >> +		 * Here we leave some old samples to the buffer. We need to
> >> +		 * adjust the timestamp to match the first sample in the buffer
> >> +		 * or we will miscalculate the sample_period at next round.
> >> +		 */ >> +		data->timestamp -= (count - samples) * sample_period;
> >> +		count = samples;  
> 
> Just a note not directly related to this driver. I borrowed (stoled) the 
> timestamp logic from the bmc150-accel-core.c. The bmc150-core did not 
> have this timestamp adjustment which I think is necessary in case the 
> fifo is not read empty. Someone familiar with the bmc150-accel-core.c 
> might want to check this.

Interesting point.  Probably worth sending a separate email to query this
as quite likely no one who is that position is reading this thread!

> 
> >> +	}

....


> >> +
> >> +static int kx022a_prepare_irq_pin(struct kx022a_data *data)
> >> +{
> >> +	/* Enable IRQ1 pin. Set polarity to active low */  
> > 
> > Must either handle both pins or at least know if it is irq2 and
> > treat that as no irq for now.  
> 
> I don't want to try supporting both pins for now. It makes this somewhat 
> more complex - especially if we want to support using two IRQs. That 
> will require some thorough thinking which I don't have time to do right 
> now :(
> 
> I can add the irq-names to the bindings and add check to the probe so 
> that if the irq2 is used we error out with nice 'not supported' message.
> 

A slightly nicer thing to do is support one irq, but let it be either irq1 or
irq2. If both are supplied just ignore the second one.  People have
an 'amusing' habit of only wiring up irq2 on boards.

...


> >> +static int kx022a_fifo_enable(struct kx022a_data *data)
> >> +{
> >> +	int ret = 0;
> >> +
> >> +	ret = kx022a_turn_off_lock(data);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/* Write WMI to HW */  
> > 
> > Where WMI is?  
> 
> Stored in the iio_priv. data->watermark. The kx022a_set_watermark() only 
> updates the value in iio_priv() and we take it in use only when the 
> buffer is enabled.

/* Write watermark to HW */ ?

> 
> 
>
> >> +/* Read the data from the fifo and fill IIO buffers */
> >> +static irqreturn_t kx022a_irq_thread_handler(int irq, void *private)
> >> +{
> >> +	struct iio_dev *idev = private;
> >> +	struct kx022a_data *data = iio_priv(idev);
> >> +	bool ack = false;
> >> +	int ret;
> >> +
> >> +	mutex_lock(&data->mutex);
> >> +
> >> +	if (data->state & KX022A_STATE_FIFO) {
> >> +		ret = __kx022a_fifo_flush(idev, KX022A_FIFO_LENGTH, true);
> >> +		if (ret > 0)
> >> +			ack = true;
> >> +	}
> >> +	/*
> >> +	 * WMI and data-ready IRQs are acked when results are read. If we add
> >> +	 * TILT/WAKE or other IRQs - then we may need to implement the acking
> >> +	 * (which is racy).  
> > 
> > I'm not even going to ask for more info at this stage but that sound worrying.  
> 
> Yep, you didn't ask but I can still babble a bit :) It's just about the 
> fact that this (and many other) Kionix sensors clear all IRQs when a 
> single bit of a single register is written. This naturally is racy 
> because there will always be a time-window for new IRQs to trigger 
> between reading the active IRQs and writing the ack. So with this acking 
> mechanism we do potentially lose IRQs.
> 
> It might be there were separate ack registers for both of the IRQ pins - 
> meaning we might be able to use separate pins for separate (ackable) 
> IRQs - and be able to support two IRQs without an acking race. This 
> however would require some logic for which pin to use for which IRQ - 
> and potentially this selection could be HW dependant. Currently I am not 
> supporting anything but watermark and data-ready, both of which get 
> cleaned when data is read. It's still worth mentioning that care must be 
> taken if ackable IRQs are to be added...

Fair enough.  I 'love' stupid designs like this.  If you want another
silly interrupt example, take the PCI Data Object Exchanges spec that
has caused me much woe over the last year :) 

For this one, probably a case of only one interrupt source at a time
(or one per pin as you suggest).

> 
> >> +	struct kx022a_data *data = t->data;
> >> +
> >> +	enable_irq(data->irq);
> >> +}
> >> +
> >> +static const struct iio_trigger_ops kx022a_trigger_ops = {
> >> +	.set_trigger_state = kx022a_trigger_set_state,
> >> +	.reenable = kx022a_trig_reen,
> >> +};
> >> +
> >> +static int kx022a_chip_init(struct kx022a_data *data)
> >> +{
> >> +	int ret, dummy;
> >> +
> >> +	/*
> >> +	 * Disable IRQs because if the IRQs are left on (for example by
> >> +	 * a shutdown which did not deactivate the accelerometer) we do
> >> +	 * most probably end up flooding the system with unhandled IRQs
> >> +	 * and get the line disabled from SOC side.
> >> +	 */
> >> +	ret = regmap_write(data->regmap, KX022A_REG_INC4, 0);  
> > 
> > Unusual to do this rather than a reset.  Quick look suggests there is
> > a suitable software reset (CNTL2)  
> 
> Same thing was just told me by a colleague of mine yesterday. Reset 
> simplifies this quite a bit. (I just wonder if we can trust the reset 
> always initializes the IC to same defaults or if there may be OTP 
> differencies. I am new to these sensors).
> 

I really hope we can rely on any documented reset values!

Jonathan
