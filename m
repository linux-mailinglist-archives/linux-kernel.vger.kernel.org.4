Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8574E74FE69
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 06:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjGLEnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 00:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGLEno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 00:43:44 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681CD1736
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 21:43:42 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-56fff21c2ebso73766197b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 21:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689137021; x=1691729021;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=32J2R02jsERy50AfXzN+Fv7mkbkTcayWxoVtpmMI0mo=;
        b=kQgLOireKqLbQKrB+SyHisW6tHedPZ4G73Quib/4dgQ29ZxZF0aUUC9/AB1YAXJTmW
         YfN2VLL4oxjBytasR0DDmdsA/5SwE00Qr2eUa6/BDHduLqwOHYcIxbv7cRXIJlWzEw2m
         uoqeOZ8DbWFaiY63frmb1j9LBXR1ks+8b73KgPMot86t+OVw+MvtSmilEn/5eKnnRo9K
         SAxgb45RUrxIr6smOzqkeoGVSl5EJPs5usxApXvZRRMwRcK/6dkO1aWOTsyUkX+UXkby
         QrSLYbHURK0PWj/JH/BKH9qrF8fgxguY0Wuc8PElVG57pF2x2Uxoa29tGTGp97vsnB2j
         jLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689137021; x=1691729021;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=32J2R02jsERy50AfXzN+Fv7mkbkTcayWxoVtpmMI0mo=;
        b=lU2GiNzJgh0GOXk3I/7U2eRqI//rnYiTs8kAlnBzBPJOuaCVcKQNgyFbogCohm0JlP
         95VKNDFI6xRNG+hU272csYx4cv1v6/E4p4pbTJCP9L2vIjvzvQUE9BZ132A4SdsDHZlF
         Y5059GPkkUxngajxHEYRt+BEtfpcJYVIBDE9RNyGd4plxgeWkHpibYvSF6F0TQ7+Lydy
         aLUJCgljgD5PGrhYuN5I63hiia6W8dfAOp2BGbbEqEBmXL+ChNIza7oZ9wfOlvg76jrw
         wDEsNKr4TrgqtT8zAFlD0h9xACVbwtukt/iVzbJ+RNxUIYUVlo7F0saBt34uNq7SlFxB
         8eJw==
X-Gm-Message-State: ABy/qLaxLNvsxsYeslWfP2I2VDWVGX3Ts+XzFkAa7uN+tvKyJfsQSPLA
        HbffveDLdlTC5L1rHv0WMKxagw==
X-Google-Smtp-Source: APBJJlEKLBPT5DnCx42X0tK5DSIxj7Xpwg5AizJaj2C86j321LP85ClVc2RWHCxTTmThFbhjxFV/0w==
X-Received: by 2002:a81:4e46:0:b0:577:42be:1804 with SMTP id c67-20020a814e46000000b0057742be1804mr17031953ywb.29.1689137021419;
        Tue, 11 Jul 2023 21:43:41 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h62-20020a815341000000b0057682d3f95fsm981159ywb.136.2023.07.11.21.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 21:43:41 -0700 (PDT)
Date:   Tue, 11 Jul 2023 21:43:36 -0700 (PDT)
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
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 11/13] mm/khugepaged: delete
 khugepaged_collapse_pte_mapped_thps()
In-Reply-To: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
Message-ID: <a5dce57-6dfa-5559-4698-e817eb2f993@google.com>
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
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

Now that retract_page_tables() can retract page tables reliably, without
depending on trylocks, delete all the apparatus for khugepaged to try
again later: khugepaged_collapse_pte_mapped_thps() etc; and free up the
per-mm memory which was set aside for that in the khugepaged_mm_slot.

