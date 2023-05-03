Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF726F5CA7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 19:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjECRGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 13:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjECRGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 13:06:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4952C5FF0;
        Wed,  3 May 2023 10:05:41 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343Bgvip022774;
        Wed, 3 May 2023 17:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ltKQHF5TVmeqGJiBA7tddD2qXFAEVZkhHMdeu+opXvQ=;
 b=fbAzv1EY4+LTtarPnTEHtYPkHx1ZzbWAA8x8t85KUhXwcFgPbS9tanz3VruHA5aVprWE
 QEFIZYfE2LGifWLrokqKQJTIVbBWK0ExVqIH5ZyUHKoAaEw/Y0/dHIRtxmqEwg2+fKra
 05mmUC+3ZCQpur0mMv0SXhUeZ0LRuN1M8jLqTY1qw2/HjVdJMibSIU2EF11hg/aUnbPs
 3spCg4hszEl6fWSnTZ7D/e69JPSfsyJSr5EtF+9Db5merSbHAKf+3xKSZTe1xtlvVtpn
 e/1Jv0ZcBc1WXZaBiJuSleY4QRKEzJtmI2hxiibL0ro9VwXeJGFktS8SzglIxMGkmRr7 Pg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qbk7sh7q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 17:04:12 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 343H3kZS007873
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 May 2023 17:03:46 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 3 May 2023 10:03:40 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <corbet@lwn.net>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v3 09/18] soc: qcom: Add qcom's pstore minidump driver support
Date:   Wed, 3 May 2023 22:32:23 +0530
Message-ID: <1683133352-10046-10-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VODEKwVhn-KW2YEDAvkXgoxUSIZ4ma8n
X-Proofpoint-GUID: VODEKwVhn-KW2YEDAvkXgoxUSIZ4ma8n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_12,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030146
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver was inspired from the fact pstore ram region should be
fixed and boot firmware need to have awarness about this region,
so that it will be persistent across boot. But, there are many
QCOM SoC which does not support warm boot from hardware but they
have minidump support from the software, and for them, there is
no need of this pstore ram region to be fixed, but at the same
time have interest in the pstore frontends. So, this driver
get the dynamic reserved region from the ram and register the
ramoops platform device.

 +---------+     +---------+   +--------+     +---------+
 | console |     | pmsg    |   | ftrace |     | dmesg   |
 +---------+     +---------+   +--------+     +---------+
       |             |             |              |
       |             |             |              |
       +------------------------------------------+
                          |
                         \ /
                  +----------------+
            (1)   |pstore frontends|
                  +----------------+
                          |
                         \ /
                 +------------------- +
            (2)  | pstore backend(ram)|
                 +--------------------+
                          |
                         \ /
                 +--------------------+
            (3)  |qcom_pstore_minidump|
                 +--------------------+
                          |
                         \ /
                   +---------------+
            (4)    | qcom_minidump |
                   +---------------+

This driver will route all the pstore front data to the stored
in qcom pstore reserved region and the reason of showing an
arrow from (3) to (4) as qcom_pstore_minidump driver will register
all the available frontends region with qcom minidump driver
in upcoming patch.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/soc/qcom/Kconfig                |  11 +++
 drivers/soc/qcom/Makefile               |   1 +
 drivers/soc/qcom/qcom_pstore_minidump.c | 116 ++++++++++++++++++++++++++++++++
 3 files changed, 128 insertions(+)
 create mode 100644 drivers/soc/qcom/qcom_pstore_minidump.c

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 15c931e..afdc634 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -293,4 +293,15 @@ config QCOM_MINIDUMP
 	  these selective regions will be dumped instead of the entire DDR.
 	  This saves significant amount of time and/or storage space.
 
+config QCOM_PSTORE_MINIDUMP
+	tristate "Pstore support for QCOM Minidump"
+	depends on ARCH_QCOM
+	depends on PSTORE_RAM
+	depends on QCOM_MINIDUMP
+	help
+	  Enablement of this driver ensures that ramoops region can be anywhere
+	  reserved in ram instead of being fixed address which needs boot firmware
+	  awareness. So, this driver creates plaform device and registers available
+	  frontend region with the Qualcomm's minidump driver.
+
 endmenu
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 1ebe081..02d30d7 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -34,3 +34,4 @@ obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
 obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
 obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= ice.o
 obj-$(CONFIG_QCOM_MINIDUMP) += qcom_minidump.o
