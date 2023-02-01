Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BB1686264
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjBAJGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjBAJGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:06:51 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E8661D4F;
        Wed,  1 Feb 2023 01:06:28 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31187BZ8029006;
        Wed, 1 Feb 2023 09:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=rF2hfdBo7/5gPnVO8XVQBFgol9bRPYLLridw5CtoSCs=;
 b=fEs4p+lOd7p5eBeMgl84vRwB1SMuHakW+OIp9/zF9pzfDwwqSURgnRBKPE8kbyKB1zeB
 mcFtUjcwTW9d9iOEfFulLJRL+l8J9AF51jCCSsPPvnivsHpAHc6Cp186qZD4XXqDgVbq
 IRhKd/aS9FkKeONF+EAgOaO1lQKysD7SxLoJ1CWH+bio35KGqtADUtezqj0Yi76ouX9q
 02WM6g+G9Li/8ilvfrFKnqcNufFX7P7druIpDUz+gs4YDTgaQ4cf4fXuli7nmv6DTb3r
 cUZJuKww518jo3OX2WFNLHHO6y3MsDNepWZfrvJm6EpIOiOJQuynQISp7T4Xm0y4ArnD eQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfm9g04pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 09:06:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31196EgD023715
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 09:06:14 GMT
Received: from poovendh-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 1 Feb 2023 01:06:05 -0800
From:   Poovendhan Selvaraj <quic_poovendh@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jassisinghbrar@gmail.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <robimarko@gmail.com>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH V2 2/5] arm64: dts: Add support for Crashdump collection on IPQ9574
Date:   Wed, 1 Feb 2023 14:35:26 +0530
Message-ID: <20230201090529.30446-3-quic_poovendh@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230201090529.30446-1-quic_poovendh@quicinc.com>
References: <20230201090529.30446-1-quic_poovendh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CjxRJxKGQvPawKQ14sA3XzobKMi8KVK7
X-Proofpoint-GUID: CjxRJxKGQvPawKQ14sA3XzobKMi8KVK7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_03,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=763 suspectscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Crashdump collection in ipq9574

Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
Co-developed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index a425b1865129..3b615acedfd5 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -81,6 +81,13 @@
 		reg = <0x0 0x40000000 0x0 0x0>;
 	};
 
+	firmware {
+		scm {
+			compatible = "qcom,scm-ipq9574", "qcom,scm";
+			qcom,dload-mode = <&tcsr_boot_misc 0>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,cortex-a73-pmu";
 		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
@@ -95,11 +102,17 @@
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
-
 		tz_region: tz@4a600000 {
 			reg = <0x0 0x4a600000 0x0 0x400000>;
 			no-map;
 		};
+
+		smem@4aa00000 {
+			compatible = "qcom,smem";
+			reg = <0x0 0x4aa00000 0x0 0x00100000>;
+			hwlocks = <&tcsr_mutex 0>;
+			no-map;
+		};
 	};
 
 	soc: soc@0 {
@@ -150,6 +163,17 @@
 			#power-domain-cells = <1>;
 		};
 
+		tcsr_mutex: hwlock@1905000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0x01905000 0x8000>;
+			#hwlock-cells = <1>;
+		};
+
+		tcsr_boot_misc: syscon@193d100 {
+			ompatible = "qcom,tcsr-ipq9574", "syscon";
+			reg = <0x0193d100 0x4>;
+		};
+
 		sdhc_1: mmc@7804000 {
 			compatible = "qcom,ipq9574-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x07804000 0x1000>, <0x07805000 0x1000>;
-- 
2.17.1

