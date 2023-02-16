Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7E5698BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBPFT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjBPFTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:19:16 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B0947416
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:36 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-52ec8c88d75so8524207b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4tPY63bpwhpT+tcOBCZmVWQ4EsQSsAiOumfwemoUSR4=;
        b=S2sXkiCN7LWOjXaeaMYvz0qNJtP37xcl3aD2Yh+x1ZEOEg3KLdTaCbat1bdYvpjsne
         ssUpFmsgMZn2ZzaQIQ1nCUMhum1BKo1kVXXpN4w0/hSPSa2H/9hW6SiJ4urWGDrWEDIg
         /lDLOzKc/0bGJk2Y7O7P1pt9zjSY2dn9UPLftjGBDJCogvybLOdBJ/pVV0l/nLyc8nbd
         78hCVT3xeGJZ3GfClpuKXysNAZLItz5CqeYcRfuccmKUwUq5LhC6V5ar511CeqKShlzR
         g15CQtYg8YR8Te7+dSB+30LV6maBKvWp8iWZepEStLZa94uN9djYv3KGIMR2EUqABQ+Q
         /xVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4tPY63bpwhpT+tcOBCZmVWQ4EsQSsAiOumfwemoUSR4=;
        b=1gSp1NhqKDSGVwAYOrs7UiLEtJSXs/IZIItXO+LeS/aSR5jAeqWBV1BD8ll43L61ZD
         2mJyESaOQrLAJg7LYujyxfmj8o0Es8EkyaJp8/VAaOE2uU0Zqu5sZyK9PPtqpC0jN78+
         KrJLQm1k4oN13qGwlatE4W30dlmUkhQEeRuW2Eqy/B758r7v0nYScKo0RgwoMh5yvTQa
         idQg6T4r/A6qXoFuY4oLsJ3ZYVY/L+EzAsMvfr0JuYRG7Rv+AaaESpKMvF5+VSL1khRl
         m8c40SwUTXYvTwvsgTnd51eQ/2Ce/XC1V6tNSlWAQGnJB+8aV0GI+B6WdVB5pJadWK25
         /EEw==
X-Gm-Message-State: AO0yUKVO2ispUTM5pBxHy2HkofDvcWn6bm6Ec5DczVN9HbhBMrK86TIj
        4qgRcRIGlTKDLXQoQ0ooXPuLJ1WvOUA=
X-Google-Smtp-Source: AK7set+CCkBNuKyDmku/7wwfF8A9hgf/5Gdg5m5aj/wzSHdI7lsc4GkupJYUuH2rfCym/bLqx0hNud/JqYI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a05:6902:10f:b0:855:fa17:4f5f with SMTP id
 o15-20020a056902010f00b00855fa174f5fmr82ybh.1.1676524711465; Wed, 15 Feb 2023
 21:18:31 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:30 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-16-surenb@google.com>
Subject: [PATCH v3 15/35] mm/khugepaged: write-lock VMA while collapsing a
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
index 8dbc39896811..d9376acf1fbe 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1140,6 +1140,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	if (result != SCAN_SUCCEED)
 		goto out_up_write;
 
+	vma_start_write(vma);
 	anon_vma_lock_write(vma->anon_vma);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
@@ -1607,6 +1608,9 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		goto drop_hpage;
 	}
 
+	/* Lock the vma before taking i_mmap and page table locks */
+	vma_start_write(vma);
+
 	/*
 	 * We need to lock the mapping so that from here on, only GUP-fast and
 	 * hardware page walks can access the parts of the page tables that
@@ -1812,6 +1816,7 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
 				result = SCAN_PTE_UFFD_WP;
 				goto unlock_next;
 			}
+			vma_start_write(vma);
 			collapse_and_free_pmd(mm, vma, addr, pmd);
 			if (!cc->is_khugepaged && is_target)
 				result = set_huge_pmd(vma, addr, pmd, hpage);
diff --git a/mm/rmap.c b/mm/rmap.c
index 15ae24585fc4..8e1a2ad9ca53 100644
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
2.39.1

