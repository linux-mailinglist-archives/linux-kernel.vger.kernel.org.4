Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E655A669B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjAMPOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjAMPNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:13:24 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00A81BCB6;
        Fri, 13 Jan 2023 07:03:51 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DD7KDZ020656;
        Fri, 13 Jan 2023 15:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=PHH2/l6GOA8jtlzVq6Id5VmQ2Cr9yT6xm6ZMq6MUQ44=;
 b=pdx6E67q+CpAlEcnkPGkCv4SdjPMRYTtOKdjyj2dxnt+m63n+D060gSCzWFJcvcCmDum
 eIeMvSyu3ii+60sA1jFq180YT2hG/QAaEcDIcCIS0THE/hB5OWk2E1Llm91IFEKZdhC3
 CFfnVsyDYqZDQgQc6e3YmBLDYaj/AOcIUU4PdvziFoX/lPg100bqYIsqXcjGXEFXq/0T
 dqiuVPYpoVbikA6FZE8Pm/ixd6vbm1BWEWbyCmh5/z0d2jgeYoZI6E9c0oL1yaY+N+FJ
 jdamaLnIPUVtPW46Ubve85Xz0phH320CEm0bYpAX+oiGevLN5jqaK2tvdmPtpJyrLP9k DQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n32wu98df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 15:03:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DF3lN0010310
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 15:03:47 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 13 Jan 2023 07:03:41 -0800
From:   devi priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
Subject: [PATCH 3/6] regulator: qcom_smd: Add MP5496 regulators
Date:   Fri, 13 Jan 2023 20:33:07 +0530
Message-ID: <20230113150310.29709-4-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230113150310.29709-1-quic_devipriy@quicinc.com>
References: <20230113150310.29709-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8VvaDIIKYzpHBK3yGet0taJ0UdKMGrV1
X-Proofpoint-ORIG-GUID: 8VvaDIIKYzpHBK3yGet0taJ0UdKMGrV1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_07,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130099
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support for PMIC MP5496 on IPQ9574 SoC

Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: devi priya <quic_devipriy@quicinc.com>
---
 drivers/regulator/qcom_smd-regulator.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 9f2b58458841..1eb17d378897 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -767,6 +767,15 @@ static const struct regulator_desc mp5496_ldoa2 = {
 	.ops = &rpm_mp5496_ops,
 };
 
+static const struct regulator_desc ipq9574_mp5496_smpa1 = {
+	.linear_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(600000, 0, 37, 12500),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 38,
+	.ops = &rpm_mp5496_ops,
+};
+
 static const struct regulator_desc pm2250_lvftsmps = {
 	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(320000, 0, 269, 4000),
@@ -799,6 +808,11 @@ static const struct rpm_regulator_data rpm_mp5496_regulators[] = {
 	{}
 };
 
+static const struct rpm_regulator_data rpm_ipq9574_mp5496_regulators[] = {
+	{ "s1", QCOM_SMD_RPM_SMPA, 1, &ipq9574_mp5496_smpa1, "s1" },
+	{}
+};
+
 static const struct rpm_regulator_data rpm_pm2250_regulators[] = {
 	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm2250_lvftsmps, "vdd_s1" },
 	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm2250_lvftsmps, "vdd_s2" },
@@ -1320,6 +1334,8 @@ static const struct rpm_regulator_data rpm_pms405_regulators[] = {
 };
 
 static const struct of_device_id rpm_of_match[] = {
+	{ .compatible = "qcom,rpm-ipq9574-mp5496-regulators",
+		.data = &rpm_ipq9574_mp5496_regulators },
 	{ .compatible = "qcom,rpm-mp5496-regulators", .data = &rpm_mp5496_regulators },
 	{ .compatible = "qcom,rpm-pm2250-regulators", .data = &rpm_pm2250_regulators },
 	{ .compatible = "qcom,rpm-pm6125-regulators", .data = &rpm_pm6125_regulators },
-- 
2.17.1

