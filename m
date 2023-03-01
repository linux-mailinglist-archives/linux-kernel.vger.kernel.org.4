Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CB66A6996
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCAJNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjCAJNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:13:21 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AFB4C2E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 01:12:56 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h11so715997wrm.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 01:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1677661971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WUPmhliitXmdULS7FNWdqBgJqWmIJnQg9y2FVhSFvHM=;
        b=EJSTTVirwvWvvzeST5d3o2yqpAthOAO+gB0vORl7BcrNwrTLt3l4Te5GrjM9N1FEQr
         nZH4vwttJAH6BnM4v2RdIujpQYWD4Dq/6oyuaP9CjYwXDqv+uUP+LO03WSydH00+KQWm
         pS4OO8dfAVtFrbGA2K/SoQjIMjcZ1eP3NihkrQBwjkI+j7jMOpNbUVs3GxwejFG3hoiZ
         Vi2Hw7pGdR8B6DC3sXlKX9DMjXdD0x3fdmE48BEtZo6LEm0nnW9SU92Qk3t/qhKAyEEv
         cYaNxl6vcx4yvkEXDINXz2kLYJY4JsQsyoqnDaGkxIJtMtcrkcAveJy5ljbZ/bFCwLqD
         QBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677661971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUPmhliitXmdULS7FNWdqBgJqWmIJnQg9y2FVhSFvHM=;
        b=mr9ZRP2GIe46TeNk5pxejKd825jbGKzdUsCcoX15tl6uwP9jCPe0qAo4KXZcIfHSnI
         YVBn1KeUHOkn+s3QCFBCI9yrpmWdM1P4u4vQYDlsYzMj6QKfOgIH4Mhqf38uiLSnG4cp
         hZPbFFzPI0tQxtjxNxXejx5Vkjj9djyQm0aJnkD57hEHhyWbDbgXNtw60Jiu6yfjb6pi
         SrWEYF022aCJ4l7Yy1AvFOUAHqeAFnOPyq2NeZKSTPr0nqPCK2QQulu+mAO86ZHaYzLJ
         3ZazpqCh2Hc7b/e5Y0EYMOdzIW82R4uzNBvDz4fGvLvsTFWtmvohXKEiViwYsbKGFI2a
         nKuw==
X-Gm-Message-State: AO0yUKW7X8VDnYthBQ7UwaWM4WIqA2XenVYBKRaLyMD4xcdyh3u8azAm
        QV5a8e7FDmeOTsbkEWJ/GFXVlQ==
X-Google-Smtp-Source: AK7set8kUCFn8TSvZslDBxsPVHnFmj9BoFgznJs2gpP17Y6dANqIOXWNBy0KECr+1X8DuAxQ3JHULw==
X-Received: by 2002:adf:ec47:0:b0:2c9:ee31:962a with SMTP id w7-20020adfec47000000b002c9ee31962amr4385782wrn.64.1677661971327;
        Wed, 01 Mar 2023 01:12:51 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id s8-20020a5d4ec8000000b002c704271b05sm12072232wrv.66.2023.03.01.01.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 01:12:51 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: mfd: Add MAX5970 and MAX5978
Date:   Wed,  1 Mar 2023 10:12:33 +0100
Message-Id: <20230301091234.3159953-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
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

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
Co-developed-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Co-developed-by: Naresh Solanki <Naresh.Solanki@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 .../bindings/mfd/maxim,max5970.yaml           | 151 ++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
new file mode 100644
index 000000000000..6ee269afdab2
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
@@ -0,0 +1,151 @@
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
+      Properties for both hot swap control/switch.
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
+        unevaluatedProperties: false
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
+                    shunt-resistor-micro-ohms = <12000>;
+                };
+                sw1_ref_1: sw1 {
+                    shunt-resistor-micro-ohms = <10000>;
+                };
+            };
+        };
+    };
+...

base-commit: 59c54c59974649b2e7bc92faae4a21e2b2408db2
-- 
2.39.1

