Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935D46295B0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbiKOKW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238127AbiKOKWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:22:53 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2317D1F9F1;
        Tue, 15 Nov 2022 02:22:50 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AF8Ek4k004588;
        Tue, 15 Nov 2022 10:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=BIGCnaiFy7YNCZXdgVkrUvh5iKWcR3W3fZ3jy0dp1jQ=;
 b=c4mKFTlUgeS9PeUxCR49hJAlRYpREABMY68/zuQJeClx838WWELy8zSpM6VCQKXFThC6
 /RGbS1v7DkroR5KvGqnUe+ppmjkEzFhpQs41Ps3rvRXU8uzBPz01cSoVJ0geNcsfIcsu
 0Va7MEtqm5l9UargEXTCsnGhh6UVOasa5XAks86Eudvxp2XFKgwMw7Uq724YXtFHdeSn
 zJKxdYgYhB/J7ru7OcJ2wO72BuXnIIxxqEsHXrG2c0/yX93cRepRbwv09tRVveF1X/jx
 z3jGU8N2DgX/DQCf7/5w0OWH/BGweDySC6zkahxI6jEFfEEMBVjlSP9EW0LxLvreVyFn fg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kuxm09hkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 10:22:40 +0000
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2AFAMdJ6019979;
        Tue, 15 Nov 2022 10:22:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3kt4jm3e7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 10:22:39 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AFAL60l018263;
        Tue, 15 Nov 2022 10:22:39 GMT
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 2AFAMdhY019973
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 10:22:39 +0000
Received: from shazhuss-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 15 Nov 2022 02:22:35 -0800
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
To:     <andersson@kernel.org>, <johan@kernel.org>
CC:     <sboyd@kernel.org>, <bmasney@redhat.com>, <agross@kernel.org>,
        <mturquette@baylibre.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] clk: qcom: gcc-sc8280xp: add cxo as parent for three ufs ref clks
Date:   Tue, 15 Nov 2022 15:52:17 +0530
Message-ID: <20221115102217.6381-1-quic_shazhuss@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: C2DtN1PIcxxMrpKWkG_95hEwGahN2_yD
X-Proofpoint-GUID: C2DtN1PIcxxMrpKWkG_95hEwGahN2_yD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_05,2022-11-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 bulkscore=0 mlxlogscore=793 spamscore=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added parent_data as CXO for three UFS reference clocks named,
gcc_ufs_ref_clkref_clk, gcc_ufs_card_clkref_clk and
gcc_ufs_1_card_clkref_clk.

Fixes: d65d005f9a6c ("clk: qcom: add sc8280xp GCC driver")
Link: https://lore.kernel.org/lkml/Y2Tber39cHuOSR%2FW@hovoldconsulting.com/
Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
---
Changes since v1:
- Renamed patch subject. Did not include Brian's T-b comment.
- Added parent data for two ufs phy ref clocks.

v1 of this patch can be found at
https://lore.kernel.org/all/20221030142333.31019-1-quic_shazhuss@quicinc.com/

used below patches for verification on next-20221114
https://lore.kernel.org/lkml/20221104092045.17410-2-johan+linaro@kernel.org/
https://lore.kernel.org/lkml/20221104092045.17410-3-johan+linaro@kernel.org/
https://lore.kernel.org/lkml/20221111113732.461881-1-thierry.reding@gmail.com/

 drivers/clk/qcom/gcc-sc8280xp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
index a18ed88f3b82..b3198784e1c3 100644
--- a/drivers/clk/qcom/gcc-sc8280xp.c
+++ b/drivers/clk/qcom/gcc-sc8280xp.c
@@ -5364,6 +5364,8 @@ static struct clk_branch gcc_ufs_1_card_clkref_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_ufs_1_card_clkref_clk",
+			.parent_data = &gcc_parent_data_tcxo,
+			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5432,6 +5434,8 @@ static struct clk_branch gcc_ufs_card_clkref_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_ufs_card_clkref_clk",
+			.parent_data = &gcc_parent_data_tcxo,
+			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5848,6 +5852,8 @@ static struct clk_branch gcc_ufs_ref_clkref_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_ufs_ref_clkref_clk",
+			.parent_data = &gcc_parent_data_tcxo,
+			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
 	},
-- 
2.38.0

