Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2956011E9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJQO4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiJQOzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:55:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8159A696F5;
        Mon, 17 Oct 2022 07:54:18 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018450;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nayXj0krMV4xaTuItGv4bT76yWtzDIaZDrVUw3mV+FU=;
        b=Ld0qpBZ3x3sDxi9bczubF83Ok/y0HTxEdRataVvQll35lLziIP8RXV5XqkLrf+dtr/do6t
        h/XfYNubqxm/FIFUaL3pNw7sjfeyXXeT8GoEsuSdUh/hxqQOXcswNVQen7q67NGkkCliO0
        W0h1VA+g1BByZlHrz0SM+FqBv7yZHNvOLp/nlVlzCB76ZiTqJnt70NzfrhQyrdDlZkDv/G
        0N86/LIPjJjDjsUujH3ZVB8xHDOBhVN2jvwHYOEMGlfHrySpq0DvsIpWyKN5JksHvVGHSM
        1v677bmWZ9HOeqblSntbOFBne4AMk7zfKsADzJN3voGCSoCcS+wezfa+aLCyCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018450;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nayXj0krMV4xaTuItGv4bT76yWtzDIaZDrVUw3mV+FU=;
        b=q9Zc1Xs/xDNP+SMejy7dtGahnVTGM3OmhCQkmeMPGwoeM9bfCYJS11BZmUH8zWHiQa7Ews
        aaY3+AFBTNqaaWCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/percpu: Move preempt_count next to current_task
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111145.284170644@infradead.org>
References: <20220915111145.284170644@infradead.org>
MIME-Version: 1.0
Message-ID: <166601844863.401.9155951814716704738.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     64701838bf0575ef8acb1ad2db5934e864f3e6c3
Gitweb:        https://git.kernel.org/tip/64701838bf0575ef8acb1ad2db5934e864f3e6c3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:11:02 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:04 +02:00

x86/percpu: Move preempt_count next to current_task

