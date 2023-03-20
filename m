Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2016C1C91
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjCTQsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjCTQrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:47:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EEC1D937;
        Mon, 20 Mar 2023 09:41:08 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:39:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679330368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=o8gQfMsekA2K3amD5J6Fn2OqgpDDMXvcesoX2geOoCw=;
        b=iKDdCQrfSYITA7T7C9li9AVDGEiEwVaYtOTqLQ5ShRDhRmZj/HaZR8P3ob0mB+akb1v3z+
        ldBDlENEiJBS4kK6ae7p2rTSgRHm2Td/jqCt9VCDk/hzm874VdD+74Nq4Xk4wCUpays0u5
        1DHBP+yx7LR0as90QcBzCY29679Dbs9qEMODjMc7AFRx4uLOTyY+BX6iIIcIrFmT/dm2Z0
        q+V0TbZg+C8L0zKoXpMwNgEXsPMB+f2S+OLYpADdguXwCGIMH72gy00TXmynPTd4Pp59aF
        wS74J3ml6YOVgJq8cMbW/+msjUACEIOQhEHluqE9eK4z1I0VHStm8F+8LiHiWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679330368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=o8gQfMsekA2K3amD5J6Fn2OqgpDDMXvcesoX2geOoCw=;
        b=bh/PuCC0uB04lpdBUDEwIxCcDpijON1U8PSRKLlY6ofDWYnmOkTWOPgOVFl7Cr1ZZEgwET
        nFkHMOZ02msNidAQ==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] mm: Make pte_mkwrite() take a VMA
Cc:     David Hildenbrand <david@redhat.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167933036789.5837.14326268283162783937.tip-bot2@tip-bot2>
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

Commit-ID:     74fd30bd28e4c722b60147669fa3e1da2949b39e
Gitweb:        https://git.kernel.org/tip/74fd30bd28e4c722b60147669fa3e1da2949b39e
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Sat, 18 Mar 2023 17:15:08 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 20 Mar 2023 09:01:09 -07:00

mm: Make pte_mkwrite() take a VMA

The x86 Control-flow Enforcement Technology (CET) feature includes a new
type of memory called shadow stack. This shadow stack memory has some
unusual properties, which requires some core mm changes to function
properly.

One of these unusual properties is that shadow stack memory is writable,
but only in limited ways. These limits are applied via a specific PTE
bit combination. Nevertheless, the memory is writable, and core mm code
will need to apply the writable permissions in the typical paths that
call pte_mkwrite().

In addition to VM_WRITE, the shadow stack VMA's will have a flag denoting
that they are special shadow stack flavor of writable memory. So make
pte_mkwrite() take a VMA, so that the x86 implementation of it can know to
create regular writable memory or shadow stack memory.

Apply the same changes for pmd_mkwrite() and huge_pte_mkwrite().

No functional change.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: David Hildenbrand <david@redhat.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/lkml/0e29a2d0-08d8-bcd6-ff26-4bea0e4037b0@redhat.com/
Link: https://lore.kernel.org/all/20230319001535.23210-14-rick.p.edgecombe%40intel.com
---
 Documentation/mm/arch_pgtable_helpers.rst    |  9 ++++++---
 arch/alpha/include/asm/pgtable.h             |  6 +++++-
 arch/arc/include/asm/hugepage.h              |  2 +-
 arch/arc/include/asm/pgtable-bits-arcv2.h    |  7 ++++++-
 arch/arm/include/asm/pgtable-3level.h        |  7 ++++++-
 arch/arm/include/asm/pgtable.h               |  2 +-
 arch/arm64/include/asm/pgtable.h             |  4 ++--
 arch/csky/include/asm/pgtable.h              |  2 +-
 arch/hexagon/include/asm/pgtable.h           |  2 +-
 arch/ia64/include/asm/pgtable.h              |  2 +-
 arch/loongarch/include/asm/pgtable.h         |  4 ++--
 arch/m68k/include/asm/mcf_pgtable.h          |  2 +-
 arch/m68k/include/asm/motorola_pgtable.h     |  6 +++++-
 arch/m68k/include/asm/sun3_pgtable.h         |  6 +++++-
 arch/microblaze/include/asm/pgtable.h        |  2 +-
 arch/mips/include/asm/pgtable.h              |  6 +++---
 arch/nios2/include/asm/pgtable.h             |  2 +-
 arch/openrisc/include/asm/pgtable.h          |  2 +-
 arch/parisc/include/asm/pgtable.h            |  6 +++++-
 arch/powerpc/include/asm/book3s/32/pgtable.h |  2 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h |  4 ++--
 arch/powerpc/include/asm/nohash/32/pgtable.h |  2 +-
 arch/powerpc/include/asm/nohash/32/pte-8xx.h |  2 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h |  2 +-
 arch/riscv/include/asm/pgtable.h             |  6 +++---
 arch/s390/include/asm/hugetlb.h              |  4 ++--
 arch/s390/include/asm/pgtable.h              |  4 ++--
 arch/sh/include/asm/pgtable_32.h             | 10 ++++++++--
 arch/sparc/include/asm/pgtable_32.h          |  2 +-
 arch/sparc/include/asm/pgtable_64.h          |  6 +++---
 arch/um/include/asm/pgtable.h                |  2 +-
 arch/x86/include/asm/pgtable.h               |  6 ++++--
 arch/xtensa/include/asm/pgtable.h            |  2 +-
 include/asm-generic/hugetlb.h                |  4 ++--
 include/linux/mm.h                           |  2 +-
 mm/debug_vm_pgtable.c                        | 16 ++++++++--------
 mm/huge_memory.c                             |  6 +++---
 mm/hugetlb.c                                 |  4 ++--
 mm/memory.c                                  |  4 ++--
 mm/migrate_device.c                          |  2 +-
 mm/mprotect.c                                |  2 +-
 mm/userfaultfd.c                             |  2 +-
 42 files changed, 106 insertions(+), 69 deletions(-)

