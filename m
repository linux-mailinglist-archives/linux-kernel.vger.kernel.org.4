Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E5D6F6D3A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjEDNrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjEDNrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:47:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886F97D9F
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 06:47:38 -0700 (PDT)
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <m.felsch@pengutronix.de>)
        id 1puZIU-0004SX-82; Thu, 04 May 2023 15:47:02 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
Date:   Thu, 04 May 2023 15:46:50 +0200
Subject: [PATCH v2 1/4] dt-bindings: usb: gpio-sbu-mux: add support for
 ss-data lanes mux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-1-3889b1b2050c@pengutronix.de>
References: <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-0-3889b1b2050c@pengutronix.de>
In-Reply-To: <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-0-3889b1b2050c@pengutronix.de>
To:     andreas@fatal.se, jun.li@nxp.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.12.1
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the support for GPIO based USB-C SS data lane muxing.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 .../devicetree/bindings/usb/gpio-sbu-mux.yaml      | 82 +++++++++++++++++++---
 1 file changed, 71 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
index bf4b1d016e1f..796f3283ac02 100644
--- a/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
+++ b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
@@ -4,24 +4,26 @@
 $id: "http://devicetree.org/schemas/usb/gpio-sbu-mux.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: GPIO-based SBU mux
+title: GPIO-based SS/SBU mux
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
 
 description:
-  In USB Type-C applications the SBU lines needs to be connected, disconnected
-  and swapped depending on the altmode and orientation. This binding describes
-  a family of hardware solutions which switches between these modes using GPIO
-  signals.
+  In USB Type-C applications the SS/SBU lines needs to be connected,
+  disconnected and swapped depending on the altmode and orientation. This
+  binding describes a family of hardware solutions which switches between these
+  modes using GPIO signals.
 
 properties:
   compatible:
-    items:
-      - enum:
-          - onnn,fsusb43l10x
-          - pericom,pi3usb102
-      - const: gpio-sbu-mux
+    oneOf:
+      - items:
+          - enum:
+              - onnn,fsusb43l10x
+              - pericom,pi3usb102
+          - const: gpio-sbu-mux
+      - const: gpio-ss-mux
 
   enable-gpios:
     description: Switch enable GPIO
@@ -50,10 +52,18 @@ required:
   - compatible
   - enable-gpios
   - select-gpios
-  - mode-switch
   - orientation-switch
   - port
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: gpio-sbu-mux
+then:
+  required:
+    - mode-switch
+
 additionalProperties: false
 
 examples:
@@ -107,4 +117,54 @@ examples:
             };
         };
     };
+
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
+                    tcpm_ss_mux_out: endpoint {
+                        remote-endpoint = <&ss_mux_in>;
+                    };
+                };
+            };
+        };
+    };
+
+    usb-ss-mux {
+        compatible = "gpio-ss-mux";
+
+        enable-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
+        select-gpios = <&tlmm 164 GPIO_ACTIVE_HIGH>;
+
+        orientation-switch;
+
+        port {
+            ss_mux_in: endpoint {
+                remote-endpoint = <&tcpm_ss_mux_out>;
+            };
+        };
+    };
 ...

-- 
2.39.2

