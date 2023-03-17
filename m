Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0826BF685
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 00:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjCQXgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 19:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCQXg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 19:36:28 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7EF5F236;
        Fri, 17 Mar 2023 16:36:22 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id f14so3004613iow.5;
        Fri, 17 Mar 2023 16:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679096182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9mJ4gBbzJW/jLgwBgdQ9NurBXu5dWraoFyNH2hL32I=;
        b=CoRGKRX780maV25UZyYDT7RG+CGbiPLCELuq8iL5ZJ9G6I351TyR6SS1daWW78MhwW
         Nm0Hp+GdUcppRGRuNy+BTAfw8aZvsN47uiJzbQgeKAiQqFSA9tZ0YraLHKTM22+XMWHH
         TfpdEvFm0q0oVlqGnr8sGng6QYUg/4pvo4KB/qoR2k4DlZW2/fJqWFUkRdCxnHdkmsJn
         V2IvhGt2ike7hTW+r7YVfgz56DkNzG9JPegzaOKKGtMpvhsI2jMavD+9CxOhocKSIdh1
         BubGEhLO1lwkipYRFIs3yOW8sif/nVdDzbA6U/asTyDCO2ZShrB5eGBLwSx/qLQYS2qs
         Ti2w==
X-Gm-Message-State: AO0yUKXtGgjt0LoUdMDHr1NGL9Krzkr7i+XXLMoCNQpZYtXzM1vF7+gN
        raScOPiji3j4/bZDxarZRA==
X-Google-Smtp-Source: AK7set9BcX24R10T31XKQmxfyekFzc2clwSrZ/upqb17tJPU7EkiHRPkKbK+wk90LjAtkZhwPnyl3g==
X-Received: by 2002:a6b:c411:0:b0:74c:a5ac:7759 with SMTP id y17-20020a6bc411000000b0074ca5ac7759mr244882ioa.5.1679096181570;
        Fri, 17 Mar 2023 16:36:21 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id g33-20020a028524000000b00403d770399csm1092780jai.3.2023.03.17.16.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 16:36:21 -0700 (PDT)
Received: (nullmailer pid 3968128 invoked by uid 1000);
        Fri, 17 Mar 2023 23:36:18 -0000
From:   Rob Herring <robh@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        patches@opensource.cirrus.com
Subject: [PATCH] regulator: dt-bindings: Drop unneeded quotes
Date:   Fri, 17 Mar 2023 18:36:14 -0500
Message-Id: <20230317233616.3968003-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/regulator/anatop-regulator.yaml  | 22 +++++++++----------
 .../bindings/regulator/dlg,da9121.yaml        |  2 +-
 .../bindings/regulator/fixed-regulator.yaml   |  2 +-
 .../regulator/google,cros-ec-regulator.yaml   |  2 +-
 .../bindings/regulator/gpio-regulator.yaml    |  2 +-
 .../regulator/max77650-regulator.yaml         |  2 +-
 .../bindings/regulator/max8660.yaml           |  2 +-
 .../bindings/regulator/max8893.yaml           |  2 +-
 .../regulator/mediatek,mt6331-regulator.yaml  | 12 +++++-----
 .../regulator/mediatek,mt6332-regulator.yaml  |  4 ++--
 .../bindings/regulator/mps,mp5416.yaml        |  4 ++--
 .../bindings/regulator/mps,mp886x.yaml        |  2 +-
 .../bindings/regulator/mps,mpq7920.yaml       |  6 ++---
 .../bindings/regulator/mt6315-regulator.yaml  |  2 +-
 .../bindings/regulator/mt6359-regulator.yaml  | 16 +++++++-------
 .../bindings/regulator/mt6360-regulator.yaml  |  4 ++--
 .../regulator/nxp,pca9450-regulator.yaml      |  4 ++--
 .../regulator/nxp,pf8x00-regulator.yaml       |  4 ++--
 .../bindings/regulator/pfuze100.yaml          |  8 +++----
 .../regulator/qcom,rpmh-regulator.yaml        |  8 +++----
 ...ypi,7inch-touchscreen-panel-regulator.yaml |  2 +-
 .../bindings/regulator/regulator.yaml         | 22 +++++++++----------
 .../regulator/richtek,rt6245-regulator.yaml   |  8 +++----
 .../regulator/richtek,rtmv20-regulator.yaml   |  2 +-
 .../regulator/rohm,bd71815-regulator.yaml     |  8 +++----
 .../regulator/rohm,bd71828-regulator.yaml     |  8 +++----
 .../regulator/rohm,bd71837-regulator.yaml     |  6 ++---
 .../regulator/rohm,bd71847-regulator.yaml     |  6 ++---
 .../regulator/rohm,bd9576-regulator.yaml      |  2 +-
 .../socionext,uniphier-regulator.yaml         |  2 +-
 .../bindings/regulator/st,stm32-booster.yaml  |  4 ++--
 .../bindings/regulator/st,stm32-vrefbuf.yaml  |  2 +-
 .../regulator/st,stm32mp1-pwr-reg.yaml        |  2 +-
 .../bindings/regulator/ti,tps62360.yaml       |  2 +-
 .../regulator/vqmmc-ipq4019-regulator.yaml    |  2 +-
 .../bindings/regulator/wlf,arizona.yaml       |  6 ++---
 36 files changed, 97 insertions(+), 97 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/anatop-regulator.yaml b/Documentation/devicetree/bindings/regulator/anatop-regulator.yaml
