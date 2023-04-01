Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0F16D3312
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 20:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjDASUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 14:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDASUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 14:20:06 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0F01A96A;
        Sat,  1 Apr 2023 11:20:05 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id h1-20020a4adcc1000000b0053e9796cc7dso1182226oou.4;
        Sat, 01 Apr 2023 11:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680373205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fITr2HwYgqLUUk1Kke5I+QMgFMyvuPMKr1ZR1hYIU3I=;
        b=TWTywiVBMaANiqanN77gtisbmbm/wLVaWH+qyvtSiG7Ip59YMo9aZDcndAj+mKA+np
         pmRQ/MRD3zciKrhFt0RuZvZz2+h78fnTzX/LcAXMYKtlKZxIYQAoAP4r4EremUZ3sz0b
         qkxGHWGCNrdO76vAQ9tDN0qdcTRQQlaidz9AixfK1WPfKQHehUmHtsft+IME2e+dtrn+
         19VBxkzkYCibQxoy7a1ESloaQXtfmxLJ3EhA8uCs0lomI+AfOuw00QACf/hwYVUCwKKU
         3oeE4S6hC+9ht1tFV7Nti8PwpFUsmbeyI9oqrOcY2RqMGsSjyUcsTXnL2A5iKKaz4EDY
         DGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680373205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fITr2HwYgqLUUk1Kke5I+QMgFMyvuPMKr1ZR1hYIU3I=;
        b=4KZZTrmE3AoMbjSz20UJl7GnYRKXDst9iNBh+O56qN/lb0MJRvbThz+5/BznqLrGk5
         P8cdwQFyaaXYhnJixQxdBdsccMdisEqXbbN1gND4RFwW2SPAUW2uSP5LpAZEkvo5qDSH
         oVEt1Lh0xQ+OLsR01zZqnHfffvU/aurP9aXW6DVXkZJRTbEoCas/HEnpR1c/W3ZAMpuW
         qL051+6ScaT8yPaEz9itcmQOqyPtJLj5WJ6eQVUB10HnzZi+iVUyzhQ3j53nA2sFecNj
         EaKY5hAcK6hRrg938vfbSD759W/DYEG6EWiip3TwVzC8LpgF9x0U40dUenvwX2fK3XEi
         2oDw==
X-Gm-Message-State: AAQBX9dvJaU4oHZJwM31z7zXfVSRGwyQfGbXFZJAfytpFNDI/yGVeU1e
        EDupFsU3Wz7pBrNPh3hqh6o=
X-Google-Smtp-Source: AKy350ZGi7A5EVHermG2a+d2Y1EJ0swdZU4PDDJgxPBdTR3MqzeWevqrtPAxWogwUpGjkvCHzT782A==
X-Received: by 2002:a4a:bd8c:0:b0:53c:5f89:eb85 with SMTP id k12-20020a4abd8c000000b0053c5f89eb85mr6913034oop.2.1680373205132;
        Sat, 01 Apr 2023 11:20:05 -0700 (PDT)
Received: from heimdal.localdomain ([2804:431:cfec:79f0:85a3:2af2:a6f4:1842])
        by smtp.gmail.com with ESMTPSA id e193-20020a4a55ca000000b005255e556399sm2159485oob.43.2023.04.01.11.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 11:20:04 -0700 (PDT)
From:   =?UTF-8?q?Andr=C3=A9=20Morishita?= <andremorishita@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        anish kumar <yesanishhere@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mairacanal@riseup.net, dri-devel@lists.freedesktop.org,
        daniel.baluta@nxp.com,
        =?UTF-8?q?Andr=C3=A9=20Morishita?= <andremorishita@gmail.com>
Subject: [PATCH v3] ASoC: dt-bindings: maxim,max98371: Convert to DT schema
Date:   Sat,  1 Apr 2023 15:19:29 -0300
Message-Id: <20230401181930.533067-1-andremorishita@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Maxim Integrated MAX98371 audio codec bindings to DT schema.

Signed-off-by: André Morishita <andremorishita@gmail.com>
---
Changes in v3:
  - Make commit message and subject as v1 with ASoC subject prefix

Changes in v2:
   - Generic node names - codec (Krzysztof)
   - Drop label max98371 (Krzysztof)
   - Add sound-dai-cells in example (Krzysztof)

 .../devicetree/bindings/sound/max98371.txt    | 17 --------
 .../bindings/sound/maxim,max98371.yaml        | 42 +++++++++++++++++++
 2 files changed, 42 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/max98371.txt
 create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98371.yaml

diff --git a/Documentation/devicetree/bindings/sound/max98371.txt b/Documentation/devicetree/bindings/sound/max98371.txt
deleted file mode 100644
index 8b2b2704b574..000000000000
--- a/Documentation/devicetree/bindings/sound/max98371.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-max98371 codec
-
-This device supports I2C mode only.
-
-Required properties:
-
-- compatible : "maxim,max98371"
-- reg : The chip select number on the I2C bus
-
-Example:
-
-&i2c {
-	max98371: max98371@31 {
-		compatible = "maxim,max98371";
-		reg = <0x31>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/sound/maxim,max98371.yaml b/Documentation/devicetree/bindings/sound/maxim,max98371.yaml
new file mode 100644
index 000000000000..14fba34ef81a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/maxim,max98371.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/maxim,max98371.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX98371 audio codec
+
+maintainers:
+  - anish kumar <yesanishhere@gmail.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: maxim,max98371
+
+  '#sound-dai-cells':
+    const: 0
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        codec@31 {
+            compatible = "maxim,max98371";
+            reg = <0x31>;
+            #sound-dai-cells = <0>;
+        };
+    };
-- 
2.40.0

