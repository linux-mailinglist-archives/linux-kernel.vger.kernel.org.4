Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DEE6EB7DD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 09:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjDVHi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 03:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjDVHiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 03:38:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F71D1BC5;
        Sat, 22 Apr 2023 00:38:06 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33M7Wnnj032162;
        Sat, 22 Apr 2023 07:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=cCCZYAS2/s8RWHNCco2a0RAur54j7AIPIzJr3VO0/vY=;
 b=jpty315bCqWcFyo/DoIXxM4MDwzxWHStLLAmzx4feSIu41XTpUx8xwvZTjTLXChZeTYs
 Bpgm4x966aEuuQkkqN6yaHw9rBmeePrx0AQBf8wbMhXhL5oJ/QCBX3w4gWelEJ7TFjM9
 As46stYG8YPrnsTuGwXmfGIaMT5hekHnvoqy1LKldWwZRtihLbfCgdcgQ2knLVnYgHyO
 lhU66OVP98jegT26JE1X6uKDfsnMgv4YMHG2GnFosOWq1cEMCn4SKfM5EGhazFSJMwnX
 Uq2cpOAqV34jnQgsI6DvA9i5lkHCANdTFxaXr0zv+ucW7vC7KnzDd3+nKe8LHYErDckg Gw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q48e1r5mk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Apr 2023 07:37:46 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33M7bjV6007658
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Apr 2023 07:37:45 GMT
Received: from hazha-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sat, 22 Apr 2023 00:37:39 -0700
From:   Hao Zhang <quic_hazha@quicinc.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Hao Zhang <quic_hazha@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v3 1/3] Coresight: Add coresight dummy driver
Date:   Sat, 22 Apr 2023 15:37:12 +0800
Message-ID: <20230422073714.38844-2-quic_hazha@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230422073714.38844-1-quic_hazha@quicinc.com>
References: <20230422073714.38844-1-quic_hazha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: X86axpGb_sjpFv6MYDYGnvkI6Cnp1Fq_
X-Proofpoint-ORIG-GUID: X86axpGb_sjpFv6MYDYGnvkI6Cnp1Fq_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_08,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304220064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Coresight devices that kernel don't have permission to access or
configure. So there need driver to register dummy devices as Coresight
devices. It may also be used to define components that may not have
any programming interfaces (e.g, static links), so that paths can be
established in the driver. Provide Coresight API for dummy device
operations, such as enabling and disabling dummy devices. Build the
Coresight path for dummy sink or dummy source for debugging.

Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
---
 drivers/hwtracing/coresight/Kconfig           |  11 ++
 drivers/hwtracing/coresight/Makefile          |   1 +
 drivers/hwtracing/coresight/coresight-dummy.c | 179 ++++++++++++++++++
 include/linux/coresight.h                     |   1 +
 4 files changed, 192 insertions(+)
 create mode 100644 drivers/hwtracing/coresight/coresight-dummy.c

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 2b5bbfffbc4f..06f0a7594169 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -236,4 +236,15 @@ config CORESIGHT_TPDA
 
 	  To compile this driver as a module, choose M here: the module will be
 	  called coresight-tpda.
+
+config CORESIGHT_DUMMY
+	tristate "Dummy driver support"
+	help
+	  Enables support for dummy driver. Dummy driver can be used for
+	  CoreSight sources/sinks that are owned and configured by some
+	  other subsystem and use Linux drivers to configure rest of trace
+	  path.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called coresight-dummy.
 endif
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 33bcc3f7b8ae..995d3b2c76df 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -30,3 +30,4 @@ obj-$(CONFIG_CORESIGHT_TPDA) += coresight-tpda.o
 coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
 		   coresight-cti-sysfs.o
 obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
+obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
diff --git a/drivers/hwtracing/coresight/coresight-dummy.c b/drivers/hwtracing/coresight/coresight-dummy.c
new file mode 100644
index 000000000000..1fb8b3d1c170
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-dummy.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/coresight.h>
+#include <linux/of.h>
+#include <linux/pm_runtime.h>
+
+#include "coresight-priv.h"
+#include "coresight-trace-id.h"
+
+struct dummy_drvdata {
+	struct device			*dev;
+	struct coresight_device		*csdev;
+	int				traceid;
+};
+
+DEFINE_CORESIGHT_DEVLIST(source_devs, "dummy_source");
+DEFINE_CORESIGHT_DEVLIST(sink_devs, "dummy_sink");
+
+static int dummy_source_enable(struct coresight_device *csdev,
+			       struct perf_event *event, u32 mode)
+{
+	struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	dev_dbg(drvdata->dev, "Dummy source enabled\n");
+
+	return 0;
+}
+
+static void dummy_source_disable(struct coresight_device *csdev,
+				 struct perf_event *event)
+{
+	struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	dev_dbg(drvdata->dev, "Dummy source disabled\n");
+}
+
+static int dummy_sink_enable(struct coresight_device *csdev, u32 mode,
+				void *data)
+{
+	struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	dev_dbg(drvdata->dev, "Dummy sink enabled\n");
+
+	return 0;
+}
+
+static int dummy_sink_disable(struct coresight_device *csdev)
+{
+	struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	dev_dbg(drvdata->dev, "Dummy sink disabled\n");
+
+	return 0;
+}
+
+static const struct coresight_ops_source dummy_source_ops = {
+	.enable	= dummy_source_enable,
+	.disable = dummy_source_disable,
+};
+
+static const struct coresight_ops dummy_source_cs_ops = {
+	.source_ops = &dummy_source_ops,
+};
+
+static const struct coresight_ops_sink dummy_sink_ops = {
+	.enable	= dummy_sink_enable,
+	.disable = dummy_sink_disable,
+};
+
+static const struct coresight_ops dummy_sink_cs_ops = {
+	.sink_ops = &dummy_sink_ops,
+};
+
+static int dummy_probe(struct platform_device *pdev)
+{
+	int trace_id;
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct coresight_platform_data *pdata;
+	struct dummy_drvdata *drvdata;
+	struct coresight_desc desc = { 0 };
+
+	if (of_device_is_compatible(node, "arm,coresight-dummy-source")) {
+		trace_id = coresight_trace_id_get_system_id();
+		if (trace_id < 0)
+			return trace_id;
+
+		desc.name = coresight_alloc_device_name(&source_devs, dev);
+		if (!desc.name)
+			return -ENOMEM;
+
+		desc.type = CORESIGHT_DEV_TYPE_SOURCE;
+		desc.subtype.source_subtype =
+					CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS;
+		desc.ops = &dummy_source_cs_ops;
+	} else if (of_device_is_compatible(node, "arm,coresight-dummy-sink")) {
+		desc.name = coresight_alloc_device_name(&sink_devs, dev);
+		if (!desc.name)
+			return -ENOMEM;
+
+		desc.type = CORESIGHT_DEV_TYPE_SINK;
+		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_DUMMY;
+		desc.ops = &dummy_sink_cs_ops;
+	} else {
+		dev_err(dev, "Device type not set\n");
+		return -EINVAL;
+	}
+
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+	pdev->dev.platform_data = pdata;
+
+	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	drvdata->dev = &pdev->dev;
+	platform_set_drvdata(pdev, drvdata);
+
+	desc.pdata = pdev->dev.platform_data;
+	desc.dev = &pdev->dev;
+	drvdata->csdev = coresight_register(&desc);
+	if (IS_ERR(drvdata->csdev))
+		return PTR_ERR(drvdata->csdev);
+
+	drvdata->traceid = (u8)trace_id;
+
+	pm_runtime_enable(dev);
+	dev_dbg(dev, "Dummy device initialized\n");
+
+	return 0;
+}
+
+static int dummy_remove(struct platform_device *pdev)
+{
+	struct dummy_drvdata *drvdata = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	pm_runtime_disable(dev);
+	coresight_unregister(drvdata->csdev);
+	return 0;
+}
+
+static const struct of_device_id dummy_match[] = {
+	{.compatible = "arm,coresight-dummy-source"},
+	{.compatible = "arm,coresight-dummy-sink"},
+	{},
+};
+
+static struct platform_driver dummy_driver = {
+	.probe	= dummy_probe,
+	.remove	= dummy_remove,
+	.driver	= {
+		.name   = "coresight-dummy",
+		.of_match_table = dummy_match,
+	},
+};
+
+static int __init dummy_init(void)
+{
+	return platform_driver_register(&dummy_driver);
+}
+module_init(dummy_init);
+
+static void __exit dummy_exit(void)
+{
+	platform_driver_unregister(&dummy_driver);
+}
+module_exit(dummy_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("CoreSight dummy driver");
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index f19a47b9bb5a..6db4b49751cf 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -45,6 +45,7 @@ enum coresight_dev_type {
 };
 
 enum coresight_dev_subtype_sink {
+	CORESIGHT_DEV_SUBTYPE_SINK_DUMMY,
 	CORESIGHT_DEV_SUBTYPE_SINK_PORT,
 	CORESIGHT_DEV_SUBTYPE_SINK_BUFFER,
 	CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM,
-- 
2.17.1