index 0a66338c7e5a..17250378542a 100644
--- a/Documentation/devicetree/bindings/regulator/anatop-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/anatop-regulator.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
 
 allOf:
-  - $ref: "regulator.yaml#"
+  - $ref: regulator.yaml#
 
 properties:
   compatible:
@@ -19,43 +19,43 @@ properties:
   regulator-name: true
 
   anatop-reg-offset:
-    $ref: '/schemas/types.yaml#/definitions/uint32'
+    $ref: /schemas/types.yaml#/definitions/uint32
     description: u32 value representing the anatop MFD register offset.
 
   anatop-vol-bit-shift:
-    $ref: '/schemas/types.yaml#/definitions/uint32'
+    $ref: /schemas/types.yaml#/definitions/uint32
     description: u32 value representing the bit shift for the register.
 
   anatop-vol-bit-width:
-    $ref: '/schemas/types.yaml#/definitions/uint32'
+    $ref: /schemas/types.yaml#/definitions/uint32
     description: u32 value representing the number of bits used in the register.
 
   anatop-min-bit-val:
-    $ref: '/schemas/types.yaml#/definitions/uint32'
+    $ref: /schemas/types.yaml#/definitions/uint32
     description: u32 value representing the minimum value of this register.
 
   anatop-min-voltage:
-    $ref: '/schemas/types.yaml#/definitions/uint32'
+    $ref: /schemas/types.yaml#/definitions/uint32
     description: u32 value representing the minimum voltage of this regulator.
 
   anatop-max-voltage:
-    $ref: '/schemas/types.yaml#/definitions/uint32'
+    $ref: /schemas/types.yaml#/definitions/uint32
     description: u32 value representing the maximum voltage of this regulator.
 
   anatop-delay-reg-offset:
-    $ref: '/schemas/types.yaml#/definitions/uint32'
+    $ref: /schemas/types.yaml#/definitions/uint32
     description: u32 value representing the anatop MFD step time register offset.
 
   anatop-delay-bit-shift:
-    $ref: '/schemas/types.yaml#/definitions/uint32'
+    $ref: /schemas/types.yaml#/definitions/uint32
     description: u32 value representing the bit shift for the step time register.
 
   anatop-delay-bit-width:
-    $ref: '/schemas/types.yaml#/definitions/uint32'
+    $ref: /schemas/types.yaml#/definitions/uint32
     description: u32 value representing the number of bits used in the step time register.
 
   anatop-enable-bit:
-    $ref: '/schemas/types.yaml#/definitions/uint32'
+    $ref: /schemas/types.yaml#/definitions/uint32
     description: u32 value representing regulator enable bit offset.
 
   vin-supply:
diff --git a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
index 63e1161a87de..dc626517c2ad 100644
--- a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
+++ b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
@@ -109,7 +109,7 @@ properties:
             description: Specify a valid GPIO for platform control of the regulator
 
           dlg,ripple-cancel:
-            $ref: "/schemas/types.yaml#/definitions/uint32"
+            $ref: /schemas/types.yaml#/definitions/uint32
             enum: [ 0, 1, 2, 3 ]
             description: |
               Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
index 48af7cba4652..ac0281b1cceb 100644
--- a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
@@ -17,7 +17,7 @@ description:
   to be the same.
 
 allOf:
