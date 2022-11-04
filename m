Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED82619CB0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiKDQLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiKDQLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:11:38 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC444731E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:11:36 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id x21so3372527qkj.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 09:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2wrmGopd2SuEHcPg0XIzd7mEf4bj5oOXYDEQoz+QeQ=;
        b=ENfr+rnAZZUl1MFe62UhyhC4eug1BbPGSx8LFrPPsHBkVH6h+IiDjDi558eIhJDbfy
         5NVI4bhwfI0c+Bp+EvMU6u5glpHaDO21sGIvtqHPt3C4CDDrCXlOV99odayX3+LkF/hx
         S9P9kKuPUj2m+Y4IiUOtKrwAhb7QcevvEkh7KBF4hmOJPshO1yBDzl5avS3kTXbhnnr9
         uaQ7KDidNl9I2GWjrvg2f3uzCB8zBpjlTExxs10AyalD7cIV9CbTgRBg03udr+KMQjB1
         eUiEUzCw2XhFF2c4St/YI+hrwbYwCcTLfvpbyl/ld497IjYa1+2PEh2LVmmoMMNS2lRy
         Sbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2wrmGopd2SuEHcPg0XIzd7mEf4bj5oOXYDEQoz+QeQ=;
        b=PJtMvsggg+9HubCWZNXb9kw/BtFmVbKGzNqfBNH7yio5htcd3+6FVK8m99sIkQ167T
         YfqM+t/t+qNLlcNvQv7V6kWdn1LiAuWzeBrzpf76YQmYYNqmdDChMVl6nIAIjRQlNc79
         BgelGV2zVI/QvJJ/eXRbBHpBg4UfRefmLiytpZgM+zk0jVZ5b5DhK6ge2Ym53Zq6snjy
         U7Ug1xxbUNJZxx1rXalcGB9gYlf5ZIxCga3BNWiookrpte4yLiY2ALPY2AOUZy5LN4wZ
         aJMH+4eBVBTJeVkPXHf5Ko2l9pmHTAVZfayC8Oow4Evw82K5fx6j2gCfSVod1KHEBSM7
         pqGQ==
X-Gm-Message-State: ACrzQf1UHZMC/fcfZFALGjdCjlBdWzx3H+AvoKgiUyBCenTz9xe5dJW1
        QoWUQxxFHyLrzEM18N/gQWeitQ==
X-Google-Smtp-Source: AMsMyM5WD9eMuPHxfO29pIb1PAKf+911s8monr4hGIJU3TIXYi/5NSpkcUV3PbcNwPd4Uin3ZsZAjA==
X-Received: by 2002:a37:8981:0:b0:6f1:1560:ac7d with SMTP id l123-20020a378981000000b006f11560ac7dmr27050562qkd.659.1667578295581;
        Fri, 04 Nov 2022 09:11:35 -0700 (PDT)
Received: from krzk-bin.. ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id b6-20020a05620a0cc600b006e6a7c2a269sm3125370qkj.22.2022.11.04.09.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 09:11:35 -0700 (PDT)
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
Subject: [PATCH 2/2] dt-bindings: pinctrl: qcom,qcs404: convert to dtschema
Date:   Fri,  4 Nov 2022 12:11:31 -0400
Message-Id: <20221104161131.57719-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104161131.57719-1-krzysztof.kozlowski@linaro.org>
References: <20221104161131.57719-1-krzysztof.kozlowski@linaro.org>
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

Convert Qualcomm QCS404 pin controller bindings to DT schema.  Keep the
parsing of pin configuration subnodes consistent with other Qualcomm
schemas (children named with '-state' suffix, their children with
'-pins').

Changes during conversion: add sdc1_rclk pins (used in qcs404-evb.dtsi).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,qcs404-pinctrl.txt  | 199 ------------------
 .../bindings/pinctrl/qcom,qcs404-pinctrl.yaml | 176 ++++++++++++++++
 2 files changed, 176 insertions(+), 199 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.txt
