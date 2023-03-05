Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F04A6AB199
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 18:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCERfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 12:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCERfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 12:35:42 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328C314492
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 09:35:40 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g3so29692974eda.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 09:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678037738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zpJCYAT2evmQzO7iae4GDf1KIRspOlm4j2n0RWLvTq0=;
        b=oipBV0OMGWmhn6XgW/XqT9WkCCas2XH8tKnmLkkUOMnvJ4wFWZBAu0XS/ZCOVF44gS
         1zCB9YDrFktxhYsE0UHRCuRjkFDJ08CBjSJ5c85/xMknL2tw3sf3ej85H3MMUpVaxJf0
         AFx0ORWzDqtjT2CWZUcGfANU8PovIDds+iDiSmMUswQM1Kqgm8ARUZlb0kRhztl0fGWs
         o8aghC9YZYXDqikMiWcQpqNVXxQO8oLhUn4ISnGgloMieGLFe2WCEBqnetfOogcuUy2G
         suu4WFi766VuC/fMl/S+3NzDuAUY3Bb0jImdgJUHDFE0iovXvm2LrOV+MN98zXX4wjki
         A+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678037738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zpJCYAT2evmQzO7iae4GDf1KIRspOlm4j2n0RWLvTq0=;
        b=vvCM2+txH/3l4+yIA2qoQQt5cI0nMHtwv63/UDvCoxeoI0X0BcoIKBbHN5+TTO0PlW
         U2NOtuIZiXXzBAqT/8/7potkCP+osqNfdPLWLF8H6yaMfwOfseTInIGMlRpRfhxPTew+
         PYVh/ijIxDg2M2jKb16pGz+NJstTqLygEG693Vh0NOs/HYZJYeKB4Z7X9CcTzaOlJ1Ak
         K8Vy39BEu2DAOlQR/tNNvG7a6BGgQSCByi71ArKP88Nvzn/JhpRggIXLxNC4yNzi1ng2
         PSk/z4MniW6itGGBJfcF7m6PkmpYVkEyPNIB+FmOCw4dpyXxJOzGtrg0rteiAoUDaFUC
         ttZg==
X-Gm-Message-State: AO0yUKUD9/4chwg+lr19Zo81kNz1vFzqLeJ3xOTvMV4SJedhOy8FHcaB
        H0bXZBLTuzAsy9hO6hBfXcqgCuRm2VIeWwOHzdo=
X-Google-Smtp-Source: AK7set9NhERx/+zJ3EPO0pMZw89fz78igojTq5yrOKr9p8fzRprvOcFNYV+SRnHJypUo8nLyS2evqw==
X-Received: by 2002:a17:906:76c9:b0:8f5:2e0e:6dd4 with SMTP id q9-20020a17090676c900b008f52e0e6dd4mr7386176ejn.15.1678037738731;
        Sun, 05 Mar 2023 09:35:38 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:7000:1361:7f1f:60b0])
        by smtp.gmail.com with ESMTPSA id g26-20020a17090613da00b008d044ede804sm3385756ejc.163.2023.03.05.09.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 09:35:38 -0800 (PST)
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
        Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH] regulator: dt-bindings: qcom,rpmh: combine PM6150L and PM8150L if-then
Date:   Sun,  5 Mar 2023 18:35:35 +0100
Message-Id: <20230305173535.18046-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The supplies for PM6150L and PM8150L are the same, so they can be part
of one if-then block, for smaller code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Danila Tikhonov <danila@jiaxyga.com>
---
 .../regulator/qcom,rpmh-regulator.yaml         | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index fb9621b4b4cd..775ed2a1745e 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -144,6 +144,7 @@ allOf:
         compatible:
           enum:
             - qcom,pm6150l-rpmh-regulators
+            - qcom,pm8150l-rpmh-regulators
     then:
       properties:
         vdd-bob-supply:
@@ -244,23 +245,6 @@ allOf:
       patternProperties:
         "^vdd-s([1-9]|10)-supply$": true
 
-  - if:
-      properties:
-        compatible:
-          enum:
-            - qcom,pm8150l-rpmh-regulators
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