-  - $ref: "regulator.yaml#"
+  - $ref: regulator.yaml#
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/regulator/google,cros-ec-regulator.yaml b/Documentation/devicetree/bindings/regulator/google,cros-ec-regulator.yaml
index 0921f012c901..e0ff5012b763 100644
--- a/Documentation/devicetree/bindings/regulator/google,cros-ec-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/google,cros-ec-regulator.yaml
@@ -14,7 +14,7 @@ description:
   regulator.yaml, can also be used.
 
 allOf:
-  - $ref: "regulator.yaml#"
+  - $ref: regulator.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/regulator/gpio-regulator.yaml b/Documentation/devicetree/bindings/regulator/gpio-regulator.yaml
index 6c3371d706bb..f4c1f36e52e9 100644
--- a/Documentation/devicetree/bindings/regulator/gpio-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/gpio-regulator.yaml
@@ -15,7 +15,7 @@ description:
   regulator.txt, can also be used.
 
 allOf:
-  - $ref: "regulator.yaml#"
+  - $ref: regulator.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/regulator/max77650-regulator.yaml b/Documentation/devicetree/bindings/regulator/max77650-regulator.yaml
index 01b9775a92d1..27d5e9c2bb93 100644
--- a/Documentation/devicetree/bindings/regulator/max77650-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/max77650-regulator.yaml
@@ -25,7 +25,7 @@ properties:
 
 patternProperties:
   "^regulator-(ldo|sbb[0-2])$":
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
     unevaluatedProperties: false
 
 required:
diff --git a/Documentation/devicetree/bindings/regulator/max8660.yaml b/Documentation/devicetree/bindings/regulator/max8660.yaml
index 35792a927b03..f05f4644c8ee 100644
--- a/Documentation/devicetree/bindings/regulator/max8660.yaml
+++ b/Documentation/devicetree/bindings/regulator/max8660.yaml
@@ -25,7 +25,7 @@ properties:
 
     patternProperties:
       "^regulator-.+$":
-        $ref: "regulator.yaml#"
+        $ref: regulator.yaml#
         unevaluatedProperties: false
 
     additionalProperties: false
diff --git a/Documentation/devicetree/bindings/regulator/max8893.yaml b/Documentation/devicetree/bindings/regulator/max8893.yaml
index 2b5e977bf409..e40ee798e198 100644
--- a/Documentation/devicetree/bindings/regulator/max8893.yaml
+++ b/Documentation/devicetree/bindings/regulator/max8893.yaml
@@ -25,7 +25,7 @@ properties:
 
     patternProperties:
       "^(ldo[1-5]|buck)$":
-        $ref: "regulator.yaml#"
+        $ref: regulator.yaml#
 
     additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6331-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6331-regulator.yaml
index 771cc134393c..79e5198e1c73 100644
--- a/Documentation/devicetree/bindings/regulator/mediatek,mt6331-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6331-regulator.yaml
@@ -18,7 +18,7 @@ description: |
 patternProperties:
   "^buck-v(core2|io18|dvfs11|dvfs12|dvfs13|dvfs14)$":
     type: object
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
 
     properties:
       regulator-name:
@@ -28,7 +28,7 @@ patternProperties:
 
   "^ldo-v(avdd32aud|auxa32)$":
     type: object
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
 
     properties:
       regulator-name:
@@ -38,7 +38,7 @@ patternProperties:
 
   "^ldo-v(dig18|emc33|ibr|mc|mch|mipi|rtc|sram|usb10)$":
     type: object
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
 
     properties:
       regulator-name:
@@ -48,7 +48,7 @@ patternProperties:
 
   "^ldo-vcam(a|af|d|io)$":
     type: object
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
 
     properties:
       regulator-name:
@@ -58,7 +58,7 @@ patternProperties:
 
   "^ldo-vtcxo[12]$":
     type: object
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
 
     properties:
       regulator-name:
@@ -71,7 +71,7 @@ patternProperties:
 
   "^ldo-vgp[1234]$":
     type: object
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
 
     properties:
       regulator-name:
diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6332-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6332-regulator.yaml
index 3218f43e6957..2eb512c29a0d 100644
--- a/Documentation/devicetree/bindings/regulator/mediatek,mt6332-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6332-regulator.yaml
@@ -18,7 +18,7 @@ description: |
 patternProperties:
   "^buck-v(dram|dvfs2|pa|rf18a|rf18b|sbst)$":
     type: object
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
 
     properties:
       regulator-name:
