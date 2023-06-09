Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC676728D24
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237826AbjFIBgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjFIBgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:36:17 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AFA1FDF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:36:16 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-565cfe4ece7so11390107b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686274575; x=1688866575;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7TjV4RyPitx7LIAI3Pj7MSABK+uluBQcp84mqUzVC6k=;
        b=a5ewmipktwitFlsPba8meBOEdOaTniMgfwOwR66LxzGfjmzDH4IFIjppt+zCAFlN0g
         4qVFbiljADzlv99p9uKv0I6LLrtlgpWP5C7ZN5jYvFhWguH9wpOq9f3yGPT9NIjCbt8f
         ccDNMfVoLAT69ZaBFF/iOjiPqCtqRwYPT0P1Yb6UZGbQci3A4kQCZ/DTEhdlS+lQWdYY
         KzmqHWulcwNNrAp2wlegE+sh4YyxODsI8618mTIxeZ3NAKuS71wgysjyvDWVHPesaDpk
         PafA85IWdjWaVeXqTpvoM+ur2RY2SxdVNDgFZ9WN6yrvvp/2wYtNHHpsHPpA7aoAQsWI
         /+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686274575; x=1688866575;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7TjV4RyPitx7LIAI3Pj7MSABK+uluBQcp84mqUzVC6k=;
        b=Dr0g3tJVQRJk1oseruzU8LjbDYcxIE3mTc0rVo3UUwLy3yEFWvRLlbXAFltfB+uvRs
         /SdDc1lerothQDoUxiEQMOVQC4+R5B/kpsU08A+ijRe3Hr5+wknarGDIyVqsWyEIRCMc
         yIoThA+80I/yF1FSJhkfH1+j3bN9ksqJdn2gMvTDNXuV9Ix/lS0ivWJCeZgIC/EafNqo
         MajkBNYhTD5SzY4aYKM3ktq1BA3RbB3c14CjuJ2nthtG2kZohYFtWdcQrocG2zCcoe+R
         0406a/TFSM8Q7Qi3e8l6y4KWflEHLrUZhJ/JBLGb7YHJoSo7D5HaUR2Us5PxFZj7n2RX
         a4ag==
X-Gm-Message-State: AC+VfDyiBbIsFTW5HGLny9BLgdM+InmvrFHGWtJOxFkRp0CqL/x3G0Ki
        NLd156vzZpMZouMKi+U7Fu0kHg==
X-Google-Smtp-Source: ACHHUZ41tpEmUAG3j7GY9w97TvrJQ50NkLe4OKcO0eJ30STZxTamEDNBY6XFXEyrE/Y12cF7SVrDgA==
X-Received: by 2002:a81:a0c9:0:b0:568:a870:314f with SMTP id x192-20020a81a0c9000000b00568a870314fmr1280229ywg.30.1686274575219;
        Thu, 08 Jun 2023 18:36:15 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d191-20020a0ddbc8000000b00569fdf7f58bsm293760ywe.66.2023.06.08.18.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:36:14 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:36:11 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 22/32] mm/swapoff: allow pte_offset_map[_lock]() to fail
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <c4d831-13c3-9dfd-70c2-64514ad951fd@google.com>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust unuse_pte() and unuse_pte_range() to allow pte_offset_map_lock()
and pte_offset_map() failure; remove pmd_none_or_trans_huge_or_clear_bad()
from unuse_pmd_range() now that pte_offset_map() does all that itself.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/swapfile.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 274bbf797480..12d204e6dae2 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1774,7 +1774,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		hwposioned = true;
 
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
-	if (unlikely(!pte_same_as_swp(*pte, swp_entry_to_pte(entry)))) {
+	if (unlikely(!pte || !pte_same_as_swp(*pte, swp_entry_to_pte(entry)))) {
 		ret = 0;
 		goto out;
 	}
@@ -1827,7 +1827,8 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	set_pte_at(vma->vm_mm, addr, pte, new_pte);
 	swap_free(entry);
 out:
-	pte_unmap_unlock(pte, ptl);
+	if (pte)
+		pte_unmap_unlock(pte, ptl);
 	if (page != swapcache) {
 		unlock_page(page);
 		put_page(page);
@@ -1839,17 +1840,22 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			unsigned long addr, unsigned long end,
 			unsigned int type)
 {
-	swp_entry_t entry;
-	pte_t *pte;
+	pte_t *pte = NULL;
 	struct swap_info_struct *si;
-	int ret = 0;
 
 	si = swap_info[type];
-	pte = pte_offset_map(pmd, addr);
 	do {
 		struct folio *folio;
 		unsigned long offset;
 		unsigned char swp_count;
+		swp_entry_t entry;
+		int ret;
+
+		if (!pte++) {
+			pte = pte_offset_map(pmd, addr);
+			if (!pte)
+				break;
+		}
 
 		if (!is_swap_pte(*pte))
 			continue;
@@ -1860,6 +1866,8 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 
 		offset = swp_offset(entry);
 		pte_unmap(pte);
+		pte = NULL;
+
 		folio = swap_cache_get_folio(entry, vma, addr);
 		if (!folio) {
 			struct page *page;
@@ -1878,8 +1886,7 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		if (!folio) {
 			swp_count = READ_ONCE(si->swap_map[offset]);
 			if (swp_count == 0 || swp_count == SWAP_MAP_BAD)
-				goto try_next;
-
+				continue;
 			return -ENOMEM;
 		}
 
@@ -1889,20 +1896,17 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		if (ret < 0) {
 			folio_unlock(folio);
 			folio_put(folio);
-			goto out;
+			return ret;
 		}
 
 		folio_free_swap(folio);
 		folio_unlock(folio);
 		folio_put(folio);
-try_next:
-		pte = pte_offset_map(pmd, addr);
-	} while (pte++, addr += PAGE_SIZE, addr != end);
-	pte_unmap(pte - 1);
+	} while (addr += PAGE_SIZE, addr != end);
 
-	ret = 0;
-out:
-	return ret;
+	if (pte)
+		pte_unmap(pte);
+	return 0;
 }
 
 static inline int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
@@ -1917,8 +1921,6 @@ static inline int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
 	do {
 		cond_resched();
 		next = pmd_addr_end(addr, end);
-		if (pmd_none_or_trans_huge_or_clear_bad(pmd))
-			continue;
 		ret = unuse_pte_range(vma, pmd, addr, next, type);
 		if (ret)
 			return ret;
-- 
2.35.3

