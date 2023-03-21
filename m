Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3940F6C336E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjCUNxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjCUNxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:53:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2268E4FAB7;
        Tue, 21 Mar 2023 06:53:23 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32L5VOWo005702;
        Tue, 21 Mar 2023 13:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=U8UOMbDwFI06IsZqUd4WADb+CIUPSSIb2pfTfxi6t7s=;
 b=ccB9TttkRBJ2VjwW02fDNlTKclqp1bwK5agdnoOvUjf2oKTF0q7Se82aLZv7+4g00M+D
 AH1StuGS/OOZlFV8e4KFzEMd/kdSimGBwioKMYlEim9DxJAE3UgVkmztUfcheldOiouI
 lNAZ3PenwT44z5BiWE6hzpOlF57T0+vVmDW4sJI3t0LOmp8TehuetpiSte5rdC0MOrg8
 OHTlAj4B8fKmGSMZ1iSW+0/YuDZuXBq3JyEJFEJWYcOB4bCBbOPmeCYTH1O3B85z4bRa
 u0/3GlYBUpbtSko+SLC6YuZyse6B6tX6f6L3qEpnRhDbLkoCH4QI9RTuhiYDE+njT6Mt QQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pesyy355k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 13:53:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32LDr6OH015433
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 13:53:06 GMT
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 21 Mar 2023 06:53:02 -0700
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
Subject: [PATCH V1 3/4] soc: qcom: boot_stat: Add Driver Support for Boot Stats
Date:   Tue, 21 Mar 2023 19:21:50 +0530
Message-ID: <3f385562845ae26d519940ca8098fde89282991b.1679403696.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1679403696.git.quic_schowdhu@quicinc.com>
References: <cover.1679403696.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b_e5YTNIaUz7fmHAg2i6iLeB3DbKnGvS
X-Proofpoint-ORIG-GUID: b_e5YTNIaUz7fmHAg2i6iLeB3DbKnGvS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_10,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210108
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/soc/qcom/Kconfig      |   7 +++
 drivers/soc/qcom/Makefile     |   1 +
 drivers/soc/qcom/boot_stats.c | 108 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+)
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
index 3b92c6c..e9b1e52 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
 obj-$(CONFIG_QCOM_CPR)		+= cpr.o
 obj-$(CONFIG_QCOM_DCC) += dcc.o
+obj-$(CONFIG_QCOM_BOOTSTAT) += boot_stats.o
 obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
 obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
 obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
diff --git a/drivers/soc/qcom/boot_stats.c b/drivers/soc/qcom/boot_stats.c
new file mode 100644
index 0000000..59b5ab6
--- /dev/null
+++ b/drivers/soc/qcom/boot_stats.c
@@ -0,0 +1,108 @@
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
+/**
+ *  struct boot_stats - timestamp information related to boot stats
+ *  @bootloader_start:	Time for the starting point of the abl bootloader
+ *  @bootloader_end:	Time when the kernel starts loading from abl bootloader
+ */
+struct boot_stats {
+	u32 bootloader_start;
+	u32 bootloader_end;
+} __packed;
+
+static struct boot_stats __iomem *boot_stats;
+static void __iomem *mpm_counter_base;
+static u32 mpm_counter_freq;
+
+static int mpm_parse_dt(void)
+{
+	struct device_node *np_imem, *np_mpm2;
+
+	np_imem = of_find_compatible_node(NULL, NULL,
+					  "qcom,imem-boot_stats");
+	if (!np_imem) {
+		pr_err("can't find qcom,imem node\n");
+		return -ENODEV;
+	}
+	boot_stats = of_iomap(np_imem, 0);
+	if (!boot_stats) {
+		pr_err("boot_stats: Can't map imem\n");
+		goto err1;
+	}
+
+	np_mpm2 = of_find_compatible_node(NULL, NULL,
+					  "qcom,mpm2-sleep-counter");
+	if (!np_mpm2) {
+		pr_err("mpm_counter: can't find DT node\n");
+		goto err2;
+	}
+
+	if (of_property_read_u32(np_mpm2, "clock-frequency", &mpm_counter_freq))
+		goto err2;
+
+	if (of_get_address(np_mpm2, 0, NULL, NULL)) {
+		mpm_counter_base = of_iomap(np_mpm2, 0);
+		if (!mpm_counter_base) {
+			pr_err("mpm_counter: can't map counter base\n");
+			goto err2;
+		}
+	} else {
+		goto err2;
+	}
+
+	return 0;
+
+err2:
+	of_node_put(np_mpm2);
+err1:
+	of_node_put(np_imem);
+	return -ENODEV;
+}
+
+static void print_boot_stats(void)
+{
+	u32 pre_abl_time = readl_relaxed(&boot_stats->bootloader_start) / mpm_counter_freq;
+	u32 abl_time = readl_relaxed(&boot_stats->bootloader_end) / mpm_counter_freq;
+
+	pr_info("KPI: Pre ABL Time = %us\n", pre_abl_time);
+	pr_info("KPI: ABL Time = %us\n", abl_time);
+	pr_info("KPI: Kernel MPM timestamp = %u\n", readl_relaxed(mpm_counter_base));
+}
+
+static int __init boot_stats_init(void)
+{
+	int ret;
+
+	ret = mpm_parse_dt();
+	if (ret < 0)
+		return -ENODEV;
+
+	print_boot_stats();
+
+	iounmap(boot_stats);
+	iounmap(mpm_counter_base);
+
+	return 0;
+}
+module_init(boot_stats_init);
+
+static void __exit boot_stats_exit(void)
+{
+}
+module_exit(boot_stats_exit)
+
+MODULE_DESCRIPTION("Qualcomm Technologies Inc. Boot Stat driver");
+MODULE_LICENSE("GPL");
--
2.7.4

