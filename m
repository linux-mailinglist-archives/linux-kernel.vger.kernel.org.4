Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8226B9425
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjCNMmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjCNMmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:42:05 -0400
X-Greylist: delayed 447 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Mar 2023 05:41:29 PDT
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794871C7FB;
        Tue, 14 Mar 2023 05:41:29 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 41D5F20BBA;
        Tue, 14 Mar 2023 13:32:20 +0100 (CET)
Date:   Tue, 14 Mar 2023 13:32:16 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Marcel Ziswiler <marcel@ziswiler.com>, linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: i2c: ov5640: Implement get_mbus_config
Message-ID: <ZBBpUAhis8L5Dtuz@francesco-nb.int.toradex.com>
References: <20230306063649.7387-1-marcel@ziswiler.com>
 <ZBBk+h3EMSsacZ6v@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBBk+h3EMSsacZ6v@valkosipuli.retiisi.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sakari,

On Tue, Mar 14, 2023 at 02:13:46PM +0200, Sakari Ailus wrote:
> On Mon, Mar 06, 2023 at 07:36:49AM +0100, Marcel Ziswiler wrote:
> > From: Aishwarya Kothari <aishwarya.kothari@toradex.com>
> > 
> > Implement the introduced get_mbus_config operation to report the
> > config of the MIPI CSI-2, BT.656 and Parallel interface.
> > 
> > Signed-off-by: Aishwarya Kothari <aishwarya.kothari@toradex.com>
> > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > 
> > ---
> > 
> > Changes in v2:
> > - Take care of MIPI CSI-2, BT.656 and Parallel interface as
> >   pointed out by Jacopo. Thanks!
> > 
> >  drivers/media/i2c/ov5640.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
> > index 1536649b9e90..43373416fcba 100644
> > --- a/drivers/media/i2c/ov5640.c
> > +++ b/drivers/media/i2c/ov5640.c
> > @@ -3774,6 +3774,24 @@ static int ov5640_init_cfg(struct v4l2_subdev *sd,
> >  	return 0;
> >  }
> >  
> > +static int ov5640_get_mbus_config(struct v4l2_subdev *sd,
> > +				   unsigned int pad,
> > +				   struct v4l2_mbus_config *cfg)
> > +{
> > +	struct ov5640_dev *sensor = to_ov5640_dev(sd);
> > +
> > +	cfg->type = sensor->ep.bus_type;
> > +	if (ov5640_is_csi2(sensor)) {
> > +		cfg->bus.mipi_csi2.num_data_lanes =
> > +			sensor->ep.bus.mipi_csi2.num_data_lanes;
> > +		cfg->bus.mipi_csi2.flags = sensor->ep.bus.mipi_csi2.flags;
> > +	} else {
> > +		cfg->bus.parallel.flags = sensor->ep.bus.parallel.flags;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct v4l2_subdev_core_ops ov5640_core_ops = {
> >  	.log_status = v4l2_ctrl_subdev_log_status,
> >  	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
> > @@ -3794,6 +3812,7 @@ static const struct v4l2_subdev_pad_ops ov5640_pad_ops = {
> >  	.get_selection = ov5640_get_selection,
> >  	.enum_frame_size = ov5640_enum_frame_size,
> >  	.enum_frame_interval = ov5640_enum_frame_interval,
> > +	.get_mbus_config = ov5640_get_mbus_config,
> 
> What's the reasoning for this patch?

Without this it's not possible to use it on i.MX6,
drivers/staging/media/imx/imx6-mipi-csi2.c requires it, some more
details from Jacopo here [0].

Everything used to work fine up to v5.18, after that kernel version
various changes broke it [1][2] (I assume you are pretty much aware of
the history here, you commented on a few emails).

[0] https://lore.kernel.org/all/20230128100611.7ulsfqqqgscg54gy@uno.localdomain/
[1] https://lore.kernel.org/all/081cc2d3-1f3a-6c14-6dc7-53f976be7b2b@gmail.com/
[2] https://lore.kernel.org/all/cacfe146-101b-35b3-5f66-1a1cabfd342f@gmail.com/

> Drivers that don't have e.g. dynamic lane configuration shouldn't need to
> implement get_mbus_config.

Francesco

