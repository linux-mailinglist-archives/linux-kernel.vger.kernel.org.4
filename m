Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4936E71243E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 12:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243168AbjEZKJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 06:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjEZKJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 06:09:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A828EA9;
        Fri, 26 May 2023 03:09:31 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q8IE21008681;
        Fri, 26 May 2023 10:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=8XDHI+wnWwGsmaDmsUi7ySkNC21K9g7xIiJvQeasY4k=;
 b=pG21CVKgIFqpfc/rrJnx0xJKjkrgm0R61Dr4t0NJ3XG7J93M9mF1YjeOfKPLMHqTsJ5v
 NTfSHzM2ej029Hifs9nFNjhzqPKAp6TadB8H54kJ4ChY5kMkKUpAk3lw5fTJcaWe5DQi
 CiBLjibQte+jaFJdiUmd4fU7eHvT9UfixUWXjNmCwAwdanc+/i2gPiiz6rNiCFuuj4NU
 OHS22HGkq6rVN4xNPHhCRnjo5eqzy+LzCIQoucdK66/Qaev1sF4mhRzG1v1U7aiL6lVh
 u12Y86sfL8zTIYhIJul+qFgIIJ3QsgaLnKdueKPZvRHk4GQe0O0jgc/5QGYoEmTA5tzQ 1w== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qt02abdj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 10:09:08 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34QA97BB001077
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 10:09:07 GMT
Received: from hazha-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 26 May 2023 03:09:02 -0700
From:   Hao Zhang <quic_hazha@quicinc.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Hao Zhang <quic_hazha@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: [PATCH v5 2/3] dt-bindings: arm: Add support for Coresight dummy trace
Date:   Fri, 26 May 2023 18:07:52 +0800
Message-ID: <20230526100753.34581-3-quic_hazha@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230526100753.34581-1-quic_hazha@quicinc.com>
References: <20230526100753.34581-1-quic_hazha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4PxCql2MkgMFEQqSS8aj7VEpGSoPaj6s
X-Proofpoint-ORIG-GUID: 4PxCql2MkgMFEQqSS8aj7VEpGSoPaj6s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1011
 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0 mlxlogscore=950
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for Coresight dummy source and dummy sink trace.

Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
---
 .../arm/arm,coresight-dummy-sink.yaml         | 73 +++++++++++++++++++
 .../arm/arm,coresight-dummy-source.yaml       | 71 ++++++++++++++++++
 2 files changed, 144 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml

diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml
new file mode 100644
index 000000000000..cb78cfa56702
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/arm,coresight-dummy-sink.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Coresight Dummy sink component
+
+description: |
+  CoreSight components are compliant with the ARM CoreSight architecture
+  specification and can be connected in various topologies to suit a particular
+  SoCs tracing needs. These trace components can generally be classified as
+  sinks, links and sources. Trace data produced by one or more sources flows
+  through the intermediate links connecting the source to the currently selected
+  sink.
+
+  The Coresight dummy sink component is for the specific coresight sink devices
+  kernel don't have permission to access or configure, e.g., CoreSight EUD on
+  Qualcomm platforms. It is a mini-USB hub implemented to support the USB-based
+  debug and trace capabilities. For this device, a dummy driver is needed to
+  register it as Coresight sink device in kernel side, so that path can be
+  created in the driver. Then the trace flow would be transferred to EUD via
+  coresight link of AP processor. It provides Coresight API for operations on
+  dummy source devices, such as enabling and disabling them. It also provides
+  the Coresight dummy source paths for debugging.
+
+  The primary use case of the coresight dummy sink is to build path in kernel
+  side for dummy sink component.
+
+maintainers:
+  - Mike Leach <mike.leach@linaro.org>
+  - Suzuki K Poulose <suzuki.poulose@arm.com>
+  - James Clark <james.clark@arm.com>
+  - Mao Jinlong <quic_jinlmao@quicinc.com>
+  - Hao Zhang <quic_hazha@quicinc.com>
+
+properties:
+  compatible:
+    enum:
+      - arm,coresight-dummy-sink
+
+  in-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port:
+        description: Input connection from the Coresight Trace bus to
+          dummy sink, such as Embedded USB debugger(EUD).
+
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - in-ports
+
+additionalProperties: false
+
+examples:
+  # Minimum dummy sink definition. Dummy sink connect to coresight replicator.
+  - |
+    sink {
+      compatible = "arm,coresight-dummy-sink";
+
+      in-ports {
+        port {
+          eud_in_replicator_swao: endpoint {
+            remote-endpoint = <&replicator_swao_out_eud>;
+          };
+        };
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
new file mode 100644
index 000000000000..5fedaed49a1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/arm,coresight-dummy-source.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Coresight Dummy source component
+
+description: |
+  CoreSight components are compliant with the ARM CoreSight architecture
+  specification and can be connected in various topologies to suit a particular
+  SoCs tracing needs. These trace components can generally be classified as
+  sinks, links and sources. Trace data produced by one or more sources flows
+  through the intermediate links connecting the source to the currently selected
+  sink.
+
+  The Coresight dummy source component is for the specific coresight source
+  devices kernel don't have permission to access or configure. For some SOCs,
+  there would be Coresight source trace components on sub-processor which
+  are conneted to AP processor via debug bus. For these devices, a dummy driver
+  is needed to register them as Coresight source devices, so that paths can be
+  created in the driver. It provides Coresight API for operations on dummy
+  source devices, such as enabling and disabling them. It also provides the
+  Coresight dummy source paths for debugging.
+
+  The primary use case of the coresight dummy source is to build path in kernel
+  side for dummy source component.
+
+maintainers:
+  - Mike Leach <mike.leach@linaro.org>
+  - Suzuki K Poulose <suzuki.poulose@arm.com>
+  - James Clark <james.clark@arm.com>
+  - Mao Jinlong <quic_jinlmao@quicinc.com>
+  - Hao Zhang <quic_hazha@quicinc.com>
+
+properties:
+  compatible:
+    enum:
+      - arm,coresight-dummy-source
+
+  out-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port:
+        description: Output connection from the source to Coresight
+          Trace bus.
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - out-ports
+
+additionalProperties: false
+
+examples:
+  # Minimum dummy source definition. Dummy source connect to coresight funnel.
+  - |
+    source {
+      compatible = "arm,coresight-dummy-source";
+
+      out-ports {
+        port {
+          dummy_riscv_out_funnel_swao: endpoint {
+            remote-endpoint = <&funnel_swao_in_dummy_riscv>;
+          };
+        };
+      };
+    };
+
+...
-- 
2.17.1

