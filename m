Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF51663E684
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 01:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiLAA2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 19:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiLAA1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 19:27:55 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A98D5FEE;
        Wed, 30 Nov 2022 16:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669854457; x=1701390457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z1Z4TGl1ZiPzwlIfDb30NvVCruCDbsVGGm39QgqOK20=;
  b=C0kmCj66Hfr139MLALkzrvnyNvd1bUv3VcJRh9xQaBNdLju69VfDGSF0
   C7IuBoU3kIHIuhhjRj5BBfHYmy4HOhTNSYKunN4SiNmEqfdD6fMPas+dy
   9HaRb3mTPqjkOSt44r4TyZiAc+hewVu8MaZB+m4CEOXmsAnlZEh7E2Xip
   g9FccNtsXMA1P9IBOEHzEcx1fxVEK+I55V7l/1KnFo3WBF7IYJ7xyvWmv
   dbnzrnr8hcbECeNqPbKbgJufs/nqreAh6FklZfn0MTRU6mYFEEuomlw5x
   rpWeu7hBZ3QyZCq66H1fgeIxGmyoue4/yFMX8srhQBF/eD1uDgK5OTI4Q
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="317400886"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="317400886"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 16:27:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="622085245"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="622085245"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.251.1.240])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 16:27:34 -0800
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
Subject: [PATCH V2 09/11] cxl/test: Add generic mock events
Date:   Wed, 30 Nov 2022 16:27:17 -0800
Message-Id: <20221201002719.2596558-10-ira.weiny@intel.com>
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

Facilitate testing basic Get/Clear Event functionality by creating
multiple logs and generic events with made up UUID's.

Data is completely made up with data patterns which should be easy to
spot in trace output.

A single sysfs entry resets the event data and triggers collecting the
events for testing.

Events are returned one at a time which is within the specification even
though it does not exercise the full capabilities of what a device may
do.

Test traces are easy to obtain with a small script such as this:

	#!/bin/bash -x

	devices=`find /sys/devices/platform -name cxl_mem*`

	# Turn on tracing
	echo "" > /sys/kernel/tracing/trace
	echo 1 > /sys/kernel/tracing/events/cxl/enable
	echo 1 > /sys/kernel/tracing/tracing_on

	# Generate fake interrupt
	for device in $devices; do
	        echo 1 > $device/event_trigger
	done

	# Turn off tracing and report events
	echo 0 > /sys/kernel/tracing/tracing_on
	cat /sys/kernel/tracing/trace

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from v1:
	Fix up for new structures
	Jonathan
		Update based on specification discussion

Changes from RFC v2:
	Adjust to simulate the event status register

Changes from RFC:
	Separate out the event code
	Adjust for struct changes.
	Clean up devm_cxl_mock_event_logs()
	Clean up naming and comments
	Jonathan
		Remove dynamic allocation of event logs
		Clean up comment
		Remove unneeded xarray
		Ensure event_trigger sysfs is valid prior to the driver
		going active.
	Dan
		Remove the fill/reset event sysfs as these operations
		can be done together
---
 drivers/cxl/core/mbox.c         |  33 +++--
 drivers/cxl/cxlmem.h            |   1 +
 tools/testing/cxl/test/Kbuild   |   2 +-
 tools/testing/cxl/test/events.c | 242 ++++++++++++++++++++++++++++++++
 tools/testing/cxl/test/events.h |   9 ++
 tools/testing/cxl/test/mem.c    |  35 ++++-
 6 files changed, 307 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/cxl/test/events.c
 create mode 100644 tools/testing/cxl/test/events.h

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 1e00b49d8b06..17659b9a0408 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -886,20 +886,9 @@ static struct cxl_get_event_payload *alloc_event_buf(struct cxl_dev_state *cxlds
 	return buf;
 }
 
-/**
- * cxl_mem_get_event_records - Get Event Records from the device
- * @cxlds: The device data for the operation
- *
- * Retrieve all event records available on the device, report them as trace
- * events, and clear them.
- *
- * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
- * See CXL rev 3.0 @8.2.9.2.3 Clear Event Records
- */
-void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
+/* Direct call for mock testing */
+void __cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status)
 {
-	u32 status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
-
 	dev_dbg(cxlds->dev, "Reading event logs: %x\n", status);
 
 	if (!cxlds->event_buf) {
@@ -917,6 +906,24 @@ void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
 	if (status & CXLDEV_EVENT_STATUS_FATAL)
 		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FATAL);
 }
