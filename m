Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257676B278F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjCIOqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjCIOpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:45:07 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E23FD298
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:44:23 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x3so7865855edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 06:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678373061;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYea4xW1aPrNJdU0g9tC7HReHIPPT4JXF20GWjevROo=;
        b=e2J3fuz4MSQcv+1Ux2A9YS7GC9jRDV1648YalOlit87Bbx+xDgC6Ydf/Q6DxpalZDm
         +IgSIWbWRfAYyl6D1/bzBVwM9X5DlpQ1w3qZRki4UKPxK84WngVxunKsV59rHV2TOc4Q
         PDw+KtHYBZUAUu10+BmcTDdr+3F6xwbPwXYbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678373061;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYea4xW1aPrNJdU0g9tC7HReHIPPT4JXF20GWjevROo=;
        b=hiq5E8Y9Q8ajSGLE1TIuf+qNkfI+prPQaWehT/vDyb2mFLBBWRLj7usE85OHx1ilo4
         HTsd5AdVqadB0m3es8AkeLVptO0tsG6U8kq6WG901vOVU6I3TVuFOBgih6FSOOjpAwjy
         3ajdLJMtyZQKxoq+olJJQg9X/jzqGz4NzymjreTq68/P1t5aHplszi97wL4Smzb3B1TV
         OsxzFdQuin6OMUz0+ztIOGMLdkL1OydLninvCTPiLIfQ1xmHuEnw3J4QblmO971Lg5j4
         FeossZu0dowVpd9cLw8n/+AnqCHfz1843Y4DnAOcvdOlWzhmgF3SvJ9lH6wL4AE/aN4t
         y5bw==
X-Gm-Message-State: AO0yUKUci/XRakxbxQD7Dnhs3/41dKwWrae/FVyvD2oN7Y5gFIqSJUC5
        usKNKg5tFh6tACja9XrIVXaQq9sAExirz++pQGn+Lw==
X-Google-Smtp-Source: AK7set/A/Bci8ewQ3l22Ez83RDpqEAPvAOuVMvU8wLXDMrtzX/nYOLk2sjVvBxLW1vYsEDMeunpLjQ==
X-Received: by 2002:a05:6402:699:b0:4ad:66b:84a8 with SMTP id f25-20020a056402069900b004ad066b84a8mr22649239edy.6.1678373061519;
        Thu, 09 Mar 2023 06:44:21 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:1645:7aa4:a765:1966])
        by smtp.gmail.com with ESMTPSA id l6-20020a50d6c6000000b004bdcc480c41sm9708931edj.96.2023.03.09.06.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 06:44:21 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 09 Mar 2023 15:44:06 +0100
Subject: [PATCH v2 2/3] media: uvcvideo: Lock video streams and queues while
 unregistering
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230309-guenter-mini-v2-2-e6410d590d43@chromium.org>
References: <20230309-guenter-mini-v2-0-e6410d590d43@chromium.org>
In-Reply-To: <20230309-guenter-mini-v2-0-e6410d590d43@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Max Staudt <mstaudt@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=4440; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=fcE+GDS+VWNQt6cIEy1PE6o89MbggJy7V6rzfGUAWoA=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkCfDAE0zosgxin8UX0Wbq1VMzdLe9WPvKboLwoVCA
 IfyOwT2JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZAnwwAAKCRDRN9E+zzrEiLEvEA
 CPi1bgGf5PkApsj56wCjFkv3C6N/AVhrjtC8z6XF/JZhEEBcu+1O5WBLqx1V1OV1R6NYUawEbT+FpP
 ne44cuo0HtM7aFITUbWJIPlfi1pLVZJ2kupbOBiq+fAfjlkh//MQ9EnWFi/3bGHAysDbjR6HbvFAvf
 IUaebHeeb3DclWFXbCJ+u/oYWm8QdU/BqKAUX+IlmLaRoqnl94s6UDeXHcfBHtZ6QIf+hoSCpJyI4k
 6vqY5zvDprq9hRGpD0kTjPd7GD/nX+XacrfN0e6Q6EaZwGLvJ5XkDRK/RgNunjUJ2rOtRxs99IB0/g
 D6174lfISc+VVYc9WHI0kpuRUd6UwTl71OHrAarCVRdiK3JrCkFokOVag9h4b8pxueQWmNO/2mjyMN
 b3/I0IZDr7+1RkIKdbxw9q49cdpH5j/8/ctREZf6l+SW/tigFk0OxNUqS74wrDY2mzf0G8flY818kP
 mLzfOA2fS9v3h6PJjeaDr09dgpc2s/QxhPo6AG+6N01Ej1HUBLDdBeAtYwsBbPnTS/FlO1yaUM5aGL
 lP9VlgpzrQWxi1E6IexRg0orD2ekETMLvg7XMtOpbML8UAkJnjI9jJ+lZR+PCzBQm0FCfANvgNKHns
 OoNgJJzDEtQIc9PygewTJMOop0FJkttIGKPzkgsgvv3Ya42TTyQbe/IMSiKg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

