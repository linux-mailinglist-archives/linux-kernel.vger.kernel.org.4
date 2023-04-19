Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393D56E7A38
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjDSNCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbjDSNCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:02:49 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7065B445
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=wQ1t3KQ2eAPlhZ6OlpW0kwKFvpz
        SO9/aAnVf2UMgqWk=; b=Bh00Nw/SOS/ZpINn81N59Y66+mR3DVkNf/7Bk3s4Psx
        6shp9BXgNKfZQ7R0gL+Dust34QUYIObeTA2zFCgsqKudUT/J4IdqojizKMSL1Dpd
        4BzFr40EQnvCQqu2tm1zprUb8jjTuIRQbmp6STvLWInhEZGFL15h+NBagnZ467F4
        =
Received: (qmail 3697267 invoked from network); 19 Apr 2023 15:02:41 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Apr 2023 15:02:41 +0200
X-UD-Smtp-Session: l3s3148p1@a7UFCrD5zM0ujnsI
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Cong Dang <cong.dang.xn@renesas.com>,
        Hai Pham <hai.pham.ud@renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
Date:   Wed, 19 Apr 2023 15:02:34 +0200
Message-Id: <20230419130234.44321-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheets, the Strobe Timing Adjustment bit (STRTIM)
setting is different on R-Car SoCs, i.e.

R-Car M3 ES1.*  : STRTIM[2:0] is set to 0x6
other R-Car Gen3: STRTIM[2:0] is set to 0x7
other R-Car Gen4: STRTIM[3:0] is set to 0xf

To fix this issue, a DT match data was added to specify the setting
for special use cases.

Signed-off-by: Cong Dang <cong.dang.xn@renesas.com>
Signed-off-by: Hai Pham  <hai.pham.ud@renesas.com>
[wsa: rebased, restructured, added Gen4 support]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since v3:
* rebased to latest changes in the driver

The previous version was already reviewed by Geert and tested by
Prabhakar. Since the rebase for v4 was not super trivial, I decided to
drop the tags. It would be great if you could have another look. Thank
you already. Happy hacking!


 drivers/memory/renesas-rpc-if.c | 53 ++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 14 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 025bb628aaf3..75fcba45ec1b 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2019-2020 Cogent Embedded, Inc.
  */
 
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -163,6 +164,11 @@ static const struct regmap_access_table rpcif_volatile_table = {
 	.n_yes_ranges	= ARRAY_SIZE(rpcif_volatile_ranges),
 };
 
+struct rpcif_info {
+	enum rpcif_type type;
+	u8 strtim;
+};
+
 struct rpcif_priv {
 	struct device *dev;
 	void __iomem *base;
@@ -171,7 +177,7 @@ struct rpcif_priv {
 	struct reset_control *rstc;
 	struct platform_device *vdev;
 	size_t size;
-	enum rpcif_type type;
+	const struct rpcif_info *info;
 	enum rpcif_data_dir dir;
 	u8 bus_size;
 	u8 xfer_size;
@@ -186,6 +192,26 @@ struct rpcif_priv {
 	u32 ddr;		/* DRDRENR or SMDRENR */
 };
 
+static const struct rpcif_info rpcif_info_r8a7796 = {
+	.type = RPCIF_RCAR_GEN3,
+	.strtim = 6,
+};
+
+static const struct rpcif_info rpcif_info_gen3 = {
+	.type = RPCIF_RCAR_GEN3,
+	.strtim = 7,
+};
+
+static const struct rpcif_info rpcif_info_rz_g2l = {
+	.type = RPCIF_RZ_G2L,
+	.strtim = 7,
+};
+
+static const struct rpcif_info rpcif_info_gen4 = {
+	.type = RPCIF_RCAR_GEN4,
+	.strtim = 15,
+};
+
 /*
  * Custom accessor functions to ensure SM[RW]DR[01] are always accessed with
  * proper width.  Requires rpcif_priv.xfer_size to be correctly set before!
@@ -310,7 +336,7 @@ int rpcif_hw_init(struct device *dev, bool hyperflash)
 	if (ret)
 		return ret;
 
-	if (rpc->type == RPCIF_RZ_G2L) {
+	if (rpc->info->type == RPCIF_RZ_G2L) {
 		ret = reset_control_reset(rpc->rstc);
 		if (ret)
 			return ret;
@@ -324,12 +350,10 @@ int rpcif_hw_init(struct device *dev, bool hyperflash)
 	/* DMA Transfer is not supported */
 	regmap_update_bits(rpc->regmap, RPCIF_PHYCNT, RPCIF_PHYCNT_HS, 0);
 
-	if (rpc->type == RPCIF_RCAR_GEN3)
-		regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
-				   RPCIF_PHYCNT_STRTIM(7), RPCIF_PHYCNT_STRTIM(7));
-	else if (rpc->type == RPCIF_RCAR_GEN4)
-		regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
-				   RPCIF_PHYCNT_STRTIM(15), RPCIF_PHYCNT_STRTIM(15));
+	regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
+			   /* create mask with all affected bits set */
+			   RPCIF_PHYCNT_STRTIM(BIT(fls(rpc->info->strtim)) - 1),
+			   RPCIF_PHYCNT_STRTIM(rpc->info->strtim));
 
 	regmap_update_bits(rpc->regmap, RPCIF_PHYOFFSET1, RPCIF_PHYOFFSET1_DDRTMG(3),
 			   RPCIF_PHYOFFSET1_DDRTMG(3));
@@ -340,7 +364,7 @@ int rpcif_hw_init(struct device *dev, bool hyperflash)
 		regmap_update_bits(rpc->regmap, RPCIF_PHYINT,
 				   RPCIF_PHYINT_WPVAL, 0);
 
-	if (rpc->type == RPCIF_RZ_G2L)
+	if (rpc->info->type == RPCIF_RZ_G2L)
 		regmap_update_bits(rpc->regmap, RPCIF_CMNCR,
 				   RPCIF_CMNCR_MOIIO(3) | RPCIF_CMNCR_IOFV(3) |
 				   RPCIF_CMNCR_BSZ(3),
@@ -729,9 +753,9 @@ static int rpcif_probe(struct platform_device *pdev)
 	rpc->dirmap = devm_ioremap_resource(dev, res);
 	if (IS_ERR(rpc->dirmap))
 		return PTR_ERR(rpc->dirmap);
-	rpc->size = resource_size(res);
 
-	rpc->type = (uintptr_t)of_device_get_match_data(dev);
+	rpc->size = resource_size(res);
+	rpc->info = of_device_get_match_data(dev);
 	rpc->rstc = devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(rpc->rstc))
 		return PTR_ERR(rpc->rstc);
@@ -764,9 +788,10 @@ static int rpcif_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id rpcif_of_match[] = {
-	{ .compatible = "renesas,rcar-gen3-rpc-if", .data = (void *)RPCIF_RCAR_GEN3 },
-	{ .compatible = "renesas,rcar-gen4-rpc-if", .data = (void *)RPCIF_RCAR_GEN4 },
-	{ .compatible = "renesas,rzg2l-rpc-if", .data = (void *)RPCIF_RZ_G2L },
+	{ .compatible = "renesas,r8a7796-rpc-if", .data = &rpcif_info_r8a7796 },
+	{ .compatible = "renesas,rcar-gen3-rpc-if", .data = &rpcif_info_gen3 },
+	{ .compatible = "renesas,rcar-gen4-rpc-if", .data = &rpcif_info_gen4 },
+	{ .compatible = "renesas,rzg2l-rpc-if", .data = &rpcif_info_rz_g2l },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rpcif_of_match);
-- 
2.30.2

