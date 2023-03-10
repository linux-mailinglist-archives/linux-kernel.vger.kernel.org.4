Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5223E6B403C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCJNWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjCJNWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:22:31 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4B8FEF20
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 05:22:08 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id o12so20317915edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 05:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678454528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QzRJBCNcVjpu9L/kbF+2hC2cCPihdtDKgQqCKfLkPA=;
        b=EcdkKLJy1nTwum3RcqOoQuWYwXOTfdJDBoXZoGlsPRz+RQifnrYVz1k/AIC2yTH3kP
         PAnmohk20qiWOFcy52MPyBSEA3vRZhnu8a5EeLBWp2HO/jdushRsRoeblC62wseZHmj2
         AM/FT1KNCO8+4297rMkrfXyiFq51CbIERRp9royKeNIyfQ+C9mfQC2zjKXJoZFZdkfsk
         uLacUsy4mT9wFeo+mkYzixlOb05jWpBvrwxzbXGfg9BDanjJTT0Xm7Ze0FRkU6eX0u0K
         fe5zG01Nf/6Z/JRGzEapBHPsrftvvqUAcHyubUDAYc7IcugdLCH/6n4nGKfmVrRZFHTY
         02LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678454528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QzRJBCNcVjpu9L/kbF+2hC2cCPihdtDKgQqCKfLkPA=;
        b=U+xkEuuYJzNkz0rHaO0k/n+2MjHQTnV6QQiNYDkz3heZKnUO9N8SbekT4gn8fKMaby
         YGocsdpPC7jQmfGmvfODhZVtM9zoKHHGpB/J9+Q4r4ZKiMokOARTDl+3cMgxbYUMw3ML
         GlAjFTu/jxP3oiZKdS+MPohlNPJdo+Zae5bSN/BUJg6jd5azUri+Wdn0t5CqSgta/R+9
         OPESKaukclg1/8PNtZgd5KdT3wHWxOEfLT5IonlB4nbmSS/1rrK6xj4KGe2Tc3QmUzVK
         Kl5BI1wxwLQ5iUPB3dAlqalC5mYQzcBJ3u1VNJpbhRAU4p64DWPDla7IByssSrs/4LlO
         I6Nw==
X-Gm-Message-State: AO0yUKVh8KmJupshaw89Pw9pA7KbFS2VK/1lCMkZ41jmM9NDmQ7ZfKLW
        Bs+PFgsinGdSIZOAz7XORpzcFQ==
X-Google-Smtp-Source: AK7set99KdhfosHhNhcHm7ZbsjvUuuCLY5QJ01+eSjocVmVnePPGrExvdnFHezzFcBtWwDhU9Pon7g==
X-Received: by 2002:a17:907:787:b0:8b1:7de3:cfb0 with SMTP id xd7-20020a170907078700b008b17de3cfb0mr32023701ejb.2.1678454528466;
        Fri, 10 Mar 2023 05:22:08 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:45c4:46be:ec71:4a51])
        by smtp.gmail.com with ESMTPSA id zc4-20020a170906988400b008b17879ec95sm959124ejb.22.2023.03.10.05.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 05:22:08 -0800 (PST)
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
Subject: [PATCH 4/9] ASoC: dt-bindings: qcom,lpass-tx-macro: narrow clocks per variants
Date:   Fri, 10 Mar 2023 14:21:56 +0100
Message-Id: <20230310132201.322148-5-krzysztof.kozlowski@linaro.org>
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

Currently the Qualcomm TX macro codec binding allows two different clock
setups - with (for ADSP) and without macro/dcodec entries (for ADSP
bypassed).  With more devices coming soon, this will keep growing, thus
rework the clocks/clock-names to be specific for each binding.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/sound/qcom,lpass-tx-macro.yaml   | 63 ++++++++++++++-----
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
index da5f70910da5..559da2509d8d 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
@@ -9,9 +9,6 @@ title: LPASS(Low Power Audio Subsystem) TX Macro audio codec
 maintainers:
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
-allOf:
-  - $ref: dai-common.yaml#
-
 properties:
   compatible:
     enum:
@@ -30,22 +27,12 @@ properties:
     const: 0
 
   clocks:
-    oneOf:
-      - maxItems: 3
-      - maxItems: 5
+    minItems: 3
+    maxItems: 5
 
   clock-names:
-    oneOf:
-      - items:   #for ADSP based platforms
-          - const: mclk
-          - const: npl
-          - const: macro
-          - const: dcodec
-          - const: fsgen
-      - items:   #for ADSP bypass based platforms
-          - const: mclk
-          - const: npl
-          - const: fsgen
+    minItems: 3
+    maxItems: 5
 
   clock-output-names:
     maxItems: 1
@@ -67,6 +54,48 @@ required:
   - reg
   - "#sound-dai-cells"
 
+allOf:
+  - $ref: dai-common.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sc7280-lpass-tx-macro
+    then:
+      properties:
+        clock-names:
+          oneOf:
+            - items:   #for ADSP based platforms
+                - const: mclk
+                - const: npl
+                - const: macro
+                - const: dcodec
+                - const: fsgen
+            - items:   #for ADSP bypass based platforms
+                - const: mclk
+                - const: npl
+                - const: fsgen
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sc8280xp-lpass-tx-macro
+            - qcom,sm8250-lpass-tx-macro
+            - qcom,sm8450-lpass-tx-macro
+    then:
+      properties:
+        clocks:
+          minItems: 5
+          maxItems: 5
+        clock-names:
+          items:
+            - const: mclk
+            - const: npl
+            - const: macro
+            - const: dcodec
+            - const: fsgen
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

