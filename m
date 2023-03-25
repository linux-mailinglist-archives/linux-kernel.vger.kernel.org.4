Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF376C9108
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 22:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjCYVmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 17:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjCYVmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 17:42:11 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D857EDB;
        Sat, 25 Mar 2023 14:42:07 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A02C98BE;
        Sat, 25 Mar 2023 22:42:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1679780525;
        bh=CAS+ru0ajwIKIWzCOM/JwX8K8QgHCTE7GYFPL5L+3xo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H2MrBCNWiVjUgxcVGkWWQZNsLizT7wYScyi3l/Y6iGkdX8yP6MEzcOX9Eh9nc+UMw
         ohq5ygASUG6ikzJWztkAe8SVq4+U0Ljg0EXcxop0u1GDqS5POWL+I/zSB2MTnS3WQx
         53lDQMMa1U0vCNF9Ot4nEzr/H8JmoxQ7ZsRCpSYI=
Date:   Sat, 25 Mar 2023 23:42:12 +0200
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
Subject: Re: [PATCH 8/9] media: sun6i-isp: capture: Implement MC I/O with
 extended enum_fmt
Message-ID: <20230325214212.GF22214@pendragon.ideasonboard.com>
References: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
 <20230324151228.2778112-9-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230324151228.2778112-9-paul.kocialkowski@bootlin.com>
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

On Fri, Mar 24, 2023 at 04:12:27PM +0100, Paul Kocialkowski wrote:
> This driver needs the media-controller API to operate and should not be
> considered as a video-device-centric implementation.
> 
> Properly report the IO_MC device cap and extend the enum_fmt
> implementation to support enumeration with an explicit mbus_code.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c    | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c
> index 1595a9607775..5160b93b69ff 100644
> --- a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c
> +++ b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c
> @@ -439,6 +439,12 @@ static int sun6i_isp_capture_enum_fmt(struct file *file, void *private,
>  				      struct v4l2_fmtdesc *fmtdesc)
>  {
>  	u32 index = fmtdesc->index;
> +	u32 mbus_code = fmtdesc->mbus_code;
> +
> +	if (mbus_code && !sun6i_isp_proc_format_find(mbus_code))
> +		return -EINVAL;
> +

This doesn't look right. As far as I understand,
sun6i_isp_proc_format_find() looks up media bus codes for the ISP sink
pad. Here you enuemrate pixel formats of the ISP output, so the media
bus code given by userspace corresponds to the ISP source pad.

I've had a look at sun6i_isp_proc_set_fmt() to see what media bus codes
are used on the ISP output, and couldn't figure it out as it seems
incorrectly implemented :-) The function doesn't check format->pad.

> +	/* Capture format is independent from proc format. */
>  
>  	if (index >= ARRAY_SIZE(sun6i_isp_capture_formats))
>  		return -EINVAL;
> @@ -685,7 +691,8 @@ int sun6i_isp_capture_setup(struct sun6i_isp_device *isp_dev)
>  
>  	strscpy(video_dev->name, SUN6I_ISP_CAPTURE_NAME,
>  		sizeof(video_dev->name));
> -	video_dev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
> +	video_dev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING |
> +				 V4L2_CAP_IO_MC;
>  	video_dev->vfl_dir = VFL_DIR_RX;
>  	video_dev->release = video_device_release_empty;
>  	video_dev->fops = &sun6i_isp_capture_fops;

-- 
Regards,

Laurent Pinchart
