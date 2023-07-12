Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF41E74FCDA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 03:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjGLBtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 21:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGLBs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 21:48:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57511E77;
        Tue, 11 Jul 2023 18:48:58 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C1NjwK031759;
        Wed, 12 Jul 2023 01:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=EWcZrFBokUNXA5MWY2Gfua1jZDwquuKinWM129p9ets=;
 b=juepHxDHq4RLDDTthSJ84bjB9E/+BRDUAP43/i5cuJblpBNMUeOeQ+y84KM36RoXRSRy
 7iFNv1JVAfMYqkSHGxP0nizsjGgovuzYY0ThcontPmo85X+jGaB6p5fXXBSP6x+CBZVk
 LLAtcEHLb+/mbTH72hiL6puc0j0/lELq5GfoBut2dUNnMJF/FzWOojWJr0Edf4iZcIU1
 QXzaOuQoVHmPRzWI3glyUdS8lxPrdE+6BfGMtNsduCmMW6GdBVdD5Et/IKN8XeF7dwhz
 tDy73ez765srGH2qiiMhNoiGKuALRYt24CCcNqT/GESJ+sVeH73+85+d63XcUYoPx8UX uw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsgar875y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 01:48:51 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36C1mp9B005540
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 01:48:51 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 18:48:47 -0700
From:   Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_skakitap@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Taniya Das" <quic_tdas@quicinc.com>
Subject: [RESEND] clk: qcom: rcg: Update rcg configuration before enabling it
Date:   Wed, 12 Jul 2023 07:18:12 +0530
Message-ID: <20230712014812.3337992-1-quic_skakitap@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BLNQQmV3UXjnbcXaDp56xIW3SuiHsTDd
X-Proofpoint-ORIG-GUID: BLNQQmV3UXjnbcXaDp56xIW3SuiHsTDd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_14,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=637 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1011 adultscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120013
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taniya Das <quic_tdas@quicinc.com>

If rcg is in disabled state when clk_rcg2_shared_set_rate is called, the
new configuration is written to the configuration register but it won't be
effective in h/w yet because update bit won't be set if rcg is in disabled
state. Since the new configuration is not yet updated in h/w, dirty bit of
configuration register will be set in such case. Clear the dirty bit and
update the rcg to proper new configuration by setting the update bit before
enabling the rcg.

Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
Resending this patch as there is no review for 2 months.

 drivers/clk/qcom/clk-rcg2.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index e22baf3a7112..b25635feb617 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -982,7 +982,13 @@ static int clk_rcg2_set_force_enable(struct clk_hw *hw)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	const char *name = clk_hw_get_name(hw);
-	int ret, count;
+	int ret, count, val;
+
+	if (!__clk_is_enabled(hw->clk)) {
+		regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CMD_REG, &val);
+		if (val & CMD_DIRTY_CFG)
+			update_config(rcg);
+	}
 
 	ret = regmap_update_bits(rcg->clkr.regmap, rcg->cmd_rcgr + CMD_REG,
 				 CMD_ROOT_EN, CMD_ROOT_EN);
-- 
2.25.1

