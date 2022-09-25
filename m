Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519C95E9289
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 13:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiIYLHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 07:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbiIYLGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 07:06:33 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C37D326D4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 04:06:27 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w8so6727863lft.12
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 04:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=VSmY5xCkqiUsI4yIOTfQRDN1TkL1CLqf4sQwb5AGTxQ=;
        b=CL2wvxjrpI5m4RFjdiR5YX7W1keSnVPz4ThoUmZTYvg5yqMhzIj0GaOLFgYcD9O+Qz
         VfBVJL854P7vyabGSCRSUj12DTIEFF3l0MxSRZrKfJdR49UnzH6gvmMpbHzkSwicJXOQ
         uH/bCR6fn0++LyGn8OfH+LlPqTD4UlihTS+6yB/7tTeEFIPRxx4/4LoBJFz47/dB7W+z
         BY8v6ZvxX41rvnBvKD2nT8g9NDWVMYilJoTc2YH4vtLxs71lTy3+5mQHIPmBAVvwaXil
         +SPfldLU/Df3gAPuTq3Ngqi2CcoktLQuGY9dMbtgMEyHwtAsiLxG9A+uuJILf+7MrZJs
         8pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VSmY5xCkqiUsI4yIOTfQRDN1TkL1CLqf4sQwb5AGTxQ=;
        b=1qy/+4ukwM0ccoDClsO7gYMRYCGvt1d8JYlpkIzCJ70l5meqbvEzJUIl1C4XxEnhXT
         Jjv221BbsvIWzQKFWQ3Lc7fgCXiXg3NAOkarqG5adt9vqGWhzd5eQQkKtg4g5xqe6rxt
         o2E4G0xdzXXmogtuWj7xorpESF8XixHg+6965c4IQP6eQPaCaVXRPMhvnAmMCKwHAMA7
         WZ0U5QWYu0EcBqR3lk7Ikw/mXud5vc59Uo60vwML/Q8Hg/UNdlT06ab5nXGCZM6rm2bL
         B/9V8p01gd9Wo0oVzOClsD+YE4iyrPBJOt5KuG+ZYV8COjHLG3WweWr9cTCvINQF9oP4
         /S4Q==
X-Gm-Message-State: ACrzQf0GobaJBreD5wI29IiqS4mP8dBXetN9Ojt3I2CQmb8SMK7zUoRF
        1a7wWIZmiOpDc9IqQr1jhpNZzQ==
X-Google-Smtp-Source: AMsMyM73q2RDaQcZoazF1ZKCRhvF5so9kyPxoFlYXT1HtJrWL8sn9+2NCd1sSBYbXeF+omu1bAF+aQ==
X-Received: by 2002:ac2:4e03:0:b0:485:74c4:97ce with SMTP id e3-20020ac24e03000000b0048574c497cemr6417726lfr.13.1664103986653;
        Sun, 25 Sep 2022 04:06:26 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u19-20020ac258d3000000b00492dadd8143sm2177265lfo.168.2022.09.25.04.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 04:06:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 12/15] dt-bindings: pinctrl: qcom,sm8250: fix matching pin config
Date:   Sun, 25 Sep 2022 13:06:05 +0200
Message-Id: <20220925110608.145728-13-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220925110608.145728-1-krzysztof.kozlowski@linaro.org>
References: <20220925110608.145728-1-krzysztof.kozlowski@linaro.org>
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

The TLMM pin controller follows generic pin-controller bindings, so
should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
(level one and two) are not properly matched.  This method also unifies
the bindings with other Qualcomm TLMM and LPASS pinctrl bindings.

The change causes indentation decrement, so the diff-hunk looks big, but
there are no functional changes in the subnode "properties" section.
The only difference there is removal of blank lines between common GPIO
pinconf properties.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml | 145 +++++++++---------
 1 file changed, 75 insertions(+), 70 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
index d7d8e5d3b659..da708c748a36 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
@@ -58,77 +58,82 @@ properties:
 
   wakeup-parent: true
 
-#PIN CONFIGURATION NODES
 patternProperties:
