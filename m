Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652335FC9A5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiJLQ70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJLQ7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:59:21 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23DFFE748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 09:59:19 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id cj27so10556744qtb.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 09:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQmvEnxCacSKmyhsDZfwB55uF8afbebAIdbb3HMdfts=;
        b=s6Wzx5P4f8uEwd+o6Qzs040cp30gJ6wUNosjjCWK/EwmGMuIhgM42PrbcogJ2eiu12
         aovwR2z9NRGsQNenpprlj2MvSlyvg988/0Esx2WJgxYMyxuFHreqXae4/CxGwpLwVqK6
         QysE73f1hzUAMecCRohR+cA6WeO5apFPx2DsWchMk7KzCmUQ00rZy28MdHdZWXs4XGHm
         Uhd+X0xYYCnQVaesXAAK5cUTYm+1gTybr+YMvQDU24tgKPxlv/9BC4bM4oR75oBDMbbF
         XAVCDrVF5eT0jABbeSkOgGkaqHZXC7SWvQ0cZg9DgjjDcYuzimuyv6Ck/jDpeyXSe6or
         xfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQmvEnxCacSKmyhsDZfwB55uF8afbebAIdbb3HMdfts=;
        b=RVZ+ndU0xHDlFjZToag9pwEHwlNnphdJAkAQLtIMARuv1XRX72h/RUBUr0jmFqKw1y
         OI2aSv4eQD1oH3FPwiFwSWbutY+wVRfPeF5avR0bJhMzBIN/A8Q7dAk4wDPxhlyWgT53
         1dRLev6/Q2f6ZQ6ptaQlfCbC8Ro2P8ZYHcSvqhGHWsMNVutF7R+p+noxlHchfNgFJtgF
         ptx/WsWO4HzoexAuP+CxtgZO4TXa6ULlIZay4IYVD378SwKOb/1pxrPHeNggR4cIvcAy
         RpwfTUVoEBPBSFGShwK3IUHHrZmD8s8gtL+rASuWcO3/kSSmUWRFIcqPYkHFhRUlXqkE
         4drQ==
X-Gm-Message-State: ACrzQf3nqOwEyAZw9gRUfexuo6eTCIet/nxrUEUzQxI5JP6HlBpDmHql
        vPoOW0WIb52WdUQBnNki5VtjBQ==
X-Google-Smtp-Source: AMsMyM65dtK7p0p/HXjsHGYyfbRzuz2UDQRLeNnp8iPJyAAVb/nn+f5tYXkqvMZe2HT8ejYK0hZ4Lg==
X-Received: by 2002:ac8:5208:0:b0:399:5248:aad2 with SMTP id r8-20020ac85208000000b003995248aad2mr15222060qtn.449.1665593958567;
        Wed, 12 Oct 2022 09:59:18 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id r4-20020a05622a034400b00398a7c860c2sm9476039qtw.4.2022.10.12.09.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 09:59:18 -0700 (PDT)
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
Subject: [PATCH 3/3] dt-bindings: pinctrl: qcom,msm8994: convert to dtschema
Date:   Wed, 12 Oct 2022 12:57:12 -0400
Message-Id: <20221012165712.93053-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221012165712.93053-1-krzysztof.kozlowski@linaro.org>
References: <20221012165712.93053-1-krzysztof.kozlowski@linaro.org>
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

Convert Qualcomm MSM8994 pin controller bindings to DT schema.  Keep the
parsing of pin configuration subnodes consistent with other Qualcomm
schemas (children named with '-state' suffix, their children with
'-pins').

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,msm8994-pinctrl.txt | 186 ------------------
 .../pinctrl/qcom,msm8994-pinctrl.yaml         | 167 ++++++++++++++++
 2 files changed, 167 insertions(+), 186 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.txt
