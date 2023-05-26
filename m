Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86967129A8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243829AbjEZPf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjEZPfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:35:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE818F3;
        Fri, 26 May 2023 08:35:49 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QCg8K5027567;
        Fri, 26 May 2023 15:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=JmY/qbIJf4XRSV+xVUV0gLqFi8wNBVaoQrbtqYHroNQ=;
 b=HmjllaehDGFic1WGDtPZA19uaN0fXccf41kd1H3ld0SeXP2NW4Ko8VIoh/7qOJVeaWs7
 Zrh7yDPP+rP4NR/ZCIkh72qHdxblfdjHQltqqafbIlLG8lG4h4AVz85gck9kMG8+BVJ3
 R6XtANvAgJwT5rXZ+vlglDZXAVGXbSBVJolHS/uBES3v29s/XDJPCFDOp5fYZIYvceRc
 qBekNYP/GiFmlqir0ZHC3pWRtFmaUqU1F58diHsyKSE1+ntDo/SsgicPGcOZm1tggva0
 m/IP1WG2yXdeGfDs0ffZKLlck9PXxzjYJ3QXZ6WkOY5Md6LV3S8D0cgW5T20pGrqI8JW mw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qt47eugnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 15:35:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34QFZX1a023702
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 15:35:33 GMT
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 26 May 2023 08:35:30 -0700
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        "Tao Zhang" <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
Subject: [PATCH v1 1/3] Coresight: Add driver to support for CSR
Date:   Fri, 26 May 2023 23:35:06 +0800
Message-ID: <20230526153508.6208-2-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230526153508.6208-1-quic_jinlmao@quicinc.com>
References: <20230526153508.6208-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QJpQr7zVbAl72pYRoQb5R89dwx8dlE9x
X-Proofpoint-ORIG-GUID: QJpQr7zVbAl72pYRoQb5R89dwx8dlE9x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_06,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260131
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver provides support for CoreSight Slave Register block
that hosts miscellaneous configuration registers. Those
configuration registers can be used to control, various coresight
configurations.

Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 drivers/hwtracing/coresight/Kconfig         |  12 ++
 drivers/hwtracing/coresight/Makefile        |   1 +
 drivers/hwtracing/coresight/coresight-csr.c | 142 ++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-csr.h |  54 ++++++++
 4 files changed, 209 insertions(+)
 create mode 100644 drivers/hwtracing/coresight/coresight-csr.c
 create mode 100644 drivers/hwtracing/coresight/coresight-csr.h

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 2b5bbfffbc4f..e769ea3709d9 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -236,4 +236,16 @@ config CORESIGHT_TPDA
 
 	  To compile this driver as a module, choose M here: the module will be
 	  called coresight-tpda.
+
+config CORESIGHT_CSR
+	tristate "CoreSight Slave Register driver"
+	help
+	  This driver provides support for CoreSight Slave Register block
+	  that hosts miscellaneous configuration registers.
+	  Those configuration registers can be used to control, various
+	  coresight configurations.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called coresight-csr.
+
 endif
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 33bcc3f7b8ae..956c642d05f6 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -30,3 +30,4 @@ obj-$(CONFIG_CORESIGHT_TPDA) += coresight-tpda.o
 coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
 		   coresight-cti-sysfs.o
 obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
