Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9819603063
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiJRP6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiJRP60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:58:26 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC8FC1D85
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:58:23 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id z18so9554118qvn.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/luzpP2yRkVKKVwlofnc2HgPW3Tkf2DbTaRAwlckXY=;
        b=MpZgPXP5JfdW9pgURkxhMR6zrcREQV7O9OLO76g6TAVGcu1zQQcPXlyHH253LMdn/+
         d9w/o/CzRvJyYfmr5TmJz8KZuCM+nJsQgsPpxNcaIe8NgRZZ7sVKFTSKlfRP18vbSmiE
         BIgjuZVO7pppaFaQy+jais5NeF/S4JE5MXTHBRxfSTH2lLkHuRzMkh2SMf9xslodcOJR
         IVOMUL+50NuylJcVJB+ooUGJhUJUcDhzA+uk5/I+l2d55MVsioBKXAu5qk+BOG/aveLb
         O8lWqWsYYQcrX9WtC8M21Avj7ebCGfWufX/56PZyeGBWrFAxi3jnhEho/RVjjl5ziIX2
         w1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/luzpP2yRkVKKVwlofnc2HgPW3Tkf2DbTaRAwlckXY=;
        b=CyRJvnN7zLoR2hOEPnZTGZh8i8AYRxUaC6snhQU7h/Yovv3jTohCyw0W+F4BTqWVkb
         Fs0Kq9Iu7NRU1KeqMsGvONGsUsoRZa6K7epztq/Rw97O91pPPluXPP0xy5deE/Jy3N6f
         rE/1F1uHTiUpDoUeecjJ2ucZcWE96ryupn2mhFout5EnEzxM8S9QfEtt7XmMZ+A3S2y2
         LARuGHfyRR5g4xJhPpERGueatAtFYoaZSu6urJo5EpWygazQVmsVwonUKGZPwGj35dJK
         /dU7oDAvJ/og3lR4te32XgSGr7UKu0h5OXo4HRreayiQDu1x2swsdjvNRrZvB7b13MCU
         VZZA==
X-Gm-Message-State: ACrzQf1svuDWkViLZ/4Pz6R3zQLdTWnPEBaKCsKvKwjFDVNMVwtAQ2FA
        k5vt7wNhNCxsODT+BX333YFBHg==
X-Google-Smtp-Source: AMsMyM6XQ6gLb+lJ29N1UbfmKviVaoQv/maS4jFkK5I47b/awxSP1HhwWIzM/ac1o6kG2kruFIFoJA==
X-Received: by 2002:a0c:ac02:0:b0:4af:a3b1:3167 with SMTP id l2-20020a0cac02000000b004afa3b13167mr2868167qvb.66.1666108701785;
        Tue, 18 Oct 2022 08:58:21 -0700 (PDT)
