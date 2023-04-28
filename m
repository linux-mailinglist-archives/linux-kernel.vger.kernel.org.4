Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E31F6F1C29
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 18:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjD1QDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 12:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjD1QDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 12:03:00 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A94B2709;
        Fri, 28 Apr 2023 09:02:59 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64115e652eeso13597439b3a.0;
        Fri, 28 Apr 2023 09:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682697779; x=1685289779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NFqCvF6zcr5bU/PC6sitkV28Z2TiIUDFVfcU6fA1uhs=;
        b=PwjZmFWjx0l6/Cp3B6ZEV6WQ7Zx28GfcOc51v/XK+23ClDY50ePtgxT09IwNgPEopC
         XgFev2tc3ytoXpXLsu2m7KZ5WzuFJI08T+0tRjFosmfzexucrkduyA3QGDctCx5X1sl3
         1Enws9t3ncavnNHrV7394jQs6V2A1q0TUYUigkpb3CxG/rDvjjqvkDXW0VazHIbG+l7L
         bkjeRYHv6/rRV69VLp7KVgFOX3e9KAbdkhb6BWIUhT/urHkwkoMdUf5v9LLm6CeLVkRr
         z0fnVDsae2mmHQiEdZuIdHcl6LHoFqiGR5rtgFHEVb5carY4Nr9lqieW4rWV43BzLB25
         TPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682697779; x=1685289779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFqCvF6zcr5bU/PC6sitkV28Z2TiIUDFVfcU6fA1uhs=;
        b=TzyT3czTpo8LpGEnHaBuOQyA0xWNMvu1eQepYtGzzlMFaRuOKKRRctXffPVhxh3IBZ
         5qVVjbTbm7v++leWh6PIS12G2pj1vmD6XxcatVepDVoelmB4eVeTjlSVA4D+RlWPYdqW
         r9r/f5t4gKnkqzJwhoGoSdD4zsVnMepcBo5k5gYNKz8KsX7X4eK0iDJ6R4UCXPFxCJuq
         5UVP9lCNq2INia9T2jsIV22Rzfsnci1VjO7s4D1TGYiUDM0RZzqiuZCH7/RhkBZtwfLA
         rUSuEXAswbm8Vk/hGuqqWOhI+Odeoyc+lMYC7lx/PhcKXb7kQbf6IMTShGvRk/RmWHJX
         TXeg==
X-Gm-Message-State: AC+VfDwpcH/uD6scI98zjFCX6FCj+yfditoTyGAQ28hDKOF9Jvgp1e9B
        4sg55r1XrmCioJZp7fd2arc=
X-Google-Smtp-Source: ACHHUZ4n9eWm1zNiFdfRPnFXpG+pdAIxXQZgdvnrdjIN6cuRBezH8a5Vp7dwCkgu/eE23rnzdDfxEw==
X-Received: by 2002:a17:902:dacb:b0:1a2:a904:c42e with SMTP id q11-20020a170902dacb00b001a2a904c42emr7025837plx.24.1682697778013;
        Fri, 28 Apr 2023 09:02:58 -0700 (PDT)
Received: from localhost.localdomain (n220246252240.netvigator.com. [220.246.252.240])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902820f00b001a045f45d49sm13354756pln.281.2023.04.28.09.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 09:02:57 -0700 (PDT)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Jianhua Lu <lujianhua000@gmail.com>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: [PATCH] dt-bindings: leds: backlight: ktz8866: Add reg property and update example
Date:   Sat, 29 Apr 2023 00:02:46 +0800
Message-Id: <20230428160246.16982-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kinetic,ktz8866 is a I2C driver, so add the missing reg property.
And update example to make it clear.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 .../leds/backlight/kinetic,ktz8866.yaml       | 29 ++++++++++++-------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
index e1191453c2f0..6ec40cce3f11 100644
--- a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
@@ -21,6 +21,9 @@ properties:
   compatible:
     const: kinetic,ktz8866
 
+  reg:
+    maxItems: 1
+
   vddpos-supply:
     description: positive boost supply regulator.
 
@@ -53,6 +56,7 @@ properties:
 
 required:
   - compatible
+  - reg
   - vddpos-supply
   - vddneg-supply
   - enable-gpios
@@ -63,14 +67,19 @@ examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
 
-    backlight {
-        compatible = "kinetic,ktz8866";
-
-        vddpos-supply = <&bl_vddpos_5p5>;
-        vddneg-supply = <&bl_vddneg_5p5>;
-        enable-gpios = <&tlmm 139 GPIO_ACTIVE_HIGH>;
-        current-num-sinks = <5>;
-        kinetic,current-ramp-delay-ms = <128>;
-        kinetic,led-enable-ramp-delay-ms = <1>;
-        kinetic,enable-lcd-bias;
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        backlight@11 {
+            compatible = "kinetic,ktz8866";
+            reg = <0x11>;
+            vddpos-supply = <&bl_vddpos_5p5>;
+            vddneg-supply = <&bl_vddneg_5p5>;
+            enable-gpios = <&tlmm 139 GPIO_ACTIVE_HIGH>;
+            current-num-sinks = <5>;
+            kinetic,current-ramp-delay-ms = <128>;
+            kinetic,led-enable-ramp-delay-ms = <1>;
+            kinetic,enable-lcd-bias;
+        };
     };
-- 
2.39.2

