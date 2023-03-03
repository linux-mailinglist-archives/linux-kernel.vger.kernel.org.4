Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0064F6A9428
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjCCJa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjCCJaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:30:02 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4A5117;
        Fri,  3 Mar 2023 01:29:50 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32355Wr7032092;
        Fri, 3 Mar 2023 09:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eW7zZr44zXmONsCh8kh4YmrKE1J7ANRxhC4Py1i2X/w=;
 b=nCQkS74OBLq+rFIiOK8PFwdKw8EVy2SqTau9s1h50Djz9FrpZ8geHvwAlf79WMkRb80w
 66H64RJTLmvPFaDm+uSbAu5+n5pbr/t46O6wAQInT5hX+THcsM6WkK3r1zc41TqGNEhn
 8/Em/H2kna61F/lSfRBNULJX6ndW42bt9LKd4QixZy+cUpcC9kysSf04vsaDhsEbzUgn
 lSyexFH8FQzZlW53UyZNBj5AZ6jNhzqcG+i7iEonch/OKuDuwXplsRo8QVv6xz1yhi45
 oeQzSMYSFDLpyAWUFL7IxaNzh9v+tIYgC0acqvkhger6nDga8OvvlXKfltLoMTBP6aT/ SQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p2rbgbfut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 09:29:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3239Tcfw016974
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Mar 2023 09:29:38 GMT
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 3 Mar 2023 01:29:35 -0800
From:   Taniya Das <quic_tdas@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Subject: [PATCH 1/2] clk: qcom: common: Handle invalid index error
Date:   Fri, 3 Mar 2023 14:58:58 +0530
Message-ID: <20230303092859.22094-2-quic_tdas@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230303092859.22094-1-quic_tdas@quicinc.com>
References: <20230303092859.22094-1-quic_tdas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yNn3D6vya5rV2xsZ48gpSx2KEe8792Gc
X-Proofpoint-ORIG-GUID: yNn3D6vya5rV2xsZ48gpSx2KEe8792Gc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=839
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030084
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce start_index to handle invalid index error
seen when there are two clock descriptors assigned
to the same clock controller.

[ 3.600604] qcom_cc_clk_hw_get: invalid index 5
[ 3.625251] qcom_cc_clk_hw_get: invalid index 6
[ 3.648190] qcom_cc_clk_hw_get: invalid index 7

Fixes: 120c15528390 ("clk: qcom: Migrate to clk_hw based registration and OF APIs")
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
 drivers/clk/qcom/common.c | 12 ++++++++----
 drivers/clk/qcom/common.h |  1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 75f09e6e057e..0e80535b61f2 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -21,6 +21,7 @@ struct qcom_cc {
 	struct qcom_reset_controller reset;
 	struct clk_regmap **rclks;
 	size_t num_rclks;
+	u32 rclks_start_index;
 };

 const
@@ -226,12 +227,13 @@ static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
 	struct qcom_cc *cc = data;
 	unsigned int idx = clkspec->args[0];

-	if (idx >= cc->num_rclks) {
+	if (idx >= cc->rclks_start_index && idx < cc->num_rclks)
+		return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
+	else if (idx < cc->rclks_start_index && idx >= cc->num_rclks)
 		pr_err("%s: invalid index %u\n", __func__, idx);
-		return ERR_PTR(-EINVAL);
-	}

-	return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
+	return ERR_PTR(-EINVAL);
+
 }

 int qcom_cc_really_probe(struct platform_device *pdev,
@@ -281,6 +283,8 @@ int qcom_cc_really_probe(struct platform_device *pdev,

 	cc->rclks = rclks;
 	cc->num_rclks = num_clks;
+	if (desc->start_index)
+		cc->rclks_start_index = desc->start_index;

 	qcom_cc_drop_protected(dev, cc);

diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 9c8f7b798d9f..924f36af55b3 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -23,6 +23,7 @@ struct qcom_cc_desc {
 	const struct regmap_config *config;
 	struct clk_regmap **clks;
 	size_t num_clks;
+	u32 start_index;
 	const struct qcom_reset_map *resets;
 	size_t num_resets;
 	struct gdsc **gdscs;
--
2.17.1

