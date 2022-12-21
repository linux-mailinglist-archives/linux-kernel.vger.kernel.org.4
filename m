Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7AD653006
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 11:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbiLUK6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 05:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbiLUK6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 05:58:03 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FD521E1B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 02:58:03 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so1772518pjd.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 02:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XQBc+QvBPRkVOEcVfx3x2J4ITeNz2U1MCam23HruzQ0=;
        b=cXu1bkyqTc0P0Wcm7szyoqVrOAL0ILxZazft2Kz6pyHBfnms6LZ+Mk/bDn3SAHSOPt
         OQmElX3sGPvjMUBCG1z+3YgfWVYdbqf56EfSXkdsCO0nvB3p2CfQQdg3fBRNuNF0acQ8
         kyypKM9S0NfpEEdeb3XQOX5RFGkyP15H7bhiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQBc+QvBPRkVOEcVfx3x2J4ITeNz2U1MCam23HruzQ0=;
        b=n5iFDl5mtWyAeYBRRcUyG3v6WUAVNym1YS6BPbgk2mJG4EJep7DE1lutw4pulV+wpB
         XeAYKSjlORmuMOKlXBI7e0AEO4N8nq3kFFBVA/oTetpQHKf2r+2+08jwyviyXM/r9bpF
         b+dhGPKXA/6C3aqAlQ1ZCxR+5uqpIfSRe0cLHr8f6kDhixiGMxjRVzJfbVcto3/VXdM8
         GaPY9qEdxCo9G/39zQHl91qE83sJDtC5YnNAKj2ydqiXBn1O/EJe22Rr8l5RwUvz9huV
         9cMVzM0rZUT1HkQpItXHZIEZAxVB705hCO7SUGIq3JjNOmvvagGP26tpzfZl7OOlgHea
         xCYg==
X-Gm-Message-State: AFqh2krXu/obpg6vHlM8H3hVLFg0t8upBRJ+QOLPC7qLv6Pw0uJ3/NvD
        8NiOq8rSoGrIF7SCfEkrcRaNw6kbeGjhoNstkX4=
X-Google-Smtp-Source: AMrXdXtXJymohac62gNormYMmcN5+/N/sujdkvsKrrYuRk8C91gDjv1ZUcaYS22GLJ3HYvC+3kvbqg==
X-Received: by 2002:a17:903:28d:b0:191:386:d8f with SMTP id j13-20020a170903028d00b0019103860d8fmr1562716plr.47.1671620282289;
        Wed, 21 Dec 2022 02:58:02 -0800 (PST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com. [209.85.214.181])
        by smtp.gmail.com with ESMTPSA id j5-20020a170903024500b0018930dbc560sm11097150plh.96.2022.12.21.02.58.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 02:58:00 -0800 (PST)
Received: by mail-pl1-f181.google.com with SMTP id 4so15165948plj.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 02:58:00 -0800 (PST)
X-Received: by 2002:a17:90a:cf02:b0:219:33a1:d05f with SMTP id
 h2-20020a17090acf0200b0021933a1d05fmr140255pju.116.1671620279828; Wed, 21 Dec
 2022 02:57:59 -0800 (PST)
MIME-Version: 1.0
References: <20220920-resend-meta-v4-0-3ac355b66723@chromium.org>
 <20220920-resend-meta-v4-3-3ac355b66723@chromium.org> <Y45tnp0naosOrYCY@pendragon.ideasonboard.com>
 <CANiDSCtRoVQ2+asPmOacarvC2VrJYTbU67+wKJq1ciuMrwguPg@mail.gmail.com>
 <CANiDSCtav5U6759tvt7Hm0nR+8Hz22qfWft3OEFOotSeHpxnAA@mail.gmail.com> <Y6LmJGgBYfSMBsj+@pendragon.ideasonboard.com>
In-Reply-To: <Y6LmJGgBYfSMBsj+@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 21 Dec 2022 11:57:48 +0100
X-Gmail-Original-Message-ID: <CANiDSCs3dd7uzts6jgAd-G9pkH5mszxNm2-61T_yAeXBWj6LNw@mail.gmail.com>
Message-ID: <CANiDSCs3dd7uzts6jgAd-G9pkH5mszxNm2-61T_yAeXBWj6LNw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] media: uvcvideo: Add a unique suffix to camera names
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Yunke Cao <yunkec@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
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

