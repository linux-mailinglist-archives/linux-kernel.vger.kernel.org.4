Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E87A619DAF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbiKDQsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiKDQrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:47:42 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F1640463;
        Fri,  4 Nov 2022 09:47:33 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8FCE040012;
        Fri,  4 Nov 2022 16:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667580452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p71j8d2SmYLQ6c2itM9CC/tES1wHjKai9EtqL7pWA8U=;
        b=jN7KeFvPpX1StScCgwr0C9ycidffQZWu3+18tklZTArlCIdwx6LtVCF7SmU0tqs97QYjLC
        FUw+0NnuWmfkx+74JbXv5caNYvwJHz+8P1IGuuNgDhoX2ZvIxYkjCS3NFSjJB2A5T//ZtI
        AI1RB7TpdIsRaOnWthXrcihCqlYZvGuK+KV5mFSHZDkThhOLCDKN+tIUFZBS1WB0TwRRPL
        eoxdGE5PPt5C3/+TxCawJYUtGI6a7EltTFeNIaCVXtvcnspw8lg/ZFlgnMydu2qjxv9fgl
        dcUTwJCMT3+4vdF7zZ/3PX1A81xPMwYee/c+xyrBfmXRBh4/VHp2sGIwssRwTw==
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
Subject: [PATCH v2 11/17] dt-bindings: mtd: partitions: Constrain the list of parsers
Date:   Fri,  4 Nov 2022 17:47:12 +0100
Message-Id: <20221104164718.1290859-12-miquel.raynal@bootlin.com>
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

Parser compatibles cannot be used anywhere, and the list is limited. In
order to constrain this list, enumerate them all under the top
"partitions" subnode. New parsers will have to add their own compatible
here as well.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 Documentation/devicetree/bindings/mtd/mtd.yaml       |  3 +++
 .../mtd/partitions/arm,arm-firmware-suite.yaml       |  2 ++
 .../mtd/partitions/brcm,bcm4908-partitions.yaml      |  2 ++
 .../mtd/partitions/brcm,bcm947xx-cfe-partitions.yaml |  2 ++
 .../mtd/partitions/linksys,ns-partitions.yaml        |  2 ++
 .../bindings/mtd/partitions/partitions.yaml          | 12 ++++++++++--
 .../bindings/mtd/partitions/qcom,smem-part.yaml      |  2 ++
 .../bindings/mtd/partitions/redboot-fis.yaml         |  6 ++++++
 8 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/mtd.yaml b/Documentation/devicetree/bindings/mtd/mtd.yaml
index 2fbd0a2ff548..2494ec2d80e3 100644
--- a/Documentation/devicetree/bindings/mtd/mtd.yaml
+++ b/Documentation/devicetree/bindings/mtd/mtd.yaml
@@ -30,6 +30,9 @@ properties:
   partitions:
     $ref: /schemas/mtd/partitions/partitions.yaml
 
+    required:
+      - compatible
+
 patternProperties:
   "@[0-9a-f]+$":
     $ref: partitions/partition.yaml
diff --git a/Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.yaml b/Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.yaml
index 76c88027b6d2..97618847ee35 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.yaml
@@ -9,6 +9,8 @@ title: ARM Firmware Suite (AFS) Partitions
 maintainers:
   - Linus Walleij <linus.walleij@linaro.org>
 
+select: false
+
 description: |
   The ARM Firmware Suite is a flash partitioning system found on the
   ARM reference designs: Integrator AP, Integrator CP, Versatile AB,
diff --git a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
index 7b113e5e3421..5bbb1c01ddee 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
@@ -17,6 +17,8 @@ description: |
 maintainers:
   - Rafał Miłecki <rafal@milecki.pl>
 
+select: false
+
 properties:
   compatible:
     const: brcm,bcm4908-partitions
diff --git a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm947xx-cfe-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm947xx-cfe-partitions.yaml
index 3484e06d6bcb..939e7b50db22 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm947xx-cfe-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm947xx-cfe-partitions.yaml
@@ -35,6 +35,8 @@ description: |
 maintainers:
   - Rafał Miłecki <rafal@milecki.pl>
 
+select: false
+
 properties:
   compatible:
     const: brcm,bcm947xx-cfe-partitions
diff --git a/Documentation/devicetree/bindings/mtd/partitions/linksys,ns-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/linksys,ns-partitions.yaml
index 99249cdfbfb3..213858f60375 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/linksys,ns-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/linksys,ns-partitions.yaml
@@ -18,6 +18,8 @@ description: |
 maintainers:
   - Rafał Miłecki <rafal@milecki.pl>
 
+select: false
+
 properties:
   compatible:
     const: linksys,ns-partitions
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
index ff65795de285..9aca4e6c6047 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
@@ -13,6 +13,15 @@ description: |
 maintainers:
   - Miquel Raynal <miquel.raynal@bootlin.com>
 
+oneOf:
+  - $ref: arm,arm-firmware-suite.yaml
+  - $ref: brcm,bcm4908-partitions.yaml
+  - $ref: brcm,bcm947xx-cfe-partitions.yaml
+  - $ref: fixed-partitions.yaml
+  - $ref: linksys,ns-partitions.yaml
+  - $ref: qcom,smem-part.yaml
+  - $ref: redboot-fis.yaml
+
 properties:
   compatible: true
 
@@ -29,5 +38,4 @@ patternProperties:
 required:
   - compatible
 
-# Temporary value, should be set to false when constraining the parsers list
-additionalProperties: true
+unevaluatedProperties: false
diff --git a/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml b/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
index dc07909af023..805eabece7c8 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
@@ -15,6 +15,8 @@ description: |
   varies between partition table revisions. V3 supports maximum 16 partitions
   and V4 supports 48 partitions.
 
+select: false
+
 properties:
   compatible:
     const: qcom,smem-part
diff --git a/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml b/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml
index fee8d81b5276..ba7445cd69e8 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml
@@ -16,6 +16,8 @@ description: The FLASH Image System (FIS) directory is a flash description
 maintainers:
   - Linus Walleij <linus.walleij@linaro.org>
 
+select: false
+
 properties:
   compatible:
     const: redboot-fis
@@ -26,6 +28,10 @@ properties:
       device. On a flash memory with 32KB eraseblocks, 0 means the first
       eraseblock at 0x00000000, 1 means the second eraseblock at 0x00008000 and so on.
 
+  '#address-cells': false
+
+  '#size-cells': false
+
 required:
   - compatible
   - fis-index-block
-- 
2.34.1

