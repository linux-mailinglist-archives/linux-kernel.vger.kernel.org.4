Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BA9600260
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiJPRYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiJPRXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:23:36 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE24F3FEEF
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:22:50 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id o2so5438207qkk.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eo8OSi3RjShS3ZweZC7DDZy7VoZ+t8ZLyQ6wzB9q9iE=;
        b=eX308tZWAeXRj7cQesRYhA09rrGiKoMfGUkE9le/ey1pt1ca5E9B+Jd/HuZh1EIv9F
         t5Gd3O4YfR5uvWHPzMrCYrBJWODxcnOexIWqj9jYfgabIApqQOVSUroH7MzYAXE2kqFY
         WjiRon30nv3ZYRlsml8pxUMb5zzp4iomsbj6L2bsvSN3luDSEmIQXK13XQuv9ofUfWW0
         qPkaTMMchnyQNcCUyzREvRthFStyNk+pdtLuMV0CCujAWr1fAVcJ6WjG6t9JkVsr9aeg
         S7QdBMM/lOsSnc68Uw2wZBJk0+LK0gbjkeQPuIVqlvHA5QzWHUAjNckDM66cUvpVWw92
         7D3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eo8OSi3RjShS3ZweZC7DDZy7VoZ+t8ZLyQ6wzB9q9iE=;
        b=bR42EzbkPUrdPnOzsf5qlCR0zm2vzLUBg2QvFhSeyaarDfsqG3T2eoiviF2Q6DLPTW
         VNzbfvQDXO9Vp6gMSbyFCeXcr9/CwFhIba/5gG28ezS1Tkoa+l04Di+ky0fiqvbya2cu
         jwgGJ6aPwNj/CfvBMY5Fg8PvWvKc5Q0dF+z9Z38nZLkuzDSDPftWWrav+K6zzZI7BrLL
         qmPe8vh7tJbMtI9O4Ekx0xxOY4TAPslBN3J1aqqXU69PzLxdDGz4iIN24w+qEJ1V7mno
         L7jiQBRq2bix6MIWl8GUPEAQiESs/IvS9my9SnyF/HErvfcebJEAl08k3af80rk9fT9p
         2Gvg==
X-Gm-Message-State: ACrzQf1nbUXww8odW+N9Tg7tB4PZrFpqkNuygMwDOluRw5UzYfAenU2F
        kpHvaII4aj2aRpl1WCiszfv/XA==
X-Google-Smtp-Source: AMsMyM5KSzmQODYjxVTx4awQqt5U0KC8A26DJx7gEikeXC0HQgQyVMbUJBEEPKOv7eTf/FsbwSHWJQ==
X-Received: by 2002:a37:6044:0:b0:6cf:ce19:a73 with SMTP id u65-20020a376044000000b006cfce190a73mr5110429qkb.21.1665940970254;
        Sun, 16 Oct 2022 10:22:50 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id r5-20020ac87945000000b003431446588fsm6051008qtt.5.2022.10.16.10.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 10:22:49 -0700 (PDT)
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
Subject: [PATCH v3 13/17] dt-bindings: pinctrl: qcom,sm8250: fix matching pin config
Date:   Sun, 16 Oct 2022 13:22:08 -0400
Message-Id: <20221016172212.49105-14-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016172212.49105-1-krzysztof.kozlowski@linaro.org>
References: <20221016172212.49105-1-krzysztof.kozlowski@linaro.org>
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

The TLMM pin controller follows generic pin-controller bindings, so
should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
(level one and two) are not properly matched.  This method also unifies
the bindings with other Qualcomm TLMM and LPASS pinctrl bindings.

The change causes indentation decrement, so the diff-hunk looks big, but
there are no functional changes in the subnode "properties" section.
The only difference there is removal of blank lines between common GPIO
pinconf properties.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
---
 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml | 117 ++++++++++--------
 1 file changed, 62 insertions(+), 55 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
index 9447b79655e2..aa8315a4d9b1 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
@@ -58,62 +58,69 @@ properties:
 
   wakeup-parent: true
 
-#PIN CONFIGURATION NODES
 patternProperties:
-  '^.*$':
-    if:
-      type: object
-    then:
-      $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
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
-        bias-pull-down: true
-
-        bias-pull-up: true
-
-        bias-disable: true
-        drive-strength: true
-        output-high: true
-
-        output-low: true
-
-      required:
-        - pins
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
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
+
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
+      bias-pull-down: true
+      bias-pull-up: true
+      bias-disable: true
+      drive-strength: true
+      output-high: true
+      output-low: true
+
+    required:
+      - pins
+
+    additionalProperties: false
 
 allOf:
   - $ref: "pinctrl.yaml#"
-- 
2.34.1

