Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD91745ED7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjGCOnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjGCOmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:42:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A50510F8;
        Mon,  3 Jul 2023 07:42:45 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363DeJeA028550;
        Mon, 3 Jul 2023 14:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=6BEryEGco3pPQuKABB8CJ/SbUmj6JCX3kIAjJB7BuEw=;
 b=fZ4ABiDOdm1AflcX67IAhOSSWlfaK6TbgaM5NGhQiRx5BUsIZYgNQXbgsXbMYLYBM+06
 22dHlTiRj5uufSRX1iMldjCbE2UqTCVK7DQ5WZXUiL2Ga0MhdLYiFFrRGvzXnLNr3Tsw
 UrE+6CKpe8GnR58+svXYHdH0AN+jaSRdgqj3GrxaHgtegZyX0NiBkq+8V/N+TEqbX5et
 tC3zacMSXLazul25o/R+V4MhlDgAs1U/1SA2IwAzT/j3y4fPRRYqUgFs7lGlJiUJWaXH
 tGeuqOonHDtc5nm99yWfDT8gnNTMoKNPu0sUMUl5Onptqo+JT61vmR3ssi2tIj+OGIIq hA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rkw8s0dvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 14:42:35 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 363EgUVh031931;
        Mon, 3 Jul 2023 14:42:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rjd7k8gf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 03 Jul 2023 14:42:32 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 363EgRgX031491;
        Mon, 3 Jul 2023 14:42:31 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 363EgTaN031748;
        Mon, 03 Jul 2023 14:42:31 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 3A2845025; Mon,  3 Jul 2023 20:12:31 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 08/10] regulator: qcom-rpmh: Add support for SDX75
Date:   Mon,  3 Jul 2023 20:12:24 +0530
Message-Id: <1688395346-3126-9-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688395346-3126-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1688395346-3126-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rRwu-IMWcXPfYEG8XAD8FXqWM7f2fcNl
X-Proofpoint-GUID: rRwu-IMWcXPfYEG8XAD8FXqWM7f2fcNl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030132
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support from RPMH regulators found in SDX75 platform.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 drivers/regulator/qcom-rpmh-regulator.c | 38 +++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index b0a58c6..96d8fab 100644
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

