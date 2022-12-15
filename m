Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8011E64E2F5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 22:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiLOVSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 16:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiLOVSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:18:02 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CFE5444E;
        Thu, 15 Dec 2022 13:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671139080; x=1702675080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9wR2gE1D6Xa9ST52IXr4SoxXZETBGlJVCgYIYR4AvqU=;
  b=lS2AemA0qBO4+9N+AgFEXoRMqfigCGLGLDnM72vb0UngEpcPE3xep1Fe
   FAzgCp2UqlqXQNGt8m1r+C+/PoSJFfH8ZGkx+2FD5v2m64K8B77n6ZVzR
   hPuZE/TUpdFJICSUUpNaqrMB0ApfNebClsiaAIw3zPBuvZAYzqN2LBkhW
   6CeX2xH0Of1gFKjRgsDShyooQgk3q9vH4QcrmELq3DVF3IrvU9eKDSEeA
   yLLXI2Wy14DwC5726xXA4M+U+D765UJgRDOoH06sremkjHmLueFM74ElL
   Xii5heFFzHI1YZsfgvVJv/acCc7IjikQExsAPfWjd1pkeq80+xdZmGTEV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="302230292"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="302230292"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 13:17:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="649570077"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="649570077"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.55.178])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 13:17:50 -0800
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
Subject: [PATCH v4 1/5] cxl/mbox: Add GET_POISON_LIST mailbox command
Date:   Thu, 15 Dec 2022 13:17:43 -0800
Message-Id: <5e402c5f6adbdcf9943b7b7fdf391abe6c4cb198.1671135967.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1671135967.git.alison.schofield@intel.com>
References: <cover.1671135967.git.alison.schofield@intel.com>
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
 drivers/cxl/core/mbox.c | 75 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    | 67 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/pci.c       |  4 +++
 3 files changed, 146 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index b03fba212799..dfe24a2adfdb 100644
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
@@ -857,6 +865,73 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
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
+		/* At least flags, overflow_t, and count must be valid */
+		.min_out = 12,
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

