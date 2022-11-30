Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F274F63CEF1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 06:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbiK3Fzr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Nov 2022 00:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiK3Fzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 00:55:31 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9984A65E63;
        Tue, 29 Nov 2022 21:55:27 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id D03E324E2E2;
        Wed, 30 Nov 2022 13:52:34 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 30 Nov
 2022 13:52:35 +0800
Received: from ubuntu.localdomain (202.188.176.82) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 30 Nov
 2022 13:52:30 +0800
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>
Subject: [PATCH 3/6] crypto: starfive - Add AES skcipher and aead support
Date:   Wed, 30 Nov 2022 13:52:11 +0800
Message-ID: <20221130055214.2416888-4-jiajie.ho@starfivetech.com>
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

Adding AES skcipher and AEAD support to
Starfive crypto driver.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
---
 drivers/crypto/starfive/Makefile        |    2 +-
 drivers/crypto/starfive/starfive-aes.c  | 1723 +++++++++++++++++++++++
 drivers/crypto/starfive/starfive-cryp.c |   17 +
 drivers/crypto/starfive/starfive-regs.h |   64 +
 drivers/crypto/starfive/starfive-str.h  |   39 +-
 5 files changed, 1842 insertions(+), 3 deletions(-)
 create mode 100644 drivers/crypto/starfive/starfive-aes.c

