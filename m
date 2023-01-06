Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB7E66082C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbjAFUUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbjAFUTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:19:09 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F233C737
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 12:19:03 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso2912240pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 12:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AGLGQcWh7fxTpjGo3tS7tRpH8cdVI9NZGacuJMxc3aM=;
        b=J9xFPANkCtLv9kwtnvnZCou4HRBDEo4c9C3yNzimS63v01YOjey8j/jy+W+9spWOfP
         Hb32XPyzMkYx0h6JUNMnQ/6b8C/Uza4b+Vh6XP+suOFMvmj1xOQKuXkOEJNQcEEL0EM/
         jxcndy3ffaHbTh+Gu0foYs47OsMEs6VWN0Bqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGLGQcWh7fxTpjGo3tS7tRpH8cdVI9NZGacuJMxc3aM=;
        b=y954SBcbVZQZz1VUQiIz+R7jtaXiInmCnfLNmTwEjBg2BUcSWgVJmAhe01IOxk8P3y
         2S8bTdokftfN/dvQzyGHEY0Q3qo+x9Ss+uig5H18HrCCfZH4oCw/zVvk37Xjf1hHKXYL
         Cba1blcBl8L1bG4zClMUD/Gkd/cTE7eVnLVewA/Q+QjqrWESQwYWE2R6d3RdYQq2SZr4
         mc4GGxZguAupuhhn500Mgu+6K2G6hXMoIVqgF30DzZ4Bm9j+jSnf+XxJ44v2xnWcaj5Y
         XigxaJxRBIRl0ts5CPEW3HEWAclRqYjgaZNb/uKXrNmxKfMaCYSV1mvdbvHr3+C74HBD
         z4Xw==
X-Gm-Message-State: AFqh2krW3SHfhTDJ0OZw97GRuq6A4WeeXeOyO/t9gnAwJBUIbOSHqOQ9
        NuA7LxNlsD2CtK5MBiiw5PQjM25ZlUmde6LB
X-Google-Smtp-Source: AMrXdXudlVKAU4UX6Qzu0Go3bkXbaS/ERmoDwzPoi9msar5Xeo82q3RaDfeX+3INk0Ve1FfNZ7uYCA==
X-Received: by 2002:a17:902:ec01:b0:192:b0a0:789b with SMTP id l1-20020a170902ec0100b00192b0a0789bmr27137344pld.2.1673036343274;
        Fri, 06 Jan 2023 12:19:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b14-20020a1709027e0e00b00193132018ecsm970899plm.170.2023.01.06.12.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:19:02 -0800 (PST)
Date:   Fri, 6 Jan 2023 12:19:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        ionut_n2001@yahoo.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: Silence memcpy() run-time false
 positive warnings
Message-ID: <202301061217.816FC0313D@keescook>
References: <20230106061659.never.817-kees@kernel.org>
 <CANiDSCtTz4mpTz4RHBzNXL=yBvXNXHBZQ-HYMFegLytoScW4eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCtTz4mpTz4RHBzNXL=yBvXNXHBZQ-HYMFegLytoScW4eA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 12:43:44PM +0100, Ricardo Ribalda wrote:
> On Fri, 6 Jan 2023 at 07:19, Kees Cook <keescook@chromium.org> wrote:
> >
> > The memcpy() in uvc_video_decode_meta() intentionally copies across the
> > length and flags members and into the trailing buf flexible array.
> > Split the copy so that the compiler can better reason about (the lack
> > of) buffer overflows here. Avoid the run-time false positive warning:
> >
> >   memcpy: detected field-spanning write (size 12) of single field "&meta->length" at drivers/media/usb/uvc/uvc_video.c:1355 (size 1)
> >
> > Additionally fix a typo in the documentation for struct uvc_meta_buf.
> >
> > Reported-by: ionut_n2001@yahoo.com
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216810
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > Cc: linux-media@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_video.c | 4 +++-
> >  include/uapi/linux/uvcvideo.h     | 2 +-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index d2eb9066e4dc..b67347ab4181 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -1352,7 +1352,9 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
> >         if (has_scr)
> >                 memcpy(stream->clock.last_scr, scr, 6);
> >
> > -       memcpy(&meta->length, mem, length);
> > +       meta->length = mem[0];
> > +       meta->flags  = mem[1];
> > +       memcpy(meta->buf, &mem[2], length - 2);
> >         meta_buf->bytesused += length + sizeof(meta->ns) + sizeof(meta->sof);
> >
> >         uvc_dbg(stream->dev, FRAME,
> > diff --git a/include/uapi/linux/uvcvideo.h b/include/uapi/linux/uvcvideo.h
> > index 8288137387c0..a9d0a64007ba 100644
> > --- a/include/uapi/linux/uvcvideo.h
> > +++ b/include/uapi/linux/uvcvideo.h
> > @@ -86,7 +86,7 @@ struct uvc_xu_control_query {
> >   * struct. The first two fields are added by the driver, they can be used for
> >   * clock synchronisation. The rest is an exact copy of a UVC payload header.
> >   * Only complete objects with complete buffers are included. Therefore it's
> > - * always sizeof(meta->ts) + sizeof(meta->sof) + meta->length bytes large.
> > + * always sizeof(meta->ns) + sizeof(meta->sof) + meta->length bytes large.
> >   */
> >  struct uvc_meta_buf {
> >         __u64 ns;
> [...]
>
> Would it make more sense to replace *mem with a structure/union. Something like:
> https://patchwork.linuxtv.org/project/linux-media/patch/20221214-uvc-status-alloc-v4-0-f8e3e2994ebd@chromium.org/

I wasn't sure -- it seemed like this routine was doing the serializing
into a struct already and an additional struct overlay wasn't going to
improve readability. But I can certainly do that if it's preferred!

-Kees

-- 
Kees Cook