diff --git a/Documentation/mm/arch_pgtable_helpers.rst b/Documentation/mm/arch_pgtable_helpers.rst
index 30d9a09..78ac3ff 100644
--- a/Documentation/mm/arch_pgtable_helpers.rst
+++ b/Documentation/mm/arch_pgtable_helpers.rst
@@ -46,7 +46,8 @@ PTE Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pte_mkclean               | Creates a clean PTE                              |
 +---------------------------+--------------------------------------------------+
-| pte_mkwrite               | Creates a writable PTE                           |
+| pte_mkwrite               | Creates a writable PTE of the type specified by  |
+|                           | the VMA.                                         |
 +---------------------------+--------------------------------------------------+
 | pte_wrprotect             | Creates a write protected PTE                    |
 +---------------------------+--------------------------------------------------+
@@ -118,7 +119,8 @@ PMD Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pmd_mkclean               | Creates a clean PMD                              |
 +---------------------------+--------------------------------------------------+
-| pmd_mkwrite               | Creates a writable PMD                           |
+| pmd_mkwrite               | Creates a writable PMD of the type specified by  |
+|                           | the VMA.                                         |
 +---------------------------+--------------------------------------------------+
 | pmd_wrprotect             | Creates a write protected PMD                    |
 +---------------------------+--------------------------------------------------+
@@ -222,7 +224,8 @@ HugeTLB Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | huge_pte_mkdirty          | Creates a dirty HugeTLB                          |
 +---------------------------+--------------------------------------------------+
-| huge_pte_mkwrite          | Creates a writable HugeTLB                       |
+| huge_pte_mkwrite          | Creates a writable HugeTLB of the type specified |
+|                           | by the VMA.                                      |
 +---------------------------+--------------------------------------------------+
 | huge_pte_wrprotect        | Creates a write protected HugeTLB                |
 +---------------------------+--------------------------------------------------+
diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index ba43cb8..fb5d207 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -256,9 +256,13 @@ extern inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; 
 extern inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) |= _PAGE_FOW; return pte; }
 extern inline pte_t pte_mkclean(pte_t pte)	{ pte_val(pte) &= ~(__DIRTY_BITS); return pte; }
 extern inline pte_t pte_mkold(pte_t pte)	{ pte_val(pte) &= ~(__ACCESS_BITS); return pte; }
-extern inline pte_t pte_mkwrite(pte_t pte)	{ pte_val(pte) &= ~_PAGE_FOW; return pte; }
 extern inline pte_t pte_mkdirty(pte_t pte)	{ pte_val(pte) |= __DIRTY_BITS; return pte; }
 extern inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |= __ACCESS_BITS; return pte; }
