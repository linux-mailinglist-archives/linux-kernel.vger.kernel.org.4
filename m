Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A90669AED
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjAMOvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjAMOv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:51:26 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907B1A41F3;
        Fri, 13 Jan 2023 06:37:51 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DD1JnT008266;
        Fri, 13 Jan 2023 14:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=FXPnunrhdcpD2U9KcjoaHr8Be6vGt3y43oqp6fmj+w4=;
 b=T+QwPYi3wC2u6dJyvIxNbfJb9cAIu/6iCmf5Lp+A7nSZXM2/hOV3Dl6Du7jh2+VzP94t
 pH32MveUa8OOe1r2gj/ogxAuJPUysRAdJqSdMapKE/kUh52drdwaYJ4RPP+ThX1Dfka9
 u0wpmnmQNLXA19xyTRONysTSJucrAqRlJ3y2HI22qf21PY9NiU3wVcMhloOPBF7nZ/NC
 At7q3qYyZg258cGzSBNk46yg5G7bHbeIr5YUUy41BpmMa42ZYrslgzYuVXj+SJt+YuBg
 2YtmRaRWF3/D3Md1OE8C8Ey3OoBhQv9RrXu0Nxlb+wtwrp+qqHdtw83TBDGzN0LAcD5K 9g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n351f8w7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 14:37:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DEbQ3C030456
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 14:37:27 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 13 Jan 2023 06:37:19 -0800
From:   devi priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <jassisinghbrar@gmail.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
Subject: [PATCH 2/6] clk: qcom: ipq9574: Enable APSS clock driver
Date:   Fri, 13 Jan 2023 20:06:43 +0530
Message-ID: <20230113143647.14961-3-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230113143647.14961-1-quic_devipriy@quicinc.com>
References: <20230113143647.14961-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Grb9o1kJCR7lhmJ7Ynu42Wv5wKkKsAN_
X-Proofpoint-ORIG-GUID: Grb9o1kJCR7lhmJ7Ynu42Wv5wKkKsAN_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_06,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130096
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable APSS clock driver for IPQ9574 based devices

Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: devi priya <quic_devipriy@quicinc.com>
---
 drivers/clk/qcom/apss-ipq-pll.c         | 13 +++++++++++++
 drivers/mailbox/qcom-apcs-ipc-mailbox.c |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index a5aea27eb867..dd0c01bf5a98 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -61,6 +61,18 @@ static const struct alpha_pll_config ipq8074_pll_config = {
 	.test_ctl_hi_val = 0x4000,
 };
 
+static const struct alpha_pll_config ipq9574_pll_config = {
+	.l = 0x3b,
+	.config_ctl_val = 0x200D4828,
+	.config_ctl_hi_val = 0x6,
+	.early_output_mask = BIT(3),
+	.aux2_output_mask = BIT(2),
+	.aux_output_mask = BIT(1),
+	.main_output_mask = BIT(0),
+	.test_ctl_val = 0x0,
+	.test_ctl_hi_val = 0x4000,
+};
+
 static const struct regmap_config ipq_pll_regmap_config = {
 	.reg_bits		= 32,
 	.reg_stride		= 4,
@@ -102,6 +114,7 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
 static const struct of_device_id apss_ipq_pll_match_table[] = {
 	{ .compatible = "qcom,ipq6018-a53pll", .data = &ipq6018_pll_config },
 	{ .compatible = "qcom,ipq8074-a53pll", .data = &ipq8074_pll_config },
+	{ .compatible = "qcom,ipq9574-a73pll", .data = &ipq9574_pll_config },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, apss_ipq_pll_match_table);
diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 0e9f9cba8668..90e74f9d7cb3 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -33,6 +33,10 @@ static const struct qcom_apcs_ipc_data ipq6018_apcs_data = {
 	.offset = 8, .clk_name = "qcom,apss-ipq6018-clk"
 };
 
+static const struct qcom_apcs_ipc_data ipq9574_apcs_data = {
+	.offset = 8, .clk_name = "qcom,apss-ipq6018-clk"
+};
+
 static const struct qcom_apcs_ipc_data msm8916_apcs_data = {
 	.offset = 8, .clk_name = "qcom-apcs-msm8916-clk"
 };
@@ -143,6 +147,7 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
 static const struct of_device_id qcom_apcs_ipc_of_match[] = {
 	{ .compatible = "qcom,ipq6018-apcs-apps-global", .data = &ipq6018_apcs_data },
 	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = &ipq6018_apcs_data },
+	{ .compatible = "qcom,ipq9574-apcs-apps-global", .data = &ipq9574_apcs_data },
 	{ .compatible = "qcom,msm8916-apcs-kpss-global", .data = &msm8916_apcs_data },
 	{ .compatible = "qcom,msm8939-apcs-kpss-global", .data = &msm8916_apcs_data },
 	{ .compatible = "qcom,msm8953-apcs-kpss-global", .data = &msm8994_apcs_data },
-- 
2.17.1

