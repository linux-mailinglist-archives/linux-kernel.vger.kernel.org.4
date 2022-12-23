Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E42654ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbiLWCLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbiLWCKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:10:37 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADCD2657D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:10:36 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id n3so2645179wrc.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrGmzC4FPUxaC4Ut3V1G8Ym4yhqQYUlqvh7nkKRN/u4=;
        b=nZ60nGGbsIxAAaBQ0iO2KqgUC4lFpVop8wQ+MldGMA6+IUFAyt5qErt7RVQSQo3TAX
         E+KeYCqEH4w0SwBTba8imXK8bbUBGDaE8RYnz6hlgxdDhIHlFwgcLOLhCBkJa9AFWQd2
         bqtgoVWKlrj0gsQCA7+9W8GOOqzA4R/5P9e8Pbqx/QKF2WdOPSmJWwJY4jctmD73nXn1
         NWuUVojDjX1r7Cl23bTtXCfvQDm8Q2BxWbTSvSGOC7fSNNIpy7dyQXqf0AlOk+9HLjkK
         4dLsFhgnwZGvG1UPZJYQ3FpOw80HLUwXDL792cPvaEiZe7yuT3kB6d3aPLkDRBY6TM4a
         e+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KrGmzC4FPUxaC4Ut3V1G8Ym4yhqQYUlqvh7nkKRN/u4=;
        b=bKpDsO9Oxp6g/BBAaA6E/vuUi24wtcu07HpG//imf2eiILa4WTSDQ/qJ/StOrcZ7Ke
         ZvlkZNW51W1E8AtdJ6NUc5bbvVn6E8XTZjQUyq1e6JTyKeWZ2qso0pEegT1zys9dWY6U
         QdDPLMuaM5eLiDVO77MK9x5K+JVNjY4D9e/RwF+eOQ01yPu4s064w0tU5fSFG/CnroGR
         xrcmNrJ2Wl8WL6+FhDZAG0onZkQufqdLCMRo684sXyAHVg+LTxZDJURNej23ehA4nq0A
         b06b6J4X2iER4LXHADSKW5kx+1edchCQNie7m3JVuIogCYsU/gyz3ojWuHN4QUkwXz68
         PiIg==
X-Gm-Message-State: AFqh2koSfaBu6O3rulTd5Trff7ttIZ/wWkzt8+4vPG3BQqMcZIZjn9Pb
        k3OofsnfVuJfuaApwMzHytNMzA==
X-Google-Smtp-Source: AMrXdXvratfSjjqDX9wOj7+1xVt6OdMkh2JyrnGFM1oRpHFjtPKTxlPqEevfCoL7BbmKdGBvETF5cA==
X-Received: by 2002:adf:dd47:0:b0:242:880:20d2 with SMTP id u7-20020adfdd47000000b00242088020d2mr4802693wrm.48.1671761436263;
        Thu, 22 Dec 2022 18:10:36 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d452b000000b0022cc0a2cbecsm1849725wra.15.2022.12.22.18.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 18:10:35 -0800 (PST)
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
Subject: [PATCH v6 07/18] dt-bindings: display/msm: Add list of mdss-dsi-ctrl compats
Date:   Fri, 23 Dec 2022 02:10:14 +0000
Message-Id: <20221223021025.1646636-8-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221223021025.1646636-1-bryan.odonoghue@linaro.org>
References: <20221223021025.1646636-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the list of current compats absent the deprecated qcm2290 to the list
of dsi compats listed here.

Several MDSS yaml files exist which document the dsi sub-node.
For each existing SoC MDSS yaml, provide the right dsi compat string.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../bindings/display/msm/qcom,mdss.yaml          | 16 +++++++++++++++-
 .../bindings/display/msm/qcom,msm8998-mdss.yaml  |  8 +++++---
 .../bindings/display/msm/qcom,sc7180-mdss.yaml   |  6 ++++--
 .../bindings/display/msm/qcom,sc7280-mdss.yaml   |  6 ++++--
 .../bindings/display/msm/qcom,sdm845-mdss.yaml   |  8 +++++---
 .../bindings/display/msm/qcom,sm8250-mdss.yaml   |  8 +++++---
 6 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml
index ba0460268731b..86bb43489bf4a 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml
@@ -94,7 +94,21 @@ patternProperties:
     type: object
     properties:
       compatible:
-        const: qcom,mdss-dsi-ctrl
+        items:
+          - enum:
+              - qcom,apq8064-dsi-ctrl
+              - qcom,msm8916-dsi-ctrl
+              - qcom,msm8953-dsi-ctrl
+              - qcom,msm8974-dsi-ctrl
+              - qcom,msm8996-dsi-ctrl
+              - qcom,msm8998-dsi-ctrl
+              - qcom,qcm2290-dsi-ctrl
+              - qcom,sc7180-dsi-ctrl
+              - qcom,sc7280-dsi-ctrl
+              - qcom,sdm660-dsi-ctrl
+              - qcom,sdm845-dsi-ctrl
+              - qcom,sm8250-dsi-ctrl
+          - const: qcom,mdss-dsi-ctrl
 
   "^phy@[1-9a-f][0-9a-f]*$":
     type: object
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,msm8998-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,msm8998-mdss.yaml
index cf52ff77a41aa..692b60af946f0 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,msm8998-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,msm8998-mdss.yaml
@@ -47,7 +47,9 @@ patternProperties:
     type: object
     properties:
       compatible:
