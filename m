Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45F774B566
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjGGQxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjGGQxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:53:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EB5170C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 09:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688748785; x=1720284785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LCsBu7dWqfVmLSb5jMD4R7baYuKbw8fnATRe6XbxLRw=;
  b=nZ29caYEJWijKG7lMoGUS+iyKtJZ3Sti+0oCGDOMnfiKD2bMVlYERpFQ
   avGQDM50/gt4XwvoWFzmtoQDESmO8tl/Drh+aIiPztCWdrCqpFlkpY6xW
   lfCrlzzr/5E+dWJ0FlkKxVpjMEOPANz7nZLyZsOm9m3COG/IisSyWYjDh
   ItPCCn3Xe8MHeGdZ5pqSUC03oX8kska4p/bsRGokfOKH5inQ/duNTJdWA
   gseykZPa/BnbZCrUXk4D8cT3QSt1CPknEXgOp3JwJYvPpi1Ru+Ph0+2qs
   1PmiB9wpaLOPJmHCwg/RUOBgsLt9ejDZq+oWfaVY6skE3QHStdITYW365
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="427619015"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="427619015"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 09:53:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="966700777"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="966700777"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jul 2023 09:52:59 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yuzhao@google.com, ryan.roberts@arm.com, shy828301@gmail.com,
        akpm@linux-foundation.org, willy@infradead.org, david@redhat.com
Cc:     fengwei.yin@intel.com
Subject: [RFC PATCH 3/3] mm: mlock: update mlock_pte_range to handle large folio
Date:   Sat,  8 Jul 2023 00:52:21 +0800
Message-Id: <20230707165221.4076590-4-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230707165221.4076590-1-fengwei.yin@intel.com>
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current kernel only lock base size folio during mlock syscall.
Add large folio support with following rules:
  - Only mlock large folio when it's in VM_LOCKED VMA range

  - If there is cow folio, mlock the cow folio as cow folio
    is also in VM_LOCKED VMA range.

  - munlock will apply to the large folio which is in VMA range
    or cross the VMA boundary.

The last rule is used to handle the case that the large folio is
mlocked, later the VMA is split in the middle of large folio
and this large folio become cross VMA boundary.

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
---
 mm/mlock.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 95 insertions(+), 8 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index d7db94519884d..e09a481062ef5 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -305,6 +305,64 @@ void munlock_folio(struct folio *folio)
 	local_unlock(&mlock_fbatch.lock);
 }
 
+void mlock_folio_range(struct folio *folio, struct vm_area_struct *vma,
+		pte_t *pte, unsigned long addr, unsigned int nr)
+{
+	struct folio *cow_folio;
+	unsigned int step = 1;
+
+	mlock_folio(folio);
+	if (nr == 1)
+		return;
+
+	for (; nr > 0; pte += step, addr += (step << PAGE_SHIFT), nr -= step) {
+		pte_t ptent;
+
+		step = 1;
+		ptent = ptep_get(pte);
+
+		if (!pte_present(ptent))
+			continue;
+
+		cow_folio = vm_normal_folio(vma, addr, ptent);
+		if (!cow_folio || cow_folio == folio) {
+			continue;
+		}
+
+		mlock_folio(cow_folio);
+		step = min_t(unsigned int, nr, folio_nr_pages(cow_folio));
+	}
+}
+
+void munlock_folio_range(struct folio *folio, struct vm_area_struct *vma,
+		pte_t *pte, unsigned long addr, unsigned int nr)
+{
+	struct folio *cow_folio;
+	unsigned int step = 1;
+
+	munlock_folio(folio);
+	if (nr == 1)
+		return;
+
+	for (; nr > 0; pte += step, addr += (step << PAGE_SHIFT), nr -= step) {
+		pte_t ptent;
+
+		step = 1;
+		ptent = ptep_get(pte);
+
+		if (!pte_present(ptent))
+			continue;
+
+		cow_folio = vm_normal_folio(vma, addr, ptent);
+		if (!cow_folio || cow_folio == folio) {
+			continue;
+		}
+
+		munlock_folio(cow_folio);
+		step = min_t(unsigned int, nr, folio_nr_pages(cow_folio));
+	}
+}
+
 static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 			   unsigned long end, struct mm_walk *walk)
 
@@ -314,6 +372,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 	pte_t *start_pte, *pte;
 	pte_t ptent;
 	struct folio *folio;
+	unsigned int step = 1, nr;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -329,24 +388,52 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		goto out;
 	}
 
-	start_pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	pte = start_pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	if (!start_pte) {
 		walk->action = ACTION_AGAIN;
 		return 0;
 	}
-	for (pte = start_pte; addr != end; pte++, addr += PAGE_SIZE) {
+
+	for (; addr != end; pte += step, addr += (step << PAGE_SHIFT)) {
+		step = 1;
 		ptent = ptep_get(pte);
 		if (!pte_present(ptent))
 			continue;
 		folio = vm_normal_folio(vma, addr, ptent);
 		if (!folio || folio_is_zone_device(folio))
 			continue;
-		if (folio_test_large(folio))
-			continue;
-		if (vma->vm_flags & VM_LOCKED)
-			mlock_folio(folio);
-		else
-			munlock_folio(folio);
+
+		folio_get(folio);
+		nr = folio_nr_pages(folio) + folio_pfn(folio) - pte_pfn(ptent);
+		nr = min_t(unsigned int, nr, (end - addr) >> PAGE_SHIFT);
+
+		if (vma->vm_flags & VM_LOCKED) {
+			/*
+			 * Only mlock the 4K folio or large folio
+			 * in VMA range
+			 */
+			if (folio_test_large(folio) &&
+			    !folio_in_range(folio, vma,
+					vma->vm_start, vma->vm_end)) {
+				folio_put(folio);
+				continue;
+			}
+			mlock_folio_range(folio, vma, pte, addr, nr);
+		} else {
+			/*
+			 * Allow munlock large folio which is partially mapped
+			 * to VMA. As it's possible that large folio is mlocked
+			 * and VMA is split later.
+			 *
+			 * During memory pressure, such kind of large folio can
+			 * be split. And the pages are not in VM_LOCKed VMA
+			 * can be reclaimed.
+			 */
+			munlock_folio_range(folio, vma, pte, addr, nr);
+		}
+
+		step = nr;
+		folio_put(folio);
 	}
 	pte_unmap(start_pte);
 out:
-- 
2.39.2

