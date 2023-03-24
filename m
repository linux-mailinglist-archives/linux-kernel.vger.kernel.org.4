Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E05D6C77C8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjCXGRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjCXGRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:17:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E0628D13;
        Thu, 23 Mar 2023 23:17:15 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32O67WBc007905;
        Fri, 24 Mar 2023 06:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=8C7m0DbmmsxTJEi0AOtc7YtdKD+by2Z8hHftvMur6WQ=;
 b=Iw+PlfozyhJAxIieloK9XhlxD98TU5UgUX426oKHZXztri8CEQlG7Sap4soK4vzv85CK
 l+PzUg7CAlb45YUxXPKcXqzmui9yaHHCUWh/mC4ex6vrsTBjCVTdT7SCvV4xtMeNTNAO
 OgS//hVHvyUhbfTPneiesskRsX1f320sBu5LXwrlKLNuJkfFzFtSgiU0YPDkK/6f6KdB
 9vDiF8nJZ/BGCCJOaVgDenlDu4Zm5xFfUXXe4kw7x6+eKX21L/BznIBoHiwpm2dtnOeS
 d43/RRVEq5WAtQivZL4MA2MkDZFk8Ic7MBcj9pZ/fZ7oQHUabhWirYfSF9OmPGkfRaqD rA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pgxr88xgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 06:16:44 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32O6Ghd8014332
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 06:16:43 GMT
Received: from hazha-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 23 Mar 2023 23:16:37 -0700
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
CC:     Hao Zhang <quic_hazha@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: arm: Add Coresight Dummy Trace YAML schema
Date:   Fri, 24 Mar 2023 14:16:07 +0800
Message-ID: <20230324061608.33609-3-quic_hazha@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230324061608.33609-1-quic_hazha@quicinc.com>
References: <20230324061608.33609-1-quic_hazha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZGqvjWdMDlUYIH5wn6TjMe-O5zpRAiM2
X-Proofpoint-GUID: ZGqvjWdMDlUYIH5wn6TjMe-O5zpRAiM2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_02,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303240049
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new coresight-dummy.yaml file describing the bindings required
to define coresight dummy trace in the device trees.

Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
---
 .../bindings/arm/qcom,coresight-dummy.yaml    | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
new file mode 100644
index 000000000000..7b719b084d72
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
@@ -0,0 +1,118 @@
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
+    pattern: "^dummy_.*(sink|source)_[0-9]+.*$"
+  compatible:
+    items:
+      - const: qcom,coresight-dummy
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
+  in-ports:
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
+
+additionalProperties: false
+
+oneOf:
+  - required:
+      - qcom,dummy-sink
+  - required:
+      - qcom,dummy-source
+
+examples:
+  # minimum dummy sink definition. dummy sink connect to coresight replicator.
+  - |
+    dummy_sink_1 {
+      compatible = "qcom,coresight-dummy";
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
+    dummy_source_1 {
+      compatible = "qcom,coresight-dummy";
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

