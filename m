Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B723E607C7C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiJUQjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiJUQid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:38:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB3C2892E7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h4-20020a5b02c4000000b006bc192d672bso3734405ybp.22
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ei7k3uU35Z4Hu/w/xkPODXeMU6eNvsuQ55K19eUxLMI=;
        b=huKMsf08tu+ikIVOCPqBNwFsJXqNyp0P8NACcPr/sumx9YmFpNoCw7wMEhSlSL8pMP
         nSAMHrcN+7UfC0DL5d1quDTLv1jC014OC18xm+ftOJsMlX86PO+FJJI4RqcxlQb7hajv
         PzQFgZUu5gOec6xHS10xWWeea1IDWG2Utvm0kWwRv/uh6n7cEEBs0u+ueLl/S4oJE+Vy
         nDwZQusgJIjBbOwa/l5QxjrgNgvpToknRIkLb2dQOitFidH8U4mZMupmnTOexm99hkrz
         z0sYqYb8B3PDqwJp6QYPOzSeMKhGJlKRatwIHEblCaYbrb8BMhBjB2tWxOLSppUpCrob
         tTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ei7k3uU35Z4Hu/w/xkPODXeMU6eNvsuQ55K19eUxLMI=;
        b=1bQgREnWO0T731JmYARbFzFi58laCGy+ZOBHNylWXqhdBGUdbF/v6A0OR3XFL8OvBg
         xi2VE8TU57UqAYsZpX3E0NBZAbQuQaQP0xcsO7jkkOzrUJC5zPhjhc3qyQ+elfmclS+2
         REv7ymRE5T3gtknDnvTTtwlvGwN0R0To6JDQyCsH4LUpDcyXbS7D7o5M97u6RojDvbdD
         n7tLlQ0/EtKIkPWB2xLaQ1+vKA0v+Uj5+q/3v5wMJ5ucGvdomwhIBonDw/yolKD64TAl
         vIEP3UbFvaKqAGbfM8RvhL/E4gQszKjLWmn1Foeg26ET4I1ua1C4NlQJfo7hIsOKOJgK
         fojA==
X-Gm-Message-State: ACrzQf2BFoGoVhNSy+lx/VGm5IHNlbJOV65PvOvsYsH62VqkkofLga0k
        7G5WnN88jjdRFw6eVXnyy3G694Mf2f0qd0BO
X-Google-Smtp-Source: AMsMyM7zI9mXFO3X8vPctlBiB3UBLdTU3cbMoRvzP0AM4QwHltXjTzo1HEhNiplbJ7IWD/KkV3s28fi8e7mc0/0l
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:15c4:0:b0:6bd:4d9c:a3bc with SMTP
 id 187-20020a2515c4000000b006bd4d9ca3bcmr18149514ybv.211.1666370262380; Fri,
 21 Oct 2022 09:37:42 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:44 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-29-jthoughton@google.com>
Subject: [RFC PATCH v2 28/47] rmap: in try_to_{migrate,unmap}_one, check head
 page for page flags
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
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
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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

The main complication here is that HugeTLB pages have their poison
status stored in the head page as the HWPoison page flag. Because
HugeTLB high-granularity mapping can create PTEs that point to subpages
instead of always the head of a hugepage, we need to check the
compound_head for page flags.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/rmap.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index a8359584467e..d5e1eb6b8ce5 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1474,10 +1474,11 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
 	pte_t pteval;
-	struct page *subpage;
+	struct page *subpage, *page_flags_page;
 	bool anon_exclusive, ret = true;
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
+	bool page_poisoned;
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
@@ -1530,9 +1531,17 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 
 		subpage = folio_page(folio,
 					pte_pfn(*pvmw.pte) - folio_pfn(folio));
+		/*
+		 * We check the page flags of HugeTLB pages by checking the
+		 * head page.
+		 */
+		page_flags_page = folio_test_hugetlb(folio)
+			? &folio->page
+			: subpage;
+		page_poisoned = PageHWPoison(page_flags_page);
 		address = pvmw.address;
 		anon_exclusive = folio_test_anon(folio) &&
-				 PageAnonExclusive(subpage);
+				 PageAnonExclusive(page_flags_page);
 
 		if (folio_test_hugetlb(folio)) {
 			bool anon = folio_test_anon(folio);
@@ -1541,7 +1550,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 * The try_to_unmap() is only passed a hugetlb page
 			 * in the case where the hugetlb page is poisoned.
 			 */
-			VM_BUG_ON_PAGE(!PageHWPoison(subpage), subpage);
+			VM_BUG_ON_FOLIO(!page_poisoned, folio);
 			/*
 			 * huge_pmd_unshare may unmap an entire PMD page.
 			 * There is no way of knowing exactly which PMDs may
@@ -1630,7 +1639,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		/* Update high watermark before we lower rss */
 		update_hiwater_rss(mm);
 
-		if (PageHWPoison(subpage) && !(flags & TTU_IGNORE_HWPOISON)) {
+		if (page_poisoned && !(flags & TTU_IGNORE_HWPOISON)) {
 			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
 			if (folio_test_hugetlb(folio)) {
 				hugetlb_count_sub(1UL << pvmw.pte_order, mm);
@@ -1656,7 +1665,9 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			mmu_notifier_invalidate_range(mm, address,
 						      address + PAGE_SIZE);
 		} else if (folio_test_anon(folio)) {
-			swp_entry_t entry = { .val = page_private(subpage) };
+			swp_entry_t entry = {
+				.val = page_private(page_flags_page)
+			};
 			pte_t swp_pte;
 			/*
 			 * Store the swap location in the pte.
@@ -1855,7 +1866,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
 	pte_t pteval;
-	struct page *subpage;
+	struct page *subpage, *page_flags_page;
 	bool anon_exclusive, ret = true;
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
@@ -1935,9 +1946,16 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			subpage = folio_page(folio,
 					pte_pfn(*pvmw.pte) - folio_pfn(folio));
 		}
+		/*
+		 * We check the page flags of HugeTLB pages by checking the
+		 * head page.
+		 */
+		page_flags_page = folio_test_hugetlb(folio)
+			? &folio->page
+			: subpage;
 		address = pvmw.address;
 		anon_exclusive = folio_test_anon(folio) &&
-				 PageAnonExclusive(subpage);
+				 PageAnonExclusive(page_flags_page);
 
 		if (folio_test_hugetlb(folio)) {
 			bool anon = folio_test_anon(folio);
@@ -2048,7 +2066,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			 * No need to invalidate here it will synchronize on
 			 * against the special swap migration pte.
 			 */
-		} else if (PageHWPoison(subpage)) {
+		} else if (PageHWPoison(page_flags_page)) {
 			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
 			if (folio_test_hugetlb(folio)) {
 				hugetlb_count_sub(1L << pvmw.pte_order, mm);
-- 
2.38.0.135.g90850a2211-goog

