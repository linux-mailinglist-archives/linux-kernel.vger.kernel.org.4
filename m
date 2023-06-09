Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0118A729C5B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240976AbjFIOJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240954AbjFIOIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:08:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01363AB7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:08:14 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5149c76f4dbso3203609a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686319669; x=1688911669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qb0ZFzAhhK+erW7LJP2wxkzkSRjZwcO8zreCGJicNFw=;
        b=g0IAe/XKTBIdzkRWIKTXMHHY4xvxoph0Yho8VHmmcTHZv9MXFFyKoIfbpBKD9YHxIf
         MsBrgujXVELr8R+pC8ewFG3Yi9CFhEMmKpMz67eKFTa3AZFnvP0vVIncACRTPJ6C138n
         7f9/iQyGAq0L1B3iWek2pZqgaRzpjR3cnDSWANH2rnKDkXBURv5IRQ/Bm6L7EDzVzwDX
         f07thJF5H7vXcZ66rRE2WLus1NONw5Pu2f1EsKs5cXTtk4eDAUeQ3RBQ/Rw4rv2W2WVh
         hWU5cLTgqX4Ant73FnFEL6YsM40rnLZV51WOqVqq07nN3/bdParGhT3YXPaSIvDz6Is6
         mkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686319669; x=1688911669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qb0ZFzAhhK+erW7LJP2wxkzkSRjZwcO8zreCGJicNFw=;
        b=Q6raHKsjQBHzdgLhB+VenWB7tAcrIlxP7eWXheknzCvVggwB/uvBB7WBytEQjm6Hew
         +9wFpugnSAFbmqV7b1EbXbTRe/5s80whv9YtOg1Ak6gdP4Y3wTiDUlNMSBdOnysnCDU2
         SKd39iOo4xdKVgVwr3tKsbdqhEJrf4JffW1MJvMLTNtVm2oeTBOqHpXZC2clV3zqr5ps
         YSwxyqd0YIPWSvUcFPxZURbLu89Qgu6y0fNayKg2+NS/efTJXoQLHR3hzHuH3kH5S/Z1
         2ZuvaKOoGjUx1Ozp4ZZHHnWWZyBN9tiriFVl5jL4BvJlaYFU1ggl8+kSQm3o1JrO0AD1
         maAg==
X-Gm-Message-State: AC+VfDza1LMGe2Ms0jrMQZS8b7CYCi4dNK5NEJcJpI7aPVdHj6Lhqmb+
        A2LqhmVkNL5/VhrOjs9obDloNQ==
X-Google-Smtp-Source: ACHHUZ7+AMaHS+1ugJrL7maVJt9zzkeyqMobj7k+MK3bgJsaH56MLQu9BqRWzq+p0fAn87cIDLfCTg==
X-Received: by 2002:aa7:c48a:0:b0:514:9acd:7bc1 with SMTP id m10-20020aa7c48a000000b005149acd7bc1mr1414817edq.9.1686319669388;
        Fri, 09 Jun 2023 07:07:49 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id t1-20020aa7d701000000b005166779bfd2sm1833258edq.6.2023.06.09.07.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:07:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: mfd: brcm: drop unneeded quotes and use absolute /schemas path
Date:   Fri,  9 Jun 2023 16:07:47 +0200
Message-Id: <20230609140747.65074-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.  Also absolute path
starting with /schemas is preferred.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/mfd/brcm,bcm6318-gpio-sysctl.yaml     | 4 ++--
 .../devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml    | 4 ++--
 .../devicetree/bindings/mfd/brcm,bcm6328-gpio-sysctl.yaml     | 4 ++--
 .../devicetree/bindings/mfd/brcm,bcm6358-gpio-sysctl.yaml     | 4 ++--
 .../devicetree/bindings/mfd/brcm,bcm6362-gpio-sysctl.yaml     | 4 ++--
 .../devicetree/bindings/mfd/brcm,bcm6368-gpio-sysctl.yaml     | 4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm6318-gpio-sysctl.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm6318-gpio-sysctl.yaml
index 9f9a14af875e..cb480162f967 100644
--- a/Documentation/devicetree/bindings/mfd/brcm,bcm6318-gpio-sysctl.yaml
+++ b/Documentation/devicetree/bindings/mfd/brcm,bcm6318-gpio-sysctl.yaml
@@ -35,7 +35,7 @@ patternProperties:
   "^gpio@[0-9a-f]+$":
     # Child node
     type: object
-    $ref: "../gpio/brcm,bcm63xx-gpio.yaml"
+    $ref: /schemas/gpio/brcm,bcm63xx-gpio.yaml
     description:
       GPIO controller for the SoC GPIOs. This child node definition
       should follow the bindings specified in
@@ -44,7 +44,7 @@ patternProperties:
   "^pinctrl@[0-9a-f]+$":
     # Child node
     type: object
-    $ref: "../pinctrl/brcm,bcm6318-pinctrl.yaml"
+    $ref: /schemas/pinctrl/brcm,bcm6318-pinctrl.yaml
     description:
       Pin controller for the SoC pins. This child node definition
       should follow the bindings specified in
diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml
index 803277dd2725..c14def1b2ad2 100644
--- a/Documentation/devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml
+++ b/Documentation/devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml
@@ -35,7 +35,7 @@ patternProperties:
   "^gpio@[0-9a-f]+$":
     # Child node
     type: object
