Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E656C2EB2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCUKY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjCUKYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:24:42 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398CC166DA;
        Tue, 21 Mar 2023 03:24:27 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a11so4443365lji.6;
        Tue, 21 Mar 2023 03:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679394265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcNwNDUcozJ4ihl03xpaC0MK0yzIXoC3GmNplcK5VuY=;
        b=SyoDu8ZMUOI+lX1BtyTlX1QnIVrvgtQR2ZmTBTIUIYIG1/bWFsPm1ACl3tv2f7elO6
         InRVkS9KlJmbSmlfcbMDiNulycEnUpkUV3V1mQShUq8bVOo8wNEEht8V+xCYxTOLXKT+
         jNyqnjxEdHfF8r8qceJ3RgCk8TL8uSFCtEfrfMlBhhHYDz9V5XibZron81KNl5wObMDB
         nUCZhy27UEGrEsMKYBRNXh1A0YD5+JZZclYEr6scZ2+3LOjnm6vF4psh7nn7fy8ow/hV
         DJSnNKb2bC5nqj4GaR8soTPKS73+l30w869VxUwDGW27aaspFUFAW2iW2Ewv4gf/Wn21
         hcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679394265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcNwNDUcozJ4ihl03xpaC0MK0yzIXoC3GmNplcK5VuY=;
        b=s3pWv+arR8co/SMgvFMSif4/VnOvVnpUoIqqWGmEH6BZmFHbwYtTdnk2MlRpJNHAre
         6lLWq4HIWqzbdQSvybhZLdxLo/Jd0ZSoLFoR88cAbJPkgF3KQYng6mMTF+P27DfhnL6I
         JJBmmDtVj1hJM4w6pZEa+dRTaKnyAvzn8+2owrT1KeqxBHQO2OrQrgB1whVuzo6r9zdf
         5PgTPuzvjl+bNjOpPVw4w74sab0rkC607c4DJQtNYuDkWY5ETVMIF938g9G+r7U17XMC
         P3l3u8TIi96Dd83WKUNI9dc6Et7gKW4HisK8jsRN5AOWgucLPV5zEl9rGeJpXrg1NCel
         lVwA==
X-Gm-Message-State: AO0yUKUyv5NE9BXSDjDtQAhII3lIX/qJYgCZUy95xkq/QJwBmefrPRIq
        r4AA3S3ud5itvBH+aIIA30M=
X-Google-Smtp-Source: AK7set+IM9gmx6+QFWFJYvP9ctTrbfbGNhaXDMHQHoVSU4YWYfWQQVBpzFK+9bYn9zaxfJVLZubw+g==
X-Received: by 2002:a05:651c:223:b0:29c:9223:2f6b with SMTP id z3-20020a05651c022300b0029c92232f6bmr669574ljn.30.1679394265330;
        Tue, 21 Mar 2023 03:24:25 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id n12-20020a2e904c000000b00299f0194108sm2163069ljg.31.2023.03.21.03.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 03:24:24 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V5 1/3] dt-bindings: nvmem: layouts: add fixed-layout
Date:   Tue, 21 Mar 2023 11:24:16 +0100
Message-Id: <20230321102418.4190-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321102418.4190-1-zajec5@gmail.com>
References: <20230321102418.4190-1-zajec5@gmail.com>
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

Having NVMEM cells in separated node is preferred as it draws a nice
line between NVMEM device and its content. It results in cleaner
bindings.

FWIW a very similar situation has happened to MTD devices and their
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

