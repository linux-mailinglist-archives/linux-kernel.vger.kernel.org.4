Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD525624A41
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiKJTGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiKJTFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:05:39 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EB91B7BA;
        Thu, 10 Nov 2022 11:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668107118; x=1699643118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZmN6mxkBDibuSLG+5UKps6XRo1Tmm2bQYClfv7mkWL8=;
  b=guCm/CI221MzVR6jAQT2tvU7HhkNsZHhZHpisORX5LdImcmpabU4OCKm
   bJNmMVIjF20qyOhJH6U2v0Zys3KOvaVr5goJwNC7Y0ixpp8VdmSLV4NGn
   Z4BY3Fl6k1Jyj8whDP6TlIEdVG+a3vKBT0U+KZkALhO8MF1chdc6wlgfH
   psB3Dt5b6Fg4c3F1D/Fmg8YBqYms+8ml2jgXd9rCYfwS4OJlzYY66olyT
   rLb4lrtDgyS5wba7iWXl3o0AiLiGVW3/4PQgZpvWYHeQTo/Im+Djxzr+8
   LU63C6MUMvXZybVEEgGuBZkbqphYimBeSd3ts7hATLSlQ0TB1MyAjOsMm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="375662096"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="375662096"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 10:58:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="882473423"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="882473423"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.6.223])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 10:58:07 -0800
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
Subject: [PATCH 05/11] cxl/mem: Trace General Media Event Record
Date:   Thu, 10 Nov 2022 10:57:52 -0800
Message-Id: <20221110185758.879472-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221110185758.879472-1-ira.weiny@intel.com>
References: <20221110185758.879472-1-ira.weiny@intel.com>
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

From: Ira Weiny <ira.weiny@intel.com>

CXL rev 3.0 section 8.2.9.2.1.1 defines the General Media Event Record.

Determine if the event read is a general media record and if so trace
the record as a General Media Event Record.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC v2:
	Output DPA flags as a single field
	Ensure names of fields match what TP_print outputs
	Steven
		prefix TRACE_EVENT with 'cxl_'
	Jonathan
		Remove Reserved field

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
 drivers/cxl/core/mbox.c    |  40 ++++++++++--
 drivers/cxl/cxlmem.h       |  19 ++++++
 include/trace/events/cxl.h | 124 +++++++++++++++++++++++++++++++++++++
 3 files changed, 179 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f46558e09f08..6d48fdb07700 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -709,6 +709,38 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
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
+static bool cxl_event_tracing_enabled(void)
+{
+	return trace_cxl_generic_event_enabled() ||
+	       trace_cxl_general_media_enabled();
+}
+
+static void cxl_trace_event_record(const char *dev_name,
+				   enum cxl_event_log_type type,
+				   struct cxl_event_record_raw *record)
+{
+	uuid_t *id = &record->hdr.id;
+
+	if (uuid_equal(id, &gen_media_event_uuid)) {
+		struct cxl_event_gen_media *rec =
+				(struct cxl_event_gen_media *)record;
+
+		trace_cxl_general_media(dev_name, type, rec);
+		return;
+	}
+
+	/* For unknown record types print just the header */
+	trace_cxl_generic_event(dev_name, type, record);
+}
+
 static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
 				  enum cxl_event_log_type log,
 				  struct cxl_get_event_payload *get_pl, u16 nr)
@@ -754,11 +786,11 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
 			u16 nr_rec = min_t(u16, pl_nr, CXL_GET_EVENT_NR_RECORDS);
 			int i;
 
