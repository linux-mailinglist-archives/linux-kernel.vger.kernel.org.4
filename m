Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A74367D34E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjAZRff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjAZRfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:35:25 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200DC71642
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=4K7XlSvLqsgNooioi1OUJRX2pbW
        KDuA2+FsM3NFS1Wc=; b=PBH34yhNsYUnTyG6d/7YlWTTSdhqi06yCPmDqRUUAmd
        Ow67bP15IEs9QZu8O8oLAubYAxxGioKpF2BJ5PJL36FmDckqyXuRqzH0NQ2xgIzk
        GU16B1T3Ycj2TNY6cIYDMJRP/Ib57AdW5Wyh6Teb17013t4QY92Suq2+3OiJrj5w
        =
Received: (qmail 3889470 invoked from network); 26 Jan 2023 18:35:18 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 26 Jan 2023 18:35:18 +0100
X-UD-Smtp-Session: l3s3148p1@Aj4qLC7zMOcujnvo
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Cong Dang <cong.dang.xn@renesas.com>,
        Hai Pham <hai.pham.ud@renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
Date:   Thu, 26 Jan 2023 18:35:12 +0100
Message-Id: <20230126173513.36659-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

Changes since v2:
* dropped support for H3 ES1 (we don't support it upstream anymore)
* M3-W ES1 now handled via 'compatible' (Thanks, Geert!)
* -> dropped soc_device_match()
* removed old rpcif_type entry in struct rpcif (Thanks, Prabhakar)

 drivers/memory/renesas-rpc-if.c | 45 +++++++++++++++++++++++----------
 include/memory/renesas-rpc-if.h |  7 ++++-
 2 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index c36b407851ff..1dc684a93ff4 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2019-2020 Cogent Embedded, Inc.
  */
 
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -163,6 +164,25 @@ static const struct regmap_access_table rpcif_volatile_table = {
 	.n_yes_ranges	= ARRAY_SIZE(rpcif_volatile_ranges),
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
 
 /*
  * Custom accessor functions to ensure SM[RW]DR[01] are always accessed with
@@ -276,9 +296,9 @@ int rpcif_sw_init(struct rpcif *rpc, struct device *dev)
 	rpc->dirmap = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(rpc->dirmap))
 		return PTR_ERR(rpc->dirmap);
-	rpc->size = resource_size(res);
 
-	rpc->type = (uintptr_t)of_device_get_match_data(dev);
+	rpc->size = resource_size(res);
+	rpc->info = of_device_get_match_data(dev);
 	rpc->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 
 	return PTR_ERR_OR_ZERO(rpc->rstc);
@@ -305,7 +325,7 @@ int rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
 
 	pm_runtime_get_sync(rpc->dev);
 
-	if (rpc->type == RPCIF_RZ_G2L) {
+	if (rpc->info->type == RPCIF_RZ_G2L) {
 		int ret;
 
 		ret = reset_control_reset(rpc->rstc);
@@ -321,12 +341,10 @@ int rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
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
@@ -337,7 +355,7 @@ int rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
 		regmap_update_bits(rpc->regmap, RPCIF_PHYINT,
 				   RPCIF_PHYINT_WPVAL, 0);
 
-	if (rpc->type == RPCIF_RZ_G2L)
+	if (rpc->info->type == RPCIF_RZ_G2L)
 		regmap_update_bits(rpc->regmap, RPCIF_CMNCR,
 				   RPCIF_CMNCR_MOIIO(3) | RPCIF_CMNCR_IOFV(3) |
 				   RPCIF_CMNCR_BSZ(3),
@@ -720,9 +738,10 @@ static int rpcif_remove(struct platform_device *pdev)
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
diff --git a/include/memory/renesas-rpc-if.h b/include/memory/renesas-rpc-if.h
index 862eff613dc7..405011008a5a 100644
--- a/include/memory/renesas-rpc-if.h
+++ b/include/memory/renesas-rpc-if.h
@@ -63,6 +63,11 @@ enum rpcif_type {
 	RPCIF_RZ_G2L,
 };
 
+struct rpcif_info {
+	enum rpcif_type type;
+	u8 strtim;
+};
+
 struct rpcif {
 	struct device *dev;
 	void __iomem *base;
@@ -70,7 +75,7 @@ struct rpcif {
 	struct regmap *regmap;
 	struct reset_control *rstc;
 	size_t size;
-	enum rpcif_type type;
+	const struct rpcif_info *info;
 	enum rpcif_data_dir dir;
 	u8 bus_size;
 	u8 xfer_size;
-- 
2.30.2

