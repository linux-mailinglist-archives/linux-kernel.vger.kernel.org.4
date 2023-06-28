Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B58740F5D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjF1KyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjF1Kx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:53:28 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6D78F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 03:53:27 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b7f2239bfdso34979415ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 03:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687949607; x=1690541607;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcDhTm+8IhNlt66O+hBb+pqLlKKFGHo6pP41iJu48L0=;
        b=nQ5VlLaZQN/gcEvu68ksVPaR+Gn6CzEYVGRWWhoX357FqyIwt+vpj/cuYjTkkqrkIp
         FALboiaGIGs3AeincxwadAkREBfv8hMCutOWD0HRnVm8qDgWBeyZEesqUuM9mEE3p08z
         vRLVrMfmcCp+l1NAx4bdA1yHEN51PV4brRaDRxmZaYU6xtvOBMUqGZ81HbwwrZuCCEi1
         9yTpoYGBL8dSNpT4Mi90fY2nNHb2uYgEU1qc0yyITM72BXR6MwGoo6EVzE+jTO6pZpyx
         heeZOoLsCcjVO/0xvoFiPyk4DKB1MS27oGOk5PX7tdgIQHQvIoKNkFwgquLdddMMx+sc
         fY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687949607; x=1690541607;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcDhTm+8IhNlt66O+hBb+pqLlKKFGHo6pP41iJu48L0=;
        b=BF1FQpoUtATDEr6e7xnCwqCaETHHNkuDb17DirM30eTiS4SjMtdvpvEpTG32Ouhv/h
         W/2p0Y5G+iCnPyeio8nbpKJRRcFUk0Zl19FOxMMcMqecw9nFqd7V3VKK6DUBS5w/hxXQ
         AHbousY44O01jR37JuWjyIwfpO9N3QjjdEfV0kdpRCpcQBMXUPt/HudeTtJ7lL+Yx1Eo
         l6xqO/jBxMD10c6puUCmp5PR/gEHlhEfo1LnhEXd+sb9af96a+o6B+B4cRYeT4zdx1eA
         Na51EXc/qQLVa+2Kh2sFBpYvkHKYy0L+Mdh0zdU5QaLrVcpkmsSAdqeURLcJXzY4kq0E
         Rrtg==
X-Gm-Message-State: AC+VfDxo7YFfIYWoXN1pBkgAFT10xAfQGQOe2ve4cuqm7sDIeENWPYHJ
        HPPD2GL7bUU61/PmqJ6WxzA=
X-Google-Smtp-Source: ACHHUZ52syXj/sMn69/eKqoDLPTpISRgemn0K3hDGDGqZlxWv6jSRjp+8A1UdaHgCYIwn0ubDEuZFg==
X-Received: by 2002:a17:902:dac3:b0:1b6:8b70:328f with SMTP id q3-20020a170902dac300b001b68b70328fmr14549561plx.6.1687949606712;
        Wed, 28 Jun 2023 03:53:26 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id jn16-20020a170903051000b001b53472353csm7408581plb.211.2023.06.28.03.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 03:53:26 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     scott.branden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] misc: bcm_vk: Fix potential deadlock on &vk->ctx_lock
Date:   Wed, 28 Jun 2023 10:52:50 +0000
Message-Id: <20230628105250.40874-1-dg573847474@gmail.com>
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

As &vk->ctx_lock is acquired by timer bcm_vk_hb_poll() under softirq
context, other process context code should disable irq or bottom-half
before acquire the same lock, otherwise deadlock could happen if the
timer preempt the execution while the lock is held in process context
on the same CPU.

Possible deadlock scenario
bcm_vk_open()
    -> bcm_vk_get_ctx()
    -> spin_lock(&vk->ctx_lock)
        <timer iterrupt>
        -> bcm_vk_hb_poll()
        -> bcm_vk_blk_drv_access()
        -> spin_lock_irqsave(&vk->ctx_lock, flags) (deadlock here)

This flaw was found using an experimental static analysis tool we are
developing for irq-related deadlock.

