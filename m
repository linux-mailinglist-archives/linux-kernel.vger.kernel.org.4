Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1D667608E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjATWsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjATWsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:48:31 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A62A66FA0;
        Fri, 20 Jan 2023 14:48:08 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KMZXXu022939;
        Fri, 20 Jan 2023 22:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=4X74yKIrLrqF+b1pUTzOb8tH+X7zRbJn3cEBM2UgYuE=;
 b=InuzS6CStbayoHiw4f18cxVgHS0Lz/MHEDamS115sQ2xm05/HwG3ltC6efVD4jVcbL/7
 nNjP/2twik6Wc2G4n/ttamgRTe7RA9OQ7hE4HFRdLCLPgau8nf1sBvsqYYC3LjYrC/4h
 dBJ7lJMJcVN43Ls+Q2b1+g0C6DTmrMjbLSWd+Ghc6rTsFB/VBOujW1a0DKeJ0iMeRNQd
 Zki5VR7Jrkt8st8CmSeifnKje0e7/5JSGw+3x5O6hwhM47Mjd/fPqXfdHkhZ6ouBL6eY
 1bxqHp1db+ktGgehHuGQ+f7Q9tTi9epwJdhsfmUtMJ/bBuPhBd6qXMoqrtZhkRytn3Nr 3w== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n7yc60gh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:47:43 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KMlhDB027197
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:47:43 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 14:47:42 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v9 09/27] gunyah: rsc_mgr: Add resource manager RPC core
Date:   Fri, 20 Jan 2023 14:46:08 -0800
Message-ID: <20230120224627.4053418-10-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120224627.4053418-1-quic_eberman@quicinc.com>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Yaarz7o1gMZecAiR7JQ4DD_2dcT_0Cjn
X-Proofpoint-ORIG-GUID: Yaarz7o1gMZecAiR7JQ4DD_2dcT_0Cjn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_11,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200218
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
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
 drivers/virt/gunyah/Kconfig    |   1 -
 drivers/virt/gunyah/Makefile   |   3 +
 drivers/virt/gunyah/rsc_mgr.c  | 616 +++++++++++++++++++++++++++++++++
 drivers/virt/gunyah/rsc_mgr.h  |  71 ++++
 include/linux/gunyah.h         |   3 +-
 include/linux/gunyah_rsc_mgr.h |  18 +
 7 files changed, 710 insertions(+), 4 deletions(-)
 create mode 100644 drivers/virt/gunyah/rsc_mgr.c
 create mode 100644 drivers/virt/gunyah/rsc_mgr.h
 create mode 100644 include/linux/gunyah_rsc_mgr.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d02e8abe6457..7ab1462577cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9051,7 +9051,7 @@ F:	Documentation/virt/gunyah/
 F:	arch/arm64/gunyah/
 F:	drivers/mailbox/gunyah-msgq.c
 F:	drivers/virt/gunyah/
-F:	include/linux/gunyah.h
+F:	include/linux/gunyah*.h
 
 HABANALABS PCI DRIVER
 M:	Oded Gabbay <ogabbay@kernel.org>
diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
index 71c38845bcea..1a737694c333 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -4,7 +4,6 @@ config GUNYAH
 	tristate "Gunyah Virtualization drivers"
 	depends on ARM64
 	depends on MAILBOX
