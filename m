Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3441603070
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJRQBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiJRQBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:01:37 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D366C964
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:01:34 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id f14so9582935qvo.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NYSH+KPKLXF3i3ygsViuEOSPQEPRdZv4UiHjICkxwls=;
        b=thGEcwbOeaF7eskjiVnpkNrilR4NHeY/TXyJUMbM1FWzRCG/44z+0Xfku4kJtYwGzi
         NlX1YUygVwSp6xTZUE78TfNlQ8X7+N9AqeIlLqnYkB9yv0pMpkJRiCYR12f4Bcrly36Z
         JZgxSu88t11k50JhBy0ZyPEh7Z1vF5Fk8SV3/I5zSYYpZU5qI6hPIJOOZCATexRG6ilX
         fkd3d7mRytpfXvtZJsV688nLi7asAv4xnALA/bjQ+GkFgKnOlxX8hDy3beJ+S4VICBqQ
         orkX0mlxGhl951laIrCMEJciweBSb8rvowOdCLqYHhdb2dWkgc3mpG06egn21VCTsueV
         uQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYSH+KPKLXF3i3ygsViuEOSPQEPRdZv4UiHjICkxwls=;
        b=UFYj2SdFtZYIP6NhdNf0wue2C97cVSWEUwgKJCOnZ2dN4qo3/N5KIPQGlqeIexmLsv
         Gyc1EIeFlU1nmJLvWNcXbBm+G8J3s0sWvvaoP+VEalV61+d+gHGaTJmzv/bl3V9kC/vX
         fDRwlTXcjoekBCnfPLOSK3wJKXh2jXfxT8HNAW+iVSPUQ+ga8tLShMVm28hGopHbK9Xo
         2Ddrf1f18mt9i//zXkP+yfgLC1sXhVj/bL+nXCtNp0BzuNiZO3OQ5XG1JmYiiBGTJYzm
         07DNDIcnfd9vJnyeZGJZCc8yhosfhNORpCQQnZy6JpMrYG3tM3DcKCXJL+fpaWwMLCNZ
         kXnw==
X-Gm-Message-State: ACrzQf2hXvPhVE1NBbEshiJAtq7RjQhNf87sjD+fv5esc+ROYuxOAUvn
        EFFZNzYcd5P6ana2N5KbFr/wyQ==
X-Google-Smtp-Source: AMsMyM4DkeSpsFPhzR6vZsewN0ZeqmsG+ToDtJDq5Y45ZvYuCUnUSeXEgCDvCo2G0CH+qnVsHITY4Q==
X-Received: by 2002:a05:6214:20a6:b0:4b4:32a9:6c96 with SMTP id 6-20020a05621420a600b004b432a96c96mr2601091qvd.63.1666108893283;
        Tue, 18 Oct 2022 09:01:33 -0700 (PDT)
Received: from krzk-bin.MSRM (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id y4-20020a37e304000000b006b5cc25535fsm2469389qki.99.2022.10.18.09.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 09:01:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2] dt-bindings: pinctrl: qcom,sm8150: convert to dtschema
Date:   Tue, 18 Oct 2022 12:01:28 -0400
Message-Id: <20221018160128.51851-1-krzysztof.kozlowski@linaro.org>
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

Convert Qualcomm SM8150 pin controller bindings to DT schema.  Keep the
parsing of pin configuration subnodes consistent with other Qualcomm
schemas (children named with '-state' suffix, their children with
'-pins').

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Add tags.
2. Drop drive-strength (included by common TLMM node).
---
 .../bindings/pinctrl/qcom,sm8150-pinctrl.txt  | 190 ------------------
 .../bindings/pinctrl/qcom,sm8150-pinctrl.yaml | 173 ++++++++++++++++
 2 files changed, 173 insertions(+), 190 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.txt
