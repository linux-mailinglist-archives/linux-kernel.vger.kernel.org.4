Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A90653022
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 12:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiLULXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 06:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLULXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 06:23:32 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A8F2BD2;
        Wed, 21 Dec 2022 03:23:31 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1F55CFB;
        Wed, 21 Dec 2022 12:23:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671621809;
        bh=2wcSda8e9qklFbq/GDmVA4PoZQywKiTPh8H1fje+8jE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nTLzLJsRBHhRYnWUFugBg0GpRmh3AkiC4HXOTxJwZy8lTequN7MJnH7/X/Xh4Gz2t
         2J9N+o1cDuTCHuHnCT+g9FOfE3zFK6B3Zxx1cbiOhPKuxhJXa1XF2hRewY/Cd4DXee
         rM/42dF962hEsHQ6PKkSyc78MsVL/SuxuYg0qr+A=
Date:   Wed, 21 Dec 2022 13:23:24 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Yunke Cao <yunkec@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] media: uvcvideo: Add a unique suffix to camera
 names
Message-ID: <Y6LsrH9pOVqt6ZXr@pendragon.ideasonboard.com>
References: <20220920-resend-meta-v4-0-3ac355b66723@chromium.org>
 <20220920-resend-meta-v4-3-3ac355b66723@chromium.org>
 <Y45tnp0naosOrYCY@pendragon.ideasonboard.com>
 <CANiDSCtRoVQ2+asPmOacarvC2VrJYTbU67+wKJq1ciuMrwguPg@mail.gmail.com>
 <CANiDSCtav5U6759tvt7Hm0nR+8Hz22qfWft3OEFOotSeHpxnAA@mail.gmail.com>
 <Y6LmJGgBYfSMBsj+@pendragon.ideasonboard.com>
 <CANiDSCs3dd7uzts6jgAd-G9pkH5mszxNm2-61T_yAeXBWj6LNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiDSCs3dd7uzts6jgAd-G9pkH5mszxNm2-61T_yAeXBWj6LNw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Wed, Dec 21, 2022 at 11:57:48AM +0100, Ricardo Ribalda wrote:
> On Wed, 21 Dec 2022 at 11:55, Laurent Pinchart wrote:
> > On Wed, Dec 21, 2022 at 12:00:58AM +0100, Ricardo Ribalda wrote:
> > > On Tue, 6 Dec 2022 at 00:02, Ricardo Ribalda wrote:
> > > > On Mon, 5 Dec 2022 at 23:16, Laurent Pinchart wrote:
> > > > > On Fri, Dec 02, 2022 at 06:08:19PM +0100, Ricardo Ribalda wrote:
> > > > > > Some cameras have multiple data inputs (i.e. IR sensor and RGB sensor),
> >
> > Did you mean "data outputs" by the way ?
> >
> > > > > > append a unique number to the device name.
> > > > > >
> > > > > > Fixes v4l2-compliance:
> > > > > >     Media Controller ioctls:
> > > > > >          fail: v4l2-test-media.cpp(205): v2_entity_names_set.find(key) != v2_entity_names_set.end()
> > > > > >        test MEDIA_IOC_G_TOPOLOGY: FAIL
> > > > > >          fail: v4l2-test-media.cpp(394): num_data_links != num_links
> > > > > >        test MEDIA_IOC_ENUM_ENTITIES/LINKS: FAIL
> > > > > >
> > > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > > ---
> > > > > >  drivers/media/usb/uvc/uvc_driver.c | 3 ++-
> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > > > > index 215fb483efb0..f4032ebb3689 100644
> > > > > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > > > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > > > > @@ -1963,7 +1963,8 @@ int uvc_register_video_device(struct uvc_device *dev,
> > > > > >               break;
> > > > > >       }
> > > > > >
> > > > > > -     strscpy(vdev->name, dev->name, sizeof(vdev->name));
> > > > > > +     snprintf(vdev->name, sizeof(vdev->name), "%s %u", dev->name,
> > > > > > +              stream->header.bTerminalLink);
> > > > >
> > > > > This won't be perfect as the string is not guaranteed to fit in
> > > > > vdev->name, but I suppose it will help as a quick fix for some devices.
> > > > > How about the other devices ? Won't they still exhibit the above
> > > > > v4l2-compliance failure ? Isn't that something that will still affect
> > > > > Chrome OS devices ?
> > > >
> > > > We could place the id first... but that will look bad: Eg:
> > > >
> > > > 1- My favorite camera
> > > >
> > > > Another option is to remove the last chars to fit the id. Eg:
> > > >
> > > > My favorite came-1
> > > >
> > > > If you prefer any of those options or have a better idea I can implement that.
> > >
> > > @Laurent
> > >
> > > Any preference here?
> >
> > I think the latter is better. Could we do so only when there are
> > multiple video capture devices (excluding the metadata device) though ?
> > That way we won't have a weird "-n" suffix in the majority of use cases.
> >
> > > > > The change should not cause any regression as big as in patch 1/3.
> > > > > However, unless I'm mistaken users will notice a device name change,
> > > > > especially when selecting a device in their web browser. Could that be a
> > > > > problem ?
> > > >
> > > > I think the only side effect is that the first time that the kernel
> > > > changes the naming convention, if there are more than one camera on
> > > > the system, the video conference might pick a different camera.
> > > > The good news is that the user will be presented with cameras with
> > > > different names. Now some cameras show very confusing names:
> > > >
> > > > ribalda@alco:~/work/linux$ for a in /dev/video* ; do yavta -l $a| grep
> > > > "Dell Webcam"; done
> > > > Device `Dell Webcam WB7022' on `usb-0000:2d:00.0-1.2.3.1' (driver
> > > > 'uvcvideo') supports video, capture, without mplanes.
> > > > Device `Dell Webcam WB7022' on `usb-0000:2d:00.0-1.2.3.1' (driver
> > > > 'uvcvideo') supports meta-data, capture, without mplanes.
> > > > Device `Dell Webcam WB7022' on `usb-0000:2d:00.0-1.2.3.1' (driver
> > > > 'uvcvideo') supports video, capture, without mplanes.
> > > > Device `Dell Webcam WB7022' on `usb-0000:2d:00.0-1.2.3.1' (driver
> > > > 'uvcvideo') supports meta-data, capture, without mplanes.
> >
> > I'm tempted to add a new model read-only string control to overcome the
> > length limitation. It could then be combined with other information
> > (such as the location and supported pixel formats) to create a
> > user-friendly camera name by applications.
> 
> Adding the vid:pid would be really useful! Mapping a /dev/videoX to
> vid:pid is kind of complicated now.

libcamera can help there ;-) We already extract the vendor and product
ID. They are only used to create the camera ID at the moment, they are
not exposed to applications independently. That would be a good
addition.

Overall, device naming is something that we have decided *not* to handle
in libcamera. We provide information to applications to help them
construct a meaningful name, but don't create the name ourselves. This
was decided because naming schemes are dependent on application use
cases, and in many cases should be localized (e.g. "Front camera" and
"Back camera" vs. "Etukamera" and "Takakamera").

> > > > > >       /*
> > > > > >        * Set the driver data before calling video_register_device, otherwise
> > > > > >

-- 
Regards,

Laurent Pinchart
