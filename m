Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDAB660889
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbjAFU4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjAFU4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:56:40 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECC673E16;
        Fri,  6 Jan 2023 12:56:38 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 47CE44AE;
        Fri,  6 Jan 2023 21:56:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673038597;
        bh=O+lZRKGklAUbUOw3w+KFU1s2PzW+rjlH05aQR/JzUkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zx555jm9qXCpcaFXPEQkn73ZflaQTqSJoH3AsOI+z+FWSu6rKoUaLx37CAWeu9Ydx
         qLTnTAq+ZZP81L8IQGlt/uJuprADj5l0Qgsg9Vz9KkFsmzi3Gp7PHSZlQQUcz0f/so
         3aJH1AkVd+8445TUVxQl1AujGa/csxHhI/sB+Rr4=
Date:   Fri, 6 Jan 2023 22:56:31 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Yunke Cao <yunkec@chromium.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 5/7] media: uvcvideo: Refactor
 power_line_frequency_controls_limited
Message-ID: <Y7iK/xuiSOsqBzqq@pendragon.ideasonboard.com>
References: <20230105-uvc-gcc5-v2-0-2ba6c660d6f5@chromium.org>
 <20230105-uvc-gcc5-v2-5-2ba6c660d6f5@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230105-uvc-gcc5-v2-5-2ba6c660d6f5@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Thu, Jan 05, 2023 at 02:52:56PM +0100, Ricardo Ribalda wrote:
> Move the control mapping to uvc_ctrl.c. This way we do not have
> references to UVC controls or V4L2 controls in uvc_driver.c
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c   | 13 +++++++++++++
>  drivers/media/usb/uvc/uvc_driver.c | 18 ------------------
>  drivers/media/usb/uvc/uvcvideo.h   |  1 +
>  3 files changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 9af64f7a23d3..f559a1ac6e3c 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -723,6 +723,19 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
>  	},
>  };
>  
> +const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
> +	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
> +	.entity		= UVC_GUID_UVC_PROCESSING,
> +	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
> +	.size		= 2,
> +	.offset		= 0,
> +	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
> +	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
> +	.menu_info	= power_line_frequency_controls,
> +	.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ,
> +				  V4L2_CID_POWER_LINE_FREQUENCY_50HZ),

This also fixes a bug introduced in commit 382075604a68 ("media:
uvcvideo: Limit power line control for Quanta UVC Webcam"). The
offending commit caused the power line control menu entries to have
incorrect indices compared to the V4L2_CID_POWER_LINE_FREQUENCY_*
enumeration. Now that the limited mapping reuses the correct menu_info
array, the indices correctly map to the V4L2 control specification.

I'll add the above paragraph to the commit message, along with a Fixes:
line.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +};
> +
>  static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11 = {
>  	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
>  	.entity		= UVC_GUID_UVC_PROCESSING,
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index e659670ea2d8..37d2b08bc8b2 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2378,24 +2378,6 @@ MODULE_PARM_DESC(timeout, "Streaming control requests timeout");
>   * Driver initialization and cleanup
>   */
>  
> -static const struct uvc_menu_info power_line_frequency_controls_limited[] = {
> -	{ 1, "50 Hz" },
> -	{ 2, "60 Hz" },
> -};
> -
> -static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
> -	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
> -	.entity		= UVC_GUID_UVC_PROCESSING,
> -	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
> -	.size		= 2,
> -	.offset		= 0,
> -	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
> -	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
> -	.menu_info	= power_line_frequency_controls_limited,
> -	.menu_mask	=
> -		GENMASK(ARRAY_SIZE(power_line_frequency_controls_limited) - 1, 0),
> -};
> -
>  static const struct uvc_device_info uvc_ctrl_power_line_limited = {
>  	.mappings = (const struct uvc_control_mapping *[]) {
>  		&uvc_ctrl_power_line_mapping_limited,
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index a8eec43cd860..1b2d9f327583 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -747,6 +747,7 @@ int uvc_status_start(struct uvc_device *dev, gfp_t flags);
>  void uvc_status_stop(struct uvc_device *dev);
>  
>  /* Controls */
> +extern const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited;
>  extern const struct v4l2_subscribed_event_ops uvc_ctrl_sub_ev_ops;
>  
>  int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
> 

-- 
Regards,

Laurent Pinchart
