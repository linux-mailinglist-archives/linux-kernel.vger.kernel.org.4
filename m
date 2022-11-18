Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AFB62EF07
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241099AbiKRIQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbiKRIP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:15:58 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296F682232
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:15:57 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id q21so3316840iod.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KwPAc197/GRXQfFzKw4N05NeqqdYUbMm9HtIWR5I0BY=;
        b=VNkG8mqW926v7YUcFCMicxULL4SvQe5s1XW0IpftRviYFQ3FE6318dd0aLRSLvLLiq
         RrzR7bj0aj1XTsZOXZi8ZFXS2Ypu0o8A5+XbC2M3YTz55lBn7mV+C4FGjXMUYLzARkAW
         CDT2WLPtUis6xgbTZ5b6IjfgbQIdneg5BvVeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwPAc197/GRXQfFzKw4N05NeqqdYUbMm9HtIWR5I0BY=;
        b=gYc5v4URMWLgqRikvSOmmDF4EvdB6+DRipwOGfCH2wHk9PERiUpwwsSYxuUV+XH2mS
         fUV9hpfOUJ2HR9HarfPPARzujYVb4iA/numMM3S4VmbfjlklPNx6XOE04n+jboLWdI+C
         e17hb1nzvYlrnNLNuza9JzHp2mkYoajSKoJt6Z/ClufwqdKuN/nVSkO4y18PTIfXgAak
         nOnMT9xBVW78d8v/LgIrkLvbEDbRkBxLRc+1pjmnj/jT6mIGFD7E3IEVLdoiN52ihHna
         xF6sTQ+wt7x8Wk0ztuckBpYTM3nFucTqXRXgtu/sK2rqEPKi64nvDc8Ssuwpo2V3FanP
         /ZDQ==
X-Gm-Message-State: ANoB5pnLXVBGMMMVl3mpbRxQ7wZgtVsDJP8zZ9pgMAVgguYK3x3B/PX0
        BVF7K3VlSqD08JUbyHMqFuGj6wdvmJm1vQ==
X-Google-Smtp-Source: AA0mqf6R3+eoYQ4haSuPTLzO//MQK4mbIZ80yWAZVYhE2CgKm4TgUHCVm1g22pBw/+aGvznWJ8Jl0A==
X-Received: by 2002:a05:6638:e8e:b0:365:ca83:bafb with SMTP id p14-20020a0566380e8e00b00365ca83bafbmr2850431jas.272.1668759356276;
        Fri, 18 Nov 2022 00:15:56 -0800 (PST)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id i13-20020a02b68d000000b003638d00b759sm1032181jam.54.2022.11.18.00.15.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 00:15:54 -0800 (PST)
Received: by mail-il1-f177.google.com with SMTP id z9so2188411ilu.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:15:54 -0800 (PST)
X-Received: by 2002:a92:ca89:0:b0:302:385e:eeb4 with SMTP id
 t9-20020a92ca89000000b00302385eeeb4mr2862683ilo.66.1668759353955; Fri, 18 Nov
 2022 00:15:53 -0800 (PST)
MIME-Version: 1.0
References: <20221118022302.112121-1-aichao@kylinos.cn>
In-Reply-To: <20221118022302.112121-1-aichao@kylinos.cn>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 18 Nov 2022 09:15:43 +0100
X-Gmail-Original-Message-ID: <CANiDSCs746jMSfzPJN9SzUfU-1xhRqG7G2Z9mVF_h=zThNoPxA@mail.gmail.com>
Message-ID: <CANiDSCs746jMSfzPJN9SzUfU-1xhRqG7G2Z9mVF_h=zThNoPxA@mail.gmail.com>
Subject: Re: [PATCH v3] media: uvcvideo: Fix bandwidth error for Alcor camera
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

Thanks for your patch!

On Fri, 18 Nov 2022 at 03:23, Ai Chao <aichao@kylinos.cn> wrote:
>
> For Alcor Corp. Slave camera(1b17:6684/2017:0011), it support to
> output compressed video data, and it return a wrong
> dwMaxPayloadTransferSize fields. This is a fireware issue,
s/fireware/firmware/
> but the manufacturer cannot provide a const return fields
> by the fireware. For some device, device requested 2752512
>  B/frame bandwidth. For some device, device requested 3072
>  B/frame bandwidth. so we check the dwMaxPayloadTransferSize
>  fields,if it large than 0x1000, reset dwMaxPayloadTransferSize
> to 1024, and the camera preview normally.

3072 is smaller than 0x1000.

It is ok to have values between 1024 and 0x1000 (4096) ?

Thanks

>
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
>
> ---
> change for v3
> - Add VID/PID 2017:0011
>
> change for v2
> - Used usb_match_one_id to check VID and PID
> ---
> ---
>  drivers/media/usb/uvc/uvc_video.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index d2eb9066e4dc..1260800ef8bd 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -135,6 +135,10 @@ static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
>         static const struct usb_device_id elgato_cam_link_4k = {
>                 USB_DEVICE(0x0fd9, 0x0066)
>         };
> +       static const struct usb_device_id alcor_corp_slave_cam = {
> +               USB_DEVICE(0x1b17, 0x6684),
> +               USB_DEVICE(0x2017, 0x0011),
> +       };
>         struct uvc_format *format = NULL;
>         struct uvc_frame *frame = NULL;
>         unsigned int i;
> @@ -234,6 +238,13 @@ static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
>
>                 ctrl->dwMaxPayloadTransferSize = bandwidth;
>         }
> +
> +       /* Alcor Corp. Slave camera return wrong dwMaxPayloadTransferSize */
> +       if ((format->flags & UVC_FMT_FLAG_COMPRESSED) &&
> +           (ctrl->dwMaxPayloadTransferSize > 0x1000) &&
> +            usb_match_one_id(stream->dev->intf, &alcor_corp_slave_cam)) {
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
