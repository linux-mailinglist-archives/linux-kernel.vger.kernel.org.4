Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EB55F7279
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 03:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiJGBIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 21:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiJGBIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 21:08:18 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA101429A8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 18:08:12 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665104890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ji70CGNKgBen+y2EQBhMb8FWPoRE6+YO0lCc0ItVfP0=;
        b=A31FTVAslzp7THxtC3baRaiJqxfjXnW45AnrtWfRIW4Iz7H0yYYxsa2H6MmuOWANaHxU2A
        0fd0LUsTqUax269N+Le1X2OLe0KyqFG38qFrl/XSIasuRyTUDiQ4XKuwkAlNEO0SsIkiwc
        mIPnXzEVhztgmLSfi5r2fXx1BHOpVtQ=
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
Subject: [PATCH v6 3/4] mm/hwpoison: pass pfn to num_poisoned_pages_*()
Date:   Fri,  7 Oct 2022 10:07:05 +0900
Message-Id: <20221007010706.2916472-4-naoya.horiguchi@linux.dev>
In-Reply-To: <20221007010706.2916472-1-naoya.horiguchi@linux.dev>
References: <20221007010706.2916472-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

No functional change.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
ChangeLog v2 -> v3:
- added declaration of num_poisoned_pages_inc() in #ifdef CONFIG_MEMORY_FAILURE
---
 arch/parisc/kernel/pdt.c |  2 +-
 include/linux/mm.h       |  4 ++--
 mm/memory-failure.c      | 14 +++++++-------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/parisc/kernel/pdt.c b/arch/parisc/kernel/pdt.c
index fdc880e2575a..80943a00e245 100644
--- a/arch/parisc/kernel/pdt.c
+++ b/arch/parisc/kernel/pdt.c
@@ -231,7 +231,7 @@ void __init pdc_pdt_init(void)
 
 		/* mark memory page bad */
 		memblock_reserve(pdt_entry[i] & PAGE_MASK, PAGE_SIZE);
-		num_poisoned_pages_inc();
+		num_poisoned_pages_inc(addr >> PAGE_SHIFT);
 	}
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 782ab29bb1fb..17119dbf8fad 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3279,7 +3279,7 @@ extern int soft_offline_page(unsigned long pfn, int flags);
 #ifdef CONFIG_MEMORY_FAILURE
 extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 					bool *migratable_cleared);
-extern void num_poisoned_pages_inc(void);
+extern void num_poisoned_pages_inc(unsigned long pfn);
 #else
 static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 					bool *migratable_cleared)
@@ -3287,7 +3287,7 @@ static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 	return 0;
 }
 
-static inline void num_poisoned_pages_inc(void)
+static inline void num_poisoned_pages_inc(unsigned long pfn)
 {
 }
 #endif
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 323e0a21833f..c19a301f16fc 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -74,12 +74,12 @@ atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
 static bool hw_memory_failure __read_mostly = false;
 
-inline void num_poisoned_pages_inc(void)
+inline void num_poisoned_pages_inc(unsigned long pfn)
 {
 	atomic_long_inc(&num_poisoned_pages);
 }
 
-static inline void num_poisoned_pages_sub(long i)
+static inline void num_poisoned_pages_sub(unsigned long pfn, long i)
 {
 	atomic_long_sub(i, &num_poisoned_pages);
 }
@@ -125,7 +125,7 @@ static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, boo
 	if (release)
 		put_page(page);
 	page_ref_inc(page);
-	num_poisoned_pages_inc();
+	num_poisoned_pages_inc(page_to_pfn(page));
 
 	return true;
 }
@@ -1194,7 +1194,7 @@ static void action_result(unsigned long pfn, enum mf_action_page_type type,
 {
 	trace_memory_failure_event(pfn, type, result);
 
-	num_poisoned_pages_inc();
+	num_poisoned_pages_inc(pfn);
 	pr_err("%#lx: recovery action for %s: %s\n",
 		pfn, action_page_types[type], action_name[result]);
 }
@@ -1741,7 +1741,7 @@ static int hugetlb_set_page_hwpoison(struct page *hpage, struct page *page)
 		llist_add(&raw_hwp->node, head);
 		/* the first error event will be counted in action_result(). */
 		if (ret)
-			num_poisoned_pages_inc();
+			num_poisoned_pages_inc(page_to_pfn(page));
 	} else {
 		/*
 		 * Failed to save raw error info.  We no longer trace all
@@ -2419,7 +2419,7 @@ int unpoison_memory(unsigned long pfn)
 unlock_mutex:
 	mutex_unlock(&mf_mutex);
 	if (!ret || freeit) {
-		num_poisoned_pages_sub(count);
+		num_poisoned_pages_sub(pfn, count);
 		unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
 				 page_to_pfn(p), &unpoison_rs);
 	}
@@ -2643,5 +2643,5 @@ void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
 		}
 	}
 	if (total)
-		num_poisoned_pages_sub(total);
+		num_poisoned_pages_sub(0, total);
 }
-- 
2.25.1

