Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41F36004CC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 03:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiJQBWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 21:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJQBWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 21:22:31 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3215432BA4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 18:22:30 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id l28so6924593qtv.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 18:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3xWtiKYiQtvHStnfbfcGKHJ9sfPtgzrNeWbpbXy8qJ0=;
        b=lcoK6JfsyChYB9UMgN05QHgLqTH3ZHpA3/eaKycgyUHhMHIPct83Xp7tflPIQZRI5v
         lJRPfYEQKlN1n0SJOeobF4Qb+W+3KupomlWZU6JhT26CFf8NCFeB6KOFqylVRGopAKDw
         StIQBk7WPa0l8seqUevwl4emzDkg48qtwx18ZzMIeE2XDuu7KserilQ4cLGOzUQScDvh
         kbQxptAjtU3D+tMol6AA29TBxT4bRkeQUxmrh797hfe5gDKxQf+jvY3Je/W2UVH0mBwv
         +vzX7tNlNI5Yf80W8mARWcjqPXfwpGBt08exEsJrE9apkf2VJHpc8/iZyu917WQ4PkU5
         mg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xWtiKYiQtvHStnfbfcGKHJ9sfPtgzrNeWbpbXy8qJ0=;
        b=cNO3xEV+h7Y7DRWvTAKhitnoAjnwbE6KbdSzbMj9/GpTmHzo9OPOhzx8umOVSlvq+6
         QNbk7/fXEGJSR4XrBxwrpuAdpwH+tqZeXOPeO4P+jtH9lFGeUqhO+reJdnT5AyMm49nQ
         Q6AD7HJ/3NM+0jnHTeIem+wQoKfuPPxGilRzotD/ggXOYHqnz93lrgBUgRiI4za2qLYB
         e/4iEQR3tdTaS1M1NLp+l/MqyMc4bDtv3Pvi0jHl5aOZqsYTEymUaKXEVZaBf5k6GIzB
         ut81/V3791wK0IIRPQMnGdSf4C5yqCSr8oU0dwnQkfqd03s9JqYoQYVpsYEA30rvrDWP
         b81w==
X-Gm-Message-State: ACrzQf041OcSjfmtxcSqibmMd5vUJgUbUzrWegeQG2xx36GHbP8TTXdC
        9++klxvL94TepAuwYfcTJIWAtw==
X-Google-Smtp-Source: AMsMyM4Ttu+R1FuB4CyyggzkDpgbWYP8ZKsBFMVGMrmXqPjiREQ02N3P9Tyu+fSZn4pE8fB5sYunDg==
X-Received: by 2002:a05:622a:40f:b0:394:57eb:ced0 with SMTP id n15-20020a05622a040f00b0039457ebced0mr6907225qtx.225.1665969749316;
        Sun, 16 Oct 2022 18:22:29 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:bb7d:1aa4:bef8:ec27])
        by smtp.gmail.com with ESMTPSA id b13-20020ac87fcd000000b0039a610a04b1sm7011349qtk.37.2022.10.16.18.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 18:22:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: pinctrl: qcom,msm8974: convert to dtschema
Date:   Sun, 16 Oct 2022 21:22:24 -0400
Message-Id: <20221017012225.8579-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Convert Qualcomm MSM8974 pin controller bindings to DT schema.  Keep the
parsing of pin configuration subnodes consistent with other Qualcomm
schemas (children named with '-state' suffix, their children with
'-pins').

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,msm8974-pinctrl.txt | 121 ------------
 .../pinctrl/qcom,msm8974-pinctrl.yaml         | 179 ++++++++++++++++++
 2 files changed, 179 insertions(+), 121 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt
