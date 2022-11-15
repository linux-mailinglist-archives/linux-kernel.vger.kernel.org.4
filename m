Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCB8629688
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbiKOK61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbiKOK5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:57:49 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B765F86
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:56:00 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id t4so9389838wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCi7YFy2fjbBE3WEf3zcS1kGXNt63J9q4Tgiqiwur08=;
        b=d2snvaMp96sDrYHfndctd8uvR2posqG3lOgKLGpu8H38Gs46hOBPPnJkWcCwKXdPD2
         NSNTvr7gwRTLab2w2L57LA76aluuMFKthfckaCkDazbgZtkhoNWS6zrt6Cx/MH9+R1q9
         Lvx7Hz6cd3nBqi62rFoGeaaC6UYhvMdpQqPG0bLO9Z17a78LkfnSys2ZCtOnxmUnP16r
         ZnnTJESLFwNMoZs1ZF+ocEDQBbp0ukiV2EXLpK/rGSLBaCp8ctOaQg7HEajNCtEeDCZr
         caO2OyjV5qF9ColI0fUiyE2D4QaV8ASpriwjIr4Q/giiRzU1NaLZ0Wn4bC9p870qdyMX
         ZHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCi7YFy2fjbBE3WEf3zcS1kGXNt63J9q4Tgiqiwur08=;
        b=jwcsPx2CPZ8lk88/QtjygGJGEwbi7OB1CqoSkkhSZEzLuDmnLUq0ePLBZf34Wfj91l
         P9/eDJxC2O1bj+nZ5pZJcZCHsXqz9zKhNsQP93QGXMPfGQwKgWXcV+oZajwyJHywewEB
         iEFo9c/GqXb+HCc+csM8/AAXkYzQvXN7Iv5V9vJPDk+OBJiunngLQ7X8Sw5Ia4YLRAxn
         /BO+Jh9qWtmuE+aBvFi+lOcm4IwAG3h0Pp7MQQIo0v0LRvrhg9YZcxgh3vmfVGULQUcn
         U2XKY7L2PZE4OmcBDtNPrIlTS2HhVsweM7k1iYJu+2M2kwl9l2ZOJzRrovSrLgwQR/71
         p6zg==
X-Gm-Message-State: ANoB5plOQ8uIvoPCIYxQ4FPg+1jAc5DSeJfOr6yUFv0WGwhHXGM2COTf
        evHAiLHdD8vQlTOwAL01uv/BsA==
X-Google-Smtp-Source: AA0mqf7dHxz7sn1ZpVdYHHEUGbzqS80S0bgteW5WYyL8drX0zBxNtZAfHdQDJNKkkT8Iaiq1PVS4yA==
X-Received: by 2002:a05:600c:1f0d:b0:3cf:7556:a592 with SMTP id bd13-20020a05600c1f0d00b003cf7556a592mr1004863wmb.199.1668509759244;
        Tue, 15 Nov 2022 02:55:59 -0800 (PST)
Received: from localhost.localdomain ([185.201.60.217])
        by smtp.gmail.com with ESMTPSA id r18-20020adfe692000000b00238df11940fsm12185046wrm.16.2022.11.15.02.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 02:55:58 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] ASoC: dt-bindings: lpass-va: add npl clock for new VA macro
Date:   Tue, 15 Nov 2022 10:55:40 +0000
Message-Id: <20221115105541.16322-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221115105541.16322-1-srinivas.kandagatla@linaro.org>
References: <20221115105541.16322-1-srinivas.kandagatla@linaro.org>
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

LPASS VA Macro now has soundwire master to deal with access to
analog mic in low power island use cases. This also means that VA macro
now needs to get hold of the npl clock too. Add clock bindings required
for this.

As part of adding this bindings, also update bindings to be able to
specific and associate the clock names specific to the SoC.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/sound/qcom,lpass-va-macro.yaml   | 72 ++++++++++++++++---
 1 file changed, 64 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
index c36caf90b837..848e34111df1 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
@@ -27,16 +27,13 @@ properties:
     const: 0
 
   clocks:
-    maxItems: 3
+    minItems: 1
+    maxItems: 4
+
 
   clock-names:
-    oneOf:
-      - items:   #for ADSP based platforms
-          - const: mclk
-          - const: core
-          - const: dcodec
-      - items:   #for ADSP bypass based platforms
-          - const: mclk
+    minItems: 1
+    maxItems: 4
 
   clock-output-names:
     maxItems: 1
@@ -61,6 +58,65 @@ required:
   - reg
   - "#sound-dai-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,sc7280-lpass-va-macro
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 1
+        clock-names:
+          items:
+            - const: mclk
+      required:
+        - clock-names
+        - clocks
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
+            - const: core
+            - const: dcodec
+      required:
+        - clock-names
+        - clocks
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
+            - const: npl
+            - const: core
+            - const: dcodec
+      required:
+        - clock-names
+        - clocks
+
 additionalProperties: false
 
 examples:
-- 
2.25.1

