Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00ACE6E2C7D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 00:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjDNWiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 18:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNWiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 18:38:18 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66CA49E1;
        Fri, 14 Apr 2023 15:38:17 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b4dfead1bso528732b3a.3;
        Fri, 14 Apr 2023 15:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681511897; x=1684103897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rd3c9+mE7jlWzBM428gtRxGvixpDmdNW0Kf4A0MjSMA=;
        b=UD6PxTIDCsE4J+rPmy8GMiFLpPCTQ1CQrkYgVjV06BcaKT43qjbC5n5gJx61EtyNeA
         upOp6yo07/MGB5NM/tPJzODZ4XhxxNQhuAzaUMsj8GzDOXjuGMzz+QXi8Z7EkPKNkyY9
         d03rndiEB/L/iCvqVZtlpdHyYkZD/i4JVlAKyPFKlcY/7ADVyft2KEfFHl1Kc48xiwsZ
         PAZfyY0PSBBqgyCXHYYdHrhgSz6V9aL+m+cMIcg/62kfZV8bOhqns3r8LoEvysWoYTmC
         IdWZXgnHo41uFI+k+OqGLr9NODetSYnIvUthbLcISBcGd802rit7avfxrjomgqLsyae7
         Jfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681511897; x=1684103897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rd3c9+mE7jlWzBM428gtRxGvixpDmdNW0Kf4A0MjSMA=;
        b=bNnjK3tOCWsTDv6Y4R5h1kMkLtATcHaonNUJbHzaX4Ek+8mCbMhC5mtpfy1jRr2Uk3
         IRYscJh54VaL3BoYpCxYDXCwA9dXrytl3Uqh05SvC0qbw1GzbToungkHSalOjlCs7efM
         jE4opdytSx98vCbrfNQlrjp2zvQbv3GLlTRowijKY3DKCD6OcKrJXpNGsGU6HYPWX3C6
         1IHz/SvF2d8tY6cbbA4dvj9PE94AFhDeabu6A9cPrv0rJNrdmY5jKvXsZiQ8IT8kZK50
         255ah5IUtVF8L7HVP+Cex9n8t/eLUNI0Mt9wMcXB1E9OaN5+H9ThKqe8ATLVInhL5zdI
         Becg==
X-Gm-Message-State: AAQBX9dxpk6Ovhaitm5MG/OmfpxV5AGmAY2PuXrzD8nVC6JlRuuZJMUm
        kJTjbRy+5GrmG7TlSKxyH3kaGI1NVP5L0A==
X-Google-Smtp-Source: AKy350apIIoDRR+eXBw9W9c5rt3yXzw2WlFDTi4QTZvEVK8Chf3FqVrZrXgZCZFz+pq6B4PSfLQ46w==
X-Received: by 2002:aa7:8891:0:b0:632:e512:1025 with SMTP id z17-20020aa78891000000b00632e5121025mr10789705pfe.33.1681511897077;
        Fri, 14 Apr 2023 15:38:17 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:218d:82:ae97:7cb6:b12a:54f5])
        by smtp.gmail.com with ESMTPSA id v26-20020aa7851a000000b00637b0c719c5sm3478084pfn.201.2023.04.14.15.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 15:38:16 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@nxp.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saalim Quadri <danascape@gmail.com>
Subject: [PATCH] ASoC: dt-bindings: wm8753: Convert to dtschema
Date:   Fri, 14 Apr 2023 22:38:01 +0000
Message-Id: <20230414223801.1106550-1-danascape@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the WM8753 audio codec bindings to DT schema.

Signed-off-by: Saalim Quadri <danascape@gmail.com>
---
 .../devicetree/bindings/sound/wlf,wm8753.yaml | 62 +++++++++++++++++++
 .../devicetree/bindings/sound/wm8753.txt      | 40 ------------
 2 files changed, 62 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8753.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wm8753.txt

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8753.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8753.yaml
new file mode 100644
index 000000000000..9eebe7d7f0b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8753.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/wlf,wm8753.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: WM8753 audio CODEC
+
+description: |
+  Pins on the device (for linking into audio routes):
+      * LOUT1
+      * LOUT2
+      * ROUT1
+      * ROUT2
+      * MONO1
+      * MONO2
+      * OUT3
+      * OUT4
+      * LINE1
+      * LINE2
+      * RXP
+      * RXN
+      * ACIN
+      * ACOP
+      * MIC1N
+      * MIC1
+      * MIC2N
+      * MIC2
+      * Mic Bias
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: wlf,wm8753
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
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
+        codec@1a {
+            compatible = "wlf,wm8753";
+            reg = <0x1a>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/wm8753.txt b/Documentation/devicetree/bindings/sound/wm8753.txt
deleted file mode 100644
index eca9e5a825a9..000000000000
--- a/Documentation/devicetree/bindings/sound/wm8753.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-WM8753 audio CODEC
-
-This device supports both I2C and SPI (configured with pin strapping
-on the board).
-
-Required properties:
-
-  - compatible : "wlf,wm8753"
-
-  - reg : the I2C address of the device for I2C, the chip select
-          number for SPI.
-
-Pins on the device (for linking into audio routes):
-
-  * LOUT1
-  * LOUT2
-  * ROUT1
-  * ROUT2
-  * MONO1
-  * MONO2
-  * OUT3
-  * OUT4
-  * LINE1
-  * LINE2
-  * RXP
-  * RXN
-  * ACIN
-  * ACOP
-  * MIC1N
-  * MIC1
-  * MIC2N
-  * MIC2
-  * Mic Bias
-
-Example:
-
-wm8753: codec@1a {
-	compatible = "wlf,wm8753";
-	reg = <0x1a>;
-};
-- 
2.40.0

