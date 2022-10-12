Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2595FCD24
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJLV2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJLV20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:28:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4251187B8;
        Wed, 12 Oct 2022 14:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665610106; x=1697146106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GDE0F2gRE+3RNCoyAc/vJbM1NA8sddfEo7OjEj0BcYs=;
  b=arHSSmtW342f62+QrpArmWllg6/Y4RJvSJxnlL+QqJBYym8Pw22S2z9d
   +bmMlFV3REYJ6AJkk3U8gwhlqv649kU6EP0QPSSfHE0Mz56mUjZ3FM3Ch
   57/OX9p803cNPYVHNBVxrYyFnFvuVpvNsA5xJ6P5yZW7CL7lBbNFux4Pz
   uEiTllMff+Yj78gbR6JAkuu56cOChvwqzYWHzw2re/8BfW15Vkp7tL0CG
   76dpDe257LptcG7i/qE2Ha282eaaJwLrWrP5wGUjnbYqZXY3Y/7mdFoMa
   lSR6oJCpBItvBXZistnFDxZKf34FYua05o3iKKEd26A+Axh4d777rvjsl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="306543870"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="306543870"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 14:28:25 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="689834231"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="689834231"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.251.3.191])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 14:28:24 -0700
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
Subject: [PATCH v2 1/4] trace, cxl: Introduce a TRACE_EVENT for CXL poison records
Date:   Wed, 12 Oct 2022 14:28:17 -0700
Message-Id: <17ee0f309e4287510e4e68f2cbcfc9d111a6e69d.1665606782.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665606782.git.alison.schofield@intel.com>
References: <cover.1665606782.git.alison.schofield@intel.com>
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
the error records.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 include/trace/events/cxl.h | 88 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 include/trace/events/cxl.h

diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
new file mode 100644
index 000000000000..9613b0f18011
--- /dev/null
+++ b/include/trace/events/cxl.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM cxl
+
+#if !defined(_CXL_TRACE_H) ||  defined(TRACE_HEADER_MULTI_READ)
+#define _CXL_TRACE_H
+
+#include <linux/tracepoint.h>
+
+/* CXL 8.2.9.5.4.1 Get Poison List: Poison Source */
+#define        CXL_POISON_SOURCE_UNKNOWN       0
+#define        CXL_POISON_SOURCE_EXTERNAL      1
+#define        CXL_POISON_SOURCE_INTERNAL      2
+#define        CXL_POISON_SOURCE_INJECTED      3
+#define        CXL_POISON_SOURCE_VENDOR        7
+
+#define show_poison_source(source)                            \
+	__print_symbolic(source,                              \
+		{ CXL_POISON_SOURCE_UNKNOWN,   "Unknown"  },  \
+		{ CXL_POISON_SOURCE_EXTERNAL,  "External" },  \
+		{ CXL_POISON_SOURCE_INTERNAL,  "Internal" },  \
+		{ CXL_POISON_SOURCE_INJECTED,  "Injected" },  \
+		{ CXL_POISON_SOURCE_VENDOR,    "Vendor"   })
+
+/* CXL 8.2.9.5.4.1 Get Poison List: Payload out flags */
+#define CXL_POISON_FLAG_MORE            BIT(0)
+#define CXL_POISON_FLAG_OVERFLOW        BIT(1)
+#define CXL_POISON_FLAG_SCANNING        BIT(2)
+
+#define show_poison_flags(flags)                             \
+	__print_flags(flags, "|",                            \
+		{ CXL_POISON_FLAG_MORE,      "More"     },   \
+		{ CXL_POISON_FLAG_OVERFLOW,  "Overflow"  },  \
+		{ CXL_POISON_FLAG_SCANNING,  "Scanning"  })
+
+TRACE_EVENT(cxl_poison,
+
+	    TP_PROTO(pid_t pid, const char *region, const char *memdev,
+		     const char *pcidev, u64 hpa, u64 dpa, u32 length,
+		     u8 source, u8 flags, u64 overflow_t),
+
+	    TP_ARGS(pid, region, memdev, pcidev, hpa, dpa,
+		    length, source, flags, overflow_t),
+
+	    TP_STRUCT__entry(
+		__field(pid_t, pid)
+		__string(region, region ? region : "")
+		__string(memdev, memdev)
+		__string(pcidev, pcidev)
+		__field(u64, hpa)
+		__field(u64, dpa)
+		__field(u32, length)
+		__field(u8, source)
+		__field(u8, flags)
+		__field(u64, overflow_t)
+	    ),
+
+	    TP_fast_assign(
+		__entry->pid = pid;
+		__assign_str(region, region ? region : "");
+		__assign_str(memdev, memdev);
+		__assign_str(pcidev, pcidev);
+		__entry->hpa = hpa;
+		__entry->dpa = dpa;
+		__entry->length = length;
+		__entry->source = source;
+		__entry->flags = flags;
+		__entry->overflow_t = overflow_t;
+	    ),
+
+	    TP_printk("pid:%d region:%s memdev:%s pcidev:%s hpa:0x%llx dpa:0x%llx length:0x%x source:%s flags:%s overflow_time:%llu",
+		__entry->pid,
+		__get_str(region),
+		__get_str(memdev),
+		__get_str(pcidev),
+		__entry->hpa,
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

