Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD295FC820
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJLPQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJLPQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:16:27 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9DF1262A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:16:25 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id a24so2797096qto.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/W16gySlDW3dAhFLI1DjGqkEZE40K/EWxlURaC3p1Gs=;
        b=T7+CvOfds5/zsJErcGYnurKsOF9ixZkWHc0Vay7Ovamra7Yfgi8eMfCXUNEhaeid9u
         wKAOOymmP/eYEwNyy+4KBQFv7jXHn+9OxpHBnm2c57n5KV7WdWWWeLPdy1A8bt4oXaVa
         8uXBMfOTmlefsJcn9A5rdfV/1qi/hOPtKnGORFJnBYRkWQqz3K22wG1ATkXlGiUm9TCf
         3i/amxA2sxFVeIggKEssHkVH/iOgZfXfeYRU/zvKs7dwu/qoJ1AEld+Apmd+OdABZ0ci
         R/ow/xUiQ7uyj7ErIXbegvhLA7DfuDUJkMgduy88Y6k/93bat6F094gSWcAr0C+ugCAq
         63rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/W16gySlDW3dAhFLI1DjGqkEZE40K/EWxlURaC3p1Gs=;
        b=FbR3TU+X6IsIjE9cxqjCU6I0P5aKue23cHT8+0Pb6AlpX6c7GbMscGVpT0R68AvmXL
         GL2Qw3fDQsDbEDq1WiL3i4w4HKxgEX6PbToW1gU51QtkW53hDV/e54rsxrBh/soiNcqv
         Yx9uOh5Lob5o0WcqtDvJ5IXJMZjAn9cnuUcAEdHWQFnmtdaidF/eqsJIuj64ApSXvXB6
         9I89j0VHtXo32CPFhBBQ2/WyMZ/yQgFA0ZHspFebrcxMckl0zS/6qNruwSpPpOiOpa86
         tR5Ygvg8jZbkiAG/WwfmGl4mbLBwFJej0h4/ar5bCCCx8Gv9XTFqzHQ/2tga0AMiYU1Z
         ORpQ==
X-Gm-Message-State: ACrzQf3r6+XpNIwNEAKj2zW9jYtN8Kul9+vsmd3sKtsIAchTRwdGVdeD
        Va8iVshrekoz3Oa+F6BBndqV9w==
X-Google-Smtp-Source: AMsMyM6FMJ6f3m5oq4OCtl8kIB1wGWO1lwo3M4Jt9MPIANCwFaChiMbZjvtfiuPtxBb5z6AeEW5Oeg==
X-Received: by 2002:ac8:5a43:0:b0:39c:c4ec:636d with SMTP id o3-20020ac85a43000000b0039cc4ec636dmr1919000qta.87.1665587784033;
        Wed, 12 Oct 2022 08:16:24 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id u2-20020a05620a454200b006af0ce13499sm16671612qkp.115.2022.10.12.08.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 08:16:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 4/4] dt-bindings: pinctrl: qcom,msm8998: convert to dtschema
Date:   Wed, 12 Oct 2022 11:14:16 -0400
Message-Id: <20221012151416.38645-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221012151416.38645-1-krzysztof.kozlowski@linaro.org>
References: <20221012151416.38645-1-krzysztof.kozlowski@linaro.org>
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

Convert Qualcomm MSM8998 pin controller bindings to DT schema.  Keep the
parsing of pin configuration subnodes consistent with other Qualcomm
schemas (children named with '-state' suffix, their children with
'-pins').

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Correct bindings description.
---
 .../bindings/pinctrl/qcom,msm8998-pinctrl.txt | 202 ------------------
 .../pinctrl/qcom,msm8998-pinctrl.yaml         | 176 +++++++++++++++
 2 files changed, 176 insertions(+), 202 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.txt