@@ -28,7 +28,7 @@ patternProperties:
 
   "^ldo-v(bif28|dig18|sram|usb33)$":
     type: object
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
 
     properties:
       regulator-name:
diff --git a/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml b/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
index 7023c597c3ed..2e720d152890 100644
--- a/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
+++ b/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
@@ -28,11 +28,11 @@ properties:
 
     patternProperties:
       "^buck[1-4]$":
-        $ref: "regulator.yaml#"
+        $ref: regulator.yaml#
         type: object
 
       "^ldo[1-4]$":
-        $ref: "regulator.yaml#"
+        $ref: regulator.yaml#
         type: object
 
     additionalProperties: false
diff --git a/Documentation/devicetree/bindings/regulator/mps,mp886x.yaml b/Documentation/devicetree/bindings/regulator/mps,mp886x.yaml
index 9245b7199439..374a4f6b1e23 100644
--- a/Documentation/devicetree/bindings/regulator/mps,mp886x.yaml
+++ b/Documentation/devicetree/bindings/regulator/mps,mp886x.yaml
@@ -28,7 +28,7 @@ properties:
   mps,fb-voltage-divider:
     description: An array of two integers containing the resistor
       values R1 and R2 of the feedback voltage divider in kilo ohms.
-    $ref: "/schemas/types.yaml#/definitions/uint32-array"
+    $ref: /schemas/types.yaml#/definitions/uint32-array
     maxItems: 2
 
   mps,switch-frequency-hz:
diff --git a/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
index c2e8c54e5311..f3fcfc8be72f 100644
--- a/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
+++ b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
@@ -29,7 +29,7 @@ properties:
 
     properties:
       mps,switch-freq:
-        $ref: "/schemas/types.yaml#/definitions/uint8"
+        $ref: /schemas/types.yaml#/definitions/uint8
         enum: [0, 1, 2, 3]
         default: 2
         description: |
@@ -51,14 +51,14 @@ properties:
 
         properties:
           mps,buck-softstart:
-            $ref: "/schemas/types.yaml#/definitions/uint8"
+            $ref: /schemas/types.yaml#/definitions/uint8
             enum: [0, 1, 2, 3]
             description: |
               defines the soft start time of this buck, must be one of the following
               corresponding values 150us, 300us, 610us, 920us
 
           mps,buck-phase-delay:
-            $ref: "/schemas/types.yaml#/definitions/uint8"
+            $ref: /schemas/types.yaml#/definitions/uint8
             enum: [0, 1, 2, 3]
             description: |
               defines the phase delay of this buck, must be one of the following
diff --git a/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml b/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
index 364b58730be2..6317daf76d1f 100644
--- a/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
@@ -28,7 +28,7 @@ properties:
     patternProperties:
       "^vbuck[1-4]$":
         type: object
-        $ref: "regulator.yaml#"
+        $ref: regulator.yaml#
         unevaluatedProperties: false
 
         properties:
diff --git a/Documentation/devicetree/bindings/regulator/mt6359-regulator.yaml b/Documentation/devicetree/bindings/regulator/mt6359-regulator.yaml
index 8cc413eb482d..d6b3b5a5c0b3 100644
--- a/Documentation/devicetree/bindings/regulator/mt6359-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/mt6359-regulator.yaml
@@ -17,7 +17,7 @@ description: |
 patternProperties:
   "^buck_v(s1|gpu11|modem|pu|core|s2|pa|proc2|proc1|core_sshub)$":
     type: object
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
 
     properties:
       regulator-name:
@@ -27,7 +27,7 @@ patternProperties:
 
   "^ldo_v(ibr|rf12|usb|camio|efuse|xo22)$":
     type: object
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
 
     properties:
       regulator-name:
@@ -37,7 +37,7 @@ patternProperties:
 
   "^ldo_v(rfck|emc|a12|a09|ufs|bbck)$":
     type: object
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
 
     properties:
       regulator-name:
@@ -47,7 +47,7 @@ patternProperties:
 
   "^ldo_vcn(18|13|33_1_bt|13_1_wifi|33_2_bt|33_2_wifi)$":
     type: object
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
 
     properties:
       regulator-name:
