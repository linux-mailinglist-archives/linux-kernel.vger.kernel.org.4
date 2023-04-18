Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E16A6E599E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjDRGqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjDRGqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:46:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15F540DC;
        Mon, 17 Apr 2023 23:46:43 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I6Lc8g008942;
        Tue, 18 Apr 2023 06:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=3QUMVJZYbZcnwqGMQhM5R0p/9kYPOiZZKwn+2pmfj88=;
 b=DxmK12siI0D7cwyAYIZpT9Rv4OZRkkl+bw2M2r8F6dwcrdXOpteGG9fAYhzz66n5+d/C
 SYRhuAuMTj1YaaFjIyOAbnLlc4myX3U4f+KHypAvaVi4PbK0Gr3xGgV2kdzF+ki0Rs4P
 W/2XXivE+vdN9Gt+hJgMLovRXQnkYgyS/hRnJruVpymI/20qHclfzb96v6R8UfI9UZSl
 /JAmN+wJB66cl7uHCn4mR4+EyzYC4XDHpX1fsKG9buYfxt/kdoikbMRVEgN9APWnxbkb
 6frzMny0EpSorJboWvY15TW87uLu0mCN+sFLDLx/SXrdvy4pPgyGtTW8o8D58A+k1O1w +A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q12sttjua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 06:46:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33I6kaa0006737
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 06:46:36 GMT
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 17 Apr 2023 23:46:31 -0700
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
Subject: [PATCH V5 2/3] soc: qcom: boot_stat: Add Driver Support for Boot Stats
Date:   Tue, 18 Apr 2023 12:16:04 +0530
Message-ID: <142bfd034c12c245cda9f1dee20a05188b63494d.1681799201.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1681799201.git.quic_schowdhu@quicinc.com>
References: <cover.1681799201.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -rS22YT5upnUzrSMqPLwvEN71dJ_wNmL
X-Proofpoint-ORIG-GUID: -rS22YT5upnUzrSMqPLwvEN71dJ_wNmL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_03,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxscore=0 impostorscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180062
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
members of the structure to show the information within debugfs file.
This information is useful in verifying if the existing boot KPIs have
regressed or not. The information is shown in milliseconds, a sample
log from sm8450(waipio) device is as follows:-

/sys/kernel/debug/146aa6b0.boot_stats # cat abl_time
17898 ms
/sys/kernel/debug/146aa6b0.boot_stats # cat pre_abl_time
2879 ms

The Module Power Manager(MPM) sleep counter starts ticking at the PBL
stage and the timestamp generated by the sleep counter is logged by
the Qualcomm proprietary bootloader(ABL) at two points-> First when it
starts execution which is logged here as "pre_abl_time" and the second
when it is about to load the kernel logged as "abl_time". Documentation
details are also added in Documentation/ABI/testing/debugfs-driver-bootstat

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 Documentation/ABI/testing/debugfs-driver-bootstat |  17 ++++
 drivers/soc/qcom/Kconfig                          |   9 ++
 drivers/soc/qcom/Makefile                         |   1 +
 drivers/soc/qcom/boot_stats.c                     | 101 ++++++++++++++++++++++
 4 files changed, 128 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-driver-bootstat
 create mode 100644 drivers/soc/qcom/boot_stats.c

diff --git a/Documentation/ABI/testing/debugfs-driver-bootstat b/Documentation/ABI/testing/debugfs-driver-bootstat
new file mode 100644
index 0000000..2543029
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-driver-bootstat
@@ -0,0 +1,17 @@
+What:		/sys/kernel/debug/...stats/pre_abl_time
+Date:           April 2023
+Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+Description:
+		This file is used to read the KPI value pre abl time.
+		It shows the time in milliseconds from the starting
+		point of PBL to the point when the control shifted
+		to ABL(Qualcomm proprietary bootloader).
+
+What:           /sys/kernel/debug/...stats/abl_time
+Date:           April 2023
+Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+Description:
+		This file is used to read the KPI value abl time.
+		It show the duration in milliseconds from the
+		time control switched to ABL to the point when
+		the linux kernel started getting loaded.
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index a8f2830..0d2cbd3 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -16,6 +16,15 @@ config QCOM_AOSS_QMP
 	  subsystems as well as controlling the debug clocks exposed by the Always On
 	  Subsystem (AOSS) using Qualcomm Messaging Protocol (QMP).
 
