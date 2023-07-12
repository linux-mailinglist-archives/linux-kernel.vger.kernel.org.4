Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3658A74FEEE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjGLGCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjGLGCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:02:17 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C772F198A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689141730; x=1720677730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bgQflrx8qMg9vkqGlfihJRy1xgfAbAds62AMD1mGmM4=;
  b=FvPwCiTQ2ewOzBpaDjqFetT9isTYHhpAjobWoHZFeIe6ep3ztCH19Ivb
   HwavmLE6K5tpFAHGpCl9gLrlUIO86Hu4bpaQHM5vFzoSqw/0sip947DEb
   v/GqNwmNSHzHsOXFTTeiBg/xMFKtubFyY587jPVcxWUlJ1YlqlBD1UL73
   45TaGFtOkIz/5LQL9iVU2D6N+2MH4innH2+N977o9rYInXR42z3XrSjMl
   bE7OxDR4p6pvixxAa7G5PGwrkors1Egl2usSZhabG4nJyGOg1/OtVtW5p
   vsMDOZX+f41IOJE0TLfGLil/F6I8tf3uPAqVWsszJPqaYkwq4g83C+0K4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="363673767"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="363673767"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 23:02:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="1052051350"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="1052051350"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jul 2023 23:02:06 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, yuzhao@google.com, willy@infradead.org,
        david@redhat.com, ryan.roberts@arm.com, shy828301@gmail.com
Cc:     fengwei.yin@intel.com
Subject: [RFC PATCH v2 2/3] mm: handle large folio when large folio in VM_LOCKED VMA range
Date:   Wed, 12 Jul 2023 14:01:43 +0800
Message-Id: <20230712060144.3006358-3-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230712060144.3006358-1-fengwei.yin@intel.com>
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
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

If large folio is in the range of VM_LOCKED VMA, it should be
mlocked to avoid being picked by page reclaim. Which may split
the large folio and then mlock each pages again.

Mlock this kind of large folio to prevent them being picked by
page reclaim.

For the large folio which cross the boundary of VM_LOCKED VMA,
we'd better not to mlock it. So if the system is under memory
pressure, this kind of large folio will be split and the pages
ouf of VM_LOCKED VMA can be reclaimed.

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
---
 mm/internal.h | 11 ++++++++---
 mm/rmap.c     | 34 +++++++++++++++++++++++++++-------
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index c7dd15d8de3ef..776141de2797a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -643,7 +643,8 @@ static inline void mlock_vma_folio(struct folio *folio,
 	 *    still be set while VM_SPECIAL bits are added: so ignore it then.
 	 */
 	if (unlikely((vma->vm_flags & (VM_LOCKED|VM_SPECIAL)) == VM_LOCKED) &&
-	    (compound || !folio_test_large(folio)))
+	    (compound || !folio_test_large(folio) ||
+	    folio_in_range(folio, vma, vma->vm_start, vma->vm_end)))
 		mlock_folio(folio);
 }
 
@@ -651,8 +652,12 @@ void munlock_folio(struct folio *folio);
 static inline void munlock_vma_folio(struct folio *folio,
 			struct vm_area_struct *vma, bool compound)
 {
-	if (unlikely(vma->vm_flags & VM_LOCKED) &&
-	    (compound || !folio_test_large(folio)))
+	/*
+	 * To handle the case that a mlocked large folio is unmapped from VMA
+	 * piece by piece, allow munlock the large folio which is partially
+	 * mapped to VMA.
+	 */
+	if (unlikely(vma->vm_flags & VM_LOCKED))
 		munlock_folio(folio);
 }
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 2668f5ea35342..455f415d8d9ca 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -803,6 +803,14 @@ struct folio_referenced_arg {
 	unsigned long vm_flags;
 	struct mem_cgroup *memcg;
 };
+
+static inline bool should_restore_mlock(struct folio *folio,
+		struct vm_area_struct *vma, bool pmd_mapped)
+{
+	return !folio_test_large(folio) ||
+			pmd_mapped || folio_within_vma(folio, vma);
+}
+
 /*
  * arg: folio_referenced_arg will be passed
  */
@@ -816,13 +824,25 @@ static bool folio_referenced_one(struct folio *folio,
 	while (page_vma_mapped_walk(&pvmw)) {
 		address = pvmw.address;
 
-		if ((vma->vm_flags & VM_LOCKED) &&
-		    (!folio_test_large(folio) || !pvmw.pte)) {
-			/* Restore the mlock which got missed */
-			mlock_vma_folio(folio, vma, !pvmw.pte);
-			page_vma_mapped_walk_done(&pvmw);
-			pra->vm_flags |= VM_LOCKED;
-			return false; /* To break the loop */
+		if (vma->vm_flags & VM_LOCKED) {
+			if (should_restore_mlock(folio, vma, !pvmw.pte)) {
+				/* Restore the mlock which got missed */
+				mlock_vma_folio(folio, vma, !pvmw.pte);
+				page_vma_mapped_walk_done(&pvmw);
+				pra->vm_flags |= VM_LOCKED;
+				return false; /* To break the loop */
+			} else {
+				/*
+				 * For large folio cross VMA boundaries, it's
+				 * expected to be picked  by page reclaim. But
+				 * should skip reference of pages which are in
+				 * the range of VM_LOCKED vma. As page reclaim
+				 * should just count the reference of pages out
+				 * the range of VM_LOCKED vma.
+				 */
+				pra->mapcount--;
+				continue;
+			}
 		}
 
 		if (pvmw.pte) {
-- 
2.39.2

