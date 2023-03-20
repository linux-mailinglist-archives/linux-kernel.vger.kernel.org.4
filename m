Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D646C1240
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjCTMrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjCTMrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:47:25 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156C97DB1;
        Mon, 20 Mar 2023 05:47:18 -0700 (PDT)
Received: from ideasonboard.com (93-61-96-190.ip145.fastwebnet.it [93.61.96.190])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 09CFDA25;
        Mon, 20 Mar 2023 13:47:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1679316436;
        bh=8gQVnLQ7icM2cdxFjpNyr1Gr6yb1MMFoYDWr5iEDuHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z5b+3l6oWPf8V+WI1dWAVma7rV7W6hcSwJTjorqTD/t+AOvyyEFSDpdjs22HWzEiP
         nfQkP0N1tj6U1OVnw+pWlZR/WcDK2GupnJVnzNclv6k9NsnBfG4Yad58enwBX8rENy
         Vhzu+/FL+9tE/yYYTuQ+p4zDenhFtg6A3bqnL3r4=
Date:   Mon, 20 Mar 2023 13:47:12 +0100
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
Message-ID: <20230320124712.q67dqlldkqsdwyke@uno.localdomain>
References: <ZBBk+h3EMSsacZ6v@valkosipuli.retiisi.eu>
 <ZBBpUAhis8L5Dtuz@francesco-nb.int.toradex.com>
 <ZBBsgW75Gc2FmuQ0@valkosipuli.retiisi.eu>
 <ZBBvmjUZIn/g0/Nv@francesco-nb.int.toradex.com>
 <20230320084844.tdjiv6kaxcosiwm2@uno.localdomain>
 <ZBggtBU1TjlvVNCS@kekkonen.localdomain>
 <20230320092602.GE20234@pendragon.ideasonboard.com>
 <ZBgpXRtXcxg14OGv@kekkonen.localdomain>
 <20230320095514.GF20234@pendragon.ideasonboard.com>
 <9b4f0896a3a3e97b44197de263c30f0d31333abd.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b4f0896a3a3e97b44197de263c30f0d31333abd.camel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp

On Mon, Mar 20, 2023 at 12:26:26PM +0100, Philipp Zabel wrote:
> On Mo, 2023-03-20 at 11:55 +0200, Laurent Pinchart wrote:
> > On Mon, Mar 20, 2023 at 11:37:33AM +0200, Sakari Ailus wrote:
> > > Hi Laurent,
> > >
> > > On Mon, Mar 20, 2023 at 11:26:02AM +0200, Laurent Pinchart wrote:
> > > > In a (simplified) nutshell,
> > > >
> > > > ---------+     +----------+     +---------+     +-----+     +-----+
> > > > > Camera | --> | CSI-2 RX | --> | CSI2IPU | --> | Mux | --> | IPU |
> > > > > Sensor |     |          |     | Gasket  |     |     |     |     |
> > > > ---------+     +----------+     +---------+     +-----+     +-----+
> > >
> > > Thank you, this is helpful.
> > >
> > > I suppose the mux here at least won't actively do anything to the data. So
> > > presumably its endpoint won't contain the active configuration, but its
> > > superset.
> > >
> > > >
> > > > All those blocks, except for the gasket, have a node in DT.
> > > >
> > > > The IPU driver needs to know the number of CSI-2 data lanes, which is
> > > > encoded in the data-lanes DT property present in both the sensor output
> > > > endpoint and the CSI-2 RX input endpoint, but not the other endpoints in
> > > > the pipeline.
> > >
> > > This doesn't yet explain why the sensor would need to implement
> > > get_mbus_config if its bus configuration remains constant.
> >
> > If I recall correctly, the IPU driver calls .g_mbus_config() on the
> > camera sensor to get the number of lanes, as it can't get it from its
> > own endpoint. That's a hack, and as Jacopo proposed, calling
> > .g_mbus_config() on the CSI-2 RX would be better, as the CSI-2 RX driver
> > can then get the value from its own endpoint, without requiring all
> > sensor drivers to implement .g_mbus_config().
>
> The IPU driver doesn't call get_mbus_config, the CSI-2 RX driver does

Am I confusing IPU CSI with CSI-2 ?
https://elixir.bootlin.com/linux/latest/source/drivers/staging/media/imx/imx-media-csi.c#L211

> (csi2_get_active_lanes in imx6-mipi-csi2.c). It could just fall back to
> looking at its own endpoint if the upstream driver does not implement
> get_mbus_config.
>
> Of course that will only help if the DT contains this information and
> all connected lanes are active.

We should assume DTs are correct, otherwise we're screwed most of the
times...

>
> regards
> Philipp
