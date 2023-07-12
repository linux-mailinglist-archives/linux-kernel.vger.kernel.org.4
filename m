Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4901174FEEF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjGLGCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjGLGCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:02:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B031995
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689141743; x=1720677743;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q8YW+Ak1aFSHS6ap1YknDbUFbazLnvkg+GE8oMd5GIc=;
  b=enRLnjAyfbywbEY81IxqlMNG7o2X8GJXfjfhkjMMe30vy9nHF5QIlrLO
   pk7GQQEcbmRTdT7CRnEMrEDTyuHlAQvNKVwSRogWVSJ+Xb8K/gDvEx6Ld
   AcFFP5iC+aQgBHb1nPrlvlP1Dp6BnAjYunmHyexrcpRtBlFamgq6gvGbk
   A0C3HwsITopl4phQz+mzoL3Iau5PNh2IIMiMPXaOirR6XDBP68Hw3801M
   wCH5yjghn1s57dln24wKUlhptM6beOsXshyjvOnU9Ybrv/1chhBEwCkPE
   Ja1Ce058+MAMmBCUlb3WKNlzYYk81R8p1ii39aJKKvBrDdvNmnm02uqly
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="349662855"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="349662855"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 23:02:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="865994265"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="865994265"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jul 2023 23:02:20 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, yuzhao@google.com, willy@infradead.org,
        david@redhat.com, ryan.roberts@arm.com, shy828301@gmail.com
Cc:     fengwei.yin@intel.com
Subject: [RFC PATCH v2 3/3] mm: mlock: update mlock_pte_range to handle large folio
Date:   Wed, 12 Jul 2023 14:01:44 +0800
Message-Id: <20230712060144.3006358-4-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230712060144.3006358-1-fengwei.yin@intel.com>
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 mm/mlock.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 99 insertions(+), 5 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 0a0c996c5c214..f49e079066870 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -305,6 +305,95 @@ void munlock_folio(struct folio *folio)
 	local_unlock(&mlock_fbatch.lock);
 }
 
+static inline bool should_mlock_folio(struct folio *folio,
+					struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_LOCKED)
+		return (!folio_test_large(folio) ||
+				folio_within_vma(folio, vma));
+
+	/*
+	 * For unlock, allow munlock large folio which is partially
+	 * mapped to VMA. As it's possible that large folio is
+	 * mlocked and VMA is split later.
+	 *
+	 * During memory pressure, such kind of large folio can
+	 * be split. And the pages are not in VM_LOCKed VMA
+	 * can be reclaimed.
+	 */
+
+	return true;
+}
+
+static inline unsigned int get_folio_mlock_step(struct folio *folio,
+			pte_t pte, unsigned long addr, unsigned long end)
+{
+	unsigned int nr;
+
+	nr = folio_pfn(folio) + folio_nr_pages(folio) - pte_pfn(pte);
+	return min_t(unsigned int, nr, (end - addr) >> PAGE_SHIFT);
+}
+
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
+		step = get_folio_mlock_step(folio, ptent,
+				addr, addr + (nr << PAGE_SHIFT));
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
+		step = get_folio_mlock_step(folio, ptent,
+				addr, addr + (nr << PAGE_SHIFT));
+	}
+}
+
 static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 			   unsigned long end, struct mm_walk *walk)
 
@@ -314,6 +403,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 	pte_t *start_pte, *pte;
 	pte_t ptent;
 	struct folio *folio;
+	unsigned int step = 1;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -329,24 +419,28 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
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
+		if (!should_mlock_folio(folio, vma))
 			continue;
+
+		step = get_folio_mlock_step(folio, ptent, addr, end);
 		if (vma->vm_flags & VM_LOCKED)
-			mlock_folio(folio);
+			mlock_folio_range(folio, vma, pte, addr, step);
 		else
-			munlock_folio(folio);
+			munlock_folio_range(folio, vma, pte, addr, step);
 	}
 	pte_unmap(start_pte);
 out:
-- 
2.39.2

