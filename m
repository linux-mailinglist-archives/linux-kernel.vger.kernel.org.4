Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5655BFA8F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiIUJQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiIUJQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:16:28 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2C28E4CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:16:05 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663751755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NAK+OfD9y76Qeqp8V3ZaY9yJ/ZmnLYVYzxQlX59hfUo=;
        b=EqXp6eVohBUwOJlfQsMX5CatWXvACPoYJVgieu9JfuooBH3wIc3sxKU+WaOakYWcn31BXW
        WV1maFBKpk56Y32dSraaK8ei7ZeeM8DqxYPPz1mX2pNW4EAoBDmHl3VUIIOlOuEVoKnxjP
        dJWZzMHdVs2RjqoKtspztq7WIiwdTGM=
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
Subject: [PATCH v3 1/4] mm,hwpoison,hugetlb,memory_hotplug: hotremove memory section with hwpoisoned hugepage
Date:   Wed, 21 Sep 2022 18:13:56 +0900
Message-Id: <20220921091359.25889-2-naoya.horiguchi@linux.dev>
In-Reply-To: <20220921091359.25889-1-naoya.horiguchi@linux.dev>
References: <20220921091359.25889-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
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
---
ChangeLog v2 -> v3
- move to the approach of clearing HPageMigratable instead of shifting
  dissolve_free_huge_pages.
---
 include/linux/hugetlb.h |  4 ++--
 mm/hugetlb.c            |  4 ++--
 mm/memory-failure.c     | 12 ++++++++++--
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index cfe15b32e2d4..18229402c6d7 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -181,7 +181,7 @@ bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
 int isolate_hugetlb(struct page *page, struct list_head *list);
-int get_hwpoison_huge_page(struct page *page, bool *hugetlb);
+int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison);
 int get_huge_page_for_hwpoison(unsigned long pfn, int flags);
 void putback_active_hugepage(struct page *page);
 void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason);
@@ -425,7 +425,7 @@ static inline int isolate_hugetlb(struct page *page, struct list_head *list)
 	return -EBUSY;
 }
 
-static inline int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
+static inline int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison)
 {
 	return 0;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8bcaf66defc5..d3b83c570b56 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7257,7 +7257,7 @@ int isolate_hugetlb(struct page *page, struct list_head *list)
 	return ret;
 }
 
-int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
+int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison)
 {
 	int ret = 0;
 
@@ -7267,7 +7267,7 @@ int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
 		*hugetlb = true;
 		if (HPageFreed(page))
 			ret = 0;
-		else if (HPageMigratable(page))
+		else if (HPageMigratable(page) || unpoison)
 			ret = get_page_unless_zero(page);
 		else
 			ret = -EBUSY;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 145bb561ddb3..5942e1c0407e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1244,7 +1244,7 @@ static int __get_hwpoison_page(struct page *page, unsigned long flags)
 	int ret = 0;
 	bool hugetlb = false;
 
-	ret = get_hwpoison_huge_page(head, &hugetlb);
+	ret = get_hwpoison_huge_page(head, &hugetlb, false);
 	if (hugetlb)
 		return ret;
 
@@ -1334,7 +1334,7 @@ static int __get_unpoison_page(struct page *page)
 	int ret = 0;
 	bool hugetlb = false;
 
-	ret = get_hwpoison_huge_page(head, &hugetlb);
+	ret = get_hwpoison_huge_page(head, &hugetlb, true);
 	if (hugetlb)
 		return ret;
 
@@ -1815,6 +1815,13 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
 		goto out;
 	}
 
+	/*
+	 * Clearing HPageMigratable for hwpoisoned hugepages to prevent them
+	 * from being migrated by memory hotremove.
+	 */
+	if (count_increased)
+		ClearHPageMigratable(head);
+
 	return ret;
 out:
 	if (count_increased)
@@ -1862,6 +1869,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 
 	if (hwpoison_filter(p)) {
 		hugetlb_clear_page_hwpoison(head);
+		SetHPageMigratable(head);
 		unlock_page(head);
 		if (res == 1)
 			put_page(head);
-- 
2.25.1

