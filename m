Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD4B5FCD25
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiJLV2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJLV23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:28:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ED21187B8;
        Wed, 12 Oct 2022 14:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665610108; x=1697146108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VrxHuMpgkOPkAI6Z8ozNVsBV1nAycHBihR/5S4R8jxc=;
  b=GGs0IY3C/Oj95ffxFE0ObSlE9iGthDJgOiQZt4Cbpv/Isqhv053K4n9Y
   sQXiAInLPizV0X1LTzk9v/klLCMpCYUyEROGT85fX/vYWuq7P0A9MONKT
   6K0Y/Sawj6IJ0B9AjxpOkjhIsY6DUNyfcIHIo1UhhdyBgmRXkyYJG7GIO
   RMorSmw1/wmspPTWkHJ1GXDn3N2QpnNaPdElFPVlIXXMflywfpsWWJd2W
   rl3vhLO8FmJkXL4FHnpQLtiGD8zk+iR+/GYXsHSTLhjtVUHViOZ4AOaBB
   wEIOF2GlXuA1ISKElXhgWjkzBUsgEMPptYdPbbrepamFsXVuFjNWxriMZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="306543877"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="306543877"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 14:28:27 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="689834237"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="689834237"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.251.3.191])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 14:28:26 -0700
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
Subject: [PATCH v2 2/4] cxl/mbox: Add GET_POISON_LIST mailbox command
Date:   Wed, 12 Oct 2022 14:28:18 -0700
Message-Id: <54b9c0b570636c04f1caaff5ac66e56128568732.1665606782.git.alison.schofield@intel.com>
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

CXL devices maintain a list of locations that are poisoned or result
in poison if the addresses are accessed by the host.

Per the spec (CXL 3.0 8.2.9.8.4.1), the device returns this Poison
list as a set of  Media Error Records that include the source of the
error, the starting device physical address and length. The length is
the number of adjacent DPAs in the record and is in units of 64 bytes.

Retrieve the list and log each Media Error Record as a trace event of
type 'cxl_poison'.

Use an optional 'region_name' parameter and include it in the trace
event, to identify per region poison collection.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Trace field 'hpa' is always zero here. Another patch doing the
address translation trails this one, and will fill it in.
Happy to remove it here if the foreshadowing is unwanted.


 drivers/cxl/core/mbox.c | 69 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    | 42 +++++++++++++++++++++++++
 2 files changed, 111 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 40e3ccb2bf3e..f982645e35e4 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -9,6 +9,9 @@
 
 #include "core.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/cxl.h>
+
 static bool cxl_raw_allow_all;
 
 /**
@@ -750,6 +753,7 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
 {
 	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
 	struct cxl_mbox_identify id;
+	__le32 val = 0;
 	int rc;
 
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_IDENTIFY, NULL, 0, &id,
@@ -769,6 +773,9 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
 	cxlds->lsa_size = le32_to_cpu(id.lsa_size);
 	memcpy(cxlds->firmware_version, id.fw_revision, sizeof(id.fw_revision));
 
+	memcpy(&val, id.poison_list_max_mer, 3);
+	cxlds->poison_max = min_t(u32, le32_to_cpu(val), CXL_POISON_LIST_MAX);
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
@@ -833,6 +840,67 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
 
+int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
+		       const char *region_name)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_mbox_poison_payload_out *po;
+	struct cxl_mbox_poison_payload_in pi;
+	int nr_records = 0;
+	int rc, i;
+
+	po = kvmalloc(cxlds->payload_size, GFP_KERNEL);
+	if (!po)
+		return -ENOMEM;
+
+	pi.offset = cpu_to_le64(offset);
+	pi.length = cpu_to_le64(len);
+
+	rc = mutex_lock_interruptible(&cxlds->poison_list_mutex);
+	if (rc)
+		goto out;
+
+	do {
+		u64 overflow_t = 0;
+
+		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_POISON, &pi,
+				       sizeof(pi), po, cxlds->payload_size);
+		if (rc)
+			break;
+
+		if (po->flags & CXL_POISON_FLAG_OVERFLOW)
+			overflow_t = le64_to_cpu(po->overflow_timestamp);
+
+		for (i = 0; i < le16_to_cpu(po->count); i++) {
+			u32 len = le32_to_cpu(po->record[i].length) *
+					      CXL_POISON_LEN_MULT;
+			u64 addr = le64_to_cpu(po->record[i].address);
+			u8 source = addr & CXL_POISON_SOURCE_MASK;
+			u64 dpa = addr & CXL_POISON_START_MASK;
+			u64 hpa = 0;
+
+			trace_cxl_poison(current->pid, region_name,
+					 dev_name(&cxlmd->dev),
+					 dev_name(cxlds->dev), hpa, dpa, len,
+					 source, po->flags, overflow_t);
+		}
+
+		/* Protect against an uncleared _FLAG_MORE */
+		nr_records = nr_records + le16_to_cpu(po->count);
+		if (nr_records >= cxlds->poison_max) {
+			dev_dbg(&cxlmd->dev, "Max Error Records reached: %d\n",
+				nr_records);
+			break;
+		}
+	} while (po->flags & CXL_POISON_FLAG_MORE);
+
+	mutex_unlock(&cxlds->poison_list_mutex);
+out:
+	kvfree(po);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison, CXL);
+
 struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
 {
 	struct cxl_dev_state *cxlds;
@@ -844,6 +912,7 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
 	}
 
 	mutex_init(&cxlds->mbox_mutex);
