Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB93619D9A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiKDQr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiKDQrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:47:24 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836BA31EFC;
        Fri,  4 Nov 2022 09:47:22 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6286A4000A;
        Fri,  4 Nov 2022 16:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667580441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9JEZ1c2lp6KpEcCyVREwYutRhrJJex3PSE0UiYvaYr4=;
        b=Em0KXUoGDMROIrOx9PdU72KhBktqNT1SHNCvhQpHbvfiBKU28pFDzVM9/QGxx8mLC8rEKf
        U6UTIs6mEVebIvcrw9Q66Sdgcd1u1RpCb+qJ4ChoHHZIafC27i39MPLzQkI7C/UKRwQwnn
        HNPyZ+N0XFrZFflHRXRqJh/ZUduxVtW9UHGyy/7JtY9NSsnAroyJFUoP/Awi/zfZEoRScO
        LhcAXvDu3epR5+Or5MJupp8Mdn0SyX2Ynolqno4cyt2sk/eZYwhcgUppPXv3HG2Kv6naqQ
        +1HXxb4q7IhEdZrvAmQBy+FOS7Bo34XKl8jZk9Q/maBxzLTl3t7HvZ1TB842LQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 01/17] dt-bindings: mtd: Clarify all partition subnodes
Date:   Fri,  4 Nov 2022 17:47:02 +0100
Message-Id: <20221104164718.1290859-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104164718.1290859-1-miquel.raynal@bootlin.com>
References: <20221104164718.1290859-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Over time the various ways to define MTD partitions has evolved. Most of
the controllers support several different bindings. Let's define all
possible choices in one file and mark the legacy ones deprecated. This
way, we can just reference this file and avoid dupplicating these
definitions.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../devicetree/bindings/mtd/mtd.yaml          | 17 ++++++++++
 .../bindings/mtd/partitions/partitions.yaml   | 33 +++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/partitions.yaml

diff --git a/Documentation/devicetree/bindings/mtd/mtd.yaml b/Documentation/devicetree/bindings/mtd/mtd.yaml
index 3498e485679b..a6b498bbdbb6 100644
--- a/Documentation/devicetree/bindings/mtd/mtd.yaml
+++ b/Documentation/devicetree/bindings/mtd/mtd.yaml
@@ -21,7 +21,24 @@ properties:
       based name) in order to ease flash device identification and/or
       describe what they are used for.
 
+  '#address-cells':
+    deprecated: true
+
+  '#size-cells':
+    deprecated: true
+
+  partitions:
+    $ref: /schemas/mtd/partitions/partitions.yaml
+
 patternProperties:
+  "@[0-9a-f]+$":
+    $ref: partitions/partition.yaml
+    deprecated: true
+
+  "^partition@[0-9a-f]+":
+    $ref: partitions/partition.yaml
+    deprecated: true
+
   "^otp(-[0-9]+)?$":
     type: object
     $ref: ../nvmem/nvmem.yaml#
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
new file mode 100644
index 000000000000..ff65795de285
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/partitions.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Partitions
+
+description: |
+  This binding is generic and describes the content of the partitions container
+  node. All partition parsers must be referenced here.
+
+maintainers:
+  - Miquel Raynal <miquel.raynal@bootlin.com>
+
+properties:
+  compatible: true
+
+  '#address-cells':
+    enum: [1, 2]
+
+  '#size-cells':
+    enum: [1, 2]
+
+patternProperties:
+  "partition(-.+|@[0-9a-f]+)":
+    $ref: partition.yaml
+
+required:
+  - compatible
+
+# Temporary value, should be set to false when constraining the parsers list
+additionalProperties: true
-- 
2.34.1

