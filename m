Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F59F68C0CC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjBFO55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjBFO5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:57:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0DB30E9;
        Mon,  6 Feb 2023 06:57:47 -0800 (PST)
Date:   Mon, 06 Feb 2023 14:57:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675695466;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=btbN0AE/UGdyFWTJPvRWHlPDrIrpiFlhuBh5UGVrx1M=;
        b=u8WcgwveZlDlKTB3PcAF2v8Of5TluA/5O2okM/udiJdqGcn3zBrt4lE8VErBZlnttYp3cy
        Zp94ttwdU5BSpN5dLorBjvDpgwDTO0kZhSdthcVcYi6VfCIxv38vUOn66M1tPrwELRaxUV
        ALnh+7/7PeRixhwIR79L3rv9rMyHjlRkER1r19cd8cLDdozjmKLoh1ESQ2gNSziAGQwTad
        1v6OtcqOf69vVc0u7alP2Dtnab9322ulbpuWmTcNgGr0BN5IMmPjwz/ntbXnWFXwpb3UeW
        yocTEFGKjOKbhQnrQfBsJ2I5nUo36jo89vZ8ADrO7VCPK0gv7cyV/MTrCRNFcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675695466;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=btbN0AE/UGdyFWTJPvRWHlPDrIrpiFlhuBh5UGVrx1M=;
        b=YthzoUKr3G3xki8S9TZwIoJ2oP0ChNzjwit+Y3+AbIY/gqiTRAFh9BkbY/xIMqWFhea0Ac
        haHRXFnb6mpOoLDw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vdso] x86/cpu: Provide the full setup for getcpu() on x86-32
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Roland Mainz <roland.mainz@nrubsig.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221125094216.3663444-2-bigeasy@linutronix.de>
References: <20221125094216.3663444-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <167569546601.4906.5987162401774591165.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/vdso branch of tip:

Commit-ID:     717cce3bdcf34705417f641bf2fcdf9b038ec36c
Gitweb:        https://git.kernel.org/tip/717cce3bdcf34705417f641bf2fcdf9b038ec36c
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 10:42:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 06 Feb 2023 15:48:54 +01:00

x86/cpu: Provide the full setup for getcpu() on x86-32

setup_getcpu() configures two things:

  - it writes the current CPU & node information into MSR_TSC_AUX
  - it writes the same information as a GDT entry.

By using the "full" setup_getcpu() on i386 it is possible to read the CPU
information in userland via RDTSCP() or via LSL from the GDT.

Provide an GDT_ENTRY_CPUNODE for x86-32 and make the setup function
unconditionally available.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Link: https://lore.kernel.org/r/20221125094216.3663444-2-bigeasy@linutronix.de

---
 arch/x86/include/asm/segment.h | 8 ++++----
 arch/x86/kernel/cpu/common.c   | 4 +---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index c390a67..794f696 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -96,7 +96,7 @@
  *
  *  26 - ESPFIX small SS
  *  27 - per-cpu			[ offset to per-cpu data area ]
- *  28 - unused
+ *  28 - VDSO getcpu
  *  29 - unused
  *  30 - unused
  *  31 - TSS for double fault handler
@@ -119,6 +119,7 @@
 
 #define GDT_ENTRY_ESPFIX_SS		26
 #define GDT_ENTRY_PERCPU		27
+#define GDT_ENTRY_CPUNODE		28
 
 #define GDT_ENTRY_DOUBLEFAULT_TSS	31
 
@@ -159,6 +160,8 @@
 # define __KERNEL_PERCPU		0
 #endif
 
+#define __CPUNODE_SEG			(GDT_ENTRY_CPUNODE*8 + 3)
+
 #else /* 64-bit: */
 
 #include <asm/cache.h>
@@ -226,8 +229,6 @@
 #define GDT_ENTRY_TLS_ENTRIES		3
 #define TLS_SIZE			(GDT_ENTRY_TLS_ENTRIES* 8)
 
-#ifdef CONFIG_X86_64
-
 /* Bit size and mask of CPU number stored in the per CPU data (and TSC_AUX) */
 #define VDSO_CPUNODE_BITS		12
 #define VDSO_CPUNODE_MASK		0xfff
@@ -265,7 +266,6 @@ static inline void vdso_read_cpunode(unsigned *cpu, unsigned *node)
 }
 
 #endif /* !__ASSEMBLY__ */
-#endif /* CONFIG_X86_64 */
 
 #ifdef __KERNEL__
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3a9043e..a26ce20 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2124,7 +2124,6 @@ static void wait_for_master_cpu(int cpu)
 #endif
 }
 
-#ifdef CONFIG_X86_64
 static inline void setup_getcpu(int cpu)
 {
 	unsigned long cpudata = vdso_encode_cpunode(cpu, early_cpu_to_node(cpu));
@@ -2146,6 +2145,7 @@ static inline void setup_getcpu(int cpu)
 	write_gdt_entry(get_cpu_gdt_rw(cpu), GDT_ENTRY_CPUNODE, &d, DESCTYPE_S);
 }
 
+#ifdef CONFIG_X86_64
 static inline void ucode_cpu_init(int cpu)
 {
 	if (cpu)
@@ -2165,8 +2165,6 @@ static inline void tss_setup_ist(struct tss_struct *tss)
 
 #else /* CONFIG_X86_64 */
 
-static inline void setup_getcpu(int cpu) { }
-
 static inline void ucode_cpu_init(int cpu)
 {
 	show_ucode_info_early();