deleted file mode 100644
index a50e74684195..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.txt
+++ /dev/null
@@ -1,199 +0,0 @@
-Qualcomm QCS404 TLMM block
-
-This binding describes the Top Level Mode Multiplexer block found in the
-QCS404 platform.
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be "qcom,qcs404-pinctrl"
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: the base address and size of the north, south and east TLMM
-		    tiles.
-
-- reg-names:
-	Usage: required
-	Value type: <stringlist>
-	Defintiion: names for the cells of reg, must contain "north", "south"
-		    and "east".
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
-		      gpio0-gpio119
-		        Supports mux, bias and drive-strength
-
-		      sdc1_clk, sdc1_cmd, sdc1_data, sdc2_clk, sdc2_cmd,
-		      sdc2_data
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
-		    gpio, hdmi_tx, hdmi_ddc, blsp_uart_tx_a2, blsp_spi2, m_voc,
-		    qdss_cti_trig_in_a0, blsp_uart_rx_a2, qdss_tracectl_a,
-		    blsp_uart2, aud_cdc, blsp_i2c_sda_a2, qdss_tracedata_a,
-		    blsp_i2c_scl_a2, qdss_tracectl_b, qdss_cti_trig_in_b0,
-		    blsp_uart1, blsp_spi_mosi_a1, blsp_spi_miso_a1,
-		    qdss_tracedata_b, blsp_i2c1, blsp_spi_cs_n_a1, gcc_plltest,
-		    blsp_spi_clk_a1, rgb_data0, blsp_uart5, blsp_spi5,
-		    adsp_ext, rgb_data1, prng_rosc, rgb_data2, blsp_i2c5,
-		    gcc_gp1_clk_b, rgb_data3, gcc_gp2_clk_b, blsp_spi0,
-		    blsp_uart0, gcc_gp3_clk_b, blsp_i2c0, qdss_traceclk_b,
-		    pcie_clk, nfc_irq, blsp_spi4, nfc_dwl, audio_ts, rgb_data4,
-		    spi_lcd, blsp_uart_tx_b2, gcc_gp3_clk_a, rgb_data5,
-		    blsp_uart_rx_b2, blsp_i2c_sda_b2, blsp_i2c_scl_b2,
-		    pwm_led11, i2s_3_data0_a, ebi2_lcd, i2s_3_data1_a,
-		    i2s_3_data2_a, atest_char, pwm_led3, i2s_3_data3_a,
-		    pwm_led4, i2s_4, ebi2_a, dsd_clk_b, pwm_led5, pwm_led6,
-		    pwm_led7, pwm_led8, pwm_led24, spkr_dac0, blsp_i2c4,
-		    pwm_led9, pwm_led10, spdifrx_opt, pwm_led12, pwm_led13,
-		    pwm_led14, wlan1_adc1, rgb_data_b0, pwm_led15,
-		    blsp_spi_mosi_b1, wlan1_adc0, rgb_data_b1, pwm_led16,
-		    blsp_spi_miso_b1, qdss_cti_trig_out_b0, wlan2_adc1,
-		    rgb_data_b2, pwm_led17, blsp_spi_cs_n_b1, wlan2_adc0,
-		    rgb_data_b3, pwm_led18, blsp_spi_clk_b1, rgb_data_b4,
-		    pwm_led19, ext_mclk1_b, qdss_traceclk_a, rgb_data_b5,
-		    pwm_led20, atest_char3, i2s_3_sck_b, ldo_update, bimc_dte0,
-		    rgb_hsync, pwm_led21, i2s_3_ws_b, dbg_out, rgb_vsync,
-		    i2s_3_data0_b, ldo_en, hdmi_dtest, rgb_de, i2s_3_data1_b,
-		    hdmi_lbk9, rgb_clk, atest_char1, i2s_3_data2_b, ebi_cdc,
-		    hdmi_lbk8, rgb_mdp, atest_char0, i2s_3_data3_b, hdmi_lbk7,
-		    rgb_data_b6, rgb_data_b7, hdmi_lbk6, rgmii_int, cri_trng1,
-		    rgmii_wol, cri_trng0, gcc_tlmm, rgmii_ck, rgmii_tx,
-		    hdmi_lbk5, hdmi_pixel, hdmi_rcv, hdmi_lbk4, rgmii_ctl,
-		    ext_lpass, rgmii_rx, cri_trng, hdmi_lbk3, hdmi_lbk2,
-		    qdss_cti_trig_out_b1, rgmii_mdio, hdmi_lbk1, rgmii_mdc,
-		    hdmi_lbk0, ir_in, wsa_en, rgb_data6, rgb_data7,
-		    atest_char2, ebi_ch0, blsp_uart3, blsp_spi3, sd_write,
-		    blsp_i2c3, gcc_gp1_clk_a, qdss_cti_trig_in_b1,
-		    gcc_gp2_clk_a, ext_mclk0, mclk_in1, i2s_1, dsd_clk_a,
-		    qdss_cti_trig_in_a1, rgmi_dll1, pwm_led22, pwm_led23,
-		    qdss_cti_trig_out_a0, rgmi_dll2, pwm_led1,
-		    qdss_cti_trig_out_a1, pwm_led2, i2s_2, pll_bist,
-		    ext_mclk1_a, mclk_in2, bimc_dte1, i2s_3_sck_a, i2s_3_ws_a
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
-		compatible = "qcom,qcs404-pinctrl";
-		reg = <0x01000000 0x200000>,
-		      <0x01300000 0x200000>,
-		      <0x07b00000 0x200000>;
-		reg-names = "south", "north", "east";
-		interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		gpio-ranges = <&tlmm 0 0 120>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-	};
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.yaml
new file mode 100644
index 000000000000..3d314458bf84
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.yaml
@@ -0,0 +1,176 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,qcs404-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SCS404 TLMM pin controller
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm QCS404 SoC.
+
+properties:
+  compatible:
+    const: qcom,qcs404-pinctrl
+
+  reg:
+    maxItems: 3
+
+  reg-names:
+    items:
+      - const: south
+      - const: north
+      - const: east
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
+    maxItems: 60
+
+  gpio-line-names:
+    maxItems: 120
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-qcs404-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-qcs404-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-qcs404-tlmm-state:
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
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-1][0-9])$"
+            - enum: [ sdc1_clk, sdc1_cmd, sdc1_data, sdc1_rclk, sdc2_clk,
+                      sdc2_cmd, sdc2_data, ufs_reset ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+        enum: [ gpio, adsp_ext, atest_char, atest_char0, atest_char1,
+                atest_char2, atest_char3, aud_cdc, audio_ts, bimc_dte0,
+                bimc_dte1, blsp_i2c0, blsp_i2c1, blsp_i2c3, blsp_i2c4,
+                blsp_i2c5, blsp_i2c_scl_a2, blsp_i2c_scl_b2, blsp_i2c_sda_a2,
+                blsp_i2c_sda_b2, blsp_spi0, blsp_spi2, blsp_spi3, blsp_spi4,
+                blsp_spi5, blsp_spi_clk_a1, blsp_spi_clk_b1, blsp_spi_cs_n_a1,
+                blsp_spi_cs_n_b1, blsp_spi_miso_a1, blsp_spi_miso_b1,
+                blsp_spi_mosi_a1, blsp_spi_mosi_b1, blsp_uart0, blsp_uart1,
+                blsp_uart2, blsp_uart3, blsp_uart5, blsp_uart_rx_a2,
+                blsp_uart_rx_b2, blsp_uart_tx_a2, blsp_uart_tx_b2, cri_trng,
+                cri_trng0, cri_trng1, dbg_out, dsd_clk_a, dsd_clk_b, ebi2_a,
+                ebi2_lcd, ebi_cdc, ebi_ch0, ext_lpass, ext_mclk0, ext_mclk1_a,
+                ext_mclk1_b, gcc_gp1_clk_a, gcc_gp1_clk_b, gcc_gp2_clk_a,
+                gcc_gp2_clk_b, gcc_gp3_clk_a, gcc_gp3_clk_b, gcc_plltest,
+                gcc_tlmm, hdmi_ddc, hdmi_dtest, hdmi_lbk0, hdmi_lbk1,
+                hdmi_lbk2, hdmi_lbk3, hdmi_lbk4, hdmi_lbk5, hdmi_lbk6,
+                hdmi_lbk7, hdmi_lbk8, hdmi_lbk9, hdmi_pixel, hdmi_rcv, hdmi_tx,
+                i2s_1, i2s_2, i2s_3_data0_a, i2s_3_data0_b, i2s_3_data1_a,
+                i2s_3_data1_b, i2s_3_data2_a, i2s_3_data2_b, i2s_3_data3_a,
+                i2s_3_data3_b, i2s_3_sck_a, i2s_3_sck_b, i2s_3_ws_a,
+                i2s_3_ws_b, i2s_4, ir_in, ldo_en, ldo_update, mclk_in1,
+                mclk_in2, m_voc, nfc_dwl, nfc_irq, pcie_clk, pll_bist,
+                prng_rosc, pwm_led1, pwm_led10, pwm_led11, pwm_led12,
+                pwm_led13, pwm_led14, pwm_led15, pwm_led16, pwm_led17,
+                pwm_led18, pwm_led19, pwm_led2, pwm_led20, pwm_led21,
+                pwm_led22, pwm_led23, pwm_led24, pwm_led3, pwm_led4, pwm_led5,
+                pwm_led6, pwm_led7, pwm_led8, pwm_led9, qdss_cti_trig_in_a0,
+                qdss_cti_trig_in_a1, qdss_cti_trig_in_b0, qdss_cti_trig_in_b1,
+                qdss_cti_trig_out_a0, qdss_cti_trig_out_a1,
+                qdss_cti_trig_out_b0, qdss_cti_trig_out_b1, qdss_traceclk_a,
+                qdss_traceclk_b, qdss_tracectl_a, qdss_tracectl_b,
+                qdss_tracedata_a, qdss_tracedata_b, rgb_clk, rgb_data0,
+                rgb_data1, rgb_data2, rgb_data3, rgb_data4, rgb_data5,
+                rgb_data6, rgb_data7, rgb_data_b0, rgb_data_b1, rgb_data_b2,
+                rgb_data_b3, rgb_data_b4, rgb_data_b5, rgb_data_b6,
+                rgb_data_b7, rgb_de, rgb_hsync, rgb_mdp, rgb_vsync, rgmi_dll1,
+                rgmi_dll2, rgmii_ck, rgmii_ctl, rgmii_int, rgmii_mdc,
+                rgmii_mdio, rgmii_rx, rgmii_tx, rgmii_wol, sd_write,
+                spdifrx_opt, spi_lcd, spkr_dac0, wlan1_adc0, wlan1_adc1,
+                wlan2_adc0, wlan2_adc1, wsa_en ]
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
+        compatible = "qcom,qcs404-pinctrl";
+        reg = <0x01000000 0x200000>,
+              <0x01300000 0x200000>,
+              <0x07b00000 0x200000>;
+        reg-names = "south", "north", "east";
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-ranges = <&tlmm 0 0 120>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+
+
+        blsp1-i2c1-default-state {
+            pins = "gpio24", "gpio25";
+            function = "blsp_i2c1";
+        };
+
+        blsp1-i2c2-default-state {
+            sda-pins {
+                pins = "gpio19";
+                function = "blsp_i2c_sda_a2";
+            };
+
+            scl-pins {
+                pins = "gpio20";
+                function = "blsp_i2c_scl_a2";
+            };
+        };
+    };
-- 
2.34.1

