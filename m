Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5847C619D81
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiKDQj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiKDQir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:38:47 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958952E68D;
        Fri,  4 Nov 2022 09:38:44 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3E999C000E;
        Fri,  4 Nov 2022 16:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667579923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+IAKdycEjB3JSBVjZSTycHnanjluSD4CNhAulpC1qcM=;
        b=li/4x+t9JqVt/eqjBbXqkyPTrk/zyd+3f2YWAKuTLw56hokHnO6zCEavs/7/GKTe2Tlwtu
        OwM8suBPNdfWZKU58reA1Q5ZBachcHcTtpQ5epx9AWNoRi/UfgzDnOvzorN1kxf8Vu7hsJ
        9UBeGDkzybqSeESNV4DBZEjjMAz2GhI9S1G4NqneiOIqF5VLo90ZfRCjQxtAluNa5afj+5
        W2HeJ7eZ5dp/BOF1nQ6EpXQ+1Ye6ODhuvqeCBeFbnW5zIaiRvBuBxniY3+yH6pVQ4Wfofp
        U9Epm0S7Z21HkSCd/fyiuOmKrtlTHmvVI1aQwIUx/VZKeg3Z2czZNYbnTkTKlw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christian Eggers <ceggers@arri.de>,
        Cory Tusar <cory.tusar@pid1solutions.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 6/6] dt-bindings: nvmem: add YAML schema for the ONIE tlv layout
Date:   Fri,  4 Nov 2022 17:38:33 +0100
Message-Id: <20221104163833.1289857-7-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104163833.1289857-1-miquel.raynal@bootlin.com>
References: <20221104163833.1289857-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a schema for the ONIE tlv NVMEM layout that can be found on any ONIE
compatible networking device.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../bindings/nvmem/layouts/nvmem-layout.yaml  |   1 +
 .../nvmem/layouts/onie,tlv-layout.yaml        | 115 ++++++++++++++++++
 2 files changed, 116 insertions(+)
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
index 000000000000..1d91277324ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
@@ -0,0 +1,115 @@
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
+properties:
+  compatible:
+    const: onie,tlv-layout
+
+  product-name: true
+
+  part-number: true
+
+  serial-number: true
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
+  manufacture-date: true
+
+  device-version: true
+
+  label-revision: true
+
+  platforn-name: true
+
+  onie-version: true
+
+  num-macs: true
+
+  manufacturer: true
+
+  country-code: true
+
+  vendor: true
+
+  diag-version: true
+
+  service-tag: true
+
+  vendor-extension: true
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

