Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534B45FBB06
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiJKTFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJKTEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:04:50 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F99DDFC8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:04:44 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id de14so9557200qvb.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbkVNqEg2TKcacSnEXXZZ8u5iovslVk+ID5guDolyD8=;
        b=FBGKq1pNQZzXz6lEX8X1m13Nm3NmD/Qa8AdFDPWpIyeqkOUKa2C91Se8GAJYjKe7Rr
         cagfe+l5/E7DOwSnhXxZ0i7RShaaolbDTyJLAHVHTHB6Bk+/1vDoe5SPsZgHG51px5UV
         oBKuIMwib+4e+VD9cxDCVyui/k5c6eeV26qLS4Wn71c4gVwtinOkObIlUYfoM8S2HskX
         52mQSdZ4TKlNuPBpseCx4e6iCR+ICpV1MkkkQWzSzsJGE76TMjrEPvd9TSx90z8Eme3I
         1L73iD40Lm4fGv1SrG905VNOTHYRaPXUpvVZiCIz5IUeZGjy4JQtJCL/5koBl0ZqC60y
         7nNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbkVNqEg2TKcacSnEXXZZ8u5iovslVk+ID5guDolyD8=;
        b=JC8z4vFYo3vqueyPy7TmTVG9/6J6ttKX0aWIsSo+Pm/GBFRe6YVKveP/EbO4tKAJrL
         lNXxVBP5TAFGczn/8skxTMdY5CNIsh80eW+2W6zpMVz/JjRr9Dbk4Srl3tZdFadzlBp6
         Y33zVXpdBcW9WWWwo8DUx9Wofe+cq93H3PNIEtUZuCcT6b5CW+iTzuHp+L8QIIghS1zO
         r78VKTCQYXciQqes7rljQnXZ8ZI5MiPE0fTx2tQpVio5cYu2afvatL6boKEXOvX9A63/
         VtnzdsISSxeUuRuBI0n4p2kGlrVHJfpz/1ncEWNW0vrJSuvHGJF7puBnBPNfe4XEkOj5
         9fMA==
X-Gm-Message-State: ACrzQf0MHfHbRRv3beGsorZ582X+uk2C7wfZe7EyiS4GL8AbdJGdgzqI
        YHLnMs2kaYrHAtAzmaJIsMCCjg==
X-Google-Smtp-Source: AMsMyM7WyGx/XBWirqYaLcvYx8uBFIDkzFUDnWkPuIIHqQU78552BIOk5wvnuD5aeigSBNW4lCogsA==
X-Received: by 2002:a0c:f20f:0:b0:4b1:b8f0:d1bb with SMTP id h15-20020a0cf20f000000b004b1b8f0d1bbmr19959140qvk.30.1665515082883;
        Tue, 11 Oct 2022 12:04:42 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id i14-20020a05620a248e00b006bba46e5eeasm14527185qkn.37.2022.10.11.12.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 12:04:41 -0700 (PDT)
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
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 4/4] dt-bindings: pinctrl: qcom,sdm630: convert to dtschema
Date:   Tue, 11 Oct 2022 15:02:31 -0400
Message-Id: <20221011190231.76784-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011190231.76784-1-krzysztof.kozlowski@linaro.org>
References: <20221011190231.76784-1-krzysztof.kozlowski@linaro.org>
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

Convert Qualcomm SDM630 and SDM660 pin controller bindings to DT schema.
Keep the parsing of pin configuration subnodes consistent with other
Qualcomm schemas (children named with '-state' suffix, their children
with '-pins').

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Add tags.
2. Adjust a bit bindings description to match other bindings.
3. Add tlmm label to example, because it is used in gpio-ranges.
---
 .../bindings/pinctrl/qcom,sdm630-pinctrl.yaml | 188 +++++++++++++++++
 .../bindings/pinctrl/qcom,sdm660-pinctrl.txt  | 191 ------------------
 2 files changed, 188 insertions(+), 191 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml
