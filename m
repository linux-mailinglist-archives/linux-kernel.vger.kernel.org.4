Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D52C6B2812
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjCIPBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjCIPBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:01:12 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A684D50B;
        Thu,  9 Mar 2023 06:57:56 -0800 (PST)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 786758B1;
        Thu,  9 Mar 2023 15:57:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1678373874;
        bh=4tUk+33kPiCk1+bL4NC4sgOTjs0IM6b95xiNWBvw28c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uVKMGDrj8Yxn3uJbT7pUZ9LO3Lz9PFkWn7yg2El9IYGR6DYm2rFSBf4ucDjUN/NKI
         3/zKwHpqhh3IsMySTviYnMHlVjW2fWQxG1xfyTNgR62PsR2AARN7ZiVE0ywOGZnI+e
         uSVtElQJlBfZXLt8gNAZN8RK9k3zAmJ9RAya6pYw=
Date:   Thu, 9 Mar 2023 16:57:57 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Max Staudt <mstaudt@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH v2 1/3] media: uvcvideo: Cancel async worker earlier
Message-ID: <20230309145757.GB1088@pendragon.ideasonboard.com>
References: <20230309-guenter-mini-v2-0-e6410d590d43@chromium.org>
 <20230309-guenter-mini-v2-1-e6410d590d43@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230309-guenter-mini-v2-1-e6410d590d43@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo and Guenter,

Thank you for the patch.

On Thu, Mar 09, 2023 at 03:44:05PM +0100, Ricardo Ribalda wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> 
> So far the asynchronous control worker was canceled only in
> uvc_ctrl_cleanup_device. This is much later than the call to
> uvc_disconnect. However, after the call to uvc_disconnect returns,
> there must be no more USB activity. This can result in all kinds
> of problems in the USB code. One observed example:
> 
> URB ffff993e83d0bc00 submitted while active
> WARNING: CPU: 0 PID: 4046 at drivers/usb/core/urb.c:364 usb_submit_urb+0x4ba/0x55e
> Modules linked in: <...>
> CPU: 0 PID: 4046 Comm: kworker/0:35 Not tainted 4.19.139 #18
> Hardware name: Google Phaser/Phaser, BIOS Google_Phaser.10952.0.0 08/09/2018
> Workqueue: events uvc_ctrl_status_event_work [uvcvideo]
> RIP: 0010:usb_submit_urb+0x4ba/0x55e
> Code: <...>
> RSP: 0018:ffffb08d471ebde8 EFLAGS: 00010246
> RAX: a6da85d923ea5d00 RBX: ffff993e71985928 RCX: 0000000000000000
> RDX: ffff993f37a1de90 RSI: ffff993f37a153d0 RDI: ffff993f37a153d0
> RBP: ffffb08d471ebe28 R08: 000000000000003b R09: 001424bf85822e96
> R10: 0000001000000000 R11: ffffffff975a4398 R12: ffff993e83d0b000
> R13: ffff993e83d0bc00 R14: 0000000000000000 R15: 00000000fffffff0
> FS:  0000000000000000(0000) GS:ffff993f37a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000ec9c0000 CR3: 000000025b160000 CR4: 0000000000340ef0
> Call Trace:
>  uvc_ctrl_status_event_work+0xd6/0x107 [uvcvideo]
>  process_one_work+0x19b/0x4c5
>  worker_thread+0x10d/0x286
>  kthread+0x138/0x140
>  ? process_one_work+0x4c5/0x4c5
>  ? kthread_associate_blkcg+0xc1/0xc1
>  ret_from_fork+0x1f/0x40
> 
> Introduce new function uvc_ctrl_stop_device() to cancel the worker
> and call it from uvc_unregister_video() to solve the problem.
> 
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> Reviewed-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c   | 11 +++++++----
>  drivers/media/usb/uvc/uvc_driver.c |  1 +
>  drivers/media/usb/uvc/uvcvideo.h   |  1 +
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 5e9d3da862dd..769c1d2a2f45 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -2757,14 +2757,17 @@ static void uvc_ctrl_cleanup_mappings(struct uvc_device *dev,
>  	}
>  }
>  
> -void uvc_ctrl_cleanup_device(struct uvc_device *dev)
> +void uvc_ctrl_stop_device(struct uvc_device *dev)
>  {
> -	struct uvc_entity *entity;
> -	unsigned int i;
> -
>  	/* Can be uninitialized if we are aborting on probe error. */
>  	if (dev->async_ctrl.work.func)
>  		cancel_work_sync(&dev->async_ctrl.work);
> +}

There may be an opportunity for refactoring, as we have
uvc_status_stop() that stops the work queue, but I think this is good
enough for now. I'm wondering, though, if there could be a race
condition here similar to the one that the recent changes to
uvc_status_stop() have fixed ? As uvc_ctrl_stop_device() is called at
release time I assume that URBs have been cancelled, so there should be
no race, but a second pair of eyeballs to confirm this would be
appreciated.

Other than that, the patch looks good to me, and fixes an issue
independent from the rest of the series, so

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I will wait for a reply regarding the race condition before queuing this
up though.

> +
> +void uvc_ctrl_cleanup_device(struct uvc_device *dev)
> +{
> +	struct uvc_entity *entity;
> +	unsigned int i;
>  
>  	/* Free controls and control mappings for all entities. */
>  	list_for_each_entry(entity, &dev->entities, list) {
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 7aefa76a42b3..4be6dfeaa295 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -1893,6 +1893,7 @@ static void uvc_unregister_video(struct uvc_device *dev)
>  	}
>  
>  	uvc_status_unregister(dev);
> +	uvc_ctrl_stop_device(dev);
>  
>  	if (dev->vdev.dev)
>  		v4l2_device_unregister(&dev->vdev);
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 9a596c8d894a..50f171e7381b 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -760,6 +760,7 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
>  int uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
>  			 const struct uvc_control_mapping *mapping);
>  int uvc_ctrl_init_device(struct uvc_device *dev);
> +void uvc_ctrl_stop_device(struct uvc_device *dev);
>  void uvc_ctrl_cleanup_device(struct uvc_device *dev);
>  int uvc_ctrl_restore_values(struct uvc_device *dev);
>  bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video_chain *chain,

-- 
Regards,

Laurent Pinchart
