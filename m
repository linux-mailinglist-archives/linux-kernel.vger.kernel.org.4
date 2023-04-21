Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC0D6EA608
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjDUIlE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Apr 2023 04:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjDUIlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:41:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C3B902B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:41:00 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1ppmJa-0005PO-Lz; Fri, 21 Apr 2023 10:40:22 +0200
Message-ID: <56a805b4a74f620f7948f57d416b135effb6e52d.camel@pengutronix.de>
Subject: Re: [PATCH 1/6] drm: bridge: samsung-dsim: Support multi-lane
 calculations
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        aford@beaconembedded.com,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Fabio Estevam <festevam@gmail.com>, m.szyprowski@samsung.com,
        marex@denx.de, Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Fri, 21 Apr 2023 10:40:18 +0200
In-Reply-To: <CAHCN7x+HYmGoxZ107OdY1aJYtjNWB4p3fqJ1tGjOAK2eO356yA@mail.gmail.com>
References: <20230415104104.5537-1-aford173@gmail.com>
         <3e47f0d1017fe4c9f71a5de65f32c6ba1662efe2.camel@pengutronix.de>
         <CAHCN7xL4+9NogrnXA1PEWorwY7JpSGBozDtHT83JvzjfinmS+A@mail.gmail.com>
         <CAHCN7xK8K+DsNAFTVAezwJQzZ7RCDb2CjCBZ8dNb=S8d1BmtMA@mail.gmail.com>
         <f42a2a11c1a2df4d773b61a449e8f4d5a9a010d1.camel@pengutronix.de>
         <CAHCN7x+bZHZHxYk=qC3QFS07kLO85w_rj1tOuX1Y3fJXekmvMQ@mail.gmail.com>
         <19d2c40180d0b9176e17aa6e91c1e7f36f77f626.camel@pengutronix.de>
         <CAHCN7x+HYmGoxZ107OdY1aJYtjNWB4p3fqJ1tGjOAK2eO356yA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, dem 20.04.2023 um 16:51 -0500 schrieb Adam Ford:
> On Thu, Apr 20, 2023 at 8:43 AM Lucas Stach <l.stach@pengutronix.de> wrote:
> > 
> > Am Donnerstag, dem 20.04.2023 um 08:24 -0500 schrieb Adam Ford:
> > > On Thu, Apr 20, 2023 at 8:06 AM Lucas Stach <l.stach@pengutronix.de> wrote:
> > > > 
> > > > Hi Adam,
> > > > 
> > > > Am Mittwoch, dem 19.04.2023 um 05:47 -0500 schrieb Adam Ford:
> > > > > On Mon, Apr 17, 2023 at 6:55 AM Adam Ford <aford173@gmail.com> wrote:
> > > > > > 
> > > > > > On Mon, Apr 17, 2023 at 3:43 AM Lucas Stach <l.stach@pengutronix.de> wrote:
> > > > > > > 
> > > > > > > Hi Adam,
> > > > > > > 
> > > > > > > Am Samstag, dem 15.04.2023 um 05:40 -0500 schrieb Adam Ford:
> > > > > > > > If there is more than one lane, the HFP, HBP, and HSA is calculated in
> > > > > > > > bytes/pixel, then they are divided amongst the different lanes with some
> > > > > > > > additional overhead. This is necessary to achieve higher resolutions while
> > > > > > > > keeping the pixel clocks lower as the number of lanes increase.
> > > > > > > > 
> > > > > > > 
> > > > > > > In the testing I did to come up with my patch "drm: bridge: samsung-
> > > > > > > dsim: fix blanking packet size calculation" the number of lanes didn't
> > > > > > > make any difference. My testing might be flawed, as I could only
> > > > > > > measure the blanking after translation from MIPI DSI to DPI, so I'm
> > > > > > > interested to know what others did here. How did you validate the
> > > > > > > blanking with your patch? Would you have a chance to test my patch and
> > > > > > > see if it works or breaks in your setup?
> > > > > 
> > > > > Lucas,
> > > > > 
> > > > > I tried your patch instead of mine.  Yours is dependent on the
> > > > > hs_clock being always set to the burst clock which is configured by
> > > > > the device tree.  I unrolled a bit of my stuff and replaced it with
> > > > > yours.  It worked at 1080p, but when I tried a few other resolutions,
> > > > > they did not work.  I assume it's because the DSI clock is fixed and
> > > > > not changing based on the pixel clock.  In the version I did, I only
> > > > > did that math when the lanes were > 1. In your patch, you divide by 8,
> > > > > and in mine, I fetch the bits-per-pixel (which is 8) and I divide by
> > > > > that just in case the bpp ever changes from 8.  Overall,  I think our
> > > > > patches basically do the same thing.
> > > > 
> > > > The calculations in your and my patch are quite different. I'm not
> > > > taking into account the number of lanes or the MIPI format. I'm basing
> 
> I was taking the number of lanes into account in order to calculate
> the clock rate, since 4-lanes can run slower.
> 
Ah that makes sense if you aren't running at full clock burst clock
rate.

