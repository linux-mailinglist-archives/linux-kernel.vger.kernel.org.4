Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033946B1E07
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCII1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjCII0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:26:54 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C6AE20F8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:24:52 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id k10so3678934edk.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 00:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678350291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nL9/TykSc18L23eiaPWvgWLTS2LdKi4LLDhXCWkq3ec=;
        b=ErQvoImE2RaH2Wg4rFSVMBuQ1SpAgZTY7oYNpzjDuaNbfkGTxI0jUTNDVQBkPRfkas
         fo6/QPZk+ngNfUEKatCrAYYcEgK8rQU3eFmZ2ZW6P3J1B6+LgcJYUKyNiTBidusCs3+i
         2Gxv+/OFyJMVjXTIcRMt+UJ1E+HGLdJuXxbrclCajwB3r6HgvcnoJbwr+DGUzFPdJFfj
         DBU8ZxRbuS46OIymqBDlbtis4EH+aS4Gf93yr5eUSSSYc4Pysta7KDr+2KZTiY1OxlZN
         GJSDofCPHA7ULLpS42/L83Xt4EXGTyUpXyIYlpehcd68JKm4xjkzqJ/AStVW1Eq7OKZY
         xPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678350291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nL9/TykSc18L23eiaPWvgWLTS2LdKi4LLDhXCWkq3ec=;
        b=B7R6liLxP+omMNH5u30nRwGbvdTjgj0s7Eh9hrbkDputa3siDuEzKoP8iVz/sXIvSv
         SdHOr0R97oNPmE2VxB55E0bGZCAZBLwIXiSRoB/c4ifqQk6FfeOcyRUtSUnT/E37wpFi
         ImkRv2xMkroPnCzFaheE+ah1d3fOk9Kac0Fq873c7a2RxFMCoE97uncAWLNGtQNo4yTP
         RmYhEAgbzK6XHYuXr/ooCQNbuqb+HsPCSjEgsM31kBOAUo5cifu15FI0k1BBCEKLoiPZ
         ZYP3gJw9B5h0XltvniEWlNbiEvZ0EdUiQwxsSHsTvxinVggb5fhN+Z74GrsPmmCc50MA
         jc2w==
X-Gm-Message-State: AO0yUKX2eyf15hhgWlDSQ+ABEoxpXR2oA+Yj9ySKardz06on7bccQsoJ
        hOItv1NrpntjND/Xytkrl/LEXQ==
X-Google-Smtp-Source: AK7set9Pxlfg0WbyyCqmv5evnq9+rDOLYCfyemuhusbSo4yqYEPm2tzrcznP6017QpTPKzIIOIsGfQ==
X-Received: by 2002:a17:907:7244:b0:8b1:78b6:bbd7 with SMTP id ds4-20020a170907724400b008b178b6bbd7mr26301630ejc.10.1678350291210;
        Thu, 09 Mar 2023 00:24:51 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id k7-20020a170906578700b008b904cb2bcdsm8662276ejq.11.2023.03.09.00.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 00:24:50 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] dt-bindings: remoteproc: qcom,pas: correct memory-region constraints
Date:   Thu,  9 Mar 2023 09:24:44 +0100
Message-Id: <20230309082446.37362-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Qualcomm PAS devices expect exactly one memory region, not many.  Also,
the memory-region is now defined in device specific binding, not in
qcom,pas-common.yaml, thus also require it in the same place.

Fixes: cee616c68846 ("dt-bindings: remoteproc: qcom: adsp: move memory-region and firmware-name out of pas-common")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Following dtbs_check errors are expected (not related):
 - qcom,halt-regs:0: [142] is too short
 - clocks: [[24, 222], [24, 223], [24, 157], [16], [24, 229], [24, 224], [24, 225], [27, 2], [27, 8]] is too short
 - 'px-supply' is a required property
---
 Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml    | 1 +
 .../devicetree/bindings/remoteproc/qcom,pas-common.yaml        | 1 -
 .../devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml        | 3 ++-
 .../devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml        | 3 ++-
 .../devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml       | 3 ++-
 .../devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml      | 3 ++-
 .../devicetree/bindings/remoteproc/qcom,sdx55-pas.yaml         | 3 ++-
 .../devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml        | 3 ++-
 .../devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml        | 3 ++-
 .../devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml        | 3 ++-
 10 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 828dfebaef6a..69ba955432bf 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -50,6 +50,7 @@ properties:
 
 required:
   - compatible
