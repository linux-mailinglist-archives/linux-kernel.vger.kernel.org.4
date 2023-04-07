Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDD56DA8C4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 08:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjDGGLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 02:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbjDGGLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 02:11:40 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0488F10A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 23:11:39 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-23cfbaef575so38631a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 23:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680847898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsyeQXy2xW6CfVtCD6z7F80PD3154E+msxA/B8ME+4s=;
        b=TxaHigEq/powxt8G0YFWCXnhy0gHw5R4nSEaBXCc2cQZqagDXWat0bd9Zh3uLL7zSO
         QsY7o+RvJ+WTiTAaFzURH7O76/opFYBjzsmtbkZWv5EpsTrPqSbMmbRDhXYYhh06vX0A
         d7sRTztRarC/f662JZc5E+dGQDLwX0mpFZrbzbzoq+c2vEh9VrKvlaC5msEMnBqyszgY
         wZDb8CDlOp5ExQugSSSK63+TJr61lWfanxcJsAm3kv9mny+/IrgN9SODSovp/8N3nyYB
         1n0oAe3EOrNQhpQCEyojkNCKRUcJZ2obdHmQcbM+JNvobXmcGZRmHx6dKBAzFg+FD/Zi
         M2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680847898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsyeQXy2xW6CfVtCD6z7F80PD3154E+msxA/B8ME+4s=;
        b=7uhIWOj+HJMJ/lHjH1pyN2D9vPxE0XGa9vatLIiobhvRMzrqIe1PyxxQ65nFLxmn00
         v1G++tOU3JP1MtbWmTuQE1lhjp7Qs6J4FlmoNvqQ/D1LPia8SU8j5geF1ZlN6bK8ujxQ
         odUYsog/EMVywsPXd/2C15J6jAQcpwNDptmZeYMNRog9d1KvMZRZ5h/Bg4gvC/DeYCpM
         sE1jgW9T5x0tSEOIlK11p7iSvfEdfnvwejGQ8Xy+AfALx1a2aIBjtI/xUjG1j0SSqT8V
         hQX2dTmuorCmJ63bGgjJ4EtBR+mZohU2NUB6+KmKMJqT9sb7zF3qaN+LA1yeUoUfEAYA
         ueWw==
X-Gm-Message-State: AAQBX9fTOL0DZXQOWAMjYbKOukvihNp6EMuGafeBOnUSvZWmZPFK4JBu
        nkLbCjj8PurR+O6JHA6s1qdpvTLGRIbWCPZTLIM=
X-Google-Smtp-Source: AKy350aR5pK8ttJepHEzseIhmBm6LXUUcc0dnTi5V1bRjzde3iRWNT3mv/x+VCZxMYrai5Vr70S1og==
X-Received: by 2002:a62:52d0:0:b0:62e:43ce:e6ab with SMTP id g199-20020a6252d0000000b0062e43cee6abmr1346096pfb.13.1680847898470;
        Thu, 06 Apr 2023 23:11:38 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:6a11:8ba1:beba:def7:a4ae])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78399000000b0062d7e9bb17asm2253879pfm.81.2023.04.06.23.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 23:11:38 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org, kishon@kernel.org,
        vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v6 1/2] dt-bindings: phy: qcom,qmp-usb: Drop legacy bindings and move to newer one (SM6115 & QCM2290)
Date:   Fri,  7 Apr 2023 11:41:21 +0530
Message-Id: <20230407061122.2036838-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230407061122.2036838-1-bhupesh.sharma@linaro.org>
References: <20230407061122.2036838-1-bhupesh.sharma@linaro.org>
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

'qcom,msm8996-qmp-usb3-phy.yaml' defines bindings for several PHYs
which predate USB -> USB+DP migration. Since SM6115 and QCM2290
nodes for USB QMP phy are being added to dtsi files by followup patches,
move these bindings instead to the newer style
'qcom,sc8280xp-qmp-usb3-uni-phy.yaml' file.

Since no device trees use these bindings presently, so we have no ABI breakages
with this patch.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../phy/qcom,msm8996-qmp-usb3-phy.yaml        |  27 -----
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   | 109 +++++++++++++++++-
 2 files changed, 104 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
index e81a38281f8c..4c96dab5b9e3 100644
--- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
@@ -23,14 +23,12 @@ properties:
       - qcom,ipq8074-qmp-usb3-phy
       - qcom,msm8996-qmp-usb3-phy
       - qcom,msm8998-qmp-usb3-phy
