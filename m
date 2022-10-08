Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4DF5F83EB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 09:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJHHFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 03:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJHHFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 03:05:23 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40C74F187
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 00:05:21 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 3so5146125pfw.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 00:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TTOF9N9iR/s34f2B+vKzoMurrZM7tfnNofX5SBhUeU=;
        b=TKxT76iUIyp2PdMUPm342LyyWfmbAtq+yidjutwticBt2ujhaJ1f0TLf2ypF/kfBWQ
         qHIuSZY6cE+vjahnKM8hYO5ZCmyNbtNB+ZfHMMpuaQD9kzZAfXyJinED5JEhnUraRpuM
         l4F+BozbWKphh14ws5PArG5QhHIx/4OOZYJsfy1hn5Ni2vTWpGLXUqubIsmE6Vs5D160
         Fa3EmC2Bq8EHZkxX0Z86TPE23d2t+mGWFGmdnmLyC89SM07tMZz+/1eY2Hy4ji5Nl8lX
         RSzkpJazS1MM5PtI0L44aC1YmZ+K7tDSyb0S1CNVeoMoH1AjLuk/IsOIHrOkSp8LrEax
         hTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TTOF9N9iR/s34f2B+vKzoMurrZM7tfnNofX5SBhUeU=;
        b=zfwc+mejuITnvLUnnvJ4RgCye5Fv5MpVjgZyTJgxC4Mnn+qjhOpg8Zzq3RqwPatpJ9
         iWpS5Ic09yX+cxfd9Ah7HwSXDKZVQxqY7RVM+b6Jk6lhjLQqrZ9CLtZJTX5ULpDgzsrb
         klRXOZakD18FCABJXpBgAuB0pvjeHbnbNG88ItQjg0s0Ah3dKLp6YDsjIMC/ILn2U8Pw
         cYV6qD/nDPmbAxLSXWJ1vdaZzZKA8NcWM88hOT5GxUZYvRGzCofhmHdfGEwp7SkGzMDg
         adY7MlegHQBOrC69RfN1OVeSl1jdgmnId/v9GZDvdoMHxqIgeF92gtXLTfwMLpXEqby/
         Mkjw==
X-Gm-Message-State: ACrzQf2tj1dwDp6wmuaA+LeZAyFEJf1rty2mY5wZRn0dznZYQjC8A6wi
        uAn+bOK5nEY8Ba1frkNsEHQ=
X-Google-Smtp-Source: AMsMyM4HcJKDqVB5Z4cZhIadTZQlGre0ug56Zj60bcBqI2lL1UKGlbciEIhI9K8zvwfqB4nf21XIAQ==
X-Received: by 2002:a63:2c8b:0:b0:41c:5f9e:a1d6 with SMTP id s133-20020a632c8b000000b0041c5f9ea1d6mr7685355pgs.601.1665212721029;
        Sat, 08 Oct 2022 00:05:21 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b00176ea6ce0efsm2665411plh.109.2022.10.08.00.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 00:05:20 -0700 (PDT)
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
Subject: [PATCH 2/5] ksm: support unsharing zero pages placed by KSM
Date:   Sat,  8 Oct 2022 07:05:05 +0000
Message-Id: <20221008070505.308580-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221008070156.308465-1-xu.xin16@zte.com.cn>
References: <20221008070156.308465-1-xu.xin16@zte.com.cn>
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

After the commit e86c59b1b12d ("mm/ksm: improve deduplication of zero
pages with colouring"), madvise(addr, len, MADV_UNMERGEABLE) and other
ways (like write 2 to /sys/kernel/mm/ksm/run) to trigger unsharing will
**not** unshare the shared zeropage as placed by KSM (which is against
the MADV_UNMERGEABLE documentation at least).

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
 mm/ksm.c | 134 ++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 104 insertions(+), 30 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 5b68482d2b3b..75978f7eeed1 100644
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
@@ -434,7 +427,8 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
  * of the process that owns 'vma'.  We also do not want to enforce
  * protection keys here anyway.
  */
-static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
+static int break_ksm(struct vm_area_struct *vma, unsigned long addr,
+				     bool ksm_check_bypass)
 {
 	struct page *page;
 	vm_fault_t ret = 0;
@@ -449,6 +443,16 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
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
@@ -496,6 +500,11 @@ static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
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
@@ -511,10 +520,35 @@ static void break_cow(struct ksm_rmap_item *rmap_item)
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
@@ -825,7 +859,7 @@ static int unmerge_ksm_pages(struct vm_area_struct *vma,
 		if (signal_pending(current))
 			err = -ERESTARTSYS;
 		else
-			err = break_ksm(vma, addr);
+			err = break_ksm(vma, addr, NULL);
 	}
 	return err;
 }
@@ -2017,6 +2051,36 @@ static void stable_tree_append(struct ksm_rmap_item *rmap_item,
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
@@ -2101,29 +2165,21 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
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
@@ -2197,6 +2253,7 @@ static struct ksm_rmap_item *try_to_get_old_rmap_item(unsigned long addr,
 		if (rmap_item->address > addr)
 			break;
 		*rmap_list = rmap_item->rmap_list;
+		/* running here indicates these pages have been unmerged */
 		remove_rmap_item_from_tree(rmap_item);
 		free_rmap_item(rmap_item);
 	}
@@ -2336,6 +2393,23 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
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

