Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B658608301
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 02:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJVA4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 20:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJVA41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 20:56:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0582ADD23;
        Fri, 21 Oct 2022 17:56:25 -0700 (PDT)
Date:   Sat, 22 Oct 2022 00:56:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666400183;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dtbNVOzozDoLxz7Ta5CNEey8ofBIvBtFEI42oz4UfjA=;
        b=ady2zyN+Ald7cQ3/Fnt1ENKuudY9z+2KklIYbf1mDOtPhSmUfsDvak0SDku6ZcPU2234dv
        dFbCDTKRUYfaVxtShoGNyq2/vGQkgMrgM/hED42enrGw+GlyvBzvBVS5ufblaqi57vrbw+
        iPYSH3/MOeg6Xk7HLUaWtQ6BqjujmGgtPQ5z4yAr/Ll177fjZSwiyPReaW63xmne1/8a8R
        TwLpM6wyjIQ/qyTZQk45Nc9bFwX2aghoCk3tK5ngwszEjiwaIX5N7Qp7z3OPdoDYQPSjiq
        9HCTGphHxftCssnh8RRpqWUMnur/Nu5TbQ4n/FQWtCWi6VvXm1J6cJV+WBN2cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666400183;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dtbNVOzozDoLxz7Ta5CNEey8ofBIvBtFEI42oz4UfjA=;
        b=m8d6r+Pd3yp0NiPnAu77OC8GmEN28iBCshBq4itktaYlKrIFITsI3t4ik+PtvbBPGC/zI/
        uRuhWPoJVM7hmZDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Randomize per-cpu entry area
Cc:     Seth Jenkins <sethjenkins@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166640018118.401.11959688821203132730.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     1248fb6a8201ddac1c86a202f05a0a1765efbfce
Gitweb:        https://git.kernel.org/tip/1248fb6a8201ddac1c86a202f05a0a1765efbfce
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 07 Oct 2022 10:42:36 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 21 Oct 2022 17:53:05 -07:00

x86/mm: Randomize per-cpu entry area

Seth found that the CPU-entry-area; the piece of per-cpu data that is
mapped into the userspace page-tables for kPTI is not subject to any
randomization -- irrespective of kASLR settings.

On x86_64 a whole P4D (512 GB) of virtual address space is reserved for
this structure, which is plenty large enough to randomize things a
little.

As such, use a straightforward randomization scheme that avoids
duplicates to spread the existing CPUs over the available space.

This makes it harder to find the addresses of important structures in
the cpu entry areas like the entry stacks.

[ dhansen: add minor comment in "sodding terrible" loop,
	   fix 32-bit compile issue ]

Reported-by: Seth Jenkins <sethjenkins@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/cpu_entry_area.h |  4 +--
 arch/x86/include/asm/pgtable_areas.h  |  8 +++-
 arch/x86/kernel/hw_breakpoint.c       |  2 +-
 arch/x86/mm/cpu_entry_area.c          | 47 +++++++++++++++++++++++---
 4 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index 75efc4c..462fc34 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -130,10 +130,6 @@ struct cpu_entry_area {
 };
 
 #define CPU_ENTRY_AREA_SIZE		(sizeof(struct cpu_entry_area))
-#define CPU_ENTRY_AREA_ARRAY_SIZE	(CPU_ENTRY_AREA_SIZE * NR_CPUS)
-
-/* Total size includes the readonly IDT mapping page as well: */
-#define CPU_ENTRY_AREA_TOTAL_SIZE	(CPU_ENTRY_AREA_ARRAY_SIZE + PAGE_SIZE)
 
 DECLARE_PER_CPU(struct cpu_entry_area *, cpu_entry_area);
 DECLARE_PER_CPU(struct cea_exception_stacks *, cea_exception_stacks);
diff --git a/arch/x86/include/asm/pgtable_areas.h b/arch/x86/include/asm/pgtable_areas.h
index d34cce1..4f056fb 100644
--- a/arch/x86/include/asm/pgtable_areas.h
+++ b/arch/x86/include/asm/pgtable_areas.h
@@ -11,6 +11,12 @@
 
 #define CPU_ENTRY_AREA_RO_IDT_VADDR	((void *)CPU_ENTRY_AREA_RO_IDT)
 
