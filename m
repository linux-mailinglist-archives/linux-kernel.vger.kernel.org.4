Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0E05BE375
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiITKjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiITKic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:38:32 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EC074B92;
        Tue, 20 Sep 2022 03:37:03 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 62FE86DB;
        Tue, 20 Sep 2022 12:37:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1663670221;
        bh=NOaFEv7+/TxiumsP+2i9278UrYUHgGzrEwYWBF9DCqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CEJr7fkTH7i8K71egdSuFaNsfFgujdVxyDL8JpQ5c5NpuiECvF4CDFjDdoX0OVg6k
         XY8OxbYXIsGMWWACUPN9sb1XgH5JvkSzi95gHnu5tWPIvfrBkebLW2dtc8lCpyhp8J
         9IzDKtQTDki3atqMXjVb67Jmksh4lH1wTN3s/PMA=
Date:   Tue, 20 Sep 2022 13:36:47 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Marco Felsch <m.felsch@pengutronix.de>, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, akinobu.mita@gmail.com,
        jacopo+renesas@jmondi.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] media: mt9m111: fix device power usage
Message-ID: <YymXv4AB9x77wf8J@pendragon.ideasonboard.com>
References: <20220916135713.143890-1-m.felsch@pengutronix.de>
 <20220916135713.143890-2-m.felsch@pengutronix.de>
 <20220920102704.mna6ys3bpgdi4flo@lati>
 <20220920103412.cxpykimes3d7rz7i@lati>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920103412.cxpykimes3d7rz7i@lati>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 12:34:12PM +0200, Jacopo Mondi wrote:
