Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F12716A23
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjE3Qzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjE3Qz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:55:28 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288D0A7;
        Tue, 30 May 2023 09:55:26 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126205198071.34.openmobile.ne.jp [126.205.198.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0B0569CA;
        Tue, 30 May 2023 18:55:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685465704;
        bh=g9Dh7SAZiYqZ9SM8oCgF1ZQFtlAUSvdUGF3wCcUvtts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jo+vZlcrrohe3KydEVZgpWOLdc1Xjl5oVTSznuzyYaq8MF5SiOhz4JnPxyLZpzOxX
         V5c2+o1eRNiOjO1W7dk4U+hxOyFDqUYjogo07h903V4+jgNRDoawHLZgBRKcx7zopr
         2Pqj4POoOJCWuYs95yBjph4xRUhlVUys/GvqTNzM=
Date:   Tue, 30 May 2023 19:55:23 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH 2/2] media: video-mux: update driver to active state
Message-ID: <20230530165523.GC22516@pendragon.ideasonboard.com>
References: <20230524-video-mux-active-state-v1-0-325c69937ac3@pengutronix.de>
 <20230524-video-mux-active-state-v1-2-325c69937ac3@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230524-video-mux-active-state-v1-2-325c69937ac3@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

(CC'ing Tomi)

Thank you for the patch.

On Wed, May 24, 2023 at 03:29:25PM +0200, Philipp Zabel wrote:
> Drop the open coded pad format array, use subdev active state instead.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/media/platform/video-mux.c | 78 ++++++++++++--------------------------
>  1 file changed, 24 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/media/platform/video-mux.c b/drivers/media/platform/video-mux.c
> index 4fe31386afc7..6d273abfe16c 100644
> --- a/drivers/media/platform/video-mux.c
> +++ b/drivers/media/platform/video-mux.c
> @@ -24,7 +24,6 @@ struct video_mux {
>  	struct v4l2_subdev subdev;
>  	struct v4l2_async_notifier notifier;
>  	struct media_pad *pads;
> -	struct v4l2_mbus_framefmt *format_mbus;
>  	struct mux_control *mux;
>  	struct mutex lock;
>  	int active;
> @@ -71,6 +70,9 @@ static int video_mux_link_setup(struct media_entity *entity,
>  	mutex_lock(&vmux->lock);
>  
>  	if (flags & MEDIA_LNK_FL_ENABLED) {
> +		struct v4l2_subdev_state *sd_state;
> +		struct v4l2_mbus_framefmt *source_mbusformat;
> +
>  		if (vmux->active == local->index)
>  			goto out;
>  
> @@ -86,7 +88,12 @@ static int video_mux_link_setup(struct media_entity *entity,
>  		vmux->active = local->index;
>  
>  		/* Propagate the active format to the source */
> -		vmux->format_mbus[source_pad] = vmux->format_mbus[vmux->active];
> +		sd_state = v4l2_subdev_lock_and_get_active_state(sd);
> +		source_mbusformat = v4l2_subdev_get_pad_format(sd, sd_state,
> +							       source_pad);
> +		*source_mbusformat = *v4l2_subdev_get_pad_format(sd, sd_state,
> +								 vmux->active);

This only handles the active state, try states will not reflect the link
configuration. That's a limitation of the MC API though, there isn't
much we can do about it.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

If this were to be implemented from scratch today, we should use the
subdev internal routing to configure the mux, not MC links. That would
be nice, but I doubt the resulting userspace ABI breakage would be
appreciated. I'm tempted, however, to not use the existing video-mux
driver for new platforms, and implement a new mux driver based on the
routing API instead (or possibly support both in the same driver). Any
thought from anyone ?

> +		v4l2_subdev_unlock_state(sd_state);
>  	} else {
>  		if (vmux->active != local->index)
>  			goto out;
> @@ -138,40 +145,6 @@ static const struct v4l2_subdev_video_ops video_mux_subdev_video_ops = {
>  	.s_stream = video_mux_s_stream,
>  };
>  
> -static struct v4l2_mbus_framefmt *
> -__video_mux_get_pad_format(struct v4l2_subdev *sd,
> -			   struct v4l2_subdev_state *sd_state,
> -			   unsigned int pad, u32 which)
> -{
> -	struct video_mux *vmux = v4l2_subdev_to_video_mux(sd);
> -
> -	switch (which) {
> -	case V4L2_SUBDEV_FORMAT_TRY:
> -		return v4l2_subdev_get_try_format(sd, sd_state, pad);
> -	case V4L2_SUBDEV_FORMAT_ACTIVE:
> -		return &vmux->format_mbus[pad];
> -	default:
> -		return NULL;
> -	}
> -}
> -
> -static int video_mux_get_format(struct v4l2_subdev *sd,
> -			    struct v4l2_subdev_state *sd_state,
> -			    struct v4l2_subdev_format *sdformat)
> -{
> -	struct video_mux *vmux = v4l2_subdev_to_video_mux(sd);
> -
> -	mutex_lock(&vmux->lock);
> -
> -	sdformat->format = *__video_mux_get_pad_format(sd, sd_state,
> -						       sdformat->pad,
> -						       sdformat->which);
> -
> -	mutex_unlock(&vmux->lock);
> -
> -	return 0;
> -}
> -
>  static int video_mux_set_format(struct v4l2_subdev *sd,
>  			    struct v4l2_subdev_state *sd_state,
>  			    struct v4l2_subdev_format *sdformat)
> @@ -181,14 +154,11 @@ static int video_mux_set_format(struct v4l2_subdev *sd,
>  	struct media_pad *pad = &vmux->pads[sdformat->pad];
>  	u16 source_pad = sd->entity.num_pads - 1;
>  
> -	mbusformat = __video_mux_get_pad_format(sd, sd_state, sdformat->pad,
> -						sdformat->which);
> +	mbusformat = v4l2_subdev_get_pad_format(sd, sd_state, sdformat->pad);
>  	if (!mbusformat)
>  		return -EINVAL;
>  
> -	source_mbusformat = __video_mux_get_pad_format(sd, sd_state,
> -						       source_pad,
> -						       sdformat->which);
> +	source_mbusformat = v4l2_subdev_get_pad_format(sd, sd_state, source_pad);
>  	if (!source_mbusformat)
>  		return -EINVAL;
>  
> @@ -298,7 +268,8 @@ static int video_mux_set_format(struct v4l2_subdev *sd,
>  
>  	/* Source pad mirrors active sink pad, no limitations on sink pads */
>  	if ((pad->flags & MEDIA_PAD_FL_SOURCE) && vmux->active >= 0)
> -		sdformat->format = vmux->format_mbus[vmux->active];
> +		sdformat->format = *v4l2_subdev_get_pad_format(sd, sd_state,
> +							       vmux->active);
>  
>  	*mbusformat = sdformat->format;
>  
> @@ -321,7 +292,7 @@ static int video_mux_init_cfg(struct v4l2_subdev *sd,
>  	mutex_lock(&vmux->lock);
>  
>  	for (i = 0; i < sd->entity.num_pads; i++) {
> -		mbusformat = v4l2_subdev_get_try_format(sd, sd_state, i);
> +		mbusformat = v4l2_subdev_get_pad_format(sd, sd_state, i);
>  		*mbusformat = video_mux_format_mbus_default;
>  	}
>  
> @@ -332,7 +303,7 @@ static int video_mux_init_cfg(struct v4l2_subdev *sd,
>  
>  static const struct v4l2_subdev_pad_ops video_mux_pad_ops = {
>  	.init_cfg = video_mux_init_cfg,
> -	.get_fmt = video_mux_get_format,
> +	.get_fmt = v4l2_subdev_get_fmt,
>  	.set_fmt = video_mux_set_format,
>  };
>  
> @@ -462,17 +433,9 @@ static int video_mux_probe(struct platform_device *pdev)
>  	if (!vmux->pads)
>  		return -ENOMEM;
>  
> -	vmux->format_mbus = devm_kcalloc(dev, num_pads,
> -					 sizeof(*vmux->format_mbus),
> -					 GFP_KERNEL);
> -	if (!vmux->format_mbus)
> -		return -ENOMEM;
> -
> -	for (i = 0; i < num_pads; i++) {
> +	for (i = 0; i < num_pads; i++)
>  		vmux->pads[i].flags = (i < num_pads - 1) ? MEDIA_PAD_FL_SINK
>  							 : MEDIA_PAD_FL_SOURCE;
> -		vmux->format_mbus[i] = video_mux_format_mbus_default;
> -	}
>  
>  	vmux->subdev.entity.function = MEDIA_ENT_F_VID_MUX;
>  	ret = media_entity_pads_init(&vmux->subdev.entity, num_pads,
> @@ -482,12 +445,18 @@ static int video_mux_probe(struct platform_device *pdev)
>  
>  	vmux->subdev.entity.ops = &video_mux_ops;
>  
> +	ret = v4l2_subdev_init_finalize(&vmux->subdev);
> +	if (ret < 0)
> +		goto err_entity_cleanup;
> +
>  	ret = video_mux_async_register(vmux, num_pads - 1);
>  	if (ret)
> -		goto err_entity_cleanup;
> +		goto err_subdev_cleanup;
>  
>  	return 0;
>  
> +err_subdev_cleanup:
> +	v4l2_subdev_cleanup(&vmux->subdev);
>  err_entity_cleanup:
>  	media_entity_cleanup(&vmux->subdev.entity);
>  	return ret;
> @@ -501,6 +470,7 @@ static void video_mux_remove(struct platform_device *pdev)
>  	v4l2_async_nf_unregister(&vmux->notifier);
>  	v4l2_async_nf_cleanup(&vmux->notifier);
>  	v4l2_async_unregister_subdev(sd);
> +	v4l2_subdev_cleanup(sd);
>  	media_entity_cleanup(&sd->entity);
>  }
>  

-- 
Regards,

Laurent Pinchart
