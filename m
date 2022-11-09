Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F444622919
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiKIKvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiKIKvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:51:47 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A851E26DF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 02:51:44 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id g12so25058607lfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 02:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=poOKkeGrEJIbpcuFZSUDqK3F4A8QQkTEwfuqzpR49QQ=;
        b=omQsDrdnT5es1N1V/r0TQqgr0FutGUkXyWUfdDpP/BW9oamobE2u31WzrlUQHmUene
         nNcA6QmiyeMZmfyGP6+bP8RGhJparmFIJRW/PE2LNem0RBFZoBicVpZbXBPC7Tk0W8k1
         /Fi/eVpYuLpkPn7zGpnVsgIq5nalTI46oUEXi0jzK+oEsnO00rj4cfvX0lYq7Npx7a+d
         fHx/EB1P23Ns5g5yCF2SjWHghyelgmP//iOIkEr6FVDHHp4EzDGl+yKXkuVEg5+ezoHR
         fHrTM0QgvpV19GSqGQu4Rpiy3i4juMuWmFgHOMTZdF/A3MzwehB89mp147l+BesA3Qoq
         QhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=poOKkeGrEJIbpcuFZSUDqK3F4A8QQkTEwfuqzpR49QQ=;
        b=IqLSeL8JGDq9f2oyMldb+DbWCOMzNirnbjQ3bGU6ECEv8XUrKcfalcovo8tJDjxgQu
         mFNBhIGCzkcgJhClfgWpNb6gUBInSc4rAC1n1Kcpjj8s8GYpeA/ZWRoeHmk8KPQTWTaH
         TUZpo4lxdGkYJI8CrB2VPNn/go0YJKdVcejT06EK4kf2iQtfvBMHZdJvPwKP+Ev9CeQ9
         4Fi/BHsgiB6iKRv2UTiyTQvipZATdQ59EEvIhNFvlXEVuvxhB9x9DuPZRjPblt1BbhJz
         1dK9eB9gC2odU/f0cwcxZUEtSMNTCb03dQbmrStVCNmWawrhFUcA5x3jkjfREfMznjSw
         EONA==
X-Gm-Message-State: ANoB5pliNNzVqEGBsAaEH8pkvQGHMPv9e1lw+liz/Go1/fFW3MMM+kR0
        lpo7+ec+OT1szcWIJWA2luW8OohJF31fXg==
X-Google-Smtp-Source: AA0mqf6E1/UcpfA/AKrCuiVE8+PJuNiHCEMKAllRN7ZHo8SjMAKRRrAwEgLw5wscmoKQa4HoxQzREg==
X-Received: by 2002:a05:6512:38c9:b0:4b2:1a29:cc44 with SMTP id p9-20020a05651238c900b004b21a29cc44mr7168532lft.176.1667991102944;
        Wed, 09 Nov 2022 02:51:42 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id l10-20020a056512110a00b004b005150e92sm2167508lfg.127.2022.11.09.02.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 02:51:42 -0800 (PST)
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
Subject: [PATCH v2 1/3] dt-bindings: pinctrl: qcom,msm8960: convert to dtschema
Date:   Wed,  9 Nov 2022 11:51:38 +0100
Message-Id: <20221109105140.48196-1-krzysztof.kozlowski@linaro.org>
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

Convert Qualcomm MSM8960 pin controller bindings to DT schema.  Keep the
parsing of pin configuration subnodes consistent with other Qualcomm
schemas (children named with '-state' suffix, their children with
'-pins').

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Correct gpio pattern.
---
 .../bindings/pinctrl/qcom,msm8960-pinctrl.txt | 190 ------------------
 .../pinctrl/qcom,msm8960-pinctrl.yaml         | 164 +++++++++++++++
 2 files changed, 164 insertions(+), 190 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.txt
