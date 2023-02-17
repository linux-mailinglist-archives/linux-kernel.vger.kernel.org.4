Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0806F69ADE3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBQOV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBQOVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:21:24 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556DB6C00B;
        Fri, 17 Feb 2023 06:21:10 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HC9CHm029204;
        Fri, 17 Feb 2023 14:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=kN1pMvQMvf4rNJk5oLI8P6wuj92iycXwvvelsT3HbMs=;
 b=QGYGsYtSik73OoglRfEDZ8wAmP2lpvbg/8i+qNDNOz19+Zssz+opHCmXHOg7VRZmExl7
 mWJvNw73u4esS13Rft4Xyi8iPXvKnbCzzpzzV9Bu0O7N7OIJ7a8BzgbXIU9AXIQdjfA1
 LtGOMgg5GyDwL+51ujzS5dTDUzlTlcOKQRiEoqp+GEbAI6VUro8bWj407LiuE+SzuxPc
 OubvyfvqmNjayiKm0UeFnnkilscFVgFtB/t6tCuTUXlTxZXxFc1aI9tCHDOfJX5cm3/u
 9mgKfh4TPR6XJiMSY5ElqfpUMVpR3AMzqSPZtYdUmekFfCdOVp3cclS+V77C26X8cNAe rg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nsgttc32j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 14:21:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31HEL6JV019859
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 14:21:06 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 17 Feb 2023 06:21:00 -0800
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_ipkumar@quicinc.com>
Subject: [PATCH V2 3/6] regulator: qcom_smd: Add MP5496 S1 regulator
Date:   Fri, 17 Feb 2023 19:50:27 +0530
Message-ID: <20230217142030.16012-4-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230217142030.16012-1-quic_devipriy@quicinc.com>
References: <20230217142030.16012-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3oPD5rVuIKNb-6ztUcrLboAGO_ojVaB9
X-Proofpoint-ORIG-GUID: 3oPD5rVuIKNb-6ztUcrLboAGO_ojVaB9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=987 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170130
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support for MP5496 S1 regulator on IPQ9574 SoC

Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes in V2:
	- Extended the existing MP5496 support with S1 regulator
	  and dropped the ipq9574 compatible

 drivers/regulator/qcom_smd-regulator.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 9f2b58458841..a40e66cea7e7 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -749,6 +749,15 @@ static const struct regulator_desc pms405_pldo600 = {
 	.ops = &rpm_smps_ldo_ops,
 };
 
+static const struct regulator_desc mp5496_smpa1 = {
+	.linear_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(600000, 0, 127, 12500),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 128,
+	.ops = &rpm_mp5496_ops,
+};
+
 static const struct regulator_desc mp5496_smpa2 = {
 	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(600000, 0, 127, 12500),
@@ -794,6 +803,7 @@ struct rpm_regulator_data {
 };
 
 static const struct rpm_regulator_data rpm_mp5496_regulators[] = {
+	{ "s1", QCOM_SMD_RPM_SMPA, 1, &mp5496_smpa1, "s1" },
 	{ "s2", QCOM_SMD_RPM_SMPA, 2, &mp5496_smpa2, "s2" },
 	{ "l2", QCOM_SMD_RPM_LDOA, 2, &mp5496_ldoa2, "l2" },
 	{}
-- 
2.17.1

