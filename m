Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2015469B6DD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjBRAbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjBRAaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:30:12 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349BA6CA1D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:33 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5366333bdb5so15830587b3.19
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HPj8If6i9Ge054c2yi88NtPUxX7MkhEBgezIKsLW8z8=;
        b=Kd84UzoUTRPGM2pruNTbVhhDlhlYmwG9wMjKAkrrxmwn/CJAyxsS6jZ/LzaQVwYC3z
         S69dpVgrGNsnQ2VWeasqchjAp3jDCn9n8jxsJDYFL1UCwLksmO5Kw+6uUwl7zSSgvaCl
         CihuI8Yf+eChioQnTWfweqD4fr36yuVoZcedwO4ze5S8nNa5G9axS81vDsPaWdtLrroV
         8UuCTi7HBc8+DG1q9YpGK/r09QKm4gOgG0V2UzM7mQ71xE6K5hJlSxLD1cNbFDXLleV5
         yEaFpVguoifalvGf8MAWgne1cnF863zM85vjZWzRVitIqTT0Ms2eNQkJwx5cA7n7LbdD
         9FRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HPj8If6i9Ge054c2yi88NtPUxX7MkhEBgezIKsLW8z8=;
        b=cdAD0PJMBpZmSMX9kpEE1e591YBc8vBZk/37zYRi+/nIjI/M5bLOGnX28nO3fSOTWr
         rRtap00aSisfJ/zGbAGrFRG0gwl3qc3dUvxAloHaOuMB3N5dcx4QonWSs5DJP65JQS2N
         CLfCnDCPpIG2OncnKrQYeUHZMKYFw8qQAXWP4PgRabHyCrJaqwG3p+suxUZQ1E+k1e8E
         NSWFkTSKknYZf7/s5+jBohunRl6B/yCnDQC9yJX82Xtax+zu1jRX3D2fHW613QadXebb
         Tg7YlmwWnYRbDrK77hImSQkOB6vAzel/af+kuV3AcGAoRHUqQCP94EZfaw+ehbg6R3CX
         Y1Cg==
X-Gm-Message-State: AO0yUKWEIqqYnKcARBAUWaU5VPoEqvWxKtvYPMBhDWU8zbXu3ZuPQU/M
        SpS1biMp+v1hVYDgtUqgXuv5e4g16cQCfdgz
X-Google-Smtp-Source: AK7set/mcEFSHmue9cMCcVJMB1Ku9p/0QTBXluCyDE4PFP+ttIIRE+dDut302gTdIA8Yp2aY7RngxiVOCfe3YAYP
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:1cd:b0:985:3b30:f27 with SMTP
 id u13-20020a05690201cd00b009853b300f27mr245191ybh.13.1676680160446; Fri, 17
 Feb 2023 16:29:20 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:28:09 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-37-jthoughton@google.com>
Subject: [PATCH v2 36/46] hugetlb: remove huge_pte_lock and huge_pte_lockptr
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are replaced with hugetlb_pte_lock{,ptr}. All callers that haven't
already been replaced don't get called when using HGM, so we handle them
by populating hugetlb_ptes with the standard, hstate-sized huge PTEs.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 035a0df47af0..c90ac06dc8d9 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -258,11 +258,14 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 
 #ifdef CONFIG_PPC_BOOK3S_64
 		struct hstate *h = hstate_vma(vma);
+		struct hugetlb_pte hpte;
 
 		psize = hstate_get_psize(h);
 #ifdef CONFIG_DEBUG_VM
-		assert_spin_locked(huge_pte_lockptr(huge_page_shift(h),
-						    vma->vm_mm, ptep));
+		/* HGM is not supported for powerpc yet. */
+		hugetlb_pte_init(&hpte, ptep, huge_page_shift(h),
+				 hpage_size_to_level(psize));
+		assert_spin_locked(hpte.ptl);
 #endif
 
 #else
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 6cd4ae08d84d..742e7f2cb170 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1012,14 +1012,6 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
 	return modified_mask;
 }
 
