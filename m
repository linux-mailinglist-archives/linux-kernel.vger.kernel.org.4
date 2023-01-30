Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2E4680578
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 06:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbjA3FO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 00:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbjA3FOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 00:14:45 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEA321943;
        Sun, 29 Jan 2023 21:14:44 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U3jJP9022926;
        Mon, 30 Jan 2023 05:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=FuXEuDLHp/PrvEbaT/RkZwXyybcKMLYsAYkn5GLV6bw=;
 b=R5upqniWzhAmFYNLIy2JC4pA49EGvpXAdQ/BXis6fkBbxq1Amo2s2/tzcgRAvstUj4I0
 wFFvUac4B4ezoOP9WlNxI87q+ro9Zj1LqUom2YRdSahAUTBcSyJhN3hdwHw3gGA6vSyY
 L71hM+ht8BJPxxbV0EkPhr7fuc7Rc1HLZAT0a8v4B/40fP3thb95kdWdUw/6AvnFNx5e
 jO98dYtWvS1hM2uKyK4cwceqp2Pp3xe/AVUskSIt4zm0nKcrLVvZ2P6RxKMEdaONp2EE
 2owUquGvZVoOOw1rhE5E+wq47FX5ymU4qOeLRrfM/rPA6pcvRsvaB9gT9CgL4gPyC+7J cQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nctnyjvb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 05:14:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30U5EXiL020699
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 05:14:33 GMT
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 29 Jan 2023 21:14:29 -0800
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
Subject: [PATCH V3 1/3] soc: qcom: dcc: Add bootconfig support for DCC
Date:   Mon, 30 Jan 2023 10:43:55 +0530
Message-ID: <82087136234e84eb0e10f0f168e1edb171e6d692.1675054375.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1675054375.git.quic_schowdhu@quicinc.com>
References: <cover.1675054375.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: evnd_Dct-NUphLge4VTUMiQ2Z_LS2Eib
X-Proofpoint-ORIG-GUID: evnd_Dct-NUphLge4VTUMiQ2Z_LS2Eib
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_03,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300049
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
 drivers/soc/qcom/Kconfig |  3 +-
 drivers/soc/qcom/dcc.c   | 74 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 21c4ce2..d11bda2 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -71,8 +71,9 @@ config QCOM_LLCC
 	  Say yes here to enable LLCC slice driver.
 
 config QCOM_DCC
-	tristate "Qualcomm Technologies, Inc. Data Capture and Compare(DCC) engine driver"
+	bool "Qualcomm Technologies, Inc. Data Capture and Compare(DCC) engine driver"
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

