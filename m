Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52750609A6D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 08:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiJXGUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 02:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiJXGUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 02:20:34 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE4513E87
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 23:20:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666592430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xgj0BswIBkVGdA/syrYALGbly/Y6nfTG0sbkmC7GwMs=;
        b=KSBITgTaKK2z4iAcjh5BT0FvnZGgOSiDtiMYUNOvZrAomkOtanxjMBeFn8OJ5OHjnMpC47
        ps/bfVLcUfvbTOJL8EfmHea1BTcL7QPHRk6tpxkYkEOnUWXU2XY/L3+4naIFYc2H5yDXxC
        8sNLI7WEI219Y6fpDl9rcWLmPf2V4ms=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/4] mm,hwpoison,hugetlb,memory_hotplug: hotremove memory section with hwpoisoned hugepage
Date:   Mon, 24 Oct 2022 15:20:09 +0900
Message-Id: <20221024062012.1520887-2-naoya.horiguchi@linux.dev>
In-Reply-To: <20221024062012.1520887-1-naoya.horiguchi@linux.dev>
References: <20221024062012.1520887-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

HWPoisoned page is not supposed to be accessed once marked, but currently
such accesses can happen during memory hotremove because do_migrate_range()
can be called before dissolve_free_huge_pages() is called.

Clear HPageMigratable for hwpoisoned hugepages to prevent them from being
migrated.  This should be done in hugetlb_lock to avoid race against
isolate_hugetlb().

get_hwpoison_huge_page() needs to have a flag to show it's called from
unpoison to take refcount of hwpoisoned hugepages, so add it.

Reported-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
ChangeLog v3 -> v7:
- introduce TESTCLEARHPAGEFLAG() to determine the value of migratable_cleared

ChangeLog v3 -> v6:
- introduce migratable_cleared to remember that HPageMigratable is
  cleared in error handling.  It's needed to cancel when an error event
  is filtered by hwpoison_filter(). (Thanks to Miaohe)

ChangeLog v2 -> v3
- move to the approach of clearing HPageMigratable instead of shifting
  dissolve_free_huge_pages.
---
 include/linux/hugetlb.h | 19 +++++++++++++++----
 include/linux/mm.h      |  6 ++++--
 mm/hugetlb.c            |  9 +++++----
 mm/memory-failure.c     | 19 +++++++++++++++----
 4 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index a899bc76d677..0d137dab42b6 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -183,8 +183,9 @@ bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
 int isolate_hugetlb(struct page *page, struct list_head *list);
-int get_hwpoison_huge_page(struct page *page, bool *hugetlb);
-int get_huge_page_for_hwpoison(unsigned long pfn, int flags);
+int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison);
+int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
+				bool *migratable_cleared);
 void putback_active_hugepage(struct page *page);
 void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int reason);
 void free_huge_page(struct page *page);
@@ -391,12 +392,13 @@ static inline int isolate_hugetlb(struct page *page, struct list_head *list)
 	return -EBUSY;
 }
 
-static inline int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
+static inline int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison)
 {
 	return 0;
 }
 
-static inline int get_huge_page_for_hwpoison(unsigned long pfn, int flags)
+static inline int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
+					bool *migratable_cleared)
 {
 	return 0;
 }
