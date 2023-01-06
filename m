Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB86C65FFAF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 12:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjAFLoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjAFLn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:43:59 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3FA69B2B
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 03:43:58 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id c8-20020a17090a4d0800b00225c3614161so4930213pjg.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 03:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=04eEBcfPF9rPWJ6oe8vSrIbuReCNM+F3t+uhS5IgjAI=;
        b=eTbHhoFLjQJuPbwPLx+3u4gPgft2Pc5mtQeE0YFtzDmI1Ffve96+xCYRtzTIcYRbie
         z08AL6l6eADTEDx42za6p3tIDuC+kO6hzPIxxF2h/FlDkJrbrrYxyHb6Akm2bw4S5zUL
         zRyxdg74QrapIdR150Zp6h2SRd1jot0uGWzrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04eEBcfPF9rPWJ6oe8vSrIbuReCNM+F3t+uhS5IgjAI=;
        b=n7/ywKwkFy5bEgtJWteIaF9BBPg6wP0hUpM1VEHKGqsl8+euTV41CFPblJp90JJAlr
         T4GAa3v4JJ7uHHzpqR5oBQUF1yax5wsCQ+YANjXBhglCuIMif0JuBeUWyBAIinBGFVJC
         6yNxCzSZdUIKRox+sw9zpZvBTaFpvW0bARC9B89NuhFCJnsJ2uDQg68osqfRsya98E10
         KJwMmP09sp5DR0PQJm7lrqkKB8RHKJiNlH8TTuZgBb2keqlco3TbV5dJDlirK63RmuiZ
         mrAvBmAyYkOZxz+i8tlPgJazJI2T1Qj8T9y/f0GY/V7efegCWJ+yMDYdkX9FSqAL/vve
         Gfbg==
X-Gm-Message-State: AFqh2kqa4FiaV9kACjHQ9Z9NW3vNj/RcYGVng0AW/nCUN90KUcVnpBCR
        Tvle+JsXUhI07cBnjEAxrhRooyt5/lcJeStTfzI=
X-Google-Smtp-Source: AMrXdXt4ExVot7Fs59JORt/2TP4UlmAWlVwHTp+xTuA7xI6XZYF9s7QMZyBpFosXVeUvgOK9JWu4eQ==
X-Received: by 2002:a05:6a20:6f87:b0:b5:46fa:24e8 with SMTP id gv7-20020a056a206f8700b000b546fa24e8mr5337529pzb.38.1673005438176;
        Fri, 06 Jan 2023 03:43:58 -0800 (PST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com. [209.85.214.171])
        by smtp.gmail.com with ESMTPSA id z19-20020aa79593000000b00582388bd80csm944419pfj.83.2023.01.06.03.43.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 03:43:57 -0800 (PST)
Received: by mail-pl1-f171.google.com with SMTP id p24so1399647plw.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 03:43:56 -0800 (PST)
X-Received: by 2002:a17:902:934b:b0:191:2a9b:ec94 with SMTP id
 g11-20020a170902934b00b001912a9bec94mr3686097plp.8.1673005436272; Fri, 06 Jan
 2023 03:43:56 -0800 (PST)
MIME-Version: 1.0
References: <20230106061659.never.817-kees@kernel.org>
In-Reply-To: <20230106061659.never.817-kees@kernel.org>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 6 Jan 2023 12:43:44 +0100
X-Gmail-Original-Message-ID: <CANiDSCtTz4mpTz4RHBzNXL=yBvXNXHBZQ-HYMFegLytoScW4eA@mail.gmail.com>
Message-ID: <CANiDSCtTz4mpTz4RHBzNXL=yBvXNXHBZQ-HYMFegLytoScW4eA@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Silence memcpy() run-time false positive warnings
To:     Kees Cook <keescook@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        ionut_n2001@yahoo.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

Hi Kees

Thanks for the patch

Would it make more sense to replace *mem with a structure/union. Something like:
https://patchwork.linuxtv.org/project/linux-media/patch/20221214-uvc-status-alloc-v4-0-f8e3e2994ebd@chromium.org/

Regards!

On Fri, 6 Jan 2023 at 07:19, Kees Cook <keescook@chromium.org> wrote:
>
> The memcpy() in uvc_video_decode_meta() intentionally copies across the
> length and flags members and into the trailing buf flexible array.
> Split the copy so that the compiler can better reason about (the lack
> of) buffer overflows here. Avoid the run-time false positive warning:
>
>   memcpy: detected field-spanning write (size 12) of single field "&meta->length" at drivers/media/usb/uvc/uvc_video.c:1355 (size 1)
>
> Additionally fix a typo in the documentation for struct uvc_meta_buf.
>
> Reported-by: ionut_n2001@yahoo.com
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216810
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 4 +++-
>  include/uapi/linux/uvcvideo.h     | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index d2eb9066e4dc..b67347ab4181 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -1352,7 +1352,9 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
>         if (has_scr)
>                 memcpy(stream->clock.last_scr, scr, 6);
>
> -       memcpy(&meta->length, mem, length);
> +       meta->length = mem[0];
> +       meta->flags  = mem[1];
> +       memcpy(meta->buf, &mem[2], length - 2);
>         meta_buf->bytesused += length + sizeof(meta->ns) + sizeof(meta->sof);
>
>         uvc_dbg(stream->dev, FRAME,
> diff --git a/include/uapi/linux/uvcvideo.h b/include/uapi/linux/uvcvideo.h
> index 8288137387c0..a9d0a64007ba 100644
> --- a/include/uapi/linux/uvcvideo.h
> +++ b/include/uapi/linux/uvcvideo.h
> @@ -86,7 +86,7 @@ struct uvc_xu_control_query {
>   * struct. The first two fields are added by the driver, they can be used for
>   * clock synchronisation. The rest is an exact copy of a UVC payload header.
>   * Only complete objects with complete buffers are included. Therefore it's
> - * always sizeof(meta->ts) + sizeof(meta->sof) + meta->length bytes large.
> + * always sizeof(meta->ns) + sizeof(meta->sof) + meta->length bytes large.
>   */
>  struct uvc_meta_buf {
>         __u64 ns;
> --
> 2.34.1
>


-- 
Ricardo Ribalda
