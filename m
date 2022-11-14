Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36D16276DC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbiKNH6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiKNH5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:57:49 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2950226
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:57:48 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso8831102wmb.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qK4j2egvGTI6/Ds/7rUZ9PAbrRygxTRbXoBmV3kxlw=;
        b=DzRMn3c18YYNaCPzn2PdsF//Nzda+vA8qQrP4Co5xkCEKPBEUU7Re8dTU6ykxAf+af
         NLWrHsjgfk6Q+JMIcQjgTMRvGf6G26sofH76guu4HrEBJRuYL2urT6sAi4IDAfcmYCKg
         wvvDvPpl2oo8lvpsKOPqRfDdavQNWbzJt+oq13RuwXnvzqL/sqM7CMukehewyiq7NBK5
         GtktEbzvP4u/clhDA0y/1RAk4T4gfbEos2qp36uvt7nZFG1kQezyRO1A+f0cCLK3aQ9N
         aZD5nsujJ9HfLHHq2zTWVLBfU5b3k24DSt/V6CuIrVTtsuc9WR7u7B9MAwwY+eX2JgK1
         ylWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qK4j2egvGTI6/Ds/7rUZ9PAbrRygxTRbXoBmV3kxlw=;
        b=BzqMUrETd4mEngBVev9uC3va1dmC43Rt8YR60VCHTAJdRGry4fZihPldLv3DoE06Dd
         VbzV2zNeCLNVBj7UWrTnzdbDO4812PdO11902BEasb1vxJBBXH6pyUGLNiK/WSVQJGf7
         z/VM7f5oxgmtPvB98QQyrL3OYjKWs0NGDYLKyiIPPM3AwwClnhzCL+QcN2KPbgZRcHs9
         fMPtb4W5/1sLMNQQez5x07cxO4jhUuvy+MGlzVRqA61DNq1OvjjraXlO7TtbeeF22tBi
         UBqLZXHKwNu7m3B8CpCFFAR+TYPPs2l3tiz5xl4qW6rBKqXM5spketRKzH27ZvJlPW56
         cGZA==
X-Gm-Message-State: ANoB5pn1mfNTq5ZxQrlU68sv/lckmdxdAvF4mtzUvvB3tGZN7LCdYsVN
        S8XVwpHwGBhVKJSFHHCwgp8b82YQgx1lN2UR
X-Google-Smtp-Source: AA0mqf4KvIolNa5ifG5ln6Rh2uLfg635rOewAU50fc32yfKLc9lCus+x4f/kOiY5RNjSYNZAzf9JbA==
X-Received: by 2002:a05:600c:4d85:b0:3cf:90de:7724 with SMTP id v5-20020a05600c4d8500b003cf90de7724mr7011758wmp.18.1668412666828;
        Sun, 13 Nov 2022 23:57:46 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id p25-20020a05600c1d9900b003c64c186206sm11617768wms.16.2022.11.13.23.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 23:57:46 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v9 1/2] dt-bindings: mfd: Add dt-schema MAX5970 and MAX5978
Date:   Mon, 14 Nov 2022 08:57:38 +0100
Message-Id: <20221114075739.4117439-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221114075739.4117439-1-Naresh.Solanki@9elements.com>
References: <20221114075739.4117439-1-Naresh.Solanki@9elements.com>
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

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 .../bindings/mfd/maxim,max5970.yaml           | 172 ++++++++++++++++++
 1 file changed, 172 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
new file mode 100644
index 000000000000..a93b6e009b9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
@@ -0,0 +1,172 @@
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
+  "#io-channel-cells":
+    const: 1
+
+  regulators:
+    type: object
+    description:
+      Properties for regulator.
+
+    patternProperties:
+      "^sw[0-1]$":
+        $ref: /schemas/regulator/regulator.yaml#
+        type: object
+        properties:
+          shunt-resistor-micro-ohms:
+            description: |
+              The value of curent sense resistor in microohms.
+
+        required:
+          - shunt-resistor-micro-ohms
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
+      properties:
+        io-channels:
+          items:
+            - description: voltage first channel
+            - description: current first channel
+            - description: voltage second channel
+            - description: current second channel
+          description: |
+            Voltage and current for first and second channel.
+      required:
+        - vss2-supply
+    else:
+      properties:
+        io-channels:
+          items:
+            - description: voltage first channel
+            - description: current first channel
+          description: |
+            Voltage and current for first channel.
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        regulator@3a {
+           compatible = "maxim,max5978";
+           reg = <0x3a>;
+           vss1-supply = <&p3v3>;
+
+           regulators {
+               sw0_ref_0: sw0 {
+                      regulator-compatible = "SW0";
+                      shunt-resistor-micro-ohms = <12000>;
+               };
+           };
+
+           leds {
+               #address-cells = <1>;
+               #size-cells = <0>;
+               led@0 {
+                   reg = <0>;
+                   label = "led0";
+                   default-state = "on";
+               };
+               led@1 {
+                   reg = <1>;
+                   label = "led1";
+                   default-state = "on";
+               };
+           };
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

