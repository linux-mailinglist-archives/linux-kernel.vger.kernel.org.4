Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA3E6E6C76
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjDRS5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjDRS5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:57:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF50318E;
        Tue, 18 Apr 2023 11:57:32 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I6rt33003793;
        Tue, 18 Apr 2023 18:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=tDG6E9f8cBUS0AgfMe8wEE59vV+JqBijFjadDrGU6/0=;
 b=IQWaGSG9NhhWpnbmGl4G/CtiVpLDpCAsUfr6jPKmURuFjsce07UOfUIem1ntUhgHNL2Q
 wmXNefpLjsfAyOxz3MnoFG7GOZTmwwb/4/ib9uVkw602cAKTJy8T4XYQxuqKbW/tlIMF
 4IO/Tk2du+ly3852QHp4p5IPe8m0KPbaDWR2WsBCqd94nZnbLXFhxZfWsAi7GLl/sSX5
 U9vBx3gRM7FunnuOv673fPmBrp/HOxJIbEI90n/KNjUwCvgxa8++vvDfx/BdROWDeDeR
 E9F+0DH8w1o+Jmr9fj6tmwgUAfRvnC/GPBja062yWXVf8oZQIkSnXIV893JGrL4uKUZ7 EQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q1nf8hy6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 18:57:23 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33IIvNon021503
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 18:57:23 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 18 Apr 2023 11:57:22 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v4 1/2] dt-bindings: firmware: arm,scmi: support for parameter in smc/hvc call
Date:   Tue, 18 Apr 2023 11:56:58 -0700
Message-ID: <20230418185659.29745-2-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230418185659.29745-1-quic_nkela@quicinc.com>
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
 <20230418185659.29745-1-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UuPgZpqM38Yp7nPHdPfcKoMUX-62DHdt
X-Proofpoint-ORIG-GUID: UuPgZpqM38Yp7nPHdPfcKoMUX-62DHdt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_13,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180155
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, smc/hvc calls are made with smc-id only. The parameters are
all set to zeros. This patch defines a new compatible string that can
be used to pass shmem address(4KB-page, offset) as two parameters in
SMC/HVC doorbell.

This is useful when multiple scmi instances are used with common smc-id.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
---
 Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 5824c43e9893..ad776911f990 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -34,6 +34,10 @@ properties:
       - description: SCMI compliant firmware with ARM SMC/HVC transport
         items:
           - const: arm,scmi-smc
+      - description: SCMI compliant firmware with ARM SMC/HVC transport
+                     with shmem address(4KB-page, offset) as parameters
+        items:
+          - const: arm,scmi-smc-param
       - description: SCMI compliant firmware with SCMI Virtio transport.
                      The virtio transport only supports a single device.
         items:
@@ -299,7 +303,9 @@ else:
     properties:
       compatible:
         contains:
-          const: arm,scmi-smc
+          enum:
+            - arm,scmi-smc
+            - arm,scmi-smc-param
   then:
     required:
       - arm,smc-id
-- 
2.17.1

