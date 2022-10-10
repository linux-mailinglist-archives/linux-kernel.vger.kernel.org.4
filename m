Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719105FA7C4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJJWnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiJJWnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:43:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DFE7A50D;
        Mon, 10 Oct 2022 15:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665441788; x=1696977788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5H8OUuHWxquc6uLEDyYV8dVQIZdHWxNMEnOtjnEo2HM=;
  b=h9Ndwsoj7KCk2EsoD1ilphWnXujPy5/hu1e3kS09fgTU75GCIrRQCxUl
   BPDaHjtFWStKi7AseOdLcexplVkzixEx2By3s1pzfwS/OnCbuFkeM7Cw8
   mj7AeycZ8s7/T55vXxykLVokglCKC2T+y9Grq4OzNxIdiDEw6OQ5v+gXs
   bCTt+4HoC+P1IsOpp4wlVDtARx3UQgeaoBoRHZtaFtu+5FnWno3hcDr45
   dDYW7DL5u4G2lyeWwX5wr84Ll/CPkIah/rB/xk6LK9eKr1fwDvhefE2KK
   ZWMpf/vBO8odP0g2GMokEolRqCPDUHvNmB+5FdtyPUD3NvcJbJ8t2MSqN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="287615383"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="287615383"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:43:06 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="621191360"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="621191360"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.252.141.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:43:06 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [RFC V2 PATCH 05/11] cxl/mem: Trace General Media Event Record
Date:   Mon, 10 Oct 2022 15:41:25 -0700
Message-Id: <20221010224131.1866246-6-ira.weiny@intel.com>
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

CXL rev 3.0 section 8.2.9.2.1.1 defines the General Media Event Record.

Determine if the event read is a general media record and if so trace
the record.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC:
	Add reserved byte array
	Use common CXL event header record macros
	Jonathan
		Use unaligned_le{24,16} for unaligned fields
		Don't use the inverse of phy addr mask
	Dave Jiang
		s/cxl_gen_media_event/general_media
		s/cxl_evt_gen_media/cxl_event_gen_media
---
 drivers/cxl/core/mbox.c    |  30 ++++++++++-
 drivers/cxl/cxlmem.h       |  20 +++++++
 include/trace/events/cxl.h | 108 +++++++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index bc4e42b3e01b..1097250c115a 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -712,6 +712,32 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
 
+/*
+ * General Media Event Record
+ * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ */
+static const uuid_t gen_media_event_uuid =
+	UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
+		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6);
+
+static void cxl_trace_event_record(const char *dev_name,
+				   enum cxl_event_log_type type,
+				   struct cxl_get_event_payload *payload)
+{
+	uuid_t *id = &payload->record.hdr.id;
+
+	if (uuid_equal(id, &gen_media_event_uuid)) {
+		struct cxl_event_gen_media *rec =
+				(struct cxl_event_gen_media *)&payload->record;
+
+		trace_general_media(dev_name, type, rec);
+		return;
+	}
+
+	/* For unknown record types print just the header */
+	trace_generic_event(dev_name, type, &payload->record);
+}
+
 static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
 				  enum cxl_event_log_type log,
 				  __le16 handle)
