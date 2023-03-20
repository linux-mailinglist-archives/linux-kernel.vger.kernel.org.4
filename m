Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348EA6C241C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjCTVxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCTVxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:53:35 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B67448B;
        Mon, 20 Mar 2023 14:53:32 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 671B225B;
        Mon, 20 Mar 2023 22:53:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1679349210;
        bh=8BTX/vDgLy7zKv+rtpISR0qIjLO+lvcIQfNGkq2Sha8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vGinQhWcGJ0qlCPaigQmNHdzwZ0mL46lVziHzB9AQdWxUpJiCcAtqFl3k6eJ7qt7n
         wWpVqF15sEF27as/qQfwm/UaHGXglCDHfjzpaVfnNm2OvLCDVqKLafubz4HPrOMfl1
         gplIOP7LiqStpcnmoWx0wwq0IuAPsyWveYz1CPHg=
Date:   Mon, 20 Mar 2023 23:53:36 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Francesco Dolcini <francesco@dolcini.it>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-media@vger.kernel.org, kernel@pengutronix.de,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-kernel@vger.kernel.org,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v2] media: i2c: ov5640: Implement get_mbus_config
Message-ID: <20230320215336.GN20234@pendragon.ideasonboard.com>
References: <ZBBvmjUZIn/g0/Nv@francesco-nb.int.toradex.com>
 <20230320084844.tdjiv6kaxcosiwm2@uno.localdomain>
 <ZBggtBU1TjlvVNCS@kekkonen.localdomain>
 <20230320092602.GE20234@pendragon.ideasonboard.com>
 <ZBgpXRtXcxg14OGv@kekkonen.localdomain>
 <20230320095514.GF20234@pendragon.ideasonboard.com>
 <ZBgyOPS23BC2wAfg@kekkonen.localdomain>
 <727949a9c3d9e639b046bcd86635796452b10300.camel@pengutronix.de>
 <20230320140012.GB9535@pendragon.ideasonboard.com>
 <CAPY8ntCnX9uFbyfKnJCH6+8yLWwX1ZieYqzZq6qs9uvAPh9Eyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPY8ntCnX9uFbyfKnJCH6+8yLWwX1ZieYqzZq6qs9uvAPh9Eyw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Mon, Mar 20, 2023 at 06:31:04PM +0000, Dave Stevenson wrote:
> On Mon, 20 Mar 2023 at 14:00, Laurent Pinchart wrote:
> > On Mon, Mar 20, 2023 at 02:32:25PM +0100, Philipp Zabel wrote:
> > > On Mo, 2023-03-20 at 12:15 +0200, Sakari Ailus wrote:
> > > > On Mon, Mar 20, 2023 at 11:55:14AM +0200, Laurent Pinchart wrote:
> > > > > On Mon, Mar 20, 2023 at 11:37:33AM +0200, Sakari Ailus wrote:
> > > > > > On Mon, Mar 20, 2023 at 11:26:02AM +0200, Laurent Pinchart wrote:
> > > > > > > In a (simplified) nutshell,
> > > > > > >
> > > > > > > ---------+     +----------+     +---------+     +-----+     +-----+
> > > > > > > > Camera | --> | CSI-2 RX | --> | CSI2IPU | --> | Mux | --> | IPU |
> > > > > > > > Sensor |     |          |     | Gasket  |     |     |     |     |
> > > > > > > ---------+     +----------+     +---------+     +-----+     +-----+
> > > > > >
> > > > > > Thank you, this is helpful.
> > > > > >
> > > > > > I suppose the mux here at least won't actively do anything to the data. So
> > > > > > presumably its endpoint won't contain the active configuration, but its
> > > > > > superset.
> > > > > >
> > > > > > >
> > > > > > > All those blocks, except for the gasket, have a node in DT.
> > > > > > >
> > > > > > > The IPU driver needs to know the number of CSI-2 data lanes, which is
> > > > > > > encoded in the data-lanes DT property present in both the sensor output
> > > > > > > endpoint and the CSI-2 RX input endpoint, but not the other endpoints in
> > > > > > > the pipeline.
> > > > > >
> > > > > > This doesn't yet explain why the sensor would need to implement
> > > > > > get_mbus_config if its bus configuration remains constant.
> > > > >
> > > > > If I recall correctly, the IPU driver calls .g_mbus_config() on the
> > > > > camera sensor to get the number of lanes, as it can't get it from its
> > > > > own endpoint. That's a hack, and as Jacopo proposed, calling
> > > > > .g_mbus_config() on the CSI-2 RX would be better, as the CSI-2 RX driver
> > > > > can then get the value from its own endpoint, without requiring all
> > > > > sensor drivers to implement .g_mbus_config().
> > > >
> > > > The g_mbus_config op could be implemented by the CSI2IPU and mux, by simply
> > > > requesting the information from the upstream sub-device. No hacks would be
> > > > needed.
> > >
> > > I think implementing get_mbus_config on the mux might be enough. The
> > > IPU driver already recognizes the CSI-2 RX by its grp_id and could
> > > infer that it has to use MIPI CSI-2 mode from that.
> > >
> > > The video-mux would have to forward get_mbus_config to its active
> > > upstream port and if the upstream sensor does not implement it read bus
> > > width from the active upstream endpoint.
> >
> > I'm fine with implementing it in the mux as well, but I think we can
> > take a shortcut here and call it on the CSI-2 RX from the IPU driver, as
> > the IPU driver knows about the architecture of the whole pipeline.
> 
> FWIW I have made use of video-mux and implementing g_mbus_config on it
> for D-PHY switch chips[1] where the different input ports may have
> different configurations. I'll admit that I've made the easy
> assumption that it's CSI-2 D-PHY in and out, when it could quite
> legitimately be working with any of the other bus types.

That's a use case I hadn't considered. .get_mbus_config() makes sense.

> I had been intending to send this[2] upstream when I get a chance, but
> am I reading imx6q.dtsi[3] correctly in that the mux is accepting
> parallel on some ports and CSI-2 on others? The mux hardware is
> therefore far more than just a simple switch between inputs? Although
> as this is after the CSI2 rx block, this is effectively parallel data
> within the SoC, therefore is the configuration and get_mbus_config
> really relevant?

The exact hardware architecture isn't clear, but I indeed expect the mux
to receive parallel data from the CSI-2 RX and parallel inputs.

I had a closer look at the IPU driver code, and realized I was wrong
when I mentioned it needed to know the number of lanes. What the IPU
need is the bus type (CSI-2, BT656 or parallel) and, for parallel buses,
the bus width. It may be possible to refactor the IPU driver code to
replace that information with the media bus code in some places, but not
everywhere. Whether the input comes from the CSI-2 RX could be deduced
internally from the selected mux input, but we can't differentiate BT656
from parallel without querying the mux's input bus type. Calling
.get_mbus_config() on the mux is thus required, and the mux driver
should implement the operation.

> I'd like to understand how this is being used on imx6 before trying to
> rework my patch into a generic solution.
> 
> Thanks
>   Dave
> 
> [1] eg Arducam's 2 and 4 port muxes - https://www.arducam.com/product-category/camera-multiplexers/, which
> IIRC use OnSemi's FSA644 https://www.onsemi.com/products/interfaces/analog-switches/fsa644
> [2] https://github.com/raspberrypi/linux/commit/bf653318475cf4db0ec59e92139f477f7cc0a544
> [3] https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/imx6q.dtsi#L349

-- 
Regards,

Laurent Pinchart
