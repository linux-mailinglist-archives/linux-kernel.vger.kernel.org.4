Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A806653983
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 00:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbiLUXAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 18:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiLUXAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 18:00:22 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B985BCA8;
        Wed, 21 Dec 2022 15:00:21 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9916D13FA;
        Thu, 22 Dec 2022 00:00:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671663619;
        bh=d8r+TGwKz45eLMUClR+IITxE3oPFLBRWIRAlr2ioc3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EVwvT8OB/J666L5i1lwNLzJHfly/yun9wpMDqdyWrdECiWhvsPdoz3Clp5Rm2Fie1
         Uf4Dl/Z9/4Fumj6fCFl2HkCUYY9MoE8f2n2zcoTq/ehRj9bHY4L6xw/IEEAhGVLmvB
         mq347/ZCv0mZZADXyX5PcsRpWynVWDs7CIJORwKc=
Date:   Thu, 22 Dec 2022 01:00:14 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Yunke Cao <yunkec@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] media: uvcvideo: Add a unique suffix to camera
 names
Message-ID: <Y6OP/qz9R4BgXi4o@pendragon.ideasonboard.com>
References: <20220920-resend-meta-v4-0-3ac355b66723@chromium.org>
 <20220920-resend-meta-v4-3-3ac355b66723@chromium.org>
 <Y45tnp0naosOrYCY@pendragon.ideasonboard.com>
 <CANiDSCtRoVQ2+asPmOacarvC2VrJYTbU67+wKJq1ciuMrwguPg@mail.gmail.com>
 <20221221220248.12395efb@sal.lan>
 <Y6OHrDw8p4qPWBqz@pendragon.ideasonboard.com>
 <20221221225450.448c58ea@sal.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221221225450.448c58ea@sal.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 10:54:50PM +0000, Mauro Carvalho Chehab wrote:
> Em Thu, 22 Dec 2022 00:24:44 +0200
> Laurent Pinchart <laurent.pinchart@ideasonboard.com> escreveu:
> 
> > Hi Mauro,
> > 
> > On Wed, Dec 21, 2022 at 10:02:48PM +0000, Mauro Carvalho Chehab wrote:
> > > Em Tue, 6 Dec 2022 00:02:22 +0100 Ricardo Ribalda escreveu:  
> > > > On Mon, 5 Dec 2022 at 23:16, Laurent Pinchart wrote:  
> > > > > On Fri, Dec 02, 2022 at 06:08:19PM +0100, Ricardo Ribalda wrote:    
> > > > > > Some cameras have multiple data inputs (i.e. IR sensor and RGB sensor),
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
> > > >   
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
> > > 
> > > That is bad, as some apps like camorama actually store the user
> > > preferences (last used resolution and fps), preserving them the next
> > > time the camera with the same name is used.
> > > 
> > > In the specific case of camorama, it uses the by-id filename, which is
> > > derived from the name, as stored at:
> > > 
> > > 	$ ls -la /dev/v4l/by-id/usb-Quanta_HD_Camera_0001-video-index*
> > > 	lrwxrwxrwx 1 root root 12 dez 21 09:59 /dev/v4l/by-id/usb-Quanta_HD_Camera_0001-video-index0 -> ../../video0
> > > 	lrwxrwxrwx 1 root root 12 dez 21 09:59 /dev/v4l/by-id/usb-Quanta_HD_Camera_0001-video-index1 -> ../../video1
> > > 
> > > With this change, not only the camera name will become bigger (and may
> > > end losing the index0/index1 data), but it will also lost the stored 
> > > preferences on apps like camorama, causing regressions.
> > > 
> > > It sounds a lot easier to teach udev to change the name on an unique
> > > way, on machines where you need it.  
> > 
> > It's not a udev issue, it's an API compliance problem, entity names in a
> > media controller graph must be unique, and they are not.
> 
> Then the right fix would be inside the media controller naming
> logic, in a way that it will ensure unique names. It sounds to me
> that mc core should then check, at device's register time, if the
> name was already used. If so, change it to be unique.

The entity name and video device name are one and the same.

> > Losing the stored preference is possibly inconvenient in some cases, but
> > I don't think it's a real blocker.
> 
> If it causes userspace regressions, then it is a blocker.

I wouldn't necessarily call this a regression.

-- 
Regards,

Laurent Pinchart
