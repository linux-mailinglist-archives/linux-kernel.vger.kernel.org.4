Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E0D636215
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbiKWOmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbiKWOli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:41:38 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5406E53EF0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:41:33 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:881b:815b:474d:c3fd])
        by albert.telenet-ops.be with bizsmtp
        id nqhS2800C49U0Rd06qhSTe; Wed, 23 Nov 2022 15:41:30 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oxqwH-001Rqh-NY; Wed, 23 Nov 2022 15:41:25 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oxqwH-0012HN-2m; Wed, 23 Nov 2022 15:41:25 +0100
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
Subject: [PATCH v2 2/6] memory: renesas-rpc-if: Move resource acquisition to .probe()
Date:   Wed, 23 Nov 2022 15:41:18 +0100
Message-Id: <c1012ef1de799e08a70817ab7313794e2d8d7bfb.1669213027.git.geert+renesas@glider.be>
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

While the acquired resources are tied to the lifetime of the RPC-IF core
device (through the use of managed resource functions), the actual
resource acquisition is triggered from the HyperBus and SPI child
drivers.  Due to this mismatch, unbinding and rebinding the child
drivers manually fails with -EBUSY:

    # echo rpc-if-hyperflash > /sys/bus/platform/drivers/rpc-if-hyperflash/unbind
    # echo rpc-if-hyperflash > /sys/bus/platform/drivers/rpc-if-hyperflash/bind
    rpc-if ee200000.spi: can't request region for resource [mem 0xee200000-0xee2001ff]
    rpc-if-hyperflash: probe of rpc-if-hyperflash failed with error -16

The same is true for rpc-if-spi.

Fix this by moving all resource acquisition to the core driver's probe
routine.

Fixes: ca7d8b980b67f133 ("memory: add Renesas RPC-IF driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Move forward in series,
  - Add Fixes tag.
---
 drivers/memory/renesas-rpc-if.c | 49 ++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 224973ac859f88fa..42c5f9f10135b86a 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -277,32 +277,7 @@ static const struct regmap_config rpcif_regmap_config = {
 
 int rpcif_sw_init(struct rpcif *rpcif, struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	struct rpcif_priv *rpc = dev_get_drvdata(dev);
-	struct resource *res;
-
-	rpc->base = devm_platform_ioremap_resource_byname(pdev, "regs");
-	if (IS_ERR(rpc->base))
-		return PTR_ERR(rpc->base);
-
-	rpc->regmap = devm_regmap_init(&pdev->dev, NULL, rpc, &rpcif_regmap_config);
-	if (IS_ERR(rpc->regmap)) {
-		dev_err(&pdev->dev,
-			"failed to init regmap for rpcif, error %ld\n",
-			PTR_ERR(rpc->regmap));
-		return	PTR_ERR(rpc->regmap);
-	}
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dirmap");
-	rpc->dirmap = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(rpc->dirmap))
-		return PTR_ERR(rpc->dirmap);
-	rpc->size = resource_size(res);
-
-	rpc->type = (uintptr_t)of_device_get_match_data(dev);
-	rpc->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (IS_ERR(rpc->rstc))
-		return PTR_ERR(rpc->rstc);
 
 	rpcif->dev = dev;
 	rpcif->dirmap = rpc->dirmap;
@@ -705,9 +680,11 @@ EXPORT_SYMBOL(rpcif_dirmap_read);
 
 static int rpcif_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct platform_device *vdev;
 	struct device_node *flash;
 	struct rpcif_priv *rpc;
+	struct resource *res;
 	const char *name;
 	int ret;
 
@@ -732,6 +709,28 @@ static int rpcif_probe(struct platform_device *pdev)
 	if (!rpc)
 		return -ENOMEM;
 
+	rpc->base = devm_platform_ioremap_resource_byname(pdev, "regs");
+	if (IS_ERR(rpc->base))
+		return PTR_ERR(rpc->base);
+
+	rpc->regmap = devm_regmap_init(dev, NULL, rpc, &rpcif_regmap_config);
+	if (IS_ERR(rpc->regmap)) {
+		dev_err(dev, "failed to init regmap for rpcif, error %ld\n",
+			PTR_ERR(rpc->regmap));
+		return	PTR_ERR(rpc->regmap);
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dirmap");
+	rpc->dirmap = devm_ioremap_resource(dev, res);
+	if (IS_ERR(rpc->dirmap))
+		return PTR_ERR(rpc->dirmap);
+	rpc->size = resource_size(res);
+
+	rpc->type = (uintptr_t)of_device_get_match_data(dev);
+	rpc->rstc = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(rpc->rstc))
+		return PTR_ERR(rpc->rstc);
+
 	vdev = platform_device_alloc(name, pdev->id);
 	if (!vdev)
 		return -ENOMEM;
-- 
2.25.1

