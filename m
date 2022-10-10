Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0EA5FA7C1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiJJWnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiJJWnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:43:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC607A50D;
        Mon, 10 Oct 2022 15:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665441785; x=1696977785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E+OH2LNcjgdo8PCRy0hJGDF6iAuY2X3pObr9SWdB/oM=;
  b=DlwXNjdEOoQ5ShzJaYgCFR1W4yI9Cki98TAnXggzMMSwo1scdKVsOgyu
   ZJ8y2eMXgTyWxhKfJlZcKYcv2uWtpMZLzUR3yTJQXZMWszNY60VNnNi8t
   IWLcSlujFmv4d6skmONcxVgz3r3w3x5gtmHA02+gPwXiRMWCg17jz2gV+
   WyY64ye/QtMLJcw3BSx/+0liejvy8G7t6AQxFDrOghdDP4Jt1X9CJ9Fkp
   btmThc2sQ3c6XMKYmSSJgu2A38n7f6DXRhH77iR/cp89CqGwmXWb9Go4s
   8JDxcVy3VXdM4IHhfAzKVanOJIKm+WDotn+WcRckr9mKTPq2nMJX03rv4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="287615378"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="287615378"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:43:05 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="621191347"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="621191347"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.252.141.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:43:04 -0700
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
Subject: [RFC V2 PATCH 03/11] cxl/mem: Implement Clear Event Records command
Date:   Mon, 10 Oct 2022 15:41:23 -0700
Message-Id: <20221010224131.1866246-4-ira.weiny@intel.com>
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
 drivers/cxl/core/mbox.c      | 31 ++++++++++++++++++++++++++++---
 drivers/cxl/cxlmem.h         | 15 +++++++++++++++
 include/uapi/linux/cxl_mem.h |  1 +
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 5f258c3f2190..bc4e42b3e01b 100644
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
@@ -711,6 +712,20 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
 
+static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
+				  enum cxl_event_log_type log,
+				  __le16 handle)
+{
+	struct cxl_mbox_clear_event_payload payload = {
+		.event_log = log,
+		.nr_recs = 1,
+		.handle = handle,
+	};
+
+	return cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_CLEAR_EVENT_RECORD,
+				 &payload, sizeof(payload), NULL, 0);
+}
+
 static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
 				    enum cxl_event_log_type type)
 {
@@ -729,9 +744,18 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
 			return;
 		}
 
-		if (le16_to_cpu(payload.record_count) == 1)
+		if (le16_to_cpu(payload.record_count) == 1) {
 			trace_generic_event(dev_name(cxlds->dev), type,
 					    &payload.record);
+			rc = cxl_clear_event_record(cxlds, type,
+						    payload.record.hdr.handle);
+			if (rc) {
+				dev_err(cxlds->dev, "Event log '%s': Failed to clear event (%u) : %d",
+					cxl_event_log_type_str(type),
+					payload.record.hdr.handle, rc);
+				return;
+			}
+		}
 
 		if (payload.flags & CXL_GET_EVENT_FLAG_OVERFLOW)
 			trace_overflow(dev_name(cxlds->dev), type, &payload);
@@ -743,10 +767,11 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
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
index fa8d248fb299..75aea34f3ffb 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -255,6 +255,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_INVALID		= 0x0000,
 	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
 	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
+	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
 	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
 	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
 	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
@@ -396,6 +397,20 @@ static inline const char *cxl_event_log_type_str(enum cxl_event_log_type type)
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
+	__le16 handle;
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

