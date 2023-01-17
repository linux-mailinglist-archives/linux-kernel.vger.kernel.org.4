Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C0F670BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjAQWpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjAQWnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:43:16 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E02C66CCA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 14:30:19 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id vm8so78882016ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 14:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eion5X6q0VGOUxLUpNxKDysfDIqbYrJk68bo85TaH+Q=;
        b=VoyIsv4dph5cVUhjhEFt5ShuNiAHmXfJfanoTfOyckl1ni8SujS/8QgYx0Qo5hSiVy
         VkldYfJOuMGyp0mw70ptCMM7d8jWbnu3X5r7l6C2aynym5UxDG6JfUDi7lewFgTIcLUh
         153j7dSvhNDfZhIwT9rwIKvgJSfgkLxpv156cqqvhCQYVkMCIeytGDC+y3dlo/pvleSh
         r3xyQxuEsmRzIT8gLNA7aK1RevD4OMIZz6U0JQYKF5jHayVpxFYd7qZeCmSFWGIS1G9v
         b/dGCAr/LSciZHAvcqbzmTJrg9rVXabuJKgYNZ6H9k1x1e384qbGc8iQnHEJPdm4vbHw
         ePGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eion5X6q0VGOUxLUpNxKDysfDIqbYrJk68bo85TaH+Q=;
        b=69jPM/4ZiJdBwMOrtbcQIYM+JcIiKcKqfETxSjUYGVn/foFx9lo/Hn4RZbJPnPxhPv
         IIZkeEikDUe3LOEQ9CYxZ1YdNhv2oXFDIOCVwhwQHq2iSnrxZSlMmPCEsNWfErYCDmP7
         2Zi4uy+fxJr1zJF0QFNZiKKr1u7xzJaCLE6tx2C6GBrRKhqj5/I0MKCtKKCBtUUMV1Ux
         KvcDyr5ppNYNpHSm8TahJnKgrOMwF82Ur4eflpnjFprsbh80r8x8Kwmb7DRKyclKElfq
         VImtlsduIUz39IzUo9n0zX4U4ctPzDdcRjsigfG/7dwSR759WjF7YL8i1SCLO92foOR8
         f/SQ==
X-Gm-Message-State: AFqh2kqqMYPwQPTa/HAIwP0hsrJZmzsqnzlO9fa95G53ju/EVk0gwbpL
        hHkTdRYoTtO+0rauSa8rlaR1DA==
X-Google-Smtp-Source: AMrXdXsVPq4w7cMK7zZzgZlY54dTlW+FD5LbTIjkx3OGzdQPjeGc7eDqOrmlrhG0fRBorpGJTUkB3g==
X-Received: by 2002:a17:907:a80b:b0:86f:220e:94af with SMTP id vo11-20020a170907a80b00b0086f220e94afmr13486876ejc.56.1673994617996;
        Tue, 17 Jan 2023 14:30:17 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id ec20-20020a170906b6d400b007c0f5d6f754sm13835189ejb.79.2023.01.17.14.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 14:30:17 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] dt-bindings: mailbox: qcom: correct the list of platforms using clocks
Date:   Wed, 18 Jan 2023 00:30:10 +0200
Message-Id: <20230117223013.1545026-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230117223013.1545026-1-dmitry.baryshkov@linaro.org>
References: <20230117223013.1545026-1-dmitry.baryshkov@linaro.org>
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

Only three platforms require `pll' and `aux' clocks: msm8916, msm8939
and qcs404. Correct the list of platforms in the corresponding clause.

Fixes: 0d17014e9189 ("dt-bindings: mailbox: Add binding for SDX55 APCS")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../mailbox/qcom,apcs-kpss-global.yaml        | 33 ++++++++++++++-----
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index ecc286ab49ef..7d8de7a16984 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -72,15 +72,8 @@ allOf:
         compatible:
           enum:
             - qcom,msm8916-apcs-kpss-global
-            - qcom,msm8994-apcs-kpss-global
-            - qcom,msm8996-apcs-hmss-global
-            - qcom,msm8998-apcs-hmss-global
+            - qcom,msm8939-apcs-kpss-global
             - qcom,qcs404-apcs-apps-global
-            - qcom,sc7180-apss-shared
-            - qcom,sdm660-apcs-hmss-global
-            - qcom,sdm845-apss-shared
-            - qcom,sm6125-apcs-hmss-global
-            - qcom,sm8150-apss-shared
     then:
       properties:
         clocks:
@@ -124,6 +117,30 @@ allOf:
           items:
             - const: pll
             - const: xo
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,msm8953-apcs-kpss-global
+            - qcom,msm8976-apcs-kpss-global
+            - qcom,msm8994-apcs-kpss-global
+            - qcom,msm8996-apcs-hmss-global
+            - qcom,msm8998-apcs-hmss-global
+            - qcom,qcm2290-apcs-hmss-global
+            - qcom,sc7180-apss-shared
+            - qcom,sc8180x-apss-shared
+            - qcom,sdm660-apcs-hmss-global
+            - qcom,sdm845-apss-shared
+            - qcom,sm4250-apcs-hmss-global
+            - qcom,sm6115-apcs-hmss-global
+            - qcom,sm6125-apcs-hmss-global
+            - qcom,sm8150-apss-shared
+    then:
+      properties:
+        clocks: false
+        clock-names: false
+
   - if:
       properties:
         compatible:
-- 
2.39.0