new file mode 100644
index 000000000000..bd4fd8404aa4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml
@@ -0,0 +1,188 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,sdm630-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SDM630 and SDM660 TLMM pin controller
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm SDM630 and SDM660 SoC.
+
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,sdm630-pinctrl
+      - qcom,sdm660-pinctrl
+
+  reg:
+    maxItems: 3
+
+  reg-names:
+    items:
+      - const: south
+      - const: center
+      - const: north
+
+  interrupts: true
+  interrupt-controller: true
+  "#interrupt-cells": true
+  gpio-controller: true
+
+  gpio-reserved-ranges:
+    minItems: 1
+    maxItems: 57
+
+  gpio-line-names:
+    maxItems: 114
+
+  "#gpio-cells": true
+  gpio-ranges: true
+  wakeup-parent: true
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-sdm630-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-sdm630-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-sdm630-tlmm-state:
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
+            - pattern: "^gpio([0-9]|[1-9][0-9]|10[0-9]|11[0-3])$"
+            - enum: [ sdc1_clk, sdc1_cmd, sdc1_data, sdc1_rclk, sdc2_clk,
+                      sdc2_cmd, sdc2_data ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+        enum: [ adsp_ext, agera_pll, atest_char, atest_char0, atest_char1,
+                atest_char2, atest_char3, atest_gpsadc0, atest_gpsadc1,
+                atest_tsens, atest_tsens2, atest_usb1, atest_usb10,
+                atest_usb11, atest_usb12, atest_usb13, atest_usb2, atest_usb20,
+                atest_usb21, atest_usb22, atest_usb23, audio_ref, bimc_dte0,
+                bimc_dte1, blsp_i2c1, blsp_i2c2, blsp_i2c3, blsp_i2c4,
+                blsp_i2c5, blsp_i2c6, blsp_i2c7, blsp_i2c8_a, blsp_i2c8_b,
+                blsp_spi1, blsp_spi2, blsp_spi3, blsp_spi3_cs1, blsp_spi3_cs2,
+                blsp_spi4, blsp_spi5, blsp_spi6, blsp_spi7, blsp_spi8_a,
+                blsp_spi8_b, blsp_spi8_cs1, blsp_spi8_cs2, blsp_uart1,
+                blsp_uart2, blsp_uart5, blsp_uart6_a, blsp_uart6_b, blsp_uim1,
+                blsp_uim2, blsp_uim5, blsp_uim6, cam_mclk, cci_async, cci_i2c,
+                cri_trng, cri_trng0, cri_trng1, dbg_out, ddr_bist, gcc_gp1,
+                gcc_gp2, gcc_gp3, gpio, gps_tx_a, gps_tx_b, gps_tx_c,
+                isense_dbg, jitter_bist, ldo_en, ldo_update, m_voc, mdp_vsync,
+                mdss_vsync0, mdss_vsync1, mdss_vsync2, mdss_vsync3, mss_lte,
+                nav_pps_a, nav_pps_b, nav_pps_c, pa_indicator, phase_flag0,
+                phase_flag1, phase_flag10, phase_flag11, phase_flag12,
+                phase_flag13, phase_flag14, phase_flag15, phase_flag16,
+                phase_flag17, phase_flag18, phase_flag19, phase_flag2,
+                phase_flag20, phase_flag21, phase_flag22, phase_flag23,
+                phase_flag24, phase_flag25, phase_flag26, phase_flag27,
+                phase_flag28, phase_flag29, phase_flag3, phase_flag30,
+                phase_flag31, phase_flag4, phase_flag5, phase_flag6,
+                phase_flag7, phase_flag8, phase_flag9, pll_bypassnl, pll_reset,
+                pri_mi2s, pri_mi2s_ws, prng_rosc, pwr_crypto, pwr_modem,
+                pwr_nav, qdss_cti0_a, qdss_cti0_b, qdss_cti1_a, qdss_cti1_b,
+                qdss_gpio, qdss_gpio0, qdss_gpio1, qdss_gpio10, qdss_gpio11,
+                qdss_gpio12, qdss_gpio13, qdss_gpio14, qdss_gpio15, qdss_gpio2,
+                qdss_gpio3, qdss_gpio4, qdss_gpio5, qdss_gpio6, qdss_gpio7,
+                qdss_gpio8, qdss_gpio9, qlink_enable, qlink_request, qspi_clk,
+                qspi_cs, qspi_data0, qspi_data1, qspi_data2, qspi_data3,
+                qspi_resetn, sec_mi2s, sndwire_clk, sndwire_data, sp_cmu,
+                ssc_irq, tgu_ch0, tgu_ch1, tsense_pwm1, tsense_pwm2, uim1_clk,
+                uim1_data, uim1_present, uim1_reset, uim2_clk, uim2_data,
+                uim2_present, uim2_reset, uim_batt, vfr_1, vsense_clkout,
+                vsense_data0, vsense_data1, vsense_mode, wlan1_adc0,
+                wlan1_adc1, wlan2_adc0, wlan2_adc1 ]
+
+      bias-disable: true
+      bias-pull-down: true
+      bias-pull-up: true
+      drive-strength: true
+      input-enable: true
+      output-high: true
+      output-low: true
+
+    required:
+      - pins
+
+    additionalProperties: false
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
+
+    tlmm: pinctrl@3100000 {
+        compatible = "qcom,sdm630-pinctrl";
+        reg = <0x03100000 0x400000>,
+              <0x03500000 0x400000>,
+              <0x03900000 0x400000>;
+        reg-names = "south", "center", "north";
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        gpio-ranges = <&tlmm 0 0 114>;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+
+        blsp1-uart1-default-state {
+            pins = "gpio0", "gpio1", "gpio2", "gpio3";
+            function = "gpio";
+            drive-strength = <2>;
+            bias-disable;
+        };
+
+        blsp2_uart1_default: blsp2-uart1-active-state {
+            tx-rts-pins {
+                pins = "gpio16", "gpio19";
+                function = "blsp_uart5";
+                drive-strength = <2>;
+                bias-disable;
+            };
+
+            rx-pins {
+                pins = "gpio17";
+                function = "blsp_uart5";
+                drive-strength = <2>;
+                bias-pull-up;
+            };
+
+            cts-pins {
+                pins = "gpio18";
+                function = "blsp_uart5";
+                drive-strength = <2>;
+                bias-pull-down;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt
deleted file mode 100644
index be034d329e10..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt
+++ /dev/null
@@ -1,191 +0,0 @@
-Qualcomm Technologies, Inc. SDM660 TLMM block
-
-This binding describes the Top Level Mode Multiplexer block found in the
-SDM660 platform.
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be "qcom,sdm660-pinctrl" or
-		    "qcom,sdm630-pinctrl".
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: the base address and size of the north, center and south
-		    TLMM tiles.
-
-- reg-names:
-       Usage: required
-       Value type: <stringlist>
-       Definition: names for the cells of reg, must contain "north", "center"
-                   and "south".
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
-- gpio-ranges:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: Specifies the mapping between gpio controller and
-		    pin-controller pins.
-
-- #gpio-cells:
-	Usage: required
-	Value type: <u32>
-	Definition: must be 2. Specifying the pin number and flags, as defined
-		    in <dt-bindings/gpio/gpio.h>
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
-		    this subnode.  Valid pins are:
-		    gpio0-gpio113,
-		        Supports mux, bias and drive-strength
-		    sdc1_clk, sdc1_cmd, sdc1_data sdc2_clk, sdc2_cmd, sdc2_data sdc1_rclk,
-		        Supports bias and drive-strength
-
-- function:
-	Usage: required
-	Value type: <string>
-	Definition: Specify the alternative function to be configured for the
-		    specified pins. Functions are only valid for gpio pins.
-		    Valid values are:
-		    adsp_ext, agera_pll, atest_char, atest_char0, atest_char1,
-		    atest_char2, atest_char3, atest_gpsadc0, atest_gpsadc1,
-		    atest_tsens, atest_tsens2, atest_usb1, atest_usb10,
-		    atest_usb11, atest_usb12, atest_usb13, atest_usb2,
-		    atest_usb20, atest_usb21, atest_usb22, atest_usb23,
-		    audio_ref, bimc_dte0, bimc_dte1, blsp_i2c1, blsp_i2c2,
-		    blsp_i2c3, blsp_i2c4, blsp_i2c5, blsp_i2c6, blsp_i2c7,
-		    blsp_i2c8_a, blsp_i2c8_b, blsp_spi1, blsp_spi2, blsp_spi3,
-		    blsp_spi3_cs1, blsp_spi3_cs2, blsp_spi4, blsp_spi5,
-		    blsp_spi6, blsp_spi7, blsp_spi8_a, blsp_spi8_b,
-		    blsp_spi8_cs1, blsp_spi8_cs2, blsp_uart1, blsp_uart2,
-		    blsp_uart5, blsp_uart6_a, blsp_uart6_b, blsp_uim1,
-		    blsp_uim2, blsp_uim5, blsp_uim6, cam_mclk, cci_async,
-		    cci_i2c, cri_trng, cri_trng0, cri_trng1, dbg_out, ddr_bist,
-		    gcc_gp1, gcc_gp2, gcc_gp3, gpio, gps_tx_a, gps_tx_b, gps_tx_c,
-		    isense_dbg, jitter_bist, ldo_en, ldo_update, m_voc, mdp_vsync,
-		    mdss_vsync0, mdss_vsync1, mdss_vsync2, mdss_vsync3, mss_lte,
-		    nav_pps_a, nav_pps_b, nav_pps_c, pa_indicator, phase_flag0,
-		    phase_flag1, phase_flag10, phase_flag11, phase_flag12,
-		    phase_flag13, phase_flag14, phase_flag15, phase_flag16,
-		    phase_flag17, phase_flag18, phase_flag19, phase_flag2,
-		    phase_flag20, phase_flag21, phase_flag22, phase_flag23,
-		    phase_flag24, phase_flag25, phase_flag26, phase_flag27,
-		    phase_flag28, phase_flag29, phase_flag3, phase_flag30,
-		    phase_flag31, phase_flag4, phase_flag5, phase_flag6,
-		    phase_flag7, phase_flag8, phase_flag9, pll_bypassnl,
-		    pll_reset, pri_mi2s, pri_mi2s_ws, prng_rosc, pwr_crypto,
-		    pwr_modem, pwr_nav, qdss_cti0_a, qdss_cti0_b, qdss_cti1_a,
-		    qdss_cti1_b, qdss_gpio, qdss_gpio0, qdss_gpio1, qdss_gpio10,
-		    qdss_gpio11, qdss_gpio12, qdss_gpio13, qdss_gpio14, qdss_gpio15,
-		    qdss_gpio2, qdss_gpio3, qdss_gpio4, qdss_gpio5, qdss_gpio6,
-		    qdss_gpio7, qdss_gpio8, qdss_gpio9, qlink_enable, qlink_request,
-		    qspi_clk, qspi_cs, qspi_data0, qspi_data1, qspi_data2,
-		    qspi_data3, qspi_resetn, sec_mi2s, sndwire_clk, sndwire_data,
-		    sp_cmu, ssc_irq, tgu_ch0, tgu_ch1, tsense_pwm1, tsense_pwm2,
-		    uim1_clk, uim1_data, uim1_present, uim1_reset, uim2_clk,
-		    uim2_data, uim2_present, uim2_reset, uim_batt, vfr_1,
-		    vsense_clkout, vsense_data0, vsense_data1, vsense_mode,
-		    wlan1_adc0, wlan1_adc1, wlan2_adc0, wlan2_adc1
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
-	tlmm: pinctrl@3100000 {
-		compatible = "qcom,sdm660-pinctrl";
-		reg = <0x3100000 0x200000>,
-		      <0x3500000 0x200000>,
-		      <0x3900000 0x200000>;
-		reg-names = "south", "center", "north";
-		interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-		gpio-controller;
-		gpio-ranges = <&tlmm 0 0 114>;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-	};
-- 
2.34.1

