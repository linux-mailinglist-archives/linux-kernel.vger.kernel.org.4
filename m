Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489C5723F76
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbjFFKaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbjFFK3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:29:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DD9E8;
        Tue,  6 Jun 2023 03:29:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 531E8623A8;
        Tue,  6 Jun 2023 10:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11864C433D2;
        Tue,  6 Jun 2023 10:29:44 +0000 (UTC)
Message-ID: <1fd2e387-4f9c-b016-3d7a-f03c6bffc8f6@xs4all.nl>
Date:   Tue, 6 Jun 2023 12:29:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC v2 6/6] media: v4l2-ctrls: add controls for individual
 zoom lenses
Content-Language: en-US
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     libcamera-devel@lists.libcamera.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230406-feature-controls-lens-v2-0-faa8ad2bc404@wolfvision.net>
 <20230406-feature-controls-lens-v2-6-faa8ad2bc404@wolfvision.net>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230406-feature-controls-lens-v2-6-faa8ad2bc404@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2023 11:45, Michael Riesch wrote:
> A zoom lens group may consist of several lenses, and in a calibration
> context it may be necessary to position the lenses individually. Add a
> tuple of V4L2_CID_LENS_CALIB_ZOOMx_{ABSOLUTE,CURRENT,STATUS} controls
> for each individual lens, where x = {1...5}.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  .../userspace-api/media/v4l/ext-ctrls-camera.rst   | 30 ++++++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c          | 25 ++++++++++++++++++
>  include/uapi/linux/v4l2-controls.h                 | 18 +++++++++++++
>  3 files changed, 73 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> index 8b54a0f3a617..21391f076971 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> @@ -332,6 +332,36 @@ enum v4l2_auto_focus_range -
>      * - ``V4L2_LENS_CALIB_FAILED``
>        - Lens calibration procedure has failed.
>  
> +``V4L2_CID_LENS_CALIB_ZOOM{1...5}_ABSOLUTE`` (integer)
> +    Set the absolute position of the individual lens of the zoom lens group.
> +    Most likely, this is done in a calibration context. The unit is
> +    driver-specific.
> +
> +``V4L2_CID_LENS_CALIB_ZOOM{1...5}_CURRENT`` (integer)
> +    The current absolute position of the individual lens of the zoom lens group.
> +    Most likely, this is done in a calibration context. The unit is
> +    driver-specific. This is a read-only control.
> +
> +``V4L2_CID_LENS_CALIB_ZOOM{1...5}_STATUS`` (bitmask)
> +    The current status of the individual lens of the zoom lens group.
> +    Most likely, this is done in a calibration context. The possible flags are
> +    described in the table below. This is a read-only control.

Wouldn't it be better to have this as an array control? That way the number of
lenses is set by the driver and can be easily read by userspace.

> +
> +.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +
> +    * - ``V4L2_LENS_STATUS_IDLE``
> +      - Zoom lens is at rest.
> +    * - ``V4L2_LENS_STATUS_BUSY``
> +      - Zoom lens is moving.
> +    * - ``V4L2_LENS_STATUS_FAILED``
> +      - Zoom lens has failed to reach its target position. The driver will
> +	not transition from this state until another action is performed by an
> +	application.
> +
>  ``V4L2_CID_IRIS_ABSOLUTE (integer)``
>      This control sets the camera's aperture to the specified value. The
>      unit is undefined. Larger values open the iris wider, smaller values
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> index faddfecba6d9..8a78cffcd3e8 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> @@ -1052,6 +1052,21 @@ const char *v4l2_ctrl_get_name(u32 id)
>  	case V4L2_CID_ZOOM_SPEED:		return "Zoom, Speed";
>  	case V4L2_CID_LENS_CALIB_CONTROL:	return "Lens Calibration, Control";
>  	case V4L2_CID_LENS_CALIB_STATUS:	return "Lens Calibration, Status";
> +	case V4L2_CID_LENS_CALIB_ZOOM1_ABSOLUTE:	return "Zoom1, Absolute";
> +	case V4L2_CID_LENS_CALIB_ZOOM2_ABSOLUTE:	return "Zoom2, Absolute";
> +	case V4L2_CID_LENS_CALIB_ZOOM3_ABSOLUTE:	return "Zoom3, Absolute";
> +	case V4L2_CID_LENS_CALIB_ZOOM4_ABSOLUTE:	return "Zoom4, Absolute";
> +	case V4L2_CID_LENS_CALIB_ZOOM5_ABSOLUTE:	return "Zoom5, Absolute";
> +	case V4L2_CID_LENS_CALIB_ZOOM1_CURRENT:	return "Zoom1, Current";
> +	case V4L2_CID_LENS_CALIB_ZOOM2_CURRENT:	return "Zoom1, Current";
> +	case V4L2_CID_LENS_CALIB_ZOOM3_CURRENT:	return "Zoom1, Current";
> +	case V4L2_CID_LENS_CALIB_ZOOM4_CURRENT:	return "Zoom1, Current";
> +	case V4L2_CID_LENS_CALIB_ZOOM5_CURRENT:	return "Zoom1, Current";