+extern inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
+{
+	pte_val(pte) &= ~_PAGE_FOW;
+	return pte;
+}
 
 /*
  * The smp_rmb() in the following functions are required to order the load of
diff --git a/arch/arc/include/asm/hugepage.h b/arch/arc/include/asm/hugepage.h
index 5001b79..223a969 100644
--- a/arch/arc/include/asm/hugepage.h
+++ b/arch/arc/include/asm/hugepage.h
@@ -21,7 +21,7 @@ static inline pmd_t pte_pmd(pte_t pte)
 }
 
 #define pmd_wrprotect(pmd)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
-#define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
+#define pmd_mkwrite(pmd, vma)	pte_pmd(pte_mkwrite(pmd_pte(pmd), (vma)))
 #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
 #define pmd_mkold(pmd)		pte_pmd(pte_mkold(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
diff --git a/arch/arc/include/asm/pgtable-bits-arcv2.h b/arch/arc/include/asm/pgtable-bits-arcv2.h
index 6e9f8ca..a5b8bc9 100644
--- a/arch/arc/include/asm/pgtable-bits-arcv2.h
+++ b/arch/arc/include/asm/pgtable-bits-arcv2.h
@@ -87,7 +87,6 @@
 
 PTE_BIT_FUNC(mknotpresent,     &= ~(_PAGE_PRESENT));
 PTE_BIT_FUNC(wrprotect,	&= ~(_PAGE_WRITE));
-PTE_BIT_FUNC(mkwrite,	|= (_PAGE_WRITE));
 PTE_BIT_FUNC(mkclean,	&= ~(_PAGE_DIRTY));
 PTE_BIT_FUNC(mkdirty,	|= (_PAGE_DIRTY));
 PTE_BIT_FUNC(mkold,	&= ~(_PAGE_ACCESSED));
@@ -95,6 +94,12 @@ PTE_BIT_FUNC(mkyoung,	|= (_PAGE_ACCESSED));
 PTE_BIT_FUNC(mkspecial,	|= (_PAGE_SPECIAL));
 PTE_BIT_FUNC(mkhuge,	|= (_PAGE_HW_SZ));
 
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
+{
+	pte_val(pte) |= (_PAGE_WRITE);
+	return pte;
+}
+
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 1060497..df071a8 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -202,11 +202,16 @@ static inline pmd_t pmd_##fn(pmd_t pmd) { pmd_val(pmd) op; return pmd; }
 
 PMD_BIT_FUNC(wrprotect,	|= L_PMD_SECT_RDONLY);
 PMD_BIT_FUNC(mkold,	&= ~PMD_SECT_AF);
-PMD_BIT_FUNC(mkwrite,   &= ~L_PMD_SECT_RDONLY);
 PMD_BIT_FUNC(mkdirty,   |= L_PMD_SECT_DIRTY);
 PMD_BIT_FUNC(mkclean,   &= ~L_PMD_SECT_DIRTY);
 PMD_BIT_FUNC(mkyoung,   |= PMD_SECT_AF);
 
+static inline pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
+{
+	pmd_val(pmd) |= L_PMD_SECT_RDONLY;
+	return pmd;
+}
+
 #define pmd_mkhuge(pmd)		(__pmd(pmd_val(pmd) & ~PMD_TABLE_BIT))
 
 #define pmd_pfn(pmd)		(((pmd_val(pmd) & PMD_MASK) & PHYS_MASK) >> PAGE_SHIFT)
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index a58ccbb..39ad1ae 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -227,7 +227,7 @@ static inline pte_t pte_wrprotect(pte_t pte)
 	return set_pte_bit(pte, __pgprot(L_PTE_RDONLY));
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	return clear_pte_bit(pte, __pgprot(L_PTE_RDONLY));
 }
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index cccf888..913bf37 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -187,7 +187,7 @@ static inline pte_t pte_mkwrite_kernel(pte_t pte)
 	return pte;
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	return pte_mkwrite_kernel(pte);
 }
@@ -492,7 +492,7 @@ static inline int pmd_trans_huge(pmd_t pmd)
 #define pmd_cont(pmd)		pte_cont(pmd_pte(pmd))
 #define pmd_wrprotect(pmd)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
 #define pmd_mkold(pmd)		pte_pmd(pte_mkold(pmd_pte(pmd)))
-#define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
+#define pmd_mkwrite(pmd, vma)	pte_pmd(pte_mkwrite(pmd_pte(pmd), (vma)))
 #define pmd_mkclean(pmd)	pte_pmd(pte_mkclean(pmd_pte(pmd)))
 #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index d404249..c2f92c9 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -176,7 +176,7 @@ static inline pte_t pte_mkold(pte_t pte)
 	return pte;
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	pte_val(pte) |= _PAGE_WRITE;
 	if (pte_val(pte) & _PAGE_MODIFIED)
diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
index 5939361..14ab9c7 100644
--- a/arch/hexagon/include/asm/pgtable.h
+++ b/arch/hexagon/include/asm/pgtable.h
@@ -300,7 +300,7 @@ static inline pte_t pte_wrprotect(pte_t pte)
 }
 
 /* pte_mkwrite - mark page as writable */
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	pte_val(pte) |= _PAGE_WRITE;
 	return pte;
diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
index 21c97e3..f879dd6 100644
--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -268,7 +268,7 @@ ia64_phys_addr_valid (unsigned long addr)
  * access rights:
  */
 #define pte_wrprotect(pte)	(__pte(pte_val(pte) & ~_PAGE_AR_RW))
