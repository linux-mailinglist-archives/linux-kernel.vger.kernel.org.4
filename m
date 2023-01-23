Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806BE6776F4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjAWJCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjAWJCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:02:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C13E1C33C;
        Mon, 23 Jan 2023 01:01:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 058CDB80B4C;
        Mon, 23 Jan 2023 09:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BBEC433EF;
        Mon, 23 Jan 2023 09:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674464516;
        bh=fLPLxf9UITAarrimBYhvJJGRFL1uWngBJtVtMGIMo+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HV7cU/8OaL14lRBXBvhDtqeKs/MQc6agBksKgHuD9VNGb4p6Qn2DvBgdtPLnw33OF
         6N8te6dgIZWOJpy1DxZLkSk5bp4v+6IGoXAZEbUFIdn9CYDuz7vrba3Iw9YezZ9pxa
         Dz+WMduaJDEYzTu2rFT27KepMGnebgZ99jaracJAi9KyKvA5fXhNhZh0XlhvPFySnY
         VkF5Mu7ezOxxi4Qb1aSchHy1gT1PvbyKwHExCIcHjzsponitKtk3YheFvNQZ4uyTmt
         Fzx/19qOKxxRVIVK3o68h+aTczS+atCOc+SIZDbGcWXYIEufzneQgUclGs7Vxyzxia
         88kicnsIak+jw==
Date:   Mon, 23 Jan 2023 09:01:51 +0000
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
Message-ID: <Y85M/2w9nsWTSTo1@google.com>
References: <20221209001039.7287-1-qingtao.cao@digi.com>
 <20221209124058.dwez7wohs7dfeiik@pengutronix.de>
 <Y7WnMISK20Z4hsg1@google.com>
 <ad4a1069-72c6-a431-336f-ed78a57a1ba0@gmail.com>
 <Y8qW1tlDmw6KEIuu@google.com>
 <d34ad55c-62c4-6eaf-8f73-19a675264a7c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d34ad55c-62c4-6eaf-8f73-19a675264a7c@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jan 2023, Jacek Anaszewski wrote:

> On 1/20/23 14:27, Lee Jones wrote:
> > On Sat, 07 Jan 2023, Jacek Anaszewski wrote:
> > 
> > > Hi all,
> > > 
> > > On 1/4/23 17:20, Lee Jones wrote:
> > > > On Fri, 09 Dec 2022, Uwe Kleine-König wrote:
> > > > 
> > > > > On Fri, Dec 09, 2022 at 10:10:38AM +1000, Qingtao Cao wrote:
> > > > > > The Marvell GPIO controller's driver will setup its struct gpio_chip's can_sleep
> > > > > > false, making create_gpio_led() setting up the brightness_set function pointer
> > > > > > instead of the brightness_set_blocking function pointer. In this case the
> > > > > > nonblocking version led_set_brightness() should be fallen back on by ledtrig_tty_work()
> > > > > > 
> > > > > > Signed-off-by: Qingtao Cao <qingtao.cao@digi.com>
> > > > > > ---
> > > > > >    drivers/leds/trigger/ledtrig-tty.c | 10 ++++++++--
> > > > > >    1 file changed, 8 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/ledtrig-tty.c
> > > > > > index f62db7e520b5..e43d285b5d06 100644
> > > > > > --- a/drivers/leds/trigger/ledtrig-tty.c
> > > > > > +++ b/drivers/leds/trigger/ledtrig-tty.c
> > > > > > @@ -122,12 +122,18 @@ static void ledtrig_tty_work(struct work_struct *work)
> > > > > >    	if (icount.rx != trigger_data->rx ||
> > > > > >    	    icount.tx != trigger_data->tx) {
> > > > > > -		led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
> > > > > > +		if (trigger_data->led_cdev->brightness_set_blocking)
> > > > > > +			led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
> > > > > > +		else if (trigger_data->led_cdev->brightness_set)
> > > > > > +			led_set_brightness(trigger_data->led_cdev, LED_ON);
> > > > > 
> > > > > I had similar issues in the past where a function call worked for
> > > > > sleeping LEDs but not atomic ones (or the other way around? Don't
> > > > > remember the details.)
> > > > > 
> > > > > I wonder if there isn't a function that does the right thing no matter
> > > > > what type the LED is. The other triggers should have the same issue, and
> > > > > doing the above check in all of them just looks wrong.
> > > > 
> > > > Anyone fancy taking a deeper dive into this?
> > > > 
> > > > I'd usually have a go myself, but I'm presently swamped.
> > > > 
> > > > Pavel already has an idea?
> > > > 
> > > 
> > > There is led_set_brightness_nosleep() and it should be used here
> > > from the beginning. Generally it should be used always in triggers.
> > 
> > Thanks for helping to keep an eye on things Jacek.
> > 
> > Much appreciated.
> > 
> 
> No problem, I still read the list and can elaborate
> on various details of LED subsystem, as needed.

That would be very helpful.  Thanks again.

-- 
Lee Jones [李琼斯]
