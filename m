Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CED7217CE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 16:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjFDObU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 10:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjFDOal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 10:30:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5568FF2;
        Sun,  4 Jun 2023 07:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685889033; x=1717425033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9V/9npd3TrbSaeFGJk4xNZCWwd5hsd3TlFg4/mJcDbU=;
  b=Yd+MT395J7Qg+V43pbzCB+3e0hhcn/i9skN1bHKrWNzqWvkk9IjagLdI
   Hm2PhX2LktjbzoY6Snj4+UZILIwdBLZRgFr73sifSrM7Ucvl6ai3mC7yj
   zyZdfi2MfVYDO6qWXrsmgb7f/1MCgVZFzVNBq5hx87pzk3Beb0QSdAqTN
   SIeMgg9In1hBpNLJwzSb504WcuhcY6JmPiR1fXR3W4bcNJcbgjo97xUcf
   3PEyhyUWVopGTJb8A9BPT4YP7K2SS/rpUFL2ftBfj6x4QtYkAiDy8Z3kO
   TJZHhYcJlBtjvmXdre4AprtnJWwWrHOVjruZlryPIA4vE8bJmFf9s/K2Y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="353683635"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="353683635"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 07:29:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="1038501145"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="1038501145"
Received: from tdhastx-mobl2.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.50.31])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 07:28:55 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     linux-mm@kvack.org, dave.hansen@intel.com,
        kirill.shutemov@linux.intel.com, tony.luck@intel.com,
        peterz@infradead.org, tglx@linutronix.de, seanjc@google.com,
        pbonzini@redhat.com, david@redhat.com, dan.j.williams@intel.com,
        rafael.j.wysocki@intel.com, ying.huang@intel.com,
        reinette.chatre@intel.com, len.brown@intel.com, ak@linux.intel.com,
        isaku.yamahata@intel.com, chao.gao@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, bagasdotme@gmail.com,
        sagis@google.com, imammedo@redhat.com, kai.huang@intel.com
Subject: [PATCH v11 13/20] x86/virt/tdx: Designate reserved areas for all TDMRs
Date:   Mon,  5 Jun 2023 02:27:26 +1200
Message-Id: <409448809f7c78191aa27d6d2970ba1384c2d464.1685887183.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685887183.git.kai.huang@intel.com>
References: <cover.1685887183.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the last step of constructing TDMRs, populate reserved areas for all
TDMRs.  For each TDMR, put all memory holes within this TDMR to the
reserved areas.  And for all PAMTs which overlap with this TDMR, put
all the overlapping parts to reserved areas too.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
---

v10 -> v11:
 - No update

v9 -> v10:
 - No change.

v8 -> v9:
 - Added comment around 'tdmr_add_rsvd_area()' to point out it doesn't do
   optimization to save reserved areas. (Dave).

v7 -> v8: (Dave)
 - "set_up" -> "populate" in function name change (Dave).
 - Improved comment suggested by Dave.
 - Other changes due to 'struct tdmr_info_list'.

v6 -> v7:
 - No change.

v5 -> v6:
 - Rebase due to using 'tdx_memblock' instead of memblock.
 - Split tdmr_set_up_rsvd_areas() into two functions to handle memory
   hole and PAMT respectively.
 - Added Isaku's Reviewed-by.


---
 arch/x86/virt/vmx/tdx/tdx.c | 220 ++++++++++++++++++++++++++++++++++--
 1 file changed, 212 insertions(+), 8 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 5f0499ba5d67..0c2dedbc074c 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -25,6 +25,7 @@
 #include <linux/sizes.h>
 #include <linux/pfn.h>
 #include <linux/align.h>
+#include <linux/sort.h>
 #include <asm/msr-index.h>
 #include <asm/msr.h>
 #include <asm/archrandom.h>
@@ -669,6 +670,210 @@ static unsigned long tdmrs_count_pamt_pages(struct tdmr_info_list *tdmr_list)
 	return pamt_npages;
 }
 
