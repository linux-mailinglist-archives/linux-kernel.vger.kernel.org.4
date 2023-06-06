Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD21C724055
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbjFFK6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237007AbjFFK53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:57:29 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B57310C4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:57:28 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-43b87490a27so472556137.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 03:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1686049047; x=1688641047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aRqKhGnlaqoHaJo3/OjQwqbS/TpCJN0bn4kwvJDOJKk=;
        b=pVi4BN5DvM+M/f2K1ZKvmhUAi0jM6E05abSte3DYeqSGo6blxMNO3o06T0Y0jD+53n
         z/IBHZmUMR7YJKaqHnHFc8VmHmON8epBGTwNIQoiEzKIJvSfVMqrMu6/yQA3Os7LqPVU
         MOif+3F2XRis+J5sfP447bXctfS8luyngoYJ+X4x1Q1RsMNX5YHfKIZamv3cDqLkn0Zy
         c2VxhJSf04mpEBoGOdRX1y+7VFm5lD4fusXSSATkrx8LhZkCYb4TQlJbH/3587J4yvlj
         uQ3WaVYKeRwTZnqDQ7JhBqGHIH1KPnzTfmno8p2awysJitE5RZiUYnes6vALrllKOQka
         Go5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686049047; x=1688641047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRqKhGnlaqoHaJo3/OjQwqbS/TpCJN0bn4kwvJDOJKk=;
        b=jl+/YNRra+lZ+7a0P8aNVleS5t105DSW5Z7DBHiMUOcYscCZGEB1GrSbnsM7+gjuyg
         j1EmpOLs6e+7I9wYyTyy84VkYRcOICCobFE2kYeoyhkWhOV92HSlrkHOjJxZgNrDK27N
         dFKIbLycosLkw0lJrjjWIgGx4A3CgBNR/JLdkYkze+MV6hxR/wq6yOhdkF0iCVp4CvNh
         KNSDKX+DYDwa+0boxC3VKAI7WF/jIc9Pqfja5YAGrlRU8Arhk1UV262x+D8YZY8Dwngm
         6FQisASvxhtTRX9NeqIDDiJCTVBwLdpomgYHdLJntIJC67r4uOLR1E9t60xlBhj83Qye
         CE4w==
X-Gm-Message-State: AC+VfDwr0+5/IsoNy4PQ4X7s4fhMm1RaUrZ7rq6Ch4Dud+cUiupm2El0
        C1wxiClaZB/1qSKHhxAS++TQsYXUpyMuUlMLskAQ5w==
X-Google-Smtp-Source: ACHHUZ41FnXV/lKmzkKTHaVtFTsLw7PpNozzj5AabnnFz7vAarhlTzuXi4TJw1lgKa1lskQS43Wv6woMbiNXeYF7eCc=
X-Received: by 2002:a67:b408:0:b0:43b:3eec:5e36 with SMTP id
 x8-20020a67b408000000b0043b3eec5e36mr1114900vsl.15.1686049047327; Tue, 06 Jun
 2023 03:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230406-feature-controls-lens-v2-0-faa8ad2bc404@wolfvision.net> <20230406-feature-controls-lens-v2-5-faa8ad2bc404@wolfvision.net>
In-Reply-To: <20230406-feature-controls-lens-v2-5-faa8ad2bc404@wolfvision.net>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 6 Jun 2023 11:57:11 +0100
Message-ID: <CAPY8ntB--44FAv=iwrZts7DsyHdQ=vCxxYkOCMB2mQJLBv+X=w@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/6] media: v4l2-ctrls: add lens calibration controls
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        libcamera-devel@lists.libcamera.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael

On Tue, 25 Apr 2023 at 10:45, Michael Riesch
<michael.riesch@wolfvision.net> wrote:
>
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

Idle as a term would generally encompass both COMPLETE and FAILED as
well as this case.
Use V4L2_LENS_CALIB_UNCABLIBRATED or similar instead?

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
>         case V4L2_CID_ZOOM_STATUS:              return "Zoom, Status";
>         case V4L2_CID_FOCUS_SPEED:              return "Focus, Speed";
>         case V4L2_CID_ZOOM_SPEED:               return "Zoom, Speed";
> +       case V4L2_CID_LENS_CALIB_CONTROL:       return "Lens Calibration, Control";
> +       case V4L2_CID_LENS_CALIB_STATUS:        return "Lens Calibration, Status";
>
>         /* FM Radio Modulator controls */
>         /* Keep the order of the 'case's the same as in v4l2-controls.h! */
> @@ -1596,6 +1598,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>         case V4L2_CID_FOCUS_RELATIVE:
>         case V4L2_CID_IRIS_RELATIVE:
>         case V4L2_CID_ZOOM_RELATIVE:
> +       case V4L2_CID_LENS_CALIB_CONTROL:
>                 *flags |= V4L2_CTRL_FLAG_WRITE_ONLY |
>                           V4L2_CTRL_FLAG_EXECUTE_ON_WRITE;
>                 break;
> @@ -1603,6 +1606,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>         case V4L2_CID_FOCUS_STATUS:
>         case V4L2_CID_ZOOM_CURRENT:
>         case V4L2_CID_ZOOM_STATUS:
> +       case V4L2_CID_LENS_CALIB_STATUS:
>                 *flags |= V4L2_CTRL_FLAG_READ_ONLY | V4L2_CTRL_FLAG_VOLATILE;
>                 break;
>         case V4L2_CID_FLASH_STROBE_STATUS:
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> index 8d84508d4db8..24c0eb5f4d29 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -1004,6 +1004,18 @@ enum v4l2_auto_focus_range {
>  #define V4L2_CID_FOCUS_SPEED                   (V4L2_CID_CAMERA_CLASS_BASE+41)
>  #define V4L2_CID_ZOOM_SPEED                    (V4L2_CID_CAMERA_CLASS_BASE+42)
>
> +#define V4L2_LENS_CALIB_STOP                   (0 << 0)
> +#define V4L2_LENS_CALIB_START                  (1 << 0)

Why a bitmask? What would setting both bits at the same time mean?

> +
> +#define V4L2_CID_LENS_CALIB_CONTROL            (V4L2_CID_CAMERA_CLASS_BASE+43)
> +
> +#define V4L2_LENS_CALIB_IDLE                   (0 << 0)
> +#define V4L2_LENS_CALIB_BUSY                   (1 << 0)
> +#define V4L2_LENS_CALIB_COMPLETE               (1 << 1)
> +#define V4L2_LENS_CALIB_FAILED                 (1 << 2)

Ditto. The status will only ever be one of these values, other than
possibly COMPLETE | FAILED. Renaming COMPLETE to SUCCESS would remove
that ambiguity and definitely make it one bit at a time.

  Dave

> +
> +#define V4L2_CID_LENS_CALIB_STATUS             (V4L2_CID_CAMERA_CLASS_BASE+44)
> +
>  /* FM Modulator class control IDs */
>
>  #define V4L2_CID_FM_TX_CLASS_BASE              (V4L2_CTRL_CLASS_FM_TX | 0x900)
>
> --
> 2.37.2
>
