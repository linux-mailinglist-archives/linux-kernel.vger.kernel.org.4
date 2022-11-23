Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAB5635236
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbiKWIUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbiKWIUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:20:08 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121C0C67CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:20:07 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id c7so12643166iof.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c6XRhHsjuFYmFz1yvcQmws2gxItyrK+zhuXTxyaOjn8=;
        b=gSoTf+STpbc5D7fgHbxmENe5Sw/k2nZZ8tBPBr/6h75sLpLVg7ajqbUbP3gQbg7QNl
         cGh+7ovg5aOCtWg1/tRvOHe1ZsFwrb3053VwO/TI/GooYg0IqJItvp5Dxr4MMH798juF
         Dt5FMeeAPqayNpaKhsx7MawQ4YL026aF9RPrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c6XRhHsjuFYmFz1yvcQmws2gxItyrK+zhuXTxyaOjn8=;
        b=TIoqiFw77f0H6jMCEqHNWcsADeO6Gd1CXxxUkfONlaqKeD/TwxKiQoaVqt6rqz8nz8
         RVoHU8RfcJbhfrMEmwem2xOW/H+Vl3dN4CwmOmZAyYOdFvfRthWR3D3eNCpYlPy4mjDu
         mg3Yrd17sLbGrKXYbfHFwaUvxCsGbyYeGTFJLbNGlPY7Va18//x4gzK5YqBLB1IS2O+v
         Ni8RfFq8vyAZBNWC+7muCgPjoGeVaUenoYNSUvJiov31Mw9u+M+zIWV8hM1/sU1uZQgI
         yuThAP32HiA+rQ7+ItZIWgecLcYfVjAB+4PYilwCl523jseGYekUMxP8nYMXgApuXwFM
         CrpA==
X-Gm-Message-State: ANoB5pnwDXL/iH7YIo9tsFm9pIkghVneJXhNB/MSdrIZFYo29AD8pjyk
        mcSCGDz1l2jOJexMSe57GXLhdJsdZa//ng==
X-Google-Smtp-Source: AA0mqf7Qa4L1aJnRgZZR4RMbd4T+5TdXfBHKRuARI0Ep3gkvpdXq4WAlIg/BDtT8/smZT8VGbzBg7w==
X-Received: by 2002:a02:cba6:0:b0:375:a360:a130 with SMTP id v6-20020a02cba6000000b00375a360a130mr12623531jap.307.1669191606299;
        Wed, 23 Nov 2022 00:20:06 -0800 (PST)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id z6-20020a92cb86000000b003007aba03c0sm5450357ilo.66.2022.11.23.00.20.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 00:20:05 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id n188so12670962iof.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:20:04 -0800 (PST)
X-Received: by 2002:a5e:c809:0:b0:6cf:8cf0:91ac with SMTP id
 y9-20020a5ec809000000b006cf8cf091acmr3586128iol.186.1669191604023; Wed, 23
 Nov 2022 00:20:04 -0800 (PST)
MIME-Version: 1.0
References: <20221122084833.1241078-1-aichao@kylinos.cn>
In-Reply-To: <20221122084833.1241078-1-aichao@kylinos.cn>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 23 Nov 2022 09:19:51 +0100
X-Gmail-Original-Message-ID: <CANiDSCv8wSJ3+sF33ffikcBeYQ-ExabWe6nofQWj_-HmuCiTHA@mail.gmail.com>
Message-ID: <CANiDSCv8wSJ3+sF33ffikcBeYQ-ExabWe6nofQWj_-HmuCiTHA@mail.gmail.com>
Subject: Re: [PATCH v4] media: uvcvideo: Fix bandwidth error for Alcor camera
To:     Ai Chao <aichao@kylinos.cn>
Cc:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ai

On Tue, 22 Nov 2022 at 09:49, Ai Chao <aichao@kylinos.cn> wrote:
>
> For Alcor Corp. Slave camera(1b17:6684/2017:0011), it support to output
>  compressed video data, and it return a wrong dwMaxPayloadTransferSize
>  fields. This is a fireware issue, but the manufacturer cannot provide
>  a const return fieldsby the fireware. For some device, it requested
nit:s/fireware/firmware/
>  2752512 B/frame bandwidth. For normally device, it requested 3072 or 1024
>  B/frame bandwidth. so we check the dwMaxPayloadTransferSize fields,if it
>  large than 0x1000, reset dwMaxPayloadTransferSize to 1024, and the camera
>  preview normally.
>
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
>
> ---
> change for v4
> - Change usb_match_one_id to usb_match_id
> - Modify the discription
>
> change for v3
> - Add VID/PID 2017:0011
>
> change for v2
> - Used usb_match_one_id to check VID and PID
> ---
> ---
>  drivers/media/usb/uvc/uvc_video.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index d2eb9066e4dc..75bdd71d0e5a 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -135,6 +135,11 @@ static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
>         static const struct usb_device_id elgato_cam_link_4k = {
>                 USB_DEVICE(0x0fd9, 0x0066)
>         };
> +       static const struct usb_device_id alcor_corp_slave_cam[] = {
> +               { USB_DEVICE(0x2017, 0x0011) },
> +               { USB_DEVICE(0x1b17, 0x6684) },
> +               { }
> +       };
>         struct uvc_format *format = NULL;
>         struct uvc_frame *frame = NULL;
>         unsigned int i;
> @@ -234,6 +239,13 @@ static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
>
>                 ctrl->dwMaxPayloadTransferSize = bandwidth;
>         }
> +
> +       /* Alcor Corp. Slave camera return wrong dwMaxPayloadTransferSize */
> +       if ((format->flags & UVC_FMT_FLAG_COMPRESSED) &&
> +           (ctrl->dwMaxPayloadTransferSize > 0x1000) &&
> +           usb_match_id(stream->dev->intf, alcor_corp_slave_cam)) {
> +               ctrl->dwMaxPayloadTransferSize = 1024;
> +       }
>  }
>
>  static size_t uvc_video_ctrl_size(struct uvc_streaming *stream)
> --
> 2.25.1
>


-- 
Ricardo Ribalda
