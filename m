Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051A76B2798
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjCIOqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjCIOpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:45:09 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBECFD2A5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:44:23 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id cy23so7836620edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 06:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678373062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RGloBNHxOua9Iw1+mH1830UlqyJSA0ubuVXGPR5VpVE=;
        b=Bf5APZdqT3K6VVDk4+ybnR0BxTte+I0bAOPPNfDGeIlJ3IUIoKDg0Z2QNBneKc+yR3
         sxRjPLLStzOPLh8F3CjUTPmckywHqjgwWG/pzBIEkMvblzkmXWglK19wRZ+EIWlfySkz
         A6opliPI5NIXQP1M/HGCVsKowTNSqaOcuJPUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678373062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGloBNHxOua9Iw1+mH1830UlqyJSA0ubuVXGPR5VpVE=;
        b=TSEg3zDEwKdYNe8DWExawOmuoRBgISE0Hg6anrtxWzWS0+QimzvcTtnhNwnGmdYO+J
         n2UAN3VoxK3Nyt/4jOdj2Zw12EUI4m5IlmENwmEOXS6jke7GzjYbwtipaxhajlgr27/w
         3y47KwRVDA1rCXSeFQStxuvkL2HlXm+qnehGkuzXpDjwEyqADtYXjoWKS5GSbHdSoV9M
         2LuyTxe7sU3A5fPgxWWWMaSYxNIoRVBGPIKOg6NT9xYzNP4eOFNfq4gdFg1nrXudEy3T
         iQEG7ysoyX2u/zkcLp4d4ogd1oHqQmRqQCmSaZ7n6QHJLNr1Y/VU7dFNA1Sae2xQFKr1
         qCFw==
X-Gm-Message-State: AO0yUKWNSyQj75fph2bsQz5FLldWdmCs0Ljf0XMLnfT3TbhokB8Zw9Jx
        quSqB9rWeSyF7FX4+oHd+gkbdg==
X-Google-Smtp-Source: AK7set/ZeYuFKvSKId7fT7aGQyo38zgWhAUxXKPGVMvvkNp7gTgoUVbVjmWea+Tr46T+6j1NyIdGoQ==
X-Received: by 2002:a17:906:8145:b0:8f4:9ef9:27bd with SMTP id z5-20020a170906814500b008f49ef927bdmr25149983ejw.12.1678373062394;
        Thu, 09 Mar 2023 06:44:22 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:1645:7aa4:a765:1966])
        by smtp.gmail.com with ESMTPSA id l6-20020a50d6c6000000b004bdcc480c41sm9708931edj.96.2023.03.09.06.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 06:44:22 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 09 Mar 2023 15:44:07 +0100
Subject: [PATCH v2 3/3] media: uvcvideo: Release stream queue when
 unregistering video device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230309-guenter-mini-v2-3-e6410d590d43@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3750; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=BOH3IOWNxfqaNBRdefVmQLKOUCCvdngRMwRhJ9U9HtI=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkCfDBZZCAsDZoV+Uj3AcB7rPDnPOlhvem/gT0dPE9
 2SpUApKJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZAnwwQAKCRDRN9E+zzrEiMT5D/
 sFKGVLG1o4uVDZBkY8X9lWNriff4Ta2f7S0CWt4L9/JAAe98LBiZ7hq2HU4+hQnCSnAI6v8L0nY4vb
 Yuxpxfdslfvd7shxhsnQjkzVZGOCRMunmlGvInbhuraUzhD0Boyx6JUQtVhAx0LKflsHoTw3ASMWxJ
 nsxF/pnwRTb52pNpJzIM7kQGy4OjRhEgUEK2lAubcW71BtpxtVLIx8pSxuxEdqH9OuhuVGsEed5bpp
 SieEJKZBgxmG+293HdxXjOJ6zqvesWFEc8KF8p65fpFDTaDntRLwsTZ9sDoMO5KKTPpNeUoeQNMZrj
 ACzcLcfrmJ+F+0tMj0XjMXt9Pe0biHjiKtgYF0pTS7J8oolssixQo8XkDcX7hqLCK8gqonPbD8uEij
 g0YO4/AmSWNEDYjzUAuVzSphq97xzZbCv3LO2+jl91MpD6gTyQ+p0X/61R6laOiBg2mcRvyN0Wu/J9
 k1pB7E72K0NUS4u332k8IQIHDthh3cL6U7prZrX24NIYhit8yKUOljIJjEJgNETD9qRICvHfMjTKne
 Zh09PpX3bz0Abk2vPU8QCAxNkPyolxWCyrFoFOwTGBhZa9shA3UOAg9LA0UQZoOrdjUKk8ZriLqT/s
 Kynw4i7b89LXM+U7HGaeAyhZHbZnKgQg+nGsFlAhVHArQAxqzkiNBCMwpmrA==
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

