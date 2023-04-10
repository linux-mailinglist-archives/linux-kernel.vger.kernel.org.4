Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9526DC405
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 09:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjDJHwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 03:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjDJHwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 03:52:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810383C0A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 00:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681113163; x=1712649163;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yr48j2bIPY5fAJkFuSojw587VB/8YMUbbc+kU0mekfQ=;
  b=ehW1Ke8YNasHU8DAH6yqxqgeZDpVMckFOJ/T4wB2X4WMH+YWEwdhc04S
   kErYOnoXHIqSe7fFmR5FTMKG14JNsYnMLJ47yn/2eUsqrD7PGXvjAs7g4
   eWn40cFEGmkzLqYsC+0Ah067Kyqvpw6UaO+K2ZErYZQKGpdShDyCvkph3
   xH0VzuW8vnu0+aDhkmiLUYSrTM+2fSvifrvR9XgCjG1Kbwmt5TPATvo8j
   nGAGrgmhEQFUZY2PXXStereMSkIle2YKFG/2oHA8+UxGMMGKFdXR385lO
   bDzBUY5bemDCzGgQmCl/QHL00V/NuEntF/fUgnmgxVTAN9ZAJXfcLkMeX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="345969183"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="345969183"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 00:52:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="681667638"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="681667638"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.7.50])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 00:52:40 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        kernel test robot <yujie.liu@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH] mm,unmap: avoid flushing TLB in batch if PTE is inaccessible
Date:   Mon, 10 Apr 2023 15:52:24 +0800
Message-Id: <20230410075224.827740-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0Day/LKP reported a performance regression for commit
7e12beb8ca2a ("migrate_pages: batch flushing TLB"). In the commit, the
TLB flushing during page migration is batched.  So, in
try_to_migrate_one(), ptep_clear_flush() is replaced with
set_tlb_ubc_flush_pending().  In further investigation, it is found
that the TLB flushing can be avoided in ptep_clear_flush() if the PTE
is inaccessible.  In fact, we can optimize in similar way for the
batched TLB flushing too to improve the performance.

So in this patch, we check pte_accessible() before
set_tlb_ubc_flush_pending() in try_to_unmap/migrate_one().  Tests show
that the benchmark score of the anon-cow-rand-mt test case of
vm-scalability test suite can improve up to 2.1% with the patch on a
Intel server machine.  The TLB flushing IPI can reduce up to 44.3%.

Link: https://lore.kernel.org/oe-lkp/202303192325.ecbaf968-yujie.liu@intel.com
Link: https://lore.kernel.org/oe-lkp/ab92aaddf1b52ede15e2c608696c36765a2602c1.camel@intel.com/
Fixes: 7e12beb8ca2a ("migrate_pages: batch flushing TLB")
Reported-by: kernel test robot <yujie.liu@intel.com>
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 8632e02661ac..3c7c43642d7c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1582,7 +1582,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 */
 				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
 
-				set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
+				if (pte_accessible(mm, pteval))
+					set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
 			} else {
 				pteval = ptep_clear_flush(vma, address, pvmw.pte);
 			}
@@ -1963,7 +1964,8 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				 */
 				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
 
-				set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
+				if (pte_accessible(mm, pteval))
+					set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
 			} else {
 				pteval = ptep_clear_flush(vma, address, pvmw.pte);
 			}
-- 
2.39.2