-			if (trace_cxl_generic_event_enabled()) {
+			if (cxl_event_tracing_enabled()) {
 				for (i = 0; i < nr_rec; i++)
-					trace_cxl_generic_event(dev_name(cxlds->dev),
-								type,
-								&payload.record[i]);
+					cxl_trace_event_record(dev_name(cxlds->dev),
+							       type,
+							       &payload.record[i]);
 			}
 
 			rc = cxl_clear_event_record(cxlds, type, &payload, nr_rec);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 28a114c7cf69..86197f3168c7 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -412,6 +412,25 @@ struct cxl_mbox_clear_event_payload {
 	__le16 handle[CXL_GET_EVENT_NR_RECORDS];
 };
 
+/*
+ * General Media Event Record
+ * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ */
+#define CXL_EVENT_GEN_MED_COMP_ID_SIZE	0x10
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
+	u8 reserved[0x2e];
+} __packed;
+
 struct cxl_mbox_get_partition_info {
 	__le64 active_volatile_cap;
 	__le64 active_persistent_cap;
diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
index 60dec9a84918..a0c20e110708 100644
--- a/include/trace/events/cxl.h
+++ b/include/trace/events/cxl.h
@@ -119,6 +119,130 @@ TRACE_EVENT(cxl_generic_event,
 		__print_hex(__entry->data, CXL_EVENT_RECORD_DATA_LENGTH))
 );
 
+/*
+ * Physical Address field masks
+ *
+ * General Media Event Record
+ * CXL v2.0 Section 8.2.9.1.1.1; Table 154
+ *
+ * DRAM Event Record
+ * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
+ */
+#define CXL_DPA_FLAGS_MASK			0x3F
+#define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
+
+#define CXL_DPA_VOLATILE			BIT(0)
+#define CXL_DPA_NOT_REPAIRABLE			BIT(1)
+#define show_dpa_flags(flags)	__print_flags(flags, "|",		   \
+	{ CXL_DPA_VOLATILE,			"VOLATILE"		}, \
+	{ CXL_DPA_NOT_REPAIRABLE,		"NOT_REPAIRABLE"	}  \
+)
+
+/*
+ * General Media Event Record - GMER
+ * CXL v2.0 Section 8.2.9.1.1.1; Table 154
+ */
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
+TRACE_EVENT(cxl_general_media,
+
+	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
+		 struct cxl_event_gen_media *rec),
+
+	TP_ARGS(dev_name, log, rec),
+
+	TP_STRUCT__entry(
+		CXL_EVT_TP_entry
+		/* General Media */
+		__field(u64, dpa)
+		__field(u8, descriptor)
+		__field(u8, type)
+		__field(u8, transaction_type)
+		__field(u8, channel)
+		__field(u32, device)
+		__array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
+		__field(u16, validity_flags)
+		/* Following are out of order to pack trace record */
+		__field(u8, rank)
+		__field(u8, dpa_flags)
+	),
+
+	TP_fast_assign(
+		CXL_EVT_TP_fast_assign(dev_name, log, rec->hdr);
+
+		/* General Media */
+		__entry->dpa = le64_to_cpu(rec->phys_addr);
+		__entry->dpa_flags = __entry->dpa & CXL_DPA_FLAGS_MASK;
+		/* Mask after flags have been parsed */
+		__entry->dpa &= CXL_DPA_MASK;
+		__entry->descriptor = rec->descriptor;
+		__entry->type = rec->type;
+		__entry->transaction_type = rec->transaction_type;
+		__entry->channel = rec->channel;
+		__entry->rank = rec->rank;
+		__entry->device = get_unaligned_le24(rec->device);
+		memcpy(__entry->comp_id, &rec->component_id,
+			CXL_EVENT_GEN_MED_COMP_ID_SIZE);
+		__entry->validity_flags = get_unaligned_le16(&rec->validity_flags);
+	),
+
+	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' " \
+		"descriptor='%s' type='%s' transaction_type='%s' channel=%u rank=%u " \
+		"device=%x comp_id=%s validity_flags='%s'",
+		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
+		show_event_desc_flags(__entry->descriptor),
+		show_mem_event_type(__entry->type),
+		show_trans_type(__entry->transaction_type),
+		__entry->channel, __entry->rank, __entry->device,
+		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
+		show_valid_flags(__entry->validity_flags)
+	)
+);
+
 #endif /* _CXL_TRACE_EVENTS_H */
 
 /* This part must be outside protection */
-- 
2.37.2

