Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C155EE63D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 21:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbiI1T6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 15:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbiI1T5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 15:57:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E3F53D32;
        Wed, 28 Sep 2022 12:57:45 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SJSpUp027441;
        Wed, 28 Sep 2022 19:57:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=QcUpNcp8887i1C6G7g+TrpelJvYBOsCpcwgUQd9IaDM=;
 b=iTfcOhqoL4dH17ZZHvQ1Ov+AgSpa5pn34V00FU1pNsve9QNtOkxtKSHaRaccbzEPNEuP
 Qnt1pynJ54XLq9rTEXRbybifOKyydXVdWFBMqmBZD10guMq7oRYxUQPTA/aFygyGJnKp
 HCJMSpYfinHk/g18Ymyi2FDpjaxGtRJV+hTvmMBUyVqcaMBXAjyaFTbuQrYD2GtA7Xnb
 2kDIwIwqRlFqGKSyo+DuobWBRT30pwnJ2KA8ZqwJRti84Zce4nKihuqHgEEsHPcgldey
 GeUi9OBv2/+JlZwi0uVlh+wFpzq63/lLN+XAgFTr1enTySdy8ffq6g+vCj1GUtS8cBcs wg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jvpuv98vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 19:57:30 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28SJvUSX007528
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 19:57:30 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 28 Sep 2022 12:57:29 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
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
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 09/14] mailbox: Add Gunyah message queue mailbox
Date:   Wed, 28 Sep 2022 12:56:28 -0700
Message-ID: <20220928195633.2348848-10-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928195633.2348848-1-quic_eberman@quicinc.com>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: w2iJcoOu3PEWMJh29PG2F0-UngEwGuWk
X-Proofpoint-ORIG-GUID: w2iJcoOu3PEWMJh29PG2F0-UngEwGuWk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_09,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280119
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 MAINTAINERS                   |   2 +
 drivers/mailbox/Kconfig       |  10 ++
 drivers/mailbox/Makefile      |   2 +
 drivers/mailbox/gunyah-msgq.c | 232 ++++++++++++++++++++++++++++++++++
 drivers/virt/gunyah/Kconfig   |   2 +
 include/linux/gunyah.h        |  67 ++++++++++
 6 files changed, 315 insertions(+)
 create mode 100644 drivers/mailbox/gunyah-msgq.c
 create mode 100644 include/linux/gunyah.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a26e67ef36b4..74053d8ff7ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8889,8 +8889,10 @@ F:	Documentation/ABI/testing/sysfs-hypervisor-gunyah
 F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
 F:	Documentation/virt/gunyah/
 F:	arch/arm64/gunyah/
+F:	drivers/mailbox/gunyah-msgq.c
 F:	drivers/virt/gunyah/
 F:	include/asm-generic/gunyah.h