+	mutex_init(&cxlds->poison_list_mutex);
 	cxlds->dev = dev;
 
 	return cxlds;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a83bb6782d23..f5c6992de236 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -192,6 +192,8 @@ struct cxl_endpoint_dvsec_info {
  *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
  * @lsa_size: Size of Label Storage Area
  *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
+ * @poison_max: maximum media error records held in device cache
+ * @poison_list_mutex: Mutex to synchronize poison list retrieval
  * @mbox_mutex: Mutex to synchronize mailbox access.
  * @firmware_version: Firmware version for the memory device.
  * @enabled_cmds: Hardware commands found enabled in CEL.
@@ -223,6 +225,8 @@ struct cxl_dev_state {
 
 	size_t payload_size;
 	size_t lsa_size;
+	u32 poison_max;
+	struct mutex poison_list_mutex;  /* Protect reads of poison list */
 	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
 	char firmware_version[0x10];
 	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
@@ -344,6 +348,42 @@ struct cxl_mbox_set_partition_info {
 
 #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
 
+struct cxl_mbox_poison_payload_in {
+	__le64 offset;
+	__le64 length;
+} __packed;
+
+struct cxl_mbox_poison_payload_out {
+	u8 flags;
+	u8 rsvd1;
+	__le64 overflow_timestamp;
+	__le16 count;
+	u8 rsvd2[0x14];
+	struct cxl_poison_record {
+		__le64 address;
+		__le32 length;
+		__le32 rsvd;
+	} __packed record[];
+} __packed;
+
+/* CXL 8.2.9.5.4.1 Get Poison List payload out flags */
+#define CXL_POISON_FLAG_MORE            BIT(0)
+#define CXL_POISON_FLAG_OVERFLOW        BIT(1)
+#define CXL_POISON_FLAG_SCANNING        BIT(2)
+
+/*
+ * CXL 8.2.9.5.4.1 Get Poison List address field encodes both the
+ * starting address of poison, and the source of the poison.
+ */
+#define CXL_POISON_START_MASK		GENMASK_ULL(63, 6)
+#define CXL_POISON_SOURCE_MASK		GENMASK(2, 0)
+
+/* CXL 8.2.9.5.4.1 Table 188: Length is in units of 64 bytes */
+#define CXL_POISON_LEN_MULT	64
+
+/* Kernel maximum for a cache of media poison errors */
+#define CXL_POISON_LIST_MAX	1024
+
 /**
  * struct cxl_mem_command - Driver representation of a memory device command
  * @info: Command information as it exists for the UAPI
@@ -378,6 +418,8 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
 struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
 void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
 void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
+int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
+		       const char *region_name);
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
 void cxl_mem_active_dec(void);
-- 
2.37.3