@@ -614,6 +616,10 @@ void folio_clear_hugetlb_##flname(struct folio *folio)		\
 	}							\
 static inline void ClearHPage##uname(struct page *page)		\
 	{ clear_bit(HPG_##flname, &(page->private)); }
+
+#define TESTCLEARHPAGEFLAG(uname, flname)			\
+static inline int TestClearHPage##uname(struct page *page)	\
+	{ return test_and_clear_bit(HPG_##flname, &(page->private)); }
 #else
 #define TESTHPAGEFLAG(uname, flname)				\
 static inline bool						\
@@ -635,6 +641,10 @@ folio_clear_hugetlb_##flname(struct folio *folio)		\
 	{ }							\
 static inline void ClearHPage##uname(struct page *page)		\
 	{ }
+
+#define TESTCLEARHPAGEFLAG(uname, flname)			\
+static inline int TestClearHPage##uname(struct page *page)	\
+	{ return 0; }
 #endif
 
 #define HPAGEFLAG(uname, flname)				\
@@ -647,6 +657,7 @@ static inline void ClearHPage##uname(struct page *page)		\
  */
 HPAGEFLAG(RestoreReserve, restore_reserve)
 HPAGEFLAG(Migratable, migratable)
+	TESTCLEARHPAGEFLAG(Migratable, migratable)
 HPAGEFLAG(Temporary, temporary)
 HPAGEFLAG(Freed, freed)
 HPAGEFLAG(VmemmapOptimized, vmemmap_optimized)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 58345f06a2f4..3da6283c9d30 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3246,9 +3246,11 @@ extern void shake_page(struct page *p);
 extern atomic_long_t num_poisoned_pages __read_mostly;
 extern int soft_offline_page(unsigned long pfn, int flags);
 #ifdef CONFIG_MEMORY_FAILURE
-extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags);
+extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
+					bool *migratable_cleared);
 #else
-static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
+static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
+					bool *migratable_cleared)
 {
 	return 0;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 931789a8f734..88d2dc756822 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7292,7 +7292,7 @@ int isolate_hugetlb(struct page *page, struct list_head *list)
 	return ret;
 }
 
-int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
+int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison)
 {
 	int ret = 0;
 
@@ -7302,7 +7302,7 @@ int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
 		*hugetlb = true;
 		if (HPageFreed(page))
 			ret = 0;
-		else if (HPageMigratable(page))
+		else if (HPageMigratable(page) || unpoison)
 			ret = get_page_unless_zero(page);
 		else
 			ret = -EBUSY;
@@ -7311,12 +7311,13 @@ int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
 	return ret;
 }
 
-int get_huge_page_for_hwpoison(unsigned long pfn, int flags)
+int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
+				bool *migratable_cleared)
 {
 	int ret;
 
 	spin_lock_irq(&hugetlb_lock);
-	ret = __get_huge_page_for_hwpoison(pfn, flags);
+	ret = __get_huge_page_for_hwpoison(pfn, flags, migratable_cleared);
 	spin_unlock_irq(&hugetlb_lock);
 	return ret;
 }
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 62cf1e0fbc8e..31589f2f5f07 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1250,7 +1250,7 @@ static int __get_hwpoison_page(struct page *page, unsigned long flags)
 	int ret = 0;
 	bool hugetlb = false;
 
-	ret = get_hwpoison_huge_page(head, &hugetlb);
+	ret = get_hwpoison_huge_page(head, &hugetlb, false);
 	if (hugetlb)
 		return ret;
 
@@ -1340,7 +1340,7 @@ static int __get_unpoison_page(struct page *page)
 	int ret = 0;
 	bool hugetlb = false;
 
-	ret = get_hwpoison_huge_page(head, &hugetlb);
+	ret = get_hwpoison_huge_page(head, &hugetlb, true);
 	if (hugetlb)
 		return ret;
 
@@ -1791,7 +1791,8 @@ void hugetlb_clear_page_hwpoison(struct page *hpage)
  *   -EBUSY        - the hugepage is busy (try to retry)
  *   -EHWPOISON    - the hugepage is already hwpoisoned
  */
-int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
+int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
+				 bool *migratable_cleared)
 {
 	struct page *page = pfn_to_page(pfn);
 	struct page *head = compound_head(page);
@@ -1821,6 +1822,13 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
 		goto out;
 	}
 
+	/*
+	 * Clearing HPageMigratable for hwpoisoned hugepages to prevent them
+	 * from being migrated by memory hotremove.
+	 */
+	if (count_increased)
+		*migratable_cleared = TestClearHPageMigratable(head);
+
 	return ret;
 out:
 	if (count_increased)
@@ -1840,10 +1848,11 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 	struct page *p = pfn_to_page(pfn);
 	struct page *head;
 	unsigned long page_flags;
+	bool migratable_cleared = false;
 
 	*hugetlb = 1;
 retry:
-	res = get_huge_page_for_hwpoison(pfn, flags);
+	res = get_huge_page_for_hwpoison(pfn, flags, &migratable_cleared);
 	if (res == 2) { /* fallback to normal page handling */
 		*hugetlb = 0;
 		return 0;
@@ -1867,6 +1876,8 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 
 	if (hwpoison_filter(p)) {
 		hugetlb_clear_page_hwpoison(head);
+		if (migratable_cleared)
+			SetHPageMigratable(head);
 		unlock_page(head);
 		if (res == 1)
 			put_page(head);
-- 
2.25.1

