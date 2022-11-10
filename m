Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2415624A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiKJTGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiKJTFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:05:35 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB9348753;
        Thu, 10 Nov 2022 11:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668107114; x=1699643114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8vg+IL9w6gi13hul2cKRBm83FUeTBA8qdk5UVTSu7lg=;
  b=dMxgkKXmuhHCFV6wm1IStLeIeumn5MclqpickEdLcMh22W/yGSRXW4Rw
   G8dQERdFx9yvOjbKiEGJxaawd3Rvu6EK+Au5HtqB+0/NWvu/Xgzy+v0on
   /sYNm6Lo1uC+vTa+5EIPKDiuYhpJ+PjA1lxN1twjXqQnNcc8Y8PO3uFwn
   ok0cTDXQ5eYboArhgwheXnsdVkFu7wF92iJduUSQLdX17HesvseXN4UDX
   qEXI/Kg6PiPvkZy0habv4Pgy7Guu26y8H+duTtOHfKK7Z7fiBUlEGwdwU
   KMQz2ycmfogvcEfwr6Zfx22Gb1pCbd+f/kbgLDcxS/cA/vrWjvswzwQGA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="375662076"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="375662076"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 10:58:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="882473410"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="882473410"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.6.223])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 10:58:06 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [PATCH 03/11] cxl/mem: Implement Clear Event Records command
Date:   Thu, 10 Nov 2022 10:57:50 -0800
Message-Id: <20221110185758.879472-4-ira.weiny@intel.com>
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

CXL rev 3.0 section 8.2.9.2.3 defines the Clear Event Records mailbox
command.  After an event record is read it needs to be cleared from the
event log.

Implement cxl_clear_event_record() and call it for each record retrieved
from the device.

Each record is cleared individually.  A clear all bit is specified but
events could arrive between a get and the final clear all operation.
Therefore each event is cleared specifically.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC:
	Jonathan
		Clean up init of payload and use return code.
		Also report any error to clear the event.
		s/v3.0/rev 3.0
---
 drivers/cxl/core/mbox.c      | 46 ++++++++++++++++++++++++++++++------
 drivers/cxl/cxlmem.h         | 15 ++++++++++++
 include/uapi/linux/cxl_mem.h |  1 +
 3 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index a908b95a7de4..f46558e09f08 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -52,6 +52,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 #endif
 	CXL_CMD(GET_SUPPORTED_LOGS, 0, CXL_VARIABLE_PAYLOAD, CXL_CMD_FLAG_FORCE_ENABLE),
 	CXL_CMD(GET_EVENT_RECORD, 1, CXL_VARIABLE_PAYLOAD, 0),
+	CXL_CMD(CLEAR_EVENT_RECORD, CXL_VARIABLE_PAYLOAD, 0, 0),
 	CXL_CMD(GET_FW_INFO, 0, 0x50, 0),
 	CXL_CMD(GET_PARTITION_INFO, 0, 0x20, 0),
 	CXL_CMD(GET_LSA, 0x8, CXL_VARIABLE_PAYLOAD, 0),
@@ -708,6 +709,27 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
 
+static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
+				  enum cxl_event_log_type log,
+				  struct cxl_get_event_payload *get_pl, u16 nr)
+{
+	struct cxl_mbox_clear_event_payload payload = {
+		.event_log = log,
+		.nr_recs = nr,
+	};
+	int i;
+
+	for (i = 0; i < nr; i++) {
+		payload.handle[i] = get_pl->record[i].hdr.handle;
+		dev_dbg(cxlds->dev, "Event log '%s': Clearning %u\n",
+			cxl_event_log_type_str(log),
+			le16_to_cpu(payload.handle[i]));
+	}
+
+	return cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_CLEAR_EVENT_RECORD,
+				 &payload, sizeof(payload), NULL, 0);
+}
+
 static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
 				    enum cxl_event_log_type type)
 {
@@ -728,14 +750,23 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
 		}
 
 		pl_nr = le16_to_cpu(payload.record_count);
-		if (trace_cxl_generic_event_enabled()) {
+		if (pl_nr > 0) {
 			u16 nr_rec = min_t(u16, pl_nr, CXL_GET_EVENT_NR_RECORDS);
 			int i;
 
-			for (i = 0; i < nr_rec; i++)
-				trace_cxl_generic_event(dev_name(cxlds->dev),
-							type,
-							&payload.record[i]);
+			if (trace_cxl_generic_event_enabled()) {
+				for (i = 0; i < nr_rec; i++)
+					trace_cxl_generic_event(dev_name(cxlds->dev),
+								type,
+								&payload.record[i]);
+			}
+
+			rc = cxl_clear_event_record(cxlds, type, &payload, nr_rec);
+			if (rc) {
+				dev_err(cxlds->dev, "Event log '%s': Failed to clear events : %d",
+					cxl_event_log_type_str(type), rc);
+				return;
+			}
 		}
 
 		if (trace_cxl_overflow_enabled() &&
@@ -750,10 +781,11 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
  * cxl_mem_get_event_records - Get Event Records from the device
  * @cxlds: The device data for the operation
  *
- * Retrieve all event records available on the device and report them as trace
- * events.
+ * Retrieve all event records available on the device, report them as trace
+ * events, and clear them.
  *
  * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
+ * See CXL rev 3.0 @8.2.9.2.3 Clear Event Records
  */
 void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
 {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index da64ba0f156b..28a114c7cf69 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -258,6 +258,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_INVALID		= 0x0000,
 	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
 	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
+	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
 	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
 	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
 	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
@@ -397,6 +398,20 @@ static inline const char *cxl_event_log_type_str(enum cxl_event_log_type type)
 	return "<unknown>";
 }
 
+/*
+ * Clear Event Records input payload
+ * CXL rev 3.0 section 8.2.9.2.3; Table 8-51
+ *
+ * Space given for 1 record
+ */
+struct cxl_mbox_clear_event_payload {
+	u8 event_log;		/* enum cxl_event_log_type */
+	u8 clear_flags;
+	u8 nr_recs;		/* 1 for this struct */
+	u8 reserved[3];
+	__le16 handle[CXL_GET_EVENT_NR_RECORDS];
+};
+
 struct cxl_mbox_get_partition_info {
 	__le64 active_volatile_cap;
 	__le64 active_persistent_cap;
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 70459be5bdd4..7c1ad8062792 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -25,6 +25,7 @@
 	___C(RAW, "Raw device command"),                                  \
 	___C(GET_SUPPORTED_LOGS, "Get Supported Logs"),                   \
 	___C(GET_EVENT_RECORD, "Get Event Record"),                       \
+	___C(CLEAR_EVENT_RECORD, "Clear Event Record"),                   \
 	___C(GET_FW_INFO, "Get FW Info"),                                 \
 	___C(GET_PARTITION_INFO, "Get Partition Information"),            \
 	___C(GET_LSA, "Get Label Storage Area"),                          \
-- 
2.37.2