Add preempt_count to pcpu_hot, since it is once of the most used
per-cpu variables.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111145.284170644@infradead.org
---
 arch/x86/include/asm/current.h |  1 +
 arch/x86/include/asm/preempt.h | 27 ++++++++++++++-------------
 arch/x86/kernel/cpu/common.c   |  8 +-------
 3 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 63c42ac..0f4b462 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -15,6 +15,7 @@ struct pcpu_hot {
 	union {
 		struct {
 			struct task_struct	*current_task;
+			int			preempt_count;
 		};
 		u8	pad[64];
 	};
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 5f6daea..2d13f25 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -4,11 +4,11 @@
 
 #include <asm/rmwcc.h>
 #include <asm/percpu.h>
+#include <asm/current.h>
+
 #include <linux/thread_info.h>
 #include <linux/static_call_types.h>
 
-DECLARE_PER_CPU(int, __preempt_count);
-
 /* We use the MSB mostly because its available */
 #define PREEMPT_NEED_RESCHED	0x80000000
 
@@ -24,7 +24,7 @@ DECLARE_PER_CPU(int, __preempt_count);
  */
 static __always_inline int preempt_count(void)
 {
-	return raw_cpu_read_4(__preempt_count) & ~PREEMPT_NEED_RESCHED;
+	return raw_cpu_read_4(pcpu_hot.preempt_count) & ~PREEMPT_NEED_RESCHED;
 }
 
 static __always_inline void preempt_count_set(int pc)
@@ -32,10 +32,10 @@ static __always_inline void preempt_count_set(int pc)
 	int old, new;
 
 	do {
-		old = raw_cpu_read_4(__preempt_count);
+		old = raw_cpu_read_4(pcpu_hot.preempt_count);
 		new = (old & PREEMPT_NEED_RESCHED) |
 			(pc & ~PREEMPT_NEED_RESCHED);
-	} while (raw_cpu_cmpxchg_4(__preempt_count, old, new) != old);
+	} while (raw_cpu_cmpxchg_4(pcpu_hot.preempt_count, old, new) != old);
 }
 
 /*
@@ -44,7 +44,7 @@ static __always_inline void preempt_count_set(int pc)
 #define init_task_preempt_count(p) do { } while (0)
 
 #define init_idle_preempt_count(p, cpu) do { \
-	per_cpu(__preempt_count, (cpu)) = PREEMPT_DISABLED; \
+	per_cpu(pcpu_hot.preempt_count, (cpu)) = PREEMPT_DISABLED; \
 } while (0)
 
 /*
@@ -58,17 +58,17 @@ static __always_inline void preempt_count_set(int pc)
 
 static __always_inline void set_preempt_need_resched(void)
 {
-	raw_cpu_and_4(__preempt_count, ~PREEMPT_NEED_RESCHED);
+	raw_cpu_and_4(pcpu_hot.preempt_count, ~PREEMPT_NEED_RESCHED);
 }
 
 static __always_inline void clear_preempt_need_resched(void)
 {
-	raw_cpu_or_4(__preempt_count, PREEMPT_NEED_RESCHED);
+	raw_cpu_or_4(pcpu_hot.preempt_count, PREEMPT_NEED_RESCHED);
 }
 
 static __always_inline bool test_preempt_need_resched(void)
 {
-	return !(raw_cpu_read_4(__preempt_count) & PREEMPT_NEED_RESCHED);
+	return !(raw_cpu_read_4(pcpu_hot.preempt_count) & PREEMPT_NEED_RESCHED);
 }
 
 /*
@@ -77,12 +77,12 @@ static __always_inline bool test_preempt_need_resched(void)
 
 static __always_inline void __preempt_count_add(int val)
 {
-	raw_cpu_add_4(__preempt_count, val);
+	raw_cpu_add_4(pcpu_hot.preempt_count, val);
 }
 
 static __always_inline void __preempt_count_sub(int val)
 {
-	raw_cpu_add_4(__preempt_count, -val);
+	raw_cpu_add_4(pcpu_hot.preempt_count, -val);
 }
 
 /*
@@ -92,7 +92,8 @@ static __always_inline void __preempt_count_sub(int val)
  */
 static __always_inline bool __preempt_count_dec_and_test(void)
 {
-	return GEN_UNARY_RMWcc("decl", __preempt_count, e, __percpu_arg([var]));
+	return GEN_UNARY_RMWcc("decl", pcpu_hot.preempt_count, e,
+			       __percpu_arg([var]));
 }
 
 /*
@@ -100,7 +101,7 @@ static __always_inline bool __preempt_count_dec_and_test(void)
  */
 static __always_inline bool should_resched(int preempt_offset)
 {
-	return unlikely(raw_cpu_read_4(__preempt_count) == preempt_offset);
+	return unlikely(raw_cpu_read_4(pcpu_hot.preempt_count) == preempt_offset);
 }
 
 #ifdef CONFIG_PREEMPTION
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 5207153..cafb6bd 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2014,6 +2014,7 @@ __setup("clearcpuid=", setup_clearcpuid);
 
 DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) = {
 	.current_task	= &init_task,
+	.preempt_count	= INIT_PREEMPT_COUNT,
 };
 EXPORT_PER_CPU_SYMBOL(pcpu_hot);
 
@@ -2022,13 +2023,9 @@ DEFINE_PER_CPU_FIRST(struct fixed_percpu_data,
 		     fixed_percpu_data) __aligned(PAGE_SIZE) __visible;
 EXPORT_PER_CPU_SYMBOL_GPL(fixed_percpu_data);
 
-
 DEFINE_PER_CPU(void *, hardirq_stack_ptr);
 DEFINE_PER_CPU(bool, hardirq_stack_inuse);
 
-DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
-EXPORT_PER_CPU_SYMBOL(__preempt_count);
-
 DEFINE_PER_CPU(unsigned long, cpu_current_top_of_stack) = TOP_OF_INIT_STACK;
 
 static void wrmsrl_cstar(unsigned long val)
@@ -2081,9 +2078,6 @@ void syscall_init(void)
 
 #else	/* CONFIG_X86_64 */
 
-DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
-EXPORT_PER_CPU_SYMBOL(__preempt_count);
-
 /*
  * On x86_32, vm86 modifies tss.sp0, so sp0 isn't a reliable way to find
  * the top of the kernel stack.  Use an extra percpu variable to track the
