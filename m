Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AD06728EF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjARUC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjARUCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:02:33 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16F6521F8;
        Wed, 18 Jan 2023 12:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674072151; x=1705608151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e2RBSthBY4E3exqvT5N+VtLm2wQXWJbyt9mn0kG6s3Q=;
  b=cRQ8QVumS0f2tyhQQSmz0krus92w6DVFJsjlfxT1Fukt989yAKX4qznq
   N5NETS6IcCIqJoikDxv6nz1OXvvntU70T9/5wwnu4ankckv/5udxTYv2J
   EIqQlK49ugyqYT89ARiWXPRkiuf7gLtUY18aAQ75yABtL+saiFmd43B7f
   K+ahKViPjYQ7UhXSxgpnLzw/rxB/yfNth9odN5dg4cSEKWWQKQ98bqEKJ
   sklzvgH/OcomY56vgeG7yd9oIDCEDXIECRWkDLhzqBCNe8kzdv5H7LZxY
   citT5tTXxRweyiDfHoOQzW9WP8LLlTsSTEt3l+/hi8daRHzCCo/KfvEEH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322776774"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="322776774"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 12:02:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="661861670"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="661861670"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.119.104])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 12:02:25 -0800
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
Subject: [PATCH v5 1/5] cxl/mbox: Add GET_POISON_LIST mailbox command
Date:   Wed, 18 Jan 2023 12:02:17 -0800
Message-Id: <de11785ff05844299b40b100f8e0f56c7eef7f08.1674070170.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1674070170.git.alison.schofield@intel.com>
References: <cover.1674070170.git.alison.schofield@intel.com>
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

CXL devices maintain a list of locations that are poisoned or result
in poison if the addresses are accessed by the host.

Per the spec (CXL 3.0 8.2.9.8.4.1), the device returns this Poison
list as a set of  Media Error Records that include the source of the
error, the starting device physical address and length. The length is
the number of adjacent DPAs in the record and is in units of 64 bytes.

Retrieve the poison list.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/mbox.c | 74 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    | 67 +++++++++++++++++++++++++++++++++++++
 drivers/cxl/pci.c       |  4 +++
 3 files changed, 145 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index b03fba212799..a38be141e108 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -4,7 +4,9 @@
 #include <linux/security.h>
 #include <linux/debugfs.h>
 #include <linux/mutex.h>
+#include <asm/unaligned.h>
 #include <cxlmem.h>
+#include <cxlpci.h>
 #include <cxl.h>
 
 #include "core.h"
@@ -770,6 +772,7 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
 	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
 	struct cxl_mbox_identify id;
 	struct cxl_mbox_cmd mbox_cmd;
