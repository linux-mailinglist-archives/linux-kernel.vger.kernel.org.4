Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E905269E594
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbjBURKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjBURKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:10:03 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1E1DBCC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:10:00 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id ee7so4944768edb.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zk1effhT0EXQ9+RxXUxGqQreCCRNF9GeDiBMBfy/NeA=;
        b=XAwkATaMHWEzAGgMy8wnXA4HZjDoflGyrXST0eyyeMcgM4YXZ2pefECK8lB8S4cEBw
         bkbGf4eGf6xh1c80fIMpJCXnjEK5vsHklhQ6Qlb5dV22KfWPkuSidXZp4eFrnfxmCk4L
         ToW9A/i4ncBJtRTb+UPXy0h/3KeAXEjSvcB1Fa/3PI9X7ecNeMji2iF4fzXaEMSgoohm
         lDINowSKVRUQJlzx69r7icUia5MsgXBsJcMJ0b1V38ltlbo9kDzO4Qj0s/y/7anyGRzs
         UW/nPCuSD1ttsVww7ExTj8FHQxor78JrfjbTuknVy7Xs56NYLGsa0QSZOoAvuMLHVMRq
         egcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zk1effhT0EXQ9+RxXUxGqQreCCRNF9GeDiBMBfy/NeA=;
        b=zkCV8tjtEvORNUCwIr3BTfq9sYorgSeV1nhGtyYkUw8xQGRBJ6/KKKxBnrR7omPL9Y
         C8Llp6CffGe/Y/8pX32NakrgGtOy/u8LcgeFOGmukGfGFS8O0f96rG/QirQZpvdb8U5i
         PstYN3TuzV3OwyFNbpprf70oHqHfWWsE8aO9fZRWu/nRcujghO6/+GOjymnnuoHnXzSk
         u3JInSPQHag2Z0L15TI5qL//fuARnsApcoWfJ56ieucB8sUD0IMrwmN8ZF/uUc+/AfoY
         mxrpPSh3HPbYagPaNCW+B149bBXiQ09moQCl22vU184QzrkuSFIJ1HVAOKx13L0xxM6h
         3gRw==
X-Gm-Message-State: AO0yUKVw5gDNlvLEcdBtEauESsKqayXFmJDGKX3kx1R57W9SLLeMFShE
        N3H497il+WBNABdOmdWsZWY5sA==
X-Google-Smtp-Source: AK7set9Q4/MUZHnyOtXbFC1Yu2FeinPg9/TzEfhRznYkpmJY5CzLj9XluOqEYpWqWF2Eu0CKs0QoCA==
X-Received: by 2002:a17:906:71c2:b0:8b1:3225:66f0 with SMTP id i2-20020a17090671c200b008b1322566f0mr11879621ejk.68.1676999399204;
        Tue, 21 Feb 2023 09:09:59 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bj4-20020a170906b04400b008c78fb7206dsm4054416ejb.68.2023.02.21.09.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 09:09:58 -0800 (PST)
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
Subject: [PATCH] dt-bindings: display: bridge: parade,ps8622: convert to dtschema
Date:   Tue, 21 Feb 2023 18:09:55 +0100
Message-Id: <20230221170955.62448-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Parade PS8622/PS8625 DisplayPort to LVDS Converter bindings
to DT schema.  Changes during conversion: add missing vdd12-supply, used
by Linux driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../display/bridge/parade,ps8622.yaml         | 115 ++++++++++++++++++
 .../bindings/display/bridge/ps8622.txt        |  31 -----
 2 files changed, 115 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/parade,ps8622.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/bridge/ps8622.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/parade,ps8622.yaml b/Documentation/devicetree/bindings/display/bridge/parade,ps8622.yaml
new file mode 100644
index 000000000000..e6397ac2048b
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/parade,ps8622.yaml
@@ -0,0 +1,115 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/parade,ps8622.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Parade PS8622/PS8625 DisplayPort to LVDS Converter
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+properties:
+  compatible:
+    enum:
+      - parade,ps8622
+      - parade,ps8625
+
+  reg:
+    maxItems: 1
+
+  lane-count:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2]
+    description: Number of DP lanes to use.
+
+  use-external-pwm:
+    type: boolean
+    description: Backlight will be controlled by an external PWM.
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO connected to RST_ pin.
+
+  sleep-gpios:
+    maxItems: 1
+    description: GPIO connected to PD_ pin.
+
+  vdd12-supply: true
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Video port for LVDS output.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Video port for DisplayPort input.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - sleep-gpios
+  - ports
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: parade,ps8622
+    then:
+      properties:
+        lane-count:
+          const: 1
+    else:
+      properties:
+        lane-count:
+          const: 2
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        lvds-bridge@48 {
+            compatible = "parade,ps8625";
+            reg = <0x48>;
+            sleep-gpios = <&gpx3 5 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpy7 7 GPIO_ACTIVE_HIGH>;
+            lane-count = <2>;
+            use-external-pwm;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    bridge_out: endpoint {
+                        remote-endpoint = <&panel_in>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+
+                    bridge_in: endpoint {
+                        remote-endpoint = <&dp_out>;
+                    };
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/display/bridge/ps8622.txt b/Documentation/devicetree/bindings/display/bridge/ps8622.txt
deleted file mode 100644
index c989c3807f2b..000000000000
--- a/Documentation/devicetree/bindings/display/bridge/ps8622.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-ps8622-bridge bindings
-
-Required properties:
-	- compatible: "parade,ps8622" or "parade,ps8625"
-	- reg: first i2c address of the bridge
-	- sleep-gpios: OF device-tree gpio specification for PD_ pin.
-	- reset-gpios: OF device-tree gpio specification for RST_ pin.
-
-Optional properties:
-	- lane-count: number of DP lanes to use
-	- use-external-pwm: backlight will be controlled by an external PWM
-	- video interfaces: Device node can contain video interface port
-			    nodes for panel according to [1].
-
-[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
-
-Example:
-	lvds-bridge@48 {
-		compatible = "parade,ps8622";
-		reg = <0x48>;
-		sleep-gpios = <&gpc3 6 1 0 0>;
-		reset-gpios = <&gpc3 1 1 0 0>;
-		lane-count = <1>;
-		ports {
-			port@0 {
-				bridge_out: endpoint {
-					remote-endpoint = <&panel_in>;
-				};
-			};
-		};
-	};
-- 
2.34.1

