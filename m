Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B26A60D6B3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 00:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiJYWBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 18:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiJYWBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:01:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B44284E7C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 15:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666735272; x=1698271272;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CI7ouPnQbhvab5W2CvjMw4Hb6IV4gsALSSktGnfsUlM=;
  b=kyZHRruaKo4yN0foyIagKzHY0wRb/uMf8nqoAa1eO8f9G7x3nOMUNB2A
   rnBUkB5vbFVVnfcvPVQrKAxBO5APj50mfGu8sxp2C+vMXMmDTij9bveGW
   m0tu2ezpGMJixENqBZXFnWuxjUNZ8FCE61cT0lbrnLuexGCo7V0ceAq01
   ZHp9OKt4RCpsKMpRHWyPqGljx5UZmSa9jt5QpRKuYsJflmyEl0fUxjrNH
   7xzdt9TIcXOnoqNBk0zYmg0FtpmFwG/wBuZS6mmZk7omNrWl3EJi44M0l
   4bEj2T8WCKLIxq02DcXt24nqOuyJm5YYsLiPULrqIM63X2SEcHeBRdK4k
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="369868501"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="369868501"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 15:01:11 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="876964588"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="876964588"
Received: from cckuo-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.218.44])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 15:01:10 -0700
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        kernel test robot <yujie.liu@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] mm/shmem: Ensure proper fallback if page faults
Date:   Tue, 25 Oct 2022 15:01:08 -0700
Message-Id: <20221025220108.2366043-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The kernel test robot flagged a recursive lock as a result of a
conversion from kmap_atomic() to kmap_local_folio()[Link]

The cause was due to the code depending on the kmap_atomic() side effect
of disabling page faults.  In that case the code expects the fault to
fail and take the fallback case.

git archaeology implied that the recursion may not be an actual bug.[1]
However, depending on the implementation of the mmap_lock and the
condition of the call there may still be a deadlock.[2]  So this is not
purely a lockdep issue.  Considering a single threaded call stack there
are 3 options.

	1) Different mm's are in play (no issue)
	2) Readlock implementation is recursive and same mm is in play
	   (no issue)
	3) Readlock implementation is _not_ recursive (issue)

The mmap_lock is recursive so with a single thread there is no issue.

However, Matthew pointed out a deadlock scenario when you consider
additional process' and threads thusly.

"The readlock implementation is only recursive if nobody else has taken
a write lock.  If you have a multithreaded process, one of the other
threads can call mmap() and that will prevent recursion (due to
fairness).  Even if it's a different process that you're trying to
acquire the mmap read lock on, you can still get into a deadly embrace.
eg:

process A thread 1 takes read lock on own mmap_lock
process A thread 2 calls mmap, blocks taking write lock
process B thread 1 takes page fault, read lock on own mmap lock
process B thread 2 calls mmap, blocks taking write lock
process A thread 1 blocks taking read lock on process B
process B thread 1 blocks taking read lock on process A

Now all four threads are blocked waiting for each other."

Regardless using pagefault_disable() ensures that no matter what locking
implementation is used a deadlock will not occur.  Add an explicit
pagefault_disable() and a big comment to explain this for future souls
looking at this code.

[1] https://lore.kernel.org/all/Y1MymJ%2FINb45AdaY@iweiny-desk3/
[2] https://lore.kernel.org/lkml/Y1bXBtGTCym77%2FoD@casper.infradead.org/

Fixes: 7a7256d5f512 ("shmem: convert shmem_mfill_atomic_pte() to use a folio")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Reported-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reported-by: kernel test robot <yujie.liu@intel.com>
Link: https://lore.kernel.org/r/202210211215.9dc6efb5-yujie.liu@intel.com
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V1
	Update the commit message and comment based on additional
	discussion.

Thanks to Matt for pointing out the deadlock potential despite recursive
reads.
Thanks to Matt and Andrew for initial diagnosis.
Thanks to Randy for pointing out C code needs ';'  :-D
Thanks to Andrew for suggesting an elaborate comment
Thanks to Peter for pointing out that the mm's may be the same.
---
 mm/shmem.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 8280a5cb48df..c1d8b8a1aa3b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2424,9 +2424,26 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 
 		if (!zeropage) {	/* COPY */
 			page_kaddr = kmap_local_folio(folio, 0);
+			/*
+			 * The read mmap_lock is held here.  Despite the
+			 * mmap_lock being read recursive a deadlock is still
+			 * possible if a writer has taken a lock.  For example:
+			 *
+			 * process A thread 1 takes read lock on own mmap_lock
+			 * process A thread 2 calls mmap, blocks taking write lock
+			 * process B thread 1 takes page fault, read lock on own mmap lock
+			 * process B thread 2 calls mmap, blocks taking write lock
+			 * process A thread 1 blocks taking read lock on process B
+			 * process B thread 1 blocks taking read lock on process A
+			 *
+			 * Disable page faults to prevent potential deadlock
+			 * and retry the copy outside the mmap_lock.
+			 */
+			pagefault_disable();
 			ret = copy_from_user(page_kaddr,
 					     (const void __user *)src_addr,
 					     PAGE_SIZE);
+			pagefault_enable();
 			kunmap_local(page_kaddr);
 
 			/* fallback to copy_from_user outside mmap_lock */
-- 
2.37.2

