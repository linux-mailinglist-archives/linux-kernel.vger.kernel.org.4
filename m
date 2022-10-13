Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4C85FE21B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiJMSwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiJMSv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:51:59 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CC531353
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:49:53 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id j21so1026471qkk.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+5ejviSW1e1BolACcSJ3t7Mgl7Rb4IKc8CCXZiYNVE=;
        b=BcV6WVKxrbAyeQ0bPjOerI0zql8jG+g7ct43CHrC1DvqouSltgJBd03/DUX50FqUnL
         xC7Y1biZpsZ1dcgvPheM5dW5lFj6e0MSrzWcb0+vOHklIJOTR5vEy5FvGALMf7/QZuCs
         0yooDFpZESAsV8TbVKwWL+GZs4ri8wcSeWe4EJmDGnBnFmzpew0EecXd5gJTFmfun2i3
         85HtO8jvEjYXLUoavvyd8RlBWKgzdrwrh6I0duE9Do8uSnwJhnSnSpTrXYqN2KHM7kip
         A9chY8gBSLdz+NBCI4JajkKxWdABaicL1NLaV16EvwSYijsYoBa1GhJL5BnZa8AXht6J
         CtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+5ejviSW1e1BolACcSJ3t7Mgl7Rb4IKc8CCXZiYNVE=;
        b=jvPyz3oah0NmFCAOKUcHLFJEI6tf8mh0dB1KpvMjTrwB9QnffYTJaXWLiOG01PzBUJ
         iEivdtHHGArMiEVG/0LSym8sR+3fj4pkMwcir01FH8OiXD1nS3h8+H+fCQNMZ1ePoqA7
         +0/38CB6qJ37GlVhnVnkHKR1/50u9YGPSyVWvLrwyN+CGhayxBjC7pMGhemZB6fgWgpe
         HH/a8tMd2wihigkKnJvfIRdsj+FDXjmXJCJ0L8H5mpFSvKvHeUrTtE4SIx9nVHj+Eelc
         93iaxmwhvK4sRIyA4t+lHNNevivC1eZJx9ZoAFAT94M+xy7VvAFOnwbpWTUxb1oqVm1a
         jkOg==
X-Gm-Message-State: ACrzQf2WDVElihbSF2PfzNA9K/+mVKAPv7p1Jwxf2qgVnCVuymjtxqQt
        /DDZ78YJ0p0TB93JLw/tbswglA==
X-Google-Smtp-Source: AMsMyM5EIkwWFDB6IY+qSczU1M4rEZ79sEpY6kD21sl3UzUvAoUoi2dN+zN2Iq06oU1df8iaEf2iJA==
X-Received: by 2002:a37:6807:0:b0:6ec:5212:59ee with SMTP id d7-20020a376807000000b006ec521259eemr1030605qkc.216.1665686947378;
        Thu, 13 Oct 2022 11:49:07 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a430600b006e16dcf99c8sm400748qko.71.2022.10.13.11.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:49:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH v2 3/3] dt-bindings: pinctrl: qcom,sc7180: convert to dtschema
Date:   Thu, 13 Oct 2022 14:47:00 -0400
Message-Id: <20221013184700.87260-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013184700.87260-1-krzysztof.kozlowski@linaro.org>
References: <20221013184700.87260-1-krzysztof.kozlowski@linaro.org>
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

Convert Qualcomm SC7180 pin controller bindings to DT schema.  Keep the
parsing of pin configuration subnodes consistent with other Qualcomm
schemas (children named with '-state' suffix, their children with
'-pins').

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Drop default:2 for drive strength
2. Add Rb tag.

Cc: Doug Anderson <dianders@chromium.org>
---
 .../bindings/pinctrl/qcom,sc7180-pinctrl.txt  | 187 ------------------
 .../bindings/pinctrl/qcom,sc7180-pinctrl.yaml | 162 +++++++++++++++
 2 files changed, 162 insertions(+), 187 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.txt
