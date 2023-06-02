Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09B571FC52
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbjFBInK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbjFBInC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:43:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3950D1A2;
        Fri,  2 Jun 2023 01:43:00 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3527sXMi020700;
        Fri, 2 Jun 2023 08:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=8XDHI+wnWwGsmaDmsUi7ySkNC21K9g7xIiJvQeasY4k=;
 b=ZjhUUCtjk2lI0qAyK5S+1Tox5nLRf4hhifUk5Y5pC5UmKJyOVRprxF7PN9cvwnbdZvG0
 +0jGXAObbKrxWDszU2l71iAQGCuTC6n+CuZh7gFUQ5Mk3gWSSPSZtcQbpozWpnyoDXtL
 eFfHBbE3YuMHu0yJB+AiTPeGB2yn5Dq6e6FYKMaErSrOhv/9AEqcpcbnkP4uAwPrst6l
 50McSdlP3QdlyOYD/DeyxbyQm/dXaKqYFsfUI4Mx8+QpOsSnqVVk+CHoAzdnmKe1GUGK
 TDy8wInT30Inu+Qc5Gx4WZTgKikRoh3hditk3ga0YtiSGsR4qt0l6z6iGjYAR2Kq45aw Gw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qyb5f87sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 08:42:41 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3528geMi010248
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 08:42:40 GMT
Received: from hazha-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 2 Jun 2023 01:42:34 -0700
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
Subject: [PATCH v6 2/3] dt-bindings: arm: Add support for Coresight dummy trace
Date:   Fri, 2 Jun 2023 16:41:48 +0800
Message-ID: <20230602084149.40031-3-quic_hazha@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230602084149.40031-1-quic_hazha@quicinc.com>
References: <20230602084149.40031-1-quic_hazha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BgRwSOceyO7NAAhFEVPYbRCrl0_0GwS0
X-Proofpoint-GUID: BgRwSOceyO7NAAhFEVPYbRCrl0_0GwS0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_05,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 suspectscore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=948 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020064
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

