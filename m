Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D41619DAB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiKDQsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiKDQr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:47:29 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3301731EFC;
        Fri,  4 Nov 2022 09:47:27 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8B9744000E;
        Fri,  4 Nov 2022 16:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667580445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1BVXfpUDpuO14vpkhrGj4WhajxKP64/OBHEAjC1gJJU=;
        b=YDzbuVof2BvQCL5+tC0MmGS8rNod+85O+cSBK1eT7Ru8ktT/MCZQp4ix2sFrRCUezRZWdA
        G2QIlNNJoydsR8NferXcXIdgYGuDeAWg9c7FVm+GVH/H5oBqoNKEUtthuyZNqw0MCz01q7
        YQ5SLlsrUG3eI8GNSEdt4CuPaG9EaJCZ9cOrvYrEo2Er72D9s5JmPxP8Ok8u7B+7Zh2brS
        SqatFHtjnOm5ZzP2VdlTXZ3pRAXO6zKeXsUhO7vJ4j6JwXVjLtV/+z6Pknn/+6kx46cAZF
        Hewwv/KkOrWTbhDdtxcOytvFtUC1LazYonxqx79RZNotMDU3RB0bYl+6xoo3gg==
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
Subject: [PATCH v2 05/17] dt-bindings: mtd: nand: Standardize the child node name
Date:   Fri,  4 Nov 2022 17:47:06 +0100
Message-Id: <20221104164718.1290859-6-miquel.raynal@bootlin.com>
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

In almost all the schema mentioning a NAND chip child node, the name of
the subnode contains a single index number.

In practice there are currently no controller supporting more than 8 cs
so even the [a-f] numbers are not needed. But let's be safe and limit
the number of touched files by just allow a single number everywhere, so
in practice up to 16 CS at most. This value can anyway be limited in
each schema.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
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

