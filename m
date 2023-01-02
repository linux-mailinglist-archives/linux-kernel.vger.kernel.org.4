Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C6165AD69
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 07:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjABGRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 01:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABGRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 01:17:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BD4B10CB;
        Sun,  1 Jan 2023 22:17:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CFC32F4;
        Sun,  1 Jan 2023 22:18:21 -0800 (PST)
Received: from a077893.blr.arm.com (unknown [10.162.40.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 706013F587;
        Sun,  1 Jan 2023 22:17:36 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org
Cc:     lukas.bulwahn@gmail.com, james.morse@arm.com,
        suzuki.poulose@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org
Subject: [PATCH V4] arm64: errata: Workaround possible Cortex-A715 [ESR|FAR]_ELx corruption
Date:   Mon,  2 Jan 2023 11:46:51 +0530
Message-Id: <20230102061651.34745-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a Cortex-A715 cpu sees a page mapping permissions change from executable
to non-executable, it may corrupt the ESR_ELx and FAR_ELx registers, on the
next instruction abort caused by permission fault.

Only user-space does executable to non-executable permission transition via
mprotect() system call which calls ptep_modify_prot_start() and ptep_modify
_prot_commit() helpers, while changing the page mapping. The platform code
can override these helpers via __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION.

Work around the problem via doing a break-before-make TLB invalidation, for
all executable user space mappings, that go through mprotect() system call.
This overrides ptep_modify_prot_start() and ptep_modify_prot_commit(), via
defining HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION on the platform thus giving
an opportunity to intercept user space exec mappings, and do the necessary
TLB invalidation. Similar interceptions are also implemented for HugeTLB.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.2-rc2. This has been tested on the model with 0x411FD4D1
as the MIDR_EL1 value for Cortex-A715, along with a non Cortex-A715 CPU as
well, triggering both paths.

Changes in V4:

- Folded in CONFIG_ARM64_ERRATUM_2645198 related changes from Lukas Bulwahn

https://lore.kernel.org/all/20221215094811.23188-1-lukas.bulwahn@gmail.com/

Changes in V3:

https://lore.kernel.org/all/20221116140915.356601-3-anshuman.khandual@arm.com/

 Documentation/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                     | 16 ++++++++++++++++
 arch/arm64/include/asm/hugetlb.h       |  9 +++++++++
 arch/arm64/include/asm/pgtable.h       |  9 +++++++++
 arch/arm64/kernel/cpu_errata.c         |  7 +++++++
 arch/arm64/mm/hugetlbpage.c            | 21 +++++++++++++++++++++
 arch/arm64/mm/mmu.c                    | 21 +++++++++++++++++++++
 arch/arm64/tools/cpucaps               |  1 +
 8 files changed, 86 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 808ade4cc008..ec5f889d7681 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -120,6 +120,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #2224489        | ARM64_ERRATUM_2224489       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A715     | #2645198        | ARM64_ERRATUM_2645198       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X2       | #2119858        | ARM64_ERRATUM_2119858       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X2       | #2224489        | ARM64_ERRATUM_2224489       |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 03934808b2ed..cf6d1cd8b6dc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -972,6 +972,22 @@ config ARM64_ERRATUM_2457168
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_2645198
+	bool "Cortex-A715: 2645198: Workaround possible [ESR|FAR]_ELx corruption"
+	default y
+	help
+	  This option adds the workaround for ARM Cortex-A715 erratum 2645198.
+
+	  If a Cortex-A715 cpu sees a page mapping permissions change from executable
+	  to non-executable, it may corrupt the ESR_ELx and FAR_ELx registers on the
+	  next instruction abort caused by permission fault.
+
+	  Only user-space does executable to non-executable permission transition via
+	  mprotect() system call. Workaround the problem by doing a break-before-make
+	  TLB invalidation, for all changes to executable user space mappings.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index d20f5da2d76f..6a4a1ab8eb23 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -49,6 +49,15 @@ extern pte_t huge_ptep_get(pte_t *ptep);
 
 void __init arm64_hugetlb_cma_reserve(void);
 
+#define huge_ptep_modify_prot_start huge_ptep_modify_prot_start
+extern pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma,
+					 unsigned long addr, pte_t *ptep);
+
+#define huge_ptep_modify_prot_commit huge_ptep_modify_prot_commit
+extern void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
+					 unsigned long addr, pte_t *ptep,
+					 pte_t old_pte, pte_t new_pte);
+
 #include <asm-generic/hugetlb.h>
 
 #endif /* __ASM_HUGETLB_H */
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b4bbeed80fb6..6914add66bcf 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1093,6 +1093,15 @@ static inline bool pud_sect_supported(void)
 }
 
 
