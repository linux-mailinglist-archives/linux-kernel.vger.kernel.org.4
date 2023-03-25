Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C8D6C9102
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 22:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjCYVdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 17:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjCYVdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 17:33:33 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D6CCA37;
        Sat, 25 Mar 2023 14:33:32 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 605458BE;
        Sat, 25 Mar 2023 22:33:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1679780010;
        bh=Y6nQUcxsMUEaLqFYKd5Cw8gbyXuuUb2Ob4ctiSEQ+mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F6gTpVIz0XFThyxKyCyXBI8ptYpMSvsCt+wjSsvDYGUwcKZwY3KklV2irQVXhsShl
         ild0bS5259NBrDKhIXUEjz6G5fRsGj7ziXDPhWVM7BBgV5Fco4dnjaexzNbFwaUjzr
         HjhIgDc788NZWqP1v8kdDuOtzqOxCL9JBhyyQyoI=
Date:   Sat, 25 Mar 2023 23:33:36 +0200
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
Subject: Re: [PATCH 7/9] media: sun6i-csi: capture: Implement enum_framesizes
Message-ID: <20230325213336.GE22214@pendragon.ideasonboard.com>
References: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
 <20230324151228.2778112-8-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230324151228.2778112-8-paul.kocialkowski@bootlin.com>
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

On Fri, Mar 24, 2023 at 04:12:26PM +0100, Paul Kocialkowski wrote:
> Report available frame sizes as a continuous range between the
> hardware min/max limits.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Co-authored-by: Adam Pigg <adam@piggz.co.uk>
> Signed-off-by: Adam Pigg <adam@piggz.co.uk>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> index 9627030ff060..31ba83014086 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> @@ -847,6 +847,30 @@ static int sun6i_csi_capture_try_fmt(struct file *file, void *private,
>  	return 0;
>  }
>  
> +static int
> +sun6i_csi_capture_enum_framesizes(struct file *file, void *fh,
> +				  struct v4l2_frmsizeenum *frmsizeenum)
> +{
> +	const struct sun6i_csi_capture_format *format;
> +
> +	if (frmsizeenum->index > 0)
> +		return -EINVAL;
> +
> +	format = sun6i_csi_capture_format_find(frmsizeenum->pixel_format);
> +	if (!format)
> +		return -EINVAL;
> +
> +	frmsizeenum->type = V4L2_FRMSIZE_TYPE_CONTINUOUS;
> +	frmsizeenum->stepwise.min_width = SUN6I_CSI_CAPTURE_WIDTH_MIN;
> +	frmsizeenum->stepwise.max_width = SUN6I_CSI_CAPTURE_WIDTH_MAX;
> +	frmsizeenum->stepwise.min_height = SUN6I_CSI_CAPTURE_HEIGHT_MIN;
> +	frmsizeenum->stepwise.max_height = SUN6I_CSI_CAPTURE_HEIGHT_MAX;
> +	frmsizeenum->stepwise.step_width = 1;
> +	frmsizeenum->stepwise.step_height = 1;
> +
> +	return 0;
> +}
> +
>  static int sun6i_csi_capture_enum_input(struct file *file, void *private,
>  					struct v4l2_input *input)
>  {
> @@ -884,6 +908,8 @@ static const struct v4l2_ioctl_ops sun6i_csi_capture_ioctl_ops = {
>  	.vidioc_s_fmt_vid_cap		= sun6i_csi_capture_s_fmt,
>  	.vidioc_try_fmt_vid_cap		= sun6i_csi_capture_try_fmt,
>  
> +	.vidioc_enum_framesizes		= sun6i_csi_capture_enum_framesizes,
> +
>  	.vidioc_enum_input		= sun6i_csi_capture_enum_input,
>  	.vidioc_g_input			= sun6i_csi_capture_g_input,
>  	.vidioc_s_input			= sun6i_csi_capture_s_input,

-- 
Regards,

Laurent Pinchart
