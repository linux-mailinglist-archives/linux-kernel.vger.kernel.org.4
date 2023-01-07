Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3E4660B1D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 01:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbjAGAyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 19:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjAGAyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:54:41 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2872C6E0C6;
        Fri,  6 Jan 2023 16:54:40 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5425F4AE;
        Sat,  7 Jan 2023 01:54:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673052878;
        bh=3wTz05s6w8LRBPeOyGAtm4VAX8/Zc3NEwLvMC7UcxqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ktcoHLlb8s2Dd564x8dn/FAL+ZB1lGC6VCWOWtkrsTLZKSMk4ptPkZuW4HduU559u
         +YahYZGOmLNT7zc2AgX3O0ztWS39vW4rSiTHgUivxTHqcc7sMJRVmjiz1rx6mdMhnL
         6aq6K4e4SYNUP7j9M9jEYrHSPBnvSbRuLYpnNQ1U=
Date:   Sat, 7 Jan 2023 02:54:33 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "hn.chen" <hn.chen@sunplusit.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 8/8] media: uvcvideo: Fix hw timestampt
 handling for slow FPS
Message-ID: <Y7jCydc6mFvZRQof@pendragon.ideasonboard.com>
References: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
 <20220920-resend-hwtimestamp-v2-8-0d7978a817cc@chromium.org>
 <Y6761ScB9FgMC6zb@pendragon.ideasonboard.com>
 <CANiDSCtsk+oejXSDGo_DStocHOEsk4=oYOu6KccQdckfBXbj-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiDSCtsk+oejXSDGo_DStocHOEsk4=oYOu6KccQdckfBXbj-g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Wed, Jan 04, 2023 at 12:34:34AM +0100, Ricardo Ribalda wrote:
> On Fri, 30 Dec 2022 at 15:51, Laurent Pinchart wrote:
> > On Fri, Dec 02, 2022 at 06:02:48PM +0100, Ricardo Ribalda wrote:
> > > In UVC 1.5, when working with FPS under 32, there is a chance that the
> > > circular buffer contains two dev_sof overflows,
> >
> > An explanation of why this is the case would be good in the commit
> > message. Also, by overflow, are you talking about the SOF counter
> > rolling over ?
> >
> > > but the clock interpolator
> > > is only capable of handle a single overflow.
> > >
> > > Remove all the samples from the circular buffer that are two overflows
> > > old.
> >
> > I would rather support multiple roll-over in the clock interpolator.
> > Dropping older sampls will lead to less predictable behaviour and harder
> > to debug issues.
> 
> Multiple roll-over would not necessarily mean better data here. We are
> deleting data that is more than 1 second away, and our resolution is
> 1kHz, which means that we have enough data to provide good results, we
> have measured that 250msec already provides good data.

Do we ? We may get one SCR per frame only. With low frame rates (say,
5fps for instance, which is fairly common, I have 2092 out of 16475
frame descriptors supporting that format in my database of UVC
descriptors), we'll have 4 to 5 data points.

> From a logical point of view, this patch is fixing a bug, not adding a
> new feature, and it has been validated. I would rather add multi
> roll-over as a follow-up patch, or maybe suggest implementing it in
> userspace ;).

Would you give the latter a try ? :-)

> > > Tested-by: HungNien Chen <hn.chen@sunplusit.com>
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  drivers/media/usb/uvc/uvc_video.c | 15 +++++++++++++++
> > >  drivers/media/usb/uvc/uvcvideo.h  |  1 +
> > >  2 files changed, 16 insertions(+)
> > >
> > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > > index c81a8362d582..6b6bd521d6c2 100644
> > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > @@ -471,6 +471,20 @@ static void uvc_video_clock_add_sample(struct uvc_clock *clock,
> > >
> > >       spin_lock_irqsave(&clock->lock, flags);
> > >
> > > +     /* Delete last overflows */
> > > +     if (clock->head == clock->last_sof_overflow)
> > > +             clock->last_sof_overflow = -1;
> > > +
> > > +     /* Handle overflows */
> > > +     if (clock->count > 0 && clock->last_sof > sample->dev_sof) {
> > > +             /* Remove data from the last^2 overflows */
> > > +             if (clock->last_sof_overflow != -1)
> > > +                     clock->count = (clock->head - clock->last_sof_overflow)
> > > +                                                             % clock->count;
> > > +             clock->last_sof_overflow = clock->head;
> > > +     }
> > > +
> > > +     /* Add sample */
> > >       memcpy(&clock->samples[clock->head], sample, sizeof(*sample));
> > >       clock->last_sof = sample->dev_sof;
> > >       clock->head = (clock->head + 1) % clock->size;
> > > @@ -594,6 +608,7 @@ static void uvc_video_clock_reset(struct uvc_clock *clock)
> > >       clock->head = 0;
> > >       clock->count = 0;
> > >       clock->last_sof = -1;
> > > +     clock->last_sof_overflow = -1;
> > >       clock->sof_offset = -1;
> > >  }
> > >
> > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > index 14daa7111953..d8c520ce5a86 100644
> > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > @@ -647,6 +647,7 @@ struct uvc_streaming {
> > >               unsigned int head;
> > >               unsigned int count;
> > >               unsigned int size;
> > > +             unsigned int last_sof_overflow;
> > >
> > >               u16 last_sof;
> > >               u16 sof_offset;

-- 
Regards,

Laurent Pinchart
