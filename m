Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3B0651623
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbiLSXBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbiLSXAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:00:43 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1777F15722;
        Mon, 19 Dec 2022 15:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1671490829; x=1703026829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tL1ifuv9Oa3tNXcZV7EKjufXoINaeEOIOswEBxHYgBE=;
  b=BnNHOdiQQJCqPdNcxCU7KTdaottSDnaH0iGFTUiFaHOwUJOOgHzuhMw+
   ez5Ky3tPSWmjmVX3V6SIPLTHtf6WPTrKktJ99xN7r7ialCXY74sEMek/T
   A9ij27uBPLkYx6pU+nPrtenoXaSkuytxbTRy8+OVccVny25dMnnVd5HJY
   w=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 Dec 2022 15:00:28 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 15:00:28 -0800
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 19 Dec 2022 15:00:28 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH v8 10/28] gunyah: rsc_mgr: Add resource manager RPC core
Date:   Mon, 19 Dec 2022 14:58:31 -0800
Message-ID: <20221219225850.2397345-11-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219225850.2397345-1-quic_eberman@quicinc.com>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resource manager is a special virtual machine which is always
running on a Gunyah system. It provides APIs for creating and destroying
VMs, secure memory management, sharing/lending of memory between VMs,
and setup of inter-VM communication. Calls to the resource manager are
made via message queues.

This patch implements the basic probing and RPC mechanism to make those
API calls. Request/response calls can be made with gh_rm_call.
Drivers can also register to notifications pushed by RM via
gh_rm_register_notifier

Specific API calls that resource manager supports will be implemented in
subsequent patches.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 MAINTAINERS                    |   2 +-
 drivers/virt/gunyah/Kconfig    |  14 +
 drivers/virt/gunyah/Makefile   |   3 +
 drivers/virt/gunyah/rsc_mgr.c  | 584 +++++++++++++++++++++++++++++++++
 drivers/virt/gunyah/rsc_mgr.h  |  36 ++
 include/linux/gunyah_rsc_mgr.h |  18 +
 6 files changed, 656 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/gunyah/rsc_mgr.c
 create mode 100644 drivers/virt/gunyah/rsc_mgr.h
 create mode 100644 include/linux/gunyah_rsc_mgr.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 667480bfd387..bb315385e155 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8944,7 +8944,7 @@ F:	Documentation/virt/gunyah/
 F:	arch/arm64/gunyah/
 F:	drivers/mailbox/gunyah-msgq.c
 F:	drivers/virt/gunyah/
-F:	include/linux/gunyah.h
+F:	include/linux/gunyah*.h
 
 HABANALABS PCI DRIVER
 M:	Oded Gabbay <ogabbay@kernel.org>
diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
index 127156a678a6..4a6189dedab2 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -10,3 +10,17 @@ config GUNYAH
 
 	  Say Y/M here to enable the drivers needed to interact in a Gunyah
 	  virtual environment.
+
+if GUNYAH
+config GUNYAH_RESOURCE_MANAGER
+	tristate "Gunyah Resource Manager"
+	depends on MAILBOX
+	select GUNYAH_MESSAGE_QUEUES
+	help
+	  The resource manager (RM) is a privileged application VM supporting
+	  the Gunyah Hypervisor. Enable this driver to support communicating
+	  with Gunyah RM. This is typically required for a VM running under
+	  Gunyah wanting to have Gunyah-awareness.
+
+	  Say Y/M here if unsure.
+endif
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index 2ac4ee64b89d..e7cf59b9e64e 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1 +1,4 @@
 obj-$(CONFIG_GUNYAH) += gunyah.o
