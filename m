Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFBC7048BD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjEPJMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjEPJKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:10:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCE54C3A;
        Tue, 16 May 2023 02:10:06 -0700 (PDT)
Date:   Tue, 16 May 2023 09:10:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684228203;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jEOB4TbsY4OLSvYrgTUnUnazkHtxm0f8iafS7O2hm7I=;
        b=htwn8EHV/NBqAQUfGLyZO0yGUQbcdQ9CWmVnibavHQuttd0B1XR6WXbfci2TldWx7ZU59M
        FlQw+77IOGgkefOr0xheAvQnC04aaYzblyJzNHcUGtNjjmkWoBmof/mPTx/HPDnjbQ+Fqh
        Lh0LPzjxDGzx78TJZ/5NaRL0+mQLApqSF2cFwDGMKqeuW2gcyVe2HP7k15tU8mhHRUhmOO
        C16OLHs6DvfmNEOBjpv8ZsMHt8HvMYhvPycDhs67jUQqiCr51oj5e2JCFQZzLG43KnGKy6
        Efnjo+OT3I8X4E42T5oMM8ha6O4XO0bIzB2mjWq50Orf+NgbIp4QX+UZ3oMwMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684228203;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jEOB4TbsY4OLSvYrgTUnUnazkHtxm0f8iafS7O2hm7I=;
        b=atN89+TrQ43+FjZdFEzsZGlsem/jE+SH6MoYk5aiIivwTrj0prA63bdtGeG0R+QsU9MaHt
        dQWTfKLgeuqXEiAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] x86/smpboot: Rename start_cpu0() to soft_restart_cpu()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512205255.662319599@linutronix.de>
References: <20230512205255.662319599@linutronix.de>
MIME-Version: 1.0
Message-ID: <168422820288.404.1720586361371515866.tip-bot2@tip-bot2>
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

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     666e1156b2c514f045827f50263ed2eb9d78671b
Gitweb:        https://git.kernel.org/tip/666e1156b2c514f045827f50263ed2eb9d78671b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 May 2023 23:07:03 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 May 2023 13:44:48 +02:00

x86/smpboot: Rename start_cpu0() to soft_restart_cpu()

This is used in the SEV play_dead() implementation to re-online CPUs. But
that has nothing to do with CPU0.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Link: https://lore.kernel.org/r/20230512205255.662319599@linutronix.de
---
 arch/x86/include/asm/cpu.h   |  2 +-
 arch/x86/kernel/callthunks.c |  2 +-
 arch/x86/kernel/head_32.S    | 10 +++++-----
 arch/x86/kernel/head_64.S    | 10 +++++-----
 arch/x86/kernel/sev.c        |  2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 78796b9..b356464 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -30,7 +30,7 @@ struct x86_cpu {
 #ifdef CONFIG_HOTPLUG_CPU
 extern int arch_register_cpu(int num);
 extern void arch_unregister_cpu(int);
-extern void start_cpu0(void);
+extern void soft_restart_cpu(void);
 #ifdef CONFIG_DEBUG_HOTPLUG_CPU0
 extern int _debug_hotplug_cpu(int cpu, int action);
 #endif
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 22ab139..f5a6236 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -134,7 +134,7 @@ static bool skip_addr(void *dest)
 	if (dest == ret_from_fork)
 		return true;
 #ifdef CONFIG_HOTPLUG_CPU
-	if (dest == start_cpu0)
+	if (dest == soft_restart_cpu)
 		return true;
 #endif
 #ifdef CONFIG_FUNCTION_TRACER
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 67c8ed9..805abf1 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -140,16 +140,16 @@ SYM_CODE_END(startup_32)
 
 #ifdef CONFIG_HOTPLUG_CPU
 /*
- * Boot CPU0 entry point. It's called from play_dead(). Everything has been set
- * up already except stack. We just set up stack here. Then call
- * start_secondary().
+ * Entry point for soft restart of a CPU. Invoked from xxx_play_dead() for
+ * restarting the boot CPU or for restarting SEV guest CPUs after CPU hot
+ * unplug. Everything is set up already except the stack.
  */
-SYM_FUNC_START(start_cpu0)
+SYM_FUNC_START(soft_restart_cpu)
 	movl initial_stack, %ecx
 	movl %ecx, %esp
 	call *(initial_code)
 1:	jmp 1b
-SYM_FUNC_END(start_cpu0)
+SYM_FUNC_END(soft_restart_cpu)
 #endif
 
 /*
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index a5df3e9..fc86bc1 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -377,11 +377,11 @@ SYM_CODE_END(secondary_startup_64)
 
 #ifdef CONFIG_HOTPLUG_CPU
 /*
- * Boot CPU0 entry point. It's called from play_dead(). Everything has been set
- * up already except stack. We just set up stack here. Then call
- * start_secondary() via .Ljump_to_C_code.
+ * Entry point for soft restart of a CPU. Invoked from xxx_play_dead() for
+ * restarting the boot CPU or for restarting SEV guest CPUs after CPU hot
+ * unplug. Everything is set up already except the stack.
  */
-SYM_CODE_START(start_cpu0)
+SYM_CODE_START(soft_restart_cpu)
 	ANNOTATE_NOENDBR
 	UNWIND_HINT_END_OF_STACK
 
@@ -390,7 +390,7 @@ SYM_CODE_START(start_cpu0)
 	movq	TASK_threadsp(%rcx), %rsp
 
 	jmp	.Ljump_to_C_code
-SYM_CODE_END(start_cpu0)
+SYM_CODE_END(soft_restart_cpu)
 #endif
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index b031244..d095a5d 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1328,7 +1328,7 @@ static void sev_es_play_dead(void)
 	 * If we get here, the VCPU was woken up again. Jump to CPU
 	 * startup code to get it back online.
 	 */
-	start_cpu0();
+	soft_restart_cpu();
 }
 #else  /* CONFIG_HOTPLUG_CPU */
 #define sev_es_play_dead	native_play_dead