-#define pte_mkwrite(pte)	(__pte(pte_val(pte) | _PAGE_AR_RW))
+#define pte_mkwrite(pte, vma)	(__pte(pte_val(pte) | _PAGE_AR_RW))
 #define pte_mkold(pte)		(__pte(pte_val(pte) & ~_PAGE_A))
 #define pte_mkyoung(pte)	(__pte(pte_val(pte) | _PAGE_A))
 #define pte_mkclean(pte)	(__pte(pte_val(pte) & ~_PAGE_D))
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index d28fb9d..ebf645f 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -390,7 +390,7 @@ static inline pte_t pte_mkdirty(pte_t pte)
 	return pte;
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	pte_val(pte) |= _PAGE_WRITE;
 	if (pte_val(pte) & _PAGE_MODIFIED)
@@ -490,7 +490,7 @@ static inline int pmd_write(pmd_t pmd)
 	return !!(pmd_val(pmd) & _PAGE_WRITE);
 }
 
-static inline pmd_t pmd_mkwrite(pmd_t pmd)
+static inline pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
 	pmd_val(pmd) |= _PAGE_WRITE;
 	if (pmd_val(pmd) & _PAGE_MODIFIED)
diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
index 13741c1..37d77e0 100644
--- a/arch/m68k/include/asm/mcf_pgtable.h
+++ b/arch/m68k/include/asm/mcf_pgtable.h
@@ -211,7 +211,7 @@ static inline pte_t pte_mkold(pte_t pte)
 	return pte;
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	pte_val(pte) |= CF_PAGE_WRITABLE;
 	return pte;
diff --git a/arch/m68k/include/asm/motorola_pgtable.h b/arch/m68k/include/asm/motorola_pgtable.h
index ec0dc19..c4e8eb7 100644
--- a/arch/m68k/include/asm/motorola_pgtable.h
+++ b/arch/m68k/include/asm/motorola_pgtable.h
@@ -155,7 +155,6 @@ static inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; 
 static inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) |= _PAGE_RONLY; return pte; }
 static inline pte_t pte_mkclean(pte_t pte)	{ pte_val(pte) &= ~_PAGE_DIRTY; return pte; }
 static inline pte_t pte_mkold(pte_t pte)	{ pte_val(pte) &= ~_PAGE_ACCESSED; return pte; }
-static inline pte_t pte_mkwrite(pte_t pte)	{ pte_val(pte) &= ~_PAGE_RONLY; return pte; }
 static inline pte_t pte_mkdirty(pte_t pte)	{ pte_val(pte) |= _PAGE_DIRTY; return pte; }
 static inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mknocache(pte_t pte)
@@ -168,6 +167,11 @@ static inline pte_t pte_mkcache(pte_t pte)
 	pte_val(pte) = (pte_val(pte) & _CACHEMASK040) | m68k_supervisor_cachemode;
 	return pte;
 }
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
+{
+	pte_val(pte) &= ~_PAGE_RONLY;
+	return pte;
+}
 
 #define swapper_pg_dir kernel_pg_dir
 extern pgd_t kernel_pg_dir[128];
diff --git a/arch/m68k/include/asm/sun3_pgtable.h b/arch/m68k/include/asm/sun3_pgtable.h
index e582b04..2a06bea 100644
--- a/arch/m68k/include/asm/sun3_pgtable.h
+++ b/arch/m68k/include/asm/sun3_pgtable.h
@@ -143,10 +143,14 @@ static inline int pte_young(pte_t pte)		{ return pte_val(pte) & SUN3_PAGE_ACCESS
 static inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) &= ~SUN3_PAGE_WRITEABLE; return pte; }
 static inline pte_t pte_mkclean(pte_t pte)	{ pte_val(pte) &= ~SUN3_PAGE_MODIFIED; return pte; }
 static inline pte_t pte_mkold(pte_t pte)	{ pte_val(pte) &= ~SUN3_PAGE_ACCESSED; return pte; }
-static inline pte_t pte_mkwrite(pte_t pte)	{ pte_val(pte) |= SUN3_PAGE_WRITEABLE; return pte; }
 static inline pte_t pte_mkdirty(pte_t pte)	{ pte_val(pte) |= SUN3_PAGE_MODIFIED; return pte; }
 static inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |= SUN3_PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mknocache(pte_t pte)	{ pte_val(pte) |= SUN3_PAGE_NOCACHE; return pte; }
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
+{
+	pte_val(pte) |= SUN3_PAGE_WRITEABLE;
+	return pte;
+}
 // use this version when caches work...
 //static inline pte_t pte_mkcache(pte_t pte)	{ pte_val(pte) &= SUN3_PAGE_NOCACHE; return pte; }
 // until then, use:
diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index d1b8272..5b83e82 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -266,7 +266,7 @@ static inline pte_t pte_mkread(pte_t pte) \
 	{ pte_val(pte) |= _PAGE_USER; return pte; }
 static inline pte_t pte_mkexec(pte_t pte) \
 	{ pte_val(pte) |= _PAGE_USER | _PAGE_EXEC; return pte; }
