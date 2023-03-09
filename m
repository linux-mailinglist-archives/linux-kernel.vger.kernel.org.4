Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13C36B2794
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjCIOqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjCIOpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:45:05 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DE1E8A8B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:44:22 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id j11so7952407edq.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 06:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678373060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqmvUbZhLfOLwhFDS2wZLjxzrgKFRfOQHbUU0CPsFYY=;
        b=VKrNMvZPlKm1Qz4l+fhTQC7XAAcpAauJauBDIzx9QoOHSHipsD306AV7r1NqL6TaF9
         ekGVH1m7BoCibiMaXP4121CJHRm40qye645wa5lXUYx4vN4y5atPzSIZpCJnDVLKBYQg
         GMZXkoMsZfCGgDE48E5JcNx6EQ6rH6ymeI6DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678373060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqmvUbZhLfOLwhFDS2wZLjxzrgKFRfOQHbUU0CPsFYY=;
        b=EK21cldialtGxs7khm8fa2234/WE0b8nL3X32rcEuRbipJEc5+qEfHyBAZlDoiRDiG
         gxnAGGglW9Nx3EFtysvlB1wM8vinbmK+2ALeEdulI8FYLZvgTCfu7GvTbls4z/6StEJP
         qRKE1cAIkAxUbt6uoZ6134fTKBDeVKnPi+st+Ae9SDuVQYM+UDRZt2iSFVys5tK7FZWv
         WFdkaLVgclmzmSAHOM5YSAa/9/T/YflbidFzeLi2kElm61jKN1p4YR4eq2njEhubAs43
         IzWteBIBSX/CgXXO8idoIkXOdYV6fCFvjPkiLwuOX/gDKgnwqwmkUPiuvc+IsfgIl4hQ
         d4KA==
X-Gm-Message-State: AO0yUKV5Txf8ij2LeeZ1unI963kzp+rhNYu8YXdChpw0aeD8Ckiu46LM
        9GkgNR58grA9Yayj5pgxyyNvDA==
X-Google-Smtp-Source: AK7set9+/MuV+LFCg5aZ2c/GZhF+5kEy6+jk9dhV/nNG+hcAYVLtkzyHCM28rTHNrAkTG3Z5hRu93A==
X-Received: by 2002:a17:906:da89:b0:8b1:7de6:e292 with SMTP id xh9-20020a170906da8900b008b17de6e292mr29214835ejb.9.1678373060768;
        Thu, 09 Mar 2023 06:44:20 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:1645:7aa4:a765:1966])
        by smtp.gmail.com with ESMTPSA id l6-20020a50d6c6000000b004bdcc480c41sm9708931edj.96.2023.03.09.06.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 06:44:20 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 09 Mar 2023 15:44:05 +0100
Subject: [PATCH v2 1/3] media: uvcvideo: Cancel async worker earlier
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230309-guenter-mini-v2-1-e6410d590d43@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4230; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=c4r9Zh1+85Fx2Zh7mY0BgdJ1GoRPl8v5yT/Vrh7HusA=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkCfC9Wtr20EFiqZKoGO6jW6rq3jpfSZDg8FcEUYBd
 fOXf4dqJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZAnwvQAKCRDRN9E+zzrEiHpAD/
 9zHvYkkEbMQEPYZu3fsJnJjirfXct3kHO7LHKKArNySruobQeuVulNDi4chIzFt3atGrtwUFlrz63/
 XQJgEqyJT/t1ZFWDON120/lnUk5OOWbvc36uclhNdJKLnghbdgYSCdbblZrLzYqHcCs+oIJ+yFw4ZA
 9rNgDpnFbjn4lrd1TyMUqIsEE7n4ZVuQfV8Q2sIPAh+fxqcr9MIstymbE5BANTHzroshhfxxIBhLNr
 1G37pGkyqEd67SHwc16tWa3Tur7lghpgKacL7J7rFDiy+PyiEjBZl01ay+LYAskZlMfh2bAUUgQigy
 +rzB4PQsCzHn3FhTojVlB4eE1dZP6/WEu4d/Yv/8dyRTgUlB9289RJXL26PXCIqYZIBvfRAKtICX+E
 fFWtdoeg3jIuBsi6SG8VSsgh3TP39BZlmvZpLYFXCBoD9Ra7p4QCcsx6Kj9ryDIUo9f2cCOyYsJAhU
 VYdAFs9WkHzTqSqpoBoOIblfy5WO9SrH+glqpjSFBcLKO8+U9NmCucC341czL5fBoW2/Jyw3d0PzH+
 LSIKtRa6+zspflNkqtBN7JCphrXqVMeW2LqyJ9dUxdssmJLBnkmrHeqIQCNygnhknWBXacUYUhPTFO
 511Q+7FK6qqsFISv8cRaVgg9WW5MUvD8T8GjI7dM9q6SaxVL/6wHmWFm7P3w==
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

