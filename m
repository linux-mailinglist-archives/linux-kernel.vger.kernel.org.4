Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B225C691489
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjBIXfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjBIXfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:35:22 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F066E8B;
        Thu,  9 Feb 2023 15:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675985695; x=1707521695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Lhw8ZtRWVlhOMwT0fnjXVLH8KzoyLq8BHXrBOWKlG8=;
  b=YaREexw57Q3SU/Qwkf6cL5JNAmtwYZnC2JufK+LZ7GQNjLfKZ9uDl0FM
   BS/FsG90ztCFez+jTIPHKZKL4RhJUcv+z9QQ4OLXpeFrCf5sVI1CVyp/f
   dB3vJTq6X0cga4/aKqTkWtGPpbGG25/0Apr252R+XCpol13ScROnZFoKE
   BXiW3L4FEnLp9YIiZHKaHwDZrdwt2Ll6166jNsTcCFjHuzKsthBLDSbWK
   xr7PUDZsZNdjTzRUxAcRtkH7Xhus4X9BowpAPmcP3WciGv4l5AMpwXF22
   MFYzjlPFQn/4jc6SctHPuisLNHhGP0upr3Lnf0OiWk6WNXPItRfqSLwdV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="416508742"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="416508742"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 15:33:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="756592049"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="756592049"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.13.232])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 15:33:10 -0800
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
Subject: [PATCH v6 5/6] cxl/trace: Add an HPA to cxl_poison trace events
Date:   Thu,  9 Feb 2023 15:32:58 -0800
Message-Id: <38b10009d7d222d871829f127b5651f0d6d9ca81.1675983077.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1675983077.git.alison.schofield@intel.com>
References: <cover.1675983077.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
cxl_poison hpa event field.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/trace.c | 94 ++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/trace.h |  9 +++-
 2 files changed, 102 insertions(+), 1 deletion(-)

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
index c493955719ce..e6114dd0a95c 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -614,6 +614,8 @@ TRACE_EVENT(cxl_memory_module,
 #define cxl_poison_host_name(cxlmd)					\
 	(dev_name(cxlmd->dev.parent))
 
+u64 cxl_trace_hpa(struct cxl_region *cxlr, struct cxl_memdev *memdev, u64 dpa);
+
 TRACE_EVENT(cxl_poison,
 
 	    TP_PROTO(struct cxl_memdev *cxlmd, struct cxl_region *region,
@@ -628,6 +630,7 @@ TRACE_EVENT(cxl_poison,
 		__field(u64, serial)
 		__string(region, region)
 		__field(u64, overflow_t)
+		__field(u64, hpa)
 		__field(u64, dpa)
 		__field(u32, length)
 		__array(char, uuid, 16)
@@ -647,18 +650,22 @@ TRACE_EVENT(cxl_poison,
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
 
-	    TP_printk("memdev=%s serial=%llu host=%s region=%s region_uuid=%pU dpa=0x%llx length=0x%x source=%s flags=%s overflow_time=%llu",
+	    TP_printk("memdev=%s serial=%llu host=%s region=%s region_uuid=%pU hpa=0x%llx dpa=0x%llx length=0x%x source=%s flags=%s overflow_time=%llu",
 		__get_str(memdev),
 		__entry->serial,
 		__get_str(host),
 		__get_str(region),
 		__entry->uuid,
+		__entry->hpa,
 		__entry->dpa,
 		__entry->length,
 		show_poison_source(__entry->source),
-- 
2.37.3

