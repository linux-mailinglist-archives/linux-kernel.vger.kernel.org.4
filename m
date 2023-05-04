Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEFA6F6598
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjEDHPZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 4 May 2023 03:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEDHPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:15:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACC62D5E
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 00:15:21 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1puTB8-0007Hz-VW; Thu, 04 May 2023 09:15:03 +0200
Message-ID: <9f98e3b5194640cf578d2aa290c6d0ff9ab92369.camel@pengutronix.de>
Subject: Re: [PATCH V2 1/6] drm: bridge: samsung-dsim: fix blanking packet
 size calculation
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, m.szyprowski@samsung.com,
        aford@beaconembedded.com, dario.binacchi@amarulasolutions.com,
        Inki Dae <inki.dae@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org
Date:   Thu, 04 May 2023 09:14:57 +0200
In-Reply-To: <CAMty3ZB0q7MLRyu4TgcV20rX7c8d2SMbvBr39XRru5_Ry6q1Ug@mail.gmail.com>
References: <20230423121232.1345909-1-aford173@gmail.com>
         <20230423121232.1345909-2-aford173@gmail.com>
         <CAMty3ZCn9_AT8SOfFD-MYox16ZcqOEezt_0x6aES6LWQFj8Kpg@mail.gmail.com>
         <CAHCN7xLYfEO9Pxq91vZSDG0QXjnx3BEKYdsTXgQ1BTbtuTbLGQ@mail.gmail.com>
         <CAMty3ZB0q7MLRyu4TgcV20rX7c8d2SMbvBr39XRru5_Ry6q1Ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 03.05.2023 um 22:05 +0530 schrieb Jagan Teki:
> On Mon, Apr 24, 2023 at 3:17 PM Adam Ford <aford173@gmail.com> wrote:
> > 
> > On Mon, Apr 24, 2023 at 4:03 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > 
> > > On Sun, Apr 23, 2023 at 5:42 PM Adam Ford <aford173@gmail.com> wrote:
> > > > 
> > > > From: Lucas Stach <l.stach@pengutronix.de>
> > > > 
> > > > Scale the blanking packet sizes to match the ratio between HS clock
> > > > and DPI interface clock. The controller seems to do internal scaling
> > > > to the number of active lanes, so we don't take those into account.
> > > > 
> > > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/bridge/samsung-dsim.c | 18 +++++++++++++++---
> > > >  1 file changed, 15 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
> > > > index e0a402a85787..2be3b58624c3 100644
> > > > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > > > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > > > @@ -874,17 +874,29 @@ static void samsung_dsim_set_display_mode(struct samsung_dsim *dsi)
> > > >         u32 reg;
> > > > 
> > > >         if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
> > > > +               int byte_clk_khz = dsi->burst_clk_rate / 1000 / 8;
> > > > +               int hfp = (m->hsync_start - m->hdisplay) * byte_clk_khz / m->clock;
> > > 
> > > I do not quite understand why it depends on burst_clk_rate, would you
> > > please explain? does it depends on bpp something like this
> > > 
> > > mipi_dsi_pixel_format_to_bpp(format) / 8
> > 
> > The pixel clock is currently set to the burst clock rate.  Dividing
> > the clock by 1000 gets the pixel clock in KHz, and dividing by 8
> > converts bits to bytes.
> > Later in the series, I change the clock from the burst clock to the
> > cached value returned from samsung_dsim_set_pll.
> 
> Okay.
> 
> > 
> > > 
> > > > +               int hbp = (m->htotal - m->hsync_end) * byte_clk_khz / m->clock;
> > > > +               int hsa = (m->hsync_end - m->hsync_start) * byte_clk_khz / m->clock;
> > > > +
> > > > +               /* remove packet overhead when possible */
> > > > +               hfp = max(hfp - 6, 0);
> > > > +               hbp = max(hbp - 6, 0);
> > > > +               hsa = max(hsa - 6, 0);
> > > 
> > > 6 blanking packet overhead here means, 4 bytes + payload + 2 bytes
> > > format? does this packet overhead depends on the respective porch's
> > > like hpf, hbp and hsa has different packet overheads?
> > 
> > Lucas might be able to explain this better.  However, it does match
> > the values of the downstream NXP kernel, and I tried playing with
> > these values manually, and 6 appeared to be the only number that
> > seemed to work for me too.  I abandoned my approach for Lucas'
> > implementation, because it seemed more clear than mine.
> > Maybe Lucas can chime in, since this is really his patch.
> 
> Lucan, any inputs?
> 
The blanking packets are are MIPI long packets, so 4 byte header,
payload, 2 bytes footer. I experimented with different blanking sizes
and haven't found that it would make any difference. I don't think any
real-world horizontal blanking sizes would require multiple packets to
be sent.

Regards,
Lucas

