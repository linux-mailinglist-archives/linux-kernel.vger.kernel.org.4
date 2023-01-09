Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B886621AC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbjAIJdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjAIJdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:33:47 -0500
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43196DA1;
        Mon,  9 Jan 2023 01:33:42 -0800 (PST)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 192.168.8.21
        by mg.richtek.com with MailGates ESMTP Server V3.0(2729:0:AUTH_RELAY)
        (envelope-from <prvs=1372AFEF34=gene_chen@richtek.com>); Mon, 09 Jan 2023 17:33:39 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTP Server V5.0(16500:0:AUTH_RELAY)
        (envelope-from <gene_chen@richtek.com>); Mon, 09 Jan 2023 17:31:40 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Mon, 9 Jan
 2023 17:31:39 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Mon, 9 Jan 2023 17:31:39 +0800
From:   <gene_chen@richtek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux@roeck-us.net>, <heikki.krogerus@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>
Subject: [PATCH 1/2] dt-bindings usb: typec: rt1718s: Add binding for Richtek RT1718S
Date:   Mon, 9 Jan 2023 17:31:13 +0800
Message-ID: <1673256674-25165-1-git-send-email-gene_chen@richtek.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add binding for Richtek RT1718s

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 .../devicetree/bindings/usb/richtek,rt1718s.yaml   | 98 ++++++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1718s.yaml

diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1718s.yaml b/Documentation/devicetree/bindings/usb/richtek,rt1718s.yaml
new file mode 100644
index 00000000..7797fc6
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/richtek,rt1718s.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/richtek,rt1718s.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Richtek RT1718S Type-C Port Switch and Power Delivery controller
+
+maintainers:
+  - Gene Chen <gene_chen@richtek.com>
+
+description: |
+  The RT1718S is a USB Type-C controller that complies with the latest
+  USB Type-C and PD standards. It does the USB Type-C detection including attach
+  and orientation. It integrates the physical layer of the USB BMC power
+  delivery protocol to allow up to 100W of power. The BMC PD block enables full
+  support for alternative interfaces of the Type-C specification.
+
+properties:
+  compatible:
+    enum:
+      - richtek,rt1718s
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  wakeup-source:
+    description: enable IRQ remote wakeup, see power/wakeup-source.txt
+    type: boolean
+
+  connector:
+    type: object
+    $ref: ../connector/usb-connector.yaml#
+    description:
+      Properties for usb c connector.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - connector
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/usb/pd.h>
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      rt1718s@43 {
+        compatible = "richtek,rt1718s";
+        reg = <0x43>;
+        interrupts-extended = <&gpio26 3 IRQ_TYPE_LEVEL_LOW>;
+        wakeup-source;
+
+        connector {
+          compatible = "usb-c-connector";
+          label = "USB-C";
+          data-role = "dual";
+          power-role = "dual";
+          try-power-role = "sink";
+          source-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
+          sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
+          op-sink-microwatt = <10000000>;
+
+          ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+              reg = <0>;
+              endpoint {
+                remote-endpoint = <&usb_hs>;
+              };
+            };
+            port@1 {
+              reg = <1>;
+              endpoint {
+                remote-endpoint = <&usb_ss>;
+              };
+            };
+            port@2 {
+              reg = <2>;
+              endpoint {
+                remote-endpoint = <&dp_aux>;
+              };
+            };
+          };
+        };
+      };
+    };
+...
-- 
2.7.4

