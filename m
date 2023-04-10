Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2DF6DCAA2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjDJSVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjDJSVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:21:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799E51FED;
        Mon, 10 Apr 2023 11:21:40 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AGRcqJ030951;
        Mon, 10 Apr 2023 18:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=JSpEpYA4kOiSI571keV7JwSrxOWjSXDVljItBH9YooM=;
 b=YEdP3J3l/tud5nLpq9C4wPf6hAxoocrEQPk32PXiC1sC+Ox0Gxl5f/+OQaZP1YR5J876
 0mdH0HjybdqxVeuq6knCTbhfzcf2XAWKX/MJroiHb1UQ29J9oA9a9INnAokq5qc9eJqz
 xzIiXnVJvu7VeauOCQWOeEjU91pdMvvxdybwv7G8JTn1+iZV+qsgDjpvtVvbq5bBwQlV
 0BqFtCQ+/6pMH79B/6Fi1fQARAjyyZRLgoAXl4DKqROvI+s8h2m53eBtNygdJ9aVFTwK
 zpZiUHoG1ycUS+S4Tr8LR7FPq73vS22nU5cCZe9yelcaDYjJybxUIQTBLrkc/0St4EpJ lw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pvnjerbrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 18:21:24 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33AILNj8021022
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 18:21:23 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 10 Apr 2023 11:21:22 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lkp@intel.com>, Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: support parameter passing in smc/hvc
Date:   Mon, 10 Apr 2023 11:20:57 -0700
Message-ID: <20230410182058.8949-2-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230410182058.8949-1-quic_nkela@quicinc.com>
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
 <20230410182058.8949-1-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VfJ-4yjuVbfbvqKxgTwfEkLfNllHpCmB
X-Proofpoint-GUID: VfJ-4yjuVbfbvqKxgTwfEkLfNllHpCmB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_13,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100158
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, smc/hvc calls are made with smc-id only. The parameters are
all set to zeros. This patch defines two optional device tree bindings,
that can be used to pass parameters in smc/hvc calls.

This is useful when multiple scmi instances are used with common smc-id.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
---
 .../devicetree/bindings/firmware/arm,scmi.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 5824c43e9893..ecf76b763c8c 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -115,6 +115,23 @@ properties:
     description:
       SMC id required when using smc or hvc transports
 
+  arm,smc32-params:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      An optional parameter list passed in smc32 or hvc32 calls
+    default: 0
+    minItems: 1
+    maxItems: 6
+
+  arm,smc64-params:
+    $ref: /schemas/types.yaml#/definitions/uint64-array
+    description:
+      An optional parameter list passed in smc64 or hvc64 calls.
+      This is valid only on ARM64 machines.
+    default: 0
+    minItems: 1
+    maxItems: 6
+
   linaro,optee-channel-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
@@ -427,6 +444,7 @@ examples:
             compatible = "arm,scmi-smc";
             shmem = <&cpu_scp_lpri0>, <&cpu_scp_lpri1>;
             arm,smc-id = <0xc3000001>;
+            arm,smc64-params = <0xcd974d6c 0x5ed97289>;
 
             #address-cells = <1>;
             #size-cells = <0>;
-- 
2.17.1

