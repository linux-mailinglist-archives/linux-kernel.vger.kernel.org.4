Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B11C5F132C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiI3UGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbiI3UFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:05:54 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22B115D9A4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 13:05:46 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id o7so1191235lfk.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 13:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TDfPxCW8Vgo0Tr/WCtPhdAcw4zILqj9ZDUiozuEFfpY=;
        b=DURzC7s1QTJoBFUsSjVW7/YZObKxyO6fyXYfpb19Vk7XJpF+pruYuFON9bfe9G1j8C
         jfx7jmM6sdoDzc7GwCQm6qJIKW7UPdw+dmisyUfA9mI7ezD3BfO3wy5K0qvW5JFDAeaP
         Zb3pRHGROiJ7j+tVUa/Mum7cjdNNWetNh7+rK1xpwTrL+99BpU/iZmlQ0d6VPbsEy4vc
         CbnzBoRyxj/5gfcMa+cq2AK/R0mTvT+CS7XsXMDmS7ZHM/nrkmVE6jghIo12eh6irbTR
         1KvgsYn9aseNL9asP/QxRIUWNhcavN/h72XeczgmxF4+MivPMhSf0JCzdS6v9DIJ5jQk
         CVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TDfPxCW8Vgo0Tr/WCtPhdAcw4zILqj9ZDUiozuEFfpY=;
        b=H+A+r0Y3477Ix7H7qWa5tV7XzCUitigqbKHLXSS+/C2/7VsKWJBTHKUyHxSPOmQ3yv
         X93dRFUFZ45/b8iC1Q0ZUi/aZPX/4gM00zmbyR9CmFLTK7Bu7746u1nYhxCLIk37rXdk
         aAvB+c4vGe4GT9uSAh9P5mi77MAx24tCRvh6GZDQrCMR5u+qZKghDD2pL+K7VqBazjxz
         M+bv8Xo2XC5McLOiqn2YZgGpnRIPefHwxKp4nQB6RIKDghtnf3j1VFRPZasQn9U4O4Yk
         iXfngld4OKb+869efGShPN9XA8jd+2/aHWnb6nBabNpadaVEV85LWbg6ztoSbXnz5GFo
         POaw==
X-Gm-Message-State: ACrzQf0pqhKMdjoMNGkD7C8Og8SKPqmd1zKDdgHZdX4kVBafHziOLadP
        aAOwwbd3yPmjdcIkJdsB5xpdCw==
X-Google-Smtp-Source: AMsMyM4YjejXrJlJWuN8ZSM3rqYmkZWZxj4N+lillQ+JPvlRZgz0/0y/3DIUYNsiInQgnk9Qy7a1nQ==
X-Received: by 2002:a05:6512:2307:b0:49d:b4c1:f319 with SMTP id o7-20020a056512230700b0049db4c1f319mr3512295lfu.266.1664568344806;
        Fri, 30 Sep 2022 13:05:44 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d10-20020ac2544a000000b00492f45cbbfcsm398876lfn.302.2022.09.30.13.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 13:05:44 -0700 (PDT)
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
Subject: [PATCH 2/2] dt-bindings: pinctrl: qcom,sdm845: convert to dtschema
Date:   Fri, 30 Sep 2022 22:05:29 +0200
Message-Id: <20220930200529.331223-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220930200529.331223-1-krzysztof.kozlowski@linaro.org>
References: <20220930200529.331223-1-krzysztof.kozlowski@linaro.org>
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

Convert Qualcomm SDM845 pin controller bindings to DT schema.  Keep
the parsing of pin configuration subnodes consistent with other Qualcomm
schemas (children named with '-state' suffix, their children with
'-pins').

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,sdm845-pinctrl.txt  | 176 ------------------
 .../bindings/pinctrl/qcom,sdm845-pinctrl.yaml | 158 ++++++++++++++++
 2 files changed, 158 insertions(+), 176 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