> On Tue, Sep 20, 2022 at 12:27:04PM +0200, Jacopo Mondi wrote:
> > On Fri, Sep 16, 2022 at 03:57:12PM +0200, Marco Felsch wrote:
> > > Currently the driver turn off the power after probe and toggle it during
> > > .stream by using the .s_power callback. This is problematic since other
> > > callbacks like .set_fmt accessing the hardware as well which will fail.
> > > So in the end the default format is the only supported format.
> > >
> > > Remove the hardware register access from the callbacks and instead sync
> > > the state once right before the stream gets enabled to fix this for
> > > .set_fmt() and .set_selection(). For the debug register access we need
> > > to turn the device on/off before accessing the registers to fix this and
> > > finally for the ctrls access we need the device to be powered to fix
> > > this.
> > >
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> > > Changelog:
> > >
> > > v2:
> > > - squash patch 2 and 3
> > > ---
> > >  drivers/media/i2c/mt9m111.c | 40 ++++++++++++++++++++-----------------
> > >  1 file changed, 22 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/media/i2c/mt9m111.c b/drivers/media/i2c/mt9m111.c
> > > index 52be1c310455..8de93ab99cbc 100644
> > > --- a/drivers/media/i2c/mt9m111.c
> > > +++ b/drivers/media/i2c/mt9m111.c
> > > @@ -455,7 +455,7 @@ static int mt9m111_set_selection(struct v4l2_subdev *sd,
> > >  	struct mt9m111 *mt9m111 = to_mt9m111(client);
> > >  	struct v4l2_rect rect = sel->r;
> > >  	int width, height;
> > > -	int ret, align = 0;
> > > +	int align = 0;
> > >
> > >  	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE ||
> > >  	    sel->target != V4L2_SEL_TGT_CROP)
> > > @@ -481,14 +481,11 @@ static int mt9m111_set_selection(struct v4l2_subdev *sd,
> > >  	width = min(mt9m111->width, rect.width);
> > >  	height = min(mt9m111->height, rect.height);
> > >
> > > -	ret = mt9m111_setup_geometry(mt9m111, &rect, width, height, mt9m111->fmt->code);
> > > -	if (!ret) {
> > > -		mt9m111->rect = rect;
> > > -		mt9m111->width = width;
> > > -		mt9m111->height = height;
> > > -	}
> > > +	mt9m111->rect = rect;
> > > +	mt9m111->width = width;
> > > +	mt9m111->height = height;
> > >
> > > -	return ret;
> > > +	return 0;
> > >  }
> > >
> > >  static int mt9m111_get_selection(struct v4l2_subdev *sd,
> > > @@ -632,7 +629,6 @@ static int mt9m111_set_fmt(struct v4l2_subdev *sd,
> > >  	const struct mt9m111_datafmt *fmt;
> > >  	struct v4l2_rect *rect = &mt9m111->rect;
> > >  	bool bayer;
> > > -	int ret;
> > >
> > >  	if (mt9m111->is_streaming)
> > >  		return -EBUSY;
> > > @@ -681,16 +677,11 @@ static int mt9m111_set_fmt(struct v4l2_subdev *sd,
> > >  		return 0;
> > >  	}
> > >
> > > -	ret = mt9m111_setup_geometry(mt9m111, rect, mf->width, mf->height, mf->code);
> > > -	if (!ret)
> > > -		ret = mt9m111_set_pixfmt(mt9m111, mf->code);
> > > -	if (!ret) {
> > > -		mt9m111->width	= mf->width;
> > > -		mt9m111->height	= mf->height;
> > > -		mt9m111->fmt	= fmt;
> > > -	}
> > > +	mt9m111->width	= mf->width;
> > > +	mt9m111->height	= mf->height;
> > > +	mt9m111->fmt	= fmt;
> > >
> > > -	return ret;
> > > +	return 0;
> > >  }
> > >
> > >  static const struct mt9m111_mode_info *
> > > @@ -748,6 +739,8 @@ mt9m111_find_mode(struct mt9m111 *mt9m111, unsigned int req_fps,
> > >  	return mode;
> > >  }
> > >
> > > +static int mt9m111_s_power(struct v4l2_subdev *sd, int on);
> > > +
> > >  #ifdef CONFIG_VIDEO_ADV_DEBUG
> > >  static int mt9m111_g_register(struct v4l2_subdev *sd,
> > >  			      struct v4l2_dbg_register *reg)
> > > @@ -758,10 +751,14 @@ static int mt9m111_g_register(struct v4l2_subdev *sd,
> > >  	if (reg->reg > 0x2ff)
> > >  		return -EINVAL;
> > >
> > > +	mt9m111_s_power(sd, 1);
> > > +
> > >  	val = mt9m111_reg_read(client, reg->reg);
> > >  	reg->size = 2;
> > >  	reg->val = (u64)val;
> > >
> > > +	mt9m111_s_power(sd, 0);
> > > +
> > >  	if (reg->val > 0xffff)
> > >  		return -EIO;
> > >
> > > @@ -776,9 +773,13 @@ static int mt9m111_s_register(struct v4l2_subdev *sd,
> > >  	if (reg->reg > 0x2ff)
> > >  		return -EINVAL;
> > >
> > > +	mt9m111_s_power(sd, 1);
> > > +
> > >  	if (mt9m111_reg_write(client, reg->reg, reg->val) < 0)
> > >  		return -EIO;
> > >
> > > +	mt9m111_s_power(sd, 0);
> > > +
> >
> > So far so good
> >
> > >  	return 0;
> > >  }
> > >  #endif
> > > @@ -891,6 +892,9 @@ static int mt9m111_s_ctrl(struct v4l2_ctrl *ctrl)
> > >  	struct mt9m111 *mt9m111 = container_of(ctrl->handler,
> > >  					       struct mt9m111, hdl);
> > >
> > > +	if (!mt9m111->is_streaming)
> > > +		return 0;
> > > +
> >
> > If you refuse to set controls if the sensor is not streaming (ie
> > powered) which I think it's right, shouldn't you call
> > __v4l2_ctrl_handler_setup() at s_stream(1) time to have the controls
> > applied ?
> 
> Oh scratch that, it's in the s_power(1) call path. It's would be nicer
> to have runtime_pm, but you already know that :)

Runtime PM shouldn't be hard to implement, I'd really prefer that.

> Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
> 
> > >  	switch (ctrl->id) {
> > >  	case V4L2_CID_VFLIP:
> > >  		return mt9m111_set_flip(mt9m111, ctrl->val,

-- 
Regards,

Laurent Pinchart