deleted file mode 100644
index c4de930f2406..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.txt
+++ /dev/null
@@ -1,202 +0,0 @@
-Qualcomm MSM8998 TLMM block
-
-This binding describes the Top Level Mode Multiplexer block found in the
-MSM8998 platform.
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be "qcom,msm8998-pinctrl"
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: the base address and size of the TLMM register space.
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
-	Definition:  see ../gpio/gpio.txt
-
-- gpio-reserved-ranges:
-	Usage: optional
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
-		      gpio0-gpio149
-		        Supports mux, bias and drive-strength
-
-		      sdc2_clk, sdc2_cmd, sdc2_data
-		        Supports bias and drive-strength
-
-		      ufs_reset
-		        Supports bias and drive-strength
-
-- function:
-	Usage: required
-	Value type: <string>
-	Definition: Specify the alternative function to be configured for the
-		    specified pins. Functions are only valid for gpio pins.
-		    Valid values are:
-
-		    gpio, adsp_ext, agera_pll, atest_char, atest_gpsadc0,
-		    atest_gpsadc1, atest_tsens, atest_tsens2, atest_usb1,
-		    atest_usb10, atest_usb11, atest_usb12, atest_usb13,
-		    audio_ref, bimc_dte0, bimc_dte1, blsp10_spi, blsp10_spi_a,
-		    blsp10_spi_b, blsp11_i2c, blsp1_spi, blsp1_spi_a,
-		    blsp1_spi_b, blsp2_spi, blsp9_spi, blsp_i2c1, blsp_i2c2,
-		    blsp_i2c3, blsp_i2c4, blsp_i2c5, blsp_i2c6, blsp_i2c7,
-		    blsp_i2c8, blsp_i2c9, blsp_i2c10, blsp_i2c11, blsp_i2c12,
-		    blsp_spi1, blsp_spi2, blsp_spi3, blsp_spi4, blsp_spi5,
-		    blsp_spi6, blsp_spi7, blsp_spi8, blsp_spi9, blsp_spi10,
-		    blsp_spi11, blsp_spi12, blsp_uart1_a, blsp_uart1_b,
-		    blsp_uart2_a, blsp_uart2_b, blsp_uart3_a, blsp_uart3_b,
-		    blsp_uart7_a, blsp_uart7_b, blsp_uart8, blsp_uart8_a,
-		    blsp_uart8_b, blsp_uart9_a, blsp_uart9_b, blsp_uim1_a,
-		    blsp_uim1_b, blsp_uim2_a, blsp_uim2_b, blsp_uim3_a,
-		    blsp_uim3_b, blsp_uim7_a, blsp_uim7_b, blsp_uim8_a,
-		    blsp_uim8_b, blsp_uim9_a, blsp_uim9_b, bt_reset,
-		    btfm_slimbus, cam_mclk, cci_async, cci_i2c, cci_timer0,
-		    cci_timer1, cci_timer2, cci_timer3, cci_timer4, cri_trng,
-		    cri_trng0, cri_trng1, dbg_out, ddr_bist, edp_hot, edp_lcd,
-		    gcc_gp1_a, gcc_gp1_b, gcc_gp2_a, gcc_gp2_b, gcc_gp3_a,
-		    gcc_gp3_b, hdmi_cec, hdmi_ddc, hdmi_hot, hdmi_rcv,
-		    isense_dbg, jitter_bist, ldo_en, ldo_update, lpass_slimbus,
-		    m_voc, mdp_vsync, mdp_vsync0, mdp_vsync1, mdp_vsync2,
-		    mdp_vsync3, mdp_vsync_a, mdp_vsync_b, modem_tsync, mss_lte,
-		    nav_dr, nav_pps, pa_indicator, pci_e0, phase_flag,
-		    pll_bypassnl, pll_reset, pri_mi2s, pri_mi2s_ws, prng_rosc,
-		    pwr_crypto, pwr_modem, pwr_nav, qdss_cti0_a, qdss_cti0_b,
-		    qdss_cti1_a, qdss_cti1_b, qdss, qlink_enable,
-		    qlink_request, qua_mi2s, sd_card, sd_write, sdc40, sdc41,
-		    sdc42, sdc43, sdc4_clk, sdc4_cmd, sec_mi2s, sp_cmu,
-		    spkr_i2s, ssbi1, ssc_irq, ter_mi2s, tgu_ch0, tgu_ch1,
-		    tsense_pwm1, tsense_pwm2, tsif0, tsif1,
-		    uim1_clk, uim1_data, uim1_present,
-		    uim1_reset, uim2_clk, uim2_data, uim2_present, uim2_reset,
-		    uim_batt, usb_phy, vfr_1, vsense_clkout, vsense_data0,
-		    vsense_data1, vsense_mode, wlan1_adc0, wlan1_adc1,
-		    wlan2_adc0, wlan2_adc1,
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
-	tlmm: pinctrl@03400000 {
-		compatible = "qcom,msm8998-pinctrl";
-		reg = <0x03400000 0xc00000>;
-		interrupts = <0 208 0>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		gpio-ranges = <&tlmm 0 0 175>;
-		gpio-reserved-ranges = <0 4>, <81 4>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-
-		uart_console_active: uart_console_active {
-			mux {
-				pins = "gpio4", "gpio5";
-				function = "blsp_uart8_a";
-			};
-
-			config {
-				pins = "gpio4", "gpio5";
-				drive-strength = <2>;
-				bias-disable;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml
new file mode 100644
index 000000000000..89c95b42b39b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml
@@ -0,0 +1,176 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,msm8998-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm MSM8998 TLMM pin controller
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm MSM8998 SoC.
+
+properties:
+  compatible:
+    const: qcom,msm8998-pinctrl
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
+    maxItems: 75
+
+  gpio-line-names:
+    maxItems: 150
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-msm8998-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-msm8998-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-msm8998-tlmm-state:
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
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-4][0-9])$"
+            - enum: [ sdc2_clk, sdc2_cmd, sdc2_data, ufs_reset ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+        enum: [ gpio, adsp_ext, agera_pll, atest_char, atest_gpsadc0,
+                atest_gpsadc1, atest_tsens, atest_tsens2, atest_usb1,
+                atest_usb10, atest_usb11, atest_usb12, atest_usb13, audio_ref,
+                bimc_dte0, bimc_dte1, blsp10_spi, blsp10_spi_a, blsp10_spi_b,
+                blsp11_i2c, blsp1_spi, blsp1_spi_a, blsp1_spi_b, blsp2_spi,
+                blsp9_spi, blsp_i2c1, blsp_i2c2, blsp_i2c3, blsp_i2c4,
+                blsp_i2c5, blsp_i2c6, blsp_i2c7, blsp_i2c8, blsp_i2c9,
+                blsp_i2c10, blsp_i2c11, blsp_i2c12, blsp_spi1, blsp_spi2,
+                blsp_spi3, blsp_spi4, blsp_spi5, blsp_spi6, blsp_spi7,
+                blsp_spi8, blsp_spi9, blsp_spi10, blsp_spi11, blsp_spi12,
+                blsp_uart1_a, blsp_uart1_b, blsp_uart2_a, blsp_uart2_b,
+                blsp_uart3_a, blsp_uart3_b, blsp_uart7_a, blsp_uart7_b,
+                blsp_uart8, blsp_uart8_a, blsp_uart8_b, blsp_uart9_a,
+                blsp_uart9_b, blsp_uim1_a, blsp_uim1_b, blsp_uim2_a,
+                blsp_uim2_b, blsp_uim3_a, blsp_uim3_b, blsp_uim7_a,
+                blsp_uim7_b, blsp_uim8_a, blsp_uim8_b, blsp_uim9_a,
+                blsp_uim9_b, bt_reset, btfm_slimbus, cam_mclk, cci_async,
+                cci_i2c, cci_timer0, cci_timer1, cci_timer2, cci_timer3,
+                cci_timer4, cri_trng, cri_trng0, cri_trng1, dbg_out, ddr_bist,
+                edp_hot, edp_lcd, gcc_gp1_a, gcc_gp1_b, gcc_gp2_a, gcc_gp2_b,
+                gcc_gp3_a, gcc_gp3_b, hdmi_cec, hdmi_ddc, hdmi_hot, hdmi_rcv,
+                isense_dbg, jitter_bist, ldo_en, ldo_update, lpass_slimbus,
+                m_voc, mdp_vsync, mdp_vsync0, mdp_vsync1, mdp_vsync2,
+                mdp_vsync3, mdp_vsync_a, mdp_vsync_b, modem_tsync, mss_lte,
+                nav_dr, nav_pps, pa_indicator, pci_e0, phase_flag,
+                pll_bypassnl, pll_reset, pri_mi2s, pri_mi2s_ws, prng_rosc,
+                pwr_crypto, pwr_modem, pwr_nav, qdss_cti0_a, qdss_cti0_b,
+                qdss_cti1_a, qdss_cti1_b, qdss, qlink_enable, qlink_request,
+                qua_mi2s, sd_card, sd_write, sdc40, sdc41, sdc42, sdc43,
+                sdc4_clk, sdc4_cmd, sec_mi2s, sp_cmu, spkr_i2s, ssbi1, ssc_irq,
+                ter_mi2s, tgu_ch0, tgu_ch1, tsense_pwm1, tsense_pwm2, tsif0,
+                tsif1, uim1_clk, uim1_data, uim1_present, uim1_reset, uim2_clk,
+                uim2_data, uim2_present, uim2_reset, uim_batt, usb_phy, vfr_1,
+                vsense_clkout, vsense_data0, vsense_data1, vsense_mode,
+                wlan1_adc0, wlan1_adc1, wlan2_adc0, wlan2_adc1 ]
+
+      drive-strength:
+        enum: [2, 4, 6, 8, 10, 12, 14, 16]
+        default: 2
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
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    tlmm: pinctrl@3400000 {
+        compatible = "qcom,msm8998-pinctrl";
+        reg = <0x03400000 0xc00000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-ranges = <&tlmm 0 0 150>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-reserved-ranges = <0 4>, <81 4>;
+
+        sdc2-off-state {
+            clk-pins {
+                pins = "sdc2_clk";
+                drive-strength = <2>;
+                bias-disable;
+            };
+
+            cmd-pins {
+                pins = "sdc2_cmd";
+                drive-strength = <2>;
+                bias-pull-up;
+            };
+
+            data-pins {
+                pins = "sdc2_data";
+                drive-strength = <2>;
+                bias-pull-up;
+            };
+        };
+
+        sdc2-cd-state {
+            pins = "gpio95";
+            function = "gpio";
+            bias-pull-up;
+            drive-strength = <2>;
+        };
+    };
-- 
2.34.1

