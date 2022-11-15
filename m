Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA0A6296D3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238428AbiKOLKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238247AbiKOLKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:10:03 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D83F1025
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:09:38 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id z14so23491320wrn.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohUJfOkVa1djycDvkBm2g3f0MBvTkDIWyiHcdc1gSek=;
        b=Qu9wOYtBjZGMSxkwiOGyUOQ+VwoNjP23uzZ7o+q7XIjHK6blFMyEBLO6or3ZycUcfy
         Mo/6TRPgMA+IpqGaNyhsly0DI4En083/KOZNyxPfkbD3JYtGPCweMf63aHmOSuDBW7Z6
         xnqPULOtfNIjsubYNKCkNQ+ahljRe1GjQbTH/IzMJPOJO+i3wmRo4sNQFqdnuKHYiRM2
         MZ5Fs6dPGkAyXzWItqZep/3eWzEGtERyUxwDDWRq8XtKoGZsaZ1uYTF6ulnJmPTXOiC0
         FYWbLRG6RiLLhNwcbmbi9dgCkmRqF9VGL2g6HEOaS15q7yJGWDOJjGS3Cf9Ac2WkIG3q
         6RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohUJfOkVa1djycDvkBm2g3f0MBvTkDIWyiHcdc1gSek=;
        b=XJH6zINs90B/E12z2vU9U2S9rhCWRzbYSeCQSPSkpqSQixGqKY5AlphwXEynajqI9x
         LkggglPmjR4T5/lMzrvHlzTLgfdZ2h9gqH4DQjOTwSiwg1ykoL+hGMGToWgwNURm+EIu
         22N15vLQgfCmfNxK7o05eJMBFRowJ9hdhhNZrlhYbqChU1cZRT0/3Vb3cmTRqzxnzOop
         pgzGbVCxoVFQzwlcktlZ4N7+D4Sacaa9sUBOvw0BjQCIyqfOw6QUr9/o1LN150JfgY4b
         +8MCvKp/XkiG8swHSdCYsz9c//4tDVARPb2YU40c5HPLEww9HteaCv4R9vk6Ag2SQJXv
         ko2A==
X-Gm-Message-State: ANoB5plz/2jPzrUgKhupLalwumhHBuEVGaCx/bAnMIp7TehoP5WQEW6v
        R8fWAZvJBU8uE7hvcLmwwr82ZyKcvgW1mBKO
X-Google-Smtp-Source: AA0mqf63HVK8beQCgOG8/4TQAmgpj0VSMmZqi0lMxBF1eLaF5OBDFg1E5VKlN/B/VlbE2hq/aPdmUA==
X-Received: by 2002:adf:db4b:0:b0:236:64b1:bd30 with SMTP id f11-20020adfdb4b000000b0023664b1bd30mr10283548wrj.667.1668510576708;
        Tue, 15 Nov 2022 03:09:36 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id p25-20020a05600c1d9900b003c64c186206sm15480441wms.16.2022.11.15.03.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 03:09:36 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v10 1/2] dt-bindings: mfd: Add MAX5970 and MAX5978
Date:   Tue, 15 Nov 2022 12:09:31 +0100
Message-Id: <20221115110932.637091-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221115110932.637091-1-Naresh.Solanki@9elements.com>
References: <20221115110932.637091-1-Naresh.Solanki@9elements.com>
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

From: Marcello Sylvester Bauer <sylv@sylv.io>

The MAX597x is a hot swap controller with configurable fault protection.
It also has 10bit ADC for current & voltage measurements.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
Co-developed-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Co-developed-by: Naresh Solanki <Naresh.Solanki@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 .../bindings/mfd/maxim,max5970.yaml           | 154 ++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
new file mode 100644
index 000000000000..edf0c23db4ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
@@ -0,0 +1,154 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/maxim,max5970.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Regulator for MAX5970 smart switch from Maxim Integrated.
+
+maintainers:
+  - Patrick Rudolph <patrick.rudolph@9elements.com>
+
+description: |
+  The smart switch provides no output regulation, but independent fault protection
+  and voltage and current sensing.
+  Programming is done through I2C bus.
+
+  Datasheets:
+    https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
+    https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf
+
+properties:
+  compatible:
+    enum:
+      - maxim,max5970
+      - maxim,max5978
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  leds:
+    type: object
+    description:
+      Properties for four LEDS.
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^led@[0-3]$":
+        $ref: /schemas/leds/common.yaml#
+        type: object
+
+    additionalProperties: false
+
+  vss1-supply:
+    description: Supply of the first channel.
+
+  vss2-supply:
+    description: Supply of the second channel.
+
+  regulators:
+    type: object
+    description:
+      Properties for both regulators. Also set value for shunt resistor used.
+
+    patternProperties:
+      "^sw[0-1]$":
+        $ref: /schemas/regulator/regulator.yaml#
+        type: object
+        properties:
+          shunt-resistor-micro-ohms:
+            description: |
+              The value of current sense resistor in microohms.
+
+        required:
+          - shunt-resistor-micro-ohms
+
+      unevaluatedProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+  - vss1-supply
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - maxim,max5970
+    then:
+      required:
+        - vss2-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        regulator@3a {
+            compatible = "maxim,max5978";
+            reg = <0x3a>;
+            vss1-supply = <&p3v3>;
+
+            regulators {
+                sw0_ref_0: sw0 {
+                    regulator-compatible = "SW0";
+                    shunt-resistor-micro-ohms = <12000>;
+                };
+            };
+
+            leds {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                led@0 {
+                    reg = <0>;
+                    label = "led0";
+                    default-state = "on";
+                };
+                led@1 {
+                    reg = <1>;
+                    label = "led1";
+                    default-state = "on";
+                };
+            };
+        };
+    };
+
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        regulator@3a {
+            compatible = "maxim,max5970";
+            reg = <0x3a>;
+            vss1-supply = <&p3v3>;
+            vss2-supply = <&p5v>;
+
+            regulators {
+                sw0_ref_1: sw0 {
+                    regulator-compatible = "SW0";
+                    shunt-resistor-micro-ohms = <12000>;
+                };
+                sw1_ref_1: sw1 {
+                    regulator-compatible = "SW1";
+                    shunt-resistor-micro-ohms = <10000>;
+                };
+            };
+        };
+    };
+...
-- 
2.37.3

