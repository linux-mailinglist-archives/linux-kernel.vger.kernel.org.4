Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113EF624A47
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiKJTGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiKJTFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:05:43 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25EA5800D;
        Thu, 10 Nov 2022 11:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668107126; x=1699643126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F77gPSChHeNKN9pAevgHdvZvcF+m0wKhasT7l+mnn6Q=;
  b=WHXjeoJbTA/GIbeijV7h5ZDgAzowUGv11pUlqvB+ZP0kWz+Dg6mSYsxf
   aUP6PFBdzygWngyW2Atx4sb1doZ15qT5jrTR/w4RXh3/aw5AMvXCbklHd
   v5xwRFqlVpCsd/5YERk3gzqsoks8HXkM8k/d1gcl5Nas8TM3UYpTcq3dc
   ckKIFfYKJni1gQxHmkA7HyuJKiwvmf2QLLv59IgtQ8LgaJyq9fpLk69HW
   9Cf1TpJV+ax+e9otSyGG5J6XaWzykqIftBDbRmFtsTOMP6HuJl3HP7knn
   kYviktl692WrPWmfYuztRr+UunIHfEuu2dbqZ4HHcBzrMnbXM0gtkGXzX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="375662123"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="375662123"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 10:58:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="882473446"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="882473446"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.6.223])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 10:58:09 -0800
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
Subject: [PATCH 08/11] cxl/mem: Wire up event interrupts
Date:   Thu, 10 Nov 2022 10:57:55 -0800
Message-Id: <20221110185758.879472-9-ira.weiny@intel.com>
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

CXL device events are signaled via interrupts.  Each event log may have
a different interrupt message number.  These message numbers are
reported in the Get Event Interrupt Policy mailbox command.

Add interrupt support for event logs.  Interrupts are allocated as
shared interrupts.  Therefore, all or some event logs can share the same
message number.

The driver must deal with the possibility that dynamic capacity is not
yet supported by a device it sees.  Fallback and retry without dynamic
capacity if the first attempt fails.

Device capacity event logs interrupt as part of the informational event
log.  Check the event status to see which log has data.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC v2
	Adjust to new irq 16 vector allocation
	Jonathan
		Remove CXL_INT_RES
	Use irq threads to ensure mailbox commands are executed outside irq context
	Adjust for optional Dynamic Capacity log
---
 drivers/cxl/core/mbox.c      |  53 +++++++++++++-
 drivers/cxl/cxlmem.h         |  31 ++++++++
 drivers/cxl/pci.c            | 133 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/cxl_mem.h |   2 +
 4 files changed, 217 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 879b228a98a0..1e6762af2a00 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -53,6 +53,8 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(GET_SUPPORTED_LOGS, 0, CXL_VARIABLE_PAYLOAD, CXL_CMD_FLAG_FORCE_ENABLE),
 	CXL_CMD(GET_EVENT_RECORD, 1, CXL_VARIABLE_PAYLOAD, 0),
 	CXL_CMD(CLEAR_EVENT_RECORD, CXL_VARIABLE_PAYLOAD, 0, 0),
+	CXL_CMD(GET_EVT_INT_POLICY, 0, 0x5, 0),
+	CXL_CMD(SET_EVT_INT_POLICY, 0x5, 0, 0),
 	CXL_CMD(GET_FW_INFO, 0, 0x50, 0),
 	CXL_CMD(GET_PARTITION_INFO, 0, 0x20, 0),
 	CXL_CMD(GET_LSA, 0x8, CXL_VARIABLE_PAYLOAD, 0),
@@ -791,8 +793,8 @@ static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
 				 &payload, sizeof(payload), NULL, 0);
 }
 
