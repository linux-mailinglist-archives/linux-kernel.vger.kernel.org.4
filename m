Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB856228CB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiKIKoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiKIKoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:44:09 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF85CBF5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 02:44:06 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id h12so25101466ljg.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 02:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nX5KS+HiUi+q9YOzzo2tqeIRTCNvdON5KF20TT7I2yE=;
        b=VIwMAFcBNjcQZQV4YixSIHYfDI43rADsG8U/7LJtPx2mDDV2+cpgFEsddDPhVpTnPQ
         gu6Tiq37VAuOLBo4Eb7j7Vvj76XfkspSNz0cblw0I5mL63YpSCfL319WtYM7Sb3vKEIh
         +K4AnU/1AN7iuAuaNQ9ZRqpCqbbAtMwDy3eX0oyg7RltsottkXArIJpapUeccFiU/zRk
         w77C/zVjt+txdrdekbdBlBlROnizqVFlw4+q4pM+RYN0aSvy30siWUsipu17t+5rCWYe
         m2/y9HQgC8mXhM6gg63WcZgdjZyRwEXTQeq1C89TWynJAbLz5nfwZQB72eJltwPJaP/r
         il6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nX5KS+HiUi+q9YOzzo2tqeIRTCNvdON5KF20TT7I2yE=;
        b=yh0OuXWaQmPTiZUo9dbxyaes7uC70xtKX/eKW25uvwOLPOq++GRuMV98jv3MxZevn8
         N0TnEvP5n8NbTRoOswU8dl5tNFFhPWHq+aWXImu+HCd0sLGFk0XxxAR/R4TqDzjr1Se+
         zOcAo+SlB8Fw+lxMQYf8T6tkU51Oc7QZWlYSmkWvV3VjrXoCobwquIl6v61YTGr2Cvk0
         WkhEzcVmGH/QGVe4eJreeOH4otCUk4ePq3cQwjDI578Oill/aIlI0+lhwr6f9Mc4gFN1
         SiQ8tkgZze5M7OucBq4qzT2vshYwnhS4A6JfN82l48/p8ddagM29oA6qpVzQ9OM8SWNg
         B/QQ==
X-Gm-Message-State: ACrzQf3f2bazSM3rXRjVw9znEXU1plRM6A+Jcf9f4iIBac84yVkgMX8i
        zjToVqdhislIgzAjSAs9dPw2ztgFO+bATg==
X-Google-Smtp-Source: AMsMyM7VDIrv1bqq3qb08mFff/lXVDbMngr4mTqTGR8PLvjlyf7mv7MtsncR+CepDLMDqzOZcRdjEQ==
X-Received: by 2002:a2e:999a:0:b0:277:56a9:4a39 with SMTP id w26-20020a2e999a000000b0027756a94a39mr16608731lji.333.1667990645029;
        Wed, 09 Nov 2022 02:44:05 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id j10-20020a056512344a00b004afd23cf7eesm2148568lfr.168.2022.11.09.02.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 02:44:04 -0800 (PST)
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
Subject: [PATCH 1/2] dt-bindings: pinctrl: qcom,msm8916: convert to dtschema
Date:   Wed,  9 Nov 2022 11:44:01 +0100
Message-Id: <20221109104402.45592-1-krzysztof.kozlowski@linaro.org>
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

Convert Qualcomm MSM8916 pin controller bindings to DT schema.  Keep the
parsing of pin configuration subnodes consistent with other Qualcomm
schemas (children named with '-state' suffix, their children with
'-pins').

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,msm8916-pinctrl.txt | 195 ------------------
 .../pinctrl/qcom,msm8916-pinctrl.yaml         | 166 +++++++++++++++
 2 files changed, 166 insertions(+), 195 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.txt