So far the asynchronous control worker was canceled only in
uvc_ctrl_cleanup_device. This is much later than the call to
uvc_disconnect. However, after the call to uvc_disconnect returns,
there must be no more USB activity. This can result in all kinds
of problems in the USB code. One observed example:

URB ffff993e83d0bc00 submitted while active
WARNING: CPU: 0 PID: 4046 at drivers/usb/core/urb.c:364 usb_submit_urb+0x4ba/0x55e
Modules linked in: <...>
CPU: 0 PID: 4046 Comm: kworker/0:35 Not tainted 4.19.139 #18
Hardware name: Google Phaser/Phaser, BIOS Google_Phaser.10952.0.0 08/09/2018
Workqueue: events uvc_ctrl_status_event_work [uvcvideo]
RIP: 0010:usb_submit_urb+0x4ba/0x55e
Code: <...>
RSP: 0018:ffffb08d471ebde8 EFLAGS: 00010246
RAX: a6da85d923ea5d00 RBX: ffff993e71985928 RCX: 0000000000000000
RDX: ffff993f37a1de90 RSI: ffff993f37a153d0 RDI: ffff993f37a153d0
RBP: ffffb08d471ebe28 R08: 000000000000003b R09: 001424bf85822e96
R10: 0000001000000000 R11: ffffffff975a4398 R12: ffff993e83d0b000
R13: ffff993e83d0bc00 R14: 0000000000000000 R15: 00000000fffffff0
FS:  0000000000000000(0000) GS:ffff993f37a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000ec9c0000 CR3: 000000025b160000 CR4: 0000000000340ef0
Call Trace:
 uvc_ctrl_status_event_work+0xd6/0x107 [uvcvideo]
 process_one_work+0x19b/0x4c5
 worker_thread+0x10d/0x286
 kthread+0x138/0x140
 ? process_one_work+0x4c5/0x4c5
 ? kthread_associate_blkcg+0xc1/0xc1
 ret_from_fork+0x1f/0x40

Introduce new function uvc_ctrl_stop_device() to cancel the worker
and call it from uvc_unregister_video() to solve the problem.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c   | 11 +++++++----
 drivers/media/usb/uvc/uvc_driver.c |  1 +
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 5e9d3da862dd..769c1d2a2f45 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2757,14 +2757,17 @@ static void uvc_ctrl_cleanup_mappings(struct uvc_device *dev,
 	}
 }
 
-void uvc_ctrl_cleanup_device(struct uvc_device *dev)
+void uvc_ctrl_stop_device(struct uvc_device *dev)
 {
-	struct uvc_entity *entity;
-	unsigned int i;
-
 	/* Can be uninitialized if we are aborting on probe error. */
 	if (dev->async_ctrl.work.func)
 		cancel_work_sync(&dev->async_ctrl.work);
+}
+
+void uvc_ctrl_cleanup_device(struct uvc_device *dev)
+{
+	struct uvc_entity *entity;
+	unsigned int i;
 
 	/* Free controls and control mappings for all entities. */
 	list_for_each_entry(entity, &dev->entities, list) {
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 7aefa76a42b3..4be6dfeaa295 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1893,6 +1893,7 @@ static void uvc_unregister_video(struct uvc_device *dev)
 	}
 
 	uvc_status_unregister(dev);
+	uvc_ctrl_stop_device(dev);
 
 	if (dev->vdev.dev)
 		v4l2_device_unregister(&dev->vdev);
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 9a596c8d894a..50f171e7381b 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -760,6 +760,7 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
 int uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
 			 const struct uvc_control_mapping *mapping);
 int uvc_ctrl_init_device(struct uvc_device *dev);
+void uvc_ctrl_stop_device(struct uvc_device *dev);
 void uvc_ctrl_cleanup_device(struct uvc_device *dev);
 int uvc_ctrl_restore_values(struct uvc_device *dev);
 bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video_chain *chain,

-- 
2.40.0.rc0.216.gc4246ad0f0-goog-b4-0.11.0-dev-696ae
