Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD9069B7B1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 03:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjBRCTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 21:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjBRCTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 21:19:02 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4862A6C015;
        Fri, 17 Feb 2023 18:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676686741; x=1708222741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oXQu6oW96GiedryYBCfg5qBWyZzSh5m2SheIk1Lu+Ho=;
  b=dvFRdidhcz8593q88SLChvt/3GFn4sKbfSXt4ZBhdnAcIYh3tIjmETLB
   RVZOfmN1nEgUWW3iq9gq9PrBaM+0yFFQmbxCq7ysMgGG+oBkYZ7yFNJeh
   apYQcw+ab1GxgMZ+jKvKO9KU9gsH8IPx+GtTx3YMKQL2di/MpP2WJoGjD
   dpTKoH7Fo43Ub6T6gzawQH6u4hVb9QHRK+lLS9TpYEFGe1lc8Mlwk8sHG
   2Q3CbBkpW/4E/M9ThFpKAxDhnjRXlz/eHSDK/K5jxlfNQMTUHnxB10onK
   FaDar+2e4SugpEx3INzv2Wz6vQak4qznJQYqQYZQTCOLNB8AzYE63WIZ/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="320244209"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="320244209"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 18:19:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="672787882"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="672787882"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.252.133.15])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 18:18:59 -0800
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
Subject: [PATCH v7 2/6] cxl/trace: Add TRACE support for CXL media-error records
Date:   Fri, 17 Feb 2023 18:18:50 -0800
Message-Id: <c504808e494ca93753c96ac894f209c675e3dc5a.1676685180.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1676685180.git.alison.schofield@intel.com>
References: <cover.1676685180.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/mbox.c  |  4 +-
 drivers/cxl/core/trace.h | 84 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index faa61e5f541f..a3da8b4e92a4 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1147,7 +1147,9 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		if (rc)
 			break;
 
-		/* TODO TRACE the media error records */
+		for (int i = 0; i < le16_to_cpu(po->count); i++)
+			trace_cxl_poison(cxlmd, cxlr, &po->record[i],
+					 po->flags, po->overflow_t);
 
 		/* Protect against an uncleared _FLAG_MORE */
 		nr_records = nr_records + le16_to_cpu(po->count);
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index c72ef9321cfe..289fab1a686d 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -7,6 +7,7 @@
 #define _CXL_EVENTS_H
 
 #include <linux/tracepoint.h>
+#include <linux/pci.h>
 #include <asm-generic/unaligned.h>
 
 #include <cxl.h>
@@ -581,6 +582,89 @@ TRACE_EVENT(cxl_memory_module,
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
+	TP_PROTO(struct cxl_memdev *cxlmd, struct cxl_region *region,
+		 const struct cxl_poison_record *record,
+		 u8 flags, __le64 overflow_t),
+
+	TP_ARGS(cxlmd, region, record, flags, overflow_t),
+
+	TP_STRUCT__entry(
+		__string(memdev, dev_name(&cxlmd->dev))
+		__string(host, dev_name(cxlmd->dev.parent))
+		__field(u64, serial)
+		__string(region, region)
+		__field(u64, overflow_t)
+		__field(u64, dpa)
+		__field(u32, length)
+		__array(char, uuid, 16)
+		__field(u8, source)
+		__field(u8, flags)
+	    ),
+
+	TP_fast_assign(
+		__assign_str(memdev, dev_name(&cxlmd->dev));
+		__assign_str(host, dev_name(cxlmd->dev.parent));
+		__entry->serial = cxlmd->cxlds->serial;
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
+	TP_printk("memdev=%s host=%s serial=%lld region=%s region_uuid=%pU dpa=0x%llx length=0x%x source=%s flags=%s overflow_time=%llu",
+		__get_str(memdev),
+		__get_str(host),
+		__entry->serial,
+		__get_str(region),
+		__entry->uuid,
+		__entry->dpa,
+		__entry->length,
+		show_poison_source(__entry->source),
+		show_poison_flags(__entry->flags),
+		__entry->overflow_t
+	)
+);
+
 #endif /* _CXL_EVENTS_H */
 
 #define TRACE_INCLUDE_FILE trace
-- 
2.37.3

