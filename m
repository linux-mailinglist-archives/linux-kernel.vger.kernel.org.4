Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB1663CEDF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 06:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbiK3Fyi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Nov 2022 00:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiK3Fye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 00:54:34 -0500
X-Greylist: delayed 124 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Nov 2022 21:54:27 PST
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E2F28730;
        Tue, 29 Nov 2022 21:54:27 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id CB09124E1D1;
        Wed, 30 Nov 2022 13:52:30 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 30 Nov
 2022 13:52:30 +0800
Received: from ubuntu.localdomain (202.188.176.82) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 30 Nov
 2022 13:52:24 +0800
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>
Subject: [PATCH 2/6] crypto: starfive - Add hash and HMAC support
Date:   Wed, 30 Nov 2022 13:52:10 +0800
Message-ID: <20221130055214.2416888-3-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130055214.2416888-1-jiajie.ho@starfivetech.com>
References: <20221130055214.2416888-1-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding hash function and HMAC support for SHA-2 family
and SM3 to Starfive crypto hardware driver.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
---
 drivers/crypto/starfive/Makefile        |    2 +-
 drivers/crypto/starfive/starfive-cryp.c |   22 +
 drivers/crypto/starfive/starfive-hash.c | 1152 +++++++++++++++++++++++
 drivers/crypto/starfive/starfive-regs.h |   45 +
 drivers/crypto/starfive/starfive-str.h  |   52 +-
 5 files changed, 1271 insertions(+), 2 deletions(-)
 create mode 100644 drivers/crypto/starfive/starfive-hash.c

diff --git a/drivers/crypto/starfive/Makefile b/drivers/crypto/starfive/Makefile
index 5a84f808a671..437b8f036038 100644
--- a/drivers/crypto/starfive/Makefile
+++ b/drivers/crypto/starfive/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_CRYPTO_DEV_STARFIVE) += starfive-crypto.o
-starfive-crypto-objs := starfive-cryp.o
+starfive-crypto-objs := starfive-cryp.o starfive-hash.o
diff --git a/drivers/crypto/starfive/starfive-cryp.c b/drivers/crypto/starfive/starfive-cryp.c
index 574f9e8f4cc1..9f77cae758ac 100644
--- a/drivers/crypto/starfive/starfive-cryp.c
+++ b/drivers/crypto/starfive/starfive-cryp.c
@@ -109,6 +109,8 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 	if (!sdev)
 		return -ENOMEM;
 
+	mutex_init(&sdev->lock);
+
 	sdev->dev = dev;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "secreg");
@@ -117,6 +119,7 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 	if (IS_ERR(sdev->io_base))
 		return PTR_ERR(sdev->io_base);
 
+	sdev->io_phys_base = res->start;
 	sdev->use_side_channel_mitigation =
 		device_property_read_bool(dev, "enable-side-channel-mitigation");
 	sdev->use_dma = device_property_read_bool(dev, "enable-dma");
@@ -160,6 +163,12 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 
 	pages = get_order(STARFIVE_MSG_BUFFER_SIZE);
 
+	sdev->hash_data = (void *)__get_free_pages(GFP_KERNEL | GFP_DMA32, pages);
+	if (!sdev->hash_data) {
+		dev_err(sdev->dev, "Can't allocate hash buffer pages when unaligned\n");
+		goto err_hash_data;
+	}
+
 	sdev->pages_count = pages >> 1;
 	sdev->data_buf_len = STARFIVE_MSG_BUFFER_SIZE >> 1;
 
@@ -174,13 +183,21 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_engine_start;
 
+	ret = starfive_hash_register_algs();
+	if (ret)
+		goto err_algs_hash;
+
 	dev_info(dev, "Crypto engine started\n");
 
 	return 0;
 
+err_algs_hash:
+	crypto_engine_stop(sdev->engine);
 err_engine_start:
 	crypto_engine_exit(sdev->engine);
 err_engine:
+	free_pages((unsigned long)sdev->hash_data, pages);
+err_hash_data:
 	starfive_dma_cleanup(sdev);
 err_dma_init:
 	spin_lock(&dev_list.lock);
