Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3F86EB7D5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 09:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjDVHiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 03:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVHiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 03:38:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1931BD4;
        Sat, 22 Apr 2023 00:38:07 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33M7a2hp005462;
        Sat, 22 Apr 2023 07:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=SvleGGkVmvA21/UbjS6Lgcgdr8SdW8ozYHLKe1Ta1Ls=;
 b=hvIBV/Ykv6e9pQSZAOs/HtLRyShwKnMN+6AaYRzCiXkVYYe35VBlC4ONoL8tNyAEIl3C
 VY0/T5WdcBZ9OjBNWD1xzvx2PfEqbNj9g7rE6gKiS4h/YVimXyH6GTYvEVxyIRNExNQ4
 kOEi0zGEGSnx0zZaWeHBFdaBG1nTIKJ+F5I/JGM9MR5ztvSelTKB66RRYSSBLb3ALmfI
 +r7UfYjlu3DgsqDk3HtaGkamJpDg+g7X8X6QnFl2oQ4OPwh+lskUX8zF75Yuh6bR9t0S
 3iBd0fjkIYDxHT2u4crzNOxsdVWudzIvl5AfS+KJK5HRJ9Csz/nY3UscDv6BbdJs4rRp QA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q48e1r5mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Apr 2023 07:37:53 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33M7bq5Z003864
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Apr 2023 07:37:52 GMT
Received: from hazha-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sat, 22 Apr 2023 00:37:46 -0700
From:   Hao Zhang <quic_hazha@quicinc.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
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
Subject: [PATCH v3 2/3] dt-bindings: arm: Add Coresight Dummy Trace
Date:   Sat, 22 Apr 2023 15:37:13 +0800
Message-ID: <20230422073714.38844-3-quic_hazha@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230422073714.38844-1-quic_hazha@quicinc.com>
References: <20230422073714.38844-1-quic_hazha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JnabgeTynP75g-Kpp9ZRPX63LJhsIZDk
X-Proofpoint-ORIG-GUID: JnabgeTynP75g-Kpp9ZRPX63LJhsIZDk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_08,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0
 mlxlogscore=912 priorityscore=1501 mlxscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304220064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new coresight-dummy.yaml file describing the bindings required
to define coresight dummy trace in the device trees.

Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
---
 .../bindings/arm/arm,coresight-dummy.yaml     | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml

diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml
new file mode 100644
index 000000000000..48d864aefaaa
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/arm,coresight-dummy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Coresight Dummy component
+
+description: |
+  Coresight Dummy Trace Module is for the specific devices that kernel
+  don't have permission to access or configure, e.g., CoreSight TPDMs
+  on Qualcomm platforms. So there need driver to register dummy devices
+  as Coresight devices. It may also be used to define components that
+  may not have any programming interfaces (e.g, static links), so that
+  paths can be established in the driver. Provide Coresight API for
+  dummy device operations, such as enabling and disabling dummy devices.
+  Build the Coresight path for dummy sink or dummy source for debugging.
+
+  The primary use case of the coresight dummy is to build path in kernel
+  side for dummy sink and dummy source.
+
+maintainers:
+  - Mao Jinlong <quic_jinlmao@quicinc.com>
+  - Tao Zhang <quic_taozha@quicinc.com>
+  - Hao Zhang <quic_hazha@quicinc.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - arm,coresight-dummy-sink
+          - arm,coresight-dummy-source
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
+  in-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port:
+        description: Input connection from the Coresight Trace bus to
+          dummy sink, such as Embedded USB debugger(EUD).
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+
+if:
+  # If the compatible contains the below value
+  properties:
+    compatible:
+      contains:
+        const: arm,coresight-dummy-sink
+
+then:
+  required:
+    - in-ports
+
+else:
+  required:
+    - out-ports
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

