Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94ED729C67
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241144AbjFIOJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241119AbjFIOIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:08:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252DA3A97
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:08:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-514924ca903so2767783a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686319676; x=1688911676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mq7aAwDqysJigrIwiPTPGrjCxNlaNxkTWBW8tf7ilDM=;
        b=EtANPXp4onPWBknX5WJBLtooHfbRoWWViCbQKANAWyFWyPSdn0u8M2XTRGGfBfGhjs
         HNvim90blRGkfBJ9qzeZJHpMSDggmFPdih9nlsSI5f8d+bWTWWfyrPptDP+vf2XpvJat
         8GMjRGdvxs8GoB9S1N/iZBe1o4qxgcz0w+ZYrnGPruxNgr+vob2CgnrYo2HchlBmDmHt
         gq3oTenmYs7oe6PuUMPXucY9m0tHL6uX28XfhIGrJ+oiQgSgS27x39/RrOEsTVaf4kbW
         ab4t5Tk9q/Wq2MWdh0tavLRjFHYjLYWQXq8kjd4mjX8dDzlrq++fcn7xjBCT9xIHOM+L
         Y0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686319676; x=1688911676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mq7aAwDqysJigrIwiPTPGrjCxNlaNxkTWBW8tf7ilDM=;
        b=g6JHPAJ4NxuKwyFOAEpZ/mvhhQ44jZwQHht+DnhldwzoRTDzqgiThqvZaPPWmK7j0A
         Mrtw7OKsDEAAvSbagiRbcTXGEGynEPezJ9um6hchvzTtejUaZY4yQDJfho+eimYCtbBg
         cjeQat5+109gUik3CYPcrjvbtvbAHQqyXPNUw2LAarSN1msBmB5Jzm9sO7F6oqBaqDRd
         Z6cJ9dDktMYY30LNo8yYcBGhK89u1wyPjG6ef0GGws7P3iwW4Zojd4BOB3Fdw6w4bfEh
         Ez0wx/92hcg0F18oaAF99BjjnD2gMJKuFGi/zCFC+fAMjQFHaYehdZVrt4o+Uf6R9ItQ
         0UHQ==
X-Gm-Message-State: AC+VfDwsIJ/QPugqp0buKNGGPFTTVsJUMizkNEEOuBJ6sxGn6ktrd+wf
        ddYyYyA0GogPFHDHW8iSyJHSjw==
X-Google-Smtp-Source: ACHHUZ6pY04whzkXSsILutSBFFXAvABTLYt6ob8jR/zTu+34kkmTKfsoZaSGBGmQui82Fa1SLCC16A==
X-Received: by 2002:aa7:da8a:0:b0:510:f44c:4b71 with SMTP id q10-20020aa7da8a000000b00510f44c4b71mr1207523eds.27.1686319676550;
        Fri, 09 Jun 2023 07:07:56 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id k10-20020aa7c38a000000b005027d31615dsm1793994edq.62.2023.06.09.07.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:07:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: arm: drop unneeded quotes and use absolute /schemas path
Date:   Fri,  9 Jun 2023 16:07:54 +0200
Message-Id: <20230609140754.65158-1-krzysztof.kozlowski@linaro.org>
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
 .../bindings/arm/arm,vexpress-juno.yaml        | 10 +++++-----
 .../devicetree/bindings/arm/cpus.yaml          | 18 +++++++++---------
 .../devicetree/bindings/arm/psci.yaml          |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml b/Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml
index 09c319f803ba..cdd65881fcdd 100644
--- a/Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml
@@ -122,14 +122,14 @@ properties:
   arm,vexpress,position:
     description: When daughterboards are stacked on one site, their position
       in the stack be be described this attribute.
-    $ref: '/schemas/types.yaml#/definitions/uint32'
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 3
 
   arm,vexpress,dcc:
     description: When describing tiles consisting of more than one DCC, its
       number can be specified with this attribute.
-    $ref: '/schemas/types.yaml#/definitions/uint32'
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 3
 
@@ -180,13 +180,13 @@ patternProperties:
               - const: simple-bus
           arm,v2m-memory-map:
             description: This describes the memory map type.
