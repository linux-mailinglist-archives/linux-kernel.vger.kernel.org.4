Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3028365208F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbiLTMhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiLTMgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:36:45 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F02C13F2D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:36:44 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id w15so11576597wrl.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1hPXPEXckffBNlwumvAsC5HqSCurGTcNG8EXU4Ej48=;
        b=n/v13EGg/iN9FZMV6JCSrqQEo4iGxTaj9VvSyhHUftlDJeqbBE9KVPNQqczSz0oIGA
         TCQ53qdHf2bfD+ZNPQdlcHRo7LjsMDYkZNmMf0fax0CPqAlZ8f9SyWGLixvNetZUs4/2
         UYarwp1h26Hk/WQ4ALc7Qwie9Zsf/O1p+3Pi91uuhlk7zoxm//Hp1PmXw++w+7JJZSVu
         a/P9Hr8Yr8NZ8bd7MZBAULRiJAmu79gcBJBwDGCA2o9DhrGPmsunqhKUfZIasQp3n2Ce
         Y0tNd0Zmaej7gBhGrt0BetZ55A9b4HA3RtQX0qyCcIrhBAVv22tukpcF5QphF/nZuF6A
         E0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1hPXPEXckffBNlwumvAsC5HqSCurGTcNG8EXU4Ej48=;
        b=q/R99lAXeL7QsG3dtqUsuGzWF0Svvk4J81fvsiAy9T0AVNkiaOvOJzG48jUotUlZVp
         Z+8dtwBByijrPw1qbI1cxOJDgrwdeLyX3dCAh9eZIIn79qaNUL/I+orrUBjzH2VvuISX
         X+4wLuomyskldTvz6bWijK353UsUest5SKQtedlXPNyIebEOXXog2+Jq5f97CiOmWJ/q
         +W0ZlE9A5ucfmQw/m3NjWp+/K4c7bePJWLkcQ1300bZ5Y3JmHsG1N3xYaeWtrdQQt7Du
         /mTry7BZqme/3R5Jl2L0x/BZaj9AdpP4MGLxKGlNqXXFOgZkwF7Eh+xLsomINd8OaBUU
         QAqw==
X-Gm-Message-State: ANoB5plQT3dUVz3xWttZoWnj0z4QNFTVB5oJWmpNHKt0gO3n2mxv/MYA
        b3PGlteYh2YhVSRl0LouDhKmgQ==
X-Google-Smtp-Source: AA0mqf5B5ECh+ggJRZRYmz1pdLlaVcCEONfCV05NNyl9HT9G3Cq7sziOYBCuqSJnIDq9c1qbB4NMCg==
X-Received: by 2002:a05:6000:38b:b0:242:69f4:cb6a with SMTP id u11-20020a056000038b00b0024269f4cb6amr32222320wrf.9.1671539803010;
        Tue, 20 Dec 2022 04:36:43 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id da13-20020a056000408d00b00242257f2672sm12641208wrb.77.2022.12.20.04.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:36:42 -0800 (PST)
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
Subject: [PATCH v5 05/21] dt-bindings: msm: dsi-controller-main: Deprecate qcom,dsi-ctrl-6g-qcm2290 in favour of qcom,qcm2290-dsi-ctrl
Date:   Tue, 20 Dec 2022 12:36:18 +0000
Message-Id: <20221220123634.382970-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221220123634.382970-1-bryan.odonoghue@linaro.org>
References: <20221220123634.382970-1-bryan.odonoghue@linaro.org>
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

Deprecate qcom,dsi-ctrl-6g-qcm2290 in favour of the desired format
qcom,qcm2290-dsi-ctrl.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../display/msm/dsi-controller-main.yaml      | 36 +++++++++++--------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 01afa9e9c4b3c..98d54a7ee28d4 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -14,21 +14,27 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - qcom,apq8064-dsi-ctrl
-          - qcom,msm8916-dsi-ctrl
-          - qcom,msm8953-dsi-ctrl
-          - qcom,msm8974-dsi-ctrl
-          - qcom,msm8996-dsi-ctrl
-          - qcom,msm8998-dsi-ctrl
-          - qcom,dsi-ctrl-6g-qcm2290
-          - qcom,sc7180-dsi-ctrl
-          - qcom,sc7280-dsi-ctrl
-          - qcom,sdm660-dsi-ctrl
-          - qcom,sdm845-dsi-ctrl
-          - qcom,sm8250-dsi-ctrl
-      - const: qcom,mdss-dsi-ctrl
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
-- 
2.38.1

