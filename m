Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CF0654ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiLWCK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbiLWCKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:10:35 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912D425EAD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:10:34 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id y16so3401702wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZ5FGEbeDjrL2iWfMvLI1z2BArYg+1UZFUEu8QW81ho=;
        b=supY+mfnxqFaJyer79O9fEoRFD0NXuUOGQo44W5PWoNhbHjq2dkvvn/jk1ar+GfoXV
         hM1zc90iFahzKFcPibxs7mxx6RJrGOa4tilzUdevl2Zk9vJVD+FfqqB55um3QqBEW0xP
         wpDE9IBBxfV46QsGjq8wrBQWqd8NFv2LKFh7KGPXjzm1HUDO4MQ5XzAbjg8kDDCEVHQR
         WzhDvMb3nhDjqmCHvk/YcWPYGYw1wUbYkgwo88WyvD4p6t03yACJenWikkz+8fc44uNk
         8b+lfBTZXK17n6oC+LKcTRg5ov1Jpqquzg/aXE4ThfC99pTrR5OmUOw9SgKUaZx2VRT4
         XBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZ5FGEbeDjrL2iWfMvLI1z2BArYg+1UZFUEu8QW81ho=;
        b=s/5/1F9VMKkA9B3Eeky1Fz+edZjfGopXYf3bFQz3toAnR2YR32zceKS8F+a6bib+Or
         qDqnUHaUhHSdvband2di6lRm2A961gg4klUC9Uhho+I095RMe+nb1llLdzJM/x/g4xoj
         hx17vCfgCp3m5v5cqSLpNoTbQp5L8yGX77MwlvNqbJIMcV0p3UZQZ855Lkmo2eVZoUCW
         a9l9AsDeqHa5ExXEbktXBfExLL03UK+6XfIGB+ZjmDcwai+xf6gLIc2a45pA0EalVeBX
         g+6r4bMP26lcwxvy8r5lW7czK0dEJoRi3bDMy6LvSsKEiz4b7Bc6Wx4xK2OFMv85sSoS
         r3wA==
X-Gm-Message-State: AFqh2kpYHpStYxADfALH9ohu4K5w/rqKQqb04Fh/WUrpPW1k2xHD4Ohx
        a2cXJPtiwhiwG/XfF+CyFLi4Jw==
X-Google-Smtp-Source: AMrXdXuEgXFTiwZz66Yi+3vrH5961pBWHMBNODkS/ydRMqAhyQ7UZ+RbgrVlhFyy4k9u1box64gbWQ==
X-Received: by 2002:adf:ec05:0:b0:260:6dca:f239 with SMTP id x5-20020adfec05000000b002606dcaf239mr5260070wrn.22.1671761433188;
        Thu, 22 Dec 2022 18:10:33 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d452b000000b0022cc0a2cbecsm1849725wra.15.2022.12.22.18.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 18:10:32 -0800 (PST)
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
        bryan.odonoghue@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 04/18] dt-bindings: msm: dsi-controller-main: Add compatible strings for every current SoC
Date:   Fri, 23 Dec 2022 02:10:11 +0000
Message-Id: <20221223021025.1646636-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221223021025.1646636-1-bryan.odonoghue@linaro.org>
References: <20221223021025.1646636-1-bryan.odonoghue@linaro.org>
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

Currently we do not differentiate between the various users of the
qcom,mdss-dsi-ctrl. The driver is flexible enough to operate from one
compatible string but, the hardware does have some significant differences
in the number of clocks.

To facilitate documenting the clocks add the following compatible strings

- qcom,apq8064-dsi-ctrl
- qcom,msm8916-dsi-ctrl
- qcom,msm8953-dsi-ctrl
- qcom,msm8974-dsi-ctrl
- qcom,msm8996-dsi-ctrl
- qcom,msm8998-dsi-ctrl
- qcom,sc7180-dsi-ctrl
- qcom,sc7280-dsi-ctrl
- qcom,sdm660-dsi-ctrl
- qcom,sdm845-dsi-ctrl
- qcom,sm8250-dsi-ctrl
- qcom,qcm2290-dsi-ctrl

Deprecate qcom,dsi-ctrl-6g-qcm2290 in favour of the desired format while we
do so.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../display/msm/dsi-controller-main.yaml      | 26 ++++++++++++++++---
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 6e2fd6e9fa7f0..98d54a7ee28d4 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -14,9 +14,27 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - qcom,mdss-dsi-ctrl
-      - qcom,dsi-ctrl-6g-qcm2290
+    oneOf:
+      - items:
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
+      - items:
+          - enum:
+              - dsi-ctrl-6g-qcm2290
+          - const: qcom,mdss-dsi-ctrl
+        deprecated: true
 
   reg:
     maxItems: 1
@@ -149,7 +167,7 @@ examples:
      #include <dt-bindings/power/qcom-rpmpd.h>
 
      dsi@ae94000 {
-           compatible = "qcom,mdss-dsi-ctrl";
+           compatible = "qcom,sc7180-dsi-ctrl", "qcom,mdss-dsi-ctrl";
            reg = <0x0ae94000 0x400>;
            reg-names = "dsi_ctrl";
 
-- 
2.38.1

