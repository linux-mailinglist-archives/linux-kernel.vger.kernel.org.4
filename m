Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1C86E314C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 14:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjDOMKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 08:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjDOMJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 08:09:58 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA61961B9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 05:09:39 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f09ec7a5c6so3721125e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 05:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681560578; x=1684152578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCs/sZPWJX1gtmxe2QOizxEtYJfYeMRPWTDbu9h9OZw=;
        b=YiAIwHkEdr1/ZOqe4wrEnjAkwubUYyEEsIgZJmhmGfHlK0LKA53CcITGmXAghMQBuz
         6MRaBAU4wGJycNw7yeijfstj6n9tZPM2lh9Cywavhxrkhfw7TcyV4hZ22Y7J+qTNZ056
         LTQzBaMljW/5rTInhGkr/FyQne/l2VdWGonxsOZEpVVOo8HWpqx+T82g+AJotzXhUID2
         6KX1iDN6jZqcoVqLiJceQkLrDr8d009jVLk4taTeTmD7nll7Oaz2v1IrIw28a4UR6rZs
         1Fw2fsLN4dHsXX19tJ1xX4DQJRFRvi54ASHGEqFMM2Lo2jtrFl5LOSrd5TEoi32AUHDN
         POEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681560578; x=1684152578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCs/sZPWJX1gtmxe2QOizxEtYJfYeMRPWTDbu9h9OZw=;
        b=cJFV2oiocb7pdUQ0vHN5wNS53Pl1+cZkwH7Zwah50HnLL5iy7iVu+LwRah8i1wrjvU
         oVRuYN1AcRTVH14kxAEDAPpON2trC3wIUc39A2mYixNkmGwrQnSYoEoFBzT15RIYu0uT
         gf4lF6h2SfmbyM/l4JBy1102y4BjE/lbjIUYG8A/usr0t0g/4oE4eSYLDn0CpHTq74tS
         b2Gtj4QrKlT3QQ5pMSp/oswQgFI3pAwzEdfbum5UDsSPi99j8/8PjOsNFIzaA05dIJjD
         B+QWImmYJeUJg8+GtYfLxk8D3JO8SGXs/z5RFqHLhiTY17Om2ZcLxLBMPytxpMiPRqVN
         EDFA==
X-Gm-Message-State: AAQBX9ejRx58qBPnfmZ8LrGjptlOZxKYRymyG2pxzKh3O+ofXbJOsdQt
        i32guXkPDlBE3GD/YNvy2mc=
X-Google-Smtp-Source: AKy350ZY0kxE6Dj9vHHELAdPslsinf/e7e/CwaX0yrhE9WGneZun20b+Rt4XRweObiUEpVFsW7zlKw==
X-Received: by 2002:adf:efd0:0:b0:2db:bdc2:f8da with SMTP id i16-20020adfefd0000000b002dbbdc2f8damr1451812wrp.71.1681560577772;
        Sat, 15 Apr 2023 05:09:37 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id z12-20020a5d440c000000b002f5fa5fb793sm5487919wrq.60.2023.04.15.05.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 05:09:36 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v3 7/7] mm/gup: remove vmas array from internal GUP functions
Date:   Sat, 15 Apr 2023 13:09:35 +0100
Message-Id: <217d9369b15d657128746beeaf6d65c03214df42.1681558407.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681558407.git.lstoakes@gmail.com>
References: <cover.1681558407.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we have eliminated all callers to GUP APIs which use the vmas
parameter, eliminate it altogether.

This eliminates a class of bugs where vmas might have been kept around
longer than the mmap_lock and thus we need not be concerned about locks
being dropped during this operation leaving behind dangling pointers.

This simplifies the GUP API and makes it considerably clearer as to its
purpose - follow flags are applied and if pinning, an array of pages is
returned.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 include/linux/hugetlb.h | 10 ++---
 mm/gup.c                | 83 +++++++++++++++--------------------------
 mm/hugetlb.c            | 24 +++++-------
 3 files changed, 45 insertions(+), 72 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 28703fe22386..2735e7a2b998 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -141,9 +141,8 @@ int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *,
 struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 				unsigned long address, unsigned int flags);
 long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
