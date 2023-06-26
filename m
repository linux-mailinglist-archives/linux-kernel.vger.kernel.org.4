Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B09173E29A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjFZO6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjFZO6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:58:05 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C306B6;
        Mon, 26 Jun 2023 07:58:04 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b7ef3e74edso6496965ad.0;
        Mon, 26 Jun 2023 07:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687791484; x=1690383484;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIMrqRzfHWub21vEUbdFKshCviaaEWMt8gPIlJYyDLs=;
        b=U3ungQ8fHGGcylMOOqosJmHJnlcU3sF1O5EBKBNmbK3L8gpr4hBUl2IOnXWCtVEviy
         pzVCANghGEst5HffgmXoBrrRO/d9bU7h0g5vtpOUmWpjTcsiiPDcvSVINcBsY75/n318
         teLsU0BIeSZtaUMn6jRwd8fbxrmH6Bez5K0joaEJ/z6VTTeu+mKXXbSmDisCMZ3fZ+DL
         37s7aDvAYk2Bnutmna/HojmwvApTp/8BZJNqUgMnQWUg0Uky5bGFbEv8W6bhdivRZkpi
         oEqo7PMCHNyRObqUfVLdUFTwKV4lM1rrIL5g5f4qR16Qn2uixpFZgS/fZ3yKl0yIuCil
         l1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687791484; x=1690383484;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIMrqRzfHWub21vEUbdFKshCviaaEWMt8gPIlJYyDLs=;
        b=TKkU/ODc6+5SWleKsSSRZMfvOU2gJ9WwM2eWq2m/8zH9lz9zp6d1s3P+yelN+qkSsK
         vIfXszZMKNMscCo0/AYha0/a48+sxVfptO2WXqtNSHiPB0NfqSbxIZf4Z3pT1kCwnkO2
         +lAs0RXEbxcphz6z5DMe2vnuby47uuiLrmuFV3aRb6H5GmsXNhK83C5dHyTDtMc7Ri1C
         UiHskAQhqXa4KILscTSiN25W8QZXtYZAClN3VD87EZmzCJ8PNzJsLhXv+poQmhD8nRJE
         93AAz8UrccuSIsE95JUoY0OKGrqmJwb5KYp6BMueoU47g2QUUQbd0yMnL8GTzrxoO0QK
         iT3A==
X-Gm-Message-State: AC+VfDxFoaaJl4uPTrQ+8WUC799pumHBPG7aYbDPbPJL60PAFqRmcm3o
        Nro4PXVOmr4L/PfrcpYFCxY=
X-Google-Smtp-Source: ACHHUZ6HlU8Ps9aOsuaLXOqRN3zvAGskznvY/bY5yG4B8Nuy4OmETZZA/SS3lLuefLjcBsmQgMygug==
X-Received: by 2002:a17:902:6b4a:b0:1b7:e9e9:1004 with SMTP id g10-20020a1709026b4a00b001b7e9e91004mr2486269plt.30.1687791483643;
        Mon, 26 Jun 2023 07:58:03 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id x20-20020a170902821400b001b1a2bf5277sm4313303pln.39.2023.06.26.07.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 07:58:03 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        cyeaa@connect.ust.hk, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v2 1/2] gpiolib: cdev: Fix &lr->wait.lock deadlock issue
Date:   Mon, 26 Jun 2023 14:57:55 +0000
Message-Id: <20230626145756.30696-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linereq_put_event() is called from both interrupt context (e.g.,
edge_irq_thread()) and process context (process_hw_ts_thread()).
Therefore, interrupt should be disabled before acquiring lock
&lr->wait.lock inside linereq_put_event() to avoid deadlock when
the lock is held in process context and edge_irq_thread() comes.

Similarly, linereq_read_unlocked() running in process context
also acquies the same lock. It also need to disable interrupt
otherwise deadlock could happen if the irq edge_irq_thread()
comes to execution while the lock is held.

Fix the two potential deadlock issues by spin_lock_bh() and
spin_lock_irq() separately.

Fixes: 73e0341992b6 ("gpiolib: cdev: support edge detection for uAPI v2")
Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/gpio/gpiolib-cdev.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 0a33971c964c..f768d46bdea7 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -615,13 +615,13 @@ static void linereq_put_event(struct linereq *lr,
 {
 	bool overflow = false;
 
-	spin_lock(&lr->wait.lock);
+	spin_lock_bh(&lr->wait.lock);
 	if (kfifo_is_full(&lr->events)) {
 		overflow = true;
 		kfifo_skip(&lr->events);
 	}
 	kfifo_in(&lr->events, le, 1);
-	spin_unlock(&lr->wait.lock);
+	spin_unlock_bh(&lr->wait.lock);
 	if (!overflow)
 		wake_up_poll(&lr->wait, EPOLLIN);
 	else
@@ -1514,28 +1514,28 @@ static ssize_t linereq_read_unlocked(struct file *file, char __user *buf,
 		return -EINVAL;
 
 	do {
-		spin_lock(&lr->wait.lock);
+		spin_lock_irq(&lr->wait.lock);
 		if (kfifo_is_empty(&lr->events)) {
 			if (bytes_read) {
-				spin_unlock(&lr->wait.lock);
+				spin_unlock_irq(&lr->wait.lock);
 				return bytes_read;
 			}
 
 			if (file->f_flags & O_NONBLOCK) {
-				spin_unlock(&lr->wait.lock);
+				spin_unlock_irq(&lr->wait.lock);
 				return -EAGAIN;
 			}
 
-			ret = wait_event_interruptible_locked(lr->wait,
+			ret = wait_event_interruptible_locked_irq(lr->wait,
 					!kfifo_is_empty(&lr->events));
 			if (ret) {
-				spin_unlock(&lr->wait.lock);
+				spin_unlock_irq(&lr->wait.lock);
 				return ret;
 			}
 		}
 
 		ret = kfifo_out(&lr->events, &le, 1);
-		spin_unlock(&lr->wait.lock);
+		spin_unlock_irq(&lr->wait.lock);
 		if (ret != 1) {
 			/*
 			 * This should never happen - we were holding the
-- 
2.17.1

