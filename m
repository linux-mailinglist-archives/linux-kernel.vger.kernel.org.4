Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6218D6B953A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjCNNEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjCNNDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:03:51 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C7C12879;
        Tue, 14 Mar 2023 05:59:50 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 625E520BBA;
        Tue, 14 Mar 2023 13:59:08 +0100 (CET)
Date:   Tue, 14 Mar 2023 13:59:06 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
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
Message-ID: <ZBBvmjUZIn/g0/Nv@francesco-nb.int.toradex.com>
References: <20230306063649.7387-1-marcel@ziswiler.com>
 <ZBBk+h3EMSsacZ6v@valkosipuli.retiisi.eu>
 <ZBBpUAhis8L5Dtuz@francesco-nb.int.toradex.com>
 <ZBBsgW75Gc2FmuQ0@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBBsgW75Gc2FmuQ0@valkosipuli.retiisi.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Marco

On Tue, Mar 14, 2023 at 02:45:53PM +0200, Sakari Ailus wrote:
> On Tue, Mar 14, 2023 at 01:32:16PM +0100, Francesco Dolcini wrote:
> > On Tue, Mar 14, 2023 at 02:13:46PM +0200, Sakari Ailus wrote:
> > > On Mon, Mar 06, 2023 at 07:36:49AM +0100, Marcel Ziswiler wrote:
> > > > From: Aishwarya Kothari <aishwarya.kothari@toradex.com>
> > > > 
> > > > Implement the introduced get_mbus_config operation to report the
> > > > config of the MIPI CSI-2, BT.656 and Parallel interface.
> > > > 
> > > > Signed-off-by: Aishwarya Kothari <aishwarya.kothari@toradex.com>
> > > > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > 
> > > What's the reasoning for this patch?
> > 
> > Without this it's not possible to use it on i.MX6,
> > drivers/staging/media/imx/imx6-mipi-csi2.c requires it, some more
> > details from Jacopo here [0].
> > 
> > Everything used to work fine up to v5.18, after that kernel version
> > various changes broke it [1][2] (I assume you are pretty much aware of
> > the history here, you commented on a few emails).
> > 
> > [0] https://lore.kernel.org/all/20230128100611.7ulsfqqqgscg54gy@uno.localdomain/
> > [1] https://lore.kernel.org/all/081cc2d3-1f3a-6c14-6dc7-53f976be7b2b@gmail.com/
> > [2] https://lore.kernel.org/all/cacfe146-101b-35b3-5f66-1a1cabfd342f@gmail.com/
> > 
> > > Drivers that don't have e.g. dynamic lane configuration shouldn't need to
> > > implement get_mbus_config.
> 
> Not even for staging drivers. The driver should be fixed to get that
> information from the endpoint instead.

This seems exactly the opposite of what commit 
7318abface48 ("media: imx: Use get_mbus_config instead of parsing upstream DT endpoints")
did.

Given that I am somehow confused, but I am not that familiar with this
subsystem, so I guess this is expected :-). Can someone provide some
additional hint here?

> I don't object having a helper in the framework to do this though. There
> are many receiver drivers that need this to work with those devices that
> have variable number of lanes.

Thanks in advance,
Francesco

