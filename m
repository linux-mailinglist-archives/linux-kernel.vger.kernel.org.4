Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB9B69B6CA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBRA3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjBRA3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:29:19 -0500
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F3D6B303
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:58 -0800 (PST)
Received: by mail-ua1-x949.google.com with SMTP id f9-20020ab049c9000000b00419afefbe3eso547186uad.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6oe0JKndOCFJAJQ6FnTw91/ULLeb3XwnLhf6Mjl8ksE=;
        b=ZXgI9bmT7U5wLokZ0C4oNJ6Gk9RcbKcaK8gcoGLiwH9auXPSDVM0Ol5I8tJdiHkQBm
         cqJXsvHhpPo95w78Rkbk3SLZVdtOTUOQ5nztMCmY5/Ud5mRj3hFPJhvSI6benmg8rsXE
         zUOmpa69V6q/M9cjYkffaZNIdg3JvQ6rKjZMp6Dj0DYTIaXY+Lg7BLYbHF6CKnajEaK+
         wl2mnnELaLd/60dmFNDm2ghVntcF83+VBQ5Wv+xyP+zua7DC9xkWhlP06ETH3LjJnFLh
         bf40rMtbYVk0AxD73EzwULPcAUGoIp7bBDuosmnG4aaaqWZsAeWgTL7c1Q5nHavHsXWV
         bZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6oe0JKndOCFJAJQ6FnTw91/ULLeb3XwnLhf6Mjl8ksE=;
        b=xBdmixG4X0rO4cr/lK7de3N0pw0oRTCqyX1b98hzmfShRwMC5lWjNEO3xbkrtJ4vot
         FQdvFBd4WG77Sn23vFNkcbISjzmrIgZ1pYEmtz4EBNvVGXhqNi6aIMd07IinHm8a+T9z
         1c7BBbkid2J1JHxFNm48VCN+ZJRHtrF8M9WWVoDrvu5DSBVcnCAJ3kj/yQQQBZDnCUDk
         BQs4eA7CtEThoH5MSbeXaBz7k6Ko24mvi9XG7BnDSktQfsHxJgDzMOATZZp3v35jFZE0
         w/FDWFpAlECEKQocxVhKOKLiP7diNL8kKbScQxD9okSzuZ2zpUJ6Z4ARlDO71cEbLzgP
         Vhaw==
X-Gm-Message-State: AO0yUKXgbmeLzP5jgwVKl1N7fkjfS7rOGjMyj+OH3tmnX1Lofcj4eHPi
        NLdukANXts9C5m3yRHqKp4mFl3HBa9GwXPFA
X-Google-Smtp-Source: AK7set8EIO6lV9DKEYEv7Gocq2q4pnYUxsgcQQWqM5Ogw0BQTVEawiIrDCY/tG3VwGpwjeKgD8+npdD3lNuWqFdx
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a1f:9111:0:b0:409:92de:63bd with SMTP
 id t17-20020a1f9111000000b0040992de63bdmr110245vkd.12.1676680137159; Fri, 17
 Feb 2023 16:28:57 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:47 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-15-jthoughton@google.com>
Subject: [PATCH v2 14/46] hugetlb: split PTE markers when doing HGM walks
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

Fix how UFFDIO_CONTINUE and UFFDIO_WRITEPROTECT interact in these two
ways:
 - UFFDIO_WRITEPROTECT no longer prevents a high-granularity
   UFFDIO_CONTINUE.
 - UFFD-WP PTE markers installed with UFFDIO_WRITEPROTECT will be
   properly propagated when high-granularily UFFDIO_CONTINUEs are
   performed.

Note: UFFDIO_WRITEPROTECT is not yet permitted at PAGE_SIZE granularity.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 810c05feb41f..f74183acc521 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -506,6 +506,30 @@ static bool has_same_uncharge_info(struct file_region *rg,
 #endif
 }
 
