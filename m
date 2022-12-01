Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6A463E683
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 01:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiLAA2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 19:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiLAA1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 19:27:55 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8B65FDB;
        Wed, 30 Nov 2022 16:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669854457; x=1701390457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dS7fziOXK4qpwRJCqQ3zRqxIj/8cRjILMGL8c7PQiyM=;
  b=L3vPnau7TUhX7qecuh/gZWlxwwcyQc3ZIcp1z/MvDv4caid4jHVMrrIH
   2vzdIM/q2DdXiQbPrvSI0OKS5Wg74dEQrDaTvBpGATbJlM1eEJ/VBVbTM
   ewlL9nIO5m+Eb/k4/pi3gK4r1UTnUAzvzLNV7f0cNiO0LsxSNK5Z0nzd4
   s95kw04ahyBxqJ+RXjQDm318HKSXwKQyyg9LN1rqkbhN8rAHfXZ3q44Q2
   ZFdZek7uGNkxHBXa8cUztCJ+pPsaYd+uzp1vU6Y/KD6htPGSWXBS8Lw8O
   ioPLVmokuv3WWb7z/m3i6lKKp+8i6W+9/e3cHOjR1NaktjiEQZIBvQLPn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="317400878"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="317400878"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 16:27:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="622085241"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="622085241"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.251.1.240])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 16:27:33 -0800
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
Subject: [PATCH V2 08/11] cxl/mem: Wire up event interrupts
Date:   Wed, 30 Nov 2022 16:27:16 -0800
Message-Id: <20221201002719.2596558-9-ira.weiny@intel.com>
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

CXL device events are signaled via interrupts.  Each event log may have
a different interrupt message number.  These message numbers are
reported in the Get Event Interrupt Policy mailbox command.

Add interrupt support for event logs.  Interrupts are allocated as
shared interrupts.  Therefore, all or some event logs can share the same
message number.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V1:
	Remove unneeded evt_int_policy from struct cxl_dev_state
	defer Dynamic Capacity support
	Dave Jiang
		s/irq/rc
		use IRQ_NONE to signal the irq was not for us.
	Jonathan
		use msi_enabled rather than nr_irq_vec
		On failure explicitly set CXL_INT_NONE
		Add comment for Get Event Interrupt Policy
		use devm_request_threaded_irq()
		Use individual handler/thread functions for each of the
		logs rather than struct cxl_event_irq_id.

Changes from RFC v2
	Adjust to new irq 16 vector allocation
	Jonathan
		Remove CXL_INT_RES
	Use irq threads to ensure mailbox commands are executed outside irq context
	Adjust for optional Dynamic Capacity log
---
 drivers/cxl/core/mbox.c      |  44 +++++++++++-
 drivers/cxl/cxlmem.h         |  30 ++++++++
 drivers/cxl/pci.c            | 130 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/cxl_mem.h |   2 +
 4 files changed, 204 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 30840b711381..1e00b49d8b06 100644
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
@@ -806,8 +808,8 @@ static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
 	return 0;
 }
 
-static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
-				    enum cxl_event_log_type type)
+void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
+			     enum cxl_event_log_type type)
 {
 	struct cxl_get_event_payload *payload;
 	u16 nr_rec;
@@ -857,6 +859,7 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
 unlock_buffer:
 	mutex_unlock(&cxlds->event_buf_lock);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_mem_get_records_log, CXL);
 
 static void cxl_mem_free_event_buffer(void *data)
 {
@@ -916,6 +919,43 @@ void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
 
+int cxl_event_config_msgnums(struct cxl_dev_state *cxlds,
+			     struct cxl_event_interrupt_policy *policy)
+{
+	int rc;
+
+	policy->info_settings = CXL_INT_MSI_MSIX;
+	policy->warn_settings = CXL_INT_MSI_MSIX;
+	policy->failure_settings = CXL_INT_MSI_MSIX;
+	policy->fatal_settings = CXL_INT_MSI_MSIX;
+
+	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_SET_EVT_INT_POLICY,
+			       policy, sizeof(*policy), NULL, 0);
+	if (rc < 0) {
+		dev_err(cxlds->dev, "Failed to set event interrupt policy : %d",
+			rc);
+
+		policy->info_settings = CXL_INT_NONE;
+		policy->warn_settings = CXL_INT_NONE;
+		policy->failure_settings = CXL_INT_NONE;
+		policy->fatal_settings = CXL_INT_NONE;
+
+		return rc;
+	}
+
+	/* Retrieve interrupt message numbers */
+	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_EVT_INT_POLICY, NULL, 0,
+			       policy, sizeof(*policy));
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
index 450b410f29f6..2d384b0fc2b3 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -179,6 +179,30 @@ struct cxl_endpoint_dvsec_info {
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
@@ -262,6 +286,8 @@ enum cxl_opcode {
 	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
 	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
 	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
+	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
+	CXL_MBOX_OP_SET_EVT_INT_POLICY	= 0x0103,
 	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
 	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
 	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
@@ -537,7 +563,11 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
 struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
 void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
 void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
+void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
+			     enum cxl_event_log_type type);
 void cxl_mem_get_event_records(struct cxl_dev_state *cxlds);
+int cxl_event_config_msgnums(struct cxl_dev_state *cxlds,
+			     struct cxl_event_interrupt_policy *policy);
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
 void cxl_mem_active_dec(void);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 11e95a95195a..3c0b9199f11a 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -449,6 +449,134 @@ static void cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
 	cxlds->msi_enabled = true;
 }
 
