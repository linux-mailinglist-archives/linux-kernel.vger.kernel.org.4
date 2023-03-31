Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEAC6D1BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjCaJVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjCaJVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:21:38 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3673F1738
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:21:35 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s20so2050337ljp.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680254493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9VhVRS/5dxN4m8eKpWEVuk9vUu8h4ihVl/JzGPAbAAs=;
        b=NBlj2KLvnBb9AqobDDp434EAEE6xLO7381npQBQNFH2D9Laoz8+nIqOsxevbUNwD6U
         +0R3fdqjEAmwu/ypmi0W23HPZpM0qAkDYnpb9FChZ7mPMnuqkAqQTphJDdo2afmoUVcM
         0VQq9XisOMxX5fP+8sVxaJkq6tRoCk+u3xtbdZH3az/EbAqypXu0WZQmU7IiDvFLzYgw
         4ysHZYt9RLXQ0M1BauVYZmO0dys44inrkRtaqyM5LQWvm4EkNsWzr17Q6gT3OKfbtmj9
         xUhwn416tpJMAaGu5McS1CyBg+iyOxJKiNoUakprMlMCvPpu5XnHHZr/zSLZrxkH7cpG
         BPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680254493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VhVRS/5dxN4m8eKpWEVuk9vUu8h4ihVl/JzGPAbAAs=;
        b=L00dKJYVy7fiRGt0Xav1a29lcgsv0yVygV1nBiQwh0mpM5eK2uLSImICjZafG9l91p
         0WKVveCnAEz5KjfU9Q9SAVHhWFF4hgGQI9wSnok9nkcypcaDnBd3X5ecWLu1SD8IU1g2
         EnLrP21CVaxzVNDqRIkIKPmjcIE67KZprZHQ5okxISmae4WX7MO7Vj7prXLWxJht7k3w
         d7ZjaaaKXtDStNZ7Nh2qdhrLaAXeVDt3gB9CVw/bs3/spdBCm5k2f31VCI9SHlIcouHk
         Rx10jF5m1JoJtR33QEnpCQPykFgETEIWzMHv+ZdJPjP3CYs7T0aMiHCTPj194+0a3I6L
         QrNw==
X-Gm-Message-State: AAQBX9cZjGd2z5fEZ5K0W1s8h0Q7TUdfVfgoyGv+fM+TK7nhdncMezCn
        KjhPHVNxiV/Q/cSfC40H6YAaEw==
X-Google-Smtp-Source: AKy350beIrX1AdmmYYjbkG6DASBQNS658WjIYaSzAaK3SNaJgM+c4xfw6k2T1YljpJRXICRK/a6xWA==
X-Received: by 2002:a2e:90c8:0:b0:298:a82f:1770 with SMTP id o8-20020a2e90c8000000b00298a82f1770mr8481686ljg.5.1680254493456;
        Fri, 31 Mar 2023 02:21:33 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a13-20020a2e88cd000000b0029bd1e3f9easm282629ljk.32.2023.03.31.02.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 02:21:33 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH 1/3] dt-bindings: remoteproc: qcom,pas: correct memory-region constraints
Date:   Fri, 31 Mar 2023 11:21:23 +0200
Message-Id: <20230331092125.44885-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Reviewed-by: Rob Herring <robh@kernel.org>

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
index 643ee787a81f..b571efe6d550 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -46,6 +46,7 @@ properties:
 
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

