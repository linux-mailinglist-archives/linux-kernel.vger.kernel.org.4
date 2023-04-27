Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA06C6F02E6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243213AbjD0JBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242688AbjD0JBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:01:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34E04C39;
        Thu, 27 Apr 2023 02:01:17 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33R8CcMC029625;
        Thu, 27 Apr 2023 09:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Mbw4ujXJQVn/g1wJaXelxiBAs0h9aRc7qJmeAd1QW00=;
 b=oVPIsfInVub8qnxdyV6TzlqwyDLGT1fJnpjds3bzvQ+gclxb5Fyp86XIhJckBwpF88E3
 bTkGqx0QNZnPNf1FB0pL4nZPfjIRSrsclKvoom/VDa7laNKunYR7UE264N9MCh4TomyD
 GgF0XG6uoyPUd9Umn0y4T8OKLkwpb1kuGAKaeYZ31PFy0meB9QVeQp7I9aZDf1l56341
 5pG2j7rPD7d4ciRCVKn78B3CsVw0DftCL5rfYCAGSfGSG1wMsXxJZHnn3ONa3EvEZwYN
 URqkhbFkppx46KAtoXFagzxteCoQ3TBtHGyxWeAq8kFl8Psp5QUJ/y4bgLk0rlFxnSne yA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q7hdjgm55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 09:01:01 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33R910Ix004768
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 09:01:00 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 27 Apr 2023 02:00:55 -0700
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
Subject: [PATCH v4 01/11] dt-bindings: arm: Add support for DSB element size
Date:   Thu, 27 Apr 2023 17:00:27 +0800
Message-ID: <1682586037-25973-2-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1682586037-25973-1-git-send-email-quic_taozha@quicinc.com>
References: <1682586037-25973-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: K9QDk3JpyHzwZi0D18lJJT8RvekEtoHl
X-Proofpoint-GUID: K9QDk3JpyHzwZi0D18lJJT8RvekEtoHl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_06,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 lowpriorityscore=0 mlxlogscore=847 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304270078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add property "qcom,dsb-elem-size" to support DSB(Discrete Single
Bit) element for TPDM. The associated aggregator will read this
size before it is enabled. DSB element size currently only
supports 32-bit and 64-bit.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
index 5c08342..932c55b 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
@@ -44,6 +44,14 @@ properties:
     minItems: 1
     maxItems: 2
 
+  qcom,dsb-element-size:
+    description:
+      Specifies the DSB(Discrete Single Bit) element size supported by
+      the monitor. The associated aggregator will read this size before it
+      is enabled. DSB element size currently only supports 32-bit and 64-bit.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [32, 64]
+
   clocks:
     maxItems: 1
 
@@ -77,6 +85,8 @@ examples:
       compatible = "qcom,coresight-tpdm", "arm,primecell";
       reg = <0x0684c000 0x1000>;
 
+      qcom,dsb-element-size = /bits/ 8 <32>;
+
       clocks = <&aoss_qmp>;
       clock-names = "apb_pclk";
 
-- 
2.7.4

