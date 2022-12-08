Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C216476C7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 20:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiLHTr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 14:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiLHTr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 14:47:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9031DB1D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 11:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670528792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rexCHiCz9dd9uhIh4vYTMPmJOFcsSUjxlKaGu1CsAs0=;
        b=e56Pi7SfXemwZd7OuG2vjPbWtvMjskFXoeP8uxfJoegbmbcwERd5O/4NPIrkOPdQESfUdv
        /YVIGxYwcBGxAZN47/RRQkXL8ZRKYwP5vPLIF8rdt/V/gw4DsFei7gkZOtoPhMGs6Ajkp7
        unfmw/MXcLsuXob3gKh6mh9T/vKgBYM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-156-WIRWRaSWPMmEfGtT3FHEuA-1; Thu, 08 Dec 2022 14:46:31 -0500
X-MC-Unique: WIRWRaSWPMmEfGtT3FHEuA-1
Received: by mail-qk1-f198.google.com with SMTP id h8-20020a05620a284800b006b5c98f09fbso2563976qkp.21
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 11:46:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rexCHiCz9dd9uhIh4vYTMPmJOFcsSUjxlKaGu1CsAs0=;
        b=S3VmPpHYKv5nN7LXCxy52pSMvKXGr4zqHAF/lJnBoNh9dVx0DDkZW4vLUf2OhSuoGJ
         2Kkjg9QGUjsT0ng0xvAhsfpEAWPzfCbnB0/upTKg6fBdJxnQ6q1pfRArMCVPr1yXZwjA
         kjcQknQ2jdk7PnUF/4HlKlz+mZdG3spqp+V3mYwphNBknHkDYdgtekVvmqgodhk8wSCc
         cTUy/vfc5+t5Slt97RrwYksdpkirzvY4v2pKzZjqEv24Da9QMJSYQw7e5/Mh0h1qZGjK
         BxyjA0oV6Q9boR3QgcFWJRP5iuYKnDgDQYmIZ1Ay32Taq5s7pw2kOZ1xt/LW3qwVEu7n
         onPg==
X-Gm-Message-State: ANoB5pnzSY+RG7oCrVMI+9Eq9iXCraStUTf8rQtnCjkVq51+WQ+FYart
        DRIXyv60JFT4tGUkzXPkYphxNL/+4xN5Cfoxy3ApPIPrqvb08/SV2yI7C9cH5znCoiqxYw3x6Cx
        cPWJx0jzgbQreizyWXjBzAKsH
X-Received: by 2002:ac8:70c1:0:b0:3a5:3b2f:4f31 with SMTP id g1-20020ac870c1000000b003a53b2f4f31mr4455064qtp.27.1670528790736;
        Thu, 08 Dec 2022 11:46:30 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4phOcSVSqs9ycD3VOdV84KO9SMumccbTwqtWDW8j7J0392ck6S9FMwjfQ8y0Uebvl1XRRiog==
X-Received: by 2002:ac8:70c1:0:b0:3a5:3b2f:4f31 with SMTP id g1-20020ac870c1000000b003a53b2f4f31mr4455048qtp.27.1670528790449;
        Thu, 08 Dec 2022 11:46:30 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id q21-20020a05620a0d9500b006fcb77f3bd6sm14826033qkl.98.2022.12.08.11.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 11:46:29 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Ives van Hoorne <ives@codesandbox.io>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH] mm/uffd: Always wr-protect pte in pte|pmd_mkuffd_wp()
Date:   Thu,  8 Dec 2022 14:46:28 -0500
Message-Id: <20221208194628.766316-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a cleanup to always wr-protect pte/pmd in mkuffd_wp paths.

The reasons I still think this patch is worthwhile, are:

  (1) It is a cleanup already; diffstat tells.

  (2) It just feels natural after I thought about this, if the pte is uffd
      protected, let's remove the write bit no matter what it was.

  (2) Since x86 is the only arch that supports uffd-wp, it also redefines
      pte|pmd_mkuffd_wp() in that it should always contain removals of
      write bits.  It means any future arch that want to implement uffd-wp
      should naturally follow this rule too.  It's good to make it a
      default, even if with vm_page_prot changes on VM_UFFD_WP.

  (3) It covers more than vm_page_prot.  So no chance of any potential
      future "accident" (like pte_mkdirty() sparc64 or loongarch, even
      though it just got its pte_mkdirty fixed <1 month ago).  It'll be
      fairly clear when reading the code too that we don't worry anything
      before a pte_mkuffd_wp() on uncertainty of the write bit.

We may call pte_wrprotect() one more time in some paths (e.g. thp split),
but that should be fully local bitop instruction so the overhead should be
negligible.

Although this patch should logically also fix all the known issues on
uffd-wp too recently on either page migration or numa balancing, but this
is not the plan for that fix.  So no fixes, and stable doesn't need this.

Signed-off-by: Peter Xu <peterx@redhat.com>
---

