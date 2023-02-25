Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD556A2AD9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 17:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBYQrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 11:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYQrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 11:47:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84D512BCC;
        Sat, 25 Feb 2023 08:47:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30AF0B80B05;
        Sat, 25 Feb 2023 16:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1ECAC433D2;
        Sat, 25 Feb 2023 16:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677343628;
        bh=e119iKsdnkJ1lzODCqQMvakq1hk2yYA+ibk/FsBnh5Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n6Vh40mGgWJh2zMwl7XPPzzkPoL5On9PZKcGjUpy3mN65kCLBWVhF9m8q9FqXGLNk
         S42d3PyRyAAUDzvrGqZOIpf/L8WR0O5UqimRIGaQdQrvm0FjwfclhQlXWpTmRDfXYZ
         bQdO+jbQYhfKRY4Jvk68w/YF2UppqDZBQ5xB4EBsUPJVm5ZKrAVKjXIV7ms0isaYrT
         jaN6GO90dnH5vPPFeEObfFd76tAieuuYShlZbvLZ6F7S8YQs9U3TW1xdySN6WRoL8M
         iQLZrlTuJ5x3SfCvO72KjBHsYGHpG+1HtlHHnWXY/botShCAIT7uzj9vEM1SIww6zv
         oEmuFf1pZKTQA==
Date:   Sat, 25 Feb 2023 17:01:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: Add driver for TI ADS1100 and ADS1000
 chips
Message-ID: <20230225170131.0afbfcb6@jic23-huawei>
In-Reply-To: <18a6b72b-4165-c9e7-3dc7-81fa85f0e4e9@topic.nl>
References: <20230217093128.8344-1-mike.looijmans@topic.nl>
        <20230217093128.8344-2-mike.looijmans@topic.nl>
        <20230218164832.695fe5b5@jic23-huawei>
        <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.02fda1de-62d6-4f7a-9537-1a2cd4a482bd@emailsignatures365.codetwo.com>
        <18a6b72b-4165-c9e7-3dc7-81fa85f0e4e9@topic.nl>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Feb 2023 12:03:05 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> Comments below - mailserver has a top-post fetish and will inject a 
> signature here somewhere...
> 
> No further comment from me means "agree, will implement in v2"...

One 'nice to have' when replying where you have chunks like that
is to just crop them out so it's easier to spot the interesting bits.

I've done that below.

> 
> 
> 
> Met vriendelijke groet / kind regards,
> 
> Mike Looijmans
> System Expert
> 
> 
> TOPIC Embedded Products B.V.
> Materiaalweg 4, 5681 RJ Best
> The Netherlands
> 
> T: +31 (0) 499 33 69 69
> E: mike.looijmans@topicproducts.com
> W: www.topic.nl
> 
> Please consider the environment before printing this e-mail
> On 18-02-2023 17:48, Jonathan Cameron wrote:
> > On Fri, 17 Feb 2023 10:31:28 +0100
> > Mike Looijmans <mike.looijmans@topic.nl> wrote:
> >  
> >> The ADS1100 is a 16-bit ADC (at 8 samples per second).
> >> The ADS1000 is similar, but has a fixed data rate.
> >>
> >> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>  
> > Hi Mike,
> >
> > I probably overlapped a lot in here with what Andy said, so just ignore
> > anything you've already fixed.
> >
> > Biggest thing is HARDWAREGAIN.
> > That is very rarely used with ADCs.  It exists to support cases where
> > the gain is not directly coupled to the thing being measured (light
> > sensitivity of a time of flight sensor for example).  Userspace expects
> > to use SCALE to both control amplifier gains and to multiply with
> > the _raw value to get a value in the real world units.
> >
> > It's a bit fiddly to do the computation, but typically at start up time
> > you work out what the combination of each PGA gain and the reference
> > voltage means for the scales available and stash that somewhere to use later.  
> 
> Complicating factor with this ADC is that the final gain value depends 
> on the sampling rate as well as the power supply voltage. Which would 
> lead to the "available" list being different after changing the sample 
> rate and confusing userspace. If a userspace app would read the 
> available sample rates and gains, and then proceeded to set them, the 
> results would be weird, as the order in which they were set would 
> matter. Setting the gain after setting the sample rate would likely 
> result in an EINVAL error because the selected gain is no longer applicable.
> 
> To me it seemed more logical to provide the analog amplification and 
> sample rate as separate, unrelated values.

