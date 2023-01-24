Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C731D678F21
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 04:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjAXDyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 22:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjAXDyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 22:54:00 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A180A3A5AF;
        Mon, 23 Jan 2023 19:53:59 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30O3MxV1029467;
        Tue, 24 Jan 2023 03:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=HnI59rvn4/v2sg5HehUasd2frp5NQmidbIES/KBH9e4=;
 b=NRoWEEbKaKG+tglraWppF7eCoo7IYKmw4vN7qIeIck3SzbaldpMlRaK3nDU13v41DaX+
 9Z/CcNfeobVSPSBTN4Ijxy+aD9pS+OMmZftzi+gXcfBSEg81/6tMXHlxjCOcRkrBipwK
 gusbPWquuyxWerm8Zz1wUpEU0EoH2LOsYN3lHL57O38c9zCGWo2wOIe24AXoLesCzIgD
 gk2ygwLWlu3axd17J9Yi/zG+yAn2RPaxuTpp+7iMK17gm5wi9FZ0COc/NWU/X+iy0TpS
 gDH8W9MK8ePYa0sw7pPrll2q6eA/mAdfJZ10x8OIMridDEknkxCXH0jP+drofRN66eWo aQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89dnc88e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 03:53:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30O3rdNw030505
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 03:53:39 GMT
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 23 Jan 2023 19:53:36 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Alex Elder" <elder@ieee.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        "Rajendra Nayak" <quic_rjendra@quicinc.com>, <vkoul@kernel.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V2 1/3] soc: qcom: dcc: Add bootconfig support for DCC
Date:   Tue, 24 Jan 2023 09:22:35 +0530
Message-ID: <62d98c7d56e752afff5216cfcd42451edb82cb4d.1674531462.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1674531462.git.quic_schowdhu@quicinc.com>
References: <cover.1674531462.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Vv_ZXTOp5Q9hwVmfUA-BskBU680DePef
X-Proofpoint-ORIG-GUID: Vv_ZXTOp5Q9hwVmfUA-BskBU680DePef
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240033
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bootconfig parser for DCC which is used to configure addresses
in DCC during boot time. This is needed to debug crashes that can happen
during boot-time. The expected format of a bootconfig file is as follows:-

dcc_config {
	link_list_<The list number to configure> {
		id = <The list number to configure>
		items =  <Address as same format as dcc separated by '_'>,
	}
}

Example:-

dcc_config {
	link_list_6 {
		id = 6
		items = R_0x1781005c_1_apb,
			R_0x1782005c_1_apb
	}
}

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 drivers/soc/qcom/Kconfig |  1 +
 drivers/soc/qcom/dcc.c   | 74 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 21c4ce2..f913b72 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -73,6 +73,7 @@ config QCOM_LLCC
 config QCOM_DCC
 	tristate "Qualcomm Technologies, Inc. Data Capture and Compare(DCC) engine driver"
 	depends on ARCH_QCOM || COMPILE_TEST
+	select BOOT_CONFIG
 	help
 	  This option enables driver for Data Capture and Compare engine. DCC
 	  driver provides interface to configure DCC block and read back
diff --git a/drivers/soc/qcom/dcc.c b/drivers/soc/qcom/dcc.c
index 5b50d63..93e8f86 100644
--- a/drivers/soc/qcom/dcc.c
+++ b/drivers/soc/qcom/dcc.c
@@ -6,6 +6,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/bootconfig.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
@@ -148,6 +149,18 @@ struct dcc_cfg_loop_attr {
 	bool	loop_start;
 };
 
+static char *replace_char(char *str, char find, char replace)
+{
+	char *current_pos = strchr(str, find);
+
+	while (current_pos) {
+		*current_pos = replace;
+		current_pos = strchr(current_pos, find);
+	}
+
+	return str;
+}
+
 static inline u32 dcc_list_offset(int version)
 {
 	return version == 1 ? 0x1c : version == 2 ? 0x2c : 0x34;
@@ -1185,13 +1198,62 @@ static void dcc_sram_dev_exit(struct dcc_drvdata *drvdata)
 	misc_deregister(&drvdata->sram_dev);
 }
 
-static int dcc_probe(struct platform_device *pdev)
+static int __init dcc_bootconfig_parse(struct dcc_drvdata *drvdata, struct  xbc_node  *dcc_node)
+{
+	struct xbc_node *linked_list, *node;
+	int curr_list, ret;
+	const char *p;
+	char *input, *token;
+	char val[30];
+
+	xbc_node_for_each_subkey(dcc_node, linked_list) {
+		p = xbc_node_find_value(linked_list, "id", &node);
+		if (p) {
+			ret = kstrtoint(p, 0, &curr_list);
+			if (ret)
+				return ret;
+		} else {
+			dev_err(drvdata->dev, "List number not specified\n");
+			continue;
+		}
+
+		p = xbc_node_find_value(linked_list, "items", &node);
+		if (!p)
+			continue;
+		xbc_array_for_each_value(node, p) {
+			strcpy(val, p);
+			input = replace_char(val, '_', ' ');
+			token = strsep(&input, " ");
+
+			if (!strcmp("R", token)) {
+				ret = dcc_config_add_read(drvdata, input, curr_list);
+			} else if (!strcmp("W", token)) {
+				ret = dcc_config_add_write(drvdata, input, curr_list);
+			} else if (!strcmp("RW", token)) {
+				ret = dcc_config_add_read_write(drvdata, input, curr_list);
+			} else if (!strcmp("L", token)) {
+				ret = dcc_config_add_loop(drvdata, input, curr_list);
+			} else {
+				dev_err(drvdata->dev, "%s is not a correct input\n", token);
+				return -EINVAL;
+			}
+			if (ret)
+				return ret;
+		}
+		dcc_enable(drvdata, curr_list);
+	}
+
+	return 0;
+}
+
+static int __init dcc_probe(struct platform_device *pdev)
 {
 	u32 val;
 	int ret = 0, i;
 	struct device *dev = &pdev->dev;
 	struct dcc_drvdata *drvdata;
 	struct resource *res;
+	struct xbc_node *dcc_node;
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
@@ -1263,6 +1325,13 @@ static int dcc_probe(struct platform_device *pdev)
 
 	dcc_create_debug_dir(drvdata);
 
+	dcc_node = xbc_find_node("dcc_config");
+	if (dcc_node) {
+		ret = dcc_bootconfig_parse(drvdata, dcc_node);
+		if (ret)
+			dev_err(drvdata->dev, "DCC: Bootconfig parse error.\n");
+	}
+
 	return 0;
 }
 
@@ -1287,14 +1356,13 @@ static const struct of_device_id dcc_match_table[] = {
 MODULE_DEVICE_TABLE(of, dcc_match_table);
 
 static struct platform_driver dcc_driver = {
-	.probe = dcc_probe,
 	.remove	= dcc_remove,
 	.driver	= {
 		.name = "qcom-dcc",
 		.of_match_table	= dcc_match_table,
 	},
 };
-module_platform_driver(dcc_driver);
+module_platform_driver_probe(dcc_driver, dcc_probe);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Qualcomm Technologies Inc. DCC driver");
-- 
2.7.4

