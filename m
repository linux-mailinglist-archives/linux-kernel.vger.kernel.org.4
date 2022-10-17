Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF036011F1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiJQO4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiJQOzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:55:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8AC691AD;
        Mon, 17 Oct 2022 07:54:15 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018448;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bgZAlWKNHj9wQS3KZTnB3ZCxJ/Wnpf181TzHRdX2FKA=;
        b=YlNR9Db+RZG+5isvFM85wozl7mSmBVyskeoBxcqD57vBTT9q+aZtg+VLAsvJsQPwd+TYR6
        A2M6kga3iFZcD4bl6iRLT6CenJkjlu1V2oY7qnv4VPyq76q5N7i8/mL9zZtvgj/wWmJUnZ
        G3+Q5aIB5jPeaZg3gdXgT9CBsowG0gdM5dwdlhre6EGHNXHEDuNKpBk4bu2fpy2Ql1XhUi
        nYC5ubGd/B0FNNhLrwSkaBWf1nsrf6f2jIHqZoXz0li/Iuw8NfHjhBsyv9oMm0tdS0JU2+
        hZ1c/BDC9yXHLtWU9e3fDtB0ZgFf3GRlXKhGvS6JB7VyEmzBjET8OIGE0mtY5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018448;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bgZAlWKNHj9wQS3KZTnB3ZCxJ/Wnpf181TzHRdX2FKA=;
        b=BSXg5bB1ZBavJnkvEcb9nAgUZcXdWmubTJkOdF40uXeVmN7UeXS7lcaEKC9Ye8WB5xdFzd
        YIVKcLYxpK9VVXCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/percpu: Move cpu_number next to current_task
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111145.387678283@infradead.org>
References: <20220915111145.387678283@infradead.org>
MIME-Version: 1.0
Message-ID: <166601844759.401.13692031213391443378.tip-bot2@tip-bot2>
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

Commit-ID:     7443b296e699e6922f5be243c8d2e316de8cacbe
Gitweb:        https://git.kernel.org/tip/7443b296e699e6922f5be243c8d2e316de8cacbe
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:11:03 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:04 +02:00

x86/percpu: Move cpu_number next to current_task

Also add cpu_number to the pcpu_hot structure, it is often referenced
and this cacheline is there.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111145.387678283@infradead.org
---
 arch/x86/include/asm/current.h |  1 +
 arch/x86/include/asm/smp.h     | 12 +++++-------
 arch/x86/kernel/setup_percpu.c |  5 +----
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 0f4b462..8ac6589 100644
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
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index a73bced..b4dbb20 100644
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
@@ -19,7 +19,6 @@ DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_l2c_shared_map);
 DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id);
 DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id);
-DECLARE_PER_CPU_READ_MOSTLY(int, cpu_number);
 
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid);
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid);
@@ -150,11 +149,10 @@ __visible void smp_call_function_single_interrupt(struct pt_regs *r);
 
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
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 555089a..c2fc4c4 100644
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
