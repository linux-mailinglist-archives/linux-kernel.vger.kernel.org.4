Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7A964E2F6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 22:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiLOVSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 16:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiLOVSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:18:02 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60E6554F3;
        Thu, 15 Dec 2022 13:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671139081; x=1702675081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jAD7HB86AdlfinGuo2cHQHHsynQAWJBHzs/IYe0sxy4=;
  b=Tt0tx0PY28AElQj9yCdeued4N0aKUsGSCD5h8+6LiFGklpHTlFC04ij4
   DfeOse1Xizn8y6JdDj0yl+D8ZLSfgfHxMKRkEpcm7fn51xanXjr1FPtj6
   PQvgUwARpiUo0HOD02v1MtQKKPvpHK/lfYbaZGZISJgQID9yVxA62uTzp
   F9htJUGPc1EXoi/Jfi49H+mu93joUuYeq7/WshlZ+LykiU2mQaCzixJ7G
   9eBQ+tQhHDCX+heXr5jnpkwo+3HNMYAPG+S29qjvfE/Wq1g32gElX+zEq
   DOoWJnSK/aoWmu6xhd3cEG1zzpyluXh0S9FC8VoYWGBBE2mX85ANHq+v4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="302230297"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="302230297"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 13:17:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="649570080"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="649570080"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.55.178])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 13:17:50 -0800
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
Subject: [PATCH v4 2/5] cxl/trace: Add TRACE support for CXL media-error records
Date:   Thu, 15 Dec 2022 13:17:44 -0800
Message-Id: <3417fd29fda6cd60b5a93a8f77dc57ad71693fa8.1671135967.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1671135967.git.alison.schofield@intel.com>
References: <cover.1671135967.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index dfe24a2adfdb..c345af8a4afd 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -10,6 +10,7 @@
 #include <cxl.h>
 
 #include "core.h"
+#include "trace.h"
 
 static bool cxl_raw_allow_all;
 
@@ -899,7 +900,10 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
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