-            $ref: '/schemas/types.yaml#/definitions/string'
+            $ref: /schemas/types.yaml#/definitions/string
             enum:
               - rs1
               - rs2
 
           arm,hbi:
-            $ref: '/schemas/types.yaml#/definitions/uint32'
+            $ref: /schemas/types.yaml#/definitions/uint32
             description: This indicates the ARM HBI (Hardware Board ID), this is
               ARM's unique board model ID, visible on the PCB's silkscreen.
 
@@ -197,7 +197,7 @@ patternProperties:
               property, describing the physical location of the children nodes.
               0 means motherboard site, while 1 and 2 are daughterboard sites, and
               0xf means "sisterboard" which is the site containing the main CPU tile.
-            $ref: '/schemas/types.yaml#/definitions/uint32'
+            $ref: /schemas/types.yaml#/definitions/uint32
             minimum: 0
             maximum: 15
 
diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 64b58238e3a1..9e6a45eea4e5 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -197,7 +197,7 @@ properties:
       - qcom,scorpion
 
   enable-method:
-    $ref: '/schemas/types.yaml#/definitions/string'
+    $ref: /schemas/types.yaml#/definitions/string
     oneOf:
       # On ARM v8 64-bit this property is required
       - enum:
@@ -246,8 +246,8 @@ properties:
 
   cpu-release-addr:
     oneOf:
-      - $ref: '/schemas/types.yaml#/definitions/uint32'
-      - $ref: '/schemas/types.yaml#/definitions/uint64'
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - $ref: /schemas/types.yaml#/definitions/uint64
     description:
       The DT specification defines this as 64-bit always, but some 32-bit Arm
       systems have used a 32-bit value which must be supported.
@@ -255,7 +255,7 @@ properties:
         property value of "spin-table".
 
   cpu-idle-states:
-    $ref: '/schemas/types.yaml#/definitions/phandle-array'
+    $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
       maxItems: 1
     description: |
@@ -271,7 +271,7 @@ properties:
   cci-control-port: true
 
   dynamic-power-coefficient:
-    $ref: '/schemas/types.yaml#/definitions/uint32'
+    $ref: /schemas/types.yaml#/definitions/uint32
     description:
       A u32 value that represents the running time dynamic
       power coefficient in units of uW/MHz/V^2. The
@@ -308,7 +308,7 @@ properties:
       PM domain provider, must be "psci".
 
   qcom,saw:
-    $ref: '/schemas/types.yaml#/definitions/phandle'
+    $ref: /schemas/types.yaml#/definitions/phandle
     description: |
       Specifies the SAW* node associated with this CPU.
 
@@ -318,7 +318,7 @@ properties:
       * arm/msm/qcom,saw2.txt
 
   qcom,acc:
-    $ref: '/schemas/types.yaml#/definitions/phandle'
+    $ref: /schemas/types.yaml#/definitions/phandle
     description: |
       Specifies the ACC* node associated with this CPU.
 
@@ -329,7 +329,7 @@ properties:
       * arm/msm/qcom,kpss-acc.txt
 
   rockchip,pmu:
-    $ref: '/schemas/types.yaml#/definitions/phandle'
+    $ref: /schemas/types.yaml#/definitions/phandle
     description: |
       Specifies the syscon node controlling the cpu core power domains.
 
@@ -339,7 +339,7 @@ properties:
       the cpu-core power-domains.
 
   secondary-boot-reg:
-    $ref: '/schemas/types.yaml#/definitions/uint32'
+    $ref: /schemas/types.yaml#/definitions/uint32
     description: |
       Required for systems that have an "enable-method" property value of
       "brcm,bcm11351-cpu-method", "brcm,bcm23550" or "brcm,bcm-nsp-smp".
diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index 3a2c908ff282..0c5381e081bd 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -100,7 +100,7 @@ properties:
 
 patternProperties:
   "^power-domain-":
-    $ref: "../power/power-domain.yaml#"
+    $ref: /schemas/power/power-domain.yaml#
 
     type: object
     description: |
-- 
2.34.1

