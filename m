Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36BD7092BB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjESJKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjESJKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:10:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BE0E73;
        Fri, 19 May 2023 02:09:59 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34J73M8k011780;
        Fri, 19 May 2023 09:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=1DcmjSisKtaqkkiT8rQeDecEULfn2pV5E5qjM0J3/Ds=;
 b=pXZJ5mokXhe+kFXQOcgeueXm3DSoQeNM1ZMkiejP6g6J8dk2SIXQkhQQ3lDcrycXWGYH
 /tmo5vwj/j4S5c0A716L7cRI5Dyz8wIj6EmyryGIUAwBLFuLNFMlZkGodZhSB4J9iySE
 DLgYNrooIo52C5N2JS/M5xjk0zfB7yNaGad8ulz95Ukhco2GOjldsJMR5a4idpKx5V5p
 RKFi6xpORR5hsXsioZNDvVUg6Qg5fxKfkpW9ltpo6kuYCzXROIaxTngvRuZ6jo8vyC7C
 npb3cYUsUB7TgGrjhMP5wT5rj4APGiw4iYzCXahNFR7SKEZ6Cvl8goss/VT/usm8XI1j UQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qp4ccr8hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 09:09:18 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34J99ELR031684;
        Fri, 19 May 2023 09:09:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qj3mm558u-1;
        Fri, 19 May 2023 09:09:14 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34J99C9O031608;
        Fri, 19 May 2023 09:09:14 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 34J99D8b031636;
        Fri, 19 May 2023 09:09:13 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 2B9625EC0; Fri, 19 May 2023 14:39:13 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, tglx@linutronix.de, maz@kernel.org,
        will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robimarko@gmail.com, quic_gurus@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Imran Shaik <quic_imrashai@quicinc.com>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 6/8] arm64: dts: qcom: Add support for GCC and RPMHCC for SDX75
Date:   Fri, 19 May 2023 14:39:08 +0530
Message-Id: <1684487350-30476-7-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1684487350-30476-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1684487350-30476-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ehiu0DxW4KUkT6hqqkgWWNakqdIkYIuW
X-Proofpoint-ORIG-GUID: Ehiu0DxW4KUkT6hqqkgWWNakqdIkYIuW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_05,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=928 suspectscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305190076
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Imran Shaik <quic_imrashai@quicinc.com>

Add support for GCC and RPMHCC clock nodes for SDX75 platform.

Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sdx75.dtsi | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
index c2b8810..dbbd2f4 100644
--- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
@@ -7,6 +7,7 @@
  */
 
 #include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/clock/qcom,sdx75-gcc.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
@@ -23,7 +24,21 @@
 		reg = <0 0 0 0>;
 	};
 
-	clocks { };
+	clocks {
+		xo_board: xo_board {
+			compatible = "fixed-clock";
+			clock-frequency = <76800000>;
+			clock-output-names = "xo_board";
+			#clock-cells = <0>;
+		};
+
+		sleep_clk: sleep_clk {
+			compatible = "fixed-clock";
+			clock-frequency = <32000>;
+			clock-output-names = "sleep_clk";
+			#clock-cells = <0>;
+		};
+	};
 
 	cpus {
 		#address-cells = <2>;
@@ -358,6 +373,18 @@
 		ranges;
 		compatible = "simple-bus";
 
+		gcc: clock-controller@80000 {
+			compatible = "qcom,sdx75-gcc";
+			reg = <0x0 0x0080000 0x0 0x1f7400>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&sleep_clk>;
+			clock-names = "bi_tcxo",
+				      "sleep_clk";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x40000>;
@@ -520,6 +547,14 @@
 			apps_bcm_voter: bcm_voter {
 				compatible = "qcom,bcm-voter";
 			};
+
+			rpmhcc: clock-controller {
+				compatible = "qcom,sdx75-rpmh-clk";
+				clocks = <&xo_board>;
+				clock-names = "xo";
+				#clock-cells = <1>;
+			};
+
 		};
 	};
 
-- 
2.7.4

