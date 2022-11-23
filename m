Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9890D63621D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbiKWOly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbiKWOlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:41:37 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5428E58BCE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:41:33 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:881b:815b:474d:c3fd])
        by michel.telenet-ops.be with bizsmtp
        id nqhS2800Q49U0Rd06qhSXF; Wed, 23 Nov 2022 15:41:30 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oxqwH-001Rqk-TD; Wed, 23 Nov 2022 15:41:25 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oxqwH-0012Hi-5f; Wed, 23 Nov 2022 15:41:25 +0100
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
Subject: [PATCH v2 5/6] memory: renesas-rpc-if: Pass device instead of rpcif to rpcif_*()
Date:   Wed, 23 Nov 2022 15:41:21 +0100
Message-Id: <0460fe82ba348cedec7a9a75a8eff762c50e817b.1669213027.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1669213027.git.geert+renesas@glider.be>
References: <cover.1669213027.git.geert+renesas@glider.be>
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

Most rpcif_*() API functions do not need access to any other fields in
the rpcif structure than the device pointer.  Simplify dependencies by
passing the device pointer instead.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
v2:
  - Add Acked-by.
---
 drivers/memory/renesas-rpc-if.c | 32 ++++++++++++++++----------------
 drivers/mtd/hyperbus/rpc-if.c   | 18 +++++++++---------
 drivers/spi/spi-rpc-if.c        | 14 +++++++-------
 include/memory/renesas-rpc-if.h | 16 ++++++++--------
 4 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 9346dcc29a36662e..e26c67201781776d 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -300,13 +300,13 @@ static void rpcif_rzg2l_timing_adjust_sdr(struct rpcif_priv *rpc)
 	regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000032);
 }
 
-int rpcif_hw_init(struct rpcif *rpcif, bool hyperflash)
+int rpcif_hw_init(struct device *dev, bool hyperflash)
 {
-	struct rpcif_priv *rpc = dev_get_drvdata(rpcif->dev);
+	struct rpcif_priv *rpc = dev_get_drvdata(dev);
 	u32 dummy;
 	int ret;
 
-	ret = pm_runtime_resume_and_get(rpc->dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret)
 		return ret;
 
@@ -359,7 +359,7 @@ int rpcif_hw_init(struct rpcif *rpcif, bool hyperflash)
 	regmap_write(rpc->regmap, RPCIF_SSLDR, RPCIF_SSLDR_SPNDL(7) |
 		     RPCIF_SSLDR_SLNDL(7) | RPCIF_SSLDR_SCKDL(7));
 
-	pm_runtime_put(rpc->dev);
+	pm_runtime_put(dev);
 
 	rpc->bus_size = hyperflash ? 2 : 1;
 
@@ -389,10 +389,10 @@ static u8 rpcif_bit_size(u8 buswidth)
 	return buswidth > 4 ? 2 : ilog2(buswidth);
 }
 
