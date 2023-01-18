Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E04C67249E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjARRQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjARRQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:16:32 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A694A582B8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:16:31 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j17so6699239wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7zV/lGXR4VdaEDQ4Nx12c6m631b/jAQVVbMn5yqLiQ=;
        b=dLsS8qtz350AVKCTdJBB3SPFogxL/9PcLvhFxBeRIOqWHlZtdQd0eNdkxzTp1n2u3n
         s2g4VvcaAlbkeqcp04CC2rxtczZCxYNaY0pJq5bssFTHwhZj/JusPAqsA3dz6qmyZkFX
         KzJjKhSUHA+mFtTSQa4TMhsAAPJ6J8IMr2iIpHsqBcZXevYGfA1z0venCacPb4hWNfzX
         8z8rSEAmQ+Taig7B57lznwfnjSGNyB3XrV22IM5KPq5TikyMqjB0zpIX5wplEvc7fxjc
         pP17hncZ/3n7tLZwFmx3TbzEJ1gsIxtNoajRNBWJwLBonp44Of1XOM8pouEJT9HVfI/c
         /Tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7zV/lGXR4VdaEDQ4Nx12c6m631b/jAQVVbMn5yqLiQ=;
        b=Xrbqo+tQOs3jF8JpGcadMyniV+xXccW6vFsaTFXQzBJzxLPO9c9BHFZ0Usu2mt5eVK
         ORBE8ccy7CYhUooYNlLyck5+Yapksztt4rdSK7zJeBWeGx1YCxwXwtqa7QMrazD9bN+P
         vJ2qN9+Z0YbEq1Q6mNmj4M1RjA0GVJfkrAjPUsbmw0p2Gg979EgQuzYPzzRNQedOimi5
         f/tmQXftvVDs1woWnl8DvvJXs4WHyolSliGOMlKf//P8ZOOU3dAlLkF4kgBjloo6fZ/r
         Nhfmw6LGqb5Ikx4nTkk2fTvn1U+QZ682JsQ4JWsqRwpHARvamc7KhrjWxPLAmgYt/whU
         XyxA==
X-Gm-Message-State: AFqh2krSBX20nu4hKymeH3ZQ5ldeADSHR6fJfnjcveEQnOOAy641j/qy
        /MdF2jhdVX0vWLrT2cK54uWQPA==
X-Google-Smtp-Source: AMrXdXuKC5zRFslwGJK52dVjq2ujUBD5QgTWc+OROZLGPXQt+R//dN5r7uBR7HOQr77RLbjFEkO3/g==
X-Received: by 2002:a05:600c:540f:b0:3da:f6fe:ba6 with SMTP id he15-20020a05600c540f00b003daf6fe0ba6mr7723015wmb.38.1674062190226;
        Wed, 18 Jan 2023 09:16:30 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c198d00b003cfa81e2eb4sm2772780wmq.38.2023.01.18.09.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 09:16:29 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org, dianders@chromium.org,
        david@ixit.cz, krzysztof.kozlowski+dt@linaro.org,
        swboyd@chromium.org, konrad.dybcio@somainline.org,
        agross@kernel.org, andersson@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 2/2] dt-bindings: msm: dsi-controller-main: Document clocks on a per compatible basis
Date:   Wed, 18 Jan 2023 17:16:21 +0000
Message-Id: <20230118171621.102694-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230118171621.102694-1-bryan.odonoghue@linaro.org>
References: <20230118171621.102694-1-bryan.odonoghue@linaro.org>
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

Each compatible has a different set of clocks which are associated with it.
Add in the list of clocks for each compatible.

Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../display/msm/dsi-controller-main.yaml      | 218 ++++++++++++++++--
 1 file changed, 201 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 35668caa190c4..ad1ba15b74c19 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -9,9 +9,6 @@ title: Qualcomm Display DSI controller
 maintainers:
   - Krishna Manikandan <quic_mkrishn@quicinc.com>
 
-allOf:
-  - $ref: "../dsi-controller.yaml#"
-
 properties:
   compatible:
     oneOf:
@@ -50,22 +47,23 @@ properties:
     maxItems: 1
 
   clocks:
