Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5AA70721E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjEQT0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjEQT0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:26:10 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA35955B3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:25:53 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f41d087b3bso12423875e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684351552; x=1686943552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWH+EjyNuCUCrFkcRLy75iYiK0WxcM9W/xkINR/0Rz4=;
        b=a4SjuqLN8rNls/ol005Ct1bSiRSR3ZDC0+t0FHDX9I6N66fP6VMNi5GQdV2/4maT9p
         35/0GIxTwANNNP8X+BJjbM3mWcHsROlPHVAATIdTHv4Bp8uxx+9ScW/v7YS3MJQUARk7
         +riG4lvx6u1IuPfj7AxR/wDOeO/yU2xMqSSrBuh1+wWub3UmFqjlkvCu8QaClmd5+Gwz
         OG+Ic8nANpto3x8cvKHdyijHWnRLu+eSVK/6MLMXOi9fDjks3/HYyvrxm5RxvnB1Q7Ql
         8dg2oO99YkLAQ+tuKhXBJKsM+ulmwWYgUSy4/i33ZuKuel2kysR4yqdUcn1gqX53DY6N
         Vmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684351552; x=1686943552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWH+EjyNuCUCrFkcRLy75iYiK0WxcM9W/xkINR/0Rz4=;
        b=fuO1xQRdCPBkoOL5khdsfcaVJGh+w7i4cI/EgUE6Ioc6TTSj4lGVtlggEY2oQYL2j1
         HEUUlaRE5bqeRhHKWgi9qv5YVxzGNbN9L06NYxIldAFdveL66oUiA8IzBaOEcnv4o3C/
         UkfBRrutpup9Ikj3uIh4E7ecoUUig8CZS+labk6YcLWLlbb4TTMZZR8GrdCtD3D9FXEQ
         uw9nubJ5Wqbo33b5e+qQ0LOiMrF9GpK4kkT1UtpItBXsgSbcIlraEwBv1T5VjxLeLjQK
         yhXwR7gANBZ6zo0BuxuRM5qew2cBJ+9l5FSdSZ4ULimWW5dICRHbf3B/rQK9/1KJm1gg
         CIow==
X-Gm-Message-State: AC+VfDxnz7TeqhKTahSVp9VNcgS8+/u/iYvlv2cyiq3tm5raxgtp3Y1M
        2cR2rJ73aRmQSjGC5OUbMB4=
X-Google-Smtp-Source: ACHHUZ6hGvIrFp0xpcy9GeDyGDr3FJIKFv357WoRg4Q2KCZW17oKe0lRQ74bo8hL1hnfg3V+1U1tZQ==
X-Received: by 2002:a7b:cc05:0:b0:3f1:7581:eaaf with SMTP id f5-20020a7bcc05000000b003f17581eaafmr29632435wmh.4.1684351551268;
        Wed, 17 May 2023 12:25:51 -0700 (PDT)
Received: from lucifer.home (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.googlemail.com with ESMTPSA id o12-20020a1c750c000000b003f17eaae2c9sm3163677wmc.1.2023.05.17.12.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:25:50 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 6/6] mm/gup: remove vmas array from internal GUP functions
Date:   Wed, 17 May 2023 20:25:48 +0100
Message-Id: <6811b4b2b4b3baf3dd07f422bb18853bb2cd09fb.1684350871.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684350871.git.lstoakes@gmail.com>
References: <cover.1684350871.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 include/linux/hugetlb.h | 10 ++---
 mm/gup.c                | 83 +++++++++++++++--------------------------
 mm/hugetlb.c            | 24 +++++-------
 3 files changed, 45 insertions(+), 72 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 6d041aa9f0fe..b2b698f9a2ec 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -133,9 +133,8 @@ int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *,
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
@@ -306,9 +305,8 @@ static inline struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 
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
index 36701b5f0123..dbe96d266670 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1067,8 +1067,6 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
  * @pages:	array that receives pointers to the pages pinned.
  *		Should be at least nr_pages long. Or NULL, if caller
  *		only intends to ensure the pages are faulted in.
- * @vmas:	array of pointers to vmas corresponding to each page.
- *		Or NULL if the caller does not require them.
  * @locked:     whether we're still with the mmap_lock held
  *
  * Returns either number of pages pinned (which may be less than the
@@ -1082,8 +1080,6 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
  *
  * The caller is responsible for releasing returned @pages, via put_page().
  *
- * @vmas are valid only as long as mmap_lock is held.
- *
  * Must be called with mmap_lock held.  It may be released.  See below.
  *
  * __get_user_pages walks a process's page tables and takes a reference to
@@ -1119,7 +1115,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 static long __get_user_pages(struct mm_struct *mm,
 		unsigned long start, unsigned long nr_pages,
 		unsigned int gup_flags, struct page **pages,
-		struct vm_area_struct **vmas, int *locked)
+		int *locked)
 {
 	long ret = 0, i = 0;
 	struct vm_area_struct *vma = NULL;
@@ -1159,9 +1155,9 @@ static long __get_user_pages(struct mm_struct *mm,
 				goto out;
 
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
@@ -1226,10 +1222,6 @@ static long __get_user_pages(struct mm_struct *mm,
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
@@ -1384,7 +1376,6 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
 						unsigned long start,
 						unsigned long nr_pages,
 						struct page **pages,
-						struct vm_area_struct **vmas,
 						int *locked,
 						unsigned int flags)
 {
@@ -1422,7 +1413,7 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
 	pages_done = 0;
 	for (;;) {
 		ret = __get_user_pages(mm, start, nr_pages, flags, pages,
-				       vmas, locked);
+				       locked);
 		if (!(flags & FOLL_UNLOCKABLE)) {
 			/* VM_FAULT_RETRY couldn't trigger, bypass */
 			pages_done = ret;
@@ -1486,7 +1477,7 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
 
 		*locked = 1;
 		ret = __get_user_pages(mm, start, 1, flags | FOLL_TRIED,
-				       pages, NULL, locked);
+				       pages, locked);
 		if (!*locked) {
 			/* Continue to retry until we succeeded */
 			BUG_ON(ret != 0);
@@ -1584,7 +1575,7 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 	 * not result in a stack expansion that recurses back here.
 	 */
 	ret = __get_user_pages(mm, start, nr_pages, gup_flags,
-				NULL, NULL, locked ? locked : &local_locked);
+			       NULL, locked ? locked : &local_locked);
 	lru_add_drain();
 	return ret;
 }
@@ -1642,7 +1633,7 @@ long faultin_vma_page_range(struct vm_area_struct *vma, unsigned long start,
 		return -EINVAL;
 
 	ret = __get_user_pages(mm, start, nr_pages, gup_flags,
-				NULL, NULL, locked);
+			       NULL, locked);
 	lru_add_drain();
 	return ret;
 }
@@ -1710,8 +1701,7 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 #else /* CONFIG_MMU */
 static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
 		unsigned long nr_pages, struct page **pages,
-		struct vm_area_struct **vmas, int *locked,
-		unsigned int foll_flags)
+		int *locked, unsigned int foll_flags)
 {
 	struct vm_area_struct *vma;
 	bool must_unlock = false;
@@ -1755,8 +1745,7 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
 			if (pages[i])
 				get_page(pages[i]);
 		}
