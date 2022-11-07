Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F23620434
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 00:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbiKGX5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 18:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbiKGX5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:57:13 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EE927CC0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 15:57:06 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so64796wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 15:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5H4aIH5vgrqEjkb0c4TPSI9rlEkjF0KuTX6JDaV2C+Q=;
        b=I8vHBi1wTF81RoXMibJDd+V1bea1cticVTZR4pKMBnuwoTwzVwfXple4alROtnU9tR
         P3wwltR+nDb6g+v+MJ+OxP5WniGWwjPRvbhc6W36L/uBwYdhLSi37N71OpLpIvs2qqx9
         IJf/JnQ1a3Rg+EuHzmJJM4A0sVT1d8Gq5Om6cLIKGUnibvbj/jXFmXm0zx2Rbg5NL5oJ
         ZQRA0PQtl0405XEhs6Or3yw4i/OwF54BKP5Uwp5XAjVQbZ4tKR2pU4HDuCqC4S0sL1j9
         p86GrpOSi45B+6Gj8wsE26GqdQGt8LNx3hlr1DPZ4DjIsFtavBOHF6Dyw6kZR5ZrzaDK
         lADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5H4aIH5vgrqEjkb0c4TPSI9rlEkjF0KuTX6JDaV2C+Q=;
        b=iaRotSjTYycYxeZZvJL1qIY4GYcFPcJqMUuVbiJ1/6p75oD9XcYzK5/en3NOD+vzDj
         wYCnaBwQHX0/4PEeGevUvZbPr5uMZS3cfAS4Glinzz6xhyf1sZDscxuMiIBIoejOHhlO
         gkiqMtgFryjZaLb/8464HZyFvClE13CHq3q5jVaSz6Na1vdqk6lfnJW4RmtBVIyAtyLX
         dtKeFbKBrZ9m81IlaEj5OUU82NYDOyJM1FRu3Ho2yYsSHU5y+b0SlIkk8CGiFXlCMyMD
         eiXvzlk645NVO1Y3BfQ4H2zpRi4jD7+Ydxpifas0cCTnqSYW2ckhfDuxiH3FgrYtlpke
         Rm7g==
X-Gm-Message-State: ACrzQf0Svws+bGlrniedLUanDxOE81RyXhB7AzbX9SMmIAfWt6yXUkA0
        ozUKF8NriqB4EGtpD3MSbTOEbg==
X-Google-Smtp-Source: AMsMyM5PpcWg9aHzhtCQyM0rQQT6CqD/DaJpW9c3F0kxcx6U15WTxwlB0TibX2THeNPu7nZvd6GBjw==
X-Received: by 2002:a05:600c:548a:b0:3cf:a358:ee3 with SMTP id iv10-20020a05600c548a00b003cfa3580ee3mr8953419wmb.12.1667865424999;
        Mon, 07 Nov 2022 15:57:04 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b18-20020a056000055200b00236545edc91sm8386161wrf.76.2022.11.07.15.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:57:04 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, quic_mkrishn@quicinc.com,
        linux-arm-msm@vger.kernel.org
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/18] dt-bindings: msm: dsi-controller-main: Document clocks on a per compatible basis
Date:   Mon,  7 Nov 2022 23:56:44 +0000
Message-Id: <20221107235654.1769462-9-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107235654.1769462-1-bryan.odonoghue@linaro.org>
References: <20221107235654.1769462-1-bryan.odonoghue@linaro.org>
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

Cc: Rob Clark <robdclark@gmail.com>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../display/msm/dsi-controller-main.yaml      | 177 +++++++++++++++---
 1 file changed, 150 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 9db3e63acda3d..c975df0ca22fc 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -9,24 +9,22 @@ title: Qualcomm Display DSI controller
 maintainers:
   - Krishna Manikandan <quic_mkrishn@quicinc.com>
 
-allOf:
-  - $ref: "../dsi-controller.yaml#"
-
 properties:
   compatible:
-    enum:
-      - qcom,dsi-ctrl-6g-qcm2290
-      - qcom,mdss-dsi-ctrl
-      - qcom,mdss-dsi-ctrl-apq8064
-      - qcom,mdss-dsi-ctrl-msm8916
-      - qcom,mdss-dsi-ctrl-msm8974
-      - qcom,mdss-dsi-ctrl-msm8996
-      - qcom,mdss-dsi-ctrl-sc7180
-      - qcom,mdss-dsi-ctrl-sc7280
-      - qcom,mdss-dsi-ctrl-sdm630
-      - qcom,mdss-dsi-ctrl-sdm660
-      - qcom,mdss-dsi-ctrl-sdm845
-      - qcom,mdss-dsi-ctrl-sm8250
+    items:
+      - enum:
+          - qcom,dsi-ctrl-6g-qcm2290
+          - qcom,mdss-dsi-ctrl-apq8064
+          - qcom,mdss-dsi-ctrl-msm8916
+          - qcom,mdss-dsi-ctrl-msm8974
+          - qcom,mdss-dsi-ctrl-msm8996
+          - qcom,mdss-dsi-ctrl-sc7180
+          - qcom,mdss-dsi-ctrl-sc7280
+          - qcom,mdss-dsi-ctrl-sdm630
+          - qcom,mdss-dsi-ctrl-sdm660
+          - qcom,mdss-dsi-ctrl-sdm845
+          - qcom,mdss-dsi-ctrl-sm8250
+      - const: qcom,mdss-dsi-ctrl
 
   reg:
     maxItems: 1
@@ -51,17 +49,8 @@ properties:
     minItems: 6
 
   clock-names:
-    items:
-      - const: byte
-      - const: byte_intf
-      - const: pixel
-      - const: core
-      - const: iface
-      - const: bus
-      - const: core_mmss
-      - const: mdp_core
-      - const: mnoc
     minItems: 6
+    maxItems: 9
 
   phys:
     maxItems: 1
@@ -169,6 +158,140 @@ required:
   - vddio-supply
   - vdda-supply
 
+allOf:
+  - $ref: "../dsi-controller.yaml#"
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,mdss-dsi-ctrl-apq8064
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
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,mdss-dsi-ctrl-msm8916
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
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,mdss-dsi-ctrl-msm8974
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: iface
+            - const: bus
+            - const: vsync
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,mdss-dsi-ctrl-msm8996
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
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,mdss-dsi-ctrl-sc7180
+              - qcom,mdss-dsi-ctrl-sc7280
+              - qcom,mdss-dsi-ctrl-sm8250
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
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,mdss-dsi-ctrl-sdm630
+              - qcom,mdss-dsi-ctrl-sdm660
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
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,mdss-dsi-ctrl-sdm845
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
@@ -179,7 +302,7 @@ examples:
      #include <dt-bindings/power/qcom-rpmpd.h>
 
      dsi@ae94000 {
-           compatible = "qcom,mdss-dsi-ctrl";
+           compatible = "qcom,mdss-dsi-ctrl-sc7180", "qcom,mdss-dsi-ctrl";
            reg = <0x0ae94000 0x400>;
            reg-names = "dsi_ctrl";
 
-- 
2.38.1

