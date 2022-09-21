Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4765E564D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 00:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiIUWhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 18:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiIUWhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 18:37:24 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BCCA8945
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 15:37:20 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id b23so5146672qtr.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 15:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WraM5AHrdGzNrVxYvq6E83xWiBcfqvWRynzaGQZpK+g=;
        b=PnTvaZrgzYl3A2zQXVHwCw9cXtSjz0IogQa6jGd78pmS8IycFfAtj41+CxxekNv5fz
         kuvppT0H+KuDkkMNqV8LQ95t3WDGOEE3eo0BxBPXBVwMEMdi+LDGq26Ir9GgHzCIGXJe
         wJIpLMQQcCYh9MAHP/GjpezCFX2ASWnTn/xG7CipnzEwQA8CIpcidkSKxS6wO4Q/pNsu
         wP9V0FO0IdH0eaI7hieeh96daJY5/ByFwjIanj8gX+tgpaCUpCJLg09vQMEwHfHHY1jk
         G7vGR2Yv0T4hHGeTnjsx4rz30v/KPEHXAxjqbuk7dMJlw+RXie6FGHIeCoLcGZkxKyBI
         eHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WraM5AHrdGzNrVxYvq6E83xWiBcfqvWRynzaGQZpK+g=;
        b=zKXMOt0bJ02fsN9nmYcV/JjYi251P/DSJY2vuH419EVMNCOBgchIEVkJE//kh570tL
         Mc6+uNsuH5TJIocoKlgQisPJSgYRFoYyMWEgHFT1g8LD8aho9t8fwC6TWPqdvJdm6RuU
         mWdSg4twGtyKbhq81aCUuyOVMYyQG3OTDBg5ALY7XYq5sKi2vWwGCMWN7tRH+kCDHpoB
         vDz7pG0mMHZ7dBIArc5z3Dmis9+S87jEcTFf8jJmsgytiFFDDnD5oUL4m+S0I2PwFPRi
         q92lBtYsitXgXsUeQL0wsvgb8eqMU7LcGn/XJIbWIk3Y60m7F6unu9KQ9tyJs9ClmrQS
         ExxA==
X-Gm-Message-State: ACrzQf3Xuzn3YGTZjWkeuXG+GGakBhP/wEqUe59B8iJIGHVM04d7TK58
        GvcNlqTCzwFOekIcyZdJF0E=
X-Google-Smtp-Source: AMsMyM73KuFt2vBnW+YpQZEA07l1sWlH98yMGHcP8J/1ai2vHwUIB0wwniLwB+can+pH+2j+VRjYNQ==
X-Received: by 2002:a05:622a:1391:b0:35d:fb0:d830 with SMTP id o17-20020a05622a139100b0035d0fb0d830mr497328qtk.607.1663799839911;
        Wed, 21 Sep 2022 15:37:19 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j13-20020a05620a288d00b006cea2984c9bsm2731540qkp.100.2022.09.21.15.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:37:19 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Florian Fainelli <f.fainelli@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH 2/3] mm/hugetlb: allow migrated hugepage to dissolve when freed
Date:   Wed, 21 Sep 2022 15:36:38 -0700
Message-Id: <20220921223639.1152392-3-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921223639.1152392-1-opendmb@gmail.com>
References: <20220921223639.1152392-1-opendmb@gmail.com>
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

There is no isolation mechanism for hugepages so a hugepage that
is migrated is returned to its hugepage freelist. This creates
problems for alloc_contig_range() because migrated hugepages can
be allocated as migrate targets for subsequent hugepage migration
attempts.

Even if the migration succeeds the alloc_contig_range() attempt
will fail because test_pages_isolated() will find the now free
hugepages haven't been dissolved.

A subsequent attempt by alloc_contig_range() is necessary for the
isolate_migratepages_range() function to find the freed hugepage
and dissolve it (assuming it has not been reallocated).

A workqueue is introduced to perform the equivalent functionality
of alloc_and_dissolve_huge_page() for a migrated hugepage when it
is freed so that the pages can be released to the isolated page
lists of the buddy allocator allowing the alloc_contig_range()
attempt to succeed.

The HPG_dissolve hugepage flag is introduced to allow tagging
migratable hugepages that should be dissolved when freed.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 include/linux/hugetlb.h |  5 +++
 mm/hugetlb.c            | 72 ++++++++++++++++++++++++++++++++++++++---
 mm/migrate.c            |  1 +
 mm/page_alloc.c         |  1 +
 4 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3ec981a0d8b3..0e6e21805e51 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -222,6 +222,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 
 bool is_hugetlb_entry_migration(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
+void sync_hugetlb_dissolve(void);
 
 #else /* !CONFIG_HUGETLB_PAGE */
 
@@ -430,6 +431,8 @@ static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
 
 static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma) { }
 