+#define __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
+#define ptep_modify_prot_start ptep_modify_prot_start
+extern pte_t ptep_modify_prot_start(struct vm_area_struct *vma,
+				    unsigned long addr, pte_t *ptep);
+
+#define ptep_modify_prot_commit ptep_modify_prot_commit
+extern void ptep_modify_prot_commit(struct vm_area_struct *vma,
+				    unsigned long addr, pte_t *ptep,
+				    pte_t old_pte, pte_t new_pte);
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_PGTABLE_H */
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 89ac00084f38..307faa2b4395 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -661,6 +661,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		CAP_MIDR_RANGE_LIST(trbe_write_out_of_range_cpus),
 	},
 #endif
+#ifdef CONFIG_ARM64_ERRATUM_2645198
+	{
+		.desc = "ARM erratum 2645198",
+		.capability = ARM64_WORKAROUND_2645198,
+		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A715)
+	},
+#endif
 #ifdef CONFIG_ARM64_ERRATUM_2077057
 	{
 		.desc = "ARM erratum 2077057",
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 35e9a468d13e..95364e8bdc19 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -559,3 +559,24 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
 {
 	return __hugetlb_valid_size(size);
 }
+
+pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
+{
+	if (IS_ENABLED(CONFIG_ARM64_ERRATUM_2645198) &&
+	    cpus_have_const_cap(ARM64_WORKAROUND_2645198)) {
+		/*
+		 * Break-before-make (BBM) is required for all user space mappings
+		 * when the permission changes from executable to non-executable
+		 * in cases where cpu is affected with errata #2645198.
+		 */
+		if (pte_user_exec(READ_ONCE(*ptep)))
+			return huge_ptep_clear_flush(vma, addr, ptep);
+	}
+	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+}
+
+void huge_ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
+				  pte_t old_pte, pte_t pte)
+{
+	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
+}
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 14c87e8d69d8..d77c9f56b7b4 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1630,3 +1630,24 @@ static int __init prevent_bootmem_remove_init(void)
 }
 early_initcall(prevent_bootmem_remove_init);
 #endif
+
+pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
+{
+	if (IS_ENABLED(CONFIG_ARM64_ERRATUM_2645198) &&
+	    cpus_have_const_cap(ARM64_WORKAROUND_2645198)) {
+		/*
+		 * Break-before-make (BBM) is required for all user space mappings
+		 * when the permission changes from executable to non-executable
+		 * in cases where cpu is affected with errata #2645198.
+		 */
+		if (pte_user_exec(READ_ONCE(*ptep)))
+			return ptep_clear_flush(vma, addr, ptep);
+	}
+	return ptep_get_and_clear(vma->vm_mm, addr, ptep);
+}
+
+void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
+			     pte_t old_pte, pte_t pte)
+{
+	set_pte_at(vma->vm_mm, addr, ptep, pte);
+}
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index a86ee376920a..dfeb2c51e257 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -71,6 +71,7 @@ WORKAROUND_2038923
 WORKAROUND_2064142
 WORKAROUND_2077057
 WORKAROUND_2457168
+WORKAROUND_2645198
 WORKAROUND_2658417
 WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 WORKAROUND_TSB_FLUSH_FAILURE
-- 
2.25.1

