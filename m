Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C416B66C9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjCLNjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCLNjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:39:31 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B8C2473A;
        Sun, 12 Mar 2023 06:39:29 -0700 (PDT)
Received: from pendragon.ideasonboard.com (85-76-21-162-nat.elisa-mobile.fi [85.76.21.162])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id ABB85814;
        Sun, 12 Mar 2023 14:39:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1678628367;
        bh=naBjY6NLbxeb5GFbYVxafe0jQ5tTNhpw1PbkehpXiWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eXiOdDLJT5CzTcg0+3HjsW//eP1NNDfGpxdMVU/ROZVgCz7NmrGn49b/eIkvczyVk
         WBS8gSXQcF5r8ZomsjANncYHJKPg7yl9fvQXhIMKft8N5P9SWwRxtS1yRcAud9vEpW
         RUemjI4NhilaZ1uHIX1Dvzr1bC6RQmMcAf2B0L4A=
Date:   Sun, 12 Mar 2023 15:39:21 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     slongerbeam@gmail.com, p.zabel@pengutronix.de, mchehab@kernel.org,
        gregkh@linuxfoundation.org, shawnguo@kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: Re: [PATCH v2 1/2] media: imx: imx8mq-mipi-csi2: Use V4L2 subdev
 active state
Message-ID: <20230312133921.GK2545@pendragon.ideasonboard.com>
References: <20230307150047.1486186-1-martin.kepplinger@puri.sm>
 <20230307150047.1486186-2-martin.kepplinger@puri.sm>
 <20230312133112.GH2545@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230312133112.GH2545@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 03:31:23PM +0200, Laurent Pinchart wrote:
