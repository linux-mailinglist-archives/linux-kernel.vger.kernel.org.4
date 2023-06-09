Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB3F728D1C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbjFIBc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjFIBcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:32:53 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36972D4F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:32:52 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-561b7729a12so35138137b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686274372; x=1688866372;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dPoyGlkGpegFUTFofVDIHWRBddk7VxC7U3Cl7g+dttQ=;
        b=E4DRQK86HkB1M0oL3CGdKUO2AI9NqeHpyBpHLli2aF+Pqlit3JP/3FLe7keJkIgcP9
         Ui3kDjUhzLuUpOKUr/BBsh3paM313vr/kZTbKcMrzy1rnCosbjtatNixhCUekN/A7pkf
         A1U0Xx3rYpDhvjGoSHww7Px2zZjjdooHl41F3udSS11WEeWkhqn3r8hfZs7GDrCg2BMs
         cW8rdWF1rLhD4DHvb+mCyaR83x60p+qcJdlOzarzjsn+EOUWDt8OE4eCU+8SOfMHlxy4
         XQHaWxY2xWWX/2GxHjET5xLBgwJ5RGHZxlXYqQkMUK5vHAdHkIfUkQT70qyxIHs4Ypp2
         ur1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686274372; x=1688866372;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dPoyGlkGpegFUTFofVDIHWRBddk7VxC7U3Cl7g+dttQ=;
        b=Uh+WYhBVaO3iX9ZXVhUlyoqw5HBkQgv2qPAEH4plapoYq4C9sFOJPhSEPiLvSovGRD
         tXUdqtz8FJKCFAPQAeLnZjYUQPCY932797p4RPgVrm+PMjWn8tFNmk7/zgj7KLWpGqNt
         QSMqI5kp9XPCwV7fOOyyxdIHEIRL3gaobMcqvsxcOFs02g80UMPGUPXAXehmsXx5VPru
         fhStZjwdkm+vIurxB+QEXlM7Z4NEdx5HEtcrhX0OYpmeBqKLlbR1Ih4QiqvEhBdzG0IP
         Bd/9n+BXRbhz0+IdC0Ljkx8znH7fB/vq3a0UPraBMhgZnYnty+Hizr9ReAHB322Xk9jL
         vNFQ==
X-Gm-Message-State: AC+VfDzmPjUcZF/wMPOq0ai/NBB+esdWgIASvALWHRHnFc1JqQPlpeuN
        7xoSDh4YBoiP2Qck7BqpanDpvQ==
X-Google-Smtp-Source: ACHHUZ6C2iTOD9MuiuvdKguC1n6gRPJbYpY/VQ3aTwN0L3f5aJC3JH3HR0E7O5S3i52MFj8yhumCLw==
X-Received: by 2002:a81:4f4c:0:b0:561:1cb6:f3d6 with SMTP id d73-20020a814f4c000000b005611cb6f3d6mr549240ywb.0.1686274371904;
        Thu, 08 Jun 2023 18:32:51 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u195-20020a0debcc000000b00565c29cf592sm309752ywe.10.2023.06.08.18.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:32:51 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:32:47 -0700 (PDT)
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
Subject: [PATCH v2 19/32] mm/mremap: retry if either pte_offset_map_*lock()
 fails
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <65e5e84a-f04-947-23f2-b97d3462e1e@google.com>
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

move_ptes() return -EAGAIN if pte_offset_map_lock() of old fails, or if
pte_offset_map_nolock() of new fails: move_page_tables() retry if so.

But that does need a pmd_none() check inside, to stop endless loop when
huge shmem is truncated (thank you to syzbot); and move_huge_pmd() must
tolerate that a page table might have been allocated there just before
(of course it would be more satisfying to remove the empty page table,
but this is not a path worth optimizing).

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/huge_memory.c |  5 +++--
 mm/mremap.c      | 28 ++++++++++++++++++++--------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 624671aaa60d..d4bd5fa7c823 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1760,9 +1760,10 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 
 	/*
 	 * The destination pmd shouldn't be established, free_pgtables()
-	 * should have release it.
+	 * should have released it; but move_page_tables() might have already
+	 * inserted a page table, if racing against shmem/file collapse.
 	 */
-	if (WARN_ON(!pmd_none(*new_pmd))) {
+	if (!pmd_none(*new_pmd)) {
 		VM_BUG_ON(pmd_trans_huge(*new_pmd));
 		return false;
 	}
diff --git a/mm/mremap.c b/mm/mremap.c
index b11ce6c92099..1fc47b4f38d7 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -133,7 +133,7 @@ static pte_t move_soft_dirty_pte(pte_t pte)
 	return pte;
 }
 
-static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
+static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		unsigned long old_addr, unsigned long old_end,
 		struct vm_area_struct *new_vma, pmd_t *new_pmd,
 		unsigned long new_addr, bool need_rmap_locks)
@@ -143,6 +143,7 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 	spinlock_t *old_ptl, *new_ptl;
 	bool force_flush = false;
 	unsigned long len = old_end - old_addr;
+	int err = 0;
 
 	/*
 	 * When need_rmap_locks is true, we take the i_mmap_rwsem and anon_vma
@@ -170,8 +171,16 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 	 * pte locks because exclusive mmap_lock prevents deadlock.
 	 */
 	old_pte = pte_offset_map_lock(mm, old_pmd, old_addr, &old_ptl);
-	new_pte = pte_offset_map(new_pmd, new_addr);
-	new_ptl = pte_lockptr(mm, new_pmd);
+	if (!old_pte) {
+		err = -EAGAIN;
+		goto out;
+	}
+	new_pte = pte_offset_map_nolock(mm, new_pmd, new_addr, &new_ptl);
+	if (!new_pte) {
+		pte_unmap_unlock(old_pte, old_ptl);
+		err = -EAGAIN;
+		goto out;
+	}
 	if (new_ptl != old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
 	flush_tlb_batched_pending(vma->vm_mm);
@@ -208,8 +217,10 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		spin_unlock(new_ptl);
 	pte_unmap(new_pte - 1);
 	pte_unmap_unlock(old_pte - 1, old_ptl);
+out:
 	if (need_rmap_locks)
 		drop_rmap_locks(vma);
+	return err;
 }
 
 #ifndef arch_supports_page_table_move
@@ -537,6 +548,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		new_pmd = alloc_new_pmd(vma->vm_mm, vma, new_addr);
 		if (!new_pmd)
 			break;
+again:
 		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd) ||
 		    pmd_devmap(*old_pmd)) {
 			if (extent == HPAGE_PMD_SIZE &&
@@ -544,8 +556,6 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 					   old_pmd, new_pmd, need_rmap_locks))
 				continue;
 			split_huge_pmd(vma, old_pmd, old_addr);
-			if (pmd_trans_unstable(old_pmd))
-				continue;
 		} else if (IS_ENABLED(CONFIG_HAVE_MOVE_PMD) &&
 			   extent == PMD_SIZE) {
 			/*
@@ -556,11 +566,13 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 					   old_pmd, new_pmd, true))
 				continue;
 		}
-
+		if (pmd_none(*old_pmd))
+			continue;
 		if (pte_alloc(new_vma->vm_mm, new_pmd))
 			break;
-		move_ptes(vma, old_pmd, old_addr, old_addr + extent, new_vma,
-			  new_pmd, new_addr, need_rmap_locks);
+		if (move_ptes(vma, old_pmd, old_addr, old_addr + extent,
+			      new_vma, new_pmd, new_addr, need_rmap_locks) < 0)
+			goto again;
 	}
 
 	mmu_notifier_invalidate_range_end(&range);
-- 
2.35.3

