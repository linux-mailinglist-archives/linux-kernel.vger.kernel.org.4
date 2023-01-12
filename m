Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9402D666884
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 02:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbjALBkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 20:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbjALBk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 20:40:29 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7C540C39
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 17:40:29 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id h192so11777726pgc.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 17:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mv9ioiM9uHOHSNsEfO9sNV/sLF1ZMV2fZfvqoWLiGVE=;
        b=A2G3l9mtYjnk00qiRFKJJ1r4WaAgYHD2zmdYAmLsawuE3gviK250t95Q03V6CpfZ+t
         HAIjCtzRYzkn6pp+K0ArBiI1DzfWI9rLeJYgjhHyaT2Y8H5wsQsh+/a6U7MjZlSLFatQ
         gQ+rWvOX3KY1V9RLgD6anvbp31OVVwVWhqEDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mv9ioiM9uHOHSNsEfO9sNV/sLF1ZMV2fZfvqoWLiGVE=;
        b=7HGBxFkTjLPGaJbJamS58Q2SLstv3vIFJUFniaeK1cgI7ZVSFzjrZbHkVVdxU6eVVy
         MqWd+zr4RKehsQZHZGRQCgmYDzyTLt8OeXsRrhpbJasNoHYVIRyiqp64CNUuNEAyF5uM
         8Tho4uVkeQFz+IBFYQN8Zg8IbsZAXvg3KvYsVypB6WhGir9LZpYNcr6DSA39rYechQIq
         ++7H6xa1ckl233DGt7HkRLCP6GTsgsRfrbQiark6X1e3Ki0nQGmThYIo7udRt8VbZ2t5
         ZG6nwd6XAq3FJG5nTXDcyKV0nV5tMlh0YNi+7uX40K85IQZjyS2iHjw+9uU0YHjYwv4H
         asSg==
X-Gm-Message-State: AFqh2koJqbX6qqjC8YY0P9Lv5PNMScwELsQQfPZDoonsg+G2Z4uRqdfI
        hrOT71zFTQQz4VhVZtz6yQeMYknun7yGhf2IpOVwKPNky76nkQ==
X-Google-Smtp-Source: AMrXdXtbKh5SeOQiNGwgMm3MrJggDYtOEzyi/v1iG79A4UBcYSPZFJPSqh0hRsir855jlofEqhov+Mf7IpafFpS+u2Y=
X-Received: by 2002:a62:2901:0:b0:586:7e0c:372d with SMTP id
 p1-20020a622901000000b005867e0c372dmr1461662pfp.14.1673487628474; Wed, 11 Jan
 2023 17:40:28 -0800 (PST)
MIME-Version: 1.0
References: <20230111-uvc_privacy_subdev-v1-0-f859ac9a01e3@chromium.org>
 <20230111-uvc_privacy_subdev-v1-2-f859ac9a01e3@chromium.org> <350cbdd5-55bc-96b1-387e-ba9abeb26470@collabora.com>
In-Reply-To: <350cbdd5-55bc-96b1-387e-ba9abeb26470@collabora.com>
From:   Yunke Cao <yunkec@chromium.org>
Date:   Thu, 12 Jan 2023 10:40:17 +0900
Message-ID: <CAEDqmY6f5cYy-9C9pvpvV4X+WUZjEhgSkfYpZtwf2dbomHSQiw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] media: uvcvideo: remove entity privacy control in
 the uvc video node
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
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

Hi Andrej,

On Wed, Jan 11, 2023 at 7:33 PM Andrzej Pietrasiewicz
<andrzej.p@collabora.com> wrote:
>
> Hello,
>
> W dniu 11.01.2023 o 09:52, Yunke Cao pisze:
> > For privacy_gpio, do not expose V4L2_CID_PRIVACY to userspace as a control
> > of the video node.
> >
>
> I know it is an RFC, so maybe you distribute the changes into 3 patches
> on purpose. But, after applying this patch V4L2_CID_PRIVACY is lost
> until it is re-implemented later, isn't it? Because of that It seems to me
> patches 2/3 and 3/3 should be combined into one.
>

Yes, that's correct. Now that I look at it, it makes little sense to split them.

Thanks!
Yunke

> Regards,
>
> Andrzej
>
> > Signed-off-by: Yunke Cao <yunkec@chromium.org>
> > ---
> >   drivers/media/usb/uvc/uvc_ctrl.c | 17 -----------------
> >   1 file changed, 17 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index c95a2229f4fa..77c5ff19add8 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -348,14 +348,6 @@ static const struct uvc_control_info uvc_ctrls[] = {
> >                               | UVC_CTRL_FLAG_RESTORE
> >                               | UVC_CTRL_FLAG_AUTO_UPDATE,
> >       },
> > -     {
> > -             .entity         = UVC_GUID_EXT_GPIO_CONTROLLER,
> > -             .selector       = UVC_CT_PRIVACY_CONTROL,
> > -             .index          = 0,
> > -             .size           = 1,
> > -             .flags          = UVC_CTRL_FLAG_GET_CUR
> > -                             | UVC_CTRL_FLAG_AUTO_UPDATE,
> > -     },
> >   };
> >
> >   static const u32 uvc_control_classes[] = {
> > @@ -710,15 +702,6 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
> >               .v4l2_type      = V4L2_CTRL_TYPE_BOOLEAN,
> >               .data_type      = UVC_CTRL_DATA_TYPE_BOOLEAN,
> >       },
> > -     {
> > -             .id             = V4L2_CID_PRIVACY,
> > -             .entity         = UVC_GUID_EXT_GPIO_CONTROLLER,
> > -             .selector       = UVC_CT_PRIVACY_CONTROL,
> > -             .size           = 1,
> > -             .offset         = 0,
> > -             .v4l2_type      = V4L2_CTRL_TYPE_BOOLEAN,
> > -             .data_type      = UVC_CTRL_DATA_TYPE_BOOLEAN,
> > -     },
> >   };
> >
> >   static const struct uvc_control_mapping uvc_ctrl_mappings_uvc11[] = {
> >
>
