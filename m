Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A651624A48
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbiKJTGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiKJTFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:05:44 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D1151C29;
        Thu, 10 Nov 2022 11:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668107128; x=1699643128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X0hTlSjzN6nRB0eAV3xdVOXDyE8Lzm/yx7DpFWSNwVY=;
  b=kdTGeN939Bqu3tl9+52akaWrFF6hIQ2N/2yfkh5lgVmQLQxb31U3lYW+
   ewacPWMWAIQdm4k4Q/8IV18xcKO2K4Iroxeol7Jw6R6UzK3kpUplZwuh2
   +HRgjn+tsOERSXNcRozG6j4db5boMve1KWGjdPH33UPicnlme6ozo34fs
   LHSmhBW0Vy1erqTjmguwfXx4C/sqTHmyBfgUeUl54vm6scYUa/jX0yjVW
   XHAECWr0MJl7vYjn3/PoMh/IrdZ9Z5MXjSVGCxS/KzM2AaUYEA8OMIaJf
   RAnlhZAp9OnZl8hJkUc3rpgGR3qC+e5Av8FGYmXNTOIBKUELBmj/8fgDn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="375662133"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="375662133"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 10:58:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="882473452"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="882473452"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.6.223])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 10:58:10 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [PATCH 09/11] cxl/test: Add generic mock events
Date:   Thu, 10 Nov 2022 10:57:56 -0800
Message-Id: <20221110185758.879472-10-ira.weiny@intel.com>
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

Facilitate testing basic Get/Clear Event functionality by creating
multiple logs and generic events with made up UUID's.

Data is completely made up with data patterns which should be easy to
spot in trace output.

A single sysfs entry resets the event data and triggers collecting the
events for testing.

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
 drivers/cxl/core/mbox.c         |  31 +++--
 drivers/cxl/cxlmem.h            |   1 +
 tools/testing/cxl/test/Kbuild   |   2 +-
 tools/testing/cxl/test/events.c | 222 ++++++++++++++++++++++++++++++++
 tools/testing/cxl/test/events.h |   9 ++
 tools/testing/cxl/test/mem.c    |  35 ++++-
 6 files changed, 286 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/cxl/test/events.c
 create mode 100644 tools/testing/cxl/test/events.h

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 1e6762af2a00..2d74c0f2cbf7 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -841,6 +841,24 @@ void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_get_records_log, CXL);
 
+/* Direct call for mock testing */
+void __cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status)
+{
+	dev_dbg(cxlds->dev, "Reading event logs: %x\n", status);
+
+	if (status & CXLDEV_EVENT_STATUS_INFO)
+		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_INFO);
+	if (status & CXLDEV_EVENT_STATUS_WARN)
+		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_WARN);
+	if (status & CXLDEV_EVENT_STATUS_FAIL)
+		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FAIL);
+	if (status & CXLDEV_EVENT_STATUS_FATAL)
+		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FATAL);
+	if (status & CXLDEV_EVENT_STATUS_DYNAMIC_CAP)
+		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_DYNAMIC_CAP);
+}
+EXPORT_SYMBOL_NS_GPL(__cxl_mem_get_event_records, CXL);
+
 /**
  * cxl_mem_get_event_records - Get Event Records from the device
  * @cxlds: The device data for the operation
@@ -855,18 +873,7 @@ void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
 {
 	u32 status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
 
-	dev_dbg(cxlds->dev, "Reading event logs: %x\n", status);
-
-	if (status & CXLDEV_EVENT_STATUS_INFO)
-		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_INFO);
-	if (status & CXLDEV_EVENT_STATUS_WARN)
-		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_WARN);
-	if (status & CXLDEV_EVENT_STATUS_FAIL)
-		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FAIL);
-	if (status & CXLDEV_EVENT_STATUS_FATAL)
-		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FATAL);
-	if (status & CXLDEV_EVENT_STATUS_DYNAMIC_CAP)
-		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_DYNAMIC_CAP);
+	__cxl_mem_get_event_records(cxlds, status);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 4d9c3ea30c24..77bcbaa16dd3 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -569,6 +569,7 @@ void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds
 void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
 void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
 			     enum cxl_event_log_type type);
+void __cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status);
 void cxl_mem_get_event_records(struct cxl_dev_state *cxlds);
 int cxl_event_config_msgnums(struct cxl_dev_state *cxlds);
 #ifdef CONFIG_CXL_SUSPEND
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
index 000000000000..a4816f230bb5
--- /dev/null
+++ b/tools/testing/cxl/test/events.c
@@ -0,0 +1,222 @@
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
+struct mock_event_log {
+	int cur_event;
+	int nr_events;
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
+	return log->events[log->cur_event];
+}
+
+__le16 get_cur_event_handle(struct mock_event_log *log)
+{
+	return cpu_to_le16(log->cur_event);
+}
+
+static bool log_empty(struct mock_event_log *log)
+{
+	return log->cur_event == log->nr_events;
+}
+
+static int log_rec_left(struct mock_event_log *log)
+{
+	return log->nr_events - log->cur_event;
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
+
+	/* Valid request? */
+	if (cmd->size_in != sizeof(log_type))
+		return -EINVAL;
+
+	log_type = *((u8 *)cmd->payload_in);
+	if (log_type >= CXL_EVENT_TYPE_MAX)
+		return -EINVAL;
+
+	log = find_event_log(cxlds->dev, log_type);
+	if (!log || log_empty(log))
+		goto no_data;
+
+	pl = cmd->payload_out;
+	memset(pl, 0, sizeof(*pl));
+
+	pl->record_count = cpu_to_le16(1);
+
+	if (log_rec_left(log) > 1)
+		pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
+
+	memcpy(&pl->record[0], get_cur_event(log), sizeof(pl->record[0]));
+	pl->record[0].hdr.handle = get_cur_event_handle(log);
+	return 0;
+
+no_data:
+	/* Room for header? */
+	if (cmd->size_out < (sizeof(*pl) - sizeof(pl->record[0])))
+		return -EINVAL;
+
+	memset(cmd->payload_out, 0, cmd->size_out);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mock_get_event);
+
+/*
+ * Get and clear event only handle 1 record at a time as this is what is
+ * currently implemented in the main code.
+ */
+int mock_clear_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_clear_event_payload *pl = cmd->payload_in;
+	struct mock_event_log *log;
+	u8 log_type = pl->event_log;
+
+	/* Don't handle more than 1 record at a time */
+	if (pl->nr_recs != 1)
+		return -EINVAL;
+
+	if (log_type >= CXL_EVENT_TYPE_MAX)
+		return -EINVAL;
+
+	log = find_event_log(cxlds->dev, log_type);
+	if (!log)
+		return 0; /* No mock data in this log */
+
+	/*
+	 * Test code only reported 1 event at a time.  So only support 1 event
+	 * being cleared.
+	 */
+	if (log->cur_event != le16_to_cpu(pl->handle[0])) {
+		dev_err(cxlds->dev, "Clearing events out of order\n");
+		return -EINVAL;
+	}
+
+	log->cur_event++;
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
+			log->cur_event = 0;
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

