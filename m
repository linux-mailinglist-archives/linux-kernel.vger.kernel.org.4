Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC3E669769
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241693AbjAMMgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241230AbjAMMcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81265559E7;
        Fri, 13 Jan 2023 04:31:14 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vD+1ocIfnp8gDmyOQKozdQLQVY771VujSZ7nF98x9ew=;
        b=1clR6ztfmQS15XLMMMWiIv3lAIVsbFdApD0QW5Nlp9xCp6Bd5yA4Cu7dsL/hoVyRy1tS8i
        /eOP649TexMAhhgUfMl6jscba3WieFf3LhIDa+n5bl//XO3xI+iNbU9NMS683UHDUNanzN
        VtIDb/5R4WCkZXdKCJ8wWjYjDhnsqaEnkqL08ie5RgCcBOdj/wIDb7Tc9uhMVtmg5FdgbP
        GTD64QWXj2bK9U03OumvgigsGfmclA2kBqXJCBV/ie8J0BDvrCOq5Lp/MqAKAZIf5nxSH1
        +/VB09fkPEuROc78X42xPKeKt9zNsR2HqqwfOREFnDOEMSL0iuQttjvwx76jZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vD+1ocIfnp8gDmyOQKozdQLQVY771VujSZ7nF98x9ew=;
        b=MJCXe9opek8NEfC3DCG9DxEHgct8ajkR42z6gV0IOte6XrpEx7BCw7IEQB2Mbxw0UiVGNi
        1o/KzwLWFm3mNPBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] objtool/idle: Validate __cpuidle code as noinstr
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195540.373461409@infradead.org>
References: <20230112195540.373461409@infradead.org>
MIME-Version: 1.0
Message-ID: <167361307281.4906.11393514364422209454.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2b5a0e425e6e319b1978db1e9564f6af4228a567
Gitweb:        https://git.kernel.org/tip/2b5a0e425e6e319b1978db1e9564f6af4228a567
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:31 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:15 +01:00

objtool/idle: Validate __cpuidle code as noinstr

Idle code is very like entry code in that RCU isn't available. As
such, add a little validation.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230112195540.373461409@infradead.org
---
 arch/alpha/kernel/vmlinux.lds.S      |  1 -
 arch/arc/kernel/vmlinux.lds.S        |  1 -
 arch/arm/include/asm/vmlinux.lds.h   |  1 -
 arch/arm64/kernel/vmlinux.lds.S      |  1 -
 arch/csky/kernel/vmlinux.lds.S       |  1 -
 arch/hexagon/kernel/vmlinux.lds.S    |  1 -
 arch/ia64/kernel/vmlinux.lds.S       |  1 -
 arch/loongarch/kernel/vmlinux.lds.S  |  1 -
 arch/m68k/kernel/vmlinux-nommu.lds   |  1 -
 arch/m68k/kernel/vmlinux-std.lds     |  1 -
 arch/m68k/kernel/vmlinux-sun3.lds    |  1 -
 arch/microblaze/kernel/vmlinux.lds.S |  1 -
 arch/mips/kernel/vmlinux.lds.S       |  1 -
 arch/nios2/kernel/vmlinux.lds.S      |  1 -
 arch/openrisc/kernel/vmlinux.lds.S   |  1 -
 arch/parisc/kernel/vmlinux.lds.S     |  1 -
 arch/powerpc/kernel/vmlinux.lds.S    |  1 -
 arch/riscv/kernel/vmlinux-xip.lds.S  |  1 -
 arch/riscv/kernel/vmlinux.lds.S      |  1 -
 arch/s390/kernel/vmlinux.lds.S       |  1 -
 arch/sh/kernel/vmlinux.lds.S         |  1 -
 arch/sparc/kernel/vmlinux.lds.S      |  1 -
 arch/um/kernel/dyn.lds.S             |  1 -
 arch/um/kernel/uml.lds.S             |  1 -
 arch/x86/include/asm/irqflags.h      | 11 ++++-------
 arch/x86/include/asm/mwait.h         |  2 +-
 arch/x86/kernel/vmlinux.lds.S        |  1 -
 arch/xtensa/kernel/vmlinux.lds.S     |  1 -
 include/asm-generic/vmlinux.lds.h    |  9 +++------
 include/linux/compiler_types.h       |  8 ++++++--
 include/linux/cpu.h                  |  3 ---
 tools/objtool/check.c                | 13 +++++++++++++
 32 files changed, 27 insertions(+), 45 deletions(-)