+static inline void sync_hugetlb_dissolve(void) { }
+
 #endif /* !CONFIG_HUGETLB_PAGE */
 /*
  * hugepages at page global directory. If arch support
@@ -574,6 +577,7 @@ enum hugetlb_page_flags {
 	HPG_freed,
 	HPG_vmemmap_optimized,
 	HPG_raw_hwp_unreliable,
+	HPG_dissolve,
 	__NR_HPAGEFLAGS,
 };
 
@@ -621,6 +625,7 @@ HPAGEFLAG(Temporary, temporary)
 HPAGEFLAG(Freed, freed)
 HPAGEFLAG(VmemmapOptimized, vmemmap_optimized)
 HPAGEFLAG(RawHwpUnreliable, raw_hwp_unreliable)
+HPAGEFLAG(Dissolve, dissolve)
 
 #ifdef CONFIG_HUGETLB_PAGE
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2b60de78007c..eab812760fbe 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1582,6 +1582,10 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	}
 }
 
+static LLIST_HEAD(hpage_dissolvelist);
+static void dissolve_hpage_workfn(struct work_struct *work);
+static DECLARE_WORK(dissolve_hpage_work, dissolve_hpage_workfn);
+
 /*
  * As update_and_free_page() can be called under any context, so we cannot
  * use GFP_KERNEL to allocate vmemmap pages. However, we can defer the
@@ -1628,6 +1632,8 @@ static inline void flush_free_hpage_work(struct hstate *h)
 {
 	if (hugetlb_vmemmap_optimizable(h))
 		flush_work(&free_hpage_work);
+	if (!hstate_is_gigantic(h))
+		flush_work(&dissolve_hpage_work);
 }
 
 static void update_and_free_page(struct hstate *h, struct page *page,
@@ -1679,7 +1685,7 @@ void free_huge_page(struct page *page)
 	struct hstate *h = page_hstate(page);
 	int nid = page_to_nid(page);
 	struct hugepage_subpool *spool = hugetlb_page_subpool(page);
-	bool restore_reserve;
+	bool restore_reserve, dissolve;
 	unsigned long flags;
 
 	VM_BUG_ON_PAGE(page_count(page), page);
@@ -1691,6 +1697,8 @@ void free_huge_page(struct page *page)
 	page->mapping = NULL;
 	restore_reserve = HPageRestoreReserve(page);
 	ClearHPageRestoreReserve(page);
+	dissolve = HPageDissolve(page);
+	ClearHPageDissolve(page);
 
 	/*
 	 * If HPageRestoreReserve was set on page, page allocation consumed a
@@ -1729,6 +1737,11 @@ void free_huge_page(struct page *page)
 		remove_hugetlb_page(h, page, true);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		update_and_free_page(h, page, true);
+	} else if (dissolve) {
+		spin_unlock_irqrestore(&hugetlb_lock, flags);
+		if (llist_add((struct llist_node *)&page->mapping,
+			      &hpage_dissolvelist))
+			schedule_work(&dissolve_hpage_work);
 	} else {
 		arch_clear_hugepage_flags(page);
 		enqueue_huge_page(h, page);
@@ -2771,6 +2784,49 @@ static void replace_hugepage(struct hstate *h, int nid, struct page *old_page,
 	enqueue_huge_page(h, new_page);
 }
 
+static void dissolve_hpage_workfn(struct work_struct *work)
+{
+	struct llist_node *node;
+
+	node = llist_del_all(&hpage_dissolvelist);
+
+	while (node) {
+		struct page *oldpage, *newpage;
+		struct hstate *h;
+		int nid;
+
+		oldpage = container_of((struct address_space **)node,
+				       struct page, mapping);
+		node = node->next;
+		oldpage->mapping = NULL;
+
+		h = page_hstate(oldpage);
+		nid = page_to_nid(oldpage);
+
+		newpage = alloc_replacement_page(h, nid);
+
+		spin_lock_irq(&hugetlb_lock);
+		/* finish freeing oldpage */
+		arch_clear_hugepage_flags(oldpage);
+		enqueue_huge_page(h, oldpage);
+		if (IS_ERR(newpage)) {
+			/* cannot dissolve so just leave free */
+			spin_unlock_irq(&hugetlb_lock);
+			goto next;
+		}
+
+		replace_hugepage(h, nid, oldpage, newpage);
+
+		/*
+		 * Pages have been replaced, we can safely free the old one.
+		 */
+		spin_unlock_irq(&hugetlb_lock);
+		__update_and_free_page(h, oldpage);
+next:
+		cond_resched();
+	}
+}
+
 /*
  * alloc_and_dissolve_huge_page - Allocate a new page and dissolve the old one
  * @h: struct hstate old page belongs to
@@ -2803,6 +2859,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		 */
 		spin_unlock_irq(&hugetlb_lock);
 		ret = isolate_hugetlb(old_page, list);
+		SetHPageDissolve(old_page);
 		spin_lock_irq(&hugetlb_lock);
 		goto free_new;
 	} else if (!HPageFreed(old_page)) {
@@ -2864,14 +2921,21 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 	if (hstate_is_gigantic(h))
 		return -ENOMEM;
 
-	if (page_count(head) && !isolate_hugetlb(head, list))
+	if (page_count(head) && !isolate_hugetlb(head, list)) {
+		SetHPageDissolve(head);
 		ret = 0;
-	else if (!page_count(head))
+	} else if (!page_count(head)) {
 		ret = alloc_and_dissolve_huge_page(h, head, list);
-
+	}
 	return ret;
 }
 
+void sync_hugetlb_dissolve(void)
+{
+	flush_work(&free_hpage_work);
+	flush_work(&dissolve_hpage_work);
+}
+
 struct page *alloc_huge_page(struct vm_area_struct *vma,
 				    unsigned long addr, int avoid_reserve)
 {
diff --git a/mm/migrate.c b/mm/migrate.c
index 6a1597c92261..b6c6123e614c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -141,6 +141,7 @@ void putback_movable_pages(struct list_head *l)
 
 	list_for_each_entry_safe(page, page2, l, lru) {
 		if (unlikely(PageHuge(page))) {
+			ClearHPageDissolve(page);
 			putback_active_hugepage(page);
 			continue;
 		}
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e5486d47406e..6bf76bbc0308 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9235,6 +9235,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	if (ret && ret != -EBUSY)
 		goto done;
 	ret = 0;
+	sync_hugetlb_dissolve();
 
 	/*
 	 * Pages from [start, end) are within a pageblock_nr_pages
-- 
2.25.1

