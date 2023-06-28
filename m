Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E543574113B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjF1MjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:39:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131]:25678 "EHLO
        mx0a-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231946AbjF1MhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:37:02 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SCOe3T014964;
        Wed, 28 Jun 2023 12:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=PUdvcBK75eQiAmB1sFgB1b8PFy9LJu6zPkzkKOvP6QQ=;
 b=Jcfa0Ua8h2oBaEN5PrunYOiEcHx5upAgq00w0USn6FQfoYlwbTP9/b+Sr6Sh1cjmGy4I
 R9WfzskLKSwNWHhY/Z1gIJxRDUA8DSs0e1+ugkMUzD7je12h6pN81JYshc2gRJEmXhx7
 FT4hhxWZS1avLVetpCt52OmPodsV1QIK8RcC9md70l52un8hVe6ConfMf8s7ufawVlze
 gMNoPs5N6m+VjMD4JITAiWeSbQy4bkOGnWBBypkttN0LtfiWg3doUZDSMDBtY03RkjyH
 deRRYAVI9hm64oF/uPEU0dP5I2nTQXcGBm0pNptsrKKAixrGJ8bsogLcw/mmb+h+PgBS Lg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgaxcs94e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:36:31 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SCaU70008488
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:36:30 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 28 Jun 2023 05:36:23 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v4 11/21] soc: qcom: Register pstore frontend region with minidump
Date:   Wed, 28 Jun 2023 18:04:38 +0530
Message-ID: <1687955688-20809-12-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: x6ZlZc7YHcNUisVbetG2IdTSFdzK1QbR
X-Proofpoint-ORIG-GUID: x6ZlZc7YHcNUisVbetG2IdTSFdzK1QbR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since qcom_pstore_minidump driver creates platform device for
qualcomm devices, so it knows the physical addresses of the
frontend region now. Let's register the regions with
qcom_minidump driver.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/soc/qcom/qcom_pstore_minidump.c | 131 +++++++++++++++++++++++++++++++-
 1 file changed, 128 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/qcom_pstore_minidump.c b/drivers/soc/qcom/qcom_pstore_minidump.c
index b07cd10340df..f17384dd2d72 100644
--- a/drivers/soc/qcom/qcom_pstore_minidump.c
+++ b/drivers/soc/qcom/qcom_pstore_minidump.c
@@ -9,12 +9,120 @@
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/pstore_ram.h>
+#include <soc/qcom/qcom_minidump.h>
 
 struct qcom_ramoops_dd {
 	struct ramoops_platform_data qcom_ramoops_pdata;
 	struct platform_device *ramoops_pdev;
+	struct device *dev;
+	struct qcom_minidump_region **dmesg_region;
+	struct qcom_minidump_region *console_region;
+	struct qcom_minidump_region *pmsg_region;
+	struct qcom_minidump_region **ftrace_region;
+	unsigned int max_dump_cnt;
+	unsigned int max_ftrace_cnt;
 };
 
