Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CD16755C9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjATN2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjATN17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:27:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FC63D08F;
        Fri, 20 Jan 2023 05:27:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52A38B82827;
        Fri, 20 Jan 2023 13:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE326C433D2;
        Fri, 20 Jan 2023 13:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674221275;
        bh=Tq1E8pyeCQPwUYf1ZR4/fdWEN6omesfFHTkmVrGa92c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LfV3hfiqxwvoDK//mZGT9qFEcQnUW1SloBQDbmtwkZs6OBuu/xSZq9DKEHbQ+7mak
         vHzPQpkjwyGs59ZDZjvFTHxUELgHm/Kw7T4+ugTTbYGuWE5gu2FRaJCfFKD1iOVB3R
         JU6JgoLB22eE/7IbbQNwrp1N703HmZLoBmVyGsyLE/6LQ+1gDZGqrPtZoi8fn425AE
         89WvN7RXFq2cLKbJHoPNC1paqwU8iHBMMFhteObNfw3gdbJRHqd50S/Un1U+8U86UJ
         jY9ee9LP2rzNA8zRcv7CnrLS2U8UsAadT+PL40uL22TXdLt+9fLBlpVQeq8XUtNCq0
         7PUKvEmHlX0DQ==
Date:   Fri, 20 Jan 2023 13:27:50 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Qingtao Cao <qingtao.cao.au@gmail.com>,
        Qingtao Cao <qingtao.cao@digi.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] leds: ledtrig-tty.c: call led_set_brightness() when
 the blocking callback is not available
Message-ID: <Y8qW1tlDmw6KEIuu@google.com>
References: <20221209001039.7287-1-qingtao.cao@digi.com>
 <20221209124058.dwez7wohs7dfeiik@pengutronix.de>
 <Y7WnMISK20Z4hsg1@google.com>
 <ad4a1069-72c6-a431-336f-ed78a57a1ba0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad4a1069-72c6-a431-336f-ed78a57a1ba0@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Jan 2023, Jacek Anaszewski wrote:

> Hi all,
> 
> On 1/4/23 17:20, Lee Jones wrote:
> > On Fri, 09 Dec 2022, Uwe Kleine-König wrote:
> > 
> > > On Fri, Dec 09, 2022 at 10:10:38AM +1000, Qingtao Cao wrote:
> > > > The Marvell GPIO controller's driver will setup its struct gpio_chip's can_sleep
> > > > false, making create_gpio_led() setting up the brightness_set function pointer
> > > > instead of the brightness_set_blocking function pointer. In this case the
> > > > nonblocking version led_set_brightness() should be fallen back on by ledtrig_tty_work()
> > > > 
> > > > Signed-off-by: Qingtao Cao <qingtao.cao@digi.com>
> > > > ---
> > > >   drivers/leds/trigger/ledtrig-tty.c | 10 ++++++++--
> > > >   1 file changed, 8 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/ledtrig-tty.c
> > > > index f62db7e520b5..e43d285b5d06 100644
> > > > --- a/drivers/leds/trigger/ledtrig-tty.c
> > > > +++ b/drivers/leds/trigger/ledtrig-tty.c
> > > > @@ -122,12 +122,18 @@ static void ledtrig_tty_work(struct work_struct *work)
> > > >   	if (icount.rx != trigger_data->rx ||
> > > >   	    icount.tx != trigger_data->tx) {
> > > > -		led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
> > > > +		if (trigger_data->led_cdev->brightness_set_blocking)
> > > > +			led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
> > > > +		else if (trigger_data->led_cdev->brightness_set)
> > > > +			led_set_brightness(trigger_data->led_cdev, LED_ON);
> > > 
> > > I had similar issues in the past where a function call worked for
> > > sleeping LEDs but not atomic ones (or the other way around? Don't
> > > remember the details.)
> > > 
> > > I wonder if there isn't a function that does the right thing no matter
> > > what type the LED is. The other triggers should have the same issue, and
> > > doing the above check in all of them just looks wrong.
> > 
> > Anyone fancy taking a deeper dive into this?
> > 
> > I'd usually have a go myself, but I'm presently swamped.
> > 
> > Pavel already has an idea?
> > 
> 
> There is led_set_brightness_nosleep() and it should be used here
> from the beginning. Generally it should be used always in triggers.

Thanks for helping to keep an eye on things Jacek.

Much appreciated.

-- 
Lee Jones [李琼斯]
