Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67891668A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 05:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbjAMEM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 23:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjAMELl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 23:11:41 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C68F6534C;
        Thu, 12 Jan 2023 20:11:26 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30D3LieJ012588;
        Fri, 13 Jan 2023 04:11:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=skrZtyW7NuL4lgx1XrK+XW2ygr1LktK1dYdsKpmSYZI=;
 b=cArHySgA4nWd1mKUrqVo0uTm2hXy0rj2G9qs5Vq93AS14Y9UDh+iBjVGNHG0bq6ddoP5
 qPHAJ8x5OV/g3btSIhAVS3NBM9uOS+2POlgtElHyG3Wc0rSDJAOMGBHPP12UPrXCm9Nz
 RLX8t/2lKz4NJ/g2VroP9yxZCUj0DCaFXZQFCDlD+iPJSVhcDugL2N4Cm1dZyHqkUFiS
 gJhhTuknc8FEXO+FXelZKQu9RTiWJ/mvAwdNEHv51SSy3JLDCbRMgzS/407uqo16i1KJ
 dls8xAVDb9b75l6rBQt7+W09Jl0K9On+1EQVbGJ4hWF1wr0RubGgxtiwIaz0iKMVtXFh 0g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2evhtbr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 04:11:22 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30D4BLsj011461
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 04:11:21 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 12 Jan 2023 20:11:21 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: usb: Introduce GPIO-based SBU mux
Date:   Thu, 12 Jan 2023 20:11:14 -0800
Message-ID: <20230113041115.4189210-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6_7VJjfV4A7p7lB44GeN4MTarRk4kCPc
X-Proofpoint-ORIG-GUID: 6_7VJjfV4A7p7lB44GeN4MTarRk4kCPc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_14,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 clxscore=1011 mlxlogscore=741 mlxscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130026
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Introduce a binding for GPIO-based mux hardware used for connecting,
disconnecting and switching orientation of the SBU lines in USB Type-C
applications.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v1:
- Expanded the example to indicate how this fits with the TCPM
- Updated maintainer email address.

 .../devicetree/bindings/usb/gpio-sbu-mux.yaml | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml

diff --git a/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
new file mode 100644
index 000000000000..bf4b1d016e1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/gpio-sbu-mux.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: GPIO-based SBU mux
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+description:
+  In USB Type-C applications the SBU lines needs to be connected, disconnected
+  and swapped depending on the altmode and orientation. This binding describes
+  a family of hardware solutions which switches between these modes using GPIO
+  signals.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - onnn,fsusb43l10x
+          - pericom,pi3usb102
+      - const: gpio-sbu-mux
+
+  enable-gpios:
+    description: Switch enable GPIO
+
+  select-gpios:
+    description: Orientation select
+
+  vcc-supply:
+    description: power supply
+
+  mode-switch:
+    description: Flag the port as possible handle of altmode switching
+    type: boolean
+
+  orientation-switch:
+    description: Flag the port as possible handler of orientation switching
+    type: boolean
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      A port node to link the SBU mux to a TypeC controller for the purpose of
+      handling altmode muxing and orientation switching.
+
+required:
+  - compatible
+  - enable-gpios
+  - select-gpios
+  - mode-switch
+  - orientation-switch
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    tcpm {
+        connector {
+            compatible = "usb-c-connector";
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    tcpm_hs_out: endpoint {
+                        remote-endpoint = <&usb_hs_phy_in>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    tcpm_ss_out: endpoint {
+                        remote-endpoint = <&usb_ss_phy_in>;
+                    };
+                };
+
+                port@2 {
+                    reg = <2>;
+                    tcpm_sbu_out: endpoint {
+                        remote-endpoint = <&sbu_mux_in>;
+                    };
+                };
+            };
+        };
+    };
+
+    sbu-mux {
+        compatible = "pericom,pi3usb102", "gpio-sbu-mux";
+
+        enable-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
+        select-gpios = <&tlmm 164 GPIO_ACTIVE_HIGH>;
+
+        mode-switch;
+        orientation-switch;
+
+        port {
+            sbu_mux_in: endpoint {
+                remote-endpoint = <&tcpm_sbu_out>;
+            };
+        };
+    };
+...
-- 
2.37.3

