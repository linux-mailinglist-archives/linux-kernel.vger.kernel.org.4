Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E97967ED94
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbjA0SeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjA0SeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:34:17 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E325143C;
        Fri, 27 Jan 2023 10:34:16 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EEFCB25B;
        Fri, 27 Jan 2023 19:34:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674844454;
        bh=rC8KATJNY5fwLP3srFe3PrWSsurSZYI1usUQqO0j/iM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qa94+SpQj9FdiztNKMIKuMzj9LYiuGKQNfPjjHfbV3f7SgolPKbcpixha9alNQ+/+
         zTZ8Iu/8/dPhAf9CE+NPd1dbcv6hLEHg7wfgEJTn1kCHuexw9K1bEdZkcDKJsADhkX
         67GeP8DQQndhGRhJgUzZ1JyTi1SCwRDngOA2Z720=
Date:   Fri, 27 Jan 2023 20:34:07 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Marcel Ziswiler <marcel@ziswiler.com>, linux-media@vger.kernel.org,
        kernel@pengutronix.de, Sakari Ailus <sakari.ailus@linux.intel.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] media: i2c: ov5640: Implement get_mbus_config
Message-ID: <Y9QZH2/jDbFbew2D@pendragon.ideasonboard.com>
References: <20230127151245.46732-1-marcel@ziswiler.com>
 <20230127175003.6ofmfaqovbqu54hg@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230127175003.6ofmfaqovbqu54hg@uno.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 06:50:03PM +0100, Jacopo Mondi wrote:
> On Fri, Jan 27, 2023 at 04:12:44PM +0100, Marcel Ziswiler wrote:
> > From: Aishwarya Kothari <aishwarya.kothari@toradex.com>
> >
> > Implement the introduced get_mbus_config operation to report the
> > number of used data lanes on the MIPI CSI-2 interface.
> >
> 
> OV5640 can operate in parallel mode too.
> 
> You can check how it currently configured with ov5640_is_csi2() and
> populate struct v4l2_mbus_config accordingly.

I'm also wondering which CSI-2 receiver needs .get_mbus_config() for the
ov5640. The number of lanes is usually specified in DT, on both sides of
the link. It's only when selecting a number of lanes dynamically at
runtime that .get_mbus_config() is needed.

> > Signed-off-by: Aishwarya Kothari <aishwarya.kothari@toradex.com>
> > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> >
> > ---
> >
> >  drivers/media/i2c/ov5640.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
> > index e0f908af581b..42d43f0d1e1c 100644
> > --- a/drivers/media/i2c/ov5640.c
> > +++ b/drivers/media/i2c/ov5640.c
> > @@ -3733,6 +3733,19 @@ static int ov5640_init_cfg(struct v4l2_subdev *sd,
> >  	return 0;
> >  }
> >
> > +static int ov5640_get_mbus_config(struct v4l2_subdev *sd,
> > +				   unsigned int pad,
> > +				   struct v4l2_mbus_config *cfg)
> > +{
> > +	struct ov5640_dev *sensor = to_ov5640_dev(sd);
> > +
> > +	cfg->type = V4L2_MBUS_CSI2_DPHY;
> > +	cfg->bus.mipi_csi2.num_data_lanes = sensor->ep.bus.mipi_csi2.num_data_lanes;
> > +	cfg->bus.mipi_csi2.flags = 0;
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct v4l2_subdev_core_ops ov5640_core_ops = {
> >  	.log_status = v4l2_ctrl_subdev_log_status,
> >  	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
> > @@ -3753,6 +3766,7 @@ static const struct v4l2_subdev_pad_ops ov5640_pad_ops = {
> >  	.get_selection = ov5640_get_selection,
> >  	.enum_frame_size = ov5640_enum_frame_size,
> >  	.enum_frame_interval = ov5640_enum_frame_interval,
> > +	.get_mbus_config = ov5640_get_mbus_config,
> >  };
> >
> >  static const struct v4l2_subdev_ops ov5640_subdev_ops = {

-- 
Regards,

Laurent Pinchart
