Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC51627895
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbiKNJEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbiKNJEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:04:04 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544C41D66F;
        Mon, 14 Nov 2022 01:03:54 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id ED1F9FF802;
        Mon, 14 Nov 2022 09:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668416633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oZXshiOPjCKaC4DLT1nvR8gkGxfPYRfPdpLRj3Pz4+g=;
        b=UDSNPAslbjlapBM2Hm0s6QeHvls1ReRpUBGOmWfcNV/oylSVgoLi73PT/bpVvmqg0lTGaj
        UJV1JpfXA5sVSoNT5Tg7m3VXh9884AG0AVdQhKtKbWnI7fnj1LnAordS6vOtUPw5fyHOOf
        UrgNmD+uEoiyjDUQqDczAQJrzVsskijWHtdPH1OhDI7bNKXBYI10Q2D6nA9sWbu8d/E7ZF
        PV6Z2HxUdv0r7Dh3HHwklr58jb71nt3/qBTVpJATtueCYG5TfwBsiGtC2kLKb5lPJ2vyW1
        uP99kh/SUBARWq1xENSI9iNltL5TUEod9jL5schJCQxY3hpKd3wbxPkPnoVJpw==
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
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 13/17] dt-bindings: mtd: nvmem-cells: Drop range property from example
Date:   Mon, 14 Nov 2022 10:03:11 +0100
Message-Id: <20221114090315.848208-14-miquel.raynal@bootlin.com>
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

Memory mapped devices such as parallel NOR flash could make use of the
'ranges' property to translate a nvmem 'reg' cell address to a CPU
address but in practice there is no upstream user nor any declaration of
this property being valid in this case yet, leading to a warning when
constraining a bit more the schema:

	.../mtd/partitions/nvmem-cells.example.dtb: calibration@f00000:
	Unevaluated properties are not allowed ('ranges' was unexpected)

So let's drop the property from the example, knowing that someone might
actually properly define it some day.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../devicetree/bindings/mtd/partitions/nvmem-cells.yaml          | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
index 5cdd2efa9132..ca18892eacc7 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
@@ -84,7 +84,6 @@ examples:
             compatible = "nvmem-cells";
             label = "calibration";
             reg = <0xf00000 0x100000>;
-            ranges = <0 0xf00000 0x100000>;
             #address-cells = <1>;
             #size-cells = <1>;
 
-- 
2.34.1

