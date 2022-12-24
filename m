Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3318B655A87
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 16:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiLXPmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 10:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiLXPmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 10:42:17 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4362D2E3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 07:42:15 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b3so10732112lfv.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 07:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5CHbg+8b24jKcyqMjIgkeB+fm8k5OGLCytCdmtDF84=;
        b=Tu4Cn/+Bfo24LQKjYhx6hQjfaVH2XkiYAWLSLXtJzX51Hf9SJ3RuYQDdDX4ttZJ1T2
         e94Bb3HuIYU9MnvWYHSIWuuMHizHj7YlM32orCoG7rrCnkvXO3jg4UsNix7Ote/aJyxa
         jdq6uLohW+SHjtZLH9c1WuZpXC0m4viJVRE8+NFSYTZD7o2qy62Ow4d9L0CMsp+MUKox
         jL1jqVQWyD36UA7tI4YZnOMaS5iRCkvfwLrYY/Zoo4YR4r0DTjK5xO/z5HMHZVq4EOSU
         5YMci66YvKAY/1SbEtp00YrilTS3Rj3Pt+Vj8uvgq/jrO56mttgnTp6oIphvKmqJWa0e
         vWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5CHbg+8b24jKcyqMjIgkeB+fm8k5OGLCytCdmtDF84=;
        b=h9FBWmrzQFK4qEer3WyxQZXr21s0ZhxUAvl5BT0DXVaF/PsoXXNJbNHQDZiCk1M184
         Y1bjMZ1ytzdTOQt6ezdW94SKf1CwPn3t2SIPN71say2XDe9B/9Ze3aXYasXJGGtXpt9v
         TW9e0IPK25pCDVIcpOrJB9ii8UE5g5wenST3SYDxAHU5UeZYojLTmg0Ao7ad29AkghdP
         9XR5RZY4LAOv/wEdySY0Pwdj0Lf72vlfYYg+CYG5MXXeVPsNXkfbKdsNmYcWQmrW/Ksf
         2x0JWJVZZmKurJuOBDimylNBjtVtwfnh2evYgvWOjFy+733gTqq1d0WFngk9uLnW1Itr
         xA5g==
X-Gm-Message-State: AFqh2ko7sfehYtlvDuuEFS9ZxJzc4bnqEzcNIKi4Az02kybPhIylxzfU
        Brt8OouFHLcwdAjSeAhOdSWveQ==
X-Google-Smtp-Source: AMrXdXtwLkq5JjJtX7uA0W5OuWnCMwaKAklXGhAKpIPUbnZS/ecaOwe4cZr6IggAtCbXCFd9FNqITw==
X-Received: by 2002:a05:6512:1582:b0:4b6:e494:a98d with SMTP id bp2-20020a056512158200b004b6e494a98dmr4545398lfb.44.1671896534235;
        Sat, 24 Dec 2022 07:42:14 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c14-20020ac25f6e000000b004b5821219fbsm987035lfc.60.2022.12.24.07.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Dec 2022 07:42:13 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ASoC: dt-bindings: cirrus,cs35l41: cleanup $ref and example
Date:   Sat, 24 Dec 2022 16:42:10 +0100
Message-Id: <20221224154210.43356-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221224154210.43356-1-krzysztof.kozlowski@linaro.org>
References: <20221224154210.43356-1-krzysztof.kozlowski@linaro.org>
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

Non-functional cleanup:
1. Drop unneeded quotes form $ref,
2. Example: Use generic node name, use define for GPIO flag, adjust
   indentation to consistent 4-space style.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/sound/cirrus,cs35l41.yaml        | 40 ++++++++++---------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
index 919d7f16f24c..18fb471aa891 100644
--- a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
@@ -45,7 +45,7 @@ properties:
       Configures the peak current by monitoring the current through the boost FET.
       Range starts at 1600 mA and goes to a maximum of 4500 mA with increments
       of 50 mA. See section 4.3.6 of the datasheet for details.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 1600
     maximum: 4500
     default: 4500
@@ -54,7 +54,7 @@ properties:
     description:
       Boost inductor value, expressed in nH. Valid
       values include 1000, 1200, 1500 and 2200.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 1000
     maximum: 2200
 
@@ -63,7 +63,7 @@ properties:
       Total equivalent boost capacitance on the VBST
       and VAMP pins, derated at 11 volts DC. The value must be rounded to the
       nearest integer and expressed in uF.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
 
   cirrus,asp-sdout-hiz:
     description:
@@ -73,7 +73,7 @@ properties:
       1 = Hi-Z during unused slots but logic 0 while all transmit channels disabled
       2 = (Default) Logic 0 during unused slots, but Hi-Z while all transmit channels disabled
       3 = Hi-Z during unused slots and while all transmit channels disabled
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 3
     default: 2
@@ -87,7 +87,7 @@ properties:
       enable boost voltage.
       0 = Internal Boost
       1 = External Boost
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 1
 
@@ -112,7 +112,7 @@ properties:
       1 = GPIO
       2 = Sync
       3 = MCLK input
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 3
 
@@ -139,7 +139,7 @@ properties:
       3 = MCLK input
       4 = Push-pull INTB (active low)
       5 = Push-pull INT (active high)
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 5
 
@@ -179,21 +179,23 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
+
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
 
-        cs35l41: cs35l41@2 {
-          #sound-dai-cells = <1>;
-          compatible = "cirrus,cs35l41";
-          reg = <2>;
-          VA-supply = <&dummy_vreg>;
-          VP-supply = <&dummy_vreg>;
-          reset-gpios = <&gpio 110 0>;
-
-          cirrus,boost-type = <0>;
-          cirrus,boost-peak-milliamp = <4500>;
-          cirrus,boost-ind-nanohenry = <1000>;
-          cirrus,boost-cap-microfarad = <15>;
+        cs35l41: speaker-amp@2 {
+            #sound-dai-cells = <1>;
+            compatible = "cirrus,cs35l41";
+            reg = <2>;
+            VA-supply = <&dummy_vreg>;
+            VP-supply = <&dummy_vreg>;
+            reset-gpios = <&gpio 110 GPIO_ACTIVE_HIGH>;
+
+            cirrus,boost-type = <0>;
+            cirrus,boost-peak-milliamp = <4500>;
+            cirrus,boost-ind-nanohenry = <1000>;
+            cirrus,boost-cap-microfarad = <15>;
         };
     };
-- 
2.34.1

