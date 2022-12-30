Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5D9659C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 21:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbiL3Uhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 15:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbiL3UhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 15:37:07 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975F91CB3C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 12:36:43 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id w1so8576990wrt.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 12:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GV8LuQ37BZ/7ecv+f/BxO4VhXxsy8bpKCkqPJnOFUKE=;
        b=fgQVNiHug2ILPICcNApepkspRY9gO/WVZvl3O1gZ5UzMWdxfrV/qOFVJds+k/N2bWZ
         ZjivmH1Kz33bvLmGKW9JbCoIXNjxjXJiE/6ehN6lo4qWCUoDS7iV5N3+KJhnDnqAUFfa
         xwlbWkZUQ9ZhCMWuTqOmJ1p4nOaoFqrQ1CYp1xmlE6t/KeZq7kPgAKfwa/6Y4OSOe53z
         KjCwmbFbJU8sk8BKMKRwBfJTJ14Dt5mSxj+6mZ67LavN2mMT6YusJcEZ974Jwg162U7+
         2Qyc5459QCdl5pZ+kJDBVqA8ZwWbkfSe9DWlbtZ65eDTIHJA+ruvIOEK7fyDp2pu53EM
         JcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GV8LuQ37BZ/7ecv+f/BxO4VhXxsy8bpKCkqPJnOFUKE=;
        b=iiTIteqfl86pjz6V0DGE8NMXNGVMVAo2vJJpMGdh7SPp9bGqvbXDyjtwjTsyjsmz/e
         EUpuYu3H4AzqB/XjodLlqFcMZkLWNLOZy89Em6+hcF9I5JJ9/0nPLG3Ofqj4EIChsLYR
         +uWPDHtHE4eGOKR534T9RGoKSYU3/Ag8z0rjl1DQkqFIVhSJAV8j+8l2/PxEYDwoO1KK
         JhIyOtABUeU3y/aerdv+yb+QSyVjrANSUo+TAHIbRxbHIu/Y43SeYz1VGL99eurJk0bD
         L2vn8bVU/nWy00V2Dv08WkuLSBob9fgDqLbofp7HZNqIsuaZhjUJFtN3ARt/hsNWv80I
         q4Ow==
X-Gm-Message-State: AFqh2krLBWBcf2bNetsN+mrIERtOV93GJeic0mpnV3ndoq/+gEPBBnwG
        maGxCmZrYnYqoINa/ndx0c8DYw==
X-Google-Smtp-Source: AMrXdXuaoM8d0vJQkHvwYS37fUki1UjMVpw420Ce51WYfQu1gKz9p5DdbqIFAeCKqzr6DREjACy9pw==
X-Received: by 2002:adf:dec7:0:b0:242:115d:bee4 with SMTP id i7-20020adfdec7000000b00242115dbee4mr19787507wrn.16.1672432602109;
        Fri, 30 Dec 2022 12:36:42 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id c10-20020a5d414a000000b0024242111a27sm21686946wrq.75.2022.12.30.12.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 12:36:41 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] dt-bindings: pinctrl: qcom: Add SM8550 pinctrl
Date:   Fri, 30 Dec 2022 22:36:36 +0200
Message-Id: <20221230203637.2539900-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221230203637.2539900-1-abel.vesa@linaro.org>
References: <20221230203637.2539900-1-abel.vesa@linaro.org>
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

Add device tree binding Documentation details for Qualcomm SM8550
TLMM device

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,sm8550-tlmm.yaml    | 163 ++++++++++++++++++
 1 file changed, 163 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml
new file mode 100644
index 000000000000..a457425ba112
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml
@@ -0,0 +1,163 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,sm8550-tlmm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. SM8550 TLMM block
+
+maintainers:
+  - Abel Vesa <abel.vesa@linaro.org>
+
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm SM8550 SoC.
+
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,sm8550-tlmm
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
+    maxItems: 105
+
+  gpio-line-names:
+    maxItems: 210
+
+  "#gpio-cells": true
+  gpio-ranges: true
+  wakeup-parent: true
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-sm8550-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-sm8550-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-sm8550-tlmm-state:
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
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|20[0-9])$"
+            - enum: [ ufs_reset, sdc2_clk, sdc2_cmd, sdc2_data ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+        enum: [ aon_cci, aoss_cti, atest_char, atest_usb,
+                audio_ext_mclk0, audio_ext_mclk1, audio_ref_clk,
+                cam_aon_mclk4, cam_mclk, cci_async_in, cci_i2c_scl,
+                cci_i2c_sda, cci_timer, cmu_rng, coex_uart1_rx,
+                coex_uart1_tx, coex_uart2_rx, coex_uart2_tx,
+                cri_trng, dbg_out_clk, ddr_bist_complete,
+                ddr_bist_fail, ddr_bist_start, ddr_bist_stop,
+                ddr_pxi0, ddr_pxi1, ddr_pxi2, ddr_pxi3, dp_hot,
+                gcc_gp1, gcc_gp2, gcc_gp3, gpio, i2chub0_se0,
+                i2chub0_se1, i2chub0_se2, i2chub0_se3, i2chub0_se4,
+                i2chub0_se5, i2chub0_se6, i2chub0_se7, i2chub0_se8,
+                i2chub0_se9, i2s0_data0, i2s0_data1, i2s0_sck,
+                i2s0_ws, i2s1_data0, i2s1_data1, i2s1_sck, i2s1_ws,
+                ibi_i3c, jitter_bist, mdp_vsync, mdp_vsync0_out,
+                mdp_vsync1_out, mdp_vsync2_out, mdp_vsync3_out,
+                mdp_vsync_e, nav_gpio0, nav_gpio1, nav_gpio2,
+                pcie0_clk_req_n, pcie1_clk_req_n, phase_flag,
+                pll_bist_sync, pll_clk_aux, prng_rosc0, prng_rosc1,
+                prng_rosc2, prng_rosc3, qdss_cti, qdss_gpio,
+                qlink0_enable, qlink0_request, qlink0_wmss,
+                qlink1_enable, qlink1_request, qlink1_wmss,
+                qlink2_enable, qlink2_request, qlink2_wmss,
+                qspi0, qspi1, qspi2, qspi3, qspi_clk, qspi_cs,
+                qup1_se0, qup1_se1, qup1_se2, qup1_se3, qup1_se4,
+                qup1_se5, qup1_se6, qup1_se7, qup2_se0,
+                qup2_se0_l0_mira, qup2_se0_l0_mirb, qup2_se0_l1_mira,
+                qup2_se0_l1_mirb, qup2_se0_l2_mira, qup2_se0_l2_mirb,
+                qup2_se0_l3_mira, qup2_se0_l3_mirb, qup2_se1,
+                qup2_se2, qup2_se3, qup2_se4, qup2_se5, qup2_se6,
+                qup2_se7, sd_write_protect, sdc40, sdc41, sdc42,
+                sdc43, sdc4_clk, sdc4_cmd, tb_trig_sdc2, tb_trig_sdc4,
+                tgu_ch0_trigout, tgu_ch1_trigout, tgu_ch2_trigout,
+                tgu_ch3_trigout, tmess_prng0, tmess_prng1, tmess_prng2,
+                tmess_prng3, tsense_pwm1, tsense_pwm2, tsense_pwm3,
+                uim0_clk, uim0_data, uim0_present, uim0_reset,
+                uim1_clk, uim1_data, uim1_present, uim1_reset,
+                usb1_hs, usb_phy, vfr_0, vfr_1, vsense_trigger_mirnat ]
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
+    tlmm: pinctrl@f100000 {
+        compatible = "qcom,sm8550-tlmm";
+        reg = <0x0f100000 0x300000>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 211>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+
+        gpio-wo-state {
+            pins = "gpio1";
+            function = "gpio";
+        };
+
+        uart-w-state {
+            rx-pins {
+                pins = "gpio26";
+                function = "qup2_se7";
+                bias-pull-up;
+            };
+
+            tx-pins {
+                pins = "gpio27";
+                function = "qup2_se7";
+                bias-disable;
+            };
+        };
+    };
+...
-- 
2.34.1