@@ -57,7 +57,7 @@ patternProperties:
 
   "^ldo_vsram_(proc2|others|md|proc1|others_sshub)$":
     type: object
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
 
     properties:
       regulator-name:
@@ -67,7 +67,7 @@ patternProperties:
 
   "^ldo_v(fe|bif|io)28$":
     type: object
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
 
     properties:
       regulator-name:
@@ -77,7 +77,7 @@ patternProperties:
 
   "^ldo_v(aud|io|aux|rf|m)18$":
     type: object
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
 
     properties:
       regulator-name:
@@ -87,7 +87,7 @@ patternProperties:
 
   "^ldo_vsim[12]$":
     type: object
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
 
     properties:
       regulator-name:
diff --git a/Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml b/Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml
index 8a0931dc2f30..9c879bc3c360 100644
--- a/Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml
@@ -26,11 +26,11 @@ properties:
 
 patternProperties:
   "^buck[12]$":
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
     unevaluatedProperties: false
 
   "^ldo[123567]$":
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
     unevaluatedProperties: false
 
 required:
diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index 6b53dc87694e..3d469b8e9774 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -57,7 +57,7 @@ properties:
 
         properties:
           nxp,dvs-run-voltage:
-            $ref: "/schemas/types.yaml#/definitions/uint32"
+            $ref: /schemas/types.yaml#/definitions/uint32
             minimum: 600000
             maximum: 2187500
             description:
@@ -65,7 +65,7 @@ properties:
               dvs(dynamic voltage scaling) property.
 
           nxp,dvs-standby-voltage:
-            $ref: "/schemas/types.yaml#/definitions/uint32"
+            $ref: /schemas/types.yaml#/definitions/uint32
             minimum: 600000
             maximum: 2187500
             description:
diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
index aabf50f5b39e..8c0f37d8d082 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
@@ -59,7 +59,7 @@ properties:
               should be "buck1", ..., "buck7"
 
           nxp,ilim-ma:
-            $ref: "/schemas/types.yaml#/definitions/uint32"
+            $ref: /schemas/types.yaml#/definitions/uint32
             minimum: 2100
             maximum: 4500
             deprecated: true
@@ -75,7 +75,7 @@ properties:
               4500
 
           nxp,phase-shift:
-            $ref: "/schemas/types.yaml#/definitions/uint32"
+            $ref: /schemas/types.yaml#/definitions/uint32
             default: 0
             enum: [ 0, 45, 90, 135, 180, 225, 270, 315 ]
             description:
diff --git a/Documentation/devicetree/bindings/regulator/pfuze100.yaml b/Documentation/devicetree/bindings/regulator/pfuze100.yaml
index a26bbd68b729..67a30b23b92c 100644
--- a/Documentation/devicetree/bindings/regulator/pfuze100.yaml
+++ b/Documentation/devicetree/bindings/regulator/pfuze100.yaml
@@ -63,19 +63,19 @@ properties:
 
     patternProperties:
       "^sw([1-4]|[1-4][a-c]|[1-4][a-c][a-c])$":
-        $ref: "regulator.yaml#"
+        $ref: regulator.yaml#
         type: object
 
       "^vgen[1-6]$":
-        $ref: "regulator.yaml#"
+        $ref: regulator.yaml#
         type: object
 
       "^vldo[1-4]$":
-        $ref: "regulator.yaml#"
+        $ref: regulator.yaml#
         type: object
 
       "^(vsnvs|vref|vrefddr|swbst|coin|v33|vccsd)$":
-        $ref: "regulator.yaml#"
+        $ref: regulator.yaml#
         type: object
 
     additionalProperties: false
diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 297a75069f60..a765837dc069 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -105,18 +105,18 @@ properties:
 
   bob:
     type: object
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
     description: BOB regulator node.
     dependencies:
-      regulator-allow-set-load: ["regulator-allowed-modes"]
+      regulator-allow-set-load: [ regulator-allowed-modes ]
 
 patternProperties:
   "^(smps|ldo|lvs|bob)[0-9]+$":
     type: object
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
     description: smps/ldo regulator nodes(s).
     dependencies:
