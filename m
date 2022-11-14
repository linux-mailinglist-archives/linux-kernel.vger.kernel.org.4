Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C12628967
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbiKNTcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbiKNTce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:32:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD0BB7C8;
        Mon, 14 Nov 2022 11:32:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07D68613C5;
        Mon, 14 Nov 2022 19:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3141C433D6;
        Mon, 14 Nov 2022 19:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668454352;
        bh=vtfXSCrWSmffdrETGDZzpWD6bAb8L/+SOPCiGYo9hpg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YtNO+Jd3w4ma5MnXsyRkPm2NwS3c92Hi7LHtL37aQ64fHaewupfLsQHkhiqItslZL
         pqLIH09BmHD3aqf9Q28LFPlaImnO854vVCUG0ax6WvRQybjHpqRdYiCjw7P8cAoXp9
         zByT58gBJ/z6SDn+wke6rznlJB6pYyWqGr1VCKNVN3NWv/EEF5VncyPvBOcsbZy6E4
         /cbHQAbwiQ1kdReKVkBzsWInNy4bc8MWIi/DmUrWc6cMgTzlYZvgprKIdgDp300TMF
         sEmkOpXWU8f15itT9iiA2O2Ulo+vloB70UqmIKRpRqcOsnqLckgcU4yqMsatLqj5g5
         tL8lA+PEiEUGw==
Date:   Mon, 14 Nov 2022 19:44:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] iio: addac: ad74413r: add support for reset-gpio
Message-ID: <20221114194447.2528f699@jic23-huawei>
In-Reply-To: <095a454b55cf497392a621649f24e067@analog.com>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
        <20221111143921.742194-6-linux@rasmusvillemoes.dk>
        <20221112170705.7efe1673@jic23-huawei>
        <095a454b55cf497392a621649f24e067@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Mon, 14 Nov 2022 13:52:26 +0000
"Tanislav, Cosmin" <Cosmin.Tanislav@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Saturday, November 12, 2022 7:07 PM
> > To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Cc: Tanislav, Cosmin <Cosmin.Tanislav@analog.com>; Lars-Peter Clausen
> > <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> > devicetree@vger.kernel.org; Rob Herring <robh+dt@kernel.org>; linux-
> > iio@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 5/5] iio: addac: ad74413r: add support for reset-gpio
> > 
> > [External]
> > 
> > On Fri, 11 Nov 2022 15:39:21 +0100
> > Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> >   
> > > We have a board where the reset pin of the ad74412 is connected to a
> > > gpio, but also pulled low by default. Hence to get the chip out of
> > > reset, the driver needs to know about that gpio and set it high before
> > > attempting to communicate with it.  
> > 
> > I'm a little confused on polarity here.  The pin is a !reset so
> > we need to drive it low briefly to trigger a reset.
> > I'm guessing for your board the pin is set to active low? (an example
> > in the dt would have made that clearer) Hence the pulse
> > in here to 1 is actually briefly driving it low before restoring to high?
> > 
> > For a pin documented as !reset that seems backwards though you have
> > called it reset so that is fine, but this description doesn't make that
> > celar.  
> 
> My opinion is that the driver shouldn't exactly know the polarity of the reset,
> and just assume that setting the reset GPIO to 1 means putting it in reset,
> and setting it to 0 means bringing out of reset.

Agreed. I'd just like a comment + example in the dt-binding to make the point
that the pin is !reset.

Preferably with an example in the dt binding of the common case of it being wired
up to an active low pin.

The main oddity here is the need to pulse it rather than request it directly as
in the reset state and then just set that to off.

Jonathan
> 
> > 
> > Perhaps just add some more description here to make it clear the GPIO
> > is active low, and then refer to setting it to true and false to avoid
> > the confusing high / low terminology which are inverted...


> >   
> > >
> > > When a reset-gpio is given in device tree, use that instead of the
> > > software reset. According to the data sheet, the two methods are
> > > functionally equivalent.
> > >
> > > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > > ---
> > >  drivers/iio/addac/ad74413r.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> > > index 9f77d2f514de..af09d43f921c 100644
> > > --- a/drivers/iio/addac/ad74413r.c
> > > +++ b/drivers/iio/addac/ad74413r.c
> > > @@ -71,6 +71,7 @@ struct ad74413r_state {
> > >  	struct regmap			*regmap;
> > >  	struct device			*dev;
> > >  	struct iio_trigger		*trig;
> > > +	struct gpio_desc		*reset_gpio;
> > >
> > >  	size_t			adc_active_channels;
> > >  	struct spi_message	adc_samples_msg;
> > > @@ -393,6 +394,13 @@ static int ad74413r_reset(struct ad74413r_state  
> > *st)  
> > >  {
> > >  	int ret;
> > >
> > > +	if (st->reset_gpio) {
> > > +		gpiod_set_value_cansleep(st->reset_gpio, 1);
> > > +		fsleep(50);
> > > +		gpiod_set_value_cansleep(st->reset_gpio, 0);
> > > +		return 0;
> > > +	}
> > > +
> > >  	ret = regmap_write(st->regmap, AD74413R_REG_CMD_KEY,
> > >  			   AD74413R_CMD_KEY_RESET1);
> > >  	if (ret)
> > > @@ -1316,6 +1324,10 @@ static int ad74413r_probe(struct spi_device *spi)
> > >  	if (IS_ERR(st->regmap))
> > >  		return PTR_ERR(st->regmap);
> > >
> > > +	st->reset_gpio = devm_gpiod_get_optional(st->dev, "reset",  
> > GPIOD_OUT_LOW);  
> > > +	if (IS_ERR(st->reset_gpio))
> > > +		return PTR_ERR(st->reset_gpio);
> > > +
> > >  	st->refin_reg = devm_regulator_get_optional(st->dev, "refin");
> > >  	if (IS_ERR(st->refin_reg)) {
> > >  		ret = PTR_ERR(st->refin_reg);  
> 

