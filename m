Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4D66B79B2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjCMN6u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Mar 2023 09:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjCMN6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:58:36 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4902D14203;
        Mon, 13 Mar 2023 06:58:20 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id C2E5B24E195;
        Mon, 13 Mar 2023 21:58:17 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Mar
 2023 21:58:17 +0800
Received: from ubuntu.localdomain (202.190.105.77) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Mar
 2023 21:58:02 +0800
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v3 4/4] crypto: starfive - Add hash and HMAC support
Date:   Mon, 13 Mar 2023 21:56:46 +0800
Message-ID: <20230313135646.2077707-5-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230313135646.2077707-1-jiajie.ho@starfivetech.com>
References: <20230313135646.2077707-1-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.190.105.77]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding hash/HMAC support for SHA-2 and SM3 to StarFive cryptographic
module.

Co-developed-by: Huan Feng <huan.feng@starfivetech.com>
Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 drivers/crypto/starfive/Kconfig       |    4 +
 drivers/crypto/starfive/Makefile      |    2 +-
 drivers/crypto/starfive/jh7110-cryp.c |   35 +
 drivers/crypto/starfive/jh7110-cryp.h |   69 +-
 drivers/crypto/starfive/jh7110-hash.c | 1041 +++++++++++++++++++++++++
 5 files changed, 1147 insertions(+), 4 deletions(-)
 create mode 100644 drivers/crypto/starfive/jh7110-hash.c

diff --git a/drivers/crypto/starfive/Kconfig b/drivers/crypto/starfive/Kconfig
index 73f39b6bc09f..cde485910f88 100644
--- a/drivers/crypto/starfive/Kconfig
+++ b/drivers/crypto/starfive/Kconfig
@@ -6,6 +6,10 @@ config CRYPTO_DEV_JH7110
 	tristate "StarFive JH7110 cryptographic engine driver"
 	depends on SOC_STARFIVE
 	select CRYPTO_ENGINE
+	select CRYPTO_HMAC
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
+	select CRYPTO_SM3_GENERIC
 	select ARM_AMBA
 	select DMADEVICES
 	select AMBA_PL08X
diff --git a/drivers/crypto/starfive/Makefile b/drivers/crypto/starfive/Makefile
index 071a4872fb5f..2af49062e36d 100644
--- a/drivers/crypto/starfive/Makefile
+++ b/drivers/crypto/starfive/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_CRYPTO_DEV_JH7110) += jh7110-crypto.o
-starfive-crypto-objs := jh7110-cryp.o
+jh7110-crypto-objs := jh7110-cryp.o jh7110-hash.o
diff --git a/drivers/crypto/starfive/jh7110-cryp.c b/drivers/crypto/starfive/jh7110-cryp.c
index abd500f3c1f3..94c99aab308f 100644
--- a/drivers/crypto/starfive/jh7110-cryp.c
+++ b/drivers/crypto/starfive/jh7110-cryp.c
@@ -85,10 +85,25 @@ static void starfive_dma_cleanup(struct starfive_cryp_dev *cryp)
 	dma_release_channel(cryp->rx);
 }
 
