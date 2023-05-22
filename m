Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8222470B480
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjEVFVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjEVFU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:20:58 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15ED100
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:20:56 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-babb985f9c8so3645159276.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684732856; x=1687324856;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j6etDg/swU7AOCalaMxD05iIweXIhmZHtm6GGNoHnzQ=;
        b=YFRKfsKFJp2z/omMF9kAApd0S0vxQuFTDhSSSfTCRKzoqcrub4PhM+O1boooV8+h+7
         EnjnOkymlppoTkDw4nRAPps7rFoXTdCM2fk5vgu0nhCdGNkuTC3Ywg1Tg0z3smilw57a
         AYhYR543c86roHNURCr25oJ9c1fQFj3ujvNOV5N67eBFAEXegF1f2oEskky6yYw53RB6
         1LMrFi8toFy6m/MnfxFA7DcCZIfsKlCmP01wxE3ks9bt8Xfi1FEm4Lsd/b5mwwUQxQvr
         vvJIRG6Xgs+dtaUMASMBUyR0SSOfetdWJ8Iw1sW/hI3XPXcU9B/tW4Jbs4RLezTnbIt4
         iIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684732856; x=1687324856;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6etDg/swU7AOCalaMxD05iIweXIhmZHtm6GGNoHnzQ=;
        b=LGqvEc0AcAmTqYUF03F2YMkBO6oYB2W7Zj8ZKsHm26Qg1M0ZuiC8WTtDcMfzbKgyyq
         Ht4BekgjBlgceZysA66ZFQDhOGgQj7qV082MQdZcowjtlFbPff7KsJ8ZFAEFS/ZTZ1+u
         SHfF35UAjzAi4ABzQitVFwUZmfS4IUsRsovniUYTmGB9Hb4A/CcBNvR8M2VQOZxpMLdN
         EKxAw16MJDMs0wDCwDQsuqrbpiyJY8mS7tqDAjTOe/COSZqC2/lkpVpCXL2RZkvnI5yT
         jECczQSSqpcruBbvPj6JMNgfeDqiv869pjtY8SSbb9T5NIoHw0wnWLHlkmZN+qZ0P8cZ
         EbOw==
X-Gm-Message-State: AC+VfDz96Pt1qN22rmztFQvoAIdHR1G4abBebg+tbjhu8qhInfQqZwIy
        aLdPiVZ26RFqIPALrcl4vQl4+A==
X-Google-Smtp-Source: ACHHUZ4unls6ogV9SvyZExwOGgG/jyFNvH+bFxzEVTKzBIPGmZGTzZNTpUXsl12MimVOmHUoz8BiUw==
X-Received: by 2002:a0d:ea93:0:b0:559:f0ef:aac0 with SMTP id t141-20020a0dea93000000b00559f0efaac0mr10004964ywe.30.1684732856030;
        Sun, 21 May 2023 22:20:56 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i16-20020a0ddf10000000b0054f80928ea4sm1795763ywe.140.2023.05.21.22.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 22:20:55 -0700 (PDT)
Date:   Sun, 21 May 2023 22:20:52 -0700 (PDT)
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
Subject: [PATCH 24/31] mm/migrate_device: allow pte_offset_map_lock() to
 fail
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <ea51bb69-189c-229b-fc0-9d3e7be5d6b@google.com>
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

migrate_vma_collect_pmd(): remove the pmd_trans_unstable() handling after
splitting huge zero pmd, and the pmd_none() handling after successfully
splitting huge page: those are now managed inside pte_offset_map_lock(),
and by "goto again" when it fails.

But the skip after unsuccessful split_huge_page() must stay: it avoids an
endless loop.  The skip when pmd_bad()?  Remove that: it will be treated
as a hole rather than a skip once cleared by pte_offset_map_lock(), but
with different timing that would be so anyway; and it's arguably best to
leave the pmd_bad() handling centralized there.

migrate_vma_insert_page(): remove comment on the old pte_offset_map()
and old locking limitations; remove the pmd_trans_unstable() check and
just proceed to pte_offset_map_lock(), aborting when it fails (page has
now been charged to memcg, but that's so in other cases, and presumably
uncharged later).

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/migrate_device.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index d30c9de60b0d..a14af6b12b04 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -83,9 +83,6 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 		if (is_huge_zero_page(page)) {
 			spin_unlock(ptl);
 			split_huge_pmd(vma, pmdp, addr);
-			if (pmd_trans_unstable(pmdp))
-				return migrate_vma_collect_skip(start, end,
-								walk);
 		} else {
 			int ret;
 
@@ -100,16 +97,12 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			if (ret)
 				return migrate_vma_collect_skip(start, end,
 								walk);
-			if (pmd_none(*pmdp))
-				return migrate_vma_collect_hole(start, end, -1,
-								walk);
 		}
 	}
 
-	if (unlikely(pmd_bad(*pmdp)))
-		return migrate_vma_collect_skip(start, end, walk);
-
 	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
+	if (!ptep)
+		goto again;
 	arch_enter_lazy_mmu_mode();
 
 	for (; addr < end; addr += PAGE_SIZE, ptep++) {
@@ -595,27 +588,10 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	pmdp = pmd_alloc(mm, pudp, addr);
 	if (!pmdp)
 		goto abort;
-
 	if (pmd_trans_huge(*pmdp) || pmd_devmap(*pmdp))
 		goto abort;
-
-	/*
-	 * Use pte_alloc() instead of pte_alloc_map().  We can't run
-	 * pte_offset_map() on pmds where a huge pmd might be created
-	 * from a different thread.
-	 *
-	 * pte_alloc_map() is safe to use under mmap_write_lock(mm) or when
-	 * parallel threads are excluded by other means.
-	 *
-	 * Here we only have mmap_read_lock(mm).
-	 */
 	if (pte_alloc(mm, pmdp))
 		goto abort;
-
-	/* See the comment in pte_alloc_one_map() */
-	if (unlikely(pmd_trans_unstable(pmdp)))
-		goto abort;
-
 	if (unlikely(anon_vma_prepare(vma)))
 		goto abort;
 	if (mem_cgroup_charge(page_folio(page), vma->vm_mm, GFP_KERNEL))
@@ -650,7 +626,8 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	}
 
 	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
-
+	if (!ptep)
+		goto abort;
 	if (check_stable_address_space(mm))
 		goto unlock_abort;
 
-- 
2.35.3

