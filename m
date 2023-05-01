Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A9D6F32DD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjEAP20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjEAP2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:28:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942ABAA;
        Mon,  1 May 2023 08:28:22 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341FSIYV003625;
        Mon, 1 May 2023 15:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=WxVYXWAROQLyqngVyIjkA6PL1TyrGM+M/4XnTbSf9Js=;
 b=NikjnHdxgDowrfCxfzuCBzAH7GgfIfY3/8adlGc83PyI4gTVRvFgHP1zqg8uC9RkAk6L
 qEoKAsma4r1Uz8TKmqBbDr7DhcpSNBOafa4dBSuChGtW5KKWfdnULvwyG+sYrHz0MaxX
 Rgoz8+VG+S1pQ6ZMgbTno/dbX1HCYj39OfZ3/Sa9MnKNr+nRcTi8sg52S9zVvkneRgmq
 3+gerSOuABk59pH/KH7GFsdj3fJSbeEtgRaQvRNtYau1t3Qns1t252B57kgpYYzmp6RC
 KDQO5gIGUyUS6uleS9KpSlECC9ZoIlniAQlZxlUyurL89yqsDhp0QpdoM3a5oOJBGQbw Ag== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q8ub33vsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 May 2023 15:28:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 341FSGhm001480
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 May 2023 15:28:16 GMT
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 1 May 2023 08:28:13 -0700
From:   Taniya Das <quic_tdas@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_skakitap@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>
Subject: [PATCH] clk: qcom: rcg: Update rcg configuration before enabling it
Date:   Mon, 1 May 2023 20:57:32 +0530
Message-ID: <20230501152732.9245-1-quic_tdas@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8qeVBL17wU7HePPciFAE2GRzCOu06Gat
X-Proofpoint-ORIG-GUID: 8qeVBL17wU7HePPciFAE2GRzCOu06Gat
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_08,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxscore=0 impostorscore=0 spamscore=0 mlxlogscore=803 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305010125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If rcg is in disabled state when clk_rcg2_shared_set_rate is called, the
new configuration is written to the configuration register but it won't be
effective in h/w yet because update bit won't be set if rcg is in disabled
state. Since the new configuration is not yet updated in h/w, dirty bit of
configuration register will be set in such case. Clear the dirty bit and
update the rcg to proper new configuration by setting the update bit before
enabling the rcg.

Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
 drivers/clk/qcom/clk-rcg2.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 76551534f10d..b36377979f21 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -980,7 +980,13 @@ static int clk_rcg2_set_force_enable(struct clk_hw *hw)
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
2.17.1

