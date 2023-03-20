Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08AF6C1C96
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjCTQsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbjCTQrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:47:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF392360A7;
        Mon, 20 Mar 2023 09:41:11 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:39:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679330364;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wspUowF+mevBs4sL8Jc47UxynakwtudnYeUyWeHoJ8k=;
        b=qDAVTwA/SBILX0rsmoKlfYUU9sdTkqMwXzJbNp1igP7/rJkrcMImG2kTkvQBh02H72XK4y
        RYrvNbO0HKt9Mr0BNiFwXd7nHa5g7O7VOYfGtzlmFMqvLUCwOsz8KwGlrteS9amPJvx+hR
        IVSVOmoX6bHpqr3sQ8ELTrcb8WIVieDSt1rjNUjuev0smyB6nJ91FGwk0iBDmxu3OZSaKc
        r2EnMdSsuAettuil5iWHKGzPKOZ71FQfcoYfUFnBkeZBJXzYWB9ds8BgtHE1hpU2udCbNs
        6kfGmRNLedB1QUmfVpkSc04AfvkX+79H3EhjTOhkD9Au/3I1Z/ZAooRALPsk8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679330364;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wspUowF+mevBs4sL8Jc47UxynakwtudnYeUyWeHoJ8k=;
        b=gH17BRT1ILXLRvo3Qg5e6Rm+wQR4dQSUXO5SDCCEgYsKfjdfIjywW3ec5NCtvIanPWiBYZ
        gINrjrISasDxLADg==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] mm: Warn on shadow stack memory in wrong vma
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167933036428.5837.18244160675418724868.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     50f50f9c47c022f6da1b3bd2c0205fa821877991
Gitweb:        https://git.kernel.org/tip/50f50f9c47c022f6da1b3bd2c0205fa821877991
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Sat, 18 Mar 2023 17:15:21 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 20 Mar 2023 09:01:11 -07:00

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
but should have decent coverage. It will be compiled out when shadow
stack is not configured.

In order to check if a PTE is shadow stack in core mm code, add two arch
breakouts arch_check_zapped_pte/pmd(). This will allow shadow stack
specific code to be kept in arch/x86.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230319001535.23210-27-rick.p.edgecombe%40intel.com
---
 arch/x86/include/asm/pgtable.h |  6 ++++++
 arch/x86/mm/pgtable.c          | 12 ++++++++++++
 include/linux/pgtable.h        | 14 ++++++++++++++
 mm/huge_memory.c               |  1 +
 mm/memory.c                    |  1 +
 5 files changed, 34 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 2e3d8cc..e5b3dce 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1684,6 +1684,12 @@ static inline bool arch_has_hw_pte_young(void)
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
index 98856bc..afab0bc 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -906,3 +906,15 @@ pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 
 	return pmd;
 }
+
+void arch_check_zapped_pte(struct vm_area_struct *vma, pte_t pte)
+{
+	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_SHADOW_STACK) &&
+			pte_shstk(pte));
+}
+
+void arch_check_zapped_pmd(struct vm_area_struct *vma, pmd_t pmd)
+{
+	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_SHADOW_STACK) &&
+			pmd_shstk(pmd));
+}
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index c63cd44..4a8970b 100644
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
index aaf8158..24797be 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1689,6 +1689,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 */
 	orig_pmd = pmdp_huge_get_and_clear_full(vma, addr, pmd,
 						tlb->fullmm);
+	arch_check_zapped_pmd(vma, orig_pmd);
 	tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
 	if (vma_is_special_huge(vma)) {
 		if (arch_needs_pgtable_deposit())
diff --git a/mm/memory.c b/mm/memory.c
index d0972d2..c953c2c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1389,6 +1389,7 @@ again:
 				continue;
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
+			arch_check_zapped_pte(vma, ptent);
 			tlb_remove_tlb_entry(tlb, pte, addr);
 			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
 						      ptent);