+static irqreturn_t starfive_cryp_irq(int irq, void *priv)
+{
+	u32 status;
+	struct starfive_cryp_dev *cryp = (struct starfive_cryp_dev *)priv;
+
+	status = readl(cryp->base + STARFIVE_IE_FLAG_OFFSET);
+	if (status & STARFIVE_IE_FLAG_HASH_DONE) {
+		writel(STARFIVE_IE_MASK_HASH_DONE, cryp->base + STARFIVE_IE_MASK_OFFSET);
+		complete(&cryp->hash_done);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int starfive_cryp_probe(struct platform_device *pdev)
 {
 	struct starfive_cryp_dev *cryp;
 	struct resource *res;
+	int irq;
 	int ret;
 
 	cryp = devm_kzalloc(&pdev->dev, sizeof(*cryp), GFP_KERNEL);
@@ -121,6 +136,18 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(cryp->rst),
 				     "Error getting hardware reset line\n");
 
+	init_completion(&cryp->hash_done);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(&pdev->dev, irq, starfive_cryp_irq, 0, pdev->name,
+			       (void *)cryp);
+	if (ret)
+		return dev_err_probe(&pdev->dev, irq,
+				     "Failed to register interrupt handler\n");
+
 	clk_prepare_enable(cryp->hclk);
 	clk_prepare_enable(cryp->ahb);
 	reset_control_deassert(cryp->rst);
@@ -144,8 +171,14 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_engine_start;
 
+	ret = starfive_hash_register_algs();
+	if (ret)
+		goto err_algs_hash;
+
 	return 0;
 
+err_algs_hash:
+	crypto_engine_stop(cryp->engine);
 err_engine_start:
 	crypto_engine_exit(cryp->engine);
 err_engine:
@@ -165,6 +198,8 @@ static int starfive_cryp_remove(struct platform_device *pdev)
 	if (!cryp)
 		return -ENODEV;
 
+	starfive_hash_unregister_algs();
+
 	crypto_engine_stop(cryp->engine);
 	crypto_engine_exit(cryp->engine);
 
diff --git a/drivers/crypto/starfive/jh7110-cryp.h b/drivers/crypto/starfive/jh7110-cryp.h
index 2ac87ed3fb03..28cc73308031 100644
--- a/drivers/crypto/starfive/jh7110-cryp.h
+++ b/drivers/crypto/starfive/jh7110-cryp.h
@@ -7,6 +7,8 @@
 #include <linux/dmaengine.h>
 
 #include <crypto/engine.h>
+#include <crypto/sha2.h>
+#include <crypto/sm3.h>
 
 #define STARFIVE_ALG_CR_OFFSET			0x0
 #define STARFIVE_ALG_FIFO_OFFSET		0x4
@@ -15,7 +17,44 @@
 #define STARFIVE_DMA_IN_LEN_OFFSET		0x10
 #define STARFIVE_DMA_OUT_LEN_OFFSET		0x14
 
+#define STARFIVE_IE_MASK_HASH_DONE		BIT(2)
+#define STARFIVE_IE_FLAG_HASH_DONE		BIT(2)
+
 #define STARFIVE_MSG_BUFFER_SIZE		SZ_16K
+#define MAX_KEY_SIZE				SHA512_BLOCK_SIZE
+
+union starfive_hash_csr {
+	u32 v;
+	struct {
+		u32 start			:1;
+		u32 reset			:1;
+		u32 ie				:1;
+		u32 firstb			:1;
+#define STARFIVE_HASH_SM3			0x0
+#define STARFIVE_HASH_SHA224			0x3
+#define STARFIVE_HASH_SHA256			0x4
+#define STARFIVE_HASH_SHA384			0x5
+#define STARFIVE_HASH_SHA512			0x6
+#define STARFIVE_HASH_MODE_MASK			0x7
+		u32 mode			:3;
+		u32 rsvd_1			:1;
+		u32 final			:1;
+		u32 rsvd_2			:2;
+#define STARFIVE_HASH_HMAC_FLAGS		0x800
+		u32 hmac			:1;
+		u32 rsvd_3			:1;
+#define STARFIVE_HASH_KEY_DONE			BIT(13)
+		u32 key_done			:1;
+		u32 key_flag			:1;
+#define STARFIVE_HASH_HMAC_DONE			BIT(15)
+		u32 hmac_done			:1;
+#define STARFIVE_HASH_BUSY			BIT(16)
+		u32 busy			:1;
+		u32 hashdone			:1;
+		u32 rsvd_4			:14;
+	};
+};
+
 
 union starfive_alg_cr {
 	u32 v;
@@ -34,14 +73,17 @@ union starfive_alg_cr {
 struct starfive_cryp_ctx {
 	struct crypto_engine_ctx		enginectx;
 	struct starfive_cryp_dev		*cryp;
+	struct starfive_cryp_request_ctx	*rctx;
 
-	u8					*buffer;
+	unsigned int				hash_mode;
+	u8					key[MAX_KEY_SIZE];
+	int					keylen;
+	struct crypto_ahash			*ahash_fbk;
 };
 
 struct starfive_cryp_dev {
 	struct list_head			list;
 	struct device				*dev;
-
 	struct clk				*hclk;
 	struct clk				*ahb;
 	struct reset_control			*rst;
@@ -56,12 +98,33 @@ struct starfive_cryp_dev {
 	struct dma_slave_config			cfg_out;
 	struct completion			tx_comp;
 	struct completion			rx_comp;
-
+	struct completion			hash_done;
 	struct crypto_engine			*engine;
 
 	union starfive_alg_cr			alg_cr;
 };
 
+struct starfive_cryp_request_ctx {
+	union {
+		struct ahash_request		*hreq;
+	} req;
+	union {
+		union starfive_hash_csr		hash;
+	} csr;
+
+	struct scatterlist			*in_sg;
+	struct scatterlist			in_sgl;
+	struct ahash_request			ahash_fbk_req;
+	size_t					total;
+	unsigned int				blksize;
+	unsigned int				digsize;
+	unsigned long				in_sg_len;
+	bool					sgs_copied;
+};
+
 struct starfive_cryp_dev *starfive_cryp_find_dev(struct starfive_cryp_ctx *ctx);
 
+int starfive_hash_register_algs(void);
+void starfive_hash_unregister_algs(void);
+
 #endif
diff --git a/drivers/crypto/starfive/jh7110-hash.c b/drivers/crypto/starfive/jh7110-hash.c
new file mode 100644
index 000000000000..39570f517ccc
--- /dev/null
+++ b/drivers/crypto/starfive/jh7110-hash.c
@@ -0,0 +1,1041 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Hash function and HMAC support for StarFive driver
+ *
+ * Copyright (c) 2022 StarFive Technology
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/crypto.h>
+#include <linux/dma-direct.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/amba/pl080.h>
+
+#include <crypto/hash.h>
+#include <crypto/scatterwalk.h>
+#include <crypto/internal/hash.h>
+
+#include "jh7110-cryp.h"
+
+#define STARFIVE_HASH_REGS_OFFSET	0x300
+#define STARFIVE_HASH_SHACSR		(STARFIVE_HASH_REGS_OFFSET + 0x0)
+#define STARFIVE_HASH_SHAWDR		(STARFIVE_HASH_REGS_OFFSET + 0x4)
+#define STARFIVE_HASH_SHARDR		(STARFIVE_HASH_REGS_OFFSET + 0x8)
+#define STARFIVE_HASH_SHAWSR		(STARFIVE_HASH_REGS_OFFSET + 0xC)
+#define STARFIVE_HASH_SHAWLEN3		(STARFIVE_HASH_REGS_OFFSET + 0x10)
+#define STARFIVE_HASH_SHAWLEN2		(STARFIVE_HASH_REGS_OFFSET + 0x14)
+#define STARFIVE_HASH_SHAWLEN1		(STARFIVE_HASH_REGS_OFFSET + 0x18)
+#define STARFIVE_HASH_SHAWLEN0		(STARFIVE_HASH_REGS_OFFSET + 0x1C)
+#define STARFIVE_HASH_SHAWKR		(STARFIVE_HASH_REGS_OFFSET + 0x20)
+#define STARFIVE_HASH_SHAWKLEN		(STARFIVE_HASH_REGS_OFFSET + 0x24)
+
+#define STARFIVE_HASH_BUFLEN		SHA512_BLOCK_SIZE
+
+static inline int starfive_hash_wait_busy(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	u32 status;
+
+	return readl_relaxed_poll_timeout(cryp->base + STARFIVE_HASH_SHACSR, status,
+					  !(status & STARFIVE_HASH_BUSY), 10, 100000);
+}
+
+static inline int starfive_hash_wait_key_done(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	u32 status;
+
+	return readl_relaxed_poll_timeout(cryp->base + STARFIVE_HASH_SHACSR, status,
+					  (status & STARFIVE_HASH_KEY_DONE), 10, 100000);
+}
+
+static void starfive_hash_start(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+
+	rctx->csr.hash.v = readl(cryp->base + STARFIVE_HASH_SHACSR);
+	rctx->csr.hash.firstb = 0;
+	rctx->csr.hash.final = 1;
+
+	writel(rctx->csr.hash.v, cryp->base + STARFIVE_HASH_SHACSR);
+}
+
+static int starfive_hash_hmac_key(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	int klen = ctx->keylen, loop;
+	unsigned int *key = (unsigned int *)ctx->key;
+	unsigned char *cl;
+
+	writel(ctx->keylen, cryp->base + STARFIVE_HASH_SHAWKLEN);
+
+	rctx->csr.hash.hmac = !!(ctx->hash_mode & STARFIVE_HASH_HMAC_FLAGS);
+	rctx->csr.hash.key_flag = 1;
+
+	writel(rctx->csr.hash.v, cryp->base + STARFIVE_HASH_SHACSR);
+
+	for (loop = 0; loop < klen / sizeof(unsigned int); loop++, key++)
+		writel(*key, cryp->base + STARFIVE_HASH_SHAWKR);
+
+	if (klen & 0x3) {
+		cl = (unsigned char *)key;
+		for (loop = 0; loop < (klen & 0x3); loop++, cl++)
+			writeb(*cl, cryp->base + STARFIVE_HASH_SHAWKR);
+	}
+
+	if (starfive_hash_wait_key_done(ctx))
+		return dev_err_probe(cryp->dev, -ETIMEDOUT, "starfive_hash_wait_key_done error\n");
+
+	return 0;
+}
+
+static void starfive_hash_dma_callback(void *param)
+{
+	struct starfive_cryp_dev *cryp = param;
+
+	complete(&cryp->tx_comp);
+}
+
+static int starfive_hash_xmit_dma(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct dma_async_tx_descriptor	*in_desc;
+	dma_cookie_t cookie;
+	union  starfive_alg_cr alg_cr;
+	int total_len;
+	int ret;
+
+	if (!rctx->total)
+		return 0;
+
+	writel(rctx->total, cryp->base + STARFIVE_DMA_IN_LEN_OFFSET);
+
+	total_len = rctx->total;
+	total_len = (total_len & 0x3) ? (((total_len >> 2) + 1) << 2) : total_len;
+	sg_dma_len(rctx->in_sg) = total_len;
+
+	alg_cr.v = 0;
+	alg_cr.start = 1;
+	alg_cr.hash_dma_en = 1;
+
+	writel(alg_cr.v, cryp->base + STARFIVE_ALG_CR_OFFSET);
+
+	ret = dma_map_sg(cryp->dev, rctx->in_sg, rctx->in_sg_len, DMA_TO_DEVICE);
+	if (!ret)
+		return dev_err_probe(cryp->dev, -EINVAL, "dma_map_sg() error\n");
+
+	cryp->cfg_in.direction = DMA_MEM_TO_DEV;
+	cryp->cfg_in.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cryp->cfg_in.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cryp->cfg_in.src_maxburst = cryp->dma_maxburst;
+	cryp->cfg_in.dst_maxburst = cryp->dma_maxburst;
+	cryp->cfg_in.dst_addr = cryp->phys_base + STARFIVE_ALG_FIFO_OFFSET;
+
+	dmaengine_slave_config(cryp->tx, &cryp->cfg_in);
+
+	in_desc = dmaengine_prep_slave_sg(cryp->tx, rctx->in_sg,
+					  rctx->in_sg_len, DMA_MEM_TO_DEV,
+					  DMA_PREP_INTERRUPT  |  DMA_CTRL_ACK);
+
+	if (!in_desc)
+		return -EINVAL;
+
+	reinit_completion(&cryp->tx_comp);
+
+	in_desc->callback = starfive_hash_dma_callback;
+	in_desc->callback_param = cryp;
+
+	cookie = dmaengine_submit(in_desc);
+	dma_async_issue_pending(cryp->tx);
+
+	if (!wait_for_completion_timeout(&cryp->tx_comp,
+					 msecs_to_jiffies(10000))) {
+		dev_err(cryp->dev, "wait_for_completion_timeout error, cookie = %x\n",
+			dma_async_is_tx_complete(cryp->rx, cookie,
+						 NULL, NULL));
+	}
+
+	dma_unmap_sg(cryp->dev, rctx->in_sg, rctx->in_sg_len, DMA_TO_DEVICE);
+
+	alg_cr.v = 0;
+	alg_cr.clear = 1;
+
+	writel(alg_cr.v, cryp->base + STARFIVE_ALG_CR_OFFSET);
+
+	return 0;
+}
+
+static int starfive_hash_xmit(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	int ret;
+
+	rctx->csr.hash.v = 0;
+	rctx->csr.hash.reset = 1;
+	writel(rctx->csr.hash.v, cryp->base + STARFIVE_HASH_SHACSR);
+
+	if (starfive_hash_wait_busy(ctx))
+		return dev_err_probe(cryp->dev, -ETIMEDOUT, "Error resetting engine.\n");
+
+	rctx->csr.hash.v = 0;
+	rctx->csr.hash.mode = ctx->hash_mode & STARFIVE_HASH_MODE_MASK;
+	rctx->csr.hash.ie = 1;
+
+	if (ctx->hash_mode & STARFIVE_HASH_HMAC_FLAGS) {
+		ret = starfive_hash_hmac_key(ctx);
+		if (ret)
+			return ret;
+	} else {
+		rctx->csr.hash.start = 1;
+		rctx->csr.hash.firstb = 1;
+		writel(rctx->csr.hash.v, cryp->base + STARFIVE_HASH_SHACSR);
+	}
+
+	ret = starfive_hash_xmit_dma(ctx);
+	if (ret)
+		return ret;
+
+	reinit_completion(&cryp->hash_done);
+	writel(~STARFIVE_IE_MASK_HASH_DONE, cryp->base + STARFIVE_IE_MASK_OFFSET);
+
+	starfive_hash_start(ctx);
+
+	if (!wait_for_completion_timeout(&cryp->hash_done, usecs_to_jiffies(1000)))
+		return dev_err_probe(cryp->dev, -ETIMEDOUT, "Timeout waiting for hash done\n");
+
+	return 0;
+}
+
+static int starfive_hash_copy_hash(struct ahash_request *req)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
+	int count, *data;
+	int mlen;
+
+	if (!req->result)
+		return 0;
+
+	mlen = rctx->digsize / sizeof(u32);
+	data = (u32 *)req->result;
+
+	for (count = 0; count < mlen; count++)
+		data[count] = readl(ctx->cryp->base + STARFIVE_HASH_SHARDR);
+
+	return 0;
+}
+
+static void starfive_hash_finish_req(struct ahash_request *req, int err)
+{
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+
+	if (!err)
+		err = starfive_hash_copy_hash(req);
+
+	if (rctx->sgs_copied) {
+		void *buf_in;
+		int pages, len;
+
+		buf_in = sg_virt(&rctx->in_sgl);
+		len = ALIGN(rctx->total, rctx->blksize);
+		pages = len ? get_order(len) : 1;
+		free_pages((unsigned long)buf_in, pages);
+	}
+
+	crypto_finalize_hash_request(cryp->engine, req, err);
+}
+
+static int starfive_hash_check_aligned(struct scatterlist *sg, size_t total, size_t align)
+{
+	int len = 0;
+
+	if (!total)
+		return 0;
+
+	if (!IS_ALIGNED(total, align))
+		return -EINVAL;
+
+	while (sg) {
+		if (!IS_ALIGNED(sg->offset, sizeof(u32)))
+			return -EINVAL;
+
+		if (!IS_ALIGNED(sg->length, align))
+			return -EINVAL;
+
+		len += sg->length;
+		sg = sg_next(sg);
+	}
+
+	if (len != total)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int starfive_hash_check_io_aligned(struct starfive_cryp_request_ctx *rctx)
+{
+	return starfive_hash_check_aligned(rctx->in_sg, rctx->total, rctx->blksize);
+}
+
+static void sg_copy_buf(void *buf, struct scatterlist *sg,
+			unsigned int start, unsigned int nbytes, int out)
+{
+	struct scatter_walk walk;
+
+	if (!nbytes)
+		return;
+
+	scatterwalk_start(&walk, sg);
+	scatterwalk_advance(&walk, start);
+	scatterwalk_copychunks(buf, &walk, nbytes, out);
+	scatterwalk_done(&walk, out, 0);
+}
+
+static int starfive_hash_copy_sgs(struct starfive_cryp_request_ctx *rctx)
+{
+	void *buf_in;
+	int pages, total_in;
+
+	if (!starfive_hash_check_io_aligned(rctx)) {
+		rctx->sgs_copied = 0;
+		return 0;
+	}
+
+	total_in = ALIGN(rctx->total, rctx->blksize);
+	pages = total_in ? get_order(total_in) : 1;
+	buf_in = (void *)__get_free_pages(GFP_ATOMIC, pages);
+	if (!buf_in) {
+		rctx->sgs_copied = 0;
+		return -EFAULT;
+	}
+
+	sg_copy_buf(buf_in, rctx->in_sg, 0, rctx->total, 0);
+	sg_init_one(&rctx->in_sgl, buf_in, total_in);
+
+	rctx->in_sg = &rctx->in_sgl;
+	rctx->in_sg_len = 1;
+	rctx->sgs_copied = 1;
+
+	return 0;
+}
+
+static int starfive_hash_prepare_req(struct crypto_engine *engine, void *areq)
+{
+	struct ahash_request *req = container_of(areq, struct ahash_request,
+						 base);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+
+	if (!cryp)
+		return -ENODEV;
+
+	rctx->req.hreq = req;
+
+	return starfive_hash_copy_sgs(rctx);
+}
+
+static int starfive_hash_one_request(struct crypto_engine *engine, void *areq)
+{
+	struct ahash_request *req = container_of(areq, struct ahash_request,
+						 base);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	int err;
+
+	if (!cryp)
+		return -ENODEV;
+
+	err = starfive_hash_xmit(ctx);
+	if (err)
+		return err;
+
+	starfive_hash_finish_req(req, err);
+
+	return 0;
+}
+
+static int starfive_hash_init(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->ahash_fbk_req, ctx->ahash_fbk);
+	rctx->ahash_fbk_req.base.flags = req->base.flags
+		& CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	return crypto_ahash_init(&rctx->ahash_fbk_req);
+}
+
+static int starfive_hash_update(struct ahash_request *req)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->ahash_fbk_req, ctx->ahash_fbk);
+	rctx->ahash_fbk_req.base.flags = req->base.flags
+		& CRYPTO_TFM_REQ_MAY_SLEEP;
+	rctx->ahash_fbk_req.nbytes = req->nbytes;
+	rctx->ahash_fbk_req.src = req->src;
+
+	return crypto_ahash_update(&rctx->ahash_fbk_req);
+}
+
+static int starfive_hash_final(struct ahash_request *req)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->ahash_fbk_req, ctx->ahash_fbk);
+	rctx->ahash_fbk_req.base.flags = req->base.flags
+		& CRYPTO_TFM_REQ_MAY_SLEEP;
+	rctx->ahash_fbk_req.result = req->result;
+
+	return crypto_ahash_final(&rctx->ahash_fbk_req);
+}
+
+static int starfive_hash_finup(struct ahash_request *req)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->ahash_fbk_req, ctx->ahash_fbk);
+	rctx->ahash_fbk_req.base.flags = req->base.flags
+		& CRYPTO_TFM_REQ_MAY_SLEEP;
+	rctx->ahash_fbk_req.nbytes = req->nbytes;
+	rctx->ahash_fbk_req.src = req->src;
+	rctx->ahash_fbk_req.result = req->result;
+
+	return crypto_ahash_finup(&rctx->ahash_fbk_req);
+}
+
+static int starfive_hash_digest(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+
+	memset(rctx, 0, sizeof(struct starfive_cryp_request_ctx));
+
+	rctx->req.hreq = req;
+	rctx->total = req->nbytes;
+	rctx->in_sg = req->src;
+	rctx->blksize = crypto_tfm_alg_blocksize(crypto_ahash_tfm(tfm));
+	rctx->digsize = crypto_ahash_digestsize(tfm);
+	rctx->in_sg_len = sg_nents_for_len(rctx->in_sg, rctx->total);
+	ctx->rctx = rctx;
+
+	return crypto_transfer_hash_request_to_engine(cryp->engine, req);
+}
+
+static int starfive_hash_export(struct ahash_request *req, void *out)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->ahash_fbk_req, ctx->ahash_fbk);
+	rctx->ahash_fbk_req.base.flags = req->base.flags
+		& CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	return crypto_ahash_export(&rctx->ahash_fbk_req, out);
+}
+
+static int starfive_hash_import(struct ahash_request *req, const void *in)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->ahash_fbk_req, ctx->ahash_fbk);
+	rctx->ahash_fbk_req.base.flags = req->base.flags
+		& CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	return crypto_ahash_import(&rctx->ahash_fbk_req, in);
+}
+
+static int starfive_hash_cra_init_algs(struct crypto_tfm *tfm,
+				       const char *algs_hmac_name,
+				       unsigned int mode,
+				       const char *alg_name)
+{
+	struct starfive_cryp_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct crypto_ahash *ahash = __crypto_ahash_cast(tfm);
+
+	ctx->cryp = starfive_cryp_find_dev(ctx);
+
+	if (!ctx->cryp)
+		return -ENODEV;
+
+	ctx->ahash_fbk = crypto_alloc_ahash(alg_name, 0,
+					    CRYPTO_ALG_NEED_FALLBACK);
+
+	if (IS_ERR(ctx->ahash_fbk))
+		return dev_err_probe(ctx->cryp->dev, PTR_ERR(ctx->ahash_fbk),
+				     "starfive_hash: Could not load fallback driver.\n");
+
+	crypto_hash_alg_common(ahash)->statesize = crypto_ahash_statesize(ctx->ahash_fbk);
+	crypto_ahash_set_reqsize(ahash, sizeof(struct starfive_cryp_request_ctx) +
+				 crypto_ahash_reqsize(ctx->ahash_fbk));
+
+	ctx->keylen = 0;
+	ctx->hash_mode = mode;
+
+	if (algs_hmac_name)
+		ctx->hash_mode |= STARFIVE_HASH_HMAC_FLAGS;
+
+	ctx->enginectx.op.do_one_request = starfive_hash_one_request;
+	ctx->enginectx.op.prepare_request = starfive_hash_prepare_req;
+	ctx->enginectx.op.unprepare_request = NULL;
+
+	return 0;
+}
+
+static void starfive_hash_cra_exit(struct crypto_tfm *tfm)
+{
+	struct starfive_cryp_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	crypto_free_ahash(ctx->ahash_fbk);
+
+	ctx->ahash_fbk = NULL;
+	ctx->enginectx.op.do_one_request = NULL;
+	ctx->enginectx.op.prepare_request = NULL;
+	ctx->enginectx.op.unprepare_request = NULL;
+}
+
+static int starfive_hash_long_setkey(struct starfive_cryp_ctx *ctx,
+				     const u8 *key, unsigned int keylen,
+				     const char *alg_name)
+{
+	struct crypto_wait wait;
+	struct ahash_request *req;
+	struct scatterlist sg;
+	struct crypto_ahash *ahash_tfm;
+	u8 *buf;
+	int ret;
+
+	ahash_tfm = crypto_alloc_ahash(alg_name, 0, 0);
+	if (IS_ERR(ahash_tfm))
+		return PTR_ERR(ahash_tfm);
+
+	req = ahash_request_alloc(ahash_tfm, GFP_KERNEL);
+	if (!req) {
+		ret = -ENOMEM;
+		goto err_free_ahash;
+	}
+
+	crypto_init_wait(&wait);
+	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				   crypto_req_done, &wait);
+	crypto_ahash_clear_flags(ahash_tfm, ~0);
+
+	buf = kzalloc(keylen + STARFIVE_HASH_BUFLEN, GFP_KERNEL);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto err_free_req;
+	}
+
+	memcpy(buf, key, keylen);
+	sg_init_one(&sg, buf, keylen);
+	ahash_request_set_crypt(req, &sg, ctx->key, keylen);
+
+	ret = crypto_wait_req(crypto_ahash_digest(req), &wait);
+
+	kfree(buf);
+err_free_req:
+	ahash_request_free(req);
+err_free_ahash:
+	crypto_free_ahash(ahash_tfm);
+	return ret;
+}
+
+static int starfive_hash224_setkey(struct crypto_ahash *tfm,
+				   const u8 *key, unsigned int keylen)
+{
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+	unsigned int digestsize = crypto_ahash_digestsize(tfm);
+	unsigned int blocksize;
+	int ret = 0;
+
+	blocksize = crypto_tfm_alg_blocksize(crypto_ahash_tfm(tfm));
+	crypto_ahash_setkey(ctx->ahash_fbk, key, keylen);
+
+	if (keylen <= blocksize) {
+		memcpy(ctx->key, key, keylen);
+		ctx->keylen = keylen;
+	} else {
+		ctx->keylen = digestsize;
+		ret = starfive_hash_long_setkey(ctx, key, keylen, "starfive-sha224");
+	}
+
+	return ret;
+}
+
+static int starfive_hash256_setkey(struct crypto_ahash *tfm,
+				   const u8 *key, unsigned int keylen)
+{
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+	unsigned int digestsize = crypto_ahash_digestsize(tfm);
+	unsigned int blocksize;
+	int ret = 0;
+
+	blocksize = crypto_tfm_alg_blocksize(crypto_ahash_tfm(tfm));
+	crypto_ahash_setkey(ctx->ahash_fbk, key, keylen);
+
+	if (keylen <= blocksize) {
+		memcpy(ctx->key, key, keylen);
+		ctx->keylen = keylen;
+	} else {
+		ctx->keylen = digestsize;
+		ret = starfive_hash_long_setkey(ctx, key, keylen, "starfive-sha256");
+	}
+
+	return ret;
+}
+
+static int starfive_hash384_setkey(struct crypto_ahash *tfm,
+				   const u8 *key, unsigned int keylen)
+{
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+	unsigned int digestsize = crypto_ahash_digestsize(tfm);
+	unsigned int blocksize;
+	int ret = 0;
+
+	blocksize = crypto_tfm_alg_blocksize(crypto_ahash_tfm(tfm));
+	crypto_ahash_setkey(ctx->ahash_fbk, key, keylen);
+
+	if (keylen <= blocksize) {
+		memcpy(ctx->key, key, keylen);
+		ctx->keylen = keylen;
+	} else {
+		ctx->keylen = digestsize;
+		ret = starfive_hash_long_setkey(ctx, key, keylen, "starfive-sha384");
+	}
+
+	return ret;
+}
+
+static int starfive_hash512_setkey(struct crypto_ahash *tfm,
+				   const u8 *key, unsigned int keylen)
+{
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+	unsigned int digestsize = crypto_ahash_digestsize(tfm);
+	unsigned int blocksize;
+	int ret = 0;
+
+	blocksize = crypto_tfm_alg_blocksize(crypto_ahash_tfm(tfm));
+	crypto_ahash_setkey(ctx->ahash_fbk, key, keylen);
+
+	if (keylen <= blocksize) {
+		memcpy(ctx->key, key, keylen);
+		ctx->keylen = keylen;
+	} else {
+		ctx->keylen = digestsize;
+		ret = starfive_hash_long_setkey(ctx, key, keylen, "starfive-sha512");
+	}
+
+	return ret;
+}
+
+static int starfive_sm3_setkey(struct crypto_ahash *tfm,
+			       const u8 *key, unsigned int keylen)
+{
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+	unsigned int digestsize = crypto_ahash_digestsize(tfm);
+	unsigned int blocksize;
+	int ret = 0;
+
+	blocksize = crypto_tfm_alg_blocksize(crypto_ahash_tfm(tfm));
+	crypto_ahash_setkey(ctx->ahash_fbk, key, keylen);
+
+	if (keylen <= blocksize) {
+		memcpy(ctx->key, key, keylen);
+		ctx->keylen = keylen;
+	} else {
+		ctx->keylen = digestsize;
+		ret = starfive_hash_long_setkey(ctx, key, keylen, "starfive-sm3");
+	}
+
+	return ret;
+}
+
+static int starfive_hash_cra_sha224_init(struct crypto_tfm *tfm)
+{
+	return starfive_hash_cra_init_algs(tfm, NULL,
+					   STARFIVE_HASH_SHA224,
+					   "sha224-generic");
+}
+
+static int starfive_hash_cra_sha256_init(struct crypto_tfm *tfm)
+{
+	return starfive_hash_cra_init_algs(tfm, NULL,
+					   STARFIVE_HASH_SHA256,
+					   "sha256-generic");
+}
+
+static int starfive_hash_cra_sha384_init(struct crypto_tfm *tfm)
+{
+	return starfive_hash_cra_init_algs(tfm, NULL,
+					   STARFIVE_HASH_SHA384,
+					   "sha384-generic");
+}
+
+static int starfive_hash_cra_sha512_init(struct crypto_tfm *tfm)
+{
+	return starfive_hash_cra_init_algs(tfm, NULL,
+					   STARFIVE_HASH_SHA512,
+					   "sha512-generic");
+}
+
+static int starfive_hash_cra_sm3_init(struct crypto_tfm *tfm)
+{
+	return starfive_hash_cra_init_algs(tfm, NULL,
+					   STARFIVE_HASH_SM3,
+					   "sm3-generic");
+}
+
+static int starfive_hash_cra_hmac_sha224_init(struct crypto_tfm *tfm)
+{
+	return starfive_hash_cra_init_algs(tfm, "sha224",
+					   STARFIVE_HASH_SHA224,
+					   "hmac(sha224-generic)");
+}
+
+static int starfive_hash_cra_hmac_sha256_init(struct crypto_tfm *tfm)
+{
+	return starfive_hash_cra_init_algs(tfm, "sha256",
+					   STARFIVE_HASH_SHA256,
+					   "hmac(sha256-generic)");
+}
+
+static int starfive_hash_cra_hmac_sha384_init(struct crypto_tfm *tfm)
+{
+	return starfive_hash_cra_init_algs(tfm, "sha384",
+					   STARFIVE_HASH_SHA384,
+					   "hmac(sha384-generic)");
+}
+
+static int starfive_hash_cra_hmac_sha512_init(struct crypto_tfm *tfm)
+{
+	return starfive_hash_cra_init_algs(tfm, "sha512",
+					   STARFIVE_HASH_SHA512,
+					   "hmac(sha512-generic)");
+}
+
+static int starfive_hash_cra_hmac_sm3_init(struct crypto_tfm *tfm)
+{
+	return starfive_hash_cra_init_algs(tfm, "sm3",
+					   STARFIVE_HASH_SM3,
+					   "hmac(sm3-generic)");
+}
+
+static struct ahash_alg algs_sha2_sm3[] = {
+{
+	.init     = starfive_hash_init,
+	.update   = starfive_hash_update,
+	.final    = starfive_hash_final,
+	.finup    = starfive_hash_finup,
+	.digest   = starfive_hash_digest,
+	.export   = starfive_hash_export,
+	.import   = starfive_hash_import,
+	.halg = {
+		.digestsize = SHA224_DIGEST_SIZE,
+		.statesize  = sizeof(struct sha256_state),
+		.base = {
+			.cra_name		= "sha224",
+			.cra_driver_name	= "starfive-sha224",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SHA224_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+			.cra_alignmask		= 3,
+			.cra_init		= starfive_hash_cra_sha224_init,
+			.cra_exit		= starfive_hash_cra_exit,
+			.cra_module		= THIS_MODULE,
+		}
+	}
+},
+{
+	.init     = starfive_hash_init,
+	.update   = starfive_hash_update,
+	.final    = starfive_hash_final,
+	.finup    = starfive_hash_finup,
+	.digest   = starfive_hash_digest,
+	.export   = starfive_hash_export,
+	.import   = starfive_hash_import,
+	.setkey   = starfive_hash224_setkey,
+	.halg = {
+		.digestsize = SHA224_DIGEST_SIZE,
+		.statesize  = sizeof(struct sha256_state),
+		.base = {
+			.cra_name		= "hmac(sha224)",
+			.cra_driver_name	= "starfive-hmac-sha224",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SHA224_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+			.cra_alignmask		= 3,
+			.cra_init		= starfive_hash_cra_hmac_sha224_init,
+			.cra_exit		= starfive_hash_cra_exit,
+			.cra_module		= THIS_MODULE,
+		}
+	}
+},
+{
+	.init     = starfive_hash_init,
+	.update   = starfive_hash_update,
+	.final    = starfive_hash_final,
+	.finup    = starfive_hash_finup,
+	.digest   = starfive_hash_digest,
+	.export   = starfive_hash_export,
+	.import   = starfive_hash_import,
+	.halg = {
+		.digestsize = SHA256_DIGEST_SIZE,
+		.statesize  = sizeof(struct sha256_state),
+		.base = {
+			.cra_name		= "sha256",
+			.cra_driver_name	= "starfive-sha256",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SHA256_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+			.cra_alignmask		= 3,
+			.cra_init		= starfive_hash_cra_sha256_init,
+			.cra_exit		= starfive_hash_cra_exit,
+			.cra_module		= THIS_MODULE,
+		}
+	}
+},
+{
+	.init     = starfive_hash_init,
+	.update   = starfive_hash_update,
+	.final    = starfive_hash_final,
+	.finup    = starfive_hash_finup,
+	.digest   = starfive_hash_digest,
+	.export   = starfive_hash_export,
+	.import   = starfive_hash_import,
+	.setkey   = starfive_hash256_setkey,
+	.halg = {
+		.digestsize = SHA256_DIGEST_SIZE,
+		.statesize  = sizeof(struct sha256_state),
+		.base = {
+			.cra_name		= "hmac(sha256)",
+			.cra_driver_name	= "starfive-hmac-sha256",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SHA256_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+			.cra_alignmask		= 3,
+			.cra_init		= starfive_hash_cra_hmac_sha256_init,
+			.cra_exit		= starfive_hash_cra_exit,
+			.cra_module		= THIS_MODULE,
+		}
+	}
+},
+{
+	.init     = starfive_hash_init,
+	.update   = starfive_hash_update,
+	.final    = starfive_hash_final,
+	.finup    = starfive_hash_finup,
+	.digest   = starfive_hash_digest,
+	.export   = starfive_hash_export,
+	.import   = starfive_hash_import,
+	.halg = {
+		.digestsize = SHA384_DIGEST_SIZE,
+		.statesize  = sizeof(struct sha512_state),
+		.base = {
+			.cra_name		= "sha384",
+			.cra_driver_name	= "starfive-sha384",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SHA384_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+			.cra_alignmask		= 3,
+			.cra_init		= starfive_hash_cra_sha384_init,
+			.cra_exit		= starfive_hash_cra_exit,
+			.cra_module		= THIS_MODULE,
+		}
+	}
+},
+{
+	.init     = starfive_hash_init,
+	.update   = starfive_hash_update,
+	.final    = starfive_hash_final,
+	.finup    = starfive_hash_finup,
+	.digest   = starfive_hash_digest,
+	.setkey   = starfive_hash384_setkey,
+	.export   = starfive_hash_export,
+	.import   = starfive_hash_import,
+	.halg = {
+		.digestsize = SHA384_DIGEST_SIZE,
+		.statesize  = sizeof(struct sha512_state),
+		.base = {
+			.cra_name		= "hmac(sha384)",
+			.cra_driver_name	= "starfive-hmac-sha384",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SHA384_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+			.cra_alignmask		= 3,
+			.cra_init		= starfive_hash_cra_hmac_sha384_init,
+			.cra_exit		= starfive_hash_cra_exit,
+			.cra_module		= THIS_MODULE,
+		}
+	}
+},
+{
+	.init     = starfive_hash_init,
+	.update   = starfive_hash_update,
+	.final    = starfive_hash_final,
+	.finup    = starfive_hash_finup,
+	.digest   = starfive_hash_digest,
+	.export   = starfive_hash_export,
+	.import   = starfive_hash_import,
+	.halg = {
+		.digestsize = SHA512_DIGEST_SIZE,
+		.statesize  = sizeof(struct sha512_state),
+		.base = {
+			.cra_name		= "sha512",
+			.cra_driver_name	= "starfive-sha512",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH,
+			.cra_blocksize		= SHA512_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+			.cra_alignmask		= 3,
+			.cra_init		= starfive_hash_cra_sha512_init,
+			.cra_exit		= starfive_hash_cra_exit,
+			.cra_module		= THIS_MODULE,
+		}
+	}
+},
+{
+	.init     = starfive_hash_init,
+	.update   = starfive_hash_update,
+	.final    = starfive_hash_final,
+	.finup    = starfive_hash_finup,
+	.digest   = starfive_hash_digest,
+	.setkey   = starfive_hash512_setkey,
+	.export   = starfive_hash_export,
+	.import   = starfive_hash_import,
+	.halg = {
+		.digestsize = SHA512_DIGEST_SIZE,
+		.statesize  = sizeof(struct sha512_state),
+		.base = {
+			.cra_name		= "hmac(sha512)",
+			.cra_driver_name	= "starfive-hmac-sha512",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SHA512_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+			.cra_alignmask		= 3,
+			.cra_init		= starfive_hash_cra_hmac_sha512_init,
+			.cra_exit		= starfive_hash_cra_exit,
+			.cra_module		= THIS_MODULE,
+		}
+	}
+},
+{
+	.init     = starfive_hash_init,
+	.update   = starfive_hash_update,
+	.final    = starfive_hash_final,
+	.finup    = starfive_hash_finup,
+	.digest   = starfive_hash_digest,
+	.export   = starfive_hash_export,
+	.import   = starfive_hash_import,
+	.halg = {
+		.digestsize = SM3_DIGEST_SIZE,
+		.statesize  = sizeof(struct sm3_state),
+		.base = {
+			.cra_name		= "sm3",
+			.cra_driver_name	= "starfive-sm3",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SM3_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+			.cra_alignmask		= 3,
+			.cra_init		= starfive_hash_cra_sm3_init,
+			.cra_exit		= starfive_hash_cra_exit,
+			.cra_module		= THIS_MODULE,
+		}
+	}
+},
+{
+	.init		= starfive_hash_init,
+	.update		= starfive_hash_update,
+	.final		= starfive_hash_final,
+	.finup		= starfive_hash_finup,
+	.digest		= starfive_hash_digest,
+	.setkey		= starfive_sm3_setkey,
+	.export		= starfive_hash_export,
+	.import		= starfive_hash_import,
+	.halg = {
+		.digestsize = SM3_DIGEST_SIZE,
+		.statesize  = sizeof(struct sm3_state),
+		.base = {
+			.cra_name		= "hmac(sm3)",
+			.cra_driver_name	= "starfive-hmac-sm3",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SM3_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+			.cra_alignmask		= 3,
+			.cra_init		= starfive_hash_cra_hmac_sm3_init,
+			.cra_exit		= starfive_hash_cra_exit,
+			.cra_module		= THIS_MODULE,
+		}
+	}
+},
+};
+
+int starfive_hash_register_algs(void)
+{
+	int ret = 0;
+
+	ret = crypto_register_ahashes(algs_sha2_sm3, ARRAY_SIZE(algs_sha2_sm3));
+
+	return ret;
+}
+
+void starfive_hash_unregister_algs(void)
+{
+	crypto_unregister_ahashes(algs_sha2_sm3, ARRAY_SIZE(algs_sha2_sm3));
+}
-- 
2.25.1

