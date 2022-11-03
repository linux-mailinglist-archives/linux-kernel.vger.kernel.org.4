Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08A4617851
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 09:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiKCIGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 04:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiKCIFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:05:54 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0CA6331
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 01:05:53 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso2733259wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 01:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZ0nurQiHwcmABVhZQ6fsJaRCHN3DbbSn9QOwvJTur8=;
        b=O2CjI+o8KTh80XPnG2VKHVxJIg75vzxuPVm3sbmGlo09EzKo+m6cjOyCMDk4R9lNza
         5xPQL+fVPHViwqpjpQTyKUPr+idUmO/lXCG3p4tYp7byU4BDo5AuvnlMZnkmup/AwO7/
         HLMmvA0x9GvKRlMsLOvubLxNlsSoeWr+1jI3964RIoabC+6QNQxWVRDFa04ODAU8EPdE
         0I0qhJEQ779aZT+xOcmjXY9mXg8GoA4aDzF5XGAIMZ9hYPIPI5f4ZcBjY32r99u+ZcrS
         PGf6jLPkxSjWkp9iMVen1faZYJaaA6r3Sqyc3ZNWdyJ6M133AONBUVc4RGBgd7BWuIUU
         O56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZ0nurQiHwcmABVhZQ6fsJaRCHN3DbbSn9QOwvJTur8=;
        b=cWvByaB9esW7vvoRTSwwCJXVsP3kfbqQc5HWK4mOf7eYEFzkOsFMZyLqvDSYMEWNI6
         ZsN+pdtvoLPmT9f/492OxM+y0MqdkSt/kdFBRvsSOfsBTF4sX/FE8l27H6V2y8mqwhYI
         JIQy8GlIf2cC+Xnam3z40X4tFPlsq3KQavmbSJ+xRIrFJl7xhsfvEZCsrTkztbLltmSi
         jAMTFgzJzR4dKpf0hFUfcHbReTMYJT/ZPNPP3gcs+WG0LIPUNm/H56jJRnFDnzdvSaFp
         PRa6tHRiiHonC+bjckDGIqlBxuaj+R6yhZvolHi8PpFvBVondZFpJfYGggetUAymn6gx
         mBeA==
X-Gm-Message-State: ACrzQf2eU7KMs57SZVF6nOwR4O1t1YcuVhRx4hGmPomTACGI+ATJmSqm
        3V9dKvamIclv/7who+EP439nTn4iu4o0JL/E
X-Google-Smtp-Source: AMsMyM6XqZ59cL0KPhIZvQi5ku5wZXLvRYZaPrxQHSNLZUx5/twa0U1ZjJriiEJjqOts7pcx1S+2MA==
X-Received: by 2002:a05:600c:474a:b0:3c8:3299:5ba9 with SMTP id w10-20020a05600c474a00b003c832995ba9mr18798400wmo.3.1667462751296;
        Thu, 03 Nov 2022 01:05:51 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c424900b003bfaba19a8fsm402772wmm.35.2022.11.03.01.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 01:05:50 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v6 1/2] dt-bindings: mfd: Add bindings for MAX5970 and MAX5978
Date:   Thu,  3 Nov 2022 09:05:44 +0100
Message-Id: <20221103080545.1400424-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221103080545.1400424-1-Naresh.Solanki@9elements.com>
References: <20221103080545.1400424-1-Naresh.Solanki@9elements.com>
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
 .../bindings/mfd/maxim,max5970.yaml           | 164 ++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
new file mode 100644
index 000000000000..fc9d6d3647b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
@@ -0,0 +1,164 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/max5970.yaml#
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

