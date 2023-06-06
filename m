Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6CD723F39
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjFFKUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbjFFKUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:20:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3746DE42;
        Tue,  6 Jun 2023 03:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDD1F62582;
        Tue,  6 Jun 2023 10:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E438C433D2;
        Tue,  6 Jun 2023 10:20:11 +0000 (UTC)
Message-ID: <daf50780-daad-83e3-b236-3b9a22f6a779@xs4all.nl>
Date:   Tue, 6 Jun 2023 12:20:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC v2 3/6] media: v4l2-ctrls: add lens group status
 controls for zoom and focus
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
 <20230406-feature-controls-lens-v2-3-faa8ad2bc404@wolfvision.net>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230406-feature-controls-lens-v2-3-faa8ad2bc404@wolfvision.net>
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
> +
> +``V4L2_CID_FOCUS_STATUS (bitmask)``
> +    The status of the focus lens group. The possible flags are described in
> +    the table below. This is a read-only control.
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
> +    * - ``V4L2_LENS_STATUS_FAILED``
> +      - Focus lens group has failed to reach its target position. The driver
> +	will not transition from this state until another action is performed
> +	by an application.
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

Drop the VOLATILE bit. It is up to the driver to set that.

If the hardware can keep the driver informed of position or status changes
(e.g. via an interrupt), then the driver can just update the control and
userspace is informed of the change through a control event.

If this is not possible, then userspace has to poll, and in that case VOLATILE
has to be set.

This looks good otherwise.

Regards,

	Hans

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

