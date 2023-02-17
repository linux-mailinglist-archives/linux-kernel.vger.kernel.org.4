Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272BC69A696
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBQIIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjBQIHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:07:52 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F515D3D5;
        Fri, 17 Feb 2023 00:07:46 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7Jg3t010504;
        Fri, 17 Feb 2023 08:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=6Uo3fDd/EIub4Kcl0EYseEQ8AVFKdTntS4QZgFBZh0o=;
 b=ev+XDbyxt9MX79LDr6TtAgiHO5njqNVBDr1mT+7MB5Xam9t9D1n0LgWS/2xf7kl0+t+q
 Noe9Wcncri9KEV48d9Mlst3hoVbg13uSKeM/xCdiSX2WUA3JJ0w0GezHFVmOfTVuKL/l
 aU1W9FGk46aKBF2UbX89WOMgXg3GoEYHEIh/w/9E/KhDJjtX53FQmyFuKnrOzSksKFE/
 99qnaaZ/+FZHLSFmUXVp7BxhNAeH3E69BCyzEmobNJy58/ghKR0LnzNtGxUKVuw6K2d9
 MQ1DgqvUQdhA2x1X7mtWfY6IOTOO6P0sgqYu5DPo2acT1umwcD/wy18I63wig6c9hBjV WA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nt53br3qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 08:07:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31H87ddk028727
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 08:07:39 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 17 Feb 2023 00:07:36 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     Stephen Boyd <sboyd@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mturquette@baylibre.com>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V3] clk: qcom: ipq5332: mark GPLL4 as critical temporarily
Date:   Fri, 17 Feb 2023 13:37:20 +0530
Message-ID: <20230217080720.5206-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dvIaN0t9bkSWGucrAvxmlR08jsYL6oQP
X-Proofpoint-GUID: dvIaN0t9bkSWGucrAvxmlR08jsYL6oQP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_04,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=888 spamscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock framework disables the GPLL4 source since there are no active users
for this source currently. Some of the clocks initialized by the
bootloaders uses the GPLL4 as the source. Due to this, when the GPLL4 is
disabled by the clock framework, system is going for the reboot.

To avoid this, mark the GPLL4 as CRITICAL so that clock framework
doesn't disable it. Once the users of this source is enabled, we can get
rid of this flag.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
Changes in V3:
	- Fixed the typo in the comment
	- Used CLK_IGNORE_UNUSED instead of CLK_IS_CRITICAL

Changes in V2:
	- Added a comment in driver explaining the need of the flag

 drivers/clk/qcom/gcc-ipq5332.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index 9e4baea33937..bea1194b666a 100644
--- a/drivers/clk/qcom/gcc-ipq5332.c
+++ b/drivers/clk/qcom/gcc-ipq5332.c
@@ -128,6 +128,16 @@ static struct clk_alpha_pll gpll4_main = {
 			.parent_data = &gcc_parent_data_xo,
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_stromer_ops,
+			/*
+			 * There are no consumers for this GPLL in kernel yet,
+			 * (will be added soon), so the clock framework
+			 * disables this source. But some of the clocks
+			 * initialized by boot loaders uses this source. So we
+			 * need to keep this clock ON. Add the CRITICAL flag
+			 * so the clock will not be disabled. Once the consumer
+			 * in kernel is added, we can get rid of this flag.
+			 */
+			.flags = CLK_IGNORE_UNUSED,
 		},
 	},
 };
-- 
2.17.1

