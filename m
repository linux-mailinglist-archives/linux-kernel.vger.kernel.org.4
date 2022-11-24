Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBC1636F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 01:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiKXAsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 19:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKXAsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 19:48:22 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF5E8B113
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:48:12 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bs21so252979wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KGbBDcAT4xLXSV5KWAhjzrIokB+uB1Cw7DGE4ZeW9A=;
        b=wX2s75m+cNTKK3PU8ieRDM7RZPUTIC2CpgbU7zZzrAwp6ishdxJzRDj6ABNFK7oPSc
         kQI2073+5QdjQJuIKc1ZaPhClGCRjdmwTRY8ptvdqWJXGbD8VSyk7AVslm+DZM8IOOVu
         abDL1bOdhGxSJyOEuzRspfr40WofQOZs72qr7cafKqF+IfrN1bM+/XpcO3UwyGYCYZJV
         IsV11deOAWOtOQt4XR22PuYpRue80vGjYhg4Wfea0PH/mdIdLFqX1SH9oPQKeeF1niWd
         sOkbyuyishQ+rW52W11hc6aHx6x3t/8sYCFh+8KdzrJlxphOSimMiLBVAkktFaRYqjZp
         +fcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KGbBDcAT4xLXSV5KWAhjzrIokB+uB1Cw7DGE4ZeW9A=;
        b=1TbKUsgoLuHYuDXqomL1r6xK0uajR6vhW27BiHmO+pSjO/IF7DKWOk2snKdNqApBXm
         nf8IXBqHmAXcsZGpQ45dcbPYXF6wCyP7gMSrUwkgiEt6nQJjCA5QiLrAIo4vtnyxBdCl
         0p+gIStho/gbI9yzbRW679AbOjUc9PRBPxJoHChgfOAFGyAFQ4nGy10w1PforEiZp75A
         pzOq5hVCYCoqNG/j+4o/oTN1vAgwml65m0pxa5gpEBbRTcvD0YDiEQMqZKveusFa9IiA
         lg6qeZjWV7RnTYaaxTl9TutieCGOpigVBPkihU6eWWbLRxDSDdHtXtI+3rGFqTquYa4x
         y1lQ==
X-Gm-Message-State: ANoB5plQ7HuFDO7c0zaEmLWNOw/R7YJDRNNzOeRAEOCqoixeCDPnBQbq
        leUUax0ddSV/OQK0Y7se8eTmwg==
X-Google-Smtp-Source: AA0mqf59w1AxtvWkSIJA5V56G6LjDyG9HE6d1UqeGgB2DR1nfozLgjDTWVlEiYv+kLSIERhLD3aySg==
X-Received: by 2002:adf:eb06:0:b0:236:6442:804f with SMTP id s6-20020adfeb06000000b002366442804fmr18462581wrn.302.1669250890958;
        Wed, 23 Nov 2022 16:48:10 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n38-20020a05600c3ba600b003c6bbe910fdsm5245076wms.9.2022.11.23.16.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 16:48:10 -0800 (PST)
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
        bryan.odonoghue@linaro.org
Subject: [PATCH v3 05/18] dt-bindings: msm: dsi-controller-main: Document clocks on a per compatible basis
Date:   Thu, 24 Nov 2022 00:47:48 +0000
Message-Id: <20221124004801.361232-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221124004801.361232-1-bryan.odonoghue@linaro.org>
References: <20221124004801.361232-1-bryan.odonoghue@linaro.org>
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

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../display/msm/dsi-controller-main.yaml      | 154 ++++++++++++++++--
 1 file changed, 143 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index c4da7179999d2..88aac7d33555c 100644
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
     items:
@@ -48,13 +45,8 @@ properties:
       - description: Display AXI clock
 
   clock-names:
-    items:
-      - const: byte
-      - const: byte_intf
-      - const: pixel
-      - const: core
-      - const: iface
-      - const: bus
+    minItems: 6
+    maxItems: 9
 
   phys:
     maxItems: 1
@@ -147,6 +139,146 @@ required:
   - assigned-clock-parents
   - ports
 
+allOf:
+  - $ref: "../dsi-controller.yaml#"
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
+              - qcom,msm8974-dsi-ctrl
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: iface
+            - const: bus
+            - const: vsync
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
+              - qcom,sc7180-dsi-ctrl
+              - qcom,sc7280-dsi-ctrl
+              - qcom,sm8250-dsi-ctrl
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
+              - qcom,sdm630-dsi-ctrl
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
@@ -157,7 +289,7 @@ examples:
      #include <dt-bindings/power/qcom-rpmpd.h>
 
      dsi@ae94000 {
-           compatible = "qcom,mdss-dsi-ctrl";
+           compatible = "qcom,sc7180-dsi-ctrl", "qcom,mdss-dsi-ctrl";
            reg = <0x0ae94000 0x400>;
            reg-names = "dsi_ctrl";
 
-- 
2.38.1

