Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF711693C24
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 03:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjBMCVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 21:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjBMCVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 21:21:43 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D680FF3F;
        Sun, 12 Feb 2023 18:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676254900; x=1707790900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tot06ZrpgRqpaHJjI93sCmTTQ7KdekHTBwRcoXQLrnE=;
  b=cPu0oV78/q7ZQr1xcsDaVuEmKy/Hei5skYLQQVKQjjL2ZRrwj5tybnjO
   O2D82pV3d5/FtoDoWCLSFCrl3x/Rp+//kKgACsXsCilUx5BFKWpVFjPXV
   pJDHgx1KtbFY34naO2mg6ZfhqT3ILOQHKB4rDKW/OE/xA6dVZ5ElaG+Pg
   UOj6Y31kkn6F72HfHeupIAjqF6LRiCvEKg8j7BKW8NKPjPVaK07ReceN0
   qYXzlSbe2mVf5Ek/tqi8t05iMi5IXsW/EYpy35Zfc2c3oEZcGx5qFnSvD
   oNxS4TuWInDKusmKgq+PHOCQZ4wIWuVJgRPQscz6OUgZfsxOMMMB6L8fI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="310424833"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="310424833"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 18:21:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="701103157"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="701103157"
Received: from wentongw-hp-z228-microtower-workstation.sh.intel.com ([10.239.153.109])
  by orsmga001.jf.intel.com with ESMTP; 12 Feb 2023 18:21:36 -0800
From:   Wentong Wu <wentong.wu@intel.com>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        linux-media@vger.kernel.org
Cc:     srinivas.pandruvada@intel.com,
        pierre-louis.bossart@linux.intel.com, zhifeng.wang@intel.com,
        xiang.ye@intel.com, tian.shu.qiu@intel.com, bingbu.cao@intel.com,
        linux-kernel@vger.kernel.org, Wentong Wu <wentong.wu@intel.com>
Subject: [PATCH v2 2/3] media: pci: intel: ivsc: Add ACE submodule
Date:   Mon, 13 Feb 2023 10:23:46 +0800
Message-Id: <20230213022347.2480307-3-wentong.wu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213022347.2480307-1-wentong.wu@intel.com>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACE is a submodule of IVSC which controls camera sensor's
ownership, belonging to host or IVSC. When IVSC owns camera
sensor, it is for algorithm computing. When host wants to
control camera sensor, ACE module needs to be informed of
ownership with defined interface.

The interface is via MEI. There is a separate MEI UUID, which
this driver uses to enumerate.

To switch ownership of camera sensor between IVSC and host,
the caller specifies the defined ownership information which
will be sent to firmware by sending MEI command.

The only exported API ace_set_camera_owner is to switch
ownership of camera sensor.

Signed-off-by: Wentong Wu <wentong.wu@intel.com>
---
 drivers/media/pci/intel/ivsc/Makefile  |   1 +
 drivers/media/pci/intel/ivsc/mei_ace.c | 472 +++++++++++++++++++++++++
 drivers/media/pci/intel/ivsc/mei_ace.h |  36 ++
 3 files changed, 509 insertions(+)
 create mode 100644 drivers/media/pci/intel/ivsc/mei_ace.c
 create mode 100644 drivers/media/pci/intel/ivsc/mei_ace.h

diff --git a/drivers/media/pci/intel/ivsc/Makefile b/drivers/media/pci/intel/ivsc/Makefile
index 1825aad45cff..de0a425c22c2 100644
--- a/drivers/media/pci/intel/ivsc/Makefile
+++ b/drivers/media/pci/intel/ivsc/Makefile
@@ -3,3 +3,4 @@
 # Copyright (C) 2023, Intel Corporation. All rights reserved.
 
 obj-$(CONFIG_INTEL_VSC) += mei_csi.o
