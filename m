Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D626EC697
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 08:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjDXGyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 02:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjDXGyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 02:54:32 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3397186
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 23:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682319264; x=1713855264;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lFIM3SiRtcb8O9YKp++Jg0PUJfBH52f31PGcowvaHDw=;
  b=PZ4TEOolTCYZhG1jEFX1qAgyGQ3SIJY3eMU6LFxYCtZ0WJUhj651macz
   PZjyR1CpoDC7Rl+ZRe8MNBmPE6toJPWRGtpzTEjBiHcHHBQYqZmg4Wyvr
   X+wV1dp98qBIC7u/1EScT1Tps4fL+GOi5WkOqqHJhWVs1+9XAqHzQ3KKT
   Hu03xgL794ro6cqTUveB71D0XVAe6pJ14MmMM94aHgySEsl/irYYud/Bn
   s5XNkglXyw2zBonhxjmUREqt9JXk7ZHVFQadvyxmvvs8r9PlSgVMh0jSN
   GLcfla7nvz/GCHnLR0g6wmmfQ2UjnfmGrsaTCqTxm/RgnKBlZfyQrjgAF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="326696563"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="326696563"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 23:54:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="867376670"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="867376670"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.7.50])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 23:54:19 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        kernel test robot <yujie.liu@intel.com>,
        haoxin <xhao@linux.alibaba.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH -V2] mm,unmap: avoid flushing TLB in batch if PTE is inaccessible
Date:   Mon, 24 Apr 2023 14:54:08 +0800
Message-Id: <20230424065408.188498-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew,

The version 1 of this patch was merged in mm-unstable branch.  If you
want to move that patch into mm-stable recently, it may be better to
update that patch with this new version firstly.  If you want to do
that after v6.4-rc1, I will rebase this patch and resend it after
v6.4-rc1 is released.

Hi, Amit,

The patch has been changed based on comments from Xin.  I keep your
"reviewed-by" because I think the change is trivial.  But if you think
it's inappropriate,  I will change that.

Best Regards,
Huang, Ying

------------------------------->8------------------------------------------
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
Reviewed-by: Nadav Amit <namit@vmware.com>
Cc: haoxin <xhao@linux.alibaba.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 8632e02661ac..be19232e94f4 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -641,10 +641,14 @@ void try_to_unmap_flush_dirty(void)
 #define TLB_FLUSH_BATCH_PENDING_LARGE			\
 	(TLB_FLUSH_BATCH_PENDING_MASK / 2)
 
-static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
+static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
 	int batch, nbatch;
+	bool writable = pte_dirty(pteval);
+
+	if (!pte_accessible(mm, pteval))
+		return;
 
 	arch_tlbbatch_add_mm(&tlb_ubc->arch, mm);
 	tlb_ubc->flush_required = true;
@@ -731,7 +735,7 @@ void flush_tlb_batched_pending(struct mm_struct *mm)
 	}
 }
 #else
-static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
+static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval)
 {
 }
 
@@ -1582,7 +1586,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 */
 				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
 
-				set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
+				set_tlb_ubc_flush_pending(mm, pteval);
 			} else {
 				pteval = ptep_clear_flush(vma, address, pvmw.pte);
 			}
@@ -1963,7 +1967,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				 */
 				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
 
-				set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
+				set_tlb_ubc_flush_pending(mm, pteval);
 			} else {
 				pteval = ptep_clear_flush(vma, address, pvmw.pte);
 			}
-- 
2.39.2

