Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB44B725501
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238626AbjFGHDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238205AbjFGHDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:03:51 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5D2124;
        Wed,  7 Jun 2023 00:03:50 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126233170111.36.openmobile.ne.jp [126.233.170.111])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 40A2A75B;
        Wed,  7 Jun 2023 09:03:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1686121403;
        bh=16vLBD7V1iKc3L9Fi4fiArgYRtxacE0V/FVXE+u8hDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Err2+G0Ii/EIUcvp1qlJvi4Vmpu8hV0R83xOxnhpceXxD8xqMdbnZdLlzuJhSYpz7
         tIAYcug6VjMGS5+3YySybAEYAJl4x0OnPq7A5UWqrkXOtu25Xzf8DJoHUTSTF1OOnL
         yj3TzNmDZdrKAfTFd5UxNFIWYW4AAbMtqG4jkChc=
Date:   Wed, 7 Jun 2023 10:03:45 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        libcamera-devel@lists.libcamera.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 3/6] media: v4l2-ctrls: add lens group status
 controls for zoom and focus
Message-ID: <20230607070345.GH14101@pendragon.ideasonboard.com>
References: <20230406-feature-controls-lens-v2-0-faa8ad2bc404@wolfvision.net>
 <20230406-feature-controls-lens-v2-3-faa8ad2bc404@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230406-feature-controls-lens-v2-3-faa8ad2bc404@wolfvision.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Thank you for the patch.

On Tue, Apr 25, 2023 at 11:45:13AM +0200, Michael Riesch wrote:
> Add the controls V4L2_CID_{FOCUS,ZOOM}_{CURRENT,STATUS} that report the
> current position and status, respectively, of the zoom lens group and
> the focus lens group.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  .../userspace-api/media/v4l/ext-ctrls-camera.rst   | 46 ++++++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c          | 10 +++++
>  include/uapi/linux/v4l2-controls.h                 |  9 +++++
>  3 files changed, 65 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> index 42cf4c3cda0c..3ea4175f9619 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> @@ -150,6 +150,29 @@ enum v4l2_exposure_metering -
>      write-only control. It should be implemented only if the device cannot
>      handle absolute values.
>  
> +``V4L2_CID_FOCUS_CURRENT (integer)``
> +    The current position of the focal point. The unit is undefined. Larger
> +    values indicate that the focus is closer to the camera, smaller values
> +    indicate that the focus is closer to infinity. This is a read-only control.

I think you should also update the definition of the
V4L2_CID_FOCUS_ABSOLUTE control to indicate the reading the control back
will return the focus *target*, not the current focus position. This
control should also refer to V4L2_CID_FOCUS_ABSOLUTE.

I think we should also require the V4L2_CID_FOCUS_CURRENT and
V4L2_CID_FOCUS_ABSOLUTE controls to have the same unit.

Is this control expected to generate events, when the lens reaches its
target position, or during movement ?

How should we deal with the drivers that implement
V4L2_CID_FOCUS_ABSOLUTE, do any of them implement reading
V4L2_CID_FOCUS_ABSOLUTE with the semantics of the V4L2_CID_FOCUS_CURRENT
control, instead of returning the focus target ?

> +
> +``V4L2_CID_FOCUS_STATUS (bitmask)``
> +    The status of the focus lens group. The possible flags are described in
> +    the table below. This is a read-only control.

Is this control expected to generate events ?

> +
> +.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +
> +    * - ``V4L2_LENS_STATUS_IDLE``
> +      - Focus lens group is at rest.
> +    * - ``V4L2_LENS_STATUS_BUSY``
> +      - Focus lens group is moving.

V4L2_LENS_STATUS_MOVING would be a better name if it's defined as "is
moving".

> +    * - ``V4L2_LENS_STATUS_FAILED``
> +      - Focus lens group has failed to reach its target position. The driver

What are the expected reasons for this ?

> +	will not transition from this state until another action is performed
> +	by an application.

You're talking about transitions here, I think you should document the
state machine for the other states too. I expect the control to
transition from IDLE to MOVING when the V4L2_CID_FOCUS_ABSOLUTE control
is set, and transition from MOVING to IDLE or FAILED at the end of the
motion. What happens if the user sets V4L2_CID_FOCUS_ABSOLUTE while the
status is MOVING also needs to be documented.

It sounds we need helper functions to implement this state machine and
generate events, leaving it to drivers would open the door to different
behaviours for different devices.

