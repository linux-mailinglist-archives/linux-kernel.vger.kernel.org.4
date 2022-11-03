Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5316618AA2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 22:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiKCVeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 17:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiKCVed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:34:33 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3580205F7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 14:34:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bk15so4572398wrb.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 14:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/4+eXF8HpUTTm4kFgWKs+phL3AAN+t5ZDemm/5nRcY=;
        b=PrW+5YO0RqZuycpkoGoR7au2Gky5LVucJ5S5PjQpqvNXOEHXW3Xz+AxA5e9sVmISrj
         WJaLy6Rsp++C+JwD8FTp4eGzx1ZHUp2x1LhgtGcAkENl5QQXWCKkqVP1OcbgosQIS4va
         VOT5K0tWFR3HQ1lHW7tp4E7aAgj+twVdE2AlCC8fnxBVdHeVlekowm+KS9ZG6cIIbCE0
         wAnPRymqoyEWpwgh24cbvV3M9mXDDPmgjapfZ8chkG1FTXDkbW9oUqSdLbSiZ2unHQBI
         BWFKUk2PqVAQTfNoLkt39zBHbs6j0WcFDeR6tt5P9qO74om9SNfPvggN7+uvhZ9v89Z4
         2RyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/4+eXF8HpUTTm4kFgWKs+phL3AAN+t5ZDemm/5nRcY=;
        b=TOBnJQEToPW4l7PEoN7fVH6bVF613asWkfzYweF8HdOjMX2ax75DOZ2IqTUzWeVJrO
         oNV2aGRN+NCgp1QNk76AIECBUKNmSh4CJJiHyEjJ3Y9XU5oYdNdwQ9plIMG14wFou68u
         +V6ibWwTJ9J55QCeuCiYeFfTKZdjvo/eepEge/7p2aykmeO2rnYBgLjqimp67978Idpl
         t3IfqH4EjY4F9zL2UhIVXdBlxsDyxCfE6Ayz7wuHaN09OPWTjKbM2WT8mGuwdEWjqiGg
         LD7eY/0LBNRSSnirXxrWKA4yN+kCsWHu7GHgKhHI+ajlrQQZcvrRi5s6+LBJ/FB4lAY0
         x4iQ==
X-Gm-Message-State: ACrzQf1EJmdazUD2w2nu9Hr6dw+cEtZWfiE0WEpB8+S16VZ1S6L0h/Bn
        3zG4q+l/CJj6yYWHIjxtq99GYZq+AG770PyK
X-Google-Smtp-Source: AMsMyM7D4lkmsOJ8neYB3b1pQuPm4VYuEleyUd61sV9Kt3mtr2AzjuQ99iRjK/K7FtF/sI8cEhPvOA==
X-Received: by 2002:adf:ec0b:0:b0:236:d76e:273f with SMTP id x11-20020adfec0b000000b00236d76e273fmr14078688wrn.179.1667511270177;
        Thu, 03 Nov 2022 14:34:30 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id bq7-20020a5d5a07000000b0022e035a4e93sm1757027wrb.87.2022.11.03.14.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 14:34:29 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v8 1/2] dt-bindings: mfd: Add bindings for MAX5970 and MAX5978
Date:   Thu,  3 Nov 2022 22:34:24 +0100
Message-Id: <20221103213425.2474772-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221103213425.2474772-1-Naresh.Solanki@9elements.com>
References: <20221103213425.2474772-1-Naresh.Solanki@9elements.com>
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
 .../bindings/mfd/maxim,max5970.yaml           | 170 ++++++++++++++++++
 1 file changed, 170 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
new file mode 100644
index 000000000000..25079c518f68
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
@@ -0,0 +1,170 @@
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
+      "^(SW[0-1])$":
+        $ref: /schemas/regulator/regulator.yaml#
+        type: object
+
+      shunt-resistor-micro-ohms:
+        description: |
+          The value of curent sense resistor in microohms.
+          Must be specified for each channel.
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