deleted file mode 100644
index 3354a63296d9..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.txt
+++ /dev/null
@@ -1,195 +0,0 @@
-Qualcomm MSM8916 TLMM block
-
-This binding describes the Top Level Mode Multiplexer block found in the
-MSM8916 platform.
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be "qcom,msm8916-pinctrl"
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
-		    this subnode.  Valid pins are:
-		    gpio0-gpio121,
-		    sdc1_clk,
-		    sdc1_cmd,
-		    sdc1_data
-		    sdc2_clk,
-		    sdc2_cmd,
-		    sdc2_data,
-		    qdsd_cmd,
-		    qdsd_data0,
-		    qdsd_data1,
-		    qdsd_data2,
-		    qdsd_data3
-
-- function:
-	Usage: required
-	Value type: <string>
-	Definition: Specify the alternative function to be configured for the
-		    specified pins. Functions are only valid for gpio pins.
-		    Valid values are:
-	adsp_ext, alsp_int, atest_bbrx0, atest_bbrx1, atest_char, atest_char0,
-	atest_char1, atest_char2, atest_char3, atest_combodac, atest_gpsadc0,
-	atest_gpsadc1, atest_tsens, atest_wlan0, atest_wlan1, backlight_en,
-	bimc_dte0,bimc_dte1, blsp_i2c1, blsp_i2c2, blsp_i2c3, blsp_i2c4,
-	blsp_i2c5, blsp_i2c6, blsp_spi1, blsp_spi1_cs1, blsp_spi1_cs2,
-	blsp_spi1_cs3, blsp_spi2, blsp_spi2_cs1, blsp_spi2_cs2, blsp_spi2_cs3,
-	blsp_spi3, blsp_spi3_cs1, blsp_spi3_cs2, blsp_spi3_cs3, blsp_spi4,
-	blsp_spi5, blsp_spi6, blsp_uart1, blsp_uart2, blsp_uim1, blsp_uim2,
-	cam1_rst, cam1_standby, cam_mclk0, cam_mclk1, cci_async, cci_i2c,
-	cci_timer0, cci_timer1, cci_timer2, cdc_pdm0, codec_mad, dbg_out,
-	display_5v, dmic0_clk, dmic0_data, dsi_rst, ebi0_wrcdc, euro_us,
-	ext_lpass, flash_strobe, gcc_gp1_clk_a, gcc_gp1_clk_b, gcc_gp2_clk_a,
-	gcc_gp2_clk_b, gcc_gp3_clk_a, gcc_gp3_clk_b, gpio, gsm0_tx0, gsm0_tx1,
-	gsm1_tx0, gsm1_tx1, gyro_accl, kpsns0, kpsns1, kpsns2, ldo_en,
-	ldo_update, mag_int, mdp_vsync, modem_tsync, m_voc, nav_pps, nav_tsync,
-	pa_indicator, pbs0, pbs1, pbs2, pri_mi2s, pri_mi2s_ws, prng_rosc,
-	pwr_crypto_enabled_a, pwr_crypto_enabled_b, pwr_modem_enabled_a,
-	pwr_modem_enabled_b, pwr_nav_enabled_a, pwr_nav_enabled_b,
-	qdss_ctitrig_in_a0, qdss_ctitrig_in_a1, qdss_ctitrig_in_b0,
-	qdss_ctitrig_in_b1, qdss_ctitrig_out_a0, qdss_ctitrig_out_a1,
-	qdss_ctitrig_out_b0, qdss_ctitrig_out_b1, qdss_traceclk_a,
-	qdss_traceclk_b, qdss_tracectl_a, qdss_tracectl_b, qdss_tracedata_a,
-	qdss_tracedata_b, reset_n, sd_card, sd_write, sec_mi2s, smb_int,
-	ssbi_wtr0, ssbi_wtr1, uim1, uim2, uim3, uim_batt, wcss_bt, wcss_fm,
-	wcss_wlan, webcam1_rst
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
-	tlmm: pinctrl@1000000 {
-		compatible = "qcom,msm8916-pinctrl";
-		reg = <0x1000000 0x300000>;
-		interrupts = <0 208 0>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		gpio-ranges = <&tlmm 0 0 122>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-
-		uart2: uart2-default {
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
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.yaml
new file mode 100644
index 000000000000..7ab5995fbbbf
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.yaml
@@ -0,0 +1,166 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,msm8916-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm MSM8916 TLMM pin controller
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm MSM8916 SoC.
+
+properties:
+  compatible:
+    const: qcom,msm8916-pinctrl
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
+    maxItems: 61
+
+  gpio-line-names:
+    maxItems: 122
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-msm8916-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-msm8916-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-msm8916-tlmm-state:
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
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-1][0-9]|12[0-1])$"
+            - enum: [ qdsd_cmd, qdsd_data0, qdsd_data1, qdsd_data2, qdsd_data3,
+                      sdc1_clk, sdc1_cmd, sdc1_data, sdc2_clk, sdc2_cmd,
+                      sdc2_data ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+        enum: [ gpio, adsp_ext, alsp_int, atest_bbrx0, atest_bbrx1, atest_char,
+                atest_char0, atest_char1, atest_char2, atest_char3,
+                atest_combodac, atest_gpsadc0, atest_gpsadc1, atest_tsens,
+                atest_wlan0, atest_wlan1, backlight_en, bimc_dte0, bimc_dte1,
+                blsp_i2c1, blsp_i2c2, blsp_i2c3, blsp_i2c4, blsp_i2c5,
+                blsp_i2c6, blsp_spi1, blsp_spi1_cs1, blsp_spi1_cs2,
+                blsp_spi1_cs3, blsp_spi2, blsp_spi2_cs1, blsp_spi2_cs2,
+                blsp_spi2_cs3, blsp_spi3, blsp_spi3_cs1, blsp_spi3_cs2,
+                blsp_spi3_cs3, blsp_spi4, blsp_spi5, blsp_spi6, blsp_uart1,
+                blsp_uart2, blsp_uim1, blsp_uim2, cam1_rst, cam1_standby,
+                cam_mclk0, cam_mclk1, cci_async, cci_i2c, cci_timer0,
+                cci_timer1, cci_timer2, cdc_pdm0, codec_mad, dbg_out,
+                display_5v, dmic0_clk, dmic0_data, dsi_rst, ebi0_wrcdc,
+                euro_us, ext_lpass, flash_strobe, gcc_gp1_clk_a, gcc_gp1_clk_b,
+                gcc_gp2_clk_a, gcc_gp2_clk_b, gcc_gp3_clk_a, gcc_gp3_clk_b,
+                gsm0_tx0, gsm0_tx1, gsm1_tx0, gsm1_tx1, gyro_accl, kpsns0,
+                kpsns1, kpsns2, ldo_en, ldo_update, mag_int, mdp_vsync,
+                modem_tsync, m_voc, nav_pps, nav_tsync, pa_indicator, pbs0,
+                pbs1, pbs2, pri_mi2s, pri_mi2s_ws, prng_rosc,
+                pwr_crypto_enabled_a, pwr_crypto_enabled_b,
+                pwr_modem_enabled_a, pwr_modem_enabled_b, pwr_nav_enabled_a,
+                pwr_nav_enabled_b, qdss_ctitrig_in_a0, qdss_ctitrig_in_a1,
+                qdss_ctitrig_in_b0, qdss_ctitrig_in_b1, qdss_ctitrig_out_a0,
+                qdss_ctitrig_out_a1, qdss_ctitrig_out_b0, qdss_ctitrig_out_b1,
+                qdss_traceclk_a, qdss_traceclk_b, qdss_tracectl_a,
+                qdss_tracectl_b, qdss_tracedata_a, qdss_tracedata_b, reset_n,
+                sd_card, sd_write, sec_mi2s, smb_int, ssbi_wtr0, ssbi_wtr1,
+                uim1, uim2, uim3, uim_batt, wcss_bt, wcss_fm, wcss_wlan,
+                webcam1_rst ]
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
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    msmgpio: pinctrl@1000000 {
+        compatible = "qcom,msm8916-pinctrl";
+        reg = <0x01000000 0x300000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        gpio-ranges = <&msmgpio 0 0 122>;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+
+        spi1-default-state {
+            spi-pins {
+                pins = "gpio0", "gpio1", "gpio3";
+                function = "blsp_spi1";
+
+                drive-strength = <12>;
+                bias-disable;
+            };
+
+            cs-pins {
+                pins = "gpio2";
+                function = "gpio";
+
+                drive-strength = <16>;
+                bias-disable;
+                output-high;
+            };
+        };
+
+        spi1-sleep-state {
+            pins = "gpio0", "gpio1", "gpio2", "gpio3";
+            function = "gpio";
+
+            drive-strength = <2>;
+            bias-pull-down;
+        };
+    };
-- 
2.34.1

