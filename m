Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D0165C7F4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237615AbjACURo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjACURm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:17:42 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B6121B2;
        Tue,  3 Jan 2023 12:17:41 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9D5D4108;
        Tue,  3 Jan 2023 21:17:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672777060;
        bh=lh2YiudcULvWvjVfZZbBPQ/O+yMC2b+02qH09fc1qNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=atg7Iwtjskq4rDaYqHp/YrTUYDbAWSdiWGN7tvNGb8DSfUOyIvTJ+5NFJyxQRUUQK
         T1oVxGi6YmU0p61vMpsNcg6nMTcwaNirHNgq8x2UEHRqhh7JrkvYw0/+cj5xMBKZr5
         4sDB4T4+GKZthFh+LCw74Ku2lSCTTl11dZum60qw=
Date:   Tue, 3 Jan 2023 22:17:35 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH v3 5/8] media: uvcvideo: Fix handling on Bitmask controls
Message-ID: <Y7SNX5vAOuTq0NbO@pendragon.ideasonboard.com>
References: <20220920-resend-v4l2-compliance-v3-0-598d33a15815@chromium.org>
 <20220920-resend-v4l2-compliance-v3-5-598d33a15815@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-v4l2-compliance-v3-5-598d33a15815@chromium.org>
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

On Tue, Jan 03, 2023 at 03:36:23PM +0100, Ricardo Ribalda wrote:
> Minimum and step values for V4L2_CTRL_TYPE_BITMASK controls should be 0.
> There is no need to query the camera firmware about this and maybe get
> invalid results.
> 
> Also value should be masked to the max value advertised by the
> hardware.
> 
> Finally, handle UVC 1.5 mask controls that use MAX instead of RES to
> describe the valid bits.
> 
> Fixes v4l2-compliane:
> Control ioctls (Input 0):
>                 fail: v4l2-test-controls.cpp(97): minimum must be 0 for a bitmask control
> 	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: FAIL
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 52 ++++++++++++++++++++++++++++++----------
>  1 file changed, 40 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 6165d6b8e855..7622c5b54b35 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1161,6 +1161,25 @@ static const char *uvc_map_get_name(const struct uvc_control_mapping *map)
>  	return "Unknown Control";
>  }
>  
> +static u32 uvc_get_ctrl_bitmap(struct uvc_control *ctrl,
> +			       struct uvc_control_mapping *mapping)
> +{
> +	/*
> +	 * Some controls, like CT_AE_MODE_CONTROL, use GET_RES to represent
> +	 * the number of bits supported. Those controls do not list GET_MAX
> +	 * as supported.
> +	 */
> +	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)
> +		return mapping->get(mapping, UVC_GET_RES,
> +				    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
> +
> +	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX)
> +		return mapping->get(mapping, UVC_GET_MAX,
> +				    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
> +
> +	return ~0;
> +}
> +
>  static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>  	struct uvc_control *ctrl,
>  	struct uvc_control_mapping *mapping,
> @@ -1235,6 +1254,12 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>  		v4l2_ctrl->step = 0;
>  		return 0;
>  
> +	case V4L2_CTRL_TYPE_BITMASK:
> +		v4l2_ctrl->minimum = 0;
> +		v4l2_ctrl->maximum = uvc_get_ctrl_bitmap(ctrl, mapping);
> +		v4l2_ctrl->step = 0;
> +		return 0;
> +
>  	default:
>  		break;
>  	}
> @@ -1336,19 +1361,14 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
>  
>  	menu_info = &mapping->menu_info[query_menu->index];
>  
> -	if (mapping->data_type == UVC_CTRL_DATA_TYPE_BITMASK &&
> -	    (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)) {
> -		s32 bitmap;
> -
> +	if (mapping->data_type == UVC_CTRL_DATA_TYPE_BITMASK) {
>  		if (!ctrl->cached) {
>  			ret = uvc_ctrl_populate_cache(chain, ctrl);
>  			if (ret < 0)
>  				goto done;
>  		}
>  
> -		bitmap = mapping->get(mapping, UVC_GET_RES,
> -				      uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
> -		if (!(bitmap & menu_info->value)) {
> +		if (!(uvc_get_ctrl_bitmap(ctrl, mapping) & menu_info->value)) {
>  			ret = -EINVAL;
>  			goto done;
>  		}
> @@ -1831,6 +1851,17 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>  		value = xctrl->value;
>  		break;
>  
> +	case V4L2_CTRL_TYPE_BITMASK:
> +		if (!ctrl->cached) {
> +			ret = uvc_ctrl_populate_cache(chain, ctrl);
> +			if (ret < 0)
> +				return ret;
> +		}
> +
> +		xctrl->value &= uvc_get_ctrl_bitmap(ctrl, mapping);
> +		value = xctrl->value;
> +		break;
> +
>  	case V4L2_CTRL_TYPE_BOOLEAN:
>  		xctrl->value = clamp(xctrl->value, 0, 1);
>  		value = xctrl->value;
> @@ -1845,17 +1876,14 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>  		 * Valid menu indices are reported by the GET_RES request for
>  		 * UVC controls that support it.
>  		 */
> -		if (mapping->data_type == UVC_CTRL_DATA_TYPE_BITMASK &&
> -		    (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)) {
> +		if (mapping->data_type == UVC_CTRL_DATA_TYPE_BITMASK) {
>  			if (!ctrl->cached) {
>  				ret = uvc_ctrl_populate_cache(chain, ctrl);
>  				if (ret < 0)
>  					return ret;
>  			}
>  
> -			step = mapping->get(mapping, UVC_GET_RES,
> -					uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
> -			if (!(step & value))
> +			if (!(uvc_get_ctrl_bitmap(ctrl, mapping) & value))
>  				return -EINVAL;
>  		}
>  
> 

-- 
Regards,

Laurent Pinchart