-static inline pte_t pte_mkwrite(pte_t pte) \
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma) \
 	{ pte_val(pte) |= _PAGE_RW; return pte; }
 static inline pte_t pte_mkdirty(pte_t pte) \
 	{ pte_val(pte) |= _PAGE_DIRTY; return pte; }
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 791389b..06efd56 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -309,7 +309,7 @@ static inline pte_t pte_mkold(pte_t pte)
 	return pte;
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	pte.pte_low |= _PAGE_WRITE;
 	if (pte.pte_low & _PAGE_MODIFIED) {
@@ -364,7 +364,7 @@ static inline pte_t pte_mkold(pte_t pte)
 	return pte;
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	pte_val(pte) |= _PAGE_WRITE;
 	if (pte_val(pte) & _PAGE_MODIFIED)
@@ -626,7 +626,7 @@ static inline pmd_t pmd_wrprotect(pmd_t pmd)
 	return pmd;
 }
 
-static inline pmd_t pmd_mkwrite(pmd_t pmd)
+static inline pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
 	pmd_val(pmd) |= _PAGE_WRITE;
 	if (pmd_val(pmd) & _PAGE_MODIFIED)
diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
index 0f5c256..edd4585 100644
--- a/arch/nios2/include/asm/pgtable.h
+++ b/arch/nios2/include/asm/pgtable.h
@@ -129,7 +129,7 @@ static inline pte_t pte_mkold(pte_t pte)
 	return pte;
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	pte_val(pte) |= _PAGE_WRITE;
 	return pte;
diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index 3eb9b95..fd40aec 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -250,7 +250,7 @@ static inline pte_t pte_mkold(pte_t pte)
 	return pte;
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	pte_val(pte) |= _PAGE_WRITE;
 	return pte;
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index e2950f5..89f6213 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -331,8 +331,12 @@ static inline pte_t pte_mkold(pte_t pte)	{ pte_val(pte) &= ~_PAGE_ACCESSED; retu
 static inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) &= ~_PAGE_WRITE; return pte; }
 static inline pte_t pte_mkdirty(pte_t pte)	{ pte_val(pte) |= _PAGE_DIRTY; return pte; }
 static inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |= _PAGE_ACCESSED; return pte; }
-static inline pte_t pte_mkwrite(pte_t pte)	{ pte_val(pte) |= _PAGE_WRITE; return pte; }
 static inline pte_t pte_mkspecial(pte_t pte)	{ pte_val(pte) |= _PAGE_SPECIAL; return pte; }
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
+{
+	pte_val(pte) |= _PAGE_WRITE;
+	return pte;
+}
 
 /*
  * Huge pte definitions.
diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 7bf1fe7..10d9a1d 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -498,7 +498,7 @@ static inline pte_t pte_mkpte(pte_t pte)
 	return pte;
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	return __pte(pte_val(pte) | _PAGE_RW);
 }
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 4acc969..be06365 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -600,7 +600,7 @@ static inline pte_t pte_mkexec(pte_t pte)
 	return __pte_raw(pte_raw(pte) | cpu_to_be64(_PAGE_EXEC));
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	/*
 	 * write implies read, hence set both
@@ -1071,7 +1071,7 @@ static inline pte_t *pmdp_ptep(pmd_t *pmd)
 #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
 #define pmd_mkclean(pmd)	pte_pmd(pte_mkclean(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
-#define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
+#define pmd_mkwrite(pmd, vma)	pte_pmd(pte_mkwrite(pmd_pte(pmd), (vma)))
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
 #define pmd_soft_dirty(pmd)    pte_soft_dirty(pmd_pte(pmd))
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index fec56d9..7bfbcb9 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -171,7 +171,7 @@ void unmap_kernel_page(unsigned long va);
 	do { pte_update(mm, addr, ptep, ~0, 0, 0); } while (0)
 
 #ifndef pte_mkwrite
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	return __pte(pte_val(pte) | _PAGE_RW);
 }
diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index 1a89ebd..f32450e 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -101,7 +101,7 @@ static inline int pte_write(pte_t pte)
 
 #define pte_write pte_write
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	return __pte(pte_val(pte) & ~_PAGE_RO);
 }
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 287e258..5890095 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -85,7 +85,7 @@
 #ifndef __ASSEMBLY__
 /* pte_clear moved to later in this file */
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	return __pte(pte_val(pte) | _PAGE_RW);
 }
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index ab05f89..93de938 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -338,7 +338,7 @@ static inline pte_t pte_wrprotect(pte_t pte)
 
 /* static inline pte_t pte_mkread(pte_t pte) */
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
@@ -624,9 +624,9 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return pte_pmd(pte_mkyoung(pmd_pte(pmd)));
 }
 
