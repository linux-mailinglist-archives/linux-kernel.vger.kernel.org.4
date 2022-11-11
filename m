Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8129625154
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiKKDM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiKKDMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:12:52 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECAF2EF42;
        Thu, 10 Nov 2022 19:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668136371; x=1699672371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dpT2xSej3sVQoszQCqz3VXjYp4+bosvOJvtGCWIi7qY=;
  b=gwwPesXrClALuyZh3u3Q6dmPf/XscyQRKq4YVA7rHLZuXs4MTczA2BNg
   ILKmKjUWWwynFVsSW8EB85mr8xWUR2yhIp8XJ0EhuNEMWUk24S9JL2EAw
   I4hR77D8b/YTCj+lrhxLq5k4vLYfVZBN9/+8NKoAHc+TmlCzPZmvkGJo6
   3qZlH/xYeQWw8/PTc3BdixtlBDCLiWpc6XQ5sX1CPGkXBBfIgTFk/ZPYb
   u+7oxqh2EEz7TbxXh/lhv6PFnN3WYkLiU8/vbETdPvXht+Kwykbm+XUYl
   07TYw3owEUwp1T9nAv/1Y0zA77mAY8vxTLyOt+F9kwZiwmlGs6GD02hyr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="310224398"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="310224398"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 19:12:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="812296052"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="812296052"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.161.45])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 19:12:50 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] trace, cxl: Introduce a TRACE_EVENT for CXL poison records
Date:   Thu, 10 Nov 2022 19:12:39 -0800
Message-Id: <5746274c905f57f117987c8268c9f6dc9bd33337.1668115235.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1668115235.git.alison.schofield@intel.com>
References: <cover.1668115235.git.alison.schofield@intel.com>
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
Introduce a trace event that the CXL subsystem can use to log
the poison error records.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/cxlmem.h       | 14 +++++++
 include/trace/events/cxl.h | 80 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100644 include/trace/events/cxl.h

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 88e3a8e54b6a..669868cc1553 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -347,6 +347,20 @@ struct cxl_mbox_set_partition_info {
 
 #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
 
+/* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
+
+/* Get Poison List: Payload out flags */
+#define CXL_POISON_FLAG_MORE            BIT(0)
+#define CXL_POISON_FLAG_OVERFLOW        BIT(1)
+#define CXL_POISON_FLAG_SCANNING        BIT(2)
+
+/* Get Poison List: Poison Source */
+#define CXL_POISON_SOURCE_UNKNOWN	0
+#define CXL_POISON_SOURCE_EXTERNAL	1
+#define CXL_POISON_SOURCE_INTERNAL	2
+#define CXL_POISON_SOURCE_INJECTED	3
+#define CXL_POISON_SOURCE_VENDOR	7
+
 /**
  * struct cxl_mem_command - Driver representation of a memory device command
  * @info: Command information as it exists for the UAPI
diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
new file mode 100644
index 000000000000..03428125573f
--- /dev/null
+++ b/include/trace/events/cxl.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM cxl
+
+#if !defined(_CXL_TRACE_H) ||  defined(TRACE_HEADER_MULTI_READ)
+#define _CXL_TRACE_H
+
+#include <linux/tracepoint.h>
+#include <cxlmem.h>
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
+TRACE_EVENT(cxl_poison,
+
+	    TP_PROTO(const char *memdev, const char *pcidev, const char *region,
+		     const uuid_t *uuid, u64 dpa, u32 length, u8 source,
+		     u8 flags, u64 overflow_t),
+
+	    TP_ARGS(memdev, pcidev, region, uuid, dpa, length, source,
+		    flags, overflow_t),
+
+	    TP_STRUCT__entry(
+		__string(memdev, memdev)
+		__string(pcidev, pcidev)
+		__string(region, region ? region : "")
+		__array(char, uuid, 16)
+		__field(u64, dpa)
+		__field(u32, length)
+		__field(u8, source)
+		__field(u8, flags)
+		__field(u64, overflow_t)
+	    ),
+
+	    TP_fast_assign(
+		__assign_str(memdev, memdev);
+		__assign_str(pcidev, pcidev);
+		__assign_str(region, region ? region : "");
+		if (uuid)
+			memcpy(__entry->uuid, uuid, 16);
+		__entry->dpa = dpa;
+		__entry->length = length;
+		__entry->source = source;
+		__entry->flags = flags;
+		__entry->overflow_t = overflow_t;
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
+#endif /* _CXL_TRACE_H */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE cxl
+#include <trace/define_trace.h>
-- 
2.37.3

