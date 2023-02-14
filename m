Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7390A696166
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjBNKr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbjBNKr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:47:29 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A4E2685D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:47:05 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l21-20020a05600c1d1500b003dfe462b7e4so916273wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRtfH3cTciqqpmtap5y0tTTb3f6l4rz/TOKfQGaPBOI=;
        b=Fd6KsWetHyj27LAx7SBYAxUB8cV0XhaebZbaKubDdWIq1K2BHBVUHCwxJiBcn463/H
         PNsnouToUjloSXczi8+t/PhUD1kGfyvMkpcPF0sh41FudW03eqiy8/nbxSURxwt92H3I
         k5lDde6jcVpsN+WKfDRaM0Vhsciebsbo6N4Fsc2RYsCzo4MY1GVv0CCqhOOkHY97JZK9
         R3zydVAp/PhukA7au4LD13P19Z4eDQ7CC0omRbvrTgcPUkGV7b17CUek8MY/+2A3HqZp
         oWFIlPb0UTpPej0piBpq1CUPvHlI1nq0dcsyoq3gw/uprSQwk27BVNxsPmzTnrfwkv49
         baaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRtfH3cTciqqpmtap5y0tTTb3f6l4rz/TOKfQGaPBOI=;
        b=h3mzm4bZQYeHdw40xPoqfs+HrogyuF2JvU4APyR0btUMkFdwr/1ByFuFrj+3P2031g
         M0TUpT4Ft9fcWXxCk4rgngNWlM+XIxS6QG0t+b1/6MWeFFBYcKluOTzAhiJP11yRshAZ
         KlnHQI42FlBGBdolJ15SpPmtbWgaHw6CfVT2NVqF7aLV5xz1LmWMvQsikJJ7+sGmhFga
         oCvzbnMzSvgZaUUNVI2lUlZRdtg+LUOKB+C4eGvYyI6AqNL95rGya6DwpkCxsqqjqUmk
         dY7Edx0WX+8axGTS9nP1XV4buLULO2ZgFSBrNh+xWYlGV753EVg68crUbBNhZ2Q1hw/C
         RLZg==
X-Gm-Message-State: AO0yUKWJyKBOC2Y2Etb+bKw+TC9v2/6JqqPUIlAiUPN0eH1iNBsiLLA1
        7emrdnmV4a4E9TQG+eX0mMDrNg==
X-Google-Smtp-Source: AK7set9GFkMXNPFLC4MLlFBUpcMtH438Rv01TFTzVVUZFFFUaPGN01xARZZvMYtIcX+loV0ppglsBA==
X-Received: by 2002:a05:600c:4b28:b0:3df:ee44:e45a with SMTP id i40-20020a05600c4b2800b003dfee44e45amr1659201wmp.15.1676371621706;
        Tue, 14 Feb 2023 02:47:01 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c4f5400b003e1f319b87bsm2623719wmq.24.2023.02.14.02.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 02:47:01 -0800 (PST)
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
Subject: [PATCH v2 7/7] media: dt-bindings: samsung,s5c73m3: convert to dtschema
Date:   Tue, 14 Feb 2023 11:45:08 +0100
Message-Id: <20230214104508.51955-8-krzysztof.kozlowski@linaro.org>
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
index 87140ebb9a40..9bb777760964 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18441,6 +18441,7 @@ M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 M:	Andrzej Hajda <andrzej.hajda@intel.com>
 L:	linux-media@vger.kernel.org
 S:	Supported
+F:	Documentation/devicetree/bindings/media/samsung,s5c73m3.yaml
 F:	drivers/media/i2c/s5c73m3/*
 
 SAMSUNG S5K5BAF CAMERA DRIVER
-- 
2.34.1

