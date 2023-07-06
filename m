Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EE2749C37
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjGFMoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGFMoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:44:32 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA761BD6;
        Thu,  6 Jul 2023 05:44:00 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99384a80af7so75649166b.2;
        Thu, 06 Jul 2023 05:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688647434; x=1691239434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8V9jbWrkBD6li8Ss0Ga4cRkbrGO/YOXZLHgGgY4Tpc=;
        b=MSfOoGUYb7hZtYlE44RKP1Ocb19TzdfgNykh+t35lAvd+VtyjkGdaemYADJ3FoXZCM
         etVzR0O0KEOJo7mrfSyG9mMFyBUybkaQdarVd+hv5+2w6XGXVtxDGpz+SQpxZwW3NVHH
         5KbJgEbg4oPt6DU49lteLc7PJ80ucVIExyFCLD5FAvoPwVQapWriEN6J5uuS2mgzBImP
         7D6n68qeF7igNP1cd65979TZMSUw3ga1WtOlwj1STjPsK4OZVFebcRXQ/jKs29KZmEox
         5tDjUT29AQCAEn0unug7p2Jfcheh+xfK/ijsMxI6vSPLmcZPmzICmvyP7p6N7unZHcLA
         bbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688647434; x=1691239434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8V9jbWrkBD6li8Ss0Ga4cRkbrGO/YOXZLHgGgY4Tpc=;
        b=IzYH5KMzlHbUzxXiDnA8T752ef+xowv+07SicxX7KzJaLokSAKmaBcbb2jRHzUSPS9
         BZgTk/oN6ASGLrDZgYTDGqrKi8U9bod9zif9JyRDMXWsO/xBvHyS6SZRHHe6REm41Gf4
         EOmDIq9+7peh8R9gIgFwTfdx+teSJj9xJCiRorQl969diGuMe+0MtYLFvEg/p6hODEYR
         jHmfTNkyEAEjF6cbWvfvTU/gg6sF02gcph6PZtXOmivGRgF8jBsgt9gbQu4QBfj0+qqx
         v0W10wCNoUWrc4UtJD/KS5bxL5FIKHtqeWZuy1BVkvk1AcAUjGdN+srAMqY7N3KfvD/Z
         iIDA==
X-Gm-Message-State: ABy/qLZzrr8LqTbAltxCI9iXQh182tTM9XftgVZb+C5wclxSDRtMtXIh
        N1UuOTylOUhmepM94TzZ1jg=
X-Google-Smtp-Source: APBJJlHauMP8NsjtzwndN9TJ8WC9k+JmQq4SW+wpJwc0UrWU/EnTICNk2gbbzdJgSH/BexjNZSiQzw==
X-Received: by 2002:a17:906:4ad2:b0:988:a986:b11c with SMTP id u18-20020a1709064ad200b00988a986b11cmr1174341ejt.29.1688647434272;
        Thu, 06 Jul 2023 05:43:54 -0700 (PDT)
Received: from david-ryuzu.fritz.box (ipbcc3a9b0.dynamic.kabel-deutschland.de. [188.195.169.176])
        by smtp.googlemail.com with ESMTPSA id w14-20020a170906b18e00b00992ca779f42sm775915ejy.97.2023.07.06.05.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 05:43:53 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        David Wronek <davidwronek@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/7] dt-bindings: arm: qcom: Document SM7125 and xiaomi,joyeuse board
Date:   Thu,  6 Jul 2023 14:40:22 +0200
Message-ID: <20230706124339.134272-4-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706124339.134272-1-davidwronek@gmail.com>
References: <20230706124339.134272-1-davidwronek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the xiaomi,joyeuse board based on the Qualcomm SM7125 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 450f616774e0..a403c433e9b5 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -77,6 +77,7 @@ description: |
         sm6125
         sm6350
         sm6375
+        sm7125
         sm7225
         sm8150
         sm8250
@@ -929,6 +930,11 @@ properties:
               - sony,pdx225
           - const: qcom,sm6375
 
+      - items:
+          - enum:
+              - xiaomi,joyeuse
+          - const: qcom,sm7125
+
       - items:
           - enum:
               - fairphone,fp4
@@ -1072,6 +1078,7 @@ allOf:
               - qcom,sm6115
               - qcom,sm6125
               - qcom,sm6350
+              - qcom,sm7125
               - qcom,sm7225
               - qcom,sm8150
               - qcom,sm8250
-- 
2.41.0

