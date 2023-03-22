Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17FB6C4031
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 03:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjCVCMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 22:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjCVCM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 22:12:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07865A18C;
        Tue, 21 Mar 2023 19:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679451146; x=1710987146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TZvFUemshfvvi/Wz6kY2Ao2MmH+K/4+eHAd1NP7Pmf4=;
  b=g/Pk/Ofqm09FJ+E95EQtxYw/l5b5m55ZjYW72LnzA93Eeww+oEU9aVCq
   ueJHNh/76wL6Bs52TW/c9QXTsc4HL+vcymaVFsRbadlnUqHD/TWU5EAWE
   u6Q0TIQIde1mHRQ5d4NAtS/edEijy+47pMjs7jOfvJXqSEi//nWF3isQG
   4TD1/OR4qjXtArKTU+Qg/O7vDuDoxpjhCDOQigs7yKLGWO/HqG6e75Hwu
   wt2gLszZiOLOOg9xwmEQGyyzcMQc+0UbNvniLBn+SFHW6q+lzkAnn2uBW
   QYdhfuGmH9Mx1vdyITa/e3uczd55uZbIURgxPMsJnoVnUCz5oAKfBkX5U
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="401677438"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="401677438"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 19:12:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="746126854"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="746126854"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.251.21.85])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 19:12:25 -0700
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
Subject: [PATCH v10 2/6] cxl/trace: Add TRACE support for CXL media-error records
Date:   Tue, 21 Mar 2023 19:12:15 -0700
Message-Id: <be0b6edfb0a9fdafe783c68f37972f6bc6d805c4.1679448904.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1679448904.git.alison.schofield@intel.com>
References: <cover.1679448904.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/core.h  |  4 ++
 drivers/cxl/core/mbox.c  |  5 ++-
 drivers/cxl/core/trace.h | 94 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index cde475e13216..e888e293943e 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -64,4 +64,8 @@ int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
 void cxl_mbox_init(void);
 
+enum cxl_poison_trace_type {
+	CXL_POISON_TRACE_LIST,
+};
+
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 0da0a30511f2..a8369ef56f61 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1147,7 +1147,10 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		if (rc)
 			break;
 
-		/* TODO TRACE the media error records */
+		for (int i = 0; i < le16_to_cpu(po->count); i++)
+			trace_cxl_poison(cxlmd, cxlr, &po->record[i],
+					 po->flags, po->overflow_t,
+					 CXL_POISON_TRACE_LIST);
 
 		/* Protect against an uncleared _FLAG_MORE */
 		nr_records = nr_records + le16_to_cpu(po->count);
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 9b8d3d997834..2ebfa55c31a8 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -7,10 +7,12 @@
 #define _CXL_EVENTS_H
 
 #include <linux/tracepoint.h>
+#include <linux/pci.h>
 #include <asm-generic/unaligned.h>
 
 #include <cxl.h>
 #include <cxlmem.h>
+#include "core.h"
 
 #define CXL_RAS_UC_CACHE_DATA_PARITY	BIT(0)
 #define CXL_RAS_UC_CACHE_ADDR_PARITY	BIT(1)
@@ -600,6 +602,98 @@ TRACE_EVENT(cxl_memory_module,
 	)
 );
 
+#define show_poison_trace_type(type)		   \
+	__print_symbolic(type,			   \
+	{ CXL_POISON_TRACE_LIST,	"LIST"	})
+
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
+#define cxl_poison_record_dpa_length(record)				\
+	(le32_to_cpu(record->length) * CXL_POISON_LEN_MULT)
+#define cxl_poison_overflow(flags, time)				\
+	(flags & CXL_POISON_FLAG_OVERFLOW ? le64_to_cpu(time) : 0)
+
+TRACE_EVENT(cxl_poison,
+
+	TP_PROTO(struct cxl_memdev *cxlmd, struct cxl_region *region,
+		 const struct cxl_poison_record *record, u8 flags,
+		 __le64 overflow_t, enum cxl_poison_trace_type type),
+
+	TP_ARGS(cxlmd, region, record, flags, overflow_t, type),
+
+	TP_STRUCT__entry(
+		__string(memdev, dev_name(&cxlmd->dev))
+		__string(host, dev_name(cxlmd->dev.parent))
+		__field(u64, serial)
+		__field(u8, type)
+		__string(region, region)
+		__field(u64, overflow_t)
+		__field(u64, dpa)
+		__field(u32, dpa_length)
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
+		__entry->dpa_length = cxl_poison_record_dpa_length(record);
+		__entry->source = cxl_poison_record_source(record);
+		__entry->type = type;
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
+	TP_printk("memdev=%s host=%s serial=%lld type=%s region=%s "	\
+		"region_uuid=%pU hpa=0x%llx dpa=0x%llx dpa_length=0x%x "\
+		"source=%s flags=%s overflow_time=%llu",
+		__get_str(memdev),
+		__get_str(host),
+		__entry->serial,
+		show_poison_trace_type(__entry->type),
+		__get_str(region),
+		__entry->uuid,
+		__entry->dpa,
+		__entry->dpa_length,
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

