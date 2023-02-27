Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F806A4835
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjB0RiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjB0Rhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:37:35 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0204C23DA2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:12 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536c039f859so154178577b3.21
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wnWzHyaDa4xKEsusiA17Gd0QXhxkYtF9yictDdgKzrI=;
        b=eYNrKBSiv4pp3yC/iTCyZADelL0yGuzmaY6iqmhnRhO2ZC4AwjZBlMwQ60T7+F6v5V
         W9pXVV/VzgegCAMywuIjmCwiOA+90SLBeJW+MLSiosTMfuWNrFFPzi/DpMcpFnT2QAIz
         CS8A9pF/mDc6TBfXFulN3NvXyigohh18r+RbFrpjgpOYnpRGGrUngztXOUUKHZu+O84j
         vZr6z0eLJ0rZFHfCy+yhp6M25rLJHKBYEd4jK+R2iR3coHxysAy7kDI+ez956k4JFPra
         ihhR22fhGEVzhhNLMgR5SxjkhXirQ5xjL8arQw+dXDtDF4Wmy1/3QOzDKcZaxxbfGAP+
         YaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wnWzHyaDa4xKEsusiA17Gd0QXhxkYtF9yictDdgKzrI=;
        b=2Fxm5Iv6bnWXs4BbDzdxGuugicHlbt6h+PqaFjEksMCD+yBml2TXzHmlij2wxT/Mzi
         OvO5ch2SIadmqpzeRpeIi5WR5eqokaUIlOB958mRjaI9605mdmMENdCj/wn24jSb05qp
         /oSTEDET2nxeNjI7U5jFDvlcUGiVIz4TIoIq7b0JpJlT3qNSmgSSaduhga4gIP4G/ZYx
         WnCrPasWArMGizfBKXIJjv+yVzwBYSLkV7yI6kHqIozdM1tR1SgXOUSGpm9pUJp6eGWc
         LMRH31Mc5v0ypWc7iOXueW/KqtvgyBxuIGq26J9ETHwdWW+if0o0II3HpSIvYce3eR3Q
         H0/g==
X-Gm-Message-State: AO0yUKWJ9dsLbey3k8x5xBJG3OTHxc+q6z6uENqJBXSp8f8do8NL/CIP
        tms+USsYin05tN1GE/PGA+svpVKV40c=
X-Google-Smtp-Source: AK7set85RoEyMLPPVhWwtVXRmKlr9rEFzrfKcusuRBnfvQixZvHj1lhFnYPTkzBCMOeQSYlYKbHYaDSIuDs=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a05:6902:118c:b0:a06:538f:265f with SMTP id
 m12-20020a056902118c00b00a06538f265fmr8111185ybu.4.1677519432589; Mon, 27 Feb
 2023 09:37:12 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:14 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-16-surenb@google.com>
Subject: [PATCH v4 15/33] mm/khugepaged: write-lock VMA while collapsing a
 huge page
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Suren Baghdasaryan <surenb@google.com>
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

Protect VMA from concurrent page fault handler while collapsing a huge
page. Page fault handler needs a stable PMD to use PTL and relies on
per-VMA lock to prevent concurrent PMD changes. pmdp_collapse_flush(),
set_huge_pmd() and collapse_and_free_pmd() can modify a PMD, which will
not be detected by a page fault handler without proper locking.

Before this patch, page tables can be walked under any one of the
mmap_lock, the mapping lock, and the anon_vma lock; so when khugepaged
unlinks and frees page tables, it must ensure that all of those either
are locked or don't exist. This patch adds a fourth lock under which
page tables can be traversed, and so khugepaged must also lock out that
one.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/khugepaged.c |  5 +++++
 mm/rmap.c       | 31 ++++++++++++++++---------------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 941d1c7ea910..c64e01f03f27 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1147,6 +1147,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	if (result != SCAN_SUCCEED)
 		goto out_up_write;
 
+	vma_start_write(vma);
 	anon_vma_lock_write(vma->anon_vma);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
@@ -1614,6 +1615,9 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		goto drop_hpage;
 	}
 
+	/* Lock the vma before taking i_mmap and page table locks */
+	vma_start_write(vma);
+
 	/*
 	 * We need to lock the mapping so that from here on, only GUP-fast and
 	 * hardware page walks can access the parts of the page tables that
@@ -1819,6 +1823,7 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
 				result = SCAN_PTE_UFFD_WP;
 				goto unlock_next;
 			}
+			vma_start_write(vma);
 			collapse_and_free_pmd(mm, vma, addr, pmd);
 			if (!cc->is_khugepaged && is_target)
 				result = set_huge_pmd(vma, addr, pmd, hpage);
diff --git a/mm/rmap.c b/mm/rmap.c
index 8632e02661ac..cfdaa56cad3e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -25,21 +25,22 @@
  *     mapping->invalidate_lock (in filemap_fault)
  *       page->flags PG_locked (lock_page)
  *         hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share, see hugetlbfs below)
- *           mapping->i_mmap_rwsem
- *             anon_vma->rwsem
- *               mm->page_table_lock or pte_lock
- *                 swap_lock (in swap_duplicate, swap_info_get)
- *                   mmlist_lock (in mmput, drain_mmlist and others)
- *                   mapping->private_lock (in block_dirty_folio)
- *                     folio_lock_memcg move_lock (in block_dirty_folio)
- *                       i_pages lock (widely used)
- *                         lruvec->lru_lock (in folio_lruvec_lock_irq)
- *                   inode->i_lock (in set_page_dirty's __mark_inode_dirty)
- *                   bdi.wb->list_lock (in set_page_dirty's __mark_inode_dirty)
- *                     sb_lock (within inode_lock in fs/fs-writeback.c)
- *                     i_pages lock (widely used, in set_page_dirty,
- *                               in arch-dependent flush_dcache_mmap_lock,
- *                               within bdi.wb->list_lock in __sync_single_inode)
+ *           vma_start_write
+ *             mapping->i_mmap_rwsem
+ *               anon_vma->rwsem
+ *                 mm->page_table_lock or pte_lock
+ *                   swap_lock (in swap_duplicate, swap_info_get)
+ *                     mmlist_lock (in mmput, drain_mmlist and others)
+ *                     mapping->private_lock (in block_dirty_folio)
+ *                       folio_lock_memcg move_lock (in block_dirty_folio)
+ *                         i_pages lock (widely used)
+ *                           lruvec->lru_lock (in folio_lruvec_lock_irq)
+ *                     inode->i_lock (in set_page_dirty's __mark_inode_dirty)
+ *                     bdi.wb->list_lock (in set_page_dirty's __mark_inode_dirty)
+ *                       sb_lock (within inode_lock in fs/fs-writeback.c)
+ *                       i_pages lock (widely used, in set_page_dirty,
+ *                                 in arch-dependent flush_dcache_mmap_lock,
+ *                                 within bdi.wb->list_lock in __sync_single_inode)
  *
  * anon_vma->rwsem,mapping->i_mmap_rwsem   (memory_failure, collect_procs_anon)
  *   ->tasklist_lock
-- 
2.39.2.722.g9855ee24e9-goog

