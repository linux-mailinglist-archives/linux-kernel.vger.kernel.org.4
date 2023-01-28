Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B4467F6E2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjA1KGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjA1KGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:06:21 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42D27C32B;
        Sat, 28 Jan 2023 02:06:17 -0800 (PST)
Received: from ideasonboard.com (host-212-171-97-20.retail.telecomitalia.it [212.171.97.20])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B8FF15A9;
        Sat, 28 Jan 2023 11:06:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674900375;
        bh=KEbqha5WsN8gzYrfjT35M5Ldl0aRj8T+nZjEG+cg5O0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sd43Idqn1Oc3F/HMPBorjbon4xElXMA080j28jmZoY3c9+UKK14q6opT2lC7CFv2h
         eM0hhK4+8qfojmr6ExftyNdfvhKCW9rP4lIc4+hQftS9/ZoTIF2gI6+/fIUSuqmszQ
         7OTgiWxdRbqnZoS6GfQZAcxpckqttbjHYsg0PYQc=
Date:   Sat, 28 Jan 2023 11:06:11 +0100
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-media@vger.kernel.org, kernel@pengutronix.de,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] media: i2c: ov5640: Implement get_mbus_config
Message-ID: <20230128100611.7ulsfqqqgscg54gy@uno.localdomain>
References: <20230127151245.46732-1-marcel@ziswiler.com>
 <20230127175003.6ofmfaqovbqu54hg@uno.localdomain>
 <Y9QZH2/jDbFbew2D@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y9QZH2/jDbFbew2D@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On Fri, Jan 27, 2023 at 08:34:07PM +0200, Laurent Pinchart wrote:
> On Fri, Jan 27, 2023 at 06:50:03PM +0100, Jacopo Mondi wrote:
> > On Fri, Jan 27, 2023 at 04:12:44PM +0100, Marcel Ziswiler wrote:
> > > From: Aishwarya Kothari <aishwarya.kothari@toradex.com>
> > >
> > > Implement the introduced get_mbus_config operation to report the
> > > number of used data lanes on the MIPI CSI-2 interface.
> > >
> >
> > OV5640 can operate in parallel mode too.
> >
> > You can check how it currently configured with ov5640_is_csi2() and
> > populate struct v4l2_mbus_config accordingly.
>
> I'm also wondering which CSI-2 receiver needs .get_mbus_config() for the
> ov5640. The number of lanes is usually specified in DT, on both sides of
> the link. It's only when selecting a number of lanes dynamically at
> runtime that .get_mbus_config() is needed.
>

iirc Aishwarya and Marcel reported issues on i.MX6 so I presume they
need get_mbus_config as a drivers in staging/media/imx/ requires
that:

drivers/staging/media/imx/imx6-mipi-csi2.c
Fetches the remote mbus config to get the number of lanes and make
sure the bus type is CSI-2

drivers/staging/media/imx/imx-media-csi.c
Fetches the remote mbus config to deduce the bus type in use

In both cases I concur the callers can be fixed to parse their
endpoints but looking at commit 7318abface486d6a6389731810f5b60650daedb5
it seems that was not the plan (reason not clear to me)

> > > Signed-off-by: Aishwarya Kothari <aishwarya.kothari@toradex.com>
> > > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > >
> > > ---
> > >
> > >  drivers/media/i2c/ov5640.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
> > > index e0f908af581b..42d43f0d1e1c 100644
> > > --- a/drivers/media/i2c/ov5640.c
> > > +++ b/drivers/media/i2c/ov5640.c
> > > @@ -3733,6 +3733,19 @@ static int ov5640_init_cfg(struct v4l2_subdev *sd,
> > >  	return 0;
> > >  }
> > >
> > > +static int ov5640_get_mbus_config(struct v4l2_subdev *sd,
> > > +				   unsigned int pad,
> > > +				   struct v4l2_mbus_config *cfg)
> > > +{
> > > +	struct ov5640_dev *sensor = to_ov5640_dev(sd);
> > > +
> > > +	cfg->type = V4L2_MBUS_CSI2_DPHY;
> > > +	cfg->bus.mipi_csi2.num_data_lanes = sensor->ep.bus.mipi_csi2.num_data_lanes;
> > > +	cfg->bus.mipi_csi2.flags = 0;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static const struct v4l2_subdev_core_ops ov5640_core_ops = {
> > >  	.log_status = v4l2_ctrl_subdev_log_status,
> > >  	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
> > > @@ -3753,6 +3766,7 @@ static const struct v4l2_subdev_pad_ops ov5640_pad_ops = {
> > >  	.get_selection = ov5640_get_selection,
> > >  	.enum_frame_size = ov5640_enum_frame_size,
> > >  	.enum_frame_interval = ov5640_enum_frame_interval,
> > > +	.get_mbus_config = ov5640_get_mbus_config,
> > >  };
> > >
> > >  static const struct v4l2_subdev_ops ov5640_subdev_ops = {
>
> --
> Regards,
>
> Laurent Pinchart