The call to uvc_disconnect() is not protected by any mutex.
This means it can and will be called while other accesses to the video
device are in progress. This can cause all kinds of race conditions,
including crashes such as the following.

usb 1-4: USB disconnect, device number 3
BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 0 PID: 5633 Comm: V4L2CaptureThre Not tainted 4.19.113-08536-g5d29ca36db06 #1
Hardware name: GOOGLE Edgar, BIOS Google_Edgar.7287.167.156 03/25/2019
RIP: 0010:usb_ifnum_to_if+0x29/0x40
Code: <...>
RSP: 0018:ffffa46f42a47a80 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff904a396c9000
RDX: ffff904a39641320 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffa46f42a47a80 R08: 0000000000000002 R09: 0000000000000000
R10: 0000000000009975 R11: 0000000000000009 R12: 0000000000000000
R13: ffff904a396b3800 R14: ffff904a39e88000 R15: 0000000000000000
FS: 00007f396448e700(0000) GS:ffff904a3ba00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000016cb46000 CR4: 00000000001006f0
Call Trace:
 usb_hcd_alloc_bandwidth+0x1ee/0x30f
 usb_set_interface+0x1a3/0x2b7
 uvc_video_start_transfer+0x29b/0x4b8 [uvcvideo]
 uvc_video_start_streaming+0x91/0xdd [uvcvideo]
 uvc_start_streaming+0x28/0x5d [uvcvideo]
 vb2_start_streaming+0x61/0x143 [videobuf2_common]
 vb2_core_streamon+0xf7/0x10f [videobuf2_common]
 uvc_queue_streamon+0x2e/0x41 [uvcvideo]
 uvc_ioctl_streamon+0x42/0x5c [uvcvideo]
 __video_do_ioctl+0x33d/0x42a
 video_usercopy+0x34e/0x5ff
 ? video_ioctl2+0x16/0x16
 v4l2_ioctl+0x46/0x53
 do_vfs_ioctl+0x50a/0x76f
 ksys_ioctl+0x58/0x83
 __x64_sys_ioctl+0x1a/0x1e
 do_syscall_64+0x54/0xde

usb_set_interface() should not be called after the USB device has been
unregistered. However, in the above case the disconnect happened after
v4l2_ioctl() was called, but before the call to usb_ifnum_to_if().

Acquire various mutexes in uvc_unregister_video() to fix the majority
(maybe all) of the observed race conditions.

The uvc_device lock prevents races against suspend and resume calls
and the poll function.

The uvc_streaming lock prevents races against stream related functions;
for the most part, those are ioctls. This lock also requires other
functions using this lock to check if a video device is still registered
after acquiring it. For example, it was observed that the video device
was already unregistered by the time the stream lock was acquired in
uvc_ioctl_streamon().

The uvc_queue lock prevents races against queue functions, Most of
those are already protected by the uvc_streaming lock, but some
are called directly. This is done as added protection; an actual race
was not (yet) observed.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 4be6dfeaa295..9fda863ec446 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1882,14 +1882,22 @@ static void uvc_unregister_video(struct uvc_device *dev)
 {
 	struct uvc_streaming *stream;
 
+	mutex_lock(&dev->lock);
+
 	list_for_each_entry(stream, &dev->streams, list) {
 		if (!video_is_registered(&stream->vdev))
 			continue;
 
+		mutex_lock(&stream->mutex);
+		mutex_lock(&stream->queue.mutex);
+
 		video_unregister_device(&stream->vdev);
 		video_unregister_device(&stream->meta.vdev);
 
 		uvc_debugfs_cleanup_stream(stream);
+
+		mutex_unlock(&stream->queue.mutex);
+		mutex_unlock(&stream->mutex);
 	}
 
 	uvc_status_unregister(dev);
@@ -1901,6 +1909,7 @@ static void uvc_unregister_video(struct uvc_device *dev)
 	if (media_devnode_is_registered(dev->mdev.devnode))
 		media_device_unregister(&dev->mdev);
 #endif
+	mutex_unlock(&dev->lock);
 }
 
 int uvc_register_video_device(struct uvc_device *dev,

-- 
2.40.0.rc0.216.gc4246ad0f0-goog-b4-0.11.0-dev-696ae