+EXPORT_SYMBOL_NS_GPL(__cxl_mem_get_event_records, CXL);
+
+/**
+ * cxl_mem_get_event_records - Get Event Records from the device
+ * @cxlds: The device data for the operation
+ *
+ * Retrieve all event records available on the device, report them as trace
+ * events, and clear them.
+ *
+ * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
+ * See CXL rev 3.0 @8.2.9.2.3 Clear Event Records
+ */
+void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
+{
+	u32 status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
+
+	__cxl_mem_get_event_records(cxlds, status);
+}
 EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
 
 int cxl_event_config_msgnums(struct cxl_dev_state *cxlds,
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 2d384b0fc2b3..10e3c1c893f3 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -565,6 +565,7 @@ void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds
 void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
 void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
 			     enum cxl_event_log_type type);
+void __cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status);
 void cxl_mem_get_event_records(struct cxl_dev_state *cxlds);
 int cxl_event_config_msgnums(struct cxl_dev_state *cxlds,
 			     struct cxl_event_interrupt_policy *policy);
diff --git a/tools/testing/cxl/test/Kbuild b/tools/testing/cxl/test/Kbuild
index 4e59e2c911f6..64b14b83d8d9 100644
--- a/tools/testing/cxl/test/Kbuild
+++ b/tools/testing/cxl/test/Kbuild
@@ -7,4 +7,4 @@ obj-m += cxl_mock_mem.o
 
 cxl_test-y := cxl.o
 cxl_mock-y := mock.o
