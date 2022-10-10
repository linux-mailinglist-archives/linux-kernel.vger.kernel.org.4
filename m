Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31855FA7C2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJJWnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJJWnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:43:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0953F79ED2;
        Mon, 10 Oct 2022 15:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665441785; x=1696977785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FBRYKBEBKIyVPAy4CKD7wEkYr+8JGNb6sTTInjF5eo4=;
  b=Firmm4VQV0T/YzDvy2wSKdEmx2uPou/Z5raVuHxmy9bDFLuWcNVsgX5U
   TFAxeqSnzDvDonTZx7UQOZKvdkavbO1AyWfdGUaqTn58CNPosS42HVT/m
   00/yDInhV0SHxp6ZicSLYB8mCiu54/eAygWJ0KYOdnPGBRqcbO+zRkcXu
   AcfTigikVP44MyDr9XiNkPvAY3nI5yyiIrK/fsGOUETBL3Xn/C7Eq7Nr3
   0lcjQgVFONzrpAae01joFu+YgYsM7BGtH5iSyztqD/cpwR5sIE+1MzBFO
   b38tg1Q/YIFIqMlfC7b/br5MA/N/ujO72Qt2i9Pw4P9q0cLQkEP1W6fw7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="287615376"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="287615376"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:43:04 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="621191337"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="621191337"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.252.141.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:43:03 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [RFC V2 PATCH 02/11] cxl/mem: Implement Get Event Records command
Date:   Mon, 10 Oct 2022 15:41:22 -0700
Message-Id: <20221010224131.1866246-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221010224131.1866246-1-ira.weiny@intel.com>
References: <20221010224131.1866246-1-ira.weiny@intel.com>
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

From: Ira Weiny <ira.weiny@intel.com>

Event records are defined for CXL devices.  Each record is reported in
one event log.  Devices are required to support the storage of at least
one event record in each event log type.

Devices track event log overflow by incrementing a counter and tracking
the time of the first and last overflow event seen.

Software queries events via the Get Event Record mailbox command; CXL
rev 3.0 section 8.2.9.2.2.

Issue the Get Event Record mailbox command on driver load.  Trace each
record found, as well as any overflow conditions.  Only 1 event is
requested for each query.  Optimization of multiple record queries is
deferred.

This patch traces a raw event record only and leaves the specific event
record types to subsequent patches.

Macros are created to use for the common CXL Event header fields.

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Change from RFC:
	Remove redundant error message in get event records loop
	s/EVENT_RECORD_DATA_LENGTH/CXL_EVENT_RECORD_DATA_LENGTH
	Use hdr_uuid for the header UUID field
	Use cxl_event_log_type_str() for the trace events
	Create macros for the header fields and common entries of each event
	Add reserved buffer output dump
	Report error if event query fails
	Remove unused record_cnt variable
	Steven - reorder overflow record
		Remove NOTE about checkpatch
	Jonathan
		check for exactly 1 record
		s/v3.0/rev 3.0
		Use 3 byte fields for 24bit fields
		Add 3.0 Maintenance Operation Class
		Add Dynamic Capacity log type
		Fix spelling
	Dave Jiang/Dan/Alison
		s/cxl-event/cxl
		trace/events/cxl-events => trace/events/cxl.h
		s/cxl_event_overflow/overflow
		s/cxl_event/generic_event
---
 MAINTAINERS                  |   1 +
 drivers/cxl/core/mbox.c      |  53 ++++++++++++++
 drivers/cxl/cxlmem.h         |  75 ++++++++++++++++++++
 include/trace/events/cxl.h   | 130 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/cxl_mem.h |   1 +
 5 files changed, 260 insertions(+)
 create mode 100644 include/trace/events/cxl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7547ffce5032..49bec9cc8bda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5219,6 +5219,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-cxl@vger.kernel.org
 S:	Maintained
 F:	drivers/cxl/
+F:	include/trace/events/cxl.h
 F:	include/uapi/linux/cxl_mem.h
 
 CONEXANT ACCESSRUNNER USB DRIVER
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 6c4d024ad0e8..5f258c3f2190 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -7,6 +7,9 @@
 #include <cxlmem.h>
 #include <cxl.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/cxl.h>
