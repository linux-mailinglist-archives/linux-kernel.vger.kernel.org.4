Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639A7694640
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjBMMrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjBMMrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:47:45 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965D11ABED
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:47:43 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r2so12069434wrv.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eLcFHEy4OAQ/LfPqJOYEZwVyv3uhgcnS0r7pBqHMjn4=;
        b=kIVvxJJLExyr30QkBpe6ke48ysBtCQfmTzZImzK8g8CAqPha7OggKxgppcE8uk10rs
         ro6PiimmQ1dfQlgLR+IVWal9UySbJLFC1jReTPX0m0goSFEOTvD4hgbU9tdUgVXDhGFN
         SPi2Ng3xuDZrE/ierPav8/KyVvJ3xoIThP66eAiWKTa9yLVZtling22BJsnWgS5SQkzf
         JGHWRWWAfqScbXGWj03qNohaM8xDnh6Excd+trmxBDe5GfbRAS+QEC4NgPF34pmob3rM
         267TNZTQ6XJbUxGr5FMYtmcyd4wzV8766sTWYSefUXPk3z3GCwJR/lKS/rAM9kq48IiS
         A1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLcFHEy4OAQ/LfPqJOYEZwVyv3uhgcnS0r7pBqHMjn4=;
        b=pfyyAf2hfDt/jZ52ar4tk2MB/SwcnXiZxA8hSxkF9f0jhPkdCEPZ9ebl2+/2+i4KbF
         ZFTOnJZGxQ1c47YdU5mlYr/ftVyKgxki/c6fxU6dpJW9eVeXz+i1CC98nVpEU1nocitp
         V/+WUJlqrwpibk+0QLyU9XiJCiQX/MBXl19Ghx7kHwIt3Ap+Qf3+HELJYzVimpcs88wK
         NxZet3W1CExVj3CNcRT/42Co7Jb21qPCrpRGIOKZUTdiu7miVuPCnnDF1aG3/ICFxECY
         yOvCC2lpGL4zVWFPvmtDVvFYMpka050MMvVYKteVzp0dS8wk6dMJ3m6hEWs9BdtKrwF2
         LR9g==
X-Gm-Message-State: AO0yUKXhW3HbB2RaDpzYEVUVOod0UWjaZoMpYmm3GZmfvzNrMOTNKLtO
        ytrlnNrD7QLXSJx3Xkz4SJtnLA==
X-Google-Smtp-Source: AK7set/aQUal0zYqJ5uAzBmBkGz32U5mbohd3AC2v9m2jIBFo9prWb+fNeR0h3axJDHohOmUbMDxiQ==
X-Received: by 2002:a5d:4ed0:0:b0:2c5:55a1:4b2 with SMTP id s16-20020a5d4ed0000000b002c555a104b2mr3227592wrv.49.1676292462131;
        Mon, 13 Feb 2023 04:47:42 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a12-20020a5d508c000000b002c55ec7f661sm1119502wrt.5.2023.02.13.04.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 04:47:41 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] media: dt-bindings: samsung,s5c73m3: convert to dtschema
Date:   Mon, 13 Feb 2023 13:47:39 +0100
Message-Id: <20230213124739.34579-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Convert the Samsung S5C73M3 8Mp camera ISP bindings to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/media/samsung,s5c73m3.yaml       | 165 ++++++++++++++++++
 .../bindings/media/samsung-s5c73m3.txt        |  97 ----------
 MAINTAINERS                                   |   1 +
 3 files changed, 166 insertions(+), 97 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/samsung,s5c73m3.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/samsung-s5c73m3.txt