All these comments apply to zoom too.

>  
>  ``V4L2_CID_FOCUS_AUTO (boolean)``
>      Enables continuous automatic focus adjustments. The effect of manual
> @@ -241,6 +264,29 @@ enum v4l2_auto_focus_range -
>      movement. A negative value moves the zoom lens group towards the
>      wide-angle direction. The zoom speed unit is driver-specific.
>  
> +``V4L2_CID_ZOOM_CURRENT (integer)``
> +    The current objective lens focal length. The unit is undefined and
> +    its value should be a positive integer. This is a read-only control.
> +
> +``V4L2_CID_ZOOM_STATUS (bitmask)``
> +    The status of the zoom lens group. The possible flags are described in
> +    the table below. This is a read-only control.
> +
> +.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +
> +    * - ``V4L2_LENS_STATUS_IDLE``
> +      - Zoom lens group is at rest.
> +    * - ``V4L2_LENS_STATUS_BUSY``
> +      - Zoom lens group is moving.
> +    * - ``V4L2_LENS_STATUS_FAILED``
> +      - Zoom lens group has failed to reach its target position. The driver will
> +	not transition from this state until another action is performed by an
> +	application.
> +
>  ``V4L2_CID_IRIS_ABSOLUTE (integer)``
>      This control sets the camera's aperture to the specified value. The
>      unit is undefined. Larger values open the iris wider, smaller values
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> index 564fedee2c88..794ef3ab0c02 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> @@ -1044,6 +1044,10 @@ const char *v4l2_ctrl_get_name(u32 id)
>  	case V4L2_CID_CAMERA_ORIENTATION:	return "Camera Orientation";
>  	case V4L2_CID_CAMERA_SENSOR_ROTATION:	return "Camera Sensor Rotation";
>  	case V4L2_CID_HDR_SENSOR_MODE:		return "HDR Sensor Mode";
> +	case V4L2_CID_FOCUS_CURRENT:		return "Focus, Current";
> +	case V4L2_CID_FOCUS_STATUS:		return "Focus, Status";
> +	case V4L2_CID_ZOOM_CURRENT:		return "Zoom, Current";
> +	case V4L2_CID_ZOOM_STATUS:		return "Zoom, Status";
>  
>  	/* FM Radio Modulator controls */
>  	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
> @@ -1593,6 +1597,12 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>  		*flags |= V4L2_CTRL_FLAG_WRITE_ONLY |
>  			  V4L2_CTRL_FLAG_EXECUTE_ON_WRITE;
>  		break;
> +	case V4L2_CID_FOCUS_CURRENT:
> +	case V4L2_CID_FOCUS_STATUS:
> +	case V4L2_CID_ZOOM_CURRENT:
> +	case V4L2_CID_ZOOM_STATUS:
> +		*flags |= V4L2_CTRL_FLAG_READ_ONLY | V4L2_CTRL_FLAG_VOLATILE;
> +		break;
>  	case V4L2_CID_FLASH_STROBE_STATUS:
>  	case V4L2_CID_AUTO_FOCUS_STATUS:
>  	case V4L2_CID_FLASH_READY:
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> index 5e80daa4ffe0..793ee8c65e87 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -993,6 +993,15 @@ enum v4l2_auto_focus_range {
>  
>  #define V4L2_CID_HDR_SENSOR_MODE		(V4L2_CID_CAMERA_CLASS_BASE+36)
>  
> +#define V4L2_LENS_STATUS_IDLE			(0 << 0)
> +#define V4L2_LENS_STATUS_BUSY			(1 << 0)
> +#define V4L2_LENS_STATUS_FAILED			(1 << 2)
> +
> +#define V4L2_CID_FOCUS_CURRENT			(V4L2_CID_CAMERA_CLASS_BASE+37)
> +#define V4L2_CID_FOCUS_STATUS			(V4L2_CID_CAMERA_CLASS_BASE+38)
> +#define V4L2_CID_ZOOM_CURRENT			(V4L2_CID_CAMERA_CLASS_BASE+39)
> +#define V4L2_CID_ZOOM_STATUS			(V4L2_CID_CAMERA_CLASS_BASE+40)
> +
>  /* FM Modulator class control IDs */
>  
>  #define V4L2_CID_FM_TX_CLASS_BASE		(V4L2_CTRL_CLASS_FM_TX | 0x900)
> 

-- 
Regards,

Laurent Pinchart
