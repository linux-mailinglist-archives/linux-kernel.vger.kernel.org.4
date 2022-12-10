Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE5B648F09
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 14:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiLJN7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 08:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiLJN62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 08:58:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2572B13F90
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 05:58:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC72660C28
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 13:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B56C433EF;
        Sat, 10 Dec 2022 13:58:26 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1p40Mz-000kqL-0i;
        Sat, 10 Dec 2022 08:58:25 -0500
Message-ID: <20221210135825.088221176@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 10 Dec 2022 08:58:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [for-next][PATCH 12/25] x86/mm/kmmio: Switch to arch_spin_lock()
References: <20221210135750.425719934@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>

The mmiotrace tracer is "special". The purpose is to help reverse engineer
binary drivers by removing the memory allocated by the driver and when the
driver goes to access it, a fault occurs, the mmiotracer will record what
the driver was doing and then do the work on its behalf by single stepping
through the process.

But to achieve this ability, it must do some special things. One is it
needs to grab a lock while in the breakpoint handler. This is considered
an NMI state, and then lockdep warns that the lock is being held in both
an NMI state (really a breakpoint handler) and also in normal context.

As the breakpoint/NMI state only happens when the driver is accessing
memory, there's no concern of a race condition against the setup and
tear-down of mmiotracer.

To make lockdep and mmiotrace work together, convert the locks used in the
breakpoint handler into arch_spin_lock().

Link: https://lkml.kernel.org/r/20221206191229.656244029@goodmis.org
Link: https://lore.kernel.org/lkml/20221201213126.620b7dd3@gandalf.local.home/
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Karol Herbst <karolherbst@gmail.com>
Cc: Pekka Paalanen <ppaalanen@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/mm/kmmio.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/kmmio.c b/arch/x86/mm/kmmio.c
index d3efbc5b3449..edb486450158 100644
--- a/arch/x86/mm/kmmio.c
+++ b/arch/x86/mm/kmmio.c
@@ -62,7 +62,13 @@ struct kmmio_context {
 	int active;
 };
 
-static DEFINE_SPINLOCK(kmmio_lock);
+/*
+ * The kmmio_lock is taken in int3 context, which is treated as NMI context.
+ * This causes lockdep to complain about it bein in both NMI and normal
+ * context. Hide it from lockdep, as it should not have any other locks
+ * taken under it, and this is only enabled for debugging mmio anyway.
+ */
+static arch_spinlock_t kmmio_lock = __ARCH_SPIN_LOCK_UNLOCKED;
 
 /* Protected by kmmio_lock */
 unsigned int kmmio_count;
@@ -346,10 +352,10 @@ static int post_kmmio_handler(unsigned long condition, struct pt_regs *regs)
 		ctx->probe->post_handler(ctx->probe, condition, regs);
 
 	/* Prevent racing against release_kmmio_fault_page(). */
-	spin_lock(&kmmio_lock);
+	arch_spin_lock(&kmmio_lock);
 	if (ctx->fpage->count)
 		arm_kmmio_fault_page(ctx->fpage);
-	spin_unlock(&kmmio_lock);
+	arch_spin_unlock(&kmmio_lock);
 
 	regs->flags &= ~X86_EFLAGS_TF;
 	regs->flags |= ctx->saved_flags;
@@ -440,7 +446,8 @@ int register_kmmio_probe(struct kmmio_probe *p)
 	unsigned int l;
 	pte_t *pte;
 
-	spin_lock_irqsave(&kmmio_lock, flags);
+	local_irq_save(flags);
+	arch_spin_lock(&kmmio_lock);
 	if (get_kmmio_probe(addr)) {
 		ret = -EEXIST;
 		goto out;
@@ -460,7 +467,9 @@ int register_kmmio_probe(struct kmmio_probe *p)
 		size += page_level_size(l);
 	}
 out:
-	spin_unlock_irqrestore(&kmmio_lock, flags);
+	arch_spin_unlock(&kmmio_lock);
+	local_irq_restore(flags);
+
 	/*
 	 * XXX: What should I do here?
 	 * Here was a call to global_flush_tlb(), but it does not exist
@@ -494,7 +503,8 @@ static void remove_kmmio_fault_pages(struct rcu_head *head)
 	struct kmmio_fault_page **prevp = &dr->release_list;
 	unsigned long flags;
 
-	spin_lock_irqsave(&kmmio_lock, flags);
+	local_irq_save(flags);
+	arch_spin_lock(&kmmio_lock);
 	while (f) {
 		if (!f->count) {
 			list_del_rcu(&f->list);
@@ -506,7 +516,8 @@ static void remove_kmmio_fault_pages(struct rcu_head *head)
 		}
 		f = *prevp;
 	}
-	spin_unlock_irqrestore(&kmmio_lock, flags);
+	arch_spin_unlock(&kmmio_lock);
+	local_irq_restore(flags);
 
 	/* This is the real RCU destroy call. */
 	call_rcu(&dr->rcu, rcu_free_kmmio_fault_pages);
@@ -540,14 +551,16 @@ void unregister_kmmio_probe(struct kmmio_probe *p)
 	if (!pte)
 		return;
 
-	spin_lock_irqsave(&kmmio_lock, flags);
+	local_irq_save(flags);
+	arch_spin_lock(&kmmio_lock);
 	while (size < size_lim) {
 		release_kmmio_fault_page(addr + size, &release_list);
 		size += page_level_size(l);
 	}
 	list_del_rcu(&p->list);
 	kmmio_count--;
-	spin_unlock_irqrestore(&kmmio_lock, flags);
+	arch_spin_unlock(&kmmio_lock);
+	local_irq_restore(flags);
 
 	if (!release_list)
 		return;
-- 
2.35.1


