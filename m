Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A7B636212
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238420AbiKWOlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235777AbiKWOlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:41:37 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A4C532F8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:41:33 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:881b:815b:474d:c3fd])
        by michel.telenet-ops.be with bizsmtp
        id nqhS2800P49U0Rd06qhSXE; Wed, 23 Nov 2022 15:41:30 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oxqwH-001Rql-Rb; Wed, 23 Nov 2022 15:41:25 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oxqwH-0012Ho-7B; Wed, 23 Nov 2022 15:41:25 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 6/6] memory: renesas-rpc-if: Remove Runtime PM wrappers
Date:   Wed, 23 Nov 2022 15:41:22 +0100
Message-Id: <d87aa5d7e4a39b18f7e2e0649fee0a45b45d371f.1669213027.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1669213027.git.geert+renesas@glider.be>
References: <cover.1669213027.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the rpcif_{en,dis}able_rpm() wrappers just take a pointer to a
device structure, there is no point in keeping them.  Remove them, and
update the callers to call Runtime PM directly.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This could be split in three patches for three different subsystems,
with the changes to <memory/renesas-rpc-if.h> postponed, to relax
dependencies, but the previous patch already touches all three
subsystems anyway.

v2:
  - New.
---
 drivers/mtd/hyperbus/rpc-if.c   |  6 +++---
 drivers/spi/spi-rpc-if.c        |  6 +++---
 include/memory/renesas-rpc-if.h | 10 ----------
 3 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/hyperbus/rpc-if.c b/drivers/mtd/hyperbus/rpc-if.c
index 41734e337ac00e40..ef32fca5f785e376 100644
--- a/drivers/mtd/hyperbus/rpc-if.c
+++ b/drivers/mtd/hyperbus/rpc-if.c
@@ -130,7 +130,7 @@ static int rpcif_hb_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, hyperbus);
 
-	rpcif_enable_rpm(hyperbus->rpc.dev);
+	pm_runtime_enable(hyperbus->rpc.dev);
 
 	error = rpcif_hw_init(hyperbus->rpc.dev, true);
 	if (error)
@@ -150,7 +150,7 @@ static int rpcif_hb_probe(struct platform_device *pdev)
 	return 0;
 
 out_disable_rpm:
-	rpcif_disable_rpm(hyperbus->rpc.dev);
+	pm_runtime_disable(hyperbus->rpc.dev);
 	return error;
 }
 
@@ -160,7 +160,7 @@ static int rpcif_hb_remove(struct platform_device *pdev)
 
 	hyperbus_unregister_device(&hyperbus->hbdev);
 
-	rpcif_disable_rpm(hyperbus->rpc.dev);
+	pm_runtime_disable(hyperbus->rpc.dev);
 
 	return 0;
 }
diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index 5063587d2c724c7c..ec0904faf3a10bd0 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -147,7 +147,7 @@ static int rpcif_spi_probe(struct platform_device *pdev)
 
 	ctlr->dev.of_node = parent->of_node;
 
-	rpcif_enable_rpm(rpc->dev);
+	pm_runtime_enable(rpc->dev);
 
 	ctlr->num_chipselect = 1;
 	ctlr->mem_ops = &rpcif_spi_mem_ops;
@@ -169,7 +169,7 @@ static int rpcif_spi_probe(struct platform_device *pdev)
 	return 0;
 
 out_disable_rpm:
-	rpcif_disable_rpm(rpc->dev);
+	pm_runtime_disable(rpc->dev);
 	return error;
 }
 
@@ -179,7 +179,7 @@ static int rpcif_spi_remove(struct platform_device *pdev)
 	struct rpcif *rpc = spi_controller_get_devdata(ctlr);
 
 	spi_unregister_controller(ctlr);
-	rpcif_disable_rpm(rpc->dev);
+	pm_runtime_disable(rpc->dev);
 
 	return 0;
 }
diff --git a/include/memory/renesas-rpc-if.h b/include/memory/renesas-rpc-if.h
index 86a26ea78221a204..b8fa30fd6b500c73 100644
--- a/include/memory/renesas-rpc-if.h
+++ b/include/memory/renesas-rpc-if.h
@@ -76,14 +76,4 @@ void rpcif_prepare(struct device *dev, const struct rpcif_op *op, u64 *offs,
 int rpcif_manual_xfer(struct device *dev);
 ssize_t rpcif_dirmap_read(struct device *dev, u64 offs, size_t len, void *buf);
 
-static inline void rpcif_enable_rpm(struct device *dev)
-{
-	pm_runtime_enable(dev);
-}
-
-static inline void rpcif_disable_rpm(struct device *dev)
-{
-	pm_runtime_disable(dev);
-}
-
 #endif // __RENESAS_RPC_IF_H
-- 
2.25.1