+static irqreturn_t cxl_event_info_thread(int irq, void *id)
+{
+	struct cxl_dev_state *cxlds = id;
+
+	cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_INFO);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t cxl_event_info_handler(int irq, void *id)
+{
+	struct cxl_dev_state *cxlds = id;
+	u32 status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
+
+	if (CXLDEV_EVENT_STATUS_INFO & status)
+		return IRQ_WAKE_THREAD;
+	return IRQ_NONE;
+}
+
+static irqreturn_t cxl_event_warn_thread(int irq, void *id)
+{
+	struct cxl_dev_state *cxlds = id;
+
+	cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_WARN);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t cxl_event_warn_handler(int irq, void *id)
+{
+	struct cxl_dev_state *cxlds = id;
+	u32 status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
+
+	if (CXLDEV_EVENT_STATUS_WARN & status)
+		return IRQ_WAKE_THREAD;
+	return IRQ_NONE;
+}
+
+static irqreturn_t cxl_event_failure_thread(int irq, void *id)
+{
+	struct cxl_dev_state *cxlds = id;
+
+	cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FAIL);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t cxl_event_failure_handler(int irq, void *id)
+{
+	struct cxl_dev_state *cxlds = id;
+	u32 status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
+
+	if (CXLDEV_EVENT_STATUS_FAIL & status)
+		return IRQ_WAKE_THREAD;
+	return IRQ_NONE;
+}
+
+static irqreturn_t cxl_event_fatal_thread(int irq, void *id)
+{
+	struct cxl_dev_state *cxlds = id;
+
+	cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FATAL);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t cxl_event_fatal_handler(int irq, void *id)
+{
+	struct cxl_dev_state *cxlds = id;
+	u32 status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
+
+	if (CXLDEV_EVENT_STATUS_FATAL & status)
+		return IRQ_WAKE_THREAD;
+	return IRQ_NONE;
+}
+
+static void cxl_event_irqsetup(struct cxl_dev_state *cxlds)
+{
+	struct cxl_event_interrupt_policy policy;
+	struct device *dev = cxlds->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u8 setting;
+	int rc;
+
+	if (cxl_event_config_msgnums(cxlds, &policy))
+		return;
+
+	setting = policy.info_settings;
+	if (cxl_evt_int_is_msi(setting)) {
+		rc = devm_request_threaded_irq(dev,
+				pci_irq_vector(pdev, CXL_EVENT_INT_MSGNUM(setting)),
+				cxl_event_info_handler, cxl_event_info_thread,
+				IRQF_SHARED, NULL, cxlds);
+		if (rc)
+			dev_err(dev, "Failed to get interrupt for %s event log\n",
+				cxl_event_log_type_str(CXL_EVENT_TYPE_INFO));
+	}
+
+	setting = policy.warn_settings;
+	if (cxl_evt_int_is_msi(setting)) {
+		rc = devm_request_threaded_irq(dev,
+				pci_irq_vector(pdev, CXL_EVENT_INT_MSGNUM(setting)),
+				cxl_event_warn_handler, cxl_event_warn_thread,
+				IRQF_SHARED, NULL, cxlds);
+		if (rc)
+			dev_err(dev, "Failed to get interrupt for %s event log\n",
+				cxl_event_log_type_str(CXL_EVENT_TYPE_WARN));
+	}
+
+	setting = policy.failure_settings;
+	if (cxl_evt_int_is_msi(setting)) {
+		rc = devm_request_threaded_irq(dev,
+				pci_irq_vector(pdev, CXL_EVENT_INT_MSGNUM(setting)),
+				cxl_event_failure_handler, cxl_event_failure_thread,
+				IRQF_SHARED, NULL, cxlds);
+		if (rc)
+			dev_err(dev, "Failed to get interrupt for %s event log\n",
+				cxl_event_log_type_str(CXL_EVENT_TYPE_FAIL));
+	}
+
+	setting = policy.fatal_settings;
+	if (cxl_evt_int_is_msi(setting)) {
+		rc = devm_request_threaded_irq(dev,
+				pci_irq_vector(pdev, CXL_EVENT_INT_MSGNUM(setting)),
+				cxl_event_fatal_handler, cxl_event_fatal_thread,
+				IRQF_SHARED, NULL, cxlds);
+		if (rc)
+			dev_err(dev, "Failed to get interrupt for %s event log\n",
+				cxl_event_log_type_str(CXL_EVENT_TYPE_FATAL));
+	}
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
@@ -516,6 +644,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return rc;
 
 	cxl_pci_alloc_irq_vectors(cxlds);
+	if (cxlds->msi_enabled)
+		cxl_event_irqsetup(cxlds);
 
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

