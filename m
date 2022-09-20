Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4DB5BD9F2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 04:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiITCQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 22:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiITCQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 22:16:46 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540A513E9F;
        Mon, 19 Sep 2022 19:16:45 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id d16so663036ils.8;
        Mon, 19 Sep 2022 19:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=YpTog3JkdJDmG6Ptr/Ro3eF8uGe57OgKdCkBLo2iFow=;
        b=Y0aqv1PHGcDxjUVOiGqMxAkcSiTuHeVkjWi/DFyyjyEactkaQUQbSTYGYhy2cI0cBE
         UPJIBT1KeFn9K60rcMFZQh7xd8E/2NdsY8IQ0L2J6HcsN910MbLepcr9toKV/ppsLDi5
         v1fMlg2KbYttUmedl+ypMMqda/zqizkQHw6s5f8Tt31r/h6DptcUP2YRIn8MeT5H7/aF
         U9QWCSQGWG25yKdIVpf6pRT91vUJDdr/rb34P0o/Z4jrDwjdX4DavogEGWIIvtfCud5+
         OyDLZWPu7+WhJQK186Mj+/ePE1CEdFvN7cRyCYY2fozONXboLkThu7csz9WoMltjeV12
         /mWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YpTog3JkdJDmG6Ptr/Ro3eF8uGe57OgKdCkBLo2iFow=;
        b=VJ5hWwVsQt/veZ0ULkWI4IJOXn4VlAHe/ZaSYO7WMKVhQqxtiWO7Jw4XTYdIpQBL1J
         N7Kaks9GzZUfWMy3KTE2yjDQG3eMJKHhbBXFJx5ldaz/noQBIu62zcvK4J2XB5EunM4K
         lp2TDqn8qU3YOCYVMBAJvyi7RC/bjiYW++KVXinDg6XCAVMTeYzakfu/liaeQ3W96zNU
         6qY648FxzztrW1PBcc0NBZNofMuwyg+2jw2cvxEYlJRHXjDqOZmt3to3mkzBJv0AauFE
         o9+CdIgVG9y1/v7FCRLXVnd5K7envTCIu+FKRfLV5gQSyi1A84Ks+gWk91Ei9n+fWpYR
         tTOg==
X-Gm-Message-State: ACrzQf2mOBWZNgZ1tZQV/vF0hEuOoVuMeQKy+/L3te8euWItl9suYFyw
        Yzfqcvvx6olHqVA9ZG4g8APKZzMVFYY=
X-Google-Smtp-Source: AMsMyM4dqOwDl099drYW4l9dq0tVOres/dLvHtM5y2RDKaFSYVEPWfXJZt+SG3DbCL7kj1E5wZwoGg==
X-Received: by 2002:a92:ccd0:0:b0:2f6:274c:f564 with SMTP id u16-20020a92ccd0000000b002f6274cf564mr1112212ilq.116.1663640204443;
        Mon, 19 Sep 2022 19:16:44 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::58d4])
        by smtp.gmail.com with UTF8SMTPSA id j5-20020a0566022cc500b006a25a193a7bsm117300iow.20.2022.09.19.19.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 19:16:44 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v3 1/3] dt-bindings: pinctrl: qcom: add sdm670 pinctrl
Date:   Mon, 19 Sep 2022 22:16:34 -0400
Message-Id: <20220920021636.1634-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920021636.1634-1-mailingradian@gmail.com>
References: <20220920021636.1634-1-mailingradian@gmail.com>
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

Adapted from qcom,sm6350-pinctrl.yaml in the same directory at
commit c09acbc499e8 ("dt-bindings: pinctrl: use pinctrl.yaml").

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 .../bindings/pinctrl/qcom,sdm670-tlmm.yaml    | 138 ++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
new file mode 100644
index 000000000000..b9d07a0c6dc2
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
@@ -0,0 +1,138 @@
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
+    maxItems: 76
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
+  '-state$':
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
+    allOf:
+      - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
+      - if:
+          properties:
+            pins:
+              pattern: "^gpio([0-9]|[1-9][0-9]|1[0-4][0-9])$"
+        then:
+          required:
+            - function
+
+    additionalProperties: false
+
+examples:
+  - |
+        #include <dt-bindings/interrupt-controller/arm-gic.h>
+        pinctrl@3400000 {
+                compatible = "qcom,sdm670-tlmm";
+                reg = <0x03400000 0x300000>;
+                interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+                gpio-controller;
+                #gpio-cells = <2>;
+                interrupt-controller;
+                #interrupt-cells = <2>;
+                gpio-ranges = <&tlmm 0 0 151>;
+
+                qup-i2c9-state {
+                        pins = "gpio6", "gpio7";
+                        function = "qup9";
+                };
+        };
+...
-- 
2.37.3