diff --git a/drivers/crypto/starfive/Makefile b/drivers/crypto/starfive/Makefile
index 437b8f036038..4958b1f6812c 100644
--- a/drivers/crypto/starfive/Makefile
+++ b/drivers/crypto/starfive/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_CRYPTO_DEV_STARFIVE) += starfive-crypto.o
-starfive-crypto-objs := starfive-cryp.o starfive-hash.o
+starfive-crypto-objs := starfive-cryp.o starfive-hash.o starfive-aes.o
diff --git a/drivers/crypto/starfive/starfive-aes.c b/drivers/crypto/starfive/starfive-aes.c
new file mode 100644
index 000000000000..0f79f72cafcd
--- /dev/null
+++ b/drivers/crypto/starfive/starfive-aes.c
@@ -0,0 +1,1723 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive AES acceleration driver
+ *
+ * Copyright (c) 2022 StarFive Technology
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dma-direct.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/amba/pl080.h>
+
+#include <crypto/gcm.h>
+#include <crypto/scatterwalk.h>
+#include <crypto/internal/aead.h>
+#include <crypto/internal/skcipher.h>
+
+#include "starfive-str.h"
+
+/* Mode mask = bits [3..0] */
+#define FLG_MODE_MASK			GENMASK(2, 0)
+
+/* Bit [4] encrypt / decrypt */
+#define FLG_ENCRYPT			BIT(4)
+
+/* Misc */
+#define AES_BLOCK_32			(AES_BLOCK_SIZE / sizeof(u32))
+#define CCM_B0_ADATA			0x40
+
+static inline int starfive_aes_wait_busy(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	u32 status;
+
+	return readl_relaxed_poll_timeout(sdev->io_base + STARFIVE_AES_CSR, status,
+				   !(status & STARFIVE_AES_BUSY), 10, 100000);
+}
+
+static inline int starfive_aes_wait_keydone(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	u32 status;
+
+	return readl_relaxed_poll_timeout(sdev->io_base + STARFIVE_AES_CSR, status,
+				   (status & STARFIVE_AES_KEY_DONE), 10, 100000);
+}
+
+static inline int starfive_aes_wait_gcmdone(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	u32 status;
+
+	return readl_relaxed_poll_timeout(sdev->io_base + STARFIVE_AES_CSR, status,
+				   (status & STARFIVE_AES_GCM_DONE), 10, 100000);
+}
+
+static int starfive_cryp_check_aligned(struct scatterlist *sg, size_t total,
+				       size_t align)
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
+static int starfive_cryp_check_io_aligned(struct starfive_sec_request_ctx *rctx)
+{
+	int ret;
+
+	ret = starfive_cryp_check_aligned(rctx->in_sg, rctx->total_in,
+					  rctx->hw_blocksize);
+
+	if (ret)
+		return ret;
+
+	return starfive_cryp_check_aligned(rctx->out_sg, rctx->total_out,
+					   rctx->hw_blocksize);
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
+static int starfive_cryp_copy_sgs(struct starfive_sec_request_ctx *rctx)
+{
+	void *buf_in, *buf_out;
+	int pages, total_in, total_out;
+
+	if (!starfive_cryp_check_io_aligned(rctx)) {
+		rctx->sgs_copied = 0;
+		return 0;
+	}
+
+	total_in = ALIGN(rctx->total_in, rctx->hw_blocksize);
+	pages = total_in ? get_order(total_in) : 1;
+	buf_in = (void *)__get_free_pages(GFP_ATOMIC, pages);
+
+	total_out = ALIGN(rctx->total_out, rctx->hw_blocksize);
+	pages = total_out ? get_order(total_out) : 1;
+	buf_out = (void *)__get_free_pages(GFP_ATOMIC, pages);
+
+	if (!buf_in || !buf_out) {
+		dev_err(rctx->sdev->dev, "Can't allocate pages when unaligned\n");
+		rctx->sgs_copied = 0;
+		return -EFAULT;
+	}
+
+	sg_copy_buf(buf_in, rctx->in_sg, 0, rctx->total_in, 0);
+
+	sg_init_one(&rctx->in_sgl, buf_in, total_in);
+	rctx->in_sg = &rctx->in_sgl;
+	rctx->in_sg_len = 1;
+
+	sg_init_one(&rctx->out_sgl, buf_out, total_out);
+	rctx->out_sg_save = rctx->out_sg;
+	rctx->out_sg = &rctx->out_sgl;
+	rctx->out_sg_len = 1;
+
+	rctx->sgs_copied = 1;
+
+	return 0;
+}
+
+static inline int is_ecb(struct starfive_sec_request_ctx *rctx)
+{
+	return (rctx->flags & FLG_MODE_MASK) == STARFIVE_AES_MODE_ECB;
+}
+
+static inline int is_cbc(struct starfive_sec_request_ctx *rctx)
+{
+	return (rctx->flags & FLG_MODE_MASK) == STARFIVE_AES_MODE_CBC;
+}
+
+static inline int is_ofb(struct starfive_sec_request_ctx *rctx)
+{
+	return (rctx->flags & FLG_MODE_MASK) == STARFIVE_AES_MODE_OFB;
+}
+
+static inline int is_cfb(struct starfive_sec_request_ctx *rctx)
+{
+	return (rctx->flags & FLG_MODE_MASK) == STARFIVE_AES_MODE_CFB;
+}
+
+static inline int is_ctr(struct starfive_sec_request_ctx *rctx)
+{
+	return (rctx->flags & FLG_MODE_MASK) == STARFIVE_AES_MODE_CTR;
+}
+
+static inline int is_gcm(struct starfive_sec_request_ctx *rctx)
+{
+	return (rctx->flags & FLG_MODE_MASK) == STARFIVE_AES_MODE_GCM;
+}
+
+static inline int is_ccm(struct starfive_sec_request_ctx *rctx)
+{
+	return (rctx->flags & FLG_MODE_MASK) == STARFIVE_AES_MODE_CCM;
+}
+
+static inline int get_aes_mode(struct starfive_sec_request_ctx *rctx)
+{
+	return rctx->flags & FLG_MODE_MASK;
+}
+
+static inline int is_encrypt(struct starfive_sec_request_ctx *rctx)
+{
+	return !!(rctx->flags & FLG_ENCRYPT);
+}
+
+static inline int is_decrypt(struct starfive_sec_request_ctx *rctx)
+{
+	return !is_encrypt(rctx);
+}
+
+static int starfive_cryp_read_auth_tag(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+	int loop, total_len, start_addr;
+
+	total_len = AES_BLOCK_SIZE / sizeof(u32);
+	start_addr = STARFIVE_AES_NONCE0;
+
+	if (starfive_aes_wait_busy(ctx))
+		return -EBUSY;
+
+	if (is_gcm(rctx))
+		for (loop = 0; loop < total_len; loop++, start_addr += 4)
+			rctx->tag_out[loop] = starfive_sec_read(sdev, start_addr);
+	else
+		for (loop = 0; loop < total_len; loop++)
+			rctx->tag_out[loop] = starfive_sec_read(sdev, STARFIVE_AES_AESDIO0R);
+
+	if (is_encrypt(rctx)) {
+		sg_copy_buffer(rctx->out_sg, sg_nents(rctx->out_sg), rctx->tag_out,
+			       rctx->authsize, rctx->offset, 0);
+	} else {
+		scatterwalk_map_and_copy(rctx->tag_in, rctx->in_sg,
+					 rctx->total_in_save - rctx->authsize,
+					 rctx->authsize, 0);
+
+		if (crypto_memneq(rctx->tag_in, rctx->tag_out, rctx->authsize))
+			return -EBADMSG;
+	}
+
+	return 0;
+}
+
+static inline void starfive_aes_reset(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+
+	rctx->csr.aes.v = 0;
+	rctx->csr.aes.aesrst = 1;
+	starfive_sec_write(ctx->sdev, STARFIVE_AES_CSR, rctx->csr.aes.v);
+}
+
+static inline void starfive_aes_xcm_start(struct starfive_sec_ctx *ctx, u32 hw_mode)
+{
+	unsigned int value;
+
+	switch (hw_mode) {
+	case STARFIVE_AES_MODE_GCM:
+		value = starfive_sec_read(ctx->sdev, STARFIVE_AES_CSR);
+		value |= STARFIVE_AES_GCM_START;
+		starfive_sec_write(ctx->sdev, STARFIVE_AES_CSR, value);
+		break;
+	case STARFIVE_AES_MODE_CCM:
+		value = starfive_sec_read(ctx->sdev, STARFIVE_AES_CSR);
+		value |= STARFIVE_AES_CCM_START;
+		starfive_sec_write(ctx->sdev, STARFIVE_AES_CSR, value);
+		break;
+	}
+}
+
+static inline void starfive_aes_setup(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+
+	rctx->csr.aes.v = 0;
+	switch (ctx->keylen) {
+	case AES_KEYSIZE_128:
+		rctx->csr.aes.keymode = STARFIVE_AES_KEYMODE_128;
+		break;
+	case AES_KEYSIZE_192:
+		rctx->csr.aes.keymode = STARFIVE_AES_KEYMODE_192;
+		break;
+	case AES_KEYSIZE_256:
+		rctx->csr.aes.keymode = STARFIVE_AES_KEYMODE_256;
+		break;
+	default:
+		return;
+	}
+
+	rctx->csr.aes.mode  = rctx->flags & FLG_MODE_MASK;
+	rctx->csr.aes.cmode = is_decrypt(rctx);
+	rctx->csr.aes.stream_mode = rctx->stmode;
+
+	if (ctx->sdev->use_side_channel_mitigation) {
+		rctx->csr.aes.delay_aes = 1;
+		rctx->csr.aes.vaes_start = 1;
+	}
+
+	if (starfive_aes_wait_busy(ctx)) {
+		dev_err(ctx->sdev->dev, "reset error\n");
+		return;
+	}
+
+	starfive_sec_write(ctx->sdev, STARFIVE_AES_CSR, rctx->csr.aes.v);
+}
+
+static inline void starfive_aes_set_ivlen(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+
+	if (is_gcm(rctx))
+		starfive_sec_write(sdev, STARFIVE_AES_IVLEN, GCM_AES_IV_SIZE);
+	else
+		starfive_sec_write(sdev, STARFIVE_AES_IVLEN, AES_BLOCK_SIZE);
+}
+
+static inline void starfive_aes_set_alen(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_dev *sdev = ctx->sdev;
+
+	starfive_sec_write(sdev, STARFIVE_AES_ALEN0, upper_32_bits(ctx->rctx->assoclen));
+	starfive_sec_write(sdev, STARFIVE_AES_ALEN1, lower_32_bits(ctx->rctx->assoclen));
+}
+
+static unsigned int starfive_cryp_get_input_text_len(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+
+	return is_encrypt(rctx) ? rctx->req.areq->cryptlen :
+				  rctx->req.areq->cryptlen - rctx->authsize;
+}
+
+static inline void starfive_aes_set_mlen(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	size_t data_len;
+
+	data_len = starfive_cryp_get_input_text_len(ctx);
+
+	starfive_sec_write(sdev, STARFIVE_AES_MLEN0, upper_32_bits(data_len));
+	starfive_sec_write(sdev, STARFIVE_AES_MLEN1, lower_32_bits(data_len));
+}
+
+static inline int crypto_ccm_check_iv(const u8 *iv)
+{
+	/* 2 <= L <= 8, so 1 <= L' <= 7. */
+	if (iv[0] < 1 || iv[0] > 7)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int starfive_cryp_hw_write_iv(struct starfive_sec_ctx *ctx, u32 *iv)
+{
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+
+	if (!iv)
+		return -EINVAL;
+
+	starfive_sec_write(sdev, STARFIVE_AES_IV0, iv[0]);
+	starfive_sec_write(sdev, STARFIVE_AES_IV1, iv[1]);
+	starfive_sec_write(sdev, STARFIVE_AES_IV2, iv[2]);
+
+	if (!is_gcm(rctx))
+		starfive_sec_write(sdev, STARFIVE_AES_IV3, iv[3]);
+	else
+		if (starfive_aes_wait_gcmdone(ctx))
+			return -ETIMEDOUT;
+
+	return 0;
+}
+
+static void starfive_cryp_hw_get_iv(struct starfive_sec_ctx *ctx, u32 *iv)
+{
+	struct starfive_sec_dev *sdev = ctx->sdev;
+
+	if (!iv)
+		return;
+
+	iv[0] = starfive_sec_read(sdev, STARFIVE_AES_IV0);
+	iv[1] = starfive_sec_read(sdev, STARFIVE_AES_IV1);
+	iv[2] = starfive_sec_read(sdev, STARFIVE_AES_IV2);
+	iv[3] = starfive_sec_read(sdev, STARFIVE_AES_IV3);
+}
+
+static void starfive_cryp_hw_write_ctr(struct starfive_sec_ctx *ctx, u32 *ctr)
+{
+	struct starfive_sec_dev *sdev = ctx->sdev;
+
+	starfive_sec_write(sdev, STARFIVE_AES_NONCE0, ctr[0]);
+	starfive_sec_write(sdev, STARFIVE_AES_NONCE1, ctr[1]);
+	starfive_sec_write(sdev, STARFIVE_AES_NONCE2, ctr[2]);
+	starfive_sec_write(sdev, STARFIVE_AES_NONCE3, ctr[3]);
+}
+
+static int starfive_cryp_hw_write_key(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	u32 *key = (u32 *)ctx->key;
+
+	switch (ctx->keylen) {
+	case AES_KEYSIZE_256:
+	case AES_KEYSIZE_192:
+	case AES_KEYSIZE_128:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ctx->keylen >= AES_KEYSIZE_128) {
+		starfive_sec_write(sdev, STARFIVE_AES_KEY0, key[0]);
+		starfive_sec_write(sdev, STARFIVE_AES_KEY1, key[1]);
+		starfive_sec_write(sdev, STARFIVE_AES_KEY2, key[2]);
+		starfive_sec_write(sdev, STARFIVE_AES_KEY3, key[3]);
+	}
+
+	if (ctx->keylen >= AES_KEYSIZE_192) {
+		starfive_sec_write(sdev, STARFIVE_AES_KEY4, key[4]);
+		starfive_sec_write(sdev, STARFIVE_AES_KEY5, key[5]);
+	}
+
+	if (ctx->keylen >= AES_KEYSIZE_256) {
+		starfive_sec_write(sdev, STARFIVE_AES_KEY6, key[6]);
+		starfive_sec_write(sdev, STARFIVE_AES_KEY7, key[7]);
+	}
+
+	if (starfive_aes_wait_keydone(ctx))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int starfive_cryp_gcm_init(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+
+	memcpy(rctx->ctr, rctx->req.areq->iv, 12);
+
+	return starfive_cryp_hw_write_iv(ctx, (u32 *)rctx->ctr);
+}
+
+static void starfive_cryp_ccm_init(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+	u8 iv[AES_BLOCK_SIZE], *b0;
+	unsigned int textlen;
+
+	memcpy(iv, rctx->req.areq->iv, AES_BLOCK_SIZE);
+	memset(iv + AES_BLOCK_SIZE - 1 - iv[0], 0, iv[0] + 1);
+
+	/* Build B0 */
+	b0 = (u8 *)sdev->aes_data;
+	memcpy(b0, iv, AES_BLOCK_SIZE);
+
+	b0[0] |= (8 * ((rctx->authsize - 2) / 2));
+
+	if (rctx->req.areq->assoclen)
+		b0[0] |= CCM_B0_ADATA;
+
+	textlen = starfive_cryp_get_input_text_len(ctx);
+
+	b0[AES_BLOCK_SIZE - 2] = textlen >> 8;
+	b0[AES_BLOCK_SIZE - 1] = textlen & 0xFF;
+
+	memcpy((void *)rctx->ctr, sdev->aes_data, AES_BLOCK_SIZE);
+	starfive_cryp_hw_write_ctr(ctx, (u32 *)b0);
+}
+
+static int starfive_cryp_hw_init(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+	int ret;
+	u32 hw_mode;
+
+	starfive_aes_reset(ctx);
+
+	hw_mode = get_aes_mode(ctx->rctx);
+	if (hw_mode == STARFIVE_AES_MODE_CFB ||
+	    hw_mode == STARFIVE_AES_MODE_OFB)
+		rctx->stmode = STARFIVE_AES_MODE_XFB_128;
+	else
+		rctx->stmode = STARFIVE_AES_MODE_XFB_1;
+
+	starfive_aes_setup(ctx);
+
+	ret = starfive_cryp_hw_write_key(ctx);
+	if (ret)
+		return ret;
+
+	switch (hw_mode) {
+	case STARFIVE_AES_MODE_GCM:
+		memset(ctx->sdev->aes_data, 0, STARFIVE_MSG_BUFFER_SIZE);
+		starfive_aes_set_alen(ctx);
+		starfive_aes_set_mlen(ctx);
+		starfive_aes_set_ivlen(ctx);
+		starfive_aes_xcm_start(ctx, hw_mode);
+
+		if (starfive_aes_wait_gcmdone(ctx))
+			return -ETIMEDOUT;
+
+		memset((void *)rctx->ctr, 0, sizeof(rctx->ctr));
+		ret = starfive_cryp_gcm_init(ctx);
+		break;
+	case STARFIVE_AES_MODE_CCM:
+		memset(ctx->sdev->aes_data, 0, STARFIVE_MSG_BUFFER_SIZE);
+		memset((void *)rctx->ctr, 0, sizeof(rctx->ctr));
+
+		starfive_aes_set_alen(ctx);
+		starfive_aes_set_mlen(ctx);
+		starfive_cryp_ccm_init(ctx);
+		starfive_aes_xcm_start(ctx, hw_mode);
+		break;
+	case STARFIVE_AES_MODE_OFB:
+	case STARFIVE_AES_MODE_CFB:
+	case STARFIVE_AES_MODE_CBC:
+	case STARFIVE_AES_MODE_CTR:
+		ret = starfive_cryp_hw_write_iv(ctx, (void *)rctx->req.sreq->iv);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int starfive_cryp_get_from_sg(struct starfive_sec_request_ctx *rctx,
+				     size_t offset, size_t count,
+				     size_t data_offset)
+{
+	size_t of, ct, index;
+	struct scatterlist *sg = rctx->in_sg;
+
+	of = offset;
+	ct = count;
+	while (sg->length <= of) {
+		of -= sg->length;
+
+		if (!sg_is_last(sg)) {
+			sg = sg_next(sg);
+			continue;
+		} else {
+			return -EBADE;
+		}
+	}
+
+	index = data_offset;
+	while (ct > 0) {
+		if (sg->length - of >= ct) {
+			scatterwalk_map_and_copy(rctx->sdev->aes_data + index, sg,
+						 of, ct, 0);
+			index = index + ct;
+			return index - data_offset;
+		}
+		scatterwalk_map_and_copy(rctx->sdev->aes_data + index, sg,
+					 of, sg->length - of, 0);
+		index += sg->length - of;
+		ct = ct - (sg->length - of);
+
+		of = 0;
+
+		if (!sg_is_last(sg))
+			sg = sg_next(sg);
+		else
+			return -EBADE;
+	}
+
+	return index - data_offset;
+}
+
+static void starfive_cryp_finish_req(struct starfive_sec_ctx *ctx, int err)
+{
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+
+	if (!err && (is_gcm(rctx) || is_ccm(rctx))) {
+		/* Phase 4 : output tag */
+		err = starfive_cryp_read_auth_tag(ctx);
+	}
+
+	if (!err && (is_cbc(rctx) || is_ctr(rctx)))
+		starfive_cryp_hw_get_iv(ctx, (void *)rctx->req.sreq->iv);
+
+	if (rctx->sgs_copied) {
+		void *buf_in, *buf_out;
+		int pages, len;
+
+		buf_in = sg_virt(&rctx->in_sgl);
+		buf_out = sg_virt(&rctx->out_sgl);
+
+		sg_copy_buf(buf_out, rctx->out_sg_save, 0,
+			    rctx->total_out_save, 1);
+
+		len = ALIGN(rctx->total_in_save, rctx->hw_blocksize);
+		pages = len ? get_order(len) : 1;
+		free_pages((unsigned long)buf_in, pages);
+
+		len = ALIGN(rctx->total_out_save, rctx->hw_blocksize);
+		pages = len ? get_order(len) : 1;
+		free_pages((unsigned long)buf_out, pages);
+	}
+
+	if (is_gcm(rctx) || is_ccm(rctx))
+		crypto_finalize_aead_request(ctx->sdev->engine, rctx->req.areq, err);
+	else
+		crypto_finalize_skcipher_request(ctx->sdev->engine, rctx->req.sreq,
+						 err);
+
+	memset(ctx->key, 0, ctx->keylen);
+}
+
+static bool starfive_check_counter_overflow(struct starfive_sec_ctx *ctx, size_t count)
+{
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+	bool ret = false;
+	u32 start, end, ctr, blocks;
+
+	if (count) {
+		blocks = DIV_ROUND_UP(count, AES_BLOCK_SIZE);
+		rctx->ctr[3] = cpu_to_be32(be32_to_cpu(rctx->ctr[3]) + blocks);
+
+		if (rctx->ctr[3] == 0) {
+			rctx->ctr[2] = cpu_to_be32(be32_to_cpu(rctx->ctr[2]) + 1);
+			if (rctx->ctr[2] == 0) {
+				rctx->ctr[1] = cpu_to_be32(be32_to_cpu(rctx->ctr[1]) + 1);
+				if (rctx->ctr[1] == 0) {
+					rctx->ctr[0] = cpu_to_be32(be32_to_cpu(rctx->ctr[0]) + 1);
+					if (rctx->ctr[1] == 0)
+						starfive_cryp_hw_write_ctr(ctx, (u32 *)rctx->ctr);
+				}
+			}
+		}
+	}
+
+	/* ctr counter overflow. */
+	ctr = rctx->total_in - rctx->assoclen - rctx->authsize;
+	blocks = DIV_ROUND_UP(ctr, AES_BLOCK_SIZE);
+	start = be32_to_cpu(rctx->ctr[3]);
+
+	end = start + blocks - 1;
+	if (end < start) {
+		rctx->ctr_over_count = AES_BLOCK_SIZE * -start;
+		ret = true;
+	}
+
+	return ret;
+}
+
+static void starfive_aes_dma_callback(void *param)
+{
+	struct starfive_sec_dev *sdev = param;
+
+	complete(&sdev->sec_comp_p);
+}
+
+static int starfive_cryp_write_out_dma(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	struct dma_async_tx_descriptor	*in_desc, *out_desc;
+	union  starfive_alg_cr		alg_cr;
+	dma_cookie_t cookie;
+	unsigned int  *out;
+	int total_len;
+	int err;
+	int loop;
+
+	total_len = rctx->bufcnt;
+
+	alg_cr.v = 0;
+	alg_cr.start = 1;
+	alg_cr.aes_dma_en = 1;
+	starfive_sec_write(sdev, STARFIVE_ALG_CR_OFFSET, alg_cr.v);
+
+	total_len = (total_len & 0xf) ? (((total_len >> 4) + 1) << 4) : total_len;
+
+	starfive_sec_write(sdev, STARFIVE_DMA_IN_LEN_OFFSET, total_len);
+	starfive_sec_write(sdev, STARFIVE_DMA_OUT_LEN_OFFSET, total_len);
+
+	sg_init_table(&ctx->sg[0], 1);
+	sg_set_buf(&ctx->sg[0], sdev->aes_data, total_len);
+	sg_dma_address(&ctx->sg[0]) = phys_to_dma(sdev->dev, (unsigned long long)(sdev->aes_data));
+	sg_dma_len(&ctx->sg[0]) = total_len;
+
+	sg_init_table(&ctx->sg[1], 1);
+	sg_set_buf(&ctx->sg[1], sdev->aes_data + (STARFIVE_MSG_BUFFER_SIZE >> 1), total_len);
+	sg_dma_address(&ctx->sg[1]) = phys_to_dma(sdev->dev,
+						  (unsigned long long)(sdev->aes_data +
+						  (STARFIVE_MSG_BUFFER_SIZE >> 1)));
+	sg_dma_len(&ctx->sg[1]) = total_len;
+
+	err = dma_map_sg(sdev->dev, &ctx->sg[0], 1, DMA_TO_DEVICE);
+	if (!err) {
+		dev_err(sdev->dev, "Error: dma_map_sg() DMA_TO_DEVICE\n");
+		return -EINVAL;
+	}
+
+	err = dma_map_sg(sdev->dev, &ctx->sg[1], 1, DMA_FROM_DEVICE);
+	if (!err) {
+		dev_err(sdev->dev, "Error: dma_map_sg() DMA_FROM_DEVICE\n");
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
+	sdev->cfg_out.direction = DMA_DEV_TO_MEM;
+	sdev->cfg_out.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	sdev->cfg_out.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	sdev->cfg_out.src_maxburst = 4;
+	sdev->cfg_out.dst_maxburst = 4;
+	sdev->cfg_out.src_addr = sdev->io_phys_base + STARFIVE_ALG_FIFO_OFFSET;
+
+	dmaengine_slave_config(sdev->sec_xm_p, &sdev->cfg_out);
+
+	in_desc = dmaengine_prep_slave_sg(sdev->sec_xm_m, &ctx->sg[0],
+					  1, DMA_MEM_TO_DEV,
+					  DMA_PREP_INTERRUPT  |  DMA_CTRL_ACK);
+	if (!in_desc)
+		return -EINVAL;
+
+	cookie = dmaengine_submit(in_desc);
+	dma_async_issue_pending(sdev->sec_xm_m);
+
+	out_desc = dmaengine_prep_slave_sg(sdev->sec_xm_p, &ctx->sg[1],
+					   1, DMA_DEV_TO_MEM,
+					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!out_desc)
+		return -EINVAL;
+
+	reinit_completion(&sdev->sec_comp_p);
+
+	out_desc->callback = starfive_aes_dma_callback;
+	out_desc->callback_param = sdev;
+
+	dmaengine_submit(out_desc);
+	dma_async_issue_pending(sdev->sec_xm_p);
+
+	if (!wait_for_completion_timeout(&sdev->sec_comp_p, msecs_to_jiffies(10000))) {
+		alg_cr.v = 0;
+		alg_cr.clear = 1;
+
+		starfive_sec_write(sdev, STARFIVE_ALG_CR_OFFSET, alg_cr.v);
+
+		dev_err(sdev->dev, "wait_for_completion_timeout error, cookie = %x\n",
+			dma_async_is_tx_complete(sdev->sec_xm_p, cookie,
+						 NULL, NULL));
+	}
+
+	out = (unsigned int *)(sdev->aes_data + (STARFIVE_MSG_BUFFER_SIZE >> 1));
+
+	for (loop = 0; loop < total_len / 4; loop++)
+		dev_dbg(sdev->dev, "this is debug [%d] = %x\n", loop, out[loop]);
+
+	sg_copy_buffer(rctx->out_sg, sg_nents(rctx->out_sg), out,
+		       total_len, rctx->offset, 0);
+
+	dma_unmap_sg(sdev->dev, &ctx->sg[0], 1, DMA_TO_DEVICE);
+	dma_unmap_sg(sdev->dev, &ctx->sg[1], 1, DMA_FROM_DEVICE);
+
+	alg_cr.v = 0;
+	alg_cr.clear = 1;
+
+	starfive_sec_write(sdev, STARFIVE_ALG_CR_OFFSET, alg_cr.v);
+
+	return 0;
+}
+
+static int starfive_cryp_write_out_cpu(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+	unsigned int  *buffer, *out;
+	int total_len, loop, count;
+
+	total_len = rctx->bufcnt;
+	buffer = (unsigned int *)sdev->aes_data;
+	out = (unsigned int *)(sdev->aes_data + (STARFIVE_MSG_BUFFER_SIZE >> 1));
+
+	while (total_len > 0) {
+		for (loop = 0; loop < 4; loop++, buffer++)
+			starfive_sec_write(sdev, STARFIVE_AES_AESDIO0R, *buffer);
+
+		if (starfive_aes_wait_busy(ctx)) {
+			dev_err(sdev->dev, "Error: timeout processing input text\n");
+			return -ETIMEDOUT;
+		}
+
+		for (loop = 0; loop < 4; loop++, out++)
+			*out = starfive_sec_read(sdev, STARFIVE_AES_AESDIO0R);
+
+		total_len -= 16;
+	}
+
+	if (rctx->bufcnt >= rctx->total_out)
+		count = rctx->total_out;
+	else
+		count = rctx->bufcnt;
+
+	out = (unsigned int *)(sdev->aes_data + (STARFIVE_MSG_BUFFER_SIZE >> 1));
+
+	sg_copy_buffer(rctx->out_sg, sg_nents(rctx->out_sg), out,
+		       count, rctx->offset, 0);
+
+	return 0;
+}
+
+static int starfive_cryp_write_data(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+	size_t data_len, total, count, data_buf_len, data_offset;
+	int ret;
+	bool fragmented = false;
+
+	/* ctr counter overflow. */
+	fragmented = starfive_check_counter_overflow(ctx, 0);
+
+	total = 0;
+	rctx->offset = 0;
+	rctx->data_offset = 0;
+
+	data_offset = rctx->data_offset;
+	while (total < rctx->total_in) {
+		data_buf_len = sdev->data_buf_len -
+			(sdev->data_buf_len % ctx->keylen) - data_offset;
+		count = min(rctx->total_in - rctx->offset, data_buf_len);
+
+		/* ctr counter overflow. */
+		if (fragmented && rctx->ctr_over_count != 0) {
+			if (count >= rctx->ctr_over_count)
+				count = rctx->ctr_over_count;
+		}
+
+		data_len = starfive_cryp_get_from_sg(rctx, rctx->offset, count, data_offset);
+
+		if (data_len < 0)
+			return data_len;
+		if (data_len != count)
+			return -EINVAL;
+
+		rctx->bufcnt = data_len + data_offset;
+		total += data_len;
+
+		if (!is_encrypt(rctx) && (total + rctx->assoclen >= rctx->total_in))
+			rctx->bufcnt = rctx->bufcnt - rctx->authsize;
+
+		if (rctx->bufcnt) {
+			if (sdev->use_dma)
+				ret = starfive_cryp_write_out_dma(ctx);
+			else
+				ret = starfive_cryp_write_out_cpu(ctx);
+
+			if (ret)
+				return ret;
+		}
+
+		data_offset = 0;
+		rctx->offset += data_len;
+		fragmented = starfive_check_counter_overflow(ctx, data_len);
+	}
+
+	return ret;
+}
+
+static int starfive_cryp_gcm_write_aad(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+	unsigned int *buffer;
+	int total_len, loop;
+
+	if (rctx->assoclen) {
+		total_len = rctx->assoclen;
+		total_len = (total_len & 0xf) ? (((total_len >> 4) + 1) << 2) : (total_len >> 2);
+	}
+
+	buffer = (unsigned int *)sdev->aes_data;
+
+	for (loop = 0; loop < total_len; loop += 4) {
+		starfive_sec_write(sdev, STARFIVE_AES_NONCE0, *buffer);
+		buffer++;
+		starfive_sec_write(sdev, STARFIVE_AES_NONCE1, *buffer);
+		buffer++;
+		starfive_sec_write(sdev, STARFIVE_AES_NONCE2, *buffer);
+		buffer++;
+		starfive_sec_write(sdev, STARFIVE_AES_NONCE3, *buffer);
+		buffer++;
+		udelay(2);
+	}
+
+	if (starfive_aes_wait_gcmdone(ctx))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int starfive_cryp_ccm_write_aad(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+	unsigned int  *buffer, *out;
+	unsigned char *ci;
+	int total_len, mlen, loop;
+
+	total_len = rctx->bufcnt;
+	buffer = (unsigned int *)sdev->aes_data;
+	out = (unsigned int *)(sdev->aes_data + (STARFIVE_MSG_BUFFER_SIZE >> 1));
+
+	ci = (unsigned char *)buffer;
+	starfive_sec_writeb(sdev, STARFIVE_AES_AESDIO0R, *ci);
+	ci++;
+	starfive_sec_writeb(sdev, STARFIVE_AES_AESDIO0R, *ci);
+	ci++;
+	total_len -= 2;
+	buffer = (unsigned int *)ci;
+
+	for (loop = 0; loop < 3; loop++, buffer++)
+		starfive_sec_write(sdev, STARFIVE_AES_AESDIO0R, *buffer);
+
+	if (starfive_aes_wait_busy(ctx)) {
+		dev_err(sdev->dev, "Error: timeout processing first AAD block\n");
+		return -ETIMEDOUT;
+	}
+
+	total_len -= 12;
+
+	while (total_len >= 16) {
+		for (loop = 0; loop < 4; loop++, buffer++)
+			starfive_sec_write(sdev, STARFIVE_AES_AESDIO0R, *buffer);
+
+		if (starfive_aes_wait_busy(ctx)) {
+			dev_err(sdev->dev, "Error: timeout processing consecutive AAD block\n");
+			return -ETIMEDOUT;
+		}
+
+		total_len -= 16;
+	}
+
+	if (total_len > 0) {
+		mlen = total_len;
+		for (; total_len >= 4; total_len -= 4, buffer++)
+			starfive_sec_write(sdev, STARFIVE_AES_AESDIO0R, *buffer);
+
+		ci = (unsigned char *)buffer;
+		for (; total_len > 0; total_len--, ci++)
+			starfive_sec_writeb(sdev, STARFIVE_AES_AESDIO0R, *ci);
+
+		if (starfive_aes_wait_busy(ctx)) {
+			dev_err(sdev->dev, "Error: timeout processing final AAD block\n");
+			return -ETIMEDOUT;
+		}
+	}
+
+	return 0;
+}
+
+static int starfive_cryp_xcm_write_data(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+	size_t data_len, total, count, data_buf_len, offset, auths;
+	int ret;
+	bool fragmented = false;
+
+	/* ctr counter overflow. */
+	fragmented = starfive_check_counter_overflow(ctx, 0);
+
+	total = 0;
+	rctx->offset = 0;
+	rctx->data_offset = 0;
+	offset = 0;
+
+	while (total < rctx->assoclen) {
+		data_buf_len = sdev->data_buf_len - (sdev->data_buf_len % ctx->keylen);
+		count = min(rctx->assoclen - offset, data_buf_len);
+		count = min(count, rctx->assoclen - total);
+		data_len = starfive_cryp_get_from_sg(rctx, offset, count, 0);
+		if (data_len < 0)
+			return data_len;
+		if (data_len != count)
+			return -EINVAL;
+
+		offset += data_len;
+		rctx->offset += data_len;
+		if ((data_len + 2) & 0xF) {
+			memset(sdev->aes_data + data_len, 0, 16 - ((data_len + 2) & 0xf));
+			data_len += 16 - ((data_len + 2) & 0xf);
+		}
+
+		rctx->bufcnt = data_len;
+		total += data_len;
+
+		if (is_ccm(rctx))
+			ret = starfive_cryp_ccm_write_aad(ctx);
+		else
+			ret = starfive_cryp_gcm_write_aad(ctx);
+
+		if (ret)
+			return ret;
+	}
+
+	total = 0;
+	auths = 0;
+
+	while (total + auths < rctx->total_in - rctx->assoclen) {
+		data_buf_len = sdev->data_buf_len - (sdev->data_buf_len % ctx->keylen);
+		count = min(rctx->total_in - rctx->offset, data_buf_len);
+
+		if (is_encrypt(rctx)) {
+			count = min(count, rctx->total_in - rctx->assoclen - total);
+		} else {
+			count = min(count,
+				    rctx->total_in - rctx->assoclen - total - rctx->authsize);
+			auths = rctx->authsize;
+		}
+
+		/* ctr counter overflow. */
+		if (fragmented && rctx->ctr_over_count != 0) {
+			if (count >= rctx->ctr_over_count)
+				count = rctx->ctr_over_count;
+		}
+
+		data_len = starfive_cryp_get_from_sg(rctx, rctx->offset, count, 0);
+
+		if (data_len < 0)
+			return data_len;
+		if (data_len != count)
+			return -EINVAL;
+
+		if (data_len % STARFIVE_AES_IV_LEN) {
+			memset(sdev->aes_data + data_len, 0,
+			       STARFIVE_AES_IV_LEN - (data_len % STARFIVE_AES_IV_LEN));
+			data_len = data_len +
+				(STARFIVE_AES_IV_LEN - (data_len % STARFIVE_AES_IV_LEN));
+		}
+
+		rctx->bufcnt = data_len;
+		total += data_len;
+
+		if (rctx->bufcnt) {
+			if (sdev->use_dma)
+				ret = starfive_cryp_write_out_dma(ctx);
+			else
+				ret = starfive_cryp_write_out_cpu(ctx);
+		}
+
+		rctx->offset += count;
+		offset += count;
+
+		fragmented = starfive_check_counter_overflow(ctx, data_len);
+	}
+
+	return ret;
+}
+
+static int starfive_gcm_zero_message_data(struct starfive_sec_ctx *ctx)
+{
+	int ret;
+
+	ctx->rctx->bufcnt = 0;
+	ctx->rctx->offset = 0;
+	if (ctx->sdev->use_dma)
+		ret = starfive_cryp_write_out_dma(ctx);
+	else
+		ret = starfive_cryp_write_out_cpu(ctx);
+
+	return ret;
+}
+
+static int starfive_cryp_cpu_start(struct starfive_sec_ctx *ctx,
+				   struct starfive_sec_request_ctx *rctx)
+{
+	int ret;
+
+	ret = starfive_cryp_write_data(ctx);
+	if (ret)
+		return ret;
+
+	starfive_cryp_finish_req(ctx, ret);
+
+	return 0;
+}
+
+static int starfive_cryp_xcm_start(struct starfive_sec_ctx *ctx,
+				   struct starfive_sec_request_ctx *rctx)
+{
+	int ret;
+
+	mutex_lock(&ctx->sdev->lock);
+
+	ret = starfive_cryp_xcm_write_data(ctx);
+	if (ret)
+		return ret;
+
+	starfive_cryp_finish_req(ctx, ret);
+
+	mutex_unlock(&ctx->sdev->lock);
+
+	return 0;
+}
+
+static int starfive_cryp_cipher_one_req(struct crypto_engine *engine, void *areq)
+{
+	struct skcipher_request *req =
+		container_of(areq, struct skcipher_request, base);
+	struct starfive_sec_request_ctx *rctx = skcipher_request_ctx(req);
+	struct starfive_sec_ctx *ctx =
+		crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	int ret;
+
+	if (!sdev)
+		return -ENODEV;
+
+	mutex_lock(&sdev->lock);
+	ret = starfive_cryp_cpu_start(ctx, rctx);
+	mutex_unlock(&sdev->lock);
+
+	return ret;
+}
+
+static int starfive_cryp_prepare_req(struct skcipher_request *req,
+				     struct aead_request *areq)
+{
+	struct starfive_sec_ctx *ctx;
+	struct starfive_sec_dev *sdev;
+	struct starfive_sec_request_ctx *rctx;
+	int ret;
+
+	if (!req && !areq)
+		return -EINVAL;
+
+	ctx = req ? crypto_skcipher_ctx(crypto_skcipher_reqtfm(req)) :
+		    crypto_aead_ctx(crypto_aead_reqtfm(areq));
+
+	sdev = ctx->sdev;
+
+	if (!sdev)
+		return -ENODEV;
+
+	rctx = req ? skcipher_request_ctx(req) : aead_request_ctx(areq);
+
+	rctx->sdev = sdev;
+	ctx->rctx = rctx;
+	rctx->hw_blocksize = AES_BLOCK_SIZE;
+
+	if (req) {
+		rctx->req.sreq = req;
+		rctx->req_type = STARFIVE_ABLK_REQ;
+		rctx->total_in = req->cryptlen;
+		rctx->total_out = rctx->total_in;
+		rctx->authsize = 0;
+		rctx->assoclen = 0;
+	} else {
+		/*
+		 * Length of input and output data:
+		 * Encryption case:
+		 *  INPUT  =   AssocData  ||   PlainText
+		 *          <- assoclen ->  <- cryptlen ->
+		 *          <------- total_in ----------->
+		 *
+		 *  OUTPUT =   AssocData  ||  CipherText  ||   AuthTag
+		 *          <- assoclen ->  <- cryptlen ->  <- authsize ->
+		 *          <---------------- total_out ----------------->
+		 *
+		 * Decryption case:
+		 *  INPUT  =   AssocData  ||  CipherText  ||  AuthTag
+		 *          <- assoclen ->  <--------- cryptlen --------->
+		 *                                          <- authsize ->
+		 *          <---------------- total_in ------------------>
+		 *
+		 *  OUTPUT =   AssocData  ||   PlainText
+		 *          <- assoclen ->  <- crypten - authsize ->
+		 *          <---------- total_out ----------------->
+		 */
+		rctx->req.areq = areq;
+		rctx->req_type = STARFIVE_AEAD_REQ;
+		rctx->authsize = crypto_aead_authsize(crypto_aead_reqtfm(areq));
+		rctx->total_in = areq->assoclen + areq->cryptlen;
+		rctx->assoclen = areq->assoclen;
+		if (is_encrypt(rctx))
+			/* Append auth tag to output */
+			rctx->total_out = rctx->total_in + rctx->authsize;
+		else
+			/* No auth tag in output */
+			rctx->total_out = rctx->total_in - rctx->authsize;
+	}
+
+	rctx->total_in_save = rctx->total_in;
+	rctx->total_out_save = rctx->total_out;
+
+	rctx->in_sg = req ? req->src : areq->src;
+	rctx->out_sg = req ? req->dst : areq->dst;
+	rctx->out_sg_save = rctx->out_sg;
+
+	rctx->in_sg_len = sg_nents_for_len(rctx->in_sg, rctx->total_in);
+	if (rctx->in_sg_len < 0) {
+		dev_err(sdev->dev, "Cannot get in_sg_len\n");
+		ret = rctx->in_sg_len;
+		return ret;
+	}
+
+	rctx->out_sg_len = sg_nents_for_len(rctx->out_sg, rctx->total_out);
+	if (rctx->out_sg_len < 0) {
+		dev_err(sdev->dev, "Cannot get out_sg_len\n");
+		ret = rctx->out_sg_len;
+		return ret;
+	}
+
+	ret = starfive_cryp_copy_sgs(rctx);
+	if (ret)
+		return ret;
+
+	return starfive_cryp_hw_init(ctx);
+}
+
+static int starfive_cryp_prepare_cipher_req(struct crypto_engine *engine,
+					    void *areq)
+{
+	struct skcipher_request *req =
+		container_of(areq, struct skcipher_request, base);
+
+	return starfive_cryp_prepare_req(req, NULL);
+}
+
+static int starfive_cryp_cra_init(struct crypto_skcipher *tfm)
+{
+	struct starfive_sec_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	ctx->sdev = starfive_sec_find_dev(ctx);
+	if (!ctx->sdev)
+		return -ENODEV;
+
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct starfive_sec_request_ctx));
+
+	ctx->enginectx.op.do_one_request = starfive_cryp_cipher_one_req;
+	ctx->enginectx.op.prepare_request = starfive_cryp_prepare_cipher_req;
+	ctx->enginectx.op.unprepare_request = NULL;
+
+	return 0;
+}
+
+static void starfive_cryp_cra_exit(struct crypto_skcipher *tfm)
+{
+	struct starfive_sec_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	ctx->enginectx.op.do_one_request = NULL;
+	ctx->enginectx.op.prepare_request = NULL;
+	ctx->enginectx.op.unprepare_request = NULL;
+}
+
+static int starfive_cryp_aead_one_req(struct crypto_engine *engine, void *areq)
+{
+	struct aead_request *req =
+		container_of(areq, struct aead_request, base);
+	struct starfive_sec_request_ctx *rctx = aead_request_ctx(req);
+	struct starfive_sec_ctx *ctx = crypto_aead_ctx(crypto_aead_reqtfm(req));
+	struct starfive_sec_dev *sdev = ctx->sdev;
+
+	if (!sdev)
+		return -ENODEV;
+
+	if (unlikely(!rctx->req.areq->assoclen &&
+		     !starfive_cryp_get_input_text_len(ctx))) {
+		/* No input data to process: get tag and finish */
+		mutex_lock(&ctx->sdev->lock);
+
+		starfive_gcm_zero_message_data(ctx);
+		starfive_cryp_finish_req(ctx, 0);
+
+		mutex_unlock(&ctx->sdev->lock);
+
+		return 0;
+	}
+
+	return starfive_cryp_xcm_start(ctx, rctx);
+}
+
+static int starfive_cryp_prepare_aead_req(struct crypto_engine *engine, void *areq)
+{
+	struct aead_request *req = container_of(areq, struct aead_request,
+						base);
+
+	return starfive_cryp_prepare_req(NULL, req);
+}
+
+static int starfive_cryp_aes_aead_init(struct crypto_aead *tfm)
+{
+	struct starfive_sec_ctx *ctx = crypto_aead_ctx(tfm);
+	struct crypto_tfm *aead = crypto_aead_tfm(tfm);
+	struct crypto_alg *alg = aead->__crt_alg;
+	struct starfive_sec_dev *sdev = ctx->sdev;
+
+	ctx->sdev = starfive_sec_find_dev(ctx);
+
+	if (!ctx->sdev)
+		return -ENODEV;
+
+	crypto_aead_set_reqsize(tfm, sizeof(struct starfive_sec_request_ctx));
+
+	if (alg->cra_flags & CRYPTO_ALG_NEED_FALLBACK) {
+		ctx->fallback.aead =
+			crypto_alloc_aead(alg->cra_name, 0,
+					  CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK);
+		if (IS_ERR(ctx->fallback.aead)) {
+			dev_err(sdev->dev, "%s() failed to allocate fallback for %s\n",
+				__func__, alg->cra_name);
+			return PTR_ERR(ctx->fallback.aead);
+		}
+	}
+
+	ctx->enginectx.op.do_one_request = starfive_cryp_aead_one_req;
+	ctx->enginectx.op.prepare_request = starfive_cryp_prepare_aead_req;
+	ctx->enginectx.op.unprepare_request = NULL;
+
+	return 0;
+}
+
+static void starfive_cryp_aes_aead_exit(struct crypto_aead *tfm)
+{
+	struct starfive_sec_ctx *ctx = crypto_aead_ctx(tfm);
+
+	if (ctx->fallback.aead) {
+		crypto_free_aead(ctx->fallback.aead);
+		ctx->fallback.aead = NULL;
+	}
+
+	ctx->enginectx.op.do_one_request = NULL;
+	ctx->enginectx.op.prepare_request = NULL;
+	ctx->enginectx.op.unprepare_request = NULL;
+}
+
+static int starfive_cryp_crypt(struct skcipher_request *req, unsigned long flags)
+{
+	struct starfive_sec_ctx *ctx =
+		crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct starfive_sec_request_ctx *rctx = skcipher_request_ctx(req);
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	unsigned int blocksize_align = crypto_skcipher_blocksize(tfm) - 1;
+
+	if (!sdev)
+		return -ENODEV;
+
+	rctx->flags = flags;
+	rctx->req_type = STARFIVE_ABLK_REQ;
+
+	if (is_ecb(rctx) || is_cbc(rctx))
+		if (req->cryptlen & (blocksize_align))
+			return -EINVAL;
+
+	return crypto_transfer_skcipher_request_to_engine(sdev->engine, req);
+}
+
+static int aead_do_fallback(struct aead_request *req)
+{
+	struct aead_request *subreq = aead_request_ctx(req);
+	struct crypto_aead *aead = crypto_aead_reqtfm(req);
+	struct starfive_sec_ctx *ctx = crypto_aead_ctx(aead);
+
+	aead_request_set_tfm(subreq, ctx->fallback.aead);
+	aead_request_set_callback(subreq, req->base.flags,
+				  req->base.complete, req->base.data);
+	aead_request_set_crypt(subreq, req->src,
+			       req->dst, req->cryptlen, req->iv);
+	aead_request_set_ad(subreq, req->assoclen);
+
+	return crypto_aead_decrypt(subreq);
+}
+
+static int starfive_cryp_aead_crypt(struct aead_request *req, unsigned long flags)
+{
+	struct starfive_sec_ctx *ctx = crypto_aead_ctx(crypto_aead_reqtfm(req));
+	struct starfive_sec_request_ctx *rctx = aead_request_ctx(req);
+	struct starfive_sec_dev *sdev = ctx->sdev;
+
+	if (!sdev)
+		return -ENODEV;
+
+	rctx->flags = flags;
+	rctx->req_type = STARFIVE_AEAD_REQ;
+
+	/* HW engine could not perform tag verification on
+	 * non-blocksize aligned ciphertext, use fallback algo instead
+	 */
+	if (ctx->fallback.aead && is_decrypt(rctx))
+		return aead_do_fallback(req);
+
+	return crypto_transfer_aead_request_to_engine(sdev->engine, req);
+}
+
+static int starfive_cryp_setkey(struct crypto_skcipher *tfm, const u8 *key,
+				unsigned int keylen)
+{
+	struct starfive_sec_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	memcpy(ctx->key, key, keylen);
+	ctx->keylen = keylen;
+
+	return 0;
+}
+
+static int starfive_cryp_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
+				    unsigned int keylen)
+{
+	if (!key || !keylen)
+		return -EINVAL;
+
+	if (keylen != AES_KEYSIZE_128 &&
+	    keylen != AES_KEYSIZE_192 &&
+	    keylen != AES_KEYSIZE_256)
+		return -EINVAL;
+	else
+		return starfive_cryp_setkey(tfm, key, keylen);
+}
+
+static int starfive_cryp_aes_aead_setkey(struct crypto_aead *tfm, const u8 *key,
+					 unsigned int keylen)
+{
+	struct starfive_sec_ctx *ctx = crypto_aead_ctx(tfm);
+	int ret = 0;
+
+	if (!key || !keylen)
+		return -EINVAL;
+
+	if (keylen != AES_KEYSIZE_128 && keylen != AES_KEYSIZE_192 &&
+	    keylen != AES_KEYSIZE_256) {
+		return -EINVAL;
+	}
+
+	memcpy(ctx->key, key, keylen);
+	ctx->keylen = keylen;
+
+	if (ctx->fallback.aead)
+		ret = crypto_aead_setkey(ctx->fallback.aead, key, keylen);
+
+	return ret;
+}
+
+static int starfive_cryp_aes_gcm_setauthsize(struct crypto_aead *tfm,
+					     unsigned int authsize)
+{
+	struct starfive_sec_ctx *ctx = crypto_aead_ctx(tfm);
+
+	tfm->authsize = authsize;
+
+	if (ctx->fallback.aead)
+		ctx->fallback.aead->authsize = authsize;
+
+	return crypto_gcm_check_authsize(authsize);
+}
+
+static int starfive_cryp_aes_ccm_setauthsize(struct crypto_aead *tfm,
+					     unsigned int authsize)
+{
+	struct starfive_sec_ctx *ctx = crypto_aead_ctx(tfm);
+
+	switch (authsize) {
+	case 4:
+	case 6:
+	case 8:
+	case 10:
+	case 12:
+	case 14:
+	case 16:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	tfm->authsize = authsize;
+
+	if (ctx->fallback.aead)
+		ctx->fallback.aead->authsize = authsize;
+
+	return 0;
+}
+
+static int starfive_cryp_aes_ecb_encrypt(struct skcipher_request *req)
+{
+	return starfive_cryp_crypt(req,  STARFIVE_AES_MODE_ECB | FLG_ENCRYPT);
+}
+
+static int starfive_cryp_aes_ecb_decrypt(struct skcipher_request *req)
+{
+	return starfive_cryp_crypt(req,  STARFIVE_AES_MODE_ECB);
+}
+
+static int starfive_cryp_aes_cbc_encrypt(struct skcipher_request *req)
+{
+	return starfive_cryp_crypt(req,  STARFIVE_AES_MODE_CBC | FLG_ENCRYPT);
+}
+
+static int starfive_cryp_aes_cbc_decrypt(struct skcipher_request *req)
+{
+	return starfive_cryp_crypt(req,  STARFIVE_AES_MODE_CBC);
+}
+
+static int starfive_cryp_aes_cfb_encrypt(struct skcipher_request *req)
+{
+	return starfive_cryp_crypt(req,  STARFIVE_AES_MODE_CFB | FLG_ENCRYPT);
+}
+
+static int starfive_cryp_aes_cfb_decrypt(struct skcipher_request *req)
+{
+	return starfive_cryp_crypt(req,  STARFIVE_AES_MODE_CFB);
+}
+
+static int starfive_cryp_aes_ofb_encrypt(struct skcipher_request *req)
+{
+	return starfive_cryp_crypt(req,  STARFIVE_AES_MODE_OFB | FLG_ENCRYPT);
+}
+
+static int starfive_cryp_aes_ofb_decrypt(struct skcipher_request *req)
+{
+	return starfive_cryp_crypt(req,  STARFIVE_AES_MODE_OFB);
+}
+
+static int starfive_cryp_aes_ctr_encrypt(struct skcipher_request *req)
+{
+	return starfive_cryp_crypt(req,  STARFIVE_AES_MODE_CTR | FLG_ENCRYPT);
+}
+
+static int starfive_cryp_aes_ctr_decrypt(struct skcipher_request *req)
+{
+	return starfive_cryp_crypt(req,  STARFIVE_AES_MODE_CTR);
+}
+
+static int starfive_cryp_aes_gcm_encrypt(struct aead_request *req)
+{
+	return starfive_cryp_aead_crypt(req,  STARFIVE_AES_MODE_GCM | FLG_ENCRYPT);
+}
+
+static int starfive_cryp_aes_gcm_decrypt(struct aead_request *req)
+{
+	return starfive_cryp_aead_crypt(req,  STARFIVE_AES_MODE_GCM);
+}
+
+static int starfive_cryp_aes_ccm_encrypt(struct aead_request *req)
+{
+	int ret;
+
+	ret = crypto_ccm_check_iv(req->iv);
+	if (ret)
+		return ret;
+
+	return starfive_cryp_aead_crypt(req,  STARFIVE_AES_MODE_CCM | FLG_ENCRYPT);
+}
+
+static int starfive_cryp_aes_ccm_decrypt(struct aead_request *req)
+{
+	int ret;
+
+	ret = crypto_ccm_check_iv(req->iv);
+	if (ret)
+		return ret;
+
+	return starfive_cryp_aead_crypt(req, STARFIVE_AES_MODE_CCM);
+}
+
+static struct skcipher_alg crypto_algs[] = {
+{
+	.base.cra_name		        = "ecb(aes)",
+	.base.cra_driver_name	        = "starfive-ecb-aes",
+	.base.cra_priority		= 200,
+	.base.cra_flags		        = CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize		= AES_BLOCK_SIZE,
+	.base.cra_ctxsize		= sizeof(struct starfive_sec_ctx),
+	.base.cra_alignmask		= 0xf,
+	.base.cra_module		= THIS_MODULE,
+	.init		                = starfive_cryp_cra_init,
+	.exit                           = starfive_cryp_cra_exit,
+	.min_keysize	                = AES_MIN_KEY_SIZE,
+	.max_keysize	                = AES_MAX_KEY_SIZE,
+	.setkey		                = starfive_cryp_aes_setkey,
+	.encrypt	                = starfive_cryp_aes_ecb_encrypt,
+	.decrypt	                = starfive_cryp_aes_ecb_decrypt,
+}, {
+	.base.cra_name		        = "cbc(aes)",
+	.base.cra_driver_name	        = "starfive-cbc-aes",
+	.base.cra_priority		= 200,
+	.base.cra_flags		        = CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize		= AES_BLOCK_SIZE,
+	.base.cra_ctxsize		= sizeof(struct starfive_sec_ctx),
+	.base.cra_alignmask		= 0xf,
+	.base.cra_module		= THIS_MODULE,
+	.init		                = starfive_cryp_cra_init,
+	.exit                           = starfive_cryp_cra_exit,
+	.min_keysize	                = AES_MIN_KEY_SIZE,
+	.max_keysize	                = AES_MAX_KEY_SIZE,
+	.ivsize		                = AES_BLOCK_SIZE,
+	.setkey		                = starfive_cryp_aes_setkey,
+	.encrypt	                = starfive_cryp_aes_cbc_encrypt,
+	.decrypt	                = starfive_cryp_aes_cbc_decrypt,
+}, {
+	.base.cra_name		        = "ctr(aes)",
+	.base.cra_driver_name	        = "starfive-ctr-aes",
+	.base.cra_priority		= 200,
+	.base.cra_flags		        = CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize		= 1,
+	.base.cra_ctxsize		= sizeof(struct starfive_sec_ctx),
+	.base.cra_alignmask		= 0xf,
+	.base.cra_module		= THIS_MODULE,
+	.init		                = starfive_cryp_cra_init,
+	.exit                           = starfive_cryp_cra_exit,
+	.min_keysize	                = AES_MIN_KEY_SIZE,
+	.max_keysize	                = AES_MAX_KEY_SIZE,
+	.ivsize		                = AES_BLOCK_SIZE,
+	.setkey		                = starfive_cryp_aes_setkey,
+	.encrypt	                = starfive_cryp_aes_ctr_encrypt,
+	.decrypt	                = starfive_cryp_aes_ctr_decrypt,
+}, {
+	.base.cra_name		        = "cfb(aes)",
+	.base.cra_driver_name	        = "starfive-cfb-aes",
+	.base.cra_priority		= 200,
+	.base.cra_flags		        = CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize		= 1,
+	.base.cra_ctxsize		= sizeof(struct starfive_sec_ctx),
+	.base.cra_alignmask		= 0xf,
+	.base.cra_module		= THIS_MODULE,
+	.init		                = starfive_cryp_cra_init,
+	.exit                           = starfive_cryp_cra_exit,
+	.min_keysize	                = AES_MIN_KEY_SIZE,
+	.max_keysize	                = AES_MAX_KEY_SIZE,
+	.ivsize		                = AES_BLOCK_SIZE,
+	.setkey		                = starfive_cryp_aes_setkey,
+	.encrypt	                = starfive_cryp_aes_cfb_encrypt,
+	.decrypt	                = starfive_cryp_aes_cfb_decrypt,
+}, {
+	.base.cra_name		        = "ofb(aes)",
+	.base.cra_driver_name	        = "starfive-ofb-aes",
+	.base.cra_priority		= 200,
+	.base.cra_flags		        = CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize		= 1,
+	.base.cra_ctxsize		= sizeof(struct starfive_sec_ctx),
+	.base.cra_alignmask		= 0xf,
+	.base.cra_module		= THIS_MODULE,
+	.init		                = starfive_cryp_cra_init,
+	.exit                           = starfive_cryp_cra_exit,
+	.min_keysize	                = AES_MIN_KEY_SIZE,
+	.max_keysize	                = AES_MAX_KEY_SIZE,
+	.ivsize		                = AES_BLOCK_SIZE,
+	.setkey		                = starfive_cryp_aes_setkey,
+	.encrypt	                = starfive_cryp_aes_ofb_encrypt,
+	.decrypt	                = starfive_cryp_aes_ofb_decrypt,
+},
+};
+
+static struct aead_alg aead_algs[] = {
+{
+	.setkey                         = starfive_cryp_aes_aead_setkey,
+	.setauthsize                    = starfive_cryp_aes_gcm_setauthsize,
+	.encrypt                        = starfive_cryp_aes_gcm_encrypt,
+	.decrypt                        = starfive_cryp_aes_gcm_decrypt,
+	.init                           = starfive_cryp_aes_aead_init,
+	.exit                           = starfive_cryp_aes_aead_exit,
+	.ivsize                         = GCM_AES_IV_SIZE,
+	.maxauthsize                    = AES_BLOCK_SIZE,
+
+	.base = {
+		.cra_name               = "gcm(aes)",
+		.cra_driver_name        = "starfive-gcm-aes",
+		.cra_priority           = 200,
+		.cra_flags              = CRYPTO_ALG_ASYNC,
+		.cra_blocksize          = 1,
+		.cra_ctxsize            = sizeof(struct starfive_sec_ctx),
+		.cra_alignmask          = 0xf,
+		.cra_module             = THIS_MODULE,
+	},
+}, {
+	.setkey		                = starfive_cryp_aes_aead_setkey,
+	.setauthsize	                = starfive_cryp_aes_ccm_setauthsize,
+	.encrypt	                = starfive_cryp_aes_ccm_encrypt,
+	.decrypt	                = starfive_cryp_aes_ccm_decrypt,
+	.init		                = starfive_cryp_aes_aead_init,
+	.exit		                = starfive_cryp_aes_aead_exit,
+	.ivsize		                = AES_BLOCK_SIZE,
+	.maxauthsize	                = AES_BLOCK_SIZE,
+
+	.base = {
+		.cra_name		= "ccm(aes)",
+		.cra_driver_name	= "starfive-ccm-aes",
+		.cra_priority		= 200,
+		.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK,
+		.cra_blocksize		= 1,
+		.cra_ctxsize		= sizeof(struct starfive_sec_ctx),
+		.cra_alignmask		= 0xf,
+		.cra_module		= THIS_MODULE,
+	},
+},
+};
+
+int starfive_aes_register_algs(void)
+{
+	int ret;
+
+	ret = crypto_register_skciphers(crypto_algs, ARRAY_SIZE(crypto_algs));
+	if (ret)
+		return ret;
+
+	ret = crypto_register_aeads(aead_algs, ARRAY_SIZE(aead_algs));
+	if (ret) {
+		crypto_unregister_skciphers(crypto_algs, ARRAY_SIZE(crypto_algs));
+		return ret;
+	}
+
+	return ret;
+}
+
+void starfive_aes_unregister_algs(void)
+{
+	crypto_unregister_aeads(aead_algs, ARRAY_SIZE(aead_algs));
+	crypto_unregister_skciphers(crypto_algs, ARRAY_SIZE(crypto_algs));
+}
diff --git a/drivers/crypto/starfive/starfive-cryp.c b/drivers/crypto/starfive/starfive-cryp.c
index 9f77cae758ac..452bd1ab4f04 100644
--- a/drivers/crypto/starfive/starfive-cryp.c
+++ b/drivers/crypto/starfive/starfive-cryp.c
@@ -169,6 +169,12 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 		goto err_hash_data;
 	}
 
+	sdev->aes_data = (void *)__get_free_pages(GFP_KERNEL | GFP_DMA32, pages);
+	if (!sdev->aes_data) {
+		dev_err(sdev->dev, "Can't allocate aes buffer pages when unaligned\n");
+		goto err_aes_data;
+	}
+
 	sdev->pages_count = pages >> 1;
 	sdev->data_buf_len = STARFIVE_MSG_BUFFER_SIZE >> 1;
 
@@ -187,15 +193,23 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_algs_hash;
 
+	ret = starfive_aes_register_algs();
+	if (ret)
+		goto err_algs_aes;
+
 	dev_info(dev, "Crypto engine started\n");
 
 	return 0;
 
+err_algs_aes:
+	starfive_hash_unregister_algs();
 err_algs_hash:
 	crypto_engine_stop(sdev->engine);
 err_engine_start:
 	crypto_engine_exit(sdev->engine);
 err_engine:
+	free_pages((unsigned long)sdev->aes_data, pages);
+err_aes_data:
 	free_pages((unsigned long)sdev->hash_data, pages);
 err_hash_data:
 	starfive_dma_cleanup(sdev);
@@ -215,6 +229,7 @@ static int starfive_cryp_remove(struct platform_device *pdev)
 		return -ENODEV;
 
 	starfive_hash_unregister_algs();
+	starfive_aes_unregister_algs();
 
 	crypto_engine_stop(sdev->engine);
 	crypto_engine_exit(sdev->engine);
@@ -222,7 +237,9 @@ static int starfive_cryp_remove(struct platform_device *pdev)
 	starfive_dma_cleanup(sdev);
 
 	free_pages((unsigned long)sdev->hash_data, sdev->pages_count);
+	free_pages((unsigned long)sdev->aes_data, sdev->pages_count);
 	sdev->hash_data = NULL;
+	sdev->aes_data = NULL;
 
 	spin_lock(&dev_list.lock);
 	list_del(&sdev->list);
diff --git a/drivers/crypto/starfive/starfive-regs.h b/drivers/crypto/starfive/starfive-regs.h
index 3f5e8881b3c0..c53b0303fb66 100644
--- a/drivers/crypto/starfive/starfive-regs.h
+++ b/drivers/crypto/starfive/starfive-regs.h
@@ -9,6 +9,7 @@
 #define STARFIVE_DMA_IN_LEN_OFFSET		0x10
 #define STARFIVE_DMA_OUT_LEN_OFFSET		0x14
 
+#define STARFIVE_AES_REGS_OFFSET		0x100
 #define STARFIVE_HASH_REGS_OFFSET		0x300
 
 union starfive_alg_cr {
@@ -25,6 +26,69 @@ union starfive_alg_cr {
 	};
 };
 
+#define STARFIVE_AES_AESDIO0R			(STARFIVE_AES_REGS_OFFSET + 0x0)
+#define STARFIVE_AES_KEY0			(STARFIVE_AES_REGS_OFFSET + 0x4)
+#define STARFIVE_AES_KEY1			(STARFIVE_AES_REGS_OFFSET + 0x8)
+#define STARFIVE_AES_KEY2			(STARFIVE_AES_REGS_OFFSET + 0xC)
+#define STARFIVE_AES_KEY3			(STARFIVE_AES_REGS_OFFSET + 0x10)
+#define STARFIVE_AES_KEY4			(STARFIVE_AES_REGS_OFFSET + 0x14)
+#define STARFIVE_AES_KEY5			(STARFIVE_AES_REGS_OFFSET + 0x18)
+#define STARFIVE_AES_KEY6			(STARFIVE_AES_REGS_OFFSET + 0x1C)
+#define STARFIVE_AES_KEY7			(STARFIVE_AES_REGS_OFFSET + 0x20)
+#define STARFIVE_AES_CSR			(STARFIVE_AES_REGS_OFFSET + 0x24)
+#define STARFIVE_AES_IV0			(STARFIVE_AES_REGS_OFFSET + 0x28)
+#define STARFIVE_AES_IV1			(STARFIVE_AES_REGS_OFFSET + 0x2C)
+#define STARFIVE_AES_IV2			(STARFIVE_AES_REGS_OFFSET + 0x30)
+#define STARFIVE_AES_IV3			(STARFIVE_AES_REGS_OFFSET + 0x34)
+#define STARFIVE_AES_NONCE0			(STARFIVE_AES_REGS_OFFSET + 0x3C)
+#define STARFIVE_AES_NONCE1			(STARFIVE_AES_REGS_OFFSET + 0x40)
+#define STARFIVE_AES_NONCE2			(STARFIVE_AES_REGS_OFFSET + 0x44)
+#define STARFIVE_AES_NONCE3			(STARFIVE_AES_REGS_OFFSET + 0x48)
+#define STARFIVE_AES_ALEN0			(STARFIVE_AES_REGS_OFFSET + 0x4C)
+#define STARFIVE_AES_ALEN1			(STARFIVE_AES_REGS_OFFSET + 0x50)
+#define STARFIVE_AES_MLEN0			(STARFIVE_AES_REGS_OFFSET + 0x54)
+#define STARFIVE_AES_MLEN1			(STARFIVE_AES_REGS_OFFSET + 0x58)
+#define STARFIVE_AES_IVLEN			(STARFIVE_AES_REGS_OFFSET + 0x5C)
+
+union starfive_aes_csr {
+	u32 v;
+	struct {
+		u32 cmode			:1;
+#define STARFIVE_AES_KEYMODE_128		0x0
+#define STARFIVE_AES_KEYMODE_192		0x1
+#define STARFIVE_AES_KEYMODE_256		0x2
+		u32 keymode			:2;
+#define STARFIVE_AES_BUSY			BIT(3)
+		u32 busy			:1;
+		u32 done			:1;
+#define STARFIVE_AES_KEY_DONE			BIT(5)
+		u32 krdy			:1;
+		u32 aesrst			:1;
+		u32 rsvd_0			:1;
+#define STARFIVE_AES_CCM_START			BIT(8)
+		u32 ccm_start			:1;
+#define STARFIVE_AES_MODE_ECB			0x0
+#define STARFIVE_AES_MODE_CBC			0x1
+#define STARFIVE_AES_MODE_CFB			0x2
+#define STARFIVE_AES_MODE_OFB			0x3
+#define STARFIVE_AES_MODE_CTR			0x4
+#define STARFIVE_AES_MODE_CCM			0x5
+#define STARFIVE_AES_MODE_GCM			0x6
+		u32 mode			:3;
+#define STARFIVE_AES_GCM_START			BIT(12)
+		u32 gcm_start			:1;
+#define STARFIVE_AES_GCM_DONE			BIT(13)
+		u32 gcm_done			:1;
+		u32 delay_aes			:1;
+		u32 vaes_start			:1;
+		u32 rsvd_1			:8;
+#define STARFIVE_AES_MODE_XFB_1			0x0
+#define STARFIVE_AES_MODE_XFB_128		0x5
+		u32 stream_mode			:3;
+		u32 rsvd_2			:5;
+	};
+};
+
 #define STARFIVE_HASH_SHACSR			(STARFIVE_HASH_REGS_OFFSET + 0x0)
 #define STARFIVE_HASH_SHAWDR			(STARFIVE_HASH_REGS_OFFSET + 0x4)
 #define STARFIVE_HASH_SHARDR			(STARFIVE_HASH_REGS_OFFSET + 0x8)
diff --git a/drivers/crypto/starfive/starfive-str.h b/drivers/crypto/starfive/starfive-str.h
index a6fed48a0b19..396529a9a8f1 100644
--- a/drivers/crypto/starfive/starfive-str.h
+++ b/drivers/crypto/starfive/starfive-str.h
@@ -6,6 +6,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 
+#include <crypto/aes.h>
 #include <crypto/engine.h>
 #include <crypto/sha2.h>
 #include <crypto/sm3.h>
@@ -15,6 +16,9 @@
 #define STARFIVE_MSG_BUFFER_SIZE		SZ_16K
 #define MAX_KEY_SIZE				SHA512_BLOCK_SIZE
 
+#define STARFIVE_AES_IV_LEN			AES_BLOCK_SIZE
+#define STARFIVE_AES_CTR_LEN			AES_BLOCK_SIZE
+
 struct starfive_sec_ctx {
 	struct crypto_engine_ctx		enginectx;
 	struct starfive_sec_dev			*sdev;
@@ -27,6 +31,7 @@ struct starfive_sec_ctx {
 	u8					*buffer;
 
 	union {
+		struct crypto_aead		*aead;
 		struct crypto_shash		*shash;
 	} fallback;
 	bool                                    fallback_available;
@@ -42,6 +47,7 @@ struct starfive_sec_dev {
 
 	void __iomem				*io_base;
 	phys_addr_t				io_phys_base;
+	void					*aes_data;
 	void					*hash_data;
 
 	size_t					data_buf_len;
@@ -70,26 +76,52 @@ struct starfive_sec_request_ctx {
 	struct starfive_sec_dev			*sdev;
 
 	union {
+		struct aead_request		*areq;
 		struct ahash_request		*hreq;
+		struct skcipher_request		*sreq;
 	} req;
 #define STARFIVE_AHASH_REQ			0
+#define STARFIVE_ABLK_REQ			1
+#define STARFIVE_AEAD_REQ			2
 	unsigned int				req_type;
 
 	union {
+		union starfive_aes_csr		aes;
 		union starfive_hash_csr		hash;
 	} csr;
 
 	struct scatterlist			*in_sg;
-
+	struct scatterlist			*out_sg;
+	struct scatterlist			*out_sg_save;
+	struct scatterlist			in_sgl;
+	struct scatterlist			out_sgl;
+	bool					sgs_copied;
+
+	unsigned long				sg_len;
+	unsigned long				in_sg_len;
+	unsigned long				out_sg_len;
 	unsigned long				flags;
 	unsigned long				op;
+	unsigned long				stmode;
 
 	size_t					bufcnt;
 	size_t					buflen;
 	size_t					total;
 	size_t					offset;
 	size_t					data_offset;
-
+	size_t					authsize;
+	size_t					hw_blocksize;
+	size_t					total_in;
+	size_t					total_in_save;
+	size_t					total_out;
+	size_t					total_out_save;
+	size_t					assoclen;
+	size_t					ctr_over_count;
+
+	u32					ctr[4];
+	u32					aes_iv[4];
+	u32					tag_out[4];
+	u32					tag_in[4];
 	unsigned int				hash_digest_len;
 	u8 hash_digest_mid[SHA512_DIGEST_SIZE]__aligned(sizeof(u32));
 };
@@ -121,4 +153,7 @@ struct starfive_sec_dev *starfive_sec_find_dev(struct starfive_sec_ctx *ctx);
 int starfive_hash_register_algs(void);
 void starfive_hash_unregister_algs(void);
 
+int starfive_aes_register_algs(void);
+void starfive_aes_unregister_algs(void);
+
 #endif
-- 
2.25.1

