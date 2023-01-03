Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D85965C87C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbjACUyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238635AbjACUyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:54:44 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A9A14D32;
        Tue,  3 Jan 2023 12:54:43 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B59DB6F0;
        Tue,  3 Jan 2023 21:54:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672779282;
        bh=Qwh7z2GFSGrhgDrwExUs6QXMM2bHAT4UcvZ1obFrdkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SlMQcelxEoMqYzYgDXigftq2jXkK2QncSxBKjbWiRBUYovsU0NzEib2FpCqb3VuIT
         PpzzAGWXUEiMZY3mH838J5qcCo3OCwfp3yBI7Z/8YZVaGyQoZRELEOJFfuawZNB49B
         BzkB7+GTp4XiW1VKMjzC76hsLuPTddOA2dfw5Pf4=
Date:   Tue, 3 Jan 2023 22:54:37 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH v1 1/1] media: uvc: Handle cameras with invalid
 descriptors
Message-ID: <Y7SWDUuHyCQWeGXY@pendragon.ideasonboard.com>
References: <20220920-invalid-desc-v1-0-76a93174f3bc@chromium.org>
 <20220920-invalid-desc-v1-1-76a93174f3bc@chromium.org>
 <Yypgi6Jc9/tZLtIw@pendragon.ideasonboard.com>
 <CANiDSCsbwYfnqcWOjAJw2qvZnB-qE66LqGMhpD8youDj=f+U-g@mail.gmail.com>
 <Yyt/LhNoEEfjly54@pendragon.ideasonboard.com>
 <CANiDSCsSsKk37JtBZjQiuw6MoH+f-iCf47MqU9BH18gbd4EKAg@mail.gmail.com>
 <Y1bXCP2fzacDuZxE@pendragon.ideasonboard.com>
 <CANiDSCsguMfWEHTGy3yry12uOFL=qELQO6tYwu9L-ueLW+bZpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiDSCsguMfWEHTGy3yry12uOFL=qELQO6tYwu9L-ueLW+bZpw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 03:55:54PM +0100, Ricardo Ribalda wrote:
> Hi Laurent
> 
> I think we have missed this patch.

Pushed to
https://git.kernel.org/pub/scm/linux/kernel/git/pinchartl/linux.git/log/?h=next/uvc,
I'll send a pull request next week when Mauro comes back from vacation.

> On Mon, 24 Oct 2022 at 20:19, Laurent Pinchart wrote:
> > On Wed, Sep 21, 2022 at 11:52:29PM +0200, Ricardo Ribalda wrote:
> > > On Wed, 21 Sept 2022 at 23:16, Laurent Pinchart wrote:
> > > > On Wed, Sep 21, 2022 at 09:51:44AM +0200, Ricardo Ribalda wrote:
> > > > > Do you mean something like this?
> > > > >
> > > > > diff --git a/drivers/media/usb/uvc/uvc_entity.c
> > > > > b/drivers/media/usb/uvc/uvc_entity.c
> > > > > index 7c4d2f93d351..66d1f5da4ec7 100644
> > > > > --- a/drivers/media/usb/uvc/uvc_entity.c
> > > > > +++ b/drivers/media/usb/uvc/uvc_entity.c
> > > > > @@ -37,7 +37,7 @@ static int uvc_mc_create_links(struct uvc_video_chain *chain,
> > > > >                         continue;
> > > > >
> > > > >                 remote = uvc_entity_by_id(chain->dev, entity->baSourceID[i]);
> > > > > -               if (remote == NULL)
> > > > > +               if (remote == NULL || remote->num_pads == 0)
> > > > >                         return -EINVAL;
> > > >
> > > > Yes.
> > > >
> > > > >
> > > > >                 source = (UVC_ENTITY_TYPE(remote) == UVC_TT_STREAMING)
> > > > > @@ -46,6 +46,9 @@ static int uvc_mc_create_links(struct uvc_video_chain *chain,
> > > > >                 if (source == NULL)
> > > > >                         continue;
> > > > >
> > > > > +               if (source->num_pads != remote->num_pads)
> > > > > +                       return -EINVAL;
> > > > > +
> > > >
> > > > But this I would have dropped, as the media_entity num_pads is
> > > > initialized from uvc_entity num_pads and neither are changed after.
> > >
> > > Works for me. Shall I send a v2 or you can take it?
> >
> > I'm handling it locally, will be in the next pull request.
> >
> > > > >                 remote_pad = remote->num_pads - 1;
> > > > >                 ret = media_create_pad_link(source, remote_pad,
> > > > >                                                sink, i, flags);
> > > > >
> > > > > regarding making a new patch, whatever is easier for you ;)
> > > > >
> > > > >
> > > > > On Wed, 21 Sept 2022 at 02:53, Laurent Pinchart wrote:
> > > > > >
> > > > > > Hi Ricardo,
> > > > > >
> > > > > > Thank you for the patch.
> > > > > >
> > > > > > On Tue, Sep 20, 2022 at 04:04:55PM +0200, Ricardo Ribalda wrote:
> > > > > > > If the source entity does not contain any pads, do not create a link.
> > > > > > >
> > > > > > > Reported-by: syzbot <syzkaller@googlegroups.com>
> > > > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > > >
> > > > > > > diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
> > > > > > > index 7c4d2f93d351..1f730cb72e58 100644
> > > > > > > --- a/drivers/media/usb/uvc/uvc_entity.c
> > > > > > > +++ b/drivers/media/usb/uvc/uvc_entity.c
> > > > > > > @@ -43,7 +43,7 @@ static int uvc_mc_create_links(struct uvc_video_chain *chain,
> > > > > > >               source = (UVC_ENTITY_TYPE(remote) == UVC_TT_STREAMING)
> > > > > > >                      ? (remote->vdev ? &remote->vdev->entity : NULL)
> > > > > > >                      : &remote->subdev.entity;
> > > > > > > -             if (source == NULL)
> > > > > > > +             if (source == NULL || source->num_pads == 0)
> > > > > >
> > > > > > source->num_pads and remote->num_pads should always be identical, but as
> > > > > > the next line uses remote->num_pads, wouldn't it be better to test that
> > > > > > variable ? If so, I'd move the test a file lines earlier, with the
> > > > > > remote == NULL test.
> > > > > >
> > > > > > What do you think ? If you agree I can make that change when applying,
> > > > > > there's no need for a new version. Otherwise I'll keep the patch as-is.
> > > > > >
> > > > > > >                       continue;
> > > > > > >
> > > > > > >               remote_pad = remote->num_pads - 1;

-- 
Regards,

Laurent Pinchart
