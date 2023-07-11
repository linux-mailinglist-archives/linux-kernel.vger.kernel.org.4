Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B98D74EAA9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjGKJg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGKJg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:36:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F70F121;
        Tue, 11 Jul 2023 02:36:26 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B9NDvT028110;
        Tue, 11 Jul 2023 09:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=DumaIzbu8kss2bm0Ne7ddfIHyCtCrODSDZtNqdfr9Lc=;
 b=UuXt2ygWzHj78TL51KhnLWyuAfgjJfqsssP/SJ2L4FDILG9Wf3eQx1EiRDxpnwYZvPGQ
 f6RHQIqV9gvdVwRoZqE8nqDw+zYkmi9XoBkJeINs+6+ZF7AczJ469c7XfpZVyXBFvRln
 c/GwSkXxxdr903ox2omfU87i7fdM7O2GWzP2vERAv17axQgvkRZxhMwcRqdVOTwUGKZ5
 R/qrl8IPmvLq24UNG69LvOMCOpS08kCl38CEKzAUvMZxWS27EopngfkM6RTKHENLR5iN
 wpa0tzEEZKOhwk+UD/aJGxti7vO39kQP5rAjlpiM8efV4/1byy4hubhv9bjA42vAf34p CA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs4db00mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 09:35:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36B9ZuQG005239
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 09:35:56 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 02:35:49 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <richardcochran@gmail.com>,
        <arnd@arndb.de>, <geert+renesas@glider.be>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
CC:     <quic_saahtoma@quicinc.com>
Subject: [PATCH 1/6] clk: qcom: clk-alpha-pll: Add NSS HUAYRA ALPHA PLL support for ipq9574
Date:   Tue, 11 Jul 2023 15:05:24 +0530
Message-ID: <20230711093529.18355-2-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230711093529.18355-1-quic_devipriy@quicinc.com>
References: <20230711093529.18355-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cy4XgVlOlSxRNHdWmiKlIepBf8w7b9q9
X-Proofpoint-ORIG-GUID: cy4XgVlOlSxRNHdWmiKlIepBf8w7b9q9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=864 priorityscore=1501 malwarescore=0 impostorscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1011 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for NSS Huayra alpha pll found on ipq9574 SoCs.
Programming sequence is the same as that of Huayra type Alpha PLL,
so we can re-use the same.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 drivers/clk/qcom/clk-alpha-pll.c | 12 ++++++++++++
 drivers/clk/qcom/clk-alpha-pll.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index e4ef645f65d1..1c2a72840cd2 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -228,6 +228,18 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
 		[PLL_OFF_ALPHA_VAL] = 0x24,
 		[PLL_OFF_ALPHA_VAL_U] = 0x28,
 	},
+
+	[CLK_ALPHA_PLL_TYPE_NSS_HUAYRA] =  {
+		[PLL_OFF_L_VAL] = 0x04,
+		[PLL_OFF_ALPHA_VAL] = 0x08,
+		[PLL_OFF_TEST_CTL] = 0x0c,
+		[PLL_OFF_TEST_CTL_U] = 0x10,
+		[PLL_OFF_USER_CTL] = 0x14,
+		[PLL_OFF_CONFIG_CTL] = 0x18,
+		[PLL_OFF_CONFIG_CTL_U] = 0x1c,
+		[PLL_OFF_STATUS] = 0x20,
+	},
+
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
 
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index e4bd863027ab..cb079a6ed96a 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -28,6 +28,7 @@ enum {
 	CLK_ALPHA_PLL_TYPE_BRAMMO_EVO,
 	CLK_ALPHA_PLL_TYPE_STROMER,
 	CLK_ALPHA_PLL_TYPE_STROMER_PLUS,
+	CLK_ALPHA_PLL_TYPE_NSS_HUAYRA,
 	CLK_ALPHA_PLL_TYPE_MAX,
 };
 
-- 
2.17.1