-static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
-				    enum cxl_event_log_type type)
+void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
+			     enum cxl_event_log_type type)
 {
 	struct cxl_get_event_payload payload;
 	u16 pl_nr;
@@ -837,6 +839,7 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
 	} while (pl_nr > CXL_GET_EVENT_NR_RECORDS ||
 		 payload.flags & CXL_GET_EVENT_FLAG_MORE_RECORDS);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_mem_get_records_log, CXL);
 
 /**
  * cxl_mem_get_event_records - Get Event Records from the device
@@ -867,6 +870,52 @@ void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
 
+int cxl_event_config_msgnums(struct cxl_dev_state *cxlds)
+{
+	struct cxl_event_interrupt_policy *policy = &cxlds->evt_int_policy;
+	size_t policy_size = sizeof(*policy);
+	bool retry = true;
+	int rc;
+
+	policy->info_settings = CXL_INT_MSI_MSIX;
+	policy->warn_settings = CXL_INT_MSI_MSIX;
+	policy->failure_settings = CXL_INT_MSI_MSIX;
+	policy->fatal_settings = CXL_INT_MSI_MSIX;
+	policy->dyn_cap_settings = CXL_INT_MSI_MSIX;
+
+again:
+	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_SET_EVT_INT_POLICY,
+			       policy, policy_size, NULL, 0);
+	if (rc < 0) {
+		/*
+		 * If the device does not support dynamic capacity it may fail
+		 * the command due to an invalid payload.  Retry without
+		 * dynamic capacity.
+		 */
+		if (retry) {
+			retry = false;
+			policy->dyn_cap_settings = 0;
+			policy_size = sizeof(*policy) - sizeof(policy->dyn_cap_settings);
+			goto again;
+		}
+		dev_err(cxlds->dev, "Failed to set event interrupt policy : %d",
+			rc);
+		memset(policy, CXL_INT_NONE, sizeof(*policy));
+		return rc;
+	}
+
+	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_EVT_INT_POLICY, NULL, 0,
+			       policy, policy_size);
+	if (rc < 0) {
+		dev_err(cxlds->dev, "Failed to get event interrupt policy : %d",
+			rc);
+		return rc;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_event_config_msgnums, CXL);
+
 /**
  * cxl_mem_get_partition_info - Get partition info
  * @cxlds: The device data for the operation
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 03da4f8f74d3..4d9c3ea30c24 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -179,6 +179,31 @@ struct cxl_endpoint_dvsec_info {
 	struct range dvsec_range[2];
 };
 
+/**
+ * Event Interrupt Policy
+ *
+ * CXL rev 3.0 section 8.2.9.2.4; Table 8-52
+ */
+enum cxl_event_int_mode {
+	CXL_INT_NONE		= 0x00,
+	CXL_INT_MSI_MSIX	= 0x01,
+	CXL_INT_FW		= 0x02
+};
+#define CXL_EVENT_INT_MODE_MASK 0x3
+#define CXL_EVENT_INT_MSGNUM(setting) (((setting) & 0xf0) >> 4)
+struct cxl_event_interrupt_policy {
+	u8 info_settings;
+	u8 warn_settings;
+	u8 failure_settings;
+	u8 fatal_settings;
+	u8 dyn_cap_settings;
+} __packed;
+
+static inline bool cxl_evt_int_is_msi(u8 setting)
+{
+	return CXL_INT_MSI_MSIX == (setting & CXL_EVENT_INT_MODE_MASK);
+}
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -246,6 +271,7 @@ struct cxl_dev_state {
 
 	resource_size_t component_reg_phys;
 	u64 serial;
+	struct cxl_event_interrupt_policy evt_int_policy;
 
 	struct xarray doe_mbs;
 
@@ -259,6 +285,8 @@ enum cxl_opcode {
 	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
 	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
 	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
+	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
+	CXL_MBOX_OP_SET_EVT_INT_POLICY	= 0x0103,
 	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
 	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
 	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
@@ -539,7 +567,10 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
 struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
 void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
 void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
+void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
+			     enum cxl_event_log_type type);
 void cxl_mem_get_event_records(struct cxl_dev_state *cxlds);
+int cxl_event_config_msgnums(struct cxl_dev_state *cxlds);
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
 void cxl_mem_active_dec(void);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index e0d511575b45..64b2e2671043 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -458,6 +458,138 @@ static void cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
 	cxlds->nr_irq_vecs = nvecs;
 }
 
