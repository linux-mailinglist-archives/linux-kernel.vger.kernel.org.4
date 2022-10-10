Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857F65FA7C9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiJJWno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiJJWnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:43:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98FB7B297;
        Mon, 10 Oct 2022 15:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665441795; x=1696977795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jQjzgRNwelJ7aa1kXWvGeLiPWL5481kOoQNotiQ38pk=;
  b=Fbxv9PmEGWV64tS7ia9cWHSrKfd89UuhxXSlYBrDx+PETruOE5vdarFE
   zXE7axQGK1S9CZWlN+q1zTLLY6Mcha2TAvdmtTgTFb7DIAbjjj83eAYBd
   ZEjCckKE4saInvjsvNEGNBEIP2tFKTH+YViqqT9P9MKxT7pyOQgI9fbv2
   R0TFldzNM7eEDj7HCY0XVv6cmo4KJGl9t7gh9gplJvPq8GwKQL8Ds+oKO
   QRjv7qr8kug8xIqU4BbOTJ6t9D/rlwAbFVkZ42NWfg7r6SFwY0HPxaeDR
   MjbSTMboHx8Ti1jMXkSZaz4tUamOeA0zAgrlNt7Ye52XT6lomprjugT/5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="287615397"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="287615397"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:43:11 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="621191401"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="621191401"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.252.141.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:43:11 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [RFC V2 PATCH 11/11] cxl/mem: Wire up event interrupts
Date:   Mon, 10 Oct 2022 15:41:31 -0700
Message-Id: <20221010224131.1866246-12-ira.weiny@intel.com>
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

CXL device events are signaled via interrupts.  Each event log may have
a different interrupt message number.  These message numbers are
reported in the Get Event Interrupt Policy mailbox command.

Create an infrastructure to query the max vectors required for the CXL
device.  Add event interrupt information that infrastructure.  Set up a
handler for each event log.

Davidlohr suggested the generic vector code.

Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
Link: https://lore.kernel.org/linux-cxl/20220822161802.h47v7yfrqufeltqt@offworld/
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/mbox.c      |  53 +++++++++++-
 drivers/cxl/cxlmem.h         |  32 ++++++++
 drivers/cxl/pci.c            | 152 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/cxl_mem.h |   2 +
 4 files changed, 237 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 6b3119bc83d2..ffd58da95df3 100644
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
@@ -780,8 +782,8 @@ static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
 				 &payload, sizeof(payload), NULL, 0);
 }
 
