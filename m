Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91BB6F5CFE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 19:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjECRWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 13:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjECRWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 13:22:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F93210F1;
        Wed,  3 May 2023 10:22:39 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343GmLI0019257;
        Wed, 3 May 2023 17:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=3j6qKMufK1xOS3WjPDSg9QQXFKVRPXyyQTDI+AWUpgI=;
 b=ihSW94Fxv8BF+qz/loxVJczsOPRnVmMCC/uRdbKBcYgyV3HijWNH6rDBVBqdOtMw+JHG
 ue1qFjbgzzCCJI3lhRgCUgErKK1M1ZtSDbjRZbYH/vaWO9mxOsRb8zKWWRxIpj74KkSy
 AHm+hzzXFrwSiDcLHrqGD6hqunm3P3jeYq/mnI8abpk2Z3y1WMhk3LS8vEkIk1xYU18C
 QJsWvZYoqx6gdzztSvWaLJvi9oIc4I0j1PAKldLqzu/Bq5c6tgOdW8wliPQxRxNE7/sj
 XebdbZF4OoONDKuHcFKq4S2X5LGJ+p4m7vXd+NjJyOLenEROege+bpxQn+2iOS93QHhb pg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qbk7sh7qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 17:04:12 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 343H44fs005070
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 May 2023 17:04:04 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 3 May 2023 10:03:58 -0700
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
Subject: [PATCH v3 12/18] soc: qcom: Register pstore frontend region with minidump
Date:   Wed, 3 May 2023 22:32:26 +0530
Message-ID: <1683133352-10046-13-git-send-email-quic_mojha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: KciCwc0YGPllTPgHlxaAHCpumGHprIXZ
X-Proofpoint-GUID: KciCwc0YGPllTPgHlxaAHCpumGHprIXZ
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

Since qcom_pstore_minidump driver creates platform device
for qualcomm devices, so it knows the physical addresses
of the frontend region now. Let's register the regions
with qcom_minidump driver.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/soc/qcom/qcom_pstore_minidump.c | 80 ++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom_pstore_minidump.c b/drivers/soc/qcom/qcom_pstore_minidump.c
index 8d58500..c2bba4e 100644
--- a/drivers/soc/qcom/qcom_pstore_minidump.c
+++ b/drivers/soc/qcom/qcom_pstore_minidump.c
@@ -11,6 +11,8 @@
 #include <linux/pstore_ram.h>
 #include <soc/qcom/qcom_minidump.h>
 
+#define QCOM_PSTORE_TYPE_MAX	4
+
 struct qcom_ramoops_config {
 	unsigned long	record_size;
 	unsigned long	console_size;
@@ -24,6 +26,11 @@ struct qcom_ramoops_config {
 struct qcom_ramoops_dd {
 	struct ramoops_platform_data qcom_ramoops_pdata;
 	struct platform_device *ramoops_pdev;
+	struct device *dev;
+	struct qcom_apss_minidump_region *record_region;
+	struct qcom_apss_minidump_region *console_region;
+	struct qcom_apss_minidump_region *pmsg_region;
+	struct qcom_apss_minidump_region *ftrace_region;
 };
 
 static struct qcom_ramoops_config default_ramoops_config = {
@@ -35,6 +42,64 @@ static struct qcom_ramoops_config default_ramoops_config = {
 };
 
 static struct qcom_ramoops_dd *qcom_rdd;
+
+static int
+__qcom_ramoops_minidump_region_register(struct qcom_apss_minidump_region *md_region,
+					const char *name, phys_addr_t phys_addr,
+					unsigned long size)
+{
+	int ret;
+
+	if (!size)
+		return 0;
+
+	md_region = devm_kzalloc(qcom_rdd->dev, sizeof(*md_region), GFP_KERNEL);
+	if (!md_region)
+		return -ENOMEM;
+
+	strlcpy(md_region->name, name, sizeof(md_region->name));
+	md_region->phys_addr = phys_addr;
+	md_region->virt_addr = phys_to_virt(phys_addr);
+	md_region->size = size;
+	ret = qcom_apss_minidump_region_register(md_region);
+	if (ret)
+		dev_err(qcom_rdd->dev,
+			"failed to add %s in minidump: err: %d\n", name, ret);
+
+	return ret;
+}
+
+static int
+qcom_ramoops_minidump_region_register(struct ramoops_platform_data *qcom_ramoops_data)
+{
+	phys_addr_t phys_addr;
+	int ret = 0;
+
+	phys_addr = qcom_ramoops_data->mem_address;
+	ret = __qcom_ramoops_minidump_region_register(qcom_rdd->record_region,
+			"KDMESG", phys_addr, qcom_ramoops_data->record_size);
+	if (ret)
+		return ret;
+
+	phys_addr += qcom_ramoops_data->record_size;
+	ret = __qcom_ramoops_minidump_region_register(qcom_rdd->console_region,
+			"KCONSOLE", phys_addr, qcom_ramoops_data->console_size);
+	if (ret)
+		return ret;
+
+	phys_addr += qcom_ramoops_data->console_size;
+	ret = __qcom_ramoops_minidump_region_register(qcom_rdd->pmsg_region,
+			"KPMSG", phys_addr, qcom_ramoops_data->pmsg_size);
+	if (ret)
+		return ret;
+
+	phys_addr += qcom_ramoops_data->pmsg_size;
+	ret = __qcom_ramoops_minidump_region_register(qcom_rdd->ftrace_region,
+			"KFTRACE", phys_addr, qcom_ramoops_data->ftrace_size);
+
+	return ret;
+}
+
 static int qcom_ramoops_probe(struct platform_device *pdev)
 {
 	struct device_node *of_node = pdev->dev.of_node;
@@ -59,6 +124,7 @@ static int qcom_ramoops_probe(struct platform_device *pdev)
 	if (!qcom_rdd)
 		return -ENOMEM;
 
+	qcom_rdd->dev = &pdev->dev;
 	cfg = of_device_get_match_data(&pdev->dev);
 	if (!cfg) {
 		dev_err(&pdev->dev, "failed to get supported matched data\n");
@@ -81,13 +147,25 @@ static int qcom_ramoops_probe(struct platform_device *pdev)
 		ret = PTR_ERR(qcom_rdd->ramoops_pdev);
 		dev_err(&pdev->dev, "could not create platform device: %ld\n", ret);
 		qcom_rdd->ramoops_pdev = NULL;
+		return ret;
 	}
 
-	return ret;
+	return qcom_ramoops_minidump_region_register(pdata);
 }
 
 static int qcom_ramoops_remove(struct platform_device *pdev)
 {
+	struct ramoops_platform_data *pdata;
+
+	pdata = &qcom_rdd->qcom_ramoops_pdata;
+	if (pdata->record_size)
+		qcom_apss_minidump_region_unregister(qcom_rdd->record_region);
+	if (pdata->console_size)
+		qcom_apss_minidump_region_unregister(qcom_rdd->console_region);
+	if (pdata->pmsg_size)
+		qcom_apss_minidump_region_unregister(qcom_rdd->pmsg_region);
+	if (pdata->ftrace_size)
+		qcom_apss_minidump_region_unregister(qcom_rdd->ftrace_region);
 	platform_device_unregister(qcom_rdd->ramoops_pdev);
 	qcom_rdd->ramoops_pdev = NULL;
 
-- 
2.7.4

