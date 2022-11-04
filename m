Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02CC619DB0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiKDQsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiKDQrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:47:42 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62634045D;
        Fri,  4 Nov 2022 09:47:32 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9DC7440004;
        Fri,  4 Nov 2022 16:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667580451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tjavzH+cgvyVn10sIb3TajzzynkuJ4IjBmZ/bGLtnUI=;
        b=OEYTCO5+4f36WFPpc931MekHiJo1gUYCq+KWG53vJbjkgQGYJG/FLJU2nn6v3KueuYtvP5
        Xu70MwSLsenRIdoI+yZQvNwdAjNoo0PY5RuzBR5fet+XGITeAYsvMMlZS89wmO03SZDJuV
        iQC0EoBDG+Q2XEt5I6QpneA22c/26gihS0xO+cceDd+QJtB1I+4TiU8ZZjEBNYCstJo2HH
        X9YpT1MTaiC4QV2ZvbKhXAIiAXn00+vZtVBX5UIxyl7FjabYesVRvyJOMwTGWgfPZbtPQw
        oBfGZS/czSyRKVeWVNEvbAQXQSN5zfvl9LFUCb4zHVphaLIOSsXI0hXLmtMrjw==
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
Subject: [PATCH v2 10/17] dt-bindings: mtd: physmap: Reuse the generic definitions
Date:   Fri,  4 Nov 2022 17:47:11 +0100
Message-Id: <20221104164718.1290859-11-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104164718.1290859-1-miquel.raynal@bootlin.com>
References: <20221104164718.1290859-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory mapped MTD devices also share a lot with all the other MTD
devices, so let's share the properties by referencing mtd.yaml. We can
then drop mentioning the properties, to the cost of mentioning the
possible "sram" node name prefix.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 Documentation/devicetree/bindings/mtd/mtd-physmap.yaml     | 7 +++----
 Documentation/devicetree/bindings/mtd/mtd.yaml             | 2 +-
 Documentation/devicetree/bindings/mtd/nand-controller.yaml | 1 -
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/mtd-physmap.yaml b/Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
index 82eb4e0f453b..5df94953c34e 100644
--- a/Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
+++ b/Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
@@ -13,6 +13,9 @@ description: |
   Flash chips (Memory Technology Devices) are often used for solid state
   file systems on embedded devices.
 
+allOf:
+  - $ref: "mtd.yaml#"
+
 properties:
   compatible:
     oneOf:
@@ -121,10 +124,6 @@ properties:
   big-endian: true
   little-endian: true
 
-patternProperties:
-  '@[0-9a-f]+$':
-    $ref: partitions/partition.yaml
-
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/mtd/mtd.yaml b/Documentation/devicetree/bindings/mtd/mtd.yaml
index a6b498bbdbb6..2fbd0a2ff548 100644
--- a/Documentation/devicetree/bindings/mtd/mtd.yaml
+++ b/Documentation/devicetree/bindings/mtd/mtd.yaml
@@ -12,7 +12,7 @@ maintainers:
 
 properties:
   $nodename:
-    pattern: "^flash(@.*)?$"
+    pattern: "^(flash|.*sram)(@.*)?$"
 
   label:
     description:
diff --git a/Documentation/devicetree/bindings/mtd/nand-controller.yaml b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
index 359a015d4e5a..3f2a1480e1eb 100644
--- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
@@ -51,7 +51,6 @@ properties:
 
 patternProperties:
   "^nand@[a-f0-9]$":
-    type: object
     $ref: "nand-chip.yaml#"
 
     properties:
-- 
2.34.1