On Wed, 21 Dec 2022 at 11:55, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> On Wed, Dec 21, 2022 at 12:00:58AM +0100, Ricardo Ribalda wrote:
> > On Tue, 6 Dec 2022 at 00:02, Ricardo Ribalda wrote:
> > > On Mon, 5 Dec 2022 at 23:16, Laurent Pinchart wrote:
> > > > On Fri, Dec 02, 2022 at 06:08:19PM +0100, Ricardo Ribalda wrote:
> > > > > Some cameras have multiple data inputs (i.e. IR sensor and RGB sensor),
>
> Did you mean "data outputs" by the way ?
>
> > > > > append a unique number to the device name.
> > > > >
> > > > > Fixes v4l2-compliance:
> > > > >     Media Controller ioctls:
> > > > >          fail: v4l2-test-media.cpp(205): v2_entity_names_set.find(key) != v2_entity_names_set.end()
> > > > >        test MEDIA_IOC_G_TOPOLOGY: FAIL
> > > > >          fail: v4l2-test-media.cpp(394): num_data_links != num_links
> > > > >        test MEDIA_IOC_ENUM_ENTITIES/LINKS: FAIL
> > > > >
> > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > ---
> > > > >  drivers/media/usb/uvc/uvc_driver.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > > > index 215fb483efb0..f4032ebb3689 100644
> > > > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > > > @@ -1963,7 +1963,8 @@ int uvc_register_video_device(struct uvc_device *dev,
> > > > >               break;
> > > > >       }
> > > > >
> > > > > -     strscpy(vdev->name, dev->name, sizeof(vdev->name));
> > > > > +     snprintf(vdev->name, sizeof(vdev->name), "%s %u", dev->name,
> > > > > +              stream->header.bTerminalLink);
> > > >
> > > > This won't be perfect as the string is not guaranteed to fit in
> > > > vdev->name, but I suppose it will help as a quick fix for some devices.
> > > > How about the other devices ? Won't they still exhibit the above
> > > > v4l2-compliance failure ? Isn't that something that will still affect
> > > > Chrome OS devices ?
> > >
> > > We could place the id first... but that will look bad: Eg:
> > >
> > > 1- My favorite camera
> > >
> > > Another option is to remove the last chars to fit the id. Eg:
> > >
> > > My favorite came-1
> > >
> > > If you prefer any of those options or have a better idea I can implement that.
> >
> > @Laurent
> >
> > Any preference here?
>
> I think the latter is better. Could we do so only when there are
> multiple video capture devices (excluding the metadata device) though ?
> That way we won't have a weird "-n" suffix in the majority of use cases.
>
> > > > The change should not cause any regression as big as in patch 1/3.
> > > > However, unless I'm mistaken users will notice a device name change,
> > > > especially when selecting a device in their web browser. Could that be a
> > > > problem ?
> > >
> > > I think the only side effect is that the first time that the kernel
> > > changes the naming convention, if there are more than one camera on
> > > the system, the video conference might pick a different camera.
> > > The good news is that the user will be presented with cameras with
> > > different names. Now some cameras show very confusing names:
> > >
> > > ribalda@alco:~/work/linux$ for a in /dev/video* ; do yavta -l $a| grep
> > > "Dell Webcam"; done
> > > Device `Dell Webcam WB7022' on `usb-0000:2d:00.0-1.2.3.1' (driver
> > > 'uvcvideo') supports video, capture, without mplanes.
> > > Device `Dell Webcam WB7022' on `usb-0000:2d:00.0-1.2.3.1' (driver
> > > 'uvcvideo') supports meta-data, capture, without mplanes.
> > > Device `Dell Webcam WB7022' on `usb-0000:2d:00.0-1.2.3.1' (driver
> > > 'uvcvideo') supports video, capture, without mplanes.
> > > Device `Dell Webcam WB7022' on `usb-0000:2d:00.0-1.2.3.1' (driver
> > > 'uvcvideo') supports meta-data, capture, without mplanes.
>
> I'm tempted to add a new model read-only string control to overcome the
> length limitation. It could then be combined with other information
> (such as the location and supported pixel formats) to create a
> user-friendly camera name by applications.

Adding the vid:pid would be really useful! Mapping a /dev/videoX to
vid:pid is kind of complicated now.

Thanks!
>
> > > > >       /*
> > > > >        * Set the driver data before calling video_register_device, otherwise
> > > > >
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
