Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB32C733992
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346129AbjFPTSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345969AbjFPTRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:17:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FB23AAD;
        Fri, 16 Jun 2023 12:17:02 -0700 (PDT)
Date:   Fri, 16 Jun 2023 19:17:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686943021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mYO0hKfedHNGFqZfWJso1Onm/0bxHDH/0cTlv+XOHrU=;
        b=KxwxzC0SwmizY/4miXjhP+0y2N6G20xyLbBmRp+KDfLCdgaewniyRy7AFF3AGLN0msXZy7
        fnqvCZ1IS1Sx7z9utMZOHSDgitkPFLXdPZxZUf+EXJh3mVuDpEdIScaJiD0po7e2MIlc66
        7dV6q31sU+ve06yq3B7gqsv8VO5OTDRmeeMmjIaMRuiOMxOqrFM8KuQDVtBH8k3U+hQ/ms
        RMN4iUPcH/MjlJWmVGXCbct1B95lVlCOoKUMzKGIy67e/KkQkKmh2KUN/+qwNBra8ablp4
        Zi69YfdK5YUEjD3C4105bP7ggZC5kIst4Im+vS8LyJbj8AFcWjhpqCR6FCzXrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686943021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mYO0hKfedHNGFqZfWJso1Onm/0bxHDH/0cTlv+XOHrU=;
        b=ZlxCU2HFEqiVwJzx5hpmOBAgiL5pZkOuIP7ujseOUjnkE7pgY6G4pM5zTVljaiUIKABWyz
        iscEPTeOTI79jgCw==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] mm: Warn on shadow stack memory in wrong vma
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168694302101.404.9675949949281395759.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     aa47900443851e9185db5af6ea197f9a1506c7d3
Gitweb:        https://git.kernel.org/tip/aa47900443851e9185db5af6ea197f9a1506c7d3
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:43 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Jun 2023 16:31:33 -07:00

mm: Warn on shadow stack memory in wrong vma

The x86 Control-flow Enforcement Technology (CET) feature includes a new
type of memory called shadow stack. This shadow stack memory has some
unusual properties, which requires some core mm changes to function
properly.

One sharp edge is that PTEs that are both Write=0 and Dirty=1 are
treated as shadow by the CPU, but this combination used to be created by
the kernel on x86. Previous patches have changed the kernel to now avoid
creating these PTEs unless they are for shadow stack memory. In case any
missed corners of the kernel are still creating PTEs like this for
non-shadow stack memory, and to catch any re-introductions of the logic,
warn if any shadow stack PTEs (Write=0, Dirty=1) are found in non-shadow
stack VMAs when they are being zapped. This won't catch transient cases
but should have decent coverage.

In order to check if a PTE is shadow stack in core mm code, add two arch
breakouts arch_check_zapped_pte/pmd(). This will allow shadow stack
specific code to be kept in arch/x86.

Only do the check if shadow stack is supported by the CPU and configured
because in rare cases older CPUs may write Dirty=1 to a Write=0 CPU on
older CPUs. This check is handled in pte_shstk()/pmd_shstk().

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-18-rick.p.edgecombe%40intel.com
---
 arch/x86/include/asm/pgtable.h |  6 ++++++
 arch/x86/mm/pgtable.c          | 20 ++++++++++++++++++++
 include/linux/pgtable.h        | 14 ++++++++++++++
 mm/huge_memory.c               |  1 +
 mm/memory.c                    |  1 +
 5 files changed, 42 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 707de18..3fbddf6 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1664,6 +1664,12 @@ static inline bool arch_has_hw_pte_young(void)
 	return true;
 }
 
+#define arch_check_zapped_pte arch_check_zapped_pte
+void arch_check_zapped_pte(struct vm_area_struct *vma, pte_t pte);
+
+#define arch_check_zapped_pmd arch_check_zapped_pmd
+void arch_check_zapped_pmd(struct vm_area_struct *vma, pmd_t pmd);
+
 #ifdef CONFIG_XEN_PV
 #define arch_has_hw_nonleaf_pmd_young arch_has_hw_nonleaf_pmd_young
 static inline bool arch_has_hw_nonleaf_pmd_young(void)
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 0ad2c62..101e721 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -894,3 +894,23 @@ pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 
 	return pmd_clear_saveddirty(pmd);
 }
+
+void arch_check_zapped_pte(struct vm_area_struct *vma, pte_t pte)
+{
+	/*
+	 * Hardware before shadow stack can (rarely) set Dirty=1
+	 * on a Write=0 PTE. So the below condition
+	 * only indicates a software bug when shadow stack is
+	 * supported by the HW. This checking is covered in
+	 * pte_shstk().
+	 */
+	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_SHADOW_STACK) &&
+			pte_shstk(pte));
+}
+
+void arch_check_zapped_pmd(struct vm_area_struct *vma, pmd_t pmd)
+{
+	/* See note in arch_check_zapped_pte() */
+	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_SHADOW_STACK) &&
+			pmd_shstk(pmd));
+}
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index f5077a0..c2e9248 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -291,6 +291,20 @@ static inline bool arch_has_hw_pte_young(void)
 }
 #endif
 
+#ifndef arch_check_zapped_pte
+static inline void arch_check_zapped_pte(struct vm_area_struct *vma,
+					 pte_t pte)
+{
+}
+#endif
+
+#ifndef arch_check_zapped_pmd
+static inline void arch_check_zapped_pmd(struct vm_area_struct *vma,
+					 pmd_t pmd)
+{
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 37dd56b..c3cc20c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1681,6 +1681,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 */
 	orig_pmd = pmdp_huge_get_and_clear_full(vma, addr, pmd,
 						tlb->fullmm);
+	arch_check_zapped_pmd(vma, orig_pmd);
 	tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
 	if (vma_is_special_huge(vma)) {
 		if (arch_needs_pgtable_deposit())
diff --git a/mm/memory.c b/mm/memory.c
index c1b6fe9..40c0b23 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1412,6 +1412,7 @@ again:
 				continue;
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
+			arch_check_zapped_pte(vma, ptent);
 			tlb_remove_tlb_entry(tlb, pte, addr);
 			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
 						      ptent);
