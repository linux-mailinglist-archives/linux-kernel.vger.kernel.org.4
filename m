Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D447364C8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjFTHfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjFTHe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:34:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8552B119;
        Tue, 20 Jun 2023 00:34:27 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35K7RtiS015363;
        Tue, 20 Jun 2023 07:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=EwDQ8V1o8aMoce5+y4ZLTI9J03Z8DIY0p5SfAX3XBG4=;
 b=LEi/bP85d757d0nbbmDQ4/EJVH/h/X+o7yM0tqGYQdnnEpYISCwiN3eCcdN9vsYUxPZT
 B6VITbzY2yOB0Zzl8UHot4scP7Bke8xIz9PGC9RkqEIcglIu9pBv4+IDAq7lHm1QQNOS
 2Vge9ZIdPPV8rSmka46bhbdgoVxJLRVLIeLnR36qJxSLWogHxCpPAAQbmNPRoe83WmNN
 9dAHv8uPylvDMKmXkWpXfc8t4pPlsaLZcnzW2HTarb1r7Ug0ABIy5zLRFH/8zkySi8XL
 czTWRQbXRcR4RtxHFWLLJ2/udSiej+zbL0BM2sgvpioQFiRDUGDZWlgCEUtA/Eyw7/YT Bw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ramke1rtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 07:34:07 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35K7Y4F5025835
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 07:34:06 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 20 Jun 2023 00:34:01 -0700
From:   Tao Zhang <quic_taozha@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Tao Zhang <quic_taozha@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
Subject: [PATCH v6 12/13] dt-bindings: arm: Add support for DSB MSR register
Date:   Tue, 20 Jun 2023 15:32:40 +0800
Message-ID: <1687246361-23607-13-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1687246361-23607-1-git-send-email-quic_taozha@quicinc.com>
References: <1687246361-23607-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KK3Se1jYlbb6UJmLmPRoOMXmEzBCSwQz
X-Proofpoint-GUID: KK3Se1jYlbb6UJmLmPRoOMXmEzBCSwQz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_04,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=869 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200067
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add property "qcom,dsb-msrs-num" to support DSB(Discrete Single
Bit) MSR(mux select register) for TPDM. It specifies the number
of MSR registers supported by the DSB TDPM.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
index 931ee8f..d1d66bc 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
@@ -52,6 +52,15 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint8
     enum: [32, 64]
 
+  qcom,dsb-msrs-num:
+    description:
+      Specifies the number of DSB(Discrete Single Bit) MSR(mux select register)
+      registers supported by the monitor. If this property is not configured
+      or set to 0, it means this DSB TPDM doesn't support MSR.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 32
+
   clocks:
     maxItems: 1
 
@@ -86,6 +95,7 @@ examples:
       reg = <0x0684c000 0x1000>;
 
       qcom,dsb-element-size = /bits/ 8 <32>;
+      qcom,dsb-msrs-num = <16>;
 
       clocks = <&aoss_qmp>;
       clock-names = "apb_pclk";
-- 
2.7.4

