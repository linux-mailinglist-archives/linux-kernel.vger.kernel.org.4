Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64985F4B45
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJDV6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJDV63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:58:29 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8FE2F39B;
        Tue,  4 Oct 2022 14:58:28 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id l127so9085608iof.12;
        Tue, 04 Oct 2022 14:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+BvCjKq9ezJwY9x7zDgBv67DKt1Hy26JaSxVLkXEvF0=;
        b=MtZklHiY52tCf2cjoAAaFVS6deT/dYArg7hdweS6Ew+IbNA6QJt0UPACkdfgEH2QPa
         m2pEf0s6zsQVkEhSJluIP2xQC4Q19HMn6H7APAFEQlPEHK0AXO7laK6mvbK4VYSMR/kf
         lIsFTUhQGmIst9DmGhEQh7nThTZEgbvPBYy9Navp8UKhJZ91QDI9GHQ7Oz2G83QrlOfK
         RuJcj6vBW6cW1WUWJjeEcJ92t/TJlgZxpN10iV2Zp/kP+ZOdWcEQWv3XGqGCLfPqOvlk
         C/vyv7ypcwr7dC4SoN/VfpeUsW9EUO3MwOy5RE4ezxwSWQSMXDBO14EbYn8PaUlHgU23
         B8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+BvCjKq9ezJwY9x7zDgBv67DKt1Hy26JaSxVLkXEvF0=;
        b=6I/yAB9S4eVRemPpb8nggYFfrlbEFj2wfLFsL9Z9IQdCgr4cUXTXHDfNVung3yJC/M
         cU/mYj8gD7hlpW9rahdfOq5fJUqciN/iVnWZtCDZxG/NK0WiHC1fsT3iz+dIu9browkd
         9ztUUJ+7YIp9FAPKjAEiAfAcVbpbpRIrW/G3a4VYK9yhv+970zVV6Yg/U/wkzrKwKlI1
         5oGdz8mQTJ3cdgiKyu85BRg/Uz5KDoZ8OvcxXRSVdhWYwSqBRmyADpF8A9B+f2fKKxXb
         SQUztAGmhBvGFKsdhYM6q5jGEatR6Q/YFhcA6XOPCdqbQh5v0x5cfmterNGdiEVeu9J+
         sOsQ==
X-Gm-Message-State: ACrzQf0UFktQoYw4CmIlaTPErs8C6j586daw6pck3hK/4UJQ1Tc3zRbD
        B3jiUkbHNCx7rZIs6yJ7UZgZiz84DDPRLA==
X-Google-Smtp-Source: AMsMyM7ngBphYqcSxRyve8i9T8LUeFgYglf89XT3HCdJn1M3+qQrWJXaMzotexUCaX8ZLBTJ6OegXg==
X-Received: by 2002:a05:6638:1a1:b0:363:38d6:9963 with SMTP id b1-20020a05663801a100b0036338d69963mr5186840jaq.158.1664920707213;
        Tue, 04 Oct 2022 14:58:27 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::1eda])
        by smtp.gmail.com with UTF8SMTPSA id t10-20020a056638204a00b0035a205ab110sm5738083jaj.123.2022.10.04.14.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 14:58:26 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v7 1/3] dt-bindings: pinctrl: qcom: add sdm670 pinctrl
Date:   Tue,  4 Oct 2022 17:58:12 -0400
Message-Id: <20221004215814.11694-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221004215814.11694-1-mailingradian@gmail.com>
References: <20221004215814.11694-1-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a new driver for the Snapdragon 670 TLMM (Top-Level Mode
Multiplexer). Document it.

Adapted from qcom,sm6350-pinctrl.yaml.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
---
 .../bindings/pinctrl/qcom,sdm670-tlmm.yaml    | 129 ++++++++++++++++++
 1 file changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
new file mode 100644
index 000000000000..e2f563ae6bbf
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
@@ -0,0 +1,129 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,sdm670-tlmm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. SDM670 TLMM block
+
+maintainers:
+  - Richard Acayan <mailingradian@gmail.com>
+
+description: |
+  This binding describes the Top Level Mode Multiplexer (TLMM) block found
+  in the SDM670 platform.
+
+allOf:
+  - $ref: pinctrl.yaml#
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,sdm670-tlmm
+
+  reg:
+    maxItems: 1
+
+  interrupts: true
+  interrupt-controller: true
+  '#interrupt-cells': true
+  gpio-controller: true
+  gpio-reserved-ranges:
+    minItems: 1
+    maxItems: 75
+
+  '#gpio-cells': true
+  gpio-ranges: true
+  wakeup-parent: true
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
+      - $ref: "#/$defs/qcom-sdm670-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-sdm670-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-sdm670-tlmm-state:
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
+            - enum: [ ufs_reset, sdc1_rclk, sdc1_clk, sdc1_cmd, sdc1_data,
+                      sdc2_clk, sdc2_cmd, sdc2_data ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+        enum: [ adsp_ext, agera_pll, atest_char, atest_tsens, atest_tsens2, atest_usb1, atest_usb10,
+                atest_usb11, atest_usb12, atest_usb13, atest_usb2, atest_usb20, atest_usb21,
+                atest_usb22, atest_usb23, cam_mclk, cci_async, cci_i2c, cci_timer0, cci_timer1,
+                cci_timer2, cci_timer3, cci_timer4, copy_gp, copy_phase, dbg_out, ddr_bist,
+                ddr_pxi0, ddr_pxi1, ddr_pxi2, ddr_pxi3, edp_hot, edp_lcd, gcc_gp1, gcc_gp2, gcc_gp3,
+                gp_pdm0, gp_pdm1, gp_pdm2, gpio, gps_tx, jitter_bist, ldo_en, ldo_update,
+                lpass_slimbus, m_voc, mdp_vsync, mdp_vsync0, mdp_vsync1, mdp_vsync2, mdp_vsync3,
+                mss_lte, nav_pps, pa_indicator, pci_e0, pci_e1, phase_flag, pll_bist, pll_bypassnl,
+                pll_reset, pri_mi2s, pri_mi2s_ws, prng_rosc, qdss_cti, qdss, qlink_enable,
+                qlink_request, qua_mi2s, qup0, qup1, qup10, qup11, qup12, qup13, qup14, qup15, qup2,
+                qup3, qup4, qup5, qup6, qup7, qup8, qup9, qup_l4, qup_l5, qup_l6, sdc4_clk,
+                sdc4_cmd, sdc4_data, sd_write, sec_mi2s, ter_mi2s, tgu_ch0, tgu_ch1, tgu_ch2,
+                tgu_ch3, tsif1_clk, tsif1_data, tsif1_en, tsif1_error, tsif1_sync, tsif2_clk,
+                tsif2_data, tsif2_en, tsif2_error, tsif2_sync, uim1_clk, uim1_data, uim1_present,
+                uim1_reset, uim2_clk, uim2_data, uim2_present, uim2_reset, uim_batt, usb_phy, vfr_1,
+                vsense_trigger, wlan1_adc0, wlan1_adc1, wlan2_adc0, wlan2_adc1, wsa_clk, wsa_data, ]
+
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
+    pinctrl@3400000 {
+        compatible = "qcom,sdm670-tlmm";
+        reg = <0x03400000 0x300000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 151>;
+
+        qup-i2c9-state {
+            pins = "gpio6", "gpio7";
+            function = "qup9";
+        };
+    };
+...
-- 
2.38.0

