Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933706C0C82
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjCTItR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjCTIsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:48:51 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6AA358E;
        Mon, 20 Mar 2023 01:48:49 -0700 (PDT)
Received: from ideasonboard.com (93-61-96-190.ip145.fastwebnet.it [93.61.96.190])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 27424158D;
        Mon, 20 Mar 2023 09:48:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1679302127;
        bh=zlt562X9QzUgBwMymkMaVpfiMlPs4iZ2567c7dHn6w0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XnDyElPAvPhwVjN2lCbhGoMHqlGYSRBoqYNDkdQVT0f00Wd32nzSv/Je8vR33NrYf
         xxmsncDsQTvcj+oMzTUKSZHhahTTRB7eMBRAgHx6n7Sf7BaI6JtQaEjyIq6A3yczCH
         qlQQtfc3kdBAx0RtBUso89/Q+Az/ucP1iQ089Lws=
Date:   Mon, 20 Mar 2023 09:48:44 +0100
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-kernel@vger.kernel.org,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v2] media: i2c: ov5640: Implement get_mbus_config
Message-ID: <20230320084844.tdjiv6kaxcosiwm2@uno.localdomain>
References: <20230306063649.7387-1-marcel@ziswiler.com>
 <ZBBk+h3EMSsacZ6v@valkosipuli.retiisi.eu>
 <ZBBpUAhis8L5Dtuz@francesco-nb.int.toradex.com>
 <ZBBsgW75Gc2FmuQ0@valkosipuli.retiisi.eu>
 <ZBBvmjUZIn/g0/Nv@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZBBvmjUZIn/g0/Nv@francesco-nb.int.toradex.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Tue, Mar 14, 2023 at 01:59:06PM +0100, Francesco Dolcini wrote:
> +Marco
>
> On Tue, Mar 14, 2023 at 02:45:53PM +0200, Sakari Ailus wrote:
> > On Tue, Mar 14, 2023 at 01:32:16PM +0100, Francesco Dolcini wrote:
> > > On Tue, Mar 14, 2023 at 02:13:46PM +0200, Sakari Ailus wrote:
> > > > On Mon, Mar 06, 2023 at 07:36:49AM +0100, Marcel Ziswiler wrote:
> > > > > From: Aishwarya Kothari <aishwarya.kothari@toradex.com>
> > > > >
> > > > > Implement the introduced get_mbus_config operation to report the
> > > > > config of the MIPI CSI-2, BT.656 and Parallel interface.
> > > > >
> > > > > Signed-off-by: Aishwarya Kothari <aishwarya.kothari@toradex.com>
> > > > > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > >
> > > > What's the reasoning for this patch?
> > >
> > > Without this it's not possible to use it on i.MX6,
> > > drivers/staging/media/imx/imx6-mipi-csi2.c requires it, some more
> > > details from Jacopo here [0].
> > >
> > > Everything used to work fine up to v5.18, after that kernel version
> > > various changes broke it [1][2] (I assume you are pretty much aware of
> > > the history here, you commented on a few emails).
> > >
> > > [0] https://lore.kernel.org/all/20230128100611.7ulsfqqqgscg54gy@uno.localdomain/
> > > [1] https://lore.kernel.org/all/081cc2d3-1f3a-6c14-6dc7-53f976be7b2b@gmail.com/
> > > [2] https://lore.kernel.org/all/cacfe146-101b-35b3-5f66-1a1cabfd342f@gmail.com/
> > >
> > > > Drivers that don't have e.g. dynamic lane configuration shouldn't need to
> > > > implement get_mbus_config.
> >
> > Not even for staging drivers. The driver should be fixed to get that
> > information from the endpoint instead.
>
> This seems exactly the opposite of what commit
> 7318abface48 ("media: imx: Use get_mbus_config instead of parsing upstream DT endpoints")
> did.
>
> Given that I am somehow confused, but I am not that familiar with this
> subsystem, so I guess this is expected :-). Can someone provide some
> additional hint here?
>

As per my understanding, the i.MX6 IPU CSI driver connects to the
CSI-2 receiver and/or two video muxes. One figure's worth a thousands
words: "Figure 19-1. CSI2IPU gasket connectivity" of the IMX6DQRM TRM.

So the local endpoint might not provide the required information on
the bus configuration as it connects to a video-mux.

That's why the imx_media_pipeline_subdev() helper is used in
csi_get_upstream_mbus_config().

My gut feeling is that it would be better to always call
get_mbus_config() on the next subdev (the mux or the CSI-2 rx) and
there parse the local endpoint as it's the mux or the CSI-2 rx that
connect to the actual source.

To be honest my understanding is that this patch has always been
needed to work on imx6 and this is not a regression but something that
was kept as an out-of-tree patch downstream. Is this correct or is
this a regression ? The above mentioned patches that move fwnode
matching to endpoints don't seem related, don't they ?

Thanks
   j

> > I don't object having a helper in the framework to do this though. There
> > are many receiver drivers that need this to work with those devices that
> > have variable number of lanes.
>
> Thanks in advance,
> Francesco
>
