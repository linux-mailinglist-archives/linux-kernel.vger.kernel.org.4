Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE75260C355
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 07:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiJYFgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 01:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJYFgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 01:36:12 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DEFA99D6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 22:36:09 -0700 (PDT)
Date:   Tue, 25 Oct 2022 14:35:59 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666676167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lG01Ahpo4ENuldLEAS9Qh2m3uNUJs2/EyBGEGwc5EcI=;
        b=img6RSROb0vt8i38+T/353SRbYlB1u0iSa3fyoTyGc23o26DCxpdp6CFggFaevAKwlKQLL
        fqAYG/r8oqd0hAqXUGThMzYjl0C4PP4X6snl/TeyaZlpwCT0PxG99OmPgFprusKhWIEOko
        x7IVrJD7F6oge+OIsCCKpBZuWCLKQXk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/4] mm,hwpoison,hugetlb,memory_hotplug: hotremove memory
 section with hwpoisoned hugepage
Message-ID: <20221025053559.GA2104800@ik1-406-35019.vs.sakura.ne.jp>
References: <20221024062012.1520887-1-naoya.horiguchi@linux.dev>
 <20221024062012.1520887-2-naoya.horiguchi@linux.dev>
 <2484c6be-5075-2203-4f16-9cfdc4876e11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2484c6be-5075-2203-4f16-9cfdc4876e11@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 10:38:11AM +0800, Miaohe Lin wrote:
> On 2022/10/24 14:20, Naoya Horiguchi wrote:
> > From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > 
> > HWPoisoned page is not supposed to be accessed once marked, but currently
> > such accesses can happen during memory hotremove because do_migrate_range()
> > can be called before dissolve_free_huge_pages() is called.
> > 
> > Clear HPageMigratable for hwpoisoned hugepages to prevent them from being
> > migrated.  This should be done in hugetlb_lock to avoid race against
> > isolate_hugetlb().
> > 
> > get_hwpoison_huge_page() needs to have a flag to show it's called from
> > unpoison to take refcount of hwpoisoned hugepages, so add it.
> > 
> > Reported-by: Miaohe Lin <linmiaohe@huawei.com>
> > Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > Reviewed-by: Oscar Salvador <osalvador@suse.de>
> > Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> > ---
> > ChangeLog v3 -> v7:
> > - introduce TESTCLEARHPAGEFLAG() to determine the value of migratable_cleared
> 
> Many thanks for update, Naoya. I'm sorry but TestClearHPageMigratable() might be somewhat
> overkill. As we discussed in previous thread:
> 
> """
> I think I might be nitpicking... But it seems ClearHPageMigratable is not enough here.
>   1. In MF_COUNT_INCREASED case, we don't know whether HPageMigratable is set.
>   2. Even if HPageMigratable is set, there might be a race window before we clear HPageMigratable?
> So "*migratable_cleared = TestClearHPageMigratable" might be better? But I might be wrong.
> """
> 
> The case 2 should be a dumb problem(sorry about it). HPageMigratable() is always cleared while holding
> the hugetlb_lock which is already held by get_huge_page_for_hwpoison(). So the only case we should care
> about is case 1 and that can be handled by below more efficient pattern:
> 	if (HPageMigratable)
> 		ClearHPageMigratable()
> 
> So the overhead of test and clear atomic ops can be avoided. But this is trival.
> 
> Anyway, this patch still looks good to me. And my Reviewed-by tag still applies. Many thanks.

OK, so I replace this 1/4 with the following one, thank you.

- Naoya Horiguchi
---
From 22cbd7649d1e23db272306f8d066edb15d4e322c Mon Sep 17 00:00:00 2001
From: Naoya Horiguchi <naoya.horiguchi@nec.com>
Date: Tue, 25 Oct 2022 14:18:10 +0900
Subject: [PATCH v8 1/4] mm,hwpoison,hugetlb,memory_hotplug: hotremove memory section
 with hwpoisoned hugepage

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
ChangeLog v7 -> v8:
- remove TestClearHPageMigratable and reduce to test and clear separately.

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
 include/linux/hugetlb.h | 10 ++++++----
 include/linux/mm.h      |  6 ++++--
 mm/hugetlb.c            |  9 +++++----
 mm/memory-failure.c     | 21 +++++++++++++++++----
 4 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index a899bc76d677..3568b90b397d 100644
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
index 62cf1e0fbc8e..0ba7032be8c0 100644
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
@@ -1821,6 +1822,15 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
 		goto out;
 	}
 
+	/*
+	 * Clearing HPageMigratable for hwpoisoned hugepages to prevent them
+	 * from being migrated by memory hotremove.
+	 */
+	if (count_increased && HPageMigratable(head)) {
+		ClearHPageMigratable(head);
+		*migratable_cleared = true;
+	}
+
 	return ret;
 out:
 	if (count_increased)
@@ -1840,10 +1850,11 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
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
@@ -1867,6 +1878,8 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 
 	if (hwpoison_filter(p)) {
 		hugetlb_clear_page_hwpoison(head);
+		if (migratable_cleared)
+			SetHPageMigratable(head);
 		unlock_page(head);
 		if (res == 1)
 			put_page(head);
-- 
2.37.3.518.g79f2338b37


