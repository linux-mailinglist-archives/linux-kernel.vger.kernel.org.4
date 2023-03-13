Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E856B77C7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjCMMlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCMMlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:41:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5CC5ADEE;
        Mon, 13 Mar 2023 05:41:21 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DBB94f005024;
        Mon, 13 Mar 2023 12:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=qcppdkim1;
 bh=pw2qauJDJ1GtPyu7CN6d2qKRJxDzjTe1P/Bh9VDw4Cw=;
 b=nTnQK5WT7Ab3+vDPRs9Am7WfG6t1GnbfppqfQPy6HHV43QgsO1wnHomeGki6++V+GinU
 0HJK9S2ypj3XFOFyXS+DmPDhLmzqXF8Sh8z72CKkpcIbGgspzQmFFTz+YGoUknYuo/VG
 FZeew+cdITDA771tDhGF3Kzve69B6TOnj2g5pEIE9dg5SH8dpk/zdqwBeTr4sb15reik
 jkr7oZRLCGkzeCejEsKxcQyn58Lb/r3tkwbH/SMucGo3pWOBSkGrOrSokdllyUjDuc6b
 6TdxgUUg8aR4z3vNNdgVZBiiYobNKrGlug204I+F3iJ5jMk3JXXMcTpSbpfRSZj+r5ow eQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p8gnq4vqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 12:40:53 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32DCekCB022385;
        Mon, 13 Mar 2023 12:40:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3p8jqkna0n-1;
        Mon, 13 Mar 2023 12:40:50 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32DCeo9t022428;
        Mon, 13 Mar 2023 12:40:50 GMT
Received: from kbajaj-linux.qualcomm.com (kbajaj-linux.qualcomm.com [10.214.66.129])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 32DCeo6p022427;
        Mon, 13 Mar 2023 12:40:50 +0000
Received: from kbajaj-linux.qualcomm.com (localhost [127.0.0.1])
        by kbajaj-linux.qualcomm.com (Postfix) with ESMTP id 4DAFE2A3;
        Mon, 13 Mar 2023 18:10:49 +0530 (IST)
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     Komal Bajaj <quic_kbajaj@quicinc.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 4/5] soc: qcom: Add LLCC support for multi channel DDR
Date:   Mon, 13 Mar 2023 18:10:39 +0530
Message-Id: <20230313124040.9463-5-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230313124040.9463-1-quic_kbajaj@quicinc.com>
References: <20230313124040.9463-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TP067fexm3GBBYZsc_DOq5Y833zzEi_C
X-Proofpoint-ORIG-GUID: TP067fexm3GBBYZsc_DOq5Y833zzEi_C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_05,2023-03-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LLCC support for multi channel DDR configurations
based off of a feature register.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 drivers/soc/qcom/llcc-qcom.c       | 56 ++++++++++++++++++++++++++++--
 include/linux/soc/qcom/llcc-qcom.h |  2 ++
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 00699a0c047e..f4d3e266c629 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -17,6 +17,7 @@
 #include <linux/regmap.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
+#include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/soc/qcom/llcc-qcom.h>
 
 #define ACTIVATE                      BIT(0)
@@ -924,6 +925,40 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev,
 	return ret;
 }
 
+static int qcom_llcc_get_cfg_index(struct platform_device *pdev, u32 *cfg_index)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *ch_res = NULL;
+
+	u32 ch_reg_sz;
+	u32 ch_reg_off;
+	u32 val;
+	int ret = 0;
+
+	ch_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "multi_channel_register");
+	if (ch_res) {
+		if (of_property_read_u32(dev->of_node, "multi-ch-bit-off", &ch_reg_off)) {
+			dev_err(&pdev->dev,
+				"Couldn't get offset for multi channel feature register\n");
+			return -ENODEV;
+		}
+		if (of_property_read_u32_index(dev->of_node, "multi-ch-bit-off", 1, &ch_reg_sz)) {
+			dev_err(&pdev->dev,
+				"Couldn't get size of multi channel feature register\n");
+			return -ENODEV;
+		}
+
+		if (qcom_scm_io_readl(ch_res->start, &val)) {
+			dev_err(&pdev->dev, "Couldn't access multi channel feature register\n");
+			ret = -EINVAL;
+		}
+		*cfg_index = (val >> ch_reg_off) & ((1 << ch_reg_sz) - 1);
+	} else
+		*cfg_index = 0;
+
+	return ret;
+}
+
 static int qcom_llcc_remove(struct platform_device *pdev)
 {
 	/* Set the global pointer to a error code to avoid referencing it */
@@ -956,10 +991,13 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int ret, i;
 	struct platform_device *llcc_edac;
-	const struct qcom_llcc_config *cfg;
+	const struct qcom_llcc_config *cfg, *entry;
 	const struct llcc_slice_config *llcc_cfg;
+
 	u32 sz;
+	u32 cfg_index;
 	u32 version;
+	u32 no_of_entries = 0;
 
 	drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
 	if (!drv_data) {
@@ -999,8 +1037,20 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 	num_banks >>= LLCC_LB_CNT_SHIFT;
 	drv_data->num_banks = num_banks;
 
-	llcc_cfg = cfg[0].sct_data;
-	sz = cfg[0].size;
+	ret = qcom_llcc_get_cfg_index(pdev, &cfg_index);
+	if (ret)
+		goto err;
+
+	for (entry = cfg; entry->sct_data; entry++, no_of_entries++)
+		;
+	if (cfg_index >= no_of_entries) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	drv_data->cfg_index = cfg_index;
+	llcc_cfg = cfg[cfg_index].sct_data;
+	sz = cfg[cfg_index].size;
 
 	for (i = 0; i < sz; i++)
 		if (llcc_cfg[i].slice_id > drv_data->max_slices)
diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
index ad1fd718169d..225891a02f5d 100644
--- a/include/linux/soc/qcom/llcc-qcom.h
+++ b/include/linux/soc/qcom/llcc-qcom.h
@@ -125,6 +125,7 @@ struct llcc_edac_reg_offset {
  * @cfg: pointer to the data structure for slice configuration
  * @edac_reg_offset: Offset of the LLCC EDAC registers
  * @lock: mutex associated with each slice
+ * @cfg_index: index of config table if multiple configs present for a target
  * @cfg_size: size of the config data table
  * @max_slices: max slices as read from device tree
  * @num_banks: Number of llcc banks
@@ -139,6 +140,7 @@ struct llcc_drv_data {
 	const struct llcc_slice_config *cfg;
 	const struct llcc_edac_reg_offset *edac_reg_offset;
 	struct mutex lock;
+	u32 cfg_index;
 	u32 cfg_size;
 	u32 max_slices;
 	u32 num_banks;
-- 
2.39.1

