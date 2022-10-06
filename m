Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A465F6475
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 12:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiJFKlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 06:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiJFKlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:41:15 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF61728E39
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 03:41:13 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id j4so2186487lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 03:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=83k5JZ/X4KlDsxEl7RSSXfEDOzc2Wi0Ts3Xh70GQyqI=;
        b=tHIzFFqvVxCrJyYTGV9KpmOY0dOkR8C9pDgYKyP5LLgJnxX3PIm+N5/LBdU5UDZyCu
         wAtt4tQMTiUlcE3sOZ/nPeNluxGTomz7WBqvkvMKnCl6i2xDVmSZ33FG+fkcpGTP2Jb7
         pYxiOIOi8h7qy4CfYVlAJQa3ij/+dLIv536SjrnxxJooOXaw31MiVkkZavab9dI+pk1C
         rVr3/542CQiBMktr2+RuXnBFMTSNO3t9ljR0lIho9gLuD62ZGn1GEJAzZJrmZXVmFkjy
         OcFi8/BexywZDO18nBFDPWREtu7ejPSQbnHvoEeA/ATJAXF5HbmpaiJ01EnezvkmhrMz
         +d9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=83k5JZ/X4KlDsxEl7RSSXfEDOzc2Wi0Ts3Xh70GQyqI=;
        b=ncOdvVN2edfvHO+aPa5r6aijcFVCgRem+VzBqNN4U0C7QgDhbT9xqem438oBG3GHAq
         gG0oSraLXBTFy3+9mURcPhadPoH8JB9Fh/KuOEoixvWSkssa6G3/769PHqLWB3dmorgF
         7XQ8w2JgL9iZOdbbHuC6JDq9VRXFnDwVQ/kOiN5BD6YBb32nDtNNNjAMGw4YBn/x5tVQ
         ienrvR1K+YFtW4jyJRq1oaqvivwfXRQuXuLf0+VTeZEfJprf6VCsNJyWAECpaXCj+05k
         aHVdUcVYH/KgiUrd3ZTa99qwUgKk7At/E6VuCYN5PMztqHxFX4QjOgtK6IgJc6Bgw69Z
         ZOZw==
X-Gm-Message-State: ACrzQf0T+Ubp9Va3gIdZeVvpUfeflOYZl6FBhQd7NRJpX2BT1fyhQuXq
        a7t5OsNuhHYAFdzJNVXbBPP4sQ==
X-Google-Smtp-Source: AMsMyM7Jm1Sa4Q3BbJzA4l65LJriQdZkFXGMyYj3od6G0FKi3wPg4I9FPR5Dav29KHO6zWcuQVTpkw==
X-Received: by 2002:a05:6512:1281:b0:4a2:5c10:c38b with SMTP id u1-20020a056512128100b004a25c10c38bmr1712647lfs.2.1665052871515;
        Thu, 06 Oct 2022 03:41:11 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q3-20020a0565123a8300b00492aefd73a5sm2648293lfu.132.2022.10.06.03.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 03:41:11 -0700 (PDT)
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
Subject: [PATCH 4/4] dt-bindings: pinctrl: qcom,sdm630: convert to dtschema
Date:   Thu,  6 Oct 2022 12:41:04 +0200
Message-Id: <20221006104104.171368-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006104104.171368-1-krzysztof.kozlowski@linaro.org>
References: <20221006104104.171368-1-krzysztof.kozlowski@linaro.org>
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
---
 .../bindings/pinctrl/qcom,sdm630-pinctrl.yaml | 189 +++++++++++++++++
 .../bindings/pinctrl/qcom,sdm660-pinctrl.txt  | 191 ------------------
 2 files changed, 189 insertions(+), 191 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml
new file mode 100644
index 000000000000..057801652d1a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml
@@ -0,0 +1,189 @@
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
+  Top Level Mode Multiplexer pin controller node in Qualcomm SDM630 and SDM660
+  SoC.
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
+    pinctrl@3100000 {
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