@@ -197,11 +214,16 @@ static int starfive_cryp_remove(struct platform_device *pdev)
 	if (!sdev)
 		return -ENODEV;
 
+	starfive_hash_unregister_algs();
+
 	crypto_engine_stop(sdev->engine);
 	crypto_engine_exit(sdev->engine);
 
 	starfive_dma_cleanup(sdev);
 
+	free_pages((unsigned long)sdev->hash_data, sdev->pages_count);
+	sdev->hash_data = NULL;
+
 	spin_lock(&dev_list.lock);
 	list_del(&sdev->list);
 	spin_unlock(&dev_list.lock);
diff --git a/drivers/crypto/starfive/starfive-hash.c b/drivers/crypto/starfive/starfive-hash.c
new file mode 100644
index 000000000000..c85dec784df9
--- /dev/null
+++ b/drivers/crypto/starfive/starfive-hash.c
@@ -0,0 +1,1152 @@
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
+static inline int starfive_hash_wait_hmac_done(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	u32 status;
+
+	return readl_relaxed_poll_timeout(sdev->io_base + STARFIVE_HASH_SHACSR, status,
+			(status & STARFIVE_HASH_HMAC_DONE), 10, 100000);
+}
+
+static inline int starfive_hash_wait_busy(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	u32 status;
+
+	return readl_relaxed_poll_timeout(sdev->io_base + STARFIVE_HASH_SHACSR, status,
+			!(status & STARFIVE_HASH_BUSY), 10, 100000);
+}
+
+static inline int starfive_hash_wait_key_done(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	u32 status;
+
+	return readl_relaxed_poll_timeout(sdev->io_base + STARFIVE_HASH_SHACSR, status,
+			(status & STARFIVE_HASH_KEY_DONE), 10, 100000);
+}
+
+static int starfive_get_hash_size(struct starfive_sec_ctx *ctx)
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
+static void starfive_hash_start(struct starfive_sec_ctx *ctx, int flags)
+{
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+	struct starfive_sec_dev *sdev = ctx->sdev;
+
+	rctx->csr.hash.v = starfive_sec_read(sdev, STARFIVE_HASH_SHACSR);
+	rctx->csr.hash.firstb = 0;
+
+	if (flags)
+		rctx->csr.hash.final = 1;
+
+	starfive_sec_write(sdev, STARFIVE_HASH_SHACSR, rctx->csr.hash.v);
+}
+
+static int starfive_hash_hmac_key(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	int klen = ctx->keylen, loop;
+	unsigned int *key = (unsigned int *)ctx->key;
+	unsigned char *cl;
+
+	starfive_sec_write(sdev, STARFIVE_HASH_SHAWKLEN, ctx->keylen);
+
+	rctx->csr.hash.hmac = !!(ctx->hash_mode & STARFIVE_HASH_HMAC_FLAGS);
+	rctx->csr.hash.key_flag = 1;
+
+	starfive_sec_write(sdev, STARFIVE_HASH_SHACSR, rctx->csr.hash.v);
+
+	for (loop = 0; loop < klen / sizeof(unsigned int); loop++, key++)
+		starfive_sec_write(sdev, STARFIVE_HASH_SHAWKR, *key);
+
+	if (klen & 0x3) {
+		cl = (unsigned char *)key;
+		for (loop = 0; loop < (klen & 0x3); loop++, cl++)
+			starfive_sec_writeb(sdev, STARFIVE_HASH_SHAWKR, *cl);
+	}
+
+	if (starfive_hash_wait_key_done(ctx)) {
+		dev_err(sdev->dev, " starfive_hash_wait_key_done error\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static void starfive_hash_dma_callback(void *param)
+{
+	struct starfive_sec_dev *sdev = param;
+
+	complete(&sdev->sec_comp_m);
+}
+
+static int starfive_hash_xmit_dma(struct starfive_sec_ctx *ctx, int flags)
+{
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+	struct starfive_sec_dev *sdev = ctx->sdev;
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
+	total_len = rctx->bufcnt;
+
+	starfive_sec_write(sdev, STARFIVE_DMA_IN_LEN_OFFSET, rctx->bufcnt);
+
+	total_len = (total_len & 0x3) ? (((total_len >> 2) + 1) << 2) : total_len;
+
+	memset(sdev->hash_data + rctx->bufcnt, 0, total_len - rctx->bufcnt);
+
+	alg_cr.v = 0;
+	alg_cr.start = 1;
+	alg_cr.hash_dma_en = 1;
+	starfive_sec_write(sdev, STARFIVE_ALG_CR_OFFSET, alg_cr.v);
+
+	sg_init_table(&ctx->sg[0], 1);
+	sg_set_buf(&ctx->sg[0], sdev->hash_data, total_len);
+	sg_dma_address(&ctx->sg[0]) = phys_to_dma(sdev->dev, (unsigned long long)(sdev->hash_data));
+	sg_dma_len(&ctx->sg[0]) = total_len;
+
+	ret = dma_map_sg(sdev->dev, &ctx->sg[0], 1, DMA_TO_DEVICE);
+	if (!ret) {
+		dev_err(sdev->dev, "dma_map_sg() error\n");
+		return -EINVAL;
+	}
+
+	sdev->cfg_in.direction = DMA_MEM_TO_DEV;
+	sdev->cfg_in.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	sdev->cfg_in.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	sdev->cfg_in.src_maxburst = sdev->dma_maxburst;
+	sdev->cfg_in.dst_maxburst = sdev->dma_maxburst;
+	sdev->cfg_in.dst_addr = sdev->io_phys_base + STARFIVE_ALG_FIFO_OFFSET;
+
+	dmaengine_slave_config(sdev->sec_xm_m, &sdev->cfg_in);
+
+	in_desc = dmaengine_prep_slave_sg(sdev->sec_xm_m, &ctx->sg[0],
+					  1, DMA_MEM_TO_DEV,
+					  DMA_PREP_INTERRUPT  |  DMA_CTRL_ACK);
+	if (!in_desc)
+		return -EINVAL;
+
+	reinit_completion(&sdev->sec_comp_m);
+
+	in_desc->callback = starfive_hash_dma_callback;
+	in_desc->callback_param = sdev;
+
+	cookie = dmaengine_submit(in_desc);
+	dma_async_issue_pending(sdev->sec_xm_m);
+
+	if (!wait_for_completion_timeout(&sdev->sec_comp_m,
+					 msecs_to_jiffies(10000))) {
+		dev_err(sdev->dev, "wait_for_completion_timeout error, cookie = %x\n",
+			dma_async_is_tx_complete(sdev->sec_xm_p, cookie,
+						 NULL, NULL));
+	}
+
+	dma_unmap_sg(sdev->dev, &ctx->sg[0], 1, DMA_TO_DEVICE);
+
+	alg_cr.v = 0;
+	alg_cr.clear = 1;
+	starfive_sec_write(sdev, STARFIVE_ALG_CR_OFFSET, alg_cr.v);
+
+	return 0;
+}
+
+static int starfive_hash_xmit_cpu(struct starfive_sec_ctx *ctx, int flags)
+{
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	int total_len, mlen, loop;
+	unsigned int  *buffer;
+	unsigned char *cl;
+
+	if (!rctx->bufcnt)
+		return 0;
+
+	ctx->hash_len_total += rctx->bufcnt;
+
+	total_len = rctx->bufcnt;
+	mlen = total_len / sizeof(u32);
+	buffer = (unsigned int *)ctx->buffer;
+
+	for (loop = 0; loop < mlen; loop++, buffer++) {
+		starfive_sec_write(sdev, STARFIVE_HASH_SHAWDR, *buffer);
+		udelay(2);
+	}
+
+	if (total_len & 0x3) {
+		cl = (unsigned char *)buffer;
+		for (loop = 0; loop < (total_len & 0x3); loop++, cl++) {
+			starfive_sec_writeb(sdev, STARFIVE_HASH_SHAWDR, *cl);
+			udelay(2);
+		}
+	}
+
+	return 0;
+}
+
+static void starfive_hash_append_sg(struct starfive_sec_request_ctx *rctx)
+{
+	struct starfive_sec_ctx *ctx = rctx->ctx;
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
+static int starfive_hash_xmit(struct starfive_sec_ctx *ctx, int flags)
+{
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	int ret;
+
+	rctx->csr.hash.v = 0;
+	rctx->csr.hash.reset = 1;
+	starfive_sec_write(sdev, STARFIVE_HASH_SHACSR, rctx->csr.hash.v);
+
+	if (starfive_hash_wait_busy(ctx)) {
+		dev_err(sdev->dev, "Error resetting engine.\n");
+		return -ETIMEDOUT;
+	}
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
+		starfive_sec_write(sdev, STARFIVE_HASH_SHACSR, rctx->csr.hash.v);
+	}
+
+	if (ctx->sdev->use_dma)
+		ret = starfive_hash_xmit_dma(ctx, flags);
+	else
+		ret = starfive_hash_xmit_cpu(ctx, flags);
+
+	if (ret)
+		return ret;
+
+	rctx->flags |= HASH_FLAGS_FINAL;
+	starfive_hash_start(ctx, flags);
+
+	if (starfive_hash_wait_busy(ctx)) {
+		dev_err(sdev->dev, "Timeout waiting for hash completion\n");
+		return -ETIMEDOUT;
+	}
+
+	if (ctx->hash_mode & STARFIVE_HASH_HMAC_FLAGS)
+		if (starfive_hash_wait_hmac_done(ctx)) {
+			dev_err(sdev->dev, "Timeout waiting for hmac completion\n");
+			return -ETIMEDOUT;
+		}
+
+	return 0;
+}
+
+static int starfive_hash_update_req(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+	int ret, final;
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
+static int starfive_hash_final_req(struct starfive_sec_ctx *ctx)
+{
+	struct ahash_request *req = ctx->rctx->req.hreq;
+	struct starfive_sec_request_ctx *rctx = ahash_request_ctx(req);
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
+	struct starfive_sec_request_ctx *rctx = ahash_request_ctx(req);
+	struct starfive_sec_ctx *ctx = rctx->ctx;
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
+		data[count] = starfive_sec_read(ctx->sdev, STARFIVE_HASH_SHARDR);
+
+	return 0;
+}
+
+static int starfive_hash_copy_hash(struct ahash_request *req)
+{
+	struct starfive_sec_request_ctx *rctx = ahash_request_ctx(req);
+	struct starfive_sec_ctx *ctx = rctx->ctx;
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
+	struct starfive_sec_request_ctx *rctx = ahash_request_ctx(req);
+	struct starfive_sec_dev *sdev = rctx->sdev;
+
+	if (!err && (HASH_FLAGS_FINAL & rctx->flags)) {
+		err = starfive_hash_copy_hash(req);
+		rctx->flags &= ~(HASH_FLAGS_FINAL |
+				 HASH_FLAGS_INIT);
+	}
+
+	crypto_finalize_hash_request(sdev->engine, req, err);
+}
+
+static int starfive_hash_prepare_req(struct crypto_engine *engine, void *areq)
+{
+	struct ahash_request *req = container_of(areq, struct ahash_request,
+						 base);
+	struct starfive_sec_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	struct starfive_sec_request_ctx *rctx;
+
+	if (!sdev)
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
+	struct starfive_sec_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	struct starfive_sec_request_ctx *rctx;
+	int err = 0;
+
+	if (!sdev)
+		return -ENODEV;
+
+	rctx = ahash_request_ctx(req);
+
+	mutex_lock(&ctx->sdev->lock);
+
+	if (rctx->op == HASH_OP_UPDATE)
+		err = starfive_hash_update_req(ctx);
+	else if (rctx->op == HASH_OP_FINAL)
+		err = starfive_hash_final_req(ctx);
+
+	if (err != -EINPROGRESS)
+	/* done task will not finish it, so do it here */
+		starfive_hash_finish_req(req, err);
+
+	mutex_unlock(&ctx->sdev->lock);
+
+	return 0;
+}
+
+static int starfive_hash_handle_queue(struct starfive_sec_dev *sdev,
+				      struct ahash_request *req)
+{
+	return crypto_transfer_hash_request_to_engine(sdev->engine, req);
+}
+
+static int starfive_hash_enqueue(struct ahash_request *req, unsigned int op)
+{
+	struct starfive_sec_request_ctx *rctx = ahash_request_ctx(req);
+	struct starfive_sec_ctx *ctx = crypto_tfm_ctx(req->base.tfm);
+	struct starfive_sec_dev *sdev = ctx->sdev;
+
+	rctx->op = op;
+
+	return starfive_hash_handle_queue(sdev, req);
+}
+
+static int starfive_hash_init(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct starfive_sec_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct starfive_sec_request_ctx *rctx = ahash_request_ctx(req);
+	struct starfive_sec_dev *sdev = ctx->sdev;
+
+	memset(rctx, 0, sizeof(struct starfive_sec_request_ctx));
+
+	rctx->sdev = sdev;
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
+	dev_dbg(sdev->dev, "%s Flags %lx\n", __func__, rctx->flags);
+
+	return 0;
+}
+
+static int starfive_hash_update(struct ahash_request *req)
+{
+	struct starfive_sec_request_ctx *rctx = ahash_request_ctx(req);
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
+	struct starfive_sec_request_ctx *rctx = ahash_request_ctx(req);
+	struct starfive_sec_ctx *ctx = crypto_tfm_ctx(req->base.tfm);
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
+	struct starfive_sec_request_ctx *rctx = ahash_request_ctx(req);
+	int err1, err2;
+	int nents;
+
+	nents = sg_nents_for_len(req->src, req->nbytes);
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
+	struct starfive_sec_request_ctx *rctx = ahash_request_ctx(req);
+
+	memcpy(out, rctx, sizeof(*rctx));
+
+	return 0;
+}
+
+static int starfive_hash_import(struct ahash_request *req, const void *in)
+{
+	struct starfive_sec_request_ctx *rctx = ahash_request_ctx(req);
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
+	struct starfive_sec_ctx *ctx = crypto_tfm_ctx(tfm);
+	const char *alg_name = crypto_tfm_alg_name(tfm);
+
+	ctx->sdev = starfive_sec_find_dev(ctx);
+
+	if (!ctx->sdev)
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
+				 sizeof(struct starfive_sec_request_ctx));
+
+	ctx->keylen   = 0;
+	ctx->hash_mode = mode;
+	ctx->hash_len_total = 0;
+	ctx->buffer = ctx->sdev->hash_data;
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
+	struct starfive_sec_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	crypto_free_shash(ctx->fallback.shash);
+
+	ctx->fallback.shash = NULL;
+	ctx->enginectx.op.do_one_request = NULL;
+	ctx->enginectx.op.prepare_request = NULL;
+	ctx->enginectx.op.unprepare_request = NULL;
+}
+
+static int starfive_hash_long_setkey(struct starfive_sec_ctx *ctx,
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
+	struct starfive_sec_ctx *ctx = crypto_ahash_ctx(tfm);
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
+	struct starfive_sec_ctx *ctx = crypto_ahash_ctx(tfm);
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
+	struct starfive_sec_ctx *ctx = crypto_ahash_ctx(tfm);
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
+	struct starfive_sec_ctx *ctx = crypto_ahash_ctx(tfm);
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
+	struct starfive_sec_ctx *ctx = crypto_ahash_ctx(tfm);
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
+		.statesize  = sizeof(struct starfive_sec_request_ctx),
+		.base = {
+			.cra_name		= "sha224",
+			.cra_driver_name	= "starfive-sha224",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SHA224_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_sec_ctx),
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
+		.statesize  = sizeof(struct starfive_sec_request_ctx),
+		.base = {
+			.cra_name		= "hmac(sha224)",
+			.cra_driver_name	= "starfive-hmac-sha224",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SHA224_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_sec_ctx),
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
+		.statesize  = sizeof(struct starfive_sec_request_ctx),
+		.base = {
+			.cra_name		= "sha256",
+			.cra_driver_name	= "starfive-sha256",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SHA256_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_sec_ctx),
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
+		.statesize  = sizeof(struct starfive_sec_request_ctx),
+		.base = {
+			.cra_name		= "hmac(sha256)",
+			.cra_driver_name	= "starfive-hmac-sha256",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SHA256_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_sec_ctx),
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
+		.statesize  = sizeof(struct starfive_sec_request_ctx),
+		.base = {
+			.cra_name		= "sha384",
+			.cra_driver_name	= "starfive-sha384",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SHA384_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_sec_ctx),
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
+		.statesize  = sizeof(struct starfive_sec_request_ctx),
+		.base = {
+			.cra_name		= "hmac(sha384)",
+			.cra_driver_name	= "starfive-hmac-sha384",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SHA384_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_sec_ctx),
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
+		.statesize  = sizeof(struct starfive_sec_request_ctx),
+		.base = {
+			.cra_name		= "sha512",
+			.cra_driver_name	= "starfive-sha512",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH,
+			.cra_blocksize		= SHA512_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_sec_ctx),
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
+		.statesize  = sizeof(struct starfive_sec_request_ctx),
+		.base = {
+			.cra_name		= "hmac(sha512)",
+			.cra_driver_name	= "starfive-hmac-sha512",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SHA512_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_sec_ctx),
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
+		.statesize  = sizeof(struct starfive_sec_request_ctx),
+		.base = {
+			.cra_name		= "sm3",
+			.cra_driver_name	= "starfive-sm3",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SM3_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_sec_ctx),
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
+		.statesize  = sizeof(struct starfive_sec_request_ctx),
+		.base = {
+			.cra_name		= "hmac(sm3)",
+			.cra_driver_name	= "starfive-hmac-sm3",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SM3_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_sec_ctx),
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
index 4ba3c56f0573..a6fed48a0b19 100644
--- a/drivers/crypto/starfive/starfive-str.h
+++ b/drivers/crypto/starfive/starfive-str.h
@@ -7,16 +7,29 @@
 #include <linux/dmaengine.h>
 
 #include <crypto/engine.h>
+#include <crypto/sha2.h>
+#include <crypto/sm3.h>
 
 #include "starfive-regs.h"
 
 #define STARFIVE_MSG_BUFFER_SIZE		SZ_16K
+#define MAX_KEY_SIZE				SHA512_BLOCK_SIZE
 
 struct starfive_sec_ctx {
 	struct crypto_engine_ctx		enginectx;
 	struct starfive_sec_dev			*sdev;
-
+	struct starfive_sec_request_ctx		*rctx;
+	unsigned int				hash_mode;
+	u8					key[MAX_KEY_SIZE];
+	int					keylen;
+	struct scatterlist			sg[2];
+	size_t					hash_len_total;
 	u8					*buffer;
+
+	union {
+		struct crypto_shash		*shash;
+	} fallback;
+	bool                                    fallback_available;
 };
 
 struct starfive_sec_dev {
@@ -29,6 +42,7 @@ struct starfive_sec_dev {
 
 	void __iomem				*io_base;
 	phys_addr_t				io_phys_base;
+	void					*hash_data;
 
 	size_t					data_buf_len;
 	int					pages_count;
@@ -41,12 +55,45 @@ struct starfive_sec_dev {
 	struct dma_slave_config			cfg_out;
 	struct completion			sec_comp_m;
 	struct completion			sec_comp_p;
+	/* To synchronize concurrent request from different
+	 * crypto module accessing the hardware engine.
+	 */
+	struct mutex				lock;
 
 	struct crypto_engine			*engine;
 
 	union starfive_alg_cr			alg_cr;
 };
 
+struct starfive_sec_request_ctx {
+	struct starfive_sec_ctx			*ctx;
+	struct starfive_sec_dev			*sdev;
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
 static inline u32 starfive_sec_read(struct starfive_sec_dev *sdev, u32 offset)
 {
 	return __raw_readl(sdev->io_base + offset);
@@ -71,4 +118,7 @@ static inline void starfive_sec_writeb(struct starfive_sec_dev *sdev,
 
 struct starfive_sec_dev *starfive_sec_find_dev(struct starfive_sec_ctx *ctx);
 
+int starfive_hash_register_algs(void);
+void starfive_hash_unregister_algs(void);
+
 #endif
-- 
2.25.1

