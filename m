Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCA4716DA2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjE3TfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjE3Teu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:34:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B0710B;
        Tue, 30 May 2023 12:34:48 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UJPpLO018287;
        Tue, 30 May 2023 19:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=QS76EgvJjXKKaWmp7a7ub1P//dtgRXQ0pPsURfP1vFc=;
 b=HqGbWtkpcvwozky5HT7CXh09o2V8erkiNGzRcGzaiA2yZe2ie1gvBUBX3iiTlk/V+7sd
 wrPdLikNbePEl1+Pa4/atSV4Fm1FTFaHgiCKxn6blq7kidmOWsBYS5gqzFpCRNWKnGkq
 kjO22D3ZIqFI3RBxXQXpdWyP9ZUo7TGy33NjHFF5CVspRBXNbD4nQAX2O/GeRh/0FRsK
 XZsEdF1yFhHYGbuQuR1N8yHG8R3LaGrXYIjL7d1XH+uGF0gdVYQmTSEgrOuqqZSyg9mk
 Q3O+roI7vv7p69t+9Wq9TkWcLPfpgN/7H0vryKD1sEdYjw91heSMvNAtrMagGwbODxVo yg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qw7rtt23t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 19:34:43 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34UJYgxe014215
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 19:34:42 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 30 May 2023 12:34:42 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: reserved-memory: rmtfs: Allow dynamic allocation
Date:   Tue, 30 May 2023 12:34:35 -0700
Message-ID: <20230530193436.3833889-2-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230530193436.3833889-1-quic_bjorande@quicinc.com>
References: <20230530193436.3833889-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kKuk1V_8slN4zQbiiBOigzMzPI2ngOdK
X-Proofpoint-ORIG-GUID: kKuk1V_8slN4zQbiiBOigzMzPI2ngOdK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_14,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300157
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow instances of the qcom,rmtfs-mem either be defined as a
reserved-memory regoin, or just standalone given just a size.

This relieve the DeviceTree source author the need to come up with a
static memory region for the region.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 .../reserved-memory/qcom,rmtfs-mem.yaml       | 23 ++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
index bab982f00485..8b5de033f9ac 100644
--- a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
@@ -14,13 +14,16 @@ description: |
 maintainers:
   - Bjorn Andersson <bjorn.andersson@linaro.org>
 
-allOf:
-  - $ref: reserved-memory.yaml
-
 properties:
   compatible:
     const: qcom,rmtfs-mem
 
+  qcom,alloc-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Requested size of the rmtfs memory allocation, when not defined as a
+      reserved-memory region.
+
   qcom,client-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: >
@@ -36,6 +39,11 @@ properties:
 required:
   - qcom,client-id
 
+oneOf:
+  - $ref: reserved-memory.yaml
+  - required:
+      - qcom,alloc-size
+
 unevaluatedProperties: false
 
 examples:
@@ -53,3 +61,12 @@ examples:
             qcom,client-id = <1>;
         };
     };
+  - |
+    rmtfs {
+        compatible = "qcom,rmtfs-mem";
+
+        qcom,alloc-size = <(2*1024*1024)>;
+        qcom,client-id = <1>;
+        qcom,vmid = <15>;
+    };
+...
-- 
2.25.1

