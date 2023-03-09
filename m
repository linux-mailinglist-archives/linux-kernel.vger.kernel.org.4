Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D9F6B2337
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjCILj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCILjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:39:48 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E705DC0BE;
        Thu,  9 Mar 2023 03:39:47 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id b10so1528991ljr.0;
        Thu, 09 Mar 2023 03:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678361985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5/fm4EqRCQX8P0V8IgQoUdGEPJ3+a5JFn9mYMwtSO3Q=;
        b=jz8hJhESfDuPQgyoO4TMijhXSSWQRZKlV81/ZaLE1L19/bVehhsCxPiTATZqsogeuP
         Lm3C+nd6zUQfQOtHYmgIQ1N7emCuJszYTIwguedZttJi05Z23HC5g6HjeBQYH++q++Il
         kx4dChfSsKnGmc96ExgaWdu9F5O7qyzK+/hlfh76osrzvCofmzlRyELaeXYoNrKQcRfV
         YSHnkWH5QtT7Nmnqh7UaEPHV1ijH7qgq2tOg2L/I4jclKK5JTrt6X7SGLWwx9QomW999
         7S8JEJRdCvnraQz2ErxcFWSQXHaWifE0WrDLK2yErSOFGy/V0nmLbef6e9xIJx3ORAwk
         K+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678361985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/fm4EqRCQX8P0V8IgQoUdGEPJ3+a5JFn9mYMwtSO3Q=;
        b=wGFk4PoB14gY6K/p9TXXHKkkTjalNG2OUar0xhriunz5c9MgQN+KtfHdA9VkfRbTCR
         DvtxpH6NueyIZ9qUULtH06gtI+9JvCINd4XBw9DcQF4+iblBJmYydYgJieQmSJ0mlXJ3
         CqkeXJFpXNNlC3DQYA4+s26OlZXCL6P9HzCICumxIePueeSb8h8GegWp8h8t3j8bCciW
         I38qiRyhLYyjE0kQczojZ2B0mvC4Vqgfa3esEZpeIrRnb1rvDAHFCG748DCZmQTObXMd
         Wvbjj/gwiMsk6li7MWWF+hKlKkx2xn/RC0ZOQqTYNMkQKnv/kJC95HpgGi4WUbij8Na6
         BKFQ==
X-Gm-Message-State: AO0yUKWA/5kN7hE+PyKLFCt96mUQ56TbTsUkp3GSoq3moTZ+Bnp96bAb
        3xG4zztDxZ0el9d4296yxYI=
X-Google-Smtp-Source: AK7set9QKUcxRVrUyzBPzAU0cb0zeeb5y7pCe8dkUsIrv4s0TRIbWUItLm1utqdEMYdS/g7S64hEyg==
X-Received: by 2002:a2e:8812:0:b0:298:7061:1172 with SMTP id x18-20020a2e8812000000b0029870611172mr1434269ljh.42.1678361985413;
        Thu, 09 Mar 2023 03:39:45 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id y13-20020a2e9d4d000000b00295965f7495sm2922373ljj.0.2023.03.09.03.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 03:39:44 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2] dt-bindings: nvmem: layouts: add fixed-layout
Date:   Thu,  9 Mar 2023 12:39:36 +0100
Message-Id: <20230309113936.20162-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

With the introduction of NVMEM layouts we should prefer and support
describing all NVMEM devices content in the "nvmem-layout" node. That
inludes using it for fixed NVMEM cells (those with hardcoded offset &
size).

This seems to be cleaner design and more explicit.

Introduce a binding allowing fixed NVMEM cells as a type of layout. To
avoid code duplication put shared part in the fixed-cell.yaml.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Use fixed-cell.yaml
---
 .../bindings/nvmem/layouts/fixed-cell.yaml    | 30 ++++++++++++
 .../bindings/nvmem/layouts/fixed-layout.yaml  | 49 +++++++++++++++++++
 .../bindings/nvmem/layouts/nvmem-layout.yaml  |  1 +
 .../devicetree/bindings/nvmem/nvmem.yaml      | 18 +------
 4 files changed, 81 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
new file mode 100644
index 000000000000..2c77d02052d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/layouts/fixed-cell.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Fixed offset & size NVMEM cell
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+properties:
+  reg:
+    maxItems: 1
+
+  bits:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - minimum: 0
+        maximum: 7
+        description:
+          Offset in bit within the address range specified by reg.
+      - minimum: 1
+        description:
+          Size in bit within the address range specified by reg.
+
+required:
+  - reg
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
new file mode 100644
index 000000000000..4c4a968bb302
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/layouts/fixed-layout.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVMEM layout for fixed NVMEM cells
+
+description:
+  Many NVMEM devices have hardcoded cells layout (offset and size of specific
+  NVMEM content doesn't change).
+
+  This binding allows defining such cells using NVMEM layout. It can be used on
+  top of any NVMEM device.
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+properties:
+  compatible:
+    const: fixed-layout
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+patternProperties:
+  "@[a-f0-9]+$":
+    type: object
+    $ref: fixed-cell.yaml
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    nvmem-layout {
+        compatible = "fixed-layout";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        calibration@4000 {
+            reg = <0x4000 0x100>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
index 8512ee538c4c..03da7848c713 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
@@ -18,6 +18,7 @@ description: |
   perform their parsing. The nvmem-layout container is here to describe these.
 
 oneOf:
+  - $ref: fixed-layout.yaml
   - $ref: kontron,sl28-vpd.yaml
   - $ref: onie,tlv-layout.yaml
 
diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index 75bb93dda9df..732162e9d13e 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -49,23 +49,7 @@ properties:
 patternProperties:
   "@[0-9a-f]+(,[0-7])?$":
     type: object
-
-    properties:
-      reg:
-        maxItems: 1
-        description:
-          Offset and size in bytes within the storage device.
-
-      bits:
-        $ref: /schemas/types.yaml#/definitions/uint32-array
-        items:
-          - minimum: 0
-            maximum: 7
-            description:
-              Offset in bit within the address range specified by reg.
-          - minimum: 1
-            description:
-              Size in bit within the address range specified by reg.
+    $ref: layouts/fixed-cell.yaml
 
 additionalProperties: true
 
-- 
2.34.1

