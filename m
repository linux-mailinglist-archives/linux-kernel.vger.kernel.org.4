Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301866E5C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjDRIrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjDRIrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:47:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4FC40D5;
        Tue, 18 Apr 2023 01:47:41 -0700 (PDT)
Date:   Tue, 18 Apr 2023 08:47:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681807659;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rsdIAMAwWopaXTDtOD5aLMYboZIulPn7eG1OGyICisY=;
        b=xwdwruv5LDE0XdxsJNO3X4Ce8VwNwW1kTbUv8dNRcQs2A74197WoXjAOQuo8rwieyp/gPf
        sHjYruQ+/DDhqfgZy/68rXJLuPGDOlr1LZgcV9ieBDaGEhrME1nxaeiYND6idsHuudoTXv
        FWy+ax3/HwHtA+hSQgGI0ZS2pTELCiPyACi20PApvPaZ0+48UzM4PWAK5Y9O6rYRubMjNL
        6+ffz0BZzPkQcMizAjz4eKSazv2Ra4zNh3o9OLNZHEZDnHJ8uU+0jERqbEK1mBx7YGnca+
        N0i83gU7M1gQlMp5YzGnBN0xSE2FBfr+5rwlgVccH4xCh7N5ba+NN+Wn/fyHCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681807659;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rsdIAMAwWopaXTDtOD5aLMYboZIulPn7eG1OGyICisY=;
        b=m+YIBgxL+JFywTivrGbJLJYCDdNBQALYylOekIxGtcI7zzgWtRN3xXkhLnQIoVRwaWrL6S
        vO2pFvNasplqyNAg==
From:   "tip-bot2 for Gregory Price" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] syscall_user_dispatch: Split up set_syscall_user_dispatch()
Cc:     Gregory Price <gregory.price@memverge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230407171834.3558-2-gregory.price@memverge.com>
References: <20230407171834.3558-2-gregory.price@memverge.com>
MIME-Version: 1.0
Message-ID: <168180765934.404.13399191864427617953.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     43360686328b1f4b7d9dcc883ee9243ad7c16fae
Gitweb:        https://git.kernel.org/tip/43360686328b1f4b7d9dcc883ee9243ad7c16fae
Author:        Gregory Price <gourry.memverge@gmail.com>
AuthorDate:    Fri, 07 Apr 2023 13:18:31 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 16 Apr 2023 14:23:07 +02:00

syscall_user_dispatch: Split up set_syscall_user_dispatch()

syscall user dispatch configuration is not covered by checkpoint/restore.

To prepare for ptrace access to the syscall user dispatch configuration,
move the inner working of set_syscall_user_dispatch() into a helper
function. Make the helper function task pointer based and let
set_syscall_user_dispatch() invoke it with task=current.

No functional change.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20230407171834.3558-2-gregory.price@memverge.com

---
 kernel/entry/syscall_user_dispatch.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index 0b6379a..22396b2 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -68,8 +68,9 @@ bool syscall_user_dispatch(struct pt_regs *regs)
 	return true;
 }
 
-int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
-			      unsigned long len, char __user *selector)
+static int task_set_syscall_user_dispatch(struct task_struct *task, unsigned long mode,
+					  unsigned long offset, unsigned long len,
+					  char __user *selector)
 {
 	switch (mode) {
 	case PR_SYS_DISPATCH_OFF:
@@ -94,15 +95,21 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 		return -EINVAL;
 	}
 
-	current->syscall_dispatch.selector = selector;
-	current->syscall_dispatch.offset = offset;
-	current->syscall_dispatch.len = len;
-	current->syscall_dispatch.on_dispatch = false;
+	task->syscall_dispatch.selector = selector;
+	task->syscall_dispatch.offset = offset;
+	task->syscall_dispatch.len = len;
+	task->syscall_dispatch.on_dispatch = false;
 
 	if (mode == PR_SYS_DISPATCH_ON)
-		set_syscall_work(SYSCALL_USER_DISPATCH);
+		set_task_syscall_work(task, SYSCALL_USER_DISPATCH);
 	else
-		clear_syscall_work(SYSCALL_USER_DISPATCH);
+		clear_task_syscall_work(task, SYSCALL_USER_DISPATCH);
 
 	return 0;
 }
+
+int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
+			      unsigned long len, char __user *selector)
+{
+	return task_set_syscall_user_dispatch(current, mode, offset, len, selector);
+}
