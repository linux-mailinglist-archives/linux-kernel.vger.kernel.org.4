Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58686732BF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjASHnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjASHmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:42:47 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7881762D3C;
        Wed, 18 Jan 2023 23:42:34 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J5umJh017565;
        Thu, 19 Jan 2023 07:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=+ile8KrnCqycQDSvZSIwrvg2RXj1x3vU89K9f6ueCe4=;
 b=V5Et1LAMmQx/qjK7sPXzymFggvusBXFsXJnzkVrf0Pu2XOVwIZXP5Vco9qHcA2gMHSfI
 lhnnZ201R/u6qEIPA8N4QVJTwvhaTC4iQHqCmDQLK7kPuAOT6C4zoibPfto3gBG+IgCn
 wzrDvlWGQHTpSynBYLtrRBcPUvO/uy2+VbNZbC3AzU3mTABL32x7pmRYnF1Up61nNcJR
 h7K+P28dEhhJZz+EfNZYz7AMt2AI149ac9h+kygCP/s8fdFlANAFjZ0RTflBppgh5nxA
 wCa6CpQQ75sdYfJ0A8DrtntiXbvpsUtzjz4TM9j4756y/czXO8aVK1HrpHqnbfeCKvVm Ng== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6yksgcj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 07:42:16 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30J7gFZi025257
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 07:42:15 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 18 Jan 2023 23:42:10 -0800
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
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>,
        Tao Zhang <taozha@qti.qualcomm.com>
Subject: [PATCH v2 1/9] dt-bindings: arm: Add support for DSB element
Date:   Thu, 19 Jan 2023 15:41:37 +0800
Message-ID: <1674114105-16651-2-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1674114105-16651-1-git-send-email-quic_taozha@quicinc.com>
References: <1674114105-16651-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OvgUlOvRsaHqZ2w84ckYxUUB3CuSOl0f
X-Proofpoint-ORIG-GUID: OvgUlOvRsaHqZ2w84ckYxUUB3CuSOl0f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxlogscore=911 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190062
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add property "qcom,dsb-elem-size" to support DSB(Discrete Single
Bit) element for TPDA. Specifies the DSB element size supported
by each monitor connected to the aggregator on each port. Should
be specified in pairs (port, dsb element size).

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Tao Zhang <taozha@qti.qualcomm.com>
---
 .../bindings/arm/qcom,coresight-tpda.yaml          | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
index 2ec9b5b..298db7f 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
@@ -58,6 +58,26 @@ properties:
     minItems: 1
     maxItems: 2
 
+  qcom,dsb-element-size:
+    description: |
+      Specifies the DSB(Discrete Single Bit) element size supported by
+      each monitor connected to the aggregator on each port. Should be
+      specified in pairs <port, dsb element size>.
+
+      Note: The maximum value of the port number depends on how many
+      input ports the current TPDA has. DSB element size currently only
+      supports 32-bit and 64-bit.
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      items:
+        - description: |
+            "port" indicates TPDA input port number
+          minimum: 0
+        - description: |
+            "dsb element size" indicates dsb element size
+          minimum: 0
+          maximum: 64
+
   clocks:
     maxItems: 1
 
@@ -100,6 +120,8 @@ examples:
        compatible = "qcom,coresight-tpda", "arm,primecell";
        reg = <0x6004000 0x1000>;
 
+       qcom,dsb-element-size = <0 32>;
+
        clocks = <&aoss_qmp>;
        clock-names = "apb_pclk";
 
-- 
2.7.4

