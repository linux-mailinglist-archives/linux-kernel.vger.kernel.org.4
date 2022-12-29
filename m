Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DE96591D7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 21:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbiL2UzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 15:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiL2UzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 15:55:02 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34F1AE41;
        Thu, 29 Dec 2022 12:55:00 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EE2FD283;
        Thu, 29 Dec 2022 21:54:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672347298;
        bh=97obUa25AWySinbvAk5YwsC8CEZqGjb8Mg5elGlUPA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DQMj0DYvvFu0sqegxHbl647x3Y1Shx67J1qhM7q20J+RH9sDWBnnOBsYSI7R3VJnk
         zaUMfqcqNjSqxz8h7gO/+MF9D6T3xkn3t1fi9LmnzZWBtqIwMRpVGCbKPVPl1R4GS+
         a5vbiVDAtb0bUgxAsritLJ3fNrG/h3WG3DL8q+FU=
Date:   Thu, 29 Dec 2022 22:54:52 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>
Subject: Re: [PATCH RESEND v2 1/7] media: uvcvideo: uvc_ctrl_is_accessible:
 check for INACTIVE
Message-ID: <Y63+nF2PqKad8S18@pendragon.ideasonboard.com>
References: <20220920-resend-v4l2-compliance-v2-0-b0ceb15353ac@chromium.org>
 <20220920-resend-v4l2-compliance-v2-1-b0ceb15353ac@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220920-resend-v4l2-compliance-v2-1-b0ceb15353ac@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo and Hans,

Thank you for the patch.

On Fri, Dec 02, 2022 at 06:21:35PM +0100, Ricardo Ribalda wrote:
> From: Hans Verkuil <hverkuil@xs4all.nl>
> 
> Check for inactive controls in uvc_ctrl_is_accessible().
> Use the new value for the master_id controls if present,
> otherwise use the existing value to determine if it is OK
> to set the control. Doing this here avoids attempting to
> set an inactive control, which will return an error from the
> USB device, which returns an invalid errorcode.

I'd write the subject line as

media: uvcvideo: Check for INACTIVE in uvc_ctrl_is_accessible()

and reflow the commit message to 72 columns here.

> This fixes:
>   warn: v4l2-test-controls.cpp(483): s_ctrl returned EIO
>   warn: v4l2-test-controls.cpp(483): s_ctrl returned EIO
> test VIDIOC_G/S_CTRL: OK
>   warn: v4l2-test-controls.cpp(739): s_ext_ctrls returned EIO
>   warn: v4l2-test-controls.cpp(739): s_ext_ctrls returned EIO
>   warn: v4l2-test-controls.cpp(816): s_ext_ctrls returned EIO
> test VIDIOC_G/S/TRY_EXT_CTRLS: OK
> 
> Tested with:
> v4l2-ctl -c auto_exposure=1
> OK
> v4l2-ctl -c exposure_time_absolute=251
> OK
> v4l2-ctl -c auto_exposure=3
> OK
> v4l2-ctl -c exposure_time_absolute=251
> VIDIOC_S_EXT_CTRLS: failed: Input/output error
> exposure_time_absolute: Input/output error
> ERROR
> v4l2-ctl -c auto_exposure=3,exposure_time_absolute=251,auto_exposure=1
> v4l2-ctl -C auto_exposure,exposure_time_absolute  
> auto_exposure: 1
> exposure_time_absolute: 251
> 
> Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 47 +++++++++++++++++++++++++++++++++++++++-
>  drivers/media/usb/uvc/uvc_v4l2.c |  4 ++--
>  drivers/media/usb/uvc/uvcvideo.h |  3 ++-
>  3 files changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 8c208db9600b..7153ee5aabb1 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1064,11 +1064,33 @@ static int uvc_query_v4l2_class(struct uvc_video_chain *chain, u32 req_id,
>  	return 0;
>  }
>  
> +/**
> + * uvc_ctrl_is_accessible() - Check if a control can be read/writen/tried.
> + * @chain: uvc_video_chain that the controls belong to.
> + * @v4l2_id: video4linux id of the control.
> + * @ctrl: Other controls that will be accessed in the ioctl.
> + * @ioctl: ioctl used to access the control.

The driver doesn't use kerneldoc anywhere, so to match the current style
I'd use /* instead of /**, and drop the documentation of the function
arguments as it's trivial.

> + *
> + * Check if a control can be accessed by a specicific ioctl operation,

s/specicific/specific/

> + * assuming that other controls are also going to be accessed by that ioctl.
> + * We need to check the value of the other controls, to support operations
> + * where a master value is changed with a slave value. Eg.
> + * auto_exposure=1,exposure_time_absolute=251
> + *

Extra blank line.

I'd rephrase that a bit to make it more precise:

 * Check if control @v4l2_id can be accessed by the given control @ioctl
 * (VIDIOC_G_EXT_CTRLS, VIDIOC_TRY_EXT_CTRLS or VIDIOC_S_EXT_CTRLS).
 *
 * For set operations on slave controls, check if the master's value is set to
 * manual, either in the others controls set in the same ioctl call, or from the
 * master's current value. This catches VIDIOC_S_EXT_CTRLS calls that
 * set both the master and slave control, such as for instance setting
 * auto_exposure=1,exposure_time_absolute=251.

> + */
>  int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
> -			   bool read)
> +			   const struct v4l2_ext_controls *ctrls,
> +			   unsigned long ioctl)
>  {
> +	struct uvc_control_mapping *master_map = NULL;
> +	struct uvc_control *master_ctrl = NULL;
>  	struct uvc_control_mapping *mapping;
>  	struct uvc_control *ctrl;
> +	bool read = ioctl == VIDIOC_G_EXT_CTRLS;
> +	bool try = ioctl == VIDIOC_TRY_EXT_CTRLS;
> +	s32 val;
> +	int ret;
> +	int i;
>  
>  	if (__uvc_query_v4l2_class(chain, v4l2_id, 0) >= 0)
>  		return -EACCES;
> @@ -1083,6 +1105,29 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
>  	if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR) && !read)
>  		return -EACCES;
>  
> +	if (read || try || !mapping->master_id)