+struct cxl_event_irq_id {
+	struct cxl_dev_state *cxlds;
+	u32 status;
+	unsigned int msgnum;
+};
+
+static irqreturn_t cxl_event_int_thread(int irq, void *id)
+{
+	struct cxl_event_irq_id *cxlid = id;
+	struct cxl_dev_state *cxlds = cxlid->cxlds;
+
+	if (cxlid->status & CXLDEV_EVENT_STATUS_INFO)
+		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_INFO);
+	if (cxlid->status & CXLDEV_EVENT_STATUS_WARN)
+		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_WARN);
+	if (cxlid->status & CXLDEV_EVENT_STATUS_FAIL)
+		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FAIL);
+	if (cxlid->status & CXLDEV_EVENT_STATUS_FATAL)
+		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FATAL);
+	if (cxlid->status & CXLDEV_EVENT_STATUS_DYNAMIC_CAP)
+		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_DYNAMIC_CAP);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t cxl_event_int_handler(int irq, void *id)
+{
+	struct cxl_event_irq_id *cxlid = id;
+	struct cxl_dev_state *cxlds = cxlid->cxlds;
+	u32 status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
+
+	if (cxlid->status & status)
+		return IRQ_WAKE_THREAD;
+	return IRQ_HANDLED;
+}
+
+static void cxl_free_event_irq(void *id)
+{
+	struct cxl_event_irq_id *cxlid = id;
+	struct pci_dev *pdev = to_pci_dev(cxlid->cxlds->dev);
+
+	pci_free_irq(pdev, cxlid->msgnum, id);
+}
+
+static u32 log_type_to_status(enum cxl_event_log_type log_type)
+{
+	switch (log_type) {
+	case CXL_EVENT_TYPE_INFO:
+		return CXLDEV_EVENT_STATUS_INFO | CXLDEV_EVENT_STATUS_DYNAMIC_CAP;
+	case CXL_EVENT_TYPE_WARN:
+		return CXLDEV_EVENT_STATUS_WARN;
+	case CXL_EVENT_TYPE_FAIL:
+		return CXLDEV_EVENT_STATUS_FAIL;
+	case CXL_EVENT_TYPE_FATAL:
+		return CXLDEV_EVENT_STATUS_FATAL;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static int cxl_request_event_irq(struct cxl_dev_state *cxlds,
+				 enum cxl_event_log_type log_type,
+				 u8 setting)
+{
+	struct device *dev = cxlds->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct cxl_event_irq_id *id;
+	unsigned int msgnum = CXL_EVENT_INT_MSGNUM(setting);
+	int irq;
+
+	/* Disabled irq is not an error */
+	if (!cxl_evt_int_is_msi(setting) || msgnum > cxlds->nr_irq_vecs) {
+		dev_dbg(dev, "Event interrupt not enabled; %s %u %d\n",
+			cxl_event_log_type_str(CXL_EVENT_TYPE_INFO),
+			msgnum, cxlds->nr_irq_vecs);
+		return 0;
+	}
+
+	id = devm_kzalloc(dev, sizeof(*id), GFP_KERNEL);
+	if (!id)
+		return -ENOMEM;
+
+	id->cxlds = cxlds;
+	id->msgnum = msgnum;
+	id->status = log_type_to_status(log_type);
+
+	irq = pci_request_irq(pdev, id->msgnum, cxl_event_int_handler,
+			      cxl_event_int_thread, id,
+			      "%s:event-log-%s", dev_name(dev),
+			      cxl_event_log_type_str(log_type));
+	if (irq)
+		return irq;
+
+	devm_add_action_or_reset(dev, cxl_free_event_irq, id);
+	return 0;
+}
+
+static void cxl_event_irqsetup(struct cxl_dev_state *cxlds)
+{
+	struct device *dev = cxlds->dev;
+	u8 setting;
+
+	if (cxl_event_config_msgnums(cxlds))
+		return;
+
+	/*
+	 * Dynamic Capacity shares the info message number
+	 * Nothing to be done except check the status bit in the
+	 * irq thread.
+	 */
+	setting = cxlds->evt_int_policy.info_settings;
+	if (cxl_request_event_irq(cxlds, CXL_EVENT_TYPE_INFO, setting))
+		dev_err(dev, "Failed to get interrupt for %s event log\n",
+			cxl_event_log_type_str(CXL_EVENT_TYPE_INFO));
+
+	setting = cxlds->evt_int_policy.warn_settings;
+	if (cxl_request_event_irq(cxlds, CXL_EVENT_TYPE_WARN, setting))
+		dev_err(dev, "Failed to get interrupt for %s event log\n",
+			cxl_event_log_type_str(CXL_EVENT_TYPE_WARN));
+
+	setting = cxlds->evt_int_policy.failure_settings;
+	if (cxl_request_event_irq(cxlds, CXL_EVENT_TYPE_FAIL, setting))
+		dev_err(dev, "Failed to get interrupt for %s event log\n",
+			cxl_event_log_type_str(CXL_EVENT_TYPE_FAIL));
+
+	setting = cxlds->evt_int_policy.fatal_settings;
+	if (cxl_request_event_irq(cxlds, CXL_EVENT_TYPE_FATAL, setting))
+		dev_err(dev, "Failed to get interrupt for %s event log\n",
+			cxl_event_log_type_str(CXL_EVENT_TYPE_FATAL));
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
@@ -525,6 +657,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return rc;
 
 	cxl_pci_alloc_irq_vectors(cxlds);
+	cxl_event_irqsetup(cxlds);
 
 	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 7c1ad8062792..a8204802fcca 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -26,6 +26,8 @@
 	___C(GET_SUPPORTED_LOGS, "Get Supported Logs"),                   \
 	___C(GET_EVENT_RECORD, "Get Event Record"),                       \
 	___C(CLEAR_EVENT_RECORD, "Clear Event Record"),                   \
+	___C(GET_EVT_INT_POLICY, "Get Event Interrupt Policy"),           \
+	___C(SET_EVT_INT_POLICY, "Set Event Interrupt Policy"),           \
 	___C(GET_FW_INFO, "Get FW Info"),                                 \
 	___C(GET_PARTITION_INFO, "Get Partition Information"),            \
 	___C(GET_LSA, "Get Label Storage Area"),                          \
-- 
2.37.2

