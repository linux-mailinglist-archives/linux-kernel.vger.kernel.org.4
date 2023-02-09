Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EF7691482
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjBIXfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjBIXez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:34:55 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B17D6E891;
        Thu,  9 Feb 2023 15:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675985670; x=1707521670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zuwc1m+vbftupav4vZpK2NNYPN3Qaqlb6C2lE3DNfUY=;
  b=fChwPiiskdK1q1A3XseUh9/+wJX6ZgMCU5r3Liypl30sRtg1bzD+pMMI
   01j5g0zsm11II9epV3Sz9HY66Sq+BB5XLkKXRpc2qeA6/Xc59x3rtgMW5
   Y8ROGQ++nTA2/nX4gIi/KS236My506+NzklHaSSZ9UNMTDMhIiyKaPNTS
   E6IUkOXZ0FJtrkjKbRw4ZKH71wIzST+odAiJe2p+RDxgsWarrIml6CWCZ
   snELYRHk5zeP/B5WkZ0ALSWuD3OqilFx+yf2zkGmW1UfbYPdPNSziPJmW
   lpZwf8MeEd7CFA8WkPpdDm2u99eFbXjl6TiWVtLpDNC8fgzmcCVS3+L48
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="416508698"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="416508698"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 15:33:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="756592028"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="756592028"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.13.232])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 15:33:03 -0800
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
Subject: [PATCH v6 1/6] cxl/mbox: Add GET_POISON_LIST mailbox command
Date:   Thu,  9 Feb 2023 15:32:54 -0800
Message-Id: <f21354678bc15432b3eaa6c5c372ae4c6dcd2a28.1675983077.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1675983077.git.alison.schofield@intel.com>
References: <cover.1675983077.git.alison.schofield@intel.com>
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
 drivers/cxl/core/mbox.c | 72 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    | 67 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/pci.c       |  4 +++
 3 files changed, 143 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 03909b6cef55..a57de8896846 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -5,6 +5,8 @@
 #include <linux/debugfs.h>
 #include <linux/ktime.h>
 #include <linux/mutex.h>
+#include <asm/unaligned.h>
+#include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
 
@@ -989,6 +991,7 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
 	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
 	struct cxl_mbox_identify id;
 	struct cxl_mbox_cmd mbox_cmd;
+	u32 val;
 	int rc;
 
 	mbox_cmd = (struct cxl_mbox_cmd) {
@@ -1012,6 +1015,11 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
 	cxlds->lsa_size = le32_to_cpu(id.lsa_size);
 	memcpy(cxlds->firmware_version, id.fw_revision, sizeof(id.fw_revision));
 
+	if (test_bit(CXL_MEM_COMMAND_ID_GET_POISON, cxlds->enabled_cmds)) {
+		val = get_unaligned_le24(id.poison_list_max_mer);
+		cxlds->poison.max_errors = min_t(u32, val, CXL_POISON_LIST_MAX);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
@@ -1102,6 +1110,70 @@ int cxl_set_timestamp(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
 
+int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
+		       struct cxl_region *cxlr)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_mbox_poison_payload_out *po;
+	struct cxl_mbox_poison_payload_in pi;
+	struct cxl_mbox_cmd mbox_cmd;
+	int nr_records = 0;
+	int rc;
+
+	rc = mutex_lock_interruptible(&cxlds->poison.lock);
+	if (rc)
+		return rc;
+
+	po = cxlds->poison.payload_out;
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
+		if (nr_records >= cxlds->poison.max_errors) {
+			dev_dbg(&cxlmd->dev, "Max Error Records reached: %d\n",
+				nr_records);
+			break;
+		}
+	} while (po->flags & CXL_POISON_FLAG_MORE);
+
+	mutex_unlock(&cxlds->poison.lock);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison, CXL);
+
+int cxl_poison_state_init(struct cxl_dev_state *cxlds)
+{
+	if (!test_bit(CXL_MEM_COMMAND_ID_GET_POISON, cxlds->enabled_cmds))
+		return 0;
+
+	cxlds->poison.payload_out = devm_kzalloc(cxlds->dev,
+						 cxlds->payload_size,
+						 GFP_KERNEL);
+	if (!cxlds->poison.payload_out)
+		return -ENOMEM;
+
+	mutex_init(&cxlds->poison.lock);
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
+
 struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
 {
 	struct cxl_dev_state *cxlds;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 802b5b396daf..17ea575f8a06 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -222,6 +222,24 @@ struct cxl_event_state {
 	struct mutex log_lock;
 };
 
+/**
+ * struct cxl_poison_state - Poison list retrieval
+ *
+ * @max_errors: Maximum media error records held in device cache
+ * @payload_out: The poison list payload returned by device
+ * @lock: Protect reads of the poison list
+ *
+ * Reads of the poison list are synchronized to ensure that a reader
+ * does not get an incomplete list because their request overlapped
+ * (was interrupted or preceded by) another read request of the same
+ * DPA range. CXL Spec 3.0 Section 8.2.9.8.4.1
+ */
+struct cxl_poison_state {
+	u32 max_errors;
+	struct cxl_mbox_poison_payload_out *payload_out;
+	struct mutex lock;  /* Protect reads of poison list */
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -257,6 +275,7 @@ struct cxl_event_state {
  * @info: Cached DVSEC information about the device.
  * @serial: PCIe Device Serial Number
  * @doe_mbs: PCI DOE mailbox array
+ * @poison: poison list retrieval info
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
@@ -296,6 +315,7 @@ struct cxl_dev_state {
 	struct xarray doe_mbs;
 
 	struct cxl_event_state event;
+	struct cxl_poison_state poison;
 
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
 };
@@ -544,6 +564,50 @@ struct cxl_mbox_set_timestamp_in {
 
 } __packed;
 
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
@@ -615,6 +679,9 @@ void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds
 void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
 void cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status);
 int cxl_set_timestamp(struct cxl_dev_state *cxlds);
+int cxl_poison_state_init(struct cxl_dev_state *cxlds);
+int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
+		       struct cxl_region *cxlr);
 
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4cf9a2191602..7ca06016dac9 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -713,6 +713,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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

