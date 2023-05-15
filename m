Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B7070220A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbjEODOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238361AbjEODOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:14:12 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85EF19AD;
        Sun, 14 May 2023 20:14:01 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-24dec03ad8fso8716354a91.1;
        Sun, 14 May 2023 20:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684120441; x=1686712441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Misk8RzcAuhujPj5CN4/zB0H7gvh8yXqb60mLrr5oOQ=;
        b=mxRmqh7RrZKI4U323j4QPj9REZOu20NRL2ypQKyhgtAio9Dgz6PqIAtGGj+I/S8d9D
         JcFiLL86AFLBMrrEBHaYu+c9PBRjeT8ZWxVH7oreEdaW4DovxDL4y/mvq8U3TAp5nHCH
         SIQhw3ZhUh+IOveWMBg7nw/IhDKU35QJhZLqglLbqU4vxdnznenShULKTrw1SEFnkBEN
         Q3ZDXR6cmTt4/+py+wnXuC0illIP/GUnZfy/Yt2ef6O5LVrZ+KEcfYOyRvpeSemZA6pQ
         EmGuZmoAuNIC2ysE9lW8qMU1QpQraTgl16W0ygFIQcEFvIIeLx9HAwNIrWZAs4E20LSx
         e1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684120441; x=1686712441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Misk8RzcAuhujPj5CN4/zB0H7gvh8yXqb60mLrr5oOQ=;
        b=JVjrt342shrV30xUK75ut1phkdRcTB6rQ7CNHFDySFDaM52jdogJijlfBpvRKMV0gp
         DVqoiShXb5w+SpoGnOrgjtY4JlR2y/8dtDXj6ee4flsyjrlC9xFTpQ/JAoHfRqJGcnC9
         ASAb6vZo6Mi02TAGDMwmgt/9lLX5skURdWtWUJPsRmt1tL+oZgEUyuF2KP8p8P2I06Ca
         95Eu4W9ct3OcZQAl/zsKXSpjpemSacsxZZgswmYnqumS4FzILBGu9qHwEmRjLB9AiWjX
         9eaek5Hn1UhjSuWCDYD95zTTj6TW6ba9b5OWrpIjZa9xdbi05Q6yNOO9KA+/IKorvhB4
         3Azg==
X-Gm-Message-State: AC+VfDza2G+6VevKEBgMiOeXZpIYbGa0DsQXkM4fJV3juCyDRSvVRQu1
        FGDssciIVRgmmnx7YjGqAZg=
X-Google-Smtp-Source: ACHHUZ7e39ooAoq6J7/mpAO93KBoLWfGhslTSW0wjXD07bX284VzdylHfe6bOl+kRYpTUX1uQwcmhA==
X-Received: by 2002:a17:90b:3881:b0:246:c097:6a17 with SMTP id mu1-20020a17090b388100b00246c0976a17mr33470341pjb.24.1684120440707;
        Sun, 14 May 2023 20:14:00 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.42])
        by smtp.googlemail.com with ESMTPSA id o4-20020a17090a744400b00252b3328ad8sm4943577pjk.0.2023.05.14.20.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 20:14:00 -0700 (PDT)
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
Date:   Mon, 15 May 2023 11:13:13 +0800
Message-Id: <20230515031314.7836-5-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515031314.7836-1-zegao@tencent.com>
References: <20230515031314.7836-1-zegao@tencent.com>
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

