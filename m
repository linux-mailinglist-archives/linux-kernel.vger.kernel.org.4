Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94F55FC6EB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 16:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJLOCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 10:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiJLOCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 10:02:02 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7D4C7078
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 07:01:59 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:3da6:62e6:8ab0:ff90])
        by andre.telenet-ops.be with bizsmtp
        id X21x2800432x5mf0121xPs; Wed, 12 Oct 2022 16:01:57 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oicJ2-001OYA-MM; Wed, 12 Oct 2022 16:01:56 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oicJ2-00C327-A3; Wed, 12 Oct 2022 16:01:56 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] memory: renesas-rpc-if: Add support for R-Car Gen4
Date:   Wed, 12 Oct 2022 16:01:52 +0200
Message-Id: <4d0824bf5ed0fb95c51cd36f9a3f0f562b1a6bf8.1665583089.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1665583089.git.geert+renesas@glider.be>
References: <cover.1665583089.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPI Multi I/O Bus Controller (RPC-IF) on R-Car Gen4 SoCs is very
similar to the RPC-IF on R-Car Gen3 SoCs.  It does support four instead
of three bits of strobe timing adjustment (STRTIM), and thus requires a
new mask and new settings.

Inspired by a patch in the BSP by Cong Dang.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/memory/renesas-rpc-if.c | 19 ++++++++++++-------
 include/memory/renesas-rpc-if.h |  1 +
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 61c288d403750b14..09cd4318a83d84d3 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -136,7 +136,8 @@
 #define RPCIF_PHYCNT_DDRCAL	BIT(19)
 #define RPCIF_PHYCNT_HS		BIT(18)
 #define RPCIF_PHYCNT_CKSEL(v)	(((v) & 0x3) << 16) /* valid only for RZ/G2L */
-#define RPCIF_PHYCNT_STRTIM(v)	(((v) & 0x7) << 15) /* valid for R-Car and RZ/G2{E,H,M,N} */
+#define RPCIF_PHYCNT_STRTIM(v)	(((v) & 0x7) << 15 | ((v) & 0x8) << 24) /* valid for R-Car and RZ/G2{E,H,M,N} */
+
 #define RPCIF_PHYCNT_WBUF2	BIT(4)
 #define RPCIF_PHYCNT_WBUF	BIT(2)
 #define RPCIF_PHYCNT_PHYMEM(v)	(((v) & 0x3) << 0)
@@ -323,6 +324,9 @@ int rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
 	if (rpc->type == RPCIF_RCAR_GEN3)
 		regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
 				   RPCIF_PHYCNT_STRTIM(7), RPCIF_PHYCNT_STRTIM(7));
+	else if (rpc->type == RPCIF_RCAR_GEN4)
+		regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
+				   RPCIF_PHYCNT_STRTIM(15), RPCIF_PHYCNT_STRTIM(15));
 
 	regmap_update_bits(rpc->regmap, RPCIF_PHYOFFSET1, RPCIF_PHYOFFSET1_DDRTMG(3),
 			   RPCIF_PHYOFFSET1_DDRTMG(3));
@@ -333,17 +337,17 @@ int rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
 		regmap_update_bits(rpc->regmap, RPCIF_PHYINT,
 				   RPCIF_PHYINT_WPVAL, 0);
 
-	if (rpc->type == RPCIF_RCAR_GEN3)
-		regmap_update_bits(rpc->regmap, RPCIF_CMNCR,
-				   RPCIF_CMNCR_MOIIO(3) | RPCIF_CMNCR_BSZ(3),
-				   RPCIF_CMNCR_MOIIO(3) |
-				   RPCIF_CMNCR_BSZ(hyperflash ? 1 : 0));
-	else
+	if (rpc->type == RPCIF_RZ_G2L)
 		regmap_update_bits(rpc->regmap, RPCIF_CMNCR,
 				   RPCIF_CMNCR_MOIIO(3) | RPCIF_CMNCR_IOFV(3) |
 				   RPCIF_CMNCR_BSZ(3),
 				   RPCIF_CMNCR_MOIIO(1) | RPCIF_CMNCR_IOFV(2) |
 				   RPCIF_CMNCR_BSZ(hyperflash ? 1 : 0));
+	else
+		regmap_update_bits(rpc->regmap, RPCIF_CMNCR,
+				   RPCIF_CMNCR_MOIIO(3) | RPCIF_CMNCR_BSZ(3),
+				   RPCIF_CMNCR_MOIIO(3) |
+				   RPCIF_CMNCR_BSZ(hyperflash ? 1 : 0));
 
 	/* Set RCF after BSZ update */
 	regmap_write(rpc->regmap, RPCIF_DRCR, RPCIF_DRCR_RCF);
@@ -718,6 +722,7 @@ static int rpcif_remove(struct platform_device *pdev)
 
 static const struct of_device_id rpcif_of_match[] = {
 	{ .compatible = "renesas,rcar-gen3-rpc-if", .data = (void *)RPCIF_RCAR_GEN3 },
+	{ .compatible = "renesas,rcar-gen4-rpc-if", .data = (void *)RPCIF_RCAR_GEN4 },
 	{ .compatible = "renesas,rzg2l-rpc-if", .data = (void *)RPCIF_RZ_G2L },
 	{},
 };
diff --git a/include/memory/renesas-rpc-if.h b/include/memory/renesas-rpc-if.h
index 9c0ad64b8d292d49..862eff613dc7963d 100644
--- a/include/memory/renesas-rpc-if.h
+++ b/include/memory/renesas-rpc-if.h
@@ -59,6 +59,7 @@ struct rpcif_op {
 
 enum rpcif_type {
 	RPCIF_RCAR_GEN3,
+	RPCIF_RCAR_GEN4,
 	RPCIF_RZ_G2L,
 };
 
-- 
2.25.1