It may be logical, but it isn't how the IIO ABI has ever worked and it doesn't
extend to more complex cases.  It's in general true that a PGA will result
in a change to the scale that userspace needs to apply. There are devices
where it doesn't. There are lots of things that at first glance 'could'
affect scale but often do it in complex non linear ways that userspace
simply can't know about - hence if we are pushing calculations into userspace
we need it to just be (_raw + _offset) * _scale.
Note that there is some wiggle room with how raw "raw" is.

There are two solutions that have been taken in drivers.
1) The above software flow is broken as any ABI write in IIO is allowed
   to affect other ABI elements.  This is less than ideal though.
2) Let the scale free float.  So the attempt is to keep as close as possible
   to the set value as other things change (i.e. the sampling frequency).
   The scale_avail reflects current settings of everything else, and indeed
   changes with other ABI wirtes (this is quite common) but the interface is
   made more intuitive by matching as closely as possible. Thus if you change the
   sampling rate and the scale changes then you attempt to modify the PGA
   to keep it approximately the same.  Obviously it clamps at end points
   but nothing we can do about that.

However, having said that, I don't 'think' we need either here...
A common thing to do for scale vs sampling rate (which is typically
either oversampling based, or based on another SAR cycle) is to just shift
the raw data to incorporate it - a common sensor design is to justify it
so that the unused bits are the LSBs - so may be a case of just not shifting
it to compensate for the datarate change.. That's not true here if I read
the datasheet correctly, but a simple 
sysfs raw read value == raw_value << (16 - bits for data rate) should fix that.

Interesting the datasheet argues they deliberately right aligned and sign extended
to allow oversampling without shifts, though counter argument is they made everyone
who wants a real scale apply a shift.  I guess it depends on the expected use case.


> >> +
> >> +static const struct iio_chan_spec ads1100_channel = {
> >> +	.type = IIO_VOLTAGE,
> >> +	.differential = 0,
> >> +	.indexed = 0,
> >> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> >> +	.info_mask_shared_by_all =
> >> +				BIT(IIO_CHAN_INFO_SCALE) |
> >> +				BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
> >> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),
> >> +	.info_mask_shared_by_all_available =
> >> +				BIT(IIO_CHAN_INFO_HARDWAREGAIN) |  
> > Hardware gain is normally only used for cases where the gain is not
> > directly related to scale.  Things like the gain on a signal that is
> > being used for measuring time of flight.  Here you should probably
> > just be using SCALE.  
> 
> In this case, SCALE depends on SAMP_FREQ as well as GAIN. Which will be 
> very confusing to userspace.
> 
> Hoping for some leeway here...

Sorry no. Though I think applying the shift as mentioned above deals
with your data rate dependent scaling and makes this all a lot easier.


> >> +
> >> +	if (chan != 0)
> >> +		return -EINVAL;
> >> +
> >> +	ret = i2c_master_recv(data->client, buffer, sizeof(buffer));
> >> +	if (ret < 0) {
> >> +		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	*val = (s16)(((u16)buffer[0] << 8) | buffer[1]);  
> > 	*val = sign_extend32(le16_to_cpu(), 15);  
> 
> Looks be16 to me though...

:) Oops - you are of course correct.



...

> >> +	case IIO_CHAN_INFO_SCALE:
> >> +		ret = regulator_get_voltage(data->reg_vdd);
> >> +		if (ret > 0) {
> >> +			/* full-scale is the supply voltage (microvolts now) */
> >> +			*val = ret / 1000; /* millivolts, range 27000..50000 */
> >> +			*val2 = 1000 * ads1100_full_scale(data);  
> > This doesn't seem to take into account the PGA gain?  Userspace is only going
> > to apply _raw * _scale to get the real world units.  
> 
> The "full_scale" method also applies the PGA.

Indeed. I misread that code.

...

> >> +	iio_device_unregister(indio_dev);
> >> +
> >> +	ads1100_set_conv_mode(data, ADS1100_SINGLESHOT);
> >> +
> >> +	pm_runtime_disable(&client->dev);  
> > I'd expect runtime pm to be disable before messing with the conv mode.
> > With a little care you can use devm_runtime_pm_enable()  
> 
> Setting the conv mode involves I2C traffic. After runtime_disable, the 
> power supply to the chip may have been disabled, leading to 
> communication errors on the I2C bus. Hence I thought it appropriate to 
> write the config register before turning off power.

pm_runtime_disable() is disabling the runtime management of the power
not the power itself.  That you need to do after turning off the
management (thus avoiding any races)

> 
> 