+config QCOM_BOOTSTAT
+	tristate "Qualcomm Technologies, Boot Stat driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	help
+	  This option enables driver support for boot stats. Boot stat driver logs
+	  the kernel bootloader information by accessing the imem region. These
+	  information are exposed in the form of debugfs files. This is used to
+	  determine if there is any regression in boot timings.
+
 config QCOM_COMMAND_DB
 	tristate "Qualcomm Command DB"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 6e88da8..bdaa41a 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS_rpmh-rsc.o := -I$(src)
 obj-$(CONFIG_QCOM_AOSS_QMP) +=	qcom_aoss.o
+obj-$(CONFIG_QCOM_BOOTSTAT) += boot_stats.o
 obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
 obj-$(CONFIG_QCOM_CPR)		+= cpr.o
diff --git a/drivers/soc/qcom/boot_stats.c b/drivers/soc/qcom/boot_stats.c
new file mode 100644
index 0000000..7ae002b
--- /dev/null
+++ b/drivers/soc/qcom/boot_stats.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2013-2019, 2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+
+#define TO_MS(timestamp) ((timestamp * 1000) / 32768)
+
+/**
+ *  struct boot_stats - timestamp information related to boot stats
+ *  @abl_start: Time for the starting point of the abl
+ *  @abl_end: Time when the kernel starts loading from abl
+ */
+struct boot_stats {
+	u32 abl_start;
+	u32 abl_end;
+} __packed;
+
+struct bs_data {
+	struct boot_stats __iomem *b_stats;
+	struct dentry *dbg_dir;
+};
+
+static int abl_time_show(struct seq_file *seq, void *v)
+{
+	struct boot_stats *boot_stats = seq->private;
+	u32 abl_time = TO_MS(boot_stats->abl_end) - TO_MS(boot_stats->abl_start);
+
+	seq_printf(seq, "%u ms\n", abl_time);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(abl_time);
+
+static int pre_abl_time_show(struct seq_file *seq, void *v)
+{
+	struct boot_stats *boot_stats = seq->private;
+
+	seq_printf(seq, "%u ms\n", TO_MS(boot_stats->abl_start));
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(pre_abl_time);
+
+static int boot_stats_probe(struct platform_device *pdev)
+{
+	struct device *bootstat_dev = &pdev->dev;
+	struct bs_data *drvdata;
+
+	drvdata = devm_kzalloc(bootstat_dev, sizeof(*drvdata), GFP_KERNEL);
+	platform_set_drvdata(pdev, drvdata);
+
+	drvdata->dbg_dir = debugfs_create_dir(dev_name(bootstat_dev), NULL);
+	if (IS_ERR(drvdata->dbg_dir))
+		return dev_err_probe(bootstat_dev, -ENOENT, "failed to create debugfs directory");
+
+	drvdata->b_stats = devm_of_iomap(bootstat_dev, bootstat_dev->of_node, 0, NULL);
+	if (!drvdata->b_stats)
+		return dev_err_probe(bootstat_dev, -ENOMEM, "failed to map imem region\n");
+
+	debugfs_create_file("pre_abl_time", 0200, drvdata->dbg_dir,
+			    drvdata->b_stats, &pre_abl_time_fops);
+	debugfs_create_file("abl_time", 0200, drvdata->dbg_dir, drvdata->b_stats, &abl_time_fops);
+
+	return 0;
+}
+
+static void boot_stats_remove(struct platform_device *pdev)
+{
+	struct bs_data *drvdata = platform_get_drvdata(pdev);
+
+	debugfs_remove_recursive(drvdata->dbg_dir);
+	iounmap(drvdata->b_stats);
+}
+
+static const struct of_device_id boot_stats_dt_match[] = {
+	{ .compatible = "qcom,sm8450-bootstats" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, boot_stats_dt_match);
+
+static struct platform_driver boot_stat_driver = {
+	.probe  = boot_stats_probe,
+	.remove_new = boot_stats_remove,
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

