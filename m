Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A2173B9D6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjFWOTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjFWOTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:19:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816ED2693;
        Fri, 23 Jun 2023 07:18:58 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NE2gK3009719;
        Fri, 23 Jun 2023 14:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=ztdeNjMOlMS3hnt8R1iJ/msS+N0+PEYQloQcaMXDqKg=;
 b=jDPLKN6FTMPB70QW4RLum7Zr3cRWpoZVAQKWzGBbXeps/6AQ/5R8rwpxNbEqHGhJOntA
 oWe8KB996fi1/dJzBKjCH9bYkp1z8pZCuFvEnhWFhetBgyHZ+gfwjZsr/bXn+aY719os
 9i7crIAOBuM6Z4FDjeDOsf4cYOFXW/XCaSVf7GqyQe1WUftEimUGgwizgUmZ28EMSQ/P
 9uULKJUXTqPg/DNX/3AFhg3OlSs/iIbrbbH9eoDkFpSW2oKxdKqBjMTMTVVOGA0NbtTF
 /IBXKT1U+3Lm68ZARsBLOtR3TxTnGKjdoqnQeMAVeH3AzfYOQUiPsE86L2sZGjsQqtys GA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rd64a0v53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 14:18:55 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35NEIsDd013593
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 14:18:54 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 23 Jun 2023 07:18:50 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH v4 5/6] soc: qcom: Add LLCC support for multi channel DDR
Date:   Fri, 23 Jun 2023 19:48:05 +0530
Message-ID: <20230623141806.13388-6-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230623141806.13388-1-quic_kbajaj@quicinc.com>
References: <20230623141806.13388-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VGSDNmTnx1G88uooTdPkL3WjWYZiBPg7
X-Proofpoint-ORIG-GUID: VGSDNmTnx1G88uooTdPkL3WjWYZiBPg7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxscore=0 adultscore=0
 mlxlogscore=833 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230130
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LLCC support for multi channel DDR configuration
based on a feature register. Reading DDR channel
confiuration uses nvmem framework, so select the
dependency in Kconfig. Without this, there will be
errors while building the driver with COMPILE_TEST only.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 drivers/soc/qcom/Kconfig     |  2 ++
 drivers/soc/qcom/llcc-qcom.c | 33 ++++++++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index a491718f8064..cc9ad41c63aa 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -64,6 +64,8 @@ config QCOM_LLCC
 	tristate "Qualcomm Technologies, Inc. LLCC driver"
 	depends on ARCH_QCOM || COMPILE_TEST
 	select REGMAP_MMIO
+	select NVMEM
+	select QCOM_SCM
 	help
 	  Qualcomm Technologies, Inc. platform specific
 	  Last Level Cache Controller(LLCC) driver for platforms such as,
diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 6cf373da5df9..3c29612da1c5 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
@@ -943,6 +944,19 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev,
 	return ret;
 }
 
+static int qcom_llcc_get_cfg_index(struct platform_device *pdev, u8 *cfg_index)
+{
+	int ret;
+
+	ret = nvmem_cell_read_u8(&pdev->dev, "multi-chan-ddr", cfg_index);
+	if (ret == -ENOENT) {
+		*cfg_index = 0;
+		return 0;
+	}
+
+	return ret;
+}
+
 static int qcom_llcc_remove(struct platform_device *pdev)
 {
 	/* Set the global pointer to a error code to avoid referencing it */
@@ -975,11 +989,13 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int ret, i;
 	struct platform_device *llcc_edac;
-	const struct qcom_llcc_config *cfg;
+	const struct qcom_llcc_config *cfg, *entry;
 	const struct llcc_slice_config *llcc_cfg;
 	u32 sz;
+	u8 cfg_index;
 	u32 version;
 	struct regmap *regmap;
+	u32 num_entries = 0;
 
 	drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
 	if (!drv_data) {
@@ -1040,8 +1056,19 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 
 	drv_data->version = version;
 
-	llcc_cfg = cfg[0]->sct_data;
-	sz = cfg[0]->size;
+	ret = qcom_llcc_get_cfg_index(pdev, &cfg_index);
+	if (ret)
+		goto err;
+
+	for (entry = cfg; entry->sct_data; entry++, num_entries++)
+		;
+	if (cfg_index >= num_entries || cfg_index < 0) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	llcc_cfg = cfg[cfg_index].sct_data;
+	sz = cfg[cfg_index].size;
 
 	for (i = 0; i < sz; i++)
 		if (llcc_cfg[i].slice_id > drv_data->max_slices)
-- 
2.40.1

