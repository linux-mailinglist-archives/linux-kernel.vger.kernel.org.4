Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7E9656C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 15:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiL0OlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 09:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiL0OlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 09:41:10 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793FFBB1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:41:07 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bf43so19869752lfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3vcm1M+NcXvyFcZkFdiUGmAOLs8+rtdAtOeFBnbW7o=;
        b=cF+sQ3B0m6jccMI+7c4gucx1GVwqX0k3emWVIkTu348JPsLe3IZwEMaeaDZN4Oo54L
         H0gt7SL5DFlTSn7dx5I0gnp+mAxtrqV4+MZdBr9Ng03e56OxNySaJLJIP7nta/89jKh8
         JX3Zi3sKXzj2E9+H2dKln33DBBZ0x6EGs9fMP38QV4xIm41cCUMyxsoHfplju8X4m1Qc
         zOLSCmyiDI6L0iqYpkWSSF+yqhRDED/EESEu9LpMlC1YtVmBaSFuL1Nbq9+01dsXXsI7
         LOnLZ7GcoDK9Y45bDeT71Um+saTYUAEiOcWEjBbX/gXMY1Zq4EbUVZDIxtrw1wMzVAcs
         sYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3vcm1M+NcXvyFcZkFdiUGmAOLs8+rtdAtOeFBnbW7o=;
        b=PBKTEdd5LifKvz+K+NNMucEeNNzeeBzB/xujt0LJWG7a2nAQbOvaRnYb0UJbKcgloz
         KMFRTSGTpgxcAPwQO/sOn28c57rJ65DnlJIBzyxUZ6O6FCOArFTJ5/YXRDj5A/Xw1Yzm
         qxfJ6QJ5ThG63PWTEM9XZUkmpzuVw63mX1Nue5JQIDK4NvPQnyv4ib3bw7BfVnU4V93d
         ekX7vIBzwRU9F48IuRW0ab9qZJlJg9z84rYJwtuDB8vtYAglP+Kn3Vn3HmnF3xf43VL/
         nLpx6+wioNiSMYYKKzwMpSw6R3ej+a6mdzTAJgiOSJZLZaAeTE4EFsJ5M/xqhF2U26Kc
         SLTQ==
X-Gm-Message-State: AFqh2kqb5qXE3XfdVU3E/aBUOSnttATTTmGOChmBa9OPBytALxOEBfJ2
        /ToHNEgeJlnYOxhlQ+n0w91Jdg==
X-Google-Smtp-Source: AMrXdXu9KYzPEbEhTWJjizEMQzbaWLxFIiGUUIP6LhuXUeRSRg7HZjYNn6mwn/ykp11Z/bC4h3IuzA==
X-Received: by 2002:a05:6512:261a:b0:4ca:f432:3e45 with SMTP id bt26-20020a056512261a00b004caf4323e45mr5274462lfb.33.1672152065813;
        Tue, 27 Dec 2022 06:41:05 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s1-20020a056512214100b004b5853f0fc6sm2261126lfr.246.2022.12.27.06.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 06:41:05 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/8] media: dt-bindings: qcom,venus: split common properties
Date:   Tue, 27 Dec 2022 15:40:56 +0100
Message-Id: <20221227144102.79391-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221227144102.79391-1-krzysztof.kozlowski@linaro.org>
References: <20221227144102.79391-1-krzysztof.kozlowski@linaro.org>
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

All Qualcomm SoC Venus bindings share a lot of properties, so split
common part to re-usable schema to reduce the duplication and promote
unified style.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/media/qcom,msm8916-venus.yaml    | 35 ++--------
 .../bindings/media/qcom,msm8996-venus.yaml    | 35 ++--------
 .../bindings/media/qcom,sc7180-venus.yaml     | 32 ++-------
 .../bindings/media/qcom,sc7280-venus.yaml     | 35 ++--------
 .../bindings/media/qcom,sdm660-venus.yaml     | 35 ++--------
 .../bindings/media/qcom,sdm845-venus-v2.yaml  | 35 ++--------
 .../bindings/media/qcom,sdm845-venus.yaml     | 35 ++--------
 .../bindings/media/qcom,sm8250-venus.yaml     | 35 ++--------
 .../bindings/media/qcom,venus-common.yaml     | 70 +++++++++++++++++++
 9 files changed, 102 insertions(+), 245 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/qcom,venus-common.yaml

