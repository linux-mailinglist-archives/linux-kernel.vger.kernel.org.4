Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DCA623E03
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbiKJIxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiKJIww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:52:52 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012302EF7A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:52:38 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id c25so674022ljr.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wo0Swiu+N5bkpk7rXImiAO0LHaluidzIS3xO9j+tDjM=;
        b=bG1wViM97U80if7xG+S30IKIgdSo0go+iaYtsP6iROlgdE10w3qhgJEFrtDmelSOWb
         XK7kwwDbqYJ9GqkotLoXyK/YRw5nFfchhVHTJJ2UVPDxKIJPQLa4R92JUEn4+QunOZam
         HJ8G9l8tH46sqyEUln8kQvHV5peHjR7bzaZaDnhMVxxer4Xz9XBoAvjC/Rjgf9IsSflC
         t5KhwXc0fVGA/uZ/Dnv6QJW0bTAtgrgXEBUrBBYyzeY4XzDmRhzS4c64hNDmN5jIw6vT
         YF9D6ppOSEvPgBYI0QVHA2bLetM9jqlL6gDTEskFXebC/veLzKnX78CqX5wP7BrzTUze
         WmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wo0Swiu+N5bkpk7rXImiAO0LHaluidzIS3xO9j+tDjM=;
        b=OqTbOj7UWZbO7GcGNyMlPM5rW9rlhj0WMdBVORREHQeDL66YL7g11GL3WzerveVGyn
         78vp8gEXXyMezvAmUjOsFtWRJX1qhbmSF7+us/IzQr0/jyMuxIv3o7SFlpeBXHSylTMn
         dL/iMYkrACcs6mqcpPrJqtbDNEiHIQ15cuuEX2s5/TxHn2nTuh6+cyT6dcXM/6wlwW5B
         NyZfuVWiDG4FWQBjyZtuBadFdiTXCEXcxJOOa6kDgoCALaQfwS0VUJiEskzj94RLoCeq
         WFQ1KsKIzQ+nHfsT3DdajVddXMQtjP+4ZEXTOiEmhds2fy1njEKR3Ed8eryDlvQ4twiN
         66+w==
X-Gm-Message-State: ACrzQf2VeRXD4NfcstF8VWwGa8nylMGkhu/xDqR2WGkEosfJuhEf19Di
        jlrUEAgaiqQdBwjWRB0A1TIw4A==
X-Google-Smtp-Source: AMsMyM79zkxm51b2+3zH+DMQEO4jy38JylgZHL1kCivTIDumX4FceX24JezKqw2VGKXixwY+hm72uw==
X-Received: by 2002:a2e:b626:0:b0:26e:6fb:4845 with SMTP id s6-20020a2eb626000000b0026e06fb4845mr8318398ljn.120.1668070356253;
        Thu, 10 Nov 2022 00:52:36 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id b19-20020a0565120b9300b004b3db0a3d9csm1714655lfv.117.2022.11.10.00.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 00:52:35 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: pinctrl: qcom,msm8976: convert to dtschema
Date:   Thu, 10 Nov 2022 09:52:30 +0100
Message-Id: <20221110085230.15108-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Convert Qualcomm MSM8976 pin controller bindings to DT schema.  Keep the
parsing of pin configuration subnodes consistent with other Qualcomm
schemas (children named with '-state' suffix, their children with
'-pins').

Changes during conversion: update the list of non-mux pins (like sdc1)
to match Linux driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

---

Changes since v1:
1. Add Rb tag.
2. Correct missing comma pins enum (Marijn).
3. Adjust description of state/pins objects (Marijn).
---
 .../bindings/pinctrl/qcom,msm8976-pinctrl.txt | 183 ------------------
 .../pinctrl/qcom,msm8976-pinctrl.yaml         | 136 +++++++++++++
 2 files changed, 136 insertions(+), 183 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8976-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8976-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8976-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,msm8976-pinctrl.txt
