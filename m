Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2727621641
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbiKHOZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbiKHOZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:25:24 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101E754B36
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 06:24:03 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id z24so21345378ljn.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 06:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kzxTV0X+yQxXJgZlrlaClTgQHtvgc1ORzzoobFuqWL0=;
        b=NNWN8VT07DCC3zDfTVTAG14DrKNcDUhkMCeJG4wKqNPfOCeu3/+5fKWcgPUSBYBcao
         qSlVXfb7G/v2Qm0KlRhXYCe/GN218qFxST+DFzCGFpf8RId9qM2p2M/8/iW0KzuLozuH
         n9h/aw+vOM1VXBjZ4+qvUNG00ognxosf4wenhMjFdv2RUWay068kdc4SOEc3OiWdbyZq
         3RlYxLBw4xiOPE+QzLkW4LAoJ0l1VAb7ZOgXFSFCzLbjYTZ7CuT7VEwlsf2LOgTr57I5
         KqSBJpETWyw0QHz7UC/bT0WopfYD4gNZIfpOFvaLBv97Yhjw2o851rjLMDsf3ycUPTfU
         bCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzxTV0X+yQxXJgZlrlaClTgQHtvgc1ORzzoobFuqWL0=;
        b=6JaH34oLadAI+l59d091x2emu0k5EWdZ21+0zhlu6cTmLi1jbnZgbAcwRq3l8Vah0j
         XmXSeqRmjjLMgDCQZpkM9RospJC9YJMCdxU2Pxjbq+xOD0nTMT9Zwv7AdSLsErIMutHz
         hfa04uD3cL7UjVuVRJ1+RrsXN12T24MrRGca2Z11TeeKkWjyZDlVLVRFSPWDea7WWlMc
         th+mLy+AvrdEjoaiyYEoArQqhztWIicZ79X34JEbEFTji2QKFABrFIkLLTW8rXNO8BHQ
         B65kMpJhcGmTBzUT9x32jBzz/SuAE3AchUlZ+DiIN/s5LctR2tIBSrhwgqP4lBjW1uxx
         suWg==
X-Gm-Message-State: ACrzQf3IGpP5GeDaDfxgX0CwckBDyYlGuvfYfyUjHotqzc5t8YelCDJS
        kPIoMeghw+LQOLk0tZfEoXYFbg==
X-Google-Smtp-Source: AMsMyM4Vy5pe2OBv3GnQlV4lMfJzqQNAIRrzEe4vfUOJlBhniW+3FPYt2Mm2bUK4Y48lVGOJjhEfgw==
X-Received: by 2002:a2e:8781:0:b0:26d:e758:ce84 with SMTP id n1-20020a2e8781000000b0026de758ce84mr18941581lji.178.1667917441301;
        Tue, 08 Nov 2022 06:24:01 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id k7-20020ac24f07000000b004a65780e4cfsm1815117lfr.106.2022.11.08.06.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 06:23:59 -0800 (PST)
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
Subject: [PATCH 1/2] dt-bindings: pinctrl: qcom,ipq8074: convert to dtschema
Date:   Tue,  8 Nov 2022 15:23:56 +0100
Message-Id: <20221108142357.67202-1-krzysztof.kozlowski@linaro.org>
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

Convert Qualcomm IPQ8074 pin controller bindings to DT schema.  Keep the
parsing of pin configuration subnodes consistent with other Qualcomm
schemas (children named with '-state' suffix, their children with
'-pins').

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,ipq8074-pinctrl.txt | 181 ------------------
 .../pinctrl/qcom,ipq8074-pinctrl.yaml         | 135 +++++++++++++
 2 files changed, 135 insertions(+), 181 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.txt
