Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C7D5B458B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 11:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiIJJPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 05:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiIJJPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 05:15:04 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D91628E2C
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:14:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id o2so4547516lfc.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=mUmppME7zaLO9Gm03potROZ5imNm8303jvDKrM7wFXw=;
        b=VpzzwR2FyuPMAh6rLDWLYBcHRF5yVL5TxPR0yNX5Uzx2ueU4Puxldwb0cotvNA574D
         y+s96KYptf+kQx8tKai4bK86dCupISuhDfPMN0G/RbAxy9wtqJOdPKEBFGhl9TYxJv07
         DNnxj9WpiyowGaf4mTJWP+zElb3vQxwBtPJO7GdNFdeIpkCpO3f55RV+iq6MZu68pR2D
         3MjWIkOvFcsvZkoyEx0kU5lBBvRGHKCc4YdI1Li3mtfuFV5VpT3NjL3l8E0jAeSGt/uo
         gOJJwDvmCb7bsdwcwhQBUdByuOESf4Wh7NQY044NdbCtQwNmMCeTyZx1aJ3z6aB3uVnC
         uW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mUmppME7zaLO9Gm03potROZ5imNm8303jvDKrM7wFXw=;
        b=CyJREcv8sltv3FtHUqRWrN6miH3zKg99rBeXeP7sXTU4rG/BS1T7Y+aXthGAm6P84D
         05ynQJSry+FXWIQPk7lbTlNVqPx53TP2BdnvP/5RvgnuOCtk4zu5bMbKMgQm4egOrs2C
         KG2+jpGXrOVL5CvwQhQrXCb7nU7VHh6myQVH2I3Abn0n9vGN4WANi6b1YGDPR2Nlt8hc
         QWQIx0mhAz/s1pUKBZrzlObw+TguDGJGAcg9pT4beVuBz08+xx+MiPO1RlBA9H6S90Sq
         dksS1KkvYvQAGp/RXmk8wJz1qVIkQ3Y6Hf7Mm9uk/sjI+owaEdT+QCe50d0IGGGsr2vE
         o3rw==
X-Gm-Message-State: ACgBeo0tINijdjmfD+PEwCoJGPxkm0M4rUnB+KOpxELONiR7dEZ+V0PN
        9HYZrAcd+Iv2kfqxFBW37U1pavkVMWLGow==
X-Google-Smtp-Source: AA6agR6DfeZZgjI4BrsQk7LgRZnNDJeVAZ22fLaPcjtXgmFYQkP+bN5LCy9I/Gbd7OSSVy6qcG2Skg==
X-Received: by 2002:a05:6512:3501:b0:496:d15:e614 with SMTP id h1-20020a056512350100b004960d15e614mr6158497lfs.194.1662801289123;
        Sat, 10 Sep 2022 02:14:49 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x22-20020a19e016000000b0048b26d4bb64sm201552lfg.40.2022.09.10.02.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 02:14:48 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 10/15] ASoC: dt-bindings: qcom,q6asm: convert to dtschema
Date:   Sat, 10 Sep 2022 11:14:23 +0200
Message-Id: <20220910091428.50418-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220910091428.50418-1-krzysztof.kozlowski@linaro.org>
References: <20220910091428.50418-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Qualcomm Audio Stream Manager (Q6ASM) bindings to DT schema.

The original bindings documented:
1. APR service node with compatibles: "qcom,q6asm" and
   "qcom,q6asm-v<MAJOR-NUMBER>.<MINOR-NUMBER>",
2. actual DAIs child node with compatible "qcom,q6asm-dais".

The conversion entirely drops (1) because the compatible is already
documented in bindings/soc/qcom/qcom,apr.yaml.  The
"qcom,q6asm-v<MAJOR-NUMBER>.<MINOR-NUMBER>" on the other hand is not
used at all - neither in existing DTS, nor in downstream sources - so
versions seems to be fully auto-detectable.

Another change done in conversion is adding "iommus" property, which is
already used in DTS and Linux driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v3:
1. Re-order patches, so the change to apr.yaml happens here and we can
   avoid early `make dt_binding_check` warning.

Changes since v2:
1. Rename to qcom,q6asm-dais.yaml (Rob)
2. Extend commit msg.

Changes since v1:
1. New patch.
---
 .../bindings/soc/qcom/qcom,apr.yaml           |   6 +-
 .../bindings/sound/qcom,q6asm-dais.yaml       | 112 ++++++++++++++++++
 .../devicetree/bindings/sound/qcom,q6asm.txt  |  70 -----------
 3 files changed, 117 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.txt

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
index ac508622dc04..a1a8f77beef7 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
@@ -103,8 +103,12 @@ patternProperties:
         unevaluatedProperties: false
 
       dais:
