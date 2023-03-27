Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8682B6CA753
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjC0OS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjC0OSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:18:06 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A496A64;
        Mon, 27 Mar 2023 07:16:19 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id h11so4696055lfu.8;
        Mon, 27 Mar 2023 07:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679926577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzCwekFGfxzs1CDNjeDV7r4j31xaEPMaYXmxUiOdDtk=;
        b=jkSlOjGPwovb56Z9OU+zzP1erojmRSVnXihJEmA/6boY4vkMTFK1XwgnXyvJi8JqHj
         /pjpPjtDhAyVMD5uJbJ1J3qeJ9tBx7vAFcFAFjgywDKPQ0L2dS0++bvVSsNbqIbWFGZH
         BnAAEbGlNIqKKZ93KwUIa7hvj0ySvlpvdq0xZo61R4NzbrZAB7P3BmiCJ+urmHXYqNtZ
         WFL6stshmFIY83e/+JV1BkX3hv/6ALDvocypKQzStSW47Vl4blGX6qPiFp+T8GfVuheP
         pdZ5t5OwV6U+ypBwDjCoVd9ii2ChkAZ6lresRuyC93P6H3/iLAw3V1+0Xrm+yiuB7eIP
         AmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679926577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzCwekFGfxzs1CDNjeDV7r4j31xaEPMaYXmxUiOdDtk=;
        b=NCIWc39iUr/GTaJKcDGQ6Ftt9CC6zU7oGSP0I9Z/ughGcyodxo2ZLKd7F0pJdOO7uJ
         ZBRihDi8hFWrHXGZcMfS0Wn1RbHdQK9lWCbxB4oQy4JgIm9C9pNAl9aA7lQenG5mgUc7
         VegHIdFWSwI3T05ZQkUXjgHNIxQ0uyCp0aLwg8xHBY56PnZSSPCWBRxAQRE5BvcVt7qD
         onWfFts/QzUggoxgVfJhp3zXEjb1M4iaZr+qmdiVpx7Z1dTzFdOsNstlU8n0nXYHaPLu
         C4EWpYbnWGtnDe5WVPMeao26JotVU0lB8dNCLP74xUV72OMUjWK/5iIIRmJlpkXLZijb
         9GEA==
X-Gm-Message-State: AAQBX9cMSshd5jmt7EqOevy9YMLBYFgHB1QQYg77vkdbaDw3MUSjR6Ks
        AlvG4/HEws0+zrR1n+GWrC4=
X-Google-Smtp-Source: AKy350ainV6iC5gic5XaaKtVh+/1mcO1aPMsD/jqNOYyxIjzmWLxbVX6CY5FfN6Dv8HILjcVxB2pkA==
X-Received: by 2002:ac2:484a:0:b0:4dd:a73f:aede with SMTP id 10-20020ac2484a000000b004dda73faedemr3095133lfy.10.1679926577303;
        Mon, 27 Mar 2023 07:16:17 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id w3-20020ac24423000000b004e977970721sm4444519lfl.219.2023.03.27.07.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 07:16:16 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V6 1/3] dt-bindings: nvmem: layouts: add fixed-layout
Date:   Mon, 27 Mar 2023 16:16:09 +0200
Message-Id: <20230327141611.25131-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327141611.25131-1-zajec5@gmail.com>
References: <20230327141611.25131-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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
V6: Add unevaluatedProperties: false
---
 .../bindings/nvmem/layouts/fixed-cell.yaml    | 31 ++++++++++++
 .../bindings/nvmem/layouts/fixed-layout.yaml  | 50 +++++++++++++++++++
 .../bindings/nvmem/layouts/nvmem-layout.yaml  |  5 +-
 .../devicetree/bindings/nvmem/nvmem.yaml      | 19 +------
 4 files changed, 84 insertions(+), 21 deletions(-)
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
index 000000000000..c271537d0714
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
@@ -0,0 +1,50 @@
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
+    unevaluatedProperties: false
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