+static void hugetlb_install_markers_pmd(pmd_t *pmdp, pte_marker marker)
+{
+	int i;
+
+	for (i = 0; i < PTRS_PER_PMD; ++i)
+		/*
+		 * WRITE_ONCE not needed because the pud hasn't been
+		 * installed yet.
+		 */
+		pmdp[i] = __pmd(pte_val(make_pte_marker(marker)));
+}
+
+static void hugetlb_install_markers_pte(pte_t *ptep, pte_marker marker)
+{
+	int i;
+
+	for (i = 0; i < PTRS_PER_PTE; ++i)
+		/*
+		 * WRITE_ONCE not needed because the pmd hasn't been
+		 * installed yet.
+		 */
+		ptep[i] = make_pte_marker(marker);
+}
+
 /*
  * hugetlb_alloc_pmd -- Allocate or find a PMD beneath a PUD-level hpte.
  *
@@ -528,23 +552,32 @@ pmd_t *hugetlb_alloc_pmd(struct mm_struct *mm, struct hugetlb_pte *hpte,
 	pmd_t *new;
 	pud_t *pudp;
 	pud_t pud;
+	bool is_marker;
+	pte_marker marker;
 
 	if (hpte->level != HUGETLB_LEVEL_PUD)
 		return ERR_PTR(-EINVAL);
 
 	pudp = (pud_t *)hpte->ptep;
 retry:
+	is_marker = false;
 	pud = READ_ONCE(*pudp);
 	if (likely(pud_present(pud)))
 		return unlikely(pud_leaf(pud))
 			? ERR_PTR(-EEXIST)
 			: pmd_offset(pudp, addr);
-	else if (!pud_none(pud))
+	else if (!pud_none(pud)) {
 		/*
-		 * Not present and not none means that a swap entry lives here,
-		 * and we can't get rid of it.
+		 * Not present and not none means that a swap entry lives here.
+		 * If it's a PTE marker, we can deal with it. If it's another
+		 * swap entry, we don't attempt to split it.
 		 */
-		return ERR_PTR(-EEXIST);
+		is_marker = is_pte_marker(__pte(pud_val(pud)));
+		if (!is_marker)
+			return ERR_PTR(-EEXIST);
+
+		marker = pte_marker_get(pte_to_swp_entry(__pte(pud_val(pud))));
+	}
 
 	new = pmd_alloc_one(mm, addr);
 	if (!new)
@@ -557,6 +590,13 @@ pmd_t *hugetlb_alloc_pmd(struct mm_struct *mm, struct hugetlb_pte *hpte,
 		goto retry;
 	}
 
+	/*
+	 * Install markers before PUD to avoid races with other
+	 * page tables walks.
+	 */
+	if (is_marker)
+		hugetlb_install_markers_pmd(new, marker);
+
 	mm_inc_nr_pmds(mm);
 	smp_wmb(); /* See comment in pmd_install() */
 	pud_populate(mm, pudp, new);
@@ -576,23 +616,32 @@ pte_t *hugetlb_alloc_pte(struct mm_struct *mm, struct hugetlb_pte *hpte,
 	pgtable_t new;
 	pmd_t *pmdp;
 	pmd_t pmd;
+	bool is_marker;
+	pte_marker marker;
 
 	if (hpte->level != HUGETLB_LEVEL_PMD)
 		return ERR_PTR(-EINVAL);
 
 	pmdp = (pmd_t *)hpte->ptep;
 retry:
+	is_marker = false;
 	pmd = READ_ONCE(*pmdp);
 	if (likely(pmd_present(pmd)))
 		return unlikely(pmd_leaf(pmd))
 			? ERR_PTR(-EEXIST)
 			: pte_offset_kernel(pmdp, addr);
-	else if (!pmd_none(pmd))
+	else if (!pmd_none(pmd)) {
 		/*
-		 * Not present and not none means that a swap entry lives here,
-		 * and we can't get rid of it.
+		 * Not present and not none means that a swap entry lives here.
+		 * If it's a PTE marker, we can deal with it. If it's another
+		 * swap entry, we don't attempt to split it.
 		 */
-		return ERR_PTR(-EEXIST);
+		is_marker = is_pte_marker(__pte(pmd_val(pmd)));
+		if (!is_marker)
+			return ERR_PTR(-EEXIST);
+
+		marker = pte_marker_get(pte_to_swp_entry(__pte(pmd_val(pmd))));
+	}
 
 	/*
 	 * With CONFIG_HIGHPTE, calling `pte_alloc_one` directly may result
@@ -613,6 +662,9 @@ pte_t *hugetlb_alloc_pte(struct mm_struct *mm, struct hugetlb_pte *hpte,
 		goto retry;
 	}
 
+	if (is_marker)
+		hugetlb_install_markers_pte(page_address(new), marker);
+
 	mm_inc_nr_ptes(mm);
 	smp_wmb(); /* See comment in pmd_install() */
 	pmd_populate(mm, pmdp, new);
@@ -7384,7 +7436,12 @@ static int __hugetlb_hgm_walk(struct mm_struct *mm, struct vm_area_struct *vma,
 		if (!pte_present(pte)) {
 			if (!alloc)
 				return 0;
-			if (unlikely(!huge_pte_none(pte)))
+			/*
+			 * In hugetlb_alloc_pmd and hugetlb_alloc_pte,
+			 * we split PTE markers, so we can tolerate
+			 * PTE markers here.
+			 */
+			if (unlikely(!huge_pte_none_mostly(pte)))
 				return -EEXIST;
 		} else if (hugetlb_pte_present_leaf(hpte, pte))
 			return 0;
-- 
2.39.2.637.g21b0678d19-goog

