Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474B85B4581
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 11:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiIJJP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 05:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiIJJOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 05:14:52 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A3327DE9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:14:49 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i26so6679811lfp.11
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=IM79X6U3l09DXVV1jonLpBNAlRXnPcICCJsZ+yBX2/0=;
        b=C5eywpAkLUIH1SbXUEGKXO66O8IzESmj4DYgpUxR2eVuoaeipUflrHiT5Q/0HCnRjj
         sVdMb7JNzAMTzYeLucfNdDdgNyQAo2EK1pcRGP/gchjDSdqcOJGtyVq4eR6G94kVY+hV
         IwNK3Yu205Gaes0rQK0ft+fVeeRBmuFIal27ZM7OWbWHGf/sAewBq6P6cTBQWq7vi+4I
         lDV8RzeM1IZLPboIfdSgQgTPn9xj1eyNfBt6/uctl4PHaKdItJjnfXrIZQSOeTdQm9xF
         Po6MMRrvRuThYEs80HEeY4M3BwAgylhDb5YedDyjlr2e58bbsi+e+eAiX1TPpGa1sfrL
         OsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IM79X6U3l09DXVV1jonLpBNAlRXnPcICCJsZ+yBX2/0=;
        b=X3ZfZMGk+FVUy16L4PUhSKjokUULkSfr/4GxGADshOKR6hCkeYp+zODhY648ImuORd
         80Zu8qAy5LsKlXkinqfsPsKmFh2nL1v2VSkSsMDygFzNjKFiLr66u+ZN/gYsTAH4TR9j
         SuCou1P0wwqXD7Du4SzkpH80VDz9NOQZHqU1x8ooIFUphXnP4X2HzpDgVc9Lrx0myFTt
         FUeGgt+iabyh1JGqzZJE8juhfNpRbWRVznyBIZDOhuZAYe8YQeXMSYDyeDy63Z88jCFe
         2zxxVvXICQn4sZrHZnUZFlc/QqAfa+MiXqihOnmPU3+EwrA4w1EgqVNrmjVd/PwlNKIc
         nngg==
X-Gm-Message-State: ACgBeo08ohbkKTQYTW5WMKEhPHeNgVrpg/sQDZs4MeY7T1slmMGQGl7E
        daNdLbuD1sJWme13wMLnaXHvnw==
X-Google-Smtp-Source: AA6agR7KViF3KGwqmqRJL96rVukvW7cokLsEQMOyIzbT+67zb9kcG25SlslfekbFxMjuOn+t+Fxb8g==
X-Received: by 2002:ac2:5d26:0:b0:494:6d31:4c5b with SMTP id i6-20020ac25d26000000b004946d314c5bmr6007205lfb.358.1662801287773;
        Sat, 10 Sep 2022 02:14:47 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x22-20020a19e016000000b0048b26d4bb64sm201552lfg.40.2022.09.10.02.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 02:14:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 09/15] dt-bindings: soc: qcom: apr: correct service children
Date:   Sat, 10 Sep 2022 11:14:22 +0200
Message-Id: <20220910091428.50418-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220910091428.50418-1-krzysztof.kozlowski@linaro.org>
References: <20220910091428.50418-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The APR bindings were not describing properly children nodes for DAIs.
None of the DTSes use unit addresses for the children, so correct the
nodes and reference their schema: clock-controller, dais and routing.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v3:
1. Re-order patches, so the qcom,q6asm-dais.yaml is used later. Helps in
   bisectability.

Changes since v1:
1. Correct also sound/qcom,q6apm-dai.yaml (Rob)
---
 .../bindings/soc/qcom/qcom,apr.yaml           | 64 +++++++++++++++----
 .../bindings/sound/qcom,q6apm-dai.yaml        | 10 +--
 .../sound/qcom,q6dsp-lpass-clocks.yaml        | 16 ++---
 .../sound/qcom,q6dsp-lpass-ports.yaml         | 16 ++---
 4 files changed, 62 insertions(+), 44 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
index 028c5d105adb..ac508622dc04 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
@@ -97,6 +97,21 @@ patternProperties:
             3 = AMDB Service.
             4 = Voice processing manager.
 
+      clock-controller:
+        $ref: /schemas/sound/qcom,q6dsp-lpass-clocks.yaml#
+        description: Qualcomm DSP LPASS clock controller
+        unevaluatedProperties: false
+
+      dais:
+        # TODO: Waiting for Documentation/devicetree/bindings/sound/qcom,q6asm.txt
+        type: object
+        description: Qualcomm DSP audio ports
+
+      routing:
+        # TODO: Waiting for Documentation/devicetree/bindings/sound/qcom,q6adm.txt
+        type: object
+        description: Qualcomm DSP LPASS audio routing
+
       qcom,protection-domain:
         $ref: /schemas/types.yaml#/definitions/string-array
         description: protection domain service name and path for apr service
