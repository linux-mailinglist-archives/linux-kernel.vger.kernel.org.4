Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE29A6B7A08
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjCMOMq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Mar 2023 10:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjCMOMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:12:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D506C1A1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:11:49 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1pbitn-0002Tg-IN; Mon, 13 Mar 2023 15:11:39 +0100
Message-ID: <71c8e22793330e413792824bd1affc36159a2de5.camel@pengutronix.de>
Subject: Re: MXSFB and Video PLL clock on i.MX8M Mini/Nano Question
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        Adam Ford <aford173@gmail.com>
Cc:     Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 13 Mar 2023 15:11:37 +0100
In-Reply-To: <20230313112937.GC7446@pengutronix.de>
References: <CAHCN7xJXMmwYqD=Eb2=_vJw390KAd6NgkWCpq6yCbAyaJ3xK5A@mail.gmail.com>
         <20230313085105.GB7446@pengutronix.de>
         <CAHCN7xJxBrN5aQgvkV8LrqoTATinr0kFYKht2_YKqTF71UCoKw@mail.gmail.com>
         <20230313112937.GC7446@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, dem 13.03.2023 um 12:29 +0100 schrieb Sascha Hauer:
> On Mon, Mar 13, 2023 at 06:08:05AM -0500, Adam Ford wrote:
> > On Mon, Mar 13, 2023 at 3:51 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > > 
> > > On Sun, Mar 12, 2023 at 02:28:45PM -0500, Adam Ford wrote:
> > > > I am trying to work through a series that was submitted for enabling
> > > > the DSI on the i.MX8M Mini and Nano.  I have extended this series to
> > > > route the DSI to an HDMI bridge, and I am able to get several
> > > > resolutions to properly sync on my monitor.  However, there are also a
> > > >  bunch that appear on the list when I run modetest that do not sync on
> > > > my monitor.
> > > > 
> > > > When running some debug code, it appears that it's related to the
> > > > clocking of the MXSFB driver.
> > > > 
> > > > From what I can tell, the MSXFB driver attempts to set the clock based
> > > > on the desired resolution and refresh rate.  When the default
> > > > VIDEO_PLL clock is set to 594MHz, many of the resolutions that cleanly
> > > > divide from the 594MHz clock appear to sync with my monitor.  However,
> > > > in order to get other resolutions to appear, I have to manually change
> > > > the device tree to set VIDEO_PLL to a different clock rate so MSXFB
> > > > can use it.  Unfortunately, that breaks the resolutions that used to
> > > > work.
> > > > 
> > > > I threw together a hack into the MXSFB driver which adds a new
> > > > optional clock to the MSXFB driver.  When I pass VIDEO_PLL to this
> > > > driver, it can automatically set the clock rate to match that of
> > > > whatever the desired clock is, and I can get many more resolutions to
> > > > appear.
> > > > Another advantage of this is that the Video_PLL can be the minimum
> > > > speed needed for a given rate instead of setting a higher rate, then
> > > > dividing it down.
> > > 
> > > Isn't it possible to add the CLK_SET_RATE_PARENT flag to the pixel
> > > clock? That's what i.MX6sx and i.MX7 do.
> > 
> > I thought about that, but on the Nano, the video_pll is several layers up.
> > 
> > video_pll -> video_pll_bypass -> disp_pixel -> disp_pixel_clk
> > 
> > Do I just set that flag for each of these?
> 
> Yes, that's what I would suggest. I don't know the i.MX8M clock tree
> very well, so I don't know which other clocks might be influenced when
> the video_pll clock changes its rate. But if you have to change the PLL
> rate anyway it shouldn't make a difference if you change it directly
> or if you let the rate change propagate up from disp_pixel_clk.
> 
The problem with a simple CLK_SET_RATE_PARENT is that the rate changes
propagate upwards in the tree for all possible sources. If the source
is the video PLL then the rate propagation is exactly what you want to
happen. If the display clock is sourced from a system PLL, you really
don't want to change the PLL rate, so we need something more clever
here.

Either the mux part of the composite clock needs to learn to only
propagate rate requests for specific sources, or we need to deny rate
changes to the system PLLs, but not sure if there are other similar
cases for other sources.

Regards,
Lucas

