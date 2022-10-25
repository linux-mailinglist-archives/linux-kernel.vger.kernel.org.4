Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5773960CF2B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiJYOfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbiJYOfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:35:20 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3AB89959
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:35:18 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id t25so7498664ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1brNmOeIqvLHZriUymMjmWBOUrEuqumqBXcSDvQDmk=;
        b=kk8ztiwJk/VrU1CnULvrrSl1rCZFGsUTjAEEuzfqylHAa5owbW3dVON4IAjb8Pdm31
         yEreP1X4dIxQmO6rzP5130rr1eLwznp2BBG6IXeq9nkwqsn4QpX8ACnyFcm7MeIoBXFX
         DbQhtCVHwggkGWFOkZKvqCLgbVPUifol2GQL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1brNmOeIqvLHZriUymMjmWBOUrEuqumqBXcSDvQDmk=;
        b=FBMgPRtA2WB5gIjBLN1aIwGbc9v+rgx3AU6Owa20oluSdSdh+wkJIBNDkDGXhzpEO1
         TDpa8uzkhltoCE3hFRCj3qWjuKVGJsj8qbU9dX3ZJHsq++d8Znx6qyVbARYL0EqLHp7G
         pAAF6XkvFDzMppwN+V+EbH7x2B0j7YPpdsRdtvEX8B+6PtzAwGT7LXyWqlRYksC64Q1C
         5slJwAUa1BKSsEJCj/cWdLUg43aDS6VpJgG+6rdwrSBcDhXcQ6bS4K9UmQDRiRjZ+30G
         dmqjkO7nUo32bJq/rOT8t8ekvPQ7nx2p2vOIBRTTIcR6HfUXYvKsLmqzOVyTw5vImi7q
         tZJw==
X-Gm-Message-State: ACrzQf0y7AKAcx0D0g05XDKXTMmA7J6rjJarSTjrvw0QNi5e7mbQn2fn
        oWVTZe6gMezOgNcGBNTajfRgPw==
X-Google-Smtp-Source: AMsMyM6PFzCguJkAXuZKdCeaGzZkf14xA4WDwbOhOMT6QyqJlPAfkksQyRLrhjzPmYvYrX/6zh8+mQ==
X-Received: by 2002:a17:906:7945:b0:73b:e605:f31 with SMTP id l5-20020a170906794500b0073be6050f31mr32990283ejo.129.1666708516872;
        Tue, 25 Oct 2022 07:35:16 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:e6ae:c7ac:c234:953c])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906314900b007acd04fcedcsm631021eje.46.2022.10.25.07.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:35:16 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 25 Oct 2022 16:34:26 +0200
Subject: [PATCH v2 5/8] media: uvcvideo: Lock video streams and queues while
 unregistering
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-powersave-v2-5-5135d1bb1c38@chromium.org>
References: <20220920-resend-powersave-v2-0-5135d1bb1c38@chromium.org>
In-Reply-To: <20220920-resend-powersave-v2-0-5135d1bb1c38@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Max Staudt <mstaudt@google.com>, linux-media@vger.kernel.org,
        Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4775; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=JccDHJlMGn0ERZrldEIMeE1yCBRex4FL0yGZe55zmQk=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjV/QX1OMDpV++F5pP93hJJb0oIw/vYJZddRC/Z+bx
 i1JmOr6JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY1f0FwAKCRDRN9E+zzrEiBcVD/
 9tJaK168vSuc8YLN6Gdlp+81+REVjfDUgo3Y9xFQ1FWA39QM8iXTLnrpDs/QvjoWWSAVBu26P1hAZu
 gHtvLg5PbLy9C9V85/Zltg82NdtKHLPwMqZnun4DpizBarJe3AL3oi85mUaR0fmwoGau2WRpU26JYE
 yZFcLKLbeMfkoq4lmrJxuWry08d29JrMbPjCljOWZ0nAWgbz1Fi1xQ8i4+eIxAnmqQr6UXx9yvJuLI
 DpttCA9Sol9gHubHcqiMoqAlIz2M6ednqMzD3dbUITTViQ3W7LtoY+RQLwKEcShdmwUn7EFbK4hbn+
 QQewXQiel09f+6llZC4XOkbvjgHQEpfH7DPIIq95He3QDK33tERAYvqib+wGvfEkPdelY9hLqEwcyJ
 1kx7hgRK2NhnxfszSGvs4NgMyQT7ekk1bnwJ5axFvLpQsysyFGLK+/fDh8PEC4L4SuLxoOccC7I+rj
 oXVAC4zfEsjee/T/ljNX3YAjzZmoNxUfjL0+06my4aZGSXyE2r2H0Dn3DuOIpwcxBVIdzaCfv0WB/B
 fUrdm0/FbmjPYbthwLqljD/5DPnxNgrlV0FyDmT2F/XgYHD0gS875Kxd/AsvHqahSnvYnohLkv1Eh4
 v8o4WsVZj3dD6O9Baa6RqBj6iHuOiBnVeSJXEYXDFNHRWzW/0yeafyyzkyUw==
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
index fb58f80f0b37..14b66019208d 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1898,14 +1898,22 @@ static void uvc_unregister_video(struct uvc_device *dev)
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
@@ -1917,6 +1925,8 @@ static void uvc_unregister_video(struct uvc_device *dev)
 	if (media_devnode_is_registered(dev->mdev.devnode))
 		media_device_unregister(&dev->mdev);
 #endif
+
+	mutex_unlock(&dev->lock);
 }
 
 int uvc_register_video_device(struct uvc_device *dev,
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index f5b0f1905962..c250b628fc4f 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -38,10 +38,18 @@ static int uvc_pm_get(struct uvc_streaming *stream)
 		return ret;
 
 	mutex_lock(&stream->dev->lock);
+
+	if (!video_is_registered(&stream->vdev)) {
+		ret = -ENODEV;
+		goto done;
+	}
+
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