@@ -107,17 +122,44 @@ patternProperties:
           "tms/servreg", "msm/modem/wlan_pd".
           "tms/servreg", "msm/slpi/sensor_pd".
 
-      '#address-cells':
-        const: 1
-
-      '#size-cells':
-        const: 0
-
-    patternProperties:
-      "^.*@[0-9a-f]+$":
-        type: object
-        description:
-          Service based devices like clock controllers or digital audio interfaces.
+    allOf:
+      - if:
+          properties:
+            compatible:
+              enum:
+                - qcom,q6afe
+        then:
+          properties:
+            dais:
+              properties:
+                compatible:
+                  const: qcom,q6afe-dais
+
+      - if:
+          properties:
+            compatible:
+              enum:
+                - qcom,q6apm
+        then:
+          properties:
+            dais:
+              properties:
+                compatible:
+                  enum:
+                    - qcom,q6apm-dais
+                    - qcom,q6apm-lpass-dais
+
+      - if:
+          properties:
+            compatible:
+              enum:
+                - qcom,q6asm
+        then:
+          properties:
+            dais:
+              properties:
+                compatible:
+                  const: qcom,q6asm-dais
 
     additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml b/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
index 5d972784321d..844d72b30969 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
@@ -16,16 +16,12 @@ properties:
   compatible:
     const: qcom,q6apm-dais
 
-  reg:
-    maxItems: 1
-
   iommus:
     maxItems: 1
 
 required:
   - compatible
   - iommus
-  - reg
 
 additionalProperties: false
 
@@ -41,13 +37,9 @@ examples:
           compatible = "qcom,q6apm";
           reg = <1>;
 
-          #address-cells = <1>;
-          #size-cells = <0>;
-
-          apm-dai@1 {
+          dais {
             compatible = "qcom,q6apm-dais";
             iommus = <&apps_smmu 0x1801 0x0>;
-            reg = <1>;
           };
         };
     };
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml
index f83f00737a2f..604861d84ffa 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml
@@ -18,9 +18,6 @@ properties:
       - qcom,q6afe-clocks
       - qcom,q6prm-lpass-clocks
 
-  reg:
-    maxItems: 1
-
   '#clock-cells':
     const: 2
     description:
@@ -32,7 +29,6 @@ properties:
 
 required:
   - compatible
-  - reg
   - "#clock-cells"
 
 additionalProperties: false
@@ -46,11 +42,9 @@ examples:
         #size-cells = <0>;
         apr-service@4 {
             reg = <APR_SVC_AFE>;
-            #address-cells = <1>;
-            #size-cells = <0>;
-            clock-controller@2 {
+
+            clock-controller {
               compatible = "qcom,q6afe-clocks";
-              reg = <2>;
               #clock-cells = <2>;
             };
         };
@@ -66,11 +60,9 @@ examples:
         service@2 {
             reg = <GPR_PRM_MODULE_IID>;
             compatible = "qcom,q6prm";
-            #address-cells = <1>;
-            #size-cells = <0>;
-            clock-controller@2 {
+
+            clock-controller {
               compatible = "qcom,q6prm-lpass-clocks";
-              reg = <2>;
               #clock-cells = <2>;
             };
         };
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
index dc7fba7b92d5..5e666d9fb388 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
@@ -18,9 +18,6 @@ properties:
       - qcom,q6afe-dais
       - qcom,q6apm-lpass-dais
 
-  reg:
-    maxItems: 1
-
   '#sound-dai-cells':
     const: 1
 
@@ -145,7 +142,6 @@ patternProperties:
 
 required:
   - compatible
-  - reg
   - "#sound-dai-cells"
   - "#address-cells"
   - "#size-cells"
@@ -161,11 +157,9 @@ examples:
         #size-cells = <0>;
         apr-service@4 {
             reg = <APR_SVC_AFE>;
-            #address-cells = <1>;
-            #size-cells = <0>;
-            q6afedai@1 {
+
+            dais {
               compatible = "qcom,q6afe-dais";
-              reg = <1>;
               #address-cells = <1>;
               #size-cells = <0>;
               #sound-dai-cells = <1>;
@@ -187,11 +181,9 @@ examples:
         service@1 {
             compatible = "qcom,q6apm";
             reg = <GPR_APM_MODULE_IID>;
-            #address-cells = <1>;
-            #size-cells = <0>;
-            q6apmdai@1 {
+
+            dais {
               compatible = "qcom,q6apm-lpass-dais";
-              reg = <1>;
               #address-cells = <1>;
               #size-cells = <0>;
               #sound-dai-cells = <1>;
-- 
2.34.1