Note: this patch should be able to apply cleanly with/without the other
mm/migrate patch, or David's vm_page_prot changes.
---
 arch/x86/include/asm/pgtable.h | 24 ++++++++++++------------
 include/asm-generic/hugetlb.h  | 16 ++++++++--------
 mm/huge_memory.c               |  8 +++-----
 mm/hugetlb.c                   |  4 ++--
 mm/memory.c                    |  8 +++-----
 mm/mprotect.c                  |  6 ++----
 mm/userfaultfd.c               | 18 ++----------------
 7 files changed, 32 insertions(+), 52 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 0564edd24ffb..1c843395a8b3 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -289,6 +289,11 @@ static inline pte_t pte_clear_flags(pte_t pte, pteval_t clear)
 	return native_make_pte(v & ~clear);
 }
 
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	return pte_clear_flags(pte, _PAGE_RW);
+}
+
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 static inline int pte_uffd_wp(pte_t pte)
 {
@@ -313,7 +318,7 @@ static inline int pte_uffd_wp(pte_t pte)
 
 static inline pte_t pte_mkuffd_wp(pte_t pte)
 {
-	return pte_set_flags(pte, _PAGE_UFFD_WP);
+	return pte_wrprotect(pte_set_flags(pte, _PAGE_UFFD_WP));
 }
 
 static inline pte_t pte_clear_uffd_wp(pte_t pte)
@@ -332,11 +337,6 @@ static inline pte_t pte_mkold(pte_t pte)
 	return pte_clear_flags(pte, _PAGE_ACCESSED);
 }
 
-static inline pte_t pte_wrprotect(pte_t pte)
-{
-	return pte_clear_flags(pte, _PAGE_RW);
-}
-
 static inline pte_t pte_mkexec(pte_t pte)
 {
 	return pte_clear_flags(pte, _PAGE_NX);
@@ -401,6 +401,11 @@ static inline pmd_t pmd_clear_flags(pmd_t pmd, pmdval_t clear)
 	return native_make_pmd(v & ~clear);
 }
 
+static inline pmd_t pmd_wrprotect(pmd_t pmd)
+{
+	return pmd_clear_flags(pmd, _PAGE_RW);
+}
+
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 static inline int pmd_uffd_wp(pmd_t pmd)
 {
@@ -409,7 +414,7 @@ static inline int pmd_uffd_wp(pmd_t pmd)
 
 static inline pmd_t pmd_mkuffd_wp(pmd_t pmd)
 {
-	return pmd_set_flags(pmd, _PAGE_UFFD_WP);
+	return pmd_wrprotect(pmd_set_flags(pmd, _PAGE_UFFD_WP));
 }
 
 static inline pmd_t pmd_clear_uffd_wp(pmd_t pmd)
@@ -428,11 +433,6 @@ static inline pmd_t pmd_mkclean(pmd_t pmd)
 	return pmd_clear_flags(pmd, _PAGE_DIRTY);
 }
 
-static inline pmd_t pmd_wrprotect(pmd_t pmd)
-{
-	return pmd_clear_flags(pmd, _PAGE_RW);
-}
-
 static inline pmd_t pmd_mkdirty(pmd_t pmd)
 {
 	return pmd_set_flags(pmd, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index a57d667addd2..d7f6335d3999 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -25,6 +25,13 @@ static inline pte_t huge_pte_mkwrite(pte_t pte)
 	return pte_mkwrite(pte);
 }
 
+#ifndef __HAVE_ARCH_HUGE_PTE_WRPROTECT
+static inline pte_t huge_pte_wrprotect(pte_t pte)
+{
+	return pte_wrprotect(pte);
+}
+#endif
+
 static inline pte_t huge_pte_mkdirty(pte_t pte)
 {
 	return pte_mkdirty(pte);
@@ -37,7 +44,7 @@ static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
 
 static inline pte_t huge_pte_mkuffd_wp(pte_t pte)
 {
-	return pte_mkuffd_wp(pte);
+	return huge_pte_wrprotect(pte_mkuffd_wp(pte));
 }
 
 static inline pte_t huge_pte_clear_uffd_wp(pte_t pte)
@@ -104,13 +111,6 @@ static inline int huge_pte_none_mostly(pte_t pte)
 	return huge_pte_none(pte) || is_pte_marker(pte);
 }
 
-#ifndef __HAVE_ARCH_HUGE_PTE_WRPROTECT
-static inline pte_t huge_pte_wrprotect(pte_t pte)
-{
-	return pte_wrprotect(pte);
-}
-#endif
-
 #ifndef __HAVE_ARCH_PREPARE_HUGEPAGE_RANGE
 static inline int prepare_hugepage_range(struct file *file,
 		unsigned long addr, unsigned long len)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1d9ad909c87c..86f1ecb0f9b4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1913,17 +1913,15 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	oldpmd = pmdp_invalidate_ad(vma, addr, pmd);
 
 	entry = pmd_modify(oldpmd, newprot);
-	if (uffd_wp) {
-		entry = pmd_wrprotect(entry);
+	if (uffd_wp)
 		entry = pmd_mkuffd_wp(entry);
-	} else if (uffd_wp_resolve) {
+	else if (uffd_wp_resolve)
 		/*
 		 * Leave the write bit to be handled by PF interrupt
 		 * handler, then things like COW could be properly
 		 * handled.
 		 */
 		entry = pmd_clear_uffd_wp(entry);
-	}
 
 	/* See change_pte_range(). */
 	if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) && !pmd_write(entry) &&
