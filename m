Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F87C6437D9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiLEWQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiLEWQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:16:03 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB131A3B0;
        Mon,  5 Dec 2022 14:16:03 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 56774589;
        Mon,  5 Dec 2022 23:16:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1670278561;
        bh=VUJiv+oCI97fmhJGQU37Erv4U9yGfxnZ6q1/K988UdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S22/ku8G8YBkzdK1yYQX+Lo9rdI31jJzASi5nDgNWJbbqr0JTYZaEHU0EDOqm++jw
         XdnhY9whN9SnynzPbIL0XeANHDblWPSW6q7C5daYg5GFRRFcrdNRbTohWuhRT6SiCJ
         2ug0/UZnnOkuJIYOc1FweCf9dYGvy/zSXsxFG11E=
Date:   Tue, 6 Dec 2022 00:15:58 +0200
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
Message-ID: <Y45tnp0naosOrYCY@pendragon.ideasonboard.com>
References: <20220920-resend-meta-v4-0-3ac355b66723@chromium.org>
 <20220920-resend-meta-v4-3-3ac355b66723@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-meta-v4-3-3ac355b66723@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Fri, Dec 02, 2022 at 06:08:19PM +0100, Ricardo Ribalda wrote:
> Some cameras have multiple data inputs (i.e. IR sensor and RGB sensor),
> append a unique number to the device name.
> 
> Fixes v4l2-compliance:
>     Media Controller ioctls:
>          fail: v4l2-test-media.cpp(205): v2_entity_names_set.find(key) != v2_entity_names_set.end()
>        test MEDIA_IOC_G_TOPOLOGY: FAIL
>          fail: v4l2-test-media.cpp(394): num_data_links != num_links
>        test MEDIA_IOC_ENUM_ENTITIES/LINKS: FAIL
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 215fb483efb0..f4032ebb3689 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -1963,7 +1963,8 @@ int uvc_register_video_device(struct uvc_device *dev,
>  		break;
>  	}
>  
> -	strscpy(vdev->name, dev->name, sizeof(vdev->name));
> +	snprintf(vdev->name, sizeof(vdev->name), "%s %u", dev->name,
> +		 stream->header.bTerminalLink);

This won't be perfect as the string is not guaranteed to fit in
vdev->name, but I suppose it will help as a quick fix for some devices.
How about the other devices ? Won't they still exhibit the above
v4l2-compliance failure ? Isn't that something that will still affect
Chrome OS devices ?

The change should not cause any regression as big as in patch 1/3.
However, unless I'm mistaken users will notice a device name change,
especially when selecting a device in their web browser. Could that be a
problem ?

>  	/*
>  	 * Set the driver data before calling video_register_device, otherwise
> 

-- 
Regards,

Laurent Pinchart