You forget to update the number, it's all Zoom1 here.

> +	case V4L2_CID_LENS_CALIB_ZOOM1_STATUS:	return "Zoom1, Status";
> +	case V4L2_CID_LENS_CALIB_ZOOM2_STATUS:	return "Zoom2, Status";
> +	case V4L2_CID_LENS_CALIB_ZOOM3_STATUS:	return "Zoom3, Status";
> +	case V4L2_CID_LENS_CALIB_ZOOM4_STATUS:	return "Zoom4, Status";
> +	case V4L2_CID_LENS_CALIB_ZOOM5_STATUS:	return "Zoom5, Status";
>  
>  	/* FM Radio Modulator controls */
>  	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
> @@ -1607,6 +1622,16 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>  	case V4L2_CID_ZOOM_CURRENT:
>  	case V4L2_CID_ZOOM_STATUS:
>  	case V4L2_CID_LENS_CALIB_STATUS:
> +	case V4L2_CID_LENS_CALIB_ZOOM1_CURRENT:
> +	case V4L2_CID_LENS_CALIB_ZOOM2_CURRENT:
> +	case V4L2_CID_LENS_CALIB_ZOOM3_CURRENT:
> +	case V4L2_CID_LENS_CALIB_ZOOM4_CURRENT:
> +	case V4L2_CID_LENS_CALIB_ZOOM5_CURRENT:
> +	case V4L2_CID_LENS_CALIB_ZOOM1_STATUS:
> +	case V4L2_CID_LENS_CALIB_ZOOM2_STATUS:
> +	case V4L2_CID_LENS_CALIB_ZOOM3_STATUS:
> +	case V4L2_CID_LENS_CALIB_ZOOM4_STATUS:
> +	case V4L2_CID_LENS_CALIB_ZOOM5_STATUS:
>  		*flags |= V4L2_CTRL_FLAG_READ_ONLY | V4L2_CTRL_FLAG_VOLATILE;

Same issue as for patch 3 w.r.t. VOLATILE.

>  		break;
>  	case V4L2_CID_FLASH_STROBE_STATUS:
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> index 24c0eb5f4d29..7c49c0ba23d4 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -1016,6 +1016,24 @@ enum v4l2_auto_focus_range {
>  
>  #define V4L2_CID_LENS_CALIB_STATUS		(V4L2_CID_CAMERA_CLASS_BASE+44)
>  
> +#define V4L2_CID_LENS_CALIB_ZOOM1_ABSOLUTE	(V4L2_CID_CAMERA_CLASS_BASE+45)
> +#define V4L2_CID_LENS_CALIB_ZOOM2_ABSOLUTE	(V4L2_CID_CAMERA_CLASS_BASE+46)
> +#define V4L2_CID_LENS_CALIB_ZOOM3_ABSOLUTE	(V4L2_CID_CAMERA_CLASS_BASE+47)
> +#define V4L2_CID_LENS_CALIB_ZOOM4_ABSOLUTE	(V4L2_CID_CAMERA_CLASS_BASE+48)
> +#define V4L2_CID_LENS_CALIB_ZOOM5_ABSOLUTE	(V4L2_CID_CAMERA_CLASS_BASE+49)
> +
> +#define V4L2_CID_LENS_CALIB_ZOOM1_CURRENT	(V4L2_CID_CAMERA_CLASS_BASE+50)
> +#define V4L2_CID_LENS_CALIB_ZOOM2_CURRENT	(V4L2_CID_CAMERA_CLASS_BASE+51)
> +#define V4L2_CID_LENS_CALIB_ZOOM3_CURRENT	(V4L2_CID_CAMERA_CLASS_BASE+52)
> +#define V4L2_CID_LENS_CALIB_ZOOM4_CURRENT	(V4L2_CID_CAMERA_CLASS_BASE+53)
> +#define V4L2_CID_LENS_CALIB_ZOOM5_CURRENT	(V4L2_CID_CAMERA_CLASS_BASE+54)
> +
> +#define V4L2_CID_LENS_CALIB_ZOOM1_STATUS	(V4L2_CID_CAMERA_CLASS_BASE+55)
> +#define V4L2_CID_LENS_CALIB_ZOOM2_STATUS	(V4L2_CID_CAMERA_CLASS_BASE+56)
> +#define V4L2_CID_LENS_CALIB_ZOOM3_STATUS	(V4L2_CID_CAMERA_CLASS_BASE+57)
> +#define V4L2_CID_LENS_CALIB_ZOOM4_STATUS	(V4L2_CID_CAMERA_CLASS_BASE+58)
> +#define V4L2_CID_LENS_CALIB_ZOOM5_STATUS	(V4L2_CID_CAMERA_CLASS_BASE+59)
> +
>  /* FM Modulator class control IDs */
>  
>  #define V4L2_CID_FM_TX_CLASS_BASE		(V4L2_CTRL_CLASS_FM_TX | 0x900)
> 

Disclaimer: I do not have enough domain knowledge to comment on if this is the
right solution or not. I can only comment on the control framework specifics.

Regards,

	Hans