deleted file mode 100644
index 6ffeac9801df..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.txt
+++ /dev/null
@@ -1,187 +0,0 @@
-Qualcomm Technologies, Inc. SC7180 TLMM block
-
-This binding describes the Top Level Mode Multiplexer block found in the
-SC7180 platform.
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be "qcom,sc7180-pinctrl"
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: the base address and size of the north, south and west
-		    TLMM tiles
-
-- reg-names:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: names for the cells of reg, must contain "north", "south"
-		    and "west".
-
-- interrupts:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: should specify the TLMM summary IRQ.
-
-- interrupt-controller:
-	Usage: required
-	Value type: <none>
-	Definition: identifies this node as an interrupt controller
-
-- #interrupt-cells:
-	Usage: required
-	Value type: <u32>
-	Definition: must be 2. Specifying the pin number and flags, as defined
-		    in <dt-bindings/interrupt-controller/irq.h>
-
-- gpio-controller:
-	Usage: required
-	Value type: <none>
-	Definition: identifies this node as a gpio controller
-
-- #gpio-cells:
-	Usage: required
-	Value type: <u32>
-	Definition: must be 2. Specifying the pin number and flags, as defined
-		    in <dt-bindings/gpio/gpio.h>
-
-- gpio-ranges:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition:  see ../gpio/gpio.txt
-
-- gpio-reserved-ranges:
-	Usage: optional
-	Value type: <prop-encoded-array>
-	Definition: see ../gpio/gpio.txt
-
-Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
-a general description of GPIO and interrupt bindings.
-
-Please refer to pinctrl-bindings.txt in this directory for details of the
-common pinctrl bindings used by client devices, including the meaning of the
-phrase "pin configuration node".
-
-The pin configuration nodes act as a container for an arbitrary number of
-subnodes. Each of these subnodes represents some desired configuration for a
-pin, a group, or a list of pins or groups. This configuration can include the
-mux function to select on those pin(s)/group(s), and various pin configuration
-parameters, such as pull-up, drive strength, etc.
-
-
-PIN CONFIGURATION NODES:
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
-
-- pins:
-	Usage: required
-	Value type: <string-array>
-	Definition: List of gpio pins affected by the properties specified in
-		    this subnode.
-
-		    Valid pins are:
-		      gpio0-gpio118
-		        Supports mux, bias and drive-strength
-
-		      sdc1_clk, sdc1_cmd, sdc1_data sdc2_clk, sdc2_cmd,
-		      sdc2_data sdc1_rclk
-		        Supports bias and drive-strength
-
-		      ufs_reset
-			Supports bias and drive-strength
-
-- function:
-	Usage: required
-	Value type: <string>
-	Definition: Specify the alternative function to be configured for the
-		    specified pins. Functions are only valid for gpio pins.
-		    Valid values are:
-
-		    adsp_ext, agera_pll, aoss_cti, atest_char, atest_char0,
-		    atest_char1, atest_char2, atest_char3, atest_tsens,
-		    atest_tsens2, atest_usb1, atest_usb10, atest_usb11,
-		    atest_usb12, atest_usb13, atest_usb2, atest_usb20,
-		    atest_usb21, atest_usb22, atest_usb23, audio_ref,
-		    btfm_slimbus, cam_mclk, cci_async, cci_i2c, cci_timer0,
-		    cci_timer1, cci_timer2, cci_timer3, cci_timer4,
-		    cri_trng, dbg_out, ddr_bist, ddr_pxi0, ddr_pxi1,
-		    ddr_pxi2, ddr_pxi3, dp_hot, edp_lcd, gcc_gp1, gcc_gp2,
-		    gcc_gp3, gpio, gp_pdm0, gp_pdm1, gp_pdm2, gps_tx,
-		    jitter_bist, ldo_en, ldo_update, lpass_ext, mdp_vsync,
-		    mdp_vsync0, mdp_vsync1, mdp_vsync2, mdp_vsync3, mi2s_0,
-		    mi2s_1, mi2s_2, mss_lte, m_voc, pa_indicator, phase_flag,
-		    PLL_BIST, pll_bypassnl, pll_reset, prng_rosc, qdss,
-		    qdss_cti, qlink_enable, qlink_request, qspi_clk, qspi_cs,
-		    qspi_data, qup00, qup01, qup02_i2c, qup02_uart, qup03,
-		    qup04_i2c, qup04_uart, qup05, qup10, qup11_i2c, qup11_uart,
-		    qup12, qup13_i2c, qup13_uart, qup14, qup15, sdc1_tb,
-		    sdc2_tb, sd_write, sp_cmu, tgu_ch0, tgu_ch1, tgu_ch2,
-		    tgu_ch3, tsense_pwm1, tsense_pwm2, uim1, uim2, uim_batt,
-		    usb_phy, vfr_1, _V_GPIO, _V_PPS_IN, _V_PPS_OUT,
-		    vsense_trigger, wlan1_adc0, wlan1_adc1, wlan2_adc0,
-		    wlan2_adc1,
-
-- bias-disable:
-	Usage: optional
-	Value type: <none>
-	Definition: The specified pins should be configured as no pull.
-
-- bias-pull-down:
-	Usage: optional
-	Value type: <none>
-	Definition: The specified pins should be configured as pull down.
-
-- bias-pull-up:
-	Usage: optional
-	Value type: <none>
-	Definition: The specified pins should be configured as pull up.
-
-- output-high:
-	Usage: optional
-	Value type: <none>
-	Definition: The specified pins are configured in output mode, driven
-		    high.
-		    Not valid for sdc pins.
-
-- output-low:
-	Usage: optional
-	Value type: <none>
-	Definition: The specified pins are configured in output mode, driven
-		    low.
-		    Not valid for sdc pins.
-
-- drive-strength:
-	Usage: optional
-	Value type: <u32>
-	Definition: Selects the drive strength for the specified pins, in mA.
-		    Valid values are: 2, 4, 6, 8, 10, 12, 14 and 16
-
-Example:
-
-	tlmm: pinctrl@3500000 {
-		compatible = "qcom,sc7180-pinctrl";
-		reg = <0x3500000 0x300000>,
-		      <0x3900000 0x300000>,
-		      <0x3D00000 0x300000>;
-		reg-names = "west", "north", "south";
-		interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		gpio-ranges = <&tlmm 0 0 119>;
-		gpio-reserved-ranges = <0 4>, <106 4>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-	};
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml
new file mode 100644
index 000000000000..464f1031d15d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml
@@ -0,0 +1,162 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,sc7180-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SC7180 TLMM pin controller
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm SC7180 SoC.
+
+properties:
+  compatible:
+    const: qcom,sc7180-pinctrl
+
+  reg:
+    maxItems: 3
+
+  reg-names:
+    items:
+      - const: west
+      - const: north
+      - const: south
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
+    maxItems: 60
+
+  gpio-line-names:
+    maxItems: 119
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-sc7180-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-sc7180-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-sc7180-tlmm-state:
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
+            - pattern: "^gpio([0-9]|[1-9][0-9]|10[0-9]|11[0-8])$"
+            - enum: [ sdc1_rclk, sdc1_clk, sdc1_cmd, sdc1_data, sdc2_clk,
+                      sdc2_cmd, sdc2_data, ufs_reset ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+        enum: [ adsp_ext, agera_pll, aoss_cti, atest_char, atest_char0,
+                atest_char1, atest_char2, atest_char3, atest_tsens,
+                atest_tsens2, atest_usb1, atest_usb10, atest_usb11,
+                atest_usb12, atest_usb13, atest_usb2, atest_usb20, atest_usb21,
+                atest_usb22, atest_usb23, audio_ref, btfm_slimbus, cam_mclk,
+                cci_async, cci_i2c, cci_timer0, cci_timer1, cci_timer2,
+                cci_timer3, cci_timer4, cri_trng, dbg_out, ddr_bist, ddr_pxi0,
+                ddr_pxi1, ddr_pxi2, ddr_pxi3, dp_hot, edp_lcd, gcc_gp1,
+                gcc_gp2, gcc_gp3, gpio, gp_pdm0, gp_pdm1, gp_pdm2, gps_tx,
+                jitter_bist, ldo_en, ldo_update, lpass_ext, mdp_vsync,
+                mdp_vsync0, mdp_vsync1, mdp_vsync2, mdp_vsync3, mi2s_0, mi2s_1,
+                mi2s_2, mss_lte, m_voc, pa_indicator, phase_flag, PLL_BIST,
+                pll_bypassnl, pll_reset, prng_rosc, qdss, qdss_cti,
+                qlink_enable, qlink_request, qspi_clk, qspi_cs, qspi_data,
+                qup00, qup01, qup02_i2c, qup02_uart, qup03, qup04_i2c,
+                qup04_uart, qup05, qup10, qup11_i2c, qup11_uart, qup12,
+                qup13_i2c, qup13_uart, qup14, qup15, sdc1_tb, sdc2_tb,
+                sd_write, sp_cmu, tgu_ch0, tgu_ch1, tgu_ch2, tgu_ch3,
+                tsense_pwm1, tsense_pwm2, uim1, uim2, uim_batt, usb_phy, vfr_1,
+                _V_GPIO, _V_PPS_IN, _V_PPS_OUT, vsense_trigger, wlan1_adc0,
+                wlan1_adc1, wlan2_adc0, wlan2_adc1 ]
+
+      drive-strength:
+        enum: [2, 4, 6, 8, 10, 12, 14, 16]
+        description:
+          Selects the drive strength for the specified pins, in mA.
+
+      bias-pull-down: true
+      bias-pull-up: true
+      bias-disable: true
+      input-enable: true
+      output-high: true
+      output-low: true
+
+    required:
+      - pins
+
+    additionalProperties: false
+
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    tlmm: pinctrl@3500000 {
+        compatible = "qcom,sc7180-pinctrl";
+        reg = <0x03500000 0x300000>,
+              <0x03900000 0x300000>,
+              <0x03d00000 0x300000>;
+        reg-names = "west", "north", "south";
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 120>;
+        wakeup-parent = <&pdc>;
+
+        dp_hot_plug_det: dp-hot-plug-det-state {
+            pins = "gpio117";
+            function = "dp_hot";
+        };
+
+        qup_spi11_cs_gpio: qup-spi11-cs-gpio-state {
+            spi-pins {
+                pins = "gpio53", "gpio54", "gpio55";
+                function = "qup15";
+            };
+
+            cs-pins {
+                pins = "gpio56";
+                function = "gpio";
+            };
+        };
+    };
-- 
2.34.1

