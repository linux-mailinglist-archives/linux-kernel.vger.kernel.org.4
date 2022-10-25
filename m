Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D7360CF28
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbiJYOfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiJYOfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:35:20 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B21292F44
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:35:17 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bj12so12907136ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KvGsjskLZRNKygMGJ72lSJUoo6AJ3rOQ6/7RzoglZg8=;
        b=I4lq41owIEKs6FfUYkPvTw8hJ5RUkfEADXJCABfFBjTkDUumGSSbh87hiz1PZenvuG
         o5KrsJCRigJshepcumssIl4Hgqt8TQ6wpenI89tYxdFsJn77X3HQiTGT3FdReqHmoPRO
         j0tn18aDbDI1Z45O1D6Lgxa2qOl250o9EocGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvGsjskLZRNKygMGJ72lSJUoo6AJ3rOQ6/7RzoglZg8=;
        b=JPL4sDubi30SWMkZTjWyx3+OfXBaHTMvrrzODpWYqWScZzfPUn/llk061M6iFxE+im
         XO4QIPhjwqmkePQXfwBHi5zM9EKpU7AkUBNhMsgIvlaD1Vb4tKYgEIF8E7oFgKusGfNl
         z2JH5sHf+q2H0u3XFIdDnTo5dX+PL0PPIZ61DgtDcdZgqPwa3Mp6Q/zENJBvGJp3eKWZ
         Wr98rjXvyCXnvVFUlrA6AMfingj4ByrJSWGHsUvf4j5rBwHQU9miFlY0Keg/bOxoy3jo
         WBMOI5z7p3WtsX8syWsE1oackKJfCZMH1vrvhR//UxIfkE3p6cZrNH0CZAvr7/Axes4g
         3tGw==
X-Gm-Message-State: ACrzQf2PCENoQFIqA1oYebtheCBJvBMfUKGxa1/F3RrlEhFya4y8N/11
        o/bC3QwuYY8Gc38CsFurnkMB3Q==
X-Google-Smtp-Source: AMsMyM79SNVJINBvLnNZgH+FrZFXsGIcYR0CtMZbeaLNq2btEAvEEluL3w7s1VQ2Yt9ldaiuHfVL1Q==
X-Received: by 2002:a17:907:b01:b0:78d:ce3d:905d with SMTP id h1-20020a1709070b0100b0078dce3d905dmr32380992ejl.45.1666708515627;
        Tue, 25 Oct 2022 07:35:15 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:e6ae:c7ac:c234:953c])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906314900b007acd04fcedcsm631021eje.46.2022.10.25.07.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:35:15 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 25 Oct 2022 16:34:25 +0200
Subject: [PATCH v2 4/8] media: uvcvideo: Cancel async worker earlier
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-powersave-v2-4-5135d1bb1c38@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3850; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=0l2KdHP21BwHh7O1kFOKoF3d4tIlj1BptCuhhZq8++g=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjV/QVaLHI+mQrPtakacw9hVvyePqZ+MWgIM8uJidM
 E8/BakCJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY1f0FQAKCRDRN9E+zzrEiECID/
 0RWgzXkrL4a09vGFcPSax2yoszoL7vBaUlZQXK7vmTI6PDTe6GnCloeadCiIS31fThH+juyEWznqvL
 nwwKjB8lopBC6EjDOkoBPumWZ10CBPQtgOjffooREj6kR6IlflTeJ62XafEdHvyXwfsQlu0UgdHO12
 CF8Kb5RwXOpibO/wXCCTiTI9ZoFs4xPsY66Vp6SOUeMiFO3AjiCtwTgFD8NLgebhHdz+2kLsuHvHTx
 1LcPxb96dXOHmLH6r/8JlzX8I16gQzej0uP5Kom+JJhUyluB56pWM/JAxrwM3Y1vDnNVP58p4d/Ttz
 jd7E2p/INm6kkFD8dFWozf71qTDwkq9P9Mmmi+k1x2U5B4fExdBtz7MCneVodXl2jJpIZOK3pjkOkC
 2KQU2+KVQpd4vDx9VWQvsPSQIxgLKWmPfodRV9kbF8usACFYhfwFzUEV0j97LIjZWqVx/Aq95da7+O
 WVOknGfIBTJINPNgfMqx+pCaphuShOKdIK+CpyBINqnsCNbfl7Gc4ub1TUObOcvldp1cFMs2O1hj1l
 sHCmG0Ocv9tRAuDyEElUURLMgygz5wFfAzeIlOVamZuGVu7GINggogX4di/9fjKRN35ZgCmAdmjfhX
 9ghrjilTPhpjnjgpStSxyUeEePvqZ2CsZFclqW9OGHsuKyTfF422+4+4PiMw==
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
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index c95a2229f4fa..c7af3e08b2c6 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2597,14 +2597,17 @@ static void uvc_ctrl_cleanup_mappings(struct uvc_device *dev,
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
index 215fb483efb0..fb58f80f0b37 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1909,6 +1909,7 @@ static void uvc_unregister_video(struct uvc_device *dev)
 	}
 
 	uvc_status_unregister(dev);
+	uvc_ctrl_stop_device(dev);
 
 	if (dev->vdev.dev)
 		v4l2_device_unregister(&dev->vdev);
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 45310f55475f..6b07abac7034 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -739,6 +739,7 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
 int uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
 			 const struct uvc_control_mapping *mapping);
 int uvc_ctrl_init_device(struct uvc_device *dev);
+void uvc_ctrl_stop_device(struct uvc_device *dev);
 void uvc_ctrl_cleanup_device(struct uvc_device *dev);
 int uvc_ctrl_restore_values(struct uvc_device *dev);
 bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video_chain *chain,

-- 
b4 0.11.0-dev-d93f8
