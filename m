Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB50B6BEA0F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 14:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjCQN0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 09:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCQN0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 09:26:30 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0800020A2B;
        Fri, 17 Mar 2023 06:26:29 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b10so5106070ljr.0;
        Fri, 17 Mar 2023 06:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679059587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XerqNhTQ44trkSYUMxRxIaoPSVpfz3XqDhrYxWbrqsQ=;
        b=lrjCcYeTl+RE8SRvybZeprbvRsfQjiGUrulFeJ7cK4WF+F1Ka+zaBGMYRkxyAzosXn
         ImYa5pGAEh/9xNcvA7QDfeAFX5WIkMxzkHsNkmSnFe4uhCIis4tfl7a002r2TZRxwmwk
         3NC2fXvnzLcqINATHTB9Wdwp22sm9nbyTjuVS0S7Y+IkvVMRN2fugFsk7DSJTTL8aRH7
         L3iB8hFKwFrS93E6xYgll4/2OX9UCNSWnKj2Xa1NyaQ4xz2KCVO69UpGNGq6u4TSeoY/
         tHrc+7i6RhyVfjDkuA+zt3qHSiGQ/0F7l9L+4ZOUQJBEqt8VM19HzXxGY2/kr6swgxDk
         tNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679059587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XerqNhTQ44trkSYUMxRxIaoPSVpfz3XqDhrYxWbrqsQ=;
        b=0UxqS45Pc1sIloYRc0q5ZHTF61YWkItrTfqdMMnZNGyCMymtYVaDqi5oFdDZKzrPsv
         K6CUBlso660bGoTORfxQlonVXy30a7RT7A8nhrFfSc2ET3pZ5g8miUby+qsQ06yxZ2YI
         mtaTJ/qUjwBI5acWlAGDKygAZGQtgmHZkmYzpRC8rPOF0Pte6RNdroJx6lqCA+WYOiG7
         PFWF65ycDAEb2JoEUA0xuQ4LL9qeRy/Ug4NnxjBxIQ2fhy+4ORimWSwOJcqfVhFI2f+V
         GAhfvoIrhufIxC3cXHIVMKQ0MQvfl0P0VyYAUOBMD/Ld0f+D/+EJIgO8MI36S83ZJ4i7
         QUKQ==
X-Gm-Message-State: AO0yUKXTtcXbxQdKtsFa8fR0pdblK/33WX9sE7JsFyRywELgNjf5R46r
        uA6Hp+UirQ9oyZmFjZ45HPE=
X-Google-Smtp-Source: AK7set+zPv5Nqo5hRmQnKgqgahIWF20pv1SHi8BohqYCo7j6tf26NBF0vauDW66Nhi2yaaHAeRA2wg==
X-Received: by 2002:a05:651c:50b:b0:298:a864:8c14 with SMTP id o11-20020a05651c050b00b00298a8648c14mr4539380ljp.10.1679059587106;
        Fri, 17 Mar 2023 06:26:27 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id p15-20020a2e740f000000b00295b588d21dsm411083ljc.49.2023.03.17.06.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 06:26:26 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V4 1/4] dt-bindings: nvmem: layouts: add fixed-layout
Date:   Fri, 17 Mar 2023 14:26:17 +0100
Message-Id: <20230317132620.31142-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230317132620.31142-1-zajec5@gmail.com>
References: <20230317132620.31142-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

With the introduction of NVMEM layouts, new NVMEM content structures
should be defined as such. We should also try to convert / migrate
existing NVMEM content bindings to layouts.

This commit handles fixed NVMEM cells. So far they had to be defined
directly - as device subnodes. With this change it's allowed to put them
in the DT node named "nvmem-layout".

Having NVMEM cells in separated node is prefered as it draws a nice line
between NVMEM device and its content. It results in cleaner bindings.

FWIW a very similiar situation has happened to MTD devices and their
partitions: see commit 5d96ea42eb63 ("dt-bindings: mtd: Clarify all
partition subnodes").

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bindings/nvmem/layouts/fixed-cell.yaml    | 31 ++++++++++++
 .../bindings/nvmem/layouts/fixed-layout.yaml  | 49 +++++++++++++++++++
 .../bindings/nvmem/layouts/nvmem-layout.yaml  |  5 +-
 .../devicetree/bindings/nvmem/nvmem.yaml      | 19 +------
 4 files changed, 83 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
new file mode 100644
index 000000000000..e698098450e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
@@ -0,0 +1,31 @@
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
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
new file mode 100644
index 000000000000..f7496ba28f33
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
+  Many NVMEM devices have hardcoded cells layout (offset and size of defined
+  NVMEM content doesn't change).
+
+  This binding allows defining such NVMEM layout with its cells. It can be used
+  on top of any NVMEM device.
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
index 8512ee538c4c..3b40f7880774 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
@@ -18,16 +18,13 @@ description: |
   perform their parsing. The nvmem-layout container is here to describe these.
 
 oneOf:
+  - $ref: fixed-layout.yaml
   - $ref: kontron,sl28-vpd.yaml
   - $ref: onie,tlv-layout.yaml
 
 properties:
   compatible: true
 
-  '#address-cells': false
-
-  '#size-cells': false
-
 required:
   - compatible
 
diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index 75bb93dda9df..b79f1bb795fb 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -49,23 +49,8 @@ properties:
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
+    deprecated: true
 
 additionalProperties: true
 
-- 
2.34.1

