Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46386624027
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiKJKmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiKJKmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:42:07 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676B0959F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:42:06 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id r76so1360988oie.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8B5mWkyToYr2vNuXzPC54pNDWrXFrhZfhiV/iv6BGu0=;
        b=JB33/r+SZkDlxPzFsPYwQ2WEOFT8yzKm5+a++KartRyp+5FRuEE+U7kNqLzXfzEYbo
         J5akQfuqHcv5g0XKBhh+nil+Caue50wOoUSo+BeHevkih4sOq+ONN+5pAxfAwXeDI3Pu
         4UOHOMS71fJUzeJxANxjK8l+ojeVTGsXZv+iY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8B5mWkyToYr2vNuXzPC54pNDWrXFrhZfhiV/iv6BGu0=;
        b=txvPLeiXkws66uHvtvw1+nI12bzgV/A7Yf02S9uaTQWtfPZLT+Stasdu7hu+DXaWz1
         tg2WA/hUOQxJLFHWEbQUBsaxESy0GoqTPkRDFMJsg15JWyg8WESk2GSkxiq9VFDUovuY
         uZCTwwSwYgS4ds+DuSLMP4BwtlA6QIsA5LHrpvntyVzmJ2zbapTjSEgtySR5GdeCVPmI
         22rjPovFLlhntFuScHBcuL4B0Yfqy8b9XLBX3F2Xn8VNrVi19e4N95/OvodbJN1//aRk
         jRRaHPUKyEHtOhnHfJabgT7bi6v+3dhjMORtK4Ln76DHmOwjn09lOGT/8dAaLLH4RZXK
         EUWg==
X-Gm-Message-State: ACrzQf2lh5gj3P6fGIu+xcYVgPglw7rDGzqWtdgojrXT2JQD3sKPTCU5
        bceWtsfupRS76g4CnRj67KYv+4Ql6/n1SbfD
X-Google-Smtp-Source: AMsMyM5kpX6CTOMBq9/hTrNMeKEaHKTiy3cH45SDPZVQM4d2mHYBvyClcitafesHFxkimFgZwf4TXw==
X-Received: by 2002:aca:3d05:0:b0:35a:113d:6357 with SMTP id k5-20020aca3d05000000b0035a113d6357mr29727952oia.264.1668076925365;
        Thu, 10 Nov 2022 02:42:05 -0800 (PST)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com. [209.85.160.45])
        by smtp.gmail.com with ESMTPSA id m8-20020a4aab88000000b00480816a5b8csm5050441oon.18.2022.11.10.02.42.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 02:42:04 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-13bef14ea06so1727940fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:42:04 -0800 (PST)
X-Received: by 2002:a05:6870:a901:b0:136:b801:e24c with SMTP id
 eq1-20020a056870a90100b00136b801e24cmr37742224oab.60.1668076924149; Thu, 10
 Nov 2022 02:42:04 -0800 (PST)
MIME-Version: 1.0
References: <20221110081259.947269-1-aichao@kylinos.cn>
In-Reply-To: <20221110081259.947269-1-aichao@kylinos.cn>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 10 Nov 2022 11:41:52 +0100
X-Gmail-Original-Message-ID: <CANiDSCs2BdgWOO=1K6k=Ow0gvrfnMj8RyoVfa5tb+00soUD=6w@mail.gmail.com>
Message-ID: <CANiDSCs2BdgWOO=1K6k=Ow0gvrfnMj8RyoVfa5tb+00soUD=6w@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Fix bandwidth error for Alcor camera
To:     Ai Chao <aichao@kylinos.cn>
Cc:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ai

Thanks for your patch

On Thu, 10 Nov 2022 at 09:15, Ai Chao <aichao@kylinos.cn> wrote:
>
> For Alcor Corp. Slave camera(1b17:6684), it support to
> output compressed video data, and it return a wrong
>  dwMaxPayloadTransferSize fields. This is a fireware issue,

s/fireware/firmware/

> but the manufacturer cannot provide a const return fields
> by the fireware. so we check the dwMaxPayloadTransferSize fields,
> if it large than 0x1000, reset dwMaxPayloadTransferSize to 1024.


Can you also provide the output of lsusb -d 1b17:6684 -v

>
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index d2eb9066e4dc..49226c3f423c 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -234,6 +234,14 @@ static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
>
>                 ctrl->dwMaxPayloadTransferSize = bandwidth;
>         }
> +
> +       /*Alcor Corp. Slave camera return wrong dwMaxPayloadTransferSize*/
> +       if ((format->flags & UVC_FMT_FLAG_COMPRESSED) &&
> +           (ctrl->dwMaxPayloadTransferSize > 0x1000) &&
> +           (le16_to_cpu(stream->dev->udev->descriptor.idVendor) == 0x1b17) &&
> +           (le16_to_cpu(stream->dev->udev->descriptor.idProduct) == 0x6684)) {
> +               ctrl->dwMaxPayloadTransferSize = 1024;
> +       }


What happens to transfersize between 1024 and 0x1000  (4096), are they ok?

Instead of le16_to_cpu(stream->dev->udev->descriptor.idVendor) ==
0x1b17) you can use usb_match_one_id

Thanks!

>  }
>
>  static size_t uvc_video_ctrl_size(struct uvc_streaming *stream)
> --
> 2.25.1
>


-- 
Ricardo Ribalda