+obj-$(CONFIG_INTEL_VSC) += mei_ace.o
diff --git a/drivers/media/pci/intel/ivsc/mei_ace.c b/drivers/media/pci/intel/ivsc/mei_ace.c
new file mode 100644
index 000000000000..3dbd885d11a1
--- /dev/null
+++ b/drivers/media/pci/intel/ivsc/mei_ace.c
@@ -0,0 +1,472 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Intel Corporation. All rights reserved.
+ * Intel Visual Sensing Controller ACE Linux driver
+ */
+
+/*
+ * To set ownership of camera sensor, there is specific command, which
+ * is sent via MEI protocol. That's a two-step scheme where the firmware
+ * first acks receipt of the command and later responses the command was
+ * executed. The command sending function uses "completion" as the
+ * synchronization mechanism. The notification for command is received
+ * via a mei callback which wakes up the caller. There can be only one
+ * outstanding command at a time.
+ */
+
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/ivsc.h>
+#include <linux/kernel.h>
+#include <linux/mei_cl_bus.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/uuid.h>
+
+#include "mei_ace.h"
+
+#define	MEI_ACE_DRIVER_NAME	"ivsc_ace"
+
+/* indicating driver message */
+#define	ACE_DRV_MSG		1
+/* indicating set command */
+#define	ACE_CMD_SET		4
+/* command timeout determined experimentally */
+#define	ACE_CMD_TIMEOUT		(5 * HZ)
+/* indicating the first command block */
+#define	ACE_CMD_INIT_BLOCK	1
+/* indicating the last command block */
+#define	ACE_CMD_FINAL_BLOCK	1
+/* size of camera status notification content */
+#define	ACE_CAMERA_STATUS_SIZE	5
+
+/* UUID used to get firmware id */
+#define ACE_GET_FW_ID_UUID UUID_LE(0x6167DCFB, 0x72F1, 0x4584, 0xBF, \
+				   0xE3, 0x84, 0x17, 0x71, 0xAA, 0x79, 0x0B)
+
+/* identify firmware event type */
+enum ace_event_type {
+	/* firmware ready */
+	ACE_FW_READY = 0x8,
+
+	/* command response */
+	ACE_CMD_RESPONSE = 0x10,
+};
+
+/* identify the command id supported by firmware IPC */
+enum ace_cmd_id {
+	/* used to switch camera sensor to host */
+	ACE_SWITCH_CAMERA_TO_HOST = 0x13,
+
+	/* used to switch camera sensor to IVSC */
+	ACE_SWITCH_CAMERA_TO_IVSC = 0x14,
+
+	/* used to get firmware id */
+	ACE_GET_FW_ID = 0x1A,
+};
+
+/* ACE command header structure */
+struct ace_cmd_hdr {
+	u32 firmware_id : 16;
+	u32 instance_id : 8;
+	u32 type : 5;
+	u32 rsp : 1;
+	u32 msg_tgt : 1;
+	u32 _hw_rsvd_1 : 1;
+	u32 param_size : 20;
+	u32 cmd_id : 8;
+	u32 final_block : 1;
+	u32 init_block : 1;
+	u32 _hw_rsvd_2 : 2;
+} __packed;
+
+/* ACE command parameter structure */
+union ace_cmd_param {
+	uuid_le uuid;
+	u32 param;
+};
+
+/* ACE command structure */
+struct ace_cmd {
+	struct ace_cmd_hdr hdr;
+	union ace_cmd_param param;
+} __packed;
+
+/* ACE notification header */
+union ace_notif_hdr {
+	struct _confirm {
+		u32 status : 24;
+		u32 type : 5;
+		u32 rsp : 1;
+		u32 msg_tgt : 1;
+		u32 _hw_rsvd_1 : 1;
+		u32 param_size : 20;
+		u32 cmd_id : 8;
+		u32 final_block : 1;
+		u32 init_block : 1;
+		u32 _hw_rsvd_2 : 2;
+	} __packed ack;
+
+	struct _event {
+		u32 rsvd1 : 16;
+		u32 event_type : 8;
+		u32 type : 5;
+		u32 ack : 1;
+		u32 msg_tgt : 1;
+		u32 _hw_rsvd_1 : 1;
+		u32 rsvd2 : 30;
+		u32 _hw_rsvd_2 : 2;
+	} __packed event;
+
+	struct _response {
+		u32 event_id : 16;
+		u32 notif_type : 8;
+		u32 type : 5;
+		u32 rsp : 1;
+		u32 msg_tgt : 1;
+		u32 _hw_rsvd_1 : 1;
+		u32 event_data_size : 16;
+		u32 request_target : 1;
+		u32 request_type : 5;
+		u32 cmd_id : 8;
+		u32 _hw_rsvd_2 : 2;
+	} __packed response;
+};
+
+/* ACE notification content */
+union ace_notif_cont {
+	u16 firmware_id;
+	u8 state_notif;
+	u8 camera_status[ACE_CAMERA_STATUS_SIZE];
+};
+
+/* ACE notification structure */
+struct ace_notif {
+	union ace_notif_hdr hdr;
+	union ace_notif_cont cont;
+} __packed;
+
+struct mei_ace {
+	struct mei_cl_device *cldev;
+
+	/* command ack */
+	struct ace_notif cmd_ack;
+	/* command response */
+	struct ace_notif cmd_response;
+	/* used to wait for command ack and response */
+	struct completion cmd_completion;
+
+	/* used to construct command */
+	u16 firmware_id;
+};
+
+/* only one for now */
+static struct mei_ace *ace;
+/* lock used to prevent multiple call to ace */
+static DEFINE_MUTEX(ace_mutex);
+
+static inline void init_cmd_hdr(struct ace_cmd_hdr *hdr)
+{
+	memset(hdr, 0, sizeof(struct ace_cmd_hdr));
+
+	hdr->type = ACE_CMD_SET;
+	hdr->msg_tgt = ACE_DRV_MSG;
+	hdr->init_block = ACE_CMD_INIT_BLOCK;
+	hdr->final_block = ACE_CMD_FINAL_BLOCK;
+}
+
+static int construct_command(struct ace_cmd *cmd, enum ace_cmd_id cmd_id)
+{
+	union ace_cmd_param *param = &cmd->param;
+	struct ace_cmd_hdr *hdr = &cmd->hdr;
+
+	init_cmd_hdr(hdr);
+
+	hdr->cmd_id = cmd_id;
+	switch (cmd_id) {
+	case ACE_GET_FW_ID:
+		param->uuid = ACE_GET_FW_ID_UUID;
+		hdr->param_size = sizeof(param->uuid);
+		break;
+	case ACE_SWITCH_CAMERA_TO_IVSC:
+		param->param = 0;
+		hdr->firmware_id = ace->firmware_id;
+		hdr->param_size = sizeof(param->param);
+		break;
+	case ACE_SWITCH_CAMERA_TO_HOST:
+		hdr->firmware_id = ace->firmware_id;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return hdr->param_size + sizeof(cmd->hdr);
+}
+
+/* send a command to firmware and mutex must be held by caller */
+static int mei_ace_send(struct ace_cmd *cmd, size_t len, bool only_ack)
+{
+	union ace_notif_hdr *resp_hdr = &ace->cmd_response.hdr;
+	union ace_notif_hdr *ack_hdr = &ace->cmd_ack.hdr;
+	struct ace_cmd_hdr *cmd_hdr = &cmd->hdr;
+	int ret;
+
+	reinit_completion(&ace->cmd_completion);
+
+	ret = mei_cldev_send(ace->cldev, (u8 *)cmd, len);
+	if (ret < 0)
+		goto out;
+
+	ret = wait_for_completion_killable_timeout(&ace->cmd_completion,
+						   ACE_CMD_TIMEOUT);
+	if (ret < 0) {
+		goto out;
+	} else if (!ret) {
+		ret = -ETIMEDOUT;
+		goto out;
+	}
+
+	if (ack_hdr->ack.cmd_id != cmd_hdr->cmd_id) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* command ack status */
+	ret = ack_hdr->ack.status;
+	if (ret) {
+		ret = -EIO;
+		goto out;
+	}
+
+	if (only_ack)
+		goto out;
+
+	ret = wait_for_completion_killable_timeout(&ace->cmd_completion,
+						   ACE_CMD_TIMEOUT);
+	if (ret < 0) {
+		goto out;
+	} else if (!ret) {
+		ret = -ETIMEDOUT;
+		goto out;
+	}
+
+	if (resp_hdr->response.cmd_id != cmd_hdr->cmd_id)
+		ret = -EINVAL;
+
+out:
+	return ret;
+}
+
+int ace_set_camera_owner(enum ace_camera_owner owner)
+{
+	enum ace_cmd_id cmd_id;
+	struct ace_cmd cmd;
+	int cmd_size;
+	int ret;
+
+	if (owner == ACE_CAMERA_IVSC)
+		cmd_id = ACE_SWITCH_CAMERA_TO_IVSC;
+	else
+		cmd_id = ACE_SWITCH_CAMERA_TO_HOST;
+
+	mutex_lock(&ace_mutex);
+	if (unlikely(!ace)) {
+		mutex_unlock(&ace_mutex);
+		return -EAGAIN;
+	}
+
+	cmd_size = construct_command(&cmd, cmd_id);
+	if (cmd_size >= 0)
+		ret = mei_ace_send(&cmd, cmd_size, false);
+	else
+		ret = cmd_size;
+	mutex_unlock(&ace_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(ace_set_camera_owner, IVSC);
+
+/* the first command downloaded to firmware */
+static inline int ace_get_firmware_id(void)
+{
+	struct ace_cmd cmd;
+	int cmd_size;
+	int ret;
+
+	cmd_size = construct_command(&cmd, ACE_GET_FW_ID);
+	if (cmd_size >= 0)
+		ret = mei_ace_send(&cmd, cmd_size, true);
+	else
+		ret = cmd_size;
+
+	return ret;
+}
+
+static void handle_command_response(struct ace_notif *resp, int len)
+{
+	union ace_notif_hdr *hdr = &resp->hdr;
+
+	switch (hdr->response.cmd_id) {
+	case ACE_SWITCH_CAMERA_TO_IVSC:
+	case ACE_SWITCH_CAMERA_TO_HOST:
+		memcpy(&ace->cmd_response, resp, len);
+		complete(&ace->cmd_completion);
+		break;
+	case ACE_GET_FW_ID:
+		break;
+	default:
+		break;
+	}
+}
+
+static void handle_command_ack(struct ace_notif *ack, int len)
+{
+	union ace_notif_hdr *hdr = &ack->hdr;
+
+	switch (hdr->ack.cmd_id) {
+	case ACE_GET_FW_ID:
+		ace->firmware_id = ack->cont.firmware_id;
+		fallthrough;
+	case ACE_SWITCH_CAMERA_TO_IVSC:
+	case ACE_SWITCH_CAMERA_TO_HOST:
+		memcpy(&ace->cmd_ack, ack, len);
+		complete(&ace->cmd_completion);
+		break;
+	default:
+		break;
+	}
+}
+
+/* callback for receive */
+static void mei_ace_rx(struct mei_cl_device *cldev)
+{
+	struct ace_notif event;
+	union ace_notif_hdr *hdr = &event.hdr;
+	int ret;
+
+	ret = mei_cldev_recv(cldev, (u8 *)&event, sizeof(event));
+	if (ret < 0) {
+		dev_err(&cldev->dev, "recv error: %d\n", ret);
+		return;
+	}
+
+	if (hdr->event.ack) {
+		handle_command_ack(&event, ret);
+		return;
+	}
+
+	switch (hdr->event.event_type) {
+	case ACE_CMD_RESPONSE:
+		handle_command_response(&event, ret);
+		break;
+	case ACE_FW_READY:
+		/*
+		 * firmware ready notification sent to driver
+		 * after HECI client connected with firmware.
+		 */
+		dev_dbg(&cldev->dev, "firmware ready\n");
+		break;
+	default:
+		break;
+	}
+}
+
+static int mei_ace_probe(struct mei_cl_device *cldev,
+			 const struct mei_cl_device_id *id)
+{
+	int ret;
+
+	mutex_lock(&ace_mutex);
+	/*
+	 * only instance is possible in the current hardware,
+	 * but adding protection for future hardware.
+	 */
+	if (ace) {
+		ret = -EBUSY;
+		goto err_unlock;
+	}
+
+	ace = kzalloc(sizeof(struct mei_ace), GFP_KERNEL);
+	if (!ace) {
+		ret = -ENOMEM;
+		goto err_unlock;
+	}
+
+	ace->cldev = cldev;
+	init_completion(&ace->cmd_completion);
+
+	mei_cldev_set_drvdata(cldev, ace);
+
+	ret = mei_cldev_enable(cldev);
+	if (ret < 0) {
+		dev_err(&cldev->dev, "mei_cldev_enable failed: %d\n", ret);
+		goto err_free;
+	}
+
+	ret = mei_cldev_register_rx_cb(cldev, mei_ace_rx);
+	if (ret) {
+		dev_err(&cldev->dev, "event cb registration failed: %d\n", ret);
+		goto err_disable;
+	}
+
+	ret = ace_get_firmware_id();
+	if (ret) {
+		dev_err(&cldev->dev, "get firmware id failed: %d\n", ret);
+		goto err_disable;
+	}
+	mutex_unlock(&ace_mutex);
+
+	return 0;
+
+err_disable:
+	mei_cldev_disable(cldev);
+
+err_free:
+	kfree(ace);
+	/* disable ace */
+	ace = NULL;
+
+err_unlock:
+	mutex_unlock(&ace_mutex);
+
+	return ret;
+}
+
+static void mei_ace_remove(struct mei_cl_device *cldev)
+{
+	mutex_lock(&ace_mutex);
+	/* disable mei ace client device */
+	mei_cldev_disable(cldev);
+
+	kfree(ace);
+	/* disable ace */
+	ace = NULL;
+	mutex_unlock(&ace_mutex);
+}
+
+#define MEI_ACE_UUID UUID_LE(0x5DB76CF6, 0x0A68, 0x4ED6, \
+			     0x9B, 0x78, 0x03, 0x61, 0x63, 0x5E, 0x24, 0x47)
+
+static const struct mei_cl_device_id mei_ace_tbl[] = {
+	{ MEI_ACE_DRIVER_NAME, MEI_ACE_UUID, MEI_CL_VERSION_ANY },
+
+	/* required last entry */
+	{ }
+};
+MODULE_DEVICE_TABLE(mei, mei_ace_tbl);
+
+static struct mei_cl_driver mei_ace_driver = {
+	.id_table = mei_ace_tbl,
+	.name = MEI_ACE_DRIVER_NAME,
+
+	.probe = mei_ace_probe,
+	.remove = mei_ace_remove,
+};
+
+module_mei_cl_driver(mei_ace_driver);
+
+MODULE_AUTHOR("Wentong Wu <wentong.wu@intel.com>");
+MODULE_AUTHOR("Zhifeng Wang <zhifeng.wang@intel.com>");
+MODULE_DESCRIPTION("Device driver for IVSC ACE");
+MODULE_LICENSE("GPL");
diff --git a/drivers/media/pci/intel/ivsc/mei_ace.h b/drivers/media/pci/intel/ivsc/mei_ace.h
new file mode 100644
index 000000000000..0302bc899521
--- /dev/null
+++ b/drivers/media/pci/intel/ivsc/mei_ace.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 Intel Corporation. All rights reserved.
+ * Intel Visual Sensing Controller ACE external interface
+ */
+
+#ifndef _MEI_ACE_H_
+#define _MEI_ACE_H_
+
+#include <linux/types.h>
+
+/* identify camera sensor ownership */
+enum ace_camera_owner {
+	ACE_CAMERA_IVSC,
+	ACE_CAMERA_HOST,
+};
+
+#if IS_ENABLED(CONFIG_INTEL_VSC)
+/*
+ * @brief set camera sensor ownership
+ *
+ * @param owner Camera sensor ownership being set
+ *
+ * @return 0 on success, negative on failure
+ */
+int ace_set_camera_owner(enum ace_camera_owner owner);
+
+#else
+static inline int ace_set_camera_owner(enum ace_camera_owner owner)
+{
+	return 0;
+}
+
+#endif
+
+#endif
-- 
2.25.1