-      - qcom,qcm2290-qmp-usb3-phy
       - qcom,sc7180-qmp-usb3-phy
       - qcom,sc8180x-qmp-usb3-phy
       - qcom,sdm845-qmp-usb3-phy
       - qcom,sdm845-qmp-usb3-uni-phy
       - qcom,sdx55-qmp-usb3-uni-phy
       - qcom,sdx65-qmp-usb3-uni-phy
-      - qcom,sm6115-qmp-usb3-phy
       - qcom,sm8150-qmp-usb3-phy
       - qcom,sm8150-qmp-usb3-uni-phy
       - qcom,sm8250-qmp-usb3-phy
@@ -248,29 +246,6 @@ allOf:
             - const: phy
             - const: common
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,qcm2290-qmp-usb3-phy
-              - qcom,sm6115-qmp-usb3-phy
-    then:
-      properties:
-        clocks:
-          maxItems: 3
-        clock-names:
-          items:
-            - const: cfg_ahb
-            - const: ref
-            - const: com_aux
-        resets:
-          maxItems: 2
-        reset-names:
-          items:
-            - const: phy_phy
-            - const: phy
-
   - if:
       properties:
         compatible:
@@ -318,12 +293,10 @@ allOf:
             enum:
               - qcom,ipq6018-qmp-usb3-phy
               - qcom,ipq8074-qmp-usb3-phy
-              - qcom,qcm2290-qmp-usb3-phy
               - qcom,sc7180-qmp-usb3-phy
               - qcom,sc8180x-qmp-usb3-phy
               - qcom,sdx55-qmp-usb3-uni-phy
               - qcom,sdx65-qmp-usb3-uni-phy
-              - qcom,sm6115-qmp-usb3-phy
               - qcom,sm8150-qmp-usb3-uni-phy
               - qcom,sm8250-qmp-usb3-phy
     then:
diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
index 16fce1038285..ae207ce5f0c0 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
@@ -16,20 +16,28 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,qcm2290-qmp-usb3-phy
       - qcom,sc8280xp-qmp-usb3-uni-phy
+      - qcom,sm6115-qmp-usb3-phy
 
   reg:
     maxItems: 1
 
+  "#address-cells":
+    enum: [ 1, 2 ]
+
+  "#size-cells":
+    enum: [ 1, 2 ]
+
+  ranges: true
+
   clocks:
+    minItems: 3
     maxItems: 4
 
   clock-names:
-    items:
-      - const: aux
-      - const: ref
-      - const: com_aux
-      - const: pipe
+    minItems: 3
+    maxItems: 4
 
   power-domains:
     maxItems: 1
@@ -55,6 +63,42 @@ properties:
   "#phy-cells":
     const: 0
 
+patternProperties:
+  "^phy@[0-9a-f]+$":
+    type: object
+    description: single PHY-provider child node
+    properties:
+      reg:
+        minItems: 3
+        maxItems: 6
+
+      clocks:
+        items:
+          - description: PIPE clock
+
+      clock-names:
+        deprecated: true
+        items:
+          - const: pipe0
+
+      "#clock-cells":
+        const: 0
+
+      clock-output-names:
+        maxItems: 1
+
+      "#phy-cells":
+        const: 0
+
+    required:
+      - reg
+      - clocks
+      - "#clock-cells"
+      - clock-output-names
+      - "#phy-cells"
+
+    additionalProperties: false
+
 required:
   - compatible
   - reg
@@ -71,6 +115,61 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qcm2290-qmp-usb3-phy
+              - qcom,sm6115-qmp-usb3-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: cfg_ahb
+            - const: ref
+            - const: com_aux
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8280xp-qmp-usb3-uni-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          items:
+            - const: aux
+            - const: ref
+            - const: com_aux
+            - const: pipe
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qcm2290-qmp-usb3-phy
+              - qcom,sm6115-qmp-usb3-phy
+    then:
+      patternProperties:
+        "^phy@[0-9a-f]+$":
+          properties:
+            reg:
+              items:
+                - description: TX lane 1
+                - description: RX lane 1
+                - description: PCS
+                - description: TX lane 2
+                - description: RX lane 2
+                - description: PCS_MISC
+
 examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
-- 
2.38.1

