Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195106EF1BD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240308AbjDZKML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239464AbjDZKMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:12:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93EA3C1F;
        Wed, 26 Apr 2023 03:12:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71E2C63514;
        Wed, 26 Apr 2023 10:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3434BC433EF;
        Wed, 26 Apr 2023 10:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682503923;
        bh=Q1pkdHI82YRaZX6Y8FThpKLfzCI1n/+xSg+uFsLfR2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=myHs7Hz7urg5HciZ9IL26A6UAMyuKh0PSMweZ8W0ZZPJqKTCvtscSLXFoQsV//Tul
         wECjTeWZ5+u2rKvsOYARfvRTFlWr2IvDgxdNraxC7qUlrk0mC0zB1GTCyV3RMp2qzy
         QgSnzyvk3z4oxAGqQ70b+4y1VuyUFmwMK9lUrpHIsyjWUy5SQyonvkQs/oU1TEIp9O
         mYV1TrWVSB8Aoi54YchDzHEUe3e+gPSNP+f1ESA3fImsf2uamwx0szjIxkUfoVXyYV
         RFnSTJGDfNedA4OGMMyEwZ6EobREal72cmCu6MriXj4VutFxHRPV7fNT4i6fUE214V
         Vv573ZLPaGwLw==
Date:   Wed, 26 Apr 2023 12:12:00 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: light: ROHM BU27008 color sensor
Message-ID: <20230426101200.7czyp6nlg44tweyb@intel.intel>
References: <cover.1682340947.git.mazziesaccount@gmail.com>
 <d51d5e2b3eff65fd86aeb47840db9cd413d96668.1682340947.git.mazziesaccount@gmail.com>
 <20230425164522.sljcniui5ox5yx3l@intel.intel>
 <102a1605-d6dc-80c7-2075-212569c97042@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <102a1605-d6dc-80c7-2075-212569c97042@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

> Thanks for the review! It's nice to see you're still keeping an eye on ROHM
> / Kionix senor drivers ;)

yeah... this is fun... if I just had a bit more time :)

> > > +static int bu27008_read_one(struct bu27008_data *data, struct iio_dev *idev,
> > > +			    struct iio_chan_spec const *chan, int *val, int *val2)
> > > +{
> > > +	int ret, int_time;
> > > +
> > > +	ret = bu27008_chan_cfg(data, chan);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = bu27008_meas_set(data, BU27008_MEAS_EN);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	int_time = bu27008_get_int_time(data);
> > > +	if (int_time < 0)
> > > +		int_time = 400000;
> > > +
> > > +	msleep((int_time + 500) / 1000);
> > 
> > What is this 500 doing? Is it making a real difference? it's
> > 0.5ms.
> 
> Thanks for the question, having extra pairs of eyes helps spotting
> brainfarts :)
> 
> The 500 here is half of the value of the divider - idea was to do rounding
> correctly upwards to prevent premature wake-up. Well, this is incorrect
> because we should always round up the sleep time, not just 'mathematically
> correctly' (Eg, not only upwards when value >= 0.5 but upwards always when
> the division is not even).
> 
> After this being said, integration times for this device are full milli
> seconds so they can all be divided by 1000 uS.
> 
> Nevertheless, it's good to note that the sensor is definitely not being
> clocked by the same clock as CPU and I assume the timing for it will be
> drifting quite a bit from the CPU clock. This means some sensors will for
> sure complete the measurement later than this wake-up. In order to tackle
> this we have the valid-bit polling in bu27008_chan_read_data(). So, at the
> end of the day, this rounding correction is lkely to be just some
> unnecessary noise.

I understand the logic of the waiting, but msleep is not the
right function as waiting with msleep is always very approximate,
that's why it's recommended to use it for a large waiting period,
where the error is smaller.

If int_time is 1ms, waiting 1.5 or 2 or 1, is the same thing,
most probably you will end up waiting more.

> > What's the minimum int_time? Can we set a minimum, as well, just
> > for the sake of the msleep?
> 
> Can you please elaborate what you mean by this? The minimum integration time
> for bu27008 is 55 mS and this is set in the time tables for the gts-helpers.
> The bu27008_get_int_time() should never return valid time smaller than that.

Witha minimum i mean a minimum value for the msleep to start
working decently. E.g. what if int_time is lower than 1ms? Can we
have msleep(0)?

[...]

> > > +static int bu27008_chip_init(struct bu27008_data *data)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = regmap_update_bits(data->regmap, BU27008_REG_SYSTEM_CONTROL,
> > > +			   BU27008_MASK_SW_RESET, BU27008_MASK_SW_RESET);
> > > +	if (ret)
> > > +		return dev_err_probe(data->dev, ret, "Sensor reset failed\n");
> > > +
> > > +	/*
> > > +	 * The data-sheet does not tell how long performing the IC reset takes.
> > > +	 * However, the data-sheet says the minimum time it takes the IC to be
> > > +	 * able to take inputs after power is applied, is 100 uS. I'd assume
> > > +	 * > 1 mS is enough.
> > > +	 */
> > > +	msleep(1);
> > 
> > please use usleep_range().
> 
> I prefer to not require setting up hrtimers as we have no real requirements
> for the duration of this sleep. I know the msleep() is likely to exceed the
> 1 mS, potentially a lot if there is things to do - but we don't really care
> at this point. The main thing is to give the HW time to reset while allowing
> other things to be scheduled.

For the reason above, msleep(1) is quite a meaningless
instruction. If you need to wait around 1ms, then usleep_range is
the function to be used.

Refer, also, to the Documentation/timers/timers-howto.rst

> > > +
> > > +	return ret;
> > > +}

[...]

> > > +static irqreturn_t bu27008_trigger_handler(int irq, void *p)
> > 
> > Do we really need to be in atomic context here? Can this be
> > handled from a thread?
> 
> As far as I understand, this is handled from a process context.

Sorry... I misread it... I thought you used request_irq() for
this and request_threaded_irq() for bu27008_irq_thread_handler().

Ignore :)

Andi