diff --git a/arch/alpha/kernel/vmlinux.lds.S b/arch/alpha/kernel/vmlinux.lds.S
index 5b78d64..2efa7df 100644
--- a/arch/alpha/kernel/vmlinux.lds.S
+++ b/arch/alpha/kernel/vmlinux.lds.S
@@ -27,7 +27,6 @@ SECTIONS
 		HEAD_TEXT
 		TEXT_TEXT
 		SCHED_TEXT
-		CPUIDLE_TEXT
 		LOCK_TEXT
 		*(.fixup)
 		*(.gnu.warning)
diff --git a/arch/arc/kernel/vmlinux.lds.S b/arch/arc/kernel/vmlinux.lds.S
index 529ae50..549c3f4 100644
--- a/arch/arc/kernel/vmlinux.lds.S
+++ b/arch/arc/kernel/vmlinux.lds.S
@@ -85,7 +85,6 @@ SECTIONS
 		_stext = .;
 		TEXT_TEXT
 		SCHED_TEXT
-		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		IRQENTRY_TEXT
diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
index fad45c8..4c8632d 100644
--- a/arch/arm/include/asm/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -96,7 +96,6 @@
 		SOFTIRQENTRY_TEXT					\
 		TEXT_TEXT						\
 		SCHED_TEXT						\
-		CPUIDLE_TEXT						\
 		LOCK_TEXT						\
 		KPROBES_TEXT						\
 		ARM_STUBS_TEXT						\
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 4c13daf..2777214 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -175,7 +175,6 @@ SECTIONS
 			ENTRY_TEXT
 			TEXT_TEXT
 			SCHED_TEXT
-			CPUIDLE_TEXT
 			LOCK_TEXT
 			KPROBES_TEXT
 			HYPERVISOR_TEXT
diff --git a/arch/csky/kernel/vmlinux.lds.S b/arch/csky/kernel/vmlinux.lds.S
index 68c980d..d718961 100644
--- a/arch/csky/kernel/vmlinux.lds.S
+++ b/arch/csky/kernel/vmlinux.lds.S
@@ -34,7 +34,6 @@ SECTIONS
 		SOFTIRQENTRY_TEXT
 		TEXT_TEXT
 		SCHED_TEXT
-		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		*(.fixup)
diff --git a/arch/hexagon/kernel/vmlinux.lds.S b/arch/hexagon/kernel/vmlinux.lds.S
index 57465bf..1140051 100644
--- a/arch/hexagon/kernel/vmlinux.lds.S
+++ b/arch/hexagon/kernel/vmlinux.lds.S
@@ -41,7 +41,6 @@ SECTIONS
 		IRQENTRY_TEXT
 		SOFTIRQENTRY_TEXT
 		SCHED_TEXT