+static int qcom_ramoops_md_region_register(struct device *dev, struct qcom_minidump_region **zone,
+					   const char *name, phys_addr_t phys_addr,
+					   unsigned long size)
+{
+	struct qcom_minidump_region *md_region;
+	int ret;
+
+	if (!size)
+		return 0;
+
+	md_region = devm_kzalloc(dev, sizeof(*md_region), GFP_KERNEL);
+	if (!md_region)
+		return -ENOMEM;
+
+	strscpy(md_region->name, name, sizeof(md_region->name));
+	md_region->phys_addr = phys_addr;
+	md_region->virt_addr = phys_to_virt(phys_addr);
+	md_region->size = size;
+	*zone = md_region;
+	ret = qcom_minidump_region_register(md_region);
+	if (ret)
+		dev_err(dev, "failed to add %s in minidump: err: %d\n", name, ret);
+
+	return ret;
+}
+
+static int qcom_ramoops_minidump_register(struct qcom_ramoops_dd *qcom_rdd)
+{
+	struct ramoops_platform_data *pdata = &qcom_rdd->qcom_ramoops_pdata;
+	char name[MAX_NAME_LENGTH];
+	size_t zone_sz;
+	phys_addr_t phys_addr;
+	int ret = 0;
+	int i;
+
+	phys_addr = pdata->mem_address;
+	for (i = 0; i < qcom_rdd->max_dump_cnt; i++) {
+		scnprintf(name, sizeof(name), "KDMSG%d", i);
+		ret = qcom_ramoops_md_region_register(qcom_rdd->dev,
+			&qcom_rdd->dmesg_region[i], name, phys_addr,
+			pdata->record_size);
+		if (ret)
+			return ret;
+
+		phys_addr += pdata->record_size;
+	}
+
+	ret = qcom_ramoops_md_region_register(qcom_rdd->dev,
+			&qcom_rdd->console_region, "KCONSOLE", phys_addr,
+			pdata->console_size);
+	if (ret)
+		return ret;
+
+	phys_addr += pdata->console_size;
+
+	ret = qcom_ramoops_md_region_register(qcom_rdd->dev,
+			&qcom_rdd->pmsg_region, "KPMSG", phys_addr,
+			pdata->pmsg_size);
+	if (ret)
+		return ret;
+
+	phys_addr += pdata->pmsg_size;
+
+	zone_sz =  pdata->ftrace_size / qcom_rdd->max_ftrace_cnt;
+	for (i = 0; i < qcom_rdd->max_ftrace_cnt; i++) {
+		ret = qcom_ramoops_md_region_register(qcom_rdd->dev,
+			&qcom_rdd->ftrace_region[i], "KFTRACE", phys_addr,
+			zone_sz);
+		if (ret)
+			return ret;
+
+		phys_addr += zone_sz;
+	}
+
+	return ret;
+}
+
+static void qcom_ramoops_minidump_unregister(struct qcom_ramoops_dd *qcom_rdd)
+{
+	struct ramoops_platform_data *pdata;
+	int i;
+
+	pdata = &qcom_rdd->qcom_ramoops_pdata;
+	if (pdata->record_size) {
+		for (i = 0; i < qcom_rdd->max_dump_cnt; i++)
+			qcom_minidump_region_unregister(qcom_rdd->dmesg_region[i]);
+	}
+
+	if (pdata->console_size)
+		qcom_minidump_region_unregister(qcom_rdd->console_region);
+
+	if (pdata->pmsg_size)
+		qcom_minidump_region_unregister(qcom_rdd->pmsg_region);
+
+	if (pdata->ftrace_size) {
+		for (i = 0; i < qcom_rdd->max_ftrace_cnt; i++)
+			qcom_minidump_region_unregister(qcom_rdd->ftrace_region[i]);
+	}
+}
+
 static int qcom_ramoops_probe(struct platform_device *pdev)
 {
 	struct device_node *of_node = pdev->dev.of_node;
@@ -22,6 +130,7 @@ static int qcom_ramoops_probe(struct platform_device *pdev)
 	struct ramoops_platform_data *pdata;
 	struct reserved_mem *rmem;
 	struct device_node *node;
+	size_t dump_mem_sz;
 	long ret;
 
 	node = of_parse_phandle(of_node, "memory-region", 0);
@@ -39,27 +148,43 @@ static int qcom_ramoops_probe(struct platform_device *pdev)
 	if (!qcom_rdd)
 		return -ENOMEM;
 
+	qcom_rdd->dev = &pdev->dev;
 	pdata = &qcom_rdd->qcom_ramoops_pdata;
 	pdata->mem_size = rmem->size;
 	pdata->mem_address = rmem->base;
-	ramoops_parse_dt(pdev, pdata);
-
+	ret = ramoops_parse_dt(pdev, pdata);
+	if (ret < 0)
+		return ret;
+
+	dump_mem_sz = pdata->mem_size - pdata->console_size - pdata->ftrace_size
+		      - pdata->pmsg_size;
+	if (!dump_mem_sz || !pdata->record_size)
+		qcom_rdd->max_dump_cnt = 0;
+	else
+		qcom_rdd->max_dump_cnt = dump_mem_sz / pdata->record_size;
+
+	qcom_rdd->max_ftrace_cnt = (pdata->flags & RAMOOPS_FLAG_FTRACE_PER_CPU)
+				? nr_cpu_ids
+				: 1;
 	qcom_rdd->ramoops_pdev = platform_device_register_data(NULL, "ramoops", -1,
 							       pdata, sizeof(*pdata));
 	if (IS_ERR(qcom_rdd->ramoops_pdev)) {
 		ret = PTR_ERR(qcom_rdd->ramoops_pdev);
 		dev_err(&pdev->dev, "could not create platform device: %ld\n", ret);
 		qcom_rdd->ramoops_pdev = NULL;
+		return ret;
 	}
+
 	platform_set_drvdata(pdev, qcom_rdd);
 
-	return ret;
+	return qcom_ramoops_minidump_register(qcom_rdd);
 }
 
 static void qcom_ramoops_remove(struct platform_device *pdev)
 {
 	struct qcom_ramoops_dd *qcom_rdd = platform_get_drvdata(pdev);
 
+	qcom_ramoops_minidump_unregister(qcom_rdd);
 	platform_device_unregister(qcom_rdd->ramoops_pdev);
 	qcom_rdd->ramoops_pdev = NULL;
 }
-- 
2.7.4