+
 #include "core.h"
 
 static bool cxl_raw_allow_all;
@@ -48,6 +51,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(RAW, CXL_VARIABLE_PAYLOAD, CXL_VARIABLE_PAYLOAD, 0),
 #endif
 	CXL_CMD(GET_SUPPORTED_LOGS, 0, CXL_VARIABLE_PAYLOAD, CXL_CMD_FLAG_FORCE_ENABLE),
+	CXL_CMD(GET_EVENT_RECORD, 1, CXL_VARIABLE_PAYLOAD, 0),
 	CXL_CMD(GET_FW_INFO, 0, 0x50, 0),
 	CXL_CMD(GET_PARTITION_INFO, 0, 0x20, 0),
 	CXL_CMD(GET_LSA, 0x8, CXL_VARIABLE_PAYLOAD, 0),
@@ -707,6 +711,55 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
 
+static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
+				    enum cxl_event_log_type type)
+{
+	struct cxl_get_event_payload payload;
+
+	do {
+		u8 log_type = type;
+		int rc;
+
+		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_EVENT_RECORD,
+				       &log_type, sizeof(log_type),
+				       &payload, sizeof(payload));
+		if (rc) {
+			dev_err(cxlds->dev, "Event log '%s': Failed to query event records : %d",
+				cxl_event_log_type_str(type), rc);
+			return;
+		}
+
+		if (le16_to_cpu(payload.record_count) == 1)
+			trace_generic_event(dev_name(cxlds->dev), type,
+					    &payload.record);
+
+		if (payload.flags & CXL_GET_EVENT_FLAG_OVERFLOW)
+			trace_overflow(dev_name(cxlds->dev), type, &payload);
+
+	} while (payload.flags & CXL_GET_EVENT_FLAG_MORE_RECORDS);
+}
+
+/**
+ * cxl_mem_get_event_records - Get Event Records from the device
+ * @cxlds: The device data for the operation
+ *
+ * Retrieve all event records available on the device and report them as trace
+ * events.
+ *
+ * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
+ */
+void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
+{
+	enum cxl_event_log_type log_type;
+
+	dev_dbg(cxlds->dev, "Reading event logs\n");
+
+	for (log_type = CXL_EVENT_TYPE_INFO;
+	     log_type < CXL_EVENT_TYPE_MAX; log_type++)
+		cxl_mem_get_records_log(cxlds, log_type);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
+
 /**
  * cxl_mem_get_partition_info - Get partition info
  * @cxlds: The device data for the operation
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 88e3a8e54b6a..fa8d248fb299 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -4,6 +4,7 @@
 #define __CXL_MEM_H__
 #include <uapi/linux/cxl_mem.h>
 #include <linux/cdev.h>
+#include <linux/uuid.h>
 #include "cxl.h"
 
 /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
@@ -253,6 +254,7 @@ struct cxl_dev_state {
 enum cxl_opcode {
 	CXL_MBOX_OP_INVALID		= 0x0000,
 	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
+	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
 	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
 	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
 	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
@@ -322,6 +324,78 @@ struct cxl_mbox_identify {
 	u8 qos_telemetry_caps;
 } __packed;
 
+/*
+ * Common Event Record Format
+ * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
+ */
+#define CXL_EVENT_REC_HDR_RES_LEN 0xf
+struct cxl_event_record_hdr {
+	uuid_t id;
+	u8 length;
+	u8 flags[3];
+	__le16 handle;
+	__le16 related_handle;
+	__le64 timestamp;
+	u8 maint_op_class;
+	u8 reserved[CXL_EVENT_REC_HDR_RES_LEN];
+} __packed;
+
+#define CXL_EVENT_RECORD_DATA_LENGTH 0x50
+struct cxl_event_record_raw {
+	struct cxl_event_record_hdr hdr;
+	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
+} __packed;
+
+/*
+ * Get Event Records output payload
+ * CXL rev 3.0 section 8.2.9.2.2; Table 8-50
+ *
+ * Space given for 1 record
+ */
+#define CXL_GET_EVENT_FLAG_OVERFLOW		BIT(0)
+#define CXL_GET_EVENT_FLAG_MORE_RECORDS	BIT(1)
+struct cxl_get_event_payload {
+	u8 flags;
+	u8 reserved1;
+	__le16 overflow_err_count;
+	__le64 first_overflow_timestamp;
+	__le64 last_overflow_timestamp;
+	__le16 record_count;
+	u8 reserved2[0xa];
+	struct cxl_event_record_raw record;
+} __packed;
+
+/*
+ * CXL rev 3.0 section 8.2.9.2.2; Table 8-49
+ */
+enum cxl_event_log_type {
+	CXL_EVENT_TYPE_INFO = 0x00,
+	CXL_EVENT_TYPE_WARN,
+	CXL_EVENT_TYPE_FAIL,
+	CXL_EVENT_TYPE_FATAL,
+	CXL_EVENT_TYPE_DYNAMIC_CAP,
+	CXL_EVENT_TYPE_MAX
+};
+
+static inline const char *cxl_event_log_type_str(enum cxl_event_log_type type)
+{
+	switch (type) {
+	case CXL_EVENT_TYPE_INFO:
+		return "Informational";
+	case CXL_EVENT_TYPE_WARN:
+		return "Warning";
+	case CXL_EVENT_TYPE_FAIL:
+		return "Failure";
+	case CXL_EVENT_TYPE_FATAL:
+		return "Fatal";
+	case CXL_EVENT_TYPE_DYNAMIC_CAP:
+		return "Dynamic Capacity";
+	default:
+		break;
+	}
+	return "<unknown>";
+}
+
 struct cxl_mbox_get_partition_info {
 	__le64 active_volatile_cap;
 	__le64 active_persistent_cap;
@@ -381,6 +455,7 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
 struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
 void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
 void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
+void cxl_mem_get_event_records(struct cxl_dev_state *cxlds);
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
 void cxl_mem_active_dec(void);
diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
new file mode 100644
index 000000000000..318ba5fe046e
--- /dev/null
+++ b/include/trace/events/cxl.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM cxl
+
+#if !defined(_CXL_TRACE_EVENTS_H) ||  defined(TRACE_HEADER_MULTI_READ)
+#define _CXL_TRACE_EVENTS_H
+
+#include <asm-generic/unaligned.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(overflow,
+
+	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
+		 struct cxl_get_event_payload *payload),
+
+	TP_ARGS(dev_name, log, payload),
+
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name)
+		__field(int, log)
+		__field(u64, first)
+		__field(u64, last)
+		__field(u16, count)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name);
+		__entry->log = log;
+		__entry->count = le16_to_cpu(payload->overflow_err_count);
+		__entry->first = le64_to_cpu(payload->first_overflow_timestamp);
+		__entry->last = le64_to_cpu(payload->last_overflow_timestamp);
+	),
+
+	TP_printk("%s: EVENT LOG OVERFLOW log=%s : %u records from %llu to %llu",
+		__get_str(dev_name), cxl_event_log_type_str(__entry->log),
+		__entry->count, __entry->first, __entry->last)
+
+);
+
+/*
+ * Common Event Record Format
+ * CXL 3.0 section 8.2.9.2.1; Table 8-42
+ */
+#define CXL_EVENT_RECORD_FLAG_PERMANENT		BIT(2)
+#define CXL_EVENT_RECORD_FLAG_MAINT_NEEDED	BIT(3)
+#define CXL_EVENT_RECORD_FLAG_PERF_DEGRADED	BIT(4)
+#define CXL_EVENT_RECORD_FLAG_HW_REPLACE	BIT(5)
+#define show_hdr_flags(flags)	__print_flags(flags, " | ",			   \
+	{ CXL_EVENT_RECORD_FLAG_PERMANENT,	"Permanent Condition"		}, \
+	{ CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,	"Maintenance Needed"		}, \
+	{ CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,	"Performance Degraded"		}, \
+	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"Hardware Replacement Needed"	}  \
+)
+
+/*
+ * Define macros for the common header of each CXL event.
+ *
+ * Tracepoints using these macros must do 3 things:
+ *
+ *	1) Add CXL_EVT_TP_entry to TP_STRUCT__entry
+ *	2) Use CXL_EVT_TP_fast_assign within TP_fast_assign;
+ *	   pass the dev_name, log, and CXL event header
+ *	3) Use CXL_EVT_TP_printk() instead of TP_printk()
+ *
+ * See the generic_event tracepoint as an example.
+ */
+#define CXL_EVT_TP_entry					\
+	__string(dev_name, dev_name)				\
+	__field(int, log)					\
+	__array(u8, hdr_uuid, UUID_SIZE)			\
+	__field(u32, hdr_flags)					\
+	__field(u16, hdr_handle)				\
+	__field(u16, hdr_related_handle)			\
+	__field(u64, hdr_timestamp)				\
+	__array(u8, hdr_res, CXL_EVENT_REC_HDR_RES_LEN)		\
+	__field(u8, hdr_length)					\
+	__field(u8, hdr_maint_op_class)
+
+#define CXL_EVT_TP_fast_assign(dname, l, hdr)					\
+	__assign_str(dev_name, (dname));					\
+	__entry->log = (l);							\
+	memcpy(__entry->hdr_uuid, &(hdr).id, UUID_SIZE);			\
+	__entry->hdr_length = (hdr).length;					\
+	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
+	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
+	__entry->hdr_related_handle = le16_to_cpu((hdr).related_handle);	\
+	__entry->hdr_timestamp = le64_to_cpu((hdr).timestamp);			\
+	__entry->hdr_maint_op_class = (hdr).maint_op_class;			\
+	memcpy(__entry->hdr_res, &(hdr).reserved,				\
+		CXL_EVENT_REC_HDR_RES_LEN)
+
+
+#define CXL_EVT_TP_printk(fmt, ...) \
+	TP_printk("%s log=%s : time=%llu uuid=%pUl len=%d flags='%s' "		\
+		"handle=%x related_handle=%x maint_op_class=%u res='%s' "	\
+		" : " fmt,							\
+		__get_str(dev_name), cxl_event_log_type_str(__entry->log),	\
+		__entry->hdr_timestamp, __entry->hdr_uuid, __entry->hdr_length,	\
+		show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,	\
+		__entry->hdr_related_handle, __entry->hdr_maint_op_class,	\
+		__print_hex(__entry->hdr_res, CXL_EVENT_REC_HDR_RES_LEN),	\
+		##__VA_ARGS__)
+
+TRACE_EVENT(generic_event,
+
+	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
+		 struct cxl_event_record_raw *rec),
+
+	TP_ARGS(dev_name, log, rec),
+
+	TP_STRUCT__entry(
+		CXL_EVT_TP_entry
+		__array(u8, data, CXL_EVENT_RECORD_DATA_LENGTH)
+	),
+
+	TP_fast_assign(
+		CXL_EVT_TP_fast_assign(dev_name, log, rec->hdr);
+		memcpy(__entry->data, &rec->data, CXL_EVENT_RECORD_DATA_LENGTH);
+	),
+
+	CXL_EVT_TP_printk("%s",
+		__print_hex(__entry->data, CXL_EVENT_RECORD_DATA_LENGTH))
+);
+
+#endif /* _CXL_TRACE_EVENTS_H */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE cxl
+#include <trace/define_trace.h>
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index c71021a2a9ed..70459be5bdd4 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -24,6 +24,7 @@
 	___C(IDENTIFY, "Identify Command"),                               \
 	___C(RAW, "Raw device command"),                                  \
 	___C(GET_SUPPORTED_LOGS, "Get Supported Logs"),                   \
+	___C(GET_EVENT_RECORD, "Get Event Record"),                       \
 	___C(GET_FW_INFO, "Get FW Info"),                                 \
 	___C(GET_PARTITION_INFO, "Get Partition Information"),            \
 	___C(GET_LSA, "Get Label Storage Area"),                          \
-- 
2.37.2

