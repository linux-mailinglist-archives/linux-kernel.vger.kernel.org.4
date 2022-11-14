Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B85362788F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbiKNJEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236815AbiKNJDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:03:49 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB791D643;
        Mon, 14 Nov 2022 01:03:47 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 089E8FF814;
        Mon, 14 Nov 2022 09:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668416626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9dJEc1+k308koWh3qlEAPGOXzHpFninitXpbK03A4Gs=;
        b=L+e4cEYFuSXg05G3UhHC4xTMcufckNXW9ulOWm+MzLx3GWuEoahJNEXOPvO4xl6kIObLXD
        OLTGhK/1l8TRH6kfM+iinGQXrjsw8jvH3uV6SBEOL4xOrQEHjjyS/3Em7XLzox5YTwdXDB
        Fv0oUQxIgRYdZdQdEsSbsWByVu7l9KIcck7yYaQxPHA4yEMDX0B00RVwZvqO12Juvdqc84
        8ipDDdQ+IaEGkjEJJOFi0EffoilgbLpMqZ4f0CA8eQkFux7JweJvrS2XGoEtr2mqjjibb9
        l/oxzv5p/6UTuV6j7xd28C+UfPonkm4OJ3wqs1Ih0hpQsZcXwnaX9aS0pcdRUw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 10/17] dt-bindings: mtd: physmap: Reuse the generic definitions
Date:   Mon, 14 Nov 2022 10:03:08 +0100
Message-Id: <20221114090315.848208-11-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114090315.848208-1-miquel.raynal@bootlin.com>
References: <20221114090315.848208-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
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

The memory mapped MTD devices also share a lot with all the other MTD
devices, so let's share the properties by referencing mtd.yaml. We can
then drop mentioning the properties, to the cost of mentioning the
possible "sram" node name prefix.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