-    $ref: "../gpio/brcm,bcm63xx-gpio.yaml"
+    $ref: /schemas/gpio/brcm,bcm63xx-gpio.yaml
     description:
       GPIO controller for the SoC GPIOs. This child node definition
       should follow the bindings specified in
@@ -44,7 +44,7 @@ patternProperties:
   "^pinctrl@[0-9a-f]+$":
     # Child node
     type: object
-    $ref: "../pinctrl/brcm,bcm63268-pinctrl.yaml"
+    $ref: /schemas/pinctrl/brcm,bcm63268-pinctrl.yaml
     description:
       Pin controller for the SoC pins. This child node definition
       should follow the bindings specified in
diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm6328-gpio-sysctl.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm6328-gpio-sysctl.yaml
index b9a6856ce970..5f48209ed40f 100644
--- a/Documentation/devicetree/bindings/mfd/brcm,bcm6328-gpio-sysctl.yaml
+++ b/Documentation/devicetree/bindings/mfd/brcm,bcm6328-gpio-sysctl.yaml
@@ -35,7 +35,7 @@ patternProperties:
   "^gpio@[0-9a-f]+$":
     # Child node
     type: object
-    $ref: "../gpio/brcm,bcm63xx-gpio.yaml"
+    $ref: /schemas/gpio/brcm,bcm63xx-gpio.yaml
     description:
       GPIO controller for the SoC GPIOs. This child node definition
       should follow the bindings specified in
@@ -44,7 +44,7 @@ patternProperties:
   "^pinctrl@[0-9a-f]+$":
     # Child node
     type: object
-    $ref: "../pinctrl/brcm,bcm6328-pinctrl.yaml"
+    $ref: /schemas/pinctrl/brcm,bcm6328-pinctrl.yaml
     description:
       Pin controller for the SoC pins. This child node definition
       should follow the bindings specified in
diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm6358-gpio-sysctl.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm6358-gpio-sysctl.yaml
index 4651fe4dde07..f1f4629565d9 100644
--- a/Documentation/devicetree/bindings/mfd/brcm,bcm6358-gpio-sysctl.yaml
+++ b/Documentation/devicetree/bindings/mfd/brcm,bcm6358-gpio-sysctl.yaml
@@ -35,7 +35,7 @@ patternProperties:
   "^gpio@[0-9a-f]+$":
     # Child node
     type: object
-    $ref: "../gpio/brcm,bcm63xx-gpio.yaml"
+    $ref: /schemas/gpio/brcm,bcm63xx-gpio.yaml
     description:
       GPIO controller for the SoC GPIOs. This child node definition
       should follow the bindings specified in
@@ -44,7 +44,7 @@ patternProperties:
   "^pinctrl@[0-9a-f]+$":
     # Child node
     type: object
-    $ref: "../pinctrl/brcm,bcm6358-pinctrl.yaml"
+    $ref: /schemas/pinctrl/brcm,bcm6358-pinctrl.yaml
     description:
       Pin controller for the SoC pins. This child node definition
       should follow the bindings specified in
diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm6362-gpio-sysctl.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm6362-gpio-sysctl.yaml
index 0330b621fd38..4d594739b382 100644
--- a/Documentation/devicetree/bindings/mfd/brcm,bcm6362-gpio-sysctl.yaml
+++ b/Documentation/devicetree/bindings/mfd/brcm,bcm6362-gpio-sysctl.yaml
@@ -35,7 +35,7 @@ patternProperties:
   "^gpio@[0-9a-f]+$":
     # Child node
     type: object
-    $ref: "../gpio/brcm,bcm63xx-gpio.yaml"
+    $ref: /schemas/gpio/brcm,bcm63xx-gpio.yaml
     description:
       GPIO controller for the SoC GPIOs. This child node definition
       should follow the bindings specified in
@@ -44,7 +44,7 @@ patternProperties:
   "^pinctrl@[0-9a-f]+$":
     # Child node
     type: object
-    $ref: "../pinctrl/brcm,bcm6362-pinctrl.yaml"
+    $ref: /schemas/pinctrl/brcm,bcm6362-pinctrl.yaml
     description:
       Pin controller for the SoC pins. This child node definition
       should follow the bindings specified in
diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm6368-gpio-sysctl.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm6368-gpio-sysctl.yaml
index 82d3e4415bda..aae83d432880 100644
--- a/Documentation/devicetree/bindings/mfd/brcm,bcm6368-gpio-sysctl.yaml
+++ b/Documentation/devicetree/bindings/mfd/brcm,bcm6368-gpio-sysctl.yaml
@@ -35,7 +35,7 @@ patternProperties:
   "^gpio@[0-9a-f]+$":
     # Child node
     type: object
-    $ref: "../gpio/brcm,bcm63xx-gpio.yaml"
+    $ref: /schemas/gpio/brcm,bcm63xx-gpio.yaml
     description:
       GPIO controller for the SoC GPIOs. This child node definition
       should follow the bindings specified in
@@ -44,7 +44,7 @@ patternProperties:
   "^pinctrl@[0-9a-f]+$":
     # Child node
     type: object
-    $ref: "../pinctrl/brcm,bcm6368-pinctrl.yaml"
+    $ref: /schemas/pinctrl/brcm,bcm6368-pinctrl.yaml
     description:
       Pin controller for the SoC pins. This child node definition
       should follow the bindings specified in
-- 
2.34.1

