Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FEC70222D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjEOD1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbjEOD1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:27:23 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF96019B2;
        Sun, 14 May 2023 20:27:15 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64ab2a37812so16612128b3a.1;
        Sun, 14 May 2023 20:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684121235; x=1686713235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Misk8RzcAuhujPj5CN4/zB0H7gvh8yXqb60mLrr5oOQ=;
        b=SUTYpi9m7sfB03krQSEVvZC8BAKoBAFKxMDYCydpITO/I8zUiiyk5Kzo+jNSg95b6v
         RhIw64DX8qMnXWvKy9BNDKbpwJyFCs1eZwm3295yCaUvKJgzf+2aYHJ8skA18ZY7Y9NG
         mvxd5TH9uewZGkdyp6C+yQy21hckWwkYwB+4u3eU94xPVquK6qutXALcwB/fmAZ6sIPJ
         KecxVHrKXwVRQjtpPenLWz035ZHCciWD97jD3PVH2NdwOESiJDOUOtONJGRC4osglUR1
         0+ZJgF8NZxTf74J2fP3+p4HBsS5RTDF7qMqjhz6gE6p19cjT7K+BAyvT1rMEnas+TqeB
         bdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684121235; x=1686713235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Misk8RzcAuhujPj5CN4/zB0H7gvh8yXqb60mLrr5oOQ=;
        b=Erv9su7KgkzKQuU2TRIUd4vCrq/geQ9fqcCuFamqtBwnAYwbiN81pdaKfL4TE4D02X
         i8ekJLo/qIiawkGTr6RbwsQZPVHJmrk3gfP4wt0hr+Df8hQOkhs3DqPsi9bxmvkG4PxV
         WAezEXcZm3Oj+eYhLbM/Y9jGzrCCSfJo+Or8LtR1AtuaqMp0pSjIvximZZMYDZ01zd0Y
         YDinLX51kOY/O+tECwVoDYU/WeVMMYTXjh1ZiZV08FWx+heFEODeCFdRe3dby615Uso6
         FnXycTBspsO0Tw6RZYBI/dhrjJMc7Ov6kMnSVxVKCXrgvqtooXGBk8uzsSdijwkcFCLE
         lGQA==
X-Gm-Message-State: AC+VfDxtypHArS/ttUgNDzfXMVE1qJnlrc/cNsx58uQdjNFFAmfwU86S
        0oN+/ZI6EydgIu+NzWpmBW0=
X-Google-Smtp-Source: ACHHUZ6Cgz27fn+/f04F6U/99cc0elHZFIBQRg512B0TLAkvbrJvxvIfy4wf8ER547TSO8rTWSCjpA==
X-Received: by 2002:a17:90a:ad09:b0:244:d441:8f68 with SMTP id r9-20020a17090aad0900b00244d4418f68mr44442897pjq.16.1684121235252;
        Sun, 14 May 2023 20:27:15 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.42])
        by smtp.googlemail.com with ESMTPSA id s6-20020a632146000000b0051416609fb7sm10363825pgm.61.2023.05.14.20.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 20:27:14 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ze Gao <zegao@tencent.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH 4/4] rehook, fprobe: mark rethook related functions notrace
Date:   Mon, 15 May 2023 11:26:41 +0800
Message-Id: <238bad4335d029072ca6000fb404f47376197f39.1684120990.git.zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684120990.git.zegao@tencent.com>
References: <cover.1684120990.git.zegao@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are already marked as NOKPROBE to prevent recusion and
we have the same reason to blacklist them if rethook is used with fprobe,
since they are beyond the recursion-free region ftrace can guard.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 arch/riscv/kernel/probes/rethook.c | 4 ++--
 arch/s390/kernel/rethook.c         | 6 +++---
 arch/x86/kernel/rethook.c          | 8 +++++---
 kernel/trace/rethook.c             | 8 ++++----
 4 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/kernel/probes/rethook.c b/arch/riscv/kernel/probes/rethook.c
index 5c27c1f50989..803c412a1bea 100644
--- a/arch/riscv/kernel/probes/rethook.c
+++ b/arch/riscv/kernel/probes/rethook.c
@@ -8,14 +8,14 @@
 #include "rethook.h"
 
 /* This is called from arch_rethook_trampoline() */
-unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *regs)
+unsigned long __used notrace arch_rethook_trampoline_callback(struct pt_regs *regs)
 {
 	return rethook_trampoline_handler(regs, regs->s0);
 }
 
 NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
 
