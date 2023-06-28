Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4867A741016
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjF1LbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjF1Lao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:30:44 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EFD2D59
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:30:42 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666eb03457cso3101403b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687951842; x=1690543842;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xX8VhefgmcPT+thj/47+bMSZaHDhU9pv9wKERh7p3s=;
        b=WttF6AEi770ncLMj0x9CHl3X8yPMph41cvk+befFZJSvxd0CtJmLCzE0+svmywCuxP
         yzL0hs+u9Sp2Pl3eemN8Uv42jVfL7xcrhJNc2Yt9oYqgK0F56cAwflQ0eL2lbkqsAs79
         zrYiEeOmuB8kazD0rDi5ZdZ4PKwfSAxue5+4RAZHCZAXfIyN8NJJs6p4IlU/pgNl3fCf
         EhCOqEFU6VNsqjkWSIGdHnXwsruiei3S7gxWAJcqEnDv3LujOw4pXJ3l6/SQnven5sNh
         /5xXGo9PeOwmyTXiGTRzqJ7DrcAPwSeoxKuGMQMz7v+k1zugigkKDpfkiumyJgLMq5Pq
         GYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687951842; x=1690543842;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xX8VhefgmcPT+thj/47+bMSZaHDhU9pv9wKERh7p3s=;
        b=QEhxIsZrJHNUMGPjonmQUFNQgQMdDpsvLJv4wqAWed9bFDitPBtlIBORxPdxizfii0
         Dk/1IW5ChRaxHvPJq5gOnGAXanlCoyTp5T9H6CkMpv0+65bT55sf47QMDxDc6cG/CDuK
         EQAlisziZjiBiMe7cIuz933K3ljfuXXs3DExqDacCheVCz9+It8S8dyOC89t97ej7oMC
         JUY7VmIiuRw/drM5vcEOqcO+mQ0uiyP0T1DjIZ90DYiUBjf7uB+M0h7qiHIeYAwK+st/
         MF1iBM/zXjS/BHvSuEwWFhsKeXRd3SDZVjuDju1Fn9ZG8yB7l5kzVm4hxadu7bw0VLox
         88yw==
X-Gm-Message-State: AC+VfDzrYIpQmn0f08dCmOL7/A80NnLocLSrhQqieR7xV3I47RFY0Lso
        /EfoLvSJKqDt4Hh3vA3Cs7ZTblb4RO84xA==
X-Google-Smtp-Source: ACHHUZ5pRUyYmZuG0uHkA0RiTRi77YDi549SPulGyBoENvcFsMgldHt2jttWBHz4UoLrMwk90e+I5A==
X-Received: by 2002:a05:6a21:999d:b0:12b:e7de:6385 with SMTP id ve29-20020a056a21999d00b0012be7de6385mr2902756pzb.27.1687951842334;
        Wed, 28 Jun 2023 04:30:42 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id e26-20020aa7825a000000b0064381853bfcsm6837537pfn.89.2023.06.28.04.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:30:41 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     scott.branden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v2] misc: bcm_vk: Fix potential deadlock on &vk->ctx_lock
Date:   Wed, 28 Jun 2023 11:29:58 +0000
Message-Id: <20230628112958.45374-1-dg573847474@gmail.com>
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
developing for irq-related deadlock, which reported the following
warning when analyzing the linux kernel 6.4-rc7 release.

[Deadlock]: &vk->ctx_lock
  [Interrupt]: bcm_vk_hb_poll
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:176
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:512
  [Locking Unit]: bcm_vk_ioctl
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:1181
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:512

[Deadlock]: &vk->ctx_lock
  [Interrupt]: bcm_vk_hb_poll
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:176
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:512
  [Locking Unit]: bcm_vk_ioctl
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:1169

[Deadlock]: &vk->ctx_lock
  [Interrupt]: bcm_vk_hb_poll
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:176
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:512
  [Locking Unit]: bcm_vk_open
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:216

[Deadlock]: &vk->ctx_lock
  [Interrupt]: bcm_vk_hb_poll
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:176
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:512
  [Locking Unit]: bcm_vk_release
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:306

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

