Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBBD6C4030
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 03:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCVCMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 22:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCVCM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 22:12:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD49157D1E;
        Tue, 21 Mar 2023 19:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679451144; x=1710987144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GNjeYwENcvrJafsH7MHEUoVOCPWNOu2+6KTBIVqNwL0=;
  b=Hi5eongWipeIvNGh8D582LyxsCKi4w72o29ueviMabVLKlew/h5Mv0vc
   xRGaFs/Bm90yyZn8Wndj7wCT5oIJfJM1jhYctu6jUMfD2GbitEkIN/kuJ
   PQNzWs0nk4EfBwaIq2IDSczPTeepVLsu0YSGz49+0t3mbOFH98PXN3KI5
   c+gGMfMHB9QOkTtgsa86aN2tjgX+FPsWR3zxlgOzKxeIg3ls7RgC//JFe
   iIn3eyjaE9rstTPIX6bLVQSLX0gdSn9Coc+oIzTqfWye/GIgMNbqGjiqb
   9x5OKIw/ugN1gyTJZgQcd3L57H81fqUF/m/EFtbPNykowPQ8v9VWa2k4a
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="401677433"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="401677433"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 19:12:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="746126844"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="746126844"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.251.21.85])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 19:12:23 -0700
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
Subject: [PATCH v10 1/6] cxl/mbox: Add GET_POISON_LIST mailbox command
Date:   Tue, 21 Mar 2023 19:12:14 -0700
Message-Id: <7789c4ab210ca309b449ae948d3e56c44aaff38d.1679448904.git.alison.schofield@intel.com>
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

CXL devices maintain a list of locations that are poisoned or result
in poison if the addresses are accessed by the host.

Per the spec (CXL 3.0 8.2.9.8.4.1), the device returns this Poison
list as a set of  Media Error Records that include the source of the
error, the starting device physical address and length. The length is
the number of adjacent DPAs in the record and is in units of 64 bytes.

Retrieve the poison list.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/mbox.c | 72 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    | 67 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/pci.c       |  4 +++
 3 files changed, 143 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f2addb457172..0da0a30511f2 100644
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
 
@@ -994,6 +996,7 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
 	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
 	struct cxl_mbox_identify id;
 	struct cxl_mbox_cmd mbox_cmd;
+	u32 val;
 	int rc;
 
 	mbox_cmd = (struct cxl_mbox_cmd) {
@@ -1017,6 +1020,11 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
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
@@ -1107,6 +1115,70 @@ int cxl_set_timestamp(struct cxl_dev_state *cxlds)
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
index ccbafc05a636..57a5999ddb35 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -215,6 +215,24 @@ struct cxl_event_state {
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
@@ -251,6 +269,7 @@ struct cxl_event_state {
  * @serial: PCIe Device Serial Number
  * @doe_mbs: PCI DOE mailbox array
  * @event: event log driver state
+ * @poison: poison list retrieval info
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
@@ -290,6 +309,7 @@ struct cxl_dev_state {
 	struct xarray doe_mbs;
 
 	struct cxl_event_state event;
+	struct cxl_poison_state poison;
 
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
 };
@@ -538,6 +558,50 @@ struct cxl_mbox_set_timestamp_in {
 
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
@@ -608,6 +672,9 @@ void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds
 void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
 void cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status);
 int cxl_set_timestamp(struct cxl_dev_state *cxlds);
+int cxl_poison_state_init(struct cxl_dev_state *cxlds);
+int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
+		       struct cxl_region *cxlr);
 
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 60b23624d167..827ea0895778 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -769,6 +769,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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

