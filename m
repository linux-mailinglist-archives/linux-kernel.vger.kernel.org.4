Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B44B7362D4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 06:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjFTEwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 00:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjFTEv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 00:51:57 -0400
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1115.securemx.jp [210.130.202.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CDE1732
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 21:51:49 -0700 (PDT)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1115) id 35K3HPtg018262; Tue, 20 Jun 2023 12:17:25 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 35K3GgL9010403; Tue, 20 Jun 2023 12:16:42 +0900
X-Iguazu-Qid: 2wHHDpROIE2K2upkJ7
X-Iguazu-QSIG: v=2; s=0; t=1687231002; q=2wHHDpROIE2K2upkJ7; m=E+RVEeJopNuTV/4JvggiCsa3R+/efoS/M1haM1kzYFI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
        by relay.securemx.jp (mx-mr1110) id 35K3Gdix040355
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 20 Jun 2023 12:16:40 +0900
X-SA-MID: 2172047
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/5] dt-bindings: media: platform: visconti: Add Toshiba Visconti Video Input Interface bindings
Date:   Tue, 20 Jun 2023 12:11:07 +0900
X-TSB-HOP2: ON
Message-Id: <20230620031111.3776-2-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230620031111.3776-1-yuji2.ishikawa@toshiba.co.jp>
References: <20230620031111.3776-1-yuji2.ishikawa@toshiba.co.jp>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the Device Tree binding documentation that allows to describe
the Video Input Interface found in Toshiba Visconti SoCs.

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
Changelog v2:
- no change

Changelog v3:
- no change

Changelog v4:
- fix style problems at the v3 patch
- remove "index" member
- update example

Changelog v5:
- no change

Changelog v6:
- add register definition of BUS-IF and MPU

 .../bindings/media/toshiba,visconti-viif.yaml | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml

diff --git a/Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml b/Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
new file mode 100644
index 000000000..19ef4242e
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/toshiba,visconti-viif.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toshiba Visconti5 SoC Video Input Interface Device Tree Bindings
+
+maintainers:
+  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+
+description:
+  Toshiba Visconti5 SoC Video Input Interface (VIIF)
+  receives MIPI CSI2 video stream,
+  processes the stream with embedded image signal processor (L1ISP, L2ISP),
+  then stores pictures to main memory.
+
+properties:
+  compatible:
+    const: toshiba,visconti-viif
+
+  reg:
+    items:
+      - description: registers for capture control
+      - description: registers for CSI2 receiver control
+      - description: registers for bus interface unit control
+      - description: registers for Memory Protection Unit
+
+  interrupts:
+    items:
+      - description: Sync Interrupt
+      - description: Status (Error) Interrupt
+      - description: CSI2 Receiver Interrupt
+      - description: L1ISP Interrupt
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    unevaluatedProperties: false
+    description: Input port, single endpoint describing the CSI-2 transmitter.
+
+    properties:
+      endpoint:
+        $ref: video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          data-lanes:
+            description: VIIF supports 2 or 4 data lines
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            minItems: 1
+            maxItems: 4
+            items:
+              minimum: 1
+              maximum: 4
+
+          clock-lanes:
+            description: VIIF supports 1 clock line
+            const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        viif@1c000000 {
+            compatible = "toshiba,visconti-viif";
+            reg = <0 0x1c000000 0 0x6000>,
+                  <0 0x1c008000 0 0x400>,
+                  <0 0x1c00E000 0 0x1000>,
+                  <0 0x2417A000 0 0x1000>;
+            interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+
+            port {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                csi_in0: endpoint {
+                    remote-endpoint = <&imx219_out0>;
+                    bus-type = <4>;
+                    data-lanes = <1 2>;
+                    clock-lanes = <0>;
+                    clock-noncontinuous;
+                    link-frequencies = /bits/ 64 <456000000>;
+                };
+            };
+        };
+    };
-- 
2.25.1