-      regulator-allow-set-load: ["regulator-allowed-modes"]
+      regulator-allow-set-load: [ regulator-allowed-modes ]
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/regulator/raspberrypi,7inch-touchscreen-panel-regulator.yaml b/Documentation/devicetree/bindings/regulator/raspberrypi,7inch-touchscreen-panel-regulator.yaml
index 0ae25d119b6f..41678400e63f 100644
--- a/Documentation/devicetree/bindings/regulator/raspberrypi,7inch-touchscreen-panel-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/raspberrypi,7inch-touchscreen-panel-regulator.yaml
@@ -15,7 +15,7 @@ description: |
   and control the backlight.
 
 allOf:
-  - $ref: "regulator.yaml#"
+  - $ref: regulator.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/regulator/regulator.yaml b/Documentation/devicetree/bindings/regulator/regulator.yaml
index 53b81d8a2d41..e158c2d3d3f9 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/regulator.yaml
@@ -13,7 +13,7 @@ maintainers:
 properties:
   regulator-name:
     description: A string used as a descriptive name for regulator outputs
-    $ref: "/schemas/types.yaml#/definitions/string"
+    $ref: /schemas/types.yaml#/definitions/string
 
   regulator-min-microvolt:
     description: smallest voltage consumers may set
@@ -23,7 +23,7 @@ properties:
 
   regulator-microvolt-offset:
     description: Offset applied to voltages to compensate for voltage drops
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
 
   regulator-min-microamp:
     description: smallest current consumers may set
@@ -59,7 +59,7 @@ properties:
     description: ramp delay for regulator(in uV/us) For hardware which supports
       disabling ramp rate, it should be explicitly initialised to zero (regulator-ramp-delay
       = <0>) for disabling ramp delay.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
 
   regulator-enable-ramp-delay:
     description: The time taken, in microseconds, for the supply rail to
@@ -68,7 +68,7 @@ properties:
       required due to the combination of internal ramping of the regulator
       itself, and board design issues such as trace capacitance and load
       on the supply.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
 
   regulator-settling-time-us:
     description: Settling time, in microseconds, for voltage change if regulator
@@ -95,7 +95,7 @@ properties:
     description: initial operating mode. The set of possible operating modes
       depends on the capabilities of every hardware so each device binding
       documentation explains which values the regulator supports.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
 
   regulator-allowed-modes:
     description: list of operating modes that software is allowed to configure
@@ -103,12 +103,12 @@ properties:
       The set of possible operating modes depends on the capabilities of
       every hardware so each device binding document explains which values
       the regulator supports.
-    $ref: "/schemas/types.yaml#/definitions/uint32-array"
+    $ref: /schemas/types.yaml#/definitions/uint32-array
 
   regulator-system-load:
     description: Load in uA present on regulator that is not captured by
       any consumer request.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
 
   regulator-pull-down:
     description: Enable pull down resistor when the regulator is disabled.
@@ -206,14 +206,14 @@ properties:
       0: Disable active discharge.
       1: Enable active discharge.
       Absence of this property will leave configuration to default.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1]
 
   regulator-coupled-with:
     description: Regulators with which the regulator is coupled. The linkage
       is 2-way - all coupled regulators should be linked with each other.
       A regulator should not be coupled with its supplier.
-    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
       maxItems: 1
 
@@ -221,7 +221,7 @@ properties:
     description: Array of maximum spread between voltages of coupled regulators
       in microvolts, each value in the array relates to the corresponding
       couple specified by the regulator-coupled-with property.
-    $ref: "/schemas/types.yaml#/definitions/uint32-array"
+    $ref: /schemas/types.yaml#/definitions/uint32-array
 
   regulator-max-step-microvolt:
     description: Maximum difference between current and target voltages
@@ -269,7 +269,7 @@ patternProperties:
           of possible operating modes depends on the capabilities of every
           hardware so the valid modes are documented on each regulator device
           tree binding document.
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
 
     additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt6245-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt6245-regulator.yaml
index e983d0e70c9b..b73762e151bb 100644
--- a/Documentation/devicetree/bindings/regulator/richtek,rt6245-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt6245-regulator.yaml
@@ -32,7 +32,7 @@ properties:
     maxItems: 1
 
   richtek,oc-level-select:
-    $ref: "/schemas/types.yaml#/definitions/uint8"
+    $ref: /schemas/types.yaml#/definitions/uint8
     enum: [0, 1, 2, 3]
     description: |
       Over current level selection. Each respective value means the current
@@ -40,7 +40,7 @@ properties:
       in chip default.
 
   richtek,ot-level-select:
