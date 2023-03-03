Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE07A6A8E26
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjCCAbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjCCAa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:30:59 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E5459E73;
        Thu,  2 Mar 2023 16:30:38 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id h9so777660ljq.2;
        Thu, 02 Mar 2023 16:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677803438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Abxnf4PLTXbO0gDgH1qEHA+CvbUbFZZ/y+G7g1X35Vc=;
        b=B4ClqieKONYzx7f0+8OXamiu4+DH/ZzMIR5y9yG1bsj4d1C+lawrgk7/2xU7+Do6bc
         EdrrRsDEmJpIAI3LBU7mAtgOsGyRCn8UJNvj9ZXq0gcZ+7FP8sE94V4j5lkakMyg9Sd7
         iHvBoFGs7cZg2TM5XJhZSnzbrmxDHrbHR+knuspyqLPGATYSFuDM5kcO8NgLQ9UAHsR6
         xn2JCU8nxmVh0TXPscWtrF/jpWExZql67sxL1binjr9XnU/xs16FCUbfVid6y6hPnj//
         dk+F1ofgM/HLoY52y8nBjLbeTR8gsOu02i4Q6KZKhXZK0CYoUPxbA7VlcJfoQmoPqJxD
         w6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677803438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Abxnf4PLTXbO0gDgH1qEHA+CvbUbFZZ/y+G7g1X35Vc=;
        b=OIekT4Qr8mqwdcUTABeFfkuUwn5HUrgaCjyZx5s00xZbnXY3KwgdS539wS8txDipVg
         FJq6IQrYPs7P6uRp82hnNzdtL512n/iEQ1N+/jzzDVK7xrWV1z/HskW8LobySQkbYVPL
         Jy/YaHxS+pfit3gxTzUsRG1FRYvX7alzDViIPvo/xG9f8XOJJ8UoEFuVrlVfIrTd8Im0
         LWFt4Pubn+8tCXbgPg1phiyHiAxl89w8axpp1GwmoosgCUbKSwL6G7lhp4Yl7PQ/HLws
         FIiaRnygIaTq6KSGuCSgkjHVuEWDIsWwxPYhZU7q8sIn1kut+GN1Tqd15CTmfaXUEyeN
         qovw==
X-Gm-Message-State: AO0yUKXFo0/DsO80CXPMYxvEhRXQ12fZN6NaUa1bDhgEnuTKcVVpMstV
        E87m28vSq1Kje62bSFLG0HI=
X-Google-Smtp-Source: AK7set/W5/f4HZD8YZC067+A+mlXTI+colSlOuvo+z0OqZegLPtSQALH5/dCR8F48Qp6RupepoClkw==
X-Received: by 2002:a2e:574a:0:b0:295:c306:ec40 with SMTP id r10-20020a2e574a000000b00295c306ec40mr3567066ljd.34.1677803437774;
        Thu, 02 Mar 2023 16:30:37 -0800 (PST)
Received: from arinc9-PC.lan ([212.68.60.226])
        by smtp.gmail.com with ESMTPSA id v19-20020a2e9f53000000b002932b817990sm64901ljk.31.2023.03.02.16.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 16:30:37 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Subject: [PATCH 18/20] dt-bindings: pinctrl: ralink: rt305x: split binding
Date:   Fri,  3 Mar 2023 03:28:47 +0300
Message-Id: <20230303002850.51858-19-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230303002850.51858-1-arinc.unal@arinc9.com>
References: <20230303002850.51858-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The RT3352 and RT5350 SoCs each contain different pin muxing information,
therefore, should be split. This can be done now that there are compatible
strings to distinguish them from other SoCs.

Split the schema out to ralink,rt3352-pinctrl.yaml and
ralink,rt5350-pinctrl.yaml.

Remove ralink,rt3352-pinctrl and ralink,rt5350-pinctrl from rt305x.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../pinctrl/ralink,rt305x-pinctrl.yaml        |  83 +-----
 .../pinctrl/ralink,rt3352-pinctrl.yaml        | 243 ++++++++++++++++++
 .../pinctrl/ralink,rt5350-pinctrl.yaml        | 206 +++++++++++++++
 3 files changed, 455 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ralink,rt3352-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ralink,rt5350-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
index 55c6f9826e76..95a904273009 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
@@ -11,17 +11,13 @@ maintainers:
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
 description: |
-  Ralink RT305X pin controller for RT3050, RT3052, RT3350, RT3352 and RT5350
-  SoCs.
+  Ralink RT305X pin controller for RT3050, RT3052, and RT3350 SoCs.
   The pin controller can only set the muxing of pin groups. Muxing individual
   pins is not supported. There is no pinconf support.
 
 properties:
   compatible:
-    enum:
-      - ralink,rt305x-pinctrl
-      - ralink,rt3352-pinctrl
-      - ralink,rt5350-pinctrl
+    const: ralink,rt305x-pinctrl
 
 patternProperties:
   '-pins$':
