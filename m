Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701F1619DB2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiKDQsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbiKDQro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:47:44 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAE44731D;
        Fri,  4 Nov 2022 09:47:36 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DDCAF4000C;
        Fri,  4 Nov 2022 16:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667580455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+/lDN07HzIVXyCOe6g7TO1CLyUYJmJJyGrTHG8Es/Kw=;
        b=IKn83bltza7mii6W7ZBV5MTpEknwv96h9DUbfImGD2IJgAJsWRiLGMEQE02jRLTfjcCHXd
        9fLXANAkFTZ2XIK3H7cLQXYosjmmrwLLZEg35MsMFa50AyhHIJ3GS2WSKOVdUHAPfqvWdA
        8kb782HO0TXhJV6KLU1oaVmEzF10ivlT0zE4vfIQ+lvPZRIJ/IJqgiTBtVP7Qv+uhVc9ce
        f0wMNIQVmhKHknhzs9Vgc38dcX0omsloSvxmMgDBLpICaK2bYmuOVtG8ENeNaof8cINW7x
        Vhu+QqG/ctWTEoDmLz80nzVKoZ10JKBKLqr6ESvIc/L1cnx0j6hJSnGsGktDlg==
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
Subject: [PATCH v2 14/17] dt-bindings: mtd: nvmem-cells: Inherit from MTD partitions
Date:   Fri,  4 Nov 2022 17:47:15 +0100
Message-Id: <20221104164718.1290859-15-miquel.raynal@bootlin.com>
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

The aim of MTD nvmem-cells is to treat MTD partitions as NVMEM
providers. Hence, MTD partition properties are valid here. Let's
reference mtd/partition.yaml which gives us a chance to drop
"additionalProperties: true" in favor of "unevaluatedProperties:
false".

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../devicetree/bindings/mtd/partitions/nvmem-cells.yaml        | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
index ca18892eacc7..5474d63268dc 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
@@ -17,6 +17,7 @@ maintainers:
   - Ansuel Smith <ansuelsmth@gmail.com>
 
 allOf:
+  - $ref: /schemas/mtd/partitions/partition.yaml#
   - $ref: /schemas/nvmem/nvmem.yaml#
 
 properties:
@@ -26,7 +27,7 @@ properties:
 required:
   - compatible
 
-additionalProperties: true
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

