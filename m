Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A998C69751C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 05:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjBOENG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 23:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjBOEND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 23:13:03 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58CF23D84;
        Tue, 14 Feb 2023 20:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676434381; x=1707970381;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=AGbVQNjFFhD48sGA4OZ7YohsbgowM2f2d1WZiqzgwps=;
  b=jkj4MQpfAy32ZTQyeMLZdCKMNEZWpTUUp05hzeOEbb6OlhGzs1vIZn1k
   NtsQgT/XlwN2Q3wK1k/pl58aoyQMDu+qL5E0VvBeBrxt3Og1BJXtEl5Xb
   owYUTR7xJB0L6c0G5BjuHimizogY5MF3wDWsax+GKdYHwQefgCz37eC71
   VoQFIHvsotVLp27RsRiTUvhk3efeOKTNqeuekkwRu+W9mOcm5RZdaWtef
   pan9/7LdwrobLt6Qs9k+IDZ+TQonW8b/Gy7vlOBGnraqhU4nUPysy3G2R
   vNkMU7SWaL+LvRytTybLqwgvgposgGaldIr+D/rflvBGN9hyqRBCXsNsp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="311706801"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="311706801"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 20:13:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="647016996"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="647016996"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.74.178])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 20:12:59 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Tue, 14 Feb 2023 20:12:43 -0800
Subject: [PATCH v2 1/3] cxl/trace: Standardize device information output
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230208-cxl-event-names-v2-1-fca130c2c68b@intel.com>
References: <20230208-cxl-event-names-v2-0-fca130c2c68b@intel.com>
In-Reply-To: <20230208-cxl-event-names-v2-0-fca130c2c68b@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Jiang <dave.jiang@intel.com>
X-Mailer: b4 0.13-dev-ada30
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676434378; l=11681;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=AGbVQNjFFhD48sGA4OZ7YohsbgowM2f2d1WZiqzgwps=;
 b=C4xFfEhcG5fT4dcLw1nET3J8nnyv0ayCjqE5x4pzWI8dvGPfVP3c4/JGfVgr6UzV46WhNKNEMNUC
 LjDBFW8tBZGgpurDv11W3BXHDh4OqPIK4MnMaX4Pa0gD1woH7z/z
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trace points were written to take a struct device input for the
trace.  In CXL multiple device objects are associated with each CXL
hardware device.  Using different device objects in the trace point can
lead to confusion for users.

The PCIe device is nice to have, but the user space tooling relies on
the memory device naming.  It is better to have those device names
reported.

Change all trace points to take struct cxl_memdev as a standard and
report that name.

Furthermore, standardize on the name 'memdev' in both
/sys/kernel/tracing/trace and cxl-cli monitor output.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v2
	Update commit message
	Wrap cxlmd in parens within the CXL_EVT_TP_fast_assign macro
	Fix a formatting issue
---
 drivers/cxl/core/mbox.c  | 14 +++++-----
 drivers/cxl/core/pci.c   |  8 ++----
 drivers/cxl/core/trace.h | 70 ++++++++++++++++++++++++------------------------
 3 files changed, 44 insertions(+), 48 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index fc7631bb1c24..f2addb457172 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -768,7 +768,7 @@ static const uuid_t mem_mod_event_uuid =
 	UUID_INIT(0xfe927475, 0xdd59, 0x4339,
 		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74);
 
-static void cxl_event_trace_record(const struct device *dev,
+static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 				   enum cxl_event_log_type type,
 				   struct cxl_event_record_raw *record)
 {
@@ -778,19 +778,19 @@ static void cxl_event_trace_record(const struct device *dev,
 		struct cxl_event_gen_media *rec =
 				(struct cxl_event_gen_media *)record;
 
-		trace_cxl_general_media(dev, type, rec);
+		trace_cxl_general_media(cxlmd, type, rec);
 	} else if (uuid_equal(id, &dram_event_uuid)) {
 		struct cxl_event_dram *rec = (struct cxl_event_dram *)record;
 
-		trace_cxl_dram(dev, type, rec);
+		trace_cxl_dram(cxlmd, type, rec);
 	} else if (uuid_equal(id, &mem_mod_event_uuid)) {
 		struct cxl_event_mem_module *rec =
 				(struct cxl_event_mem_module *)record;
 
-		trace_cxl_memory_module(dev, type, rec);
+		trace_cxl_memory_module(cxlmd, type, rec);
 	} else {
 		/* For unknown record types print just the header */
-		trace_cxl_generic_event(dev, type, record);
+		trace_cxl_generic_event(cxlmd, type, record);
 	}
 }
 
@@ -897,11 +897,11 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
 			break;
 
 		for (i = 0; i < nr_rec; i++)
