Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226EC72E955
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbjFMRWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238560AbjFMRVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:21:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481B1172A;
        Tue, 13 Jun 2023 10:21:48 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DExcXQ031315;
        Tue, 13 Jun 2023 17:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=/iuZ7CWGG0VNBdKzkKlxIpiC9jWY1cnfrqMBIOf43ZM=;
 b=ETaXzldmsyF1TTadVZVQiOUNAnvs2DBSKZsmV/ZY5HDp2VxIfErZpGiRWB0WAptOWvWo
 tezOOewo49XAUmvKQKAoPjSa3HfJlbm5D6Otl6HMF8jgI62mNzBERTfQhWSt3uVYEtWI
 wPteAH/InR4hON2WHpQua1Tjq8Ml3WhlgcQRXMyyflPYHai6r0QmeHO/Hw3ssayqLKnK
 uorocncPSpYNIWegYNqmnp6eJEC5acV/y2ZJOKido+K5dWoGvTVXj3+R0bTco06gWssF
 0815/6GlhOyhZd0GJ45V+c8Ngyb9kg+wmPYskAPC2B8oxtfaVAZQ1nTx8xaHdWm/Bquq Vg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6s3wrnav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:21:28 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35DHLQco029074
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:21:26 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 13 Jun 2023 10:21:25 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v14 06/25] mailbox: Add Gunyah message queue mailbox
Date:   Tue, 13 Jun 2023 10:20:34 -0700
Message-ID: <20230613172054.3959700-7-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230613172054.3959700-1-quic_eberman@quicinc.com>
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JecKb8AV1797_2_Cth_RBwhCv0rWSRo3
X-Proofpoint-GUID: JecKb8AV1797_2_Cth_RBwhCv0rWSRo3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_19,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=413 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130153
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gunyah message queues are a unidirectional inter-VM pipe for messages up
to 1024 bytes. This driver supports pairing a receiver message queue and
a transmitter message queue to expose a single mailbox channel.

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 Documentation/virt/gunyah/message-queue.rst |   8 +
 drivers/mailbox/Makefile                    |   2 +
 drivers/mailbox/gunyah-msgq.c               | 219 ++++++++++++++++++++
 include/linux/gunyah.h                      |  57 +++++
 4 files changed, 286 insertions(+)
 create mode 100644 drivers/mailbox/gunyah-msgq.c

diff --git a/Documentation/virt/gunyah/message-queue.rst b/Documentation/virt/gunyah/message-queue.rst
index b352918ae54b4..70d82a4ef32d7 100644
--- a/Documentation/virt/gunyah/message-queue.rst
+++ b/Documentation/virt/gunyah/message-queue.rst
@@ -61,3 +61,11 @@ vIRQ: two TX message queues will have two vIRQs (and two capability IDs).
       |               |         |                 |         |               |
       |               |         |                 |         |               |
       +---------------+         +-----------------+         +---------------+
+
+Gunyah message queues are exposed as mailboxes. To create the mailbox, create
+a mbox_client and call `gh_msgq_init()`. On receipt of the RX_READY interrupt,
+all messages in the RX message queue are read and pushed via the `rx_callback`
+of the registered mbox_client.
+
+.. kernel-doc:: drivers/mailbox/gunyah-msgq.c
+   :identifiers: gh_msgq_init
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index fc93761171113..5f929bb55e9a5 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -55,6 +55,8 @@ obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o
 
 obj-$(CONFIG_ZYNQMP_IPI_MBOX)	+= zynqmp-ipi-mailbox.o
 
+obj-$(CONFIG_GUNYAH)		+= gunyah-msgq.o
+
 obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
 
 obj-$(CONFIG_SPRD_MBOX)		+= sprd-mailbox.o