Received: from krzk-bin.MSRM (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id de38-20020a05620a372600b006ce30a5f892sm2721448qkb.102.2022.10.18.08.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:58:21 -0700 (PDT)
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
Subject: [PATCH v3 3/3] dt-bindings: pinctrl: qcom,msm8996: convert to dtschema
Date:   Tue, 18 Oct 2022 11:57:21 -0400
Message-Id: <20221018155721.47140-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018155721.47140-1-krzysztof.kozlowski@linaro.org>
References: <20221018155721.47140-1-krzysztof.kozlowski@linaro.org>
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

Convert Qualcomm MSM8996 pin controller bindings to DT schema.  Keep the
parsing of pin configuration subnodes consistent with other Qualcomm
schemas (children named with '-state' suffix, their children with
'-pins').

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v2:
1. Drop entire drive-strength (not needed, brought by common TLMM
   schema).

Changes since v1:
1. Drop default:2 for drive strength.
2. Add Rb tag.
3. Drop ufs_reset from supported pin functions.
---
 .../bindings/pinctrl/qcom,msm8996-pinctrl.txt | 208 ------------------
 .../pinctrl/qcom,msm8996-pinctrl.yaml         | 182 +++++++++++++++
 2 files changed, 182 insertions(+), 208 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.txt
deleted file mode 100644
index a56cb882830c..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.txt
+++ /dev/null
@@ -1,208 +0,0 @@
-Qualcomm MSM8996 TLMM block
-
-This binding describes the Top Level Mode Multiplexer block found in the
-MSM8996 platform.
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be "qcom,msm8996-pinctrl"
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
-		      sdc1_clk, sdc1_cmd, sdc1_data sdc2_clk, sdc2_cmd,
-		      sdc2_data sdc1_rclk
-		        Supports bias and drive-strength
-
-- function:
-	Usage: required
-	Value type: <string>
-	Definition: Specify the alternative function to be configured for the
-		    specified pins. Functions are only valid for gpio pins.
-		    Valid values are:
-
-		    blsp_uart1, blsp_spi1, blsp_i2c1, blsp_uim1, atest_tsens,
-		    bimc_dte1, dac_calib0, blsp_spi8, blsp_uart8, blsp_uim8,
-		    qdss_cti_trig_out_b, bimc_dte0, dac_calib1, qdss_cti_trig_in_b,
-		    dac_calib2, atest_tsens2, atest_usb1, blsp_spi10, blsp_uart10,
-		    blsp_uim10, atest_bbrx1, atest_usb13, atest_bbrx0, atest_usb12,
-		    mdp_vsync, edp_lcd, blsp_i2c10, atest_gpsadc1, atest_usb11,
-		    atest_gpsadc0, edp_hot, atest_usb10, m_voc, dac_gpio, atest_char,
-		    cam_mclk, pll_bypassnl, qdss_stm7, blsp_i2c8, qdss_tracedata_b,
-		    pll_reset, qdss_stm6, qdss_stm5, qdss_stm4, atest_usb2, cci_i2c,
-		    qdss_stm3, dac_calib3, atest_usb23, atest_char3, dac_calib4,
-		    qdss_stm2, atest_usb22, atest_char2, qdss_stm1, dac_calib5,
-		    atest_usb21, atest_char1, dbg_out, qdss_stm0, dac_calib6,
-		    atest_usb20, atest_char0, dac_calib10, qdss_stm10,
-		    qdss_cti_trig_in_a, cci_timer4, blsp_spi6, blsp_uart6, blsp_uim6,
-		    blsp2_spi, qdss_stm9, qdss_cti_trig_out_a, dac_calib11,
-		    qdss_stm8, cci_timer0, qdss_stm13, dac_calib7, cci_timer1,
-		    qdss_stm12, dac_calib8, cci_timer2, blsp1_spi, qdss_stm11,
-		    dac_calib9, cci_timer3, cci_async, dac_calib12, blsp_i2c6,
-		    qdss_tracectl_a, dac_calib13, qdss_traceclk_a, dac_calib14,
-		    dac_calib15, hdmi_rcv, dac_calib16, hdmi_cec, pwr_modem,
-		    dac_calib17, hdmi_ddc, pwr_nav, dac_calib18, pwr_crypto,
-		    dac_calib19, hdmi_hot, dac_calib20, dac_calib21, pci_e0,
-		    dac_calib22, dac_calib23, dac_calib24, tsif1_sync, dac_calib25,
-		    sd_write, tsif1_error, blsp_spi2, blsp_uart2, blsp_uim2,
-		    qdss_cti, blsp_i2c2, blsp_spi3, blsp_uart3, blsp_uim3, blsp_i2c3,
-		    uim3, blsp_spi9, blsp_uart9, blsp_uim9, blsp10_spi, blsp_i2c9,
-		    blsp_spi7, blsp_uart7, blsp_uim7, qdss_tracedata_a, blsp_i2c7,
-		    qua_mi2s, gcc_gp1_clk_a, ssc_irq, uim4, blsp_spi11, blsp_uart11,
-		    blsp_uim11, gcc_gp2_clk_a, gcc_gp3_clk_a, blsp_i2c11, cri_trng0,
-		    cri_trng1, cri_trng, qdss_stm18, pri_mi2s, qdss_stm17, blsp_spi4,
-		    blsp_uart4, blsp_uim4, qdss_stm16, qdss_stm15, blsp_i2c4,
-		    qdss_stm14, dac_calib26, spkr_i2s, audio_ref, lpass_slimbus,
-		    isense_dbg, tsense_pwm1, tsense_pwm2, btfm_slimbus, ter_mi2s,
-		    qdss_stm22, qdss_stm21, qdss_stm20, qdss_stm19, gcc_gp1_clk_b,
-		    sec_mi2s, blsp_spi5, blsp_uart5, blsp_uim5, gcc_gp2_clk_b,
-		    gcc_gp3_clk_b, blsp_i2c5, blsp_spi12, blsp_uart12, blsp_uim12,
-		    qdss_stm25, qdss_stm31, blsp_i2c12, qdss_stm30, qdss_stm29,
-		    tsif1_clk, qdss_stm28, tsif1_en, tsif1_data, sdc4_cmd, qdss_stm27,
-		    qdss_traceclk_b, tsif2_error, sdc43, vfr_1, qdss_stm26, tsif2_clk,
-		    sdc4_clk, qdss_stm24, tsif2_en, sdc42, qdss_stm23, qdss_tracectl_b,
-		    sd_card, tsif2_data, sdc41, tsif2_sync, sdc40, mdp_vsync_p_b,
-		    ldo_en, mdp_vsync_s_b, ldo_update, blsp11_uart_tx_b, blsp11_uart_rx_b,
-		    blsp11_i2c_sda_b, prng_rosc, blsp11_i2c_scl_b, uim2, uim1, uim_batt,
-		    pci_e2, pa_indicator, adsp_ext, ddr_bist, qdss_tracedata_11,
-		    qdss_tracedata_12, modem_tsync, nav_dr, nav_pps, pci_e1, gsm_tx,
-		    qspi_cs, ssbi2, ssbi1, mss_lte, qspi_clk, qspi0, qspi1, qspi2, qspi3,
-		    gpio
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
-	tlmm: pinctrl@1010000 {
-		compatible = "qcom,msm8996-pinctrl";
-		reg = <0x01010000 0x300000>;
-		interrupts = <0 208 0>;
-		gpio-controller;
-		gpio-ranges = <&tlmm 0 0 150>;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-
-		uart_console_active: uart_console_active {
-			mux {
-				pins = "gpio4", "gpio5";
-				function = "blsp_uart8";
-			};
-
-			config {
-				pins = "gpio4", "gpio5";
-				drive-strength = <2>;
-				bias-disable;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.yaml
new file mode 100644
index 000000000000..8e1cd4ba1116
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.yaml
@@ -0,0 +1,182 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,msm8996-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm MSM8996 TLMM pin controller
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm MSM8996 SoC.
+
+properties:
+  compatible:
+    const: qcom,msm8996-pinctrl
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
+      - $ref: "#/$defs/qcom-msm8996-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-msm8996-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-msm8996-tlmm-state:
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
+                      sdc2_cmd, sdc2_data ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+        enum: [ gpio, blsp_uart1, blsp_spi1, blsp_i2c1, blsp_uim1, atest_tsens,
+                bimc_dte1, dac_calib0, blsp_spi8, blsp_uart8, blsp_uim8,
+                qdss_cti_trig_out_b, bimc_dte0, dac_calib1, qdss_cti_trig_in_b,
+                dac_calib2, atest_tsens2, atest_usb1, blsp_spi10, blsp_uart10,
+                blsp_uim10, atest_bbrx1, atest_usb13, atest_bbrx0, atest_usb12,
+                mdp_vsync, edp_lcd, blsp_i2c10, atest_gpsadc1, atest_usb11,
+                atest_gpsadc0, edp_hot, atest_usb10, m_voc, dac_gpio,
+                atest_char, cam_mclk, pll_bypassnl, qdss_stm7, blsp_i2c8,
+                qdss_tracedata_b, pll_reset, qdss_stm6, qdss_stm5, qdss_stm4,
+                atest_usb2, cci_i2c, qdss_stm3, dac_calib3, atest_usb23,
+                atest_char3, dac_calib4, qdss_stm2, atest_usb22, atest_char2,
+                qdss_stm1, dac_calib5, atest_usb21, atest_char1, dbg_out,
+                qdss_stm0, dac_calib6, atest_usb20, atest_char0, dac_calib10,
+                qdss_stm10, qdss_cti_trig_in_a, cci_timer4, blsp_spi6,
+                blsp_uart6, blsp_uim6, blsp2_spi, qdss_stm9,
+                qdss_cti_trig_out_a, dac_calib11, qdss_stm8, cci_timer0,
+                qdss_stm13, dac_calib7, cci_timer1, qdss_stm12, dac_calib8,
+                cci_timer2, blsp1_spi, qdss_stm11, dac_calib9, cci_timer3,
+                cci_async, dac_calib12, blsp_i2c6, qdss_tracectl_a,
+                dac_calib13, qdss_traceclk_a, dac_calib14, dac_calib15,
+                hdmi_rcv, dac_calib16, hdmi_cec, pwr_modem, dac_calib17,
+                hdmi_ddc, pwr_nav, dac_calib18, pwr_crypto, dac_calib19,
+                hdmi_hot, dac_calib20, dac_calib21, pci_e0, dac_calib22,
+                dac_calib23, dac_calib24, tsif1_sync, dac_calib25, sd_write,
+                tsif1_error, blsp_spi2, blsp_uart2, blsp_uim2, qdss_cti,
+                blsp_i2c2, blsp_spi3, blsp_uart3, blsp_uim3, blsp_i2c3, uim3,
+                blsp_spi9, blsp_uart9, blsp_uim9, blsp10_spi, blsp_i2c9,
+                blsp_spi7, blsp_uart7, blsp_uim7, qdss_tracedata_a, blsp_i2c7,
+                qua_mi2s, gcc_gp1_clk_a, ssc_irq, uim4, blsp_spi11,
+                blsp_uart11, blsp_uim11, gcc_gp2_clk_a, gcc_gp3_clk_a,
+                blsp_i2c11, cri_trng0, cri_trng1, cri_trng, qdss_stm18,
+                pri_mi2s, qdss_stm17, blsp_spi4, blsp_uart4, blsp_uim4,
+                qdss_stm16, qdss_stm15, blsp_i2c4, qdss_stm14, dac_calib26,
+                spkr_i2s, audio_ref, lpass_slimbus, isense_dbg, tsense_pwm1,
+                tsense_pwm2, btfm_slimbus, ter_mi2s, qdss_stm22, qdss_stm21,
+                qdss_stm20, qdss_stm19, gcc_gp1_clk_b, sec_mi2s, blsp_spi5,
+                blsp_uart5, blsp_uim5, gcc_gp2_clk_b, gcc_gp3_clk_b, blsp_i2c5,
+                blsp_spi12, blsp_uart12, blsp_uim12, qdss_stm25, qdss_stm31,
+                blsp_i2c12, qdss_stm30, qdss_stm29, tsif1_clk, qdss_stm28,
+                tsif1_en, tsif1_data, sdc4_cmd, qdss_stm27, qdss_traceclk_b,
+                tsif2_error, sdc43, vfr_1, qdss_stm26, tsif2_clk, sdc4_clk,
+                qdss_stm24, tsif2_en, sdc42, qdss_stm23, qdss_tracectl_b,
+                sd_card, tsif2_data, sdc41, tsif2_sync, sdc40, mdp_vsync_p_b,
+                ldo_en, mdp_vsync_s_b, ldo_update, blsp11_uart_tx_b,
+                blsp11_uart_rx_b, blsp11_i2c_sda_b, prng_rosc,
+                blsp11_i2c_scl_b, uim2, uim1, uim_batt, pci_e2, pa_indicator,
+                adsp_ext, ddr_bist, qdss_tracedata_11, qdss_tracedata_12,
+                modem_tsync, nav_dr, nav_pps, pci_e1, gsm_tx, qspi_cs, ssbi2,
+                ssbi1, mss_lte, qspi_clk, qspi0, qspi1, qspi2, qspi3 ]
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
+    tlmm: pinctrl@1010000 {
+        compatible = "qcom,msm8996-pinctrl";
+        reg = <0x01010000 0x300000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        gpio-ranges = <&tlmm 0 0 150>;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+
+        blsp1-spi1-default-state {
+            spi-pins {
+                pins = "gpio0", "gpio1", "gpio3";
+                function = "blsp_spi1";
+                drive-strength = <12>;
+                bias-disable;
+            };
+
+            cs-pins {
+                pins = "gpio2";
+                function = "gpio";
+                drive-strength = <16>;
+                bias-disable;
+                output-high;
+            };
+        };
+
+        blsp1-spi1-sleep-state {
+            pins = "gpio0", "gpio1", "gpio2", "gpio3";
+            function = "gpio";
+            drive-strength = <2>;
+            bias-pull-down;
+        };
+    };
-- 
2.34.1

