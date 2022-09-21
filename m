Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977315BF60F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiIUGHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiIUGHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:07:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576987C1F9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663740427; x=1695276427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bnpB1LSVTakor8hls6T/vcEzoakaO2S/bSiuGKHVfgY=;
  b=lpQySTYSBH9vbYYz5PG1UXuM/+k3qWhBRVrE9r59kVDNLJ8I5/tjPXz+
   leH7IrwZWKNtoq07lURdHgBNtsoqUNO6VhwOZzkH4i5/Bh54cV82Uaqye
   1sFdnbFHaB2dOpmwPiLffw4Tcix7NyDjiqFLdCwoxlL5O3CoO9BvVTTvw
   OY6q0UwLRkUSCBHAtkkkWDHeHdq9Y+7aBgQd9zP0yVoRPzWWBX23M2ymS
   sldslQiyieK9RchzTRJVlkr+K9NexgrE44UxbLfeNyHUlf9QKbpTZ8cMx
   lQ+kv2nrNH0CQV7FZ3514i1oxidNuzhoJOq7hHFuTANY62l9Dm0/aYljQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="280284867"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="280284867"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 23:07:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="649913962"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.5.245])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 23:07:04 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC 6/6] mm/migrate_pages: batch flushing TLB
Date:   Wed, 21 Sep 2022 14:06:16 +0800
Message-Id: <20220921060616.73086-7-ying.huang@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220921060616.73086-1-ying.huang@intel.com>
References: <20220921060616.73086-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TLB flushing will cost quite some CPU cycles during the page
migration in some situations.  For example, when migrate a page of a
process with multiple active threads that run on multiple CPUs.  After
batching the _unmap and _move in migrate_pages(), the TLB flushing can
be batched easily with the existing TLB flush batching mechanism.
This patch implements that.

We use the following test case to test the patch.

On a 2-socket Intel server,

- Run pmbench memory accessing benchmark

- Run `migratepages` to migrate pages of pmbench between node 0 and
  node 1 back and forth.

With the patch, the TLB flushing IPI reduces 99.1% during the test and
the number of pages migrated successfully per second increases 291.7%.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
---
 mm/migrate.c |  4 +++-
 mm/rmap.c    | 24 ++++++++++++++++++++----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 042fa147f302..a0de0d9b4d41 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1179,7 +1179,7 @@ static int migrate_page_unmap(new_page_t get_new_page, free_page_t put_new_page,
 		/* Establish migration ptes */
 		VM_BUG_ON_PAGE(PageAnon(page) && !PageKsm(page) && !anon_vma,
 				page);
-		try_to_migrate(folio, 0);
+		try_to_migrate(folio, TTU_BATCH_FLUSH);
 		page_was_mapped = 1;
 	}
 
@@ -1647,6 +1647,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 	nr_thp_failed += thp_retry;
 	nr_failed_pages += nr_retry_pages;
 move:
+	try_to_unmap_flush();
+
 	retry = 1;
 	thp_retry = 1;
 	for (pass = 0; pass < 10 && (retry || thp_retry); pass++) {
diff --git a/mm/rmap.c b/mm/rmap.c
index 93d5a6f793d2..ab88136720dc 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1960,8 +1960,24 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
 		} else {
 			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
-			/* Nuke the page table entry. */
-			pteval = ptep_clear_flush(vma, address, pvmw.pte);
+			/*
+			 * Nuke the page table entry.
+			 */
+			if (should_defer_flush(mm, flags)) {
+				/*
+				 * We clear the PTE but do not flush so potentially
+				 * a remote CPU could still be writing to the folio.
+				 * If the entry was previously clean then the
+				 * architecture must guarantee that a clear->dirty
+				 * transition on a cached TLB entry is written through
+				 * and traps if the PTE is unmapped.
+				 */
+				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
+
+				set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
+			} else {
+				pteval = ptep_clear_flush(vma, address, pvmw.pte);
+			}
 		}
 
 		/* Set the dirty flag on the folio now the pte is gone. */
@@ -2128,10 +2144,10 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
 
 	/*
 	 * Migration always ignores mlock and only supports TTU_RMAP_LOCKED and
-	 * TTU_SPLIT_HUGE_PMD and TTU_SYNC flags.
+	 * TTU_SPLIT_HUGE_PMD, TTU_SYNC and TTU_BATCH_FLUSH flags.
 	 */
 	if (WARN_ON_ONCE(flags & ~(TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD |
-					TTU_SYNC)))
+					TTU_SYNC | TTU_BATCH_FLUSH)))
 		return;
 
 	if (folio_is_zone_device(folio) &&
-- 
2.35.1

