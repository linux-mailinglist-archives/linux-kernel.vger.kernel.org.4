Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB7F6C90F0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 22:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCYVYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 17:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYVYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 17:24:09 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33120C655;
        Sat, 25 Mar 2023 14:24:08 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5D4688BE;
        Sat, 25 Mar 2023 22:24:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1679779446;
        bh=XFT2/Of6tXbRCWRlq7XJOvawMJpq1iSEbwMuAA7jtmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NTSayLYiolEyRvq25V/zs2k6izOy6dAzrT+uZ8qCzA+1UXaAlXEIfRF40WPFAMx12
         KOZh0OUz2B6gETQ/ItGT1UT56v91NN6/heRGl6fBjYIa2R0apPrV2M1u4XbVYpJmqZ
         FVl9aYGeQeDufZFDdXGVjATAdLixE+77Yl8LhelA=
Date:   Sat, 25 Mar 2023 23:24:12 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Adam Pigg <adam@piggz.co.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 5/9] media: sun6i-csi: capture: Rework and separate
 format validation
Message-ID: <20230325212412.GC22214@pendragon.ideasonboard.com>
References: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
 <20230324151228.2778112-6-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230324151228.2778112-6-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thank you for the patch.

On Fri, Mar 24, 2023 at 04:12:24PM +0100, Paul Kocialkowski wrote:
> Introduce a new sun6i_csi_capture_format_check helper to indicate
> whether a set of pixel format and mbus code are compatible.
> Most of the logic is taken from sun6i_csi_capture_link_validate,
> with extra checks added along the way.
> 
> Note that v4l2_format_info is now used for all pixel formats
> since they should all be listed in the helper at this point.
> 
> The motivation behind this change is to pave the way for supporting
> the mc-style enum_fmt.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 95 ++++++++++---------
>  1 file changed, 49 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> index cf6aadbc130b..6ce7f1d3ed57 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> @@ -327,6 +327,52 @@ static bool sun6i_csi_capture_format_match(u32 pixelformat, u32 mbus_code)
>  	return false;
>  }
>  
> +static bool sun6i_csi_capture_format_check(u32 pixelformat, u32 mbus_code)
> +{
> +	const struct sun6i_csi_capture_format *capture_format;
> +	const struct sun6i_csi_bridge_format *bridge_format;

I think I would have named those output_format and input_format
respectively, as "capture" and "bridge" take a bit more mental
processing when reading the code. That may be because I'm not familiar
with the driver though, so feel free to ignore this.

> +	const struct v4l2_format_info *format_info;
> +
> +	format_info = v4l2_format_info(pixelformat);
> +	if (WARN_ON(!format_info))
> +		return false;
> +
> +	capture_format = sun6i_csi_capture_format_find(pixelformat);
> +	if (WARN_ON(!capture_format))
> +		return false;
> +
> +	bridge_format = sun6i_csi_bridge_format_find(mbus_code);
> +	if (WARN_ON(!bridge_format))
> +		return false;
> +
> +	/* Raw input is required for non-YUV formats. */
> +	if (bridge_format->input_format != SUN6I_CSI_INPUT_FMT_RAW &&
> +	    (format_info->pixel_enc == V4L2_PIXEL_ENC_BAYER ||
> +	     format_info->pixel_enc == V4L2_PIXEL_ENC_RGB ||
> +	     format_info->pixel_enc == V4L2_PIXEL_ENC_COMPRESSED))

Unless I'm mistaken, the compressed format check is new. You could split
it to a separate patch, or at least mention it in the commit message.

> +		return false;
> +
> +	if (format_info->pixel_enc == V4L2_PIXEL_ENC_YUV) {
> +		/* YUV input is required for YUV pixels. */
> +		if (bridge_format->input_format != SUN6I_CSI_INPUT_FMT_YUV420 &&
> +		    bridge_format->input_format != SUN6I_CSI_INPUT_FMT_YUV422)
> +			return false;
> +
> +		/* YUV420 input can't produce (upsampled) YUV422 output. */
> +		if (bridge_format->input_format == SUN6I_CSI_INPUT_FMT_YUV420 &&
> +		    format_info->vdiv == 1)
> +			return false;
> +	}
> +
> +	/* Raw input requires a 1:1 match between input and output. */
> +	if ((bridge_format->input_format == SUN6I_CSI_INPUT_FMT_RAW ||
> +	     capture_format->input_format_raw) &&
> +	    !sun6i_csi_capture_format_match(pixelformat, mbus_code))
> +			return false;

Wrong indentation.

With this fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +
> +	return true;
> +}
> +
>  /* Capture */
>  
>  static void
> @@ -890,28 +936,16 @@ static int sun6i_csi_capture_link_validate(struct media_link *link)
>  		media_entity_to_video_device(link->sink->entity);
>  	struct sun6i_csi_device *csi_dev = video_get_drvdata(video_dev);
>  	struct v4l2_device *v4l2_dev = csi_dev->v4l2_dev;
> -	const struct sun6i_csi_capture_format *capture_format;
> -	const struct sun6i_csi_bridge_format *bridge_format;
>  	unsigned int capture_width, capture_height;
>  	unsigned int bridge_width, bridge_height;
> -	const struct v4l2_format_info *format_info;
>  	u32 pixelformat, capture_field;
>  	u32 mbus_code, bridge_field;
> -	bool match;
>  
>  	sun6i_csi_capture_dimensions(csi_dev, &capture_width, &capture_height);
> -
>  	sun6i_csi_capture_format(csi_dev, &pixelformat, &capture_field);
> -	capture_format = sun6i_csi_capture_format_find(pixelformat);
> -	if (WARN_ON(!capture_format))
> -		return -EINVAL;
>  
>  	sun6i_csi_bridge_dimensions(csi_dev, &bridge_width, &bridge_height);
> -
>  	sun6i_csi_bridge_format(csi_dev, &mbus_code, &bridge_field);
> -	bridge_format = sun6i_csi_bridge_format_find(mbus_code);
> -	if (WARN_ON(!bridge_format))
> -		return -EINVAL;
>  
>  	/* No cropping/scaling is supported. */
>  	if (capture_width != bridge_width || capture_height != bridge_height) {
> @@ -922,43 +956,12 @@ static int sun6i_csi_capture_link_validate(struct media_link *link)
>  		return -EINVAL;
>  	}
>  
> -	format_info = v4l2_format_info(pixelformat);
> -	/* Some formats are not listed. */
> -	if (!format_info)
> -		return 0;
> -
> -	if (format_info->pixel_enc == V4L2_PIXEL_ENC_BAYER &&
> -	    bridge_format->input_format != SUN6I_CSI_INPUT_FMT_RAW)
> -		goto invalid;
> -
> -	if (format_info->pixel_enc == V4L2_PIXEL_ENC_RGB &&
> -	    bridge_format->input_format != SUN6I_CSI_INPUT_FMT_RAW)
> -		goto invalid;
> -
> -	if (format_info->pixel_enc == V4L2_PIXEL_ENC_YUV) {
> -		if (bridge_format->input_format != SUN6I_CSI_INPUT_FMT_YUV420 &&
> -		    bridge_format->input_format != SUN6I_CSI_INPUT_FMT_YUV422)
> -			goto invalid;
> -
> -		/* YUV420 input can't produce YUV422 output. */
> -		if (bridge_format->input_format == SUN6I_CSI_INPUT_FMT_YUV420 &&
> -		    format_info->vdiv == 1)
> -			goto invalid;
> -	}
> -
> -	/* With raw input mode, we need a 1:1 match between input and output. */
> -	if (bridge_format->input_format == SUN6I_CSI_INPUT_FMT_RAW ||
> -	    capture_format->input_format_raw) {
> -		match = sun6i_csi_capture_format_match(pixelformat, mbus_code);
> -		if (!match)
> -			goto invalid;
> +	if (!sun6i_csi_capture_format_check(pixelformat, mbus_code)) {
> +		v4l2_err(v4l2_dev, "invalid input/output format combination\n");
> +		return -EINVAL;
>  	}
>  
>  	return 0;
> -
> -invalid:
> -	v4l2_err(v4l2_dev, "invalid input/output format combination\n");
> -	return -EINVAL;
>  }
>  
>  static const struct media_entity_operations sun6i_csi_capture_media_ops = {

-- 
Regards,

Laurent Pinchart
