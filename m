Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD7E661FBC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjAIINz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjAIINx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:13:53 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D84721B1
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:13:52 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso6854103pjl.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 00:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n/+kTm6b20BoT7pid+/6F2tOXS0uOA39QAnXddRvFQE=;
        b=WtlF95Tke6ZhUGLvH9NxyenOUI4a9e69omRMVYQ+xsCRc2QMkBmobFnt53kBc7hNsd
         +uAb1gdtsaAbh0xjAK4f8kCtF/kYW2tu0f86agnDvJcwfMKa/s1Ohd9AWjbQLC5Z/zZA
         gaVYfz+2y8psKbPLl25hY0H4fs1W7Z+Q6pfGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/+kTm6b20BoT7pid+/6F2tOXS0uOA39QAnXddRvFQE=;
        b=gJYDqKQPiXs/SU51Eh++3RcC1vjZQt6M4fK8HLN5IQbWOp+aSUVXWl9pbba9ac0yjP
         hoX5pkGODLqPgyhtcXhvo7TCpbg/sjYLItlLz+P6jF3CxwAt5IPsmhCWPwvEjxPMdUvb
         BzdqzL4rjeJUCoA85UEufQStUjDVaRtQgmrJWbyIm7Rdo3jhkbNW33aGDKghiWWRhLEa
         ene5EBY8lOgzcCcnibb1gqS0inA5aoaf6ZADdipTkPqIgOGzW8Ru3Bx+mc+EvgpV3kAc
         cxFC3Cdm6kVBD76KCSuvC2N+fG1oauxUH3K0ALA+vnml5L7wSuLnaLxinB1efNUawjsf
         6mKQ==
X-Gm-Message-State: AFqh2kpfd3RhCkl+enTGQM2rIJHnQligve0TIIIfa1kTxCitUVlAtJFS
        0z4ArY8klZtMFjEqvF7J4PAK8KNcKkbLouW2SBI=
X-Google-Smtp-Source: AMrXdXsTBnVE8hNDtWfs5/3FEounQuwhWFBoW8H1LQ8YmbqfAO09tohfCObLfe8EQ200TaL+S82MPg==
X-Received: by 2002:a17:903:40cd:b0:180:f32c:7501 with SMTP id t13-20020a17090340cd00b00180f32c7501mr70050307pld.0.1673252031643;
        Mon, 09 Jan 2023 00:13:51 -0800 (PST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com. [209.85.215.172])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902c3c100b001891ea4d133sm5502754plj.12.2023.01.09.00.13.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 00:13:50 -0800 (PST)
Received: by mail-pg1-f172.google.com with SMTP id d10so5309192pgm.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 00:13:50 -0800 (PST)
X-Received: by 2002:a62:1501:0:b0:589:8362:c7ce with SMTP id
 1-20020a621501000000b005898362c7cemr58561pfv.21.1673252029904; Mon, 09 Jan
 2023 00:13:49 -0800 (PST)
MIME-Version: 1.0
References: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
 <20220920-resend-hwtimestamp-v2-8-0d7978a817cc@chromium.org>
 <Y6761ScB9FgMC6zb@pendragon.ideasonboard.com> <CANiDSCtsk+oejXSDGo_DStocHOEsk4=oYOu6KccQdckfBXbj-g@mail.gmail.com>
 <Y7jCydc6mFvZRQof@pendragon.ideasonboard.com>
