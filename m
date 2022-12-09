Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5218364881D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiLIR7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiLIR7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:59:38 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D166293A4F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:59:36 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id b9so5704758ljr.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 09:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wDE+dh0QXjs8GECyva0hsyEdVkE34uGE8hKMHkEygPY=;
        b=QBRKFxkNyqkOse22TUczWmVIZQ+akSalBA42KviCVzlkPT46XSEVWZQm5oAe03aYzN
         0krooFAylEVrz9IeklDGmmRcddEHzTczz4c4LyOHoYhwGem3ht7PoTT5lm7uEAfNez3i
         XxGeColRRQx0GuklTRaTpZm557PftBttNLW3tfWhSv6iKMpqnx0dj6d+/UQWeABtcvjY
         OR8ULLy4dxgnTdFc8nUUPGze5RLjyOeD1rphXrYslE1dDuF/6gaB3oXMcrNi6ofnDx2h
         1ZlS3MQbq5ICGjcbqLrQ95x2qZxdTadP+qrbsyc+l8JyGvP/9eiA001BRH9ZnT4hhHfL
         J55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDE+dh0QXjs8GECyva0hsyEdVkE34uGE8hKMHkEygPY=;
        b=YMxo5FHAbyV05EsJ2S7Rq5tnf6fr99JpBm1fAr+cmkH7L9Mlgagq+4QX3mvLlN+s1a
         sHTuiBp2Ej1ZtXWJ2jbDcueiyriAVkJoyPeT6C2qfNCgK82TqhU60LzVTvR3TKp5MceS
         wUeNG3mQGVQIATk5NFN34a4CxT7q9rkIcH/AmR086/SqQNrNNjTfyHAoXPkp8ncxaTXt
         7biUjzp5Fa/LwPawiECY+cVEvgWaNS0k/7DIYGCJzhyoESayV/hvsBHlekrziZ0SxWOK
         NFlKSAGzkvpuMzPK0ACYnOb6FT9BQPBZS+OEalgP/Y2bG7XUusOGiX735FQ/JVoDW3JX
         nicA==
X-Gm-Message-State: ANoB5ploo/yzA24BqKU0tow6pNcNamGdMYNI19Pu7PsInQdsCVslIHov
        vM8oQ8/t+j/PemLTSEnN2K6v1g==
X-Google-Smtp-Source: AA0mqf4k0XQkxR64xVBuLUb9lpFbyRxNIYk7apma3qSnxjVCyNdbaGCFVnP7rYXkFtFQLAyEyOlgOg==
X-Received: by 2002:a2e:b8c6:0:b0:277:1c60:fded with SMTP id s6-20020a2eb8c6000000b002771c60fdedmr2215574ljp.9.1670608775075;
        Fri, 09 Dec 2022 09:59:35 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a17-20020a05651c031100b0026dffa29989sm301385ljp.23.2022.12.09.09.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 09:59:34 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        =?UTF-8?q?=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: dt-bindings: silabs,si470x: Convert to DT schema
Date:   Fri,  9 Dec 2022 18:59:26 +0100
Message-Id: <20221209175926.335227-1-krzysztof.kozlowski@linaro.org>
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
index b110c6d5133e..f603b89b690a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18977,6 +18977,7 @@ L:	linux-media@vger.kernel.org
 S:	Odd Fixes
 W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/silabs,si470x.yaml
 F:	drivers/media/radio/si470x/radio-si470x-i2c.c
 
 SI470X FM RADIO RECEIVER USB DRIVER
-- 
2.34.1