+F:	include/linux/gunyah.h
 
 HABANALABS PCI DRIVER
 M:	Oded Gabbay <ogabbay@kernel.org>
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
index 000000000000..359f682d101c
--- /dev/null
+++ b/drivers/mailbox/gunyah-msgq.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/mailbox_controller.h>
+#include <linux/interrupt.h>
+#include <linux/gunyah.h>
+#include <linux/printk.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+
+#define mbox_chan_to_msgq(chan) (container_of(chan->mbox, struct gunyah_msgq, mbox))
+
+static inline bool gh_msgq_has_tx(struct gunyah_msgq *msgq)
+{
+	return msgq->tx_ghrsc.type == GUNYAH_RESOURCE_TYPE_MSGQ_TX;
+}
+
+static inline bool gh_msgq_has_rx(struct gunyah_msgq *msgq)
+{
+	return msgq->rx_ghrsc.type == GUNYAH_RESOURCE_TYPE_MSGQ_RX;
+}
+
+static ssize_t __gh_msgq_recv(struct gunyah_msgq *msgq, void *buff, size_t size, bool *ready)
+{
+	unsigned long gh_err;
+	size_t recv_size;
+	ssize_t ret;
+
+	gh_err = gh_hypercall_msgq_recv(msgq->rx_ghrsc.capid, (uintptr_t)buff, size,
+					&recv_size, ready);
+	switch (gh_err) {
+	case GH_ERROR_OK:
+		ret = recv_size;
+		break;
+	case GH_ERROR_MSGQUEUE_EMPTY:
+		ret = -EAGAIN;
+		*ready = false;
+		break;
+	default:
+		ret = gh_remap_error(gh_err);
+		break;
+	}
+
+	return ret;
+}
+
+static irqreturn_t gh_msgq_rx_irq_handler(int irq, void *data)
+{
+	struct gunyah_msgq *msgq = data;
+	struct gunyah_msgq_rx_data rx_data;
+	ssize_t ret;
+	bool more;
+
+	do {
+		ret = __gh_msgq_recv(msgq, &rx_data.data, sizeof(rx_data.data), &more);
+
+		if (ret >= 0) {
+			rx_data.length = ret;
+			mbox_chan_received_data(gunyah_msgq_chan(msgq), &rx_data);
+		} else if (ret != -EAGAIN)
+			pr_warn("Failed to receive data from msgq for %s: %ld\n",
+				msgq->mbox.dev ? dev_name(msgq->mbox.dev) : "", ret);
+	} while (ret >= 0 && more);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t gh_msgq_tx_irq_handler(int irq, void *data)
+{
+	struct gunyah_msgq *msgq = data;
+
+	mbox_chan_txdone(gunyah_msgq_chan(msgq), 0);
+
+	return IRQ_HANDLED;
+}
+
+static void gh_msgq_txdone_tasklet(unsigned long data)
+{
+	struct gunyah_msgq *msgq = (struct gunyah_msgq *)data;
+
+	mbox_chan_txdone(gunyah_msgq_chan(msgq), msgq->last_status);
+}
+
+static int __gh_msgq_send(struct gunyah_msgq *msgq, void *buff, size_t size, u64 tx_flags)
+{
+	unsigned long gh_err;
+	ssize_t ret;
+	bool ready;
+
+	gh_err = gh_hypercall_msgq_send(msgq->tx_ghrsc.capid, size, (uintptr_t)buff, tx_flags,
+					&ready);
+	switch (gh_err) {
+	case GH_ERROR_OK:
+		ret = !ready;
+		break;
+	case GH_ERROR_MSGQUEUE_FULL:
+		ret = -EAGAIN;
+		break;
+	default:
+		/* Not sure how to propagate these out to client. If we get here, nobody is going
+		 * to trigger a retry
+		 */
+		ret = gh_remap_error(gh_err);
+		break;
+	}
+
+	return ret;
+}
+
+static int gh_msgq_send_data(struct mbox_chan *chan, void *data)
+{
+	struct gunyah_msgq *msgq = mbox_chan_to_msgq(chan);
+	struct gunyah_msgq_tx_data *msgq_data = data;
+	u64 tx_flags = 0;
+	int ret;
+
+	if (msgq_data->push)
+		tx_flags |= GH_HYPERCALL_MSGQ_TX_FLAGS_PUSH;
+
+	ret = __gh_msgq_send(msgq, msgq_data->data, msgq_data->length, tx_flags);
+
+	/**
+	 * EAGAIN: message didn't send.
+	 * ret = 1: message sent, but now the message queue is full and we can't send any more msgs.
+	 * Either way, don't report that this message is done.
+	 */
+	if (ret == -EAGAIN || ret == 1)
+		return ret;
+
+	/**
+	 * Mailbox framework requires that tx done happens asynchronously to sending the message
+	 * IOW, a notification that the message was sent happens after sending the message.
+	 * To work around this, defer the txdone to a tasklet.
+	 */
+	msgq->last_status = ret;
+	tasklet_schedule(&msgq->txdone_tasklet);
+
+	return 0;
+}
+
+struct mbox_chan_ops gunyah_msgq_ops = {
+	.send_data = gh_msgq_send_data,
+};
+
+/**
+ * gunyah_msgq_init() - Initialize a Gunyah message queue with an mbox_client
+ * @parent: optional, device parent used for the mailbox controller
+ * @msgq: Pointer to the gunyah_msgq to initialize
+ * @cl: A mailbox client to bind to the mailbox channel that the message queue creates
+ * @tx_ghrsc: optional, the transmission side of the message queue
+ * @rx_ghrsc: optional, the receiving side of the message queue
+ *
+ * At least one of tx_ghrsc and rx_ghrsc should be not NULL. Most message queue use cases come with
+ * a pair of message queues to facilitiate bidirectional communication. When tx_ghrsc is set,
+ * the client can send messages with mbox_send_message(gunyah_msgq_chan(msgq), msg). When rx_ghrsc
+ * is set, the mbox_client should register an .rx_callback() and the message queue driver will
+ * push all available messages upon receiving the RX ready interrupt. The messages should be
+ * consumed or copied by the client right away as the gunyah_msgq_rx_data will be replaced/destroyed
+ * after the callback.
+ *
+ * Returns - 0 on success, negative otherwise
+ */
+int gunyah_msgq_init(struct device *parent, struct gunyah_msgq *msgq, struct mbox_client *cl,
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
+	msgq->tx_ghrsc = *tx_ghrsc;
+	msgq->rx_ghrsc = *rx_ghrsc;
+
+	msgq->mbox.dev = parent;
+	msgq->mbox.ops = &gunyah_msgq_ops;
+	msgq->mbox.chans = kcalloc(1, sizeof(*msgq->mbox.chans), GFP_KERNEL);
+	msgq->mbox.num_chans = 1;
+	msgq->mbox.txdone_irq = true;
+
+	if (gh_msgq_has_tx(msgq)) {
+		ret = request_irq(msgq->tx_ghrsc.irq, gh_msgq_tx_irq_handler, 0, "gh_msgq_tx",
+				msgq);
+		if (ret)
+			goto err_chans;
+	}
+
+	if (gh_msgq_has_rx(msgq)) {
+		ret = request_threaded_irq(msgq->rx_ghrsc.irq, NULL, gh_msgq_rx_irq_handler,
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
+	ret = mbox_bind_client(gunyah_msgq_chan(msgq), cl);
+	if (ret)
+		goto err_mbox;
+
+	return 0;
+err_mbox:
+	mbox_controller_unregister(&msgq->mbox);
+err_rx_irq:
+	if (gh_msgq_has_rx(msgq))
+		free_irq(msgq->rx_ghrsc.irq, msgq);
+err_tx_irq:
+	if (gh_msgq_has_tx(msgq))
+		free_irq(msgq->tx_ghrsc.irq, msgq);
+err_chans:
+	kfree(msgq->mbox.chans);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gunyah_msgq_init);
+
+void gunyah_msgq_remove(struct gunyah_msgq *msgq)
+{
+	if (gh_msgq_has_tx(msgq))
+		free_irq(msgq->tx_ghrsc.irq, msgq);
+
+	kfree(msgq->mbox.chans);
+}
+EXPORT_SYMBOL_GPL(gunyah_msgq_remove);
diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
index 7ac917e0aa3f..f4c822a82f1a 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -4,6 +4,8 @@ config GUNYAH
 	tristate "Gunyah Virtualization drivers"
 	depends on ARM64
 	select AUXILIARY_BUS
+	select MAILBOX
+	select GUNYAH_MESSAGE_QUEUES
 	help
 	  The Gunyah drivers are the helper interfaces that runs in a guest VM
 	  such as basic inter-VM IPC and signaling mechanisms, and higher level
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
new file mode 100644
index 000000000000..d5e80e2defab
--- /dev/null
+++ b/include/linux/gunyah.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _GUNYAH_H
+#define _GUNYAH_H
+
+#include <linux/mailbox_controller.h>
+#include <linux/mailbox_client.h>
+#include <linux/interrupt.h>
+
+#include <asm-generic/gunyah.h>
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
+#define GH_MSGQ_MAX_MSG_SIZE	1024
+
+struct gunyah_msgq_tx_data {
+	size_t length;
+	bool push;
+	char data[];
+};
+
+struct gunyah_msgq_rx_data {
+	size_t length;
+	char data[GH_MSGQ_MAX_MSG_SIZE];
+};
+
+struct gunyah_msgq {
+	struct gunyah_resource tx_ghrsc;
+	struct gunyah_resource rx_ghrsc;
+
+	/* msgq private */
+	int last_status;
+	struct mbox_controller mbox;
+	struct tasklet_struct txdone_tasklet;
+};
+
+
+int gunyah_msgq_init(struct device *parent, struct gunyah_msgq *msgq, struct mbox_client *cl,
+		     struct gunyah_resource *tx_ghrsc, struct gunyah_resource *rx_ghrsc);
+void gunyah_msgq_remove(struct gunyah_msgq *msgq);
+
+static inline struct mbox_chan *gunyah_msgq_chan(struct gunyah_msgq *msgq)
+{
+	return &msgq->mbox.chans[0];
+}
+
+#endif
-- 
2.25.1

