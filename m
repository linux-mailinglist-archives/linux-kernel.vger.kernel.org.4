Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4756060E04C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiJZMH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiJZMHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:07:14 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E70A7AB0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:06:49 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id g7so28071708lfv.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dhCAhO1KizZsj2zV3Y1+5lSZUzxRxUUnW3l6ylAL+HQ=;
        b=PariO7jBXkPxi7oaWf9UcPRM4x2uQhz0hxR0+FonRFFcZHjVos/FnvtjA2+bqitZ6o
         W8/kGkD0W67rfGi3V2wQwXRqlDB/CCEXMOqp37fpXblzvOEeXtRY8uWGPnJ3905RNRtt
         FVe8TFqdEUQ+heATy36Al/QFJSCaHzPcxD+u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhCAhO1KizZsj2zV3Y1+5lSZUzxRxUUnW3l6ylAL+HQ=;
        b=TFPFPke2C5RZ7jHINBi9yZlVMEZ1qGUtdhwnhzfPe87MvK8k+YSHXuj/0tY6ozLLFM
         C0TVP5ixQNLQvtGpyxUlpFrdNKL+uuVG194q8sUrLtYJVr5NYRTlR9rEUnG6rSo4Sz9w
         YUC/NLtT6vBspgUe+nHKF3MkNWnbl97Vc0SXFZy+bZf2DVpkBk93djt8KxvMr7qEJNhz
         85pjuclbh6NIdZoShb5rhQ/oYO5QEkEzRlSdAIFfP5y8E7unpKUz+i3FF6PAH7tqlZ35
         T8vXsbV3Q4VSUQmZru0i6k1/jtUbTtrnTEVjnKql9/4f+sFFzpdUhtFiXVWLe8hhOUwr
         d5CQ==
X-Gm-Message-State: ACrzQf2+MMqvfxMG74DTkTF4GmEXIyMhO124xa0GYBLP4Z6svXpcfQNe
        cKwIu6iUosquUdNNxP9XJSKYhuukDnr7Yvr9
X-Google-Smtp-Source: AMsMyM5LjzKcRywTls07k9t/YXG8rGkd19MTusoAXTQ+lJelo1ae3d4j3cRVczlardGMTGkyTaP7ig==
X-Received: by 2002:a17:907:80d:b0:73d:a576:dfbd with SMTP id wv13-20020a170907080d00b0073da576dfbdmr36953678ejb.402.1666785997192;
        Wed, 26 Oct 2022 05:06:37 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:b47a:bedd:2941:1e3f])
        by smtp.gmail.com with ESMTPSA id y18-20020a17090668d200b0079e11b8e891sm2892546ejr.125.2022.10.26.05.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 05:06:36 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 26 Oct 2022 14:06:09 +0200
Subject: [PATCH v3 4/7] media: uvcvideo: Cancel async worker earlier
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-powersave-v3-4-c47856d8757e@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3866; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=0D1+Lk6BVHUTakJMT2e6YiV+9G/COKgarhcWvdj4pyo=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjWSLCY04skufuVZ8dA70NgBOex3XNb/EB82CUsCFi
 nvBzkMiJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY1kiwgAKCRDRN9E+zzrEiOmwEA
 CVSrcddwfF6QWTufc7Ys/ruPXJl5EmAjMv7h8sDxHvj9MegMHgfSZqgyWun/Pj6dLp3g3Lu+zi60re
 3BvXaQmQgHK5SWKh4GXoEvkJH8DbIgLnFrrmm6GHCyXjkMyewtRIh2TN240Or6OR4Oxz98kio4RXmb
 NvvAl4fmmxh25Qlbjl9vK+aAQdUfS0EaXKavTzixC90e+OhW/cRxU9jktvDCxgHgzHIsynBJjTaMso
 +GfKwnGgZc4OVrg9FqrEebuxWADjJ1jz2iwSunKet3J/vhbu58Qkq5b4KI/5l4VEybIfs4TapiwPef
 BBRq+a2f+DeHf3iM3UhNgGgMIZwauMV4ajRruokJTcEvfutqQMN26oqoH+GvuduZGdoyI+yGKSTNz9
 694Xl6SfVTtiJjdHBdM9DlfXcg8Hr2UInKsQNJFHfCoQ7mRsHZNSqesyJymUgdrVdBraBLsHoZiSGP
 kw0uua07zdGDb/IenWWXIZCqg/LM7sLBIp80gLdxGF9hh+IvGwQodXiVojSOy7lTwSsk3ALgYC3lUf
 QNE/eyVU6259QNKStKDplBSI1ZZzizlcg1Wsq3NqjXgHL50QTpaDCEyCmjLdSPUVSS3JjV3bqs9/zY
 ZJ0ZZLIg6JJacaYsDiaz+UcCin2d5gUG4a0na0fOo/BETa5nm//aRRRu9TxQ==
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
index ac87dee77f44..70d081c9a9fe 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1901,6 +1901,7 @@ static void uvc_unregister_video(struct uvc_device *dev)
 
 	if (dev->int_ep)
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
