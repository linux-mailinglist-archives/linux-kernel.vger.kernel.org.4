Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80BD65EACC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjAEMiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjAEMh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:37:58 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4124E409
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:37:57 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so1919537pjd.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 04:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CxPAWPdLx+AnYDGFecYmtGAl8s4Zh03V0RGOIrw0ZtU=;
        b=bgNiT8l+AWP2NRTl3vL/pq+86ILh2xabfb8ijK9XbEU0gp5PE4RBQk5l11i5HuYK9P
         36YyMLlLxTu6q6luLfvpI5h53x7FLoJt+v6mte0L+Qmst5YEue8ZTdJ0806Rm0wz/JRs
         Qgv52Lv9htyBXg/jghsfZ1beJ34JkSH1D52ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CxPAWPdLx+AnYDGFecYmtGAl8s4Zh03V0RGOIrw0ZtU=;
        b=Cx/kPbJgdTlNoDiekAk/WxMChpEcu8KY/4w7nNwYnWT9sQsXSsCsk3TJZ4s1JkxDlc
         W0q2LVxvJjeB5uk4hBI3478w3NsV+3wBwlpoYwX0UWX5PTBJYiV3fLtzZNVjUaC4CMJ3
         T4dxhLyCcQ/EvrXy4n0kny6xh29NXg62PDe9MGqdsIBVtToEcqnTo/dECNfmLaSFmGNX
         qSXkWS9SniMJaKt94R1kpjITQVLfIeTy9FIGUO5i/qTJnmQ/oP2RDZoZb1KvnKcNLLyj
         VdxWt7R6VxLr70dEQLpzTx0pILZ9zT/vuDHT3mk7MOgEX0ykW1ZpW5grUBFZBV76OA2I
         0l4A==
X-Gm-Message-State: AFqh2koirCawCgv+iLeCAuhsJ47sMZJtG0tTfnQbexZsTn37QuVzXTqV
        S2xunYkD0PdLm0Fb4ukSEp8qj4a2PmQ82YK9Glc=
X-Google-Smtp-Source: AMrXdXvqt+CArgMj4CD4dL9iOCxLiZml8mECdxeSLVym6vWJGdbQD+va27oMqlOjhbKxA9eHhPXMgQ==
X-Received: by 2002:a17:903:3289:b0:192:8c20:444c with SMTP id jh9-20020a170903328900b001928c20444cmr32675090plb.12.1672922276315;
        Thu, 05 Jan 2023 04:37:56 -0800 (PST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com. [209.85.214.178])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b001871acf245csm25978213plg.37.2023.01.05.04.37.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 04:37:55 -0800 (PST)
Received: by mail-pl1-f178.google.com with SMTP id b2so39201835pld.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 04:37:55 -0800 (PST)
X-Received: by 2002:a17:90a:c984:b0:219:8132:70db with SMTP id
 w4-20020a17090ac98400b00219813270dbmr4884596pjt.183.1672922274966; Thu, 05
 Jan 2023 04:37:54 -0800 (PST)
MIME-Version: 1.0
References: <20230105-uvc-gcc5-v1-0-8550de720e82@chromium.org> <20230105-uvc-gcc5-v1-6-8550de720e82@chromium.org>
In-Reply-To: <20230105-uvc-gcc5-v1-6-8550de720e82@chromium.org>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 5 Jan 2023 13:37:43 +0100
X-Gmail-Original-Message-ID: <CANiDSCuA-3Yedrtx-hBHUDCsahQCy898zONzOM=oJWQo0zndCA@mail.gmail.com>
Message-ID: <CANiDSCuA-3Yedrtx-hBHUDCsahQCy898zONzOM=oJWQo0zndCA@mail.gmail.com>
Subject: Re: [PATCH 6/6] media: uvcvideo: Fix power line control for Lenovo
 Integrated Camera
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yunke Cao <yunkec@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJECT_DRUG_GAP_L autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On Thu, 5 Jan 2023 at 13:33, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> The device does not implement the power line control correctly. It is
> a UVC 1.5 device, but implements the PLC control as a UVC 1.1 device.
>
> Add the corresponding control mapping override.
>
> Bus 003 Device 002: ID 30c9:0093 Lenovo Integrated Camera
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.01
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0        64
>   idVendor           0x30c9
>   idProduct          0x0093
>   bcdDevice            0.07
>   iManufacturer           3 Lenovo
>   iProduct                1 Integrated Camera
>   iSerial                 2 8SSC21J75356V1SR2830069
>   bNumConfigurations      1
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
I deleted the wrong singed-off-by, This should say
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

If I need to send a new version it will be fixed accordingly.

Thanks!
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c   |  2 +-
>  drivers/media/usb/uvc/uvc_driver.c | 16 ++++++++++++++++
>  drivers/media/usb/uvc/uvcvideo.h   |  1 +
>  3 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index f559a1ac6e3c..28ef9b2024a1 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -736,7 +736,7 @@ const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
>                                   V4L2_CID_POWER_LINE_FREQUENCY_50HZ),
>  };
>
> -static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11 = {
> +const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11 = {
>         .id             = V4L2_CID_POWER_LINE_FREQUENCY,
>         .entity         = UVC_GUID_UVC_PROCESSING,
>         .selector       = UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 37d2b08bc8b2..57c948d47bbf 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2385,6 +2385,13 @@ static const struct uvc_device_info uvc_ctrl_power_line_limited = {
>         },
>  };
>
> +static const struct uvc_device_info uvc_ctrl_power_line_uvc11 = {
> +       .mappings = (const struct uvc_control_mapping *[]) {
> +               &uvc_ctrl_power_line_mapping_uvc11,
> +               NULL, /* Sentinel */
> +       },
> +};
> +
>  static const struct uvc_device_info uvc_quirk_probe_minmax = {
>         .quirks = UVC_QUIRK_PROBE_MINMAX,
>  };
> @@ -2964,6 +2971,15 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_FORCE_BPP) },
> +       /* Lenovo Integrated Camera */
> +       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +                               | USB_DEVICE_ID_MATCH_INT_INFO,
> +         .idVendor             = 0x30c9,
> +         .idProduct            = 0x0093,
> +         .bInterfaceClass      = USB_CLASS_VIDEO,
> +         .bInterfaceSubClass   = 1,
> +         .bInterfaceProtocol   = UVC_PC_PROTOCOL_15,
> +         .driver_info          = (kernel_ulong_t)&uvc_ctrl_power_line_uvc11 },
>         /* Sonix Technology USB 2.0 Camera */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 1b2d9f327583..31c33eb0edf5 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -748,6 +748,7 @@ void uvc_status_stop(struct uvc_device *dev);
>
>  /* Controls */
>  extern const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited;
> +extern const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11;
>  extern const struct v4l2_subscribed_event_ops uvc_ctrl_sub_ev_ops;
>
>  int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>
> --
> 2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae



-- 
Ricardo Ribalda