-  '^.*$':
-    if:
-      type: object
-    then:
-      properties:
-        pins:
-          description:
-            List of gpio pins affected by the properties specified in this
-            subnode.
-          items:
-            oneOf:
-              - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-7][0-9])$"
-              - enum: [ sdc2_clk, sdc2_cmd, sdc2_data, ufs_reset ]
-          minItems: 1
-          maxItems: 36
-
-        function:
-          description:
-            Specify the alternative function to be configured for the specified
-            pins.
-
-          enum: [ aoss_cti, atest, audio_ref, cam_mclk, cci_async, cci_i2c,
-                  cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4, cri_trng,
-                  cri_trng0, cri_trng1, dbg_out, ddr_bist, ddr_pxi0, ddr_pxi1,
-                  ddr_pxi2, ddr_pxi3, dp_hot, dp_lcd, gcc_gp1, gcc_gp2, gcc_gp3, gpio,
-                  ibi_i3c, jitter_bist, lpass_slimbus, mdp_vsync, mdp_vsync0,
-                  mdp_vsync1, mdp_vsync2, mdp_vsync3, mi2s0_data0, mi2s0_data1,
-                  mi2s0_sck, mi2s0_ws, mi2s1_data0, mi2s1_data1, mi2s1_sck, mi2s1_ws,
-                  mi2s2_data0, mi2s2_data1, mi2s2_sck, mi2s2_ws, pci_e0, pci_e1,
-                  pci_e2, phase_flag, pll_bist, pll_bypassnl, pll_clk, pll_reset,
-                  pri_mi2s, prng_rosc, qdss_cti, qdss_gpio, qspi0, qspi1, qspi2, qspi3,
-                  qspi_clk, qspi_cs, qup0, qup1, qup10, qup11, qup12, qup13, qup14,
-                  qup15, qup16, qup17, qup18, qup19, qup2, qup3, qup4, qup5, qup6,
-                  qup7, qup8, qup9, qup_l4, qup_l5, qup_l6, sd_write, sdc40, sdc41,
-                  sdc42, sdc43, sdc4_clk, sdc4_cmd, sec_mi2s, sp_cmu, tgu_ch0, tgu_ch1,
-                  tgu_ch2, tgu_ch3, tsense_pwm1, tsense_pwm2, tsif0_clk, tsif0_data,
-                  tsif0_en, tsif0_error, tsif0_sync, tsif1_clk, tsif1_data, tsif1_en,
-                  tsif1_error, tsif1_sync, usb2phy_ac, usb_phy, vsense_trigger ]
-
-        drive-strength:
-          enum: [2, 4, 6, 8, 10, 12, 14, 16]
-          default: 2
-          description:
-            Selects the drive strength for the specified pins, in mA.
-
-        bias-pull-down: true
-
-        bias-pull-up: true
-
-        bias-disable: true
-
-        output-high: true
-
-        output-low: true
-
-      required:
-        - pins
-
-      allOf:
-        - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
-        - if:
-            properties:
-              pins:
-                pattern: "^gpio([0-9]|[1-9][0-9]|1[0-7][0-9])$"
-          then:
-            required:
-              - function
-
-      additionalProperties: false
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-sm8250-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-sm8250-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-sm8250-tlmm-state:
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          oneOf:
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-7][0-9])$"
+            - enum: [ sdc2_clk, sdc2_cmd, sdc2_data, ufs_reset ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+        enum: [ aoss_cti, atest, audio_ref, cam_mclk, cci_async, cci_i2c,
+                cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4, cri_trng,
+                cri_trng0, cri_trng1, dbg_out, ddr_bist, ddr_pxi0, ddr_pxi1,
+                ddr_pxi2, ddr_pxi3, dp_hot, dp_lcd, gcc_gp1, gcc_gp2, gcc_gp3, gpio,
+                ibi_i3c, jitter_bist, lpass_slimbus, mdp_vsync, mdp_vsync0,
+                mdp_vsync1, mdp_vsync2, mdp_vsync3, mi2s0_data0, mi2s0_data1,
+                mi2s0_sck, mi2s0_ws, mi2s1_data0, mi2s1_data1, mi2s1_sck, mi2s1_ws,
+                mi2s2_data0, mi2s2_data1, mi2s2_sck, mi2s2_ws, pci_e0, pci_e1,
+                pci_e2, phase_flag, pll_bist, pll_bypassnl, pll_clk, pll_reset,
+                pri_mi2s, prng_rosc, qdss_cti, qdss_gpio, qspi0, qspi1, qspi2, qspi3,
+                qspi_clk, qspi_cs, qup0, qup1, qup10, qup11, qup12, qup13, qup14,
+                qup15, qup16, qup17, qup18, qup19, qup2, qup3, qup4, qup5, qup6,
+                qup7, qup8, qup9, qup_l4, qup_l5, qup_l6, sd_write, sdc40, sdc41,
+                sdc42, sdc43, sdc4_clk, sdc4_cmd, sec_mi2s, sp_cmu, tgu_ch0, tgu_ch1,
+                tgu_ch2, tgu_ch3, tsense_pwm1, tsense_pwm2, tsif0_clk, tsif0_data,
+                tsif0_en, tsif0_error, tsif0_sync, tsif1_clk, tsif1_data, tsif1_en,
+                tsif1_error, tsif1_sync, usb2phy_ac, usb_phy, vsense_trigger ]
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
+              pattern: "^gpio([0-9]|[1-9][0-9]|1[0-7][0-9])$"
+        then:
+          required:
+            - function
+
+    additionalProperties: false
 
 allOf:
   - $ref: "pinctrl.yaml#"
-- 
2.34.1

