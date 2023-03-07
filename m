Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3FE6AE067
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjCGNZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjCGNZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:25:48 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2E22FCF8;
        Tue,  7 Mar 2023 05:25:35 -0800 (PST)
Received: from pendragon.ideasonboard.com (153.162-64-87.adsl-dyn.isp.belgacom.be [87.64.162.153])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 84D854AD;
        Tue,  7 Mar 2023 14:25:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1678195532;
        bh=IAV7zyWTgvClPGC2x4JxCL0M1Pz955iI6f2ZBfa8TrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sDTCmlVjYn4qi07Clw5nqMioVAEmYGViiQXTsS8R9zd4tYOeNTUWkaz4FNp6AO2KN
         8jkeh0maf87Q07ekk85o74Amz+dI+CV+hq4rxk7tbdLi8dufWTTBQwAjtCB5eVDVGg
         lcI1waO1rq41DwB+RzLMptwyasvBCQ0wcQU48Vho=
Date:   Tue, 7 Mar 2023 15:25:36 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     slongerbeam@gmail.com, p.zabel@pengutronix.de, mchehab@kernel.org,
        gregkh@linuxfoundation.org, shawnguo@kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: Re: [PATCH] media: imx: imx8mq-mipi-csi2: Use V4L2 subdev active
 state
Message-ID: <20230307132536.GG22827@pendragon.ideasonboard.com>
References: <20230307121729.1419120-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230307121729.1419120-1-martin.kepplinger@puri.sm>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thank you for the patch.

