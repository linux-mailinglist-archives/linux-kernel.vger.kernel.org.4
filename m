Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6260164B6C4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbiLMOGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbiLMOFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:05:53 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7933A20F5A;
        Tue, 13 Dec 2022 06:05:40 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDDhTwT015709;
        Tue, 13 Dec 2022 14:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=7+F7z+Ta8EpscKUbPoTu/myv8SUS28PNc0GSWR9l3dY=;
 b=MPMFy4o3NF8jUQRCJwRMKvFj48hAppxtMyI3OZvX/lBkDEvOKARM9yEdDrPz/K1pt9+l
 Oh3JpL8yD+9BbByrIbr0Dx3NbnP89RJ69OQHYPZ/PGDp0M3u40XVfMMWD3ZTls2+3yQp
 Gzp5F2mecq4XITEYvQ1ZSO3kIudwjiDaBtJAObO+VnKmsgvcZ16Lyhv2Z8mB4hhflF7i
 2g6SbX+6no3mRp4SxduOS1wfvMXQwhayL+ubjwaZmWhUF5hzBz9EnbdSB7ihBxdZlXLi
 djTqAfL4FAt68cGhlH/sOO0Ew90NAxK2bgwLziNTFgZbt1ov5Za6ZyIZV0Ts3ABTDEVi hw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mej4w9dv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 14:05:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BDE51kN024525
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 14:05:01 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 13 Dec 2022 06:04:56 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <konrad.dybcio@somainline.org>,
        <amit.pundir@linaro.org>, <regressions@leemhuis.info>,
        <sumit.semwal@linaro.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, <robin.murphy@arm.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Gaurav Kohli <gkohli@codeaurora.org>
Subject: [PATCH 2/2] mailbox: Add support for QTI CPUCP mailbox controller
Date:   Tue, 13 Dec 2022 19:34:09 +0530
Message-ID: <20221213140409.772-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221213140409.772-1-quic_sibis@quicinc.com>
References: <20221213140409.772-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -rzQYEfOF2ROQyWGtM2BHjv3g9a5wfIk
X-Proofpoint-GUID: -rzQYEfOF2ROQyWGtM2BHjv3g9a5wfIk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1011 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212130125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for CPUSS Control Processor (CPUCP) mailbox controller,
this driver enables communication between AP and CPUCP by acting as
a doorbell between them.

Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>
[sibis: moved to mailbox and misc. cleanups]
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/mailbox/Kconfig           |   9 ++
 drivers/mailbox/Makefile          |   2 +
 drivers/mailbox/qcom-cpucp-mbox.c | 176 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 187 insertions(+)
 create mode 100644 drivers/mailbox/qcom-cpucp-mbox.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 05d6fae800e3..7766e0ad2f12 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -284,6 +284,15 @@ config SPRD_MBOX
 	  to send message between application processors and MCU. Say Y here if
 	  you want to build the Spreatrum mailbox controller driver.
 
+config QCOM_CPUCP_MBOX
+	tristate "Qualcomm Technologies, Inc. CPUCP mailbox driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	help
+	  Qualcomm Technologies, Inc. CPUSS Control Processor (CPUCP) mailbox
+	  controller driver enables communication between AP and CPUCP by
+	  acting as a doorbell between them. Say Y here if you want to build
+	  this driver.
+
 config QCOM_IPCC
 	tristate "Qualcomm Technologies, Inc. IPCC driver"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index fc9376117111..195b7e40541f 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -59,6 +59,8 @@ obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
 
 obj-$(CONFIG_SPRD_MBOX)		+= sprd-mailbox.o
 
+obj-$(CONFIG_QCOM_CPUCP_MBOX)	+= qcom-cpucp-mbox.o
+
 obj-$(CONFIG_QCOM_IPCC)		+= qcom-ipcc.o
 
 obj-$(CONFIG_APPLE_MAILBOX)	+= apple-mailbox.o