-#define CPU_ENTRY_AREA_MAP_SIZE		(CPU_ENTRY_AREA_PER_CPU + CPU_ENTRY_AREA_ARRAY_SIZE - CPU_ENTRY_AREA_BASE)
+#ifdef CONFIG_X86_32
+#define CPU_ENTRY_AREA_MAP_SIZE		(CPU_ENTRY_AREA_PER_CPU +		\
+					 (CPU_ENTRY_AREA_SIZE * NR_CPUS) -	\
+					 CPU_ENTRY_AREA_BASE)
+#else
+#define CPU_ENTRY_AREA_MAP_SIZE		P4D_SIZE
+#endif
 
 #endif /* _ASM_X86_PGTABLE_AREAS_H */
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 668a4a6..bbb0f73 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -266,7 +266,7 @@ static inline bool within_cpu_entry(unsigned long addr, unsigned long end)
 
 	/* CPU entry erea is always used for CPU entry */
 	if (within_area(addr, end, CPU_ENTRY_AREA_BASE,
-			CPU_ENTRY_AREA_TOTAL_SIZE))
+			CPU_ENTRY_AREA_MAP_SIZE))
 		return true;
 
 	/*
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 6c2f1b7..ad1f750 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -15,16 +15,54 @@ static DEFINE_PER_CPU_PAGE_ALIGNED(struct entry_stack_page, entry_stack_storage)
 #ifdef CONFIG_X86_64
 static DEFINE_PER_CPU_PAGE_ALIGNED(struct exception_stacks, exception_stacks);
 DEFINE_PER_CPU(struct cea_exception_stacks*, cea_exception_stacks);
-#endif
 
-#ifdef CONFIG_X86_32
+static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, _cea_offset);
+
+static inline unsigned int cea_offset(unsigned int cpu)
+{
+	return per_cpu(_cea_offset, cpu);
+}
+
+static __init void init_cea_offsets(void)
+{
+	unsigned int max_cea;
+	unsigned int i, j;
+
+	max_cea = (CPU_ENTRY_AREA_MAP_SIZE - PAGE_SIZE) / CPU_ENTRY_AREA_SIZE;
+
+	/* O(sodding terrible) */
+	for_each_possible_cpu(i) {
+		unsigned int cea;
+
+again:
+		cea = prandom_u32_max(max_cea);
+
+		/* Make sure that no previous CPU shares the offset: */
+		for_each_possible_cpu(j) {
+			if (cea_offset(j) == cea)
+				goto again;
+
+			if (i == j)
+				break;
+		}
+
+		per_cpu(_cea_offset, i) = cea;
+	}
+}
+#else /* !X86_64 */
 DECLARE_PER_CPU_PAGE_ALIGNED(struct doublefault_stack, doublefault_stack);
+
+static inline unsigned int cea_offset(unsigned int cpu)
+{
+	return cpu;
+}
+static inline void init_cea_offsets(void) { }
 #endif
 
 /* Is called from entry code, so must be noinstr */
 noinstr struct cpu_entry_area *get_cpu_entry_area(int cpu)
 {
-	unsigned long va = CPU_ENTRY_AREA_PER_CPU + cpu * CPU_ENTRY_AREA_SIZE;
+	unsigned long va = CPU_ENTRY_AREA_PER_CPU + cea_offset(cpu) * CPU_ENTRY_AREA_SIZE;
 	BUILD_BUG_ON(sizeof(struct cpu_entry_area) % PAGE_SIZE != 0);
 
 	return (struct cpu_entry_area *) va;
@@ -205,7 +243,6 @@ static __init void setup_cpu_entry_area_ptes(void)
 
 	/* The +1 is for the readonly IDT: */
 	BUILD_BUG_ON((CPU_ENTRY_AREA_PAGES+1)*PAGE_SIZE != CPU_ENTRY_AREA_MAP_SIZE);
-	BUILD_BUG_ON(CPU_ENTRY_AREA_TOTAL_SIZE != CPU_ENTRY_AREA_MAP_SIZE);
 	BUG_ON(CPU_ENTRY_AREA_BASE & ~PMD_MASK);
 
 	start = CPU_ENTRY_AREA_BASE;
@@ -221,6 +258,8 @@ void __init setup_cpu_entry_areas(void)
 {
 	unsigned int cpu;
 
+	init_cea_offsets();
+
 	setup_cpu_entry_area_ptes();
 
 	for_each_possible_cpu(cpu)
