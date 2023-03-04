Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C376AABF3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 19:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCDSx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 13:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDSxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 13:53:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBE612BC1;
        Sat,  4 Mar 2023 10:53:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 646A560A2C;
        Sat,  4 Mar 2023 18:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF800C4339B;
        Sat,  4 Mar 2023 18:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677956002;
        bh=k0aanQ9BQy0w6irW8q/v1a383LHLQI046GTElNXpG8Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iy42JZZs/+WDlRW6FWG5ZBArwXus0UGwIzimntKxlghi2zFL7ZKNyVqJl2h/9a9s8
         lhWOO+XPAN4QdcdbfPML69LZuMj4t4x1+Aauowrt/AbZ7pmjgljviOtT5hREeTZRvr
         0b9B3XoiRqE5xU1ziXxYGmIFNnECXqQ/jHHooMyRZdKgGaziDpjjl3MLcE7RgBOWmE
         R1alfkSOjquKgrAs89od7xqmp71SOw+q2R5v8Eil2P0PgFWKErwtfK5s5+GDMJgrL4
         opg/kWqDS2Tmb4bSrH7ihFGUOHQwrBlux87HTzm8BE1HgkdOUIMgF7TLUIsP5u3RQ/
         dGgqsDwuTW2dA==
Date:   Sat, 4 Mar 2023 18:53:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
Message-ID: <20230304185318.117f9e48@jic23-huawei>
In-Reply-To: <ec0d0f3a-c10a-4d55-486f-7b90db90a427@fi.rohmeurope.com>
References: <cover.1677080089.git.mazziesaccount@gmail.com>
        <63a2dbedf54e2e00e3b63dd16aae190ff6596355.1677080089.git.mazziesaccount@gmail.com>
        <02f948ee-34ee-c15e-09e4-d0d8c5161c9b@gmail.com>
        <20230226135216.3f962b51@jic23-huawei>
        <ec0d0f3a-c10a-4d55-486f-7b90db90a427@fi.rohmeurope.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Tue, 28 Feb 2023 08:43:28 +0000
"Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com> wrote:

> On 2/26/23 15:52, Jonathan Cameron wrote:
> > On Fri, 24 Feb 2023 12:41:46 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> On 2/22/23 18:15, Matti Vaittinen wrote:
> >>
> >> Well, this "works on my machine" - but I am slightly unhappy with this.
> >> I have a feeling I am effectively making a poor, reduced version of data
> >> buffering here. I am starting to think that I should
> >>
> >> a) Not start measurement at chip init. (saves power)
> >> b) Start measurement at raw-read and just block for damn long for each
> >> raw-read. Yep, it probably means that users who want to raw-read all
> >> channels will be blocking 4 * measurement time when they are reading all
> >> channels one after another. Yes, this is in worst case 4 * 400 mS.
> >> Horrible. But see (c) below.  
> > 
> > Hmm. Light sensors tend to be slow in some modes, but rarely do people actually
> > have such low light levels that they are using them with 400mS integration times.
> >   
> >> c) Implement triggered_buffer mode. Here my lack of IIO-experience shows
> >> up again. I have no idea if there is - or what is - the "de facto" way
> >> for implementing this when our device has no IRQ? I could cook-up some
> >> 'tiny bit shorter than the measurement time' period timer which would
> >> kick the driver to poll the VALID-bit - or, because we need anyways to
> >> poll the valid bit from process context - just a kthread which polls the
> >> VALID-bit. Naturally the thread/timer should be only activated when the
> >> trigger is enabled.  
> > 
> > Firstly you don't have to have a trigger. In a case where it's a bit hacky
> > and unlikely to be particularly useful for other devices, you can just implement
> > a buffer directly.  
> 
> This is the approach I took for the next attempt. I just used the 
> iio_kfifo_buffer.
> 
> > There are various options that exist..
> > 1) iio-trig-loop - this is nasty but occasionally useful approach.  You then
> >     make the iio_poll_func wait on the flag.  
> 
> I actually did take a look at this. The loop trigger had pretty much 
> everything I would have needed - except configurability from the driver. 

It's purpose was a originally a bit different, so I'm not surprised it
didn't really fit.  The target was a sensor that needed explicit triggering
but then took a while to get the data.  Aim was to grab data as quick as we
could.  So there were no problems with alignment.

> It had the enable/disable with protected start of the thread and the 
> thread stopping all in place. Really, as you said, the only thing that 
> was missing was "hinting the timing". For a moment I was playing with a 
> thought of trying to implement a simple generic thread-loop code which 
> could take the sleep-time + callback for 'ensuring we slept long enough' 
> + a callback for code to execute (collect data +  push to buffers) - but 
> it felt like re-implementing existing mechanisms. Besides, as you said, 
> I don't probably need a trigger
> 
> I'll do some clean-ups and look through the feedback and try to get the 
> v2 out still during this week.
> 
> Yours,
> 	-- Matti
> 

