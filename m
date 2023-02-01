Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFB6686983
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjBAPDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjBAPDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:03:23 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766F4721CE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:00:59 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bk16so17566993wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8K+K1T18FiSvYbvYMMoM5c+33M4Xja2jC1mbJUMJtE=;
        b=uU2gQ+gffKI16oG3sgwegftXUioR6ZvoK47aCANKJkDuz9G6sqb5GS8LwOsBCB57oH
         n7hRHDj0APeef99LzTMtJXkKfuyvWLRW48yT+4ZY1uYUaAmm6ruCsjrNCEJwAW5HSK5y
         AGVq+LTiJfbZVtAyZY1+RoQ0Lr/vVDtMHOdwfAmntHsgFoDq6/H4anMSeB3TDOLtZMjy
         LPndbxz3azJKcI0cbz8uidB3TCioATYNkYu2MNPMQu+fvbFidk/PwBGSCht9xftHhx5B
         ngoF7rSkxal902igU1YMzR5hgNAtj6USbyW9yCmWSCs9mwlUa/pOkWyoGeWPb+LM1puM
         qYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8K+K1T18FiSvYbvYMMoM5c+33M4Xja2jC1mbJUMJtE=;
        b=T2R/nO9ns0/1QDoceU60UoVBF91nSDlN6sW4i9vEdcVY9INUrmOS39SjEDOSbCUCl0
         71JKZgxI1IpWvi1d3sAHe1waqGjym+pjDqCciRCbKE2tG2L6Ipytuyq1GoTLjGNuojFk
         OZLgtHFwGQeNX21hXf+3bWuStnh52TEsRDAfUh3L4iz0mk1Dah07IwMvuC/g1yNIC2cY
         caapcZZmmSubWvXwjyVIc1KQ2BkOYfNzHtE78ImnK3wmUtmh6VFp77sefzij3Hvr6cpN
         J7dNzVyqrwwj0M1cfGb97F/WuGrpiNqNDgf3cuyrVxl42a0Iqn82/3KXN3z5UQQuQGv5
         xamw==
X-Gm-Message-State: AO0yUKWtEKeSRxJRPUjif57GlY7HPRCGjdhkf7qoMjSaJK2FcjZNXKwZ
        6tkONa1j68AFeA8NMqMYSfpP6g==
X-Google-Smtp-Source: AK7set/10fjZ8+XWhh1XTiGuHdnZAq1Bi7wsQozqNZ7pZU9f9Nx5O9wSGH03r1Rr4b85batWR3BIhQ==
X-Received: by 2002:a05:6000:110d:b0:2bf:c0f2:4b0 with SMTP id z13-20020a056000110d00b002bfc0f204b0mr2726385wrw.19.1675263618908;
        Wed, 01 Feb 2023 07:00:18 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d64:a4e6:40a8:8e69])
        by smtp.gmail.com with ESMTPSA id f28-20020a5d58fc000000b002be5401ef5fsm18063754wrd.39.2023.02.01.07.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:00:18 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: pinctrl: describe sa8775p-tlmm
Date:   Wed,  1 Feb 2023 16:00:10 +0100
Message-Id: <20230201150011.200613-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230201150011.200613-1-brgl@bgdev.pl>
References: <20230201150011.200613-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add DT bindings for the TLMM controller on sa8775p platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../bindings/pinctrl/qcom,sa8775p-tlmm.yaml   | 138 ++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml
new file mode 100644
index 000000000000..a91f5816ed5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml
@@ -0,0 +1,138 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,sa8775p-tlmm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. SA8775P TLMM block
+
+maintainers:
+  - Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
+
+description: |
+  Top Level Mode Multiplexer pin controller in Qualcomm SA8775P SoC.
+
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,sa8775p-tlmm
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
+
+  gpio-reserved-ranges:
+    minItems: 1
+    maxItems: 74
+
+  gpio-line-names:
+    maxItems: 148
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-sa8775p-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-sa8775p-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-sa8775p-tlmm-state:
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
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-3][0-9]|14[0-7])$"
+            - enum: [ sdc1_clk, sdc1_cmd, sdc1_data, sdc1_rclk, ufs_reset ]
+        minItems: 1
+        maxItems: 16
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+        enum: [ atest_char, atest_usb2, audio_ref, cam_mclk, cci_async, cci_i2c,
+                cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4,
+                cci_timer5, cci_timer6, cci_timer7, cci_timer8, cci_timer9,
+                cri_trng, cri_trng0, cri_trng1, dbg_out, ddr_bist, ddr_pxi0,
+                ddr_pxi1, ddr_pxi2, ddr_pxi3, ddr_pxi4, ddr_pxi5, edp0_hot,
+                edp0_lcd, edp1_hot, edp1_lcd, edp2_hot, edp2_lcd, edp3_hot,
+                edp3_lcd, emac0_mcg0, emac0_mcg1, emac0_mcg2, emac0_mcg3,
+                emac0_mdc, emac0_mdio, emac0_ptp_aux, emac0_ptp_pps, emac1_mcg0,
+                emac1_mcg1, emac1_mcg2, emac1_mcg3, emac1_mdc, emac1_mdio,
+                emac1_ptp_aux, emac1_ptp_pps, gcc_gp1, gcc_gp2, gcc_gp3,
+                gcc_gp4, gcc_gp5, hs0_mi2s, hs1_mi2s, hs2_mi2s, ibi_i3c,
+                jitter_bist, mdp0_vsync0, mdp0_vsync1, mdp0_vsync2, mdp0_vsync3,
+                mdp0_vsync4, mdp0_vsync5, mdp0_vsync6, mdp0_vsync7, mdp0_vsync8,
+                mdp1_vsync0, mdp1_vsync1, mdp1_vsync2, mdp1_vsync3, mdp1_vsync4,
+                mdp1_vsync5, mdp1_vsync6, mdp1_vsync7, mdp1_vsync8, mdp_vsync,
+                mi2s1_data0, mi2s1_data1, mi2s1_sck, mi2s1_ws, mi2s2_data0,
+                mi2s2_data1, mi2s2_sck, mi2s2_ws, mi2s_mclk0, mi2s_mclk1,
+                pcie0_clkreq, pcie1_clkreq, phase_flag, pll_bist, pll_clk,
+                prng_rosc0, prng_rosc1, prng_rosc2, prng_rosc3, qdss_cti,
+                qdss_gpio, qup0_se0, qup0_se1, qup0_se2, qup0_se3, qup0_se4,
+                qup0_se5, qup1_se0, qup1_se1, qup1_se2, qup1_se3, qup1_se4,
+                qup1_se5, qup1_se6, qup2_se0, qup2_se1, qup2_se2, qup2_se3,
+                qup2_se4, qup2_se5, qup2_se6, qup3_se0, sailss_emac0,
+                sailss_ospi, sail_top, sgmii_phy, tb_trig, tgu_ch0, tgu_ch1,
+                tgu_ch2, tgu_ch3, tgu_ch4, tgu_ch5, tsense_pwm1, tsense_pwm2,
+                tsense_pwm3, tsense_pwm4, usb2phy_ac, vsense_trigger ]
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
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    tlmm: pinctrl@f000000 {
+        compatible = "qcom,sa8775p-tlmm";
+        reg = <0xf000000 0x1000000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 149>;
+
+        qup-uart10-state {
+            pins = "gpio46", "gpio47";
+            function = "qup1_se3";
+        };
+    };
+...
-- 
2.37.2

