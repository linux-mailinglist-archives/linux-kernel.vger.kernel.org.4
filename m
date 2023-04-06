Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D666D8FFB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbjDFHCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbjDFHB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:01:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD7F9013;
        Thu,  6 Apr 2023 00:01:10 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3363tf69011218;
        Thu, 6 Apr 2023 07:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=lZhz5ioxyUYicEKmzqXe20G9owP/70IZtLXMIwDa878=;
 b=kfFHNuB5c4Q4HfGHdiRjmy9uwHoe926moQkfXyEFfEYrEprRFCBkq0kRiQOF7wLPWDN6
 4YcvJ5DJ0mA2CPE9Psvo6wx3t/ur8NfHt/ZrT7UUuOMESeowbIzGqEj8e15//RjpGgUb
 anOSDQnccGHyLo5mxTHGZ7uUtJJkEMdCokjJOxVprANOJQoVTtO7jXlT0Uz2efdELp+8
 +ZFQtpClNTB0uCY2TepgDJd6eUCYwWH6xLKAV7zHiS6mcYjbIbcwZ0GPrqpo5wkfHBdm
 wW0Pui7yFtQcECDpU29DZWtRgTdW9Mdh2aNqIGLrPmYjS0AAjvdQDaYNjqHLkj+ZV2sC SA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3psasthv2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 07:01:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33671354020917
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Apr 2023 07:01:03 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 6 Apr 2023 00:00:57 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_ipkumar@quicinc.com>
Subject: [PATCH V3 2/5] regulator: qcom_smd: Add MP5496 S1 regulator
Date:   Thu, 6 Apr 2023 12:30:29 +0530
Message-ID: <20230406070032.22243-3-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406070032.22243-1-quic_devipriy@quicinc.com>
References: <20230406070032.22243-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FM3CvFIzAANiVptu98BtW3j_1QyNbxmJ
X-Proofpoint-GUID: FM3CvFIzAANiVptu98BtW3j_1QyNbxmJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_02,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 spamscore=0
 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060061
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support for MP5496 S1 regulator on IPQ9574 SoC.

Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes in V3:
	- No change

 drivers/regulator/qcom_smd-regulator.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 6f722b2d682e..cb77b3bd1723 100644
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

