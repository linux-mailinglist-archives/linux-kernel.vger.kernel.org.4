Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2246702FFB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240629AbjEOOfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241846AbjEOOfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:35:44 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCCA11D
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 07:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1684161342;
        bh=55UiL7049d5WwXoq8Ga1ETl0Xcqd3k/79bhP8jRai1I=;
        h=From:To:Cc:Subject:Date:From;
        b=Ygbu0By2kzmJLHh1Fy4KXvfh+K9aNW5LbzhbEX5LeLatHUBNzOUEcNYDrcUw5Az5e
         v3SH4smxTxOMBPYSXoGiQuPqbVFeQMfc02K4UtkVhJMeHCcKxxgL795dpfbwruTact
         TdIrD0ixOzK3WpYzJKsh77uwmo9LwNOyNw2KZLr8q0TNVo0EGf8faPJezJsV3+JtuX
         zZFsLOUVQYckfd3VO9KJkCXjOA4Ixt05jknCAgSUVrIgCecJycLf3JuVsqt7twXxav
         9Ma1bfkisrmpyWi+8puxAJFgbKbBvMCrn5rzbym0yGp/GAAAZNzShPunQjAlsiohQ7
         NxI3QqSkgR+ig==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QKhk55lzxz12dV;
        Mon, 15 May 2023 10:35:41 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        kernel test robot <yujie.liu@intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Olivier Dion <odion@efficios.com>, michael.christie@oracle.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Feng Tang <feng.tang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
        linux-mm@kvack.org
Subject: [PATCH] mm: Move mm_count into its own cache line
Date:   Mon, 15 May 2023 10:35:36 -0400
Message-Id: <20230515143536.114960-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mm_struct mm_count field is frequently updated by mmgrab/mmdrop
performed by context switch. This causes false-sharing for surrounding
mm_struct fields which are read-mostly.

This has been observed on a 2sockets/112core/224cpu Intel Sapphire
Rapids server running hackbench, and by the kernel test robot
will-it-scale testcase.

Move the mm_count field into its own cache line to prevent false-sharing
with other mm_struct fields.

Move mm_count to the first field of mm_struct to minimize the amount of
padding required: rather than adding padding before and after the
mm_count field, padding is only added after mm_count.

Note that I noticed this odd comment in mm_struct:

commit 2e3025434a6b ("mm: relocate 'write_protect_seq' in struct mm_struct")

                /*
                 * With some kernel config, the current mmap_lock's offset
                 * inside 'mm_struct' is at 0x120, which is very optimal, as
                 * its two hot fields 'count' and 'owner' sit in 2 different
                 * cachelines,  and when mmap_lock is highly contended, both
                 * of the 2 fields will be accessed frequently, current layout
                 * will help to reduce cache bouncing.
                 *
                 * So please be careful with adding new fields before
                 * mmap_lock, which can easily push the 2 fields into one
                 * cacheline.
                 */
                struct rw_semaphore mmap_lock;

This comment is rather odd for a few reasons:

- It requires addition/removal of mm_struct fields to carefully consider
  field alignment of _other_ fields,
- It expresses the wish to keep an "optimal" alignment for a specific
  kernel config.

I suspect that the author of this comment may want to revisit this topic
and perhaps introduce a split-struct approach for struct rw_semaphore,
if the need is to place various fields of this structure in different
cache lines.

Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
Fixes: af7f588d8f73 ("sched: Introduce per-memory-map concurrency ID")
Link: https://lore.kernel.org/lkml/7a0c1db1-103d-d518-ed96-1584a28fbf32@efficios.com
Reported-by: kernel test robot <yujie.liu@intel.com>
Link: https://lore.kernel.org/oe-lkp/202305151017.27581d75-yujie.liu@intel.com
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Aaron Lu <aaron.lu@intel.com>
Cc: Olivier Dion <odion@efficios.com>
Cc: michael.christie@oracle.com
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Feng Tang <feng.tang@intel.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org
---
 include/linux/mm_types.h | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 306a3d1a0fa6..de10fc797c8e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -583,6 +583,21 @@ struct mm_cid {
 struct kioctx_table;
 struct mm_struct {
 	struct {
+		/*
+		 * Fields which are often written to are placed in a separate
+		 * cache line.
+		 */
+		struct {
+			/**
+			 * @mm_count: The number of references to &struct
+			 * mm_struct (@mm_users count as 1).
+			 *
+			 * Use mmgrab()/mmdrop() to modify. When this drops to
+			 * 0, the &struct mm_struct is freed.
+			 */
+			atomic_t mm_count;
+		} ____cacheline_aligned_in_smp;
+
 		struct maple_tree mm_mt;
 #ifdef CONFIG_MMU
 		unsigned long (*get_unmapped_area) (struct file *filp,
@@ -620,14 +635,6 @@ struct mm_struct {
 		 */
 		atomic_t mm_users;
 
-		/**
-		 * @mm_count: The number of references to &struct mm_struct
-		 * (@mm_users count as 1).
-		 *
-		 * Use mmgrab()/mmdrop() to modify. When this drops to 0, the
-		 * &struct mm_struct is freed.
-		 */
-		atomic_t mm_count;
 #ifdef CONFIG_SCHED_MM_CID
 		/**
 		 * @pcpu_cid: Per-cpu current cid.
-- 
2.25.1