-    items:
-      - description: Display byte clock
-      - description: Display byte interface clock
-      - description: Display pixel clock
-      - description: Display core clock
-      - description: Display AHB clock
-      - description: Display AXI clock
+    description: |
+      Several clocks are used, depending on the variant. Typical ones are::
+       - bus:: Display AHB clock.
+       - byte:: Display byte clock.
+       - byte_intf:: Display byte interface clock.
+       - core:: Display core clock.
+       - core_mss:: Core MultiMedia SubSystem clock.
+       - iface:: Display AXI clock.
+       - mdp_core:: MDP Core clock.
+       - mnoc:: MNOC clock
+       - pixel:: Display pixel clock.
+    minItems: 3
+    maxItems: 9
 
   clock-names:
-    items:
-      - const: byte
-      - const: byte_intf
-      - const: pixel
-      - const: core
-      - const: iface
-      - const: bus
+    minItems: 3
+    maxItems: 9
 
   phys:
     maxItems: 1
@@ -161,6 +159,192 @@ required:
   - assigned-clock-parents
   - ports
 
+allOf:
+  - $ref: ../dsi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,apq8064-dsi-ctrl
+    then:
+      properties:
+        clocks:
+          maxItems: 7
+        clock-names:
+          items:
+            - const: iface
+            - const: bus
+            - const: core_mmss
+            - const: src
+            - const: byte
+            - const: pixel
+            - const: core
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8916-dsi-ctrl
+    then:
+      properties:
+        clocks:
+          maxItems: 6
+        clock-names:
+          items:
+            - const: mdp_core
+            - const: iface
+            - const: bus
+            - const: byte
+            - const: pixel
+            - const: core
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8953-dsi-ctrl
+    then:
+      properties:
+        clocks:
+          maxItems: 6
+        clock-names:
+          items:
+            - const: mdp_core
+            - const: iface
+            - const: bus
+            - const: byte
+            - const: pixel
+            - const: core
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8974-dsi-ctrl
+    then:
+      properties:
+        clocks:
+          maxItems: 7
+        clock-names:
+          items:
+            - const: mdp_core
+            - const: iface
+            - const: bus
+            - const: byte
+            - const: pixel
+            - const: core
+            - const: core_mmss
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8996-dsi-ctrl
+    then:
+      properties:
+        clocks:
+          maxItems: 7
+        clock-names:
+          items:
+            - const: mdp_core
+            - const: byte
+            - const: iface
+            - const: bus
+            - const: core_mmss
+            - const: pixel
+            - const: core
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8998-dsi-ctrl
+    then:
+      properties:
+        clocks:
+          maxItems: 6
+        clock-names:
+          items:
+            - const: byte
+            - const: byte_intf
+            - const: pixel
+            - const: core
+            - const: iface
+            - const: bus
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc7180-dsi-ctrl
+              - qcom,sc7280-dsi-ctrl
+              - qcom,sm8250-dsi-ctrl
+              - qcom,sm8150-dsi-ctrl
+              - qcom,sm8250-dsi-ctrl
+              - qcom,sm8350-dsi-ctrl
+              - qcom,sm8450-dsi-ctrl
+              - qcom,sm8550-dsi-ctrl
+    then:
+      properties:
+        clocks:
+          maxItems: 6
+        clock-names:
+          items:
+            - const: byte
+            - const: byte_intf
+            - const: pixel
+            - const: core
+            - const: iface
+            - const: bus
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sdm660-dsi-ctrl
+    then:
+      properties:
+        clocks:
+          maxItems: 9
+        clock-names:
+          items:
+            - const: mdp_core
+            - const: byte
+            - const: byte_intf
+            - const: mnoc
+            - const: iface
+            - const: bus
+            - const: core_mmss
+            - const: pixel
+            - const: core
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sdm845-dsi-ctrl
+    then:
+      properties:
+        clocks:
+          maxItems: 6
+        clock-names:
+          items:
+            - const: byte
+            - const: byte_intf
+            - const: pixel
+            - const: core
+            - const: iface
+            - const: bus
+
 additionalProperties: false
 
 examples:
-- 
2.38.1

