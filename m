Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846775FBD0A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 23:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiJKVeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 17:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJKVd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 17:33:56 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8862F9C7D2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 14:33:54 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id c23so5123853qtw.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 14:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ome2ZfsAFV8cWgokkGQsmv7FDHgt0OanJjr6cMKz3x0=;
        b=ztWBpaco6jE1E91eRUHeSWHbxfzsbUeqnYvujqyGBttbqfGWsvqd5kkusb4KuOHJ3Y
         2DR/mnwBCHJYeorM3vuDlzTNL/7M6+vR5ZAOWu9fVxk0GAAeemktqpnWFtYUtaUYtv1C
         wnyrtOieeWbWh4+X03le9dwCJdndcx9Un9JtCipYhdZvHoyPfS+EZ2bL0lW3qvR+JO9M
         H/34E5fCFOi+fGYLZf3o4+Pjoa7k6uDlZJUtqKURmT52r2zTYgC3SLL6r1W/Lb90rlC/
         Agpzlr74uEICXwWr8C4XPkdc3BTQnW1lPDq0E2QQc0QJzWMnfkh1gi+8P08s6YJ3RgLZ
         TY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ome2ZfsAFV8cWgokkGQsmv7FDHgt0OanJjr6cMKz3x0=;
        b=70V9OxjD+8sMLNcqu5pjIj3MI9HSeUNhr9n2rf/QIAWQlX4d1s5jCuv8VJpqjSP4HD
         TOAqWmrmQsnLcI2gam+VJEViMVSbTiJzByEd5IGxiqlwpei6zvW0hga5cLvfjYjZncEx
         eB9ynj4M/B0xKkpMPTfnnolLYMXAq8fLDtFTUlkTJQuwyTBsbHt/zc1bFYzyCUSoXj+4
         KxSe+mdBe9AYwydRpGlkaBU7LUShloEd2CISsVyh7iHT2EA6YWOSpGFNZk+hxUQNnGsz
         kgcDmxxufO4jGeO1y1T/EwO8CTrZ2F1kBJJfjrnpewmoFz0BGNfWpf/F3/Dmm0CQGGgr
         UnKQ==
X-Gm-Message-State: ACrzQf3tvf7JgdSyFZEp+ZcRvMhr+lLWfbo6E6p7a80T2X8OioxwG5a5
        PTivE0ot1CoxoaHzvNZMWBkKmA==
X-Google-Smtp-Source: AMsMyM6fjNOmeNW/GmW8cbqZNnCaCcvaBE2uerYt08JD7bGKVAGAs2OfYjcbbW/zIGC6Fi7eyQ2MOg==
X-Received: by 2002:ac8:5a0c:0:b0:391:7be4:1c4f with SMTP id n12-20020ac85a0c000000b003917be41c4fmr21162893qta.472.1665524033478;
        Tue, 11 Oct 2022 14:33:53 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id j20-20020ac84414000000b0039cbb50951asm604224qtn.24.2022.10.11.14.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 14:33:52 -0700 (PDT)
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
Subject: [PATCH 4/4] dt-bindings: pinctrl: qcom,msm8998: convert to dtschema
Date:   Tue, 11 Oct 2022 17:31:45 -0400
Message-Id: <20221011213145.122879-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011213145.122879-1-krzysztof.kozlowski@linaro.org>
References: <20221011213145.122879-1-krzysztof.kozlowski@linaro.org>
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
index 000000000000..1cff2b02e2a7
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
+  Top Level Mode Multiplexer pin controller in Qualcomm SM8150 SoC.
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

