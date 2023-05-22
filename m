Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E8870B464
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjEVFNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjEVFNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:13:41 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A136100
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:13:38 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-ba841216e92so8155539276.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684732417; x=1687324417;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dPoyGlkGpegFUTFofVDIHWRBddk7VxC7U3Cl7g+dttQ=;
        b=u/pipKzV3+7Fw72J6ZuzihOhd10w0gGlLGmoTYVNzOrFtguVpB16bQ3yHwI9CSCfkH
         3Vl3zrzd94RD+ao7QuGXMU38bZgzZUL1/QZs1hHXZKn7GPINxEVThftcMMnY2o+Yudl0
         U2nS3rhKugfJt5YxhFfn9PDdwtey86BwLjUPjmgewXJIUFBVGRQf2ahMAOU7Z/t1DHAm
         l66iDmXAruV3nmxv3A2DqZgGdZJpE3BSBsWI9c3hTvkUhwfiQW5QjWVbpPvVCeixeUrI
         GKrbNt5veHLdmjZBBDPCavEMUBfFme3RGuyXCTdVESH6VYwjwFZwaExB5zSeQBSZMndy
         lQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684732417; x=1687324417;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dPoyGlkGpegFUTFofVDIHWRBddk7VxC7U3Cl7g+dttQ=;
        b=B4dq0P87YlyKv3X+UVN+5bxqCZLlbdW186Ldu8YAmWsH8Sog6dppbeeZvfpo28rIRU
         rbN13fq6yPhrTpjHJ2S35WGx5Qo9ZViDLLeHrDHSdJvhrAbkHM5vOzkjKBjIiufTBzri
         CnoRGic17BughCSF6w6cyrAx/vz1SfqhVCVQ+JAjX6azXYaSZzgmJzmVoevmoKDFzJ4k
         LfV8CNMePLhhr2zvwJBXg/bOPe7dgm8Hn0sKKzKlw9UupKvcl7p6f0trpiK8AwWCtS1Z
         RWorfgvxiNeAPAyaza5oRGSWfbwV1aEnUbXcf7LQoNGd5vYNWTtZjQyPd32ZtFh336eW
         SRqA==
X-Gm-Message-State: AC+VfDwDvnknkpWwcFsJ9EC0kF5TuCES/Y0+691ojJVLTfW6rBrdahOv
        BpjTC87yMvAVyZVkBxpBLm6s8w==
X-Google-Smtp-Source: ACHHUZ6QCzXgzIS4cFPDNtq3tlt+HJnjXO6ZXovLO9zv6wjiXs/oia4ZbqdffbL8veAaOUMs5BJwAQ==
X-Received: by 2002:a0d:d595:0:b0:561:e910:52f5 with SMTP id x143-20020a0dd595000000b00561e91052f5mr12194393ywd.27.1684732417238;
        Sun, 21 May 2023 22:13:37 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i67-20020a0df846000000b00559f1cb8444sm1824582ywf.70.2023.05.21.22.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 22:13:36 -0700 (PDT)
Date:   Sun, 21 May 2023 22:13:33 -0700 (PDT)
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
Subject: [PATCH 19/31] mm/mremap: retry if either pte_offset_map_*lock()
 fails
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <2d3fbfea-5884-8211-0cc-954afe25ae9c@google.com>
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

