Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE4F5EDCA7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiI1M3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbiI1M3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:29:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B5FBF7C;
        Wed, 28 Sep 2022 05:29:35 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SBawND029788;
        Wed, 28 Sep 2022 12:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=7P8YZT3yaphJR4nO+RCpzKLfnxm9vhCYa0LPqa3e1og=;
 b=NCjOCSP1gVCtFb/bPVTlm5vxSgIBT5svxHEjKNsrXwbuZ7pYV6xG3g3uanvl5g/PPUlx
 5SxW4jFnZEan1grF/DWplgoOQ8gGitNcKN5pKjp8oImy/8mQYrPPr0kamyBVMFkUTDs/
 fpF9+Mlk+gSQ9NJL9R3vFnjUTjCMhJNB4V1yBtQEsENsHAYfumCqX821OxVtsfrWQKaH
 U5rkfcb8d7Zl5NY84W2ew6F7n2rHHeKXbB+l6YzZVAb5pcmvkvmXktUcnJnZgm2CAFoK
 /3Mx5Bb7a2hhRHQlnFa0Rlvm9B9MWdansmrYzdEVqE+6IfVOXsdkeY8u2vKM9EjDYpeQ dQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3juvnnkqxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 12:28:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28SCSsD5031101
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 12:28:54 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 28 Sep 2022 05:28:48 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v10 6/7] remoteproc: qcom: Add efuse evb selection control
Date:   Wed, 28 Sep 2022 17:57:52 +0530
Message-ID: <1664368073-13659-7-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1664368073-13659-1-git-send-email-quic_srivasam@quicinc.com>
References: <1664368073-13659-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3MsK6Bg9SgRVc40Zkadl0eyZk9wp-ct1
X-Proofpoint-GUID: 3MsK6Bg9SgRVc40Zkadl0eyZk9wp-ct1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_05,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxlogscore=995 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209280077
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add efuse evb selection control and enable it for starting ADSP.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>
---
Changes since V5:
	-- Split devm_platform_ioremap_resource_byname function.

 drivers/remoteproc/qcom_q6v5_adsp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 14c94af..4e70e76 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -56,6 +56,7 @@
 
 #define LPASS_BOOT_CORE_START	BIT(0)
 #define LPASS_BOOT_CMD_START	BIT(0)
+#define LPASS_EFUSE_Q6SS_EVB_SEL 0x0
 
 struct adsp_pil_data {
 	int crash_reason_smem;
@@ -86,6 +87,7 @@ struct qcom_adsp {
 	struct clk_bulk_data *clks;
 
 	void __iomem *qdsp6ss_base;
+	void __iomem *lpass_efuse;
 
 	struct reset_control *pdc_sync_reset;
 	struct reset_control *restart;
@@ -367,6 +369,9 @@ static int adsp_start(struct rproc *rproc)
 	/* Program boot address */
 	writel(adsp->mem_phys >> 4, adsp->qdsp6ss_base + RST_EVB_REG);
 
+	if (adsp->lpass_efuse)
+		writel(LPASS_EFUSE_Q6SS_EVB_SEL, adsp->lpass_efuse);
+
 	/* De-assert QDSP6 stop core. QDSP6 will execute after out of reset */
 	writel(LPASS_BOOT_CORE_START, adsp->qdsp6ss_base + CORE_START_REG);
 
@@ -533,6 +538,7 @@ static int adsp_init_reset(struct qcom_adsp *adsp)
 static int adsp_init_mmio(struct qcom_adsp *adsp,
 				struct platform_device *pdev)
 {
+	struct resource *efuse_region;
 	struct device_node *syscon;
 	int ret;
 
@@ -542,6 +548,17 @@ static int adsp_init_mmio(struct qcom_adsp *adsp,
 		return PTR_ERR(adsp->qdsp6ss_base);
 	}
 
+	efuse_region = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!efuse_region) {
+		adsp->lpass_efuse = NULL;
+		dev_dbg(adsp->dev, "failed to get efuse memory region\n");
+	} else {
+		adsp->lpass_efuse = devm_ioremap_resource(&pdev->dev, efuse_region);
+		if (IS_ERR(adsp->lpass_efuse)) {
+			dev_err(adsp->dev, "failed to map efuse registers\n");
+			return PTR_ERR(adsp->lpass_efuse);
+		}
+	}
 	syscon = of_parse_phandle(pdev->dev.of_node, "qcom,halt-regs", 0);
 	if (!syscon) {
 		dev_err(&pdev->dev, "failed to parse qcom,halt-regs\n");
-- 
2.7.4

