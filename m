Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA136DCD72
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 00:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDJWaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 18:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDJWaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 18:30:06 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3F0E60;
        Mon, 10 Apr 2023 15:30:05 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n19-20020a05600c501300b003f064936c3eso8379497wmr.0;
        Mon, 10 Apr 2023 15:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681165803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0D4LsfAW6191QwNdK4ta66PY+hl1RuuGNyGsehh1bKM=;
        b=RaOH+5cpTaSGaPQ96/dB25hRT8d8reD+ky6sQeH+7WLElvuuAeDsMN96MQEUehm+nl
         JquppEasMJwoOBkDPoD+jS09xZgi+pR8KVWYco2JDjdqDzZOZ93TiCJ8oo98L/nZ6R+E
         zj5u4+eHMwtpZL+YR6OACcLwnHOwpuf4Al+WRJfyx3ZdD7DaDvJAU91h98FwV0mXXAgI
         w2QgNZfU9hwTD/6SiqVidbBIy+Etb3MgesVHNdhS7npny42SK2rFfCG1AfHMd0CAymgP
         UjQcVQjB7qKHjqkzmU9MwETrEGr4DDTDe1o84HdKOz97QWclHo1J3suc+iSKe/6YxGtm
         SGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681165803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0D4LsfAW6191QwNdK4ta66PY+hl1RuuGNyGsehh1bKM=;
        b=KMT5+yYQReVqlrDPZLRBA9VGw4vXGWhQ7kHsHE7FPXCsj+BqRmRYiXYkuLQc6a+Grx
         gFoUxHh9vx96UdpK/ej32uDTnPNK5pyMOX02pgDnqjyQY4PpoT+4U2cYgXIHkxSrFIhC
         O7Svxecl6Z/NnbhJzZisYalqAtwlOShtGhVThv8C/0oLbcgen4dT+Nz9Hjr70GsT29lK
         Srom75Dntmh9o0Ywz+lOlOCeaHaF08Dc+QR1VnWRMjWflU7Fn/oNM/bmmhrLvDkYBQ7h
         Ua8sc5uQRzXZyxUIZoRpCYaK91E1vcHwkjFgHgrKPm/YWvs0AL2HZBXL9DUgJ6zFasBT
         cP5A==
X-Gm-Message-State: AAQBX9cjB8cQAFtmo7d2L0U5s8mfZgM4/hYE5WaIVdtTIJ0SJVMKKEMN
        zH2i0YjXoyF/KMefsxocpYZc/99RbmzjAw==
X-Google-Smtp-Source: AKy350ZNlm7b4LIjyU0q14EYTktx6/KUiaIJFJCINddBIpuiCQNGe64Jzpa+jWPi9kCKl0LeTthkGw==
X-Received: by 2002:a05:600c:c4:b0:3ed:f5d4:3bff with SMTP id u4-20020a05600c00c400b003edf5d43bffmr8570805wmm.38.1681165803300;
        Mon, 10 Apr 2023 15:30:03 -0700 (PDT)
Received: from localhost ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with UTF8SMTPSA id n4-20020a5d51c4000000b002efb55de21dsm8613137wrv.103.2023.04.10.15.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 15:30:02 -0700 (PDT)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Nikita Shubin <nikita.shubin@maquefel.me>
Subject: [PATCH v2 1/2] dt-bindings: sound: ep93xx: Add I2S description
Date:   Tue, 11 Apr 2023 00:29:57 +0200
Message-Id: <20230410222958.2321398-1-alexander.sverdlin@gmail.com>
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

Add device tree bindings for Cirrus Logic EP93xx internal SoCs' I2S
controller.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
Changelog:
v2:
 - Incorporated most of the suggestions from Krzysztof Kozlowski [1]
 - Dropped AC97 (deleted from the tree)

[1]. https://lore.kernel.org/lkml/46d5b6af-23e1-4178-83bc-b4a435b1426e@linaro.org/

 .../bindings/sound/cirrus,ep9301-i2s.yaml     | 66 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml

diff --git a/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml b/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
new file mode 100644
index 000000000000..9c01310a5445
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/cirrus,ep9301-i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus EP93xx I2S Controller
+
+description: |
+  The I2S controller is used to stream serial audio data between the external
+  I2S CODECs’, ADCs/DACs, and the ARM Core. The controller supports I2S, Left-
+  and Right-Justified DSP formats.
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: cirrus,ep9301-i2s
+
+  '#sound-dai-cells':
+    const: 0
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 3
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: mclk
+      - const: sclk
+      - const: lrclk
+
+required:
+  - compatible
+  - '#sound-dai-cells'
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    i2s: i2s@80820000 {
+        compatible = "cirrus,ep9301-i2s";
+        #sound-dai-cells = <0>;
+        reg = <0x80820000 0x100>;
+        interrupt-parent = <&vic1>;
+        interrupts = <28>;
+        clocks = <&syscon 29>,
+                 <&syscon 30>,
+                 <&syscon 31>;
+        clock-names = "mclk", "sclk", "lrclk";
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 4485969f58f1..da829bedb89b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2072,6 +2072,7 @@ M:	Alexander Sverdlin <alexander.sverdlin@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
+F:	Documentation/devicetree/bindings/sound/cirrus,ep9301-*
 F:	arch/arm/boot/compressed/misc-ep93xx.h
 F:	arch/arm/mach-ep93xx/
 F:	drivers/iio/adc/ep93xx_adc.c
-- 
2.40.0

