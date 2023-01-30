Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D37B681571
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbjA3PqN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 30 Jan 2023 10:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237518AbjA3Ppp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:45:45 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5862C3FF34;
        Mon, 30 Jan 2023 07:45:38 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 190C124E02F;
        Mon, 30 Jan 2023 23:45:37 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 30 Jan
 2023 23:45:36 +0800
Received: from ubuntu.localdomain (202.190.105.77) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 30 Jan
 2023 23:45:28 +0800
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v2 4/4] crypto: starfive - Add hash and HMAC support
Date:   Mon, 30 Jan 2023 23:42:42 +0800
Message-ID: <20230130154242.112613-5-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230130154242.112613-1-jiajie.ho@starfivetech.com>
References: <20230130154242.112613-1-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.190.105.77]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/crypto/starfive/Makefile        |    2 +-
 drivers/crypto/starfive/starfive-cryp.c |   30 +-
 drivers/crypto/starfive/starfive-hash.c | 1095 +++++++++++++++++++++++
 drivers/crypto/starfive/starfive-regs.h |   45 +
 drivers/crypto/starfive/starfive-str.h  |   52 +-
 5 files changed, 1220 insertions(+), 4 deletions(-)
 create mode 100644 drivers/crypto/starfive/starfive-hash.c

diff --git a/drivers/crypto/starfive/Makefile b/drivers/crypto/starfive/Makefile
index 079ceb938a4c..0315ec623b34 100644
--- a/drivers/crypto/starfive/Makefile
+++ b/drivers/crypto/starfive/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_CRYPTO_DEV_JH7110) += starfive-crypto.o
-starfive-crypto-objs := starfive-cryp.o
+starfive-crypto-objs := starfive-cryp.o starfive-hash.o
diff --git a/drivers/crypto/starfive/starfive-cryp.c b/drivers/crypto/starfive/starfive-cryp.c
index 09654b1c0d0e..f9dabcccbcaf 100644
--- a/drivers/crypto/starfive/starfive-cryp.c
+++ b/drivers/crypto/starfive/starfive-cryp.c
@@ -96,9 +96,10 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 {
 	struct starfive_cryp_dev *cryp;
 	struct resource *res;
-	int ret;
+	int ret, pages;
 
 	cryp = devm_kzalloc(&pdev->dev, sizeof(*cryp), GFP_KERNEL);
+	mutex_init(&cryp->lock);
 	if (!cryp)
 		return -ENOMEM;
 
@@ -141,6 +142,20 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_dma_init;
 
+	mutex_init(&cryp->lock);
+	pages = get_order(STARFIVE_MSG_BUFFER_SIZE);
+
+	cryp->hash_data = (void *)__get_free_pages(GFP_KERNEL | GFP_DMA32, pages);
+	if (!cryp->hash_data) {
+		dev_err_probe(&pdev->dev, -ENOMEM,
+			      "Can't allocate hash buffer pages when unaligned\n");
+		ret = -ENOMEM;
+		goto err_hash_data;
+	}
+
+	cryp->pages_count = pages >> 1;
+	cryp->data_buf_len = STARFIVE_MSG_BUFFER_SIZE >> 1;
+
 	/* Initialize crypto engine */
 	cryp->engine = crypto_engine_alloc_init(&pdev->dev, 1);
 	if (!cryp->engine) {
@@ -152,11 +167,19 @@ static int starfive_cryp_probe(struct platform_device *pdev)
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
+	free_pages((unsigned long)cryp->hash_data, pages);
+err_hash_data:
 	starfive_dma_cleanup(cryp);
 err_dma_init:
 	spin_lock(&dev_list.lock);
@@ -173,11 +196,16 @@ static int starfive_cryp_remove(struct platform_device *pdev)
 	if (!cryp)
 		return -ENODEV;
 
+	starfive_hash_unregister_algs();
+
 	crypto_engine_stop(cryp->engine);
 	crypto_engine_exit(cryp->engine);
 
 	starfive_dma_cleanup(cryp);
 
+	free_pages((unsigned long)cryp->hash_data, cryp->pages_count);
+	cryp->hash_data = NULL;
+
 	spin_lock(&dev_list.lock);
 	list_del(&cryp->list);
 	spin_unlock(&dev_list.lock);
diff --git a/drivers/crypto/starfive/starfive-hash.c b/drivers/crypto/starfive/starfive-hash.c
new file mode 100644
index 000000000000..3f7523da68e7
--- /dev/null
+++ b/drivers/crypto/starfive/starfive-hash.c
@@ -0,0 +1,1095 @@
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
+#include "starfive-str.h"
+
+#define HASH_OP_UPDATE			1
+#define HASH_OP_FINAL			2
+
+#define HASH_FLAGS_INIT			BIT(0)
+#define HASH_FLAGS_FINAL		BIT(1)
+#define HASH_FLAGS_FINUP		BIT(2)
+
+#define STARFIVE_MAX_ALIGN_SIZE		SHA512_BLOCK_SIZE
+
+#define STARFIVE_HASH_BUFLEN		8192
+#define STARFIVE_HASH_THRES		2048
+
+static inline int starfive_hash_wait_hmac_done(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	u32 status;
+
+	return readl_relaxed_poll_timeout(cryp->base + STARFIVE_HASH_SHACSR, status,
+					  (status & STARFIVE_HASH_HMAC_DONE), 10, 100000);
+}
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
+static int starfive_get_hash_size(struct starfive_cryp_ctx *ctx)
+{
+	unsigned int hashsize;
+
+	switch (ctx->hash_mode & STARFIVE_HASH_MODE_MASK) {
+	case STARFIVE_HASH_SHA224:
+		hashsize = SHA224_DIGEST_SIZE;
+		break;
+	case STARFIVE_HASH_SHA256:
+		hashsize = SHA256_DIGEST_SIZE;
+		break;
+	case STARFIVE_HASH_SHA384:
+		hashsize = SHA384_DIGEST_SIZE;
+		break;
+	case STARFIVE_HASH_SHA512:
+		hashsize = SHA512_DIGEST_SIZE;
+		break;
+	case STARFIVE_HASH_SM3:
+		hashsize = SM3_DIGEST_SIZE;
+		break;
+	default:
+		return 0;
+	}
+
+	return hashsize;
+}
+
+static void starfive_hash_start(struct starfive_cryp_ctx *ctx, int flags)
+{
+	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+
+	rctx->csr.hash.v = readl(cryp->base + STARFIVE_HASH_SHACSR);
+	rctx->csr.hash.firstb = 0;
+
+	if (flags)
+		rctx->csr.hash.final = 1;
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
+	if (!rctx->bufcnt)
+		return 0;
+
+	ctx->hash_len_total += rctx->bufcnt;
+
+	writel(rctx->bufcnt, cryp->base + STARFIVE_DMA_IN_LEN_OFFSET);
+
+	total_len = rctx->bufcnt;
+	total_len = (total_len & 0x3) ? (((total_len >> 2) + 1) << 2) : total_len;
+
+	memset(cryp->hash_data + rctx->bufcnt, 0, total_len - rctx->bufcnt);
+
+	alg_cr.v = 0;
+	alg_cr.start = 1;
+	alg_cr.hash_dma_en = 1;
+
+	writel(alg_cr.v, cryp->base + STARFIVE_ALG_CR_OFFSET);
+
+	sg_init_one(&ctx->sg[0], cryp->hash_data, total_len);
+	sg_dma_address(&ctx->sg[0]) = phys_to_dma(cryp->dev, (unsigned long long)(cryp->hash_data));
+	sg_dma_len(&ctx->sg[0]) = total_len;
+
+	ret = dma_map_sg(cryp->dev, &ctx->sg[0], 1, DMA_TO_DEVICE);
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
+	in_desc = dmaengine_prep_slave_sg(cryp->tx, &ctx->sg[0],
+					  1, DMA_MEM_TO_DEV,
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
+	dma_unmap_sg(cryp->dev, &ctx->sg[0], 1, DMA_TO_DEVICE);
+
+	alg_cr.v = 0;
+	alg_cr.clear = 1;
+	writel(alg_cr.v, cryp->base + STARFIVE_ALG_CR_OFFSET);
+
+	return 0;
+}
+
+static void starfive_hash_append_sg(struct starfive_cryp_request_ctx *rctx)
+{
+	struct starfive_cryp_ctx *ctx = rctx->ctx;
+	size_t count;
+
+	while ((rctx->bufcnt < rctx->buflen) && rctx->total) {
+		count = min(rctx->in_sg->length - rctx->offset, rctx->total);
+		count = min(count, rctx->buflen - rctx->bufcnt);
+
+		if (count <= 0) {
+			if (rctx->in_sg->length == 0 && !sg_is_last(rctx->in_sg)) {
+				rctx->in_sg = sg_next(rctx->in_sg);
+				continue;
+			} else {
+				break;
+			}
+		}
+
+		scatterwalk_map_and_copy(ctx->buffer + rctx->bufcnt, rctx->in_sg,
+					 rctx->offset, count, 0);
+
+		rctx->bufcnt += count;
+		rctx->offset += count;
+		rctx->total -= count;
+
+		if (rctx->offset == rctx->in_sg->length) {
+			rctx->in_sg = sg_next(rctx->in_sg);
+			if (rctx->in_sg)
+				rctx->offset = 0;
+			else
+				rctx->total = 0;
+		}
+	}
+}
+
+static int starfive_hash_xmit(struct starfive_cryp_ctx *ctx, int flags)
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
+	rctx->flags |= HASH_FLAGS_FINAL;
+	starfive_hash_start(ctx, flags);
+
+	if (starfive_hash_wait_busy(ctx))
+		return dev_err_probe(cryp->dev, -ETIMEDOUT,
+				     "Timeout waiting for hash completion\n");
+
+	if (ctx->hash_mode & STARFIVE_HASH_HMAC_FLAGS)
+		if (starfive_hash_wait_hmac_done(ctx))
+			return dev_err_probe(cryp->dev, -ETIMEDOUT,
+					     "Timeout waiting for hmac completion\n");
+
+	return 0;
+}
+
+static int starfive_hash_update_req(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
+	int ret = 0, final;
+
+	final = (rctx->flags & HASH_FLAGS_FINUP);
+
+	while ((rctx->total >= rctx->buflen) ||
+	       (rctx->bufcnt + rctx->total >= rctx->buflen)) {
+		starfive_hash_append_sg(rctx);
+		ret = starfive_hash_xmit(ctx, 0);
+		rctx->bufcnt = 0;
+	}
+
+	starfive_hash_append_sg(rctx);
+
+	if (final) {
+		ret = starfive_hash_xmit(ctx, (rctx->flags & HASH_FLAGS_FINUP));
+		rctx->bufcnt = 0;
+	}
+
+	return ret;
+}
+
+static int starfive_hash_final_req(struct starfive_cryp_ctx *ctx)
+{
+	struct ahash_request *req = ctx->rctx->req.hreq;
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	int ret;
+
+	ret = starfive_hash_xmit(ctx, 1);
+	rctx->bufcnt = 0;
+
+	return ret;
+}
+
+static int starfive_hash_out_cpu(struct ahash_request *req)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct starfive_cryp_ctx *ctx = rctx->ctx;
+	int count, *data;
+	int mlen;
+
+	if (!req->result)
+		return 0;
+
+	mlen = starfive_get_hash_size(ctx) / sizeof(u32);
+	data = (u32 *)req->result;
+
+	for (count = 0; count < mlen; count++)
+		data[count] = readl(ctx->cryp->base + STARFIVE_HASH_SHARDR);
+
+	return 0;
+}
+
+static int starfive_hash_copy_hash(struct ahash_request *req)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct starfive_cryp_ctx *ctx = rctx->ctx;
+	int hashsize;
+	int ret;
+
+	hashsize = starfive_get_hash_size(ctx);
+
+	ret = starfive_hash_out_cpu(req);
+
+	if (ret)
+		return ret;
+
+	memcpy(rctx->hash_digest_mid, req->result, hashsize);
+	rctx->hash_digest_len = hashsize;
+
+	return ret;
+}
+
+static void starfive_hash_finish_req(struct ahash_request *req, int err)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct starfive_cryp_dev *cryp = rctx->cryp;
+
+	if (!err && (HASH_FLAGS_FINAL & rctx->flags)) {
+		err = starfive_hash_copy_hash(req);
+		rctx->flags &= ~(HASH_FLAGS_FINAL |
+				 HASH_FLAGS_INIT);
+	}
+
+	crypto_finalize_hash_request(cryp->engine, req, err);
+}
+
+static int starfive_hash_prepare_req(struct crypto_engine *engine, void *areq)
+{
+	struct ahash_request *req = container_of(areq, struct ahash_request,
+						 base);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct starfive_cryp_request_ctx *rctx;
+
+	if (!cryp)
+		return -ENODEV;
+
+	rctx = ahash_request_ctx(req);
+
+	rctx->req.hreq = req;
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
+	struct starfive_cryp_request_ctx *rctx;
+	int err = 0;
+
+	if (!cryp)
+		return -ENODEV;
+
+	rctx = ahash_request_ctx(req);
+
+	mutex_lock(&ctx->cryp->lock);
+
+	if (rctx->op == HASH_OP_UPDATE)
+		err = starfive_hash_update_req(ctx);
+	else if (rctx->op == HASH_OP_FINAL)
+		err = starfive_hash_final_req(ctx);
+
+	if (err != -EINPROGRESS)
+		starfive_hash_finish_req(req, err);
+
+	mutex_unlock(&ctx->cryp->lock);
+
+	return 0;
+}
+
+static int starfive_hash_enqueue(struct ahash_request *req, unsigned int op)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct starfive_cryp_ctx *ctx = crypto_tfm_ctx(req->base.tfm);
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+
+	rctx->op = op;
+
+	return crypto_transfer_hash_request_to_engine(cryp->engine, req);
+}
+
+static int starfive_hash_init(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+
+	memset(rctx, 0, sizeof(struct starfive_cryp_request_ctx));
+
+	rctx->cryp = cryp;
+	rctx->ctx = ctx;
+	rctx->req.hreq = req;
+	rctx->bufcnt = 0;
+
+	rctx->total = 0;
+	rctx->offset = 0;
+	rctx->bufcnt = 0;
+	rctx->buflen = STARFIVE_HASH_BUFLEN;
+
+	memset(ctx->buffer, 0, STARFIVE_HASH_BUFLEN);
+
+	ctx->rctx = rctx;
+
+	return 0;
+}
+
+static int starfive_hash_update(struct ahash_request *req)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+
+	if (!req->nbytes)
+		return 0;
+
+	rctx->total = req->nbytes;
+	rctx->in_sg = req->src;
+	rctx->offset = 0;
+
+	if ((rctx->bufcnt + rctx->total < rctx->buflen)) {
+		starfive_hash_append_sg(rctx);
+		return 0;
+	}
+
+	return starfive_hash_enqueue(req, HASH_OP_UPDATE);
+}
+
+static int starfive_hash_final(struct ahash_request *req)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct starfive_cryp_ctx *ctx = crypto_tfm_ctx(req->base.tfm);
+
+	rctx->flags |= HASH_FLAGS_FINUP;
+
+	if (ctx->fallback_available && rctx->bufcnt < STARFIVE_HASH_THRES) {
+		if (ctx->hash_mode & STARFIVE_HASH_HMAC_FLAGS)
+			crypto_shash_setkey(ctx->fallback.shash, ctx->key,
+					    ctx->keylen);
+
+		return crypto_shash_tfm_digest(ctx->fallback.shash, ctx->buffer,
+					       rctx->bufcnt, req->result);
+	}
+
+	return starfive_hash_enqueue(req, HASH_OP_FINAL);
+}
+
+static int starfive_hash_finup(struct ahash_request *req)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	int err1, err2;
+
+	rctx->flags |= HASH_FLAGS_FINUP;
+
+	err1 = starfive_hash_update(req);
+
+	if (err1 == -EINPROGRESS || err1 == -EBUSY)
+		return err1;
+
+	/*
+	 * final() has to be always called to cleanup resources
+	 * even if update() failed, except EINPROGRESS
+	 */
+	err2 = starfive_hash_final(req);
+
+	return err1 ?: err2;
+}
+
+static int starfive_hash_digest(struct ahash_request *req)
+{
+	return starfive_hash_init(req) ?: starfive_hash_finup(req);
+}
+
+static int starfive_hash_export(struct ahash_request *req, void *out)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+
+	memcpy(out, rctx, sizeof(*rctx));
+
+	return 0;
+}
+
+static int starfive_hash_import(struct ahash_request *req, const void *in)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+
+	memcpy(rctx, in, sizeof(*rctx));
+
+	return 0;
+}
+
+static int starfive_hash_cra_init_algs(struct crypto_tfm *tfm,
+				       const char *algs_hmac_name,
+				       unsigned int mode)
+{
+	struct starfive_cryp_ctx *ctx = crypto_tfm_ctx(tfm);
+	const char *alg_name = crypto_tfm_alg_name(tfm);
+
+	ctx->cryp = starfive_cryp_find_dev(ctx);
+
+	if (!ctx->cryp)
+		return -ENODEV;
+
+	ctx->fallback_available = true;
+	ctx->fallback.shash = crypto_alloc_shash(alg_name, 0,
+						 CRYPTO_ALG_NEED_FALLBACK);
+
+	if (IS_ERR(ctx->fallback.shash))
+		ctx->fallback_available = false;
+
+	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
+				 sizeof(struct starfive_cryp_request_ctx));
+
+	ctx->keylen = 0;
+	ctx->hash_mode = mode;
+	ctx->hash_len_total = 0;
+	ctx->buffer = ctx->cryp->hash_data;
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
+	crypto_free_shash(ctx->fallback.shash);
+
+	ctx->fallback.shash = NULL;
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
+	buf = kzalloc(keylen + STARFIVE_MAX_ALIGN_SIZE, GFP_KERNEL);
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
+	return starfive_hash_cra_init_algs(tfm, NULL, STARFIVE_HASH_SHA224);
+}
+
+static int starfive_hash_cra_sha256_init(struct crypto_tfm *tfm)
+{
+	return starfive_hash_cra_init_algs(tfm, NULL, STARFIVE_HASH_SHA256);
+}
+
+static int starfive_hash_cra_sha384_init(struct crypto_tfm *tfm)
+{
+	return starfive_hash_cra_init_algs(tfm, NULL, STARFIVE_HASH_SHA384);
+}
+
+static int starfive_hash_cra_sha512_init(struct crypto_tfm *tfm)
+{
+	return starfive_hash_cra_init_algs(tfm, NULL, STARFIVE_HASH_SHA512);
+}
+
+static int starfive_hash_cra_sm3_init(struct crypto_tfm *tfm)
+{
+	return starfive_hash_cra_init_algs(tfm, NULL, STARFIVE_HASH_SM3);
+}
+
+static int starfive_hash_cra_hmac_sha224_init(struct crypto_tfm *tfm)
+{
+	return starfive_hash_cra_init_algs(tfm, "sha224", STARFIVE_HASH_SHA224);
+}
+
+static int starfive_hash_cra_hmac_sha256_init(struct crypto_tfm *tfm)
+{
+	return starfive_hash_cra_init_algs(tfm, "sha256", STARFIVE_HASH_SHA256);
+}
+
+static int starfive_hash_cra_hmac_sha384_init(struct crypto_tfm *tfm)
+{
+	return starfive_hash_cra_init_algs(tfm, "sha384", STARFIVE_HASH_SHA384);
+}
+
+static int starfive_hash_cra_hmac_sha512_init(struct crypto_tfm *tfm)
+{
+	return starfive_hash_cra_init_algs(tfm, "sha512", STARFIVE_HASH_SHA512);
+}
+
+static int starfive_hash_cra_hmac_sm3_init(struct crypto_tfm *tfm)
+{
+	return starfive_hash_cra_init_algs(tfm, "sm3", STARFIVE_HASH_SM3);
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
+		.statesize  = sizeof(struct starfive_cryp_request_ctx),
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
+		.statesize  = sizeof(struct starfive_cryp_request_ctx),
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
+		.statesize  = sizeof(struct starfive_cryp_request_ctx),
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
+		.statesize  = sizeof(struct starfive_cryp_request_ctx),
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
+		.statesize  = sizeof(struct starfive_cryp_request_ctx),
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
+		.statesize  = sizeof(struct starfive_cryp_request_ctx),
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
+		.statesize  = sizeof(struct starfive_cryp_request_ctx),
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
+		.statesize  = sizeof(struct starfive_cryp_request_ctx),
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
+		.statesize  = sizeof(struct starfive_cryp_request_ctx),
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
+		.statesize  = sizeof(struct starfive_cryp_request_ctx),
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
diff --git a/drivers/crypto/starfive/starfive-regs.h b/drivers/crypto/starfive/starfive-regs.h
index 0d680cb1f502..3f5e8881b3c0 100644
--- a/drivers/crypto/starfive/starfive-regs.h
+++ b/drivers/crypto/starfive/starfive-regs.h
@@ -9,6 +9,8 @@
 #define STARFIVE_DMA_IN_LEN_OFFSET		0x10
 #define STARFIVE_DMA_OUT_LEN_OFFSET		0x14
 
+#define STARFIVE_HASH_REGS_OFFSET		0x300
+
 union starfive_alg_cr {
 	u32 v;
 	struct {
@@ -23,4 +25,47 @@ union starfive_alg_cr {
 	};
 };
 
+#define STARFIVE_HASH_SHACSR			(STARFIVE_HASH_REGS_OFFSET + 0x0)
+#define STARFIVE_HASH_SHAWDR			(STARFIVE_HASH_REGS_OFFSET + 0x4)
+#define STARFIVE_HASH_SHARDR			(STARFIVE_HASH_REGS_OFFSET + 0x8)
+#define STARFIVE_HASH_SHAWSR			(STARFIVE_HASH_REGS_OFFSET + 0xC)
+#define STARFIVE_HASH_SHAWLEN3			(STARFIVE_HASH_REGS_OFFSET + 0x10)
+#define STARFIVE_HASH_SHAWLEN2			(STARFIVE_HASH_REGS_OFFSET + 0x14)
+#define STARFIVE_HASH_SHAWLEN1			(STARFIVE_HASH_REGS_OFFSET + 0x18)
+#define STARFIVE_HASH_SHAWLEN0			(STARFIVE_HASH_REGS_OFFSET + 0x1C)
+#define STARFIVE_HASH_SHAWKR			(STARFIVE_HASH_REGS_OFFSET + 0x20)
+#define STARFIVE_HASH_SHAWKLEN			(STARFIVE_HASH_REGS_OFFSET + 0x24)
+
+union starfive_hash_csr {
+	u32 v;
+	struct {
+		u32 start			:1;
+		u32 reset			:1;
+		u32 rsvd_0			:1;
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
 #endif
diff --git a/drivers/crypto/starfive/starfive-str.h b/drivers/crypto/starfive/starfive-str.h
index 10997c88f0e5..547bc2b48b78 100644
--- a/drivers/crypto/starfive/starfive-str.h
+++ b/drivers/crypto/starfive/starfive-str.h
@@ -7,28 +7,41 @@
 #include <linux/dmaengine.h>
 
 #include <crypto/engine.h>
+#include <crypto/sha2.h>
+#include <crypto/sm3.h>
 
 #include "starfive-regs.h"
 
 #define STARFIVE_MSG_BUFFER_SIZE		SZ_16K
+#define MAX_KEY_SIZE				SHA512_BLOCK_SIZE
 
 struct starfive_cryp_ctx {
 	struct crypto_engine_ctx		enginectx;
 	struct starfive_cryp_dev		*cryp;
+	struct starfive_cryp_request_ctx	*rctx;
+	struct scatterlist			sg[2];
 
+	unsigned int				hash_mode;
+	u8					key[MAX_KEY_SIZE];
+	int					keylen;
+	size_t					hash_len_total;
 	u8					*buffer;
+	union {
+		struct crypto_shash		*shash;
+	} fallback;
+	bool                                    fallback_available;
 };
 
 struct starfive_cryp_dev {
 	struct list_head			list;
 	struct device				*dev;
-
 	struct clk				*hclk;
 	struct clk				*ahb;
 	struct reset_control			*rst;
 
 	void __iomem				*base;
 	phys_addr_t				phys_base;
+	void					*hash_data;
 
 	size_t					data_buf_len;
 	int					pages_count;
@@ -40,12 +53,47 @@ struct starfive_cryp_dev {
 	struct dma_slave_config			cfg_out;
 	struct completion			tx_comp;
 	struct completion			rx_comp;
-
+	/* To synchronize concurrent request from different
+	 * crypto module accessing the hardware engine.
+	 */
+	struct mutex				lock;
 	struct crypto_engine			*engine;
 
 	union starfive_alg_cr			alg_cr;
 };
 
+struct starfive_cryp_request_ctx {
+	struct starfive_cryp_ctx		*ctx;
+	struct starfive_cryp_dev		*cryp;
+
+	union {
+		struct ahash_request		*hreq;
+	} req;
+#define STARFIVE_AHASH_REQ			0
+	unsigned int				req_type;
+
+	union {
+		union starfive_hash_csr		hash;
+	} csr;
+
+	struct scatterlist			*in_sg;
+
+	unsigned long				flags;
+	unsigned long				op;
+
+	size_t					bufcnt;
+	size_t					buflen;
+	size_t					total;
+	size_t					offset;
+	size_t					data_offset;
+
+	unsigned int				hash_digest_len;
+	u8 hash_digest_mid[SHA512_DIGEST_SIZE]__aligned(sizeof(u32));
+};
+
 struct starfive_cryp_dev *starfive_cryp_find_dev(struct starfive_cryp_ctx *ctx);
 
+int starfive_hash_register_algs(void);
+void starfive_hash_unregister_algs(void);
+
 #endif
-- 
2.25.1