diff --git a/drivers/mailbox/gunyah-msgq.c b/drivers/mailbox/gunyah-msgq.c
new file mode 100644
index 0000000000000..7f777339278eb
--- /dev/null
+++ b/drivers/mailbox/gunyah-msgq.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/gunyah.h>
+#include <linux/printk.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+
+#define mbox_chan_to_msgq(chan) (container_of(chan->mbox, struct gh_msgq, mbox))
+
+static irqreturn_t gh_msgq_rx_irq_handler(int irq, void *data)
+{
+	struct gh_msgq *msgq = data;
+	struct gh_msgq_rx_data rx_data;
+	enum gh_error gh_error;
+	bool ready = true;
+
+	while (ready) {
+		gh_error = gh_hypercall_msgq_recv(msgq->rx_ghrsc->capid,
+				&rx_data.data, sizeof(rx_data.data),
+				&rx_data.length, &ready);
+		if (gh_error != GH_ERROR_OK) {
+			if (gh_error != GH_ERROR_MSGQUEUE_EMPTY)
+				dev_warn(msgq->mbox.dev, "Failed to receive data: %d\n", gh_error);
+			break;
+		}
+		if (likely(gh_msgq_chan(msgq)->cl))
+			mbox_chan_received_data(gh_msgq_chan(msgq), &rx_data);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/* Fired when message queue transitions from "full" to "space available" to send messages */
+static irqreturn_t gh_msgq_tx_irq_handler(int irq, void *data)
+{
+	struct gh_msgq *msgq = data;
+
+	mbox_chan_txdone(gh_msgq_chan(msgq), 0);
+
+	return IRQ_HANDLED;
+}
+
+/* Fired after sending message and hypercall told us there was more space available. */
+static void gh_msgq_txdone_tasklet(struct tasklet_struct *tasklet)
+{
+	struct gh_msgq *msgq = container_of(tasklet, struct gh_msgq, txdone_tasklet);
+
+	mbox_chan_txdone(gh_msgq_chan(msgq), msgq->last_ret);
+}
+
+static int gh_msgq_send_data(struct mbox_chan *chan, void *data)
+{
+	struct gh_msgq *msgq = mbox_chan_to_msgq(chan);
+	struct gh_msgq_tx_data *msgq_data = data;
+	u64 tx_flags = 0;
+	enum gh_error gh_error;
+	bool ready;
+
+	if (!msgq->tx_ghrsc)
+		return -EOPNOTSUPP;
+
+	if (msgq_data->push)
+		tx_flags |= GH_HYPERCALL_MSGQ_TX_FLAGS_PUSH;
+
+	gh_error = gh_hypercall_msgq_send(msgq->tx_ghrsc->capid, msgq_data->length, msgq_data->data,
+						tx_flags, &ready);
+
+	/**
+	 * unlikely because Linux tracks state of msgq and should not try to
+	 * send message when msgq is full.
+	 */
+	if (unlikely(gh_error == GH_ERROR_MSGQUEUE_FULL))
+		return -EAGAIN;
+
+	/**
+	 * Propagate all other errors to client. If we return error to mailbox
+	 * framework, then no other messages can be sent and nobody will know
+	 * to retry this message.
+	 */
+	msgq->last_ret = gh_error_remap(gh_error);
+
+	/**
+	 * This message was successfully sent, but message queue isn't ready to
+	 * accept more messages because it's now full. Mailbox framework
+	 * requires that we only report that message was transmitted when
+	 * we're ready to transmit another message. We'll get that in the form
+	 * of tx IRQ once the other side starts to drain the msgq.
+	 */
+	if (gh_error == GH_ERROR_OK) {
+		if (!ready)
+			return 0;
+	} else {
+		dev_err(msgq->mbox.dev, "Failed to send data: %d (%d)\n", gh_error, msgq->last_ret);
+	}
+
+	/**
+	 * We can send more messages. Mailbox framework requires that tx done
+	 * happens asynchronously to sending the message. Gunyah message queues
+	 * tell us right away on the hypercall return whether we can send more
+	 * messages. To work around this, defer the txdone to a tasklet.
+	 */
+	tasklet_schedule(&msgq->txdone_tasklet);
+
+	return 0;
+}
+
+static struct mbox_chan_ops gh_msgq_ops = {
+	.send_data = gh_msgq_send_data,
+};
+
+/**
+ * gh_msgq_init() - Initialize a Gunyah message queue with an mbox_client
+ * @parent: device parent used for the mailbox controller
+ * @msgq: Pointer to the gh_msgq to initialize
+ * @cl: A mailbox client to bind to the mailbox channel that the message queue creates
+ * @tx_ghrsc: optional, the transmission side of the message queue
+ * @rx_ghrsc: optional, the receiving side of the message queue
+ *
+ * At least one of tx_ghrsc and rx_ghrsc must be not NULL. Most message queue use cases come with
+ * a pair of message queues to facilitate bidirectional communication. When tx_ghrsc is set,
+ * the client can send messages with mbox_send_message(gh_msgq_chan(msgq), msg). When rx_ghrsc
+ * is set, the mbox_client must register an .rx_callback() and the message queue driver will
+ * deliver all available messages upon receiving the RX ready interrupt. The messages should be
+ * consumed or copied by the client right away as the gh_msgq_rx_data will be replaced/destroyed
+ * after the callback.
+ *
+ * Returns - 0 on success, negative otherwise
+ */
+int gh_msgq_init(struct device *parent, struct gh_msgq *msgq, struct mbox_client *cl,
+		 struct gh_resource *tx_ghrsc, struct gh_resource *rx_ghrsc)
+{
+	int ret;
+
+	/* Must have at least a tx_ghrsc or rx_ghrsc and that they are the right device types */
+	if ((!tx_ghrsc && !rx_ghrsc) ||
+	    (tx_ghrsc && tx_ghrsc->type != GH_RESOURCE_TYPE_MSGQ_TX) ||
+	    (rx_ghrsc && rx_ghrsc->type != GH_RESOURCE_TYPE_MSGQ_RX))
+		return -EINVAL;
+
+	msgq->mbox.dev = parent;
+	msgq->mbox.ops = &gh_msgq_ops;
+	msgq->mbox.num_chans = 1;
+	msgq->mbox.txdone_irq = true;
+	msgq->mbox.chans = &msgq->mbox_chan;
+
+	ret = mbox_controller_register(&msgq->mbox);
+	if (ret)
+		return ret;
+
+	ret = mbox_bind_client(gh_msgq_chan(msgq), cl);
+	if (ret)
+		goto err_mbox;
+
+	if (tx_ghrsc) {
+		msgq->tx_ghrsc = tx_ghrsc;
+
+		ret = request_irq(msgq->tx_ghrsc->irq, gh_msgq_tx_irq_handler, 0, "gh_msgq_tx",
+				msgq);
+		if (ret)
+			goto err_tx_ghrsc;
+
+		enable_irq_wake(msgq->tx_ghrsc->irq);
+
+		tasklet_setup(&msgq->txdone_tasklet, gh_msgq_txdone_tasklet);
+	}
+
+	if (rx_ghrsc) {
+		msgq->rx_ghrsc = rx_ghrsc;
+
+		ret = request_threaded_irq(msgq->rx_ghrsc->irq, NULL, gh_msgq_rx_irq_handler,
+						IRQF_ONESHOT, "gh_msgq_rx", msgq);
+		if (ret)
+			goto err_tx_irq;
+
+		enable_irq_wake(msgq->rx_ghrsc->irq);
+	}
+
+	return 0;
+err_tx_irq:
+	if (msgq->tx_ghrsc)
+		free_irq(msgq->tx_ghrsc->irq, msgq);
+
+	msgq->rx_ghrsc = NULL;
+err_tx_ghrsc:
+	msgq->tx_ghrsc = NULL;
+err_mbox:
+	mbox_controller_unregister(&msgq->mbox);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_msgq_init);
+
+void gh_msgq_remove(struct gh_msgq *msgq)
+{
+	mbox_free_channel(gh_msgq_chan(msgq));
+
+	if (msgq->rx_ghrsc)
+		free_irq(msgq->rx_ghrsc->irq, msgq);
+
+	if (msgq->tx_ghrsc) {
+		tasklet_kill(&msgq->txdone_tasklet);
+		free_irq(msgq->tx_ghrsc->irq, msgq);
+	}
+
+	mbox_controller_unregister(&msgq->mbox);
+
+	msgq->rx_ghrsc = NULL;
+	msgq->tx_ghrsc = NULL;
+}
+EXPORT_SYMBOL_GPL(gh_msgq_remove);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Gunyah Message Queue Driver");
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index 01a6f202d037e..982e27d10d57f 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -8,11 +8,68 @@
 
 #include <linux/bitfield.h>
 #include <linux/errno.h>
+#include <linux/interrupt.h>
 #include <linux/limits.h>
+#include <linux/mailbox_controller.h>
+#include <linux/mailbox_client.h>
 #include <linux/types.h>
 
+/* Matches resource manager's resource types for VM_GET_HYP_RESOURCES RPC */
+enum gh_resource_type {
+	GH_RESOURCE_TYPE_BELL_TX	= 0,
+	GH_RESOURCE_TYPE_BELL_RX	= 1,
+	GH_RESOURCE_TYPE_MSGQ_TX	= 2,
+	GH_RESOURCE_TYPE_MSGQ_RX	= 3,
+	GH_RESOURCE_TYPE_VCPU		= 4,
+};
+
+struct gh_resource {
+	enum gh_resource_type type;
+	u64 capid;
+	unsigned int irq;
+};
+
+/**
+ * Gunyah Message Queues
+ */
+
+#define GH_MSGQ_MAX_MSG_SIZE		240
+
+struct gh_msgq_tx_data {
+	size_t length;
+	bool push;
+	char data[];
+};
+
+struct gh_msgq_rx_data {
+	size_t length;
+	char data[GH_MSGQ_MAX_MSG_SIZE];
+};
+
+struct gh_msgq {
+	struct gh_resource *tx_ghrsc;
+	struct gh_resource *rx_ghrsc;
+
+	/* msgq private */
+	int last_ret; /* Linux error, not GH_STATUS_* */
+	struct mbox_chan mbox_chan;
+	struct mbox_controller mbox;
+	struct tasklet_struct txdone_tasklet;
+};
+
+
+int gh_msgq_init(struct device *parent, struct gh_msgq *msgq, struct mbox_client *cl,
+		     struct gh_resource *tx_ghrsc, struct gh_resource *rx_ghrsc);
+void gh_msgq_remove(struct gh_msgq *msgq);
+
+static inline struct mbox_chan *gh_msgq_chan(struct gh_msgq *msgq)
+{
+	return &msgq->mbox.chans[0];
+}
+
 /******************************************************************************/
 /* Common arch-independent definitions for Gunyah hypercalls                  */
+
 #define GH_CAPID_INVAL	U64_MAX
 #define GH_VMID_ROOT_VM	0xff
 
-- 
2.40.0

