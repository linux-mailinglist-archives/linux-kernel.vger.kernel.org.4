Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8066655D19
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 13:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiLYMBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 07:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiLYMAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 07:00:15 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EC065CA
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 03:59:29 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id z26so12877797lfu.8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 03:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpO2mOjemVEh3PAsRoqwlQ/H7YfF7zaImpMPnEr2kkE=;
        b=WQ9gIrxIlkm1Bi3dBa3sXbnKWg3Q6+9M7yX1DJuLWzwUXDr6C9w9JgzsBHC5tLnwdK
         VVWiwAxxEYutZypfXYJlwWnW8Kw/LXGV60gOlJT69vJsPjgSZpRlVB7YuuR7eCz1Jq5t
         g0urP0hgZMtbFQN9kg7S8FUuMLk4ZjSwpD0SRNiMjbpVHe67g4qlHnvgEmL7P4ZLJNYF
         omP7CeTpAL7RRSgyZ+LQDW2qHeYj1VFCiG1IlcIvSko5qiI6FoP6p3Dtwo/8Y4HUUVZt
         c/q76xmPAe0jKlu0AksRHVjkwPflv9XBTs7Zfd7x3IlFWV3nPmTF/W+3ytbV8mtqSnFL
         UVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpO2mOjemVEh3PAsRoqwlQ/H7YfF7zaImpMPnEr2kkE=;
        b=39FQqE2EKFQZqRWE1ppI5g5SUNy/hqA3w/DQcQKtZWaGe7ZGWJQB0dJR9DuT7OzPtk
         zYcSEhOJ5DZyJnaO2ISo4dbY9YJ6LLnKccSEaLCbTKbv4i0JEi1Wgi8CNqb+u3zYSON/
         vbc3IhNQBm9f7PpufY/m/906ePq9f5ItrBxGNE5Ekkj8vsDXJFZpcZEysJx+RwF27tVt
         +J7bwLC37TnFQm64OmIncvTRikBf3fyhXbdFrQYW0RJEkaJVo2djnjEYXutYvyxqTzsN
         LIiJYssGZZPKBtJKmT1HkUnDBh+Tgg3Jxz2pv1r9eMSfnYkHgt/9Di7bhRdHS9Hraa7w
         Vs+A==
X-Gm-Message-State: AFqh2ko0ys8jIuc1GIhBQ8MhwrANNUeL0HHpfihsis25WhiAEd2EzJjS
        zCqPmp6bLo+BvffB4PvRajCsXw==
X-Google-Smtp-Source: AMrXdXuKBP7b/Q0FfTlpsV5HqeYYSwCA0PmQAWCBg3FaLBiMZtQ03yvUXAxoTp6x8h1hfEoWYwZD4A==
X-Received: by 2002:a05:6512:1111:b0:4b5:43ef:a552 with SMTP id l17-20020a056512111100b004b543efa552mr4951726lfg.16.1671969569066;
        Sun, 25 Dec 2022 03:59:29 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id r4-20020ac252a4000000b004a25bb4494fsm1336911lfm.178.2022.12.25.03.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 03:59:28 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dt-bindings: display: msm: drop unneeded list for single compatible
Date:   Sun, 25 Dec 2022 12:59:25 +0100
Message-Id: <20221225115925.55337-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221225115925.55337-1-krzysztof.kozlowski@linaro.org>
References: <20221225115925.55337-1-krzysztof.kozlowski@linaro.org>
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

With only one compatible, there is no need to define it as list (items).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml      | 3 +--
 .../devicetree/bindings/display/msm/qcom,msm8998-mdss.yaml     | 3 +--
 .../devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml      | 3 +--
 .../devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml     | 3 +--
 .../devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml       | 3 +--
 .../devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml      | 3 +--
 .../devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml       | 3 +--
 .../devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml      | 3 +--
 .../devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml       | 3 +--
 .../devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml      | 3 +--
 .../devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml      | 3 +--
 11 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml
index 727a20c4375c..943b6f017f7c 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml
@@ -13,8 +13,7 @@ $ref: /schemas/display/msm/dpu-common.yaml#
 
 properties:
   compatible:
-    items:
-      - const: qcom,msm8998-dpu
+    const: qcom,msm8998-dpu
 
   reg:
     items:
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,msm8998-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,msm8998-mdss.yaml
index cf52ff77a41a..f67632a7e8fa 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,msm8998-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,msm8998-mdss.yaml
@@ -18,8 +18,7 @@ $ref: /schemas/display/msm/mdss-common.yaml#
 
 properties:
   compatible:
-    items:
-      - const: qcom,msm8998-mdss
+    const: qcom,msm8998-mdss
 
   clocks:
     items:
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
index a2fd9f8e456c..6c234b3b2765 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
@@ -13,8 +13,7 @@ $ref: /schemas/display/msm/dpu-common.yaml#
 
 properties:
   compatible:
-    items:
-      - const: qcom,qcm2290-dpu
+    const: qcom,qcm2290-dpu
 
   reg:
     items:
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
index 4795e13c7b59..f5b24f81f382 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
@@ -18,8 +18,7 @@ $ref: /schemas/display/msm/mdss-common.yaml#
 
 properties:
   compatible:
-    items:
-      - const: qcom,qcm2290-mdss
+    const: qcom,qcm2290-mdss
 
   clocks:
     items:
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
index 2ade94a216a8..86cfa3ddce62 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
@@ -13,8 +13,7 @@ $ref: /schemas/display/msm/dpu-common.yaml#
 
 properties:
   compatible:
-    items:
-      - const: qcom,sc7180-dpu
+    const: qcom,sc7180-dpu
 
   reg:
     items:
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml
index 13e396d61a51..2a1d4510db6d 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml
@@ -18,8 +18,7 @@ $ref: /schemas/display/msm/mdss-common.yaml#
 
 properties:
   compatible:
-    items:
-      - const: qcom,sc7180-mdss
+    const: qcom,sc7180-mdss
 
   clocks:
     items:
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml
index a2f305b04ee1..5cabb899977d 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml
@@ -13,8 +13,7 @@ $ref: /schemas/display/msm/dpu-common.yaml#
 
 properties:
   compatible:
-    items:
-      - const: qcom,sdm845-dpu
+    const: qcom,sdm845-dpu
 
   reg:
     items:
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml
index 31ca6f99fc22..289d61debc38 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml
@@ -18,8 +18,7 @@ $ref: /schemas/display/msm/mdss-common.yaml#
 
 properties:
   compatible:
-    items:
-      - const: qcom,sdm845-mdss
+    const: qcom,sdm845-mdss
 
   clocks:
     items:
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
index 6ad828a20332..bf62c2f5325a 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
@@ -13,8 +13,7 @@ $ref: /schemas/display/msm/dpu-common.yaml#
 
 properties:
   compatible:
-    items:
-      - const: qcom,sm6115-dpu
+    const: qcom,sm6115-dpu
 
   reg:
     items:
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
index 886858ef6700..2491cb100b33 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
@@ -18,8 +18,7 @@ $ref: /schemas/display/msm/mdss-common.yaml#
 
 properties:
   compatible:
-    items:
-      - const: qcom,sm6115-mdss
+    const: qcom,sm6115-mdss
 
   clocks:
     items:
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml
index 0d3be5386b3f..753bc99c868a 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml
@@ -18,8 +18,7 @@ $ref: /schemas/display/msm/mdss-common.yaml#
 
 properties:
   compatible:
-    items:
-      - const: qcom,sm8250-mdss
+    const: qcom,sm8250-mdss
 
   clocks:
     items:
-- 
2.34.1

