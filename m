Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98F46048A3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbiJSOCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiJSOCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:02:20 -0400
Received: from outbound-smtp03.blacknight.com (outbound-smtp03.blacknight.com [81.17.249.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDCFC148E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:43:23 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp03.blacknight.com (Postfix) with ESMTPS id 46053C0E01
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:41:58 +0100 (IST)
Received: (qmail 28192 invoked from network); 19 Oct 2022 13:41:58 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 Oct 2022 13:41:57 -0000
Date:   Wed, 19 Oct 2022 14:41:56 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] mm/huge_memory: Do not clobber swp_entry_t during THP
 split
Message-ID: <20221019134156.zjyyn5aownakvztf@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following has been observed when running stressng mmap since commit
b653db77350c ("mm: Clear page->private when splitting or migrating a page")

   watchdog: BUG: soft lockup - CPU#75 stuck for 26s! [stress-ng:9546]
   CPU: 75 PID: 9546 Comm: stress-ng Tainted: G            E      6.0.0-revert-b653db77-fix+ #29 0357d79b60fb09775f678e4f3f64ef0579ad1374
   Hardware name: SGI.COM C2112-4GP3/X10DRT-P-Series, BIOS 2.0a 05/09/2016
   RIP: 0010:xas_descend+0x28/0x80
   Code: cc cc 0f b6 0e 48 8b 57 08 48 d3 ea 83 e2 3f 89 d0 48 83 c0 04 48 8b 44 c6 08 48 89 77 18 48 89 c1 83 e1 03 48 83 f9 02 75 08 <48> 3d fd 00 00 00 76 08 88 57 12 c3 cc cc cc cc 48 c1 e8 02 89 c2
   RSP: 0018:ffffbbf02a2236a8 EFLAGS: 00000246
   RAX: ffff9cab7d6a0002 RBX: ffffe04b0af88040 RCX: 0000000000000002
   RDX: 0000000000000030 RSI: ffff9cab60509b60 RDI: ffffbbf02a2236c0
   RBP: 0000000000000000 R08: ffff9cab60509b60 R09: ffffbbf02a2236c0
   R10: 0000000000000001 R11: ffffbbf02a223698 R12: 0000000000000000
   R13: ffff9cab4e28da80 R14: 0000000000039c01 R15: ffff9cab4e28da88
   FS:  00007fab89b85e40(0000) GS:ffff9cea3fcc0000(0000) knlGS:0000000000000000
   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   CR2: 00007fab84e00000 CR3: 00000040b73a4003 CR4: 00000000003706e0
   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
   Call Trace:
    <TASK>
    xas_load+0x3a/0x50
    __filemap_get_folio+0x80/0x370
    ? put_swap_page+0x163/0x360
    pagecache_get_page+0x13/0x90
    __try_to_reclaim_swap+0x50/0x190
    scan_swap_map_slots+0x31e/0x670
    get_swap_pages+0x226/0x3c0
    folio_alloc_swap+0x1cc/0x240
    add_to_swap+0x14/0x70
    shrink_page_list+0x968/0xbc0
    reclaim_page_list+0x70/0xf0
    reclaim_pages+0xdd/0x120
    madvise_cold_or_pageout_pte_range+0x814/0xf30
    walk_pgd_range+0x637/0xa30
    __walk_page_range+0x142/0x170
    walk_page_range+0x146/0x170
    madvise_pageout+0xb7/0x280
    ? asm_common_interrupt+0x22/0x40
    madvise_vma_behavior+0x3b7/0xac0
    ? find_vma+0x4a/0x70
    ? find_vma+0x64/0x70
    ? madvise_vma_anon_name+0x40/0x40
    madvise_walk_vmas+0xa6/0x130
    do_madvise+0x2f4/0x360
    __x64_sys_madvise+0x26/0x30
    do_syscall_64+0x5b/0x80
    ? do_syscall_64+0x67/0x80
    ? syscall_exit_to_user_mode+0x17/0x40
    ? do_syscall_64+0x67/0x80
    ? syscall_exit_to_user_mode+0x17/0x40
    ? do_syscall_64+0x67/0x80
    ? do_syscall_64+0x67/0x80
    ? common_interrupt+0x8b/0xa0
    entry_SYSCALL_64_after_hwframe+0x63/0xcd

The problem can be reproduced with the mmtests config
config-workload-stressng-mmap. It does not always happen and when it
triggers is variable but it has happened on multiple machines.

The intent of commit b653db77350c patch was to avoid the case where
PG_private is clear but folio->private is not-NULL. However, THP tail
pages uses page->private for "swp_entry_t if folio_test_swapcache()" as
stated in the documentation for struct folio. This patch only clobbers
page->private for tail pages if the head page was not in swapcache and
warns once if page->private had an unexpected value.

Fixes: b653db77350c ("mm: Clear page->private when splitting or migrating a page")
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/huge_memory.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1cc4a5f4791e..03fc7e5edf07 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2455,7 +2455,16 @@ static void __split_huge_page_tail(struct page *head, int tail,
 			page_tail);
 	page_tail->mapping = head->mapping;
 	page_tail->index = head->index + tail;
-	page_tail->private = 0;
+
+	/*
+	 * page->private should not be set in tail pages with the exception
+	 * of swap cache pages that store the swp_entry_t in tail pages.
+	 * Fix up and warn once if private is unexpectedly set.
+	 */
+	if (!folio_test_swapcache(page_folio(head))) {
+		VM_WARN_ON_ONCE_PAGE(page_tail->private != 0, head);
+		page_tail->private = 0;
+	}
 
 	/* Page flags must be visible before we make the page non-compound. */
 	smp_wmb();