-		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		*(.fixup)
diff --git a/arch/ia64/kernel/vmlinux.lds.S b/arch/ia64/kernel/vmlinux.lds.S
index 9b26578..53dfde1 100644
--- a/arch/ia64/kernel/vmlinux.lds.S
+++ b/arch/ia64/kernel/vmlinux.lds.S
@@ -51,7 +51,6 @@ SECTIONS {
 		__end_ivt_text = .;
 		TEXT_TEXT
 		SCHED_TEXT
-		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		IRQENTRY_TEXT
diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
index 733b16e..78506b3 100644
--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -43,7 +43,6 @@ SECTIONS
 	.text : {
 		TEXT_TEXT
 		SCHED_TEXT
-		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		IRQENTRY_TEXT
diff --git a/arch/m68k/kernel/vmlinux-nommu.lds b/arch/m68k/kernel/vmlinux-nommu.lds
index 387f334..2624fc1 100644
--- a/arch/m68k/kernel/vmlinux-nommu.lds
+++ b/arch/m68k/kernel/vmlinux-nommu.lds
@@ -48,7 +48,6 @@ SECTIONS {
 		IRQENTRY_TEXT
 		SOFTIRQENTRY_TEXT
 		SCHED_TEXT
-		CPUIDLE_TEXT
 		LOCK_TEXT
 		*(.fixup)
 		. = ALIGN(16);
diff --git a/arch/m68k/kernel/vmlinux-std.lds b/arch/m68k/kernel/vmlinux-std.lds
index ed1d9ed..1ccdd04 100644
--- a/arch/m68k/kernel/vmlinux-std.lds
+++ b/arch/m68k/kernel/vmlinux-std.lds
@@ -19,7 +19,6 @@ SECTIONS
 	IRQENTRY_TEXT
 	SOFTIRQENTRY_TEXT
 	SCHED_TEXT
-	CPUIDLE_TEXT
 	LOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
diff --git a/arch/m68k/kernel/vmlinux-sun3.lds b/arch/m68k/kernel/vmlinux-sun3.lds
index 4a52f44..f13ddcc 100644
--- a/arch/m68k/kernel/vmlinux-sun3.lds
+++ b/arch/m68k/kernel/vmlinux-sun3.lds
@@ -19,7 +19,6 @@ SECTIONS
 	IRQENTRY_TEXT
 	SOFTIRQENTRY_TEXT
 	SCHED_TEXT
-	CPUIDLE_TEXT
 	LOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
index fb31747..ae50d3d 100644
--- a/arch/microblaze/kernel/vmlinux.lds.S
+++ b/arch/microblaze/kernel/vmlinux.lds.S
@@ -36,7 +36,6 @@ SECTIONS {
 		EXIT_TEXT
 		EXIT_CALL
 		SCHED_TEXT
-		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		IRQENTRY_TEXT
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 1f98947..52cbde6 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -61,7 +61,6 @@ SECTIONS
 	.text : {
 		TEXT_TEXT
 		SCHED_TEXT
-		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		IRQENTRY_TEXT
diff --git a/arch/nios2/kernel/vmlinux.lds.S b/arch/nios2/kernel/vmlinux.lds.S
index 126e114..37b9580 100644
--- a/arch/nios2/kernel/vmlinux.lds.S
+++ b/arch/nios2/kernel/vmlinux.lds.S
@@ -24,7 +24,6 @@ SECTIONS
 	.text : {
 		TEXT_TEXT
 		SCHED_TEXT
-		CPUIDLE_TEXT
 		LOCK_TEXT
 		IRQENTRY_TEXT
 		SOFTIRQENTRY_TEXT
diff --git a/arch/openrisc/kernel/vmlinux.lds.S b/arch/openrisc/kernel/vmlinux.lds.S
index d5c7bb0..bc13060 100644
--- a/arch/openrisc/kernel/vmlinux.lds.S
+++ b/arch/openrisc/kernel/vmlinux.lds.S
@@ -52,7 +52,6 @@ SECTIONS
           _stext = .;
 	  TEXT_TEXT
 	  SCHED_TEXT
-	  CPUIDLE_TEXT
 	  LOCK_TEXT
 	  KPROBES_TEXT
 	  IRQENTRY_TEXT
diff --git a/arch/parisc/kernel/vmlinux.lds.S b/arch/parisc/kernel/vmlinux.lds.S
index 2769eb9..1aaa2ca 100644
--- a/arch/parisc/kernel/vmlinux.lds.S
+++ b/arch/parisc/kernel/vmlinux.lds.S
@@ -86,7 +86,6 @@ SECTIONS
 		TEXT_TEXT
 		LOCK_TEXT
 		SCHED_TEXT
-		CPUIDLE_TEXT
 		KPROBES_TEXT
 		IRQENTRY_TEXT
 		SOFTIRQENTRY_TEXT
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 8c3862b..86d5ca1 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -111,7 +111,6 @@ SECTIONS
 #endif
 		NOINSTR_TEXT
 		SCHED_TEXT
-		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		IRQENTRY_TEXT
diff --git a/arch/riscv/kernel/vmlinux-xip.lds.S b/arch/riscv/kernel/vmlinux-xip.lds.S
index 75e0fa8..eab9edc 100644
--- a/arch/riscv/kernel/vmlinux-xip.lds.S
+++ b/arch/riscv/kernel/vmlinux-xip.lds.S
@@ -39,7 +39,6 @@ SECTIONS
 		_stext = .;
 		TEXT_TEXT
 		SCHED_TEXT
-		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		ENTRY_TEXT
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 4e6c88a..643ab60 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -42,7 +42,6 @@ SECTIONS
 		_stext = .;
 		TEXT_TEXT
 		SCHED_TEXT
-		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		ENTRY_TEXT
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 5ea3830..d1f1ab2 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -42,7 +42,6 @@ SECTIONS
 		HEAD_TEXT
 		TEXT_TEXT
 		SCHED_TEXT
-		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		IRQENTRY_TEXT
diff --git a/arch/sh/kernel/vmlinux.lds.S b/arch/sh/kernel/vmlinux.lds.S
index 3161b9c..947e2e2 100644
--- a/arch/sh/kernel/vmlinux.lds.S
+++ b/arch/sh/kernel/vmlinux.lds.S
@@ -29,7 +29,6 @@ SECTIONS
 		HEAD_TEXT
 		TEXT_TEXT
 		SCHED_TEXT
-		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		IRQENTRY_TEXT
diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index d55ae65..d317a84 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -50,7 +50,6 @@ SECTIONS
 		HEAD_TEXT
 		TEXT_TEXT
 		SCHED_TEXT
-		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		IRQENTRY_TEXT
diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
index 2b7fc5b..3385d65 100644
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -74,7 +74,6 @@ SECTIONS
     _stext = .;
     TEXT_TEXT
     SCHED_TEXT
-    CPUIDLE_TEXT
     LOCK_TEXT
     IRQENTRY_TEXT
     SOFTIRQENTRY_TEXT
diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
index 71a59b8..5c92d58 100644
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -35,7 +35,6 @@ SECTIONS
     _stext = .;
     TEXT_TEXT
     SCHED_TEXT
-    CPUIDLE_TEXT
     LOCK_TEXT
     IRQENTRY_TEXT
     SOFTIRQENTRY_TEXT
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 7793e52..8c5ae64 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -8,9 +8,6 @@
 
 #include <asm/nospec-branch.h>
 
-/* Provide __cpuidle; we can't safely include <linux/cpu.h> */
-#define __cpuidle __section(".cpuidle.text")
-
 /*
  * Interrupt control:
  */
@@ -45,13 +42,13 @@ static __always_inline void native_irq_enable(void)
 	asm volatile("sti": : :"memory");
 }
 
-static inline __cpuidle void native_safe_halt(void)
+static __always_inline void native_safe_halt(void)
 {
 	mds_idle_clear_cpu_buffers();
 	asm volatile("sti; hlt": : :"memory");
 }
 
-static inline __cpuidle void native_halt(void)
+static __always_inline void native_halt(void)
 {
 	mds_idle_clear_cpu_buffers();
 	asm volatile("hlt": : :"memory");
@@ -84,7 +81,7 @@ static __always_inline void arch_local_irq_enable(void)
  * Used in the idle loop; sti takes one instruction cycle
  * to complete:
  */
-static inline __cpuidle void arch_safe_halt(void)
+static __always_inline void arch_safe_halt(void)
 {
 	native_safe_halt();
 }
@@ -93,7 +90,7 @@ static inline __cpuidle void arch_safe_halt(void)
  * Used when interrupts are already enabled or to
  * shutdown the processor:
  */
-static inline __cpuidle void halt(void)
+static __always_inline void halt(void)
 {
 	native_halt();
 }
diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 3a8fdf8..f224216 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -105,7 +105,7 @@ static inline void __sti_mwait(unsigned long eax, unsigned long ecx)
  * New with Core Duo processors, MWAIT can take some hints based on CPU
  * capability.
  */
-static inline void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
+static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
 {
 	if (static_cpu_has_bug(X86_BUG_MONITOR) || !current_set_polling_and_test()) {
 		if (static_cpu_has_bug(X86_BUG_CLFLUSH_MONITOR)) {
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 2e0ee14..25f1552 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -129,7 +129,6 @@ SECTIONS
 		HEAD_TEXT
 		TEXT_TEXT
 		SCHED_TEXT
-		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		SOFTIRQENTRY_TEXT
diff --git a/arch/xtensa/kernel/vmlinux.lds.S b/arch/xtensa/kernel/vmlinux.lds.S
index 965a395..c14fd96 100644
--- a/arch/xtensa/kernel/vmlinux.lds.S
+++ b/arch/xtensa/kernel/vmlinux.lds.S
@@ -125,7 +125,6 @@ SECTIONS
     ENTRY_TEXT
     TEXT_TEXT
     SCHED_TEXT
-    CPUIDLE_TEXT
     LOCK_TEXT
     *(.fixup)
   }
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index a94219e..ad0d394 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -558,6 +558,9 @@
 		ALIGN_FUNCTION();					\
 		__noinstr_text_start = .;				\
 		*(.noinstr.text)					\
+		__cpuidle_text_start = .;				\
+		*(.cpuidle.text)					\
+		__cpuidle_text_end = .;					\
 		__noinstr_text_end = .;
 
 /*
@@ -598,12 +601,6 @@
 		*(.spinlock.text)					\
 		__lock_text_end = .;
 
-#define CPUIDLE_TEXT							\
-		ALIGN_FUNCTION();					\
-		__cpuidle_text_start = .;				\
-		*(.cpuidle.text)					\
-		__cpuidle_text_end = .;
-
 #define KPROBES_TEXT							\
 		ALIGN_FUNCTION();					\
 		__kprobes_text_start = .;				\
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 7c1afe0..d785890 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -232,11 +232,15 @@ struct ftrace_likely_data {
 #endif
 
 /* Section for code which can't be instrumented at all */
-#define noinstr								\
-	noinline notrace __attribute((__section__(".noinstr.text")))	\
+#define __noinstr_section(section)					\
+	noinline notrace __attribute((__section__(section)))		\
 	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage \
 	__no_sanitize_memory
 
+#define noinstr __noinstr_section(".noinstr.text")
+
+#define __cpuidle __noinstr_section(".cpuidle.text")
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 314802f..f83e451 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -176,9 +176,6 @@ void __noreturn cpu_startup_entry(enum cpuhp_state state);
 
 void cpu_idle_poll_ctrl(bool enable);
 
-/* Attach to any functions which should be considered cpuidle. */
-#define __cpuidle	__section(".cpuidle.text")
-
 bool cpu_in_idle(unsigned long pc);
 
 void arch_cpu_idle(void);
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4350be7..64954aa 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -376,6 +376,7 @@ static int decode_instructions(struct objtool_file *file)
 
 		if (!strcmp(sec->name, ".noinstr.text") ||
 		    !strcmp(sec->name, ".entry.text") ||
+		    !strcmp(sec->name, ".cpuidle.text") ||
 		    !strncmp(sec->name, ".text.__x86.", 12))
 			sec->noinstr = true;
 
@@ -3366,6 +3367,12 @@ static inline bool noinstr_call_dest(struct objtool_file *file,
 		return true;
 
 	/*
+	 * If the symbol is a static_call trampoline, we can't tell.
+	 */
+	if (func->static_call_tramp)
+		return true;
+
+	/*
 	 * The __ubsan_handle_*() calls are like WARN(), they only happen when
 	 * something 'BAD' happened. At the risk of taking the machine down,
 	 * let them proceed to get the message out.
@@ -4162,6 +4169,12 @@ static int validate_noinstr_sections(struct objtool_file *file)
 		warnings += validate_unwind_hints(file, sec);
 	}
 
+	sec = find_section_by_name(file->elf, ".cpuidle.text");
+	if (sec) {
+		warnings += validate_section(file, sec);
+		warnings += validate_unwind_hints(file, sec);
+	}
+
 	return warnings;
 }
 
