Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5D369614F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjBNKrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjBNKrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:47:21 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AE6265A4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:46:56 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso13362178wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RtrS8mLtl7ssVBCGB2QEC8eHd7/s0+c6vonCW3UXCY=;
        b=Sd56QN/683Gm6kiGxEJPQo6AlA7w++n82g6sj+Vp4BLbozsYhCa3V91fS3bYREyhQj
         iEpNcDa44F/VkQ99GDfO3KZAmR8Z/GtGSiMt5kTXfA22MmufSzlZ/JbJq8e4TNIlB2CW
         iaYRhpAmpvqMqBh/OCtbmXWHjwvBUtND4pzrz3e8a/ms7xZKLxIJHYKCFseIV1qPMEbX
         Ckt7jqOBAGFAntw3NKGro8i/AKZBwEc0IlkcVRGtMBYs/kukq5uv54NhOGCYNi58Caa5
         lTamkC3Q16j5eKoSra/cNMHQ8qCopwV0PR5W930wZyO5SAcErmkNSEvP8flBiLORcmUA
         7WDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RtrS8mLtl7ssVBCGB2QEC8eHd7/s0+c6vonCW3UXCY=;
        b=lXlBNUHoI0MqAy5HAiePVWOY81fEuNk+uIzatYM3ols4A21HnoOUHJblPnVuZm501b
         xDG24+PnB2q4lzo+MArEA2BiA9JJY9QellxLO9yo9SFVQ+vBycWFwML6/MVyxRWW5T9J
         POOo8Pkw60WqIZ7VaNqfeybe3nkeUVCSlA5lc7Pho0g6cwx6rsYvsgXssTXQTsmrZm78
         AX3BP9jsvtWpmklSnI8MML4msIl7AUxdJ5DmS8R3kInAPPTKmQ1sHeazx00as3kk2tjG
         6/nMdqknApQ4LERQpwXbbJM0wBBZhUikNGKO/rO2QNb5ovGO+5seXH8oUIRXjnQolMq0
         q9lQ==
X-Gm-Message-State: AO0yUKVvTUJO1NSoK7SJwFdhjix79x0Fmr1HUWb5nrdcQWmwfqsoOdL8
        Y2grhPc/yXswlY65xPiplfw5FQ==
X-Google-Smtp-Source: AK7set8XEvIX3GQ95otgltYqMhXeZbfth1oddkGbdV1Nfp2cxKekmGsWwjTnrO7rGbXtElsO39eUsQ==
X-Received: by 2002:a05:600c:3416:b0:3dc:45a7:2b8a with SMTP id y22-20020a05600c341600b003dc45a72b8amr1566376wmp.10.1676371613805;
        Tue, 14 Feb 2023 02:46:53 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c4f5400b003e1f319b87bsm2623719wmq.24.2023.02.14.02.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 02:46:53 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/7] media: dt-bindings: i2c: samsung,s5k5baf: convert to dtschema
Date:   Tue, 14 Feb 2023 11:45:03 +0100
Message-Id: <20230214104508.51955-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230214104508.51955-1-krzysztof.kozlowski@linaro.org>
References: <20230214104508.51955-1-krzysztof.kozlowski@linaro.org>
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

Convert the Samsung S5K5BAF image sensor bindings to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/media/i2c/samsung,s5k5baf.yaml   | 101 ++++++++++++++++++
 .../bindings/media/samsung-s5k5baf.txt        |  58 ----------
 2 files changed, 101 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/samsung,s5k5baf.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/samsung-s5k5baf.txt