The following traceback was observed when stress testing the uvcvideo
driver.

config->interface[0] is NULL
WARNING: CPU: 0 PID: 2757 at drivers/usb/core/usb.c:285 usb_ifnum_to_if+0x81/0x85
^^^ added log message and WARN() to prevent crash
Modules linked in: <...>
CPU: 0 PID: 2757 Comm: inotify_reader Not tainted 4.19.139 #20
Hardware name: Google Phaser/Phaser, BIOS Google_Phaser.10952.0.0 08/09/2018
RIP: 0010:usb_ifnum_to_if+0x81/0x85
Code: <...>
RSP: 0018:ffff9ee20141fa58 EFLAGS: 00010246
RAX: 438a0e5a525f1800 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff975477a1de90 RSI: ffff975477a153d0 RDI: ffff975477a153d0
RBP: ffff9ee20141fa70 R08: 000000000000002c R09: 002daec189138d78
R10: 0000001000000000 R11: ffffffffa7da42e6 R12: ffff975459594800
R13: 0000000000000001 R14: 0000000000000001 R15: ffff975465376400
FS:  00007ddebffd6700(0000) GS:ffff975477a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000012c83000 CR3: 00000001bbaf8000 CR4: 0000000000340ef0
Call Trace:
 usb_set_interface+0x3b/0x2f3
 uvc_video_stop_streaming+0x38/0x81 [uvcvideo]
 uvc_stop_streaming+0x21/0x49 [uvcvideo]
 __vb2_queue_cancel+0x33/0x249 [videobuf2_common]
 vb2_core_queue_release+0x1c/0x45 [videobuf2_common]
 uvc_queue_release+0x26/0x32 [uvcvideo]
 uvc_v4l2_release+0x41/0xdd [uvcvideo]
 v4l2_release+0x99/0xed
 __fput+0xf0/0x1ea
 task_work_run+0x7f/0xa7
 do_exit+0x1d1/0x6eb
 do_group_exit+0x9d/0xac
 get_signal+0x135/0x482
 do_signal+0x4a/0x63c
 exit_to_usermode_loop+0x86/0xa5
 do_syscall_64+0x171/0x269
 ? __do_page_fault+0x272/0x474
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7ddec156dc26
Code: Bad RIP value.
RSP: 002b:00007ddebffd5c10 EFLAGS: 00000293 ORIG_RAX: 0000000000000017
RAX: fffffffffffffdfe RBX: 000000000000000a RCX: 00007ddec156dc26
RDX: 0000000000000000 RSI: 00007ddebffd5d28 RDI: 000000000000000a
RBP: 00007ddebffd5c50 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00007ddebffd5d28
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

When this was observed, a USB disconnect was in progress, uvc_disconnect()
had returned, but usb_disable_device() was still running.
Drivers are not supposed to call any USB functions after the driver
disconnect function has been called. The uvcvideo driver does not follow
that convention and tries to write to the disconnected USB interface
anyway. This results in a variety of race conditions.

To solve this specific problem, release the uvc queue from
uvc_unregister_video() after the associated video devices have been
unregistered. Since the function already holds the uvc queue mutex,
bypass uvc_queue_release() and call vb2_queue_release() directly.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 9fda863ec446..23d839f74ca5 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1896,6 +1896,8 @@ static void uvc_unregister_video(struct uvc_device *dev)
 
 		uvc_debugfs_cleanup_stream(stream);
 
+		vb2_queue_release(&stream->queue.queue);
+
 		mutex_unlock(&stream->queue.mutex);
 		mutex_unlock(&stream->mutex);
 	}

-- 
2.40.0.rc0.216.gc4246ad0f0-goog-b4-0.11.0-dev-696ae
