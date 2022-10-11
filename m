Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F2F5FAA94
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiJKCW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJKCW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:22:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA3982D0B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:22:21 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id n18-20020a17090ade9200b0020b0012097cso603566pjv.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzxRXZh2ZpCVU2bpLGiMFKwYjl0iDSX4se2xXGC6hk8=;
        b=g7/Dln2aP/rzIlJVDCOcKO2ExXMwc8oou+gp2lMkgFtPAxQbvBbSN+cy93oOMBZb2/
         lXHlCMKPHw/Q5eRk8hfkejD4HPR0jeernWPy60zNRCTE9f+AGO/IgXblNhFliN5OjkLj
         G6z8xHdrdVmTdaiJ9TTn13VZvpLsVDoPymx8pukFFllSW41BqsrckdeW4cFyn7ey+JU3
         tB5tDXQRLUiZiXFuVHcNVwFLOn6wHm928qtqHTugVb8BFWby7Td7nHO0d/2/4DYD9FZ0
         IpQHrV4b+AQ8d5d8Tu5g3lYVM2M86t34Qfow2FFlQv42bteYGNhttdm5IlyAkY7aZsTe
         3vTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzxRXZh2ZpCVU2bpLGiMFKwYjl0iDSX4se2xXGC6hk8=;
        b=VwGq1Y2UjSyc94HrrM1MAHK8kRDIJM2wPzK0v33IEiciUQdooYAscKDjLha3BjJ6Xs
         SqNHYQ6QVjFGAX3JIJ7/+eJhvDyz5sLSyhjO7PixSDSJ1TI56fjGgMkDhOo6gCU8OzLl
         gXdq8pxrDvHaKaqd60pzITvHYnMMAmw6GaVAP54e+1vRC4SOWTT1b8HhzgVTj3nYAzDE
         8QM9VrqhI9/cLIzQZbMb29VNNT4PhI2+ghg2dfDNWvW/gD7lLMnUn2V7S6LFyGj2k5Vf
         wgUqvIhsVHtfHJvM4zsOFcRnWesglfqph00fQYU3aCdyBUzVLrMzYlUEuPkGZ5wc31Vb
         QqyQ==
X-Gm-Message-State: ACrzQf0c2k3bPfkQdNAelztUh/cJSUlQc0bugLUFNOhkhWxrwtCz9x/H
        SVjrNsEaM/U22/x/Ix3Tx3Q=
X-Google-Smtp-Source: AMsMyM5V2AUbwC+A+kA+F0EbjGWUOHq5622wQRFWFgaeIPP22fPizocpRdqCp0xJv97gVKZ073kb+A==
X-Received: by 2002:a17:902:c40f:b0:17f:6737:9527 with SMTP id k15-20020a170902c40f00b0017f67379527mr21820578plk.19.1665454941170;
        Mon, 10 Oct 2022 19:22:21 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n6-20020a17090a2bc600b0020a8e908dc8sm9363286pje.4.2022.10.10.19.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 19:22:20 -0700 (PDT)
From:   xu.xin.sc@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Xuexin Jiang <jiang.xuexin@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: [PATCH v3 2/5] ksm: support unsharing zero pages placed by KSM
Date:   Tue, 11 Oct 2022 02:22:15 +0000
Message-Id: <20221011022215.322269-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221011022006.322158-1-xu.xin16@zte.com.cn>
References: <20221011022006.322158-1-xu.xin16@zte.com.cn>
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

From: xu xin <xu.xin16@zte.com.cn>

use_zero_pages may be very useful, not just because of cache colouring
as described in doc, but also because use_zero_pages can accelerate
merging empty pages when there are plenty of empty pages (full of zeros)
as the time of page-by-page comparisons (unstable_tree_search_insert) is
saved.

But when enabling use_zero_pages, madvise(addr, len, MADV_UNMERGEABLE) and
other ways (like write 2 to /sys/kernel/mm/ksm/run) to trigger unsharing
will *not* unshare the shared zeropage as placed by KSM (which may be
against the MADV_UNMERGEABLE documentation at least).

To not blindly unshare all shared zero_pages in applicable VMAs, the patch
introduces a dedicated flag ZERO_PAGE_FLAG to mark the rmap_items of those
shared zero_pages. and guarantee that these rmap_items will be not freed
during the time of zero_pages not being writing, so we can only unshare
the *KSM-placed* zero_pages.

