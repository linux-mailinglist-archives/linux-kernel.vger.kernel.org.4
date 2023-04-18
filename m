Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CF56E5A41
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjDRHRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjDRHRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:17:41 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3897A2123
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:17:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sz19so13577943ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681802258; x=1684394258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2L60ppviJ/50vCdK5BbqTY67oH9XUAxCh8grDDMg/4o=;
        b=tn07g4Rx+XejhP3OQVZ4MisHY1szBRWs1+dke/23ZxejY+2eA/S0bvzT7QIOpfzC6H
         f4ax5DQwet6V8XdlFjOg8cU5v0WNXv613fswvkWl3NM8zwI46lYP+8dv5jG6p8/CfzwZ
         oCZLbesvDVpCL5qqavREJ+fxMhmcKEPRWp0wSZFYJMV7/KfBO3j9pm2vLrSnKBe0xydo
         6r5YqYuYUBE6+3ZKvnbVp+D79Kirjw1wZ3AwyLr5+mTwvmiLcW1XEkDwl1UenALA8piI
         T4eGbPch0hufmFXSoK8uk6PD51LZheJIqbJqdPPO1iuNIvFAr4tbO28ZIzGqZ5FtLC72
         uUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681802258; x=1684394258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2L60ppviJ/50vCdK5BbqTY67oH9XUAxCh8grDDMg/4o=;
        b=RBVf9Cj03Isop7ap3CqrRAoJw9OX7V/jq9pExwGbECca4JoQhdqiweqjW6u1+/NDR+
         YcXk1XAKU7s4uYwyWbME14tGSLZi1MbB1zQv6zYFsMHTwNuEzPUyabZQWiw38XU0GycJ
         0CvnsbaESR975k7epnp2vzUUKj1tTfjVFZXOmuA7wz3tg5KAwUthfyLxhvNZJyVE74uX
         9vy4V5zqJXBgUJU9wF0opS/StGj/L+CuW2QzM4NV/xHNpyA4jxRBV6qxol/nx9aFsYBp
         euF/oPvRMssiAiHdbZ5AdORgctoJYfMYllAtnLmo952bPMAsaQ9WQh+bK27oMLXNyEYU
         HI/g==
X-Gm-Message-State: AAQBX9fweTISbBJNPvOQfjGimt1ikfGTfJ60zM6OUAyU950J+fPP7R0M
        7zjx5lOkgbmf8SKoTvKZaLL36Q==
X-Google-Smtp-Source: AKy350bAkWVl+XYvxmriffnnb74UY1uIU97uVqnXr+WVguAl9Pts7pqYHINrsGBnvP5Bw/Ypam3jgQ==
X-Received: by 2002:a17:906:1c12:b0:94a:6a7a:52d8 with SMTP id k18-20020a1709061c1200b0094a6a7a52d8mr8584928ejg.71.1681802258652;
        Tue, 18 Apr 2023 00:17:38 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id j19-20020a50ed13000000b00504ecc4fa96sm6641814eds.95.2023.04.18.00.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 00:17:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Danila Tikhonov <danila@jiaxyga.com>
Subject: [RESEND PATCH 2/2] regulator: dt-bindings: qcom,rpmh: Combine PM6150L and PM8150L if-then
Date:   Tue, 18 Apr 2023 09:17:34 +0200
Message-Id: <20230418071734.5706-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418071734.5706-1-krzysztof.kozlowski@linaro.org>
References: <20230418071734.5706-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The supplies for PM6150L and PM8150L are the same, so they can be part
of one if-then block, for smaller code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Cc: Danila Tikhonov <danila@jiaxyga.com>

Resending rebased patch. No other changes, except context.
---
 .../regulator/qcom,rpmh-regulator.yaml        | 20 ++-----------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 5f9ae89a220d..b9498504ad79 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -147,6 +147,8 @@ allOf:
         compatible:
           enum:
             - qcom,pm6150l-rpmh-regulators
+            - qcom,pm8150l-rpmh-regulators
+            - qcom,pmc8180c-rpmh-regulators
     then:
       properties:
         vdd-bob-supply:
@@ -264,24 +266,6 @@ allOf:
       patternProperties:
         "^vdd-s[1-9]-supply$": true
 
-  - if:
-      properties:
-        compatible:
-          enum:
-            - qcom,pm8150l-rpmh-regulators
-            - qcom,pmc8180c-rpmh-regulators
-    then:
-      properties:
-        vdd-bob-supply:
-          description: BOB regulator parent supply phandle.
-        vdd-l1-l8-supply: true
-        vdd-l2-l3-supply: true
-        vdd-l4-l5-l6-supply: true
-        vdd-l7-l11-supply: true
-        vdd-l9-l10-supply: true
-      patternProperties:
-        "^vdd-s[1-8]-supply$": true
-
   - if:
       properties:
         compatible:
-- 
2.34.1