-	select GUNYAH_PLATFORM_HOOKS
 	help
 	  The Gunyah drivers are the helper interfaces that run in a guest VM
 	  such as basic inter-VM IPC and signaling mechanisms, and higher level
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index 34f32110faf9..cc864ff5abbb 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1,3 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_GUNYAH) += gunyah.o
+
+gunyah_rsc_mgr-y += rsc_mgr.o
+obj-$(CONFIG_GUNYAH) += gunyah_rsc_mgr.o
diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
new file mode 100644
index 000000000000..382f9943fd31
--- /dev/null
+++ b/drivers/virt/gunyah/rsc_mgr.c
@@ -0,0 +1,616 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
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
+#define RM_RPC_API_VERSION_MASK		GENMASK(3, 0)
+#define RM_RPC_HEADER_WORDS_MASK	GENMASK(7, 4)
+#define RM_RPC_API_VERSION		FIELD_PREP(RM_RPC_API_VERSION_MASK, 1)
+#define RM_RPC_HEADER_WORDS		FIELD_PREP(RM_RPC_HEADER_WORDS_MASK, \
+						(sizeof(struct gh_rm_rpc_hdr) / sizeof(u32)))
+#define RM_RPC_API			(RM_RPC_API_VERSION | RM_RPC_HEADER_WORDS)
+
+#define RM_RPC_TYPE_CONTINUATION	0x0
+#define RM_RPC_TYPE_REQUEST		0x1
+#define RM_RPC_TYPE_REPLY		0x2
+#define RM_RPC_TYPE_NOTIF		0x3
+#define RM_RPC_TYPE_MASK		GENMASK(1, 0)
+
+#define GH_RM_MAX_NUM_FRAGMENTS		62
+#define RM_RPC_FRAGMENTS_MASK		GENMASK(7, 2)
+
+struct gh_rm_rpc_hdr {
+	u8 api;
+	u8 type;
+	__le16 seq;
+	__le32 msg_id;
+} __packed;
+
+struct gh_rm_rpc_reply_hdr {
+	struct gh_rm_rpc_hdr rpc_hdr;
+	__le32 err_code; /* GH_RM_ERROR_* */
+} __packed;
+
+#define GH_RM_MAX_MSG_SIZE	(GH_MSGQ_MAX_MSG_SIZE - sizeof(struct gh_rm_rpc_hdr))
+
+/**
+ * struct gh_rm_connection - Represents a complete message from resource manager
+ * @payload: Combined payload of all the fragments (msg headers stripped off).
+ * @size: Size of the payload received so far.
+ * @ret: Linux return code, set in case there was an error processing connection
+ * @msg_id: Message ID from the header.
+ * @type: RM_RPC_TYPE_REPLY or RM_RPC_TYPE_NOTIF.
+ * @num_fragments: total number of fragments expected to be received.
+ * @fragments_received: fragments received so far.
+ * @rm_error: For request/reply sequences with standard replies.
+ * @seq: Sequence ID for the main message.
+ * @seq_done: Signals caller that the RM reply has been received
+ */
+struct gh_rm_connection {
+	void *payload;
+	size_t size;
+	__le32 msg_id;
+	u8 type;
+
+	u8 num_fragments;
+	u8 fragments_received;
+
+	union {
+		struct {
+			/* only for req/reply sequence */
+			int ret;
+			u16 seq;
+			u32 rm_error; /* GH_RM_ERROR_* */
+			struct completion seq_done;
+		} reply;
+
+		struct {
+			struct work_struct work;
+		} notification;
+	};
+};
+
+struct gh_rm_notif_complete {
+	struct gh_rm_connection *conn;
+	struct work_struct work;
+};
+
+struct gh_rm {
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
+	struct kmem_cache *cache;
+	struct mutex send_lock;
+
+	struct work_struct recv_work;
+};
+
+static struct gh_rm_connection *gh_rm_alloc_connection(__le32 msg_id, u8 type)
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
+	if (connection->num_fragments > GH_RM_MAX_NUM_FRAGMENTS)
+		return -EINVAL;
+
+	max_buf_size = payload_size + (connection->num_fragments * GH_RM_MAX_MSG_SIZE);
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
+	struct gh_rm_connection *connection = container_of(work, struct gh_rm_connection,
+								notification.work);
+
+	/* No users of notifications, yet. */
+
+	kfree(connection->payload);
+	kfree(connection);
+}
+
+static struct gh_rm_connection *gh_rm_process_notif(struct gh_rm *rm, void *msg, size_t msg_size)
+{
+	struct gh_rm_rpc_hdr *hdr = msg;
+	struct gh_rm_connection *connection;
+	int ret;
+
+	connection = gh_rm_alloc_connection(hdr->msg_id, RM_RPC_TYPE_NOTIF);
+	if (!connection) {
+		dev_err(rm->dev, "Failed to alloc connection for notification, dropping.\n");
+		return NULL;
+	}
+
+	INIT_WORK(&connection->notification.work, gh_rm_notif_work);
+
+	ret = gh_rm_init_connection_payload(connection, msg, sizeof(*hdr), msg_size);
+	if (ret) {
+		dev_err(rm->dev, "Failed to initialize connection buffer for notification: %d\n",
+			ret);
+		kfree(connection);
+		return NULL;
+	}
+
+	return connection;
+}
+
+static struct gh_rm_connection *gh_rm_process_rply(struct gh_rm *rm, void *msg, size_t msg_size)
+{
+	struct gh_rm_rpc_reply_hdr *reply_hdr = msg;
+	struct gh_rm_rpc_hdr *hdr = &reply_hdr->rpc_hdr;
+	struct gh_rm_connection *connection;
+	u16 seq_id = le16_to_cpu(hdr->seq);
+
+	mutex_lock(&rm->call_idr_lock);
+	connection = idr_find(&rm->call_idr, seq_id);
+	mutex_unlock(&rm->call_idr_lock);
+
+	if (!connection) {
+		dev_err(rm->dev, "Failed to find connection for sequence %u\n", seq_id);
+		return NULL;
+	}
+	if (connection->msg_id != hdr->msg_id) {
+		dev_err(rm->dev, "Reply for sequence %u expected msg_id: %x but got %x\n",
+			seq_id, le32_to_cpu(connection->msg_id), le32_to_cpu(hdr->msg_id));
+		/*
+		 * Don't complete connection and error the client, maybe
+		 * resource manager will send us the expected reply sequence soon.
+		 */
+		return NULL;
+	}
+
+	if (gh_rm_init_connection_payload(connection, msg, sizeof(*reply_hdr), msg_size)) {
+		dev_err(rm->dev, "Failed to alloc connection buffer for sequence %d\n", seq_id);
+		/* Send connection complete and error the client. */
+		connection->reply.ret = -ENOMEM;
+		complete(&connection->reply.seq_done);
+		return NULL;
+	}
+
+	connection->reply.rm_error = le32_to_cpu(reply_hdr->err_code);
+	return connection;
+}
+
+static int gh_rm_process_cont(struct gh_rm *rm, struct gh_rm_connection *connection,
+				void *msg, size_t msg_size)
+{
+	struct gh_rm_rpc_hdr *hdr = msg;
+	size_t payload_size = msg_size - sizeof(*hdr);
+
+	/*
+	 * hdr->fragments and hdr->msg_id preserves the value from first reply
+	 * or notif message. To detect mishandling, check it's still intact.
+	 */
+	if (connection->msg_id != hdr->msg_id) {
+		dev_err(rm->dev, "Appending mismatched continuation with id %d to connection with id %d\n",
+			le32_to_cpu(hdr->msg_id), le32_to_cpu(connection->msg_id));
+		return -EINVAL;
+	}
+	if (connection->num_fragments != FIELD_GET(RM_RPC_FRAGMENTS_MASK, hdr->type)) {
+		dev_err(rm->dev, "Number of fragments mismatch for message %x\n",
+			le32_to_cpu(hdr->msg_id));
+		return -EINVAL;
+	}
+
+	memcpy(connection->payload + connection->size, msg + sizeof(*hdr), payload_size);
+	connection->size += payload_size;
+	connection->fragments_received++;
+	return 0;
+}
+
+static bool gh_rm_complete_connection(struct gh_rm *rm, struct gh_rm_connection *connection)
+{
+	if (!connection)
+		return false;
+
+	if (connection->fragments_received != connection->num_fragments)
+		return false;
+
+	switch (connection->type) {
+	case RM_RPC_TYPE_REPLY:
+		complete(&connection->reply.seq_done);
+		break;
+	case RM_RPC_TYPE_NOTIF:
+		schedule_work(&connection->notification.work);
+		break;
+	default:
+		dev_err(rm->dev, "Invalid message type (%d) received\n", connection->type);
+		break;
+	}
+
+	return true;
+}
+
+static void gh_rm_abort_connection(struct gh_rm_connection *connection)
+{
+	switch (connection->type) {
+	case RM_RPC_TYPE_REPLY:
+		connection->reply.ret = -EIO;
+		complete(&connection->reply.seq_done);
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
+	struct gh_rm *rm = container_of(cl, struct gh_rm, msgq_client);
+	struct gh_msgq_rx_data *rx_data = mssg;
+	void *msg = rx_data->data;
+	size_t msg_size = rx_data->length;
+	struct gh_rm_rpc_hdr *hdr;
+
+	if (msg_size <= sizeof(struct gh_rm_rpc_hdr)) {
+		dev_err(rm->dev, "Incomplete message size: %ld is too small\n", msg_size);
+		return;
+	}
+
+	hdr = msg;
+	if (hdr->api != RM_RPC_API) {
+		dev_err(rm->dev, "Unknown RM RPC API version: %x\n", hdr->api);
+		return;
+	}
+
+	if (msg_size > GH_MSGQ_MAX_MSG_SIZE) {
+		dev_err(rm->dev, "Unexpected large message received: %ld\n", msg_size);
+		return;
+	}
+
+	switch (FIELD_GET(RM_RPC_TYPE_MASK, hdr->type)) {
+	case RM_RPC_TYPE_NOTIF:
+		if (rm->active_rx_connection) {
+			/* Not possible per protocol. Do something better than BUG_ON */
+			dev_err(rm->dev, "Received start of new notification without finishing existing message series.\n");
+			gh_rm_abort_connection(rm->active_rx_connection);
+		}
+		rm->active_rx_connection = gh_rm_process_notif(rm, msg, msg_size);
+		break;
+	case RM_RPC_TYPE_REPLY:
+		if (rm->active_rx_connection) {
+			/* Not possible per protocol. Do something better than BUG_ON */
+			dev_err(rm->dev, "Received start of new reply without finishing existing message series.\n");
+			gh_rm_abort_connection(rm->active_rx_connection);
+		}
+		rm->active_rx_connection = gh_rm_process_rply(rm, msg, msg_size);
+		break;
+	case RM_RPC_TYPE_CONTINUATION:
+		if (!rm->active_rx_connection) {
+			dev_err(rm->dev, "Received a continuation message without receiving initial message\n");
+			break;
+		}
+		if (gh_rm_process_cont(rm, rm->active_rx_connection, msg, msg_size)) {
+			gh_rm_abort_connection(rm->active_rx_connection);
+			rm->active_rx_connection = NULL;
+		}
+		break;
+	default:
+		dev_err(rm->dev, "Invalid message type (%lu) received\n",
+			FIELD_GET(RM_RPC_TYPE_MASK, hdr->type));
+		return;
+	}
+
+	if (gh_rm_complete_connection(rm, rm->active_rx_connection))
+		rm->active_rx_connection = NULL;
+}
+
+static void gh_rm_msgq_tx_done(struct mbox_client *cl, void *mssg, int r)
+{
+	struct gh_rm *rm = container_of(cl, struct gh_rm, msgq_client);
+
+	kmem_cache_free(rm->cache, mssg);
+	rm->last_tx_ret = r;
+}
+
+static int gh_rm_send_request(struct gh_rm *rm, u32 message_id,
+			      const void *req_buff, size_t req_buff_size,
+			      struct gh_rm_connection *connection)
+{
+	size_t buff_size_remaining = req_buff_size;
+	u32 cont_fragments = 0;
+	struct gh_rm_rpc_hdr *hdr;
+	struct gh_msgq_tx_data *msg;
+	u8 msg_type = FIELD_PREP(RM_RPC_TYPE_MASK, RM_RPC_TYPE_REQUEST);
+	void *payload;
+	size_t payload_size;
+	const void *req_buff_curr = req_buff;
+	int ret;
+
+	if (req_buff_size)
+		cont_fragments = (req_buff_size - 1) / GH_RM_MAX_MSG_SIZE;
+
+	if (req_buff_size > GH_RM_MAX_NUM_FRAGMENTS * GH_RM_MAX_MSG_SIZE) {
+		pr_warn("Limit exceeded for the number of fragments: %u\n", cont_fragments);
+		dump_stack();
+		return -E2BIG;
+	}
+
+	ret = mutex_lock_interruptible(&rm->send_lock);
+	if (ret)
+		return ret;
+
+	/* Consider also the 'request' packet for the loop count */
+	do {
+		msg = kmem_cache_zalloc(rm->cache, GFP_KERNEL);
+		if (!msg) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		/* Fill header */
+		hdr = (struct gh_rm_rpc_hdr *)msg->data;
+		hdr->api = RM_RPC_API;
+		hdr->type = msg_type | FIELD_PREP(RM_RPC_FRAGMENTS_MASK, cont_fragments);
+		hdr->seq = cpu_to_le16(connection->reply.seq);
+		hdr->msg_id = cpu_to_le32(message_id);
+
+		/* Copy payload */
+		payload = hdr + 1;
+		payload_size = min(buff_size_remaining, GH_RM_MAX_MSG_SIZE);
+		memcpy(payload, req_buff_curr, payload_size);
+		req_buff_curr += payload_size;
+		buff_size_remaining -= payload_size;
+
+		/* Force the last fragment to immediately alert the receiver */
+		msg->push = !buff_size_remaining;
+		msg->length = sizeof(*hdr) + payload_size;
+
+		ret = mbox_send_message(gh_msgq_chan(&rm->msgq), msg);
+		if (ret < 0) {
+			kmem_cache_free(rm->cache, msg);
+			break;
+		}
+
+		if (rm->last_tx_ret) {
+			ret = rm->last_tx_ret;
+			break;
+		}
+
+		msg_type = FIELD_PREP(RM_RPC_TYPE_MASK, RM_RPC_TYPE_CONTINUATION);
+	} while (buff_size_remaining);
+
+out:
+	mutex_unlock(&rm->send_lock);
+	return ret < 0 ? ret : 0;
+}
+
+/**
+ * gh_rm_call: Achieve request-response type communication with RPC
+ * @rm: Pointer to Gunyah resource manager internal data
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
+ * req_buff should be not NULL for req_buff_size >0. If req_buff_size == 0,
+ * req_buff *can* be NULL and no additional payload is sent.
+ *
+ * Context: Process context. Will sleep waiting for reply.
+ * Return: 0 on success. <0 if error.
+ */
+int gh_rm_call(struct gh_rm *rm, u32 message_id, void *req_buff, size_t req_buff_size,
+		void **resp_buf, size_t *resp_buff_size)
+{
+	struct gh_rm_connection *connection;
+	int ret;
+
+	/* message_id 0 is reserved. req_buff_size implies req_buf is not NULL */
+	if (!message_id || (!req_buff && req_buff_size))
+		return -EINVAL;
+
+	if (!rm)
+		return -EPROBE_DEFER;
+
+	connection = gh_rm_alloc_connection(cpu_to_le32(message_id), RM_RPC_TYPE_REPLY);
+	if (!connection)
+		return -ENOMEM;
+
+	init_completion(&connection->reply.seq_done);
+
+	/* Allocate a new seq number for this connection */
+	mutex_lock(&rm->call_idr_lock);
+	ret = idr_alloc_cyclic(&rm->call_idr, connection, 0, U16_MAX,
+						GFP_KERNEL);
+	mutex_unlock(&rm->call_idr_lock);
+	if (ret < 0)
+		goto out;
+	connection->reply.seq = ret;
+
+	/* Send the request to the Resource Manager */
+	ret = gh_rm_send_request(rm, message_id, req_buff, req_buff_size, connection);
+	if (ret < 0)
+		goto out;
+
+	/* Wait for response */
+	ret = wait_for_completion_interruptible(&connection->reply.seq_done);
+	if (ret)
+		goto out;
+
+	/* Check for internal (kernel) error waiting for the response */
+	if (connection->reply.ret) {
+		ret = connection->reply.ret;
+		kfree(connection->payload);
+		goto out;
+	}
+
+	/* Got a response, did resource manager give us an error? */
+	if (connection->reply.rm_error) {
+		pr_warn("RM rejected message %08x. Error: %d\n", message_id,
+			connection->reply.rm_error);
+		dump_stack();
+		ret = gh_rm_remap_error(connection->reply.rm_error);
+		kfree(connection->payload);
+		goto out;
+	}
+
+	/* Everything looks good, return the payload */
+	*resp_buff_size = connection->size;
+	if (connection->size)
+		*resp_buf = connection->payload;
+	else {
+		/* kfree in case RM sent us multiple fragments but never any data in
+		 * those fragments. We would've allocated memory for it, but connection->size == 0
+		 */
+		kfree(connection->payload);
+	}
+
+out:
+	mutex_lock(&rm->call_idr_lock);
+	idr_remove(&rm->call_idr, connection->reply.seq);
+	mutex_unlock(&rm->call_idr_lock);
+	kfree(connection);
+	return ret;
+}
+
+static int gh_msgq_platform_probe_direction(struct platform_device *pdev,
+					bool tx, int idx, struct gunyah_resource *ghrsc)
+{
+	int ret;
+	struct device_node *node = pdev->dev.of_node;
+
+	ghrsc->type = tx ? GUNYAH_RESOURCE_TYPE_MSGQ_TX : GUNYAH_RESOURCE_TYPE_MSGQ_RX;
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
+	struct gh_rm *rm;
+	int ret;
+
+	rm = devm_kzalloc(&pdev->dev, sizeof(*rm), GFP_KERNEL);
+	if (!rm)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, rm);
+	rm->dev = &pdev->dev;
+
+	mutex_init(&rm->call_idr_lock);
+	idr_init(&rm->call_idr);
+	rm->cache = kmem_cache_create("gh_rm", struct_size(msg, data, GH_MSGQ_MAX_MSG_SIZE), 0,
+		SLAB_HWCACHE_ALIGN, NULL);
+	if (!rm->cache)
+		return -ENOMEM;
+	mutex_init(&rm->send_lock);
+
+	ret = gh_msgq_platform_probe_direction(pdev, true, 0, &rm->tx_ghrsc);
+	if (ret)
+		goto err_cache;
+
+	ret = gh_msgq_platform_probe_direction(pdev, false, 1, &rm->rx_ghrsc);
+	if (ret)
+		goto err_cache;
+
+	rm->msgq_client.dev = &pdev->dev;
+	rm->msgq_client.tx_block = true;
+	rm->msgq_client.rx_callback = gh_rm_msgq_rx_data;
+	rm->msgq_client.tx_done = gh_rm_msgq_tx_done;
+
+	return gh_msgq_init(&pdev->dev, &rm->msgq, &rm->msgq_client, &rm->tx_ghrsc, &rm->rx_ghrsc);
+}
+
+static int gh_rm_drv_remove(struct platform_device *pdev)
+{
+	struct gh_rm *rm = platform_get_drvdata(pdev);
+
+	mbox_free_channel(gh_msgq_chan(&rm->msgq));
+	gh_msgq_remove(&rm->msgq);
+	kmem_cache_destroy(rm->cache);
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
index 000000000000..824749e63a54
--- /dev/null
+++ b/drivers/virt/gunyah/rsc_mgr.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef __GH_RSC_MGR_PRIV_H
+#define __GH_RSC_MGR_PRIV_H
+
+#include <linux/gunyah.h>
+#include <linux/gunyah_rsc_mgr.h>
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
+static inline int gh_rm_remap_error(int rm_error)
+{
+	switch (rm_error) {
+	case GH_RM_ERROR_OK:
+		return 0;
+	case GH_RM_ERROR_UNIMPLEMENTED:
+		return -EOPNOTSUPP;
+	case GH_RM_ERROR_NOMEM:
+		return -ENOMEM;
+	case GH_RM_ERROR_NORESOURCE:
+		return -ENODEV;
+	case GH_RM_ERROR_DENIED:
+		return -EPERM;
+	case GH_RM_ERROR_BUSY:
+		return -EBUSY;
+	case GH_RM_ERROR_INVALID:
+	case GH_RM_ERROR_ARGUMENT_INVALID:
+	case GH_RM_ERROR_HANDLE_INVALID:
+	case GH_RM_ERROR_VALIDATE_FAILED:
+	case GH_RM_ERROR_MAP_FAILED:
+	case GH_RM_ERROR_MEM_INVALID:
+	case GH_RM_ERROR_MEM_INUSE:
+	case GH_RM_ERROR_MEM_RELEASED:
+	case GH_RM_ERROR_VMID_INVALID:
+	case GH_RM_ERROR_LOOKUP_FAILED:
+	case GH_RM_ERROR_IRQ_INVALID:
+	case GH_RM_ERROR_IRQ_INUSE:
+	case GH_RM_ERROR_IRQ_RELEASED:
+		return -EINVAL;
+	default:
+		return -EBADMSG;
+	}
+}
+
+struct gh_rm;
+int gh_rm_call(struct gh_rm *rsc_mgr, u32 message_id, void *req_buff, size_t req_buff_size,
+		void **resp_buf, size_t *resp_buff_size);
+
+#endif
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index 5d6fc9f88718..91d2c9f5b2f0 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -119,12 +119,11 @@ static inline int gh_remap_error(int gh_error)
 		return -EACCES;
 	case GH_ERROR_BUSY:
 	case GH_ERROR_IDLE:
-		return -EBUSY;
 	case GH_ERROR_IRQ_BOUND:
 	case GH_ERROR_IRQ_UNBOUND:
 	case GH_ERROR_MSGQUEUE_FULL:
 	case GH_ERROR_MSGQUEUE_EMPTY:
-		return -EPERM;
+		return -EBUSY;
 	default:
 		return -EINVAL;
 	}
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
new file mode 100644
index 000000000000..959787ad0a3d
--- /dev/null
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
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
2.39.0

