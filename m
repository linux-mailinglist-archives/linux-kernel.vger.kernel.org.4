Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B5B60CF27
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiJYOfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiJYOfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:35:21 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BF19623F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:35:19 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id b2so13023034eja.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CBQi3G3Ym31IbBZKsntX/6j7yLQdhJIuZJ9n/O1WbSA=;
        b=IjtjnaitqL4YWVUyckfhshIgXOqDSQJwVkL3vu2mQ4xLMHxL/dvldbBzC935krRQ11
         ThoQfe/9ZmVJR9xGdVe49xD+ISZZz6kRFkaVl8VD77hG5C25AaD7EiilpJzTriHn38TK
         h8Dpip8/8XY32l896EkV72KqhvKco/+1rFN8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBQi3G3Ym31IbBZKsntX/6j7yLQdhJIuZJ9n/O1WbSA=;
        b=WSniylXGlHcrcgjN+ZUF9YrRJKZcfnnRkGNOtV8FOYG0/co3T9b2S3WGcIhI3j3ygO
         QCp+BVFbF1Crq9y2BDjWgOxodRCnlgE+Qu+Rhae6ayshPfgmILVAI6JEHSD+mzLZgyBE
         IuDyrnT7861c/TH+M6rOfZ09uLvbz/0svvbhsOX5nFaq9Wp+GFIQuMzI43C8dI9tl9tT
         XUh+ZxeGCAb8zQdvrPM3vbsUGVsxn2VpIOjpDxGPzy2k3OhiZxqoIC47LGHuIsZOBNAs
         NebUV6u6h/KH7rZs7kfLfwmFCuRMae4WFw004n7M3AIeMJUyB2Z0v7ryP0+GQj8xTXM6
         B5Og==
X-Gm-Message-State: ACrzQf2GKdH3cg7vO7esCfRr7BvJCbyAGIOKdQKSx3smzi5p6KjpvF3g
        T6DBq0YNN3acLP0SdBI4gIk4wA==
X-Google-Smtp-Source: AMsMyM56iCvlaSjd6gTckL2lznGsHz+xLxt6FQFcShC9bAxTNItckDBO95rvBajAVRfKDgZqHqnUeA==
X-Received: by 2002:a17:907:2672:b0:780:8bb5:25a3 with SMTP id ci18-20020a170907267200b007808bb525a3mr32505579ejc.281.1666708517878;
        Tue, 25 Oct 2022 07:35:17 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:e6ae:c7ac:c234:953c])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906314900b007acd04fcedcsm631021eje.46.2022.10.25.07.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:35:17 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 25 Oct 2022 16:34:27 +0200
Subject: [PATCH v2 6/8] media: uvcvideo: Release stream queue when unregistering
 video device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-powersave-v2-6-5135d1bb1c38@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3485; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=lnR79aPbgxGWW1+CW9B6Zk1T+xgYfHfisqEZO2U/Www=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjV/QYDKMQuekATrtARrL80BycwWYzTmtrt+zsj9AD
 Uhw4JSiJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY1f0GAAKCRDRN9E+zzrEiI6QD/
 0YKUZQY1+1WWOIAxk70HDqqWeaHrf/XJIMpizWgNm50/uF6FBK/Fj8hYdn+TwVNqn9lL7mYKzRxPag
 wlWYgRgL/E2K9QuwwdkFTsC2OLArFbm3KVaH1mCIotDg9O/TLJh2f3o8rHEXFg8GWVhkkMHMoeaQOK
 +UnpMs8fVCfDv9XOmOqP8T+tsHV7H21K5D5+6dA6ExzDQqFcU2X7fWkBwGgCA98YIOxTrlN4Ud5XWK
 nCvGc2669t2c+J1u8ZON1MCRrPb3ihRJ3qWIFLCppFhcCV8eseRKkzAUIBIjUB1AtckDWG0mMPW4RH
 Xd7iLVpcy95Leh1PlxfCDwntWwk4BX44btHUDu+MBaIxQQtQhnesSrLD9IJfQDat8gYfj1mYUaCL3F
 u2tMmFZtLHfr0XwXa15Ir4oyyPwDDPGeXpIdAAa9PddzaHuio1DgSM/pLugytcvKIKwFcwvDYCHPvm
 2lmLqG1fr3duw+kxwbnjsiqMm7B1+0OqgY8CD2NL2k2MonWEsOQFjBYJxPzhQa9IPb/ldhUqERMcwK
 YYO3w/vvBv3m5NaIBD/6MGPu7BXM/7qqu2ETJ5L2yWawxlxbQ7VdeQUwteDiVf7bByiS7xijIb+TKh
 jdweYJRY/fQklPWZZBwnEm5a367xU50ftQ6S/BYPFmav6XIg1p6aBMDxJx7Q==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 14b66019208d..f15fbdbcd8bb 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1912,6 +1912,8 @@ static void uvc_unregister_video(struct uvc_device *dev)
 
 		uvc_debugfs_cleanup_stream(stream);
 
+		vb2_queue_release(&stream->queue.queue);
+
 		mutex_unlock(&stream->queue.mutex);
 		mutex_unlock(&stream->mutex);
 	}

-- 
b4 0.11.0-dev-d93f8
