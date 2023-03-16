Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0D56BC49F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCPDY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjCPDX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:23:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D523DAB89F;
        Wed, 15 Mar 2023 20:21:45 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32G23Xqe001850;
        Thu, 16 Mar 2023 03:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=PMqBL/9V7s0s4opFEsX8c/I+d9bptzT5bGjCmlDP49Y=;
 b=ZcO1IRaOiF28Avqlwr9qKwZE17q7hQXTp7NzCj6yKeWDxyfWIuJiBT6Ja0Wb9I82Ypvw
 22zJczWYZ1xmyG4VX4pyhuYHDBBjrWwtNYX5Gu5kWmxzpsoUmgVxOzyHhjpL8dHeEj2u
 xsluKu/51RZkPN9sp5TMrrf8WxeSqGRMydIaEOlh/ocVwz4Trbjbx3zw8dMqOJ8EmMuY
 0tqAleTA4SmNkqw3+Fuja8yBp2bWZdF+JjzEEDTCgA2Hd3GcxDX9d2WPgP3Fcu1uzOIF
 YUvgDPtBZ6EAaEooMTTyoBRWyuEYQorOdJzf5/UppOyEs9xV+wVc2aDny86l1Le9iR9T dg== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbpxsghj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 03:20:21 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32G3KJki006443;
        Thu, 16 Mar 2023 03:20:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3p8jqmenms-1;
        Thu, 16 Mar 2023 03:20:19 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32G3KJ6C006437;
        Thu, 16 Mar 2023 03:20:19 GMT
Received: from hazha-gv.ap.qualcomm.com (hazha-gv.qualcomm.com [10.239.105.144])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 32G3KJQP006433;
        Thu, 16 Mar 2023 03:20:19 +0000
Received: by hazha-gv.ap.qualcomm.com (Postfix, from userid 4083943)
        id 3D606120007F; Thu, 16 Mar 2023 11:20:18 +0800 (CST)
From:   Hao Zhang <quic_hazha@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Hao Zhang <quic_hazha@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-doc@vger.kernel.org
Subject: [PATCH v1 2/3] dt-bindings: arm: Add Coresight Dummy Trace YAML schema
Date:   Thu, 16 Mar 2023 11:20:04 +0800
Message-Id: <20230316032005.6509-3-quic_hazha@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230316032005.6509-1-quic_hazha@quicinc.com>
References: <20230316032005.6509-1-quic_hazha@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7Qg1bPsFcW6Si0dAzbjBLksHC2XCD_Dd
X-Proofpoint-ORIG-GUID: 7Qg1bPsFcW6Si0dAzbjBLksHC2XCD_Dd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_02,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303160028
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new coresight-dummy.yaml file describing the bindings required
to define coresight dummy trace in the device trees.

Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
---
 .../bindings/arm/qcom,coresight-dummy.yaml    | 129 ++++++++++++++++++
 1 file changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
new file mode 100644
index 000000000000..3a7f98df2ee9
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
@@ -0,0 +1,129 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/qcom,coresight-dummy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QCOM Coresight Dummy component
+
+description: |
+  The Coresight Dummy component is for the specific devices that HLOS don't have
+  permission to access or configure. Such as Coresight sink EUD, some TPDMs etc.
+  So there need driver to register dummy devices as Coresight devices. Provide
+  Coresight API for dummy device operations, such as enabling and disabling
+  dummy devices. Build the Coresight path for dummy sink or dummy source for
+  debugging.
+
+  The primary use case of the coresight dummy is to build path for dummy sink or
+  dummy source.
+
+maintainers:
+  - Mao Jinlong <quic_jinlmao@quicinc.com>
+  - Tao Zhang <quic_taozha@quicinc.com>
+  - Hao Zhang <quic_hazha@quicinc.com>
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - qcom,coresight-dummy
+  required:
+    - compatible
+
+properties:
+  $nodename:
+    pattern: "^dummy(@[0-9a-f]+)$"
+  compatible:
+    items:
+      - const: qcom,coresight-dummy
+
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: apb_pclk
+
+  qcom,dummy-sink:
+    type: boolean
+    description:
+      Indicates that the type of this coresight node is dummy sink.
+
+  qcom,dummy-source:
+    type: boolean
+    description:
+      Indicates that the type of this coresight node is dummy source.
+
+  out-ports:
+    description: |
+      Output connections from the dummy source to Coresight Trace bus.
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port:
+        description: Output connection from the dummy source to Coresight
+            Trace bus.
+        $ref: /schemas/graph.yaml#/properties/port
+
+  in-puts:
+    description: |
+      Input connections from the CoreSight Trace bus to dummy sink.
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port:
+        description: Input connection from the Coresight Trace bus to
+            dummy sink.
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - oneOf:
+    - qcom,dummy-sink
+    - qcom,dummy-source
+
+additionalProperties: false
+
+examples:
+  # minimum dummy sink definition. dummy sink connect to coresight replicator.
+  - |
+    dummy_eud: dummy_sink {
+      compatible = "qcom,dummy";
+      qcom,dummy-sink;
+
+      in-ports {
+        port {
+          eud_in_replicator_swao: endpoint {
+            remote-endpoint =
+              <&replicator_swao_out_eud>;
+          };
+        };
+      };
+    };
+
+  # minimum dummy source definition. dummy source connect to coresight funnel.
+  - |
+    dummy_riscv: dummy_source {
+      compatible = "qcom,dummy";
+      qcom,dummy-source;
+
+      out-ports {
+        port {
+          dummy_riscv_out_funnel_swao: endpoint {
+            remote-endpoint =
+              <&funnel_swao_in_dummy_riscv>;
+          };
+        };
+      };
+    };
+
+...
-- 
2.17.1

