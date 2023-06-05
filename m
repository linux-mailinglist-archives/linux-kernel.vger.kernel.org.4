Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507C272311A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 22:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjFEUVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 16:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjFEUUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:20:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B6C131;
        Mon,  5 Jun 2023 13:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685996452; x=1717532452;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=8NoLDzTaDtX8oRYZuAAFVVjzeCX1nMQzM5M2Hww1+yw=;
  b=aBVGpgbLAbi9kRKnPXgEC5f+wIpS7twoSt8pXtdCbemZ1qMFqT+cll3T
   T4aDjlS5Rb+kEjxnMfL7K4gC26annif8PK6ma+zoiaBbe8mY2XZMikHIw
   muBl6YnRE6hP5Tt6C+A2UQvyFrCT+K3WRwffcp4gAzQ560tqbRqfipfBQ
   Lszm95QcMdhzuPIDqjWils/JgWlTIaYKRDvB0NHv1eHiyBRMnxYk8yhsh
   J+AVnGNWpJkTgQgcu8sABCl0X96pLyJs2leCrijKPLHg61P6tqTURno9C
   d9Elme6LFMO5pCo70wFrVPiiS5xInwexDB4w2hP1BG/LXNGw5VwB6cuQN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="336093124"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="336093124"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 13:20:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="832934188"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="832934188"
Received: from kmsalzbe-mobl1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.209.52.9])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 13:20:50 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Mon, 05 Jun 2023 14:20:22 -0600
Subject: [PATCH v2 1/4] cxl: add a firmware update mechanism using the
 sysfs firmware loader
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230602-vv-fw_update-v2-1-e9e5cd5adb44@intel.com>
References: <20230602-vv-fw_update-v2-0-e9e5cd5adb44@intel.com>
In-Reply-To: <20230602-vv-fw_update-v2-0-e9e5cd5adb44@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.13-dev-02a79
X-Developer-Signature: v=1; a=openpgp-sha256; l=17271;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=8NoLDzTaDtX8oRYZuAAFVVjzeCX1nMQzM5M2Hww1+yw=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDCl1zgtnZix/f3vqrN5Vbc18Py8sit+pzPXpgc/FA/GNz
 5XPO6n96ChlYRDjYpAVU2T5u+cj4zG57fk8gQmOMHNYmUCGMHBxCsBEFMsYGR7t5M/slnOLfFq8
 wNT93xUeNb9Z+l+yd79fKNixd/Jex2kMf6W1/bWzvqh5XGTiYz7MfO2PP6O1W4WYxA8xg+Len+z
 d3AA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sysfs based firmware loader mechanism was created to easily allow
userspace to upload firmware images to FPGA cards. This also happens to
be pretty suitable to create a user-initiated but kernel-controlled
firmware update mechanism for CXL devices, using the CXL specified
mailbox commands.

Since firmware update commands can be long-running, and can be processed
in the background by the endpoint device, it is desirable to have the
ability to chunk the firmware transfer down to smaller pieces, so that
one operation does not monopolize the mailbox, locking out any other
long running background commands entirely - e.g. security commands like
'sanitize' or poison scanning operations.

The firmware loader mechanism allows a natural way to perform this
chunking, as after each mailbox command, that is restricted to the
maximum mailbox payload size, the cxl memdev driver relinquishes control
back to the fw_loader system and awaits the next chunk of data to
transfer. This opens opportunities for other background commands to
access the mailbox and send their own slices of background commands.

Add the necessary helpers and state tracking to be able to perform the
'Get FW Info', 'Transfer FW', and 'Activate FW' mailbox commands as
described in the CXL spec. Wire these up to the firmware loader
callbacks, and register with that system to create the memX/firmware/
sysfs ABI.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Russ Weight <russell.h.weight@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ben Widawsky <bwidawsk@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/cxl/cxlmem.h                    |  85 +++++++++
 drivers/cxl/core/memdev.c               | 309 +++++++++++++++++++++++++++++++-
 drivers/cxl/pci.c                       |   4 +
 Documentation/ABI/testing/sysfs-bus-cxl |  11 ++
 drivers/cxl/Kconfig                     |   1 +
 5 files changed, 409 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 1d8e81c87c6a..835b544812bc 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -49,6 +49,7 @@ struct cxl_memdev {
 	struct work_struct detach_work;
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct cxl_nvdimm *cxl_nvd;
+	const char *fw_name;
 	int id;
 	int depth;
 };