+obj-$(CONFIG_QCOM_PSTORE_MINIDUMP) += qcom_pstore_minidump.o
diff --git a/drivers/soc/qcom/qcom_pstore_minidump.c b/drivers/soc/qcom/qcom_pstore_minidump.c
new file mode 100644
index 0000000..8d58500
--- /dev/null
+++ b/drivers/soc/qcom/qcom_pstore_minidump.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/pstore_ram.h>
+#include <soc/qcom/qcom_minidump.h>
+
+struct qcom_ramoops_config {
+	unsigned long	record_size;
+	unsigned long	console_size;
+	unsigned long	ftrace_size;
+	unsigned long	pmsg_size;
+	unsigned int	mem_type;
+	unsigned int	flags;
+	int		max_reason;
+};
+
+struct qcom_ramoops_dd {
+	struct ramoops_platform_data qcom_ramoops_pdata;
+	struct platform_device *ramoops_pdev;
+};
+
+static struct qcom_ramoops_config default_ramoops_config = {
+	.mem_type = 2,
+	.record_size = 0x0,
+	.console_size = 0x200000,
+	.ftrace_size = 0x0,
+	.pmsg_size = 0x0,
+};
+
+static struct qcom_ramoops_dd *qcom_rdd;
+static int qcom_ramoops_probe(struct platform_device *pdev)
+{
+	struct device_node *of_node = pdev->dev.of_node;
+	struct device_node *node;
+	const struct qcom_ramoops_config *cfg;
+	struct ramoops_platform_data *pdata;
+	struct reserved_mem *rmem;
+	long ret;
+
+	node = of_parse_phandle(of_node, "memory-region", 0);
+	if (!node)
+		return -ENODEV;
+
+	rmem = of_reserved_mem_lookup(node);
+	of_node_put(node);
+	if (!rmem) {
+		dev_err(&pdev->dev, "failed to locate DT /reserved-memory resource\n");
+		return -EINVAL;
+	}
+
+	qcom_rdd = devm_kzalloc(&pdev->dev, sizeof(*qcom_rdd), GFP_KERNEL);
+	if (!qcom_rdd)
+		return -ENOMEM;
+
+	cfg = of_device_get_match_data(&pdev->dev);
+	if (!cfg) {
+		dev_err(&pdev->dev, "failed to get supported matched data\n");
+		return -ENOENT;
+	}
+
+	pdata = &qcom_rdd->qcom_ramoops_pdata;
+	pdata->mem_size = rmem->size;
+	pdata->mem_address = rmem->base;
+	pdata->mem_type = cfg->mem_type;
+	pdata->record_size = cfg->record_size;
+	pdata->console_size = cfg->console_size;
+	pdata->ftrace_size = cfg->ftrace_size;
+	pdata->pmsg_size = cfg->pmsg_size;
+	pdata->max_reason = KMSG_DUMP_PANIC;
+
+	qcom_rdd->ramoops_pdev = platform_device_register_data(NULL, "ramoops", -1,
+							       pdata, sizeof(*pdata));
+	if (IS_ERR(qcom_rdd->ramoops_pdev)) {
+		ret = PTR_ERR(qcom_rdd->ramoops_pdev);
+		dev_err(&pdev->dev, "could not create platform device: %ld\n", ret);
+		qcom_rdd->ramoops_pdev = NULL;
+	}
+
+	return ret;
+}
+
+static int qcom_ramoops_remove(struct platform_device *pdev)
+{
+	platform_device_unregister(qcom_rdd->ramoops_pdev);
+	qcom_rdd->ramoops_pdev = NULL;
+
+	return 0;
+}
+
+static const struct of_device_id qcom_ramoops_of_match[] = {
+	{ .compatible = "qcom,sm8450-ramoops-minidump", .data = &default_ramoops_config },
+	{ .compatible = "qcom,ramoops-minidump", .data = &default_ramoops_config },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, qcom_ramoops_of_match);
+static struct platform_driver qcom_ramoops_drv = {
+	.driver		= {
+		.name	= "qcom,ramoops-minidump",
+		.of_match_table = qcom_ramoops_of_match,
+	},
+	.probe = qcom_ramoops_probe,
+	.remove = qcom_ramoops_remove,
+};
+
+module_platform_driver(qcom_ramoops_drv);
+
+MODULE_DESCRIPTION("Qualcomm minidump pstore driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

