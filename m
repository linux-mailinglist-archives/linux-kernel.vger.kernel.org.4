Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C18C636216
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238889AbiKWOmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238560AbiKWOli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:41:38 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B2F627ED
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:41:33 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:881b:815b:474d:c3fd])
        by michel.telenet-ops.be with bizsmtp
        id nqhS2800V49U0Rd06qhSXJ; Wed, 23 Nov 2022 15:41:30 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oxqwI-001Rqg-0P; Wed, 23 Nov 2022 15:41:26 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oxqwH-0012HG-1S; Wed, 23 Nov 2022 15:41:25 +0100
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
Subject: [PATCH v2 1/6] memory: renesas-rpc-if: Split-off private data from struct rpcif
Date:   Wed, 23 Nov 2022 15:41:17 +0100
Message-Id: <09fbb6fa67d5a8cd48a08808c9afa2f6a499aa42.1669213027.git.geert+renesas@glider.be>
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

The rpcif structure is used as a common data structure, shared by the
RPC-IF core driver and by the HyperBus and SPI child drivers.
This poses several problems:
  - Most structure members describe private core driver state, which
    should not be accessible by the child drivers,
  - The structure's lifetime is controlled by the child drivers,
    complicating use by the core driver.

Fix this by moving the private core driver state to its own structure,
managed by the RPC-IF core driver, and store it in the core driver's
private data field.  This requires absorbing the child's platform
device, as that was stored in the driver's private data field before.