deleted file mode 100644
index a7dd213c77c6..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.txt
+++ /dev/null
@@ -1,190 +0,0 @@
-Qualcomm MSM8960 TLMM block
-
-This binding describes the Top Level Mode Multiplexer block found in the
-MSM8960 platform.
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be "qcom,msm8960-pinctrl"
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
-		    gpio0-gpio151,
-		    sdc1_clk,
-		    sdc1_cmd,
-		    sdc1_data
-		    sdc3_clk,
-		    sdc3_cmd,
-		    sdc3_data
-
-- function:
-	Usage: required
-	Value type: <string>
-	Definition: Specify the alternative function to be configured for the
-		    specified pins. Functions are only valid for gpio pins.
-		    Valid values are:
-		    audio_pcm, bt, cam_mclk0, cam_mclk1, cam_mclk2,
-		    codec_mic_i2s, codec_spkr_i2s, ext_gps, fm, gps_blanking,
-		    gps_pps_in, gps_pps_out, gp_clk_0a, gp_clk_0b, gp_clk_1a,
-		    gp_clk_1b, gp_clk_2a, gp_clk_2b, gp_mn, gp_pdm_0a,
-		    gp_pdm_0b, gp_pdm_1a, gp_pdm_1b, gp_pdm_2a, gp_pdm_2b, gpio,
-		    gsbi1, gsbi1_spi_cs1_n, gsbi1_spi_cs2a_n, gsbi1_spi_cs2b_n,
-		    gsbi1_spi_cs3_n, gsbi2, gsbi2_spi_cs1_n, gsbi2_spi_cs2_n,
-		    gsbi2_spi_cs3_n, gsbi3, gsbi4, gsbi4_3d_cam_i2c_l,
-		    gsbi4_3d_cam_i2c_r, gsbi5, gsbi5_3d_cam_i2c_l,
-		    gsbi5_3d_cam_i2c_r, gsbi6, gsbi7, gsbi8, gsbi9, gsbi10,
-		    gsbi11, gsbi11_spi_cs1a_n, gsbi11_spi_cs1b_n,
-		    gsbi11_spi_cs2a_n, gsbi11_spi_cs2b_n, gsbi11_spi_cs3_n,
-		    gsbi12, hdmi_cec, hdmi_ddc_clock, hdmi_ddc_data,
-		    hdmi_hot_plug_detect, hsic, mdp_vsync, mi2s, mic_i2s,
-		    pmb_clk, pmb_ext_ctrl, ps_hold, rpm_wdog, sdc2, sdc4, sdc5,
-		    slimbus1, slimbus2, spkr_i2s, ssbi1, ssbi2, ssbi_ext_gps,
-		    ssbi_pmic2, ssbi_qpa1, ssbi_ts, tsif1, tsif2, ts_eoc,
-		    usb_fs1, usb_fs1_oe, usb_fs1_oe_n, usb_fs2, usb_fs2_oe,
-		    usb_fs2_oe_n, vfe_camif_timer1_a, vfe_camif_timer1_b,
-		    vfe_camif_timer2, vfe_camif_timer3_a, vfe_camif_timer3_b,
-		    vfe_camif_timer4_a, vfe_camif_timer4_b, vfe_camif_timer4_c,
-		    vfe_camif_timer5_a, vfe_camif_timer5_b, vfe_camif_timer6_a,
-		    vfe_camif_timer6_b, vfe_camif_timer6_c, vfe_camif_timer7_a,
-		    vfe_camif_timer7_b, vfe_camif_timer7_c, wlan
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
-	msmgpio: pinctrl@800000 {
-		compatible = "qcom,msm8960-pinctrl";
-		reg = <0x800000 0x4000>;
-
-		gpio-controller;
-		#gpio-cells = <2>;
-		gpio-ranges = <&msmgpio 0 0 152>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <0 16 0x4>;
-
-		gsbi8_uart: gsbi8-uart {
-			mux {
-				pins = "gpio34", "gpio35";
-				function = "gsbi8";
-			};
-
-			tx {
-				pins = "gpio34";
-				drive-strength = <4>;
-				bias-disable;
-			};
-
-			rx {
-				pins = "gpio35";
-				drive-strength = <2>;
-				bias-pull-up;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.yaml
new file mode 100644
index 000000000000..9dc1b0b02b9b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.yaml
@@ -0,0 +1,164 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,msm8960-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm MSM8960 TLMM pin controller
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm MSM8960 SoC.
+
+properties:
+  compatible:
+    const: qcom,msm8960-pinctrl
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
+    maxItems: 76
+
+  gpio-line-names:
+    maxItems: 152
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-msm8960-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-msm8960-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-msm8960-tlmm-state:
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
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-4][0-9]|15[0-1])$"
+            - enum: [ sdc1_clk, sdc1_cmd, sdc1_data, sdc3_clk, sdc3_cmd,
+                      sdc3_data ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+        enum: [ gpio, audio_pcm, bt, cam_mclk0, cam_mclk1, cam_mclk2,
+                codec_mic_i2s, codec_spkr_i2s, ext_gps, fm, gps_blanking,
+                gps_pps_in, gps_pps_out, gp_clk_0a, gp_clk_0b, gp_clk_1a,
+                gp_clk_1b, gp_clk_2a, gp_clk_2b, gp_mn, gp_pdm_0a, gp_pdm_0b,
+                gp_pdm_1a, gp_pdm_1b, gp_pdm_2a, gp_pdm_2b, gsbi1,
+                gsbi1_spi_cs1_n, gsbi1_spi_cs2a_n, gsbi1_spi_cs2b_n,
+                gsbi1_spi_cs3_n, gsbi2, gsbi2_spi_cs1_n, gsbi2_spi_cs2_n,
+                gsbi2_spi_cs3_n, gsbi3, gsbi4, gsbi4_3d_cam_i2c_l,
+                gsbi4_3d_cam_i2c_r, gsbi5, gsbi5_3d_cam_i2c_l,
+                gsbi5_3d_cam_i2c_r, gsbi6, gsbi7, gsbi8, gsbi9, gsbi10, gsbi11,
+                gsbi11_spi_cs1a_n, gsbi11_spi_cs1b_n, gsbi11_spi_cs2a_n,
+                gsbi11_spi_cs2b_n, gsbi11_spi_cs3_n, gsbi12, hdmi_cec,
+                hdmi_ddc_clock, hdmi_ddc_data, hdmi_hot_plug_detect, hsic,
+                mdp_vsync, mi2s, mic_i2s, pmb_clk, pmb_ext_ctrl, ps_hold,
+                rpm_wdog, sdc2, sdc4, sdc5, slimbus1, slimbus2, spkr_i2s,
+                ssbi1, ssbi2, ssbi_ext_gps, ssbi_pmic2, ssbi_qpa1, ssbi_ts,
+                tsif1, tsif2, ts_eoc, usb_fs1, usb_fs1_oe, usb_fs1_oe_n,
+                usb_fs2, usb_fs2_oe, usb_fs2_oe_n, vfe_camif_timer1_a,
+                vfe_camif_timer1_b, vfe_camif_timer2, vfe_camif_timer3_a,
+                vfe_camif_timer3_b, vfe_camif_timer4_a, vfe_camif_timer4_b,
+                vfe_camif_timer4_c, vfe_camif_timer5_a, vfe_camif_timer5_b,
+                vfe_camif_timer6_a, vfe_camif_timer6_b, vfe_camif_timer6_c,
+                vfe_camif_timer7_a, vfe_camif_timer7_b, vfe_camif_timer7_c,
+                wlan ]
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
+    msmgpio: pinctrl@800000 {
+        compatible = "qcom,msm8960-pinctrl";
+        reg = <0x800000 0x4000>;
+        gpio-controller;
+        gpio-ranges = <&msmgpio 0 0 152>;
+        #gpio-cells = <2>;
+        interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+
+        spi1-default-state {
+            mosi-pins {
+                pins = "gpio6";
+                function = "gsbi1";
+                drive-strength = <12>;
+                bias-disable;
+            };
+
+            miso-pins {
+                pins = "gpio7";
+                function = "gsbi1";
+                drive-strength = <12>;
+                bias-disable;
+            };
+
+            cs-pins {
+                pins = "gpio8";
+                function = "gpio";
+                drive-strength = <12>;
+                bias-disable;
+                output-low;
+            };
+
+            clk-pins {
+                pins = "gpio9";
+                function = "gsbi1";
+                drive-strength = <12>;
+                bias-disable;
+            };
+        };
+    };
-- 
2.34.1

