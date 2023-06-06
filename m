Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AAE723F55
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbjFFK0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjFFKZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:25:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A80E8;
        Tue,  6 Jun 2023 03:25:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB755623A8;
        Tue,  6 Jun 2023 10:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96818C433EF;
        Tue,  6 Jun 2023 10:25:52 +0000 (UTC)
Message-ID: <cb390322-3b4a-7ed3-e304-11393342787c@xs4all.nl>
Date:   Tue, 6 Jun 2023 12:25:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC v2 5/6] media: v4l2-ctrls: add lens calibration
 controls
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
 <20230406-feature-controls-lens-v2-5-faa8ad2bc404@wolfvision.net>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230406-feature-controls-lens-v2-5-faa8ad2bc404@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2023 11:45, Michael Riesch wrote:
> Add the controls V4L2_CID_LENS_CALIB_CONTROL and V4L2_CID_LENS_CALIB_STATUS
> that facilitate the control of the lens group calibration procedure.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  .../userspace-api/media/v4l/ext-ctrls-camera.rst   | 35 ++++++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c          |  4 +++
>  include/uapi/linux/v4l2-controls.h                 | 12 ++++++++
>  3 files changed, 51 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> index a17620ab03b9..8b54a0f3a617 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> @@ -297,6 +297,41 @@ enum v4l2_auto_focus_range -
>      (V4L2_CID_ZOOM_ABSOLUTE and V4L2_CID_ZOOM_RELATIVE). The unit is
>      driver-specific. The value should be a positive integer.
>  
> +``V4L2_CID_LENS_CALIB_CONTROL (bitmask)``
> +    Control the calibration procedure (or individual parts thereof) of the lens
> +    groups. For example, this could include the mechanical range detection
> +    of zoom lens motors. This is a write-only control.
> +
> +.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +
> +    * - ``V4L2_LENS_CALIB_STOP``
> +      - Stop the lens calibration procedure.
> +    * - ``V4L2_LENS_CALIB_START``
> +      - Start the complete lens calibration procedure.

I don't like this as a bitmask control. Wouldn't it be better to have
two 'button' controls? One to start the calibration, one to stop?

Are more calibration control actions expected?

> +
> +``V4L2_CID_LENS_CALIB_STATUS (bitmask)``
> +    The status of the calibration procedure (or individual parts thereof) of
> +    the lens groups. This is a read-only control.
> +
> +.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +
> +    * - ``V4L2_LENS_CALIB_IDLE``
> +      - Lens calibration procedure has not yet been started.
> +    * - ``V4L2_LENS_CALIB_BUSY``
> +      - Lens calibration procedure is in progress.
> +    * - ``V4L2_LENS_CALIB_COMPLETE``
> +      - Lens calibration procedure is complete.
> +    * - ``V4L2_LENS_CALIB_FAILED``
> +      - Lens calibration procedure has failed.
> +
>  ``V4L2_CID_IRIS_ABSOLUTE (integer)``
>      This control sets the camera's aperture to the specified value. The
>      unit is undefined. Larger values open the iris wider, smaller values
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> index 3ef465ba73bd..faddfecba6d9 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> @@ -1050,6 +1050,8 @@ const char *v4l2_ctrl_get_name(u32 id)
>  	case V4L2_CID_ZOOM_STATUS:		return "Zoom, Status";
>  	case V4L2_CID_FOCUS_SPEED:		return "Focus, Speed";
>  	case V4L2_CID_ZOOM_SPEED:		return "Zoom, Speed";
> +	case V4L2_CID_LENS_CALIB_CONTROL:	return "Lens Calibration, Control";
> +	case V4L2_CID_LENS_CALIB_STATUS:	return "Lens Calibration, Status";
>  
>  	/* FM Radio Modulator controls */
>  	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
> @@ -1596,6 +1598,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>  	case V4L2_CID_FOCUS_RELATIVE:
>  	case V4L2_CID_IRIS_RELATIVE:
>  	case V4L2_CID_ZOOM_RELATIVE:
> +	case V4L2_CID_LENS_CALIB_CONTROL:
>  		*flags |= V4L2_CTRL_FLAG_WRITE_ONLY |
>  			  V4L2_CTRL_FLAG_EXECUTE_ON_WRITE;
>  		break;
> @@ -1603,6 +1606,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>  	case V4L2_CID_FOCUS_STATUS:
>  	case V4L2_CID_ZOOM_CURRENT:
>  	case V4L2_CID_ZOOM_STATUS:
> +	case V4L2_CID_LENS_CALIB_STATUS:
>  		*flags |= V4L2_CTRL_FLAG_READ_ONLY | V4L2_CTRL_FLAG_VOLATILE;

It makes no sense that this is volatile. Besides the comments I made in patch 3/6, there
is also the fact that I would expect the device to provide some sort of interrupt to
indicate calibration status changes. Otherwise userspace would have to keep polling to
know when the calibration finishes, which would be a really poor hardware design.

Is this really the case for the hardware you are considering?

>  		break;
>  	case V4L2_CID_FLASH_STROBE_STATUS:
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> index 8d84508d4db8..24c0eb5f4d29 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -1004,6 +1004,18 @@ enum v4l2_auto_focus_range {
>  #define V4L2_CID_FOCUS_SPEED			(V4L2_CID_CAMERA_CLASS_BASE+41)
>  #define V4L2_CID_ZOOM_SPEED			(V4L2_CID_CAMERA_CLASS_BASE+42)
>  
> +#define V4L2_LENS_CALIB_STOP			(0 << 0)
> +#define V4L2_LENS_CALIB_START			(1 << 0)
> +
> +#define V4L2_CID_LENS_CALIB_CONTROL		(V4L2_CID_CAMERA_CLASS_BASE+43)
> +
> +#define V4L2_LENS_CALIB_IDLE			(0 << 0)
> +#define V4L2_LENS_CALIB_BUSY			(1 << 0)
> +#define V4L2_LENS_CALIB_COMPLETE		(1 << 1)
> +#define V4L2_LENS_CALIB_FAILED			(1 << 2)
> +
> +#define V4L2_CID_LENS_CALIB_STATUS		(V4L2_CID_CAMERA_CLASS_BASE+44)
> +
>  /* FM Modulator class control IDs */
>  
>  #define V4L2_CID_FM_TX_CLASS_BASE		(V4L2_CTRL_CLASS_FM_TX | 0x900)
> 

Regards,

	Hans
