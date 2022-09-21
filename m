Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA2D5E5513
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 23:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiIUVQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 17:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiIUVQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 17:16:49 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D3BA2853;
        Wed, 21 Sep 2022 14:16:47 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1D9336BE;
        Wed, 21 Sep 2022 23:16:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1663795005;
        bh=uYeJJ+u55Mqbk9ZLBFbpfCcBTgKXtawh0fzIcnY06CM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XPVeEN2tnQAHITiOODoEPTby2941qgid10y/F9iUpJcnR7ptwMPy9/Q77R5L+h0AS
         WRvZMYe2HLaYRfR6xN+5Yrs4CbXQheDXbHefl2CEyFzKaj564v27EmIxtF19wqDGtL
         o9Ms5l76nnnhSkxWUT5Ys8Yc26BQEwd35Cybpj8g=
Date:   Thu, 22 Sep 2022 00:16:30 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH v1 1/1] media: uvc: Handle cameras with invalid
 descriptors
Message-ID: <Yyt/LhNoEEfjly54@pendragon.ideasonboard.com>
References: <20220920-invalid-desc-v1-0-76a93174f3bc@chromium.org>
 <20220920-invalid-desc-v1-1-76a93174f3bc@chromium.org>
 <Yypgi6Jc9/tZLtIw@pendragon.ideasonboard.com>
 <CANiDSCsbwYfnqcWOjAJw2qvZnB-qE66LqGMhpD8youDj=f+U-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiDSCsbwYfnqcWOjAJw2qvZnB-qE66LqGMhpD8youDj=f+U-g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Wed, Sep 21, 2022 at 09:51:44AM +0200, Ricardo Ribalda wrote:
> Do you mean something like this?
> 
> diff --git a/drivers/media/usb/uvc/uvc_entity.c
> b/drivers/media/usb/uvc/uvc_entity.c
> index 7c4d2f93d351..66d1f5da4ec7 100644
> --- a/drivers/media/usb/uvc/uvc_entity.c
> +++ b/drivers/media/usb/uvc/uvc_entity.c
> @@ -37,7 +37,7 @@ static int uvc_mc_create_links(struct uvc_video_chain *chain,
>                         continue;
> 
>                 remote = uvc_entity_by_id(chain->dev, entity->baSourceID[i]);
> -               if (remote == NULL)
> +               if (remote == NULL || remote->num_pads == 0)
>                         return -EINVAL;

Yes.

> 
>                 source = (UVC_ENTITY_TYPE(remote) == UVC_TT_STREAMING)
> @@ -46,6 +46,9 @@ static int uvc_mc_create_links(struct uvc_video_chain *chain,
>                 if (source == NULL)
>                         continue;
> 
> +               if (source->num_pads != remote->num_pads)
> +                       return -EINVAL;
> +

But this I would have dropped, as the media_entity num_pads is
initialized from uvc_entity num_pads and neither are changed after.

>                 remote_pad = remote->num_pads - 1;
>                 ret = media_create_pad_link(source, remote_pad,
>                                                sink, i, flags);
> 
> regarding making a new patch, whatever is easier for you ;)
> 
> 
> On Wed, 21 Sept 2022 at 02:53, Laurent Pinchart wrote:
> >
> > Hi Ricardo,
> >
> > Thank you for the patch.
> >
> > On Tue, Sep 20, 2022 at 04:04:55PM +0200, Ricardo Ribalda wrote:
> > > If the source entity does not contain any pads, do not create a link.
> > >
> > > Reported-by: syzbot <syzkaller@googlegroups.com>
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > >
> > > diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
> > > index 7c4d2f93d351..1f730cb72e58 100644
> > > --- a/drivers/media/usb/uvc/uvc_entity.c
> > > +++ b/drivers/media/usb/uvc/uvc_entity.c
> > > @@ -43,7 +43,7 @@ static int uvc_mc_create_links(struct uvc_video_chain *chain,
> > >               source = (UVC_ENTITY_TYPE(remote) == UVC_TT_STREAMING)
> > >                      ? (remote->vdev ? &remote->vdev->entity : NULL)
> > >                      : &remote->subdev.entity;
> > > -             if (source == NULL)
> > > +             if (source == NULL || source->num_pads == 0)
> >
> > source->num_pads and remote->num_pads should always be identical, but as
> > the next line uses remote->num_pads, wouldn't it be better to test that
> > variable ? If so, I'd move the test a file lines earlier, with the
> > remote == NULL test.
> >
> > What do you think ? If you agree I can make that change when applying,
> > there's no need for a new version. Otherwise I'll keep the patch as-is.
> >
> > >                       continue;
> > >
> > >               remote_pad = remote->num_pads - 1;
> > >

-- 
Regards,

Laurent Pinchart