diff --git a/drivers/mailbox/qcom-cpucp-mbox.c b/drivers/mailbox/qcom-cpucp-mbox.c
new file mode 100644
index 000000000000..063bb2d80f3e
--- /dev/null
+++ b/drivers/mailbox/qcom-cpucp-mbox.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+/* CPUCP Register offsets */
+#define CPUCP_INTR_CLEAR_REG		0x8
+#define CPUCP_INTR_STATUS_REG		0xC
+#define CPUCP_SEND_IRQ_REG		0xC
+
+#define CPUCP_IRQ_CLEAR			BIT(3)
+#define CPUCP_IRQ_STATUS_ASSERTED	BIT(3)
+#define CPUCP_SEND_IRQ			BIT(28)
+
+/**
+ * struct qcom_cpucp_mbox - Holder for the mailbox driver
+ * @mbox:			The mailbox controller
+ * @chan:			The mailbox channel
+ * @tx_base:			Base address of the CPUCP tx registers
+ * @rx_base:			Base address of the CPUCP rx registers
+ * @dev:			Device associated with this instance
+ * @lock:			Lock protecting private
+ * @irq:			CPUCP to AP irq
+ */
+struct qcom_cpucp_mbox {
+	struct mbox_controller mbox;
+	struct mbox_chan chan;
+	void __iomem *tx_base;
+	void __iomem *rx_base;
+	struct device *dev;
+	int irq;
+
+	/* control access to the chan private data */
+	spinlock_t lock;
+};
+
+static inline struct qcom_cpucp_mbox *to_qcom_cpucp_mbox(struct mbox_controller *mbox)
+{
+	return container_of(mbox, struct qcom_cpucp_mbox, mbox);
+}
+
+static irqreturn_t qcom_cpucp_mbox_irq_fn(int irq, void *data)
+{
+	struct qcom_cpucp_mbox *cpucp = data;
+	unsigned long flags;
+	u32 val;
+
+	val = readl(cpucp->rx_base + CPUCP_INTR_STATUS_REG);
+	if (val & CPUCP_IRQ_STATUS_ASSERTED) {
+		writel(CPUCP_IRQ_CLEAR, cpucp->rx_base + CPUCP_INTR_CLEAR_REG);
+
+		spin_lock_irqsave(&cpucp->lock, flags);
+		if (cpucp->chan.con_priv)
+			mbox_chan_received_data(&cpucp->chan, NULL);
+		spin_unlock_irqrestore(&cpucp->lock, flags);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int qcom_cpucp_mbox_send_data(struct mbox_chan *chan, void *data)
+{
+	struct qcom_cpucp_mbox *cpucp = to_qcom_cpucp_mbox(chan->mbox);
+
+	writel(CPUCP_SEND_IRQ, cpucp->tx_base + CPUCP_SEND_IRQ_REG);
+
+	return 0;
+}
+
+static void qcom_cpucp_mbox_shutdown(struct mbox_chan *chan)
+{
+	struct qcom_cpucp_mbox *cpucp = to_qcom_cpucp_mbox(chan->mbox);
+	unsigned long flags;
+
+	spin_lock_irqsave(&cpucp->lock, flags);
+	chan->con_priv = NULL;
+	spin_unlock_irqrestore(&cpucp->lock, flags);
+}
+
+static const struct mbox_chan_ops cpucp_mbox_chan_ops = {
+	.send_data = qcom_cpucp_mbox_send_data,
+	.shutdown = qcom_cpucp_mbox_shutdown
+};
+
+static struct mbox_chan *qcom_cpucp_mbox_xlate(struct mbox_controller *mbox,
+					       const struct of_phandle_args *ph)
+{
+	struct qcom_cpucp_mbox *cpucp = to_qcom_cpucp_mbox(mbox);
+
+	if (ph->args_count != 0)
+		return ERR_PTR(-EINVAL);
+
+	if (mbox->chans[0].con_priv)
+		return ERR_PTR(-EBUSY);
+
+	mbox->chans[0].con_priv = cpucp;
+
+	return &mbox->chans[0];
+}
+
+static int qcom_cpucp_mbox_probe(struct platform_device *pdev)
+{
+	struct qcom_cpucp_mbox *cpucp;
+	struct mbox_controller *mbox;
+	int ret;
+
+	cpucp = devm_kzalloc(&pdev->dev, sizeof(*cpucp), GFP_KERNEL);
+	if (!cpucp)
+		return -ENOMEM;
+
+	spin_lock_init(&cpucp->lock);
+	cpucp->dev = &pdev->dev;
+
+	cpucp->tx_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(cpucp->tx_base))
+		return PTR_ERR(cpucp->tx_base);
+
+	cpucp->rx_base = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(cpucp->rx_base))
+		return PTR_ERR(cpucp->rx_base);
+
+	cpucp->irq = platform_get_irq(pdev, 0);
+	if (cpucp->irq < 0)
+		return cpucp->irq;
+
+	mbox = &cpucp->mbox;
+	mbox->dev = cpucp->dev;
+	mbox->num_chans = 1;
+	mbox->chans = &cpucp->chan;
+	mbox->ops = &cpucp_mbox_chan_ops;
+	mbox->of_xlate = qcom_cpucp_mbox_xlate;
+	mbox->txdone_irq = false;
+	mbox->txdone_poll = false;
+
+	ret = devm_mbox_controller_register(&pdev->dev, mbox);
+	if (ret)
+		return ret;
+
+	ret = devm_request_irq(&pdev->dev, cpucp->irq, qcom_cpucp_mbox_irq_fn,
+			       IRQF_TRIGGER_HIGH | IRQF_NO_SUSPEND, "qcom_cpucp_mbox", cpucp);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register the irq: %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, cpucp);
+
+	return 0;
+}
+
+static const struct of_device_id qcom_cpucp_mbox_of_match[] = {
+	{ .compatible = "qcom,cpucp-mbox"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, qcom_cpucp_mbox_of_match);
+
+static struct platform_driver qcom_cpucp_mbox_driver = {
+	.probe = qcom_cpucp_mbox_probe,
+	.driver = {
+		.name = "qcom_cpucp_mbox",
+		.of_match_table = qcom_cpucp_mbox_of_match,
+	},
+};
+module_platform_driver(qcom_cpucp_mbox_driver);
+
+MODULE_AUTHOR("Gaurav Kohli <gkohli@codeaurora.org>");
+MODULE_AUTHOR("Sibi Sankar <quic_sibis@qti.qualcomm.com>");
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. CPUSS Control Processor Mailbox driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