-void rpcif_prepare(struct rpcif *rpcif, const struct rpcif_op *op, u64 *offs,
+void rpcif_prepare(struct device *dev, const struct rpcif_op *op, u64 *offs,
 		   size_t *len)
 {
-	struct rpcif_priv *rpc = dev_get_drvdata(rpcif->dev);
+	struct rpcif_priv *rpc = dev_get_drvdata(dev);
 
 	rpc->smcr = 0;
 	rpc->smadr = 0;
@@ -477,13 +477,13 @@ void rpcif_prepare(struct rpcif *rpcif, const struct rpcif_op *op, u64 *offs,
 }
 EXPORT_SYMBOL(rpcif_prepare);
 
-int rpcif_manual_xfer(struct rpcif *rpcif)
+int rpcif_manual_xfer(struct device *dev)
 {
-	struct rpcif_priv *rpc = dev_get_drvdata(rpcif->dev);
+	struct rpcif_priv *rpc = dev_get_drvdata(dev);
 	u32 smenr, smcr, pos = 0, max = rpc->bus_size == 2 ? 8 : 4;
 	int ret = 0;
 
-	ret = pm_runtime_resume_and_get(rpc->dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		return ret;
 
@@ -595,13 +595,13 @@ int rpcif_manual_xfer(struct rpcif *rpcif)
 	}
 
 exit:
-	pm_runtime_put(rpc->dev);
+	pm_runtime_put(dev);
 	return ret;
 
 err_out:
 	if (reset_control_reset(rpc->rstc))
-		dev_err(rpc->dev, "Failed to reset HW\n");
-	rpcif_hw_init(rpcif, rpc->bus_size == 2);
+		dev_err(dev, "Failed to reset HW\n");
+	rpcif_hw_init(dev, rpc->bus_size == 2);
 	goto exit;
 }
 EXPORT_SYMBOL(rpcif_manual_xfer);
@@ -648,9 +648,9 @@ static void memcpy_fromio_readw(void *to,
 	}
 }
 
-ssize_t rpcif_dirmap_read(struct rpcif *rpcif, u64 offs, size_t len, void *buf)
+ssize_t rpcif_dirmap_read(struct device *dev, u64 offs, size_t len, void *buf)
 {
-	struct rpcif_priv *rpc = dev_get_drvdata(rpcif->dev);
+	struct rpcif_priv *rpc = dev_get_drvdata(dev);
 	loff_t from = offs & (rpc->size - 1);
 	size_t size = rpc->size - from;
 	int ret;
@@ -658,7 +658,7 @@ ssize_t rpcif_dirmap_read(struct rpcif *rpcif, u64 offs, size_t len, void *buf)
 	if (len > size)
 		len = size;
 
-	ret = pm_runtime_resume_and_get(rpc->dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		return ret;
 
@@ -678,7 +678,7 @@ ssize_t rpcif_dirmap_read(struct rpcif *rpcif, u64 offs, size_t len, void *buf)
 	else
 		memcpy_fromio(buf, rpc->dirmap + from, len);
 
-	pm_runtime_put(rpc->dev);
+	pm_runtime_put(dev);
 
 	return len;
 }
diff --git a/drivers/mtd/hyperbus/rpc-if.c b/drivers/mtd/hyperbus/rpc-if.c
index d00d302434030b20..41734e337ac00e40 100644
--- a/drivers/mtd/hyperbus/rpc-if.c
+++ b/drivers/mtd/hyperbus/rpc-if.c
@@ -56,7 +56,7 @@ static void rpcif_hb_prepare_read(struct rpcif *rpc, void *to,
 	op.data.nbytes = len;
 	op.data.buf.in = to;
 
-	rpcif_prepare(rpc, &op, NULL, NULL);
+	rpcif_prepare(rpc->dev, &op, NULL, NULL);
 }
 
 static void rpcif_hb_prepare_write(struct rpcif *rpc, unsigned long to,
@@ -70,7 +70,7 @@ static void rpcif_hb_prepare_write(struct rpcif *rpc, unsigned long to,
 	op.data.nbytes = len;
 	op.data.buf.out = from;
 
-	rpcif_prepare(rpc, &op, NULL, NULL);
+	rpcif_prepare(rpc->dev, &op, NULL, NULL);
 }
 
 static u16 rpcif_hb_read16(struct hyperbus_device *hbdev, unsigned long addr)
@@ -81,7 +81,7 @@ static u16 rpcif_hb_read16(struct hyperbus_device *hbdev, unsigned long addr)
 
 	rpcif_hb_prepare_read(&hyperbus->rpc, &data, addr, 2);
 
-	rpcif_manual_xfer(&hyperbus->rpc);
+	rpcif_manual_xfer(hyperbus->rpc.dev);
 
 	return data.x[0];
 }
@@ -94,7 +94,7 @@ static void rpcif_hb_write16(struct hyperbus_device *hbdev, unsigned long addr,
 
 	rpcif_hb_prepare_write(&hyperbus->rpc, addr, &data, 2);
 
-	rpcif_manual_xfer(&hyperbus->rpc);
+	rpcif_manual_xfer(hyperbus->rpc.dev);
 }
 
 static void rpcif_hb_copy_from(struct hyperbus_device *hbdev, void *to,
@@ -105,7 +105,7 @@ static void rpcif_hb_copy_from(struct hyperbus_device *hbdev, void *to,
 
 	rpcif_hb_prepare_read(&hyperbus->rpc, to, from, len);
 
-	rpcif_dirmap_read(&hyperbus->rpc, from, len, to);
+	rpcif_dirmap_read(hyperbus->rpc.dev, from, len, to);
 }
 
 static const struct hyperbus_ops rpcif_hb_ops = {
@@ -130,9 +130,9 @@ static int rpcif_hb_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, hyperbus);
 
-	rpcif_enable_rpm(&hyperbus->rpc);
+	rpcif_enable_rpm(hyperbus->rpc.dev);
 
-	error = rpcif_hw_init(&hyperbus->rpc, true);
+	error = rpcif_hw_init(hyperbus->rpc.dev, true);
 	if (error)
 		goto out_disable_rpm;
 
@@ -150,7 +150,7 @@ static int rpcif_hb_probe(struct platform_device *pdev)
 	return 0;
 
 out_disable_rpm:
-	rpcif_disable_rpm(&hyperbus->rpc);
+	rpcif_disable_rpm(hyperbus->rpc.dev);
 	return error;
 }
 
@@ -160,7 +160,7 @@ static int rpcif_hb_remove(struct platform_device *pdev)
 
 	hyperbus_unregister_device(&hyperbus->hbdev);
 
-	rpcif_disable_rpm(&hyperbus->rpc);
+	rpcif_disable_rpm(hyperbus->rpc.dev);
 
 	return 0;
 }
diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index 24ec1c83f379ceec..5063587d2c724c7c 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -58,7 +58,7 @@ static void rpcif_spi_mem_prepare(struct spi_device *spi_dev,
 		rpc_op.data.dir = RPCIF_NO_DATA;
 	}
 
-	rpcif_prepare(rpc, &rpc_op, offs, len);
+	rpcif_prepare(rpc->dev, &rpc_op, offs, len);
 }
 
 static bool rpcif_spi_mem_supports_op(struct spi_mem *mem,
@@ -86,7 +86,7 @@ static ssize_t rpcif_spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	rpcif_spi_mem_prepare(desc->mem->spi, &desc->info.op_tmpl, &offs, &len);
 
-	return rpcif_dirmap_read(rpc, offs, len, buf);
+	return rpcif_dirmap_read(rpc->dev, offs, len, buf);
 }
 
 static int rpcif_spi_mem_dirmap_create(struct spi_mem_dirmap_desc *desc)