-        const: qcom,mdss-dsi-ctrl
+        items:
+          - const: qcom,msm8998-dsi-ctrl
+          - const: qcom,mdss-dsi-ctrl
 
   "^phy@[0-9a-f]+$":
     type: object
@@ -126,7 +128,7 @@ examples:
         };
 
         dsi@c994000 {
-            compatible = "qcom,mdss-dsi-ctrl";
+            compatible = "qcom,msm8998-dsi-ctrl", "qcom,mdss-dsi-ctrl";
             reg = <0x0c994000 0x400>;
             reg-names = "dsi_ctrl";
 
@@ -196,7 +198,7 @@ examples:
         };
 
         dsi@c996000 {
-            compatible = "qcom,mdss-dsi-ctrl";
+            compatible = "qcom,msm8998-dsi-ctrl", "qcom,mdss-dsi-ctrl";
             reg = <0x0c996000 0x400>;
             reg-names = "dsi_ctrl";
 
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml
index 13e396d61a512..e72190040ca05 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml
@@ -59,7 +59,9 @@ patternProperties:
     type: object
     properties:
       compatible:
-        const: qcom,mdss-dsi-ctrl
+        items:
+          - const: qcom,sc7180-dsi-ctrl
+          - const: qcom,mdss-dsi-ctrl
 
   "^phy@[0-9a-f]+$":
     type: object
@@ -142,7 +144,7 @@ examples:
         };
 
         dsi@ae94000 {
-            compatible = "qcom,mdss-dsi-ctrl";
+            compatible = "qcom,sc7180-dsi-ctrl", "qcom,mdss-dsi-ctrl";
             reg = <0x0ae94000 0x400>;
             reg-names = "dsi_ctrl";
 
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml
index a3de1744ba119..8997e24f804eb 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml
@@ -58,7 +58,9 @@ patternProperties:
     type: object
     properties:
       compatible:
-        const: qcom,mdss-dsi-ctrl
+        items:
+          - const: qcom,sc7280-dsi-ctrl
+          - const: qcom,mdss-dsi-ctrl
 
   "^edp@[0-9a-f]+$":
     type: object
@@ -162,7 +164,7 @@ examples:
         };
 
         dsi@ae94000 {
-            compatible = "qcom,mdss-dsi-ctrl";
+            compatible = "qcom,sc7280-dsi-ctrl", "qcom,mdss-dsi-ctrl";
             reg = <0x0ae94000 0x400>;
             reg-names = "dsi_ctrl";
 
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml
index 31ca6f99fc223..b5446671f3adf 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml
@@ -51,7 +51,9 @@ patternProperties:
     type: object
     properties:
       compatible:
-        const: qcom,mdss-dsi-ctrl
+        items:
+          - const: qcom,sdm845-dsi-ctrl
+          - const: qcom,mdss-dsi-ctrl
 
   "^phy@[0-9a-f]+$":
     type: object
@@ -128,7 +130,7 @@ examples:
         };
 
         dsi@ae94000 {
-            compatible = "qcom,mdss-dsi-ctrl";
+            compatible = "qcom,sdm845-dsi-ctrl", "qcom,mdss-dsi-ctrl";
             reg = <0x0ae94000 0x400>;
             reg-names = "dsi_ctrl";
 
@@ -198,7 +200,7 @@ examples:
         };
 
         dsi@ae96000 {
-            compatible = "qcom,mdss-dsi-ctrl";
+            compatible = "qcom,sdm845-dsi-ctrl", "qcom,mdss-dsi-ctrl";
             reg = <0x0ae96000 0x400>;
             reg-names = "dsi_ctrl";
 
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml
index 0d3be5386b3f4..d093f73e02dc3 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml
@@ -55,7 +55,9 @@ patternProperties:
     type: object
     properties:
       compatible:
-        const: qcom,mdss-dsi-ctrl
+        items:
+          - const: qcom,sm8250-dsi-ctrl
+          - const: qcom,mdss-dsi-ctrl
 
   "^phy@[0-9a-f]+$":
     type: object
@@ -167,7 +169,7 @@ examples:
         };
 
         dsi@ae94000 {
-            compatible = "qcom,mdss-dsi-ctrl";
+            compatible = "qcom,sm8250-dsi-ctrl", "qcom,mdss-dsi-ctrl";
             reg = <0x0ae94000 0x400>;
             reg-names = "dsi_ctrl";
 
@@ -257,7 +259,7 @@ examples:
         };
 
         dsi@ae96000 {
-            compatible = "qcom,mdss-dsi-ctrl";
+            compatible = "qcom,sm8250-dsi-ctrl", "qcom,mdss-dsi-ctrl";
             reg = <0x0ae96000 0x400>;
             reg-names = "dsi_ctrl";
 
-- 
2.38.1

