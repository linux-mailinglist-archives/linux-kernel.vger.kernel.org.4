Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9E5611DFD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 01:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJ1XNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 19:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ1XNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 19:13:02 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8F360513
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:13:00 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id l28so4448414qtv.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1TTqFXJnufak57lBJdLAiI5r22saT5S8wMPVdyLYJWQ=;
        b=ogypng3huLd9C6k8ChgEqfkCle5/rUaHBHBD/ptyC6xEUFau8FCB8ZK1goK4KakUUL
         I0RXL9cORu3+wNcIouY5hYG7WS6Oerh3Pl/cgBXXZlD5r9SiCxmAfCcw08qqjzRZAZkO
         utjAxP0dbDfy5xxkAP/r8ei0283DOAy9l2Dg8p0FMvveI809EwkmZAqZHmHh4hBaWiZ8
         P8SdGIYY18Da39kcFSVfeQ1MEiFbT46EaD0urz3QxhEZ/6EHNs/Amilz4Sx1mYvyY5Sc
         H0LeLuQKiI81AVYcLuahymCG3/7o1IQzj9b0bNLxHlucpaGZnm0n4hPUeqc7/R2dyLi3
         LWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1TTqFXJnufak57lBJdLAiI5r22saT5S8wMPVdyLYJWQ=;
        b=aqTQttwtxyHMCpJqgsofnXIrXVhsqXIiZJ7sd0DEKxdC4WzYr1t1LpdIhe/0pT+w99
         t+VsqYgrognHXFUfmBND3epma99zk1mMjk3IIwaz62CObcuXvm9GNbqJlOGq3rAA+q2G
         0nBhCzLPa5p10EYqFWCuzjG/g0Mgy6CXtq7qgC3KLQKWed8j8bm7XKJ8nW6r7qXrKcM2
         5xUEOT0HBA0jC2SnhgWBWzms5L5zZtlMMr0G/e26QryoRush9FTVFOQ5gSo6Fstfh8uF
         vaz9hjk7Swwlq8F+9ZOUOE2lJeDxVoACGgrhoYF3mD05amPSqr00DGqa4w/NcRSVogAa
         zEBA==
X-Gm-Message-State: ACrzQf2U3gelVllddDx1UAkVDOR7+9Z7Gi+nAuShyruzPqVsMuKazqgO
        mgMsj+8x0XLUyagEu0qQ4ggFYw==
X-Google-Smtp-Source: AMsMyM4deQ6TLfI9iTlLyVmUPekBdwUM2eeZJhBtMskzloonFWP5VJbYDXDokrrsCMQjRIM5Q04YpA==
X-Received: by 2002:a05:622a:188a:b0:3a4:eb2c:f221 with SMTP id v10-20020a05622a188a00b003a4eb2cf221mr1641126qtc.613.1666998779575;
        Fri, 28 Oct 2022 16:12:59 -0700 (PDT)
Received: from krzk-bin.. ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id fx12-20020a05622a4acc00b0039ccd7a0e10sm3016026qtb.62.2022.10.28.16.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 16:12:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: power: supply: expect specific type for monitored-battery
Date:   Fri, 28 Oct 2022 19:12:55 -0400
Message-Id: <20221028231255.565363-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Core schema does not define type of monitored-battery, so the schemas
are expected to reference proper type.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/power/supply/bq27xxx.yaml    | 2 +-
 .../devicetree/bindings/power/supply/ingenic,battery.yaml      | 1 +
 .../devicetree/bindings/power/supply/rohm,bd99954.yaml         | 1 +
 .../devicetree/bindings/power/supply/sc2731-charger.yaml       | 2 +-
 Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml  | 3 ++-
 5 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
index 65fc6049efc1..b04c86ed0f58 100644
--- a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
@@ -59,6 +59,7 @@ properties:
     description: integer, I2C address of the fuel gauge.
 
   monitored-battery:
+    $ref: /schemas/types.yaml#/definitions/phandle
     description: |
        phandle of battery characteristics node.
        The fuel gauge uses the following battery properties:
@@ -66,7 +67,6 @@ properties:
        - charge-full-design-microamp-hours
        - voltage-min-design-microvolt
        Both or neither of the *-full-design-*-hours properties must be set.
-       See Documentation/devicetree/bindings/power/supply/battery.yaml
 
   power-supplies: true
 
diff --git a/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml b/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
index 46527038bf22..8bdacc30e9d8 100644
--- a/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
@@ -27,6 +27,7 @@ properties:
     const: battery
 
   monitored-battery:
+    $ref: /schemas/types.yaml#/definitions/phandle
     description: >
       phandle to a "simple-battery" compatible node.
 
diff --git a/Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml b/Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml
index 24b06957b4ca..ad97d0ac9438 100644
--- a/Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml
+++ b/Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml
@@ -121,6 +121,7 @@ properties:
   monitored-battery:
     description:
       phandle of battery characteristics devicetree node
+    $ref: /schemas/types.yaml#/definitions/phandle
 
   rohm,vsys-regulation-microvolt:
     description: system specific lower limit for system voltage.
diff --git a/Documentation/devicetree/bindings/power/supply/sc2731-charger.yaml b/Documentation/devicetree/bindings/power/supply/sc2731-charger.yaml
index eeb043f9bb4f..4a1ca7288a3b 100644
--- a/Documentation/devicetree/bindings/power/supply/sc2731-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/sc2731-charger.yaml
@@ -24,11 +24,11 @@ properties:
     description: phandle to the USB phy
 
   monitored-battery:
+    $ref: /schemas/types.yaml#/definitions/phandle
     description: |
       The charger uses the following battery properties
       - charge-term-current-microamp: current for charge termination phase.
       - constant-charge-voltage-max-microvolt: maximum constant input voltage.
-      See Documentation/devicetree/bindings/power/supply/battery.yaml
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml
index d90a838a1744..8af5957800c0 100644
--- a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml
+++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml
@@ -47,7 +47,8 @@ properties:
   sprd,calib-resistance-micro-ohms:
     description: real resistance of coulomb counter chip in micro Ohms
 
-  monitored-battery: true
+  monitored-battery:
+    $ref: /schemas/types.yaml#/definitions/phandle
 
 required:
   - compatible
-- 
2.34.1

