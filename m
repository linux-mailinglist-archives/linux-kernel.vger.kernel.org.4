Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981A3646199
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiLGTXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiLGTXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:23:36 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33B8663E7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 11:23:33 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q7so29528675wrr.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 11:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GUly8uO1OUcoSESV+o668Tkb+5x4qUzBcDjwS5bQlu4=;
        b=qIlMt8qo1eeKSh1mVdnpDD4P/cGqRQrED9Utsx1lcz4jajJ+h51LAdNxNpUc1Pgs5C
         SUzG1G7F29TUO3MPa1vprsFU65xh+L/6qpV37Ms0avq1bsA2J53M8c4NhnDuaeJugm78
         2vGnr4UVVTy1PXmU/4ATqb7PveHBvts+q2M/mxsJrnNosCOyqmvBtP57bZ6fuyc8k+dk
         vIhAgYB5kNVREdqDLjueOTQRBuKI9dO7YX3QN3RQ9xrk79em+XSJ0SM+0XG/BUMTWWhH
         UQkhbRh64Jnf6NgGot7kY1nnwpw/2+MDo0Pr6BnVuE8XapCaE+/9RLGm5aNmoQcuoqNP
         wJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUly8uO1OUcoSESV+o668Tkb+5x4qUzBcDjwS5bQlu4=;
        b=Ft+fxf653mHmerqJsyWBsHVqu9A58AnIe8Iw1COYgZAbwNN2DvNZKEpuf3AXX9Udiu
         VKTQaRZyz9Cboc4dntCtMrPxKrZI+hDitrwhFkLfVMOy+n7WuEfKf3D9yuvjp/l/VfNQ
         tUVXYANOcYM1nKFe5kZPmsUfM4d+/bd9dL68DrOQjiwan0gtMGaaepwfuN5RQvhN9fgO
         ftiQluJ3S6CYoERnaAXsPDZ2aLC3aIzYfkz9rnqMArwVv65NkpgvPHDOB/tqBqqumM3N
         LnWIDhrgDO9W8sj55kWp5mTcFfhKdQWgvERGp37HeVSIP6U8l7rfEzFFPlVwfH2Ik8QS
         xAkw==
X-Gm-Message-State: ANoB5pnXYPbssS+i4TD08yIKBHNUvxEkAeRbFD/SgidUc9NffPRNRGNR
        y/FM3vbos2NHtjtqthmCgFpwsA==
X-Google-Smtp-Source: AA0mqf578qz1XUgN6HFBVYwJAXNHPJ3BBOD/Wkd1Rvq4auQ4eWm7K69XG3NJMUYIVtLB9QZwVqgcoA==
X-Received: by 2002:adf:ded1:0:b0:242:673a:d9e0 with SMTP id i17-20020adfded1000000b00242673ad9e0mr8087914wrn.134.1670441012430;
        Wed, 07 Dec 2022 11:23:32 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id w1-20020a5d5441000000b002422b462975sm19400355wrv.34.2022.12.07.11.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 11:23:31 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 07 Dec 2022 20:23:23 +0100
Subject: [PATCH v3 1/5] dt-bindings: remoteproc: qcom: adsp: move memory-region and
 firmware-name out of pas-common
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-remoteproc-v3-1-62162a1df718@linaro.org>
References: <20221114-narmstrong-sm8550-upstream-remoteproc-v3-0-62162a1df718@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-remoteproc-v3-0-62162a1df718@linaro.org>
To:     Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-remoteproc@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move memory-region and firmware-name definitions out of qcom,pas-common.yaml
since they will be redefined differently for SM8550 PAS bindings documentation.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml       | 4 ++++
 Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml | 8 --------
 Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml | 8 ++++++++
 Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml | 8 ++++++++
 .../devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml          | 8 ++++++++
 .../devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml         | 8 ++++++++
 Documentation/devicetree/bindings/remoteproc/qcom,sdx55-pas.yaml  | 8 ++++++++
 Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml | 8 ++++++++
 Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml | 8 ++++++++
 Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml | 8 ++++++++
 10 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 9af2db72b337..5b55a22182ce 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -39,6 +39,10 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: Reference to the AOSS side-channel message RAM.
 
+  memory-region:
+    maxItems: 1
+    description: Reference to the reserved-memory for the Hexagon core
+
 required:
   - compatible
 
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
index 1d5e01c8d8bc..171ef85de193 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
@@ -52,14 +52,6 @@ properties:
     minItems: 1
     maxItems: 3
 
-  firmware-name:
-    $ref: /schemas/types.yaml#/definitions/string
-    description: Firmware name for the Hexagon core
-
-  memory-region:
-    maxItems: 1
-    description: Reference to the reserved-memory for the Hexagon core
-
   qcom,smem-states:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description: States used by the AP to signal the Hexagon core
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml
index 007349ef51ed..5efa0e5c0439 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml
@@ -41,6 +41,14 @@ properties:
   power-domain-names: false
   smd-edge: false
 
+  memory-region:
+    minItems: 1
+    description: Reference to the reserved-memory for the Hexagon core
+
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Firmware name for the Hexagon core
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
index 6fd768609a66..5cefd2c58593 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
@@ -50,12 +50,20 @@ properties:
       - const: mx
       - const: mss
 
+  memory-region:
+    minItems: 1
+    description: Reference to the reserved-memory for the Hexagon core
+
   qcom,qmp:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: Reference to the AOSS side-channel message RAM.
 
   smd-edge: false
 
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Firmware name for the Hexagon core
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml
index 3026cfde5582..c1f8dd8d0e4c 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml
@@ -37,6 +37,14 @@ properties:
 
   smd-edge: false
 
+  memory-region:
+    minItems: 1
+    description: Reference to the reserved-memory for the Hexagon core
+
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Firmware name for the Hexagon core
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml
index c08274aaa6f8..f6fbc531dc28 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml
@@ -37,6 +37,14 @@ properties:
 
   smd-edge: false
 
+  memory-region:
+    minItems: 1
+    description: Reference to the reserved-memory for the Hexagon core
+
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Firmware name for the Hexagon core
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sdx55-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sdx55-pas.yaml
index cbeaa00ca4d4..c66e298462c7 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sdx55-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sdx55-pas.yaml
@@ -45,12 +45,20 @@ properties:
       - const: cx
       - const: mss
 
+  memory-region:
+    minItems: 1
+    description: Reference to the reserved-memory for the Hexagon core
+
   qcom,qmp:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: Reference to the AOSS side-channel message RAM.
 
   smd-edge: false
 
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Firmware name for the Hexagon core
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml
index 911529400142..fee02fa800b5 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml
@@ -35,8 +35,16 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: Reference to the AOSS side-channel message RAM.
 
+  memory-region:
+    minItems: 1
+    description: Reference to the reserved-memory for the Hexagon core
+
   smd-edge: false
 
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Firmware name for the Hexagon core
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
index b934252cf02b..2c085ac2c3fb 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
@@ -39,8 +39,16 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: Reference to the AOSS side-channel message RAM.
 
+  memory-region:
+    minItems: 1
+    description: Reference to the reserved-memory for the Hexagon core
+
   smd-edge: false
 
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Firmware name for the Hexagon core
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
index 853f97d6879f..af24f9a3cdf1 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
@@ -42,6 +42,14 @@ properties:
 
   smd-edge: false
 
+  memory-region:
+    minItems: 1
+    description: Reference to the reserved-memory for the Hexagon core
+
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Firmware name for the Hexagon core
+
 required:
   - compatible
   - reg

-- 
b4 0.10.1