-			cxl_event_trace_record(cxlds->dev, type,
+			cxl_event_trace_record(cxlds->cxlmd, type,
 					       &payload->records[i]);
 
 		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
-			trace_cxl_overflow(cxlds->dev, type, payload);
+			trace_cxl_overflow(cxlds->cxlmd, type, payload);
 
 		rc = cxl_clear_event_record(cxlds, type, payload);
 		if (rc) {
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 2b463f107cb5..8afd127fa9f5 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -622,8 +622,6 @@ EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
 void cxl_cor_error_detected(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct cxl_memdev *cxlmd = cxlds->cxlmd;
-	struct device *dev = &cxlmd->dev;
 	void __iomem *addr;
 	u32 status;
 
@@ -634,7 +632,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(dev, status);
+		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, CXL);
@@ -662,8 +660,6 @@ static void header_log_copy(struct cxl_dev_state *cxlds, u32 *log)
  */
 static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
 {
-	struct cxl_memdev *cxlmd = cxlds->cxlmd;
-	struct device *dev = &cxlmd->dev;
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
 	u32 status;
@@ -689,7 +685,7 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
 	}
 
 	header_log_copy(cxlds, hl);
-	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index c72ef9321cfe..93ac651a2f21 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -47,16 +47,16 @@
 )
 
 TRACE_EVENT(cxl_aer_uncorrectable_error,
-	TP_PROTO(const struct device *dev, u32 status, u32 fe, u32 *hl),
-	TP_ARGS(dev, status, fe, hl),
+	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
+	TP_ARGS(cxlmd, status, fe, hl),
 	TP_STRUCT__entry(
-		__string(dev_name, dev_name(dev))
+		__string(memdev, dev_name(&cxlmd->dev))
 		__field(u32, status)
 		__field(u32, first_error)
 		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
 	),
 	TP_fast_assign(
-		__assign_str(dev_name, dev_name(dev));
+		__assign_str(memdev, dev_name(&cxlmd->dev));
 		__entry->status = status;
 		__entry->first_error = fe;
 		/*
@@ -65,8 +65,8 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 		 */
 		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
 	),
-	TP_printk("%s: status: '%s' first_error: '%s'",
-		  __get_str(dev_name),
+	TP_printk("memdev=%s: status: '%s' first_error: '%s'",
+		  __get_str(memdev),
 		  show_uc_errs(__entry->status),
 		  show_uc_errs(__entry->first_error)
 	)
@@ -91,18 +91,18 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 )
 
 TRACE_EVENT(cxl_aer_correctable_error,
-	TP_PROTO(const struct device *dev, u32 status),
-	TP_ARGS(dev, status),
+	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
+	TP_ARGS(cxlmd, status),
 	TP_STRUCT__entry(
-		__string(dev_name, dev_name(dev))
+		__string(memdev, dev_name(&cxlmd->dev))
 		__field(u32, status)
 	),
 	TP_fast_assign(
-		__assign_str(dev_name, dev_name(dev));
+		__assign_str(memdev, dev_name(&cxlmd->dev));
 		__entry->status = status;
 	),
-	TP_printk("%s: status: '%s'",
-		  __get_str(dev_name), show_ce_errs(__entry->status)
+	TP_printk("memdev=%s: status: '%s'",
+		  __get_str(memdev), show_ce_errs(__entry->status)
 	)
 );
 
@@ -115,13 +115,13 @@ TRACE_EVENT(cxl_aer_correctable_error,
 
 TRACE_EVENT(cxl_overflow,
 
-	TP_PROTO(const struct device *dev, enum cxl_event_log_type log,
+	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
 		 struct cxl_get_event_payload *payload),
 
-	TP_ARGS(dev, log, payload),
+	TP_ARGS(cxlmd, log, payload),
 
 	TP_STRUCT__entry(
-		__string(dev_name, dev_name(dev))
+		__string(memdev, dev_name(&cxlmd->dev))
 		__field(int, log)
 		__field(u64, first_ts)
 		__field(u64, last_ts)
@@ -129,15 +129,15 @@ TRACE_EVENT(cxl_overflow,
 	),
 
 	TP_fast_assign(
-		__assign_str(dev_name, dev_name(dev));
+		__assign_str(memdev, dev_name(&cxlmd->dev));
 		__entry->log = log;
 		__entry->count = le16_to_cpu(payload->overflow_err_count);
 		__entry->first_ts = le64_to_cpu(payload->first_overflow_timestamp);
 		__entry->last_ts = le64_to_cpu(payload->last_overflow_timestamp);
 	),
 
-	TP_printk("%s: log=%s : %u records from %llu to %llu",
-		__get_str(dev_name), cxl_event_log_type_str(__entry->log),
+	TP_printk("memdev=%s: log=%s : %u records from %llu to %llu",
+		__get_str(memdev), cxl_event_log_type_str(__entry->log),
 		__entry->count, __entry->first_ts, __entry->last_ts)
 
 );
@@ -170,7 +170,7 @@ TRACE_EVENT(cxl_overflow,
  * See the generic_event tracepoint as an example.
  */
 #define CXL_EVT_TP_entry					\
-	__string(dev_name, dev_name(dev))			\
+	__string(memdev, dev_name(&cxlmd->dev))			\
 	__field(int, log)					\
 	__field_struct(uuid_t, hdr_uuid)			\
 	__field(u32, hdr_flags)					\
@@ -180,8 +180,8 @@ TRACE_EVENT(cxl_overflow,
 	__field(u8, hdr_length)					\
 	__field(u8, hdr_maint_op_class)
 
-#define CXL_EVT_TP_fast_assign(dev, l, hdr)					\
-	__assign_str(dev_name, dev_name(dev));					\
+#define CXL_EVT_TP_fast_assign(cxlmd, l, hdr)					\
+	__assign_str(memdev, dev_name(&(cxlmd)->dev));				\
 	__entry->log = (l);							\
 	memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));			\
 	__entry->hdr_length = (hdr).length;					\
@@ -192,10 +192,10 @@ TRACE_EVENT(cxl_overflow,
 	__entry->hdr_maint_op_class = (hdr).maint_op_class
 
 #define CXL_EVT_TP_printk(fmt, ...) \
-	TP_printk("%s log=%s : time=%llu uuid=%pUb len=%d flags='%s' "		\
+	TP_printk("memdev=%s log=%s : time=%llu uuid=%pUb len=%d flags='%s' "	\
 		"handle=%x related_handle=%x maint_op_class=%u"			\
 		" : " fmt,							\
-		__get_str(dev_name), cxl_event_log_type_str(__entry->log),	\
+		__get_str(memdev), cxl_event_log_type_str(__entry->log),	\
 		__entry->hdr_timestamp, &__entry->hdr_uuid, __entry->hdr_length,\
 		show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,	\
 		__entry->hdr_related_handle, __entry->hdr_maint_op_class,	\
@@ -203,10 +203,10 @@ TRACE_EVENT(cxl_overflow,
 
 TRACE_EVENT(cxl_generic_event,
 
-	TP_PROTO(const struct device *dev, enum cxl_event_log_type log,
+	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
 		 struct cxl_event_record_raw *rec),
 
-	TP_ARGS(dev, log, rec),
+	TP_ARGS(cxlmd, log, rec),
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
@@ -214,7 +214,7 @@ TRACE_EVENT(cxl_generic_event,
 	),
 
 	TP_fast_assign(
-		CXL_EVT_TP_fast_assign(dev, log, rec->hdr);
+		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
 		memcpy(__entry->data, &rec->data, CXL_EVENT_RECORD_DATA_LENGTH);
 	),
 
@@ -293,10 +293,10 @@ TRACE_EVENT(cxl_generic_event,
 
 TRACE_EVENT(cxl_general_media,
 
-	TP_PROTO(const struct device *dev, enum cxl_event_log_type log,
+	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
 		 struct cxl_event_gen_media *rec),
 
-	TP_ARGS(dev, log, rec),
+	TP_ARGS(cxlmd, log, rec),
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
@@ -315,7 +315,7 @@ TRACE_EVENT(cxl_general_media,
 	),
 
 	TP_fast_assign(
-		CXL_EVT_TP_fast_assign(dev, log, rec->hdr);
+		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
 
 		/* General Media */
 		__entry->dpa = le64_to_cpu(rec->phys_addr);
@@ -376,10 +376,10 @@ TRACE_EVENT(cxl_general_media,
 
 TRACE_EVENT(cxl_dram,
 
-	TP_PROTO(const struct device *dev, enum cxl_event_log_type log,
+	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
 		 struct cxl_event_dram *rec),
 
-	TP_ARGS(dev, log, rec),
+	TP_ARGS(cxlmd, log, rec),
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
@@ -401,7 +401,7 @@ TRACE_EVENT(cxl_dram,
 	),
 
 	TP_fast_assign(
-		CXL_EVT_TP_fast_assign(dev, log, rec->hdr);
+		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
 
 		/* DRAM */
 		__entry->dpa = le64_to_cpu(rec->phys_addr);
@@ -525,10 +525,10 @@ TRACE_EVENT(cxl_dram,
 
 TRACE_EVENT(cxl_memory_module,
 
-	TP_PROTO(const struct device *dev, enum cxl_event_log_type log,
+	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
 		 struct cxl_event_mem_module *rec),
 
-	TP_ARGS(dev, log, rec),
+	TP_ARGS(cxlmd, log, rec),
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
@@ -548,7 +548,7 @@ TRACE_EVENT(cxl_memory_module,
 	),
 
 	TP_fast_assign(
-		CXL_EVT_TP_fast_assign(dev, log, rec->hdr);
+		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
 
 		/* Memory Module Event */
 		__entry->event_type = rec->event_type;

-- 
2.39.1