-static inline pmd_t pmd_mkwrite(pmd_t pmd)
+static inline pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
-	return pte_pmd(pte_mkwrite(pmd_pte(pmd)));
+	return pte_pmd(pte_mkwrite(pmd_pte(pmd), vma));
 }
 
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index ccdbccf..558f7ee 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -102,9 +102,9 @@ static inline int huge_pte_dirty(pte_t pte)
 	return pte_dirty(pte);
 }
 
-static inline pte_t huge_pte_mkwrite(pte_t pte)
+static inline pte_t huge_pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
-	return pte_mkwrite(pte);
+	return pte_mkwrite(pte, vma);
 }
 
 static inline pte_t huge_pte_mkdirty(pte_t pte)
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index deeb918..8f2c743 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1013,7 +1013,7 @@ static inline pte_t pte_mkwrite_kernel(pte_t pte)
 	return pte;
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	return pte_mkwrite_kernel(pte);
 }
@@ -1499,7 +1499,7 @@ static inline pmd_t pmd_mkwrite_kernel(pmd_t pmd)
 	return pmd;
 }
 
-static inline pmd_t pmd_mkwrite(pmd_t pmd)
+static inline pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
 	return pmd_mkwrite_kernel(pmd);
 }
diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable_32.h
index 21952b0..9f2dcb9 100644
--- a/arch/sh/include/asm/pgtable_32.h
+++ b/arch/sh/include/asm/pgtable_32.h
@@ -351,6 +351,12 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 
 #define PTE_BIT_FUNC(h,fn,op) \
 static inline pte_t pte_##fn(pte_t pte) { pte.pte_##h op; return pte; }
+#define PTE_BIT_FUNC_VMA(h,fn,op) \
+static inline pte_t pte_##fn(pte_t pte, struct vm_area_struct *vma) \
+{ \
+	pte.pte_##h op; \
+	return pte; \
+}
 
 #ifdef CONFIG_X2TLB
 /*
@@ -359,11 +365,11 @@ static inline pte_t pte_##fn(pte_t pte) { pte.pte_##h op; return pte; }
  * kernel permissions), we attempt to couple them a bit more sanely here.
  */
 PTE_BIT_FUNC(high, wrprotect, &= ~(_PAGE_EXT_USER_WRITE | _PAGE_EXT_KERN_WRITE));
-PTE_BIT_FUNC(high, mkwrite, |= _PAGE_EXT_USER_WRITE | _PAGE_EXT_KERN_WRITE);
+PTE_BIT_FUNC_VMA(high, mkwrite, |= _PAGE_EXT_USER_WRITE | _PAGE_EXT_KERN_WRITE);
 PTE_BIT_FUNC(high, mkhuge, |= _PAGE_SZHUGE);
 #else
 PTE_BIT_FUNC(low, wrprotect, &= ~_PAGE_RW);
-PTE_BIT_FUNC(low, mkwrite, |= _PAGE_RW);
+PTE_BIT_FUNC_VMA(low, mkwrite, |= _PAGE_RW);
 PTE_BIT_FUNC(low, mkhuge, |= _PAGE_SZHUGE);
 #endif
 
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index d4330e3..3e88361 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -241,7 +241,7 @@ static inline pte_t pte_mkold(pte_t pte)
 	return __pte(pte_val(pte) & ~SRMMU_REF);
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	return __pte(pte_val(pte) | SRMMU_WRITE);
 }
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 2dc8d46..c5cd5c0 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -466,7 +466,7 @@ static inline pte_t pte_mkclean(pte_t pte)
 	return __pte(val);
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	unsigned long val = pte_val(pte), mask;
 
@@ -756,11 +756,11 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return __pmd(pte_val(pte));
 }
 
-static inline pmd_t pmd_mkwrite(pmd_t pmd)
+static inline pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
 	pte_t pte = __pte(pmd_val(pmd));
 
-	pte = pte_mkwrite(pte);
+	pte = pte_mkwrite(pte, vma);
 
 	return __pmd(pte_val(pte));
 }
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index a70d161..963479c 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -207,7 +207,7 @@ static inline pte_t pte_mkyoung(pte_t pte)
 	return(pte);
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	if (unlikely(pte_get_bits(pte,  _PAGE_RW)))
 		return pte;
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 3607f25..66c5148 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -369,7 +369,9 @@ static inline pte_t pte_mkwrite_kernel(pte_t pte)
 	return pte_set_flags(pte, _PAGE_RW);
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+struct vm_area_struct;
+
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	return pte_mkwrite_kernel(pte);
 }
@@ -470,7 +472,7 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return pmd_set_flags(pmd, _PAGE_ACCESSED);
 }
 
