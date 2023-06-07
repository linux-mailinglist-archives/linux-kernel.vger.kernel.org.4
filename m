Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4130E72550C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbjFGHIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238561AbjFGHIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:08:05 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750F7198B;
        Wed,  7 Jun 2023 00:08:04 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126233170111.36.openmobile.ne.jp [126.233.170.111])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4290C75B;
        Wed,  7 Jun 2023 09:07:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1686121657;
        bh=pJbYtMyyu1/ugr10zRFTfl56Goe4o8unQjK6lSSuXA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M2oudcTCVRe19TW5SqU+ZA9kZe5ZikzgWqneGHjT5MoVOhdWzL4bSYCWD21m+HcH4
         D+oAib+NFALwEMOrv7F3EPSJb1xRc2C9c/jF1QWjCObojRWUV/IkmprH8dNPQtJkRl
         HmVOpojZD+yZmoa/z0cIFQXWbnVOVUbF/W6m97rQ=
Date:   Wed, 7 Jun 2023 10:07:59 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        libcamera-devel@lists.libcamera.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 4/6] media: v4l2-ctrls: add lens group speed
 controls for zoom and focus
Message-ID: <20230607070759.GI14101@pendragon.ideasonboard.com>
References: <20230406-feature-controls-lens-v2-0-faa8ad2bc404@wolfvision.net>
 <20230406-feature-controls-lens-v2-4-faa8ad2bc404@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230406-feature-controls-lens-v2-4-faa8ad2bc404@wolfvision.net>
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

On Tue, Apr 25, 2023 at 11:45:14AM +0200, Michael Riesch wrote:
> Add the controls V4L2_CID_FOCUS_SPEED and V4L2_CID_ZOOM_SPEED that set
> the speed of the zoom lens group and focus lens group, respectively.

Ah, now the UVC relative focus and zoom controls could be implemented
;-) They still don't match the definition of the corresponding V4L2
controls, so I'm still tempted to deprecate both.

> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst | 10 ++++++++++
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c                  |  2 ++
>  include/uapi/linux/v4l2-controls.h                         |  2 ++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> index 3ea4175f9619..a17620ab03b9 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> @@ -174,6 +174,11 @@ enum v4l2_exposure_metering -
>  	will not transition from this state until another action is performed
>  	by an application.
>  
> +``V4L2_CID_FOCUS_SPEED (integer)``
> +    Set the speed with which the focus lens group of the camera is moved
> +    (V4L2_CID_FOCUS_ABSOLUTE and V4L2_CID_FOCUS_RELATIVE). The unit is
> +    driver-specific. The value should be a positive integer.
> +

Could you explain your expected use cases for focus and zoom speed ?

>  ``V4L2_CID_FOCUS_AUTO (boolean)``
>      Enables continuous automatic focus adjustments. The effect of manual
>      focus adjustments while this feature is enabled is undefined,
> @@ -287,6 +292,11 @@ enum v4l2_auto_focus_range -
>  	not transition from this state until another action is performed by an
>  	application.
>  
> +``V4L2_CID_ZOOM_SPEED (integer)``
> +    Set the speed with which the zoom lens group of the camera is moved
> +    (V4L2_CID_ZOOM_ABSOLUTE and V4L2_CID_ZOOM_RELATIVE). The unit is
> +    driver-specific. The value should be a positive integer.
> +
>  ``V4L2_CID_IRIS_ABSOLUTE (integer)``
>      This control sets the camera's aperture to the specified value. The
>      unit is undefined. Larger values open the iris wider, smaller values
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> index 794ef3ab0c02..3ef465ba73bd 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> @@ -1048,6 +1048,8 @@ const char *v4l2_ctrl_get_name(u32 id)
>  	case V4L2_CID_FOCUS_STATUS:		return "Focus, Status";
>  	case V4L2_CID_ZOOM_CURRENT:		return "Zoom, Current";
>  	case V4L2_CID_ZOOM_STATUS:		return "Zoom, Status";
> +	case V4L2_CID_FOCUS_SPEED:		return "Focus, Speed";
> +	case V4L2_CID_ZOOM_SPEED:		return "Zoom, Speed";
>  
>  	/* FM Radio Modulator controls */
>  	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> index 793ee8c65e87..8d84508d4db8 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -1001,6 +1001,8 @@ enum v4l2_auto_focus_range {
>  #define V4L2_CID_FOCUS_STATUS			(V4L2_CID_CAMERA_CLASS_BASE+38)
>  #define V4L2_CID_ZOOM_CURRENT			(V4L2_CID_CAMERA_CLASS_BASE+39)
>  #define V4L2_CID_ZOOM_STATUS			(V4L2_CID_CAMERA_CLASS_BASE+40)
> +#define V4L2_CID_FOCUS_SPEED			(V4L2_CID_CAMERA_CLASS_BASE+41)
> +#define V4L2_CID_ZOOM_SPEED			(V4L2_CID_CAMERA_CLASS_BASE+42)
>  
>  /* FM Modulator class control IDs */
>  

-- 
Regards,

Laurent Pinchart