+	u32 val;
 	int rc;
 
 	mbox_cmd = (struct cxl_mbox_cmd) {
@@ -793,6 +796,11 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
 	cxlds->lsa_size = le32_to_cpu(id.lsa_size);
 	memcpy(cxlds->firmware_version, id.fw_revision, sizeof(id.fw_revision));
 
+	if (test_bit(CXL_MEM_COMMAND_ID_GET_POISON, cxlds->enabled_cmds)) {
+		val = get_unaligned_le24(id.poison_list_max_mer);
+		cxlds->poison.max_mer = min_t(u32, val, CXL_POISON_LIST_MAX);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
@@ -857,6 +865,72 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
 
+int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
+		       struct cxl_region *cxlr)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_poison_state *cxlps = &cxlds->poison;
+	struct cxl_mbox_poison_payload_out *po;
+	struct cxl_mbox_poison_payload_in pi;
+	struct cxl_mbox_cmd mbox_cmd;
+	int nr_records = 0;
+	int rc;
+
+	rc = mutex_lock_interruptible(&cxlps->getpoison_lock);
+	if (rc)
+		return rc;
+
+	po = cxlps->getpoison_po;
+	pi.offset = cpu_to_le64(offset);
+	pi.length = cpu_to_le64(len / CXL_POISON_LEN_MULT);
+
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_GET_POISON,
+		.size_in = sizeof(pi),
+		.payload_in = &pi,
+		.size_out = cxlds->payload_size,
+		.payload_out = po,
+		.min_out = struct_size(po, record, 0),
+	};
+
+	do {
+		rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
+		if (rc)
+			break;
+
+		/* TODO TRACE the media error records */
+
+		/* Protect against an uncleared _FLAG_MORE */
+		nr_records = nr_records + le16_to_cpu(po->count);
+		if (nr_records >= cxlps->max_mer) {
+			dev_dbg(&cxlmd->dev, "Max Error Records reached: %d\n",
+				nr_records);
+			break;
+		}
+	} while (po->flags & CXL_POISON_FLAG_MORE);
+
+	mutex_unlock(&cxlps->getpoison_lock);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison, CXL);
+
+int cxl_poison_state_init(struct cxl_dev_state *cxlds)
+{
+	struct cxl_poison_state *cxlps = &cxlds->poison;
+
+	if (!test_bit(CXL_MEM_COMMAND_ID_GET_POISON, cxlds->enabled_cmds))
+		return 0;
+
+	cxlps->getpoison_po = devm_kzalloc(cxlds->dev, cxlds->payload_size,
+					   GFP_KERNEL);
+	if (!cxlps->getpoison_po)
+		return -ENOMEM;
+
+	mutex_init(&cxlps->getpoison_lock);
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
+
 struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
 {
 	struct cxl_dev_state *cxlds;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ab138004f644..f53fae20f502 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -193,6 +193,24 @@ struct cxl_endpoint_dvsec_info {
 	struct range dvsec_range[2];
 };
 
+/**
+ * struct cxl_poison_state - Poison list retrieval
+ *
+ * @max_mer: Maximum media error records held in device cache
+ * @getpoison_po: The poison list payload returned by device
+ * @getpoison_lock: Protect reads of the poison list
+ *
+ * Reads of the poison list are synchronized to ensure that a reader
+ * does not get an incomplete list because their request overlapped
+ * (was interrupted or preceded by) another read request of the same
+ * DPA range. CXL Spec 3.0 Section 8.2.9.8.4.1
+ */
+struct cxl_poison_state {
+	u32 max_mer;
+	void *getpoison_po;
+	struct mutex getpoison_lock;  /* Protect reads of poison list */
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -211,6 +229,7 @@ struct cxl_endpoint_dvsec_info {
  *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
  * @mbox_mutex: Mutex to synchronize mailbox access.
  * @firmware_version: Firmware version for the memory device.
+ * @poison: Poison list retrieval
  * @enabled_cmds: Hardware commands found enabled in CEL.
  * @exclusive_cmds: Commands that are kernel-internal only
  * @dpa_res: Overall DPA resource tree for the device
@@ -245,6 +264,7 @@ struct cxl_dev_state {
 	size_t lsa_size;
 	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
 	char firmware_version[0x10];
+	struct cxl_poison_state poison;
 	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
 	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
 
@@ -372,6 +392,50 @@ struct cxl_mbox_set_partition_info {
 
 #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
 
+/* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
+struct cxl_mbox_poison_payload_in {
+	__le64 offset;
+	__le64 length;
+} __packed;
+
+struct cxl_mbox_poison_payload_out {
+	u8 flags;
+	u8 rsvd1;
+	__le64 overflow_t;
+	__le16 count;
+	u8 rsvd2[20];
+	struct cxl_poison_record {
+		__le64 address;
+		__le32 length;
+		__le32 rsvd;
+	} __packed record[];
+} __packed;
+
+/*
+ * Get Poison List address field encodes the starting
+ * address of poison, and the source of the poison.
+ */
+#define CXL_POISON_START_MASK		GENMASK_ULL(63, 6)
+#define CXL_POISON_SOURCE_MASK		GENMASK(2, 0)
+
+/* Get Poison List record length is in units of 64 bytes */
+#define CXL_POISON_LEN_MULT	64
+
+/* Kernel defined maximum for a list of poison errors */
+#define CXL_POISON_LIST_MAX	1024
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
@@ -441,6 +505,9 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
 struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
 void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
 void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
+int cxl_poison_state_init(struct cxl_dev_state *cxlds);
+int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
+		       struct cxl_region *cxlr);
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
 void cxl_mem_active_dec(void);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 3a66aadb4df0..d21357f3eca0 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -482,6 +482,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = cxl_poison_state_init(cxlds);
+	if (rc)
+		return rc;
+
 	rc = cxl_dev_state_identify(cxlds);
 	if (rc)
 		return rc;
-- 
2.37.3

