Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBDB6B6879
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjCLQ6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjCLQ6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:58:03 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8576A72
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:57:59 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x3so39646311edb.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678640278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k5AnnZE28vmaXIXEQrL8eUKQzsCZWn8PosDZ4WwlUFo=;
        b=hqnw8EeVwBJsA089DgVENUSeXwPRY8vRG+4mYsZdo5MqWl4YqMFgYX4ZIlpQsLZL7t
         B+/PrW6elq07xthNR+WznP7eKbqzUai058p/OvhqjTmaALmeTJrG4A/cIJ4Oqc4AaS9m
         j205GKaHsfgO789k2tiqQe1rwMIsHbtzM1fszaX3BUBcWrgXCpK9Q2xX8P+c6uf5OQJO
         iMdi2uoRvx6qA7WDxA9MzSw3+SuHwIcB0qAO2G4/avnPJiZ6Qmd8iJXzj6eY8l85B1Te
         XlQAfU5s+PfAScew4zajsI4Tf3daQ6sw0h6QThXMAjOliQlCF24I4JAQ3VYUaMp3jIwV
         /Pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678640278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5AnnZE28vmaXIXEQrL8eUKQzsCZWn8PosDZ4WwlUFo=;
        b=l48CJNuTnP5yXGT/wkKP6sXsCbL765X7s3jNf9K6DCQh1oYhEyxB3bEkChw9bZsBD8
         I4gygMwbQgVql3gxhDnVXjzwpjjbinJK3nDETXk4RQg2WPq7obMVNIr8/n5voHIiwVAo
         K5yw9KQIFApL9YuEF2rHZpD8Em6r2D1r3x8AmOEBc0ycYejs+lN5egopoIL5zXXCJNeD
         twljP0QltLuN4yJMzM8OV+Di6e6HDbr1XwvvFPtTaCYELUzoy+RiQ+CM8B64Sm2siP3V
         ztT67eFO9Pw9/elNsEOn3m/RNQA3RVIlYBg6W+QwbAbtL1UoJYWopV2JtQO5gpPDTCBl
         pJfQ==
X-Gm-Message-State: AO0yUKUfwZbJc54udGysXpq4gSb3dzwtf9fRo2rOXuoaHEHXPx/Gu/hG
        GI+la1ucF6DWzGbLViObzmJ2uA==
X-Google-Smtp-Source: AK7set8AQ3hvSDIO61F7nvE8/aXECdaLSX+D3AHg5tWE60d7IQm/2kKe3eVV1PvcTUwu0PpTgqlFMQ==
X-Received: by 2002:a17:906:175b:b0:8b1:3483:e3d5 with SMTP id d27-20020a170906175b00b008b13483e3d5mr27161002eje.48.1678640278013;
        Sun, 12 Mar 2023 09:57:58 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id t17-20020a170906179100b008e724dfc44bsm2405483eje.78.2023.03.12.09.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 09:57:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        =?UTF-8?q?=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH] media: dt-bindings: silabs,si470x: Convert to DT schema
Date:   Sun, 12 Mar 2023 17:57:55 +0100
Message-Id: <20230312165755.385593-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Convert the Silicon Labs Si470x FM Radio Receiver bindings to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Resending because this patch is waiting for three months:
https://patchwork.kernel.org/project/linux-media/patch/20221209175926.335227-1-krzysztof.kozlowski@linaro.org/
---
 .../devicetree/bindings/media/si470x.txt      | 26 ----------
 .../bindings/media/silabs,si470x.yaml         | 48 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 49 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/si470x.txt
 create mode 100644 Documentation/devicetree/bindings/media/silabs,si470x.yaml

diff --git a/Documentation/devicetree/bindings/media/si470x.txt b/Documentation/devicetree/bindings/media/si470x.txt
deleted file mode 100644
index a9403558362e..000000000000
--- a/Documentation/devicetree/bindings/media/si470x.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-* Silicon Labs FM Radio receiver
-
-The Silicon Labs Si470x is family of FM radio receivers with receive power scan
-supporting 76-108 MHz, programmable through an I2C interface.
-Some of them includes an RDS encoder.
-
-Required Properties:
-- compatible: Should contain "silabs,si470x"
-- reg: the I2C address of the device
-
-Optional Properties:
-- interrupts : The interrupt number
-- reset-gpios: GPIO specifier for the chips reset line
-
-Example:
-
-&i2c2 {
-        si470x@63 {
-                compatible = "silabs,si470x";
-                reg = <0x63>;
-
-                interrupt-parent = <&gpj2>;
-                interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
-                reset-gpios = <&gpj2 5 GPIO_ACTIVE_HIGH>;
-        };
-};
diff --git a/Documentation/devicetree/bindings/media/silabs,si470x.yaml b/Documentation/devicetree/bindings/media/silabs,si470x.yaml
new file mode 100644
index 000000000000..a3d19c562ca3
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/silabs,si470x.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/silabs,si470x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silicon Labs Si470x FM Radio Receiver
+
+maintainers:
+  - Hans Verkuil <hverkuil@xs4all.nl>
+  - Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
+
+properties:
+  compatible:
+    const: silabs,si470x
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        fmradio@10 {
+            compatible = "silabs,si470x";
+            reg = <0x10>;
+            interrupt-parent = <&gpj2>;
+            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+            reset-gpios = <&gpj2 5 GPIO_ACTIVE_HIGH>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 2892858cb040..a068df885006 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19034,6 +19034,7 @@ L:	linux-media@vger.kernel.org
 S:	Odd Fixes
 W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/silabs,si470x.yaml
 F:	drivers/media/radio/si470x/radio-si470x-i2c.c
 
 SI470X FM RADIO RECEIVER USB DRIVER
-- 
2.34.1

