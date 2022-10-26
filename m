Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE5060E044
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbiJZMG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiJZMGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:06:40 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4C5855A8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:06:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id t15so6379381edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OMOY9ddHOZwXHSgzFPquU4QOb1r0DNXtzkX5neLlEsI=;
        b=kUE7bsYQMQMslr9SolofhiwNBs8TPpXFluH96mlsBzX3wHR4CWHUl6rEU2XdqyI8JF
         3GaE2bSFn9OtEcQjSct2AMtav+MXAZG5np1jC4bd0cBK4goPZRdJart7aq1xf7itlHkQ
         3kdkEH+L3zHF7voS8BYCVAfCL2nc1bNTUEvsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMOY9ddHOZwXHSgzFPquU4QOb1r0DNXtzkX5neLlEsI=;
        b=AdNaac7X+Xb5BCGyWFV91mh4wbSsI34RI4tbgebsO+gWABNf/mBeYwbK8nEGjjLFex
         CeoXKnZV+2y2jvV0EFBDCUlAcxb5Ks5re6e4z5uYUTfvvgqIU9rI307Ko3oS4f6wvTW+
         jioqLACmHju+3Va2fy/Spqe+UBOEozrNYbvfRyc1RvajKLkHAsvyHLgHW4E6+x5LZpFS
         NxcO6Y96CgOVLu1AiHJivv0rA2mvOgekx4+eAH7SJCA7AZ84BSkjd4oAEFFO+os/yJuV
         LFPXK5MRxfVM9Q8v2hqoJc50Hbke4akRMKJROE1Wx6Q7GFCIQUhZwj4j5V0pkyHsGkes
         tDkg==
X-Gm-Message-State: ACrzQf3RGNbH7/775Rfa9OdToafnFMTJ1w3RT7fEv4Mj7xX6wo6hkh1r
        MFKpd2It+12EvR2XWFzY/loBog==
X-Google-Smtp-Source: AMsMyM7VeS0kh9P1BpLFqqBPHDufZkoF0HozDYYJ2VuVzsoclMrg0RLsSjnK+gyV/hkARxka3ghbvQ==
X-Received: by 2002:a05:6402:1cc1:b0:45c:3a90:9499 with SMTP id ds1-20020a0564021cc100b0045c3a909499mr41281169edb.61.1666785998227;
        Wed, 26 Oct 2022 05:06:38 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:b47a:bedd:2941:1e3f])
        by smtp.gmail.com with ESMTPSA id y18-20020a17090668d200b0079e11b8e891sm2892546ejr.125.2022.10.26.05.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 05:06:37 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 26 Oct 2022 14:06:10 +0200
Subject: [PATCH v3 5/7] media: uvcvideo: Release stream queue when unregistering
 video device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-powersave-v3-5-c47856d8757e@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3480; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=APLvTWouHG6W7Hdh3pI6r+3IhJhwMwT1aCPAKGfmTl4=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjWSLDhfVyWypDVPC0JJxEfV0bmc/qRHVqOY3owrR7
 RZYSEmeJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY1kiwwAKCRDRN9E+zzrEiINUD/
 9Tq8I83z6Lg6tNvcsuCkWyM5/KaT/QDyXaNaM/rrVS8WeXY8HFa798+mQi9RaZ7fgEBZXOt6VLiM9g
 DTmY3weROqImFZ3xkflgoJNpufYIDbdhtEYuhajS6ME/n3M1K3+DN6+Ij4Mf5XyAGa7dhT0SZiZGji
 OPNSrwRSuPn7Sn5aNs3l6i4NTrHJ2a7CNBXrXXNFfRsrBrUykckaiCDdru0wzSWSQHSgBNbcKFXu93
 EzhOYnqUcR+AYKn66FiMf3oIcyJvVgQuN8hWosQNaH9oXmwi87XJzEP899lLnyXaw7D00qnYfbIKrt
 qbxtxNu2NXpzVFMNZwNADeafFOdmwAQsucdcUDdtZGqf0qxFYqEAqRIx7BXrEIt6z7pfBJMjR5lq9h
 Lc5oechRzpecNIvq56tMKMAWNNa+dwb8r7BLReXhD+0itNp/Ya2ucpRpnd5lTCEQna9EbrbR5VCmHB
 iDjfncy5wAKf5VzHIwJRU7z0dYy2K03etVb7gs9BKCNQ1ICQ/+A81KwECyHhlvpsnSNVkDjothNkBo
 E9HuAIQjml1+iWhPoQcmeXAey2NGqW4x+oe9LuTvHby1YJd2Kt7wQrjezb2cwC/OltXzNhp2F7FCa9
 u2xgAXXeXbhooW8l6NbYztriySHHRAZksfEM/iLDhz1VFLNpKvnVfuYoTZmA==
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
index 70d081c9a9fe..dc43100d0f95 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1897,6 +1897,8 @@ static void uvc_unregister_video(struct uvc_device *dev)
 		video_unregister_device(&stream->meta.vdev);
 
 		uvc_debugfs_cleanup_stream(stream);
+
+		vb2_queue_release(&stream->queue.queue);
 	}
 
 	if (dev->int_ep)

-- 
b4 0.11.0-dev-d93f8