deleted file mode 100644
index 004056506679..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt
+++ /dev/null
@@ -1,121 +0,0 @@
-Qualcomm MSM8974 TLMM block
-
-Required properties:
-- compatible: "qcom,msm8974-pinctrl"
-- reg: Should be the base address and length of the TLMM block.
-- interrupts: Should be the parent IRQ of the TLMM block.
-- interrupt-controller: Marks the device node as an interrupt controller.
-- #interrupt-cells: Should be two.
-- gpio-controller: Marks the device node as a GPIO controller.
-- #gpio-cells : Should be two.
-                The first cell is the gpio pin number and the
-                second cell is used for optional parameters.
-- gpio-ranges: see ../gpio/gpio.txt
-
-Optional properties:
-
-- gpio-reserved-ranges: see ../gpio/gpio.txt
-
-Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
-a general description of GPIO and interrupt bindings.
-
-Please refer to pinctrl-bindings.txt in this directory for details of the
-common pinctrl bindings used by client devices, including the meaning of the
-phrase "pin configuration node".
-
-Qualcomm's pin configuration nodes act as a container for an arbitrary number of
-subnodes. Each of these subnodes represents some desired configuration for a
-pin, a group, or a list of pins or groups. This configuration can include the
-mux function to select on those pin(s)/group(s), and various pin configuration
-parameters, such as pull-up, drive strength, etc.
-
-The name of each subnode is not important; all subnodes should be enumerated
-and processed purely based on their content.
-
-Each subnode only affects those parameters that are explicitly listed. In
-other words, a subnode that lists a mux function but no pin configuration
-parameters implies no information about any pin configuration parameters.
-Similarly, a pin subnode that describes a pullup parameter implies no
-information about e.g. the mux function.
-
-
-The following generic properties as defined in pinctrl-bindings.txt are valid
-to specify in a pin configuration subnode:
- pins, function, bias-disable, bias-pull-down, bias-pull-up, drive-strength.
-
-Non-empty subnodes must specify the 'pins' property.
-Note that not all properties are valid for all pins.
-
-
-Valid values for pins are:
-  gpio0-gpio145
-    Supports mux, bias and drive-strength
-
-  sdc1_clk, sdc1_cmd, sdc1_data, sdc2_clk, sdc2_cmd, sdc2_data
-    Supports bias and drive-strength
-
-  hsic_data, hsic_strobe
-    Supports only mux
-
-Valid values for function are:
-  cci_i2c0, cci_i2c1, uim1, uim2, uim_batt_alarm,
-  blsp_uim1, blsp_uart1, blsp_i2c1, blsp_spi1,
-  blsp_uim2, blsp_uart2, blsp_i2c2, blsp_spi2,
-  blsp_uim3, blsp_uart3, blsp_i2c3, blsp_spi3,
-  blsp_uim4, blsp_uart4, blsp_i2c4, blsp_spi4,
-  blsp_uim5, blsp_uart5, blsp_i2c5, blsp_spi5,
-  blsp_uim6, blsp_uart6, blsp_i2c6, blsp_spi6,
-  blsp_uim7, blsp_uart7, blsp_i2c7, blsp_spi7,
-  blsp_uim8, blsp_uart8, blsp_i2c8, blsp_spi8,
-  blsp_uim9, blsp_uart9, blsp_i2c9, blsp_spi9,
-  blsp_uim10, blsp_uart10, blsp_i2c10, blsp_spi10,
-  blsp_uim11, blsp_uart11, blsp_i2c11, blsp_spi11,
-  blsp_uim12, blsp_uart12, blsp_i2c12, blsp_spi12,
-  blsp_spi1_cs1, blsp_spi2_cs2, blsp_spi_cs3, blsp_spi2_cs1, blsp_spi2_cs2
-  blsp_spi2_cs3, blsp_spi10_cs1, blsp_spi10_cs2, blsp_spi10_cs3,
-  sdc3, sdc4, gcc_gp_clk1, gcc_gp_clk2, gcc_gp_clk3, cci_timer0, cci_timer1,
-  cci_timer2, cci_timer3, cci_async_in0, cci_async_in1, cci_async_in2,
-  cam_mckl0, cam_mclk1, cam_mclk2, cam_mclk3, mdp_vsync, hdmi_cec, hdmi_ddc,
-  hdmi_hpd, edp_hpd, gp_pdm0, gp_pdm1, gp_pdm2, gp_pdm3, gp0_clk, gp1_clk,
-  gp_mn, tsif1, tsif2, hsic, grfc, audio_ref_clk, qua_mi2s, pri_mi2s, spkr_mi2s,
-  ter_mi2s, sec_mi2s, bt, fm, wlan, slimbus, hsic_ctl, gpio
-
-  (Note that this is not yet the complete list of functions)
-
-
-
-Example:
-
-	msmgpio: pinctrl@fd510000 {
-		compatible = "qcom,msm8974-pinctrl";
-		reg = <0xfd510000 0x4000>;
-
-		gpio-controller;
-		#gpio-cells = <2>;
-		gpio-ranges = <&msmgpio 0 0 146>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <0 208 0>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&uart2_default>;
-
-		uart2_default: uart2_default {
-			mux {
-				pins = "gpio4", "gpio5";
-				function = "blsp_uart2";
-			};
-
-			tx {
-				pins = "gpio4";
-				drive-strength = <4>;
-				bias-disable;
-			};
-
-			rx {
-				pins = "gpio5";
-				drive-strength = <2>;
-				bias-pull-up;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.yaml
new file mode 100644
index 000000000000..9287cbbff711
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.yaml
@@ -0,0 +1,179 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,msm8974-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm MSM8974 TLMM pin controller
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm MSM8974 SoC.
+
+properties:
+  compatible:
+    const: qcom,msm8974-pinctrl
+
+  reg:
+    maxItems: 1
+
+  interrupts: true
+  interrupt-controller: true
+  "#interrupt-cells": true
+  gpio-controller: true
+  "#gpio-cells": true
+  gpio-ranges: true
+  wakeup-parent: true
+
+  gpio-reserved-ranges:
+    minItems: 1
+    maxItems: 73
+
+  gpio-line-names:
+    maxItems: 146
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-msm8974-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-msm8974-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-msm8974-tlmm-state:
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          oneOf:
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-3][0-9]|14[0-5])$"
+            - enum: [ hsic_data, hsic_strobe, sdc1_clk, sdc1_cmd, sdc1_data,
+                      sdc2_clk, sdc2_cmd, sdc2_data ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+        enum: [ gpio, cci_i2c0, cci_i2c1, uim1, uim2, uim_batt_alarm,
+                blsp_uim1, blsp_uart1, blsp_i2c1, blsp_spi1, blsp_uim2,
+                blsp_uart2, blsp_i2c2, blsp_spi2, blsp_uim3, blsp_uart3,
+                blsp_i2c3, blsp_spi3, blsp_uim4, blsp_uart4, blsp_i2c4,
+                blsp_spi4, blsp_uim5, blsp_uart5, blsp_i2c5, blsp_spi5,
+                blsp_uim6, blsp_uart6, blsp_i2c6, blsp_spi6, blsp_uim7,
+                blsp_uart7, blsp_i2c7, blsp_spi7, blsp_uim8, blsp_uart8,
+                blsp_i2c8, blsp_spi8, blsp_uim9, blsp_uart9, blsp_i2c9,
+                blsp_spi9, blsp_uim10, blsp_uart10, blsp_i2c10, blsp_spi10,
+                blsp_uim11, blsp_uart11, blsp_i2c11, blsp_spi11, blsp_uim12,
+                blsp_uart12, blsp_i2c12, blsp_spi12, blsp_spi1_cs1,
+                blsp_spi2_cs2, blsp_spi_cs3, blsp_spi2_cs1, blsp_spi2_cs2
+                blsp_spi2_cs3, blsp_spi10_cs1, blsp_spi10_cs2, blsp_spi10_cs3,
+                sdc3, sdc4, gcc_gp_clk1, gcc_gp_clk2, gcc_gp_clk3, cci_timer0,
+                cci_timer1, cci_timer2, cci_timer3, cci_async_in0,
+                cci_async_in1, cci_async_in2, cam_mckl0, cam_mclk1, cam_mclk2,
+                cam_mclk3, mdp_vsync, hdmi_cec, hdmi_ddc, hdmi_hpd, edp_hpd,
+                gp_pdm0, gp_pdm1, gp_pdm2, gp_pdm3, gp0_clk, gp1_clk, gp_mn,
+                tsif1, tsif2, hsic, grfc, audio_ref_clk, qua_mi2s, pri_mi2s,
+                spkr_mi2s, ter_mi2s, sec_mi2s, bt, fm, wlan, slimbus, hsic_ctl ]
+
+      bias-pull-down: true
+      bias-pull-up: true
+      bias-disable: true
+      drive-strength: true
+      input-enable: true
+      output-high: true
+      output-low: true
+
+    required:
+      - pins
+
+    allOf:
+      - if:
+          properties:
+            pins:
+              contains:
+                enum:
+                  - hsic_data
+                  - hsic_strobe
+          required:
+            - pins
+        then:
+          properties:
+            bias-pull-down: false
+            bias-pull-up: false
+            bias-disable: false
+            drive-strength: false
+            input-enable: false
+            output-high: false
+            output-low: false
+
+    additionalProperties: false
+
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    tlmm: pinctrl@fd510000 {
+        compatible = "qcom,msm8974-pinctrl";
+        reg = <0xfd510000 0x4000>;
+        gpio-controller;
+        gpio-ranges = <&tlmm 0 0 146>;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+
+        sdc1-off-state {
+            clk-pins {
+                pins = "sdc1_clk";
+                bias-disable;
+                drive-strength = <2>;
+            };
+
+            cmd-pins {
+                pins = "sdc1_cmd";
+                bias-pull-up;
+                drive-strength = <2>;
+            };
+
+            data-pins {
+                pins = "sdc1_data";
+                bias-pull-up;
+                drive-strength = <2>;
+            };
+        };
+
+        blsp2-uart1-sleep-state {
+            pins = "gpio41", "gpio42", "gpio43", "gpio44";
+            function = "gpio";
+            drive-strength = <2>;
+            bias-pull-down;
+        };
+
+        hsic-state {
+            pins = "hsic_data", "hsic_strobe";
+        };
+    };
-- 
2.34.1

