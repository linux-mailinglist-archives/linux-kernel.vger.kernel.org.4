Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23A760E7E4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiJZTAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbiJZTAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:00:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0C8BCA4;
        Wed, 26 Oct 2022 11:59:45 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QIrCGD009053;
        Wed, 26 Oct 2022 18:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=ztRMO4ulMAxWLd+6hjV8urZcbur5WPZCxymYQkwM3M4=;
 b=hmy0Wb99tYqt51MYmIEEdansur+gY9tFVk1bPa5dQlXTeFAGs+EDiqE+sCefbhDHGOQs
 uS7n79o3g83whn+9weRfCLmRMb857q73ypWVFSFYZyzr6inMsatEtMjClUR0WOj0RcdF
 6WYynng27NXuNG0yXcgmA/exjvt9BSS/Z2bXzwxkKhXKugOjKh7JoJFZmxYE9Ff068HT
 4M2kKQfmBB6li4O02TSqFCqPtXIf3XfArHDC+yThFcxUiNTIqwo1kUlwGADT4IgVQFyr
 sFXLqbKvYICOYR7wQ6KG5r++Db+DnWr2xXbD3DtjCeWepn7z/kmvLOIg7OekWIkSX2Y+ rg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfahvr0r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 18:59:32 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29QIxVRs006391
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 18:59:31 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 11:59:30 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Marc Zyngier" <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 09/21] mailbox: Add Gunyah message queue mailbox
Date:   Wed, 26 Oct 2022 11:58:34 -0700
Message-ID: <20221026185846.3983888-10-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026185846.3983888-1-quic_eberman@quicinc.com>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Sy4Gz_ABdlMV-5hZW4H-5x8ufvAfX9RO
X-Proofpoint-ORIG-GUID: Sy4Gz_ABdlMV-5hZW4H-5x8ufvAfX9RO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_07,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=299
 malwarescore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2210260105
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gunyah message queues are a unidirectional inter-VM pipe for messages up
to 1024 bytes. This driver supports pairing a receiver message queue and
a transmitter message queue to expose a single mailbox channel.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 Documentation/virt/gunyah/message-queue.rst |   8 +
 MAINTAINERS                                 |   1 +
 drivers/mailbox/Kconfig                     |  10 +
 drivers/mailbox/Makefile                    |   2 +
 drivers/mailbox/gunyah-msgq.c               | 225 ++++++++++++++++++++
 include/linux/gunyah.h                      |  61 +++++-
 6 files changed, 305 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mailbox/gunyah-msgq.c

diff --git a/Documentation/virt/gunyah/message-queue.rst b/Documentation/virt/gunyah/message-queue.rst
index c9f4d75e2291..7324fc616684 100644
--- a/Documentation/virt/gunyah/message-queue.rst
+++ b/Documentation/virt/gunyah/message-queue.rst
@@ -53,3 +53,11 @@ reference message queue 2's capability ID.
       |               |         |                 |         |               |
       |               |         |                 |         |               |
       +---------------+         +-----------------+         +---------------+
+
+Gunyah message queues are exposed as mailboxes. To create the mailbox, create
+a mbox_client and call `gh_msgq_init`. On receipt of the RX_READY interrupt,
+all messages in the RX message queue are read and pushed via the `rx_callback`
+of the registered mbox_client.
+
+.. kernel-doc:: drivers/mailbox/gunyah-msgq.c
+   :identifiers: gh_msgq_init
diff --git a/MAINTAINERS b/MAINTAINERS
index 211977dc344b..586539eadd3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8943,6 +8943,7 @@ S:	Supported
 F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
 F:	Documentation/virt/gunyah/
 F:	arch/arm64/gunyah/
+F:	drivers/mailbox/gunyah-msgq.c
 F:	drivers/virt/gunyah/
 F:	include/linux/gunyah.h
 
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 05d6fae800e3..baf9451c5f04 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -41,6 +41,16 @@ config IMX_MBOX
 	help
 	  Mailbox implementation for i.MX Messaging Unit (MU).
 
