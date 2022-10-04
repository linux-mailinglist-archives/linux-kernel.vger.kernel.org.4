Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABA65F42B6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJDMJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJDMJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:09:19 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0938E57542
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 05:09:11 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q17so15059501lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 05:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=aPGidK7aepjAesrd9H3pmdchlCYA90T2ED3drHviM08=;
        b=eUwwFFRlDQ0dPHZ7nXZ9uSzyINsHKjDxBeGQx32XdcQKTTjivd9v/k87W7R0Di/3a9
         EXskKqoDPguV6PMERy9DnXZzXHQYOd/kUUtKqXoVVLwPBnEeYWZn8lgiIusHaipqGgsE
         PlVw02zjug2Nr4e/wXp1J0Z6Oqr8a7wK0B8ycCITBSiTa1qPev5zne2jiaZQSCD06F9B
         OlSCC8VylSH5cunQQY378AzMsXyuH2roJBLZz8VfjOIJcRgDnCaTAA+nZl/7QwkH/0eB
         7LGzsP2ypr6D2z1PmLmc4zalV93+HBTjs7Z9bsX+3X+IOVnr3U4iisFBW0NVkVKTuqBK
         269w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=aPGidK7aepjAesrd9H3pmdchlCYA90T2ED3drHviM08=;
        b=aHodlyFTRab6SBni6j4MW9jEg8qvPVPrYbU9K6W9F57tkRObMsOmXUzcCIaTDK1CE+
         udQMMf7AC6jBfsXoRHaEXW7wG2QH3N3kwGrR7kUQbkv1VjCwZpy5T3ReGGcz7R5GDU3H
         fROftre+X/cUTmCnxqDogtFa24Pqskx7B0D9bZU7JlwzRoqK/O2Ps08d9RxQpAwFfO5O
         TJ3SDrQpt1Wo26dsOcvUiNbvHFlMMrW3Fo/tH0VCYUNzSz+Ld6p+PkwVDelMmC3Z9vg3
         3AjdWqTjB+svZFbGdcv5CWrnacLXrssB1rAl8/V9Pllij8Px4u6kj/7JIK0S5BAs43g7
         JyVA==
X-Gm-Message-State: ACrzQf10kX86Gxjqx/gQwTTMSF23QDKH8X8vdZzooh0b3g7sg81A/cIf
        xcutKQP/gyIR7rsov9oEXHn0Xw==
X-Google-Smtp-Source: AMsMyM45quw5V+niXpUB6OEOrWbJDo4mYlYyBGIR2JYohc2wUst18OtOb8ZfZ9GCSKf+Bt3KV/9/9A==
X-Received: by 2002:a2e:bc09:0:b0:26c:203:e38 with SMTP id b9-20020a2ebc09000000b0026c02030e38mr8655204ljf.249.1664885349333;
        Tue, 04 Oct 2022 05:09:09 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z13-20020a056512308d00b004979989028bsm1891360lfd.147.2022.10.04.05.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 05:09:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Markuss Broks <markuss.broks@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Dillon Min <dillon.minfei@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: display: panel: use spi-peripheral-props.yaml
Date:   Tue,  4 Oct 2022 14:09:07 +0200
Message-Id: <20221004120907.72767-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

For devices connectable by SPI bus (e.g. already using
"spi-max-frequency" property), reference the "spi-peripheral-props.yaml"
schema to allow using all SPI device properties, even these which device
bindings author did not tried yet.

Change "additionalProperties" to "unevaluatedProperties", so the actual
other properties from "spi-peripheral-props.yaml" can be used.  This has
additional impact of allowing also other properties from
panel-common.yaml to be used.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/display/panel/ilitek,ili9163.yaml    | 3 ++-
 .../devicetree/bindings/display/panel/ilitek,ili9341.yaml    | 1 +
 .../devicetree/bindings/display/panel/nec,nl8048hl11.yaml    | 3 ++-
 .../bindings/display/panel/samsung,lms380kf01.yaml           | 5 ++---
 .../bindings/display/panel/samsung,lms397kf04.yaml           | 3 ++-
 .../devicetree/bindings/display/panel/samsung,s6d27a1.yaml   | 4 ++--
 .../devicetree/bindings/display/panel/tpo,tpg110.yaml        | 1 +
 7 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9163.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9163.yaml
index 7e7a8362b951..a4154b51043e 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9163.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9163.yaml
@@ -15,6 +15,7 @@ description:
 
 allOf:
   - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
@@ -41,7 +42,7 @@ required:
   - dc-gpios
   - reset-gpios
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
index 99e0cb9440cf..94f169ea065a 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
@@ -16,6 +16,7 @@ description: |
 
 allOf:
   - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/display/panel/nec,nl8048hl11.yaml b/Documentation/devicetree/bindings/display/panel/nec,nl8048hl11.yaml
index aa788eaa2f71..3b09b359023e 100644
--- a/Documentation/devicetree/bindings/display/panel/nec,nl8048hl11.yaml
+++ b/Documentation/devicetree/bindings/display/panel/nec,nl8048hl11.yaml
@@ -15,6 +15,7 @@ maintainers:
 
 allOf:
   - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
@@ -34,7 +35,7 @@ required:
   - reset-gpios
   - port
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,lms380kf01.yaml b/Documentation/devicetree/bindings/display/panel/samsung,lms380kf01.yaml
index 251f0c7115aa..70ffc88d2a08 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,lms380kf01.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,lms380kf01.yaml
@@ -9,14 +9,13 @@ title: Samsung LMS380KF01 display panel
 description: The LMS380KF01 is a 480x800 DPI display panel from Samsung Mobile
   Displays (SMD) utilizing the WideChips WS2401 display controller. It can be
   used with internal or external backlight control.
-  The panel must obey the rules for a SPI slave device as specified in
-  spi/spi-controller.yaml
 
 maintainers:
   - Linus Walleij <linus.walleij@linaro.org>
 
 allOf:
   - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
@@ -59,7 +58,7 @@ required:
   - spi-cpol
   - port
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,lms397kf04.yaml b/Documentation/devicetree/bindings/display/panel/samsung,lms397kf04.yaml
index cd62968426fb..5e77cee93f83 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,lms397kf04.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,lms397kf04.yaml
@@ -14,6 +14,7 @@ maintainers:
 
 allOf:
   - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
@@ -51,7 +52,7 @@ required:
   - spi-cpol
   - port
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.yaml
index 26e3c820a2f7..d273faf4442a 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.yaml
@@ -7,14 +7,14 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Samsung S6D27A1 display panel
 
 description: The S6D27A1 is a 480x800 DPI display panel from Samsung Mobile
-  Displays (SMD). The panel must obey the rules for a SPI slave device
-  as specified in spi/spi-controller.yaml
+  Displays (SMD).
 
 maintainers:
   - Markuss Broks <markuss.broks@gmail.com>
 
 allOf:
   - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/display/panel/tpo,tpg110.yaml b/Documentation/devicetree/bindings/display/panel/tpo,tpg110.yaml
index 6f1f02044b4b..f0243d196191 100644
--- a/Documentation/devicetree/bindings/display/panel/tpo,tpg110.yaml
+++ b/Documentation/devicetree/bindings/display/panel/tpo,tpg110.yaml
@@ -41,6 +41,7 @@ description: |+
 
 allOf:
   - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
-- 
2.34.1

