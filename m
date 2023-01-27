Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D2F67EE99
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjA0ToK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjA0TnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:43:19 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606A14C08
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:52 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5066df312d7so65757957b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Tx+qt9ZwCfzeziH+AxLsfIEHPwRgvIaxjFEfdwiAVs=;
        b=MwDUDcWNdtFYfmhAuC43tEYj+bx0/7zv78dJ0hpiWDqIAfrnPySCh31pwGtES+llPo
         g9aJ1BaJcPmj6QIFKuJtNB4+OKnKX4w74YBlWwFtrSbaxVsErI4QpqtlUvrQKvku3x0Y
         fv8bSpOOjUv/1+/JuPfz5M6ciXa9EK4OZHTaoyyN5QHozfr1J0btP+Cb6s+q8s6DTvgx
         Eb/YBgAB71iKrit1/2Z+f0K+0VaK6nNNkqEz24OPAMCTiIMwYOn1N+e1hh+02mLm2qhR
         X0SB7IZ09+W7stQU0DgYwMtwYdWCgN82KCjbLOZQQ4WgzpAt4BTc4SEqK+AY1F70NhR7
         prsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Tx+qt9ZwCfzeziH+AxLsfIEHPwRgvIaxjFEfdwiAVs=;
        b=V0BaELmMQZ69LYaSXhJDxSjpLq08iRF43H36xf+HTJhHeKFU94MN+Yypdg/U1ec0vy
         MqoNopfj2scoG2kitq6Lo/Qtnp2SrAGoCWIX1fMpftOlfYhnPnQgoH/+g03vUeYZI5fS
         Yd2pcWbR+LdMssq8OfmMlzC9feazNCfyRzjUFEKo1mzbCyDkmMOBmiawpsYls4Wi6dUo
         hyPo4QoPkuICVMcymrxgUXhdHzi14ddFAxFXtxTgle3KKQWOua7vsTFYogcLDhzV7rN1
         w3qyFenVl8AozhAo0vUd4/XOZT8u/aKSjJuWKdOg9T1vsyfEsUF9Zuy8aYyvTLKchS2a
         CL2Q==
X-Gm-Message-State: AO0yUKVZKKh0JMCEWiABt0r/SCEcmWcKNEA4V8AAEJdiQbVcddRjAcFo
        5QW8M/0oTahlvpg13KbNeT/q2PnYEKs=
X-Google-Smtp-Source: AK7set+eTaGDRvBxQnOso6u8cp6LCvB6g6dz+di36ExTAmlNkOKvBeltyp9kLCTqVY9tlqnocHmCi479DpA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a81:6008:0:b0:506:833a:c32e with SMTP id
 u8-20020a816008000000b00506833ac32emr1175163ywb.50.1674848507730; Fri, 27 Jan
 2023 11:41:47 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:40:51 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-15-surenb@google.com>
Subject: [PATCH v2 14/33] mm/khugepaged: write-lock VMA while collapsing a
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
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
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
index eb38bd1b1b2f..b938b286cdc3 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1134,6 +1134,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	if (result != SCAN_SUCCEED)
 		goto out_up_write;
 
+	vma_start_write(vma);
 	anon_vma_lock_write(vma->anon_vma);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
@@ -1601,6 +1602,9 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		goto drop_hpage;
 	}
 
+	/* Lock the vma before taking i_mmap and page table locks */
+	vma_start_write(vma);
+
 	/*
 	 * We need to lock the mapping so that from here on, only GUP-fast and
 	 * hardware page walks can access the parts of the page tables that
@@ -1806,6 +1810,7 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
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

