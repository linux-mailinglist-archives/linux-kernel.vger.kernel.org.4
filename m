Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6008562784E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbiKNI5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbiKNI5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:57:23 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FED91CFF9;
        Mon, 14 Nov 2022 00:57:15 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DEABA100008;
        Mon, 14 Nov 2022 08:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668416233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4HG/iT/mzETZVhKM6zL2vs6fGxz+0PlYq2xmoenZCzQ=;
        b=EE2EyoU2XiXxfqcb5iTj6B8Fx0GBBnzPeUpEidTGTu0cRaS/hm3IBaTeoocAa8NCp+tJOp
        hwsBz3GcxksSXT2WgC2hqrQ76AGhDIUF5ArdknTdPPqlbgdp6J2+IA25OZPy4uC00ax/VS
        AmQUHbrQjuxCImRZNjYbJVgyJuFQCKXK0Us6x3RBNK6yb/lA4Rz7IA2BeoUrAg1Mst/vf0
        X6tf6pRAkCXVIbp/48/CVk+CaMiNbny6ZyCE5FrGtbX6m5lik8/SkN+3KDn24MZjHV+7pY
        L4SkKDj+3wG7oOHt+xjSfXwuV3CF7LFul1CgI7vVhzONJ2FYN+wkDUBZ8RXtsQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 5/5] dt-bindings: nvmem: add YAML schema for the ONIE tlv layout
Date:   Mon, 14 Nov 2022 09:56:59 +0100
Message-Id: <20221114085659.847611-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114085659.847611-1-miquel.raynal@bootlin.com>
References: <20221114085659.847611-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a schema for the ONIE tlv NVMEM layout that can be found on any ONIE
compatible networking device.

Describe all the possible NVMEM cells that can be produced by this
layout parser.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
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
2.34.1

