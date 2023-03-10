Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529216B37C7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 08:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCJHwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 02:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCJHv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:51:57 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DEA4D623;
        Thu,  9 Mar 2023 23:51:53 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id t11so5511848lfr.1;
        Thu, 09 Mar 2023 23:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678434711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dSvrEGI+uoyv24JgYrwpkPVQsX79o64BEHwkCt2g1VA=;
        b=QjThHmdlGK2LmK/+Fm6SZlP++4KyzgkHjOlEpTQAeiJhVeJaV+7xOGdyGUy789BJz0
         ILwFJy+9BMtQnjrvFX2uale4L94eyfcmBq4NHcsruzPqfUSG0BHT6soeFm08f8JjaVdT
         75msOZFT3YyREY6PvwrTpP0b6FOalOmEkvZ2cQ0czTS3yk6yiaVDBQECXHAiQts3XOY/
         Ubvpz1uEOeQX/AFj4JplfpiPMxISbNaWeLuXPWQTL6uRGjqDXFzQLHTL5CwDK2QfyJbq
         CK01hlgs+7HjwS1JjkyVDfgB9+uN/36BqSr1qUBCjgqd8/ko36HhZNCl3UMxgGDCnY5F
         i1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678434711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSvrEGI+uoyv24JgYrwpkPVQsX79o64BEHwkCt2g1VA=;
        b=vAd9y0qQJxHvFWAoHvcxNHCkyp76RtxJ4VrUsZFQ26anQPf2MVwD4yhCI5R/xbuVf9
         2rWwGoi+drvBYAdj5MMcYRk/KJPtHN7n9o42lGhK7afIrlp7iqDnundQYt5jPOWgWRc2
         hmLiFqf6FjKcLo9p2SCRz+BOSoD+sk26ZI89gUORa2ciHoKITg/LW5bfVp6caSDPCFTN
         P9uZtiWJLW38vwswPJN8NTPZsTngS+QPlRE49VWFKWG8TNVeGJTouio7bt7Yf4M5Vl/9
         ZzJsy+99M4Ly+pkD0aY6K1QO9e+Q9I/U94Evla3ZAOWWe5ADuq9/ZmWOTCUs5U/2w9Xs
         yPqQ==
X-Gm-Message-State: AO0yUKWwgW81PC4AYRCSCg/bmELP1CiuFPPu+jwrCazkq3gYKHzb3eHq
        U7rtp001w4gwwYmr6dvwbMQ=
X-Google-Smtp-Source: AK7set9miUc/KYMTh+l3zkEbanrOY6YgTpcyx5fwqC2wMJEFsxJdI0u7WBitijMrNCtKqQVDbYzErA==
X-Received: by 2002:a19:5211:0:b0:4d7:b818:788d with SMTP id m17-20020a195211000000b004d7b818788dmr8011531lfb.23.1678434711324;
        Thu, 09 Mar 2023 23:51:51 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id l27-20020ac2555b000000b004b5480edf67sm162066lfk.36.2023.03.09.23.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 23:51:50 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V3] dt-bindings: nvmem: layouts: add fixed-layout
Date:   Fri, 10 Mar 2023 08:51:44 +0100
Message-Id: <20230310075145.3996-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
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

With the introduction of NVMEM layouts we should prefer and support
describing all NVMEM devices content in the "nvmem-layout" node. That
inludes using it for fixed NVMEM cells (those with hardcoded offset &
size).

This seems to be cleaner design and more explicit.

Introduce a binding allowing fixed NVMEM cells as a type of layout. To
avoid code duplication put shared part in the fixed-cell.yaml.

My plan is to deprecate old binding (NVMEM cells put directly in the
device node) in next 2 months or so.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Use fixed-cell.yaml
V3: Update commit description
    Allow additionalProperties (used by st,stm32-romem.yaml)
    Allow #address-cells and #size-cells
---
 .../bindings/nvmem/layouts/fixed-cell.yaml    | 30 ++++++++++++
 .../bindings/nvmem/layouts/fixed-layout.yaml  | 49 +++++++++++++++++++
 .../bindings/nvmem/layouts/nvmem-layout.yaml  |  5 +-
 .../devicetree/bindings/nvmem/nvmem.yaml      | 18 +------
 4 files changed, 81 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
new file mode 100644
index 000000000000..a27a32424d69
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
+additionalProperties: true
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