deleted file mode 100644
index fa37733e5102..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.txt
+++ /dev/null
@@ -1,190 +0,0 @@
-Qualcomm SM8150 TLMM block
-
-This binding describes the Top Level Mode Multiplexer block found in the
-QCS404 platform.
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be "qcom,sm8150-pinctrl"
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: the base address and size of the north, south, west
-		    and east TLMM tiles.
-
-- reg-names:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Defintiion: names for the cells of reg, must contain "north", "south"
-		    "west" and "east".
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
-		      gpio0-gpio149
-		        Supports mux, bias and drive-strength
-
-		      sdc1_clk, sdc1_cmd, sdc1_data sdc2_clk, sdc2_cmd,
-		      sdc2_data sdc1_rclk
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
-		    adsp_ext, agera_pll, aoss_cti, ddr_pxi2, atest_char,
-		    atest_char0, atest_char1, atest_char2, atest_char3,
-		    audio_ref, atest_usb1, atest_usb2, atest_usb10,
-		    atest_usb11, atest_usb12, atest_usb13, atest_usb20,
-		    atest_usb21, atest_usb22, atest_usb2, atest_usb23,
-		    btfm_slimbus, cam_mclk, cci_async, cci_i2c, cci_timer0,
-		    cci_timer1, cci_timer2, cci_timer3, cci_timer4,
-		    cri_trng, cri_trng0, cri_trng1, dbg_out, ddr_bist,
-		    ddr_pxi0, ddr_pxi1, ddr_pxi3, edp_hot, edp_lcd,
-		    emac_phy, emac_pps, gcc_gp1, gcc_gp2, gcc_gp3, gpio,
-		    hs1_mi2s, hs2_mi2s, hs3_mi2s, jitter_bist,
-		    lpass_slimbus, mdp_vsync, mdp_vsync0, mdp_vsync1,
-		    mdp_vsync2, mdp_vsync3, mss_lte, m_voc, nav_pps,
-		    pa_indicator, pci_e0, phase_flag, pll_bypassnl,
-		    pll_bist, pci_e1, pll_reset, pri_mi2s, pri_mi2s_ws,
-		    prng_rosc, qdss, qdss_cti, qlink_request, qlink_enable,
-		    qspi0, qspi1, qspi2, qspi3, qspi_clk, qspi_cs, qua_mi2s,
-		    qup0, qup1, qup2, qup3, qup4, qup5, qup6, qup7, qup8,
-		    qup9, qup10, qup11, qup12, qup13, qup14, qup15, qup16,
-		    qup17, qup18, qup19, qup_l4, qup_l5, qup_l6, rgmii,
-		    sdc4, sd_write, sec_mi2s, spkr_i2s, sp_cmu, ter_mi2s,
-		    tgu_ch0, tgu_ch1, tgu_ch2, tgu_ch3, tsense_pwm1,
-		    tsense_pwm2, tsif1, tsif2, uim1, uim2, uim_batt,
-		    usb2phy_ac, usb_phy, vfr_1, vsense_trigger, wlan1_adc0,
-		    wlan1_adc1, wlan2_adc0, wlan2_adc1, wmss_reset
-
-- bias-disable:
-	Usage: optional
-	Value type: <none>
-	Definition: The specified pins should be configued as no pull.
-
-- bias-pull-down:
-	Usage: optional
-	Value type: <none>
-	Definition: The specified pins should be configued as pull down.
-
-- bias-pull-up:
-	Usage: optional
-	Value type: <none>
-	Definition: The specified pins should be configued as pull up.
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
-	tlmm: pinctrl@3000000 {
-		compatible = "qcom,sm8150-pinctrl";
-		reg = <0x03100000 0x300000>,
-		      <0x03500000 0x300000>,
-		      <0x03900000 0x300000>,
-		      <0x03D00000 0x300000>;
-		reg-names = "west", "east", "north", "south";
-		interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		gpio-ranges = <&tlmm 0 0 175>;
-		gpio-reserved-ranges = <0 4>, <126 4>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-	};
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml
new file mode 100644
index 000000000000..85adddbdee56
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml
@@ -0,0 +1,173 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,sm8150-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM8150 TLMM pin controller
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
+    const: qcom,sm8150-pinctrl
+
+  reg:
+    maxItems: 4
+
+  reg-names:
+    items:
+      - const: west
+      - const: east
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
+    maxItems: 88
+
+  gpio-line-names:
+    maxItems: 175
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-sm8150-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-sm8150-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-sm8150-tlmm-state:
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
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-6][0-9]|17[0-4])$"
+            - enum: [ sdc2_clk, sdc2_cmd, sdc2_data, ufs_reset ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+        enum: [ adsp_ext, agera_pll, aoss_cti, ddr_pxi2, atest_char,
+                atest_char0, atest_char1, atest_char2, atest_char3, audio_ref,
+                atest_usb1, atest_usb2, atest_usb10, atest_usb11, atest_usb12,
+                atest_usb13, atest_usb20, atest_usb21, atest_usb22, atest_usb2,
+                atest_usb23, btfm_slimbus, cam_mclk, cci_async, cci_i2c,
+                cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4,
+                cri_trng, cri_trng0, cri_trng1, dbg_out, ddr_bist, ddr_pxi0,
+                ddr_pxi1, ddr_pxi3, edp_hot, edp_lcd, emac_phy, emac_pps,
+                gcc_gp1, gcc_gp2, gcc_gp3, gpio, hs1_mi2s, hs2_mi2s, hs3_mi2s,
+                jitter_bist, lpass_slimbus, mdp_vsync, mdp_vsync0, mdp_vsync1,
+                mdp_vsync2, mdp_vsync3, mss_lte, m_voc, nav_pps, pa_indicator,
+                pci_e0, phase_flag, pll_bypassnl, pll_bist, pci_e1, pll_reset,
+                pri_mi2s, pri_mi2s_ws, prng_rosc, qdss, qdss_cti,
+                qlink_request, qlink_enable, qspi0, qspi1, qspi2, qspi3,
+                qspi_clk, qspi_cs, qua_mi2s, qup0, qup1, qup2, qup3, qup4,
+                qup5, qup6, qup7, qup8, qup9, qup10, qup11, qup12, qup13,
+                qup14, qup15, qup16, qup17, qup18, qup19, qup_l4, qup_l5,
+                qup_l6, rgmii, sdc4, sd_write, sec_mi2s, spkr_i2s, sp_cmu,
+                ter_mi2s, tgu_ch0, tgu_ch1, tgu_ch2, tgu_ch3, tsense_pwm1,
+                tsense_pwm2, tsif1, tsif2, uim1, uim2, uim_batt, usb2phy_ac,
+                usb_phy, vfr_1, vsense_trigger, wlan1_adc0, wlan1_adc1,
+                wlan2_adc0, wlan2_adc1, wmss_reset ]
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
+    tlmm: pinctrl@3100000 {
+        compatible = "qcom,sm8150-pinctrl";
+        reg = <0x03100000 0x300000>,
+              <0x03500000 0x300000>,
+              <0x03900000 0x300000>,
+              <0x03d00000 0x300000>;
+        reg-names = "west", "east", "north", "south";
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-ranges = <&tlmm 0 0 176>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        wakeup-parent = <&pdc>;
+
+        qup-spi0-default-state {
+            pins = "gpio0", "gpio1", "gpio2", "gpio3";
+            function = "qup0";
+            drive-strength = <6>;
+            bias-disable;
+        };
+
+        pcie1-default-state {
+            perst-pins {
+                pins = "gpio102";
+                function = "gpio";
+                drive-strength = <2>;
+                bias-pull-down;
+            };
+
+            clkreq-pins {
+                pins = "gpio103";
+                function = "pci_e1";
+                drive-strength = <2>;
+                bias-pull-up;
+            };
+
+            wake-pins {
+                pins = "gpio104";
+                function = "gpio";
+                drive-strength = <2>;
+                bias-pull-up;
+            };
+        };
+    };
-- 
2.34.1