deleted file mode 100644
index da52df6273bc..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.txt
+++ /dev/null
@@ -1,186 +0,0 @@
-Qualcomm MSM8994 TLMM block
-
-This binding describes the Top Level Mode Multiplexer block found in the
-MSM8994 platform.
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: Should contain one of:
-		    "qcom,msm8992-pinctrl",
-		    "qcom,msm8994-pinctrl".
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
-		      gpio0-gpio145
-		        Supports mux, bias and drive-strength
-
-		      sdc1_clk, sdc1_cmd, sdc1_data sdc1_rclk, sdc2_clk,
-		      sdc2_cmd, sdc2_data
-		        Supports bias and drive-strength
-
-- function:
-	Usage: required
-	Value type: <string>
-	Definition: Specify the alternative function to be configured for the
-		    specified pins. Functions are only valid for gpio pins.
-		    Valid values are:
-
-		    audio_ref_clk,  blsp_i2c1, blsp_i2c2, blsp_i2c3, blsp_i2c4, blsp_i2c5,
-		    blsp_i2c6, blsp_i2c7, blsp_i2c8, blsp_i2c9, blsp_i2c10, blsp_i2c11,
-		    blsp_i2c12, blsp_spi1, blsp_spi1_cs1, blsp_spi1_cs2, blsp_spi1_cs3,
-		    blsp_spi2, blsp_spi2_cs1, blsp_spi2_cs2, blsp_spi2_cs3, blsp_spi3,
-		    blsp_spi4, blsp_spi5, blsp_spi6, blsp_spi7, blsp_spi8, blsp_spi9,
-		    blsp_spi10, blsp_spi10_cs1, blsp_spi10_cs2, blsp_spi10_cs3, blsp_spi11,
-		    blsp_spi12, blsp_uart1, blsp_uart2, blsp_uart3, blsp_uart4, blsp_uart5,
-		    blsp_uart6, blsp_uart7, blsp_uart8, blsp_uart9, blsp_uart10, blsp_uart11,
-		    blsp_uart12, blsp_uim1, blsp_uim2, blsp_uim3, blsp_uim4, blsp_uim5,
-		    blsp_uim6, blsp_uim7, blsp_uim8, blsp_uim9, blsp_uim10, blsp_uim11,
-		    blsp_uim12, blsp11_i2c_scl_b, blsp11_i2c_sda_b, blsp11_uart_rx_b,
-		    blsp11_uart_tx_b, cam_mclk0, cam_mclk1, cam_mclk2, cam_mclk3,
-		    cci_async_in0, cci_async_in1, cci_async_in2, cci_i2c0, cci_i2c1,
-		    cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4,
-		    gcc_gp1_clk_a, gcc_gp1_clk_b, gcc_gp2_clk_a, gcc_gp2_clk_b, gcc_gp3_clk_a,
-		    gcc_gp3_clk_b, gp_mn, gp_pdm0, gp_pdm1, gp_pdm2, gp0_clk,
-		    gp1_clk, gps_tx, gsm_tx, hdmi_cec, hdmi_ddc, hdmi_hpd, hdmi_rcv,
-		    mdp_vsync, mss_lte, nav_pps, nav_tsync, qdss_cti_trig_in_a,
-		    qdss_cti_trig_in_b, qdss_cti_trig_in_c, qdss_cti_trig_in_d,
-		    qdss_cti_trig_out_a, qdss_cti_trig_out_b, qdss_cti_trig_out_c,
-		    qdss_cti_trig_out_d, qdss_traceclk_a, qdss_traceclk_b, qdss_tracectl_a,
-		    qdss_tracectl_b, qdss_tracedata_a, qdss_tracedata_b, qua_mi2s, pci_e0,
-		    pci_e1, pri_mi2s, sdc4, sec_mi2s, slimbus, spkr_i2s, ter_mi2s, tsif1,
-		    tsif2, uim_batt_alarm, uim1, uim2, uim3, uim4, gpio
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
-	msmgpio: pinctrl@fd510000 {
-		compatible = "qcom,msm8994-pinctrl";
-		reg = <0xfd510000 0x4000>;
-		interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		gpio-ranges = <&msmgpio 0 0 146>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-
-		blsp1_uart2_default: blsp1_uart2_default {
-			pinmux {
-				pins = "gpio4", "gpio5";
-				function = "blsp_uart2";
-			};
-			pinconf {
-				pins = "gpio4", "gpio5";
-				drive-strength = <16>;
-				bias-disable;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.yaml
new file mode 100644
index 000000000000..611a51269487
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.yaml
@@ -0,0 +1,167 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,msm8994-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm MSM8994 TLMM pin controller
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm MSM8994 SoC.
+
+properties:
+  compatible:
+    enum:
+      - qcom,msm8992-pinctrl
+      - qcom,msm8994-pinctrl
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
+      - $ref: "#/$defs/qcom-msm8994-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-msm8994-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-msm8994-tlmm-state:
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
+            - enum: [ sdc1_clk, sdc1_cmd, sdc1_data, sdc1_rclk, sdc2_clk,
+                      sdc2_cmd, sdc2_data, sdc3_clk, sdc3_cmd, sdc3_data ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+        enum: [ gpio, audio_ref_clk, blsp_i2c1, blsp_i2c2, blsp_i2c3,
+                blsp_i2c4, blsp_i2c5, blsp_i2c6, blsp_i2c7, blsp_i2c8,
+                blsp_i2c9, blsp_i2c10, blsp_i2c11, blsp_i2c12, blsp_spi1,
+                blsp_spi1_cs1, blsp_spi1_cs2, blsp_spi1_cs3, blsp_spi2,
+                blsp_spi2_cs1, blsp_spi2_cs2, blsp_spi2_cs3, blsp_spi3,
+                blsp_spi4, blsp_spi5, blsp_spi6, blsp_spi7, blsp_spi8,
+                blsp_spi9, blsp_spi10, blsp_spi10_cs1, blsp_spi10_cs2,
+                blsp_spi10_cs3, blsp_spi11, blsp_spi12, blsp_uart1, blsp_uart2,
+                blsp_uart3, blsp_uart4, blsp_uart5, blsp_uart6, blsp_uart7,
+                blsp_uart8, blsp_uart9, blsp_uart10, blsp_uart11, blsp_uart12,
+                blsp_uim1, blsp_uim2, blsp_uim3, blsp_uim4, blsp_uim5,
+                blsp_uim6, blsp_uim7, blsp_uim8, blsp_uim9, blsp_uim10,
+                blsp_uim11, blsp_uim12, blsp11_i2c_scl_b, blsp11_i2c_sda_b,
+                blsp11_uart_rx_b, blsp11_uart_tx_b, cam_mclk0, cam_mclk1,
+                cam_mclk2, cam_mclk3, cci_async_in0, cci_async_in1,
+                cci_async_in2, cci_i2c0, cci_i2c1, cci_timer0, cci_timer1,
+                cci_timer2, cci_timer3, cci_timer4, gcc_gp1_clk_a,
+                gcc_gp1_clk_b, gcc_gp2_clk_a, gcc_gp2_clk_b, gcc_gp3_clk_a,
+                gcc_gp3_clk_b, gp_mn, gp_pdm0, gp_pdm1, gp_pdm2, gp0_clk,
+                gp1_clk, gps_tx, gsm_tx, hdmi_cec, hdmi_ddc, hdmi_hpd,
+                hdmi_rcv, mdp_vsync, mss_lte, nav_pps, nav_tsync,
+                qdss_cti_trig_in_a, qdss_cti_trig_in_b, qdss_cti_trig_in_c,
+                qdss_cti_trig_in_d, qdss_cti_trig_out_a, qdss_cti_trig_out_b,
+                qdss_cti_trig_out_c, qdss_cti_trig_out_d, qdss_traceclk_a,
+                qdss_traceclk_b, qdss_tracectl_a, qdss_tracectl_b,
+                qdss_tracedata_a, qdss_tracedata_b, qua_mi2s, pci_e0, pci_e1,
+                pri_mi2s, sdc4, sec_mi2s, slimbus, spkr_i2s, ter_mi2s, tsif1,
+                tsif2, uim_batt_alarm, uim1, uim2, uim3, uim4 ]
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
+    tlmm: pinctrl@fd510000 {
+        compatible = "qcom,msm8994-pinctrl";
+        reg = <0xfd510000 0x4000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        gpio-ranges = <&tlmm 0 0 146>;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+
+        blsp1-uart2-default-state {
+            function = "blsp_uart2";
+            pins = "gpio4", "gpio5";
+            drive-strength = <16>;
+            bias-disable;
+        };
+
+        blsp1-spi1-default-state {
+            default-pins {
+                pins = "gpio0", "gpio1", "gpio3";
+                function = "blsp_spi1";
+                drive-strength = <10>;
+                bias-pull-down;
+            };
+
+            cs-pins {
+                pins = "gpio8";
+                function = "gpio";
+                drive-strength = <2>;
+                bias-disable;
+            };
+        };
+    };
-- 
2.34.1

