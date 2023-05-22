Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B3470B47D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjEVFSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjEVFS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:18:29 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9249FAB
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:18:28 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-561d5a16be0so74545127b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684732708; x=1687324708;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7TjV4RyPitx7LIAI3Pj7MSABK+uluBQcp84mqUzVC6k=;
        b=Rn20sER4T4J8WT0bCSNgtKt+s3EuFbG8GtWiix1BcIQNeo/R8lvZKZibiwh3YZIsxd
         EnCfCzxhNamXvgrmaGBWZwQLLOogQl2zJkptkNsZuwZJP2V7Ysbew+9PodV2Eo/dF6Rz
         xAM/3hkG4T96NLraRyIuY8t8M3JyxrJk7Ta1kFceKAinzE25KLkprmyFpjg3Ymt8wWQE
         3xmly1wR7KhvAsdh/yuCHd1F4QD89xMkxfEmWA4IIW5JNutOsZzL6TS+snO9aVVtcasO
         VB24BtEFsnlH0J+Nvd70D0Zxa1Rw4VEJiHNtQC31uldZTzMR/gntM0yqANgBYRGqCRYm
         U+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684732708; x=1687324708;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7TjV4RyPitx7LIAI3Pj7MSABK+uluBQcp84mqUzVC6k=;
        b=SCaUZw1FInayFwYaIq8nw5w85aXcwXDQF2AbCS1x9hWuX2cCqqQUrLBPxt+JYOD8dg
         +Js+sfgpW8M+kw/R2FmukLnQOkirQ5V45v9EbWekHbsdOGTZBjEynHG3lWaJUyvQIB49
         RsIkqSm0WTClHA/H0HUz3Mp+Esi8T4aeBQZs6xV0kh6cqe8D4nnY3eixHMqlWUOQ3TBn
         50poEyBee3RWyVcHZaPKuGbbthWKeoIbq9pAoKCqYU5wZEOXQI0YUxHLmmiQpnukueqP
         GsbOjD28zO3VKgJ/ZcMlDpLY/F8a1PwXHB8jLi7b/lFHxFa62q5p+tgcVZYNvlN4oihs
         ixeg==
X-Gm-Message-State: AC+VfDzSHJz4q0K4dR/76qQ5vaC8hDOgDRBtUqCKkB6YS5YXpaQdcJPV
        tiD5K5ve8CmLzEj/yjIUpkeoRA==
X-Google-Smtp-Source: ACHHUZ6v2mlgLkozXZxDjiAaqAiQT2KR+fKn2zWVFJn2KWprg4vexj/qA5jscdHYSkrbKxnnqDZJ7A==
X-Received: by 2002:a0d:df8b:0:b0:55a:8b11:5f6a with SMTP id i133-20020a0ddf8b000000b0055a8b115f6amr8985666ywe.19.1684732707681;
        Sun, 21 May 2023 22:18:27 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u130-20020a816088000000b00552df52450csm1818581ywb.88.2023.05.21.22.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 22:18:27 -0700 (PDT)
Date:   Sun, 21 May 2023 22:18:24 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 22/31] mm/swapoff: allow pte_offset_map[_lock]() to fail
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <619c27-d7b0-ae71-329e-9da3d3e7fc7@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
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

