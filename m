Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790A76B404D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjCJNXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjCJNWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:22:33 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0100C1009E3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 05:22:11 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x3so20274838edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 05:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678454531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goKtutnQ2PFd8NfCZ2pE04cCvKUKzYAaQ26RIq4NWcQ=;
        b=RER2Rx5gJ5R+wduk0rXzfE5ryA2rbohjb7XXb5g/kkl2V2gOITdv2x91WBUBe7GyZu
         gzQbl+KyFVnkjtsfyt9c8aTcZ18c1l+o5RLpBbGD68Ni62VRCbISEs5sNNCcsi+36g4f
         2vVyUQ1J6lHFysa2mx7T/qGJ+l0ANCp4QCkyc0QDHgTG5l7m32OikC7JGiDQLVYgfyCH
         XjJe4M3wPRViScfkziAQb7/3RSrIi3jjT8TWv2XSG1eOnKcUU5ncO7NE6gh93BC8K+lC
         CFJiG/yjDHOOGiz9uglm9l8ev1HtlL2Y2sK6FaFJcbDq30igz/dR79IR18o3dXzc3Ke9
         /7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678454531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goKtutnQ2PFd8NfCZ2pE04cCvKUKzYAaQ26RIq4NWcQ=;
        b=bTXpYK3aZaeOpInnsDf+Ps3nvY/UU9K844tIhxjbYo+b0TH+fgINWPvB1xRN1Hc1AU
         g5FFMbD1dlgYjRcSBHFWBwwvKrAkxEghQGL+0Kwsu+riSj36jCBs5IChcwVyFwTaYdBo
         3q8/T0Qy2urZlZ1+ItNW+buaBEQfDE+fei66LKRpD7JZ6a936aDOBvMZOWNh4NUoXIf/
         QOFFM+R6se5zyfEEoSR+EzLbW44bDPT/qKO05tWF2RLyOA1Q+PDcTKpiFR0EQBuRDETV
         Rfo9nNObaVlgGD/FazPJNf0Wls6bdk68B/BoGK2cca/tgQ84YyFBgQnpt0ZZmKvCDdC5
         Iydg==
X-Gm-Message-State: AO0yUKXxKEXXz3ZuNHnHq9A3YFDz+iJ4xNuNSlA9c2tVUvIlbdlAr74z
        GIGe9J28TNyKcaSSvYjEkn46Tg==
X-Google-Smtp-Source: AK7set/7m+fKbY/1jI+CUKTq8FToiMZNX8tVAOxvsseLOOiw8ysUD1u+jkKI1OdVBofqe2vcOObR+g==
X-Received: by 2002:a17:906:1ed1:b0:8e9:6f9f:7c2d with SMTP id m17-20020a1709061ed100b008e96f9f7c2dmr1874600ejj.35.1678454531631;
        Fri, 10 Mar 2023 05:22:11 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:45c4:46be:ec71:4a51])
        by smtp.gmail.com with ESMTPSA id zc4-20020a170906988400b008b17879ec95sm959124ejb.22.2023.03.10.05.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 05:22:11 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 7/9] ASoC: dt-bindings: qcom,lpass-va-macro: Add SM8550 VA macro
Date:   Fri, 10 Mar 2023 14:21:59 +0100
Message-Id: <20230310132201.322148-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310132201.322148-1-krzysztof.kozlowski@linaro.org>
References: <20230310132201.322148-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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

