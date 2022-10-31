Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310D2613F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJaUmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiJaUl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:41:58 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C973113E22
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:41:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id a14so17611300wru.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eddshc+TxD4X+o0YuSoxkETZc7MLSHkFPfgjCwFMvTg=;
        b=R6KJPLeCN4i2l3tv3zJOif7cocU5fM0952poMYA0sd23SzML8MHYEyDaysWInulEKP
         qvYUgwO8dLerAvPLPGCNpFYNJiQU3RoBbn653TWVXlOK219s9M1eyBLN92viGGhF/v27
         y2qgnDLPYCzRmG8ng5brZUcRwhxw9gMoRPtV6ED79hdmPz+Hdx4jGdhjUqNWL7W2kEme
         n9lamVPcr1XxId30Ejp5LAyBRqW5iV0UHwXLSGpJXa+2l0t4qEz7GMhZoGK0L5PLJfu9
         JkYjKFHIS++48GjJTeEnm6Lrsbyws1EvukiOFQe/GWoh0qHuZtodViXK6xPnNBp/ZIjO
         Tgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eddshc+TxD4X+o0YuSoxkETZc7MLSHkFPfgjCwFMvTg=;
        b=zdHUuiyg2qYX3R/l0dY9lj2z7c/9iJgz2eQnzTXyv5f0enrMkEsrg5dx0LU1oqi5nM
         F7EMDMXwAFB0DbCvWc7doST55C89mDxYMF38hkEXJoQxof/m6eeJ4zT5TUjKn/9+/br+
         TK9FLvnGuHNa70fjJsYsHSp/XPg+BMHn0IUXBMyL0OsSJC329XR9ihkZmbPzB8XZ5cj5
         UVsDf9BMnFdxo8WrQUO7yDAG0wL57xk4WRTtaWYI7jSXQT2SBhCsxY/v4MNy3TX0oVzn
         Q2CTyVKFhvwseX8tEx2I81apm4M7p8cww3JMNiGRLZivRtZVMUZbENuAsb9P39h7T2Ie
         Ri9w==
X-Gm-Message-State: ACrzQf1smoWwEDQjjSiqPRt9m510GWDf07+5JZ0CmIunzpYRjMENSvEK
        4fOp7ARNEKgAUcsv3g+iX/swr/af5PY7bkPm
X-Google-Smtp-Source: AMsMyM6crdIlNinOQ9l+ERcLuE45qfGFd+f5ZwVgeJzZicCL+Qw8byIGLAekKz86fqg8V0PSkIcPWA==
X-Received: by 2002:adf:f609:0:b0:236:680b:8c65 with SMTP id t9-20020adff609000000b00236680b8c65mr9750950wrp.615.1667248913118;
        Mon, 31 Oct 2022 13:41:53 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id s12-20020a5d6a8c000000b002364c77bcacsm8012939wru.38.2022.10.31.13.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:41:52 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v3 1/2] dt-bindings: mfd: Add bindings for MAX5970 and MAX5978
Date:   Mon, 31 Oct 2022 21:41:29 +0100
Message-Id: <20221031204129.1434059-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221031204129.1434059-1-Naresh.Solanki@9elements.com>
References: <20221031204129.1434059-1-Naresh.Solanki@9elements.com>
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
index 000000000000..a0cc6a7543b5
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
+  - $ref: /schemas/regulator/regulator.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - maxim,max5970
+    then:
+      properties:
+        vss2-supply:
+          description: Supply of the second channel.
+
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
+
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
+            leds {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                led@0 {
+                        reg = <0>;
+                        label = "led0";
+                        default-state = "on";
+                };
+                led@1 {
+                        reg = <1>;
+                        label = "led1";
+                        default-state = "on";
+                };
+            };
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