@@ -39,21 +35,9 @@ patternProperties:
           function:
             description:
               A string containing the name of the function to mux to the group.
-            anyOf:
-              - description: For RT3050, RT3052 and RT3350 SoCs
-                enum: [gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, mdio,
-                       pcm gpio, pcm i2s, pcm uartf, rgmii, sdram, spi, uartf,
-                       uartlite]
-
-              - description: For RT3352 SoC
-                enum: [gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, led,
-                       lna, mdio, pa, pcm gpio, pcm i2s, pcm uartf, rgmii, spi,
-                       spi_cs1, uartf, uartlite, wdg_cs1]
-
-              - description: For RT5350 SoC
-                enum: [gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, led,
-                       pcm gpio, pcm i2s, pcm uartf, spi, spi_cs1, uartf,
-                       uartlite, wdg_cs1]
+            enum: [gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, mdio,
+                   pcm gpio, pcm i2s, pcm uartf, rgmii, sdram, spi, uartf,
+                   uartlite]
 
           groups:
             description:
@@ -72,17 +56,7 @@ patternProperties:
             then:
               properties:
                 groups:
-                  anyOf:
-                    - description: For RT3050, RT3052 and RT3350 SoCs
-                      enum: [i2c, jtag, mdio, rgmii, sdram, spi, uartf,
-                             uartlite]
-
-                    - description: For RT3352 SoC
-                      enum: [i2c, jtag, led, lna, mdio, pa, rgmii, spi, spi_cs1,
-                             uartf, uartlite]
-
-                    - description: For RT5350 SoC
-                      enum: [i2c, jtag, led, spi, spi_cs1, uartf, uartlite]
+                  enum: [i2c, jtag, mdio, rgmii, sdram, spi, uartf, uartlite]
 
           - if:
               properties:
@@ -129,24 +103,6 @@ patternProperties:
                 groups:
                   enum: [jtag]
 
-          - if:
-              properties:
-                function:
-                  const: led
-            then:
-              properties:
-                groups:
-                  enum: [led]
-
-          - if:
-              properties:
-                function:
-                  const: lna
-            then:
-              properties:
-                groups:
-                  enum: [lna]
-
           - if:
               properties:
                 function:
@@ -156,15 +112,6 @@ patternProperties:
                 groups:
                   enum: [mdio]
 
-          - if:
-              properties:
-                function:
-                  const: pa
-            then:
-              properties:
-                groups:
-                  enum: [pa]
-
           - if:
               properties:
                 function:
@@ -219,15 +166,6 @@ patternProperties:
                 groups:
                   enum: [spi]
 
-          - if:
-              properties:
-                function:
-                  const: spi_cs1
-            then:
-              properties:
-                groups:
-                  enum: [spi_cs1]
-
           - if:
               properties:
                 function:
@@ -246,15 +184,6 @@ patternProperties:
                 groups:
                   enum: [uartlite]
 