> > > 
> > > I was looking more at the division by 8 and the overhead correction of 6.
> > > This number 6 also appears in the NXP downstream kernel [1].  I know
> > > Marek V had some concerns about that.
> > > 
> > Yea, I don't fully remember the details about the overhead. Need to
> > page that back in. The division by 8 in my patch is just to get from
> > the bit to a byte clock, nothing to do with the MIPI format bits per
> > channel or something like that.
> > 
> > > > the blanking size purely on the ratio between MIPI DSI byte clock and
> > > > the DPI interface clock. It's quite counter-intuitive that the host
> > > > would scale the blanking to the number of lanes automatically, but
> > > > still require the MIPI packet offset removed, but that's what my
> > > > measurements showed to produce the correct blanking after translation
> > > > to DPI by the TC358767 bridge chip.
> > > 
> > > How many lanes is your DSI interface using?
> > > 
> > When I did the measurements to come up with the patch, I varied the
> > number of lanes between 1 and 4. Different number of lanes didn't make
> > a difference. In fact trying to compensate for the number of lanes when
> > calculating the blanking size to program into the controller lead to
> > wildly wrong blanking on the DPI side of the external bridge.
> > 
> > > > 
> > > > If you dynamically scale the HS clock, then you would need to input the
> > > > real used HS clock to the calculation in my patch, instead of the fixed
> > > > burst mode rate.
> > > 
> > > I think what you're saying makes sense.
> > > 
> > > The code I originally modeled this from was from the NXP downstream
> > > kernel where they define the calculation as being in words [2]. I am
> > > not saying the NXP code is perfect, but the NXP code works.  With this
> > > series, my monitors are able to sync a bunch of different resolutions
> > > from 1080p down to 640x480 and a bunch in between with various refresh
> > > rates too. That was the goal of this series.
> > > 
> > > Instead of just using your patch as-is, I will adapt yours to use the
> > > scaled clock to see how it behaves and get back to you.
> > > 
> > 
> > Thanks, that would be very much appreciated.
> 
> Lucas,
> 
> I took your patch and added a dsi state variable named "hs_clock"  to
> keep track of the output of samsung_dsim_set_pll which should be the
> active high-speed clock.
> 
> I then replaced one line in your code to reference the hs_clock
> instead of the burst clock:
> 
> @@ -960,7 +962,7 @@ static void samsung_dsim_set_display_mode(struct
> samsung_dsim *dsi)
>         u32 reg;
> 
>         if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
> -               int byte_clk_khz = dsi->burst_clk_rate / 1000 / 8;
> +               int byte_clk_khz = dsi->hs_clock / 1000 / 8;
>                 int hfp = (m->hsync_start - m->hdisplay) *
> byte_clk_khz / m->clock;
> 
> With that change, your patch works with the rest of my code, and I
> think it's easier to read, and it doesn't involve recalculating the
> clock speed each time since it's cached.  If you're OK with that, I'll
> incorporate your code into V2 of my series, and I'll apply my changes
> as a subsequent patch.  I hope to be able to send out V2 this weekend.
> 
That's good to hear! Seems we are converging here. Feel free to pick up
the patch, that's also easier for me as I don't have to resend with CC
fixed.

> I would be curious to know frm Marek Szyprowski what the impact is on
> the Samsung devices, if any.
> 
Since I messed up the list CC you also couldn't see his reply to my
patch:

| Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
| 
| Works fine on the Exynos based boards I have in my test farm.

Regards,
Lucas

> adam
> 
> > 
> > I also don't assert that my calculation is perfect, as I also don't
> > have any more information and needed to resort to observing the
> > blanking after translation by the external bridge, so I hope we could
> > get some better understanding of how things really work by checking
> > what works for both our systems.
> > 
> > >   I have
> > > finished reworking the dynamic DPHY settings, and I've fixed up making
> > > the PLL device tree optional. If your patch works, I'll drop my
> > > calculation and just build off what you have to use the scaled HS
> > > clock when I submit the V2 and I'll make sure I CC you.
> > > 
> > Thanks, I'm open to re-do my measurements with your new patches.
> > 
> > Regards,
> > Lucas
> > 
> > > adam
> > > 
> > > [1] - https://github.com/nxp-imx/linux-imx/blob/lf-6.1.y/drivers/gpu/drm/bridge/sec-dsim.c#L270
> > > [2] - https://github.com/nxp-imx/linux-imx/blob/lf-6.1.y/drivers/gpu/drm/bridge/sec-dsim.c#L914
> > > 
> > > > 
> > > > Regards,
> > > > Lucas
> > 

