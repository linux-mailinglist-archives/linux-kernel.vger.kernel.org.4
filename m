Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E3169B6C9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjBRAbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjBRAaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:30:06 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003196929B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:20 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id o14-20020a25810e000000b0095d2ada3d26so1817181ybk.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1rCBHumdufOlTcJkqiypODYa1r7LDyl4S1gdc35TorQ=;
        b=YN0PytyiHYPIu8m+M2E6v1NUQCnHXY6ytZcGKXyuh7z/uqk1m7+gCvJsZq1js1+Nyk
         aWy2chcaY0oSjM7oplmnZTRau4yrS7eatEn1k9ey5wfeHKB+fHXyH3hpyjtsmTvEZjCC
         943Dvm4iECKIUtQU6bNEzs0C/hZeHT7vfxnkuu/ImNucvgQ6NZzZ5BLuTjeDWoY/lNEN
         mppTbWX+d43SPhJRbQNNU06lgt5y4Yc251XxwreuYdKf65ASB8UzsacjLW/LKF5eAHUL
         AdfT5Xxv2SVRLajtE01G0LVCPjbrRrRShVjKlJ9kluNRT6aaGpxY/8iNFGTbZhsxLO7k
         +hCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1rCBHumdufOlTcJkqiypODYa1r7LDyl4S1gdc35TorQ=;
        b=tXI3GDKuAYV5c8vxt6CnXuPv00N1WYMT8XD3DkCRZN3GOwnMBNb4gaujSAVI221c3C
         LrigrvZL4+pNNPEKw+64zYUUzY0Wd2wIJUMk6C6/rKosX+iVm9BRjPKbuWJtezui38Jj
         vZ7N0sWQREXyag4g2ueTXWkJR05fWdVGFGdDoGeb3i9Vjd8K4kEeMH24tLekgLfWNzCs
         HtFEvPg2jWYIGKoSk9LSBUnXjesrbDxlE5XhLLks1CAvlVPpXvhUL9qpqGqNHLBKPbRx
         xEyyxpAdpfy5Ky6QecdhWXPzP+U/Bp4yFnAl2ulCfpHGwIXJxy8+GuetQbZWdRswH1uz
         ejPQ==
X-Gm-Message-State: AO0yUKU32frAzHvZmGcJDye2BFA7PPVKEJOjfu/bksooCdVU71E7ucOl
        P1RdK95QkAC2fy9sdIity/VYNSWV/kA4TPh/
X-Google-Smtp-Source: AK7set+LO+JnPnboVPieFkXX7WpathP3qjh8yyUr3ixLzVkV8bA9em/CG8b88d9+skAi+Y+zl4Jc6Pv1vnp/FebD
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a5b:910:0:b0:927:a3c1:b2de with SMTP id
 a16-20020a5b0910000000b00927a3c1b2demr200123ybq.7.1676680151721; Fri, 17 Feb
 2023 16:29:11 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:28:01 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-29-jthoughton@google.com>
Subject: [PATCH v2 28/46] mm: rmap: in try_to_{migrate,unmap}, check head page
 for hugetlb page flags
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
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
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
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

diff --git a/mm/rmap.c b/mm/rmap.c
index 0a019ae32f04..4908ede83173 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1456,10 +1456,11 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
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
@@ -1512,9 +1513,17 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 
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
@@ -1523,7 +1532,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 * The try_to_unmap() is only passed a hugetlb page
 			 * in the case where the hugetlb page is poisoned.
 			 */
-			VM_BUG_ON_PAGE(!PageHWPoison(subpage), subpage);
+			VM_BUG_ON_FOLIO(!page_poisoned, folio);
 			/*
 			 * huge_pmd_unshare may unmap an entire PMD page.
 			 * There is no way of knowing exactly which PMDs may
@@ -1606,7 +1615,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		/* Update high watermark before we lower rss */
 		update_hiwater_rss(mm);
 
-		if (PageHWPoison(subpage) && !(flags & TTU_IGNORE_HWPOISON)) {
+		if (page_poisoned && !(flags & TTU_IGNORE_HWPOISON)) {
 			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
 			if (folio_test_hugetlb(folio)) {
 				hugetlb_count_sub(1UL << pvmw.pte_order, mm);
@@ -1632,7 +1641,9 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
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
@@ -1822,7 +1833,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
 	pte_t pteval;
-	struct page *subpage;
+	struct page *subpage, *page_flags_page;
 	bool anon_exclusive, ret = true;
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
@@ -1902,9 +1913,16 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
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
@@ -2023,7 +2041,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			 * No need to invalidate here it will synchronize on
 			 * against the special swap migration pte.
 			 */
-		} else if (PageHWPoison(subpage)) {
+		} else if (PageHWPoison(page_flags_page)) {
 			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
 			if (folio_test_hugetlb(folio)) {
 				hugetlb_count_sub(1L << pvmw.pte_order, mm);
-- 
2.39.2.637.g21b0678d19-goog

