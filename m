Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43894627884
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbiKNJEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236753AbiKNJDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:03:37 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF57730A;
        Mon, 14 Nov 2022 01:03:32 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DAA50FF80D;
        Mon, 14 Nov 2022 09:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668416611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZniRa34IJzcORswSbVxxaxEtzC6zBhF2xlhbxe8YXs=;
        b=giuozLSxpKkGYRAtRiy7/GNRi+LI3RQWeS/+x2NZZtX3f4OoqmEsJSvoBMuCWn1rcpM34S
        06t9sHrgfFSr8zAUr/FWTj/PbDwkn75yZctx+GDeeZkisUhsnr4Oa/mjUe/pgXOfxzf2u/
        RcQgzJ2xFyw7dvEA92Gs6TxEFIMyXiUCOgmeRm0gY+zWjWwzw02WzhmJzP7N3iU965Xu2Y
        dwzK3jAo0MlxBl+dEC8drl5o8mYqna6zF8WdI0YrVPfmCwC6r0pX0c5lydjf8HyJwn3DPf
        0grSnK4D+arsp6tIci+cUpH6pRYlCUVfx4blC+YOdrhQKfkeJH0sr1cISxXHog==
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
Subject: [PATCH v3 05/17] dt-bindings: mtd: nand: Standardize the child node name
Date:   Mon, 14 Nov 2022 10:03:03 +0100
Message-Id: <20221114090315.848208-6-miquel.raynal@bootlin.com>
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

In almost all the schema mentioning a NAND chip child node, the name of
the subnode contains a single index number.

In practice there are currently no controller supporting more than 8 cs
so even the [a-f] numbers are not needed. But let's be safe and limit
the number of touched files by just allow a single number everywhere, so
in practice up to 16 CS at most. This value can anyway be limited in
each schema.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml       | 2 +-
 Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml b/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
index 65521924ee1c..465aa69f0f10 100644
--- a/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
@@ -47,7 +47,7 @@ properties:
     const: rxtx
 
 patternProperties:
-  "^nand@[a-f0-9]+$":
+  "^nand@[a-f0-9]$":
     type: object
     properties:
       reg:
diff --git a/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml b/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml
index 7c83a328845e..d455b75a0b0b 100644
--- a/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml
+++ b/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml
@@ -40,7 +40,7 @@ properties:
       - const: rx
 
 patternProperties:
-  "^nand@[a-f0-9]+$":
+  "^nand@[a-f0-9]$":
     type: object
     properties:
       reg:
-- 
2.34.1

