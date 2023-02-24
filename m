Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036276A1D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjBXOMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBXOMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:12:17 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35AB10AA4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677247935; x=1708783935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X6tTKRKr9Xy2b+0gbUDPmROHq6FpaNkIJooU65G3dW4=;
  b=XKarCqajUK6Y+PmjJlHEJIbv8T6VcY3QqAw3L55ytRgE0OLXGHYTnM9D
   sm37KIx+5KBO5R0n17MWYPGvCzLucg3SZPY4V3m99q6BRBFXJM6ClmKAF
   Tks6vQFRkWNpYuBjdd0qjG0qHvcJEo31i7KXxXLJjwjNyiipjxFFx3Vug
   lEGyVSl/Ia3RTH0R66JnMkkPpLo4W8b7XMs7vmVNIduECpNUUDB3Bp6Oj
   2O2eb9hIlII9dhyvAVndqUbifhOtjHBTgKqUBQI8lpC1JY/zt/FrJVcQH
   c31eBpxzICEY6RMKzBLaFKyGi9M/hENK6/MYK5Y6kTLXUZae4F5JzkKlf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="332167685"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="332167685"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 06:12:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="741684649"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="741684649"
Received: from bingqili-mobl2.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.19])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 06:12:11 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Stefan Roesch <shr@devkernel.io>, Tejun Heo <tj@kernel.org>,
        Xin Hao <xhao@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 1/3] migrate_pages: fix deadlock in batched migration
Date:   Fri, 24 Feb 2023 22:11:43 +0800
Message-Id: <20230224141145.96814-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230224141145.96814-1-ying.huang@intel.com>
References: <20230224141145.96814-1-ying.huang@intel.com>
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

Two deadlock bugs were reported for the migrate_pages() batching
series.  Thanks Hugh and Pengfei!  For example, in the following
deadlock trace snippet,

 INFO: task kworker/u4:0:9 blocked for more than 147 seconds.
       Not tainted 6.2.0-rc4-kvm+ #1314
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:kworker/u4:0    state:D stack:0     pid:9     ppid:2      flags:0x00004000
 Workqueue: loop4 loop_rootcg_workfn
 Call Trace:
  <TASK>
  __schedule+0x43b/0xd00
  schedule+0x6a/0xf0
  io_schedule+0x4a/0x80
  folio_wait_bit_common+0x1b5/0x4e0
  ? __pfx_wake_page_function+0x10/0x10
  __filemap_get_folio+0x73d/0x770
  shmem_get_folio_gfp+0x1fd/0xc80
  shmem_write_begin+0x91/0x220
  generic_perform_write+0x10e/0x2e0
  __generic_file_write_iter+0x17e/0x290
  ? generic_write_checks+0x12b/0x1a0
  generic_file_write_iter+0x97/0x180
  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
  do_iter_readv_writev+0x13c/0x210
  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
  do_iter_write+0xf6/0x330
  vfs_iter_write+0x46/0x70
  loop_process_work+0x723/0xfe0
  loop_rootcg_workfn+0x28/0x40
  process_one_work+0x3cc/0x8d0
  worker_thread+0x66/0x630
  ? __pfx_worker_thread+0x10/0x10
  kthread+0x153/0x190
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x29/0x50
  </TASK>

 INFO: task repro:1023 blocked for more than 147 seconds.
       Not tainted 6.2.0-rc4-kvm+ #1314
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:repro           state:D stack:0     pid:1023  ppid:360    flags:0x00004004
 Call Trace:
  <TASK>
  __schedule+0x43b/0xd00
  schedule+0x6a/0xf0
  io_schedule+0x4a/0x80
  folio_wait_bit_common+0x1b5/0x4e0
  ? compaction_alloc+0x77/0x1150
  ? __pfx_wake_page_function+0x10/0x10
  folio_wait_bit+0x30/0x40
  folio_wait_writeback+0x2e/0x1e0
  migrate_pages_batch+0x555/0x1ac0
  ? __pfx_compaction_alloc+0x10/0x10
  ? __pfx_compaction_free+0x10/0x10
  ? __this_cpu_preempt_check+0x17/0x20
  ? lock_is_held_type+0xe6/0x140
  migrate_pages+0x100e/0x1180
  ? __pfx_compaction_free+0x10/0x10
  ? __pfx_compaction_alloc+0x10/0x10
  compact_zone+0xe10/0x1b50
  ? lock_is_held_type+0xe6/0x140
  ? check_preemption_disabled+0x80/0xf0
  compact_node+0xa3/0x100
  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
  ? _find_first_bit+0x7b/0x90
  sysctl_compaction_handler+0x5d/0xb0
  proc_sys_call_handler+0x29d/0x420
  proc_sys_write+0x2b/0x40
  vfs_write+0x3a3/0x780
  ksys_write+0xb7/0x180
  __x64_sys_write+0x26/0x30
  do_syscall_64+0x3b/0x90
  entry_SYSCALL_64_after_hwframe+0x72/0xdc
 RIP: 0033:0x7f3a2471f59d
 RSP: 002b:00007ffe567f7288 EFLAGS: 00000217 ORIG_RAX: 0000000000000001
 RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3a2471f59d
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
 RBP: 00007ffe567f72a0 R08: 0000000000000010 R09: 0000000000000010
 R10: 0000000000000010 R11: 0000000000000217 R12: 00000000004012e0
 R13: 00007ffe567f73e0 R14: 0000000000000000 R15: 0000000000000000
  </TASK>

