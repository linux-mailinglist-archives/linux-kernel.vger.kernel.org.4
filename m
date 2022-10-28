Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A656661196A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJ1Rj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiJ1Rjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:39:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813021DF14;
        Fri, 28 Oct 2022 10:39:52 -0700 (PDT)
Date:   Fri, 28 Oct 2022 17:39:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666978790;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UiPdG5k8gJvNWDbDE/9f5VP8P+b9HkftTWXtU7KSg3s=;
        b=hm9ODeEsrzVsqdGIGL+j3sQ1ebeyBRRWau5QpI5Kz4JDhfrktOfrJYxHdFj7cLe8L8BIyW
        TAyIlFyfqsWt6JEVm/0ha+YmWlvqhGRz2DFsqp5etY47DWSJ6EXL5FelL1E2UxENZNWajv
        czlGVE761TO3AKKbiiMyuL6fV2CtigCYxGzltNAzpr+DpCiBYER2+4jP3ONQEiTBRItwK6
        0A1Ga2db3oi7LUkLT262uW7kPQIaBhce0SB8S+u9uRUo/1rVDQep//2Hex8/EIqXWrIL5r
        D173uRN5KxDz6Ykb4bQMnykrM11OEuVY0+dIvTxw0A3wbcH13Oa6tcMnZhGIWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666978790;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UiPdG5k8gJvNWDbDE/9f5VP8P+b9HkftTWXtU7KSg3s=;
        b=xUjRY5USReptemfXlJQfw1+TKFKgAftWNKBla51hpB+H0JfCcNEXouesn2h1PkF6CDSVz+
        nDd4RAhlXLRktfBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Randomize per-cpu entry area
Cc:     Seth Jenkins <sethjenkins@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166697878870.7716.9070036132564599807.tip-bot2@tip-bot2>
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

Commit-ID:     8844b5452d14ffd6c9d259d419842039ed656b7d
Gitweb:        https://git.kernel.org/tip/8844b5452d14ffd6c9d259d419842039ed656b7d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 27 Oct 2022 14:54:41 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 28 Oct 2022 19:29:35 +02:00

x86/mm: Randomize per-cpu entry area

Seth found that the CPU-entry-area; the piece of per-cpu data that is
mapped into the userspace page-tables for kPTI is not subject to any
randomization -- irrespective of kASLR settings.

On x86_64 a whole P4D (512 GB) of virtual address space is reserved for
this structure, which is plenty large enough to randomize things a
little.

As such, use a straight forward randomization scheme that avoids
duplicates to spread the existing CPUs over the available space.

  [ bp: Fix le build. ]

Reported-by: Seth Jenkins <sethjenkins@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/cpu_entry_area.h |  4 +--
 arch/x86/include/asm/pgtable_areas.h  |  8 ++++-
 arch/x86/kernel/hw_breakpoint.c       |  2 +-
 arch/x86/mm/cpu_entry_area.c          | 46 +++++++++++++++++++++++---
 4 files changed, 50 insertions(+), 10 deletions(-)

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
index d7081b1..dff9001 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -16,16 +16,53 @@ static DEFINE_PER_CPU_PAGE_ALIGNED(struct entry_stack_page, entry_stack_storage)
 #ifdef CONFIG_X86_64
 static DEFINE_PER_CPU_PAGE_ALIGNED(struct exception_stacks, exception_stacks);
 DEFINE_PER_CPU(struct cea_exception_stacks*, cea_exception_stacks);
-#endif
 
-#ifdef CONFIG_X86_32
+static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, _cea_offset);
+
+static __always_inline unsigned int cea_offset(unsigned int cpu)
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
+static __always_inline unsigned int cea_offset(unsigned int cpu)
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
@@ -211,7 +248,6 @@ static __init void setup_cpu_entry_area_ptes(void)
 
 	/* The +1 is for the readonly IDT: */
 	BUILD_BUG_ON((CPU_ENTRY_AREA_PAGES+1)*PAGE_SIZE != CPU_ENTRY_AREA_MAP_SIZE);
-	BUILD_BUG_ON(CPU_ENTRY_AREA_TOTAL_SIZE != CPU_ENTRY_AREA_MAP_SIZE);
 	BUG_ON(CPU_ENTRY_AREA_BASE & ~PMD_MASK);
 
 	start = CPU_ENTRY_AREA_BASE;
@@ -227,6 +263,8 @@ void __init setup_cpu_entry_areas(void)
 {
 	unsigned int cpu;
 
+	init_cea_offsets();
+
 	setup_cpu_entry_area_ptes();
 
 	for_each_possible_cpu(cpu)
