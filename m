Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4442B660B91
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 02:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjAGBmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 20:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjAGBmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 20:42:47 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449EE84603;
        Fri,  6 Jan 2023 17:42:46 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2F4724AE;
        Sat,  7 Jan 2023 02:42:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673055764;
        bh=e4/eoP/GXgSVuVnU4PKwIE/nMkRK+kad77/FzccPTkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tgqO+dmE6Mgrn8RCGwguBtHCyRix9GZXsH6cxzwainhR9pgBG1Is3cMHCfrJHr0lW
         YG+O5OQ9eyfGmqiWJcr+i4XjUQbQ1zdady0nBKkxMgMUq7/KhUaTXfUten+7mJ/c48
         Qv4gexVVe8dR2bBSYO6t29c1si1f3WI3wPg2V+GQ=
Date:   Sat, 7 Jan 2023 03:42:38 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>, ionut_n2001@yahoo.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: Silence memcpy() run-time false
 positive warnings
Message-ID: <Y7jODnbUqCwfwwHI@pendragon.ideasonboard.com>
References: <20230106061659.never.817-kees@kernel.org>
 <CANiDSCtTz4mpTz4RHBzNXL=yBvXNXHBZQ-HYMFegLytoScW4eA@mail.gmail.com>
 <202301061217.816FC0313D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202301061217.816FC0313D@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jan 06, 2023 at 12:19:01PM -0800, Kees Cook wrote:
> On Fri, Jan 06, 2023 at 12:43:44PM +0100, Ricardo Ribalda wrote:
> > On Fri, 6 Jan 2023 at 07:19, Kees Cook wrote:
> > >
> > > The memcpy() in uvc_video_decode_meta() intentionally copies across the
> > > length and flags members and into the trailing buf flexible array.
> > > Split the copy so that the compiler can better reason about (the lack
> > > of) buffer overflows here. Avoid the run-time false positive warning:
> > >
> > >   memcpy: detected field-spanning write (size 12) of single field "&meta->length" at drivers/media/usb/uvc/uvc_video.c:1355 (size 1)
> > >
> > > Additionally fix a typo in the documentation for struct uvc_meta_buf.
> > >
> > > Reported-by: ionut_n2001@yahoo.com
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216810
> > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > > Cc: linux-media@vger.kernel.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  drivers/media/usb/uvc/uvc_video.c | 4 +++-
> > >  include/uapi/linux/uvcvideo.h     | 2 +-
> > >  2 files changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > > index d2eb9066e4dc..b67347ab4181 100644
> > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > @@ -1352,7 +1352,9 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
> > >         if (has_scr)
> > >                 memcpy(stream->clock.last_scr, scr, 6);
> > >
> > > -       memcpy(&meta->length, mem, length);
> > > +       meta->length = mem[0];
> > > +       meta->flags  = mem[1];
> > > +       memcpy(meta->buf, &mem[2], length - 2);
> > >         meta_buf->bytesused += length + sizeof(meta->ns) + sizeof(meta->sof);
> > >
> > >         uvc_dbg(stream->dev, FRAME,
> > > diff --git a/include/uapi/linux/uvcvideo.h b/include/uapi/linux/uvcvideo.h
> > > index 8288137387c0..a9d0a64007ba 100644
> > > --- a/include/uapi/linux/uvcvideo.h
> > > +++ b/include/uapi/linux/uvcvideo.h
> > > @@ -86,7 +86,7 @@ struct uvc_xu_control_query {
> > >   * struct. The first two fields are added by the driver, they can be used for
> > >   * clock synchronisation. The rest is an exact copy of a UVC payload header.
> > >   * Only complete objects with complete buffers are included. Therefore it's
> > > - * always sizeof(meta->ts) + sizeof(meta->sof) + meta->length bytes large.
> > > + * always sizeof(meta->ns) + sizeof(meta->sof) + meta->length bytes large.
> > >   */
> > >  struct uvc_meta_buf {
> > >         __u64 ns;
> > [...]
> >
> > Would it make more sense to replace *mem with a structure/union. Something like:
> > https://patchwork.linuxtv.org/project/linux-media/patch/20221214-uvc-status-alloc-v4-0-f8e3e2994ebd@chromium.org/
> 
> I wasn't sure -- it seemed like this routine was doing the serializing
> into a struct already and an additional struct overlay wasn't going to
> improve readability. But I can certainly do that if it's preferred!

I'm not sure to see how using an additional struct or union would help.
We can't use struct assignment as the data may be unaligned, so memcpy()
is required. The issue isn't with the source operand of the memcpy() but
with the destination operand. Ricardo, if I'm missing something, please
submit an alternative patch to explain what you meant.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
