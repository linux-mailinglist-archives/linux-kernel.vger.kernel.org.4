Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5744729C43
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240463AbjFIOHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240127AbjFIOHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:07:09 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E590E35B1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:07:03 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51493ec65d8so3203117a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686319622; x=1688911622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E9uMQ0sfqZ2sQ8GreRUpH89gA6dhVg8HRnZ9nNzOC5U=;
        b=wnzZoyqu+R5uWVV5c2SmCaaKcEtjCYLxh7x7XZdJRpl1l3mWEPqGa0s9zBwqqJYi2f
         p1fgEf5EUa1on/lQLgGyhH2F2v+jUguBBBcFns7QGE2G/yVo89TKQZ+jh+7aJsRQsU+x
         zg8x2XPvO/8RXDzVjkg/ETZ5d+0JFvgMBHZk9A3bmG74ceRu/lBeZxuao5KSRoCs1tVK
         LeaTPlEMQ7aVF8CSCNsJ+n+Re6pTqxnFP7TaFUYhuWudZA+dUTmwuPC2v6chH892QlKq
         SlsAZTGIlNyAqWV45BsQIngMiI1B0/EU/l0bJrJREMBjs0qKp84jeA2rkNGQmgfJg66C
         Cj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686319622; x=1688911622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E9uMQ0sfqZ2sQ8GreRUpH89gA6dhVg8HRnZ9nNzOC5U=;
        b=IzWW0pplLpU73YvgNkGSerGXivrmPKp4+z99+pK7a91LzGvfz0RIrp93kJHGZ9wVBN
         jnzSANi0Nju7hq5FGKo5r6Ol/wn5vJG0KvNznS+B9Be5erUdNxHjDS+zIwAxXN0fcPLe
         +FpcSFCYHBHfW+Y5cFRacMFFPc5rTuVS1f5b48WjSZeR8CslMw0Ut1QWiUYig1e+bZGr
         JTYb90vb/V7ZUGR7SiZgKUkZmB1sAd+CgO+DNbDsowFlHDX59OJUxoNwCEuRHhFfLob0
         kQp9HxtqHdW1KedH8V1BHc4qDXnWcQ+35MaBHi9UTAWOSbH0XCTLbJRsj8J6+6ChtHdV
         UB9g==
X-Gm-Message-State: AC+VfDyEfEXi5VU8sm1ziazhi/BTqWdrlOPSv2CkEVaqhy6BTBMDwC/N
        hcRh4YJm/nne8z7aSxns/A2fOw==
X-Google-Smtp-Source: ACHHUZ5DkXFiMm5CGgSQmITXmQLTvumkIiZtW5dSbMjJW9/TR74LmfVF2cvMFqNWQc10JQoD0Ezg9A==
X-Received: by 2002:aa7:c910:0:b0:514:960e:6 with SMTP id b16-20020aa7c910000000b00514960e0006mr1388561edt.10.1686319622321;
        Fri, 09 Jun 2023 07:07:02 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id f8-20020a05640214c800b00516a29dfa68sm1818429edx.90.2023.06.09.07.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:07:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: dt-bindings: cirrus,cs35l45: drop unneeded quotes
Date:   Fri,  9 Jun 2023 16:06:58 +0200
Message-Id: <20230609140658.64557-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/sound/cirrus,cs35l45.yaml      | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs35l45.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs35l45.yaml
index 2ab74f995685..4c9acb8d4c4c 100644
--- a/Documentation/devicetree/bindings/sound/cirrus,cs35l45.yaml
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs35l45.yaml
@@ -62,7 +62,7 @@ patternProperties:
           GPIO pin direction. Valid only when 'gpio-ctrl' is 1
             0 = Output
             1 = Input
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 1
         default: 1
@@ -71,7 +71,7 @@ patternProperties:
           GPIO level. Valid only when 'gpio-ctrl' is 1 and 'gpio-dir' is 0
             0 = Low
             1 = High
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 1
         default: 0
@@ -80,7 +80,7 @@ patternProperties:
           GPIO level. Valid only when 'gpio-ctrl' is 1 and 'gpio-dir' is 0
             0 = CMOS
             1 = Open Drain
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 1
         default: 0
@@ -90,7 +90,7 @@ patternProperties:
           and 'gpio-dir' is 0
             0 = Non-inverted, Active High
             1 = Inverted, Active Low
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 1
         default: 0
@@ -114,7 +114,7 @@ patternProperties:
             0 = High impedance input
             1 = Pin acts as a GPIO, direction controlled by 'gpio-dir'
             2-7 = Reserved
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 7
         default: 0
-- 
2.34.1

