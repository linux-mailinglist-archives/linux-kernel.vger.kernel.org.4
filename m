Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BF25BE328
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiITK1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiITK1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:27:15 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B29D719BD;
        Tue, 20 Sep 2022 03:27:11 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 7427E200008;
        Tue, 20 Sep 2022 10:27:07 +0000 (UTC)
Date:   Tue, 20 Sep 2022 12:27:04 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        laurent.pinchart+renesas@ideasonboard.com, akinobu.mita@gmail.com,
        jacopo+renesas@jmondi.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] media: mt9m111: fix device power usage
Message-ID: <20220920102704.mna6ys3bpgdi4flo@lati>
References: <20220916135713.143890-1-m.felsch@pengutronix.de>
 <20220916135713.143890-2-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220916135713.143890-2-m.felsch@pengutronix.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco

On Fri, Sep 16, 2022 at 03:57:12PM +0200, Marco Felsch wrote:
> Currently the driver turn off the power after probe and toggle it during
> .stream by using the .s_power callback. This is problematic since other
> callbacks like .set_fmt accessing the hardware as well which will fail.
> So in the end the default format is the only supported format.
>
> Remove the hardware register access from the callbacks and instead sync
> the state once right before the stream gets enabled to fix this for
> .set_fmt() and .set_selection(). For the debug register access we need
> to turn the device on/off before accessing the registers to fix this and
> finally for the ctrls access we need the device to be powered to fix
> this.
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> Changelog:
>
> v2:
> - squash patch 2 and 3
> ---
>  drivers/media/i2c/mt9m111.c | 40 ++++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/media/i2c/mt9m111.c b/drivers/media/i2c/mt9m111.c
> index 52be1c310455..8de93ab99cbc 100644
> --- a/drivers/media/i2c/mt9m111.c
> +++ b/drivers/media/i2c/mt9m111.c
> @@ -455,7 +455,7 @@ static int mt9m111_set_selection(struct v4l2_subdev *sd,
>  	struct mt9m111 *mt9m111 = to_mt9m111(client);
>  	struct v4l2_rect rect = sel->r;
>  	int width, height;
> -	int ret, align = 0;
> +	int align = 0;
>
>  	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE ||
>  	    sel->target != V4L2_SEL_TGT_CROP)
> @@ -481,14 +481,11 @@ static int mt9m111_set_selection(struct v4l2_subdev *sd,
>  	width = min(mt9m111->width, rect.width);
>  	height = min(mt9m111->height, rect.height);
>
> -	ret = mt9m111_setup_geometry(mt9m111, &rect, width, height, mt9m111->fmt->code);
> -	if (!ret) {
> -		mt9m111->rect = rect;
> -		mt9m111->width = width;
> -		mt9m111->height = height;
> -	}
> +	mt9m111->rect = rect;
> +	mt9m111->width = width;
> +	mt9m111->height = height;
>
> -	return ret;
> +	return 0;
>  }
>
>  static int mt9m111_get_selection(struct v4l2_subdev *sd,
> @@ -632,7 +629,6 @@ static int mt9m111_set_fmt(struct v4l2_subdev *sd,
>  	const struct mt9m111_datafmt *fmt;
>  	struct v4l2_rect *rect = &mt9m111->rect;
>  	bool bayer;
> -	int ret;
>
>  	if (mt9m111->is_streaming)
>  		return -EBUSY;
> @@ -681,16 +677,11 @@ static int mt9m111_set_fmt(struct v4l2_subdev *sd,
>  		return 0;
>  	}
>
> -	ret = mt9m111_setup_geometry(mt9m111, rect, mf->width, mf->height, mf->code);
> -	if (!ret)
> -		ret = mt9m111_set_pixfmt(mt9m111, mf->code);
> -	if (!ret) {
> -		mt9m111->width	= mf->width;
> -		mt9m111->height	= mf->height;
> -		mt9m111->fmt	= fmt;
> -	}
> +	mt9m111->width	= mf->width;
> +	mt9m111->height	= mf->height;
> +	mt9m111->fmt	= fmt;
>
> -	return ret;
> +	return 0;
>  }
>
>  static const struct mt9m111_mode_info *
> @@ -748,6 +739,8 @@ mt9m111_find_mode(struct mt9m111 *mt9m111, unsigned int req_fps,
>  	return mode;
>  }
>
> +static int mt9m111_s_power(struct v4l2_subdev *sd, int on);
> +
>  #ifdef CONFIG_VIDEO_ADV_DEBUG
>  static int mt9m111_g_register(struct v4l2_subdev *sd,
>  			      struct v4l2_dbg_register *reg)
> @@ -758,10 +751,14 @@ static int mt9m111_g_register(struct v4l2_subdev *sd,
>  	if (reg->reg > 0x2ff)
>  		return -EINVAL;
>
> +	mt9m111_s_power(sd, 1);
> +
>  	val = mt9m111_reg_read(client, reg->reg);
>  	reg->size = 2;
>  	reg->val = (u64)val;
>
> +	mt9m111_s_power(sd, 0);
> +
>  	if (reg->val > 0xffff)
>  		return -EIO;
>
> @@ -776,9 +773,13 @@ static int mt9m111_s_register(struct v4l2_subdev *sd,
>  	if (reg->reg > 0x2ff)
>  		return -EINVAL;
>
> +	mt9m111_s_power(sd, 1);
> +
>  	if (mt9m111_reg_write(client, reg->reg, reg->val) < 0)
>  		return -EIO;
>
> +	mt9m111_s_power(sd, 0);
> +

So far so good

>  	return 0;
>  }
>  #endif
> @@ -891,6 +892,9 @@ static int mt9m111_s_ctrl(struct v4l2_ctrl *ctrl)
>  	struct mt9m111 *mt9m111 = container_of(ctrl->handler,
>  					       struct mt9m111, hdl);
>
> +	if (!mt9m111->is_streaming)
> +		return 0;
> +

If you refuse to set controls if the sensor is not streaming (ie
powered) which I think it's right, shouldn't you call
__v4l2_ctrl_handler_setup() at s_stream(1) time to have the controls
applied ?

>  	switch (ctrl->id) {
>  	case V4L2_CID_VFLIP:
>  		return mt9m111_set_flip(mt9m111, ctrl->val,
> --
> 2.30.2
>