-static inline spinlock_t *huge_pte_lockptr(unsigned int shift,
-					   struct mm_struct *mm, pte_t *pte)
-{
-	if (shift == PMD_SHIFT)
-		return pmd_lockptr(mm, (pmd_t *) pte);
-	return &mm->page_table_lock;
-}
-
 #ifndef hugepages_supported
 /*
  * Some platform decide whether they support huge pages at boot
@@ -1228,12 +1220,6 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
 	return 0;
 }
 
-static inline spinlock_t *huge_pte_lockptr(unsigned int shift,
-					   struct mm_struct *mm, pte_t *pte)
-{
-	return &mm->page_table_lock;
-}
-
 static inline void hugetlb_count_init(struct mm_struct *mm)
 {
 }
@@ -1308,16 +1294,6 @@ int hugetlb_collapse(struct mm_struct *mm, unsigned long start,
 }
 #endif
 
-static inline spinlock_t *huge_pte_lock(struct hstate *h,
-					struct mm_struct *mm, pte_t *pte)
-{
-	spinlock_t *ptl;
-
-	ptl = huge_pte_lockptr(huge_page_shift(h), mm, pte);
-	spin_lock(ptl);
-	return ptl;
-}
-
 static inline
 spinlock_t *hugetlb_pte_lockptr(struct hugetlb_pte *hpte)
 {
@@ -1353,8 +1329,22 @@ void hugetlb_pte_init(struct mm_struct *mm, struct hugetlb_pte *hpte,
 		      pte_t *ptep, unsigned int shift,
 		      enum hugetlb_level level)
 {
-	__hugetlb_pte_init(hpte, ptep, shift, level,
-			   huge_pte_lockptr(shift, mm, ptep));
+	spinlock_t *ptl;
+
+	/*
+	 * For contiguous HugeTLB PTEs that can contain other HugeTLB PTEs
+	 * on the same level, the same PTL for both must be used.
+	 *
+	 * For some architectures that implement hugetlb_walk_step, this
+	 * version of hugetlb_pte_populate() may not be correct to use for
+	 * high-granularity PTEs. Instead, call __hugetlb_pte_populate()
+	 * directly.
+	 */
+	if (level == HUGETLB_LEVEL_PMD)
+		ptl = pmd_lockptr(mm, (pmd_t *) ptep);
+	else
+		ptl = &mm->page_table_lock;
+	__hugetlb_pte_init(hpte, ptep, shift, level, ptl);
 }
 
 #if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 34368072dabe..e0a92e7c1755 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5454,9 +5454,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				put_page(hpage);
 
 				/* Install the new hugetlb folio if src pte stable */
-				dst_ptl = huge_pte_lock(h, dst, dst_pte);
-				src_ptl = huge_pte_lockptr(huge_page_shift(h),
-							   src, src_pte);
+				dst_ptl = hugetlb_pte_lock(&dst_hpte);
+				src_ptl = hugetlb_pte_lockptr(&src_hpte);
 				spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 				entry = huge_ptep_get(src_pte);
 				if (!pte_same(src_pte_old, entry)) {
@@ -7582,7 +7581,8 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	unsigned long saddr;
 	pte_t *spte = NULL;
 	pte_t *pte;
-	spinlock_t *ptl;
+	struct hugetlb_pte hpte;
+	struct hstate *shstate;
 
 	i_mmap_lock_read(mapping);
 	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
@@ -7603,7 +7603,11 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (!spte)
 		goto out;
 
-	ptl = huge_pte_lock(hstate_vma(vma), mm, spte);
+	shstate = hstate_vma(svma);
+
+	hugetlb_pte_init(mm, &hpte, spte, huge_page_shift(shstate),
+			 hpage_size_to_level(huge_page_size(shstate)));
+	spin_lock(hpte.ptl);
 	if (pud_none(*pud)) {
 		pud_populate(mm, pud,
 				(pmd_t *)((unsigned long)spte & PAGE_MASK));
@@ -7611,7 +7615,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	} else {
 		put_page(virt_to_page(spte));
 	}
-	spin_unlock(ptl);
+	spin_unlock(hpte.ptl);
 out:
 	pte = (pte_t *)pmd_alloc(mm, pud, addr);
 	i_mmap_unlock_read(mapping);
@@ -8315,6 +8319,7 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 	unsigned long address;
 	spinlock_t *ptl;
 	pte_t *ptep;
+	struct hugetlb_pte hpte;
 
 	if (!(vma->vm_flags & VM_MAYSHARE))
 		return;
@@ -8336,7 +8341,10 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 		ptep = hugetlb_walk(vma, address, sz);
 		if (!ptep)
 			continue;
-		ptl = huge_pte_lock(h, mm, ptep);
+
+		hugetlb_pte_init(mm, &hpte, ptep, huge_page_shift(h),
+				 hpage_size_to_level(sz));
+		ptl = hugetlb_pte_lock(&hpte);
 		huge_pmd_unshare(mm, vma, address, ptep);
 		spin_unlock(ptl);
 	}
-- 
2.39.2.637.g21b0678d19-goog