The patch will not degrade the performance of use_zero_pages as it doesn't
change the way of merging empty pages in use_zero_pages's feature.

Fixes: e86c59b1b12d ("mm/ksm: improve deduplication of zero pages with colouring")
Reported-by: David Hildenbrand <david@redhat.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Co-developed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Signed-off-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Co-developed-by: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 mm/ksm.c | 136 ++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 105 insertions(+), 31 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 13c60f1071d8..e351d7b6d15e 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -213,6 +213,7 @@ struct ksm_rmap_item {
 #define SEQNR_MASK	0x0ff	/* low bits of unstable tree seqnr */
 #define UNSTABLE_FLAG	0x100	/* is a node of the unstable tree */
 #define STABLE_FLAG	0x200	/* is listed from the stable tree */
+#define ZERO_PAGE_FLAG 0x400 /* is zero page placed by KSM */
 
 /* The stable and unstable tree heads */
 static struct rb_root one_stable_tree[1] = { RB_ROOT };
@@ -381,14 +382,6 @@ static inline struct ksm_rmap_item *alloc_rmap_item(void)
 	return rmap_item;
 }
 
-static inline void free_rmap_item(struct ksm_rmap_item *rmap_item)
-{
-	ksm_rmap_items--;
-	rmap_item->mm->ksm_rmap_items--;
-	rmap_item->mm = NULL;	/* debug safety */
-	kmem_cache_free(rmap_item_cache, rmap_item);
-}
-
 static inline struct ksm_stable_node *alloc_stable_node(void)
 {
 	/*
@@ -420,7 +413,8 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
 }
 
 /*
- * We use break_ksm to break COW on a ksm page: it's a stripped down
+ * We use break_ksm to break COW on a ksm page or KSM-placed zero page (only
+ * happen when enabling use_zero_pages): it's a stripped down
  *
  *	if (get_user_pages(addr, 1, FOLL_WRITE, &page, NULL) == 1)
  *		put_page(page);
@@ -434,7 +428,8 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
  * of the process that owns 'vma'.  We also do not want to enforce
  * protection keys here anyway.
  */
-static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
+static int break_ksm(struct vm_area_struct *vma, unsigned long addr,
+				     bool ksm_check_bypass)
 {
 	struct page *page;
 	vm_fault_t ret = 0;
@@ -449,6 +444,16 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
 			ret = handle_mm_fault(vma, addr,
 					      FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE,
 					      NULL);
+		else if (ksm_check_bypass && is_zero_pfn(page_to_pfn(page))) {
+			/*
+			 * Although it's not ksm page, it's zero page as placed by
+			 * KSM use_zero_page, so we should unshare it when
+			 * ksm_check_bypass is true.
+			 */
+			ret = handle_mm_fault(vma, addr,
+						  FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE,
+						  NULL);
+		}
 		else
 			ret = VM_FAULT_WRITE;
 		put_page(page);
@@ -496,6 +501,11 @@ static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
 	return vma;
 }
 
+/*
+ * Note: Don't call break_cow() in the context protected by
+ * mmap_read_lock(), which may cause dead lock because inside
+ * break_cow mmap_read_lock exists.
+ */
 static void break_cow(struct ksm_rmap_item *rmap_item)
 {
 	struct mm_struct *mm = rmap_item->mm;
@@ -511,10 +521,35 @@ static void break_cow(struct ksm_rmap_item *rmap_item)
 	mmap_read_lock(mm);
 	vma = find_mergeable_vma(mm, addr);
 	if (vma)
-		break_ksm(vma, addr);
+		break_ksm(vma, addr, false);
 	mmap_read_unlock(mm);
 }
 
+/* Only called when rmap_item->address is with ZERO_PAGE_FLAG */
+static inline int unshare_zero_pages(struct ksm_rmap_item *rmap_item)
+{
+	struct mm_struct *mm = rmap_item->mm;
+	struct vm_area_struct *vma;
+	unsigned long addr = rmap_item->address;
+	int err = -EFAULT;
+
+	vma = vma_lookup(mm, addr);
+	if (vma)
+		err = break_ksm(vma, addr, true);
+
+	return err;
+}
+
+static inline void free_rmap_item(struct ksm_rmap_item *rmap_item)
+{
+	if (rmap_item->address & ZERO_PAGE_FLAG)
+		unshare_zero_pages(rmap_item);
+	ksm_rmap_items--;
+	rmap_item->mm->ksm_rmap_items--;
+	rmap_item->mm = NULL;   /* debug safety */
+	kmem_cache_free(rmap_item_cache, rmap_item);
+}
+
 static struct page *get_mergeable_page(struct ksm_rmap_item *rmap_item)
 {
 	struct mm_struct *mm = rmap_item->mm;
@@ -825,7 +860,7 @@ static int unmerge_ksm_pages(struct vm_area_struct *vma,
 		if (signal_pending(current))
 			err = -ERESTARTSYS;
 		else
-			err = break_ksm(vma, addr);
+			err = break_ksm(vma, addr, false);
 	}
 	return err;
 }
@@ -2017,6 +2052,36 @@ static void stable_tree_append(struct ksm_rmap_item *rmap_item,
 	rmap_item->mm->ksm_merging_pages++;
 }
 
+static int try_to_merge_with_kernel_zero_page(struct mm_struct *mm,
+				   struct ksm_rmap_item *rmap_item,
+				   struct page *page)
+{
+	int err = 0;
+
+	if (!(rmap_item->address & ZERO_PAGE_FLAG)) {
+		struct vm_area_struct *vma;
+
+		mmap_read_lock(mm);
+		vma = find_mergeable_vma(mm, rmap_item->address);
+		if (vma) {
+			err = try_to_merge_one_page(vma, page,
+					ZERO_PAGE(rmap_item->address));
+		} else {
+			/* If the vma is out of date, we do not need to continue. */
+			err = 0;
+		}
+		mmap_read_unlock(mm);
+		/*
+		 * In case of failure, the page was not really empty, so we
+		 * need to continue. Otherwise we're done.
+		 */
+		if (!err)
+			rmap_item->address |= ZERO_PAGE_FLAG;
+	}
+
+	return err;
+}
+
 /*
  * cmp_and_merge_page - first see if page can be merged into the stable tree;
  * if not, compare checksum to previous and if it's the same, see if page can
@@ -2101,29 +2166,21 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 	 * Same checksum as an empty page. We attempt to merge it with the
 	 * appropriate zero page if the user enabled this via sysfs.
 	 */
-	if (ksm_use_zero_pages && (checksum == zero_checksum)) {
-		struct vm_area_struct *vma;
-
-		mmap_read_lock(mm);
-		vma = find_mergeable_vma(mm, rmap_item->address);
-		if (vma) {
-			err = try_to_merge_one_page(vma, page,
-					ZERO_PAGE(rmap_item->address));
-		} else {
+	if (ksm_use_zero_pages) {
+		if (checksum == zero_checksum) {
+			/* If success, just return. Otherwise, continue */
+			if (!try_to_merge_with_kernel_zero_page(mm, rmap_item, page))
+				return;
+		} else if (rmap_item->address & ZERO_PAGE_FLAG) {
 			/*
-			 * If the vma is out of date, we do not need to
-			 * continue.
+			 * The page now is not kernel zero page (COW happens to it)
+			 * but the flag of its rmap_item is still zero-page, so need
+			 * to reset the flag and update the corresponding count.
 			 */
-			err = 0;
+			rmap_item->address &= PAGE_MASK;
 		}
-		mmap_read_unlock(mm);
-		/*
-		 * In case of failure, the page was not really empty, so we
-		 * need to continue. Otherwise we're done.
-		 */
-		if (!err)
-			return;
 	}
+
 	tree_rmap_item =
 		unstable_tree_search_insert(rmap_item, page, &tree_page);
 	if (tree_rmap_item) {
@@ -2337,6 +2394,23 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 				mmap_read_unlock(mm);
 				return rmap_item;
 			}
+			/*
+			 * Because we want to monitor ksm zero pages which is
+			 * non-anonymous, we must try to return the rmap_items
+			 * of those kernel zero pages which replaces its
+			 * original anonymous empty page due to use_zero_pages's
+			 * feature.
+			 */
+			if (is_zero_pfn(page_to_pfn(*page))) {
+				rmap_item = try_to_get_old_rmap_item(ksm_scan.address,
+										ksm_scan.rmap_list);
+				if (rmap_item && (rmap_item->address & ZERO_PAGE_FLAG)) {
+					ksm_scan.rmap_list = &rmap_item->rmap_list;
+					ksm_scan.address += PAGE_SIZE;
+					mmap_read_unlock(mm);
+					return rmap_item;
+				}
+			}
 next_page:
 			put_page(*page);
 			ksm_scan.address += PAGE_SIZE;
-- 
2.25.1

