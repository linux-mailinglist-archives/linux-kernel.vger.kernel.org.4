Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA08F659BB9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 20:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbiL3TpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 14:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbiL3TpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 14:45:07 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39C71A832
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 11:45:05 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so15750301wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 11:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpgfXgtKUD2IiOEAolJS8ptH+/TeZa7ioj6ZZQlBhYc=;
        b=vrF3AgmeF2ByT6q68/8hjrJK3IC0CW+pL6Ne67uD7s7QNsxAiSZUp7E0IZSDcXjVwR
         4eU4DHGkyJVLsZbzC+dPgCypCCwU00N4bzUm1fb5VVWhcgCXq6DEpGGCdXRKw6Mi2+Dz
         RCiLmr9Wi9+oysX5G236OoTh47d68tFhU8vQEx/ksfnukf8EdRYVl0T37OlX/k3DRTSs
         erHerIRFTpVWcUHWEOt4fUVmM2lzp6R3kr349lb3iJALCC51tQbPfdSm6rEi6uccMi8U
         NWde1Rl+9KWRrkjPyhGFj+jKEjzdJBcGXG7aw4u7hDrHWfxNAvVHqUF3jcMak4Lo4TOa
         zf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpgfXgtKUD2IiOEAolJS8ptH+/TeZa7ioj6ZZQlBhYc=;
        b=YLBrwA4theeMiwnehr5+3WcGEjDPZPaXdOHlcZneLv0vdmawmD6Xdoc/TAt7WOZW9d
         cRnU1YbQlU/P572ou5kqDtdr6yRCU8+wgdxDbGUJgyFZQxpGRuq92pMiNhuv9MsruwEZ
         mszVjFVlK438Zh39RPlrDTnHETbHeTZ1TXiy6se1r6MuyTQVmKTRa+i/YcSLM8SUFGX7
         cS1QSUgV8FhqvRJDj2k31ykMUAtaPe9bJTkv3fJEmDCF3MMuHnThc2Y7D3Y2KxF7u2XM
         av/odIBqV3vT7skdCmd81T5XdQkvOYlce5G9zTHj8n4jG9LSutdibsrXT7Byu3WNmlSQ
         PQ+A==
X-Gm-Message-State: AFqh2kofs5GIZJiUcnT52iGcu0Dr6CaVWVd/zsD0vnNF6YFmh+9giSd+
        XfKSR3kMSCrEMMP5fS8Y5CBTfg==
X-Google-Smtp-Source: AMrXdXtURs+zZVv130aL1aGKXzY+ybFAMinmh2Mf107qCXtQLKYB4TC0KrcKVtZQspZ4Kx0nxah4vA==
X-Received: by 2002:a05:600c:1c2a:b0:3d2:3376:6f2e with SMTP id j42-20020a05600c1c2a00b003d233766f2emr23941908wms.9.1672429504245;
        Fri, 30 Dec 2022 11:45:04 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id j30-20020a05600c1c1e00b003c71358a42dsm44855413wms.18.2022.12.30.11.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 11:45:03 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: pinctrl: qcom: Add SM8550 pinctrl
Date:   Fri, 30 Dec 2022 21:44:58 +0200
Message-Id: <20221230194459.2370924-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221230194459.2370924-1-abel.vesa@linaro.org>
References: <20221230194459.2370924-1-abel.vesa@linaro.org>
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

