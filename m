Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F5160D6B4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 00:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiJYWBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 18:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiJYWBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:01:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23F266866
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 15:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666735299; x=1698271299;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XPIZHNC/KLHq2wwLZzF0y3YfGyClXuQbuFbE/PrASB8=;
  b=hiba0HBg34cL+cSjUrsqkirFMFnBcnmethpdc/+FOUBOCspDpwoBADoM
   amu/d0w5XVaPV08oD+4NoKSlxkigt0lBoftr7FkzNqxfOTvXbuvdzT4Hh
   ZP8cQQgFCov51hANsSxTgceq90owcz8HrAL/60fKfFQtelq4sjS166fAU
   Jl9G0DzM1FCtL1lUIasxxQA/CKzZFOSMkWAjKizlKche5lnxUNEGiN+TA
   YLzW2gm0jccrxVi3JzPchoCsVqrG2so9uLBBkRpjJxz+BpqvLM3qsOA9M
   mw4l4lCgklWCvhOdtHiXn9kgfLzDNoFEEPUe95PUrpPcB1gQCdfJaMIvi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="305416718"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="305416718"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 15:01:39 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="737000608"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="737000608"
Received: from cckuo-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.218.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 15:01:39 -0700
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] mm/userfaultfd: Replace kmap/kmap_atomic() with kmap_local_page()
Date:   Tue, 25 Oct 2022 15:01:36 -0700
Message-Id: <20221025220136.2366143-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

kmap() and kmap_atomic() are being deprecated in favor of
kmap_local_page() which is appropriate for any thread local context.[1]

A recent locking bug report with userfaultfd showed that the conversion
of the kmap_atomic()'s in those code flows requires care with regard to
the prevention of deadlock.[2]

git archaeology implied that the recursion may not be an actual bug.[3]
However, depending on the implementation of the mmap_lock and the
condition of the call there may still be a deadlock.[4]  So this is not
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
implementation is used a deadlock will not occur.

Complete kmap conversion in userfaultfd by replacing the kmap() and
kmap_atomic() calls with kmap_local_page().  When replacing the
kmap_atomic() call ensure page faults continue to be disabled to support
the correct fall back behavior and add a comment to inform future souls
of the requirement.

[1] https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com/
[2] https://lore.kernel.org/all/Y1Mh2S7fUGQ%2FiKFR@iweiny-desk3/
[3] https://lore.kernel.org/all/Y1MymJ%2FINb45AdaY@iweiny-desk3/
[4] https://lore.kernel.org/lkml/Y1bXBtGTCym77%2FoD@casper.infradead.org/

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V1
	Update the commit message and comment based on additional
	discussion

	Thanks to Matt for pointing out the deadlock potential despite
	recursive reads.
---
 mm/userfaultfd.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e24e8a47ce8a..3d0fef3980b3 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -157,11 +157,28 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 		if (!page)
 			goto out;
 
-		page_kaddr = kmap_atomic(page);
+		page_kaddr = kmap_local_page(page);
+		/*
+		 * The read mmap_lock is held here.  Despite the
+		 * mmap_lock being read recursive a deadlock is still
+		 * possible if a writer has taken a lock.  For example:
+		 *
+		 * process A thread 1 takes read lock on own mmap_lock
+		 * process A thread 2 calls mmap, blocks taking write lock
+		 * process B thread 1 takes page fault, read lock on own mmap lock
+		 * process B thread 2 calls mmap, blocks taking write lock
+		 * process A thread 1 blocks taking read lock on process B
+		 * process B thread 1 blocks taking read lock on process A
+		 *
+		 * Disable page faults to prevent potential deadlock
+		 * and retry the copy outside the mmap_lock.
+		 */
+		pagefault_disable();
 		ret = copy_from_user(page_kaddr,
 				     (const void __user *) src_addr,
 				     PAGE_SIZE);
-		kunmap_atomic(page_kaddr);
+		pagefault_enable();
+		kunmap_local(page_kaddr);
 
 		/* fallback to copy_from_user outside mmap_lock */
 		if (unlikely(ret)) {
@@ -646,11 +663,11 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 			mmap_read_unlock(dst_mm);
 			BUG_ON(!page);
 
-			page_kaddr = kmap(page);
+			page_kaddr = kmap_local_page(page);
 			err = copy_from_user(page_kaddr,
 					     (const void __user *) src_addr,
 					     PAGE_SIZE);
-			kunmap(page);
+			kunmap_local(page_kaddr);
 			if (unlikely(err)) {
 				err = -EFAULT;
 				goto out;
-- 
2.37.2

