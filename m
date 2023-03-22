Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED256C4034
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 03:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjCVCMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 22:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjCVCMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 22:12:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EADD59E78;
        Tue, 21 Mar 2023 19:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679451150; x=1710987150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d5+ARMmBof95SW/XWt8S0qx0BIpgv7FSIaxuKpr/WFU=;
  b=DuRhPby4Ch2xIiHEECkuRsKKJOUoK/CjrHc0MSQ7APu1C9quxUw/ryq+
   /VPL8llzHtnRQIx9BPapNGJuXimeOCBsXk4JJettSog4RZrE20QhmaGw3
   tH08UWFkAsbjKHnEaB7ghe6VThnGrT13zSv5s0FdraDWaj1HK9WNZpKE3
   81OmHKPPK/r7Nju/Pf+Tch/a2ZStOw3kHRy2MlSlvNqhmzSz5EMHBai9Z
   fYJt6wCS01DsP0OgTtLpBtpO50mpL4kO0R7Kmp8TxBAQpzBe0FSWEcPlE
   RvRw9TVYnunewQlYIA9hxx6IuTvy4VPwq55IhPggMQAinZr841pI0lPyU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="322949646"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="322949646"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 19:12:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="805663244"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="805663244"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.251.21.85])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 19:12:28 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v10 5/6] cxl/trace: Add an HPA to cxl_poison trace events
Date:   Tue, 21 Mar 2023 19:12:18 -0700
Message-Id: <bc5a756a9c4d3a6d6147e3959dadfb482afa3324.1679448904.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1679448904.git.alison.schofield@intel.com>
References: <cover.1679448904.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

When a cxl_poison trace event is reported for a region, the poisoned
Device Physical Address (DPA) can be translated to a Host Physical
Address (HPA) for consumption by user space.

Translate and add the resulting HPA to the cxl_poison trace event.
Follow the device decode logic as defined in the CXL Spec 3.0 Section
8.2.4.19.13.

If no region currently maps the poison, assign ULLONG_MAX to the
cxl_poison event hpa field.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/trace.c | 94 ++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/trace.h |  7 +++
 2 files changed, 101 insertions(+)

diff --git a/drivers/cxl/core/trace.c b/drivers/cxl/core/trace.c
index 29ae7ce81dc5..d0403dc3c8ab 100644
--- a/drivers/cxl/core/trace.c
+++ b/drivers/cxl/core/trace.c
@@ -1,5 +1,99 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
 
+#include <cxl.h>
+#include "core.h"
+
 #define CREATE_TRACE_POINTS
 #include "trace.h"
+
+static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	int gran = p->interleave_granularity;
+	int ways = p->interleave_ways;
+	u64 offset;
+
+	/* Is the hpa within this region at all */
+	if (hpa < p->res->start || hpa > p->res->end) {
+		dev_dbg(&cxlr->dev,
+			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
+		return false;
+	}
+
+	/* Is the hpa in an expected chunk for its pos(-ition) */
+	offset = hpa - p->res->start;
+	offset = do_div(offset, gran * ways);
+	if ((offset >= pos * gran) && (offset < (pos + 1) * gran))
+		return true;
+
+	dev_dbg(&cxlr->dev,
+		"Addr trans fail: hpa 0x%llx not in expected chunk\n", hpa);
+
+	return false;
+}
+
+static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
+			  struct cxl_endpoint_decoder *cxled)
+{
+	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
+	struct cxl_region_params *p = &cxlr->params;
+	int pos = cxled->pos;
+	u16 eig = 0;
+	u8 eiw = 0;
+
+	ways_to_eiw(p->interleave_ways, &eiw);
+	granularity_to_eig(p->interleave_granularity, &eig);
+
+	/*
+	 * The device position in the region interleave set was removed
+	 * from the offset at HPA->DPA translation. To reconstruct the
+	 * HPA, place the 'pos' in the offset.
+	 *
+	 * The placement of 'pos' in the HPA is determined by interleave
+	 * ways and granularity and is defined in the CXL Spec 3.0 Section
+	 * 8.2.4.19.13 Implementation Note: Device Decode Logic
+	 */
+
+	/* Remove the dpa base */
+	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
+
+	mask_upper = GENMASK_ULL(51, eig + 8);
+
+	if (eiw < 8) {
+		hpa_offset = (dpa_offset & mask_upper) << eiw;
+		hpa_offset |= pos << (eig + 8);
+	} else {
+		bits_upper = (dpa_offset & mask_upper) >> (eig + 8);
+		bits_upper = bits_upper * 3;
+		hpa_offset = ((bits_upper << (eiw - 8)) + pos) << (eig + 8);
+	}
+
+	/* The lower bits remain unchanged */
+	hpa_offset |= dpa_offset & GENMASK_ULL(eig + 7, 0);
+
+	/* Apply the hpa_offset to the region base address */
+	hpa = hpa_offset + p->res->start;
+
+	if (!cxl_is_hpa_in_range(hpa, cxlr, cxled->pos))
+		return ULLONG_MAX;
+
+	return hpa;
+}
+
+u64 cxl_trace_hpa(struct cxl_region *cxlr, struct cxl_memdev *cxlmd,
+		  u64 dpa)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_endpoint_decoder *cxled = NULL;
+
+	for (int i = 0; i <  p->nr_targets; i++) {
+		cxled = p->targets[i];
+		if (cxlmd == cxled_to_memdev(cxled))
+			break;
+	}
+	if (!cxled || cxlmd != cxled_to_memdev(cxled))
+		return ULLONG_MAX;
+
+	return cxl_dpa_to_hpa(dpa, cxlr, cxled);
+}
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 2ebfa55c31a8..c88f3e2931d1 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -636,6 +636,8 @@ TRACE_EVENT(cxl_memory_module,
 #define cxl_poison_overflow(flags, time)				\
 	(flags & CXL_POISON_FLAG_OVERFLOW ? le64_to_cpu(time) : 0)
 
+u64 cxl_trace_hpa(struct cxl_region *cxlr, struct cxl_memdev *memdev, u64 dpa);
+
 TRACE_EVENT(cxl_poison,
 
 	TP_PROTO(struct cxl_memdev *cxlmd, struct cxl_region *region,
@@ -651,6 +653,7 @@ TRACE_EVENT(cxl_poison,
 		__field(u8, type)
 		__string(region, region)
 		__field(u64, overflow_t)
+		__field(u64, hpa)
 		__field(u64, dpa)
 		__field(u32, dpa_length)
 		__array(char, uuid, 16)
@@ -671,9 +674,12 @@ TRACE_EVENT(cxl_poison,
 		if (region) {
 			__assign_str(region, dev_name(&region->dev));
 			memcpy(__entry->uuid, &region->params.uuid, 16);
+			__entry->hpa = cxl_trace_hpa(region, cxlmd,
+						     __entry->dpa);
 		} else {
 			__assign_str(region, "");
 			memset(__entry->uuid, 0, 16);
+			__entry->hpa = ULLONG_MAX;
 		}
 	    ),
 
@@ -686,6 +692,7 @@ TRACE_EVENT(cxl_poison,
 		show_poison_trace_type(__entry->type),
 		__get_str(region),
 		__entry->uuid,
+		__entry->hpa,
 		__entry->dpa,
 		__entry->dpa_length,
 		show_poison_source(__entry->source),
-- 
2.37.3