The tentative patch fix the potential deadlock by spin_lock_irqsave().

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/misc/bcm-vk/bcm_vk_dev.c | 10 ++++++----
 drivers/misc/bcm-vk/bcm_vk_msg.c | 10 ++++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index d4a96137728d..dfe16154b25a 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -503,13 +503,14 @@ static int bcm_vk_sync_card_info(struct bcm_vk *vk)
 void bcm_vk_blk_drv_access(struct bcm_vk *vk)
 {
 	int i;
+	unsigned long flags;
 
 	/*
 	 * kill all the apps except for the process that is resetting.
 	 * If not called during reset, reset_pid will be 0, and all will be
 	 * killed.
 	 */
-	spin_lock(&vk->ctx_lock);
+	spin_lock_irqsave(&vk->ctx_lock, flags);
 
 	/* set msgq_inited to 0 so that all rd/wr will be blocked */
 	atomic_set(&vk->msgq_inited, 0);
@@ -527,7 +528,7 @@ void bcm_vk_blk_drv_access(struct bcm_vk *vk)
 		}
 	}
 	bcm_vk_tty_terminate_tty_user(vk);
-	spin_unlock(&vk->ctx_lock);
+	spin_unlock_irqrestore(&vk->ctx_lock, flags);
 }
 
 static void bcm_vk_buf_notify(struct bcm_vk *vk, void *bufp,
@@ -1143,6 +1144,7 @@ static long bcm_vk_reset(struct bcm_vk *vk, struct vk_reset __user *arg)
 	int ret = 0;
 	u32 ramdump_reset;
 	int special_reset;
+	unsigned long flags;
 
 	if (copy_from_user(&reset, arg, sizeof(struct vk_reset)))
 		return -EFAULT;
@@ -1166,7 +1168,7 @@ static long bcm_vk_reset(struct bcm_vk *vk, struct vk_reset __user *arg)
 	 */
 	bcm_vk_send_shutdown_msg(vk, VK_SHUTDOWN_GRACEFUL, 0, 0);
 
-	spin_lock(&vk->ctx_lock);
+	spin_lock_irqsave(&vk->ctx_lock, flags);
 	if (!vk->reset_pid) {
 		vk->reset_pid = task_pid_nr(current);
 	} else {
@@ -1174,7 +1176,7 @@ static long bcm_vk_reset(struct bcm_vk *vk, struct vk_reset __user *arg)
 			vk->reset_pid);
 		ret = -EACCES;
 	}
-	spin_unlock(&vk->ctx_lock);
+	spin_unlock_irqrestore(&vk->ctx_lock, flags);
 	if (ret)
 		goto err_exit;
 
diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
index 3c081504f38c..ea887fa97a9e 100644
--- a/drivers/misc/bcm-vk/bcm_vk_msg.c
+++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
@@ -212,8 +212,9 @@ static struct bcm_vk_ctx *bcm_vk_get_ctx(struct bcm_vk *vk, const pid_t pid)
 	u32 i;
 	struct bcm_vk_ctx *ctx = NULL;
 	u32 hash_idx = hash_32(pid, VK_PID_HT_SHIFT_BIT);
+	unsigned long flags;
 
-	spin_lock(&vk->ctx_lock);
+	spin_lock_irqsave(&vk->ctx_lock, flags);
 
 	/* check if it is in reset, if so, don't allow */
 	if (vk->reset_pid) {
@@ -253,7 +254,7 @@ static struct bcm_vk_ctx *bcm_vk_get_ctx(struct bcm_vk *vk, const pid_t pid)
 
 all_in_use_exit:
 in_reset_exit:
-	spin_unlock(&vk->ctx_lock);
+	spin_unlock_irqrestore(&vk->ctx_lock, flags);
 
 	return ctx;
 }
@@ -295,6 +296,7 @@ static int bcm_vk_free_ctx(struct bcm_vk *vk, struct bcm_vk_ctx *ctx)
 	pid_t pid;
 	struct bcm_vk_ctx *entry;
 	int count = 0;
+	unsigned long flags;
 
 	if (!ctx) {
 		dev_err(&vk->pdev->dev, "NULL context detected\n");
@@ -303,7 +305,7 @@ static int bcm_vk_free_ctx(struct bcm_vk *vk, struct bcm_vk_ctx *ctx)
 	idx = ctx->idx;
 	pid = ctx->pid;
 
-	spin_lock(&vk->ctx_lock);
+	spin_lock_irqsave(&vk->ctx_lock, flags);
 
 	if (!vk->ctx[idx].in_use) {
 		dev_err(&vk->pdev->dev, "context[%d] not in use!\n", idx);
@@ -320,7 +322,7 @@ static int bcm_vk_free_ctx(struct bcm_vk *vk, struct bcm_vk_ctx *ctx)
 		}
 	}
 
-	spin_unlock(&vk->ctx_lock);
+	spin_unlock_irqrestore(&vk->ctx_lock, flags);
 
 	return count;
 }
-- 
2.17.1