On Tue, Mar 07, 2023 at 01:17:29PM +0100, Martin Kepplinger wrote:
> Simplify the driver by using the V4L2 subdev active state API to store
> the active format.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  drivers/staging/media/imx/imx8mq-mipi-csi2.c | 108 +++++++------------
>  1 file changed, 37 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/staging/media/imx/imx8mq-mipi-csi2.c b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
> index c0d0bf770096..066409782058 100644
> --- a/drivers/staging/media/imx/imx8mq-mipi-csi2.c
> +++ b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
> @@ -119,9 +119,7 @@ struct csi_state {
>  
>  	struct v4l2_mbus_config_mipi_csi2 bus;
>  
> -	struct mutex lock; /* Protect csi2_fmt, format_mbus, state, hs_settle */
> -	const struct csi2_pix_format *csi2_fmt;
> -	struct v4l2_mbus_framefmt format_mbus[MIPI_CSI2_PADS_NUM];
> +	struct mutex lock; /* Protect state and hs_settle */

The hs_settle value is computed in imx8mq_mipi_csi_calc_hs_settle() and
used in imx8mq_mipi_csi_system_enable(), both called from
imx8mq_mipi_csi_start_stream(). You could return it from the first
function, pass it to the second one, and drop it from the structure.
That can be done in a separate patch.

I think the state variable could also be dropped, which would allow
dropping the lock.

>  	u32 state;
>  	u32 hs_settle;
>  
> @@ -328,10 +326,18 @@ static int imx8mq_mipi_csi_calc_hs_settle(struct csi_state *state)
>  	u32 lane_rate;
>  	unsigned long esc_clk_rate;
>  	u32 min_ths_settle, max_ths_settle, ths_settle_ns, esc_clk_period_ns;
> +	const struct v4l2_mbus_framefmt *fmt;
> +	const struct csi2_pix_format *csi2_fmt;
> +	struct v4l2_subdev_state *sd_state;
>  
>  	/* Calculate the line rate from the pixel rate. */
> +
> +	sd_state = v4l2_subdev_lock_and_get_active_state(&state->sd);

You need to unlock the state when you're done with it. I would call
v4l2_subdev_lock_and_get_active_state() in
imx8mq_mipi_csi_start_stream() and unlock it there, and pass the state
to imx8mq_mipi_csi_calc_hs_settle(). This will prepare for the future
when the V4L2 core will pass the state to the .s_stream() handler.

Another candidate for a separate patch would be to rename the state
variables to csi, to avoid confusion with the subdev state.

> +	fmt = v4l2_subdev_get_pad_format(&state->sd, sd_state, MIPI_CSI2_PAD_SINK);
> +	csi2_fmt = find_csi2_format(fmt->code);
> +
>  	link_freq = v4l2_get_link_freq(state->src_sd->ctrl_handler,
> -				       state->csi2_fmt->width,
> +				       csi2_fmt->width,
>  				       state->bus.num_data_lanes * 2);
>  	if (link_freq < 0) {
>  		dev_err(state->dev, "Unable to obtain link frequency: %d\n",
> @@ -455,29 +461,14 @@ static int imx8mq_mipi_csi_s_stream(struct v4l2_subdev *sd, int enable)
>  	return ret;
>  }
>  
> -static struct v4l2_mbus_framefmt *
> -imx8mq_mipi_csi_get_format(struct csi_state *state,
> -			   struct v4l2_subdev_state *sd_state,
> -			   enum v4l2_subdev_format_whence which,
> -			   unsigned int pad)
> -{
> -	if (which == V4L2_SUBDEV_FORMAT_TRY)
> -		return v4l2_subdev_get_try_format(&state->sd, sd_state, pad);
> -
> -	return &state->format_mbus[pad];
> -}
> -
>  static int imx8mq_mipi_csi_init_cfg(struct v4l2_subdev *sd,
>  				    struct v4l2_subdev_state *sd_state)
>  {
> -	struct csi_state *state = mipi_sd_to_csi2_state(sd);
>  	struct v4l2_mbus_framefmt *fmt_sink;
>  	struct v4l2_mbus_framefmt *fmt_source;
> -	enum v4l2_subdev_format_whence which;
>  
> -	which = sd_state ? V4L2_SUBDEV_FORMAT_TRY : V4L2_SUBDEV_FORMAT_ACTIVE;
> -	fmt_sink = imx8mq_mipi_csi_get_format(state, sd_state, which,
> -					      MIPI_CSI2_PAD_SINK);
> +	fmt_sink = v4l2_subdev_get_pad_format(sd, sd_state, MIPI_CSI2_PAD_SINK);
> +	fmt_source = v4l2_subdev_get_pad_format(sd, sd_state, MIPI_CSI2_PAD_SOURCE);
>  
>  	fmt_sink->code = MEDIA_BUS_FMT_SGBRG10_1X10;
>  	fmt_sink->width = MIPI_CSI2_DEF_PIX_WIDTH;
> @@ -491,38 +482,15 @@ static int imx8mq_mipi_csi_init_cfg(struct v4l2_subdev *sd,
>  		V4L2_MAP_QUANTIZATION_DEFAULT(false, fmt_sink->colorspace,
>  					      fmt_sink->ycbcr_enc);
>  
> -	fmt_source = imx8mq_mipi_csi_get_format(state, sd_state, which,
> -						MIPI_CSI2_PAD_SOURCE);
>  	*fmt_source = *fmt_sink;
>  
>  	return 0;
>  }
>  
> -static int imx8mq_mipi_csi_get_fmt(struct v4l2_subdev *sd,
> -				   struct v4l2_subdev_state *sd_state,
> -				   struct v4l2_subdev_format *sdformat)
> -{
> -	struct csi_state *state = mipi_sd_to_csi2_state(sd);
> -	struct v4l2_mbus_framefmt *fmt;
> -
> -	fmt = imx8mq_mipi_csi_get_format(state, sd_state, sdformat->which,
> -					 sdformat->pad);
> -
> -	mutex_lock(&state->lock);
> -
> -	sdformat->format = *fmt;
> -
> -	mutex_unlock(&state->lock);
> -
> -	return 0;
> -}
> -
>  static int imx8mq_mipi_csi_enum_mbus_code(struct v4l2_subdev *sd,
>  					  struct v4l2_subdev_state *sd_state,
>  					  struct v4l2_subdev_mbus_code_enum *code)
>  {
> -	struct csi_state *state = mipi_sd_to_csi2_state(sd);
> -
>  	/*
>  	 * We can't transcode in any way, the source format is identical
>  	 * to the sink format.
> @@ -533,8 +501,7 @@ static int imx8mq_mipi_csi_enum_mbus_code(struct v4l2_subdev *sd,
>  		if (code->index > 0)
>  			return -EINVAL;
>  
> -		fmt = imx8mq_mipi_csi_get_format(state, sd_state, code->which,
> -						 code->pad);
> +		fmt = v4l2_subdev_get_pad_format(sd, sd_state, code->pad);
>  		code->code = fmt->code;
>  		return 0;
>  	}
> @@ -554,8 +521,7 @@ static int imx8mq_mipi_csi_set_fmt(struct v4l2_subdev *sd,
>  				   struct v4l2_subdev_state *sd_state,
>  				   struct v4l2_subdev_format *sdformat)
>  {
> -	struct csi_state *state = mipi_sd_to_csi2_state(sd);
> -	struct csi2_pix_format const *csi2_fmt;
> +	const struct csi2_pix_format *csi2_fmt;
>  	struct v4l2_mbus_framefmt *fmt;
>  
>  	/*
> @@ -563,7 +529,7 @@ static int imx8mq_mipi_csi_set_fmt(struct v4l2_subdev *sd,
>  	 * modified.
>  	 */
>  	if (sdformat->pad == MIPI_CSI2_PAD_SOURCE)
> -		return imx8mq_mipi_csi_get_fmt(sd, sd_state, sdformat);
> +		return v4l2_subdev_get_fmt(sd, sd_state, sdformat);
>  
>  	if (sdformat->pad != MIPI_CSI2_PAD_SINK)
>  		return -EINVAL;
> @@ -572,10 +538,7 @@ static int imx8mq_mipi_csi_set_fmt(struct v4l2_subdev *sd,
>  	if (!csi2_fmt)
>  		csi2_fmt = &imx8mq_mipi_csi_formats[0];
>  
> -	fmt = imx8mq_mipi_csi_get_format(state, sd_state, sdformat->which,
> -					 sdformat->pad);
> -
> -	mutex_lock(&state->lock);
> +	fmt = v4l2_subdev_get_pad_format(sd, sd_state, sdformat->pad);
>  
>  	fmt->code = csi2_fmt->code;
>  	fmt->width = sdformat->format.width;
> @@ -584,16 +547,9 @@ static int imx8mq_mipi_csi_set_fmt(struct v4l2_subdev *sd,
>  	sdformat->format = *fmt;
>  
>  	/* Propagate the format from sink to source. */
> -	fmt = imx8mq_mipi_csi_get_format(state, sd_state, sdformat->which,
> -					 MIPI_CSI2_PAD_SOURCE);
> +	fmt = v4l2_subdev_get_pad_format(sd, sd_state, MIPI_CSI2_PAD_SOURCE);
>  	*fmt = sdformat->format;
>  
> -	/* Store the CSI2 format descriptor for active formats. */
> -	if (sdformat->which == V4L2_SUBDEV_FORMAT_ACTIVE)
> -		state->csi2_fmt = csi2_fmt;
> -
> -	mutex_unlock(&state->lock);
> -
>  	return 0;
>  }
>  
> @@ -604,7 +560,7 @@ static const struct v4l2_subdev_video_ops imx8mq_mipi_csi_video_ops = {
>  static const struct v4l2_subdev_pad_ops imx8mq_mipi_csi_pad_ops = {
>  	.init_cfg		= imx8mq_mipi_csi_init_cfg,
>  	.enum_mbus_code		= imx8mq_mipi_csi_enum_mbus_code,
> -	.get_fmt		= imx8mq_mipi_csi_get_fmt,
> +	.get_fmt		= v4l2_subdev_get_fmt,
>  	.set_fmt		= imx8mq_mipi_csi_set_fmt,
>  };
>  
> @@ -821,6 +777,7 @@ static const struct dev_pm_ops imx8mq_mipi_csi_pm_ops = {
>  static int imx8mq_mipi_csi_subdev_init(struct csi_state *state)
>  {
>  	struct v4l2_subdev *sd = &state->sd;
> +	int ret;
>  
>  	v4l2_subdev_init(sd, &imx8mq_mipi_csi_subdev_ops);
>  	sd->owner = THIS_MODULE;
> @@ -834,15 +791,22 @@ static int imx8mq_mipi_csi_subdev_init(struct csi_state *state)
>  
>  	sd->dev = state->dev;
>  
> -	state->csi2_fmt = &imx8mq_mipi_csi_formats[0];
> -	imx8mq_mipi_csi_init_cfg(sd, NULL);
> -
>  	state->pads[MIPI_CSI2_PAD_SINK].flags = MEDIA_PAD_FL_SINK
>  					 | MEDIA_PAD_FL_MUST_CONNECT;
>  	state->pads[MIPI_CSI2_PAD_SOURCE].flags = MEDIA_PAD_FL_SOURCE
>  					   | MEDIA_PAD_FL_MUST_CONNECT;
> -	return media_entity_pads_init(&sd->entity, MIPI_CSI2_PADS_NUM,
> -				      state->pads);
> +	ret = media_entity_pads_init(&sd->entity, MIPI_CSI2_PADS_NUM,
> +				     state->pads);
> +	if (ret)
> +		return ret;
> +
> +	ret = v4l2_subdev_init_finalize(sd);
> +	if (ret) {
> +		media_entity_cleanup(&sd->entity);
> +		return ret;
> +	}
> +
> +	return 0;
>  }
>  
>  static void imx8mq_mipi_csi_release_icc(struct platform_device *pdev)
> @@ -949,6 +913,10 @@ static int imx8mq_mipi_csi_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto mutex;
>  
> +	ret = imx8mq_mipi_csi_async_register(state);
> +	if (ret < 0)
> +		goto cleanup;
> +
>  	/* Enable runtime PM. */
>  	pm_runtime_enable(dev);
>  	if (!pm_runtime_enabled(dev)) {

You should still enable runtime PM after registering the subdev,
otherwise someone may get hold of the subdev and call an operation that
depending on runtime PM being enabled before you get a chance to enable
it.

It would also be nice to suspend the device at the end of probe (using
pm runtime autosuspend), that's a candidate for another patch.

> @@ -957,10 +925,6 @@ static int imx8mq_mipi_csi_probe(struct platform_device *pdev)
>  			goto icc;
>  	}
>  
> -	ret = imx8mq_mipi_csi_async_register(state);
> -	if (ret < 0)
> -		goto cleanup;
> -
>  	return 0;
>  
>  cleanup:
> @@ -968,6 +932,7 @@ static int imx8mq_mipi_csi_probe(struct platform_device *pdev)
>  	imx8mq_mipi_csi_runtime_suspend(&pdev->dev);
>  
>  	media_entity_cleanup(&state->sd.entity);
> +	v4l2_subdev_cleanup(&state->sd);
>  	v4l2_async_nf_unregister(&state->notifier);
>  	v4l2_async_nf_cleanup(&state->notifier);
>  	v4l2_async_unregister_subdev(&state->sd);
> @@ -991,6 +956,7 @@ static int imx8mq_mipi_csi_remove(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	imx8mq_mipi_csi_runtime_suspend(&pdev->dev);
>  	media_entity_cleanup(&state->sd.entity);
> +	v4l2_subdev_cleanup(&state->sd);
>  	mutex_destroy(&state->lock);
>  	pm_runtime_set_suspended(&pdev->dev);
>  	imx8mq_mipi_csi_release_icc(pdev);

-- 
Regards,

Laurent Pinchart
