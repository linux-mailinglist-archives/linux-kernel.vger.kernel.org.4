Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA36663E67D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 01:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiLAA1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 19:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiLAA1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 19:27:31 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E925803E;
        Wed, 30 Nov 2022 16:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669854450; x=1701390450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jXysWS4Ez9au+rW5fyav+5s0bOnnmJEkvkXUz0fzpXM=;
  b=R/EhuWUKEnSKvXQKocMczcL0A+n5+j2ZJgOyVaQT5fzMD5ZXsZL6M43E
   y0Xqo+AdHvWN76Yngz8v6llJqEv2a2EobBclQMRO+S9FZEvTqZ81rGm6y
   Bzl4y4QWHOqFjLelN4udWKOeNa4NUV9ckTAS14yvXewH/7ivFzrGJhSrH
   dQDJ8V/FNycw28P5/uEvOhcDydmIpHxpMPqGpqXD/wyRXBxAzR/KOuwvp
   WM1bkZ0zWT/dfeoLtGqCy+4Cwr7JHvpyeyIdEJ0CzoVwen7qSAGcHKYPb
   QUpHH+A0HGVm0LKjOxgqA25yRIF8KlGU9v9+h66Oe6aa2cvLIUxL4YyMC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="317400840"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="317400840"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 16:27:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="622085218"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="622085218"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.251.1.240])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 16:27:28 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [PATCH V2 03/11] cxl/mem: Implement Clear Event Records command
Date:   Wed, 30 Nov 2022 16:27:11 -0800
Message-Id: <20221201002719.2596558-4-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221201002719.2596558-1-ira.weiny@intel.com>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
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

Implement cxl_clear_event_record() to clear all record retrieved from
the device.

Each record is cleared explicitly.  A clear all bit is specified but
events could arrive between a get and any final clear all operation.
This means events would be missed.
Therefore each event is cleared specifically.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V1:
	Clear Event Record allows for u8 handles while Get Event Record
	allows for u16 records to be returned.  Based on Jonathan's
	feedback; allow for all event records to be handled in this
	clear.  Which means a double loop with potentially multiple
	Clear Event payloads being sent to clear all events sent.

Changes from RFC:
	Jonathan
		Clean up init of payload and use return code.
		Also report any error to clear the event.
		s/v3.0/rev 3.0
---
 drivers/cxl/core/mbox.c      | 61 +++++++++++++++++++++++++++++++-----
 drivers/cxl/cxlmem.h         | 14 +++++++++
 include/uapi/linux/cxl_mem.h |  1 +
 3 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 70b681027a3d..076a3df0ba38 100644
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
@@ -708,6 +709,42 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
 
+static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
+				  enum cxl_event_log_type log,
+				  struct cxl_get_event_payload *get_pl,
+				  u16 total)
+{
+	struct cxl_mbox_clear_event_payload payload = {
+		.event_log = log,
+	};
+	int cnt;
+
+	/*
+	 * Clear Event Records uses u8 for the handle cnt while Get Event
+	 * Record can return up to 0xffff records.
+	 */
+	for (cnt = 0; cnt < total; /* cnt incremented internally */) {
+		u8 nr_recs = min_t(u8, (total - cnt),
+				   CXL_CLEAR_EVENT_MAX_HANDLES);
+		int i, rc;
+
+		for (i = 0; i < nr_recs; i++, cnt++) {
+			payload.handle[i] = get_pl->records[cnt].hdr.handle;
+			dev_dbg(cxlds->dev, "Event log '%s': Clearning %u\n",
+				cxl_event_log_type_str(log),
+				le16_to_cpu(payload.handle[i]));
+		}
+		payload.nr_recs = nr_recs;
+
+		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_CLEAR_EVENT_RECORD,
+				       &payload, sizeof(payload), NULL, 0);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
 static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
 				    enum cxl_event_log_type type)
 {
@@ -732,13 +769,22 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
 		}
 
 		nr_rec = le16_to_cpu(payload->record_count);
-		if (trace_cxl_generic_event_enabled()) {
+		if (nr_rec > 0) {
 			int i;
 
-			for (i = 0; i < nr_rec; i++)
-				trace_cxl_generic_event(dev_name(cxlds->dev),
-							type,
-							&payload->records[i]);
+			if (trace_cxl_generic_event_enabled()) {
+				for (i = 0; i < nr_rec; i++)
+					trace_cxl_generic_event(dev_name(cxlds->dev),
+								type,
+								&payload->records[i]);
+			}
+
+			rc = cxl_clear_event_record(cxlds, type, payload, nr_rec);
+			if (rc) {
+				dev_err(cxlds->dev, "Event log '%s': Failed to clear events : %d",
+					cxl_event_log_type_str(type), rc);
+				return;
+			}
 		}
 
 		if (trace_cxl_overflow_enabled() &&
@@ -780,10 +826,11 @@ static struct cxl_get_event_payload *alloc_event_buf(struct cxl_dev_state *cxlds
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
index 55d57f5a64bc..1ae9962c5a06 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -261,6 +261,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_INVALID		= 0x0000,
 	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
 	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
+	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
 	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
 	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
 	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
@@ -396,6 +397,19 @@ static inline const char *cxl_event_log_type_str(enum cxl_event_log_type type)
 	return "<unknown>";
 }
 
+/*
+ * Clear Event Records input payload
+ * CXL rev 3.0 section 8.2.9.2.3; Table 8-51
+ */
+#define CXL_CLEAR_EVENT_MAX_HANDLES (0xff)
+struct cxl_mbox_clear_event_payload {
+	u8 event_log;		/* enum cxl_event_log_type */
+	u8 clear_flags;
+	u8 nr_recs;
+	u8 reserved[3];
+	__le16 handle[CXL_CLEAR_EVENT_MAX_HANDLES];
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

