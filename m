Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785D06728ED
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjARUCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjARUCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:02:33 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD45056EE0;
        Wed, 18 Jan 2023 12:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674072151; x=1705608151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HKeKdBveLNMyOzNUEGqYsJRXOdPN9/L54tMdLNvwiBs=;
  b=aqwEOJTNyK12ZfB0HyYZFJWinWCjsleBgu9lOiajgeE80RGiuGPEYHHr
   pySV3UvZlODsbX4DH8L4Ds0IKNMQPOXHPr1t+ej9Ckx+1chw+C1/pLJ9K
   V4AmErlpMiiRKIYwcIgHcBtWQuBldjgMX9ugD4vQALOYTqYG+C0tSb5cC
   EAKPZO+RspbEhtdj0KwQ/OEN2Sbrb6wbFaQqpIIx4655r5fIsOQlL/41T
   98lYfcj7Pu+Gd1akU9vsYkDUBAFZEPxuRi4wQBNQeISj8UbRRFFjJ3wQu
   aTDtCaw2Qqg+fATiDu6KdlErtQv+Fz6QPMqWDP6lukxmbFxaN+BQ1P13H
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322776781"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="322776781"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 12:02:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="661861680"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="661861680"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.119.104])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 12:02:26 -0800
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
Subject: [PATCH v5 2/5] cxl/trace: Add TRACE support for CXL media-error records
Date:   Wed, 18 Jan 2023 12:02:18 -0800
Message-Id: <b81085e4ea3888abb0ae92c1eed6776ac76a35ae.1674070170.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1674070170.git.alison.schofield@intel.com>
References: <cover.1674070170.git.alison.schofield@intel.com>
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

CXL devices may support the retrieval of a device poison list.
Add a new trace event that the CXL subsystem may use to log
the media-error records returned in the poison list.

Log each media-error record as a trace event of type 'cxl_poison'.

When the poison list is requested by region, include the region name
and uuid in the trace event.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/mbox.c  |  6 ++-
 drivers/cxl/core/trace.h | 83 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index a38be141e108..19b0029bbe71 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -10,6 +10,7 @@
 #include <cxl.h>
 
 #include "core.h"
+#include "trace.h"
 
 static bool cxl_raw_allow_all;
 
@@ -898,7 +899,10 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		if (rc)
 			break;
 
-		/* TODO TRACE the media error records */
+		for (int i = 0; i < le16_to_cpu(po->count); i++)
+			trace_cxl_poison(cxlmd, to_pci_dev(cxlds->dev),
+					 cxlr, &po->record[i], po->flags,
+					 po->overflow_t);
 
 		/* Protect against an uncleared _FLAG_MORE */
 		nr_records = nr_records + le16_to_cpu(po->count);
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 20ca2fe2ca8e..c7958311ce5f 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -8,6 +8,9 @@
 
 #include <cxl.h>
 #include <linux/tracepoint.h>
+#include <linux/pci.h>
+
+#include <cxlmem.h>
 
 #define CXL_RAS_UC_CACHE_DATA_PARITY	BIT(0)
 #define CXL_RAS_UC_CACHE_ADDR_PARITY	BIT(1)
@@ -103,6 +106,86 @@ TRACE_EVENT(cxl_aer_correctable_error,
 	)
 );
 
+#define __show_poison_source(source)                          \
+	__print_symbolic(source,                              \
+		{ CXL_POISON_SOURCE_UNKNOWN,   "Unknown"  },  \
+		{ CXL_POISON_SOURCE_EXTERNAL,  "External" },  \
+		{ CXL_POISON_SOURCE_INTERNAL,  "Internal" },  \
+		{ CXL_POISON_SOURCE_INJECTED,  "Injected" },  \
+		{ CXL_POISON_SOURCE_VENDOR,    "Vendor"   })
+
+#define show_poison_source(source)			     \
+	(((source > CXL_POISON_SOURCE_INJECTED) &&	     \
+	 (source != CXL_POISON_SOURCE_VENDOR)) ? "Reserved"  \
+	 : __show_poison_source(source))
+
+#define show_poison_flags(flags)                             \
+	__print_flags(flags, "|",                            \
+		{ CXL_POISON_FLAG_MORE,      "More"     },   \
+		{ CXL_POISON_FLAG_OVERFLOW,  "Overflow"  },  \
+		{ CXL_POISON_FLAG_SCANNING,  "Scanning"  })
+
+#define __cxl_poison_addr(record)					\
+	(le64_to_cpu(record->address))
+#define cxl_poison_record_dpa(record)					\
+	(__cxl_poison_addr(record) & CXL_POISON_START_MASK)
+#define cxl_poison_record_source(record)				\
+	(__cxl_poison_addr(record)  & CXL_POISON_SOURCE_MASK)
+#define cxl_poison_record_length(record)				\
+	(le32_to_cpu(record->length) * CXL_POISON_LEN_MULT)
+#define cxl_poison_overflow(flags, time)				\
+	(flags & CXL_POISON_FLAG_OVERFLOW ? le64_to_cpu(time) : 0)
+
+TRACE_EVENT(cxl_poison,
+
+	    TP_PROTO(struct cxl_memdev *memdev, const struct pci_dev *pcidev,
+		     struct cxl_region *region,
+		     const struct cxl_poison_record *record,
+		     u8 flags, __le64 overflow_t),
+
+	    TP_ARGS(memdev, pcidev, region, record, flags, overflow_t),
+
+	    TP_STRUCT__entry(
+		__string(memdev, dev_name(&memdev->dev))
+		__string(pcidev, dev_name(&pcidev->dev))
+		__string(region, region)
+		__field(u64, overflow_t)
+		__field(u64, dpa)
+		__field(u32, length)
+		__array(char, uuid, 16)
+		__field(u8, source)
+		__field(u8, flags)
+	    ),
+
+	    TP_fast_assign(
+		__assign_str(memdev, dev_name(&memdev->dev));
+		__assign_str(pcidev, dev_name(&pcidev->dev));
+		__entry->overflow_t = cxl_poison_overflow(flags, overflow_t);
+		__entry->dpa = cxl_poison_record_dpa(record);
+		__entry->length = cxl_poison_record_length(record);
+		__entry->source = cxl_poison_record_source(record);
+		__entry->flags = flags;
+		if (region) {
+			__assign_str(region, dev_name(&region->dev));
+			memcpy(__entry->uuid, &region->params.uuid, 16);
+		} else {
+			__assign_str(region, "");
+			memset(__entry->uuid, 0, 16);
+		}
+	    ),
+
+	    TP_printk("memdev=%s pcidev=%s region=%s region_uuid=%pU dpa=0x%llx length=0x%x source=%s flags=%s overflow_time=%llu",
+		__get_str(memdev),
+		__get_str(pcidev),
+		__get_str(region),
+		__entry->uuid,
+		__entry->dpa,
+		__entry->length,
+		show_poison_source(__entry->source),
+		show_poison_flags(__entry->flags),
+		__entry->overflow_t)
+);
+
 #endif /* _CXL_EVENTS_H */
 
 #define TRACE_INCLUDE_FILE trace
-- 
2.37.3

