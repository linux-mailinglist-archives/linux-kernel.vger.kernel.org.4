Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512315F7569
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 10:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiJGImp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 04:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiJGImn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:42:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A2EA4B8C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 01:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=4oWFlg3RZB1P5uvt6YBxdefvGUOdBvg6L31EplnSgr4=; b=I5lQUtZJHJOf+JoH+qrrveZjZr
        k7XNPwzbsTo94z2NcoHOaRJ9EdE6lMljmu4mxxMSKqycxiUHIYF3A9W7W305e0CzsK83K5k9Whe96
        PKcp6ERIRmxZcj7pI3jBgRvJ7afbGDhr34cKrTNUrz4uUm/LxLk+7gb5GKRksRgcbplTazSzhxGgc
        0VT4B5WKWFwzLiVeOPFKPPsf7psTKertXkkAEbnBT5IUu7T9PmtYj55ZotFzNnZ9pc06Cim8TeWvq
        Vw2r1FtN+d+r1nH1kbcTmj+UgSYx4jbihbVHhJFKNA4LDwh4aSvLQOBhsVuC04bihvaWWKkBOXGG1
        TGB2J9DA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogiwL-001lI4-6w; Fri, 07 Oct 2022 08:42:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BA024300155;
        Fri,  7 Oct 2022 10:42:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 93A702BD2992D; Fri,  7 Oct 2022 10:42:36 +0200 (CEST)
Date:   Fri, 7 Oct 2022 10:42:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     Jann Horn <jannh@google.com>,
        Natalie Silvanovich <natashenka@google.com>,
        Seth Jenkins <sethjenkins@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, Jason@zx2c4.com
Subject: x86/mm: Randomize per-cpu entry area
Message-ID: <Yz/mfJ1gjgshF19t@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Seth found that the CPU-entry-area; the piece of per-cpu data that is
mapped into the userspace page-tables for kPTI is not subject to any
randomization -- irrespective of kASLR settings.

On x86_64 a whole P4D (512 GB) of virtual address space is reserved for
this structure, which is plenty large enough to randomize things a
little.

As such, use a straight forward randomization scheme that avoids
duplicates to spread the existing CPUs over the available space.

Reported-by: Seth Jenkins <sethjenkins@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/cpu_entry_area.h |    4 --
 arch/x86/include/asm/pgtable_areas.h  |    8 +++++
 arch/x86/kernel/hw_breakpoint.c       |    2 -
 arch/x86/mm/cpu_entry_area.c          |   46 +++++++++++++++++++++++++++++++---
 4 files changed, 50 insertions(+), 10 deletions(-)

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
--- a/arch/x86/include/asm/pgtable_areas.h
+++ b/arch/x86/include/asm/pgtable_areas.h
@@ -11,6 +11,12 @@
 
 #define CPU_ENTRY_AREA_RO_IDT_VADDR	((void *)CPU_ENTRY_AREA_RO_IDT)
 
-#define CPU_ENTRY_AREA_MAP_SIZE		(CPU_ENTRY_AREA_PER_CPU + CPU_ENTRY_AREA_ARRAY_SIZE - CPU_ENTRY_AREA_BASE)
+#ifdef CONFIG_X86_32
+#define CPU_ENTRY_AREA_MAP_SIZE		(CPU_ENTRY_AREA_PER_CPU +		\
+					 (CPU_ENTRY_AREA_SIZE * NR_CPUS) -	\
+					 CPU_ENTRY_AREA_BASE
+#else
+#define CPU_ENTRY_AREA_MAP_SIZE		P4D_SIZE
+#endif
 
 #endif /* _ASM_X86_PGTABLE_AREAS_H */
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -266,7 +266,7 @@ static inline bool within_cpu_entry(unsi
 
 	/* CPU entry erea is always used for CPU entry */
 	if (within_area(addr, end, CPU_ENTRY_AREA_BASE,
-			CPU_ENTRY_AREA_TOTAL_SIZE))
+			CPU_ENTRY_AREA_MAP_SIZE))
 		return true;
 
 	/*
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -15,16 +15,53 @@ static DEFINE_PER_CPU_PAGE_ALIGNED(struc
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
@@ -205,7 +242,6 @@ static __init void setup_cpu_entry_area_
 
 	/* The +1 is for the readonly IDT: */
 	BUILD_BUG_ON((CPU_ENTRY_AREA_PAGES+1)*PAGE_SIZE != CPU_ENTRY_AREA_MAP_SIZE);
-	BUILD_BUG_ON(CPU_ENTRY_AREA_TOTAL_SIZE != CPU_ENTRY_AREA_MAP_SIZE);
 	BUG_ON(CPU_ENTRY_AREA_BASE & ~PMD_MASK);
 
 	start = CPU_ENTRY_AREA_BASE;
@@ -221,6 +257,8 @@ void __init setup_cpu_entry_areas(void)
 {
 	unsigned int cpu;
 
+	init_cea_offsets();
+
 	setup_cpu_entry_area_ptes();
 
 	for_each_possible_cpu(cpu)
