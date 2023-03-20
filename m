Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660FB6C143D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjCTOAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjCTOAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:00:15 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9C21206C;
        Mon, 20 Mar 2023 07:00:09 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6EAF4A25;
        Mon, 20 Mar 2023 15:00:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1679320806;
        bh=IG/Ir90hcp4I1UHRmwtxnVj3+qNUDUJWDkrsBZJN4gg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qyAMbXQ/f0E1sZvnkwuRRhBTGA8pBu+c4i7tF2uQErqLbeASllho8Km8tZG4TfrG9
         7hp9ySO1weLJIsJR6WbkP3GXqCP4ZIqlLZclmQxMt1T9Jjpkr8wkVSLT9OnYmsF19f
         rYjaOJ8Bi4dbaoWwI1pwRBcigUAMBY7b5ITHonOk=
Date:   Mon, 20 Mar 2023 16:00:12 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
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
Message-ID: <20230320140012.GB9535@pendragon.ideasonboard.com>
References: <ZBBpUAhis8L5Dtuz@francesco-nb.int.toradex.com>
 <ZBBsgW75Gc2FmuQ0@valkosipuli.retiisi.eu>
 <ZBBvmjUZIn/g0/Nv@francesco-nb.int.toradex.com>
 <20230320084844.tdjiv6kaxcosiwm2@uno.localdomain>
 <ZBggtBU1TjlvVNCS@kekkonen.localdomain>
 <20230320092602.GE20234@pendragon.ideasonboard.com>
 <ZBgpXRtXcxg14OGv@kekkonen.localdomain>
 <20230320095514.GF20234@pendragon.ideasonboard.com>
 <ZBgyOPS23BC2wAfg@kekkonen.localdomain>
 <727949a9c3d9e639b046bcd86635796452b10300.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <727949a9c3d9e639b046bcd86635796452b10300.camel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 02:32:25PM +0100, Philipp Zabel wrote:
> On Mo, 2023-03-20 at 12:15 +0200, Sakari Ailus wrote:
> > On Mon, Mar 20, 2023 at 11:55:14AM +0200, Laurent Pinchart wrote:
> > > On Mon, Mar 20, 2023 at 11:37:33AM +0200, Sakari Ailus wrote:
> > > > On Mon, Mar 20, 2023 at 11:26:02AM +0200, Laurent Pinchart wrote:
> > > > > In a (simplified) nutshell,
> > > > > 
> > > > > ---------+     +----------+     +---------+     +-----+     +-----+
> > > > > > Camera | --> | CSI-2 RX | --> | CSI2IPU | --> | Mux | --> | IPU |
> > > > > > Sensor |     |          |     | Gasket  |     |     |     |     |
> > > > > ---------+     +----------+     +---------+     +-----+     +-----+
> > > > 
> > > > Thank you, this is helpful.
> > > > 
> > > > I suppose the mux here at least won't actively do anything to the data. So
> > > > presumably its endpoint won't contain the active configuration, but its
> > > > superset.
> > > > 
> > > > > 
> > > > > All those blocks, except for the gasket, have a node in DT.
> > > > > 
> > > > > The IPU driver needs to know the number of CSI-2 data lanes, which is
> > > > > encoded in the data-lanes DT property present in both the sensor output
> > > > > endpoint and the CSI-2 RX input endpoint, but not the other endpoints in
> > > > > the pipeline.
> > > > 
> > > > This doesn't yet explain why the sensor would need to implement
> > > > get_mbus_config if its bus configuration remains constant.
> > > 
> > > If I recall correctly, the IPU driver calls .g_mbus_config() on the
> > > camera sensor to get the number of lanes, as it can't get it from its
> > > own endpoint. That's a hack, and as Jacopo proposed, calling
> > > .g_mbus_config() on the CSI-2 RX would be better, as the CSI-2 RX driver
> > > can then get the value from its own endpoint, without requiring all
> > > sensor drivers to implement .g_mbus_config().
> > 
> > The g_mbus_config op could be implemented by the CSI2IPU and mux, by simply
> > requesting the information from the upstream sub-device. No hacks would be
> > needed.
> 
> I think implementing get_mbus_config on the mux might be enough. The
> IPU driver already recognizes the CSI-2 RX by its grp_id and could
> infer that it has to use MIPI CSI-2 mode from that.
> 
> The video-mux would have to forward get_mbus_config to its active
> upstream port and if the upstream sensor does not implement it read bus
> width from the active upstream endpoint.

I'm fine with implementing it in the mux as well, but I think we can
take a shortcut here and call it on the CSI-2 RX from the IPU driver, as
the IPU driver knows about the architecture of the whole pipeline.

-- 
Regards,

Laurent Pinchart
