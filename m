Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB486CFC28
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjC3HDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjC3HDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:03:50 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2E661AE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:03:48 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y15so23258537lfa.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680159826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b4Bb5GX+FMlQrfFYYOGtNxySJjTQGtWiEDeRjZZCDOc=;
        b=axOEcx2StVb58YNriRAGg9TE9X8Qyz/E81tNpwlLZio4996hAhzfrW736X8NP+UbYN
         5jEovPDXc6bUjOpzAWrPO0oHqdFWhtZW270LQkLxVYL/nFAJR0exUikcMyr9IPtcLvaO
         MgAnp3mEL9MfKZaRn1yWqCKB6ZMOIzqlRmnipXwVtv1/kUS4KfYl+YIPzv1cEOz7/4pU
         xZLM4xQ6CQOBjWe4akb42KEQOdAauFeuP7jnTSvyHw4Di7nQ6gbquhNZmsCLFgfSCqqV
         JdjbXEnYBRvC10parnWyUnl+Ba4BoHlZJG0JIp3TKyj7sFeU6o/K8YgX7J6vfURiouqI
         UAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680159826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4Bb5GX+FMlQrfFYYOGtNxySJjTQGtWiEDeRjZZCDOc=;
        b=z77wJBOld9OqcXDTOZ+bLO6pAGDvAXy5MnWvH9EESoFLvlI0HqPKF7AO0QLdS7F1qJ
         prHw+IttM7XKdnG5n92eGDNlPpmX8baff3zIVoz7SpHufggWNi5iAuDPEJ0J9f9Jb6Yu
         3UzppaDsypYiIVYsOzYfChZrWegQCXesPRFn2vF6FZYDQjXZc14Sy6P6dU41xSq7PEC3
         WjmmbtRq4wF2Gw+s7LYUkzLHEDkNrjagK6DYUCZIDaIpPQyHhkI3I9HccAdPdmr3Lf3n
         kIsvosA2jCDGC7nrXkqMN+RuDwtMDErAmhRiALyn08lHTlH864Y5oLjKWvkJ3OaAg1fc
         wCuQ==
X-Gm-Message-State: AAQBX9fO8sr2/3Gf1I0q0D/1wR+NqGzLywsPh29Ro1KOwFj7rkouN6HD
        tbsalIE5s4kGJtRg+Lj5OX+Jow==
X-Google-Smtp-Source: AKy350YZiokYUbkODadn+Xnup62W1KHlFr+bEB6GBWiAojf0zCSjvFeDAc1NaWwuJnOuIl4bmta8kw==
X-Received: by 2002:ac2:4c17:0:b0:4ea:f227:c1d6 with SMTP id t23-20020ac24c17000000b004eaf227c1d6mr6518049lfq.67.1680159826438;
        Thu, 30 Mar 2023 00:03:46 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q29-20020ac2511d000000b004eb09820adbsm2243637lfb.105.2023.03.30.00.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 00:03:46 -0700 (PDT)
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
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4] ASoC: dt-bindings: qcom,lpass-va-macro: Add missing NPL clock
Date:   Thu, 30 Mar 2023 09:03:42 +0200
Message-Id: <20230330070342.19448-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Several devices (e.g. SC8280XP and SM8450) expect a NPL (Near Pad Logic)
clock.  Add the clock and customize allowed clocks per each variant.
The clocks are also required by ADSP in all variants.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v3:
1. Only rebase. Other patches from this set were applied:
https://lore.kernel.org/all/168010864198.3244592.2114017565664183933.b4-ty@kernel.org/

Changes since v1:
1. New patch.
---
 .../bindings/sound/qcom,lpass-va-macro.yaml   | 68 ++++++++++++++++---
 1 file changed, 57 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
index 608207152a02..4a56108c444b 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
@@ -9,9 +9,6 @@ title: LPASS(Low Power Audio Subsystem) VA Macro audio codec
 maintainers:
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
-allOf:
-  - $ref: dai-common.yaml#
-
 properties:
   compatible:
     enum:
@@ -31,16 +28,12 @@ properties:
     const: 0
 
   clocks:
-    maxItems: 3
+    minItems: 1
+    maxItems: 4
 
   clock-names:
-    oneOf:
-      - items:   # for ADSP based platforms
-          - const: mclk
-          - const: macro
-          - const: dcodec
-      - items:   # for ADSP bypass based platforms
-          - const: mclk
+    minItems: 1
+    maxItems: 4
 
   clock-output-names:
     maxItems: 1
@@ -64,6 +57,59 @@ required:
   - compatible
   - reg
   - "#sound-dai-cells"
+  - clock-names
+  - clocks
+
+allOf:
+  - $ref: dai-common.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,sc7280-lpass-va-macro
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          items:
+            - const: mclk
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,sm8250-lpass-va-macro
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
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8280xp-lpass-va-macro
+              - qcom,sm8450-lpass-va-macro
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
+            - const: npl
 
   - if:
       properties:
-- 
2.34.1

