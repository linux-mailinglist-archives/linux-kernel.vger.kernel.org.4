Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3278568095A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbjA3J1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbjA3J0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:26:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1592F7A1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:25:03 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1pMQOd-0006qs-0A; Mon, 30 Jan 2023 10:24:15 +0100
Received: from pza by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1pMQOa-0006aL-S6; Mon, 30 Jan 2023 10:24:12 +0100
Date:   Mon, 30 Jan 2023 10:24:12 +0100
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-media@vger.kernel.org, kernel@pengutronix.de,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] media: i2c: ov5640: Implement get_mbus_config
Message-ID: <20230130092412.GA8319@pengutronix.de>
References: <20230127151245.46732-1-marcel@ziswiler.com>
 <20230127175003.6ofmfaqovbqu54hg@uno.localdomain>
 <Y9QZH2/jDbFbew2D@pendragon.ideasonboard.com>
 <20230128100611.7ulsfqqqgscg54gy@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128100611.7ulsfqqqgscg54gy@uno.localdomain>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: pza@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Sat, Jan 28, 2023 at 11:06:11AM +0100, Jacopo Mondi wrote:
> Hi Laurent
> 
> On Fri, Jan 27, 2023 at 08:34:07PM +0200, Laurent Pinchart wrote:
> > On Fri, Jan 27, 2023 at 06:50:03PM +0100, Jacopo Mondi wrote:
> > > On Fri, Jan 27, 2023 at 04:12:44PM +0100, Marcel Ziswiler wrote:
> > > > From: Aishwarya Kothari <aishwarya.kothari@toradex.com>
> > > >
> > > > Implement the introduced get_mbus_config operation to report the
> > > > number of used data lanes on the MIPI CSI-2 interface.
> > > >
> > >
> > > OV5640 can operate in parallel mode too.
> > >
> > > You can check how it currently configured with ov5640_is_csi2() and
> > > populate struct v4l2_mbus_config accordingly.
> >
> > I'm also wondering which CSI-2 receiver needs .get_mbus_config() for the
> > ov5640. The number of lanes is usually specified in DT, on both sides of
> > the link. It's only when selecting a number of lanes dynamically at
> > runtime that .get_mbus_config() is needed.
> >
> 
> iirc Aishwarya and Marcel reported issues on i.MX6 so I presume they
> need get_mbus_config as a drivers in staging/media/imx/ requires
> that:
> 
> drivers/staging/media/imx/imx6-mipi-csi2.c
> Fetches the remote mbus config to get the number of lanes and make
> sure the bus type is CSI-2
> 
> drivers/staging/media/imx/imx-media-csi.c
> Fetches the remote mbus config to deduce the bus type in use
> 
> In both cases I concur the callers can be fixed to parse their
> endpoints but looking at commit 7318abface486d6a6389731810f5b60650daedb5
> it seems that was not the plan (reason not clear to me)

The tc358743 driver dynamically changes the number of active lanes
depending on bandwidth requirements.

regards
Philipp