-static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
-				    enum cxl_event_log_type type)
+void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
+			     enum cxl_event_log_type type)
 {
 	struct cxl_get_event_payload payload;
 
@@ -816,6 +818,7 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
 
 	} while (payload.flags & CXL_GET_EVENT_FLAG_MORE_RECORDS);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_mem_get_records_log, CXL);
 
 /**
  * cxl_mem_get_event_records - Get Event Records from the device
@@ -839,6 +842,52 @@ void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
 
+static int cxl_event_msgnum(u8 setting)
+{
+	if (!cxl_evt_int_is_msi(setting))
+		return -1;
+
+	return CXL_EVENT_INT_MSGNUM(setting);
+}
+
+int cxl_event_get_max_msgnum(struct cxl_dev_state *cxlds)
+{
+	struct cxl_event_interrupt_policy *policy = &cxlds->evt_int_policy;
+	int rc;
+
+	policy->info_settings = CXL_INT_MSI_MSIX;
+	policy->warn_settings = CXL_INT_MSI_MSIX;
+	policy->failure_settings = CXL_INT_MSI_MSIX;
+	policy->fatal_settings = CXL_INT_MSI_MSIX;
+	policy->dyn_cap_settings = CXL_INT_MSI_MSIX;
+
+	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_SET_EVT_INT_POLICY,
+			       policy, sizeof(*policy),
+			       NULL, 0);
+	if (rc) {
+		dev_err(cxlds->dev, "Failed to set event interrupt policy : %d",
+			rc);
+		memset(policy, CXL_INT_NONE, sizeof(*policy));
+		return -1;
+	}
+
+	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_EVT_INT_POLICY, NULL, 0,
+			       policy, sizeof(*policy));
+	if (rc) {
+		dev_err(cxlds->dev, "Failed to get event interrupt policy : %d",
+			rc);
+		return -1;
+	}
+
+	rc = max_t(int, rc, cxl_event_msgnum(policy->info_settings));
+	rc = max_t(int, rc, cxl_event_msgnum(policy->warn_settings));
+	rc = max_t(int, rc, cxl_event_msgnum(policy->failure_settings));
+	rc = max_t(int, rc, cxl_event_msgnum(policy->fatal_settings));
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_event_get_max_msgnum, CXL);
+
 /**
  * cxl_mem_get_partition_info - Get partition info
  * @cxlds: The device data for the operation
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 79b3fac6d9ef..27132ed2bdd3 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -179,6 +179,32 @@ struct cxl_endpoint_dvsec_info {
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
+	CXL_INT_FW		= 0x02,
+	CXL_INT_RES		= 0x03,
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
@@ -245,6 +271,7 @@ struct cxl_dev_state {
 
 	resource_size_t component_reg_phys;
 	u64 serial;
+	struct cxl_event_interrupt_policy evt_int_policy;
 
 	struct xarray doe_mbs;
 
@@ -256,6 +283,8 @@ enum cxl_opcode {
 	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
 	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
 	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
+	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
+	CXL_MBOX_OP_SET_EVT_INT_POLICY	= 0x0103,
 	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
 	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
 	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
@@ -541,7 +570,10 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
 struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
 void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
 void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
+void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
+			     enum cxl_event_log_type type);
 void cxl_mem_get_event_records(struct cxl_dev_state *cxlds);
+int cxl_event_get_max_msgnum(struct cxl_dev_state *cxlds);
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
 void cxl_mem_active_dec(void);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 5f1b492bd388..a0d2615d5b6b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -428,6 +428,156 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
 	}
 }
 
+/**
+ * struct cxl_irq_cap - CXL feature that is capable of receiving MSI/MSI-X irqs.
+ *
+ * @name: Name of the device generating this interrupt.
+ * @get_max_msgnum: Get the feature's largest interrupt message number.  If the
+ *		    feature does not have the Interrupt Supported bit set, then
+ *		    return -1.
+ */
+struct cxl_irq_cap {
+	const char *name;
+	int (*get_max_msgnum)(struct cxl_dev_state *cxlds);
+};
+
+struct cxl_irq_cap cxl_irq_cap_table[] = {
+	{ "event", cxl_event_get_max_msgnum }
+};
+
+static void cxl_pci_free_irq_vectors(void *data)
+{
+	pci_free_irq_vectors(data);
+}
+
+static int cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
+{
+	struct device *dev = cxlds->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int rc, i, vectors = -1;
+
+	for (i = 0; i < ARRAY_SIZE(cxl_irq_cap_table); i++) {
+		int irq;
+
+		if (!cxl_irq_cap_table[i].get_max_msgnum)
+			continue;
+
+		irq = cxl_irq_cap_table[i].get_max_msgnum(cxlds);
+		vectors = max_t(int, irq, vectors);
+	}
+
+	if (vectors == -1)
+		return -EINVAL; /* no irq support whatsoever */
+
+	vectors++;
+	rc = pci_alloc_irq_vectors(pdev, vectors, vectors,
+				   PCI_IRQ_MSIX | PCI_IRQ_MSI);
+	if (rc < 0)
+		return rc;
+
+	if (rc != vectors) {
+		dev_err(dev, "Not enough interrupts; use polling where supported\n");
+		/* Some got allocated; clean them up */
+		cxl_pci_free_irq_vectors(pdev);
+		return -ENOSPC;
+	}
+
+	return devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
+}
+
+struct cxl_event_irq_id {
+	struct cxl_dev_state *cxlds;
+	enum cxl_event_log_type log_type;
+	unsigned int msgnum;
+};
+
+static irqreturn_t cxl_event_int_handler(int irq, void *id)
+{
+	struct cxl_event_irq_id *cxlid = id;
+
+	cxl_mem_get_records_log(cxlid->cxlds, cxlid->log_type);
+	return IRQ_HANDLED;
+}
+
+static void cxl_free_irq(void *id)
+{
+	struct cxl_event_irq_id *cxlid = id;
+	struct pci_dev *pdev = to_pci_dev(cxlid->cxlds->dev);
+
+	pci_free_irq(pdev, cxlid->msgnum, id);
+}
+
+static int cxl_request_event_irq(struct cxl_dev_state *cxlds,
+				 enum cxl_event_log_type log_type,
+				 u8 msgnum)
+{
+	struct device *dev = cxlds->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct cxl_event_irq_id *id;
+	int irq;
+
+	id = devm_kzalloc(dev, sizeof(*id), GFP_KERNEL);
+	if (!id)
+		return -ENOMEM;
+
+	id->cxlds = cxlds;
+	id->msgnum = msgnum;
+	id->log_type = log_type;
+
+	irq = pci_request_irq(pdev, msgnum, cxl_event_int_handler, NULL, id,
+			      "%s:event-log-%s", dev_name(dev),
+			      cxl_event_log_type_str(id->log_type));
+	if (irq)
+		return irq;
+
+	devm_add_action_or_reset(dev, cxl_free_irq, id);
+	return 0;
+}
+
+static void cxl_config_log_irq(struct cxl_dev_state *cxlds,
+			       enum cxl_event_log_type log_type,
+			       u8 setting, u8 msgnum)
+{
+	struct device *dev = cxlds->dev;
+
+	if (!cxl_evt_int_is_msi(setting)) {
+		dev_dbg(dev, "IRQ not enabled for %s event log\n",
+			cxl_event_log_type_str(log_type));
+		return;
+	}
+
+	if (cxl_request_event_irq(cxlds, log_type, msgnum))
+		dev_err(dev, "Failed to get interrupt for %s Event Log\n",
+			cxl_event_log_type_str(log_type));
+}
+
+static void cxl_configure_event_irq(struct cxl_dev_state *cxlds)
+{
+	u8 info_msg_num;
+	u8 setting;
+
+	setting = cxlds->evt_int_policy.info_settings;
+	info_msg_num = CXL_EVENT_INT_MSGNUM(setting);
+	cxl_config_log_irq(cxlds, CXL_EVENT_TYPE_INFO, setting, info_msg_num);
+
+	setting = cxlds->evt_int_policy.warn_settings;
+	cxl_config_log_irq(cxlds, CXL_EVENT_TYPE_WARN, setting,
+			   CXL_EVENT_INT_MSGNUM(setting));
+
+	setting = cxlds->evt_int_policy.failure_settings;
+	cxl_config_log_irq(cxlds, CXL_EVENT_TYPE_FAIL, setting,
+			   CXL_EVENT_INT_MSGNUM(setting));
+
+	setting = cxlds->evt_int_policy.fatal_settings;
+	cxl_config_log_irq(cxlds, CXL_EVENT_TYPE_FATAL, setting,
+			   CXL_EVENT_INT_MSGNUM(setting));
+
+	setting = cxlds->evt_int_policy.fatal_settings;
+	/* Dynamic Capacity shares the info message number */
+	cxl_config_log_irq(cxlds, CXL_EVENT_TYPE_DYNAMIC_CAP, setting,
+			   info_msg_num);
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
@@ -498,6 +648,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
+	if (!cxl_pci_alloc_irq_vectors(cxlds))
+		cxl_configure_event_irq(cxlds);
 	cxl_mem_get_event_records(cxlds);
 
 	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
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