Fixes: ca7d8b980b67f133 ("memory: add Renesas RPC-IF driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Move forward in series,
  - Add Fixes tag.
---
 drivers/memory/renesas-rpc-if.c | 75 +++++++++++++++++++++++++--------
 include/memory/renesas-rpc-if.h | 16 -------
 2 files changed, 57 insertions(+), 34 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index f38a44877b15e8b1..224973ac859f88fa 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -163,14 +163,36 @@ static const struct regmap_access_table rpcif_volatile_table = {
 	.n_yes_ranges	= ARRAY_SIZE(rpcif_volatile_ranges),
 };
 
+struct rpcif_priv {
+	struct device *dev;
+	void __iomem *base;
+	void __iomem *dirmap;
+	struct regmap *regmap;
+	struct reset_control *rstc;
+	struct platform_device *vdev;
+	size_t size;
+	enum rpcif_type type;
+	enum rpcif_data_dir dir;
+	u8 bus_size;
+	u8 xfer_size;
+	void *buffer;
+	u32 xferlen;
+	u32 smcr;
+	u32 smadr;
+	u32 command;		/* DRCMR or SMCMR */
+	u32 option;		/* DROPR or SMOPR */
+	u32 enable;		/* DRENR or SMENR */
+	u32 dummy;		/* DRDMCR or SMDMCR */
+	u32 ddr;		/* DRDRENR or SMDRENR */
+};
 
 /*
  * Custom accessor functions to ensure SM[RW]DR[01] are always accessed with
- * proper width.  Requires rpcif.xfer_size to be correctly set before!
+ * proper width.  Requires rpcif_priv.xfer_size to be correctly set before!
  */
 static int rpcif_reg_read(void *context, unsigned int reg, unsigned int *val)
 {
-	struct rpcif *rpc = context;
+	struct rpcif_priv *rpc = context;
 
 	switch (reg) {
 	case RPCIF_SMRDR0:
@@ -206,7 +228,7 @@ static int rpcif_reg_read(void *context, unsigned int reg, unsigned int *val)
 
 static int rpcif_reg_write(void *context, unsigned int reg, unsigned int val)
 {
-	struct rpcif *rpc = context;
+	struct rpcif_priv *rpc = context;
 
 	switch (reg) {
 	case RPCIF_SMWDR0:
@@ -253,13 +275,12 @@ static const struct regmap_config rpcif_regmap_config = {
 	.volatile_table	= &rpcif_volatile_table,
 };
 
-int rpcif_sw_init(struct rpcif *rpc, struct device *dev)
+int rpcif_sw_init(struct rpcif *rpcif, struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
+	struct rpcif_priv *rpc = dev_get_drvdata(dev);
 	struct resource *res;
 
-	rpc->dev = dev;
-
 	rpc->base = devm_platform_ioremap_resource_byname(pdev, "regs");
 	if (IS_ERR(rpc->base))
 		return PTR_ERR(rpc->base);
@@ -280,12 +301,17 @@ int rpcif_sw_init(struct rpcif *rpc, struct device *dev)
 
 	rpc->type = (uintptr_t)of_device_get_match_data(dev);
 	rpc->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(rpc->rstc))
+		return PTR_ERR(rpc->rstc);
 
-	return PTR_ERR_OR_ZERO(rpc->rstc);
+	rpcif->dev = dev;
+	rpcif->dirmap = rpc->dirmap;
+	rpcif->size = rpc->size;
+	return 0;
 }
 EXPORT_SYMBOL(rpcif_sw_init);
 
-static void rpcif_rzg2l_timing_adjust_sdr(struct rpcif *rpc)
+static void rpcif_rzg2l_timing_adjust_sdr(struct rpcif_priv *rpc)
 {
 	regmap_write(rpc->regmap, RPCIF_PHYWR, 0xa5390000);
 	regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000000);
@@ -299,8 +325,9 @@ static void rpcif_rzg2l_timing_adjust_sdr(struct rpcif *rpc)
 	regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000032);
 }
 
-int rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
+int rpcif_hw_init(struct rpcif *rpcif, bool hyperflash)
 {
+	struct rpcif_priv *rpc = dev_get_drvdata(rpcif->dev);
 	u32 dummy;
 
 	pm_runtime_get_sync(rpc->dev);
@@ -364,7 +391,7 @@ int rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
 }
 EXPORT_SYMBOL(rpcif_hw_init);
 
-static int wait_msg_xfer_end(struct rpcif *rpc)
+static int wait_msg_xfer_end(struct rpcif_priv *rpc)
 {
 	u32 sts;
 
@@ -373,7 +400,7 @@ static int wait_msg_xfer_end(struct rpcif *rpc)
 					USEC_PER_SEC);
 }
 
-static u8 rpcif_bits_set(struct rpcif *rpc, u32 nbytes)
+static u8 rpcif_bits_set(struct rpcif_priv *rpc, u32 nbytes)
 {
 	if (rpc->bus_size == 2)
 		nbytes /= 2;
@@ -386,9 +413,11 @@ static u8 rpcif_bit_size(u8 buswidth)
 	return buswidth > 4 ? 2 : ilog2(buswidth);
 }
 
-void rpcif_prepare(struct rpcif *rpc, const struct rpcif_op *op, u64 *offs,
+void rpcif_prepare(struct rpcif *rpcif, const struct rpcif_op *op, u64 *offs,
 		   size_t *len)
 {
+	struct rpcif_priv *rpc = dev_get_drvdata(rpcif->dev);
+
 	rpc->smcr = 0;
 	rpc->smadr = 0;
 	rpc->enable = 0;
@@ -472,8 +501,9 @@ void rpcif_prepare(struct rpcif *rpc, const struct rpcif_op *op, u64 *offs,
 }
 EXPORT_SYMBOL(rpcif_prepare);
 
-int rpcif_manual_xfer(struct rpcif *rpc)
+int rpcif_manual_xfer(struct rpcif *rpcif)
 {
+	struct rpcif_priv *rpc = dev_get_drvdata(rpcif->dev);
 	u32 smenr, smcr, pos = 0, max = rpc->bus_size == 2 ? 8 : 4;
 	int ret = 0;
 
@@ -593,7 +623,7 @@ int rpcif_manual_xfer(struct rpcif *rpc)
 err_out:
 	if (reset_control_reset(rpc->rstc))
 		dev_err(rpc->dev, "Failed to reset HW\n");
-	rpcif_hw_init(rpc, rpc->bus_size == 2);
+	rpcif_hw_init(rpcif, rpc->bus_size == 2);
 	goto exit;
 }
 EXPORT_SYMBOL(rpcif_manual_xfer);
@@ -640,8 +670,9 @@ static void memcpy_fromio_readw(void *to,
 	}
 }
 
-ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 offs, size_t len, void *buf)
+ssize_t rpcif_dirmap_read(struct rpcif *rpcif, u64 offs, size_t len, void *buf)
 {
+	struct rpcif_priv *rpc = dev_get_drvdata(rpcif->dev);
 	loff_t from = offs & (rpc->size - 1);
 	size_t size = rpc->size - from;
 
@@ -676,6 +707,7 @@ static int rpcif_probe(struct platform_device *pdev)
 {
 	struct platform_device *vdev;
 	struct device_node *flash;
+	struct rpcif_priv *rpc;
 	const char *name;
 	int ret;
 
@@ -696,11 +728,18 @@ static int rpcif_probe(struct platform_device *pdev)
 	}
 	of_node_put(flash);
 
+	rpc = devm_kzalloc(&pdev->dev, sizeof(*rpc), GFP_KERNEL);
+	if (!rpc)
+		return -ENOMEM;
+
 	vdev = platform_device_alloc(name, pdev->id);
 	if (!vdev)
 		return -ENOMEM;
 	vdev->dev.parent = &pdev->dev;
-	platform_set_drvdata(pdev, vdev);
+
+	rpc->dev = &pdev->dev;
+	rpc->vdev = vdev;
+	platform_set_drvdata(pdev, rpc);
 
 	ret = platform_device_add(vdev);
 	if (ret) {
@@ -713,9 +752,9 @@ static int rpcif_probe(struct platform_device *pdev)
 
 static int rpcif_remove(struct platform_device *pdev)
 {
-	struct platform_device *vdev = platform_get_drvdata(pdev);
+	struct rpcif_priv *rpc = platform_get_drvdata(pdev);
 
-	platform_device_unregister(vdev);
+	platform_device_unregister(rpc->vdev);
 
 	return 0;
 }
diff --git a/include/memory/renesas-rpc-if.h b/include/memory/renesas-rpc-if.h
index 862eff613dc7963d..2dcb82df0d176ed1 100644
--- a/include/memory/renesas-rpc-if.h
+++ b/include/memory/renesas-rpc-if.h
@@ -65,24 +65,8 @@ enum rpcif_type {
 
 struct rpcif {
 	struct device *dev;
-	void __iomem *base;
 	void __iomem *dirmap;
-	struct regmap *regmap;
-	struct reset_control *rstc;
 	size_t size;
-	enum rpcif_type type;
-	enum rpcif_data_dir dir;
-	u8 bus_size;
-	u8 xfer_size;
-	void *buffer;
-	u32 xferlen;
-	u32 smcr;
-	u32 smadr;
-	u32 command;		/* DRCMR or SMCMR */
-	u32 option;		/* DROPR or SMOPR */
-	u32 enable;		/* DRENR or SMENR */
-	u32 dummy;		/* DRDMCR or SMDMCR */
-	u32 ddr;		/* DRDRENR or SMDRENR */
 };
 
 int rpcif_sw_init(struct rpcif *rpc, struct device *dev);
-- 
2.25.1