diff --git a/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml b/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml
index 5c639e4232b3..2350bf4b370e 100644
--- a/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml
@@ -13,16 +13,13 @@ description: |
   The Venus IP is a video encode and decode accelerator present
   on Qualcomm platforms
 
+allOf:
+  - $ref: qcom,venus-common.yaml#
+
 properties:
   compatible:
     const: qcom,msm8916-venus
 
-  reg:
-    maxItems: 1
-
-  interrupts:
-    maxItems: 1
-
   power-domains:
     maxItems: 1
 
@@ -38,9 +35,6 @@ properties:
   iommus:
     maxItems: 1
 
-  memory-region:
-    maxItems: 1
-
   video-decoder:
     type: object
 
@@ -65,34 +59,13 @@ properties:
 
     additionalProperties: false
 
-  video-firmware:
-    type: object
-    additionalProperties: false
-
-    description: |
-      Firmware subnode is needed when the platform does not
-      have TrustZone.
-
-    properties:
-      iommus:
-        maxItems: 1
-
-    required:
-      - iommus
-
 required:
   - compatible
-  - reg
-  - interrupts
-  - power-domains
-  - clocks
-  - clock-names
   - iommus
-  - memory-region
   - video-decoder
   - video-encoder
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/media/qcom,msm8996-venus.yaml b/Documentation/devicetree/bindings/media/qcom,msm8996-venus.yaml
index 9254bfb90f5d..4a68f924ad9e 100644
--- a/Documentation/devicetree/bindings/media/qcom,msm8996-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,msm8996-venus.yaml
@@ -13,16 +13,13 @@ description: |
   The Venus IP is a video encode and decode accelerator present
   on Qualcomm platforms
 
+allOf:
+  - $ref: qcom,venus-common.yaml#
+
 properties:
   compatible:
     const: qcom,msm8996-venus
 
-  reg:
-    maxItems: 1
-
-  interrupts:
-    maxItems: 1
-
   power-domains:
     maxItems: 1
 
@@ -39,9 +36,6 @@ properties:
   iommus:
     maxItems: 20
 
-  memory-region:
-    maxItems: 1
-
   video-decoder:
     type: object
 
@@ -92,34 +86,13 @@ properties:
 
     additionalProperties: false
 
-  video-firmware:
-    type: object
-    additionalProperties: false
-
-    description: |
-      Firmware subnode is needed when the platform does not
-      have TrustZone.
-
-    properties:
-      iommus:
-        maxItems: 1
-
-    required:
-      - iommus
-
 required:
   - compatible
-  - reg
-  - interrupts
-  - power-domains
-  - clocks
-  - clock-names
   - iommus
-  - memory-region
   - video-decoder
   - video-encoder
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
index 460e9048a034..acdb54d5c69e 100644
--- a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
@@ -13,16 +13,13 @@ description: |
   The Venus IP is a video encode and decode accelerator present
   on Qualcomm platforms
 
+allOf:
+  - $ref: qcom,venus-common.yaml#
+
 properties:
   compatible:
     const: qcom,sc7180-venus
 
-  reg:
-    maxItems: 1
-
-  interrupts:
-    maxItems: 1
-
   power-domains:
     minItems: 2
     maxItems: 3
@@ -83,35 +80,14 @@ properties:
 
     additionalProperties: false
 
-  video-firmware:
-    type: object
-    additionalProperties: false
-
-    description: |
-      Firmware subnode is needed when the platform does not
-      have TrustZone.
-
-    properties:
-      iommus:
-        maxItems: 1
-
-    required:
-      - iommus
-
 required:
   - compatible
-  - reg
-  - interrupts
-  - power-domains
   - power-domain-names