+obj-$(CONFIG_CORESIGHT_CSR) += coresight-csr.o
diff --git a/drivers/hwtracing/coresight/coresight-csr.c b/drivers/hwtracing/coresight/coresight-csr.c
new file mode 100644
index 000000000000..a1403e8531ee
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-csr.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+
+#include "coresight-priv.h"
+#include "coresight-csr.h"
+
+DEFINE_CORESIGHT_DEVLIST(csr_devs, "csr");
+
+static LIST_HEAD(csr_list);
+
+/*
+ * Get the CSR by name.
+ */
+struct coresight_csr *coresight_csr_get(const char *name)
+{
+	struct coresight_csr *csr;
+
+	list_for_each_entry(csr, &csr_list, link) {
+		if (!strcmp(csr->name, name))
+			return csr;
+	}
+	return ERR_PTR(-EINVAL);
+}
+EXPORT_SYMBOL(coresight_csr_get);
+
+/*
+ * Get the device node's name from device tree.
+ */
+int of_get_coresight_csr_name(struct device_node *node, const char **csr_name)
+{
+	struct device_node *csr_node;
+
+	csr_node = of_parse_phandle(node, "coresight-csr", 0);
+	if (!csr_node)
+		return -EINVAL;
+
+	*csr_name = csr_node->full_name;
+	of_node_put(csr_node);
+	return 0;
+}
+EXPORT_SYMBOL(of_get_coresight_csr_name);
+
+static int csr_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct coresight_platform_data *pdata;
+	struct csr_drvdata *drvdata;
+	struct resource *res;
+	struct coresight_desc desc = { 0 };
+
+	desc.name = coresight_alloc_device_name(&csr_devs, dev);
+	if (!desc.name)
+		return -ENOMEM;
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+	pdev->dev.platform_data = pdata;
+
+	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+	drvdata->dev = &pdev->dev;
+	platform_set_drvdata(pdev, drvdata);
+
+	drvdata->clk = devm_clk_get(dev, "apb_pclk");
+	if (IS_ERR(drvdata->clk))
+		dev_dbg(dev, "csr not config clk\n");
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "csr-base");
+	if (!res)
+		return -ENODEV;
+	drvdata->pbase = res->start;
+
+	drvdata->base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!drvdata->base)
+		return -ENOMEM;
+
+	desc.type = CORESIGHT_DEV_TYPE_HELPER;
+	desc.pdata = pdev->dev.platform_data;
+	desc.dev = &pdev->dev;
+
+	drvdata->csdev = coresight_register(&desc);
+	if (IS_ERR(drvdata->csdev))
+		return PTR_ERR(drvdata->csdev);
+
+	spin_lock_init(&drvdata->spin_lock);
+	drvdata->csr.name = pdev->dev.of_node->full_name;
+
+	list_add_tail(&drvdata->csr.link, &csr_list);
+
+	dev_dbg(dev, "CSR initialized: %s\n", drvdata->csr.name);
+	return 0;
+}
+
+static int csr_remove(struct platform_device *pdev)
+{
+	struct csr_drvdata *drvdata = platform_get_drvdata(pdev);
+
+	list_del(&drvdata->csr.link);
+	coresight_unregister(drvdata->csdev);
+	return 0;
+}
+
+static const struct of_device_id csr_match[] = {
+	{.compatible = "qcom,coresight-csr"},
+	{}
+};
+
+static struct platform_driver csr_driver = {
+	.probe          = csr_probe,
+	.remove         = csr_remove,
+	.driver         = {
+		.name   = "coresight-csr",
+		.of_match_table = csr_match,
+		.suppress_bind_attrs = true,
+	},
+};
+
+static int __init csr_init(void)
+{
+	return platform_driver_register(&csr_driver);
+}
+module_init(csr_init);
+
+static void __exit csr_exit(void)
+{
+	platform_driver_unregister(&csr_driver);
+}
+module_exit(csr_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("CoreSight CSR driver");
diff --git a/drivers/hwtracing/coresight/coresight-csr.h b/drivers/hwtracing/coresight/coresight-csr.h
new file mode 100644
index 000000000000..3fd24b8e28e8
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-csr.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _CORESIGHT_CSR_H
+#define _CORESIGHT_CSR_H
+#include <linux/clk.h>
+#include <linux/coresight.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+
+struct coresight_csr {
+	const char *name;
+	struct list_head link;
+};
+
+/**
+ * struct csr_drvdata - specifics for the CSR device.
+ * @base:	Memory mapped base address for this component.
+ * @pbase:	Physical address base.
+ * @dev:	The device entity associated to this component.
+ * @csdev:	Data struct for coresight device.
+ * @csr:	CSR struct
+ * @clk:	Clock of this component.
+ * @spin_lock:	Spin lock for the data.
+ */
+struct csr_drvdata {
+	void __iomem		*base;
+	phys_addr_t		pbase;
+	struct device		*dev;
+	struct coresight_device	*csdev;
+	struct coresight_csr	csr;
+	struct clk		*clk;
+	spinlock_t		spin_lock;
+};
+#if IS_ENABLED(CONFIG_CORESIGHT_CSR)
+extern void coresight_csr_set_byte_cntr(struct coresight_csr *csr, uint32_t count);
+extern struct coresight_csr *coresight_csr_get(const char *name);
+#if IS_ENABLED(CONFIG_OF)
+extern int of_get_coresight_csr_name(struct device_node *node,
+				const char **csr_name);
+#else
+static inline int of_get_coresight_csr_name(struct device_node *node,
+		const char **csr_name){ return -EINVAL; }
+#endif
+#else
+static inline void coresight_csr_set_byte_cntr(struct coresight_csr *csr, int irqctrl_offset,
+					   uint32_t count) {}
+static inline struct coresight_csr *coresight_csr_get(const char *name)
+					{ return NULL; }
+#endif
+#endif
+
-- 
2.17.1

