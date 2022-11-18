Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2196362EDD1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241227AbiKRGlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241232AbiKRGkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:40:22 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24EE9B3A6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:40:09 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i186-20020a1c3bc3000000b003cfe29a5733so6819313wma.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bj0RYfTA9vPDpy3KmDK11XXmVUXWJHQPReToyWDFygo=;
        b=de8GdCUwkA8s4uu+/K0FIEh27UTpRIvYKXMzz3TzGX79tBSPeTsxhSX4HQ+OOPXF8a
         IZW+lCbgmDktjP6ljFP+OHB14DLqrXJjYYJy0omWX4XAz7QZ9mQcxQwccE8+u43Z0W1m
         vf9siDzhh52qPQG89HpAe33UCpMIC18n4zN8H7cE84b3bqgNI/IR8J4CRplPI5D1l6fZ
         umun//DdS+huTNnqMVHGT1pNKRbbFPekRu5Rc+LMOLB+so3y1KGYKJMUWU4wNuvBgKB7
         Le5c32D3F+sGDiuD9p+NuOA9LKjvpBh1bqsjRi3wQY/byI41dYopQjdfantNgekttDOg
         sT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bj0RYfTA9vPDpy3KmDK11XXmVUXWJHQPReToyWDFygo=;
        b=yfgOF8tkgA9JP8Mj/KdVHJwZkYKkT02FLrBBenlrslFPWRNuH+htVBa7BoraToL/J+
         Ggfkc5oA0yKTFJoG3k23Ib0I5Qcl/nlnYidwgdB2EsrQ/OT2HAYBcQnSto2FO18LNv7o
         K5o8hgomayH9LVRfKjO6NFCuggR8v0zEO9bIf2JaP7SjOVWseSrnV8vk4crWDR5sdPqI
         dS0eGVp/vHop3hO8gZuQ/GHEeGyo2ajGCpJBeRw0F32a+JyYmY8GOGKAIkg2/kyn52tL
         Q3KfR8mCKfTIWjRZpjyHq7ArpUkDKxPweH3QHiOuEl9wDeuTbQX3/O8Zb5pdvG+ExqOM
         HDJg==
X-Gm-Message-State: ANoB5pmt9vaUH/LizgAYkLlo++BP+DclrpsZcR4Kz71QykVyr/TgDmnY
        K90d8KNhRYRQO5J4IqJc3EHAsA==
X-Google-Smtp-Source: AA0mqf48z4Q4+VhZr/KS5wzWok/SYFjpD0h46qcj0RYUJA3BsNqcYeAEkuij9EFtlGD/SGCEwAhhlg==
X-Received: by 2002:a7b:c3c9:0:b0:3cf:5442:bbe with SMTP id t9-20020a7bc3c9000000b003cf54420bbemr7562440wmj.2.1668753609224;
        Thu, 17 Nov 2022 22:40:09 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id j13-20020adff54d000000b0023655e51c33sm2785902wrp.4.2022.11.17.22.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:40:08 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 13/13] dt-bindings: nvmem: add YAML schema for the ONIE tlv layout
Date:   Fri, 18 Nov 2022 06:39:32 +0000
Message-Id: <20221118063932.6418-14-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118063932.6418-1-srinivas.kandagatla@linaro.org>
References: <20221118063932.6418-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

Add a schema for the ONIE tlv NVMEM layout that can be found on any ONIE
compatible networking device.

Describe all the possible NVMEM cells that can be produced by this
layout parser.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/layouts/nvmem-layout.yaml  |   1 +
 .../nvmem/layouts/onie,tlv-layout.yaml        | 147 ++++++++++++++++++
 2 files changed, 148 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
index f64ea2fa362d..8512ee538c4c 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
@@ -19,6 +19,7 @@ description: |
 
 oneOf:
   - $ref: kontron,sl28-vpd.yaml
+  - $ref: onie,tlv-layout.yaml
 
 properties:
   compatible: true
diff --git a/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
new file mode 100644
index 000000000000..5a0e7671aa3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
@@ -0,0 +1,147 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/layouts/onie,tlv-layout.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVMEM layout of the ONIE tlv table
+
+maintainers:
+  - Miquel Raynal <miquel.raynal@bootlin.com>
+
+description:
+  Modern networking hardware implementing the Open Compute Project ONIE
+  infrastructure shall provide a non-volatile memory with a table whose the
+  content is well specified and gives many information about the manufacturer
+  (name, country of manufacture, etc) as well as device caracteristics (serial
+  number, hardware version, mac addresses, etc). The underlaying device type
+  (flash, EEPROM,...) is not specified. The exact location of each value is also
+  dynamic and should be discovered at run time because it depends on the
+  parameters the manufacturer decided to embed.
+
+select: false
+
+properties:
+  compatible:
+    const: onie,tlv-layout
+
+  product-name:
+    type: object
+    additionalProperties: false
+
+  part-number:
+    type: object
+    additionalProperties: false
+
+  serial-number:
+    type: object
+    additionalProperties: false
+
+  mac-address:
+    type: object
+    description:
+      Base MAC address for all on-module network interfaces. The first
+      argument of the phandle will be treated as an offset.
+
+    properties:
+      "#nvmem-cell-cells":
+        const: 1
+
+    additionalProperties: false
+
+  manufacture-date:
+    type: object
+    additionalProperties: false
+
+  device-version:
+    type: object
+    additionalProperties: false
+
+  label-revision:
+    type: object
+    additionalProperties: false
+
+  platforn-name:
+    type: object
+    additionalProperties: false
+
+  onie-version:
+    type: object
+    additionalProperties: false
+
+  num-macs:
+    type: object
+    additionalProperties: false
+
+  manufacturer:
+    type: object
+    additionalProperties: false
+
+  country-code:
+    type: object
+    additionalProperties: false
+
+  vendor:
+    type: object
+    additionalProperties: false
+
+  diag-version:
+    type: object
+    additionalProperties: false
+
+  service-tag:
+    type: object
+    additionalProperties: false
+
+  vendor-extension:
+    type: object
+    additionalProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        eeprom@56 {
+            compatible = "atmel,24c64";
+            read-only;
+            reg = <0x56>;
+
+            nvmem-layout {
+                compatible = "onie,tlv-layout";
+
+                serial-number {
+                };
+            };
+        };
+    };
+
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+            compatible = "m25p80", "jedec,spi-nor";
+            reg = <0>;
+
+            otp {
+                compatible = "user-otp";
+
+                nvmem-layout {
+                    compatible = "onie,tlv-layout";
+
+                    mac-address {
+                        #nvmem-cell-cells = <1>;
+                    };
+                };
+            };
+        };
+    };
+...
-- 
2.25.1