diff --git a/Documentation/devicetree/bindings/media/i2c/samsung,s5k5baf.yaml b/Documentation/devicetree/bindings/media/i2c/samsung,s5k5baf.yaml
new file mode 100644
index 000000000000..c8f2955e0825
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/samsung,s5k5baf.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/samsung,s5k5baf.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S5K5BAF UXGA 1/5" 2M CMOS Image Sensor with embedded SoC ISP
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+properties:
+  compatible:
+    const: samsung,s5k5baf
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: mclk
+
+  clock-frequency:
+    default: 24000000
+    description: mclk clock frequency
+
+  rstn-gpios:
+    maxItems: 1
+    description: RSTN pin
+
+  stbyn-gpios:
+    maxItems: 1
+    description: STDBYN pin
+
+  vdda-supply:
+    description: Analog power supply 2.8V (2.6V to 3.0V)
+
+  vddio-supply:
+    description: I/O power supply 1.8V (1.65V to 1.95V) or 2.8V (2.5V to 3.1V)
+
+  vddreg-supply:
+    description:
+      Regulator input power supply 1.8V (1.7V to 1.9V) or 2.8V (2.6V to 3.0)
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    additionalProperties: false
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          data-lanes:
+            items:
+              - const: 1
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - rstn-gpios
+  - stbyn-gpios
+  - vdda-supply
+  - vddio-supply
+  - vddreg-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        sensor@2d {
+            compatible = "samsung,s5k5baf";
+            reg = <0x2d>;
+            clocks = <&camera 0>;
+            clock-names = "mclk";
+            clock-frequency = <24000000>;
+            rstn-gpios = <&gpl2 1 GPIO_ACTIVE_LOW>;
+            stbyn-gpios = <&gpl2 0 GPIO_ACTIVE_LOW>;
+            vdda-supply = <&cam_io_en_reg>;
+            vddio-supply = <&vtcam_reg>;
+            vddreg-supply = <&vt_core_15v_reg>;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&csis1_ep>;
+                    data-lanes = <1>;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/media/samsung-s5k5baf.txt b/Documentation/devicetree/bindings/media/samsung-s5k5baf.txt
deleted file mode 100644
index 1f51e0439c96..000000000000
--- a/Documentation/devicetree/bindings/media/samsung-s5k5baf.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-Samsung S5K5BAF UXGA 1/5" 2M CMOS Image Sensor with embedded SoC ISP
---------------------------------------------------------------------
-
-Required properties:
-
-- compatible	  : "samsung,s5k5baf";
-- reg		  : I2C slave address of the sensor;
-- vdda-supply	  : analog power supply 2.8V (2.6V to 3.0V);
-- vddreg-supply	  : regulator input power supply 1.8V (1.7V to 1.9V)
-		    or 2.8V (2.6V to 3.0);
-- vddio-supply	  : I/O power supply 1.8V (1.65V to 1.95V)
-		    or 2.8V (2.5V to 3.1V);
-- stbyn-gpios	  : GPIO connected to STDBYN pin;
-- rstn-gpios	  : GPIO connected to RSTN pin;
-- clocks	  : list of phandle and clock specifier pairs
-		    according to common clock bindings for the
-		    clocks described in clock-names;
-- clock-names	  : should include "mclk" for the sensor's master clock;
-
-Optional properties:
-
-- clock-frequency : the frequency at which the "mclk" clock should be
-		    configured to operate, in Hz; if this property is not
-		    specified default 24 MHz value will be used.
-
-The device node should contain one 'port' child node with one child 'endpoint'
-node, according to the bindings defined in Documentation/devicetree/bindings/
-media/video-interfaces.txt. The following are properties specific to those
-nodes.
-
-endpoint node
--------------
-
-- data-lanes : (optional) specifies MIPI CSI-2 data lanes as covered in
-	       video-interfaces.txt. If present it should be <1> - the device
-	       supports only one data lane without re-mapping.
-
-Example:
-
-s5k5bafx@2d {
-	compatible = "samsung,s5k5baf";
-	reg = <0x2d>;
-	vdda-supply = <&cam_io_en_reg>;
-	vddreg-supply = <&vt_core_15v_reg>;
-	vddio-supply = <&vtcam_reg>;
-	stbyn-gpios = <&gpl2 0 1>;
-	rstn-gpios = <&gpl2 1 1>;
-	clock-names = "mclk";
-	clocks = <&clock_cam 0>;
-	clock-frequency = <24000000>;
-
-	port {
-		s5k5bafx_ep: endpoint {
-			remote-endpoint = <&csis1_ep>;
-			data-lanes = <1>;
-		};
-	};
-};
-- 
2.34.1

