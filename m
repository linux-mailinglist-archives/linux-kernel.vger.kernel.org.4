Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F186EEEB2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 08:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbjDZG7d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Apr 2023 02:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239689AbjDZG7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 02:59:16 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A9A30FD;
        Tue, 25 Apr 2023 23:59:09 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id CC10024E292;
        Wed, 26 Apr 2023 14:59:07 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 26 Apr
 2023 14:59:07 +0800
Received: from ubuntu.localdomain (202.188.176.82) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 26 Apr
 2023 14:59:04 +0800
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v6 4/4] crypto: starfive - Add hash and HMAC support
Date:   Wed, 26 Apr 2023 14:58:48 +0800
Message-ID: <20230426065848.842221-5-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230426065848.842221-1-jiajie.ho@starfivetech.com>
References: <20230426065848.842221-1-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/crypto/starfive/Kconfig       |   4 +
 drivers/crypto/starfive/Makefile      |   2 +-
 drivers/crypto/starfive/jh7110-cryp.c |  38 ++
 drivers/crypto/starfive/jh7110-cryp.h |  70 +-
 drivers/crypto/starfive/jh7110-hash.c | 896 ++++++++++++++++++++++++++
 5 files changed, 1006 insertions(+), 4 deletions(-)
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
index 41221acaee39..2af49062e36d 100644
--- a/drivers/crypto/starfive/Makefile
+++ b/drivers/crypto/starfive/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_CRYPTO_DEV_JH7110) += jh7110-crypto.o
-jh7110-crypto-objs := jh7110-cryp.o
+jh7110-crypto-objs := jh7110-cryp.o jh7110-hash.o
diff --git a/drivers/crypto/starfive/jh7110-cryp.c b/drivers/crypto/starfive/jh7110-cryp.c
index a944897609a2..8ce8c0859e1c 100644
--- a/drivers/crypto/starfive/jh7110-cryp.c
+++ b/drivers/crypto/starfive/jh7110-cryp.c
@@ -82,10 +82,25 @@ static void starfive_dma_cleanup(struct starfive_cryp_dev *cryp)
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
+		tasklet_schedule(&cryp->hash_done);
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
@@ -100,6 +115,8 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(cryp->base),
 				     "Error remapping memory for platform device\n");
 
+	tasklet_init(&cryp->hash_done, starfive_hash_done_task, (unsigned long)cryp);
+
 	cryp->phys_base = res->start;
 	cryp->dma_maxburst = 32;
 
@@ -118,6 +135,16 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(cryp->rst),
 				     "Error getting hardware reset line\n");
 
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
@@ -141,8 +168,14 @@ static int starfive_cryp_probe(struct platform_device *pdev)
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
@@ -151,6 +184,7 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 	spin_lock(&dev_list.lock);
 	list_del(&cryp->list);
 	spin_unlock(&dev_list.lock);
+	tasklet_kill(&cryp->hash_done);
 
 	return ret;
 }
@@ -162,6 +196,10 @@ static int starfive_cryp_remove(struct platform_device *pdev)
 	if (!cryp)
 		return -ENODEV;
 
+	starfive_hash_unregister_algs();
+
+	tasklet_kill(&cryp->hash_done);
+
 	crypto_engine_stop(cryp->engine);
 	crypto_engine_exit(cryp->engine);
 
diff --git a/drivers/crypto/starfive/jh7110-cryp.h b/drivers/crypto/starfive/jh7110-cryp.h
index 393efd38b098..7a589f6eca14 100644
--- a/drivers/crypto/starfive/jh7110-cryp.h
+++ b/drivers/crypto/starfive/jh7110-cryp.h
@@ -7,6 +7,8 @@
 #include <linux/dmaengine.h>
 
 #include <crypto/engine.h>
+#include <crypto/sha2.h>
+#include <crypto/sm3.h>
 
 #define STARFIVE_ALG_CR_OFFSET			0x0
 #define STARFIVE_ALG_FIFO_OFFSET		0x4
