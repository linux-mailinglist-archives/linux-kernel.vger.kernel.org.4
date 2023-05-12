Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE8370079C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240835AbjELMWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240807AbjELMV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:21:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A101112095;
        Fri, 12 May 2023 05:21:57 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CC0mZS020438;
        Fri, 12 May 2023 12:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=xlNdu9x86CFmg14L3vqKJv3SzJInwe5m0GZNMnkQ5Tw=;
 b=mMDQI37oWYvNQCuaMVatxMOW80xY1AyDjwgn4RrrhEeQ58amuAA876Jz6GBeTt4VhStN
 DNB3h5QWx3JDpo3refSJL4TDjtzC8DAwCMw+z7/0Aaru27m1By+YdKg1hNGROXC34fKN
 A2/ITFfUfs+RjC53kNXMS9YPMcAwlbx5DGOkuAw8NKKPulhM5rFS//Fcswfxq2/oPvmy
 7iBM1L1OklilbuxRQVOlTkMVoMPCueMthcQ13Uwr23QoIMFQHCQOhMQVIy28/HdDF1/L
 Z+5NoFwUapWaf34h7+TzOz983Ct/zW79qvUq5yFNFmlOzMu0Fg+ijo82KItUstUse0tQ 6Q== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qhfww0pp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 12:21:54 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34CCLpHB029068;
        Fri, 12 May 2023 12:21:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qdy59u1vg-1;
        Fri, 12 May 2023 12:21:51 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34CCLpHx029062;
        Fri, 12 May 2023 12:21:51 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-kbajaj-hyd.qualcomm.com [10.147.247.189])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 34CCLobD029061;
        Fri, 12 May 2023 12:21:51 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2340697)
        id 4632D52974D; Fri, 12 May 2023 17:51:50 +0530 (+0530)
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 06/10] soc: qcom: Add LLCC support for multi channel DDR
Date:   Fri, 12 May 2023 17:51:30 +0530
Message-Id: <20230512122134.24339-7-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
References: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ENHVhyvHmZXH_BlUpj2N_v5FDTtYymC_
X-Proofpoint-GUID: ENHVhyvHmZXH_BlUpj2N_v5FDTtYymC_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 clxscore=1015 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120103
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LLCC support for multi channel DDR configuration
based on a feature register.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 drivers/soc/qcom/llcc-qcom.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 6cf373da5df9..1da337e7a378 100644
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
+	int ret = 0;
+
+	ret = nvmem_cell_read_u8(&pdev->dev, "multi_chan_ddr", cfg_index);
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
@@ -1040,8 +1056,18 @@ static int qcom_llcc_probe(struct platform_device *pdev)

 	drv_data->version = version;

-	llcc_cfg = cfg[0]->sct_data;
-	sz = cfg[0]->size;
+	ret = qcom_llcc_get_cfg_index(pdev, &cfg_index);
+	if (ret)
+		goto err;
+
+	for (entry = cfg; entry->sct_data; entry++, num_entries++);
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
2.17.1