I'd write this

	if (ioctl != VIDIOC_S_EXT_CTRLS || !mapping->master_id)

and drop the try variable.

> +		return 0;
> +
> +	/*
> +	 * Iterate backwards in cases where the master control is accessed
> +	 * multiple times in the same ioctl. We want the last value.
> +	 */
> +	for (i = ctrls->count - 1; i >= 0; i--) {
> +		if (ctrls->controls[i].id == mapping->master_id)
> +			return ctrls->controls[i].value ==
> +					mapping->master_manual ? 0 : -EACCES;
> +	}
> +
> +	__uvc_find_control(ctrl->entity, mapping->master_id, &master_map,
> +			   &master_ctrl, 0);
> +
> +	if (!master_ctrl || !(master_ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR))
> +		return 0;
> +
> +	ret = __uvc_ctrl_get(chain, master_ctrl, master_map, &val);
> +	if (ret >= 0 && val != mapping->master_manual)
> +		return -EACCES;
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 4cc3fa6b8c98..d95168cdc2d1 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -1020,8 +1020,8 @@ static int uvc_ctrl_check_access(struct uvc_video_chain *chain,
>  	int ret = 0;
>  
>  	for (i = 0; i < ctrls->count; ++ctrl, ++i) {
> -		ret = uvc_ctrl_is_accessible(chain, ctrl->id,
> -					    ioctl == VIDIOC_G_EXT_CTRLS);
> +		ret = uvc_ctrl_is_accessible(chain, ctrl->id, ctrls,
> +					    ioctl);

This holds on a single line.

Conditionally-Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I can address all the review comments when applying.

>  		if (ret)
>  			break;
>  	}
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 24c911aeebce..644d5fcf2eef 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -905,7 +905,8 @@ static inline int uvc_ctrl_rollback(struct uvc_fh *handle)
>  int uvc_ctrl_get(struct uvc_video_chain *chain, struct v4l2_ext_control *xctrl);
>  int uvc_ctrl_set(struct uvc_fh *handle, struct v4l2_ext_control *xctrl);
>  int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
> -			   bool read);
> +			   const struct v4l2_ext_controls *ctrls,
> +			   unsigned long ioctl);
>  
>  int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
>  		      struct uvc_xu_control_query *xqry);
> 

-- 
Regards,

Laurent Pinchart
