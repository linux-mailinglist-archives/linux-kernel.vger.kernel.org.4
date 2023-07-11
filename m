Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF5374E676
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjGKFrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGKFrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:47:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6356195;
        Mon, 10 Jul 2023 22:47:13 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B5j3et020238;
        Tue, 11 Jul 2023 05:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=9MzliAnqFZmJVnQfQhjw7eHWeG8MKdDCklNfu2rE8pg=;
 b=MpeawPgTabtNlb6MqSSXt2ESvxalgdLOj24e+KY9o5lraoMZ7thCyEsi/X5dCZDPJbgq
 +QsmWMIV+FJ62Gyg07EJjr+ZhExMlqAvpeXkdiQFk0W6sL8rnWDDTPWAnh7qmbJXMRf3
 EGyhYA5BcCCE6xOgimO+HGUV8OIODU/IMEBF1ZEfu8TTtKdmxNgpoTYyS0QyqeUNSKiB
 VxqcsKOD4TPdLvfi3wxtF4z9WmD0ZZg/cZUwOc7gTLviD7HYiv2w/wLYSL5fMPSj3kq7
 eaqtbpbJJT641o0OZD1xnAabVf3fzovRg8nSM8AimB3FesQ8Sr+gx7QtF2W/wMSD/8Hr HQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs174r03t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 05:47:09 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36B5gxXw005174;
        Tue, 11 Jul 2023 05:47:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rq0vm2hgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Jul 2023 05:47:05 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36B5l5LI008333;
        Tue, 11 Jul 2023 05:47:05 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 36B5l5TN008330;
        Tue, 11 Jul 2023 05:47:05 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id C15D45045; Tue, 11 Jul 2023 11:17:04 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 2/2] regulator: qcom-rpmh: Add regulators for PMX75
Date:   Tue, 11 Jul 2023 11:16:55 +0530
Message-Id: <1689054415-11281-3-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689054415-11281-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1689054415-11281-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MxaJdlgQ-RqDw20SRBOkI12Nwvr0-caH
X-Proofpoint-ORIG-GUID: MxaJdlgQ-RqDw20SRBOkI12Nwvr0-caH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_02,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307110050
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support from RPMH regulators found in PMX75 for SDX75 platform.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 drivers/regulator/qcom-rpmh-regulator.c | 38 +++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index f3b280a..0881e91 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -1273,6 +1273,40 @@ static const struct rpmh_vreg_init_data pmx65_vreg_data[] = {
 	{}
 };
 
+static const struct rpmh_vreg_init_data pmx75_vreg_data[] = {
+	RPMH_VREG("smps1",   "smp%s1",    &pmic5_ftsmps525_lv, "vdd-s1"),
+	RPMH_VREG("smps2",   "smp%s2",    &pmic5_ftsmps525_lv, "vdd-s2"),
+	RPMH_VREG("smps3",   "smp%s3",    &pmic5_ftsmps525_lv, "vdd-s3"),
+	RPMH_VREG("smps4",   "smp%s4",    &pmic5_ftsmps525_mv, "vdd-s4"),
+	RPMH_VREG("smps5",   "smp%s5",    &pmic5_ftsmps525_lv, "vdd-s5"),
+	RPMH_VREG("smps6",   "smp%s6",    &pmic5_ftsmps525_lv, "vdd-s6"),
+	RPMH_VREG("smps7",   "smp%s7",    &pmic5_ftsmps525_lv, "vdd-s7"),
+	RPMH_VREG("smps8",   "smp%s8",    &pmic5_ftsmps525_lv, "vdd-s8"),
+	RPMH_VREG("smps9",   "smp%s9",    &pmic5_ftsmps525_lv, "vdd-s9"),
+	RPMH_VREG("smps10",  "smp%s10",   &pmic5_ftsmps525_lv, "vdd-s10"),
+	RPMH_VREG("ldo1",    "ldo%s1",    &pmic5_nldo515,   "vdd-l1"),
+	RPMH_VREG("ldo2",    "ldo%s2",    &pmic5_nldo515,   "vdd-l2-18"),
+	RPMH_VREG("ldo3",    "ldo%s3",    &pmic5_nldo515,   "vdd-l3"),
+	RPMH_VREG("ldo4",    "ldo%s4",    &pmic5_nldo515,   "vdd-l4-l16"),
+	RPMH_VREG("ldo5",    "ldo%s5",    &pmic5_pldo_lv,   "vdd-l5-l6"),
+	RPMH_VREG("ldo6",    "ldo%s6",    &pmic5_pldo_lv,   "vdd-l5-l6"),
+	RPMH_VREG("ldo7",    "ldo%s7",    &pmic5_nldo515,   "vdd-l7"),
+	RPMH_VREG("ldo8",    "ldo%s8",    &pmic5_nldo515,   "vdd-l8-l9"),
+	RPMH_VREG("ldo9",    "ldo%s9",    &pmic5_nldo515,   "vdd-l8-l9"),
+	RPMH_VREG("ldo10",   "ldo%s10",   &pmic5_pldo,      "vdd-l10"),
+	RPMH_VREG("ldo11",   "ldo%s11",   &pmic5_pldo,      "vdd-l11-l13"),
+	RPMH_VREG("ldo12",   "ldo%s12",   &pmic5_nldo515,   "vdd-l12"),
+	RPMH_VREG("ldo13",   "ldo%s13",   &pmic5_pldo,      "vdd-l11-l13"),
+	RPMH_VREG("ldo14",   "ldo%s14",   &pmic5_nldo515,   "vdd-l14"),
+	RPMH_VREG("ldo15",   "ldo%s15",   &pmic5_nldo515,   "vdd-l15"),
+	RPMH_VREG("ldo16",   "ldo%s16",   &pmic5_nldo515,   "vdd-l4-l16"),
+	RPMH_VREG("ldo17",   "ldo%s17",   &pmic5_nldo515,   "vdd-l17"),
+	/* ldo18 not configured */
+	RPMH_VREG("ldo19",   "ldo%s19",   &pmic5_nldo515,   "vdd-l19"),
+	RPMH_VREG("ldo20",   "ldo%s20",   &pmic5_nldo515,   "vdd-l20-l21"),
+	RPMH_VREG("ldo21",   "ldo%s21",   &pmic5_nldo515,   "vdd-l20-l21"),
+};
+
 static const struct rpmh_vreg_init_data pm7325_vreg_data[] = {
 	RPMH_VREG("smps1",  "smp%s1",  &pmic5_hfsmps510, "vdd-s1"),
 	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps520, "vdd-s2"),
@@ -1495,6 +1529,10 @@ static const struct of_device_id __maybe_unused rpmh_regulator_match_table[] = {
 		.data = pmx65_vreg_data,
 	},
 	{
+		.compatible = "qcom,pmx75-rpmh-regulators",
+		.data = pmx75_vreg_data,
+	},
+	{
 		.compatible = "qcom,pm7325-rpmh-regulators",
 		.data = pm7325_vreg_data,
 	},
-- 
2.7.4