+config GUNYAH_MESSAGE_QUEUES
+	tristate "Gunyah Message Queue Mailbox"
+	depends on GUNYAH
+	help
+	  Mailbox implementation for Gunyah Message Queues. Gunyah message queues
+	  are an IPC mechanism to pass short messages between virtual machines
+	  running under the Gunyah hypervisor.
+
+	  Say Y here if you run Linux as a Gunyah virtual machine.
+
 config PLATFORM_MHU
 	tristate "Platform MHU Mailbox"
 	depends on OF
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index fc9376117111..5f929bb55e9a 100644
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
index 000000000000..c4d2ede9334f
--- /dev/null
+++ b/drivers/mailbox/gunyah-msgq.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
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
+static inline bool gh_msgq_has_tx(struct gh_msgq *msgq)
+{
+	return msgq->tx_ghrsc->type == GUNYAH_RESOURCE_TYPE_MSGQ_TX;
+}
+
+static inline bool gh_msgq_has_rx(struct gh_msgq *msgq)
+{
+	return msgq->rx_ghrsc->type == GUNYAH_RESOURCE_TYPE_MSGQ_RX;
+}
+
+static irqreturn_t gh_msgq_rx_irq_handler(int irq, void *data)
+{
+	struct gh_msgq *msgq = data;
+	struct gh_msgq_rx_data rx_data;
+	unsigned long gh_err;
+	ssize_t ret;
+	bool ready = false;
+
+	do {
+		gh_err = gh_hypercall_msgq_recv(msgq->rx_ghrsc->capid,
+				(uintptr_t)&rx_data.data, sizeof(rx_data.data),
+				&rx_data.length, &ready);
+		if (gh_err == GH_ERROR_OK) {
+			mbox_chan_received_data(gh_msgq_chan(msgq), &rx_data);
+		} else if (GH_ERROR_MSGQUEUE_EMPTY) {
+			break;
+		} else {
+			pr_warn("Failed to receive data from msgq for %s: %ld\n",
+				msgq->mbox.dev ? dev_name(msgq->mbox.dev) : "", ret);
+			break;
+		}
+	} while (ready);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t gh_msgq_tx_irq_handler(int irq, void *data)
+{
+	struct gh_msgq *msgq = data;
+
+	mbox_chan_txdone(gh_msgq_chan(msgq), 0);
+
+	return IRQ_HANDLED;
+}
+
+static void gh_msgq_txdone_tasklet(unsigned long data)
+{
+	struct gh_msgq *msgq = (struct gh_msgq *)data;
+
+	mbox_chan_txdone(gh_msgq_chan(msgq), msgq->last_status);
+}
+
+static int gh_msgq_send_data(struct mbox_chan *chan, void *data)
+{
+	struct gh_msgq *msgq = mbox_chan_to_msgq(chan);
+	struct gh_msgq_tx_data *msgq_data = data;
+	u64 tx_flags = 0;
+	unsigned long ret;
+	bool ready;
+
+	if (msgq_data->push)
+		tx_flags |= GH_HYPERCALL_MSGQ_TX_FLAGS_PUSH;
+
+	ret = gh_hypercall_msgq_send(msgq->tx_ghrsc->capid, msgq_data->length,
+					(uintptr_t)msgq_data->data, tx_flags, &ready);
+
+	/**
+	 * unlikely because Linux tracks state of msgq and should not try to
+	 * send message when msgq is full.
+	 */
+	if (unlikely(ret == GH_ERROR_MSGQUEUE_FULL))
+		return -EAGAIN;
+
+	/**
+	 * Propagate all other errors to client. If we return error to mailbox
+	 * framework, then no other messages can be sent and nobody will know
+	 * to retry this message.
+	 */
+	msgq->last_status = gh_remap_error(ret);
+
+	/**
+	 * This message was successfully sent, but message queue isn't ready to
+	 * receive more messages because it's now full. Mailbox framework
+	 * requires that we only report that message was transmitted only when
+	 * we're ready to transmit another message. We'll get that in the form
+	 * of tx IRQ once the other side starts to drain the msgq.
+	 */
+	if (ret == GH_ERROR_OK && !ready)
+		return 0;
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
+struct mbox_chan_ops gh_msgq_ops = {
+	.send_data = gh_msgq_send_data,
+};
+
+/**
+ * gh_msgq_init() - Initialize a Gunyah message queue with an mbox_client
+ * @parent: optional, device parent used for the mailbox controller
+ * @msgq: Pointer to the gh_msgq to initialize
+ * @cl: A mailbox client to bind to the mailbox channel that the message queue creates
+ * @tx_ghrsc: optional, the transmission side of the message queue
+ * @rx_ghrsc: optional, the receiving side of the message queue
+ *
+ * At least one of tx_ghrsc and rx_ghrsc should be not NULL. Most message queue use cases come with
+ * a pair of message queues to facilitiate bidirectional communication. When tx_ghrsc is set,
+ * the client can send messages with mbox_send_message(gh_msgq_chan(msgq), msg). When rx_ghrsc
+ * is set, the mbox_client should register an .rx_callback() and the message queue driver will
+ * push all available messages upon receiving the RX ready interrupt. The messages should be
+ * consumed or copied by the client right away as the gh_msgq_rx_data will be replaced/destroyed
+ * after the callback.
+ *
+ * Returns - 0 on success, negative otherwise
+ */
+int gh_msgq_init(struct device *parent, struct gh_msgq *msgq, struct mbox_client *cl,
+		     struct gunyah_resource *tx_ghrsc, struct gunyah_resource *rx_ghrsc)
+{
+	int ret;
+
+	/* Must have at least a tx_ghrsc or rx_ghrsc and that they are the right device types */
+	if ((!tx_ghrsc && !rx_ghrsc) ||
+	    (tx_ghrsc && tx_ghrsc->type != GUNYAH_RESOURCE_TYPE_MSGQ_TX) ||
+	    (rx_ghrsc && rx_ghrsc->type != GUNYAH_RESOURCE_TYPE_MSGQ_RX))
+		return -EINVAL;
+
+	msgq->tx_ghrsc = tx_ghrsc;
+	msgq->rx_ghrsc = rx_ghrsc;
+
+	msgq->mbox.dev = parent;
+	msgq->mbox.ops = &gh_msgq_ops;
+	msgq->mbox.chans = kcalloc(1, sizeof(*msgq->mbox.chans), GFP_KERNEL);
+	msgq->mbox.num_chans = 1;
+	msgq->mbox.txdone_irq = true;
+
+	if (gh_msgq_has_tx(msgq)) {
+		ret = request_irq(msgq->tx_ghrsc->irq, gh_msgq_tx_irq_handler, 0, "gh_msgq_tx",
+				msgq);
+		if (ret)
+			goto err_chans;
+	}
+
+	if (gh_msgq_has_rx(msgq)) {
+		ret = request_threaded_irq(msgq->rx_ghrsc->irq, NULL, gh_msgq_rx_irq_handler,
+						IRQF_ONESHOT, "gh_msgq_rx", msgq);
+		if (ret)
+			goto err_tx_irq;
+	}
+
+	tasklet_init(&msgq->txdone_tasklet, gh_msgq_txdone_tasklet, (unsigned long)msgq);
+
+	ret = mbox_controller_register(&msgq->mbox);
+	if (ret)
+		goto err_rx_irq;
+
+	ret = mbox_bind_client(gh_msgq_chan(msgq), cl);
+	if (ret)
+		goto err_mbox;
+
+	return 0;
+err_mbox:
+	mbox_controller_unregister(&msgq->mbox);
+err_rx_irq:
+	if (gh_msgq_has_rx(msgq))
+		free_irq(msgq->rx_ghrsc->irq, msgq);
+err_tx_irq:
+	if (gh_msgq_has_tx(msgq))
+		free_irq(msgq->tx_ghrsc->irq, msgq);
+err_chans:
+	kfree(msgq->mbox.chans);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_msgq_init);
+
+void gh_msgq_remove(struct gh_msgq *msgq)
+{
+	if (gh_msgq_has_rx(msgq))
+		free_irq(msgq->rx_ghrsc->irq, msgq);
+
+	if (gh_msgq_has_tx(msgq))
+		free_irq(msgq->tx_ghrsc->irq, msgq);
+
+	kfree(msgq->mbox.chans);
+}
+EXPORT_SYMBOL_GPL(gh_msgq_remove);
+
+
+static int __init gh_msgq_init_module(void)
+{
+	if (gh_api_version() != GUNYAH_API_V1) {
+		pr_warn("Unrecognized gunyah version: %u. Currently supported: %d\n",
+			gh_api_version(), GUNYAH_API_V1);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+module_init(gh_msgq_init_module);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Gunyah Message Queue Driver");
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index c863cac4a3cf..e317d7ac938f 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -7,10 +7,67 @@
 #define _GUNYAH_H
 
 #include <linux/bitfield.h>
-#include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/mailbox_controller.h>
+#include <linux/mailbox_client.h>
+#include <linux/types.h>
+
+/* Follows resource manager's resource types for VM_GET_HYP_RESOURCES */
+enum gunyah_resource_type {
+	GUNYAH_RESOURCE_TYPE_BELL_TX	= 0,
+	GUNYAH_RESOURCE_TYPE_BELL_RX	= 1,
+	GUNYAH_RESOURCE_TYPE_MSGQ_TX	= 2,
+	GUNYAH_RESOURCE_TYPE_MSGQ_RX	= 3,
+	GUNYAH_RESOURCE_TYPE_VCPU	= 4,
+};
+
+struct gunyah_resource {
+	enum gunyah_resource_type type;
+	u64 capid;
+	int irq;
+};
+
+/**
+ * Gunyah Message Queues
+ */
+
+#define GH_MSGQ_MAX_MSG_SIZE	240
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
+	struct gunyah_resource *tx_ghrsc;
+	struct gunyah_resource *rx_ghrsc;
+
+	/* msgq private */
+	int last_status;
+	struct mbox_controller mbox;
+	struct tasklet_struct txdone_tasklet;
+};
+
+
+int gh_msgq_init(struct device *parent, struct gh_msgq *msgq, struct mbox_client *cl,
+		     struct gunyah_resource *tx_ghrsc, struct gunyah_resource *rx_ghrsc);
+void gh_msgq_remove(struct gh_msgq *msgq);
+
+static inline struct mbox_chan *gh_msgq_chan(struct gh_msgq *msgq)
+{
+	return &msgq->mbox.chans[0];
+}
+
+/******************************************************************************/
+/* Common arch-independent macros and definitions for Gunyah hypercalls */
 
-/* Common Gunyah macros */
 #define GH_CAPID_INVAL	U64_MAX
 #define GH_VMID_ROOT_VM	0xff
 
-- 
2.25.1

