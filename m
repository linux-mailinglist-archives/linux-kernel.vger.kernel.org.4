Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056597500DD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjGLILd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjGLILb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:11:31 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C61D10E5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:11:29 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51e28b299adso8865515a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689149488; x=1691741488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jHkdHjFrM5AfGKbyzbpp4QoR422wNpy9DNc8+HlwIYs=;
        b=AzJbvXxgl40Rh5LpkFIrmNi/6CwG7cp23unkfzcyCmTh6Vfe+T7HaKu0u8e6ykzg8z
         95T0Ho47gQFvBalUnsu3IHe3eFf2cX0jj/hlHVrQjRdVT2IFsSGObXP+3s21P0MlcY3k
         jy/JBDKyKvq6v55fEeFaOAkDNM9jyuyuhB5md3cx1GKu2WpkcHN2gtUH1Bs/pZNq5L8j
         1DOyiNXPxUGruMBe9F0xnub1wQKKSLACgevYyxMUQmHo5JATS4U1iHcswqNQcq01J4TU
         y5bJJhyil0rBNkljL0YPehL6poUpoO9/hKvmRsC4IR6EeC3Idf0i1LpZtbUwOS2SuhON
         LM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689149488; x=1691741488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jHkdHjFrM5AfGKbyzbpp4QoR422wNpy9DNc8+HlwIYs=;
        b=KEXULaTGvRLBJu0E2z1qMclH4yYc2LWwZrmgngIRnVDBe0bpJjOU4xOjLHF8SRpG2o
         0DFvfrstmuVjdsC38VJrlXCpHBismwN29Kp5wYDZAc+cH8W5KX/93esr1AoN1wuKgM2m
         PlWuDGat9N2yKzrwRn4qYi93VHqnlWjsSj/HpbmH8dqO+//UHBLca8/JPiCUiJlxGoCj
         5Ya5NwvCTyGgeBD3UE2xQmNiz6+gGR/UgUuXsOGtIP7HY3GuU8QyzPg1ptZs47s3+UiS
         LMyJka5WozPRNOoxM2+sDk9de4JTy9bwf3SK9kcannuCqZhkR9di2cLWQ7x7DAizzcb6
         Pm6A==
X-Gm-Message-State: ABy/qLaGs35Mh8OQU5CmPSJZrU6qi1s1UuI9znuWdoZRE7PkosmjCzUW
        tJ6qFHiiHXgHRt2C6i/0B720Ig==
X-Google-Smtp-Source: APBJJlG9168Y3yKpvGkO+PSj4hvN4VDwnF2KzycYIa/xWbJHW3ppkxTBzsAdI7Sty/NnqkSrhIdnRA==
X-Received: by 2002:aa7:c544:0:b0:51e:1bf3:f4ac with SMTP id s4-20020aa7c544000000b0051e1bf3f4acmr15556921edr.27.1689149488039;
        Wed, 12 Jul 2023 01:11:28 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id t3-20020aa7d4c3000000b0051d87e72159sm2368024edr.13.2023.07.12.01.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 01:11:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Eliav Farber <farbere@amazon.com>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: hwmon: moortec,mr75203: fix multipleOf for coefficients
Date:   Wed, 12 Jul 2023 10:11:24 +0200
Message-Id: <20230712081124.110345-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few coefficients use default values multiple of 100, not 1000 (in the
example DTS and in the Linux driver):

  moortec,mr75203.example.dtb: pvt@e0680000: moortec,ts-coeff-g:0:0: 61400 is not a multiple of 1000

Fixes: bf1fdafdbc61 ("dt-bindings: hwmon: (mr75203) add coefficient properties for the thermal equation")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/hwmon/moortec,mr75203.yaml          | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
index ae4f68d4e696..bd67cfee6d19 100644
--- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
+++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
@@ -105,7 +105,7 @@ properties:
       G coefficient for temperature equation.
       Default for series 5 = 60000
       Default for series 6 = 57400
-    multipleOf: 1000
+    multipleOf: 100
     minimum: 1000
     $ref: /schemas/types.yaml#/definitions/uint32
 
@@ -114,7 +114,7 @@ properties:
       H coefficient for temperature equation.
       Default for series 5 = 200000
       Default for series 6 = 249400
-    multipleOf: 1000
+    multipleOf: 100
     minimum: 1000
     $ref: /schemas/types.yaml#/definitions/uint32
 
@@ -131,7 +131,7 @@ properties:
       J coefficient for temperature equation.
       Default for series 5 = -100
       Default for series 6 = 0
-    multipleOf: 1000
+    multipleOf: 100
     maximum: 0
     $ref: /schemas/types.yaml#/definitions/int32
 
-- 
2.34.1