-  - clocks
-  - clock-names
   - iommus
-  - memory-region
   - video-decoder
   - video-encoder
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
index 0055bd2a3379..f14bf07e115b 100644
--- a/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
@@ -13,16 +13,13 @@ description: |
   The Venus Iris2 IP is a video encode and decode accelerator present
   on Qualcomm platforms
 
+allOf:
+  - $ref: qcom,venus-common.yaml#
+
 properties:
   compatible:
     const: qcom,sc7280-venus
 
-  reg:
-    maxItems: 1
-
-  interrupts:
-    maxItems: 1
-
   power-domains:
     minItems: 2
     maxItems: 3
@@ -48,9 +45,6 @@ properties:
   iommus:
     maxItems: 2
 
-  memory-region:
-    maxItems: 1
-
   interconnects:
     maxItems: 2
 
@@ -83,35 +77,14 @@ properties:
 
     additionalProperties: false
 
-  video-firmware:
-    type: object
-    additionalProperties: false
-
-    description: |
-      Firmware subnode is needed when the platform does not
-      have TrustZone.
-
-    properties:
-      iommus:
-        maxItems: 1
-
-    required:
-      - iommus
-
 required:
   - compatible
-  - reg
-  - interrupts
-  - power-domains
   - power-domain-names
-  - clocks
-  - clock-names
   - iommus
-  - memory-region
   - video-decoder
   - video-encoder
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/media/qcom,sdm660-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sdm660-venus.yaml
index 0ebe4341d41f..a51835b22045 100644
--- a/Documentation/devicetree/bindings/media/qcom,sdm660-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sdm660-venus.yaml
@@ -14,13 +14,13 @@ description: |
   The Venus IP is a video encode and decode accelerator present
   on Qualcomm platforms
 
+allOf:
+  - $ref: qcom,venus-common.yaml#
+
 properties:
   compatible:
     const: qcom,sdm660-venus
 
-  reg:
-    maxItems: 1
-
   clocks:
     maxItems: 4
 
@@ -39,15 +39,9 @@ properties:
       - const: cpu-cfg
       - const: video-mem
 
-  interrupts:
-    maxItems: 1
-
   iommus:
     maxItems: 20
 
-  memory-region:
-    maxItems: 1
-
   power-domains:
     maxItems: 1
 
@@ -101,34 +95,13 @@ properties:
 
     additionalProperties: false
 
-  video-firmware:
-    type: object
-    additionalProperties: false
-
-    description: |
-      Firmware subnode is needed when the platform does not
-      have TrustZone.
-
-    properties:
-      iommus:
-        maxItems: 1
-
-    required:
-      - iommus
-
 required:
   - compatible
-  - reg
-  - clocks
-  - clock-names
-  - interrupts
   - iommus
-  - memory-region
-  - power-domains
   - video-decoder
   - video-encoder
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml b/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
index 639837724d01..0840ad0f642b 100644
--- a/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
@@ -13,16 +13,13 @@ description: |
   The Venus IP is a video encode and decode accelerator present
   on Qualcomm platforms
 
+allOf:
+  - $ref: qcom,venus-common.yaml#
+
 properties:
   compatible:
     const: qcom,sdm845-venus-v2
 
-  reg:
-    maxItems: 1
-
-  interrupts:
-    maxItems: 1
-
   power-domains:
     minItems: 3
     maxItems: 4
@@ -51,9 +48,6 @@ properties:
   iommus:
     maxItems: 2
 
-  memory-region:
-    maxItems: 1
-
   video-core0:
     type: object
 
@@ -78,35 +72,14 @@ properties:
 
     additionalProperties: false
 
-  video-firmware:
-    type: object
-    additionalProperties: false
-
-    description: |
-      Firmware subnode is needed when the platform does not
-      have TrustZone.
-
-    properties:
-      iommus:
-        maxItems: 1
-
-    required:
-      - iommus
-
 required:
   - compatible
-  - reg
-  - interrupts
-  - power-domains
   - power-domain-names
-  - clocks
-  - clock-names
   - iommus
