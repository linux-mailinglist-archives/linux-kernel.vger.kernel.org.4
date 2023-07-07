Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4140A74B568
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjGGQx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjGGQxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:53:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35441999
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 09:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688748794; x=1720284794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hMAoCmMSZm9wJK0rzWzlbRvlWfE6c9KZJN6MJC4MnjE=;
  b=CojC+sZYhmdBz9pGBf1Io4qGyE8KDj03MdnKaefDYGPb+BdV0ouzfVe2
   Lw0uhrREbrfPNzcmjkyUFmocHb2GAWrB011GjhCAk49F+leiaaiPCauvF
   fz2knFeShT9GhGbbdL8Q0k2E2J6m/wc4ob6Z8PPQ2bVxFnUtiqzi5yzqY
   FY0y3t0tHl6TPZjSRyr7dMHipy67XDR8zgvSO9cL3TGpaaVVvp0f5Vmv2
   KitVVlA0HH0UBm+Qqtpp4eB6qDqySv73XjhRWve6Myaiv0hnbp34VcNV7
   jtQdh+QogtKLM56ceFI6SlP1R7n3nAzTQ9Q/BsahSiDyO1s0MnUG/Pj67
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="367422312"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="367422312"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 09:52:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="790040971"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="790040971"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by fmsmga004.fm.intel.com with ESMTP; 07 Jul 2023 09:52:46 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yuzhao@google.com, ryan.roberts@arm.com, shy828301@gmail.com,
        akpm@linux-foundation.org, willy@infradead.org, david@redhat.com
Cc:     fengwei.yin@intel.com
Subject: [RFC PATCH 2/3] mm: handle large folio when large folio in VM_LOCKED VMA range
Date:   Sat,  8 Jul 2023 00:52:20 +0800
Message-Id: <20230707165221.4076590-3-fengwei.yin@intel.com>
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
 mm/rmap.c     |  3 ++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 66117523d7d71..c7b8f0b008d81 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -637,7 +637,8 @@ static inline void mlock_vma_folio(struct folio *folio,
 	 *    still be set while VM_SPECIAL bits are added: so ignore it then.
 	 */
 	if (unlikely((vma->vm_flags & (VM_LOCKED|VM_SPECIAL)) == VM_LOCKED) &&
-	    (compound || !folio_test_large(folio)))
+	    (compound || !folio_test_large(folio) ||
+	    folio_in_range(folio, vma, vma->vm_start, vma->vm_end)))
 		mlock_folio(folio);
 }
 
@@ -645,8 +646,12 @@ void munlock_folio(struct folio *folio);
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
index 2668f5ea35342..7d6547d1bd096 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -817,7 +817,8 @@ static bool folio_referenced_one(struct folio *folio,
 		address = pvmw.address;
 
 		if ((vma->vm_flags & VM_LOCKED) &&
-		    (!folio_test_large(folio) || !pvmw.pte)) {
+		    (!folio_test_large(folio) || !pvmw.pte ||
+		    folio_in_range(folio, vma, vma->vm_start, vma->vm_end))) {
 			/* Restore the mlock which got missed */
 			mlock_vma_folio(folio, vma, !pvmw.pte);
 			page_vma_mapped_walk_done(&pvmw);
-- 
2.39.2