-        # TODO: Waiting for Documentation/devicetree/bindings/sound/qcom,q6asm.txt
         type: object
+        oneOf:
+          - $ref: /schemas/sound/qcom,q6apm-dai.yaml#
+          - $ref: /schemas/sound/qcom,q6dsp-lpass-ports.yaml#
+          - $ref: /schemas/sound/qcom,q6asm-dais.yaml#
+        unevaluatedProperties: false
         description: Qualcomm DSP audio ports
 
       routing:
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml b/Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml
new file mode 100644
index 000000000000..8deb8ffb143b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,q6asm-dais.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Audio Stream Manager (Q6ASM)
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description:
+  Q6ASM is one of the APR audio services on Q6DSP. Each of its subnodes
+  represent a dai with board specific configuration.
+
+properties:
+  compatible:
+    enum:
+      - qcom,q6asm-dais
+
+  iommus:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^dai@[0-9]+$":
+    type: object
+    description:
+      Q6ASM Digital Audio Interface
+
+    properties:
+      reg:
+        maxItems: 1
+
+      direction:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2]
+        description: |
+          The direction of the dai stream::
+           - Q6ASM_DAI_TX_RX (0) for both tx and rx
+           - Q6ASM_DAI_TX (1) for only tx (Capture/Encode)
+           - Q6ASM_DAI_RX (2) for only rx (Playback/Decode)
+
+      is-compress-dai:
+        type: boolean
+        description:
+          Compress offload dai.
+
+    dependencies:
+      is-compress-dai: ["direction"]
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - "#sound-dai-cells"
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/qcom,apr.h>
+    #include <dt-bindings/sound/qcom,q6asm.h>
+
+    apr {
+        compatible = "qcom,apr-v2";
+        qcom,domain = <APR_DOMAIN_ADSP>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        service@7 {
+            compatible = "qcom,q6asm";
+            reg = <APR_SVC_ASM>;
+            qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+
+            dais {
+                compatible = "qcom,q6asm-dais";
+                iommus = <&apps_smmu 0x1821 0x0>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+                #sound-dai-cells = <1>;
+
+                dai@0 {
+                    reg = <0>;
+                };
+
+                dai@1 {
+                    reg = <1>;
+                };
+
+                dai@2 {
+                    reg = <2>;
+                    is-compress-dai;
+                    direction = <1>;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
deleted file mode 100644
index 0d0075125243..000000000000
--- a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
+++ /dev/null
@@ -1,70 +0,0 @@
-Qualcomm Audio Stream Manager (Q6ASM) binding
-
-Q6ASM is one of the APR audio service on Q6DSP.
-Please refer to qcom,apr.txt for details of the common apr service bindings
-used by the apr service device.
-
-- but must contain the following property:
-
-- compatible:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "qcom,q6asm-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
-		    Or "qcom,q6asm" where the version number can be queried
-		    from DSP.
-		    example "qcom,q6asm-v2.0"
-
-= ASM DAIs (Digital Audio Interface)
-"dais" subnode of the ASM node represents dai specific configuration
-
-- compatible:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "qcom,q6asm-dais".
-
-- #sound-dai-cells
-	Usage: required
-	Value type: <u32>
-	Definition: Must be 1
-
-== ASM DAI is subnode of "dais" and represent a dai, it includes board specific
-configuration of each dai. Must contain the following properties.
-
-- reg
-	Usage: required
-	Value type: <u32>
-	Definition: Must be dai id
-
-- direction:
-	Usage: Required for Compress offload dais
-	Value type: <u32>
-	Definition: Specifies the direction of the dai stream
-			Q6ASM_DAI_TX_RX (0) for both tx and rx
-			Q6ASM_DAI_TX (1) for only tx (Capture/Encode)
-			Q6ASM_DAI_RX (2) for only rx (Playback/Decode)
-
-- is-compress-dai:
-	Usage: Required for Compress offload dais
-	Value type: <boolean>
-	Definition: present for Compress offload dais
-
-
-= EXAMPLE
-#include <dt-bindings/sound/qcom,q6asm.h>
-
-apr-service@7 {
-	compatible = "qcom,q6asm";
-	reg = <APR_SVC_ASM>;
-	q6asmdai: dais {
-		compatible = "qcom,q6asm-dais";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		#sound-dai-cells = <1>;
-
-		dai@0 {
-			reg = <0>;
-			direction = <Q6ASM_DAI_RX>;
-			is-compress-dai;
-		};
-	};
-};
-- 
2.34.1

