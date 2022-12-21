Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFDA65387A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 23:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbiLUWV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 17:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiLUWVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 17:21:25 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11C627145;
        Wed, 21 Dec 2022 14:21:23 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1EF9CFB;
        Wed, 21 Dec 2022 23:21:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671661281;
        bh=lyvNIEhEvmk5FHolnG9uYXcz/YyY1A5Se++FwfI3/aE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f1HIE3/4uli18oQNQS/zZNQOJ6coxf5ajW8MFtZ5Jxy2GDxmMukame3LFxU9W+dRn
         Tc8r8EJgAf/ptgdAJOAmTBd+FocIGbydGs9mE4BEbt3jfGlescf0bAHNGEcaB6I2fd
         rHN+ANfvROR8Coqw492xK9eEREA6FSMtonY2A4FE=
Date:   Thu, 22 Dec 2022 00:21:16 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Yunke Cao <yunkec@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] media: v4l2-dev.c: Add Meta: to the name of
 metadata devices
Message-ID: <Y6OG3Oar7NmReCGn@pendragon.ideasonboard.com>
References: <20220920-resend-meta-v4-0-3ac355b66723@chromium.org>
 <20220920-resend-meta-v4-1-3ac355b66723@chromium.org>
 <20221221221601.1636c763@sal.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221221221601.1636c763@sal.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Wed, Dec 21, 2022 at 10:16:01PM +0000, Mauro Carvalho Chehab wrote:
> Em Fri, 02 Dec 2022 18:08:17 +0100 Ricardo Ribalda escreveu:
> 
> > Devices with Metadata output (like uvc), create two video devices, one
> > for the data itself and another one for the metadata.
> > 
> > Add a "Meta: " to the beginning of the device name, as suggested by Mauro,
> > to avoid having multiple devices with the same name.
> 
> Hmm... I don't remember when I suggested it, but I suspect that such
> change could cause regressions on userspace.
> 
> I double-checked: the two apps I know that have code to detect meta
> devices (Camorama and ZBar) won't be affected by name changes, as they
> always open v4l2 devnodes before start seeing them as capture devices,
> and run VIDIOC_QUERYCAP to check for V4L2_CAP_VIDEO_CAPTURE:
> 
>    if (first_device < 0) {
>         fd = open(file, O_RDWR);
>         if (fd < 0) {
>             devices[n_devices].is_valid = FALSE;
>         } else {
>             if (ioctl(fd, VIDIOC_QUERYCAP, &vid_cap) == -1) {
>                 devices[n_devices].is_valid = FALSE;
>             } else if (!(vid_cap.device_caps & V4L2_CAP_VIDEO_CAPTURE)) {
>                 devices[n_devices].is_valid = FALSE;
>             } else {
>                 n_valid_devices++;
>                 devices[n_devices].is_valid = TRUE;
>             }
>         }
> 
>         close(fd);
>     } else {
>         devices[n_devices].is_valid = devices[first_device].is_valid;
>     }
> 
> You need to double-check if this won't cause userspace regressions, specially
> on browsers, as they have more complex logic, and seem to have already some
> logic to detect and remove meta files.

As commented separately in the same mail thread, this change would break
libcamera. For drivers that have well-known names for entities, we look
up some entities by name.

For the uvcvideo driver, which is affected by the v4l2-compliance
failure, a prefix (or suffix, or anything else) would be fine, but we
can't do that unconditionally for all devices.

> > Fixes v4l2-compliance:
> > Media Controller ioctls:
> >      fail: v4l2-test-media.cpp(205): v2_entity_names_set.find(key) != v2_entity_names_set.end()
> >    test MEDIA_IOC_G_TOPOLOGY: FAIL
> >      fail: v4l2-test-media.cpp(394): num_data_links != num_links
> >    test MEDIA_IOC_ENUM_ENTITIES/LINKS: FAIL
> > 
> > Suggested-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/v4l2-core/v4l2-dev.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
> > index 397d553177fa..5c2c9ebb6b96 100644
> > --- a/drivers/media/v4l2-core/v4l2-dev.c
> > +++ b/drivers/media/v4l2-core/v4l2-dev.c
> > @@ -901,6 +901,15 @@ int __video_register_device(struct video_device *vdev,
> >  	if (WARN_ON(type != VFL_TYPE_SUBDEV && !vdev->device_caps))
> >  		return -EINVAL;
> >  
> > +	/* Add Meta: to metadata device names */
> > +	if (vdev->device_caps &
> > +	    (V4L2_CAP_META_CAPTURE | V4L2_CAP_META_OUTPUT)) {
> > +		char aux[sizeof(vdev->name)];
> > +
> > +		snprintf(aux, sizeof(aux), "Meta: %s", vdev->name);
> > +		strscpy(vdev->name, aux, sizeof(aux));
> > +	}
> > +
> >  	/* v4l2_fh support */
> >  	spin_lock_init(&vdev->fh_lock);
> >  	INIT_LIST_HEAD(&vdev->fh_list);

-- 
Regards,

Laurent Pinchart