+
+gunyah_rsc_mgr-y += rsc_mgr.o
+obj-$(CONFIG_GUNYAH_RESOURCE_MANAGER) += gunyah_rsc_mgr.o
diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
new file mode 100644
index 000000000000..6b281576f5af
--- /dev/null
+++ b/drivers/virt/gunyah/rsc_mgr.c
@@ -0,0 +1,584 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/sched.h>
+#include <linux/gunyah.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/kthread.h>
+#include <linux/notifier.h>
+#include <linux/workqueue.h>
+#include <linux/completion.h>
+#include <linux/gunyah_rsc_mgr.h>
+#include <linux/platform_device.h>
+
+#include "rsc_mgr.h"
+
+/* Resource Manager Header */
+struct gh_rm_rpc_hdr {
+#define RM_RPC_HDR_VERSION_ONE		0x1
+#define RM_RPC_API_VERSION_MASK		GENMASK(3, 0)
+
+#define RM_RPC_HDR_WORDS		0x2
+#define RM_RPC_HEADER_WORDS_MASK	GENMASK(7, 4)
+	u8 api;
+
+#define RM_RPC_TYPE_CONT		0x0
+#define RM_RPC_TYPE_REQ		0x1
+#define RM_RPC_TYPE_RPLY		0x2
+#define RM_RPC_TYPE_NOTIF		0x3
+#define RM_RPC_TYPE_MASK		GENMASK(1, 0)
+
+#define GH_RM_MAX_NUM_FRAGMENTS		62
+#define RM_RPC_FRAGMENTS_MASK		GENMASK(7, 2)
+	u8 type;
+	__le16 seq;
+	__le32 msg_id;
+} __packed;
+
+/* Standard reply header */
+struct gh_rm_rpc_reply_hdr {
+	struct gh_rm_rpc_hdr rpc_hdr;
+	u32 err_code;
+} __packed;
+
+#define GH_RM_MAX_MSG_SIZE	(GH_MSGQ_MAX_MSG_SIZE - sizeof(struct gh_rm_rpc_hdr))
+
+/**
+ * struct gh_rm_connection - Represents a complete message from resource manager
+ * @payload: Combined payload of all the fragments (msg headers stripped off).
+ * @size: Size of the payload.
+ * @ret: Linux return code, set in case there was an error processing connection
+ * @msg_id: Message ID from the header.
+ * @type: RM_RPC_TYPE_RPLY or RM_RPC_TYPE_NOTIF.
+ * @num_fragments: total number of fragments expected to be received.
+ * @fragments_received: fragments received so far.
+ * @rm_error: For request/reply sequences with standard replies.
+ * @seq: Sequence ID for the main message.
+ * @seq_done: Signals caller that the RM reply has been received
+ */
+struct gh_rm_connection {
+	void *payload;
+	size_t size;
+	int ret;
+	u32 msg_id;
+	u8 type;
+
+	u8 num_fragments;
+	u8 fragments_received;
+
+	/* only for req/reply sequence */
+	u32 rm_error;
+	u16 seq;
+	struct completion seq_done;
+};
+
+struct gh_rm_notif_complete {
+	struct gh_rm_connection *conn;
+	struct work_struct work;
+};
+
+struct gh_rm_rpc {
+	struct device *dev;
+	struct gunyah_resource tx_ghrsc, rx_ghrsc;
+	struct gh_msgq msgq;
+	struct mbox_client msgq_client;
+	struct gh_rm_connection *active_rx_connection;
+	int last_tx_ret;
+
+	struct idr call_idr;
+	struct mutex call_idr_lock;
+
+	struct mutex send_lock;
+
+	struct work_struct recv_work;
+};
+
+static struct gh_rm_connection *gh_rm_alloc_connection(u32 msg_id, u8 type)
+{
+	struct gh_rm_connection *connection;
+
+	connection = kzalloc(sizeof(*connection), GFP_KERNEL);
+	if (!connection)
+		return NULL;
+
+	connection->type = type;
+	connection->msg_id = msg_id;
+
+	return connection;
+}
+
+static int gh_rm_init_connection_payload(struct gh_rm_connection *connection, void *msg,
+					size_t hdr_size, size_t msg_size)
+{
+	struct gh_rm_rpc_hdr *hdr = msg;
+	size_t max_buf_size, payload_size;
+
+	if (hdr_size > msg_size)
+		return -EINVAL;
+
+	payload_size = msg_size - hdr_size;
+
+	connection->num_fragments = FIELD_GET(RM_RPC_FRAGMENTS_MASK, hdr->type);
+	connection->fragments_received = 0;
+
+	/* There's not going to be any payload, no need to allocate buffer. */
+	if (!payload_size && !connection->num_fragments)
+		return 0;
+
+	/*
+	 * maximum payload size is GH_MSGQ_MAX_MSG_SIZE - hdr_size
+	 * and can received (hdr->fragments + 1) of those
+	 */
+	max_buf_size = (GH_MSGQ_MAX_MSG_SIZE - hdr_size) * (connection->num_fragments + 1);
+
+	connection->payload = kzalloc(max_buf_size, GFP_KERNEL);
+	if (!connection->payload)
+		return -ENOMEM;
+
+	memcpy(connection->payload, msg + hdr_size, payload_size);
+	connection->size = payload_size;
+	return 0;
+}
+
+static void gh_rm_notif_work(struct work_struct *work)
+{
+	struct gh_rm_notif_complete *notif = container_of(work, struct gh_rm_notif_complete, work);
+	struct gh_rm_connection *connection = notif->conn;
+
+	/* No users of notifications, yet. */
+
+	kfree(connection->payload);
+	kfree(connection);
+	kfree(notif);
+}
+
+static struct gh_rm_connection *gh_rm_process_notif(struct gh_rm_rpc *rsc_mgr,
+						    void *msg, size_t msg_size)
+{
+	struct gh_rm_rpc_hdr *hdr = msg;
+	struct gh_rm_connection *connection;
+
+	connection = gh_rm_alloc_connection(le32_to_cpu(hdr->msg_id),
+						FIELD_GET(RM_RPC_TYPE_MASK, hdr->type));
+	if (!connection) {
+		dev_err(rsc_mgr->dev, "Failed to alloc connection for notification, dropping.\n");
+		return NULL;
+	}
+
+	if (gh_rm_init_connection_payload(connection, msg, sizeof(*hdr), msg_size)) {
+		dev_err(rsc_mgr->dev, "Failed to alloc connection buffer for notification, dropping.\n");
+		kfree(connection);
+		return NULL;
+	}
+
+	return connection;
+}
+
+static struct gh_rm_connection *gh_rm_process_rply(struct gh_rm_rpc *rsc_mgr,
+						   void *msg, size_t msg_size)
+{
+	struct gh_rm_rpc_reply_hdr *reply_hdr = msg;
+	struct gh_rm_rpc_hdr *hdr = msg;
+	struct gh_rm_connection *connection;
+	u16 seq_id = le16_to_cpu(hdr->seq);
+
+	if (mutex_lock_interruptible(&rsc_mgr->call_idr_lock))
+		return ERR_PTR(-ERESTARTSYS);
+
+	connection = idr_find(&rsc_mgr->call_idr, seq_id);
+	mutex_unlock(&rsc_mgr->call_idr_lock);
+
+	if (!connection) {
+		dev_err(rsc_mgr->dev, "Failed to find connection for sequence %u\n", seq_id);
+		return NULL;
+	}
+	if (connection->msg_id != le32_to_cpu(hdr->msg_id)) {
+		dev_err(rsc_mgr->dev, "Reply for sequence %u expected msg_id: %x but got %x\n",
+			seq_id, connection->msg_id, le32_to_cpu(hdr->msg_id));
+		/*
+		 * Don't complete connection and error the client, maybe
+		 * resource manager will send us the expected reply sequence soon.
+		 */
+		return NULL;
+	}
+
+	if (gh_rm_init_connection_payload(connection, msg, sizeof(*reply_hdr), msg_size)) {
+		dev_err(rsc_mgr->dev, "Failed to alloc connection buffer for sequence %d\n",
+			seq_id);
+		/* Send connection complete and error the client. */
+		connection->ret = -ENOMEM;
+		complete(&connection->seq_done);
+		return NULL;
+	}
+
+	connection->rm_error = reply_hdr->err_code;
+	return connection;
+}
+
+static void gh_rm_process_cont(struct gh_rm_rpc *rsc_mgr, struct gh_rm_connection *connection,
+				void *msg, size_t msg_size)
+{
+	struct gh_rm_rpc_hdr *hdr = msg;
+	size_t payload_size = msg_size - sizeof(*hdr);
+
+	/*
+	 * hdr->fragments and hdr->msg_id preserves the value from first reply
+	 * or notif message. To detect mishandling, check it's still intact.
+	 */
+	if (connection->msg_id != le32_to_cpu(hdr->msg_id))
+		dev_err(rsc_mgr->dev, "Appending mismatched continuation with id %d to connection with id %d\n",
+			le32_to_cpu(hdr->msg_id), connection->msg_id);
+	if (connection->num_fragments != FIELD_GET(RM_RPC_FRAGMENTS_MASK, hdr->type))
+		dev_err(rsc_mgr->dev, "Number of fragments mismatch for seq: %d\n",
+			le16_to_cpu(hdr->seq));
+
+	memcpy(connection->payload + connection->size, msg + sizeof(*hdr), payload_size);
+	connection->size += payload_size;
+	connection->fragments_received++;
+}
+
+static bool gh_rm_complete_connection(struct gh_rm_rpc *rsc_mgr,
+					struct gh_rm_connection *connection)
+{
+	struct gh_rm_notif_complete *notif_work;
+
+	if (!connection)
+		return false;
+
+	if (connection->fragments_received != connection->num_fragments)
+		return false;
+
+	switch (connection->type) {
+	case RM_RPC_TYPE_RPLY:
+		complete(&connection->seq_done);
+		break;
+	case RM_RPC_TYPE_NOTIF:
+		notif_work = kzalloc(sizeof(*notif_work), GFP_KERNEL);
+		if (notif_work == NULL)
+			break;
+
+		notif_work->conn = connection;
+		INIT_WORK(&notif_work->work, gh_rm_notif_work);
+
+		schedule_work(&notif_work->work);
+		break;
+	default:
+		dev_err(rsc_mgr->dev, "Invalid message type (%d) received\n", connection->type);
+		break;
+	}
+
+	return true;
+}
+
+static void gh_rm_abort_connection(struct gh_rm_connection *connection)
+{
+	switch (connection->type) {
+	case RM_RPC_TYPE_RPLY:
+		connection->ret = -EIO;
+		complete(&connection->seq_done);
+		break;
+	case RM_RPC_TYPE_NOTIF:
+		fallthrough;
+	default:
+		kfree(connection->payload);
+		kfree(connection);
+	}
+}
+
+static void gh_rm_msgq_rx_data(struct mbox_client *cl, void *mssg)
+{
+	struct gh_rm_rpc *rsc_mgr = container_of(cl, struct gh_rm_rpc, msgq_client);
+	struct gh_msgq_rx_data *rx_data = mssg;
+	void *msg = rx_data->data;
+	size_t msg_size = rx_data->length;
+	struct gh_rm_rpc_hdr *hdr;
+
+	if (msg_size <= sizeof(struct gh_rm_rpc_hdr)) {
+		dev_err(rsc_mgr->dev, "Incomplete message size: %ld is too small\n", msg_size);
+		return;
+	}
+
+	hdr = msg;
+	switch (FIELD_GET(RM_RPC_TYPE_MASK, hdr->type)) {
+	case RM_RPC_TYPE_NOTIF:
+		if (rsc_mgr->active_rx_connection) {
+			/* Not possible per protocol. Do something better than BUG_ON */
+			dev_err(rsc_mgr->dev, "Received start of new notification without finishing existing message series.\n");
+			gh_rm_abort_connection(rsc_mgr->active_rx_connection);
+		}
+		rsc_mgr->active_rx_connection = gh_rm_process_notif(rsc_mgr, msg, msg_size);
+		break;
+	case RM_RPC_TYPE_RPLY:
+		if (rsc_mgr->active_rx_connection) {
+			/* Not possible per protocol. Do something better than BUG_ON */
+			dev_err(rsc_mgr->dev, "Received start of new reply without finishing existing message series.\n");
+			gh_rm_abort_connection(rsc_mgr->active_rx_connection);
+		}
+		rsc_mgr->active_rx_connection = gh_rm_process_rply(rsc_mgr, msg, msg_size);
+		break;
+	case RM_RPC_TYPE_CONT:
+		if (!rsc_mgr->active_rx_connection) {
+			dev_err(rsc_mgr->dev, "Received a continuation message without receiving initial message\n");
+			break;
+		}
+		gh_rm_process_cont(rsc_mgr, rsc_mgr->active_rx_connection, msg, msg_size);
+		break;
+	default:
+		dev_err(rsc_mgr->dev, "Invalid message type (%lu) received\n",
+			FIELD_GET(RM_RPC_TYPE_MASK, hdr->type));
+		return;
+	}
+
+	if (gh_rm_complete_connection(rsc_mgr, rsc_mgr->active_rx_connection))
+		rsc_mgr->active_rx_connection = NULL;
+}
+
+static void gh_rm_msgq_tx_done(struct mbox_client *cl, void *mssg, int r)
+{
+	struct gh_rm_rpc *rsc_mgr = container_of(cl, struct gh_rm_rpc, msgq_client);
+
+	kfree(mssg);
+	rsc_mgr->last_tx_ret = r;
+}
+
+static int gh_rm_send_request(struct gh_rm_rpc *rsc_mgr, u32 message_id,
+			      const void *req_buff, size_t req_buff_size,
+			      struct gh_rm_connection *connection)
+{
+	size_t buff_size_remaining = req_buff_size;
+	const void *req_buff_curr = req_buff;
+	struct gh_rm_rpc_hdr *hdr;
+	u32 cont_fragments = 0;
+	size_t payload_size;
+	struct gh_msgq_tx_data *msg;
+	int i, ret;
+
+	if (req_buff_size)
+		cont_fragments = (req_buff_size - 1) / GH_RM_MAX_MSG_SIZE;
+
+	if (WARN(cont_fragments > GH_RM_MAX_NUM_FRAGMENTS,
+		 "Limit exceeded for the number of fragments: %u\n", cont_fragments))
+		return -E2BIG;
+
+	ret = mutex_lock_interruptible(&rsc_mgr->send_lock);
+	if (ret)
+		return ret;
+
+	/* Consider also the 'request' packet for the loop count */
+	for (i = 0; i <= cont_fragments; i++) {
+		if (buff_size_remaining > GH_RM_MAX_MSG_SIZE) {
+			payload_size = GH_RM_MAX_MSG_SIZE;
+			buff_size_remaining -= payload_size;
+		} else {
+			payload_size = buff_size_remaining;
+		}
+
+		msg = kzalloc(sizeof(*msg) + GH_MSGQ_MAX_MSG_SIZE, GFP_KERNEL);
+		if (!msg) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		/* Fill header */
+		hdr = (struct gh_rm_rpc_hdr *)msg->data;
+		hdr->api = FIELD_PREP(RM_RPC_API_VERSION_MASK, RM_RPC_HDR_VERSION_ONE) |
+				FIELD_PREP(RM_RPC_HEADER_WORDS_MASK, RM_RPC_HDR_WORDS);
+		hdr->type = FIELD_PREP(RM_RPC_TYPE_MASK,
+					i == 0 ? RM_RPC_TYPE_REQ : RM_RPC_TYPE_CONT) |
+				FIELD_PREP(RM_RPC_FRAGMENTS_MASK, cont_fragments);
+		hdr->seq = cpu_to_le16(connection->seq);
+		hdr->msg_id = cpu_to_le32(message_id);
+
+		/* Copy payload */
+		memcpy(msg->data + sizeof(*hdr), req_buff_curr, payload_size);
+		req_buff_curr += payload_size;
+
+		/* Force the last fragment to immediately alert the receiver */
+		msg->push = i == cont_fragments;
+		msg->length = sizeof(*hdr) + payload_size;
+
+		ret = mbox_send_message(gh_msgq_chan(&rsc_mgr->msgq), msg);
+		if (ret < 0) {
+			kfree(msg);
+			break;
+		}
+
+		if (rsc_mgr->last_tx_ret) {
+			ret = rsc_mgr->last_tx_ret;
+			break;
+		}
+	}
+
+out:
+	mutex_unlock(&rsc_mgr->send_lock);
+	return ret < 0 ? ret : 0;
+}
+
+/**
+ * gh_rm_call: Achieve request-response type communication with RPC
+ * @message_id: The RM RPC message-id
+ * @req_buff: Request buffer that contains the payload
+ * @req_buff_size: Total size of the payload
+ * @resp_buf: Pointer to a response buffer
+ * @resp_buff_size: Size of the response buffer
+ *
+ * Make a request to the RM-VM and wait for reply back. For a successful
+ * response, the function returns the payload. The size of the payload is set in
+ * resp_buff_size. The resp_buf should be freed by the caller.
+ *
+ * Context: Process context. Will sleep waiting for reply.
+ * Return: >0 is standard reply error from RM. <0 on internal error.
+ */
+int gh_rm_call(struct gh_rm_rpc *rsc_mgr, u32 message_id, void *req_buff, size_t req_buff_size,
+		void **resp_buf, size_t *resp_buff_size)
+{
+	struct gh_rm_connection *connection;
+	int ret;
+
+	/* messaged_id 0 is reserved */
+	if (!message_id)
+		return -EINVAL;
+
+	if (!rsc_mgr)
+		return -EPROBE_DEFER;
+
+	connection = gh_rm_alloc_connection(message_id, RM_RPC_TYPE_RPLY);
+	if (!connection)
+		return -ENOMEM;
+
+	init_completion(&connection->seq_done);
+
+	/* Allocate a new seq number for this connection */
+	if (mutex_lock_interruptible(&rsc_mgr->call_idr_lock)) {
+		kfree(connection);
+		return -ERESTARTSYS;
+	}
+	connection->seq = idr_alloc_cyclic(&rsc_mgr->call_idr, connection, 0, U16_MAX, GFP_KERNEL);
+	mutex_unlock(&rsc_mgr->call_idr_lock);
+
+	/* Send the request to the Resource Manager */
+	ret = gh_rm_send_request(rsc_mgr, message_id, req_buff, req_buff_size, connection);
+	if (ret < 0)
+		goto out;
+
+	/* Wait for response */
+	ret = wait_for_completion_interruptible(&connection->seq_done);
+	if (ret)
+		goto out;
+
+	if (connection->ret) {
+		ret = connection->ret;
+		kfree(connection->payload);
+		goto out;
+	}
+
+	if (connection->rm_error) {
+		ret = connection->rm_error;
+		kfree(connection->payload);
+		goto out;
+	}
+
+	*resp_buf = connection->payload;
+	*resp_buff_size = connection->size;
+
+out:
+	mutex_lock(&rsc_mgr->call_idr_lock);
+	idr_remove(&rsc_mgr->call_idr, connection->seq);
+	mutex_unlock(&rsc_mgr->call_idr_lock);
+
+	kfree(connection);
+	return ret;
+}
+
+static int gh_msgq_platform_probe_direction(struct platform_device *pdev,
+					u8 gh_type, int idx, struct gunyah_resource *ghrsc)
+{
+	int ret;
+	struct device_node *node = pdev->dev.of_node;
+
+	ghrsc->type = gh_type;
+
+	ghrsc->irq = platform_get_irq(pdev, idx);
+	if (ghrsc->irq < 0) {
+		dev_err(&pdev->dev, "Failed to get irq%d: %d\n", idx, ghrsc->irq);
+		return ghrsc->irq;
+	}
+
+	ret = of_property_read_u64_index(node, "reg", idx, &ghrsc->capid);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to get capid%d: %d\n", idx, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int gh_rm_drv_probe(struct platform_device *pdev)
+{
+	struct gh_rm_rpc *rsc_mgr;
+	int ret;
+
+	rsc_mgr = devm_kzalloc(&pdev->dev, sizeof(*rsc_mgr), GFP_KERNEL);
+	if (!rsc_mgr)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, rsc_mgr);
+	rsc_mgr->dev = &pdev->dev;
+
+	mutex_init(&rsc_mgr->call_idr_lock);
+	idr_init(&rsc_mgr->call_idr);
+	mutex_init(&rsc_mgr->send_lock);
+
+	ret = gh_msgq_platform_probe_direction(pdev, GUNYAH_RESOURCE_TYPE_MSGQ_TX, 0,
+						&rsc_mgr->tx_ghrsc);
+	if (ret)
+		return ret;
+
+	ret = gh_msgq_platform_probe_direction(pdev, GUNYAH_RESOURCE_TYPE_MSGQ_RX, 1,
+						&rsc_mgr->rx_ghrsc);
+	if (ret)
+		return ret;
+
+	rsc_mgr->msgq_client.dev = &pdev->dev;
+	rsc_mgr->msgq_client.tx_block = true;
+	rsc_mgr->msgq_client.rx_callback = gh_rm_msgq_rx_data;
+	rsc_mgr->msgq_client.tx_done = gh_rm_msgq_tx_done;
+
+	return gh_msgq_init(&pdev->dev, &rsc_mgr->msgq, &rsc_mgr->msgq_client,
+				&rsc_mgr->tx_ghrsc, &rsc_mgr->rx_ghrsc);
+}
+
+static int gh_rm_drv_remove(struct platform_device *pdev)
+{
+	struct gh_rm_rpc *rm = platform_get_drvdata(pdev);
+
+	mbox_free_channel(gh_msgq_chan(&rm->msgq));
+	gh_msgq_remove(&rm->msgq);
+
+	return 0;
+}
+
+static const struct of_device_id gh_rm_of_match[] = {
+	{ .compatible = "gunyah-resource-manager" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, gh_rm_of_match);
+
+static struct platform_driver gh_rm_driver = {
+	.probe = gh_rm_drv_probe,
+	.remove = gh_rm_drv_remove,
+	.driver = {
+		.name = "gh_rsc_mgr",
+		.of_match_table = gh_rm_of_match,
+	},
+};
+module_platform_driver(gh_rm_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Gunyah Resource Manager Driver");
diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
new file mode 100644
index 000000000000..b5bb36a7a4cc
--- /dev/null
+++ b/drivers/virt/gunyah/rsc_mgr.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef __GH_RSC_MGR_PRIV_H
+#define __GH_RSC_MGR_PRIV_H
+
+#include <linux/gunyah.h>
+#include <linux/types.h>
+
+/* RM Error codes */
+#define GH_RM_ERROR_OK			0x0
+#define GH_RM_ERROR_UNIMPLEMENTED	0xFFFFFFFF
+#define GH_RM_ERROR_NOMEM		0x1
+#define GH_RM_ERROR_NORESOURCE		0x2
+#define GH_RM_ERROR_DENIED		0x3
+#define GH_RM_ERROR_INVALID		0x4
+#define GH_RM_ERROR_BUSY		0x5
+#define GH_RM_ERROR_ARGUMENT_INVALID	0x6
+#define GH_RM_ERROR_HANDLE_INVALID	0x7
+#define GH_RM_ERROR_VALIDATE_FAILED	0x8
+#define GH_RM_ERROR_MAP_FAILED		0x9
+#define GH_RM_ERROR_MEM_INVALID		0xA
+#define GH_RM_ERROR_MEM_INUSE		0xB
+#define GH_RM_ERROR_MEM_RELEASED	0xC
+#define GH_RM_ERROR_VMID_INVALID	0xD
+#define GH_RM_ERROR_LOOKUP_FAILED	0xE
+#define GH_RM_ERROR_IRQ_INVALID		0xF
+#define GH_RM_ERROR_IRQ_INUSE		0x10
+#define GH_RM_ERROR_IRQ_RELEASED	0x11
+
+struct gh_rm_rpc;
+int gh_rm_call(struct gh_rm_rpc *rsc_mgr, u32 message_id, void *req_buff, size_t req_buff_size,
+		void **resp_buf, size_t *resp_buff_size);
+
+#endif
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
new file mode 100644
index 000000000000..b4f55c19954b
--- /dev/null
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _GUNYAH_RSC_MGR_H
+#define _GUNYAH_RSC_MGR_H
+
+#include <linux/list.h>
+#include <linux/notifier.h>
+#include <linux/gunyah.h>
+
+#define GH_VMID_INVAL	U16_MAX
+
+/* Gunyah recognizes VMID0 as an alias to the current VM's ID */
+#define GH_VMID_SELF			0
+
+#endif
-- 
2.25.1