-          - if:
-              properties:
-                function:
-                  const: wdg_cs1
-            then:
-              properties:
-                groups:
-                  enum: [spi_cs1]
-
 allOf:
   - $ref: pinctrl.yaml#
 
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt3352-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt3352-pinctrl.yaml
new file mode 100644
index 000000000000..c9bc6cfd834c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt3352-pinctrl.yaml
@@ -0,0 +1,243 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/ralink,rt3352-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ralink RT3352 Pin Controller
+
+maintainers:
+  - Arınç ÜNAL <arinc.unal@arinc9.com>
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+description: |
+  Ralink RT3352 pin controller for RT3352 SoC.
+  The pin controller can only set the muxing of pin groups. Muxing individual
+  pins is not supported. There is no pinconf support.
+
+properties:
+  compatible:
+    const: ralink,rt3352-pinctrl
+
+patternProperties:
+  '-pins$':
+    type: object
+    additionalProperties: false
+
+    patternProperties:
+      '^(.*-)?pinmux$':
+        type: object
+        description: node for pinctrl.
+        $ref: pinmux-node.yaml#
+        additionalProperties: false
+
+        properties:
+          function:
+            description:
+              A string containing the name of the function to mux to the group.
+            enum: [gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, led, lna,
+                   mdio, pa, pcm gpio, pcm i2s, pcm uartf, rgmii, spi, spi_cs1,
+                   uartf, uartlite, wdg_cs1]
+
+          groups:
+            description:
+              An array of strings. Each string contains the name of a group.
+            maxItems: 1
+
+        required:
+          - groups
+          - function
+
+        allOf:
+          - if:
+              properties:
+                function:
+                  const: gpio
+            then:
+              properties:
+                groups:
+                  enum: [i2c, jtag, led, lna, mdio, pa, rgmii, spi, spi_cs1,
+                         uartf, uartlite]
+
+          - if:
+              properties:
+                function:
+                  const: gpio i2s
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: gpio uartf
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: i2c
+            then:
+              properties:
+                groups:
+                  enum: [i2c]
+
+          - if:
+              properties:
+                function:
+                  const: i2s uartf
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: jtag
+            then:
+              properties:
+                groups:
+                  enum: [jtag]
+
+          - if:
+              properties:
+                function:
+                  const: led
+            then:
+              properties:
+                groups:
+                  enum: [led]
+
+          - if:
+              properties:
+                function:
+                  const: lna
+            then:
+              properties:
+                groups:
+                  enum: [lna]
+
+          - if:
+              properties:
+                function:
+                  const: mdio
+            then:
+              properties:
+                groups:
+                  enum: [mdio]
+
+          - if:
+              properties:
+                function:
+                  const: pa
+            then:
+              properties:
+                groups:
+                  enum: [pa]
+
+          - if:
+              properties:
+                function:
+                  const: pcm gpio
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: pcm i2s
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: pcm uartf
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: rgmii
+            then:
+              properties:
+                groups:
+                  enum: [rgmii]
+
+          - if:
+              properties:
+                function:
+                  const: spi
+            then:
+              properties:
+                groups:
+                  enum: [spi]
+
+          - if:
+              properties:
+                function:
+                  const: spi_cs1
+            then:
+              properties:
+                groups:
+                  enum: [spi_cs1]
+
+          - if:
+              properties:
+                function:
+                  const: uartf
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: uartlite
+            then:
+              properties:
+                groups:
+                  enum: [uartlite]
+
+          - if:
+              properties:
+                function:
+                  const: wdg_cs1
+            then:
+              properties:
+                groups:
+                  enum: [spi_cs1]
+
+allOf:
+  - $ref: pinctrl.yaml#
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    pinctrl {
+      compatible = "ralink,rt3352-pinctrl";
+
+      i2c_pins: i2c0-pins {
+        pinmux {
+          groups = "i2c";
+          function = "i2c";
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt5350-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt5350-pinctrl.yaml
new file mode 100644
index 000000000000..f248202ce866
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt5350-pinctrl.yaml
@@ -0,0 +1,206 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/ralink,rt5350-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ralink RT5350 Pin Controller
+
+maintainers:
+  - Arınç ÜNAL <arinc.unal@arinc9.com>
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+description: |
+  Ralink RT5350 pin controller for RT5350 SoC.
+  The pin controller can only set the muxing of pin groups. Muxing individual
+  pins is not supported. There is no pinconf support.
+
+properties:
+  compatible:
+    const: ralink,rt5350-pinctrl
+
+patternProperties:
+  '-pins$':
+    type: object
+    additionalProperties: false
+
+    patternProperties:
+      '^(.*-)?pinmux$':
+        type: object
+        description: node for pinctrl.
+        $ref: pinmux-node.yaml#
+        additionalProperties: false
+
+        properties:
+          function:
+            description:
+              A string containing the name of the function to mux to the group.
+            enum: [gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, led,
+                   pcm gpio, pcm i2s, pcm uartf, spi, spi_cs1, uartf, uartlite,
+                   wdg_cs1]
+
+          groups:
+            description:
+              An array of strings. Each string contains the name of a group.
+            maxItems: 1
+
+        required:
+          - groups
+          - function
+
+        allOf:
+          - if:
+              properties:
+                function:
+                  const: gpio
+            then:
+              properties:
+                groups:
+                  enum: [i2c, jtag, led, spi, spi_cs1, uartf, uartlite]
+
+          - if:
+              properties:
+                function:
+                  const: gpio i2s
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: gpio uartf
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: i2c
+            then:
+              properties:
+                groups:
+                  enum: [i2c]
+
+          - if:
+              properties:
+                function:
+                  const: i2s uartf
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: jtag
+            then:
+              properties:
+                groups:
+                  enum: [jtag]
+
+          - if:
+              properties:
+                function:
+                  const: led
+            then:
+              properties:
+                groups:
+                  enum: [led]
+
+          - if:
+              properties:
+                function:
+                  const: pcm gpio
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: pcm i2s
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: pcm uartf
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: spi
+            then:
+              properties:
+                groups:
+                  enum: [spi]
+
+          - if:
+              properties:
+                function:
+                  const: spi_cs1
+            then:
+              properties:
+                groups:
+                  enum: [spi_cs1]
+
+          - if:
+              properties:
+                function:
+                  const: uartf
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: uartlite
+            then:
+              properties:
+                groups:
+                  enum: [uartlite]
+
+          - if:
+              properties:
+                function:
+                  const: wdg_cs1
+            then:
+              properties:
+                groups:
+                  enum: [spi_cs1]
+
+allOf:
+  - $ref: pinctrl.yaml#
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    pinctrl {
+      compatible = "ralink,rt5350-pinctrl";
+
+      i2c_pins: i2c0-pins {
+        pinmux {
+          groups = "i2c";
+          function = "i2c";
+        };
+      };
+    };
-- 
2.37.2

