Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11E35FA7C5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiJJWn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiJJWnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:43:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E007B2A6;
        Mon, 10 Oct 2022 15:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665441789; x=1696977789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SGSknFUw1dth8xbN7AnGtAgcUlKTySwtg9i2vQp+Sd0=;
  b=j2kebmWBueU3j4xCROsSe10LKg6gdWmpH+63IUtgROCWUWAClc/jUv2f
   Ky4amiTjOF+HWjzgGwQkyXlp66NjM+xnzjqE34+1VTjQwBUiZhwcguqGw
   zVfgcwKL9VCuWb7Fsis35BnnYkx7LycFeguMshLqMIrqvi4LgFMt56MBm
   wJ7OcVwKi56UKgoeCroHRkDHWBVBczWxSigNORryZD1/FnQbJCi2ZHJ2k
   IOUPfuHeFp5xB74n/NvFPXInJEF4jcJW+k7VsWOFauikvIARXQiTho7se
   ESOlKcNKY82e2S2I6PRNAFOGoGQVfy+1yGiz4RICS84hBK19HdMLrfntt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="287615384"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="287615384"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:43:07 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="621191365"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="621191365"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.252.141.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:43:07 -0700
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
Subject: [RFC V2 PATCH 06/11] cxl/mem: Trace DRAM Event Record
Date:   Mon, 10 Oct 2022 15:41:26 -0700
Message-Id: <20221010224131.1866246-7-ira.weiny@intel.com>
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

CXL rev 3.0 section 8.2.9.2.1.2 defines the DRAM Event Record.

Determine if the event read is a DRAM event record and if so trace the
record.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC:
	Add reserved byte data
	Use new CXL header macros
	Jonathan
		Use get_unaligned_le{24,16}() for unaligned fields
		Use 'else if'
	Dave Jiang
		s/cxl_dram_event/dram
		s/cxl_evt_dram_rec/cxl_event_dram
	Adjust for new phys addr mask
---
 drivers/cxl/core/mbox.c    | 14 ++++++
 drivers/cxl/cxlmem.h       | 24 ++++++++++
 include/trace/events/cxl.h | 94 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 1097250c115a..72b589edc074 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -720,6 +720,14 @@ static const uuid_t gen_media_event_uuid =
 	UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
 		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6);
 
+/*
+ * DRAM Event Record
+ * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
+ */
+static const uuid_t dram_event_uuid =
+	UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
+		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24);
+
 static void cxl_trace_event_record(const char *dev_name,
 				   enum cxl_event_log_type type,
 				   struct cxl_get_event_payload *payload)
@@ -732,6 +740,12 @@ static void cxl_trace_event_record(const char *dev_name,
 
 		trace_general_media(dev_name, type, rec);
 		return;
+	} else if (uuid_equal(id, &dram_event_uuid)) {
+		struct cxl_event_dram *rec =
+				(struct cxl_event_dram *)&payload->record;
+
+		trace_dram(dev_name, type, rec);
+		return;
 	}
 
 	/* For unknown record types print just the header */
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index b5c120bd4068..d0253e5f1187 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -431,6 +431,30 @@ struct cxl_event_gen_media {
 	u8 reserved[CXL_EVENT_GEN_MED_RES_SIZE];
 } __packed;
 
+/*
+ * DRAM Event Record - DER
+ * CXL rev 3.0 section 8.2.9.2.1.2; Table 3-44
+ */
+#define CXL_EVENT_DER_CORRECTION_MASK_SIZE	0x20
+#define CXL_EVENT_DER_RES_SIZE			0x17
+struct cxl_event_dram {
+	struct cxl_event_record_hdr hdr;
+	__le64 phys_addr;
+	u8 descriptor;
+	u8 type;
+	u8 transaction_type;
+	u8 validity_flags[2];
+	u8 channel;
+	u8 rank;
+	u8 nibble_mask[3];
+	u8 bank_group;
+	u8 bank;
+	u8 row[3];
+	u8 column[2];
+	u8 correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE];
+	u8 reserved[CXL_EVENT_DER_RES_SIZE];
+} __packed;
+
 struct cxl_mbox_get_partition_info {
 	__le64 active_volatile_cap;
 	__le64 active_persistent_cap;
diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
index 82a8d3b750a2..7a90cfea348b 100644
--- a/include/trace/events/cxl.h
+++ b/include/trace/events/cxl.h
@@ -230,6 +230,100 @@ TRACE_EVENT(general_media,
 		)
 );
 
