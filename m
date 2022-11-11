Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB0F625155
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiKKDNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbiKKDMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:12:54 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4382EF42;
        Thu, 10 Nov 2022 19:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668136373; x=1699672373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bOUKwtAc44fVEJb7Wp1v8fcxde+NjnUeKTqw0XJ/NhE=;
  b=E91T1odnuhzb0VGz10mPVFEfi6kcE77X76saFnr5fpy2oR3J+4MN7a5x
   hHdQksXlJo17bmFsKeYHY7vOken8PWFtRZRclVPr6vUEwMkf+KMfY3G4s
   kohV/7H860ijPP0shU2+IhKALSTTxSPJOJxHrKBnwQSeq+tXT4zIJghdv
   6b8QlHF4dOt/JsYWKPuXlAxtlQsoKBiNmfujB40erptfg+VXaLTB4kcn1
   HpHnDpsQS5Vx47OTNew7574gvdXcbAfSh5aoihWv+oVSQg6RK7DnLXPf+
   QagJgpRjcbL2HRPvGeChsg1puKdLx8HWb0HEvFSTEX5mn4cesqBaFyIQt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="310224404"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="310224404"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 19:12:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="812296069"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="812296069"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.161.45])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 19:12:51 -0800
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
Subject: [PATCH v3 2/6] cxl/mbox: Add GET_POISON_LIST mailbox command
Date:   Thu, 10 Nov 2022 19:12:40 -0800
Message-Id: <46c7c7339224744fce424b196da3e5566effec17.1668115235.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1668115235.git.alison.schofield@intel.com>
References: <cover.1668115235.git.alison.schofield@intel.com>
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

When the poison list is requested by region, include the region name
and uuid in the trace event.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/mbox.c | 81 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    | 37 +++++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 0c90f13870a4..88f034e97812 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -9,6 +9,9 @@
 
 #include "core.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/cxl.h>
+
 static bool cxl_raw_allow_all;
 
 /**
@@ -752,6 +755,7 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
 {
 	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
 	struct cxl_mbox_identify id;
+	__le32 val = 0;
 	int rc;
 
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_IDENTIFY, NULL, 0, &id,
@@ -771,6 +775,9 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
 	cxlds->lsa_size = le32_to_cpu(id.lsa_size);
 	memcpy(cxlds->firmware_version, id.fw_revision, sizeof(id.fw_revision));
 
+	memcpy(&val, id.poison_list_max_mer, 3);
+	cxlds->poison_max = min_t(u32, le32_to_cpu(val), CXL_POISON_LIST_MAX);
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
@@ -835,6 +842,79 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
 
+static void cxl_trace_poison(struct cxl_mbox_poison_payload_out *po,
+			     struct cxl_region *cxlr,
+			     const char *memdev_name,
+			     const char *pcidev_name)
+{
+	const char *region_name = cxlr ? dev_name(&cxlr->dev) : NULL;
+	struct cxl_region_params *p = cxlr ? &cxlr->params : NULL;
+	uuid_t *uuid = p ? &p->uuid : NULL;
+	u64 addr, dpa, overflow_t = 0;
+	u8 source;
+	u32 len;
+
+	if (po->flags & CXL_POISON_FLAG_OVERFLOW)
+		overflow_t = le64_to_cpu(po->overflow_timestamp);
+
+	for (int i = 0; i < le16_to_cpu(po->count); i++) {
+		len = le32_to_cpu(po->record[i].length) * CXL_POISON_LEN_MULT;
+		addr = le64_to_cpu(po->record[i].address);
+		source = addr & CXL_POISON_SOURCE_MASK;
+		dpa = addr & CXL_POISON_START_MASK;
+
+		trace_cxl_poison(memdev_name, pcidev_name, region_name, uuid,
+				 dpa, len, source, po->flags, overflow_t);
+	}
+}
+
+int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
+		       struct cxl_region *cxlr)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	const char *memdev_name = dev_name(&cxlmd->dev);
+	const char *pcidev_name = dev_name(cxlds->dev);
+	struct cxl_mbox_poison_payload_out *po;
+	struct cxl_mbox_poison_payload_in pi;
+	int nr_records = 0;
+	int rc;
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
+		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_POISON, &pi,
+				       sizeof(pi), po, cxlds->payload_size);
+		if (rc)
+			break;
+
+		if (trace_cxl_poison_enabled())
+			cxl_trace_poison(po, cxlr, memdev_name, pcidev_name);
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
@@ -846,6 +926,7 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
 	}
 
 	mutex_init(&cxlds->mbox_mutex);
+	mutex_init(&cxlds->poison_list_mutex);
 	cxlds->dev = dev;
 
 	return cxlds;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 669868cc1553..49d891347e39 100644
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
@@ -224,6 +226,8 @@ struct cxl_dev_state {
 
 	size_t payload_size;
 	size_t lsa_size;
+	u32 poison_max;
+	struct mutex poison_list_mutex;  /* Protect reads of poison list */
 	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
 	char firmware_version[0x10];
 	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
@@ -349,6 +353,37 @@ struct cxl_mbox_set_partition_info {
 
 /* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
 
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
 /* Get Poison List: Payload out flags */
 #define CXL_POISON_FLAG_MORE            BIT(0)
 #define CXL_POISON_FLAG_OVERFLOW        BIT(1)
@@ -395,6 +430,8 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
 struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
 void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
 void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
+int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
+		       struct cxl_region *cxlr);
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
 void cxl_mem_active_dec(void);
-- 
2.37.3