@@ -745,8 +771,8 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
 		}
 
 		if (le16_to_cpu(payload.record_count) == 1) {
-			trace_generic_event(dev_name(cxlds->dev), type,
-					    &payload.record);
+			cxl_trace_event_record(dev_name(cxlds->dev), type,
+					       &payload);
 			rc = cxl_clear_event_record(cxlds, type,
 						    payload.record.hdr.handle);
 			if (rc) {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 75aea34f3ffb..b5c120bd4068 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -411,6 +411,26 @@ struct cxl_mbox_clear_event_payload {
 	__le16 handle;
 };
 
+/*
+ * General Media Event Record
+ * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ */
+#define CXL_EVENT_GEN_MED_COMP_ID_SIZE	0x10
+#define CXL_EVENT_GEN_MED_RES_SIZE	0x2e
+struct cxl_event_gen_media {
+	struct cxl_event_record_hdr hdr;
+	__le64 phys_addr;
+	u8 descriptor;
+	u8 type;
+	u8 transaction_type;
+	u8 validity_flags[2];
+	u8 channel;
+	u8 rank;
+	u8 device[3];
+	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
+	u8 reserved[CXL_EVENT_GEN_MED_RES_SIZE];
+} __packed;
+
 struct cxl_mbox_get_partition_info {
 	__le64 active_volatile_cap;
 	__le64 active_persistent_cap;
diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
index 318ba5fe046e..82a8d3b750a2 100644
--- a/include/trace/events/cxl.h
+++ b/include/trace/events/cxl.h
@@ -122,6 +122,114 @@ TRACE_EVENT(generic_event,
 		__print_hex(__entry->data, CXL_EVENT_RECORD_DATA_LENGTH))
 );
 
+/*
+ * General Media Event Record - GMER
+ * CXL v2.0 Section 8.2.9.1.1.1; Table 154
+ */
+#define CXL_GMER_PHYS_ADDR_VOLATILE			BIT(0)
+#define CXL_GMER_PHYS_ADDR_MASK				0xFFFFFFFFFFFFFF80
+
+#define CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT		BIT(0)
+#define CXL_GMER_EVT_DESC_THRESHOLD_EVENT		BIT(1)
+#define CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW		BIT(2)
+#define show_event_desc_flags(flags)	__print_flags(flags, "|",		   \
+	{ CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,		"Uncorrectable Event"	}, \
+	{ CXL_GMER_EVT_DESC_THRESHOLD_EVENT,		"Threshold event"	}, \
+	{ CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW,	"Poison List Overflow"	}  \
+)
+
+#define CXL_GMER_MEM_EVT_TYPE_ECC_ERROR			0x00
+#define CXL_GMER_MEM_EVT_TYPE_INV_ADDR			0x01
+#define CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR		0x02
+#define show_mem_event_type(type)	__print_symbolic(type,			\
+	{ CXL_GMER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },		\
+	{ CXL_GMER_MEM_EVT_TYPE_INV_ADDR,		"Invalid Address" },	\
+	{ CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,	"Data Path Error" }	\
+)
+
+#define CXL_GMER_TRANS_UNKNOWN				0x00
+#define CXL_GMER_TRANS_HOST_READ			0x01
+#define CXL_GMER_TRANS_HOST_WRITE			0x02
+#define CXL_GMER_TRANS_HOST_SCAN_MEDIA			0x03
+#define CXL_GMER_TRANS_HOST_INJECT_POISON		0x04
+#define CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB		0x05
+#define CXL_GMER_TRANS_INTERNAL_MEDIA_MANAGEMENT	0x06
+#define show_trans_type(type)	__print_symbolic(type,					\
+	{ CXL_GMER_TRANS_UNKNOWN,			"Unknown" },			\
+	{ CXL_GMER_TRANS_HOST_READ,			"Host Read" },			\
+	{ CXL_GMER_TRANS_HOST_WRITE,			"Host Write" },			\
+	{ CXL_GMER_TRANS_HOST_SCAN_MEDIA,		"Host Scan Media" },		\
+	{ CXL_GMER_TRANS_HOST_INJECT_POISON,		"Host Inject Poison" },		\
+	{ CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB,		"Internal Media Scrub" },	\
+	{ CXL_GMER_TRANS_INTERNAL_MEDIA_MANAGEMENT,	"Internal Media Management" }	\
+)
+
+#define CXL_GMER_VALID_CHANNEL				BIT(0)
+#define CXL_GMER_VALID_RANK				BIT(1)
+#define CXL_GMER_VALID_DEVICE				BIT(2)
+#define CXL_GMER_VALID_COMPONENT			BIT(3)
+#define show_valid_flags(flags)	__print_flags(flags, "|",		   \
+	{ CXL_GMER_VALID_CHANNEL,			"CHANNEL"	}, \
+	{ CXL_GMER_VALID_RANK,				"RANK"		}, \
+	{ CXL_GMER_VALID_DEVICE,			"DEVICE"	}, \
+	{ CXL_GMER_VALID_COMPONENT,			"COMPONENT"	}  \
+)
+
+TRACE_EVENT(general_media,
+
+	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
+		 struct cxl_event_gen_media *rec),
+
+	TP_ARGS(dev_name, log, rec),
+
+	TP_STRUCT__entry(
+		CXL_EVT_TP_entry
+		/* General Media */
+		__field(u64, phys_addr)
+		__field(u8, descriptor)
+		__field(u8, type)
+		__field(u8, transaction_type)
+		__field(u8, channel)
+		__field(u32, device)
+		__array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
+		__array(u8, reserved, CXL_EVENT_GEN_MED_RES_SIZE)
+		__field(u16, validity_flags)
+		__field(u8, rank) /* Out of order to pack trace record */
+	),
+
+	TP_fast_assign(
+		CXL_EVT_TP_fast_assign(dev_name, log, rec->hdr);
+
+		/* General Media */
+		__entry->phys_addr = le64_to_cpu(rec->phys_addr);
+		__entry->descriptor = rec->descriptor;
+		__entry->type = rec->type;
+		__entry->transaction_type = rec->transaction_type;
+		__entry->channel = rec->channel;
+		__entry->rank = rec->rank;
+		__entry->device = get_unaligned_le24(rec->device);
+		memcpy(__entry->comp_id, &rec->component_id,
+			CXL_EVENT_GEN_MED_COMP_ID_SIZE);
+		memcpy(__entry->reserved, &rec->reserved,
+			CXL_EVENT_GEN_MED_RES_SIZE);
+		__entry->validity_flags = get_unaligned_le16(&rec->validity_flags);
+	),
+
+	CXL_EVT_TP_printk("phys_addr=%llx volatile=%s desc='%s' type='%s' " \
+		"trans_type='%s' channel=%u rank=%u device=%x comp_id=%s " \
+		"valid_flags='%s' reserved=%s",
+		__entry->phys_addr & CXL_GMER_PHYS_ADDR_MASK,
+		(__entry->phys_addr & CXL_GMER_PHYS_ADDR_VOLATILE) ? "TRUE" : "FALSE",
+		show_event_desc_flags(__entry->descriptor),
+		show_mem_event_type(__entry->type),
+		show_trans_type(__entry->transaction_type),
+		__entry->channel, __entry->rank, __entry->device,
+		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
+		show_valid_flags(__entry->validity_flags),
+		__print_hex(__entry->reserved, CXL_EVENT_GEN_MED_RES_SIZE)
+		)
+);
+
 #endif /* _CXL_TRACE_EVENTS_H */
 
 /* This part must be outside protection */
-- 
2.37.2