> Hi Martin,
> 
> Thank you for the patch.
> 
> On Tue, Mar 07, 2023 at 04:00:46PM +0100, Martin Kepplinger wrote:
> > Simplify the driver by using the V4L2 subdev active state API to store
> > the active format.
> > 
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > ---
> >  drivers/staging/media/imx/imx8mq-mipi-csi2.c | 118 ++++++++-----------
> >  1 file changed, 46 insertions(+), 72 deletions(-)
> > 
> > diff --git a/drivers/staging/media/imx/imx8mq-mipi-csi2.c b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
> > index c0d0bf770096..1aa8622a3bae 100644
> > --- a/drivers/staging/media/imx/imx8mq-mipi-csi2.c
> > +++ b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
> > @@ -119,9 +119,7 @@ struct csi_state {
> >  
> >  	struct v4l2_mbus_config_mipi_csi2 bus;
> >  
> > -	struct mutex lock; /* Protect csi2_fmt, format_mbus, state, hs_settle */
> > -	const struct csi2_pix_format *csi2_fmt;
> > -	struct v4l2_mbus_framefmt format_mbus[MIPI_CSI2_PADS_NUM];
> > +	struct mutex lock; /* Protect state and hs_settle */
> >  	u32 state;
> >  	u32 hs_settle;
> >  
> > @@ -322,16 +320,23 @@ static int imx8mq_mipi_csi_clk_get(struct csi_state *state)
> >  	return devm_clk_bulk_get(state->dev, CSI2_NUM_CLKS, state->clks);
> >  }
> >  
> > -static int imx8mq_mipi_csi_calc_hs_settle(struct csi_state *state)
> > +static int imx8mq_mipi_csi_calc_hs_settle(struct csi_state *state,
> > +					  struct v4l2_subdev_state *sd_state)
> >  {
> >  	s64 link_freq;
> >  	u32 lane_rate;
> >  	unsigned long esc_clk_rate;
> >  	u32 min_ths_settle, max_ths_settle, ths_settle_ns, esc_clk_period_ns;
> > +	const struct v4l2_mbus_framefmt *fmt;
> > +	const struct csi2_pix_format *csi2_fmt;
> >  
> >  	/* Calculate the line rate from the pixel rate. */
> > +
> > +	fmt = v4l2_subdev_get_pad_format(&state->sd, sd_state, MIPI_CSI2_PAD_SINK);
> > +	csi2_fmt = find_csi2_format(fmt->code);
> > +
> >  	link_freq = v4l2_get_link_freq(state->src_sd->ctrl_handler,
> > -				       state->csi2_fmt->width,
> > +				       csi2_fmt->width,
> >  				       state->bus.num_data_lanes * 2);
> >  	if (link_freq < 0) {
> >  		dev_err(state->dev, "Unable to obtain link frequency: %d\n",
> > @@ -380,7 +385,8 @@ static int imx8mq_mipi_csi_calc_hs_settle(struct csi_state *state)
> >  	return 0;
> >  }
> >  
> > -static int imx8mq_mipi_csi_start_stream(struct csi_state *state)
> > +static int imx8mq_mipi_csi_start_stream(struct csi_state *state,
> > +					struct v4l2_subdev_state *sd_state)
> >  {
> >  	int ret;
> >  
> > @@ -389,7 +395,7 @@ static int imx8mq_mipi_csi_start_stream(struct csi_state *state)
> >  		return ret;
> >  
> >  	imx8mq_mipi_csi_set_params(state);
> > -	ret = imx8mq_mipi_csi_calc_hs_settle(state);
> > +	ret = imx8mq_mipi_csi_calc_hs_settle(state, sd_state);
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -415,6 +421,7 @@ static struct csi_state *mipi_sd_to_csi2_state(struct v4l2_subdev *sdev)
> >  static int imx8mq_mipi_csi_s_stream(struct v4l2_subdev *sd, int enable)
> >  {
> >  	struct csi_state *state = mipi_sd_to_csi2_state(sd);
> > +	struct v4l2_subdev_state *sd_state;
> >  	int ret = 0;
> >  
> >  	if (enable) {
> > @@ -431,7 +438,9 @@ static int imx8mq_mipi_csi_s_stream(struct v4l2_subdev *sd, int enable)
> >  			goto unlock;
> >  		}
> >  
> > -		ret = imx8mq_mipi_csi_start_stream(state);
> > +		sd_state = v4l2_subdev_lock_and_get_active_state(sd);
> > +
> > +		ret = imx8mq_mipi_csi_start_stream(state, sd_state);
> >  		if (ret < 0)
> >  			goto unlock;
> 
> You're leaving the state locked here. I would write
> 
> 		sd_state = v4l2_subdev_lock_and_get_active_state(sd);
> 		ret = imx8mq_mipi_csi_start_stream(state, sd_state);
> 		v4l2_subdev_unlock_state(sd_state);
> 
> 		if (ret < 0)
> 			goto unlock;
> 
> and drop the v4l2_subdev_unlock_state() call below. Apart from that,
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

If you're fine with this change, there's no need so submit a v3, I'll
handle this locally.

> >  
> > @@ -440,6 +449,8 @@ static int imx8mq_mipi_csi_s_stream(struct v4l2_subdev *sd, int enable)
> >  			goto unlock;
> >  
> >  		state->state |= ST_STREAMING;
> > +
> > +		v4l2_subdev_unlock_state(sd_state);
> >  	} else {
> >  		v4l2_subdev_call(state->src_sd, video, s_stream, 0);
> >  		imx8mq_mipi_csi_stop_stream(state);
> > @@ -455,29 +466,14 @@ static int imx8mq_mipi_csi_s_stream(struct v4l2_subdev *sd, int enable)
> >  	return ret;
> >  }
> >  
> > -static struct v4l2_mbus_framefmt *
> > -imx8mq_mipi_csi_get_format(struct csi_state *state,
> > -			   struct v4l2_subdev_state *sd_state,
> > -			   enum v4l2_subdev_format_whence which,
> > -			   unsigned int pad)
> > -{
> > -	if (which == V4L2_SUBDEV_FORMAT_TRY)
> > -		return v4l2_subdev_get_try_format(&state->sd, sd_state, pad);
> > -
> > -	return &state->format_mbus[pad];
> > -}
> > -
> >  static int imx8mq_mipi_csi_init_cfg(struct v4l2_subdev *sd,
> >  				    struct v4l2_subdev_state *sd_state)
> >  {
> > -	struct csi_state *state = mipi_sd_to_csi2_state(sd);
> >  	struct v4l2_mbus_framefmt *fmt_sink;
> >  	struct v4l2_mbus_framefmt *fmt_source;
> > -	enum v4l2_subdev_format_whence which;
> >  
> > -	which = sd_state ? V4L2_SUBDEV_FORMAT_TRY : V4L2_SUBDEV_FORMAT_ACTIVE;
> > -	fmt_sink = imx8mq_mipi_csi_get_format(state, sd_state, which,
> > -					      MIPI_CSI2_PAD_SINK);
> > +	fmt_sink = v4l2_subdev_get_pad_format(sd, sd_state, MIPI_CSI2_PAD_SINK);
> > +	fmt_source = v4l2_subdev_get_pad_format(sd, sd_state, MIPI_CSI2_PAD_SOURCE);
> >  
> >  	fmt_sink->code = MEDIA_BUS_FMT_SGBRG10_1X10;
> >  	fmt_sink->width = MIPI_CSI2_DEF_PIX_WIDTH;
> > @@ -491,38 +487,15 @@ static int imx8mq_mipi_csi_init_cfg(struct v4l2_subdev *sd,
> >  		V4L2_MAP_QUANTIZATION_DEFAULT(false, fmt_sink->colorspace,
> >  					      fmt_sink->ycbcr_enc);
> >  
> > -	fmt_source = imx8mq_mipi_csi_get_format(state, sd_state, which,
> > -						MIPI_CSI2_PAD_SOURCE);
> >  	*fmt_source = *fmt_sink;
> >  
> >  	return 0;
> >  }
> >  
> > -static int imx8mq_mipi_csi_get_fmt(struct v4l2_subdev *sd,
> > -				   struct v4l2_subdev_state *sd_state,
> > -				   struct v4l2_subdev_format *sdformat)
> > -{
> > -	struct csi_state *state = mipi_sd_to_csi2_state(sd);
> > -	struct v4l2_mbus_framefmt *fmt;
> > -
> > -	fmt = imx8mq_mipi_csi_get_format(state, sd_state, sdformat->which,
> > -					 sdformat->pad);
> > -
> > -	mutex_lock(&state->lock);
> > -
> > -	sdformat->format = *fmt;
> > -
> > -	mutex_unlock(&state->lock);
> > -
> > -	return 0;
> > -}
> > -
> >  static int imx8mq_mipi_csi_enum_mbus_code(struct v4l2_subdev *sd,
> >  					  struct v4l2_subdev_state *sd_state,
> >  					  struct v4l2_subdev_mbus_code_enum *code)
> >  {
> > -	struct csi_state *state = mipi_sd_to_csi2_state(sd);
> > -
> >  	/*
> >  	 * We can't transcode in any way, the source format is identical
> >  	 * to the sink format.
> > @@ -533,8 +506,7 @@ static int imx8mq_mipi_csi_enum_mbus_code(struct v4l2_subdev *sd,
> >  		if (code->index > 0)
> >  			return -EINVAL;
> >  
> > -		fmt = imx8mq_mipi_csi_get_format(state, sd_state, code->which,
> > -						 code->pad);
> > +		fmt = v4l2_subdev_get_pad_format(sd, sd_state, code->pad);
> >  		code->code = fmt->code;
> >  		return 0;
> >  	}
> > @@ -554,8 +526,7 @@ static int imx8mq_mipi_csi_set_fmt(struct v4l2_subdev *sd,
> >  				   struct v4l2_subdev_state *sd_state,
> >  				   struct v4l2_subdev_format *sdformat)
> >  {
> > -	struct csi_state *state = mipi_sd_to_csi2_state(sd);
> > -	struct csi2_pix_format const *csi2_fmt;
> > +	const struct csi2_pix_format *csi2_fmt;
> >  	struct v4l2_mbus_framefmt *fmt;
> >  
> >  	/*
> > @@ -563,7 +534,7 @@ static int imx8mq_mipi_csi_set_fmt(struct v4l2_subdev *sd,
> >  	 * modified.
> >  	 */
> >  	if (sdformat->pad == MIPI_CSI2_PAD_SOURCE)
> > -		return imx8mq_mipi_csi_get_fmt(sd, sd_state, sdformat);
> > +		return v4l2_subdev_get_fmt(sd, sd_state, sdformat);
> >  
> >  	if (sdformat->pad != MIPI_CSI2_PAD_SINK)
> >  		return -EINVAL;
> > @@ -572,10 +543,7 @@ static int imx8mq_mipi_csi_set_fmt(struct v4l2_subdev *sd,
> >  	if (!csi2_fmt)
> >  		csi2_fmt = &imx8mq_mipi_csi_formats[0];
> >  
> > -	fmt = imx8mq_mipi_csi_get_format(state, sd_state, sdformat->which,
> > -					 sdformat->pad);
> > -
> > -	mutex_lock(&state->lock);
> > +	fmt = v4l2_subdev_get_pad_format(sd, sd_state, sdformat->pad);
> >  
> >  	fmt->code = csi2_fmt->code;
> >  	fmt->width = sdformat->format.width;
> > @@ -584,16 +552,9 @@ static int imx8mq_mipi_csi_set_fmt(struct v4l2_subdev *sd,
> >  	sdformat->format = *fmt;
> >  
> >  	/* Propagate the format from sink to source. */
> > -	fmt = imx8mq_mipi_csi_get_format(state, sd_state, sdformat->which,
> > -					 MIPI_CSI2_PAD_SOURCE);
> > +	fmt = v4l2_subdev_get_pad_format(sd, sd_state, MIPI_CSI2_PAD_SOURCE);
> >  	*fmt = sdformat->format;
> >  
> > -	/* Store the CSI2 format descriptor for active formats. */
> > -	if (sdformat->which == V4L2_SUBDEV_FORMAT_ACTIVE)
> > -		state->csi2_fmt = csi2_fmt;
> > -
> > -	mutex_unlock(&state->lock);
> > -
> >  	return 0;
> >  }
> >  
> > @@ -604,7 +565,7 @@ static const struct v4l2_subdev_video_ops imx8mq_mipi_csi_video_ops = {
> >  static const struct v4l2_subdev_pad_ops imx8mq_mipi_csi_pad_ops = {
> >  	.init_cfg		= imx8mq_mipi_csi_init_cfg,
> >  	.enum_mbus_code		= imx8mq_mipi_csi_enum_mbus_code,
> > -	.get_fmt		= imx8mq_mipi_csi_get_fmt,
> > +	.get_fmt		= v4l2_subdev_get_fmt,
> >  	.set_fmt		= imx8mq_mipi_csi_set_fmt,
> >  };
> >  
> > @@ -732,6 +693,7 @@ static int imx8mq_mipi_csi_pm_resume(struct device *dev)
> >  {
> >  	struct v4l2_subdev *sd = dev_get_drvdata(dev);
> >  	struct csi_state *state = mipi_sd_to_csi2_state(sd);
> > +	struct v4l2_subdev_state *sd_state;
> >  	int ret = 0;
> >  
> >  	mutex_lock(&state->lock);
> > @@ -741,7 +703,9 @@ static int imx8mq_mipi_csi_pm_resume(struct device *dev)
> >  		ret = imx8mq_mipi_csi_clk_enable(state);
> >  	}
> >  	if (state->state & ST_STREAMING) {
> > -		ret = imx8mq_mipi_csi_start_stream(state);
> > +		sd_state = v4l2_subdev_lock_and_get_active_state(sd);
> > +		ret = imx8mq_mipi_csi_start_stream(state, sd_state);
> > +		v4l2_subdev_unlock_state(sd_state);
> >  		if (ret)
> >  			goto unlock;
> >  	}
> > @@ -821,6 +785,7 @@ static const struct dev_pm_ops imx8mq_mipi_csi_pm_ops = {
> >  static int imx8mq_mipi_csi_subdev_init(struct csi_state *state)
> >  {
> >  	struct v4l2_subdev *sd = &state->sd;
> > +	int ret;
> >  
> >  	v4l2_subdev_init(sd, &imx8mq_mipi_csi_subdev_ops);
> >  	sd->owner = THIS_MODULE;
> > @@ -834,15 +799,22 @@ static int imx8mq_mipi_csi_subdev_init(struct csi_state *state)
> >  
> >  	sd->dev = state->dev;
> >  
> > -	state->csi2_fmt = &imx8mq_mipi_csi_formats[0];
> > -	imx8mq_mipi_csi_init_cfg(sd, NULL);
> > -
> >  	state->pads[MIPI_CSI2_PAD_SINK].flags = MEDIA_PAD_FL_SINK
> >  					 | MEDIA_PAD_FL_MUST_CONNECT;
> >  	state->pads[MIPI_CSI2_PAD_SOURCE].flags = MEDIA_PAD_FL_SOURCE
> >  					   | MEDIA_PAD_FL_MUST_CONNECT;
> > -	return media_entity_pads_init(&sd->entity, MIPI_CSI2_PADS_NUM,
> > -				      state->pads);
> > +	ret = media_entity_pads_init(&sd->entity, MIPI_CSI2_PADS_NUM,
> > +				     state->pads);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = v4l2_subdev_init_finalize(sd);
> > +	if (ret) {
> > +		media_entity_cleanup(&sd->entity);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> >  }
> >  
> >  static void imx8mq_mipi_csi_release_icc(struct platform_device *pdev)
> > @@ -968,6 +940,7 @@ static int imx8mq_mipi_csi_probe(struct platform_device *pdev)
> >  	imx8mq_mipi_csi_runtime_suspend(&pdev->dev);
> >  
> >  	media_entity_cleanup(&state->sd.entity);
> > +	v4l2_subdev_cleanup(&state->sd);
> >  	v4l2_async_nf_unregister(&state->notifier);
> >  	v4l2_async_nf_cleanup(&state->notifier);
> >  	v4l2_async_unregister_subdev(&state->sd);
> > @@ -991,6 +964,7 @@ static int imx8mq_mipi_csi_remove(struct platform_device *pdev)
> >  	pm_runtime_disable(&pdev->dev);
> >  	imx8mq_mipi_csi_runtime_suspend(&pdev->dev);
> >  	media_entity_cleanup(&state->sd.entity);
> > +	v4l2_subdev_cleanup(&state->sd);
> >  	mutex_destroy(&state->lock);
> >  	pm_runtime_set_suspended(&pdev->dev);
> >  	imx8mq_mipi_csi_release_icc(pdev);

-- 
Regards,

Laurent Pinchart
