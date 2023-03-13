Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5956B75F8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjCML37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjCML3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:29:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5CA50FB2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:29:49 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pbgN0-0000x8-Lt; Mon, 13 Mar 2023 12:29:38 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pbgMz-00081U-S4; Mon, 13 Mar 2023 12:29:37 +0100
Date:   Mon, 13 Mar 2023 12:29:37 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: MXSFB and Video PLL clock on i.MX8M Mini/Nano Question
Message-ID: <20230313112937.GC7446@pengutronix.de>
References: <CAHCN7xJXMmwYqD=Eb2=_vJw390KAd6NgkWCpq6yCbAyaJ3xK5A@mail.gmail.com>
 <20230313085105.GB7446@pengutronix.de>
 <CAHCN7xJxBrN5aQgvkV8LrqoTATinr0kFYKht2_YKqTF71UCoKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCN7xJxBrN5aQgvkV8LrqoTATinr0kFYKht2_YKqTF71UCoKw@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 06:08:05AM -0500, Adam Ford wrote:
> On Mon, Mar 13, 2023 at 3:51 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >
> > On Sun, Mar 12, 2023 at 02:28:45PM -0500, Adam Ford wrote:
> > > I am trying to work through a series that was submitted for enabling
> > > the DSI on the i.MX8M Mini and Nano.  I have extended this series to
> > > route the DSI to an HDMI bridge, and I am able to get several
> > > resolutions to properly sync on my monitor.  However, there are also a
> > >  bunch that appear on the list when I run modetest that do not sync on
> > > my monitor.
> > >
> > > When running some debug code, it appears that it's related to the
> > > clocking of the MXSFB driver.
> > >
> > > From what I can tell, the MSXFB driver attempts to set the clock based
> > > on the desired resolution and refresh rate.  When the default
> > > VIDEO_PLL clock is set to 594MHz, many of the resolutions that cleanly
> > > divide from the 594MHz clock appear to sync with my monitor.  However,
> > > in order to get other resolutions to appear, I have to manually change
> > > the device tree to set VIDEO_PLL to a different clock rate so MSXFB
> > > can use it.  Unfortunately, that breaks the resolutions that used to
> > > work.
> > >
> > > I threw together a hack into the MXSFB driver which adds a new
> > > optional clock to the MSXFB driver.  When I pass VIDEO_PLL to this
> > > driver, it can automatically set the clock rate to match that of
> > > whatever the desired clock is, and I can get many more resolutions to
> > > appear.
> > > Another advantage of this is that the Video_PLL can be the minimum
> > > speed needed for a given rate instead of setting a higher rate, then
> > > dividing it down.
> >
> > Isn't it possible to add the CLK_SET_RATE_PARENT flag to the pixel
> > clock? That's what i.MX6sx and i.MX7 do.
> 
> I thought about that, but on the Nano, the video_pll is several layers up.
> 
> video_pll -> video_pll_bypass -> disp_pixel -> disp_pixel_clk
> 
> Do I just set that flag for each of these?

Yes, that's what I would suggest. I don't know the i.MX8M clock tree
very well, so I don't know which other clocks might be influenced when
the video_pll clock changes its rate. But if you have to change the PLL
rate anyway it shouldn't make a difference if you change it directly
or if you let the rate change propagate up from disp_pixel_clk.

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
