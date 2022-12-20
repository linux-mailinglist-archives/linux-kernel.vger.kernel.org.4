Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0D9652093
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbiLTMhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiLTMgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:36:46 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9163E12606
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:36:45 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id z10so1024141wrh.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcdUE8NR8huKof5azSnKxhx9ERF/ArT355ZZA+6I3lQ=;
        b=K3r2HGbIFPOKJORY+FFO8G++G//W1DUYnO2Pky0W7NSVec0HCceRWHBNrgCnQmjH3O
         +1M5D53JEzuO84pwrWawc1VippiH3P19ECDHMdeD4fRr/4S9xpvNw6A6I3mWXP6PoPEQ
         +TvAvidRt/gRdGXhRSccXqEpAY2coZkmm8dmylPt1ntt4UD+ql8AT07IfBTbrGi59Unl
         MxPZrK7tJQbzCcATd7IttW6Ygq593xX4+woZb9F00c7cMw1gIVZTyTBS33k7+JTr4ed+
         /m+gNU6DG6/RFCPeAZAdSCHvvpaKByx92jm5klUqREAska1O0PrbvQomD+EkJNQaaePw
         8/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcdUE8NR8huKof5azSnKxhx9ERF/ArT355ZZA+6I3lQ=;
        b=ZkXfv9Z3M0/Po8BTYRFs5yNkImMtIO3hdaZ5L34y9CSscJfgXO1R/02qbjaVNwxvEC
         N7y3KlDUqxtHi2+0zMNxIYsvfXvnbN/+zs9Jq4AVNvbNjhLqPAMyCQF3ntfBYADYDKsW
         7NwzrNnLnaWFTFcsTHAWkcl+sXzDHoVWsul1I+omYp6CqdIeaJ/LXVEHmZkM7NbM+ZMt
         Hu8nLMMKtmoW6WqISdG/hnrJbHEL6CWW1KFtZ1V8p9AIMa4ehbEzxgVSdNnWbTUxFj0e
         FxB7QP4AtZI2G25EW5uYQHIoAT+7TMH0qcH/BtjjCt+nEnGV7BPjcDCwAfubkwAvGwDj
         9LdA==
X-Gm-Message-State: AFqh2krK0VueW6MjRrZkT5Bgshg/DiYvbqGZYRR7oMx3zGyRbFCp1xly
        FOREIKv68knTxl3MJGiivMBwKTS1WP3FJcrhmNQ=
X-Google-Smtp-Source: AMrXdXv3Vh9OqaPnGw+PeK0qGAwobfyG/V5V1zBCHjCDKHztPH38ZlEZCPk+U/g2M9mOVVuNO18yfQ==
X-Received: by 2002:a05:6000:1f1c:b0:261:d8be:3046 with SMTP id bv28-20020a0560001f1c00b00261d8be3046mr4289547wrb.0.1671539804151;
        Tue, 20 Dec 2022 04:36:44 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id da13-20020a056000408d00b00242257f2672sm12641208wrb.77.2022.12.20.04.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:36:43 -0800 (PST)
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
Subject: [PATCH v5 06/21] dt-bindings: msm: dsi-controller-main: Document clocks on a per compatible basis
Date:   Tue, 20 Dec 2022 12:36:19 +0000
Message-Id: <20221220123634.382970-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221220123634.382970-1-bryan.odonoghue@linaro.org>
References: <20221220123634.382970-1-bryan.odonoghue@linaro.org>
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
 .../display/msm/dsi-controller-main.yaml      | 189 +++++++++++++++++-
 1 file changed, 179 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 98d54a7ee28d4..ce103e3ec4db3 100644
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
@@ -55,13 +52,8 @@ properties:
       - description: Display AXI clock
 
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
@@ -157,6 +149,183 @@ required:
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

