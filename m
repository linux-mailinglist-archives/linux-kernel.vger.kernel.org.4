Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2881F5F12B1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiI3TbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiI3TaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:30:21 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9EA41D23
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:30:11 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id q14so1600361lfo.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=QQuJTHBAF+LytlsG9mBEaNV8uzLklN/f5fClzGBdurk=;
        b=vT3g3+MoY2XVkwcmZMfyPg1UrzUeyqL9YcqekiXZ2Fb4qYVEAlIDCk43K1qMe+oqz1
         UhilEvqWkNcpN9l3Wf+gGwFpBZzSQt53iSWOk8yCxgOcQDF7dM/4S9bLqIhl6zVI5zsu
         /PbGls80vSFhVadRygCwtqVx2hN9i5rKbG++PHY20Me3lJOnPXjZ+QT0X+X8YwsmW252
         YlN2T0ws9jzCAx96/Xot4nC4fr9y0p9GVaRTagJCwV2GV/XMysR0W3sXadQoDK8JH75k
         WrOJpamuoxAi6sZZQsR04lVvdAaBI72Pv7qHDV119p68xg2NqdUfp4bot844dctMe2S7
         69Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QQuJTHBAF+LytlsG9mBEaNV8uzLklN/f5fClzGBdurk=;
        b=oRs677wZYdyvno3CD8wUD84jVP5adeiU2PLdPwZVjOV6wn63grSH7RUdvfeHDOO/he
         81vZx4g2bNrOgsxq2a7+slEJWQAnHt3mcaoY0z5mEJZcZaWewBJj0purI6oVb9YkKmES
         ka36e42VMdDzvDbWDopKOZFZ60WMs3KeZ5UlTO1K3nQDVn0wcLfWvLyiqEhvtKidHXHb
         JfEAaTJ0IXUyZp6SDwigt91hgeReeGNrIykyJOPBi2SiWV+JKe+uasxHPibAoenZvYLx
         zT7OLC5MyDBnoM34GPbGQ4Zo5w6EgzUTyRBgyu6Vx4kbVPuTLCJ9SjotlCLK/hP3eMw5
         O+lA==
X-Gm-Message-State: ACrzQf2IuIyHbArEHeTdQFoa3OByMPbINUjsyMTN7GzFyoGybBfNI+Y+
        pIQbnNODPpFjUE8J/4YFfJTt/g==
X-Google-Smtp-Source: AMsMyM6j8dUtqk8kFm4xOTV/VvdfWfMCzWtr5zTjONbotnJYi7EMTUBQPxho+ZO7BH+GLkpB6Ycedw==
X-Received: by 2002:ac2:4f03:0:b0:496:e4:4d16 with SMTP id k3-20020ac24f03000000b0049600e44d16mr3601706lfr.250.1664566210530;
        Fri, 30 Sep 2022 12:30:10 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id br32-20020a056512402000b0049f9799d349sm393603lfb.187.2022.09.30.12.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 12:30:10 -0700 (PDT)
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
Subject: [PATCH v2 13/16] dt-bindings: pinctrl: qcom,sm8250: fix matching pin config
Date:   Fri, 30 Sep 2022 21:29:51 +0200
Message-Id: <20220930192954.242546-14-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220930192954.242546-1-krzysztof.kozlowski@linaro.org>
References: <20220930192954.242546-1-krzysztof.kozlowski@linaro.org>
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
 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml | 128 +++++++++---------
 1 file changed, 67 insertions(+), 61 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
index 021592b32904..131eb8c981f8 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
@@ -58,68 +58,74 @@ properties:
 
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
+    additionalProperties: false
 
 allOf:
   - $ref: "pinctrl.yaml#"
-- 
2.34.1