-    $ref: "/schemas/types.yaml#/definitions/uint8"
+    $ref: /schemas/types.yaml#/definitions/uint8
     enum: [0, 1, 2]
     description: |
       Over temperature level selection. Each respective value means the degree
@@ -48,7 +48,7 @@ properties:
       default.
 
   richtek,pgdly-time-select:
-    $ref: "/schemas/types.yaml#/definitions/uint8"
+    $ref: /schemas/types.yaml#/definitions/uint8
     enum: [0, 1, 2, 3]
     description: |
       Power good signal delay time selection. Each respective value means the
@@ -57,7 +57,7 @@ properties:
 
 
   richtek,switch-freq-select:
-    $ref: "/schemas/types.yaml#/definitions/uint8"
+    $ref: /schemas/types.yaml#/definitions/uint8
     enum: [0, 1, 2]
     description: |
       Buck switch frequency selection. Each respective value means 400KHz,
diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml
index a8ccb5cb8d77..446ec5127d1f 100644
--- a/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml
@@ -120,7 +120,7 @@ properties:
   lsw:
     description: load switch current regulator description.
     type: object
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71815-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71815-regulator.yaml
index 027fab3dc181..cc4ceb32e9d6 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71815-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71815-regulator.yaml
@@ -56,7 +56,7 @@ patternProperties:
           PMIC "RUN" state voltage in uV when PMIC HW states are used. See
           comments below for bucks/LDOs which support this. 0 means
           regulator should be disabled at RUN state.
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 3300000
 
@@ -67,7 +67,7 @@ patternProperties:
           keeps regulator enabled. BD71815 does not change voltage level
           when PMIC transitions to SNVS.SNVS voltage depends on the previous
           state (from which the PMIC transitioned to SNVS).
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 3300000
 
@@ -76,7 +76,7 @@ patternProperties:
           PMIC "SUSPEND" state voltage in uV when PMIC HW states are used. See
           comments below for bucks/LDOs which support this. 0 means
           regulator should be disabled at SUSPEND state.
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 3300000
 
@@ -85,7 +85,7 @@ patternProperties:
           PMIC "LPSR" state voltage in uV when PMIC HW states are used. See
           comments below for bucks/LDOs which support this. 0 means
           regulator should be disabled at LPSR state.
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 3300000
 
diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71828-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71828-regulator.yaml
index bbf38d5cd06d..d898800d6bca 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71828-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71828-regulator.yaml
@@ -52,7 +52,7 @@ patternProperties:
         description:
           PMIC default "RUN" state voltage in uV. See below table for
           bucks which support this. 0 means disabled.
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 3300000
 
@@ -60,7 +60,7 @@ patternProperties:
         description:
           PMIC default "IDLE" state voltage in uV. See below table for
           bucks which support this. 0 means disabled.
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 3300000
 
@@ -68,7 +68,7 @@ patternProperties:
         description:
           PMIC default "SUSPEND" state voltage in uV. See below table for
           bucks which support this. 0 means disabled.
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 3300000
 
@@ -76,7 +76,7 @@ patternProperties:
         description:
           PMIC default "LPSR" state voltage in uV. See below table for
           bucks which support this. 0 means disabled.
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 3300000
 
diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml
index abf1fbdf3850..29b350a4f88a 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml
@@ -55,7 +55,7 @@ patternProperties:
           should be "buck1", ..., "buck8"
 
       rohm,dvs-run-voltage:
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 1300000
         description:
@@ -63,7 +63,7 @@ patternProperties:
           bucks which support this. 0 means disabled.
 
       rohm,dvs-idle-voltage:
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 1300000
         description:
@@ -71,7 +71,7 @@ patternProperties:
           bucks which support this. 0 means disabled.
 
       rohm,dvs-suspend-voltage:
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 1300000
         description:
diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml
index 34ce781954b6..7ba4ccf723d8 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml
@@ -54,7 +54,7 @@ patternProperties:
           should be "buck1", ..., "buck6"
 
       rohm,dvs-run-voltage:
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 1300000
         description:
@@ -62,7 +62,7 @@ patternProperties:
           bucks which support this. 0 means disabled.
 
       rohm,dvs-idle-voltage:
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 1300000
         description:
@@ -70,7 +70,7 @@ patternProperties:
           bucks which support this. 0 means disabled.
 
       rohm,dvs-suspend-voltage:
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 1300000
         description:
diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd9576-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd9576-regulator.yaml
index 89b8592db81d..f573128da06f 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd9576-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd9576-regulator.yaml
@@ -25,7 +25,7 @@ patternProperties:
     type: object
     description:
       Properties for single regulator.
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
 
     properties:
       rohm,ocw-fet-ron-micro-ohms:
diff --git a/Documentation/devicetree/bindings/regulator/socionext,uniphier-regulator.yaml b/Documentation/devicetree/bindings/regulator/socionext,uniphier-regulator.yaml
index a6949a581cd1..ddaa112252e5 100644
--- a/Documentation/devicetree/bindings/regulator/socionext,uniphier-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/socionext,uniphier-regulator.yaml
@@ -42,7 +42,7 @@ properties:
   reset-names: true
 
 allOf:
-  - $ref: "regulator.yaml#"
+  - $ref: regulator.yaml#
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/regulator/st,stm32-booster.yaml b/Documentation/devicetree/bindings/regulator/st,stm32-booster.yaml
index c82f6f885d97..c863100f6e7d 100644
--- a/Documentation/devicetree/bindings/regulator/st,stm32-booster.yaml
+++ b/Documentation/devicetree/bindings/regulator/st,stm32-booster.yaml
@@ -14,7 +14,7 @@ description: |
   to supply ADC analog input switches.
 
 allOf:
-  - $ref: "regulator.yaml#"
+  - $ref: regulator.yaml#
 
 properties:
   compatible:
@@ -23,7 +23,7 @@ properties:
       - st,stm32mp1-booster
 
   st,syscfg:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+    $ref: /schemas/types.yaml#/definitions/phandle
     description: phandle to system configuration controller.
 
   vdda-supply:
diff --git a/Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.yaml b/Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.yaml
index c1bf1f90490a..05f4ad2c7d3a 100644
--- a/Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.yaml
+++ b/Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.yaml
@@ -15,7 +15,7 @@ maintainers:
   - Fabrice Gasnier <fabrice.gasnier@foss.st.com>
 
 allOf:
-  - $ref: "regulator.yaml#"
+  - $ref: regulator.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
index bd07b9c81570..7d53cfa2c288 100644
--- a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
+++ b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
@@ -26,7 +26,7 @@ patternProperties:
   "^(reg11|reg18|usb33)$":
     type: object
 
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/regulator/ti,tps62360.yaml b/Documentation/devicetree/bindings/regulator/ti,tps62360.yaml
index 12aeddedde05..90c39275c150 100644
--- a/Documentation/devicetree/bindings/regulator/ti,tps62360.yaml
+++ b/Documentation/devicetree/bindings/regulator/ti,tps62360.yaml
@@ -19,7 +19,7 @@ description: |
   https://www.ti.com/lit/gpn/tps62360
 
 allOf:
-  - $ref: "regulator.yaml#"
+  - $ref: regulator.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/regulator/vqmmc-ipq4019-regulator.yaml b/Documentation/devicetree/bindings/regulator/vqmmc-ipq4019-regulator.yaml
index dd7a2f92634c..3b16a25ba3b8 100644
--- a/Documentation/devicetree/bindings/regulator/vqmmc-ipq4019-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/vqmmc-ipq4019-regulator.yaml
@@ -15,7 +15,7 @@ description: |
   controller is also embedded.
 
 allOf:
-  - $ref: "regulator.yaml#"
+  - $ref: regulator.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/regulator/wlf,arizona.yaml b/Documentation/devicetree/bindings/regulator/wlf,arizona.yaml
index 7b4ae5d23351..011819c10988 100644
--- a/Documentation/devicetree/bindings/regulator/wlf,arizona.yaml
+++ b/Documentation/devicetree/bindings/regulator/wlf,arizona.yaml
@@ -21,19 +21,19 @@ properties:
   wlf,ldoena:
     description:
       GPIO specifier for the GPIO controlling LDOENA.
-    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    $ref: /schemas/types.yaml#/definitions/phandle-array
     maxItems: 1
 
   ldo1:
     description:
       Initial data for the LDO1 regulator.
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
     type: object
 
   micvdd:
     description:
       Initial data for the MICVDD regulator.
-    $ref: "regulator.yaml#"
+    $ref: regulator.yaml#
     type: object
 
 additionalProperties: true
-- 
2.39.2

