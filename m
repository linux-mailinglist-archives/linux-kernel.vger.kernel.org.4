Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC6E615E83
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiKBI5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiKBI5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:57:46 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857581D66F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:57:43 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bk15so23437422wrb.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 01:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPHDXBenpQy2nAswrRWBg2PHq6YhV0vGg41gmHXpPC8=;
        b=VW+EmARquWRj5bHCWN8loD6Bdyi+uhqfvSYeZBLQ1wjbiT3BydjhjxewKIkMJDWXOU
         wm0LVvILwahrJclM2AWhkeGZxF6V1qXA97M/z7cGq0VdfiwCuAq8wAA4DdSrwxN9PNzu
         h+ECqWJpM52nxcXpi8xQeM7gruxjIS0Zc0jhCW47PA9m5DJMtMUZF0gUx6LcwP0EerGA
         +qK3WSDOvG5LW/wWTHjQCXipcZgcEYYn1P1Jl9JrMTOr97ubzQ1y7FMTv8BZp6Jig8BY
         tXNW2BWZGBw1TXZaC/QVfUfIw80x4dczvR0+yPLEzJW+wlh6d8h1BqhRZvsZyIjiEzw8
         Sx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPHDXBenpQy2nAswrRWBg2PHq6YhV0vGg41gmHXpPC8=;
        b=RXUxoZrSot8OUeBJCQG4ZR5x8IF9TdMtK/hVp7wQmqTCzcxLCV9YKDwb8HMImYZDkk
         IWCptxisx629NsK5BSGvYojK5pRaZ2vt97mwRNNzF07T9qjwEifXDs51ncPJBJTmOgH0
         /7WnJmOS5oxqDd7dPNQV3hJQkDPkyYVHkr7R31Fd+Do/JxhePNhtTgLedR97ZukDoEyo
         vzGWNuzCV4aNE8fSYQr2Xv2HXvs8/X/KH00uTPmjZCe4xaq30sh38IdSC6UAQlBy9Vms
         Id9u/tIWUUAXbVicoxKLVoixRXFCGl6XTJGuL64oRtOtI7tCZiVpUkf92W7jTDUAyAfn
         nvqA==
X-Gm-Message-State: ACrzQf29ObtL9gEmIs3uAmK+09qemOqwAIbUpErSVyOlvdAz0DUKGBTC
        w+nUHeGY/mpAn8AssY1mRLAXfY36clW/a9nr
X-Google-Smtp-Source: AMsMyM45csnsoaH0ctG3J0aV46O95uf1MIsqptHaLwkVK4G6volSlAlrgLFWkWJYUEXPWUEtCSdGCQ==
X-Received: by 2002:adf:dd12:0:b0:236:6ef7:dacf with SMTP id a18-20020adfdd12000000b002366ef7dacfmr14117030wrm.204.1667379461881;
        Wed, 02 Nov 2022 01:57:41 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id j39-20020a05600c48a700b003b95ed78275sm1290176wmp.20.2022.11.02.01.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 01:57:41 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v5 1/2] dt-bindings: mfd: Add bindings for MAX5970 and MAX5978
Date:   Wed,  2 Nov 2022 09:57:36 +0100
Message-Id: <20221102085737.599100-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221102085737.599100-1-Naresh.Solanki@9elements.com>
References: <20221102085737.599100-1-Naresh.Solanki@9elements.com>
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

From: Marcello Sylvester Bauer <sylv@sylv.io>

The MAX597x is a hot swap controller with configurable fault protection.
It also has 10bit ADC for current & voltage measurements.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 .../devicetree/bindings/mfd/max5970.yaml      | 164 ++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/max5970.yaml

diff --git a/Documentation/devicetree/bindings/mfd/max5970.yaml b/Documentation/devicetree/bindings/mfd/max5970.yaml
new file mode 100644
index 000000000000..f5cd80c1a24a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/max5970.yaml
@@ -0,0 +1,164 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/max5970.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Regulator driver for MAX5970 smart switch from Maxim Integrated.
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
+            #address-cells = <1>;
+            #size-cells = <0>;
+            regulator@3a {
+                    reg = <0x3a>;
+                    vss1-supply = <&p3v3>;
+                    compatible = "maxim,max5978";
+
+                    regulators {
+                            sw0_ref_0: SW0 {
+                                   regulator-compatible = "SW0";
+                                   shunt-resistor-micro-ohms = <12000>;
+                            };
+                    };
+
+                    leds {
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+                        led@0 {
+                                reg = <0>;
+                                label = "led0";
+                                default-state = "on";
+                        };
+                        led@1 {
+                                reg = <1>;
+                                label = "led1";
+                                default-state = "on";
+                        };
+                    };
+            };
+    };
+
+  - |
+    i2c {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            regulator@3a {
+                    reg = <0x3a>;
+                    vss1-supply = <&p3v3>;
+                    vss2-supply = <&p5v>;
+                    compatible = "maxim,max5970";
+
+                    regulators {
+                            sw0_ref_1: SW0 {
+                                   regulator-compatible = "SW0";
+                                   shunt-resistor-micro-ohms = <12000>;
+                            };
+                            sw1_ref_1: SW1 {
+                                   regulator-compatible = "SW1";
+                                   shunt-resistor-micro-ohms = <10000>;
+                            };
+                    };
+            };
+    };
+...
-- 
2.37.3