deleted file mode 100644
index 7462e3743c68..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
+++ /dev/null
@@ -1,176 +0,0 @@
-Qualcomm SDM845 TLMM block
-
-This binding describes the Top Level Mode Multiplexer block found in the
-SDM845 platform.
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be "qcom,sdm845-pinctrl"
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
-		      sdc2_clk, sdc2_cmd, sdc2_data, ufs_reset
-		        Supports bias and drive-strength
-
-- function:
-	Usage: required
-	Value type: <string>
-	Definition: Specify the alternative function to be configured for the
-		    specified pins. Functions are only valid for gpio pins.
-		    Valid values are:
-
-		    gpio, adsp_ext, agera_pll, atest_char, atest_tsens,
-		    atest_tsens2, atest_usb1, atest_usb10, atest_usb11,
-		    atest_usb12, atest_usb13, atest_usb2, atest_usb20,
-		    atest_usb21, atest_usb22, atest_usb23, audio_ref,
-		    btfm_slimbus, cam_mclk, cci_async, cci_i2c, cci_timer0,
-		    cci_timer1, cci_timer2, cci_timer3, cci_timer4, cri_trng,
-		    cri_trng0, cri_trng1, dbg_out, ddr_bist, ddr_pxi0,
-		    ddr_pxi1, ddr_pxi2, ddr_pxi3, edp_hot, edp_lcd, gcc_gp1,
-		    gcc_gp2, gcc_gp3, jitter_bist, ldo_en, ldo_update,
-		    lpass_slimbus, m_voc, mdp_vsync, mdp_vsync0, mdp_vsync1,
-		    mdp_vsync2, mdp_vsync3, mss_lte, nav_pps, pa_indicator,
-		    pci_e0, pci_e1, phase_flag, pll_bist, pll_bypassnl,
-		    pll_reset, pri_mi2s, pri_mi2s_ws, prng_rosc, qdss_cti,
-		    qdss, qlink_enable, qlink_request, qua_mi2s, qup0, qup1,
-		    qup10, qup11, qup12, qup13, qup14, qup15, qup2, qup3, qup4,
-		    qup5, qup6, qup7, qup8, qup9, qup_l4, qup_l5, qup_l6,
-		    qspi_clk, qspi_cs, qspi_data, sd_write, sdc4_clk, sdc4_cmd,
-		    sdc4_data, sec_mi2s, sp_cmu, spkr_i2s, ter_mi2s, tgu_ch0,
-		    tgu_ch1, tgu_ch2, tgu_ch3, tsense_pwm1, tsense_pwm2,
-		    tsif1_clk, tsif1_data, tsif1_en, tsif1_error, tsif1_sync,
-		    tsif2_clk, tsif2_data, tsif2_en, tsif2_error, tsif2_sync,
-		    uim1_clk, uim1_data, uim1_present, uim1_reset, uim2_clk,
-		    uim2_data, uim2_present, uim2_reset, uim_batt, usb_phy,
-		    vfr_1, vsense_trigger, wlan1_adc0, wlan1_adc1, wlan2_adc0,
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
-	tlmm: pinctrl@3400000 {
-		compatible = "qcom,sdm845-pinctrl";
-		reg = <0x03400000 0xc00000>;
-		interrupts = <GIC_SPI 208 0>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-
-		qup9_active: qup9-active {
-			mux {
-				pins = "gpio4", "gpio5";
-				function = "qup9";
-			};
-
-			config {
-				pins = "gpio4", "gpio5";
-				drive-strength = <2>;
-				bias-disable;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
new file mode 100644
index 000000000000..da0ef5698f3e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
@@ -0,0 +1,158 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,sdm845-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SDM845 TLMM pin controller
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  Top Level Mode Multiplexer pin controller node in Qualcomm SDM845 SoC.
+
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,sdm845-pinctrl
+
+  reg:
+    maxItems: 1
+
+  interrupts: true
+  interrupt-controller: true
+  "#interrupt-cells": true
+  gpio-controller: true
+
+  gpio-reserved-ranges:
+    minItems: 1
+    maxItems: 75
+
+  gpio-line-names:
+    maxItems: 150
+
+  "#gpio-cells": true
+  gpio-ranges: true
+  wakeup-parent: true
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-sdm845-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-sdm845-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-sdm845-tlmm-state:
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
+            - enum: [ ufs_reset, sdc2_clk, sdc2_cmd, sdc2_data ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+        enum: [ adsp_ext, agera_pll, atest_char, atest_tsens, atest_tsens2,
+                atest_usb1, atest_usb10, atest_usb11, atest_usb12, atest_usb13,
+                atest_usb2, atest_usb20, atest_usb21, atest_usb22, atest_usb23,
+                audio_ref, btfm_slimbus, cam_mclk, cci_async, cci_i2c,
+                cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4,
+                cri_trng, cri_trng0, cri_trng1, dbg_out, ddr_bist, ddr_pxi0,
+                ddr_pxi1, ddr_pxi2, ddr_pxi3, edp_hot, edp_lcd, gcc_gp1,
+                gcc_gp2, gcc_gp3, gpio, jitter_bist, ldo_en, ldo_update,
+                lpass_slimbus, mdp_vsync, mdp_vsync0, mdp_vsync1, mdp_vsync2,
+                mdp_vsync3, mss_lte, m_voc, nav_pps, pa_indicator, pci_e0,
+                pci_e1, phase_flag, pll_bist, pll_bypassnl, pll_reset,
+                pri_mi2s, pri_mi2s_ws, prng_rosc, qdss, qdss_cti, qlink_enable,
+                qlink_request, qspi_clk, qspi_cs, qspi_data, qua_mi2s, qup0,
+                qup1, qup10, qup11, qup12, qup13, qup14, qup15, qup2, qup3,
+                qup4, qup5, qup6, qup7, qup8, qup9, qup_l4, qup_l5, qup_l6,
+                sdc4_clk, sdc4_cmd, sdc4_data, sd_write, sec_mi2s, sp_cmu,
+                spkr_i2s, ter_mi2s, tgu_ch0, tgu_ch1, tgu_ch2, tgu_ch3,
+                tsense_pwm1, tsense_pwm2, tsif1_clk, tsif1_data, tsif1_en,
+                tsif1_error, tsif1_sync, tsif2_clk, tsif2_data, tsif2_en,
+                tsif2_error, tsif2_sync, uim1_clk, uim1_data, uim1_present,
+                uim1_reset, uim2_clk, uim2_data, uim2_present, uim2_reset,
+                uim_batt, usb_phy, vfr_1, vsense_trigger, wlan1_adc0,
+                wlan1_adc1, wlan2_adc0, wlan2_adc1]
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
+    pinctrl@3400000 {
+        compatible = "qcom,sdm845-pinctrl";
+        reg = <0x03400000 0xc00000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 151>;
+        wakeup-parent = <&pdc_intc>;
+
+        cci0-default-state {
+            pins = "gpio17", "gpio18";
+            function = "cci_i2c";
+
+            bias-pull-up;
+            drive-strength = <2>;
+        };
+
+        cam0-default-state {
+            rst-pins {
+                pins = "gpio9";
+                function = "gpio";
+
+                drive-strength = <16>;
+                bias-disable;
+            };
+
+            mclk0-pins {
+                pins = "gpio13";
+                function = "cam_mclk";
+
+                drive-strength = <16>;
+                bias-disable;
+            };
+        };
+    };
-- 
2.34.1