@@ -15,7 +17,43 @@
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
@@ -34,12 +72,18 @@ union starfive_alg_cr {
 struct starfive_cryp_ctx {
 	struct crypto_engine_ctx		enginectx;
 	struct starfive_cryp_dev		*cryp;
+	struct starfive_cryp_request_ctx	*rctx;
+
+	unsigned int				hash_mode;
+	u8					key[MAX_KEY_SIZE];
+	int					keylen;
+	bool					is_hmac;
+	struct crypto_ahash			*ahash_fbk;
 };
 
 struct starfive_cryp_dev {
 	struct list_head			list;
 	struct device				*dev;
-
 	struct clk				*hclk;
 	struct clk				*ahb;
 	struct reset_control			*rst;
@@ -52,12 +96,32 @@ struct starfive_cryp_dev {
 	struct dma_chan				*rx;
 	struct dma_slave_config			cfg_in;
 	struct dma_slave_config			cfg_out;
-
 	struct crypto_engine			*engine;
-
+	struct tasklet_struct			hash_done;
+	int					err;
 	union starfive_alg_cr			alg_cr;
+	union {
+		struct ahash_request		*hreq;
+	} req;
+};
+
+struct starfive_cryp_request_ctx {
+	union {
+		union starfive_hash_csr		hash;
+	} csr;
+
+	struct scatterlist			*in_sg;
+	struct ahash_request			ahash_fbk_req;
+	size_t					total;
+	unsigned int				blksize;
+	unsigned int				digsize;
+	unsigned long				in_sg_len;
 };
 
 struct starfive_cryp_dev *starfive_cryp_find_dev(struct starfive_cryp_ctx *ctx);
 
+int starfive_hash_register_algs(void);
+void starfive_hash_unregister_algs(void);
+
+void starfive_hash_done_task(unsigned long param);
 #endif
diff --git a/drivers/crypto/starfive/jh7110-hash.c b/drivers/crypto/starfive/jh7110-hash.c
new file mode 100644
index 000000000000..5081abe4f5d6
--- /dev/null
+++ b/drivers/crypto/starfive/jh7110-hash.c
@@ -0,0 +1,896 @@
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
+	rctx->csr.hash.hmac = 1;
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
+static void starfive_hash_start(void *param)
+{
+	struct starfive_cryp_ctx *ctx = param;
+	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	union starfive_alg_cr alg_cr;
+	union starfive_hash_csr csr;
+
+	dma_unmap_sg(cryp->dev, rctx->in_sg, rctx->in_sg_len, DMA_TO_DEVICE);
+
+	alg_cr.v = 0;
+	alg_cr.clear = 1;
+
+	writel(alg_cr.v, cryp->base + STARFIVE_ALG_CR_OFFSET);
+
+	csr.v = readl(cryp->base + STARFIVE_HASH_SHACSR);
+	csr.firstb = 0;
+	csr.final = 1;
+
+	writel(~STARFIVE_IE_MASK_HASH_DONE, cryp->base + STARFIVE_IE_MASK_OFFSET);
+	writel(csr.v, cryp->base + STARFIVE_HASH_SHACSR);
+}
+
+static int starfive_hash_xmit_dma(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct dma_async_tx_descriptor	*in_desc;
+	union  starfive_alg_cr alg_cr;
+	int total_len;
+	int ret;
+
+	if (!rctx->total) {
+		starfive_hash_start(ctx);
+		return 0;
+	}
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
+					  ret, DMA_MEM_TO_DEV,
+					  DMA_PREP_INTERRUPT  |  DMA_CTRL_ACK);
+
+	if (!in_desc)
+		return -EINVAL;
+
+	in_desc->callback = starfive_hash_start;
+	in_desc->callback_param = ctx;
+
+	dmaengine_submit(in_desc);
+	dma_async_issue_pending(cryp->tx);
+
+	return 0;
+}
+
+static int starfive_hash_xmit(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	int ret = 0;
+
+	rctx->csr.hash.v = 0;
+	rctx->csr.hash.reset = 1;
+	writel(rctx->csr.hash.v, cryp->base + STARFIVE_HASH_SHACSR);
+
+	if (starfive_hash_wait_busy(ctx))
+		return dev_err_probe(cryp->dev, -ETIMEDOUT, "Error resetting engine.\n");
+
+	rctx->csr.hash.v = 0;
+	rctx->csr.hash.mode = ctx->hash_mode;
+	rctx->csr.hash.ie = 1;
+
+	if (ctx->is_hmac) {
+		ret = starfive_hash_hmac_key(ctx);
+		if (ret)
+			return ret;
+	} else {
+		rctx->csr.hash.start = 1;
+		rctx->csr.hash.firstb = 1;
+		writel(rctx->csr.hash.v, cryp->base + STARFIVE_HASH_SHACSR);
+	}
+
+	return starfive_hash_xmit_dma(ctx);
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
+void starfive_hash_done_task(unsigned long param)
+{
+	struct starfive_cryp_dev *cryp = (struct starfive_cryp_dev *)param;
+	int err = cryp->err;
+
+	if (!err)
+		err = starfive_hash_copy_hash(cryp->req.hreq);
+
+	crypto_finalize_hash_request(cryp->engine, cryp->req.hreq, err);
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
+static int starfive_hash_one_request(struct crypto_engine *engine, void *areq)
+{
+	struct ahash_request *req = container_of(areq, struct ahash_request,
+						 base);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+
+	if (!cryp)
+		return -ENODEV;
+
+	return starfive_hash_xmit(ctx);
+}
+
+static int starfive_hash_init(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->ahash_fbk_req, ctx->ahash_fbk);
+	ahash_request_set_callback(&rctx->ahash_fbk_req,
+				   req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP,
+				   req->base.complete, req->base.data);
+
+	ahash_request_set_crypt(&rctx->ahash_fbk_req, req->src,
+				req->result, req->nbytes);
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
+	ahash_request_set_callback(&rctx->ahash_fbk_req,
+				   req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP,
+				   req->base.complete, req->base.data);
+
+	ahash_request_set_crypt(&rctx->ahash_fbk_req, req->src,
+				req->result, req->nbytes);
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
+	ahash_request_set_callback(&rctx->ahash_fbk_req,
+				   req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP,
+				   req->base.complete, req->base.data);
+
+	ahash_request_set_crypt(&rctx->ahash_fbk_req, req->src,
+				req->result, req->nbytes);
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
+	ahash_request_set_callback(&rctx->ahash_fbk_req,
+				   req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP,
+				   req->base.complete, req->base.data);
+
+	ahash_request_set_crypt(&rctx->ahash_fbk_req, req->src,
+				req->result, req->nbytes);
+
+	return crypto_ahash_finup(&rctx->ahash_fbk_req);
+}
+
+static int starfive_hash_digest_fb(struct ahash_request *req)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->ahash_fbk_req, ctx->ahash_fbk);
+	ahash_request_set_callback(&rctx->ahash_fbk_req, req->base.flags,
+				   req->base.complete, req->base.data);
+
+	ahash_request_set_crypt(&rctx->ahash_fbk_req, req->src,
+				req->result, req->nbytes);
+
+	return crypto_ahash_digest(&rctx->ahash_fbk_req);
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
+	cryp->req.hreq = req;
+	rctx->total = req->nbytes;
+	rctx->in_sg = req->src;
+	rctx->blksize = crypto_tfm_alg_blocksize(crypto_ahash_tfm(tfm));
+	rctx->digsize = crypto_ahash_digestsize(tfm);
+	rctx->in_sg_len = sg_nents_for_len(rctx->in_sg, rctx->total);
+	ctx->rctx = rctx;
+
+	if (starfive_hash_check_aligned(rctx->in_sg, rctx->total, rctx->blksize))
+		return starfive_hash_digest_fb(req);
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
+	ahash_request_set_callback(&rctx->ahash_fbk_req,
+				   req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP,
+				   req->base.complete, req->base.data);
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
+	ahash_request_set_callback(&rctx->ahash_fbk_req,
+				   req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP,
+				   req->base.complete, req->base.data);
+
+	return crypto_ahash_import(&rctx->ahash_fbk_req, in);
+}
+
+static int starfive_hash_init_tfm(struct crypto_ahash *hash,
+				  const char *alg_name,
+				  unsigned int mode)
+{
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
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
+	crypto_ahash_set_statesize(hash, crypto_ahash_statesize(ctx->ahash_fbk));
+	crypto_ahash_set_reqsize(hash, sizeof(struct starfive_cryp_request_ctx) +
+				 crypto_ahash_reqsize(ctx->ahash_fbk));
+
+	ctx->keylen = 0;
+	ctx->hash_mode = mode;
+
+	ctx->enginectx.op.do_one_request = starfive_hash_one_request;
+	ctx->enginectx.op.prepare_request = NULL;
+	ctx->enginectx.op.unprepare_request = NULL;
+
+	return 0;
+}
+
+static void starfive_hash_exit_tfm(struct crypto_ahash *hash)
+{
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
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
+static int starfive_hash_setkey(struct crypto_ahash *hash,
+				const u8 *key, unsigned int keylen)
+{
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
+	unsigned int digestsize = crypto_ahash_digestsize(hash);
+	unsigned int blocksize = crypto_ahash_blocksize(hash);
+	const char *alg_name;
+
+	crypto_ahash_setkey(ctx->ahash_fbk, key, keylen);
+
+	if (keylen <= blocksize) {
+		memcpy(ctx->key, key, keylen);
+		ctx->keylen = keylen;
+		return 0;
+	}
+
+	ctx->keylen = digestsize;
+
+	switch (digestsize) {
+	case SHA224_DIGEST_SIZE:
+		alg_name = "sha224-starfive";
+		break;
+	case SHA256_DIGEST_SIZE:
+		if (ctx->hash_mode == STARFIVE_HASH_SM3)
+			alg_name = "sm3-starfive";
+		else
+			alg_name = "sha256-starfive";
+		break;
+	case SHA384_DIGEST_SIZE:
+		alg_name = "sha384-starfive";
+		break;
+	case SHA512_DIGEST_SIZE:
+		alg_name = "sha512-starfive";
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return starfive_hash_long_setkey(ctx, key, keylen, alg_name);
+}
+
+static int starfive_sha224_init_tfm(struct crypto_ahash *hash)
+{
+	return starfive_hash_init_tfm(hash, "sha224-generic",
+				      STARFIVE_HASH_SHA224);
+}
+
+static int starfive_sha256_init_tfm(struct crypto_ahash *hash)
+{
+	return starfive_hash_init_tfm(hash, "sha256-generic",
+				      STARFIVE_HASH_SHA256);
+}
+
+static int starfive_sha384_init_tfm(struct crypto_ahash *hash)
+{
+	return starfive_hash_init_tfm(hash, "sha384-generic",
+				      STARFIVE_HASH_SHA384);
+}
+
+static int starfive_sha512_init_tfm(struct crypto_ahash *hash)
+{
+	return starfive_hash_init_tfm(hash, "sha512-generic",
+				      STARFIVE_HASH_SHA512);
+}
+
+static int starfive_sm3_init_tfm(struct crypto_ahash *hash)
+{
+	return starfive_hash_init_tfm(hash, "sm3-generic",
+				      STARFIVE_HASH_SM3);
+}
+
+static int starfive_hmac_sha224_init_tfm(struct crypto_ahash *hash)
+{
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
+
+	ctx->is_hmac = true;
+
+	return starfive_hash_init_tfm(hash, "hmac(sha224-generic)",
+				      STARFIVE_HASH_SHA224);
+}
+
+static int starfive_hmac_sha256_init_tfm(struct crypto_ahash *hash)
+{
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
+
+	ctx->is_hmac = true;
+
+	return starfive_hash_init_tfm(hash, "hmac(sha256-generic)",
+				      STARFIVE_HASH_SHA256);
+}
+
+static int starfive_hmac_sha384_init_tfm(struct crypto_ahash *hash)
+{
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
+
+	ctx->is_hmac = true;
+
+	return starfive_hash_init_tfm(hash, "hmac(sha384-generic)",
+				      STARFIVE_HASH_SHA384);
+}
+
+static int starfive_hmac_sha512_init_tfm(struct crypto_ahash *hash)
+{
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
+
+	ctx->is_hmac = true;
+
+	return starfive_hash_init_tfm(hash, "hmac(sha512-generic)",
+				      STARFIVE_HASH_SHA512);
+}
+
+static int starfive_hmac_sm3_init_tfm(struct crypto_ahash *hash)
+{
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
+
+	ctx->is_hmac = true;
+
+	return starfive_hash_init_tfm(hash, "hmac(sm3-generic)",
+				      STARFIVE_HASH_SM3);
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
+	.init_tfm = starfive_sha224_init_tfm,
+	.exit_tfm = starfive_hash_exit_tfm,
+	.halg = {
+		.digestsize = SHA224_DIGEST_SIZE,
+		.statesize  = sizeof(struct sha256_state),
+		.base = {
+			.cra_name		= "sha224",
+			.cra_driver_name	= "sha224-starfive",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SHA224_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+			.cra_alignmask		= 3,
+			.cra_module		= THIS_MODULE,
+		}
+	}
+}, {
+	.init     = starfive_hash_init,
+	.update   = starfive_hash_update,
+	.final    = starfive_hash_final,
+	.finup    = starfive_hash_finup,
+	.digest   = starfive_hash_digest,
+	.export   = starfive_hash_export,
+	.import   = starfive_hash_import,
+	.init_tfm = starfive_hmac_sha224_init_tfm,
+	.exit_tfm = starfive_hash_exit_tfm,
+	.setkey   = starfive_hash_setkey,
+	.halg = {
+		.digestsize = SHA224_DIGEST_SIZE,
+		.statesize  = sizeof(struct sha256_state),
+		.base = {
+			.cra_name		= "hmac(sha224)",
+			.cra_driver_name	= "sha224-hmac-starfive",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SHA224_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+			.cra_alignmask		= 3,
+			.cra_module		= THIS_MODULE,
+		}
+	}
+}, {
+	.init     = starfive_hash_init,
+	.update   = starfive_hash_update,
+	.final    = starfive_hash_final,
+	.finup    = starfive_hash_finup,
+	.digest   = starfive_hash_digest,
+	.export   = starfive_hash_export,
+	.import   = starfive_hash_import,
+	.init_tfm = starfive_sha256_init_tfm,
+	.exit_tfm = starfive_hash_exit_tfm,
+	.halg = {
+		.digestsize = SHA256_DIGEST_SIZE,
+		.statesize  = sizeof(struct sha256_state),
+		.base = {
+			.cra_name		= "sha256",
+			.cra_driver_name	= "sha256-starfive",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SHA256_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+			.cra_alignmask		= 3,
+			.cra_module		= THIS_MODULE,
+		}
+	}
+}, {
+	.init     = starfive_hash_init,
+	.update   = starfive_hash_update,
+	.final    = starfive_hash_final,
+	.finup    = starfive_hash_finup,
+	.digest   = starfive_hash_digest,
+	.export   = starfive_hash_export,
+	.import   = starfive_hash_import,
+	.init_tfm = starfive_hmac_sha256_init_tfm,
+	.exit_tfm = starfive_hash_exit_tfm,
+	.setkey   = starfive_hash_setkey,
+	.halg = {
+		.digestsize = SHA256_DIGEST_SIZE,
+		.statesize  = sizeof(struct sha256_state),
+		.base = {
+			.cra_name		= "hmac(sha256)",
+			.cra_driver_name	= "sha256-hmac-starfive",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SHA256_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+			.cra_alignmask		= 3,
+			.cra_module		= THIS_MODULE,
+		}
+	}
+}, {
+	.init     = starfive_hash_init,
+	.update   = starfive_hash_update,
+	.final    = starfive_hash_final,
+	.finup    = starfive_hash_finup,
+	.digest   = starfive_hash_digest,
+	.export   = starfive_hash_export,
+	.import   = starfive_hash_import,
+	.init_tfm = starfive_sha384_init_tfm,
+	.exit_tfm = starfive_hash_exit_tfm,
+	.halg = {
+		.digestsize = SHA384_DIGEST_SIZE,
+		.statesize  = sizeof(struct sha512_state),
+		.base = {
+			.cra_name		= "sha384",
+			.cra_driver_name	= "sha384-starfive",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SHA384_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+			.cra_alignmask		= 3,
+			.cra_module		= THIS_MODULE,
+		}
+	}
+}, {
+	.init     = starfive_hash_init,
+	.update   = starfive_hash_update,
+	.final    = starfive_hash_final,
+	.finup    = starfive_hash_finup,
+	.digest   = starfive_hash_digest,
+	.export   = starfive_hash_export,
+	.import   = starfive_hash_import,
+	.init_tfm = starfive_hmac_sha384_init_tfm,
+	.exit_tfm = starfive_hash_exit_tfm,
+	.setkey   = starfive_hash_setkey,
+	.halg = {
+		.digestsize = SHA384_DIGEST_SIZE,
+		.statesize  = sizeof(struct sha512_state),
+		.base = {
+			.cra_name		= "hmac(sha384)",
+			.cra_driver_name	= "sha384-hmac-starfive",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SHA384_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+			.cra_alignmask		= 3,
+			.cra_module		= THIS_MODULE,
+		}
+	}
+}, {
+	.init     = starfive_hash_init,
+	.update   = starfive_hash_update,
+	.final    = starfive_hash_final,
+	.finup    = starfive_hash_finup,
+	.digest   = starfive_hash_digest,
+	.export   = starfive_hash_export,
+	.import   = starfive_hash_import,
+	.init_tfm = starfive_sha512_init_tfm,
+	.exit_tfm = starfive_hash_exit_tfm,
+	.halg = {
+		.digestsize = SHA512_DIGEST_SIZE,
+		.statesize  = sizeof(struct sha512_state),
+		.base = {
+			.cra_name		= "sha512",
+			.cra_driver_name	= "sha512-starfive",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SHA512_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+			.cra_alignmask		= 3,
+			.cra_module		= THIS_MODULE,
+		}
+	}
+}, {
+	.init     = starfive_hash_init,
+	.update   = starfive_hash_update,
+	.final    = starfive_hash_final,
+	.finup    = starfive_hash_finup,
+	.digest   = starfive_hash_digest,
+	.export   = starfive_hash_export,
+	.import   = starfive_hash_import,
+	.init_tfm = starfive_hmac_sha512_init_tfm,
+	.exit_tfm = starfive_hash_exit_tfm,
+	.setkey   = starfive_hash_setkey,
+	.halg = {
+		.digestsize = SHA512_DIGEST_SIZE,
+		.statesize  = sizeof(struct sha512_state),
+		.base = {
+			.cra_name		= "hmac(sha512)",
+			.cra_driver_name	= "sha512-hmac-starfive",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SHA512_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+			.cra_alignmask		= 3,
+			.cra_module		= THIS_MODULE,
+		}
+	}
+}, {
+	.init     = starfive_hash_init,
+	.update   = starfive_hash_update,
+	.final    = starfive_hash_final,
+	.finup    = starfive_hash_finup,
+	.digest   = starfive_hash_digest,
+	.export   = starfive_hash_export,
+	.import   = starfive_hash_import,
+	.init_tfm = starfive_sm3_init_tfm,
+	.exit_tfm = starfive_hash_exit_tfm,
+	.halg = {
+		.digestsize = SM3_DIGEST_SIZE,
+		.statesize  = sizeof(struct sm3_state),
+		.base = {
+			.cra_name		= "sm3",
+			.cra_driver_name	= "sm3-starfive",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SM3_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+			.cra_alignmask		= 3,
+			.cra_module		= THIS_MODULE,
+		}
+	}
+}, {
+	.init	  = starfive_hash_init,
+	.update	  = starfive_hash_update,
+	.final	  = starfive_hash_final,
+	.finup	  = starfive_hash_finup,
+	.digest	  = starfive_hash_digest,
+	.export	  = starfive_hash_export,
+	.import	  = starfive_hash_import,
+	.init_tfm = starfive_hmac_sm3_init_tfm,
+	.exit_tfm = starfive_hash_exit_tfm,
+	.setkey	  = starfive_hash_setkey,
+	.halg = {
+		.digestsize = SM3_DIGEST_SIZE,
+		.statesize  = sizeof(struct sm3_state),
+		.base = {
+			.cra_name		= "hmac(sm3)",
+			.cra_driver_name	= "sm3-hmac-starfive",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SM3_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+			.cra_alignmask		= 3,
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

