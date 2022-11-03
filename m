Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FD3618986
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiKCUZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiKCUZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:25:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38E51F2D8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 13:25:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id y16so4372647wrt.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 13:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMCDHKMv/P6PYdVt8qj996PsSxJYPASJtwbqZSZ3fAo=;
        b=V+9AWxv8jW6F6XsrCyDTt2avInrhxlN3n1jDW55cam5PIJocBQUeow+iYMiomy48Mf
         oTtOeWry6PkglsmxsSMZLltFcrzGsd9Qvpqv2wubH0KbhZfMBeY93YKvMiAowuYUUVGR
         45sAgfwPFZoOaMWQHUiVQrQHZG918hvvVL57zLa1jqIbvnS4Hjgkfv0gfgUjO956hJyI
         jKm/uF/sWZ+YNtSju3ETXbAQ91VGBpMhE5QVcRyXDZZ4TsoDOCYjR98D4ugCpOsXWY46
         ewSlOWHk2n0S//s01zwhbKgwijLm4kY7pbHG4GQMlNliUi5JsHOxsXIDCtJSAYaVIiua
         VpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMCDHKMv/P6PYdVt8qj996PsSxJYPASJtwbqZSZ3fAo=;
        b=HE9vKPQFGPhw+vibIiUnoE857Q9cMRKcfjMR4daplF8DA1wG0Ts9kPuJSjnCfXjeYr
         AD6AcGn3dIQZDfT9Omn2beslmHR/eoVQz2v1H1GOR19eby0UGLX1bCI4dcSsjsyDbcdT
         cCvdE0MBqWfo+g72qhEcsO6YCU1C44axd5uHh4I4NTfhbHnhUo6JoANNz27u/lo/TwS0
         vSgsrYd5nFgYn7/YMH0jBIkgcH/1HBSH3gcRg15/i8D7A9k9L8wlxfF20VI2gwjm6dwY
         VVJS+SV6b7GlGbj9998uQbWWTbbGpkv5QhJsMNHSJ4OnuH9j2iwhDV5ZQJrZC+TSfLgR
         z81g==
X-Gm-Message-State: ACrzQf0Wc97/py5Luv4nj9fa3K4hAnXL6UbOLttRgcarBRBkA3qjh3sC
        jHJ2RBucErqxXhRUf2+gJ2CtLvX0dqXpPHXK
X-Google-Smtp-Source: AMsMyM5STGcvVaWDzYK01tHTzwcmJyxJDll+J/OPMBPfFevYYes51r5FK+CxF9l9P2fkUwnIdA1mOw==
X-Received: by 2002:adf:f5d0:0:b0:236:5866:eefe with SMTP id k16-20020adff5d0000000b002365866eefemr21003170wrp.339.1667507152215;
        Thu, 03 Nov 2022 13:25:52 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c4ecc00b003b4fe03c881sm787946wmq.48.2022.11.03.13.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 13:25:51 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v7 1/2] dt-bindings: mfd: Add bindings for MAX5970 and MAX5978
Date:   Thu,  3 Nov 2022 21:25:47 +0100
Message-Id: <20221103202548.1921397-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221103202548.1921397-1-Naresh.Solanki@9elements.com>
References: <20221103202548.1921397-1-Naresh.Solanki@9elements.com>
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
 .../bindings/mfd/maxim,max5970.yaml           | 163 ++++++++++++++++++
 1 file changed, 163 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
new file mode 100644
index 000000000000..bf3db2484723
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
@@ -0,0 +1,163 @@
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
+      Properties for single channel.
+
+    patternProperties:
+      "^led@[0-3]$":
+        $ref: /schemas/leds/common.yaml#
+        type: object
+
+    additionalProperties: true
+
+  vss1-supply:
+    description: Supply of the first channel.
+
+  vss2-supply:
+    description: Supply of the first channel.
+
+  "#io-channel-cells":
+    const: 1
+
+  regulators:
+    type: object
+    description:
+      Properties for single channel.
+
+    patternProperties:
+      "^(sw[0-1])$":
+        $ref: /schemas/regulator/regulator.yaml#
+        type: object
+
+      shunt-resistor-micro-ohms:
+        description: |
+          The value of curent sense resistor in microohms.
+          Must be specified for each channel.
+
+    additionalProperties: true
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
+               sw0_ref_0: SW0 {
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
+                sw0_ref_1: SW0 {
+                    regulator-compatible = "SW0";
+                    shunt-resistor-micro-ohms = <12000>;
+                };
+                sw1_ref_1: SW1 {
+                    regulator-compatible = "SW1";
+                    shunt-resistor-micro-ohms = <10000>;
+                };
+            };
+        };
+    };
+...
-- 
2.37.3