The page migration task has held the lock of the shmem folio A, and is
waiting the writeback of the folio B of the file system on the loop
block device to complete.  While the loop worker task which writes
back the folio B is waiting to lock the shmem folio A, because the
folio A backs the folio B in the loop device.  Thus deadlock is
triggered.

In general, if we have locked some other folios except the one we are
migrating, it's not safe to wait synchronously, for example, to wait
the writeback to complete or wait to lock the buffer head.

To fix the deadlock, in this patch, we avoid to batch the page
migration except for MIGRATE_ASYNC mode.  In MIGRATE_ASYNC mode,
synchronous waiting is avoided.

The fix can be improved further.  We will do that as soon as possible.

Link: https://lore.kernel.org/linux-mm/87a6c8c-c5c1-67dc-1e32-eb30831d6e3d@google.com/
Link: https://lore.kernel.org/linux-mm/874jrg7kke.fsf@yhuang6-desk2.ccr.corp.intel.com/
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reported-by: Hugh Dickins <hughd@google.com>
Reported-by: "Xu, Pengfei" <pengfei.xu@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Stefan Roesch <shr@devkernel.io>
Cc: Tejun Heo <tj@kernel.org>
Cc: Xin Hao <xhao@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/migrate.c | 62 ++++++++++++++++------------------------------------
 1 file changed, 19 insertions(+), 43 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 37865f85df6d..7ac37dbbf307 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1106,7 +1106,7 @@ static void migrate_folio_done(struct folio *src,
 /* Obtain the lock on page, remove all ptes. */
 static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page,
 			       unsigned long private, struct folio *src,
-			       struct folio **dstp, int force, bool avoid_force_lock,
+			       struct folio **dstp, int force,
 			       enum migrate_mode mode, enum migrate_reason reason,
 			       struct list_head *ret)
 {
@@ -1157,17 +1157,6 @@ static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page
 		if (current->flags & PF_MEMALLOC)
 			goto out;
 
-		/*
-		 * We have locked some folios and are going to wait to lock
-		 * this folio.  To avoid a potential deadlock, let's bail
-		 * out and not do that. The locked folios will be moved and
-		 * unlocked, then we can wait to lock this folio.
-		 */
-		if (avoid_force_lock) {
-			rc = -EDEADLOCK;
-			goto out;
-		}
-
 		folio_lock(src);
 	}
 	locked = true;
@@ -1247,7 +1236,7 @@ static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page
 		/* Establish migration ptes */
 		VM_BUG_ON_FOLIO(folio_test_anon(src) &&
 			       !folio_test_ksm(src) && !anon_vma, src);
-		try_to_migrate(src, TTU_BATCH_FLUSH);
+		try_to_migrate(src, mode == MIGRATE_ASYNC ? TTU_BATCH_FLUSH : 0);
 		page_was_mapped = 1;
 	}
 
@@ -1261,7 +1250,7 @@ static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page
 	 * A folio that has not been unmapped will be restored to
 	 * right list unless we want to retry.
 	 */
