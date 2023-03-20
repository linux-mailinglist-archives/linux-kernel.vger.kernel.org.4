Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFEC6C1366
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjCTN3H convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Mar 2023 09:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjCTN3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:29:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B6025B89
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:28:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1peFYg-0006FQ-41; Mon, 20 Mar 2023 14:28:18 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1peFYe-005TH5-Ai; Mon, 20 Mar 2023 14:28:16 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1peFYd-0009oL-FK; Mon, 20 Mar 2023 14:28:15 +0100
Message-ID: <fffbd2139aa81c04138d49946686eceefc8a0d4e.camel@pengutronix.de>
Subject: Re: [PATCH v2] media: i2c: ov5640: Implement get_mbus_config
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
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
Date:   Mon, 20 Mar 2023 14:28:15 +0100
In-Reply-To: <20230320124712.q67dqlldkqsdwyke@uno.localdomain>
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
         <20230320124712.q67dqlldkqsdwyke@uno.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1+deb11u1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2023-03-20 at 13:47 +0100, Jacopo Mondi wrote:
> Hi Philipp
> 
> On Mon, Mar 20, 2023 at 12:26:26PM +0100, Philipp Zabel wrote:
> > On Mo, 2023-03-20 at 11:55 +0200, Laurent Pinchart wrote:
> > > On Mon, Mar 20, 2023 at 11:37:33AM +0200, Sakari Ailus wrote:
> > > > Hi Laurent,
> > > > 
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
> > The IPU driver doesn't call get_mbus_config, the CSI-2 RX driver does
> 
> Am I confusing IPU CSI with CSI-2 ?
> https://elixir.bootlin.com/linux/latest/source/drivers/staging/media/imx/imx-media-csi.c#L211

What the eyesight ... Sorry for the confusion. You are right, it's
right there. Yes, that is IPU CSI calling get_mbus_config.

I had git grepped for get_mbus_config this morning, and was convinced I
only found the call in imx-media-csi2, which is where the number of
lanes is evaluated. The call in imx-media-csi.c is used to determine
whether the sensor is parallel or CSI-2 and whether the CSI has to
operate in bypass mode (for 16-bit parallel bus).

regards
Philipp