-static inline pmd_t pmd_mkwrite(pmd_t pmd)
+static inline pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
 	return pmd_set_flags(pmd, _PAGE_RW);
 }
diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index fc7a148..d72632d 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -262,7 +262,7 @@ static inline pte_t pte_mkdirty(pte_t pte)
 	{ pte_val(pte) |= _PAGE_DIRTY; return pte; }
 static inline pte_t pte_mkyoung(pte_t pte)
 	{ pte_val(pte) |= _PAGE_ACCESSED; return pte; }
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 	{ pte_val(pte) |= _PAGE_WRITABLE; return pte; }
 
 #define pgprot_noncached(prot) \
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index d7f6335..e86c830 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -20,9 +20,9 @@ static inline unsigned long huge_pte_dirty(pte_t pte)
 	return pte_dirty(pte);
 }
 
-static inline pte_t huge_pte_mkwrite(pte_t pte)
+static inline pte_t huge_pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
-	return pte_mkwrite(pte);
+	return pte_mkwrite(pte, vma);
 }
 
 #ifndef __HAVE_ARCH_HUGE_PTE_WRPROTECT
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1f79667..af65244 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1163,7 +1163,7 @@ void free_compound_page(struct page *page);
 static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	if (likely(vma->vm_flags & VM_WRITE))
-		pte = pte_mkwrite(pte);
+		pte = pte_mkwrite(pte, vma);
 	return pte;
 }
 
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index af59cc7..7bc5592 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -109,10 +109,10 @@ static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
 	WARN_ON(!pte_same(pte, pte));
 	WARN_ON(!pte_young(pte_mkyoung(pte_mkold(pte))));
 	WARN_ON(!pte_dirty(pte_mkdirty(pte_mkclean(pte))));
-	WARN_ON(!pte_write(pte_mkwrite(pte_wrprotect(pte))));
+	WARN_ON(!pte_write(pte_mkwrite(pte_wrprotect(pte), args->vma)));
 	WARN_ON(pte_young(pte_mkold(pte_mkyoung(pte))));
 	WARN_ON(pte_dirty(pte_mkclean(pte_mkdirty(pte))));
-	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte))));
+	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte, args->vma))));
 	WARN_ON(pte_dirty(pte_wrprotect(pte_mkclean(pte))));
 	WARN_ON(!pte_dirty(pte_wrprotect(pte_mkdirty(pte))));
 }
@@ -153,7 +153,7 @@ static void __init pte_advanced_tests(struct pgtable_debug_args *args)
 	pte = pte_mkclean(pte);
 	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
 	flush_dcache_page(page);
-	pte = pte_mkwrite(pte);
+	pte = pte_mkwrite(pte, args->vma);
 	pte = pte_mkdirty(pte);
 	ptep_set_access_flags(args->vma, args->vaddr, args->ptep, pte, 1);
 	pte = ptep_get(args->ptep);
@@ -199,10 +199,10 @@ static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx)
 	WARN_ON(!pmd_same(pmd, pmd));
 	WARN_ON(!pmd_young(pmd_mkyoung(pmd_mkold(pmd))));
 	WARN_ON(!pmd_dirty(pmd_mkdirty(pmd_mkclean(pmd))));
-	WARN_ON(!pmd_write(pmd_mkwrite(pmd_wrprotect(pmd))));
+	WARN_ON(!pmd_write(pmd_mkwrite(pmd_wrprotect(pmd), args->vma)));
 	WARN_ON(pmd_young(pmd_mkold(pmd_mkyoung(pmd))));
 	WARN_ON(pmd_dirty(pmd_mkclean(pmd_mkdirty(pmd))));