-	if (rc == -EAGAIN || rc == -EDEADLOCK)
+	if (rc == -EAGAIN)
 		ret = NULL;
 
 	migrate_folio_undo_src(src, page_was_mapped, anon_vma, locked, ret);
@@ -1634,11 +1623,9 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 	LIST_HEAD(dst_folios);
 	bool nosplit = (reason == MR_NUMA_MISPLACED);
 	bool no_split_folio_counting = false;
-	bool avoid_force_lock;
 
 retry:
 	rc_saved = 0;
-	avoid_force_lock = false;
 	retry = 1;
 	for (pass = 0;
 	     pass < NR_MAX_MIGRATE_PAGES_RETRY && (retry || large_retry);
@@ -1683,15 +1670,14 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 			}
 
 			rc = migrate_folio_unmap(get_new_page, put_new_page, private,
-						 folio, &dst, pass > 2, avoid_force_lock,
-						 mode, reason, ret_folios);
+						 folio, &dst, pass > 2, mode,
+						 reason, ret_folios);
 			/*
 			 * The rules are:
 			 *	Success: folio will be freed
 			 *	Unmap: folio will be put on unmap_folios list,
 			 *	       dst folio put on dst_folios list
 			 *	-EAGAIN: stay on the from list
-			 *	-EDEADLOCK: stay on the from list
 			 *	-ENOMEM: stay on the from list
 			 *	Other errno: put on ret_folios list
 			 */
@@ -1743,14 +1729,6 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 					goto out;
 				else
 					goto move;
-			case -EDEADLOCK:
-				/*
-				 * The folio cannot be locked for potential deadlock.
-				 * Go move (and unlock) all locked folios.  Then we can
-				 * try again.
-				 */
-				rc_saved = rc;
-				goto move;
 			case -EAGAIN:
 				if (is_large) {
 					large_retry++;
@@ -1765,11 +1743,6 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 				stats->nr_thp_succeeded += is_thp;
 				break;
 			case MIGRATEPAGE_UNMAP:
-				/*
-				 * We have locked some folios, don't force lock
-				 * to avoid deadlock.
-				 */
-				avoid_force_lock = true;
 				list_move_tail(&folio->lru, &unmap_folios);
 				list_add_tail(&dst->lru, &dst_folios);
 				break;
@@ -1894,17 +1867,15 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 		 */
 		list_splice_init(from, ret_folios);
 		list_splice_init(&split_folios, from);
+		/*
+		 * Force async mode to avoid to wait lock or bit when we have
+		 * locked more than one folios.
+		 */
+		mode = MIGRATE_ASYNC;
 		no_split_folio_counting = true;
 		goto retry;
 	}
 
-	/*
-	 * We have unlocked all locked folios, so we can force lock now, let's
-	 * try again.
-	 */
-	if (rc == -EDEADLOCK)
-		goto retry;
-
 	return rc;
 }
 
@@ -1939,7 +1910,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
 {
 	int rc, rc_gather;
-	int nr_pages;
+	int nr_pages, batch;
 	struct folio *folio, *folio2;
 	LIST_HEAD(folios);
 	LIST_HEAD(ret_folios);
@@ -1953,6 +1924,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				     mode, reason, &stats, &ret_folios);
 	if (rc_gather < 0)
 		goto out;
+
+	if (mode == MIGRATE_ASYNC)
+		batch = NR_MAX_BATCHED_MIGRATION;
+	else
+		batch = 1;
 again:
 	nr_pages = 0;
 	list_for_each_entry_safe(folio, folio2, from, lru) {
@@ -1963,11 +1939,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		}
 
 		nr_pages += folio_nr_pages(folio);
-		if (nr_pages > NR_MAX_BATCHED_MIGRATION)
+		if (nr_pages >= batch)
 			break;
 	}
-	if (nr_pages > NR_MAX_BATCHED_MIGRATION)
-		list_cut_before(&folios, from, &folio->lru);
+	if (nr_pages >= batch)
+		list_cut_before(&folios, from, &folio2->lru);
 	else
 		list_splice_init(from, &folios);
 	rc = migrate_pages_batch(&folios, get_new_page, put_new_page, private,
-- 
2.39.1