@@ -117,7 +117,7 @@ static int rpcif_spi_mem_exec_op(struct spi_mem *mem,
 
 	rpcif_spi_mem_prepare(mem->spi, op, NULL, NULL);
 
-	return rpcif_manual_xfer(rpc);
+	return rpcif_manual_xfer(rpc->dev);
 }
 
 static const struct spi_controller_mem_ops rpcif_spi_mem_ops = {
@@ -147,7 +147,7 @@ static int rpcif_spi_probe(struct platform_device *pdev)
 
 	ctlr->dev.of_node = parent->of_node;
 
-	rpcif_enable_rpm(rpc);
+	rpcif_enable_rpm(rpc->dev);
 
 	ctlr->num_chipselect = 1;
 	ctlr->mem_ops = &rpcif_spi_mem_ops;
@@ -156,7 +156,7 @@ static int rpcif_spi_probe(struct platform_device *pdev)
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_QUAD | SPI_RX_QUAD;
 	ctlr->flags = SPI_CONTROLLER_HALF_DUPLEX;
 
-	error = rpcif_hw_init(rpc, false);
+	error = rpcif_hw_init(rpc->dev, false);
 	if (error)
 		goto out_disable_rpm;
 
@@ -169,7 +169,7 @@ static int rpcif_spi_probe(struct platform_device *pdev)
 	return 0;
 
 out_disable_rpm:
-	rpcif_disable_rpm(rpc);
+	rpcif_disable_rpm(rpc->dev);
 	return error;
 }
 
@@ -179,7 +179,7 @@ static int rpcif_spi_remove(struct platform_device *pdev)
 	struct rpcif *rpc = spi_controller_get_devdata(ctlr);
 
 	spi_unregister_controller(ctlr);
-	rpcif_disable_rpm(rpc);
+	rpcif_disable_rpm(rpc->dev);
 
 	return 0;
 }
diff --git a/include/memory/renesas-rpc-if.h b/include/memory/renesas-rpc-if.h
index 2dcb82df0d176ed1..86a26ea78221a204 100644
--- a/include/memory/renesas-rpc-if.h
+++ b/include/memory/renesas-rpc-if.h
@@ -70,20 +70,20 @@ struct rpcif {
 };
 
 int rpcif_sw_init(struct rpcif *rpc, struct device *dev);
-int rpcif_hw_init(struct rpcif *rpc, bool hyperflash);
-void rpcif_prepare(struct rpcif *rpc, const struct rpcif_op *op, u64 *offs,
+int rpcif_hw_init(struct device *dev, bool hyperflash);
+void rpcif_prepare(struct device *dev, const struct rpcif_op *op, u64 *offs,
 		   size_t *len);
-int rpcif_manual_xfer(struct rpcif *rpc);
-ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 offs, size_t len, void *buf);
+int rpcif_manual_xfer(struct device *dev);
+ssize_t rpcif_dirmap_read(struct device *dev, u64 offs, size_t len, void *buf);
 
-static inline void rpcif_enable_rpm(struct rpcif *rpc)
+static inline void rpcif_enable_rpm(struct device *dev)
 {
-	pm_runtime_enable(rpc->dev);
+	pm_runtime_enable(dev);
 }
 
-static inline void rpcif_disable_rpm(struct rpcif *rpc)
+static inline void rpcif_disable_rpm(struct device *dev)
 {
-	pm_runtime_disable(rpc->dev);
+	pm_runtime_disable(dev);
 }
 
 #endif // __RENESAS_RPC_IF_H
-- 
2.25.1