@@ -83,6 +84,7 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 }
 
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
+int cxl_memdev_setup_fw_upload(struct cxl_dev_state *cxlds);
 int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			 resource_size_t base, resource_size_t len,
 			 resource_size_t skipped);
@@ -260,6 +262,84 @@ struct cxl_poison_state {
 	struct mutex lock;  /* Protect reads of poison list */
 };
 
+/*
+ * Get FW Info
+ * CXL rev 3.0 section 8.2.9.3.1; Table 8-56
+ */
+struct cxl_mbox_get_fw_info {
+	u8 num_slots;
+	u8 slot_info;
+	u8 activation_cap;
+	u8 reserved[13];
+	char slot_1_revision[16];
+	char slot_2_revision[16];
+	char slot_3_revision[16];
+	char slot_4_revision[16];
+} __packed;
+
+#define CXL_FW_INFO_SLOT_INFO_CUR_MASK			GENMASK(2, 0)
+#define CXL_FW_INFO_SLOT_INFO_NEXT_MASK			GENMASK(5, 3)
+#define CXL_FW_INFO_SLOT_INFO_NEXT_SHIFT		3
+#define CXL_FW_INFO_ACTIVATION_CAP_HAS_LIVE_ACTIVATE	BIT(0)
+
+/*
+ * Transfer FW Input Payload
+ * CXL rev 3.0 section 8.2.9.3.2; Table 8-57
+ */
+struct cxl_mbox_transfer_fw {
+	u8 action;
+	u8 slot;
+	u8 reserved[2];
+	__le32 offset;
+	u8 reserved2[0x78];
+	u8 data[];
+} __packed;
+
+#define CXL_FW_TRANSFER_ACTION_FULL	0x0
+#define CXL_FW_TRANSFER_ACTION_INITIATE	0x1
+#define CXL_FW_TRANSFER_ACTION_CONTINUE	0x2
+#define CXL_FW_TRANSFER_ACTION_END	0x3
+#define CXL_FW_TRANSFER_ACTION_ABORT	0x4
+
+/*
+ * CXL rev 3.0 section 8.2.9.3.2 mandates 128-byte alignment for FW packages
+ * and for each part transferred in a Transfer FW command.
+ */
+#define CXL_FW_TRANSFER_ALIGNMENT	128
+
+/*
+ * Activate FW Input Payload
+ * CXL rev 3.0 section 8.2.9.3.3; Table 8-58
+ */
+struct cxl_mbox_activate_fw {
+	u8 action;
+	u8 slot;
+} __packed;
+
+#define CXL_FW_ACTIVATE_ONLINE		0x0
+#define CXL_FW_ACTIVATE_OFFLINE		0x1
+
+/* FW state bits */
+#define CXL_FW_STATE_BITS		32
+#define CXL_FW_CANCEL		BIT(0)
+
+/**
+ * struct cxl_fw_state - Firmware upload / activation state
+ *
+ * @state: fw_uploader state bitmask
+ * @oneshot: whether the fw upload fits in a single transfer
+ * @num_slots: Number of FW slots available
+ * @cur_slot: Slot number currently active
+ * @next_slot: Slot number for the new firmware
+ */
+struct cxl_fw_state {
+	DECLARE_BITMAP(state, CXL_FW_STATE_BITS);
+	bool oneshot;
+	int num_slots;
+	int cur_slot;
+	int next_slot;
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -297,6 +377,8 @@ struct cxl_poison_state {
  * @serial: PCIe Device Serial Number
  * @event: event log driver state
  * @poison: poison driver state info
+ * @fw: firmware upload / activation state
+ * @fwl: handle for registration with the firmware loader system
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
@@ -336,6 +418,8 @@ struct cxl_dev_state {
 
 	struct cxl_event_state event;
 	struct cxl_poison_state poison;
+	struct cxl_fw_state fw;
+	struct fw_upload *fwl;
 
 	struct rcuwait mbox_wait;
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
@@ -349,6 +433,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
 	CXL_MBOX_OP_SET_EVT_INT_POLICY	= 0x0103,
 	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
+	CXL_MBOX_OP_TRANSFER_FW		= 0x0201,
 	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
 	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
 	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 057a43267290..f45c8b174d9d 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. */
 
+#include <linux/firmware.h>
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/idr.h>
@@ -441,6 +442,7 @@ static void cxl_memdev_unregister(void *_cxlmd)
 	struct cxl_memdev *cxlmd = _cxlmd;
 	struct device *dev = &cxlmd->dev;
 
+	kfree(cxlmd->fw_name);
 	cxl_memdev_shutdown(dev);
 	cdev_device_del(&cxlmd->cdev, dev);
 	put_device(dev);
@@ -542,6 +544,311 @@ static int cxl_memdev_release_file(struct inode *inode, struct file *file)
 	return 0;
 }
 
+/**
+ * cxl_mem_get_fw_info - Get Firmware info
+ * @cxlds: The device data for the operation
+ *
+ * Retrieve firmware info for the device specified.
+ *
+ * Return: 0 if no error: or the result of the mailbox command.
+ *
+ * See CXL-3.0 8.2.9.3.1 Get FW Info
+ */
+static int cxl_mem_get_fw_info(struct cxl_dev_state *cxlds)
+{
+	struct cxl_mbox_get_fw_info info;
+	struct cxl_mbox_cmd mbox_cmd;
+	int rc;
+
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_GET_FW_INFO,
+		.size_out = sizeof(info),
+		.payload_out = &info,
+	};
+
+	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
+	if (rc < 0)
+		return rc;
+
+	cxlds->fw.num_slots = info.num_slots;
+	cxlds->fw.cur_slot = FIELD_GET(CXL_FW_INFO_SLOT_INFO_CUR_MASK,
+				       info.slot_info);
+
+	return 0;
+}
+
+/**
+ * cxl_mem_activate_fw - Activate Firmware
+ * @cxlds: The device data for the operation
+ * @slot: slot number to activate
+ *
+ * Activate firmware in a given slot for the device specified.
+ *
+ * Return: 0 if no error: or the result of the mailbox command.
+ *
+ * See CXL-3.0 8.2.9.3.3 Activate FW
+ */
+static int cxl_mem_activate_fw(struct cxl_dev_state *cxlds, int slot)
+{
+	struct cxl_mbox_activate_fw activate;
+	struct cxl_mbox_cmd mbox_cmd;
+
+	if (slot == 0 || slot > cxlds->fw.num_slots)
+		return -EINVAL;
+
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_ACTIVATE_FW,
+		.size_in = sizeof(activate),
+		.payload_in = &activate,
+	};
+
+	/* Only offline activation supported for now */
+	activate.action = CXL_FW_ACTIVATE_OFFLINE;
+	activate.slot = slot;
+
+	return cxl_internal_send_cmd(cxlds, &mbox_cmd);
+}
+
+/**
+ * cxl_mem_abort_fw_xfer - Abort an in-progress FW transfer
+ * @cxlds: The device data for the operation
+ *
+ * Abort an in-progress firmware transfer for the device specified.
+ *
+ * Return: 0 if no error: or the result of the mailbox command.
+ *
+ * See CXL-3.0 8.2.9.3.2 Transfer FW
+ */
+static int cxl_mem_abort_fw_xfer(struct cxl_dev_state *cxlds)
+{
+	struct cxl_mbox_transfer_fw *transfer;
+	struct cxl_mbox_cmd mbox_cmd;
+	int rc;
+
+	transfer = kzalloc(struct_size(transfer, data, 0), GFP_KERNEL);
+	if (!transfer)
+		return -ENOMEM;
+
+	/* Set a 1s poll interval and a total wait time of 30s */
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_TRANSFER_FW,
+		.size_in = sizeof(*transfer),
+		.payload_in = transfer,
+		.poll_interval_ms = 1000,
+		.poll_count = 30,
+	};
+
+	transfer->action = CXL_FW_TRANSFER_ACTION_ABORT;
+
+	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
+	kfree(transfer);
+	return rc;
+}
+
+static void cxl_fw_cleanup(struct fw_upload *fwl)
+{
+	struct cxl_dev_state *cxlds = fwl->dd_handle;
+
+	cxlds->fw.next_slot = 0;
+}
+
+static int cxl_fw_do_cancel(struct fw_upload *fwl)
+{
+	struct cxl_dev_state *cxlds = fwl->dd_handle;
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	int rc;
+
+	rc = cxl_mem_abort_fw_xfer(cxlds);
+	if (rc < 0)
+		dev_err(&cxlmd->dev, "Error aborting FW transfer: %d\n", rc);
+
+	return FW_UPLOAD_ERR_CANCELED;
+}
+
+static enum fw_upload_err cxl_fw_prepare(struct fw_upload *fwl, const u8 *data,
+					 u32 size)
+{
+	struct cxl_dev_state *cxlds = fwl->dd_handle;
+	struct cxl_mbox_transfer_fw *transfer;
+
+	if (!size)
+		return FW_UPLOAD_ERR_INVALID_SIZE;
+
+	cxlds->fw.oneshot = struct_size(transfer, data, size) <
+			    cxlds->payload_size;
+
+	if (cxl_mem_get_fw_info(cxlds))
+		return FW_UPLOAD_ERR_HW_ERROR;
+
+	/*
+	 * So far no state has been changed, hence no other cleanup is
+	 * necessary. Simply return the cancelled status.
+	 */
+	if (test_and_clear_bit(CXL_FW_CANCEL, cxlds->fw.state))
+		return FW_UPLOAD_ERR_CANCELED;
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
+				       u32 offset, u32 size, u32 *written)
+{
+	struct cxl_dev_state *cxlds = fwl->dd_handle;
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct cxl_mbox_transfer_fw *transfer;
+	struct cxl_mbox_cmd mbox_cmd;
+	u32 cur_size, remaining;
+	size_t size_in;
+	int rc;
+
+	*written = 0;
+
+	/* Offset has to be aligned to 128B (CXL-3.0 8.2.9.3.2 Table 8-57) */
+	if (!IS_ALIGNED(offset, CXL_FW_TRANSFER_ALIGNMENT)) {
+		dev_err(&cxlmd->dev,
+			"misaligned offset for FW transfer slice (%u)\n",
+			offset);
+		return FW_UPLOAD_ERR_RW_ERROR;
+	}
+
+	/* Pick transfer size based on cxlds->payload_size */
+	cur_size = min_t(size_t, size, cxlds->payload_size - sizeof(*transfer));
+	remaining = size - cur_size;
+	size_in = struct_size(transfer, data, cur_size);
+
+	if (test_and_clear_bit(CXL_FW_CANCEL, cxlds->fw.state))
+		return cxl_fw_do_cancel(fwl);
+
+	/*
+	 * Slot numbers are 1-indexed
+	 * cur_slot is the 0-indexed next_slot (i.e. 'cur_slot - 1 + 1')
+	 * Check for rollover using modulo, and 1-index it by adding 1
+	 */
+	cxlds->fw.next_slot = (cxlds->fw.cur_slot % cxlds->fw.num_slots) + 1;
+
+	/* Do the transfer via mailbox cmd */
+	transfer = kzalloc(size_in, GFP_KERNEL);
+	if (!transfer)
+		return FW_UPLOAD_ERR_RW_ERROR;
+
+	transfer->offset = cpu_to_le32(offset / CXL_FW_TRANSFER_ALIGNMENT);
+	memcpy(transfer->data, data + offset, cur_size);
+	if (cxlds->fw.oneshot) {
+		transfer->action = CXL_FW_TRANSFER_ACTION_FULL;
+		transfer->slot = cxlds->fw.next_slot;
+	} else {
+		if (offset == 0) {
+			transfer->action = CXL_FW_TRANSFER_ACTION_INITIATE;
+		} else if (remaining == 0) {
+			transfer->action = CXL_FW_TRANSFER_ACTION_END;
+			transfer->slot = cxlds->fw.next_slot;
+		} else {
+			transfer->action = CXL_FW_TRANSFER_ACTION_CONTINUE;
+		}
+	}
+
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_TRANSFER_FW,
+		.size_in = size_in,
+		.payload_in = transfer,
+		.poll_interval_ms = 1000,
+		.poll_count = 30,
+	};
+
+	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
+	if (rc < 0) {
+		kfree(transfer);
+		rc = FW_UPLOAD_ERR_RW_ERROR;
+		goto out_free;
+	}
+
+	*written = cur_size;
+
+	/* Activate FW if oneshot or if the last slice was written */
+	if (cxlds->fw.oneshot || remaining == 0) {
+		dev_dbg(&cxlmd->dev, "Activating firmware slot: %d\n",
+			cxlds->fw.next_slot);
+		rc = cxl_mem_activate_fw(cxlds, cxlds->fw.next_slot);
+		if (rc < 0) {
+			dev_err(&cxlmd->dev, "Error activating firmware: %d\n",
+				rc);
+			rc = FW_UPLOAD_ERR_HW_ERROR;
+			goto out_free;
+		}
+	}
+
+	rc = FW_UPLOAD_ERR_NONE;
+
+out_free:
+	kfree(transfer);
+	return rc;
+}
+
+static enum fw_upload_err cxl_fw_poll_complete(struct fw_upload *fwl)
+{
+	struct cxl_dev_state *cxlds = fwl->dd_handle;
+
+	/*
+	 * cxl_internal_send_cmd() handles background operations synchronously.
+	 * No need to wait for completions here - any errors would've been
+	 * reported and handled during the ->write() call(s).
+	 * Just check if a cancel request was received, and return success.
+	 */
+	if (test_and_clear_bit(CXL_FW_CANCEL, cxlds->fw.state))
+		return cxl_fw_do_cancel(fwl);
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static void cxl_fw_cancel(struct fw_upload *fwl)
+{
+	struct cxl_dev_state *cxlds = fwl->dd_handle;
+
+	set_bit(CXL_FW_CANCEL, cxlds->fw.state);
+}
+
+static const struct fw_upload_ops cxl_memdev_fw_ops = {
+        .prepare = cxl_fw_prepare,
+        .write = cxl_fw_write,
+        .poll_complete = cxl_fw_poll_complete,
+        .cancel = cxl_fw_cancel,
+        .cleanup = cxl_fw_cleanup,
+};
+
+static void devm_cxl_remove_fw_upload(void *fwl)
+{
+	firmware_upload_unregister(fwl);
+}
+
+int cxl_memdev_setup_fw_upload(struct cxl_dev_state *cxlds)
+{
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct fw_upload *fwl;
+	int rc;
+
+	if (!test_bit(CXL_MEM_COMMAND_ID_GET_FW_INFO, cxlds->enabled_cmds))
+		return 0;
+
+	fwl = firmware_upload_register(THIS_MODULE, &cxlmd->dev,
+				       dev_name(&cxlmd->dev),
+				       &cxl_memdev_fw_ops, cxlds);
+	if (IS_ERR(fwl)) {
+		dev_err(&cxlmd->dev, "Failed to register firmware loader\n");
+		return PTR_ERR(fwl);
+	}
+
+	cxlds->fwl = fwl;
+	rc = devm_add_action_or_reset(cxlds->dev, devm_cxl_remove_fw_upload,
+				      cxlds->fwl);
+	if (rc)
+		dev_err(&cxlmd->dev,
+			"Failed to add firmware loader remove action: %d\n",
+			rc);
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_memdev_setup_fw_upload, CXL);
+
 static const struct file_operations cxl_memdev_fops = {
 	.owner = THIS_MODULE,
 	.unlocked_ioctl = cxl_memdev_ioctl,
@@ -581,7 +888,7 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 
 	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
 	if (rc)
-		return ERR_PTR(rc);
+		goto err;
 	return cxlmd;
 
 err:
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index a78e40e6d0e0..ef0b4821b312 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -842,6 +842,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
+	rc = cxl_memdev_setup_fw_upload(cxlds);
+	if (rc)
+		return rc;
+
 	rc = cxl_event_config(host_bridge, cxlds);
 	if (rc)
 		return rc;
diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 48ac0d911801..06a7718d3fc3 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -58,6 +58,17 @@ Description:
 		affinity for this device.
 
 
+What:		/sys/bus/cxl/devices/memX/firmware/
+Date:		April, 2023
+KernelVersion:	v6.5
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RW) Firmware uploader mechanism. The different files under
+		this directory can be used to upload and activate new
+		firmware for CXL devices. The interfaces under this are
+		documented in sysfs-class-firmware.
+
+
 What:		/sys/bus/cxl/devices/*/devtype
 Date:		June, 2021
 KernelVersion:	v5.14
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index ff4e78117b31..80d8e35fa049 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -82,6 +82,7 @@ config CXL_PMEM
 config CXL_MEM
 	tristate "CXL: Memory Expansion"
 	depends on CXL_PCI
+	select FW_UPLOAD
 	default CXL_BUS
 	help
 	  The CXL.mem protocol allows a device to act as a provider of "System

-- 
2.40.1

