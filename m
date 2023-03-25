Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15356C90F7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 22:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjCYV3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 17:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCYV3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 17:29:49 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A25BCA36;
        Sat, 25 Mar 2023 14:29:48 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5500A8BE;
        Sat, 25 Mar 2023 22:29:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1679779786;
        bh=Jpj+akEfg2jGUqXOXG5JWaUslPt6fAU0Vc613gWhvT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iRjNIJ5FwvxoAj4MESIMf+5qXpJxHj/nxIU/EQ+GUL3Yd8VLhtwda9uFVFgBprHsw
         97fp1wiGJlIPH/xaoZ7pwHofdeKrrDd/SVtAOd02nZ0pphEmJyhTc/OhWwPQhmsCsQ
         VDrEA1pyLEdi4cub86kR9/LLr2/Ylso5qyPQ86jY=
Date:   Sat, 25 Mar 2023 23:29:53 +0200
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
Subject: Re: [PATCH 6/9] media: sun6i-csi: capture: Implement MC I/O with
 extended enum_fmt
Message-ID: <20230325212953.GD22214@pendragon.ideasonboard.com>
References: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
 <20230324151228.2778112-7-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230324151228.2778112-7-paul.kocialkowski@bootlin.com>
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

On Fri, Mar 24, 2023 at 04:12:25PM +0100, Paul Kocialkowski wrote:
> This driver needs the media-controller API to operate and should not be
> considered as a video-device-centric implementation.
> 
> Properly report the IO_MC device cap and extend the enum_fmt
> implementation to support enumeration with an explicit mbus_code.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 36 ++++++++++++++++---
>  1 file changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> index 6ce7f1d3ed57..9627030ff060 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> @@ -777,13 +777,40 @@ static int sun6i_csi_capture_enum_fmt(struct file *file, void *private,
>  				      struct v4l2_fmtdesc *fmtdesc)
>  {
>  	u32 index = fmtdesc->index;
> +	u32 mbus_code = fmtdesc->mbus_code;
> +	unsigned int index_valid = 0;
> +	unsigned int i;
> +
> +	if (!mbus_code) {
> +		if (index >= ARRAY_SIZE(sun6i_csi_capture_formats))
> +			return -EINVAL;
> +
> +		fmtdesc->pixelformat =
> +			sun6i_csi_capture_formats[index].pixelformat;
> +
> +		return 0;
> +	}
> +
> +	/* Check capture pixel format matching with mbus code. */
>  
> -	if (index >= ARRAY_SIZE(sun6i_csi_capture_formats))
> +	if (!sun6i_csi_bridge_format_find(mbus_code))
>  		return -EINVAL;
>  
> -	fmtdesc->pixelformat = sun6i_csi_capture_formats[index].pixelformat;
> +	for (i = 0; i < ARRAY_SIZE(sun6i_csi_capture_formats); i++) {
> +		u32 pixelformat = sun6i_csi_capture_formats[i].pixelformat;
>  
> -	return 0;
> +		if (!sun6i_csi_capture_format_check(pixelformat, mbus_code))
> +			continue;

I would probably have added compatible media bus codes to the
sun6i_csi_capture_format structure. This should work though, even if it
is more CPU-intensive. I'm OK with either option.

> +
> +		if (index == index_valid) {

You can replace this with

		if (index == 0) {

and

		index_valid++;

with

		index--;

below, and drop the index_valid variable.

> +			fmtdesc->pixelformat = pixelformat;
> +			return 0;
> +		}
> +
> +		index_valid++;
> +	}
> +
> +	return -EINVAL;
>  }
>  
>  static int sun6i_csi_capture_g_fmt(struct file *file, void *private,
> @@ -1039,7 +1066,8 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
>  
>  	strscpy(video_dev->name, SUN6I_CSI_CAPTURE_NAME,
>  		sizeof(video_dev->name));
> -	video_dev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
> +	video_dev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING |
> +				 V4L2_CAP_IO_MC;
>  	video_dev->vfl_dir = VFL_DIR_RX;
>  	video_dev->release = video_device_release_empty;

-- 
Regards,

Laurent Pinchart
