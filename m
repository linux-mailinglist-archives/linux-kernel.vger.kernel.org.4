Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECDE67EF99
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjA0Ufk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjA0Ufh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:35:37 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A917B7A2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 12:35:31 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id z5so6015857wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 12:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tOSLWb1vwjKO4WJ43/TjoArz+LQUiEIotvMCGvn9Rhg=;
        b=XrPghrfWp28VnVClJjRshC0wfHRxYPDGh6e4242w3yT8IYIZ4fRLKUv/MQiAoovS1M
         F0JOi92mTwNMozlOENVbeLAHM8xsOQdtyEnAxidL0dYrROc8ECbwvtDzF7tFCFsYzyrn
         cHaCuph3U0DADKUAFM30qB6FQNSxqiBP07d++LEezfrKFQfuxzQyupi7qpvSq+AiNJ27
         JOBRGl/Hpl7OkLXRenybG4FkVYXm2QyiGXLLWPpnyRm6nzuWGc3RNPN6OrvpLwFtJ70f
         XGeRMpflno8eKNKDSYpmgX7is3kIu8s+B9f1rbEpNxGfnb7PfF18oSXd1WLmmLOxs85m
         68Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tOSLWb1vwjKO4WJ43/TjoArz+LQUiEIotvMCGvn9Rhg=;
        b=p5LeIN6t4htKvwsgMidu7m4GX95lCnoZPyTdUP2X95KgGx/t14OTPMOug2/VVqZjuu
         JXWPhUrrpmnznx2ZmkBkae0428/8G/XZGa1BoGDfxey/vxwslMs5Aiak/nZ+zI6xWnwc
         jCHI1pnIfyjVfP49JXgHfvg6T0pG2+/5YG4ORuW7DG+OI5l198nT1sn8VRU8PMV1DkmL
         pewpSu6RBzc8pMPn+69UB4F3e8rN9BzmqTe12vlntx70BslI/zCoXDL4j6JDLKHvL961
         lWGDw8S5TuGsxIu+nBwfVUCywGpBoaPNoxM7QijcDOD5jPMetp/zGHozbwfZ96FuwpG1
         QE5A==
X-Gm-Message-State: AO0yUKU3Sm+zRq0YRkqYxmumkaCxZiBV8JGHhEhF9LZWUlKXZ4pcNByw
        4bJLLG5jARSq5sLcSwAQwv1ZG7mFTCgvQwD8
X-Google-Smtp-Source: AK7set9mVzens57pP2p8N2/XE1w2NpWbMM1s3hvm8aruGMS6t42palIVYPktw+LHWlOQWaXw6ViYAw==
X-Received: by 2002:adf:e48c:0:b0:2bf:ae16:817c with SMTP id i12-20020adfe48c000000b002bfae16817cmr13488006wrm.29.1674851729760;
        Fri, 27 Jan 2023 12:35:29 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b14-20020adff90e000000b002be34f87a34sm4961307wrr.1.2023.01.27.12.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 12:35:29 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: display: bridge: sil,sii8620: convert to dtschema
Date:   Fri, 27 Jan 2023 21:35:25 +0100
Message-Id: <20230127203525.198295-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Silicon Image SiI8620 HDMI/MHL bridge bindings to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/display/bridge/sil,sii8620.yaml  | 107 ++++++++++++++++++
 .../bindings/display/bridge/sil-sii8620.txt   |  33 ------
 2 files changed, 107 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml b/Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml
new file mode 100644
index 000000000000..90532bb99161
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/sil,sii8620.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silicon Image SiI8620 HDMI/MHL bridge
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+properties:
+  compatible:
+    const: sil,sii8620
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: xtal
+
+  cvcc10-supply:
+    description: Digital Core Supply Voltage (1.0V)
+
+  interrupts:
+    maxItems: 1
+
+  iovcc18-supply:
+    description: I/O Supply Voltage (1.8V)
+
+  reset-gpios:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    unevaluatedProperties: false
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Video port for HDMI (encoder) input
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          MHL to connector port
+
+    required:
+      - port@0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - cvcc10-supply
+  - interrupts
+  - iovcc18-supply
+  - reset-gpios
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        bridge@39 {
+            reg = <0x39>;
+            compatible = "sil,sii8620";
+            cvcc10-supply = <&ldo36_reg>;
+            iovcc18-supply = <&ldo34_reg>;
+            interrupt-parent = <&gpf0>;
+            interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+            reset-gpios = <&gpv7 0 GPIO_ACTIVE_LOW>;
+            clocks = <&pmu_system_controller 0>;
+            clock-names = "xtal";
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    mhl_to_hdmi: endpoint {
+                        remote-endpoint = <&hdmi_to_mhl>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    mhl_to_musb_con: endpoint {
+                        remote-endpoint = <&musb_con_to_mhl>;
+                    };
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt b/Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt
deleted file mode 100644
index b05052f7d62f..000000000000
--- a/Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-Silicon Image SiI8620 HDMI/MHL bridge bindings
-
-Required properties:
-	- compatible: "sil,sii8620"
-	- reg: i2c address of the bridge
-	- cvcc10-supply: Digital Core Supply Voltage (1.0V)
-	- iovcc18-supply: I/O Supply Voltage (1.8V)
-	- interrupts: interrupt specifier of INT pin
-	- reset-gpios: gpio specifier of RESET pin
-	- clocks, clock-names: specification and name of "xtal" clock
-	- video interfaces: Device node can contain video interface port
-			    node for HDMI encoder according to [1].
-
-[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
-
-Example:
-	sii8620@39 {
-		reg = <0x39>;
-		compatible = "sil,sii8620";
-		cvcc10-supply = <&ldo36_reg>;
-		iovcc18-supply = <&ldo34_reg>;
-		interrupt-parent = <&gpf0>;
-		interrupts = <2 0>;
-		reset-gpio = <&gpv7 0 0>;
-		clocks = <&pmu_system_controller 0>;
-		clock-names = "xtal";
-
-		port {
-			mhl_to_hdmi: endpoint {
-				remote-endpoint = <&hdmi_to_mhl>;
-			};
-		};
-	};
-- 
2.34.1