+static int tdmr_add_rsvd_area(struct tdmr_info *tdmr, int *p_idx, u64 addr,
+			      u64 size, u16 max_reserved_per_tdmr)
+{
+	struct tdmr_reserved_area *rsvd_areas = tdmr->reserved_areas;
+	int idx = *p_idx;
+
+	/* Reserved area must be 4K aligned in offset and size */
+	if (WARN_ON(addr & ~PAGE_MASK || size & ~PAGE_MASK))
+		return -EINVAL;
+
+	if (idx >= max_reserved_per_tdmr) {
+		pr_warn("initialization failed: TDMR [0x%llx, 0x%llx): reserved areas exhausted.\n",
+				tdmr->base, tdmr_end(tdmr));
+		return -ENOSPC;
+	}
+
+	/*
+	 * Consume one reserved area per call.  Make no effort to
+	 * optimize or reduce the number of reserved areas which are
+	 * consumed by contiguous reserved areas, for instance.
+	 */
+	rsvd_areas[idx].offset = addr - tdmr->base;
+	rsvd_areas[idx].size = size;
+
+	*p_idx = idx + 1;
+
+	return 0;
+}
+
+/*
+ * Go through @tmb_list to find holes between memory areas.  If any of
+ * those holes fall within @tdmr, set up a TDMR reserved area to cover
+ * the hole.
+ */
+static int tdmr_populate_rsvd_holes(struct list_head *tmb_list,
+				    struct tdmr_info *tdmr,
+				    int *rsvd_idx,
+				    u16 max_reserved_per_tdmr)
+{
+	struct tdx_memblock *tmb;
+	u64 prev_end;
+	int ret;
+
+	/*
+	 * Start looking for reserved blocks at the
+	 * beginning of the TDMR.
+	 */
+	prev_end = tdmr->base;
+	list_for_each_entry(tmb, tmb_list, list) {
+		u64 start, end;
+
+		start = PFN_PHYS(tmb->start_pfn);
+		end   = PFN_PHYS(tmb->end_pfn);
+
+		/* Break if this region is after the TDMR */
+		if (start >= tdmr_end(tdmr))
+			break;
+
+		/* Exclude regions before this TDMR */
+		if (end < tdmr->base)
+			continue;
+
+		/*
+		 * Skip over memory areas that
+		 * have already been dealt with.
+		 */
+		if (start <= prev_end) {
+			prev_end = end;
+			continue;
+		}
+
+		/* Add the hole before this region */
+		ret = tdmr_add_rsvd_area(tdmr, rsvd_idx, prev_end,
+				start - prev_end,
+				max_reserved_per_tdmr);
+		if (ret)
+			return ret;
+
+		prev_end = end;
+	}
+
+	/* Add the hole after the last region if it exists. */
+	if (prev_end < tdmr_end(tdmr)) {
+		ret = tdmr_add_rsvd_area(tdmr, rsvd_idx, prev_end,
+				tdmr_end(tdmr) - prev_end,
+				max_reserved_per_tdmr);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * Go through @tdmr_list to find all PAMTs.  If any of those PAMTs
+ * overlaps with @tdmr, set up a TDMR reserved area to cover the
+ * overlapping part.
+ */
+static int tdmr_populate_rsvd_pamts(struct tdmr_info_list *tdmr_list,
+				    struct tdmr_info *tdmr,
+				    int *rsvd_idx,
+				    u16 max_reserved_per_tdmr)
+{
+	int i, ret;
+
+	for (i = 0; i < tdmr_list->nr_consumed_tdmrs; i++) {
+		struct tdmr_info *tmp = tdmr_entry(tdmr_list, i);
+		unsigned long pamt_start_pfn, pamt_npages;
+		u64 pamt_start, pamt_end;
+
+		tdmr_get_pamt(tmp, &pamt_start_pfn, &pamt_npages);
+		/* Each TDMR must already have PAMT allocated */
+		WARN_ON_ONCE(!pamt_npages || !pamt_start_pfn);
+
+		pamt_start = PFN_PHYS(pamt_start_pfn);
+		pamt_end   = PFN_PHYS(pamt_start_pfn + pamt_npages);
+
+		/* Skip PAMTs outside of the given TDMR */
+		if ((pamt_end <= tdmr->base) ||
+				(pamt_start >= tdmr_end(tdmr)))
+			continue;
+
+		/* Only mark the part within the TDMR as reserved */
+		if (pamt_start < tdmr->base)
+			pamt_start = tdmr->base;
+		if (pamt_end > tdmr_end(tdmr))
+			pamt_end = tdmr_end(tdmr);
+
+		ret = tdmr_add_rsvd_area(tdmr, rsvd_idx, pamt_start,
+				pamt_end - pamt_start,
+				max_reserved_per_tdmr);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* Compare function called by sort() for TDMR reserved areas */
+static int rsvd_area_cmp_func(const void *a, const void *b)
+{
+	struct tdmr_reserved_area *r1 = (struct tdmr_reserved_area *)a;
+	struct tdmr_reserved_area *r2 = (struct tdmr_reserved_area *)b;
+
+	if (r1->offset + r1->size <= r2->offset)
+		return -1;
+	if (r1->offset >= r2->offset + r2->size)
+		return 1;
+
+	/* Reserved areas cannot overlap.  The caller must guarantee. */
+	WARN_ON_ONCE(1);
+	return -1;
+}
+
+/*
+ * Populate reserved areas for the given @tdmr, including memory holes
+ * (via @tmb_list) and PAMTs (via @tdmr_list).
+ */
+static int tdmr_populate_rsvd_areas(struct tdmr_info *tdmr,
+				    struct list_head *tmb_list,
+				    struct tdmr_info_list *tdmr_list,
+				    u16 max_reserved_per_tdmr)
+{
+	int ret, rsvd_idx = 0;
+
+	ret = tdmr_populate_rsvd_holes(tmb_list, tdmr, &rsvd_idx,
+			max_reserved_per_tdmr);
+	if (ret)
+		return ret;
+
+	ret = tdmr_populate_rsvd_pamts(tdmr_list, tdmr, &rsvd_idx,
+			max_reserved_per_tdmr);
+	if (ret)
+		return ret;
+
+	/* TDX requires reserved areas listed in address ascending order */
+	sort(tdmr->reserved_areas, rsvd_idx, sizeof(struct tdmr_reserved_area),
+			rsvd_area_cmp_func, NULL);
+
+	return 0;
+}
+
+/*
+ * Populate reserved areas for all TDMRs in @tdmr_list, including memory
+ * holes (via @tmb_list) and PAMTs.
+ */
+static int tdmrs_populate_rsvd_areas_all(struct tdmr_info_list *tdmr_list,
+					 struct list_head *tmb_list,
+					 u16 max_reserved_per_tdmr)
+{
+	int i;
+
+	for (i = 0; i < tdmr_list->nr_consumed_tdmrs; i++) {
+		int ret;
+
+		ret = tdmr_populate_rsvd_areas(tdmr_entry(tdmr_list, i),
+				tmb_list, tdmr_list, max_reserved_per_tdmr);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /*
  * Construct a list of TDMRs on the preallocated space in @tdmr_list
  * to cover all TDX memory regions in @tmb_list based on the TDX module
@@ -688,14 +893,13 @@ static int construct_tdmrs(struct list_head *tmb_list,
 			sysinfo->pamt_entry_size);
 	if (ret)
 		return ret;
-	/*
-	 * TODO:
-	 *
-	 *  - Designate reserved areas for each TDMR.
-	 *
-	 * Return -EINVAL until constructing TDMRs is done
-	 */
-	return -EINVAL;
+
+	ret = tdmrs_populate_rsvd_areas_all(tdmr_list, tmb_list,
+			sysinfo->max_reserved_per_tdmr);
+	if (ret)
+		tdmrs_free_pamt_all(tdmr_list);
+
+	return ret;
 }
 
 static int init_tdx_module(void)
-- 
2.40.1