@@ -3267,7 +3265,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	if (is_writable_migration_entry(entry))
 		pmde = maybe_pmd_mkwrite(pmde, vma);
 	if (pmd_swp_uffd_wp(*pvmw->pmd))
-		pmde = pmd_wrprotect(pmd_mkuffd_wp(pmde));
+		pmde = pmd_mkuffd_wp(pmde);
 	if (!is_migration_entry_young(entry))
 		pmde = pmd_mkold(pmde);
 	/* NOTE: this may contain setting soft-dirty on some archs */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1088f2f41c88..a10cb7038a04 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5749,7 +5749,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * if populated.
 	 */
 	if (unlikely(pte_marker_uffd_wp(old_pte)))
-		new_pte = huge_pte_wrprotect(huge_pte_mkuffd_wp(new_pte));
+		new_pte = huge_pte_mkuffd_wp(new_pte);
 	set_huge_pte_at(mm, haddr, ptep, new_pte);
 
 	hugetlb_count_add(pages_per_huge_page(h), mm);
@@ -6550,7 +6550,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 			pte = huge_pte_modify(old_pte, newprot);
 			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
 			if (uffd_wp)
-				pte = huge_pte_mkuffd_wp(huge_pte_wrprotect(pte));
+				pte = huge_pte_mkuffd_wp(pte);
 			else if (uffd_wp_resolve)
 				pte = huge_pte_clear_uffd_wp(pte);
 			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
diff --git a/mm/memory.c b/mm/memory.c
index aad226daf41b..1e2628bf8de1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -882,7 +882,7 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	pte = maybe_mkwrite(pte_mkdirty(pte), dst_vma);
 	if (userfaultfd_pte_wp(dst_vma, *src_pte))
 		/* Uffd-wp needs to be delivered to dest pte as well */
-		pte = pte_wrprotect(pte_mkuffd_wp(pte));
+		pte = pte_mkuffd_wp(pte);
 	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
 	return 0;
 }
@@ -3950,10 +3950,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	flush_icache_page(vma, page);
 	if (pte_swp_soft_dirty(vmf->orig_pte))
 		pte = pte_mksoft_dirty(pte);
-	if (pte_swp_uffd_wp(vmf->orig_pte)) {
+	if (pte_swp_uffd_wp(vmf->orig_pte))
 		pte = pte_mkuffd_wp(pte);
-		pte = pte_wrprotect(pte);
-	}
 	vmf->orig_pte = pte;
 
 	/* ksm created a completely new copy */
@@ -4296,7 +4294,7 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 	if (write)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 	if (unlikely(uffd_wp))
-		entry = pte_mkuffd_wp(pte_wrprotect(entry));
+		entry = pte_mkuffd_wp(entry);
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 093cb50f2fc4..a816ec34c234 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -177,12 +177,10 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 			oldpte = ptep_modify_prot_start(vma, addr, pte);
 			ptent = pte_modify(oldpte, newprot);
 
-			if (uffd_wp) {
-				ptent = pte_wrprotect(ptent);
+			if (uffd_wp)
 				ptent = pte_mkuffd_wp(ptent);
-			} else if (uffd_wp_resolve) {
+			else if (uffd_wp_resolve)
 				ptent = pte_clear_uffd_wp(ptent);
-			}
 
 			/*
 			 * In some writable, shared mappings, we might want
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index b7a9479bece2..7d28f9f02892 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -74,24 +74,10 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	_dst_pte = pte_mkdirty(_dst_pte);
 	if (page_in_cache && !vm_shared)
 		writable = false;
-
-	/*
-	 * Always mark a PTE as write-protected when needed, regardless of
-	 * VM_WRITE, which the user might change.
-	 */
-	if (wp_copy) {
-		_dst_pte = pte_mkuffd_wp(_dst_pte);
-		writable = false;
-	}
-
 	if (writable)
 		_dst_pte = pte_mkwrite(_dst_pte);
-	else
-		/*
-		 * We need this to make sure write bit removed; as mk_pte()
-		 * could return a pte with write bit set.
-		 */
-		_dst_pte = pte_wrprotect(_dst_pte);
+	if (wp_copy)
+		_dst_pte = pte_mkuffd_wp(_dst_pte);
 
 	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
 
-- 
2.37.3

