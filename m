Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503D1657266
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 04:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiL1DrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 22:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiL1DrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 22:47:02 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37B565AF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 19:47:00 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id i127so13988270oif.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 19:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n0Zi/8oFccnAJnJwzjE2MMvMFl1USl7X1V+QLXXfx74=;
        b=c7i/gTVaQnojibtdF4t3mojGVNE09BhSrpBNVPHWkeJAvegoTQd4EMiQHtYMLmnIru
         DWHdODQSO4wud0LBrOvIa7tkUh0VhYHDrI/W+e8CNYewQ1KbBO5iA+wr/FV1vqe4oORF
         XXiUT1E77jYOmWULBMiuY6+v0qMYSijIpLdu6sPDlR0xfJQXZ3MAYjQxXg/o79OBCo7h
         jBP0qpyGPIWu1tWWRHEj9oiN9EMFjNZfdaur2fR4jhztvFTArB7aw1/RFcH7p/sXr7uE
         RPSxQvNrHbI2Q9mLcs3P/7NC24DWio0hsv5mfljJsmDcjoyWCu13kI0GHb82a8CUKnoz
         BhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0Zi/8oFccnAJnJwzjE2MMvMFl1USl7X1V+QLXXfx74=;
        b=NT2kzPVADmBfQUu52OQ0RUu9sW9R4s32YqoK+HjmhIDW0WUPhfUAFhRNOQxTjsDCyT
         OpYLy1EX8X2Minm7qm/nnB9cprwVUNjCOAOARvT/rM/KJCCi7ZFpCjkbRi7I6ph+snEz
         Hck4UcAlOta8RRGmI63UU+tJQhY2T9p79JhzU1UgnpkhSLdStcIift/9prK8Abo+Yuu8
         XvSWAp+J+sTwZoTDB+2vCmPyDeBMbsOj/x1ZOZtLhHliyw3mtCcQhvVhnLB9qw9CK1Cd
         5dqFXUCxrUzZ1JPdb9QHpDGZbuUgr8etFbhJICjvwWhZe0BNoY3jHBXwOgDISfhUW8GJ
         BQoQ==
X-Gm-Message-State: AFqh2kphxssCrxr9rWRe8oj0odXo1yDHeiNBQojdX7YF6H4uwptAZBrS
        7UdR91poZbM+F+mJ15U/8Ufdl8JbbME=
X-Google-Smtp-Source: AMrXdXur7C38OYX0NVQuL0C+p0Mvq+iAcLtf6wfIooLQ+ooi5G/roIy9xDdNWpfqiW3AHgGo7fBRHQ==
X-Received: by 2002:aca:1717:0:b0:35e:2d60:32d9 with SMTP id j23-20020aca1717000000b0035e2d6032d9mr10419647oii.27.1672199220291;
        Tue, 27 Dec 2022 19:47:00 -0800 (PST)
Received: from protoss.cs.ucr.edu (protoss.cs.ucr.edu. [169.235.26.60])
        by smtp.gmail.com with ESMTPSA id j6-20020aca1706000000b0035a64076e0bsm6516663oii.37.2022.12.27.19.46.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2022 19:46:59 -0800 (PST)
From:   Hang Zhang <zh.nvgt@gmail.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, Hang Zhang <zh.nvgt@gmail.com>
Subject: [PATCH] mailbox: mailbox-test: fix potential use-after-free issues
Date:   Tue, 27 Dec 2022 19:46:17 -0800
Message-Id: <20221228034617.58386-1-zh.nvgt@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mbox_test_message_write() is the .write handler of the message
debugfs interface, it operates on global pointers "tdev->signal"
and "tdev->message" (e.g., allocation, dereference, free and
nullification). However, these operations are not protected by any
locks, making use-after-free possible in the concurrent setting.
E.g., one invocation of the handler may have freed "tdev->signal"
but being preempted before nullifying the pointer, then another
invocation of the handler may dereference the now dangling pointer,
causing use-after-free. Similarly, "tdev->message", as a shared
pointer, may be manipulated by multiple invocations concurrently,
resulting in unexpected issues such as use-after-free.

Fix these potential issues by protecting the above operations with
the spinlock "tdev->lock", which has already been deployed in other
handlers of the debugfs interface (e.g., .read). This patch introduces
the same lock to the .write handler.

Signed-off-by: Hang Zhang <zh.nvgt@gmail.com>
---
 drivers/mailbox/mailbox-test.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index 4555d678fadd..b2315261644a 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -97,6 +97,7 @@ static ssize_t mbox_test_message_write(struct file *filp,
 	struct mbox_test_device *tdev = filp->private_data;
 	void *data;
 	int ret;
+	unsigned long flags;
 
 	if (!tdev->tx_channel) {
 		dev_err(tdev->dev, "Channel cannot do Tx\n");
@@ -110,9 +111,12 @@ static ssize_t mbox_test_message_write(struct file *filp,
 		return -EINVAL;
 	}
 
+	spin_lock_irqsave(&tdev->lock, flags);
 	tdev->message = kzalloc(MBOX_MAX_MSG_LEN, GFP_KERNEL);
-	if (!tdev->message)
-		return -ENOMEM;
+	if (!tdev->message) {
+		ret = -ENOMEM;
+		goto out_1;
+	}
 
 	ret = copy_from_user(tdev->message, userbuf, count);
 	if (ret) {
@@ -143,6 +147,8 @@ static ssize_t mbox_test_message_write(struct file *filp,
 	kfree(tdev->signal);
 	kfree(tdev->message);
 	tdev->signal = NULL;
+out_1:
+	spin_unlock_irqrestore(&tdev->lock, flags);
 
 	return ret < 0 ? ret : count;
 }
-- 
2.39.0

