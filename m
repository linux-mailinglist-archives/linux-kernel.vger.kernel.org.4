Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2877A5B9A0D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiIOLpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiIOLmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:42:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1A19BB7A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=NPIEgVCIlOh8dD4yk3OVetSQQerJmiLfbsdkTOcH3dg=; b=o3/LR15w3gGaJEyLKv2P53WUPi
        pwqTm2yx+h3h17sqc+43vtkQTj/jvkLb0V//4FOEeaI1gSBWKkHylajQbNn0GwfOf6q1r6GpMbt4I
        e1z7Q6qJmOrJJUVIdHrZXVkC0nwF6SxByv9zfAhy7S3+BVn+lkj/Rh1KLZO2WDVd/lextFWjqbBZm
        M8QqIBt5e2SP4kzScmDhkM0YUMxDD668kNj6U/XjrMCSG9zRWTnsW8E4drY1YKsEn49T4Q6plS+Pm
        g1VzKGXuvxczX4jlHEGr/9QwLr+k5qvq779p9Qm30G7YQCvslZPtEx4dzr/wAJF1kjWOLFVtYtytl
        Mg6NQnXA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDa-00Caat-RT; Thu, 15 Sep 2022 11:40:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DE716302A31;
        Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6BC1B29BA2EA6; Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Message-ID: <20220915111145.387678283@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:11:03 +0200
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
Subject: [PATCH v3 24/59] x86/percpu: Move cpu_number next to current_task
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

Also add cpu_number to the pcpu_hot structure, it is often referenced
and this cacheline is there.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/current.h |    1 +
 arch/x86/include/asm/smp.h     |   12 +++++-------
 arch/x86/kernel/setup_percpu.c |    5 +----
 3 files changed, 7 insertions(+), 11 deletions(-)

--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -16,6 +16,7 @@ struct pcpu_hot {
 		struct {
 			struct task_struct	*current_task;
 			int			preempt_count;
+			int			cpu_number;
 		};
 		u8	pad[64];
 	};
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -3,10 +3,10 @@
 #define _ASM_X86_SMP_H
 #ifndef __ASSEMBLY__
 #include <linux/cpumask.h>
-#include <asm/percpu.h>
 
-#include <asm/thread_info.h>
 #include <asm/cpumask.h>
+#include <asm/current.h>
+#include <asm/thread_info.h>
 
 extern int smp_num_siblings;
 extern unsigned int num_processors;
@@ -19,7 +19,6 @@ DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_l2c_shared_map);
 DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id);
 DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id);
-DECLARE_PER_CPU_READ_MOSTLY(int, cpu_number);
 
 static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 {
@@ -160,11 +159,10 @@ asmlinkage __visible void smp_reboot_int
 
 /*
  * This function is needed by all SMP systems. It must _always_ be valid
- * from the initial startup. We map APIC_BASE very early in page_setup(),
- * so this is correct in the x86 case.
+ * from the initial startup.
  */
-#define raw_smp_processor_id()  this_cpu_read(cpu_number)
-#define __smp_processor_id() __this_cpu_read(cpu_number)
+#define raw_smp_processor_id()  this_cpu_read(pcpu_hot.cpu_number)
+#define __smp_processor_id() __this_cpu_read(pcpu_hot.cpu_number)
 
 #ifdef CONFIG_X86_32
 extern int safe_smp_processor_id(void);
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -23,9 +23,6 @@
 #include <asm/cpu.h>
 #include <asm/stackprotector.h>
 
-DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number);
-EXPORT_PER_CPU_SYMBOL(cpu_number);
-
 #ifdef CONFIG_X86_64
 #define BOOT_PERCPU_OFFSET ((unsigned long)__per_cpu_load)
 #else
@@ -172,7 +169,7 @@ void __init setup_per_cpu_areas(void)
 	for_each_possible_cpu(cpu) {
 		per_cpu_offset(cpu) = delta + pcpu_unit_offsets[cpu];
 		per_cpu(this_cpu_off, cpu) = per_cpu_offset(cpu);
-		per_cpu(cpu_number, cpu) = cpu;
+		per_cpu(pcpu_hot.cpu_number, cpu) = cpu;
 		setup_percpu_segment(cpu);
 		/*
 		 * Copy data used in early init routines from the