+  - memory-region
 
 unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
index 171ef85de193..63a82e7a8bf8 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
@@ -82,7 +82,6 @@ required:
   - clock-names
   - interrupts
   - interrupt-names
-  - memory-region
   - qcom,smem-states
   - qcom,smem-state-names
 
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml
index 5efa0e5c0439..eb868a7ff4cd 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml
@@ -42,7 +42,7 @@ properties:
   smd-edge: false
 
   memory-region:
-    minItems: 1
+    maxItems: 1
     description: Reference to the reserved-memory for the Hexagon core
 
   firmware-name:
@@ -52,6 +52,7 @@ properties:
 required:
   - compatible
   - reg
+  - memory-region
 
 allOf:
   - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
index 5cefd2c58593..689d5d535331 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
@@ -51,7 +51,7 @@ properties:
       - const: mss
 
   memory-region:
-    minItems: 1
+    maxItems: 1
     description: Reference to the reserved-memory for the Hexagon core
 
   qcom,qmp:
@@ -67,6 +67,7 @@ properties:
 required:
   - compatible
   - reg
+  - memory-region
 
 allOf:
   - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml
index c1f8dd8d0e4c..4744a37b2b5d 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml
@@ -38,7 +38,7 @@ properties:
   smd-edge: false
 
   memory-region:
-    minItems: 1
+    maxItems: 1
     description: Reference to the reserved-memory for the Hexagon core
 
   firmware-name:
@@ -48,6 +48,7 @@ properties:
 required:
   - compatible
   - reg
+  - memory-region
 
 allOf:
   - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml
index f6fbc531dc28..96d53baf6e00 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml
@@ -38,7 +38,7 @@ properties:
   smd-edge: false
 
   memory-region:
-    minItems: 1
+    maxItems: 1
     description: Reference to the reserved-memory for the Hexagon core
 
   firmware-name:
@@ -48,6 +48,7 @@ properties:
 required:
   - compatible
   - reg
+  - memory-region
 
 allOf:
   - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sdx55-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sdx55-pas.yaml
index c66e298462c7..5d463272165f 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sdx55-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sdx55-pas.yaml
@@ -46,7 +46,7 @@ properties:
       - const: mss
 
   memory-region:
-    minItems: 1
+    maxItems: 1
     description: Reference to the reserved-memory for the Hexagon core
 
   qcom,qmp:
@@ -62,6 +62,7 @@ properties:
 required:
   - compatible
   - reg
+  - memory-region
 
 allOf:
   - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml
index fee02fa800b5..f7e40fb166da 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml
@@ -36,7 +36,7 @@ properties:
     description: Reference to the AOSS side-channel message RAM.
 
   memory-region:
-    minItems: 1
+    maxItems: 1
     description: Reference to the reserved-memory for the Hexagon core
 
   smd-edge: false
@@ -48,6 +48,7 @@ properties:
 required:
   - compatible
   - reg
+  - memory-region
 
 allOf:
   - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
index 2c085ac2c3fb..238c6e5e67c5 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
@@ -40,7 +40,7 @@ properties:
     description: Reference to the AOSS side-channel message RAM.
 
   memory-region:
-    minItems: 1
+    maxItems: 1
     description: Reference to the reserved-memory for the Hexagon core
 
   smd-edge: false
@@ -52,6 +52,7 @@ properties:
 required:
   - compatible
   - reg
+  - memory-region
 
 allOf:
   - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
index af24f9a3cdf1..4394dfd2d8e6 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
@@ -43,7 +43,7 @@ properties:
   smd-edge: false
 
   memory-region:
-    minItems: 1
+    maxItems: 1
     description: Reference to the reserved-memory for the Hexagon core
 
   firmware-name:
@@ -53,6 +53,7 @@ properties:
 required:
   - compatible
   - reg
+  - memory-region
 
 allOf:
   - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
-- 
2.34.1