deleted file mode 100644
index 7b151894f5a0..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.txt
+++ /dev/null
@@ -1,181 +0,0 @@
-Qualcomm Technologies, Inc. IPQ8074 TLMM block
-
-This binding describes the Top Level Mode Multiplexer block found in the
-IPQ8074 platform.
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be "qcom,ipq8074-pinctrl"
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
-		    gpio0-gpio69
-
-- function:
-	Usage: required
-	Value type: <string>
-	Definition: Specify the alternative function to be configured for the
-		    specified pins. Functions are only valid for gpio pins.
-		    Valid values are:
-		    atest_char, atest_char0, atest_char1, atest_char2,
-		    atest_char3, audio_rxbclk, audio_rxd, audio_rxfsync,
-		    audio_rxmclk, audio_txbclk, audio_txd, audio_txfsync,
-		    audio_txmclk, blsp0_i2c, blsp0_spi, blsp0_uart, blsp1_i2c,
-		    blsp1_spi, blsp1_uart, blsp2_i2c, blsp2_spi, blsp2_uart,
-		    blsp3_i2c, blsp3_spi, blsp3_spi0, blsp3_spi1, blsp3_spi2,
-		    blsp3_spi3, blsp3_uart, blsp4_i2c0, blsp4_i2c1, blsp4_spi0,
-		    blsp4_spi1, blsp4_uart0, blsp4_uart1, blsp5_i2c, blsp5_spi,
-		    blsp5_uart, burn0, burn1, cri_trng, cri_trng0, cri_trng1,
-		    cxc0, cxc1, dbg_out, gcc_plltest, gcc_tlmm, gpio, ldo_en,
-		    ldo_update, led0, led1, led2, mac0_sa0, mac0_sa1, mac1_sa0,
-		    mac1_sa1, mac1_sa2, mac1_sa3, mac2_sa0, mac2_sa1, mdc,
-		    mdio, pcie0_clk, pcie0_rst, pcie0_wake, pcie1_clk,
-		    pcie1_rst, pcie1_wake, pcm_drx, pcm_dtx, pcm_fsync,
-		    pcm_pclk, pcm_zsi0, pcm_zsi1, prng_rosc, pta1_0, pta1_1,
-		    pta1_2, pta2_0, pta2_1, pta2_2, pwm0, pwm1, pwm2, pwm3,
-		    qdss_cti_trig_in_a0, qdss_cti_trig_in_a1,
-		    qdss_cti_trig_in_b0, qdss_cti_trig_in_b1,
-		    qdss_cti_trig_out_a0, qdss_cti_trig_out_a1,
-		    qdss_cti_trig_out_b0, qdss_cti_trig_out_b1,
-		    qdss_traceclk_a, qdss_traceclk_b, qdss_tracectl_a,
-		    qdss_tracectl_b, qdss_tracedata_a, qdss_tracedata_b,
-		    qpic, rx0, rx1, rx2, sd_card, sd_write, tsens_max, wci2a,
-		    wci2b, wci2c, wci2d
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
-
-- output-low:
-	Usage: optional
-	Value type: <none>
-	Definition: The specified pins are configured in output mode, driven
-		    low.
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
-		compatible = "qcom,ipq8074-pinctrl";
-		reg = <0x1000000 0x300000>;
-		interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		gpio-ranges = <&tlmm 0 0 70>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-
-		uart2: uart2-default {
-			mux {
-				pins = "gpio23", "gpio24";
-				function = "blsp4_uart1";
-			};
-
-			rx {
-				pins = "gpio23";
-				drive-strength = <4>;
-				bias-disable;
-			};
-
-			tx {
-				pins = "gpio24";
-				drive-strength = <2>;
-				bias-pull-up;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.yaml
new file mode 100644
index 000000000000..c02dd2ad9b31
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.yaml
@@ -0,0 +1,135 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,ipq8074-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm IPQ8074 TLMM pin controller
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm IPQ8074 SoC.
+
+properties:
+  compatible:
+    const: qcom,ipq8074-pinctrl
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
+    maxItems: 35
+
+  gpio-line-names:
+    maxItems: 70
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-ipq8074-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-ipq8074-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-ipq8074-tlmm-state:
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
+          pattern: "^gpio([0-9]|[1-6][0-9]|70)$"
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+        enum: [ gpio, atest_char, atest_char0, atest_char1, atest_char2,
+                atest_char3, audio_rxbclk, audio_rxd, audio_rxfsync,
+                audio_rxmclk, audio_txbclk, audio_txd, audio_txfsync,
+                audio_txmclk, blsp0_i2c, blsp0_spi, blsp0_uart, blsp1_i2c,
+                blsp1_spi, blsp1_uart, blsp2_i2c, blsp2_spi, blsp2_uart,
+                blsp3_i2c, blsp3_spi, blsp3_spi0, blsp3_spi1, blsp3_spi2,
+                blsp3_spi3, blsp3_uart, blsp4_i2c0, blsp4_i2c1, blsp4_spi0,
+                blsp4_spi1, blsp4_uart0, blsp4_uart1, blsp5_i2c, blsp5_spi,
+                blsp5_uart, burn0, burn1, cri_trng, cri_trng0, cri_trng1, cxc0,
+                cxc1, dbg_out, gcc_plltest, gcc_tlmm, ldo_en, ldo_update, led0,
+                led1, led2, mac0_sa0, mac0_sa1, mac1_sa0, mac1_sa1, mac1_sa2,
+                mac1_sa3, mac2_sa0, mac2_sa1, mdc, mdio, pcie0_clk, pcie0_rst,
+                pcie0_wake, pcie1_clk, pcie1_rst, pcie1_wake, pcm_drx, pcm_dtx,
+                pcm_fsync, pcm_pclk, pcm_zsi0, pcm_zsi1, prng_rosc, pta1_0,
+                pta1_1, pta1_2, pta2_0, pta2_1, pta2_2, pwm0, pwm1, pwm2, pwm3,
+                qdss_cti_trig_in_a0, qdss_cti_trig_in_a1, qdss_cti_trig_in_b0,
+                qdss_cti_trig_in_b1, qdss_cti_trig_out_a0,
+                qdss_cti_trig_out_a1, qdss_cti_trig_out_b0,
+                qdss_cti_trig_out_b1, qdss_traceclk_a, qdss_traceclk_b,
+                qdss_tracectl_a, qdss_tracectl_b, qdss_tracedata_a,
+                qdss_tracedata_b, qpic, rx0, rx1, rx2, sd_card, sd_write,
+                tsens_max, wci2a, wci2b, wci2c, wci2d ]
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
+    tlmm: pinctrl@1000000 {
+        compatible = "qcom,ipq8074-pinctrl";
+        reg = <0x01000000 0x300000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        gpio-ranges = <&tlmm 0 0 70>;
+        #gpio-cells = <0x2>;
+        interrupt-controller;
+        #interrupt-cells = <0x2>;
+
+        serial4-state {
+            pins = "gpio23", "gpio24";
+            function = "blsp4_uart1";
+            drive-strength = <8>;
+            bias-disable;
+        };
+    };
-- 
2.34.1

