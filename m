Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348A2669022
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbjAMIJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240795AbjAMIIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:08:35 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C29B574E7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=b2mmceqvtzf6lElFARDVmEM9PLO
        aKyEwhEvAg0JHMe4=; b=olUth3Axyxf4EdbyG5ZJ/qchr4/HEmEla//d7zUxoL8
        WkITfnMHWvBJnLh7oy67/MqWffBaMx2AWGBA90Dp49dMH008zWHq4McN2MvGtDYb
        /0kJ5XTPyGt+Ee6YRQAXnS7zhKVCq+bsECphIJwo4y1XY/PuJaC17iwN7E1iyVNk
        =
Received: (qmail 1181036 invoked from network); 13 Jan 2023 09:06:01 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jan 2023 09:06:01 +0100
X-UD-Smtp-Session: l3s3148p1@vPATtCDypIFehh92
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
Date:   Fri, 13 Jan 2023 09:05:50 +0100
Message-Id: <20230113080550.1736-1-wsa+renesas@sang-engineering.com>
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

From: Cong Dang <cong.dang.xn@renesas.com>

According to the datasheets, the Strobe Timing Adjustment bit (STRTIM)
setting is different on R-Car SoCs, i.e.

R-Car H3 ES1.*  : STRTIM[2:0] is set to 0x0
R-Car M3 ES1.*  : STRTIM[2:0] is set to 0x6
other R-Car Gen3: STRTIM[2:0] is set to 0x7
other R-Car Gen4: STRTIM[3:0] is set to 0xf

To fix this issue, a DT match data was added to specify the setting
for special use cases.

Signed-off-by: Cong Dang <cong.dang.xn@renesas.com>
Signed-off-by: Hai Pham  <hai.pham.ud@renesas.com>
[wsa: rebased, restructured a little, added Gen4 support]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

This upports a patch from the BSP to handle the ES1.* variants. Turns
out this is a nice idea to handle Gen3/4 differences as well. Tested on
an Eagle board (R-Car V3M) and White-Hawk (R-Car V4H). ES1.* handling
tested by faking the entries to apply for V4H as well.

Prabhakar: could you kindly check if RZ/G2L supports looks okay to you?

 drivers/memory/renesas-rpc-if.c | 61 ++++++++++++++++++++++++++-------
 include/memory/renesas-rpc-if.h |  6 ++++
 2 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index c36b407851ff..2cbd869ba443 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -15,6 +15,7 @@
 #include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
+#include <linux/sys_soc.h>
 
 #include <memory/renesas-rpc-if.h>
 
@@ -163,6 +164,36 @@ static const struct regmap_access_table rpcif_volatile_table = {
 	.n_yes_ranges	= ARRAY_SIZE(rpcif_volatile_ranges),
 };
 
+static const struct rpcif_info rpcif_info_r8a7795_es1 = {
+	.type = RPCIF_RCAR_GEN3,
+	.strtim = 0,
+};
+
+static const struct rpcif_info rpcif_info_r8a7796_es1 = {
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
+static const struct soc_device_attribute rpcif_info_match[]  = {
+	{ .soc_id = "r8a7795", .revision = "ES1.*", .data = &rpcif_info_r8a7795_es1 },
+	{ .soc_id = "r8a7796", .revision = "ES1.*", .data = &rpcif_info_r8a7796_es1 },
+	{ /* Sentinel. */ }
+};
 
 /*
  * Custom accessor functions to ensure SM[RW]DR[01] are always accessed with
@@ -256,6 +287,8 @@ static const struct regmap_config rpcif_regmap_config = {
 int rpcif_sw_init(struct rpcif *rpc, struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
+	const struct soc_device_attribute *attr;
+	const struct rpcif_info *info;
 	struct resource *res;
 
 	rpc->dev = dev;
@@ -276,9 +309,14 @@ int rpcif_sw_init(struct rpcif *rpc, struct device *dev)
 	rpc->dirmap = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(rpc->dirmap))
 		return PTR_ERR(rpc->dirmap);
-	rpc->size = resource_size(res);
 
-	rpc->type = (uintptr_t)of_device_get_match_data(dev);
+	info = of_device_get_match_data(dev);
+	attr = soc_device_match(rpcif_info_match);
+	if (attr)
+		info = attr->data;
+
+	rpc->info = info;
+	rpc->size = resource_size(res);
 	rpc->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 
 	return PTR_ERR_OR_ZERO(rpc->rstc);
@@ -305,7 +343,7 @@ int rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
 
 	pm_runtime_get_sync(rpc->dev);
 
-	if (rpc->type == RPCIF_RZ_G2L) {
+	if (rpc->info->type == RPCIF_RZ_G2L) {
 		int ret;
 
 		ret = reset_control_reset(rpc->rstc);
@@ -321,12 +359,9 @@ int rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
 	/* DMA Transfer is not supported */
 	regmap_update_bits(rpc->regmap, RPCIF_PHYCNT, RPCIF_PHYCNT_HS, 0);
 
-	if (rpc->type == RPCIF_RCAR_GEN3)
-		regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
-				   RPCIF_PHYCNT_STRTIM(7), RPCIF_PHYCNT_STRTIM(7));
-	else if (rpc->type == RPCIF_RCAR_GEN4)
-		regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
-				   RPCIF_PHYCNT_STRTIM(15), RPCIF_PHYCNT_STRTIM(15));
+	regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
+			   RPCIF_PHYCNT_STRTIM(rpc->info->strtim),
+			   RPCIF_PHYCNT_STRTIM(rpc->info->strtim));
 
 	regmap_update_bits(rpc->regmap, RPCIF_PHYOFFSET1, RPCIF_PHYOFFSET1_DDRTMG(3),
 			   RPCIF_PHYOFFSET1_DDRTMG(3));
@@ -337,7 +372,7 @@ int rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
 		regmap_update_bits(rpc->regmap, RPCIF_PHYINT,
 				   RPCIF_PHYINT_WPVAL, 0);
 
-	if (rpc->type == RPCIF_RZ_G2L)
+	if (rpc->info->type == RPCIF_RZ_G2L)
 		regmap_update_bits(rpc->regmap, RPCIF_CMNCR,
 				   RPCIF_CMNCR_MOIIO(3) | RPCIF_CMNCR_IOFV(3) |
 				   RPCIF_CMNCR_BSZ(3),
@@ -720,9 +755,9 @@ static int rpcif_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id rpcif_of_match[] = {
-	{ .compatible = "renesas,rcar-gen3-rpc-if", .data = (void *)RPCIF_RCAR_GEN3 },
-	{ .compatible = "renesas,rcar-gen4-rpc-if", .data = (void *)RPCIF_RCAR_GEN4 },
-	{ .compatible = "renesas,rzg2l-rpc-if", .data = (void *)RPCIF_RZ_G2L },
+	{ .compatible = "renesas,rcar-gen3-rpc-if", .data = &rpcif_info_gen3 },
+	{ .compatible = "renesas,rcar-gen4-rpc-if", .data = &rpcif_info_gen4 },
+	{ .compatible = "renesas,rzg2l-rpc-if", .data = &rpcif_info_rz_g2l },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rpcif_of_match);
diff --git a/include/memory/renesas-rpc-if.h b/include/memory/renesas-rpc-if.h
index 862eff613dc7..75da785a18ff 100644
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
@@ -71,6 +76,7 @@ struct rpcif {
 	struct reset_control *rstc;
 	size_t size;
 	enum rpcif_type type;
+	const struct rpcif_info *info;
 	enum rpcif_data_dir dir;
 	u8 bus_size;
 	u8 xfer_size;
-- 
2.30.2