In-Reply-To: <Y7jCydc6mFvZRQof@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 9 Jan 2023 09:13:38 +0100
X-Gmail-Original-Message-ID: <CANiDSCtyAbqyrE6+R16DeAqghSbu=inkYLR_4VsOCJqUO-B5jw@mail.gmail.com>
Message-ID: <CANiDSCtyAbqyrE6+R16DeAqghSbu=inkYLR_4VsOCJqUO-B5jw@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 8/8] media: uvcvideo: Fix hw timestampt handling
 for slow FPS
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "hn.chen" <hn.chen@sunplusit.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On Sat, 7 Jan 2023 at 01:54, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> On Wed, Jan 04, 2023 at 12:34:34AM +0100, Ricardo Ribalda wrote:
> > On Fri, 30 Dec 2022 at 15:51, Laurent Pinchart wrote:
> > > On Fri, Dec 02, 2022 at 06:02:48PM +0100, Ricardo Ribalda wrote:
> > > > In UVC 1.5, when working with FPS under 32, there is a chance that the
> > > > circular buffer contains two dev_sof overflows,
> > >
> > > An explanation of why this is the case would be good in the commit
> > > message. Also, by overflow, are you talking about the SOF counter
> > > rolling over ?
> > >
> > > > but the clock interpolator
> > > > is only capable of handle a single overflow.
> > > >
> > > > Remove all the samples from the circular buffer that are two overflows
> > > > old.
> > >
> > > I would rather support multiple roll-over in the clock interpolator.
> > > Dropping older sampls will lead to less predictable behaviour and harder
> > > to debug issues.
> >
> > Multiple roll-over would not necessarily mean better data here. We are
> > deleting data that is more than 1 second away, and our resolution is
> > 1kHz, which means that we have enough data to provide good results, we
> > have measured that 250msec already provides good data.
>
> Do we ? We may get one SCR per frame only. With low frame rates (say,
> 5fps for instance, which is fairly common, I have 2092 out of 16475
> frame descriptors supporting that format in my database of UVC
> descriptors), we'll have 4 to 5 data points.

In the current algorithm, the accuracy is not given by the number of
samples, but the time between the first and the last sample.
Every sample has an average error error of (1/clkrate)/2, but the
errors do not add up.
This is: 2 samples at 2 fps is as accurate as 4 samples at 4 fps.

>
> > From a logical point of view, this patch is fixing a bug, not adding a
> > new feature, and it has been validated. I would rather add multi
> > roll-over as a follow-up patch, or maybe suggest implementing it in
> > userspace ;).
>
> Would you give the latter a try ? :-)

Aren't these two orthogonal problems? The kernel today provides an API
and that API is broken for fps < 32, which is a common fps.
Even if we re-implement the hwtimestamp in user space we need to fix
it in the kernel.


>
> > > > Tested-by: HungNien Chen <hn.chen@sunplusit.com>
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_video.c | 15 +++++++++++++++
> > > >  drivers/media/usb/uvc/uvcvideo.h  |  1 +
> > > >  2 files changed, 16 insertions(+)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > > > index c81a8362d582..6b6bd521d6c2 100644
> > > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > > @@ -471,6 +471,20 @@ static void uvc_video_clock_add_sample(struct uvc_clock *clock,
> > > >
> > > >       spin_lock_irqsave(&clock->lock, flags);
> > > >
> > > > +     /* Delete last overflows */
> > > > +     if (clock->head == clock->last_sof_overflow)
> > > > +             clock->last_sof_overflow = -1;
> > > > +
> > > > +     /* Handle overflows */
> > > > +     if (clock->count > 0 && clock->last_sof > sample->dev_sof) {
> > > > +             /* Remove data from the last^2 overflows */
> > > > +             if (clock->last_sof_overflow != -1)
> > > > +                     clock->count = (clock->head - clock->last_sof_overflow)
> > > > +                                                             % clock->count;
> > > > +             clock->last_sof_overflow = clock->head;
> > > > +     }
> > > > +
> > > > +     /* Add sample */
> > > >       memcpy(&clock->samples[clock->head], sample, sizeof(*sample));
> > > >       clock->last_sof = sample->dev_sof;
> > > >       clock->head = (clock->head + 1) % clock->size;
> > > > @@ -594,6 +608,7 @@ static void uvc_video_clock_reset(struct uvc_clock *clock)
> > > >       clock->head = 0;
> > > >       clock->count = 0;
> > > >       clock->last_sof = -1;
> > > > +     clock->last_sof_overflow = -1;
> > > >       clock->sof_offset = -1;
> > > >  }
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > > index 14daa7111953..d8c520ce5a86 100644
> > > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > > @@ -647,6 +647,7 @@ struct uvc_streaming {
> > > >               unsigned int head;
> > > >               unsigned int count;
> > > >               unsigned int size;
> > > > +             unsigned int last_sof_overflow;
> > > >
> > > >               u16 last_sof;
> > > >               u16 sof_offset;
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
