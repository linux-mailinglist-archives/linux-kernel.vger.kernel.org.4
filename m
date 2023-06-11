Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E89A72B23D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbjFKOGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbjFKOFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:05:35 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14AB171F
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-30fc1514745so121670f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492255; x=1689084255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azjKdj8b7XoVy/9UtuYdjujBmrwXfwdg3TbW+5n+OsQ=;
        b=nubvMNHiCJd7/tx2zPwug9ueUDZ4l4sKxhVK21AclPLaW+1ffycvS6ai4izJMSWOh9
         enYdU1xMjovOcnuHvN7VPOK3PRU2gdpXPeVsibpARFlKnlfIWSqMC9ayJA3dSYWcHB1o
         9rcnPrrI0CIYT9Kw9+i5kZxzQ8KYo2BUcELzQD6TLe/BLqzgf7g0OyMTdaJwgCfeaRFE
         S6gnQIhjETwAdlhE4Xa+KzhEkBJF1z/AeUQjbI64/v5JOJPTnEMl0j76+Mf8IknfhD80
         kzE7u6R7B5izZ45/Xb+th1OQ9VNll9z9f3exfDcHucu5PrBjGYlt5I995vQRj4KMVMRM
         QdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492255; x=1689084255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azjKdj8b7XoVy/9UtuYdjujBmrwXfwdg3TbW+5n+OsQ=;
        b=OTEeAu0EmnCjyzGU7bbC708tKRye+e32PFFhgaYlIMhCPKEAG3FiaAn9wgpDKxRRRJ
         xZ1X9WbNKb6TalnPBvBgSmjM/sJhCZrB0GVaysyCPeDVnuxyjmce95p96qdWXTSM8PaZ
         pRg7uhpFtMKXTqZw1CVBwWjpVySzda1q54hCQ7e1X5KGBFSh8Gkjwv2mmH7koIidFckz
         dT/Kbcv7fcfbXDa4AAtVOPFWNaCpEpD0765b+QW/76jwh73I7SmaaIgQZegO4ZWSLvfy
         HZKW+aTLYn0b3RuUfgvcDKCkrz5nkycAgo9y9XiLQLfuTfcDzq+5ikC2PXQjV/ivJdPr
         /eFw==
X-Gm-Message-State: AC+VfDxk8yQ+f11TvEOJX0rscbQyD4LmzaAMnkoM+OzNvsngmO00kZth
        oWc2Xj6Ww/081cWb1CFr9B97SQ==
X-Google-Smtp-Source: ACHHUZ7DunGFZ/nJf/OT0j8Y2iNTSzmZC2RozZiJzvataDqEf0cQ/YP7N0eRUCIEmQGMMqQL1uKNlQ==
X-Received: by 2002:a05:6000:1a4f:b0:30a:e479:66a2 with SMTP id t15-20020a0560001a4f00b0030ae47966a2mr3468256wry.37.1686492255206;
        Sun, 11 Jun 2023 07:04:15 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:04:14 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 23/26] dt-bindings: nvmem: layouts: add fixed-layout
Date:   Sun, 11 Jun 2023 15:03:27 +0100
Message-Id: <20230611140330.154222-24-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
References: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
2.25.1

