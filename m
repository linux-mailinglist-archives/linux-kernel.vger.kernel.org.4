Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA93F603907
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJSFCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJSFCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:02:22 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205085D0E0;
        Tue, 18 Oct 2022 22:02:22 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so16003385pjl.0;
        Tue, 18 Oct 2022 22:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c9jcb0BVNFyrBxDLT90bHuWVyiFHHn8ilA4qT/fpwHM=;
        b=fIOzqk7hnn0QatrpS1XHts+WVW6tqSVCyKQVa4XLm69MJJjtDa3N56GitZSrtMTiIP
         BR8R8MxyHCsQiTQe/h1bQ1aD7HnNHa6Ha7kCOb2KMSiXBzGgBOHydZ6hn2m0KG8+o49Y
         yFTic4CUWxzxmYYYyaGCxLGlnlde+YFxz/XtiQ8vLfmbCSpLRLYJzfJwNF7RGX/0zxla
         QrE1nSSnQGk/BztbyuYcG/5YmhZDmBCh/Z9ejJTVwUatny07jwKm5ClbBRCPG5pRbK1T
         46bQxK8QlRYJeExt4Z9tDY2JcYDqIMrwEQ1l84ixbjIVy3yIIshmUSdrqBfF6pfz03yi
         GrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9jcb0BVNFyrBxDLT90bHuWVyiFHHn8ilA4qT/fpwHM=;
        b=2qCLpjVGZWC4uANOD+BTSpUjohvE0WeCDOuSp6yFraq8W48y/MlS1SfuJOCxXMwD1p
         25dk5+keM7Xl43+eXnQ99Tw91d84fnXuTDSNTpvnHuxEh50ijstzaH/4H0lySU8ANUs+
         jZRQnF70VWzDFdJ4QUMwnPqdNQL+KR+Vr5Kkk5TWqkoU/Y4BEORkyBSfbyeu6XxLYhb8
         Kd+IcRdSN7xR8Uzfto2BYncpC3o7deBbMQD2OeuQcWwwaTr1eicjLmvRrBv3pGZrVq89
         Egh3tQTFeR+zt1xqvqSq1jN68/rO5Jyh9/xHdv8gzaUtGzCkwtBc+oVUW0eWeQUxzW7/
         KCQA==
X-Gm-Message-State: ACrzQf2AKj0iBKxBC8Y6lFjQrxKJc3+WdhttNDR1y9Y+hZzxgiY2RT1m
        6d5raf5dTC4PyZSIiyVwqZ/vuuMSPj2i/iHG
X-Google-Smtp-Source: AMsMyM6dgUzLMvUfwtCjTRc3B7T9MZodzcryVcMK7ke0nnjIjCCtzYQKlG4DoNwARh4t89Hc/Zsajw==
X-Received: by 2002:a17:90b:3908:b0:20d:4151:1b73 with SMTP id ob8-20020a17090b390800b0020d41511b73mr7669815pjb.45.1666155741562;
        Tue, 18 Oct 2022 22:02:21 -0700 (PDT)
Received: from biggie.. ([103.230.148.187])
        by smtp.gmail.com with ESMTPSA id y12-20020a63fa0c000000b0045dc85c4a5fsm9094516pgh.44.2022.10.18.22.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 22:02:20 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     sean@mess.org, mchehab@kernel.org
Cc:     Gautam Menghani <gautammenghani201@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+0c3cb6dc05fbbdc3ad66@syzkaller.appspotmail.com
Subject: [PATCH] drivers/media/rc: Fix a race condition in send_packet()
Date:   Wed, 19 Oct 2022 10:32:14 +0530
Message-Id: <20221019050214.107448-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function send_packet() has a race condition as follows:
func send_packet()
{
    // do work
    call usb_submit_urb()
    mutex_unlock()
    wait_for_event_interruptible()  <-- lock gone
    mutex_lock()
}

func vfd_write()
{
    mutex_lock()
    call send_packet()  <- prev call is not completed
    mutex_unlock()
}

When the mutex is unlocked and the function send_packet() waits for the
call to complete, vfd_write() can start another call, which leads to the
"URB submitted while active" warning in usb_submit_urb(). 
Fix this by removing the mutex_unlock() call in send_packet() and using
mutex_lock_interruptible().

Fixes: 21677cfc562a ("V4L/DVB: ir-core: add imon driver")
Link: https://syzkaller.appspot.com/bug?id=e378e6a51fbe6c5cc43e34f131cc9a315ef0337e
Reported-by: syzbot+0c3cb6dc05fbbdc3ad66@syzkaller.appspotmail.com

Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
 drivers/media/rc/imon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index 735b925da998..91d8056666ec 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -646,15 +646,14 @@ static int send_packet(struct imon_context *ictx)
 		pr_err_ratelimited("error submitting urb(%d)\n", retval);
 	} else {
 		/* Wait for transmission to complete (or abort) */
-		mutex_unlock(&ictx->lock);
 		retval = wait_for_completion_interruptible(
 				&ictx->tx.finished);
 		if (retval) {
 			usb_kill_urb(ictx->tx_urb);
 			pr_err_ratelimited("task interrupted\n");
 		}
-		mutex_lock(&ictx->lock);
 
+		ictx->tx.busy = false;
 		retval = ictx->tx.status;
 		if (retval)
 			pr_err_ratelimited("packet tx failed (%d)\n", retval);
@@ -955,7 +954,8 @@ static ssize_t vfd_write(struct file *file, const char __user *buf,
 	if (ictx->disconnected)
 		return -ENODEV;
 
-	mutex_lock(&ictx->lock);
+	if (mutex_lock_interruptible(&ictx->lock))
+		return -ERESTARTSYS;
 
 	if (!ictx->dev_present_intf0) {
 		pr_err_ratelimited("no iMON device present\n");
-- 
2.34.1

