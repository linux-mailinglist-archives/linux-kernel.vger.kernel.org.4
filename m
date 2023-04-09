Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7AC6DC0F9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 20:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjDISUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 14:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjDISUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 14:20:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379962D6B;
        Sun,  9 Apr 2023 11:20:00 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 339IJkPL023087;
        Sun, 9 Apr 2023 18:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=tCLFfzbS4CdkXJ/5Rv9z076f2AbyuOOgsJ3/fzWAFiI=;
 b=Xkd7iPspI3bXVVWhlWGZyghPYNfjjYNqTsE8TlGrN3U6TQT+Gy6gziBEI9HuUyO9V/9Z
 9WCNJKdgbNybqiC3AclXM+yfmDQpEuK6MbAPTIvDKl58YZxzrgMhZN9gh1BZMj3YOw3P
 4SvKacfVsnZd9g52VPMyuzI/XH1fv1l2IZ1mc3xGulj7+EaZAydtbaRYXG4ZW3AFoXXU
 I4a/GBdY9pZDAT4ATefmWNsNiw7DaxDytNjsTSRjNrW4/IsafmELIvYagpBJkIjPGV0R
 3jdvKzo7li4Z3aobwC7k68sEXo8jQHaQViG0Txy3HCOB4pcrqj5Fx8JOm2GaLlG9lXbb Eg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pty82spmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Apr 2023 18:19:45 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 339IJjAA014279
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 9 Apr 2023 18:19:45 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 9 Apr 2023 11:19:44 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: firmware: arm,scmi: support parameter passing in smc/hvc
Date:   Sun, 9 Apr 2023 11:19:17 -0700
Message-ID: <20230409181918.29270-2-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230409181918.29270-1-quic_nkela@quicinc.com>
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: G79in4T4NDaTcPXFQ9JWV-HSBSD8Z7-Q
X-Proofpoint-GUID: G79in4T4NDaTcPXFQ9JWV-HSBSD8Z7-Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-09_14,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304090167
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
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
 .../devicetree/bindings/firmware/arm,scmi.yaml   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 5824c43e9893..08c331a79b80 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -115,6 +115,22 @@ properties:
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
+      An optional parameter list passed in smc64 or hvc64 calls
+    default: 0
+    minItems: 1
+    maxItems: 6
+
   linaro,optee-channel-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-- 
2.17.1

