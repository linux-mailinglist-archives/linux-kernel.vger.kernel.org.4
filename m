Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679B05FA7C7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJJWnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJJWnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:43:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470FB7AC3D;
        Mon, 10 Oct 2022 15:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665441790; x=1696977790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qHjOz6DWtme2yNBiVRfyccObDwS6t0vF+2pNS1l55Rw=;
  b=d/kPPXyOPJfbutHaKqHhh3V+4+1oXB+vcWzhUR3yMHltlvW5Hn2DEAGd
   0nkZj1IrBEsHKEyRKieNHnACieZcSltEVUAOWKOTGdamIU0V9M9TA0Zx6
   hRSuXWkf3+RazpSRYAVRJ10wUO2lG16xWv89RRpE0auLCSbzOGX+7/FgT
   2rZxxSyEOunVTAs5/6fX5vsULcQvNmhuOpWDvG1nEQtXNDW819JgXlGNN
   /QJf9Rky/Fe4quYbBSmVCPH5ImzK2gPavCdPM6t9aOxOXtQB1nY2juQQL
   ClObgGu6etUfTmhxUv7MeHx4kXQH5Teb/qXQELNjyFSpeSuZHN6CvEU7F
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="287615389"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="287615389"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:43:09 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="621191380"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="621191380"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.252.141.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:43:08 -0700
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
Subject: [RFC V2 PATCH 08/11] cxl/test: Add generic mock events
Date:   Mon, 10 Oct 2022 15:41:28 -0700
Message-Id: <20221010224131.1866246-9-ira.weiny@intel.com>
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
 tools/testing/cxl/test/Kbuild   |   2 +-
 tools/testing/cxl/test/events.c | 223 ++++++++++++++++++++++++++++++++
 tools/testing/cxl/test/events.h |   9 ++
 tools/testing/cxl/test/mem.c    |  32 +++++
 4 files changed, 265 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/cxl/test/events.c
 create mode 100644 tools/testing/cxl/test/events.h

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
index 000000000000..1913c321d16c
--- /dev/null
+++ b/tools/testing/cxl/test/events.c
@@ -0,0 +1,223 @@
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
+	/* Don't handle more than 1 record at a time */
+	if (cmd->size_out < sizeof(*pl))
+		return -EINVAL;
+
+	pl = cmd->payload_out;
+	memset(pl, 0, sizeof(*pl));
+
+	pl->record_count = cpu_to_le16(1);
+
+	if (log_rec_left(log) > 1)
+		pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
+
+	memcpy(&pl->record, get_cur_event(log), sizeof(pl->record));
+	pl->record.hdr.handle = get_cur_event_handle(log);
+	return 0;
+
+no_data:
+	/* Room for header? */
+	if (cmd->size_out < (sizeof(*pl) - sizeof(pl->record)))
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
+	 * The current code clears events as they are read.  Test that behavior
+	 * only; don't support clearning from the middle of the log
+	 */
+	if (log->cur_event != le16_to_cpu(pl->handle)) {
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
+	cxl_mem_get_event_records(mes->cxlds);
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
+void cxl_mock_add_event_logs(struct cxl_dev_state *cxlds)
+{
+	struct device *dev = cxlds->dev;
+	struct mock_event_store *mes;
+
+	mes = kzalloc(sizeof(*mes), GFP_KERNEL);
+	if (WARN_ON(!mes))
+		return;
+	mes->cxlds = cxlds;
+
+	if (xa_insert(&mock_dev_event_store, (unsigned long)dev, mes,
+		      GFP_KERNEL)) {
+		dev_err(dev, "Event store not available for %s\n",
+			dev_name(dev));
+		return;
+	}
+
+	event_store_add_event(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
+
+	event_store_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
+
+}
+EXPORT_SYMBOL_GPL(cxl_mock_add_event_logs);
+
+void cxl_mock_remove_event_logs(struct device *dev)
+{
+	struct mock_event_store *mes;
+
+	mes = xa_erase(&mock_dev_event_store, (unsigned long)dev);
+	kfree(mes);
+}
+EXPORT_SYMBOL_GPL(cxl_mock_remove_event_logs);
diff --git a/tools/testing/cxl/test/events.h b/tools/testing/cxl/test/events.h
new file mode 100644
index 000000000000..b3149b38d6df
--- /dev/null
+++ b/tools/testing/cxl/test/events.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <cxlmem.h>
+
+int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
+int mock_clear_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
+void cxl_mock_add_event_logs(struct cxl_dev_state *cxlds);
+void cxl_mock_remove_event_logs(struct device *dev);
+void cxl_mock_event_trigger(struct device *dev);
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index e2f5445d24ff..9768f5132a5c 100644
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
@@ -245,6 +252,21 @@ static void label_area_release(void *lsa)
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
@@ -281,6 +303,8 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	cxl_mock_add_event_logs(cxlds);
+
 	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
@@ -293,6 +317,12 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
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
@@ -301,9 +331,11 @@ MODULE_DEVICE_TABLE(platform, cxl_mock_mem_ids);
 
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