-			 struct page **, struct vm_area_struct **,
-			 unsigned long *, unsigned long *, long, unsigned int,
-			 int *);
+			 struct page **, unsigned long *, unsigned long *,
+			 long, unsigned int, int *);
 void unmap_hugepage_range(struct vm_area_struct *,
 			  unsigned long, unsigned long, struct page *,
 			  zap_flags_t);
@@ -297,9 +296,8 @@ static inline struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 
 static inline long follow_hugetlb_page(struct mm_struct *mm,
 			struct vm_area_struct *vma, struct page **pages,
-			struct vm_area_struct **vmas, unsigned long *position,
-			unsigned long *nr_pages, long i, unsigned int flags,
-			int *nonblocking)
+			unsigned long *position, unsigned long *nr_pages,
+			long i, unsigned int flags, int *nonblocking)
 {
 	BUG();
 	return 0;
diff --git a/mm/gup.c b/mm/gup.c
index 714970ef3b30..385e428a4acb 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1028,8 +1028,6 @@ static int check_vma_flags(struct vm_area_struct *vma, struct file *file,
  * @pages:	array that receives pointers to the pages pinned.
  *		Should be at least nr_pages long. Or NULL, if caller
  *		only intends to ensure the pages are faulted in.
- * @vmas:	array of pointers to vmas corresponding to each page.
- *		Or NULL if the caller does not require them.
  * @locked:     whether we're still with the mmap_lock held
  *
  * Returns either number of pages pinned (which may be less than the
@@ -1043,8 +1041,6 @@ static int check_vma_flags(struct vm_area_struct *vma, struct file *file,
  *
  * The caller is responsible for releasing returned @pages, via put_page().
  *
- * @vmas are valid only as long as mmap_lock is held.
- *
  * Must be called with mmap_lock held.  It may be released.  See below.
  *
  * __get_user_pages walks a process's page tables and takes a reference to
@@ -1080,7 +1076,7 @@ static int check_vma_flags(struct vm_area_struct *vma, struct file *file,
 static long __get_user_pages(struct mm_struct *mm,
 		unsigned long start, unsigned long nr_pages,
 		unsigned int gup_flags, struct page **pages,
-		struct vm_area_struct **vmas, int *locked)
+		int *locked)
 {
 	long ret = 0, i = 0;
 	struct vm_area_struct *vma = NULL;
@@ -1124,9 +1120,9 @@ static long __get_user_pages(struct mm_struct *mm,
 			file = vma->vm_file;
 
 			if (is_vm_hugetlb_page(vma)) {
-				i = follow_hugetlb_page(mm, vma, pages, vmas,
-						&start, &nr_pages, i,
-						gup_flags, locked);
+				i = follow_hugetlb_page(mm, vma, pages,
+							&start, &nr_pages, i,
+							gup_flags, locked);
 				if (!*locked) {
 					/*
 					 * We've got a VM_FAULT_RETRY
@@ -1191,10 +1187,6 @@ static long __get_user_pages(struct mm_struct *mm,
 			ctx.page_mask = 0;
 		}
 next_page:
-		if (vmas) {
-			vmas[i] = vma;
-			ctx.page_mask = 0;
-		}
 		page_increm = 1 + (~(start >> PAGE_SHIFT) & ctx.page_mask);
 		if (page_increm > nr_pages)
 			page_increm = nr_pages;
@@ -1349,7 +1341,6 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
 						unsigned long start,
 						unsigned long nr_pages,
 						struct page **pages,
-						struct vm_area_struct **vmas,
 						int *locked,
 						unsigned int flags)
 {
@@ -1387,7 +1378,7 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
 	pages_done = 0;
 	for (;;) {
 		ret = __get_user_pages(mm, start, nr_pages, flags, pages,
-				       vmas, locked);
+				       locked);
 		if (!(flags & FOLL_UNLOCKABLE)) {
 			/* VM_FAULT_RETRY couldn't trigger, bypass */
 			pages_done = ret;
@@ -1451,7 +1442,7 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
 
 		*locked = 1;
 		ret = __get_user_pages(mm, start, 1, flags | FOLL_TRIED,
-				       pages, NULL, locked);
+				       pages, locked);
 		if (!*locked) {
 			/* Continue to retry until we succeeded */
 			BUG_ON(ret != 0);
@@ -1549,7 +1540,7 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 	 * not result in a stack expansion that recurses back here.
 	 */
 	ret = __get_user_pages(mm, start, nr_pages, gup_flags,
-				NULL, NULL, locked ? locked : &local_locked);
+			       NULL, locked ? locked : &local_locked);
 	lru_add_drain();
 	return ret;
 }
@@ -1607,7 +1598,7 @@ long faultin_vma_page_range(struct vm_area_struct *vma, unsigned long start,
 		return -EINVAL;
 
 	ret = __get_user_pages(mm, start, nr_pages, gup_flags,
-				NULL, NULL, locked);
+			       NULL, locked);
 	lru_add_drain();
 	return ret;
 }
@@ -1675,8 +1666,7 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 #else /* CONFIG_MMU */
 static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
 		unsigned long nr_pages, struct page **pages,
-		struct vm_area_struct **vmas, int *locked,
-		unsigned int foll_flags)
+		int *locked, unsigned int foll_flags)
 {
 	struct vm_area_struct *vma;
 	bool must_unlock = false;
@@ -1720,8 +1710,7 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
 			if (pages[i])
 				get_page(pages[i]);
 		}
-		if (vmas)
-			vmas[i] = vma;
+
 		start = (start + PAGE_SIZE) & PAGE_MASK;
 	}
 
@@ -1902,8 +1891,7 @@ struct page *get_dump_page(unsigned long addr)
 	int locked = 0;
 	int ret;
 
-	ret = __get_user_pages_locked(current->mm, addr, 1, &page, NULL,
-				      &locked,
+	ret = __get_user_pages_locked(current->mm, addr, 1, &page, &locked,
 				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
 	return (ret == 1) ? page : NULL;
 }
@@ -2076,7 +2064,6 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 				  unsigned long start,
 				  unsigned long nr_pages,
 				  struct page **pages,
-				  struct vm_area_struct **vmas,
 				  int *locked,
 				  unsigned int gup_flags)
 {
@@ -2084,13 +2071,13 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 	long rc, nr_pinned_pages;
 
 	if (!(gup_flags & FOLL_LONGTERM))
-		return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
+		return __get_user_pages_locked(mm, start, nr_pages, pages,
 					       locked, gup_flags);
 
 	flags = memalloc_pin_save();
 	do {
 		nr_pinned_pages = __get_user_pages_locked(mm, start, nr_pages,
-							  pages, vmas, locked,
+							  pages, locked,
 							  gup_flags);
 		if (nr_pinned_pages <= 0) {
 			rc = nr_pinned_pages;
@@ -2108,9 +2095,8 @@ static long __gup_longterm_locked(struct mm_struct *mm,
  * Check that the given flags are valid for the exported gup/pup interface, and
  * update them with the required flags that the caller must have set.
  */
-static bool is_valid_gup_args(struct page **pages, struct vm_area_struct **vmas,
-			      int *locked, unsigned int *gup_flags_p,
-			      unsigned int to_set)
+static bool is_valid_gup_args(struct page **pages, int *locked,
+			      unsigned int *gup_flags_p, unsigned int to_set)
 {
 	unsigned int gup_flags = *gup_flags_p;
 
@@ -2152,13 +2138,6 @@ static bool is_valid_gup_args(struct page **pages, struct vm_area_struct **vmas,
 			 (gup_flags & FOLL_PCI_P2PDMA)))
 		return false;
 
-	/*
-	 * Can't use VMAs with locked, as locked allows GUP to unlock
-	 * which invalidates the vmas array
-	 */
-	if (WARN_ON_ONCE(vmas && (gup_flags & FOLL_UNLOCKABLE)))
-		return false;
-
 	*gup_flags_p = gup_flags;
 	return true;
 }
@@ -2227,11 +2206,11 @@ long get_user_pages_remote(struct mm_struct *mm,
 {
 	int local_locked = 1;
 
-	if (!is_valid_gup_args(pages, NULL, locked, &gup_flags,
+	if (!is_valid_gup_args(pages, locked, &gup_flags,
 			       FOLL_TOUCH | FOLL_REMOTE))
 		return -EINVAL;
 
-	return __get_user_pages_locked(mm, start, nr_pages, pages, NULL,
+	return __get_user_pages_locked(mm, start, nr_pages, pages,
 				       locked ? locked : &local_locked,
 				       gup_flags);
 }
@@ -2266,11 +2245,11 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
 {
 	int locked = 1;
 
-	if (!is_valid_gup_args(pages, NULL, NULL, &gup_flags, FOLL_TOUCH))
+	if (!is_valid_gup_args(pages, NULL, &gup_flags, FOLL_TOUCH))
 		return -EINVAL;
 
 	return __get_user_pages_locked(current->mm, start, nr_pages, pages,
-				       NULL, &locked, gup_flags);
+				       &locked, gup_flags);
 }
 EXPORT_SYMBOL(get_user_pages);
 
@@ -2294,12 +2273,12 @@ long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 {
 	int locked = 0;
 
-	if (!is_valid_gup_args(pages, NULL, NULL, &gup_flags,
+	if (!is_valid_gup_args(pages, NULL, &gup_flags,
 			       FOLL_TOUCH | FOLL_UNLOCKABLE))
 		return -EINVAL;
 
 	return __get_user_pages_locked(current->mm, start, nr_pages, pages,
-				       NULL, &locked, gup_flags);
+				       &locked, gup_flags);
 }
 EXPORT_SYMBOL(get_user_pages_unlocked);
 
@@ -2982,7 +2961,7 @@ static int internal_get_user_pages_fast(unsigned long start,
 	start += nr_pinned << PAGE_SHIFT;
 	pages += nr_pinned;
 	ret = __gup_longterm_locked(current->mm, start, nr_pages - nr_pinned,
-				    pages, NULL, &locked,
+				    pages, &locked,
 				    gup_flags | FOLL_TOUCH | FOLL_UNLOCKABLE);
 	if (ret < 0) {
 		/*
@@ -3024,7 +3003,7 @@ int get_user_pages_fast_only(unsigned long start, int nr_pages,
 	 * FOLL_FAST_ONLY is required in order to match the API description of
 	 * this routine: no fall back to regular ("slow") GUP.
 	 */
-	if (!is_valid_gup_args(pages, NULL, NULL, &gup_flags,
+	if (!is_valid_gup_args(pages, NULL, &gup_flags,
 			       FOLL_GET | FOLL_FAST_ONLY))
 		return -EINVAL;
 
@@ -3057,7 +3036,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 	 * FOLL_GET, because gup fast is always a "pin with a +1 page refcount"
 	 * request.
 	 */
-	if (!is_valid_gup_args(pages, NULL, NULL, &gup_flags, FOLL_GET))
+	if (!is_valid_gup_args(pages, NULL, &gup_flags, FOLL_GET))
 		return -EINVAL;
 	return internal_get_user_pages_fast(start, nr_pages, gup_flags, pages);
 }
@@ -3082,7 +3061,7 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
 int pin_user_pages_fast(unsigned long start, int nr_pages,
 			unsigned int gup_flags, struct page **pages)
 {
-	if (!is_valid_gup_args(pages, NULL, NULL, &gup_flags, FOLL_PIN))
+	if (!is_valid_gup_args(pages, NULL, &gup_flags, FOLL_PIN))
 		return -EINVAL;
 	return internal_get_user_pages_fast(start, nr_pages, gup_flags, pages);
 }
@@ -3115,10 +3094,10 @@ long pin_user_pages_remote(struct mm_struct *mm,
 {
 	int local_locked = 1;
 
-	if (!is_valid_gup_args(pages, NULL, locked, &gup_flags,
+	if (!is_valid_gup_args(pages, locked, &gup_flags,
 			       FOLL_PIN | FOLL_TOUCH | FOLL_REMOTE))
 		return 0;
-	return __gup_longterm_locked(mm, start, nr_pages, pages, NULL,
+	return __gup_longterm_locked(mm, start, nr_pages, pages,
 				     locked ? locked : &local_locked,
 				     gup_flags);
 }
@@ -3144,10 +3123,10 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
 {
 	int locked = 1;
 
-	if (!is_valid_gup_args(pages, NULL, NULL, &gup_flags, FOLL_PIN))
+	if (!is_valid_gup_args(pages, NULL, &gup_flags, FOLL_PIN))
 		return 0;
 	return __gup_longterm_locked(current->mm, start, nr_pages,
-				     pages, NULL, &locked, gup_flags);
+				     pages, &locked, gup_flags);
 }
 EXPORT_SYMBOL(pin_user_pages);
 
@@ -3161,11 +3140,11 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 {
 	int locked = 0;
 
-	if (!is_valid_gup_args(pages, NULL, NULL, &gup_flags,
+	if (!is_valid_gup_args(pages, NULL, &gup_flags,
 			       FOLL_PIN | FOLL_TOUCH | FOLL_UNLOCKABLE))
 		return 0;
 
-	return __gup_longterm_locked(current->mm, start, nr_pages, pages, NULL,
+	return __gup_longterm_locked(current->mm, start, nr_pages, pages,
 				     &locked, gup_flags);
 }
 EXPORT_SYMBOL(pin_user_pages_unlocked);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a08fb47fb200..85138a0394b9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6371,17 +6371,14 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 }
 #endif /* CONFIG_USERFAULTFD */
 
-static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
-				 int refs, struct page **pages,
-				 struct vm_area_struct **vmas)
+static void record_subpages(struct page *page, struct vm_area_struct *vma,
+			    int refs, struct page **pages)
 {
 	int nr;
 
 	for (nr = 0; nr < refs; nr++) {
 		if (likely(pages))
 			pages[nr] = nth_page(page, nr);
-		if (vmas)
-			vmas[nr] = vma;
 	}
 }
 
@@ -6454,9 +6451,9 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 }
 
 long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
-			 struct page **pages, struct vm_area_struct **vmas,
-			 unsigned long *position, unsigned long *nr_pages,
-			 long i, unsigned int flags, int *locked)
+			 struct page **pages, unsigned long *position,
+			 unsigned long *nr_pages, long i, unsigned int flags,
+			 int *locked)
 {
 	unsigned long pfn_offset;
 	unsigned long vaddr = *position;
@@ -6584,7 +6581,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * If subpage information not requested, update counters
 		 * and skip the same_page loop below.
 		 */
-		if (!pages && !vmas && !pfn_offset &&
+		if (!pages && !pfn_offset &&
 		    (vaddr + huge_page_size(h) < vma->vm_end) &&
 		    (remainder >= pages_per_huge_page(h))) {
 			vaddr += huge_page_size(h);
@@ -6599,11 +6596,10 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		refs = min3(pages_per_huge_page(h) - pfn_offset, remainder,
 		    (vma->vm_end - ALIGN_DOWN(vaddr, PAGE_SIZE)) >> PAGE_SHIFT);
 
-		if (pages || vmas)
-			record_subpages_vmas(nth_page(page, pfn_offset),
-					     vma, refs,
-					     likely(pages) ? pages + i : NULL,
-					     vmas ? vmas + i : NULL);
+		if (pages)
+			record_subpages(nth_page(page, pfn_offset),
+					vma, refs,
+					likely(pages) ? pages + i : NULL);
 
 		if (pages) {
 			/*
-- 
2.40.0

