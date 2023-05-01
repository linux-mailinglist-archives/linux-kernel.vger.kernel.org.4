Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088E66F31F8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 16:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjEAOac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 10:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjEAOab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 10:30:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E5A12C;
        Mon,  1 May 2023 07:30:29 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341DVP9T012274;
        Mon, 1 May 2023 14:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=N1x/LOuqxeeK6uds95kuS7ciBIWKxQ2BKNqlTjaHWn0=;
 b=Y4Mw2fW0s76d6ytb2ej5tPfkUX/Iux17IPVxsolePjpm8tZuyFwpOC7jsMbMggPpeHtF
 0a7WzkYPBPieZ1nc68wFuo8BTDxWGHRimjiWb/GoNUvoxP/luDrWHqYQ1k9Ohn35NNNL
 +mFRa6Gfv2lghf9e8bWIZ3EyiTWW7LbeopL7NYWl1aBW2MgARPDOtMCEdBy2Js2Oz4G2
 4eXf9+7KynonfwF9arRILwwPY32XrsyPpw+VtGkN1iQGJEi6qHQ9hMsHI2d/aREWiW9J
 FzbVSx+x9cJp9xjC0gzLIHlxwCHFNUgz6exeUxYltOOnjzd2Dkr6ph9dFR1PpHOALX7P tQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q8t71usa5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 May 2023 14:30:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 341EUP1w005898
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 May 2023 14:30:25 GMT
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 1 May 2023 07:30:21 -0700
From:   Taniya Das <quic_tdas@quicinc.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_skakitap@quicinc.com>,
        <quic_cponnapa@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>
Subject: [PATCH V2] clk: qcom: camcc-sc7180: Add parent dependency to all camera GDSCs
Date:   Mon, 1 May 2023 19:59:32 +0530
Message-ID: <20230501142932.13049-1-quic_tdas@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TacN5I0xAo4Mu2Ym9QSVaZn0SEJd-SN_
X-Proofpoint-ORIG-GUID: TacN5I0xAo4Mu2Ym9QSVaZn0SEJd-SN_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_08,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=729 lowpriorityscore=0 impostorscore=0 phishscore=0
 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305010116
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Camera titan top GDSC is a parent supply to all other camera GDSCs. Titan
top GDSC is required to be enabled before enabling any other camera GDSCs
and it should be disabled only after all other camera GDSCs are disabled.
Ensure this behavior by marking titan top GDSC as parent of all other
camera GDSCs.

Fixes: 15d09e830bbc ("clk: qcom: camcc: Add camera clock controller driver for SC7180")
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
Changes since v1:
 - Expanded the commit text and added fixes tag.

 drivers/clk/qcom/camcc-sc7180.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/qcom/camcc-sc7180.c b/drivers/clk/qcom/camcc-sc7180.c
index e2b4804695f3..8a4ba7a19ed1 100644
--- a/drivers/clk/qcom/camcc-sc7180.c
+++ b/drivers/clk/qcom/camcc-sc7180.c
@@ -1480,12 +1480,21 @@ static struct clk_branch cam_cc_sys_tmr_clk = {
 	},
 };

+static struct gdsc titan_top_gdsc = {
+	.gdscr = 0xb134,
+	.pd = {
+		.name = "titan_top_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
 static struct gdsc bps_gdsc = {
 	.gdscr = 0x6004,
 	.pd = {
 		.name = "bps_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &titan_top_gdsc.pd,
 	.flags = HW_CTRL,
 };

@@ -1495,6 +1504,7 @@ static struct gdsc ife_0_gdsc = {
 		.name = "ife_0_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &titan_top_gdsc.pd,
 };

 static struct gdsc ife_1_gdsc = {
@@ -1503,6 +1513,7 @@ static struct gdsc ife_1_gdsc = {
 		.name = "ife_1_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &titan_top_gdsc.pd,
 };

 static struct gdsc ipe_0_gdsc = {
@@ -1512,15 +1523,9 @@ static struct gdsc ipe_0_gdsc = {
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = HW_CTRL,
+	.parent = &titan_top_gdsc.pd,
 };

-static struct gdsc titan_top_gdsc = {
-	.gdscr = 0xb134,
-	.pd = {
-		.name = "titan_top_gdsc",
-	},
-	.pwrsts = PWRSTS_OFF_ON,
-};

 static struct clk_hw *cam_cc_sc7180_hws[] = {
 	[CAM_CC_PLL2_OUT_EARLY] = &cam_cc_pll2_out_early.hw,
--
2.17.1

