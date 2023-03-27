Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5746CA59C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjC0NYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjC0NX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:23:29 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D563755BF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:23:16 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y4so36244351edo.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679923395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7a67ZOiT2KfjiEjYrFPwDekMeNpv3czyvxhnWd0/zIc=;
        b=az4uIKb/12yPmBeHcyfAcgIIWW2EHltUAJIhxzSP2LxUgnKxodnLJlMfr08lDXYYBf
         TIxObZRbbhhYXnvX3rKCkZEVMl/orgmbb2f3ql54+XtIEddlhGAhAMbpKC10jiN6+bFt
         rGzSiWXy3WjZrYGiyMJ7xEpCc+7w+UzqUiVVYoaxcddwk62VaKeVo8tYjDJsw/ed5RA0
         bCmBrCiFMTcIP2KgqIGZvF9AgkPMxEXFTFjhOsG5bRAZx+oItfoVoehCuIc1o2J0VXjm
         TynKYCmRwN6DET4YN+FBFlt8vOk4bIs4fqPl9NQN0Fcst2itkWWA47ZoeluJDM+n6hK7
         gBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679923395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7a67ZOiT2KfjiEjYrFPwDekMeNpv3czyvxhnWd0/zIc=;
        b=Qqcq0t3Okgwlbz4M1gZRDo9dCdNccPS4kEyssXmOPSt0c2tVhiKSYTrlVGONiIIJAw
         fdWz91jJLjhTroq3NPuLHZuAkuWtNOZV7ZbCi85M5K3PqTSPomZoHNGEUxu3LWw5ggF2
         1XX3q43SUEOE0GYBPLJWvFbbX75nTn0jlXhU26ymtl5koQbSQs4d7owxIJZnRiLwJ3FQ
         QGJVemvaFCuR6HUkoUXZ3H7ptSjGxhHMpoNAceolSN7Mj9J2/92Z9rwV7BGM2tAWxfau
         vRKsfmbHicy1gZWOtDDqmdCFnJ2p8aT/WRE71G/1jNm+4GsDdlTLRF3Cp/lSdI/LVCOF
         wUIw==
X-Gm-Message-State: AAQBX9diesQq3McvH7kUXdYmoapAEDqmroBKbSqmPEqnavedWUZbzW93
        PCMovMWEy216riPHC2Oae+ivkA==
X-Google-Smtp-Source: AKy350YNqlH9FY7SJSed3F0rsVsq/wJy1/Z5BpFQat8+QvN7Il7dBiaXRWwqeI79HqLgfTTJY+ijMg==
X-Received: by 2002:a17:906:e0c6:b0:93b:a133:f7e6 with SMTP id gl6-20020a170906e0c600b0093ba133f7e6mr11457539ejb.46.1679923395297;
        Mon, 27 Mar 2023 06:23:15 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:581e:789c:7616:5ee])
        by smtp.gmail.com with ESMTPSA id gy24-20020a170906f25800b00930445428acsm14286814ejb.14.2023.03.27.06.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 06:23:15 -0700 (PDT)
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
Cc:     Patrick Lai <quic_plai@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 05/10] ASoC: dt-bindings: qcom,lpass-tx-macro: Add SM8550 TX macro
Date:   Mon, 27 Mar 2023 15:22:49 +0200
Message-Id: <20230327132254.147975-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327132254.147975-1-krzysztof.kozlowski@linaro.org>
References: <20230327132254.147975-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the TX macro codec on Qualcomm SM8550, which comes without NPL clock
exposed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/sound/qcom,lpass-tx-macro.yaml    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
index 768757cd077d..4156981fe02b 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
@@ -15,6 +15,7 @@ properties:
       - qcom,sc7280-lpass-tx-macro
       - qcom,sm8250-lpass-tx-macro
       - qcom,sm8450-lpass-tx-macro
+      - qcom,sm8550-lpass-tx-macro
       - qcom,sc8280xp-lpass-tx-macro
 
   reg:
@@ -96,6 +97,23 @@ allOf:
             - const: dcodec
             - const: fsgen
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm8550-lpass-tx-macro
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: mclk
+            - const: macro
+            - const: dcodec
+            - const: fsgen
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

