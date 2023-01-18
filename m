Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6C9671E85
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjARNw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjARNvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:51:42 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304A12B0A7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:23:00 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id az20so64100822ejc.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qd5f8hzZm5qMEoqR4g+4cAWjwGfAnZ3T8KmzKwoOA5o=;
        b=WsBANPIb/MSdauDOF3I1Cwh7/TeK7qJ7AeqGW3ZSNUpH8GfOH/c3JFn2WMxTRj2Z3T
         BK0Nh81P6QcLQFzaW9A5aAnV53te9rmMSyqgNs1Kd5sU2un5YEbBWO59Zsu8bi/aE3EF
         KpSJk3qJ3+kpfCsj4Xf8DvGW+t0vkNIazvkqspeW5oa081KI4JdvUPLQDP0fptUibCNV
         Ul/9yQRGToJfmrERGayAr0sMZJ5kbZ5t2IcA6naE03IUoED9r6g5iBttjsTI4WCtiQk+
         B03lzUsWoPhWoqevcJZ4t/XyYIXnnVRyexuwPraWyDjI0q+QtoFLZCWNkHUEzyEGcVb+
         L5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qd5f8hzZm5qMEoqR4g+4cAWjwGfAnZ3T8KmzKwoOA5o=;
        b=EbzkLcQ87IUalgt2ls62FKC3BYm7hYo0A+vZTfuSmwBC/4DtYMJup7OJK0Z/JOLf64
         hi5Fy8y6+r1QtlKqGE4kCjP1yHftq2wcAI/gCTJmRuo+H1kl/+RI15IcDydxQhZ7aKQr
         OsKTGuuGpHm8TGQvLOWrdyUph1uMinPlv52SBNdmGazBvdCatBc8Jx3EmGznefxTwPPU
         lTLW3qJBZ0gxn/4Cz3HAdAVklGcjwpqcLNQubd5wwv/qem3IkE6SqTzPYT1w/LP0G9RH
         s6VVS+daWb5EcYLy5U922JPWoO9YApBxMnEbEB7BL4BO/AoCd3Gro42G8W9KZxSqkWuG
         E4Ug==
X-Gm-Message-State: AFqh2kpCgDyDF+mfnRdkOMAZ6VohzrlcgUxxJipG1kLibPXnVfenCMu5
        rFtD92B39ZgK/7lpXpVdDeFoiQ==
X-Google-Smtp-Source: AMrXdXujj5F9K3yswBHwGPwac2uPaJDZZt4vRzzKOpqsN79uy1jIzXyd9Ml4Gc5huOXZpaqZkejJbw==
X-Received: by 2002:a17:906:5a5f:b0:86f:3c6b:f7c6 with SMTP id my31-20020a1709065a5f00b0086f3c6bf7c6mr7134674ejc.64.1674048179800;
        Wed, 18 Jan 2023 05:22:59 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709061da200b0083f91a32131sm14633831ejh.0.2023.01.18.05.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 05:22:59 -0800 (PST)
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
Subject: [PATCH v4 3/7] dt-bindings: mailbox: qcom: correct the list of platforms using clocks
Date:   Wed, 18 Jan 2023 15:22:50 +0200
Message-Id: <20230118132254.2356209-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118132254.2356209-1-dmitry.baryshkov@linaro.org>
References: <20230118132254.2356209-1-dmitry.baryshkov@linaro.org>
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

The schema incorrectly lists some of the platforms in the statement
requiring clocks/clock-names. Correct this by moving platforms not
requiring additional clocks to the separate clause.

Fixes: 0d17014e9189 ("dt-bindings: mailbox: Add binding for SDX55 APCS")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../mailbox/qcom,apcs-kpss-global.yaml        | 26 +++++++++++++------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index ecc286ab49ef..5f7770036fed 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -72,15 +72,7 @@ allOf:
         compatible:
           enum:
             - qcom,msm8916-apcs-kpss-global
-            - qcom,msm8994-apcs-kpss-global
-            - qcom,msm8996-apcs-hmss-global
-            - qcom,msm8998-apcs-hmss-global
             - qcom,qcs404-apcs-apps-global
-            - qcom,sc7180-apss-shared
-            - qcom,sdm660-apcs-hmss-global
-            - qcom,sdm845-apss-shared
-            - qcom,sm6125-apcs-hmss-global
-            - qcom,sm8150-apss-shared
     then:
       properties:
         clocks:
@@ -124,6 +116,24 @@ allOf:
           items:
             - const: pll
             - const: xo
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,msm8994-apcs-kpss-global
+            - qcom,msm8996-apcs-hmss-global
+            - qcom,msm8998-apcs-hmss-global
+            - qcom,sc7180-apss-shared
+            - qcom,sdm660-apcs-hmss-global
+            - qcom,sdm845-apss-shared
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

