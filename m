Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3366DAE96
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 16:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240334AbjDGOHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239731AbjDGOGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:06:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1013061BA;
        Fri,  7 Apr 2023 07:06:52 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337E1hs3024072;
        Fri, 7 Apr 2023 14:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=dR5hsH0YjVOrcxCTKV/JJnRf8WXDP6gF0YttNyCiG9k=;
 b=C9W7xb88LSAfAgfcvjxqKMQcd+tObj8IZO4xjOaSnHTxxeTejFW5cQ0aMYPFGnSMpaIc
 p4mJkNIAAEXNIGkBUXhszlX9Q2HMDLwe80cln0uZw0SW0oK7V5WxZD1pwjqmIMsFYQSC
 2eDLQtWpm3PkA51VPqMWWlK5G9O2+8/fXPbZiLLc3igwjWS79a5Hv/yLacLuVwofvz8e
 tN/KDV/PChYFzl4DTN4JRYyMvasGJKdnqiDe6USOPcPaVa9QNSW9PfLruBXfMj/cPeOo
 s77fECQcrl92J0PzJVWCzD/Sp+J2iogEvo2wPVmHCppWc2QTGMlfm/PYZzrA+k5VKLJ5 TA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ptb9wh2r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 14:06:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 337E6fQk029617
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Apr 2023 14:06:41 GMT
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 7 Apr 2023 07:06:36 -0700
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V2 2/3] soc: qcom: boot_stat: Add Driver Support for Boot Stats
Date:   Fri, 7 Apr 2023 19:34:36 +0530
Message-ID: <5eeeb46e9b3f61656a37cb77c2ad6a04e383c16d.1680874520.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1680874520.git.quic_schowdhu@quicinc.com>
References: <cover.1680874520.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: a2q5MDYc7Vq_tJORb45hiNNKpu5zcY-p
X-Proofpoint-ORIG-GUID: a2q5MDYc7Vq_tJORb45hiNNKpu5zcY-p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_08,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304070129
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of Qualcomm's proprietary Android boot-loaders capture boot time
stats, like the time when the bootloader started execution and at what
point the bootloader handed over control to the kernel etc. in the IMEM
region. This information is captured in a specific format by this driver
by mapping a structure to the IMEM memory region and then accessing the
members of the structure to print the information. This information is
useful in verifying if the existing boot KPIs have regressed or not.
A sample log in SM8450(waipio) device is as follows:-

KPI: Pre ABL Time = 3s
KPI: ABL Time = 14s
KPI: Kernel MPM timestamp = 890206

The Module Power Manager(MPM) sleep counter starts ticking at the PBL
stage and the timestamp generated by the sleep counter is logged by
the Qualcomm proprietary bootloader(ABL) at two points-> First when it
starts execution which is logged here as "Pre ABL Time" and the second
when it is about to load the kernel logged as "ABL Time". Both are
logged in the unit of seconds. The current kernel timestamp is
printed by the boot_stats driver as well.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 drivers/soc/qcom/Kconfig      |  7 ++++
 drivers/soc/qcom/Makefile     |  1 +
 drivers/soc/qcom/boot_stats.c | 95 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+)
 create mode 100644 drivers/soc/qcom/boot_stats.c

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index d11bda2..2cfdbb7 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -79,6 +79,13 @@ config QCOM_DCC
 	  driver provides interface to configure DCC block and read back
 	  captured data from DCC's internal SRAM.
 
+config QCOM_BOOTSTAT
+	tristate "Qualcomm Technologies, Boot Stat driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	help
+	  This option enables driver for boot stats. Boot stat driver prints
+	  the kernel bootloader information by accessing the imem region.
+
 config QCOM_KRYO_L2_ACCESSORS
 	bool
 	depends on ARCH_QCOM && ARM64 || COMPILE_TEST
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 3b92c6c..8a9d995 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
 obj-$(CONFIG_QCOM_CPR)		+= cpr.o
 obj-$(CONFIG_QCOM_DCC) += dcc.o
+obj-$(CONFIG_QCOM_BOOTSTAT) += boot_stats_new.o
 obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
 obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
 obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
diff --git a/drivers/soc/qcom/boot_stats.c b/drivers/soc/qcom/boot_stats.c
new file mode 100644
index 0000000..080e820
--- /dev/null
+++ b/drivers/soc/qcom/boot_stats.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2013-2019, 2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+
+#define MPM_COUNTER_FREQ 32768
+
+/**
+ *  struct boot_stats - timestamp information related to boot stats
+ *  @bootloader_start:  Time for the starting point of the abl bootloader
+ *  @bootloader_end:    Time when the kernel starts loading from abl bootloader
+ */
+struct boot_stats {
+	u32 bootloader_start;
+	u32 bootloader_end;
+} __packed;
+
+struct boot_stats __iomem *boot_stats;
+void __iomem *mpm_counter_base;
+
+static void print_boot_stats(void)
+{
+	u32 pre_abl_time = readl_relaxed(&boot_stats->bootloader_start) / MPM_COUNTER_FREQ;
+	u32 abl_time = readl_relaxed(&boot_stats->bootloader_end) / MPM_COUNTER_FREQ;
+
+	pr_info("KPI: Pre ABL Time = %us\n", pre_abl_time);
+	pr_info("KPI: ABL Time = %us\n", abl_time);
+	pr_info("KPI: Kernel MPM timestamp = %u\n", readl_relaxed(mpm_counter_base));
+}
+
+static int boot_stats_probe(struct platform_device *pdev)
+{
+	struct device_node *np_mpm2;
+	struct device *boot_stat = &pdev->dev;
+
+	boot_stats = of_iomap(boot_stat->of_node->child, 0);
+	if (!boot_stats)
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+					"failed to map imem region\n");
+
+	np_mpm2 = of_find_compatible_node(NULL, NULL,
+					  "qcom,mpm2-sleep-counter");
+	if (!np_mpm2) {
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "failed to get the counter node\n");
+	}
+
+	if (of_get_address(np_mpm2, 0, NULL, NULL)) {
+		mpm_counter_base = of_iomap(np_mpm2, 0);
+		if (!mpm_counter_base) {
+			return dev_err_probe(&pdev->dev, -ENOMEM,
+					     "failed to map the counter\n");
+		}
+	}
+	print_boot_stats();
+
+	return 0;
+}
+
+static int boot_stats_remove(struct platform_device *pdev)
+{
+	iounmap(boot_stats);
+	iounmap(mpm_counter_base);
+
+	return 0;
+}
+
+static const struct of_device_id boot_stats_dt_match[] = {
+	{ .compatible = "qcom,sm8450-imem" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, boot_stats_dt_match);
+
+static struct platform_driver boot_stat_driver = {
+	.probe  = boot_stats_probe,
+	.remove = boot_stats_remove,
+	.driver = {
+		.name = "qcom-boot-stats",
+		.of_match_table = boot_stats_dt_match,
+	},
+};
+module_platform_driver(boot_stat_driver);
+
+MODULE_DESCRIPTION("Qualcomm Technologies Inc. Boot Stat driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

