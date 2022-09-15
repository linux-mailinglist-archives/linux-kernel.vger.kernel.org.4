Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46935B99F7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiIOLn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiIOLlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:41:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670156CF43
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=xQuJtl6Oe7h8UkTWqXBwC3SMQ2iiCp9oKrM8vI/KEDI=; b=AzImx4suApGQts42JXatUI1VN/
        n5iIVz5DqK0cBMj8cshaY05zoP6fahgX7atUd+0TyYCsFIYtYbLGkCbtAOHh7Sz9bw/D+dxkRPFE1
        WQWZcChQod96HSkemfn3AM4GbhWU5z4KkeAzvwVo9K6qLAA7SyDg2B7eMPdKS/w68Hpk2TBsbA3Dg
        uFM0inKPNy0Yh9NnGgwiSHKTQEN1am+xY/F6jxo1Z6tv6+ROrHEbMHfaDipe/uDJxm6DaPtr1EMit
        G4HAohMpQyN7wtS2PhKPIxHoemmyplAgCKYuyn/UAe/zoZAUOK8fwo33FFw8CllMHyvtH1tlY4Elq
        ftqP5h7g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDa-00Caar-MC; Thu, 15 Sep 2022 11:39:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD585302911;
        Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6567229AADBFF; Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Message-ID: <20220915111145.284170644@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:11:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v3 23/59] x86/percpu: Move preempt_count next to current_task
References: <20220915111039.092790446@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Add preempt_count to pcpu_hot, since it is once of the most used
per-cpu variables.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/current.h |    1 +
 arch/x86/include/asm/preempt.h |   27 ++++++++++++++-------------
 arch/x86/kernel/cpu/common.c   |    8 +-------
 3 files changed, 16 insertions(+), 20 deletions(-)

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
@@ -32,10 +32,10 @@ static __always_inline void preempt_coun
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
@@ -44,7 +44,7 @@ static __always_inline void preempt_coun
 #define init_task_preempt_count(p) do { } while (0)
 
 #define init_idle_preempt_count(p, cpu) do { \
-	per_cpu(__preempt_count, (cpu)) = PREEMPT_DISABLED; \
+	per_cpu(pcpu_hot.preempt_count, (cpu)) = PREEMPT_DISABLED; \
 } while (0)
 
 /*
@@ -58,17 +58,17 @@ static __always_inline void preempt_coun
 
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
@@ -77,12 +77,12 @@ static __always_inline bool test_preempt
 
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
@@ -92,7 +92,8 @@ static __always_inline void __preempt_co
  */
 static __always_inline bool __preempt_count_dec_and_test(void)
 {
-	return GEN_UNARY_RMWcc("decl", __preempt_count, e, __percpu_arg([var]));
+	return GEN_UNARY_RMWcc("decl", pcpu_hot.preempt_count, e,
+			       __percpu_arg([var]));
 }
 
 /*
@@ -100,7 +101,7 @@ static __always_inline bool __preempt_co
  */
 static __always_inline bool should_resched(int preempt_offset)
 {
-	return unlikely(raw_cpu_read_4(__preempt_count) == preempt_offset);
+	return unlikely(raw_cpu_read_4(pcpu_hot.preempt_count) == preempt_offset);
 }
 
 #ifdef CONFIG_PREEMPTION
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2002,6 +2002,7 @@ static __init int setup_clearcpuid(char
 
 DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) = {
 	.current_task	= &init_task,
+	.preempt_count	= INIT_PREEMPT_COUNT,
 };
 EXPORT_PER_CPU_SYMBOL(pcpu_hot);
 
@@ -2010,13 +2011,9 @@ DEFINE_PER_CPU_FIRST(struct fixed_percpu
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
@@ -2069,9 +2066,6 @@ void syscall_init(void)
 
 #else	/* CONFIG_X86_64 */
 
-DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
-EXPORT_PER_CPU_SYMBOL(__preempt_count);
-
 /*
  * On x86_32, vm86 modifies tss.sp0, so sp0 isn't a reliable way to find
  * the top of the kernel stack.  Use an extra percpu variable to track the