-		if (vmas)
-			vmas[i] = vma;
+
 		start = (start + PAGE_SIZE) & PAGE_MASK;
 	}
 
@@ -1937,8 +1926,7 @@ struct page *get_dump_page(unsigned long addr)
 	int locked = 0;
 	int ret;
 
-	ret = __get_user_pages_locked(current->mm, addr, 1, &page, NULL,
-				      &locked,
+	ret = __get_user_pages_locked(current->mm, addr, 1, &page, &locked,
 				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
 	return (ret == 1) ? page : NULL;
 }
@@ -2111,7 +2099,6 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 				  unsigned long start,
 				  unsigned long nr_pages,
 				  struct page **pages,
-				  struct vm_area_struct **vmas,
 				  int *locked,
 				  unsigned int gup_flags)
 {
@@ -2119,13 +2106,13 @@ static long __gup_longterm_locked(struct mm_struct *mm,
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
@@ -2143,9 +2130,8 @@ static long __gup_longterm_locked(struct mm_struct *mm,
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
 
@@ -2187,13 +2173,6 @@ static bool is_valid_gup_args(struct page **pages, struct vm_area_struct **vmas,
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
@@ -2262,11 +2241,11 @@ long get_user_pages_remote(struct mm_struct *mm,
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
@@ -2301,11 +2280,11 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
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
 
@@ -2329,12 +2308,12 @@ long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
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
 
@@ -3124,7 +3103,7 @@ static int internal_get_user_pages_fast(unsigned long start,
 	start += nr_pinned << PAGE_SHIFT;
 	pages += nr_pinned;
 	ret = __gup_longterm_locked(current->mm, start, nr_pages - nr_pinned,
-				    pages, NULL, &locked,
+				    pages, &locked,
 				    gup_flags | FOLL_TOUCH | FOLL_UNLOCKABLE);
 	if (ret < 0) {
 		/*
@@ -3166,7 +3145,7 @@ int get_user_pages_fast_only(unsigned long start, int nr_pages,
 	 * FOLL_FAST_ONLY is required in order to match the API description of
 	 * this routine: no fall back to regular ("slow") GUP.
 	 */
-	if (!is_valid_gup_args(pages, NULL, NULL, &gup_flags,
+	if (!is_valid_gup_args(pages, NULL, &gup_flags,
 			       FOLL_GET | FOLL_FAST_ONLY))
 		return -EINVAL;
 
@@ -3199,7 +3178,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 	 * FOLL_GET, because gup fast is always a "pin with a +1 page refcount"
 	 * request.
 	 */
-	if (!is_valid_gup_args(pages, NULL, NULL, &gup_flags, FOLL_GET))
+	if (!is_valid_gup_args(pages, NULL, &gup_flags, FOLL_GET))
 		return -EINVAL;
 	return internal_get_user_pages_fast(start, nr_pages, gup_flags, pages);
 }
@@ -3224,7 +3203,7 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
 int pin_user_pages_fast(unsigned long start, int nr_pages,
 			unsigned int gup_flags, struct page **pages)
 {
-	if (!is_valid_gup_args(pages, NULL, NULL, &gup_flags, FOLL_PIN))
+	if (!is_valid_gup_args(pages, NULL, &gup_flags, FOLL_PIN))
 		return -EINVAL;
 	return internal_get_user_pages_fast(start, nr_pages, gup_flags, pages);
 }
@@ -3257,10 +3236,10 @@ long pin_user_pages_remote(struct mm_struct *mm,
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
@@ -3286,10 +3265,10 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
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
 
@@ -3303,11 +3282,11 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
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
index f154019e6b84..ea24718db4af 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6425,17 +6425,14 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
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
 
@@ -6508,9 +6505,9 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
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
@@ -6638,7 +6635,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * If subpage information not requested, update counters
 		 * and skip the same_page loop below.
 		 */
-		if (!pages && !vmas && !pfn_offset &&
+		if (!pages && !pfn_offset &&
 		    (vaddr + huge_page_size(h) < vma->vm_end) &&
 		    (remainder >= pages_per_huge_page(h))) {
 			vaddr += huge_page_size(h);
@@ -6653,11 +6650,10 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
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
2.40.1