-	WARN_ON(pmd_write(pmd_wrprotect(pmd_mkwrite(pmd))));
+	WARN_ON(pmd_write(pmd_wrprotect(pmd_mkwrite(pmd, args->vma))));
 	WARN_ON(pmd_dirty(pmd_wrprotect(pmd_mkclean(pmd))));
 	WARN_ON(!pmd_dirty(pmd_wrprotect(pmd_mkdirty(pmd))));
 	/*
@@ -253,7 +253,7 @@ static void __init pmd_advanced_tests(struct pgtable_debug_args *args)
 	pmd = pmd_mkclean(pmd);
 	set_pmd_at(args->mm, vaddr, args->pmdp, pmd);
 	flush_dcache_page(page);
-	pmd = pmd_mkwrite(pmd);
+	pmd = pmd_mkwrite(pmd, args->vma);
 	pmd = pmd_mkdirty(pmd);
 	pmdp_set_access_flags(args->vma, vaddr, args->pmdp, pmd, 1);
 	pmd = READ_ONCE(*args->pmdp);
@@ -928,8 +928,8 @@ static void __init hugetlb_basic_tests(struct pgtable_debug_args *args)
 	pte = mk_huge_pte(page, args->page_prot);
 
 	WARN_ON(!huge_pte_dirty(huge_pte_mkdirty(pte)));
-	WARN_ON(!huge_pte_write(huge_pte_mkwrite(huge_pte_wrprotect(pte))));
-	WARN_ON(huge_pte_write(huge_pte_wrprotect(huge_pte_mkwrite(pte))));
+	WARN_ON(!huge_pte_write(huge_pte_mkwrite(huge_pte_wrprotect(pte), args->vma)));
+	WARN_ON(huge_pte_write(huge_pte_wrprotect(huge_pte_mkwrite(pte, args->vma))));
 
 #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
 	pte = pfn_pte(args->fixed_pmd_pfn, args->page_prot);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4fc4385..aaf8158 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -555,7 +555,7 @@ __setup("transparent_hugepage=", setup_transparent_hugepage);
 pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
 	if (likely(vma->vm_flags & VM_WRITE))
-		pmd = pmd_mkwrite(pmd);
+		pmd = pmd_mkwrite(pmd, vma);
 	return pmd;
 }
 
@@ -1580,7 +1580,7 @@ out_map:
 	pmd = pmd_modify(oldpmd, vma->vm_page_prot);
 	pmd = pmd_mkyoung(pmd);
 	if (writable)
-		pmd = pmd_mkwrite(pmd);
+		pmd = pmd_mkwrite(pmd, vma);
 	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, pmd);
 	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 	spin_unlock(vmf->ptl);
@@ -1926,7 +1926,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	/* See change_pte_range(). */
 	if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) && !pmd_write(entry) &&
 	    can_change_pmd_writable(vma, addr, entry))
-		entry = pmd_mkwrite(entry);
+		entry = pmd_mkwrite(entry, vma);
 
 	ret = HPAGE_PMD_NR;
 	set_pmd_at(mm, addr, pmd, entry);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 07abcb6..6af471b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4900,7 +4900,7 @@ static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
 
 	if (writable) {
 		entry = huge_pte_mkwrite(huge_pte_mkdirty(mk_huge_pte(page,
-					 vma->vm_page_prot)));
+					 vma->vm_page_prot)), vma);
 	} else {
 		entry = huge_pte_wrprotect(mk_huge_pte(page,
 					   vma->vm_page_prot));
@@ -4916,7 +4916,7 @@ static void set_huge_ptep_writable(struct vm_area_struct *vma,
 {
 	pte_t entry;
 
-	entry = huge_pte_mkwrite(huge_pte_mkdirty(huge_ptep_get(ptep)));
+	entry = huge_pte_mkwrite(huge_pte_mkdirty(huge_ptep_get(ptep)), vma);
 	if (huge_ptep_set_access_flags(vma, address, ptep, entry, 1))
 		update_mmu_cache(vma, address, ptep);
 }
diff --git a/mm/memory.c b/mm/memory.c
index f456f3b..d0972d2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4067,7 +4067,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	entry = mk_pte(&folio->page, vma->vm_page_prot);
 	entry = pte_sw_mkyoung(entry);
 	if (vma->vm_flags & VM_WRITE)
-		entry = pte_mkwrite(pte_mkdirty(entry));
+		entry = pte_mkwrite(pte_mkdirty(entry), vma);
 
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
@@ -4755,7 +4755,7 @@ out_map:
 	pte = pte_modify(old_pte, vma->vm_page_prot);
 	pte = pte_mkyoung(pte);
 	if (writable)
-		pte = pte_mkwrite(pte);
+		pte = pte_mkwrite(pte, vma);
 	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
 	update_mmu_cache(vma, vmf->address, vmf->pte);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index d30c9de..df3f5e9 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -646,7 +646,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 		}
 		entry = mk_pte(page, vma->vm_page_prot);
 		if (vma->vm_flags & VM_WRITE)
-			entry = pte_mkwrite(pte_mkdirty(entry));
+			entry = pte_mkwrite(pte_mkdirty(entry), vma);
 	}
 
 	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 231929f..2d148d8 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -198,7 +198,7 @@ static long change_pte_range(struct mmu_gather *tlb,
 			if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) &&
 			    !pte_write(ptent) &&
 			    can_change_pte_writable(vma, addr, ptent))
-				ptent = pte_mkwrite(ptent);
+				ptent = pte_mkwrite(ptent, vma);
 
 			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
 			if (pte_needs_flush(oldpte, ptent))
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 53c3d91..3db6f87 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -75,7 +75,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	if (page_in_cache && !vm_shared)
 		writable = false;
 	if (writable)
-		_dst_pte = pte_mkwrite(_dst_pte);
+		_dst_pte = pte_mkwrite(_dst_pte, dst_vma);
 	if (wp_copy)
 		_dst_pte = pte_mkuffd_wp(_dst_pte);
 
