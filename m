Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D492680D44
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbjA3MMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbjA3MLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:11:53 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A857437B73;
        Mon, 30 Jan 2023 04:10:58 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U9L4fJ020316;
        Mon, 30 Jan 2023 12:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=H02OYIqYF0RL/cTxU6PmDoYttvm0j21J0dmxP2N/sYQ=;
 b=Mg3fZJArHrPuxtp0T4DCbwnDnlYNAj5VrKxJ30dWER0b2nakdyc3U9y2EoL9QlKD7pKM
 Br14AdRN5uISVP92Dmz+UEOWWaAguSWwN6EC6W9J78UZJnul0FwUoYNrijul0iPpcrye
 U8WsCG0bI/Si9yc9jiukS8tPGUiDCGDcoac3hAoDQquceOD2srXEs2+3STvce7qJU+fZ
 QmLGTs5geUTWpv50KkXzhObv6pOskb4u1+OJ3OmCFgYiK/sOszPPCwHjYttw5q+VE8Vf
 xa0ZgH0Jpk1hOS63lnURZo0iX/J1QwGn8jCgBXFqVUwN4FS2hg2IvlhblIk/Di1yCUnz 3Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncvfpbcn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 12:10:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30UCAGcq002568
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 12:10:16 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 30 Jan 2023 04:10:13 -0800
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
To:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH] clk: qcom: ipq5332: mark GPLL4 as critical temporarily
Date:   Mon, 30 Jan 2023 17:39:59 +0530
Message-ID: <20230130120959.9457-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SyM2C95zJgOU4YOw8eioxI2nC6CAWs2o
X-Proofpoint-ORIG-GUID: SyM2C95zJgOU4YOw8eioxI2nC6CAWs2o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_10,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxlogscore=786 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300117
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kathiravan T <quic_kathirav@quicinc.com>

Clock framework disables the GPLL4 source since there are no active users
for this source currently. Some of the clocks initialized by the
bootloaders uses the GPLL4 as the source. Due to this, when the GPLL4 is
disabled by the clock framework, system is going for the reboot.

To avoid this, mark the GPLL4 as CRITICAL so that clock framework
doesn't disable it. Once the users of this source is enabled, we can get
rid of this flag.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
Note: This patch depends on the IPQ5332 baseport series
https://lore.kernel.org/linux-arm-msm/20230130114702.20606-1-quic_kathirav@quicinc.com/T/#t

 drivers/clk/qcom/gcc-ipq5332.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index a8ce618bb81b..6159d0e1e43f 100644
--- a/drivers/clk/qcom/gcc-ipq5332.c
+++ b/drivers/clk/qcom/gcc-ipq5332.c
@@ -127,6 +127,7 @@ static struct clk_alpha_pll gpll4_main = {
 			.parent_data = &gcc_parent_data_xo,
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_stromer_ops,
+			.flags = CLK_IS_CRITICAL,
 		},
 	},
 };
-- 
2.17.1

