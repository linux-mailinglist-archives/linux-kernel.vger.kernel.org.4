Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2413B652087
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiLTMhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbiLTMgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:36:44 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F239D2D5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:36:43 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f13-20020a1cc90d000000b003d08c4cf679so8643008wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SX3uqIEBtLbM8AShYXDZOlc86/fdUP6gKtohgAJFYSs=;
        b=YdSKneixm0ez93NqPoqLdgFPkMzAxBHSiA7cXMlRegqM5dZx+HXvKtMWX+pi41XGZj
         LN6PCU81t68w6Xusx2f+PWdgee7qfG8HFWMvYGCxgTma6TAYSSbidtFuvkoUSDcH51XE
         eqjxAQryegnHAtS7+5PeawVkYY8m4izm1s5UIFqqZePbKInwAl4QAeZrhhgcQ6gNAhzY
         vbEWaFZq/MVSZAgFEN+xHvj28sh39OFjKRpEnywG8MB8BdVZ/up8f3fhEiG8BEJV9/Le
         VR4mesS9XapH09xB6HEdgSH7LekvckReyOIcUdz3mpxiBuUPVxuRIHH+tc3g4IthPD5o
         wkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SX3uqIEBtLbM8AShYXDZOlc86/fdUP6gKtohgAJFYSs=;
        b=qV2m4g78dPbpAbSSwkPNlBGOV+xrxidXtqrVrYR4/+//h/lTwaMRD3KatXhpVi3B/e
         2wDbzel9gcV4ZGkwZy0Tv+YtKznaYhVl8y0LfO6T0Op4tREN9QKfnCtqVUttHfaYt1fo
         g4r3BgYCTYJdImo6v6hiQPLVfkciBjbP55m+PFGENp/TnxMdxOehdK99KetT4fe+nLMe
         7x1Q+Y9WdTuNHhyVTtKH63rSQRUz++JoSgenuAvteBPhqagWioD3+Cm13fBNiAkHSJXc
         MJe9VBjhg/lQ8/g4vW/YBGJ0/6AoDQETp9K+1JIugNlKRquv2VL75P8xW2iLrlstoBWj
         CBpw==
X-Gm-Message-State: ANoB5pnmN72YrdGIMqpaSecO/s+it9pajTZ9WKuayFEQPbuCBkHwHtZz
        RIreHhlBPOQdc56YfDgyPKk7MQ==
X-Google-Smtp-Source: AA0mqf58I+Xg+OpAQV1uuLmLHCOt1STn3J9rzx6P0tmgKcfPwtMywcv7jnoP+lFeUIgI+nlESDkgvA==
X-Received: by 2002:a05:600c:3508:b0:3c6:e63e:816f with SMTP id h8-20020a05600c350800b003c6e63e816fmr33464232wmq.38.1671539801903;
        Tue, 20 Dec 2022 04:36:41 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id da13-20020a056000408d00b00242257f2672sm12641208wrb.77.2022.12.20.04.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:36:41 -0800 (PST)
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
Subject: [PATCH v5 04/21] dt-bindings: msm: dsi-controller-main: Add compatible strings for every current SoC
Date:   Tue, 20 Dec 2022 12:36:17 +0000
Message-Id: <20221220123634.382970-5-bryan.odonoghue@linaro.org>
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

Each SoC dtsi should declare "qcom,socname-dsi-ctrl", "qcom,mdss-dsi-ctrl";

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../display/msm/dsi-controller-main.yaml      | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 6e2fd6e9fa7f0..01afa9e9c4b3c 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -14,9 +14,21 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - qcom,mdss-dsi-ctrl
-      - qcom,dsi-ctrl-6g-qcm2290
+    items:
+      - enum:
+          - qcom,apq8064-dsi-ctrl
+          - qcom,msm8916-dsi-ctrl
+          - qcom,msm8953-dsi-ctrl
+          - qcom,msm8974-dsi-ctrl
+          - qcom,msm8996-dsi-ctrl
+          - qcom,msm8998-dsi-ctrl
+          - qcom,dsi-ctrl-6g-qcm2290
+          - qcom,sc7180-dsi-ctrl
+          - qcom,sc7280-dsi-ctrl
+          - qcom,sdm660-dsi-ctrl
+          - qcom,sdm845-dsi-ctrl
+          - qcom,sm8250-dsi-ctrl
+      - const: qcom,mdss-dsi-ctrl
 
   reg:
     maxItems: 1
@@ -149,7 +161,7 @@ examples:
      #include <dt-bindings/power/qcom-rpmpd.h>
 
      dsi@ae94000 {
-           compatible = "qcom,mdss-dsi-ctrl";
+           compatible = "qcom,sc7180-dsi-ctrl", "qcom,mdss-dsi-ctrl";
            reg = <0x0ae94000 0x400>;
            reg-names = "dsi_ctrl";
 
-- 
2.38.1

