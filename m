Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071E06B70AB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCMH6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjCMH4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:56:50 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B4E23336
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 00:55:12 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id cn21so14737152edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 00:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678694097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goKtutnQ2PFd8NfCZ2pE04cCvKUKzYAaQ26RIq4NWcQ=;
        b=CIJu2IscgcPZmgKaSTO8lOm6S+NIgoh4wZI6BpVbH51qVwz+f7WDUAZymEML4EAEzR
         V6P+T7sj9tBrjvcu5BIbp7/+hva8nP8/4HwdNpa03eUU1jCoTIQ6pSuiDkTC9OeG4Zq7
         cdEJTXfNDxiWc9Xn1E4Pbl37APwDM3KelQUJju3HXy0WqOhRHDTWEP4cY9hKeHx4v1HL
         MZLMV07zKtQZSdpx96n6AvXKdKljlAFT/p5LZFhFnt2JNYHjkXIImT/xLhXIb+LGLt0Z
         C8+4KR53IZT3C37NjDjMU7rxY8QRLdI/nnGipqv0iITglfY3oAIuQZVmzd2kEIx99UQV
         degg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678694097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goKtutnQ2PFd8NfCZ2pE04cCvKUKzYAaQ26RIq4NWcQ=;
        b=aINjSjejO2O0yUfttkP58UvleZICd8+q/gubPnFsq6op2f4LHO1R7wNoITyGQGyw+U
         gZzffjJhXZFkoVOyi7le5DU2Q+0FFT4fg2sFH7FV7xdzn/gLoK94nG9CBuQOfJybiJUW
         lk0RCJcn+HqEuQoNmyqpQiTMS/LLxtg7Bazso1Xkj8IxsCG/GwrM4XVnY2TkpBQFgH7Z
         Df57y9hmKbv0+mKRnoHZpKayj1mpMR0qFShs65L477k5p84CpDwzrlLueMg/XF+7xsib
         WoVIvz5w9wtZVfifMo97G5zsS0endqfuXX1ifDPt/kOIIsRzvwpKYLbQSr12uxpwO3fU
         ROUw==
X-Gm-Message-State: AO0yUKVK38SLZwTeMftV5JuZacjSimG3rbKSVqxnETSghvo4l1icDIqm
        Qa81R2wkqe9+8Bpq6hZy3fjUrg==
X-Google-Smtp-Source: AK7set/Shhtvx7F/zCzjDPFGf/qLGk39vBzVS7puQJx+tO0nnNGWvuz+HfqAg6dwNep2pDdAXQuoVg==
X-Received: by 2002:a17:907:7a86:b0:91f:f1b7:3673 with SMTP id mm6-20020a1709077a8600b0091ff1b73673mr7351226ejc.15.1678694097690;
        Mon, 13 Mar 2023 00:54:57 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:f052:f15:3f90:fcb3])
        by smtp.gmail.com with ESMTPSA id g7-20020a1709061c8700b008b980c3e013sm3146943ejh.179.2023.03.13.00.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 00:54:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 7/9] ASoC: dt-bindings: qcom,lpass-va-macro: Add SM8550 VA macro
Date:   Mon, 13 Mar 2023 08:54:43 +0100
Message-Id: <20230313075445.17160-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313075445.17160-1-krzysztof.kozlowski@linaro.org>
References: <20230313075445.17160-1-krzysztof.kozlowski@linaro.org>
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

Add the VA macro codec on Qualcomm SM8550, which comes without NPL clock
exposed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on:
https://lore.kernel.org/r/20221118071849.25506-2-srinivas.kandagatla@linaro.org
---
 .../bindings/sound/qcom,lpass-va-macro.yaml    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
index 528b677a439c..4a56108c444b 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
@@ -15,6 +15,7 @@ properties:
       - qcom,sc7280-lpass-va-macro
       - qcom,sm8250-lpass-va-macro
       - qcom,sm8450-lpass-va-macro
+      - qcom,sm8550-lpass-va-macro
       - qcom,sc8280xp-lpass-va-macro
 
   reg:
@@ -110,6 +111,23 @@ allOf:
             - const: dcodec
             - const: npl
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8550-lpass-va-macro
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: mclk
+            - const: macro
+            - const: dcodec
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