-cxl_mock_mem-y := mem.o
+cxl_mock_mem-y := mem.o events.o
diff --git a/tools/testing/cxl/test/events.c b/tools/testing/cxl/test/events.c
new file mode 100644
index 000000000000..a3d2ec7cc9fe
--- /dev/null
+++ b/tools/testing/cxl/test/events.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2022 Intel Corporation. All rights reserved.
+
+#include <cxlmem.h>
+#include <trace/events/cxl.h>
+
+#include "events.h"
+
+#define CXL_TEST_EVENT_CNT_MAX 15
+
+/* Set a number of events to return at a time for simulation.  */
+#define CXL_TEST_EVENT_CNT 3
+
+struct mock_event_log {
+	u16 clear_idx;
+	u16 cur_idx;
+	u16 nr_events;
+	struct cxl_event_record_raw *events[CXL_TEST_EVENT_CNT_MAX];
+};
+
+struct mock_event_store {
+	struct cxl_dev_state *cxlds;
+	struct mock_event_log mock_logs[CXL_EVENT_TYPE_MAX];
+	u32 ev_status;
+};
+
+DEFINE_XARRAY(mock_dev_event_store);
+
+struct mock_event_log *find_event_log(struct device *dev, int log_type)
+{
+	struct mock_event_store *mes = xa_load(&mock_dev_event_store,
+					       (unsigned long)dev);
+
+	if (!mes || log_type >= CXL_EVENT_TYPE_MAX)
+		return NULL;
+	return &mes->mock_logs[log_type];
+}
+
+struct cxl_event_record_raw *get_cur_event(struct mock_event_log *log)
+{
+	return log->events[log->cur_idx];
+}
+
+void reset_event_log(struct mock_event_log *log)
+{
+	log->cur_idx = 0;
+	log->clear_idx = 0;
+}
+
+/* Handle can never be 0 use 1 based indexing for handle */
+u16 get_clear_handle(struct mock_event_log *log)
+{
+	return log->clear_idx + 1;
+}
+
+/* Handle can never be 0 use 1 based indexing for handle */
+__le16 get_cur_event_handle(struct mock_event_log *log)
+{
+	u16 cur_handle = log->cur_idx + 1;
+
+	return cpu_to_le16(cur_handle);
+}
+
+static bool log_empty(struct mock_event_log *log)
+{
+	return log->cur_idx == log->nr_events;
+}
+
+static void event_store_add_event(struct mock_event_store *mes,
+				  enum cxl_event_log_type log_type,
+				  struct cxl_event_record_raw *event)
+{
+	struct mock_event_log *log;
+
+	if (WARN_ON(log_type >= CXL_EVENT_TYPE_MAX))
+		return;
+
+	log = &mes->mock_logs[log_type];
+	if (WARN_ON(log->nr_events >= CXL_TEST_EVENT_CNT_MAX))
+		return;
+
+	log->events[log->nr_events] = event;
+	log->nr_events++;
+}
+
+int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_get_event_payload *pl;
+	struct mock_event_log *log;
+	u8 log_type;
+	int i;
+
+	if (cmd->size_in != sizeof(log_type))
+		return -EINVAL;
+
+	if (cmd->size_out < struct_size(pl, records, CXL_TEST_EVENT_CNT))
+		return -EINVAL;
+
+	log_type = *((u8 *)cmd->payload_in);
+	if (log_type >= CXL_EVENT_TYPE_MAX)
+		return -EINVAL;
+
+	memset(cmd->payload_out, 0, cmd->size_out);
+
+	log = find_event_log(cxlds->dev, log_type);
+	if (!log || log_empty(log))
+		return 0;
+
+	pl = cmd->payload_out;
+
+	for (i = 0; i < CXL_TEST_EVENT_CNT && !log_empty(log); i++) {
+		memcpy(&pl->records[i], get_cur_event(log), sizeof(pl->records[i]));
+		pl->records[i].hdr.handle = get_cur_event_handle(log);
+		log->cur_idx++;
+	}
+
+	pl->record_count = cpu_to_le16(i);
+	if (!log_empty(log))
+		pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mock_get_event);
+
+int mock_clear_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_clear_event_payload *pl = cmd->payload_in;
+	struct mock_event_log *log;
+	u8 log_type = pl->event_log;
+	u16 handle;
+	int nr;
+
+	if (log_type >= CXL_EVENT_TYPE_MAX)
+		return -EINVAL;
+
+	log = find_event_log(cxlds->dev, log_type);
+	if (!log)
+		return 0; /* No mock data in this log */
+
+	/*
+	 * This check is technically not invalid per the specification AFAICS.
+	 * (The host could 'guess' handles and clear them in order).
+	 * However, this is not good behavior for the host so test it.
+	 */
+	if (log->clear_idx + pl->nr_recs > log->cur_idx) {
+		dev_err(cxlds->dev,
+			"Attempting to clear more events than returned!\n");
+		return -EINVAL;
+	}
+
+	/* Check handle order prior to clearing events */
+	for (nr = 0, handle = get_clear_handle(log);
+	     nr < pl->nr_recs;
+	     nr++, handle++) {
+		if (handle != le16_to_cpu(pl->handle[nr])) {
+			dev_err(cxlds->dev, "Clearing events out of order\n");
+			return -EINVAL;
+		}
+	}
+
+	/* Clear events */
+	log->clear_idx += pl->nr_recs;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mock_clear_event);
+
+void cxl_mock_event_trigger(struct device *dev)
+{
+	struct mock_event_store *mes = xa_load(&mock_dev_event_store,
+					       (unsigned long)dev);
+	int i;
+
+	for (i = CXL_EVENT_TYPE_INFO; i < CXL_EVENT_TYPE_MAX; i++) {
+		struct mock_event_log *log;
+
+		log = find_event_log(dev, i);
+		if (log)
+			reset_event_log(log);
+	}
+
+	__cxl_mem_get_event_records(mes->cxlds, mes->ev_status);
+}
+EXPORT_SYMBOL_GPL(cxl_mock_event_trigger);
+
+struct cxl_event_record_raw maint_needed = {
+	.hdr = {
+		.id = UUID_INIT(0xDEADBEEF, 0xCAFE, 0xBABE,
+				0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
+		.length = sizeof(struct cxl_event_record_raw),
+		.flags[0] = CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,
+		/* .handle = Set dynamically */
+		.related_handle = cpu_to_le16(0xa5b6),
+	},
+	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
+};
+
+struct cxl_event_record_raw hardware_replace = {
+	.hdr = {
+		.id = UUID_INIT(0xBABECAFE, 0xBEEF, 0xDEAD,
+				0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
+		.length = sizeof(struct cxl_event_record_raw),
+		.flags[0] = CXL_EVENT_RECORD_FLAG_HW_REPLACE,
+		/* .handle = Set dynamically */
+		.related_handle = cpu_to_le16(0xb6a5),
+	},
+	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
+};
+
+u32 cxl_mock_add_event_logs(struct cxl_dev_state *cxlds)
+{
+	struct device *dev = cxlds->dev;
+	struct mock_event_store *mes;
+
+	mes = devm_kzalloc(dev, sizeof(*mes), GFP_KERNEL);
+	if (WARN_ON(!mes))
+		return 0;
+	mes->cxlds = cxlds;
+
+	if (xa_insert(&mock_dev_event_store, (unsigned long)dev, mes,
+		      GFP_KERNEL)) {
+		dev_err(dev, "Event store not available for %s\n",
+			dev_name(dev));
+		return 0;
+	}
+
+	event_store_add_event(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
+	mes->ev_status |= CXLDEV_EVENT_STATUS_INFO;
+
+	event_store_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
+	mes->ev_status |= CXLDEV_EVENT_STATUS_FATAL;
+
+	return mes->ev_status;
+}
+EXPORT_SYMBOL_GPL(cxl_mock_add_event_logs);
+
+void cxl_mock_remove_event_logs(struct device *dev)
+{
+	struct mock_event_store *mes;
+
+	mes = xa_erase(&mock_dev_event_store, (unsigned long)dev);
+}
+EXPORT_SYMBOL_GPL(cxl_mock_remove_event_logs);
diff --git a/tools/testing/cxl/test/events.h b/tools/testing/cxl/test/events.h
new file mode 100644
index 000000000000..5bebc6a0a01b
--- /dev/null
+++ b/tools/testing/cxl/test/events.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <cxlmem.h>
+
+int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
+int mock_clear_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
+u32 cxl_mock_add_event_logs(struct cxl_dev_state *cxlds);
+void cxl_mock_remove_event_logs(struct device *dev);
+void cxl_mock_event_trigger(struct device *dev);
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index e2f5445d24ff..333fa8527a07 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -8,6 +8,7 @@
 #include <linux/sizes.h>
 #include <linux/bits.h>
 #include <cxlmem.h>
+#include "events.h"
 
 #define LSA_SIZE SZ_128K
 #define DEV_SIZE SZ_2G
@@ -224,6 +225,12 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_GET_PARTITION_INFO:
 		rc = mock_partition_info(cxlds, cmd);
 		break;
+	case CXL_MBOX_OP_GET_EVENT_RECORD:
+		rc = mock_get_event(cxlds, cmd);
+		break;
+	case CXL_MBOX_OP_CLEAR_EVENT_RECORD:
+		rc = mock_clear_event(cxlds, cmd);
+		break;
 	case CXL_MBOX_OP_SET_LSA:
 		rc = mock_set_lsa(cxlds, cmd);
 		break;
@@ -245,11 +252,27 @@ static void label_area_release(void *lsa)
 	vfree(lsa);
 }
 
+static ssize_t event_trigger_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	cxl_mock_event_trigger(dev);
+	return count;
+}
+static DEVICE_ATTR_WO(event_trigger);
+
+static struct attribute *cxl_mock_event_attrs[] = {
+	&dev_attr_event_trigger.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(cxl_mock_event);
+
 static int cxl_mock_mem_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct cxl_memdev *cxlmd;
 	struct cxl_dev_state *cxlds;
+	u32 ev_status;
 	void *lsa;
 	int rc;
 
@@ -281,11 +304,13 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	ev_status = cxl_mock_add_event_logs(cxlds);
+
 	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
-	cxl_mem_get_event_records(cxlds);
+	__cxl_mem_get_event_records(cxlds, ev_status);
 
 	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
 		rc = devm_cxl_add_nvdimm(dev, cxlmd);
@@ -293,6 +318,12 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int cxl_mock_mem_remove(struct platform_device *pdev)
+{
+	cxl_mock_remove_event_logs(&pdev->dev);
+	return 0;
+}
+
 static const struct platform_device_id cxl_mock_mem_ids[] = {
 	{ .name = "cxl_mem", },
 	{ },
@@ -301,9 +332,11 @@ MODULE_DEVICE_TABLE(platform, cxl_mock_mem_ids);
 
 static struct platform_driver cxl_mock_mem_driver = {
 	.probe = cxl_mock_mem_probe,
+	.remove = cxl_mock_mem_remove,
 	.id_table = cxl_mock_mem_ids,
 	.driver = {
 		.name = KBUILD_MODNAME,
+		.dev_groups = cxl_mock_event_groups,
 	},
 };
 
-- 
2.37.2