-void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
+void notrace arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
 {
 	rhn->ret_addr = regs->ra;
 	rhn->frame = regs->s0;
diff --git a/arch/s390/kernel/rethook.c b/arch/s390/kernel/rethook.c
index af10e6bdd34e..ad52119826c1 100644
--- a/arch/s390/kernel/rethook.c
+++ b/arch/s390/kernel/rethook.c
@@ -3,7 +3,7 @@
 #include <linux/kprobes.h>
 #include "rethook.h"
 
-void arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs, bool mcount)
+void notrace arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs, bool mcount)
 {
 	rh->ret_addr = regs->gprs[14];
 	rh->frame = regs->gprs[15];
@@ -13,7 +13,7 @@ void arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs, bool mc
 }
 NOKPROBE_SYMBOL(arch_rethook_prepare);
 
-void arch_rethook_fixup_return(struct pt_regs *regs,
+void notrace arch_rethook_fixup_return(struct pt_regs *regs,
 			       unsigned long correct_ret_addr)
 {
 	/* Replace fake return address with real one. */
@@ -24,7 +24,7 @@ NOKPROBE_SYMBOL(arch_rethook_fixup_return);
 /*
  * Called from arch_rethook_trampoline
  */
-unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs)
+unsigned long notrace arch_rethook_trampoline_callback(struct pt_regs *regs)
 {
 	return rethook_trampoline_handler(regs, regs->gprs[15]);
 }
diff --git a/arch/x86/kernel/rethook.c b/arch/x86/kernel/rethook.c
index 8a1c0111ae79..1f7cef86f73d 100644
--- a/arch/x86/kernel/rethook.c
+++ b/arch/x86/kernel/rethook.c
@@ -64,7 +64,8 @@ NOKPROBE_SYMBOL(arch_rethook_trampoline);
 /*
  * Called from arch_rethook_trampoline
  */
-__used __visible void arch_rethook_trampoline_callback(struct pt_regs *regs)
+__used __visible void notrace arch_rethook_trampoline_callback(struct pt_regs
+		*regs)
 {
 	unsigned long *frame_pointer;
 
@@ -104,7 +105,7 @@ NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
 STACK_FRAME_NON_STANDARD_FP(arch_rethook_trampoline);
 
 /* This is called from rethook_trampoline_handler(). */
-void arch_rethook_fixup_return(struct pt_regs *regs,
+void notrace arch_rethook_fixup_return(struct pt_regs *regs,
 			       unsigned long correct_ret_addr)
 {
 	unsigned long *frame_pointer = (void *)(regs + 1);
@@ -114,7 +115,8 @@ void arch_rethook_fixup_return(struct pt_regs *regs,
 }
 NOKPROBE_SYMBOL(arch_rethook_fixup_return);
 
-void arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs, bool mcount)
+void notrace arch_rethook_prepare(struct rethook_node *rh, struct pt_regs
+		*regs, bool mcount)
 {
 	unsigned long *stack = (unsigned long *)regs->sp;
 
diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index 60f6cb2b486b..e551e86d3927 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -127,7 +127,7 @@ static void free_rethook_node_rcu(struct rcu_head *head)
  * Return back the @node to @node::rethook. If the @node::rethook is already
  * marked as freed, this will free the @node.
  */
-void rethook_recycle(struct rethook_node *node)
+void notrace rethook_recycle(struct rethook_node *node)
 {
 	lockdep_assert_preemption_disabled();
 
@@ -194,7 +194,7 @@ void rethook_hook(struct rethook_node *node, struct pt_regs *regs, bool mcount)
 NOKPROBE_SYMBOL(rethook_hook);
 
 /* This assumes the 'tsk' is the current task or is not running. */
-static unsigned long __rethook_find_ret_addr(struct task_struct *tsk,
+static unsigned long notrace __rethook_find_ret_addr(struct task_struct *tsk,
 					     struct llist_node **cur)
 {
 	struct rethook_node *rh = NULL;
@@ -256,7 +256,7 @@ unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame
 }
 NOKPROBE_SYMBOL(rethook_find_ret_addr);
 
-void __weak arch_rethook_fixup_return(struct pt_regs *regs,
+void __weak notrace arch_rethook_fixup_return(struct pt_regs *regs,
 				      unsigned long correct_ret_addr)
 {
 	/*
@@ -268,7 +268,7 @@ void __weak arch_rethook_fixup_return(struct pt_regs *regs,
 }
 
 /* This function will be called from each arch-defined trampoline. */
-unsigned long rethook_trampoline_handler(struct pt_regs *regs,
+unsigned long notrace rethook_trampoline_handler(struct pt_regs *regs,
 					 unsigned long frame)
 {
 	struct llist_node *first, *node = NULL;
-- 
2.40.1