diff --git a/Documentation/devicetree/bindings/media/samsung,s5c73m3.yaml b/Documentation/devicetree/bindings/media/samsung,s5c73m3.yaml
new file mode 100644
index 000000000000..1b75390fdaac
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/samsung,s5c73m3.yaml
@@ -0,0 +1,165 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/samsung,s5c73m3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S5C73M3 8Mp camera ISP
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+
+description:
+  The S5C73M3 camera ISP supports MIPI CSI-2 and parallel (ITU-R BT.656)
+  video data busses. The I2C bus is the main control bus and additionally the
+  SPI bus is used, mostly for transferring the firmware to and from the
+  device. Two slave device nodes corresponding to these control bus
+  interfaces are required and should be placed under respective bus
+  controller nodes.
+
+properties:
+  compatible:
+    const: samsung,s5c73m3
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: cis_extclk
+
+  clock-frequency:
+    default: 24000000
+    description: cis_extclk clock frequency.
+
+  standby-gpios:
+    maxItems: 1
+    description: STANDBY pin.
+
+  vdda-supply:
+    description: Analog power supply (1.2V).
+
+  vdd-af-supply:
+    description: lens power supply (2.8V).
+
+  vddio-cis-supply:
+    description: CIS I/O power supply (1.2V to 1.8V).
+
+  vddio-host-supply:
+    description: Host I/O power supply (1.8V to 2.8V).
+
+  vdd-int-supply:
+    description: Digital power supply (1.2V).
+
+  vdd-reg-supply:
+    description: Regulator input power supply (2.8V).
+
+  xshutdown-gpios:
+    maxItems: 1
+    description: XSHUTDOWN pin.
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
+              - const: 2
+              - const: 3
+              - const: 4
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      required:
+        - spi-max-frequency
+    then:
+      properties:
+        # The SPI node is simplified firmware-transfer interface only
+        clocks: false
+        clock-names: false
+        standby-gpios: false
+        vdda-supply: false
+        vdd-af-supply: false
+        vddio-cis-supply: false
+        vddio-host-supply: false
+        vdd-int-supply: false
+        vdd-reg-supply: false
+        xshutdown-gpios: false
+        port: false
+    else:
+      required:
+        - clocks
+        - clock-names
+        - standby-gpios
+        - vdda-supply
+        - vdd-af-supply
+        - vddio-cis-supply
+        - vddio-host-supply
+        - vdd-int-supply
+        - vdd-reg-supply
+        - xshutdown-gpios
+        - port
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        image-sensor@3c {
+            compatible = "samsung,s5c73m3";
+            reg = <0x3c>;
+            clock-frequency = <24000000>;
+            clocks = <&camera 0>;
+            clock-names = "cis_extclk";
+            standby-gpios = <&gpm0 6 GPIO_ACTIVE_LOW>;
+            vdda-supply = <&cam_vdda_reg>;
+            vdd-af-supply = <&cam_af_reg>;
+            vddio-cis-supply = <&ldo9_reg>;
+            vddio-host-supply = <&ldo18_reg>;
+            vdd-int-supply = <&buck9_reg>;
+            vdd-reg-supply = <&cam_io_reg>;
+            xshutdown-gpios = <&gpf1 3 GPIO_ACTIVE_LOW>; /* ISP_RESET */
+
+            port {
+                s5c73m3_ep: endpoint {
+                    remote-endpoint = <&csis0_ep>;
+                    data-lanes = <1 2 3 4>;
+                };
+            };
+        };
+    };
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        image-sensor@0 {
+            compatible = "samsung,s5c73m3";
+            reg = <0>;
+            spi-max-frequency = <50000000>;
+            controller-data {
+                samsung,spi-feedback-delay = <2>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/media/samsung-s5c73m3.txt b/Documentation/devicetree/bindings/media/samsung-s5c73m3.txt
deleted file mode 100644
index f0ea9adad442..000000000000
--- a/Documentation/devicetree/bindings/media/samsung-s5c73m3.txt
+++ /dev/null
@@ -1,97 +0,0 @@
-Samsung S5C73M3 8Mp camera ISP
-------------------------------
-
-The S5C73M3 camera ISP supports MIPI CSI-2 and parallel (ITU-R BT.656) video
-data busses. The I2C bus is the main control bus and additionally the SPI bus
-is used, mostly for transferring the firmware to and from the device. Two
-slave device nodes corresponding to these control bus interfaces are required
-and should be placed under respective bus controller nodes.
-
-I2C slave device node
----------------------
-
-Required properties:
-
-- compatible	    : "samsung,s5c73m3";
-- reg		    : I2C slave address of the sensor;
-- vdd-int-supply    : digital power supply (1.2V);
-- vdda-supply	    : analog power supply (1.2V);
-- vdd-reg-supply    : regulator input power supply (2.8V);
-- vddio-host-supply : host I/O power supply (1.8V to 2.8V);
-- vddio-cis-supply  : CIS I/O power supply (1.2V to 1.8V);
-- vdd-af-supply     : lens power supply (2.8V);
-- xshutdown-gpios   : specifier of GPIO connected to the XSHUTDOWN pin;
-- standby-gpios     : specifier of GPIO connected to the STANDBY pin;
-- clocks	    : should contain list of phandle and clock specifier pairs
-		      according to common clock bindings for the clocks described
-		      in the clock-names property;
-- clock-names	    : should contain "cis_extclk" entry for the CIS_EXTCLK clock;
-
-Optional properties:
-
-- clock-frequency   : the frequency at which the "cis_extclk" clock should be
-		      configured to operate, in Hz; if this property is not
-		      specified default 24 MHz value will be used.
-
-The common video interfaces bindings (see video-interfaces.txt) should be used
-to specify link from the S5C73M3 to an external image data receiver. The S5C73M3
-device node should contain one 'port' child node with an 'endpoint' subnode for
-this purpose. The data link from a raw image sensor to the S5C73M3 can be
-similarly specified, but it is optional since the S5C73M3 ISP and a raw image
-sensor are usually inseparable and form a hybrid module.
-
-Following properties are valid for the endpoint node(s):
-
-endpoint subnode
-----------------
-
-- data-lanes : (optional) specifies MIPI CSI-2 data lanes as covered in
-  video-interfaces.txt. This sensor doesn't support data lane remapping
-  and physical lane indexes in subsequent elements of the array should
-  be only consecutive ascending values.
-
-SPI device node
----------------
-
-Required properties:
-
-- compatible	    : "samsung,s5c73m3";
-
-For more details see description of the SPI busses bindings
-(../spi/spi-bus.txt) and bindings of a specific bus controller.
-
-Example:
-
-i2c@138a000000 {
-	...
-	s5c73m3@3c {
-		compatible = "samsung,s5c73m3";
-		reg = <0x3c>;
-		vdd-int-supply = <&buck9_reg>;
-		vdda-supply = <&ldo17_reg>;
-		vdd-reg-supply = <&cam_io_reg>;
-		vddio-host-supply = <&ldo18_reg>;
-		vddio-cis-supply = <&ldo9_reg>;
-		vdd-af-supply = <&cam_af_reg>;
-		clock-frequency = <24000000>;
-		clocks = <&clk 0>;
-		clock-names = "cis_extclk";
-		xshutdown-gpios = <&gpf1 3 1>;
-		standby-gpios = <&gpm0 1 1>;
-		port {
-			s5c73m3_ep: endpoint {
-				remote-endpoint = <&csis0_ep>;
-				data-lanes = <1 2 3 4>;
-			};
-		};
-	};
-};
-
-spi@1392000 {
-	...
-	s5c73m3_spi: s5c73m3@0 {
-		compatible = "samsung,s5c73m3";
-		reg = <0>;
-		...
-	};
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index d9b9a95d2ce2..4cbe823f3545 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18449,6 +18449,7 @@ M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 M:	Andrzej Hajda <andrzej.hajda@intel.com>
 L:	linux-media@vger.kernel.org
 S:	Supported
+F:	Documentation/devicetree/bindings/media/samsung,s5c73m3.yaml
 F:	drivers/media/i2c/s5c73m3/*
 
 SAMSUNG S5K5BAF CAMERA DRIVER
-- 
2.34.1

