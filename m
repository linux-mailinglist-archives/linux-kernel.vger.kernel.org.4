Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1857E60E041
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbiJZMG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbiJZMGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:06:53 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949F5900EA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:06:40 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 21so7093120edv.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDPnZhTHnC4+BSDfJv5rTOVlgproVfPQyGRqh6zlgLY=;
        b=L+9Uc0J/EhrK8OXL1VuwO8chMxPeDc5rrdSRU7bLVh7gXOg+j31XSSr5DiIl/lMmAN
         Leo7OSLPnGCs6uKE3GSCPDhKgl4mvmbivEHVqaw/lYPmum8BN1+MTRaAOPzs3Zpb1Mws
         wNqqTVd2x7TgFdQTeLRu+rE8Vl421jPR+4BhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDPnZhTHnC4+BSDfJv5rTOVlgproVfPQyGRqh6zlgLY=;
        b=oZcMHN8mv0ifznOKgOVBR+kVoWsZmB+wUq1eaaXAqVOi0VHb/9XBxsB65uPw7wuyYb
         BuF/RrkoVEvQ9oaA0E+vfuBySOHZ1rFo6D6egiBnsDwt22Fh96Pw7Pvx/jWe7Rk+s3gJ
         gbbABhCsjHths+pIGjCgkGTdnwEb7Y1ekRZdICOviD474kQhAi3SqFHf5SeLH10X8tIz
         wts9MpNbToOBTS1IGHHgCBPgpOekn9/KtYV1PGwKpkM1+DnuVBJk7n0C1II/U9hfZGrH
         qxRoIWpCLLlQZtHcT5uV8q4d6wCR5bFnNKf8CZYXMMk1qFlNKifTvhn0lfASjtwEh3Zx
         jQdg==
X-Gm-Message-State: ACrzQf3x6WgtDU49IyuVVoBS14uPw8e74nBauaG897MVZ0DN4ZDw/D/O
        hvB12ZQLW5k+4SYMfhGI/afQPA==
X-Google-Smtp-Source: AMsMyM6c0SM5TK9QH+63RO8Y8mYjtDa6DQmBHzN1JEXSorzEAwijzhy0A7secNMk0whm7axkCOCxGQ==
X-Received: by 2002:a05:6402:4445:b0:461:b506:de51 with SMTP id o5-20020a056402444500b00461b506de51mr16295359edb.388.1666785999168;
        Wed, 26 Oct 2022 05:06:39 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:b47a:bedd:2941:1e3f])
        by smtp.gmail.com with ESMTPSA id y18-20020a17090668d200b0079e11b8e891sm2892546ejr.125.2022.10.26.05.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 05:06:38 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 26 Oct 2022 14:06:11 +0200
Subject: [PATCH v3 6/7] media: uvcvideo: Lock video streams and queues while
 unregistering
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-powersave-v3-6-c47856d8757e@chromium.org>
References: <20220920-resend-powersave-v3-0-c47856d8757e@chromium.org>
In-Reply-To: <20220920-resend-powersave-v3-0-c47856d8757e@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Max Staudt <mstaudt@chromium.org>,
        linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4894; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=HlIWUJ62M0kPqi0HzBoxVqaSaBvxV//ACPhATfL1bx8=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjWSLE8h3ON1ke3QBn4Z1ZWRgSwdPMJouexkwLx94p
 AANcweeJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY1kixAAKCRDRN9E+zzrEiAAjD/
 wJh1z+QuEXCHql4pl30VsduTLXic9hcSwbyq7NHRhZEGbSy8u4m1BEQnpEfz1b3lxUcVLTAGfKVuQ6
 M1Qcy3mOFJI6J42Rm2Ojs7lbEMT9ozmmNqD+5WR9jU7fki5zeY+QvKRNqIituokFvNe+vRIjut7oxB
 LO9Rm0T1ssFHXxNoKbt1F0/vsZ4J2WjKoNKf80+5P1O6s7aE4DTZDCFWpZMr1aPcp3RqsZI4Wb3l7A
 /Vo04sTVpaenIzPXHtiWWwI+Q/IepizKN8Cctp4wth1kbqY4z9wAYMqjbNdYssg5ei+hzrnED19rvG
 aARy73GY6tu+pU6+maVC+KyEezqIAayzTGAANAsYk1Liub0DSnRHi65F0rMUlmvTr7MLYPTqXeUWeO
 jzHhqB0X8fkzUsvHKjEzj1U8ACtjYRWbG3PRxQ8q7dyMnpsdhbSpsyqKL7Zp2vKeyNz0CRjttRDDch
 7/g2hJxp36u4Ozn2ECTUfkODzsgQlO9DGQUxLUMQvu7vW/4wJ2WDm3sNM1QvqOgthyaxWvgZuQY816
 9pMfXd8eGV1V4fQBEVneWcSMB0HZiv23pGg51Rgss3W9YGYG4hj8MasT/p3flG7P5ORaS/SFTS6G+G
 lDF7O+iCmcjZ6idEgKL3yVoLuP02GcfV5NGMabHflmus5jfnFTynjM9Ou28g==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index dc43100d0f95..b67d753d27ae 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1889,16 +1889,24 @@ static void uvc_unregister_video(struct uvc_device *dev)
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
 
 		vb2_queue_release(&stream->queue.queue);
+
+		mutex_unlock(&stream->queue.mutex);
+		mutex_unlock(&stream->mutex);
 	}
 
 	if (dev->int_ep)
@@ -1911,6 +1919,8 @@ static void uvc_unregister_video(struct uvc_device *dev)
 	if (media_devnode_is_registered(dev->mdev.devnode))
 		media_device_unregister(&dev->mdev);
 #endif
+
+	mutex_unlock(&dev->lock);
 }
 
 int uvc_register_video_device(struct uvc_device *dev,
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 77b687c46082..b4f2da336def 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -37,14 +37,20 @@ static int uvc_pm_get(struct uvc_streaming *stream)
 	if (ret)
 		return ret;
 
+	mutex_lock(&stream->dev->lock);
+
+	if (!video_is_registered(&stream->vdev))
+		goto done;
+
 	if (!stream->dev->int_ep)
-		return 0;
+		goto done;
 
-	mutex_lock(&stream->dev->lock);
 	if (!stream->dev->users)
 		ret = uvc_status_start(stream->dev, GFP_KERNEL);
 	if (!ret)
 		stream->dev->users++;
+
+done:
 	mutex_unlock(&stream->dev->lock);
 
 	if (ret)

-- 
b4 0.11.0-dev-d93f8