But one part of that is worth keeping: when hpage_collapse_scan_file()
found SCAN_PTE_MAPPED_HUGEPAGE, that address was noted in the mm_slot
to be tried for retraction later - catching, for example, page tables
where a reversible mprotect() of a portion had required splitting the
pmd, but now it can be recollapsed.  Call collapse_pte_mapped_thp()
directly in this case (why was it deferred before?  I assume an issue
with needing mmap_lock for write, but now it's only needed for read).

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/khugepaged.c | 125 +++++++-------------------------------------------
 1 file changed, 16 insertions(+), 109 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 46986eb4eebb..7c7aaddbe130 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -92,8 +92,6 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
 
 static struct kmem_cache *mm_slot_cache __read_mostly;
 
-#define MAX_PTE_MAPPED_THP 8
-
 struct collapse_control {
 	bool is_khugepaged;
 
@@ -107,15 +105,9 @@ struct collapse_control {
 /**
  * struct khugepaged_mm_slot - khugepaged information per mm that is being scanned
  * @slot: hash lookup from mm to mm_slot
- * @nr_pte_mapped_thp: number of pte mapped THP
- * @pte_mapped_thp: address array corresponding pte mapped THP
  */
 struct khugepaged_mm_slot {
 	struct mm_slot slot;
-
-	/* pte-mapped THP in this mm */
-	int nr_pte_mapped_thp;
-	unsigned long pte_mapped_thp[MAX_PTE_MAPPED_THP];
 };
 
 /**
@@ -1439,50 +1431,6 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
 }
 
 #ifdef CONFIG_SHMEM
-/*
- * Notify khugepaged that given addr of the mm is pte-mapped THP. Then
- * khugepaged should try to collapse the page table.
- *
- * Note that following race exists:
- * (1) khugepaged calls khugepaged_collapse_pte_mapped_thps() for mm_struct A,
- *     emptying the A's ->pte_mapped_thp[] array.
- * (2) MADV_COLLAPSE collapses some file extent with target mm_struct B, and
- *     retract_page_tables() finds a VMA in mm_struct A mapping the same extent
- *     (at virtual address X) and adds an entry (for X) into mm_struct A's
- *     ->pte-mapped_thp[] array.
- * (3) khugepaged calls khugepaged_collapse_scan_file() for mm_struct A at X,
- *     sees a pte-mapped THP (SCAN_PTE_MAPPED_HUGEPAGE) and adds an entry
- *     (for X) into mm_struct A's ->pte-mapped_thp[] array.
- * Thus, it's possible the same address is added multiple times for the same
- * mm_struct.  Should this happen, we'll simply attempt
- * collapse_pte_mapped_thp() multiple times for the same address, under the same
- * exclusive mmap_lock, and assuming the first call is successful, subsequent
- * attempts will return quickly (without grabbing any additional locks) when
- * a huge pmd is found in find_pmd_or_thp_or_none().  Since this is a cheap
- * check, and since this is a rare occurrence, the cost of preventing this
- * "multiple-add" is thought to be more expensive than just handling it, should
- * it occur.
- */
-static bool khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
-					  unsigned long addr)
-{
-	struct khugepaged_mm_slot *mm_slot;
-	struct mm_slot *slot;
-	bool ret = false;
-
-	VM_BUG_ON(addr & ~HPAGE_PMD_MASK);
-
-	spin_lock(&khugepaged_mm_lock);
-	slot = mm_slot_lookup(mm_slots_hash, mm);
-	mm_slot = mm_slot_entry(slot, struct khugepaged_mm_slot, slot);
-	if (likely(mm_slot && mm_slot->nr_pte_mapped_thp < MAX_PTE_MAPPED_THP)) {
-		mm_slot->pte_mapped_thp[mm_slot->nr_pte_mapped_thp++] = addr;
-		ret = true;
-	}
-	spin_unlock(&khugepaged_mm_lock);
-	return ret;
-}
-
 /* hpage must be locked, and mmap_lock must be held */
 static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
 			pmd_t *pmdp, struct page *hpage)
@@ -1706,29 +1654,6 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	return result;
 }
 
-static void khugepaged_collapse_pte_mapped_thps(struct khugepaged_mm_slot *mm_slot)
-{
-	struct mm_slot *slot = &mm_slot->slot;
-	struct mm_struct *mm = slot->mm;
-	int i;
-
-	if (likely(mm_slot->nr_pte_mapped_thp == 0))
-		return;
-
-	if (!mmap_write_trylock(mm))
-		return;
-
-	if (unlikely(hpage_collapse_test_exit(mm)))
-		goto out;
-
-	for (i = 0; i < mm_slot->nr_pte_mapped_thp; i++)
-		collapse_pte_mapped_thp(mm, mm_slot->pte_mapped_thp[i], false);
-
-out:
-	mm_slot->nr_pte_mapped_thp = 0;
-	mmap_write_unlock(mm);
-}
-
 static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 {
 	struct vm_area_struct *vma;
@@ -2370,16 +2295,6 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 {
 	BUILD_BUG();
 }
-
-static void khugepaged_collapse_pte_mapped_thps(struct khugepaged_mm_slot *mm_slot)
-{
-}
-
-static bool khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
-					  unsigned long addr)
-{
-	return false;
-}
 #endif
 
 static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
@@ -2409,7 +2324,6 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 		khugepaged_scan.mm_slot = mm_slot;
 	}
 	spin_unlock(&khugepaged_mm_lock);
-	khugepaged_collapse_pte_mapped_thps(mm_slot);
 
 	mm = slot->mm;
 	/*
@@ -2462,36 +2376,29 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 						khugepaged_scan.address);
 
 				mmap_read_unlock(mm);
-				*result = hpage_collapse_scan_file(mm,
-								   khugepaged_scan.address,
-								   file, pgoff, cc);
 				mmap_locked = false;
+				*result = hpage_collapse_scan_file(mm,
+					khugepaged_scan.address, file, pgoff, cc);
+				if (*result == SCAN_PTE_MAPPED_HUGEPAGE) {
+					mmap_read_lock(mm);
+					mmap_locked = true;
+					if (hpage_collapse_test_exit(mm)) {
+						fput(file);
+						goto breakouterloop;
+					}
+					*result = collapse_pte_mapped_thp(mm,
+						khugepaged_scan.address, false);
+					if (*result == SCAN_PMD_MAPPED)
+						*result = SCAN_SUCCEED;
+				}
 				fput(file);
 			} else {
 				*result = hpage_collapse_scan_pmd(mm, vma,
-								  khugepaged_scan.address,
-								  &mmap_locked,
-								  cc);
+					khugepaged_scan.address, &mmap_locked, cc);
 			}
-			switch (*result) {
-			case SCAN_PTE_MAPPED_HUGEPAGE: {
-				pmd_t *pmd;
 
-				*result = find_pmd_or_thp_or_none(mm,
-								  khugepaged_scan.address,
-								  &pmd);
-				if (*result != SCAN_SUCCEED)
-					break;
-				if (!khugepaged_add_pte_mapped_thp(mm,
-								   khugepaged_scan.address))
-					break;
-			} fallthrough;
-			case SCAN_SUCCEED:
+			if (*result == SCAN_SUCCEED)
 				++khugepaged_pages_collapsed;
-				break;
-			default:
-				break;
-			}
 
 			/* move to next address */
 			khugepaged_scan.address += HPAGE_PMD_SIZE;
-- 
2.35.3