+/*
+ * DRAM Event Record - DER
+ *
+ * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
+ */
+/*
+ * DRAM Event Record defines many fields the same as the General Media Event
+ * Record.  Reuse those definitions as appropriate.
+ */
+#define CXL_DER_VALID_CHANNEL				BIT(0)
+#define CXL_DER_VALID_RANK				BIT(1)
+#define CXL_DER_VALID_NIBBLE				BIT(2)
+#define CXL_DER_VALID_BANK_GROUP			BIT(3)
+#define CXL_DER_VALID_BANK				BIT(4)
+#define CXL_DER_VALID_ROW				BIT(5)
+#define CXL_DER_VALID_COLUMN				BIT(6)
+#define CXL_DER_VALID_CORRECTION_MASK			BIT(7)
+#define show_dram_valid_flags(flags)	__print_flags(flags, "|",			   \
+	{ CXL_DER_VALID_CHANNEL,			"CHANNEL"		}, \
+	{ CXL_DER_VALID_RANK,				"RANK"			}, \
+	{ CXL_DER_VALID_NIBBLE,				"NIBBLE"		}, \
+	{ CXL_DER_VALID_BANK_GROUP,			"BANK GROUP"		}, \
+	{ CXL_DER_VALID_BANK,				"BANK"			}, \
+	{ CXL_DER_VALID_ROW,				"ROW"			}, \
+	{ CXL_DER_VALID_COLUMN,				"COLUMN"		}, \
+	{ CXL_DER_VALID_CORRECTION_MASK,		"CORRECTION MASK"	}  \
+)
+
+TRACE_EVENT(dram,
+
+	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
+		 struct cxl_event_dram *rec),
+
+	TP_ARGS(dev_name, log, rec),
+
+	TP_STRUCT__entry(
+		CXL_EVT_TP_entry
+		/* DRAM */
+		__field(u64, phys_addr)
+		__field(u8, descriptor)
+		__field(u8, type)
+		__field(u8, transaction_type)
+		__field(u8, channel)
+		__field(u16, validity_flags)
+		__field(u16, column)	/* Out of order to pack trace record */
+		__field(u32, nibble_mask)
+		__field(u32, row)
+		__array(u8, cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE)
+		__array(u8, reserved, CXL_EVENT_DER_RES_SIZE)
+		__field(u8, rank)	/* Out of order to pack trace record */
+		__field(u8, bank_group)	/* Out of order to pack trace record */
+		__field(u8, bank)	/* Out of order to pack trace record */
+	),
+
+	TP_fast_assign(
+		CXL_EVT_TP_fast_assign(dev_name, log, rec->hdr);
+
+		/* DRAM */
+		__entry->phys_addr = le64_to_cpu(rec->phys_addr);
+		__entry->descriptor = rec->descriptor;
+		__entry->type = rec->type;
+		__entry->transaction_type = rec->transaction_type;
+		__entry->validity_flags = get_unaligned_le16(rec->validity_flags);
+		__entry->channel = rec->channel;
+		__entry->rank = rec->rank;
+		__entry->nibble_mask = get_unaligned_le24(rec->nibble_mask);
+		__entry->bank_group = rec->bank_group;
+		__entry->bank = rec->bank;
+		__entry->row = get_unaligned_le24(rec->row);
+		__entry->column = get_unaligned_le16(rec->column);
+		memcpy(__entry->cor_mask, &rec->correction_mask,
+			CXL_EVENT_DER_CORRECTION_MASK_SIZE);
+		memcpy(__entry->reserved, &rec->reserved,
+			CXL_EVENT_DER_RES_SIZE);
+	),
+
+	CXL_EVT_TP_printk("phys_addr=%llx volatile=%s desc='%s' type='%s' " \
+		"trans_type='%s' channel=%u rank=%u nibble_mask=%x " \
+		"bank_group=%u bank=%u row=%u column=%u cor_mask=%s " \
+		"valid_flags='%s' reserved=%s",
+		__entry->phys_addr & CXL_GMER_PHYS_ADDR_MASK,
+		(__entry->phys_addr & CXL_GMER_PHYS_ADDR_VOLATILE) ? "TRUE" : "FALSE",
+		show_event_desc_flags(__entry->descriptor),
+		show_mem_event_type(__entry->type),
+		show_trans_type(__entry->transaction_type),
+		__entry->channel, __entry->rank, __entry->nibble_mask,
+		__entry->bank_group, __entry->bank,
+		__entry->row, __entry->column,
+		__print_hex(__entry->cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE),
+		show_dram_valid_flags(__entry->validity_flags),
+		__print_hex(__entry->reserved, CXL_EVENT_DER_RES_SIZE)
+		)
+);
+
 #endif /* _CXL_TRACE_EVENTS_H */
 
 /* This part must be outside protection */
-- 
2.37.2