-  - memory-region
   - video-core0
   - video-core1
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/media/qcom,sdm845-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sdm845-venus.yaml
index 5f73eb76b02e..eabc0957b241 100644
--- a/Documentation/devicetree/bindings/media/qcom,sdm845-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sdm845-venus.yaml
@@ -13,16 +13,13 @@ description: |
   The Venus IP is a video encode and decode accelerator present
   on Qualcomm platforms
 
+allOf:
+  - $ref: qcom,venus-common.yaml#
+
 properties:
   compatible:
     const: qcom,sdm845-venus
 
-  reg:
-    maxItems: 1
-
-  interrupts:
-    maxItems: 1
-
   power-domains:
     maxItems: 1
 
@@ -38,9 +35,6 @@ properties:
   iommus:
     maxItems: 2
 
-  memory-region:
-    maxItems: 1
-
   video-core0:
     type: object
 
@@ -93,34 +87,13 @@ properties:
 
     additionalProperties: false
 
-  video-firmware:
-    type: object
-    additionalProperties: false
-
-    description: |
-      Firmware subnode is needed when the platform does not
-      have TrustZone.
-
-    properties:
-      iommus:
-        maxItems: 1
-
-    required:
-      - iommus
-
 required:
   - compatible
-  - reg
-  - interrupts
-  - power-domains
-  - clocks
-  - clock-names
   - iommus
-  - memory-region
   - video-core0
   - video-core1
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
index cc68b2a263d4..1cfeb136a5ca 100644
--- a/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
@@ -13,16 +13,13 @@ description: |
   The Venus IP is a video encode and decode accelerator present
   on Qualcomm platforms
 
+allOf:
+  - $ref: qcom,venus-common.yaml#
+
 properties:
   compatible:
     const: qcom,sm8250-venus
 
-  reg:
-    maxItems: 1
-
-  interrupts:
-    maxItems: 1
-
   power-domains:
     minItems: 2
     maxItems: 3
@@ -46,9 +43,6 @@ properties:
   iommus:
     maxItems: 1
 
-  memory-region:
-    maxItems: 1
-
   interconnects:
     maxItems: 2
 
@@ -89,39 +83,18 @@ properties:
 
     additionalProperties: false
 
-  video-firmware:
-    type: object
-    additionalProperties: false
-
-    description: |
-      Firmware subnode is needed when the platform does not
-      have TrustZone.
-
-    properties:
-      iommus:
-        maxItems: 1
-
-    required:
-      - iommus
-
 required:
   - compatible
-  - reg
-  - interrupts
-  - power-domains
   - power-domain-names
-  - clocks
-  - clock-names
   - interconnects
   - interconnect-names
   - iommus
-  - memory-region
   - resets
   - reset-names
   - video-decoder
   - video-encoder
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/media/qcom,venus-common.yaml b/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
new file mode 100644
index 000000000000..4a5c1d55c202
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/qcom,venus-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SoC Venus Video Encode and Decode Accelerators Common Properties
+
+maintainers:
+  - Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
+  - Vikash Garodia <quic_vgarodia@quicinc.com>
+
+description: |
+  The Venus IP is a video encode and decode accelerator present
+  on Qualcomm platforms
+
+properties:
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 3
+    maxItems: 7
+
+  clock-names:
+    minItems: 3
+    maxItems: 7
+
+  interrupts:
+    maxItems: 1
+
+  iommus:
+    minItems: 1
+    maxItems: 20
+
+  memory-region:
+    maxItems: 1
+
+  power-domains:
+    minItems: 1
+    maxItems: 4
+
+  power-domain-names:
+    minItems: 1
+    maxItems: 4
+
+  video-firmware:
+    type: object
+    additionalProperties: false
+
+    description: |
+      Firmware subnode is needed when the platform does not
+      have TrustZone.
+
+    properties:
+      iommus:
+        maxItems: 1
+
+    required:
+      - iommus
+
+required:
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - memory-region
+  - power-domains
+
+additionalProperties: true
-- 
2.34.1