deleted file mode 100644
index 70d04d12f136..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8976-pinctrl.txt
+++ /dev/null
@@ -1,183 +0,0 @@
-Qualcomm MSM8976 TLMM block
-
-This binding describes the Top Level Mode Multiplexer block found in the
-MSM8956 and MSM8976 platforms.
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be "qcom,msm8976-pinctrl"
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
-		      sdc1_clk, sdc1_cmd, sdc1_data,
-		      sdc2_clk, sdc2_cmd, sdc2_data,
-		      sdc3_clk, sdc3_cmd, sdc3_data
-		        Supports bias and drive-strength
-
-- function:
-	Usage: required
-	Value type: <string>
-	Definition: Specify the alternative function to be configured for the
-		    specified pins. Functions are only valid for gpio pins.
-		    Valid values are:
-
-		    gpio, blsp_uart1, blsp_spi1, smb_int, blsp_i2c1, blsp_spi2,
-		    blsp_uart2, blsp_i2c2, gcc_gp1_clk_b, blsp_spi3,
-		    qdss_tracedata_b, blsp_i2c3, gcc_gp2_clk_b, gcc_gp3_clk_b,
-		    blsp_spi4, cap_int, blsp_i2c4, blsp_spi5, blsp_uart5,
-		    qdss_traceclk_a, m_voc, blsp_i2c5, qdss_tracectl_a,
-		    qdss_tracedata_a, blsp_spi6, blsp_uart6, qdss_tracectl_b,
-		    blsp_i2c6, qdss_traceclk_b, mdp_vsync, pri_mi2s_mclk_a,
-		    sec_mi2s_mclk_a, cam_mclk, cci0_i2c, cci1_i2c, blsp1_spi,
-		    blsp3_spi, gcc_gp1_clk_a, gcc_gp2_clk_a, gcc_gp3_clk_a,
-		    uim_batt, sd_write, uim1_data, uim1_clk, uim1_reset,
-		    uim1_present, uim2_data, uim2_clk, uim2_reset,
-		    uim2_present, ts_xvdd, mipi_dsi0, us_euro, ts_resout,
-		    ts_sample, sec_mi2s_mclk_b, pri_mi2s, codec_reset,
-		    cdc_pdm0, us_emitter, pri_mi2s_mclk_b, pri_mi2s_mclk_c,
-		    lpass_slimbus, lpass_slimbus0, lpass_slimbus1, codec_int1,
-		    codec_int2, wcss_bt, sdc3, wcss_wlan2, wcss_wlan1,
-		    wcss_wlan0, wcss_wlan, wcss_fm, key_volp, key_snapshot,
-		    key_focus, key_home, pwr_down, dmic0_clk, hdmi_int,
-		    dmic0_data, wsa_vi, wsa_en, blsp_spi8, wsa_irq, blsp_i2c8,
-		    pa_indicator, modem_tsync, ssbi_wtr1, gsm1_tx, gsm0_tx,
-		    sdcard_det, sec_mi2s, ss_switch,
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
-		compatible = "qcom,msm8976-pinctrl";
-		reg = <0x1000000 0x300000>;
-		interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		gpio-ranges = <&tlmm 0 0 145>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-
-		blsp1_uart2_active: blsp1_uart2_active {
-			mux {
-				pins = "gpio4", "gpio5", "gpio6", "gpio7";
-				function = "blsp_uart2";
-			};
-
-			config {
-				pins = "gpio4", "gpio5", "gpio6", "gpio7";
-				drive-strength = <2>;
-				bias-disable;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8976-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8976-pinctrl.yaml
new file mode 100644
index 000000000000..ffc3a518b90d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8976-pinctrl.yaml
@@ -0,0 +1,136 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,msm8976-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm MSM8976 TLMM pin controller
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm MSM8976 SoC.
+
+properties:
+  compatible:
+    const: qcom,msm8976-pinctrl
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
+    maxItems: 73
+
+  gpio-line-names:
+    maxItems: 145
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-msm8976-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-msm8976-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-msm8976-tlmm-state:
+    type: object
+    description:
+      Desired pin configuration for a device or its specific state (like sleep
+      or active).
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this state.
+        items:
+          oneOf:
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-3][0-9]|14[0-4])$"
+            - enum: [ qdsd_clk, qdsd_cmd, qdsd_data0, qdsd_data1, qdsd_data2,
+                      qdsd_data3, sdc1_clk, sdc1_cmd, sdc1_data, sdc1_rclk,
+                      sdc2_clk, sdc2_cmd, sdc2_data ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+        enum: [ gpio, blsp_uart1, blsp_spi1, smb_int, blsp_i2c1, blsp_spi2,
+                blsp_uart2, blsp_i2c2, gcc_gp1_clk_b, blsp_spi3,
+                qdss_tracedata_b, blsp_i2c3, gcc_gp2_clk_b, gcc_gp3_clk_b,
+                blsp_spi4, cap_int, blsp_i2c4, blsp_spi5, blsp_uart5,
+                qdss_traceclk_a, m_voc, blsp_i2c5, qdss_tracectl_a,
+                qdss_tracedata_a, blsp_spi6, blsp_uart6, qdss_tracectl_b,
+                blsp_i2c6, qdss_traceclk_b, mdp_vsync, pri_mi2s_mclk_a,
+                sec_mi2s_mclk_a, cam_mclk, cci0_i2c, cci1_i2c, blsp1_spi,
+                blsp3_spi, gcc_gp1_clk_a, gcc_gp2_clk_a, gcc_gp3_clk_a,
+                uim_batt, sd_write, uim1_data, uim1_clk, uim1_reset,
+                uim1_present, uim2_data, uim2_clk, uim2_reset, uim2_present,
+                ts_xvdd, mipi_dsi0, us_euro, ts_resout, ts_sample,
+                sec_mi2s_mclk_b, pri_mi2s, codec_reset, cdc_pdm0, us_emitter,
+                pri_mi2s_mclk_b, pri_mi2s_mclk_c, lpass_slimbus,
+                lpass_slimbus0, lpass_slimbus1, codec_int1, codec_int2,
+                wcss_bt, sdc3, wcss_wlan2, wcss_wlan1, wcss_wlan0, wcss_wlan,
+                wcss_fm, key_volp, key_snapshot, key_focus, key_home, pwr_down,
+                dmic0_clk, hdmi_int, dmic0_data, wsa_vi, wsa_en, blsp_spi8,
+                wsa_irq, blsp_i2c8, pa_indicator, modem_tsync, ssbi_wtr1,
+                gsm1_tx, gsm0_tx, sdcard_det, sec_mi2s, ss_switch ]
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
+        compatible = "qcom,msm8976-pinctrl";
+        reg = <0x1000000 0x300000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 145>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+
+        blsp1-uart2-active-state {
+            pins = "gpio4", "gpio5", "gpio6", "gpio7";
+            function = "blsp_uart2";
+            drive-strength = <2>;
+            bias-disable;
+        };
+    };
-- 
2.34.1

