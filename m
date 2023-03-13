Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9006B70A8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjCMH6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCMH4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:56:50 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3624129439
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 00:55:14 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x3so44852177edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 00:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678694099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZM2NPsZ49ia+Dqe6wkMeZpgWpRvBEKr1bmuDVGwMmU=;
        b=PuuKK426W4imrwcVdY2+9oec5UOV7dMbuPit+w09Q5znpU3IvnzN31Md9Jt84L3yRS
         qHPHUvh3ZoTJBYGGv6FbQlLSOjRFXfkXVO5SltxbeVBxlIV9Y2+en8X9iLuW7cYkbt/J
         CZY0anSrcerNb0evrSZ5m2L2jdiAm/CwWnJP8GYxPDHtvO5ypw5+xtUyxPx9tJzEg04+
         2p0HKI4GlxvIrgPOlXonZyBsWvcneKOEIuEdIXkzI6EUUNzmfld0SolHsLCLG7gNa/xc
         /o/4fUs4R9PplJSeh2FROUvJMN8N5Xh7jQz+IBD1hfNvK7pFFKabTx1pJzrLs70M31UH
         dY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678694099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZM2NPsZ49ia+Dqe6wkMeZpgWpRvBEKr1bmuDVGwMmU=;
        b=Dbo3KDWWs8ci2bYNH7VmZaTYFBOEklur3Dv+d4kqY8hIF3ZvkiAzy0CA3a317axRMY
         S3BAUfQT6kTcvKpEnSSR27sVBdevaH5UeRlRCKhywm8oPNO+0ZzVWB5sbMcEK3oUaoi2
         JtoJ16W7sMHTqPbgNFE1pR1mx9W+J9l7ktUblV8FJrrdveb8Fdz7hXkif6W54DimwTfJ
         S84u7/9SyOayzyj6AV552x9NYUJteDwwQNXMKD1+M6WZ9v4XoK/dvXVOVnjq+mv7iXIK
         6vi+r0pTnpqhx6Lh4gYM8zfXPY3euh0Ss+JVe1SuAJ+UGMYPUpCGK2brENJJiZ37XvuC
         /+6Q==
X-Gm-Message-State: AO0yUKWCr5x0EWDOvWmi945usJ6xGNFyV8g7bNfnH2Y24WSd+x2vT/0P
        +dxvQCQ/EC7yk47KBKGR8Y0yEQ==
X-Google-Smtp-Source: AK7set/ICSE0O0CNa7vtYNTO3uo0GeeelaS/IRUydnhV6hPEiui9VXdhuM6fAUeREn+KKFTmps6wvg==
X-Received: by 2002:a17:907:1b1b:b0:92a:abe7:a9fe with SMTP id mp27-20020a1709071b1b00b0092aabe7a9femr1671996ejc.74.1678694099110;
        Mon, 13 Mar 2023 00:54:59 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:f052:f15:3f90:fcb3])
        by smtp.gmail.com with ESMTPSA id g7-20020a1709061c8700b008b980c3e013sm3146943ejh.179.2023.03.13.00.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 00:54:58 -0700 (PDT)
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
Subject: [PATCH v2 8/9] ASoC: dt-bindings: qcom,lpass-wsa-macro: Add SM8550 WSA macro
Date:   Mon, 13 Mar 2023 08:54:44 +0100
Message-Id: <20230313075445.17160-8-krzysztof.kozlowski@linaro.org>
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

Add the WSA macro codec on Qualcomm SM8550, which comes without NPL clock
exposed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/sound/qcom,lpass-wsa-macro.yaml  | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
index 66cbb1f5e31a..eea7609d1b33 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
@@ -15,6 +15,7 @@ properties:
       - qcom,sc7280-lpass-wsa-macro
       - qcom,sm8250-lpass-wsa-macro
       - qcom,sm8450-lpass-wsa-macro
+      - qcom,sm8550-lpass-wsa-macro
       - qcom,sc8280xp-lpass-wsa-macro
 
   reg:
@@ -27,11 +28,11 @@ properties:
     const: 0
 
   clocks:
-    minItems: 5
+    minItems: 4
     maxItems: 6
 
   clock-names:
-    minItems: 5
+    minItems: 4
     maxItems: 6
 
   clock-output-names:
@@ -62,6 +63,7 @@ allOf:
     then:
       properties:
         clocks:
+          minItems: 5
           maxItems: 5
         clock-names:
           items:
@@ -89,6 +91,23 @@ allOf:
             - const: va
             - const: fsgen
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm8550-lpass-wsa-macro
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

