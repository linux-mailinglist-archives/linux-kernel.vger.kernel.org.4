Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7CF63CEEA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 06:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiK3Fzc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Nov 2022 00:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbiK3Fz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 00:55:27 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41366654FD;
        Tue, 29 Nov 2022 21:55:24 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id AE2B024E1E2;
        Wed, 30 Nov 2022 13:52:38 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 30 Nov
 2022 13:52:38 +0800
Received: from ubuntu.localdomain (202.188.176.82) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 30 Nov
 2022 13:52:34 +0800
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>
Subject: [PATCH 4/6] crypto: starfive - Add Public Key algo support
Date:   Wed, 30 Nov 2022 13:52:12 +0800
Message-ID: <20221130055214.2416888-5-jiajie.ho@starfivetech.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding RSA enc/dec and sign/verify feature for
Starfive crypto driver.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
---
 drivers/crypto/starfive/Makefile        |   2 +-
 drivers/crypto/starfive/starfive-cryp.c |  19 +-
 drivers/crypto/starfive/starfive-pka.c  | 683 ++++++++++++++++++++++++
 drivers/crypto/starfive/starfive-regs.h |  65 +++
 drivers/crypto/starfive/starfive-str.h  |  35 ++
 5 files changed, 802 insertions(+), 2 deletions(-)
 create mode 100644 drivers/crypto/starfive/starfive-pka.c

diff --git a/drivers/crypto/starfive/Makefile b/drivers/crypto/starfive/Makefile
index 4958b1f6812c..d44e28063965 100644
--- a/drivers/crypto/starfive/Makefile
+++ b/drivers/crypto/starfive/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_CRYPTO_DEV_STARFIVE) += starfive-crypto.o
-starfive-crypto-objs := starfive-cryp.o starfive-hash.o starfive-aes.o
+starfive-crypto-objs := starfive-cryp.o starfive-hash.o starfive-aes.o starfive-pka.o
diff --git a/drivers/crypto/starfive/starfive-cryp.c b/drivers/crypto/starfive/starfive-cryp.c
index 452bd1ab4f04..a9c7f39b5547 100644
--- a/drivers/crypto/starfive/starfive-cryp.c
+++ b/drivers/crypto/starfive/starfive-cryp.c
@@ -175,6 +175,12 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 		goto err_aes_data;
 	}
 
+	sdev->pka_data = (void *)__get_free_pages(GFP_KERNEL | GFP_DMA32, pages);
+	if (!sdev->pka_data) {
+		dev_err(sdev->dev, "Can't allocate pka buffer pages when unaligned\n");
+		goto err_pka_data;
+	}
+
 	sdev->pages_count = pages >> 1;
 	sdev->data_buf_len = STARFIVE_MSG_BUFFER_SIZE >> 1;
 
@@ -197,10 +203,16 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_algs_aes;
 
+	ret = starfive_pka_register_algs();
+	if (ret)
+		goto err_algs_pka;
+
 	dev_info(dev, "Crypto engine started\n");
 
 	return 0;
 
+err_algs_pka:
+	starfive_aes_unregister_algs();
 err_algs_aes:
 	starfive_hash_unregister_algs();
 err_algs_hash:
@@ -208,6 +220,8 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 err_engine_start:
 	crypto_engine_exit(sdev->engine);
 err_engine:
+	free_pages((unsigned long)sdev->pka_data, pages);
+err_pka_data:
 	free_pages((unsigned long)sdev->aes_data, pages);
 err_aes_data:
 	free_pages((unsigned long)sdev->hash_data, pages);
@@ -230,6 +244,7 @@ static int starfive_cryp_remove(struct platform_device *pdev)
 
 	starfive_hash_unregister_algs();
 	starfive_aes_unregister_algs();
+	starfive_pka_unregister_algs();
 
 	crypto_engine_stop(sdev->engine);
 	crypto_engine_exit(sdev->engine);
@@ -238,8 +253,10 @@ static int starfive_cryp_remove(struct platform_device *pdev)
 
 	free_pages((unsigned long)sdev->hash_data, sdev->pages_count);
 	free_pages((unsigned long)sdev->aes_data, sdev->pages_count);
-	sdev->hash_data = NULL;
+	free_pages((unsigned long)sdev->pka_data, sdev->pages_count);
 	sdev->aes_data = NULL;
+	sdev->hash_data = NULL;
+	sdev->pka_data = NULL;
 
 	spin_lock(&dev_list.lock);
 	list_del(&sdev->list);
diff --git a/drivers/crypto/starfive/starfive-pka.c b/drivers/crypto/starfive/starfive-pka.c
new file mode 100644
index 000000000000..e845f2545a9a
--- /dev/null
+++ b/drivers/crypto/starfive/starfive-pka.c
@@ -0,0 +1,683 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive Public Key Algo acceleration driver
+ *
+ * Copyright (c) 2022 StarFive Technology
+ */
+
+#include <linux/crypto.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-direct.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+
+#include <crypto/scatterwalk.h>
+
+#include "starfive-str.h"
+
+#define STARFIVE_RSA_KEYSZ_LEN			(2048 >> 2)
+#define STARFIVE_RSA_KEY_SIZE			(STARFIVE_RSA_KEYSZ_LEN * 3)
+#define STARFIVE_RSA_MAX_KEYSZ			256
+
+static inline int starfive_pka_wait_done(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	u32 status;
+
+	return readl_relaxed_poll_timeout(sdev->io_base + STARFIVE_PKA_CASR_OFFSET, status,
+					  (status & STARFIVE_PKA_DONE_FLAGS), 10, 100000);
+}
+
+static void starfive_rsa_free_key(struct starfive_rsa_key *key)
+{
+	if (key->d)
+		kfree_sensitive(key->d);
+	if (key->e)
+		kfree_sensitive(key->e);
+	if (key->n)
+		kfree_sensitive(key->n);
+	memset(key, 0, sizeof(*key));
+}
+
+static unsigned int starfive_rsa_get_nbit(u8 *pa, u32 snum, int key_sz)
+{
+	u32 i;
+	u8 value;
+
+	i = snum >> 3;
+
+	value = pa[key_sz - i - 1];
+	value >>= snum & 0x7;
+	value &= 0x1;
+
+	return value;
+}
+
+static int starfive_rsa_domain_transfer(struct starfive_sec_ctx *ctx,
+					u32 *result, u32 *opa, u8 domain,
+					u32 *mod, int bit_len)
+{
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+	unsigned int *info;
+	int loop;
+	u8 opsize;
+	u32 temp;
+
+	opsize = (bit_len - 1) >> 5;
+	rctx->csr.pka.v = 0;
+	starfive_sec_write(sdev, STARFIVE_PKA_CACR_OFFSET, rctx->csr.pka.v);
+
+	info = (unsigned int *)mod;
+	for (loop = 0; loop <= opsize; loop++)
+		starfive_sec_write(sdev, STARFIVE_PKA_CANR_OFFSET + loop * 4, info[opsize - loop]);
+
+	if (domain != 0) {
+		rctx->csr.pka.v = 0;
+		rctx->csr.pka.cln_done = 1;
+		rctx->csr.pka.opsize = opsize;
+		rctx->csr.pka.exposize = opsize;
+		rctx->csr.pka.cmd = CRYPTO_CMD_PRE;
+		rctx->csr.pka.start = 1;
+		rctx->csr.pka.not_r2 = 1;
+		starfive_sec_write(sdev, STARFIVE_PKA_CACR_OFFSET, rctx->csr.pka.v);
+
+		starfive_pka_wait_done(ctx);
+
+		info = (unsigned int *)opa;
+		for (loop = 0; loop <= opsize; loop++)
+			starfive_sec_write(sdev, STARFIVE_PKA_CAAR_OFFSET + loop * 4,
+					   info[opsize - loop]);
+
+		starfive_sec_write(sdev, STARFIVE_PKA_CAER_OFFSET, 0x1000000);
+
+		for (loop = 1; loop <= opsize; loop++)
+			starfive_sec_write(sdev, STARFIVE_PKA_CAER_OFFSET + loop * 4, 0);
+
+		rctx->csr.pka.v = 0;
+		rctx->csr.pka.cln_done = 1;
+		rctx->csr.pka.opsize = opsize;
+		rctx->csr.pka.exposize = opsize;
+		rctx->csr.pka.cmd = CRYPTO_CMD_AERN;
+		rctx->csr.pka.start = 1;
+		starfive_sec_write(sdev, STARFIVE_PKA_CACR_OFFSET, rctx->csr.pka.v);
+
+		starfive_pka_wait_done(ctx);
+	} else {
+		rctx->csr.pka.v = 0;
+		rctx->csr.pka.cln_done = 1;
+		rctx->csr.pka.opsize = opsize;
+		rctx->csr.pka.exposize = opsize;
+		rctx->csr.pka.cmd = CRYPTO_CMD_PRE;
+		rctx->csr.pka.start = 1;
+		rctx->csr.pka.pre_expf = 1;
+		starfive_sec_write(sdev, STARFIVE_PKA_CACR_OFFSET, rctx->csr.pka.v);
+
+		starfive_pka_wait_done(ctx);
+
+		info = (unsigned int *)opa;
+		for (loop = 0; loop <= opsize; loop++)
+			starfive_sec_write(sdev, STARFIVE_PKA_CAER_OFFSET + loop * 4,
+					   info[opsize - loop]);
+
+		rctx->csr.pka.v = 0;
+		rctx->csr.pka.cln_done = 1;
+		rctx->csr.pka.opsize = opsize;
+		rctx->csr.pka.exposize = opsize;
+		rctx->csr.pka.cmd = CRYPTO_CMD_ARN;
+		rctx->csr.pka.start = 1;
+		starfive_sec_write(sdev, STARFIVE_PKA_CACR_OFFSET, rctx->csr.pka.v);
+
+		starfive_pka_wait_done(ctx);
+	}
+
+	for (loop = 0; loop <= opsize; loop++) {
+		temp = starfive_sec_read(sdev, STARFIVE_PKA_CAAR_OFFSET + 0x4 * loop);
+		result[opsize - loop] = temp;
+	}
+
+	return 0;
+}
+
+static int starfive_rsa_cpu_powm(struct starfive_sec_ctx *ctx, u32 *result,
+				 u8 *de, u32 *n, int key_sz)
+{
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+	struct starfive_rsa_key *key = &ctx->rsa_key;
+	u32 initial;
+	int opsize, mlen, bs, loop;
+	unsigned int *mta;
+
+	opsize = (key_sz - 1) >> 2;
+	initial = 1;
+
+	mta = kmalloc(key_sz, GFP_KERNEL);
+	if (!mta)
+		return -ENOMEM;
+
+	starfive_rsa_domain_transfer(ctx, mta, sdev->pka_data, 0, n, key_sz << 3);
+
+	for (loop = 0; loop <= opsize; loop++)
+		starfive_sec_write(sdev, STARFIVE_PKA_CANR_OFFSET + loop * 4,
+				   n[opsize - loop]);
+
+	rctx->csr.pka.v = 0;
+	rctx->csr.pka.cln_done = 1;
+	rctx->csr.pka.opsize = opsize;
+	rctx->csr.pka.exposize = opsize;
+	rctx->csr.pka.cmd = CRYPTO_CMD_PRE;
+	rctx->csr.pka.not_r2 = 1;
+	rctx->csr.pka.start = 1;
+
+	starfive_sec_write(sdev, STARFIVE_PKA_CACR_OFFSET, rctx->csr.pka.v);
+
+	starfive_pka_wait_done(ctx);
+
+	for (loop = 0; loop <= opsize; loop++)
+		starfive_sec_write(sdev, STARFIVE_PKA_CAER_OFFSET + loop * 4,
+				   mta[opsize - loop]);
+
+	for (loop = key->bitlen; loop > 0; loop--) {
+		if (initial) {
+			for (bs = 0; bs <= opsize; bs++)
+				result[bs] = mta[bs];
+
+			initial = 0;
+		} else {
+			mlen = starfive_rsa_get_nbit(de, loop - 1, key_sz);
+
+			rctx->csr.pka.v = 0;
+			rctx->csr.pka.cln_done = 1;
+			rctx->csr.pka.opsize = opsize;
+			rctx->csr.pka.exposize = opsize;
+			rctx->csr.pka.cmd = CRYPTO_CMD_AARN;
+			rctx->csr.pka.start = 1;
+
+			starfive_sec_write(sdev, STARFIVE_PKA_CACR_OFFSET, rctx->csr.pka.v);
+			starfive_pka_wait_done(ctx);
+
+			if (mlen) {
+				rctx->csr.pka.v = 0;
+				rctx->csr.pka.cln_done = 1;
+				rctx->csr.pka.opsize = opsize;
+				rctx->csr.pka.exposize = opsize;
+				rctx->csr.pka.cmd = CRYPTO_CMD_AERN;
+				rctx->csr.pka.start = 1;
+
+				starfive_sec_write(sdev, STARFIVE_PKA_CACR_OFFSET,
+						   rctx->csr.pka.v);
+				starfive_pka_wait_done(ctx);
+			}
+		}
+	}
+
+	for (loop = 0; loop <= opsize; loop++) {
+		unsigned int temp;
+
+		temp = starfive_sec_read(sdev, STARFIVE_PKA_CAAR_OFFSET + 0x4 * loop);
+		result[opsize - loop] = temp;
+	}
+
+	kfree(mta);
+
+	return starfive_rsa_domain_transfer(ctx, result, result, 1, n, key_sz << 3);
+}
+
+static int starfive_rsa_powm(struct starfive_sec_ctx *ctx, u8 *result,
+			     u8 *de, u8 *n, int key_sz)
+{
+	return starfive_rsa_cpu_powm(ctx, (u32 *)result, de, (u32 *)n, key_sz);
+}
+
+static int starfive_rsa_get_from_sg(struct starfive_sec_request_ctx *rctx,
+				    size_t offset, size_t count, size_t data_offset)
+{
+	size_t of, ct, index;
+	struct scatterlist	*sg = rctx->in_sg;
+
+	of = offset;
+	ct = count;
+
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
+			scatterwalk_map_and_copy(rctx->sdev->pka_data + index, sg,
+						 of, ct, 0);
+			index = index + ct;
+			return index - data_offset;
+		}
+
+		scatterwalk_map_and_copy(rctx->sdev->pka_data + index,
+					 sg, of, sg->length - of, 0);
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
+static int starfive_rsa_enc_core(struct starfive_sec_ctx *ctx, int enc)
+{
+	struct starfive_sec_dev *sdev = ctx->sdev;
+	struct starfive_sec_request_ctx *rctx = ctx->rctx;
+	struct starfive_rsa_key *key = &ctx->rsa_key;
+	size_t data_len, total, count, data_offset;
+	int ret = 0;
+	unsigned int *info;
+	int loop;
+
+	rctx->csr.pka.v = 0;
+	rctx->csr.pka.reset = 1;
+	starfive_sec_write(sdev, STARFIVE_PKA_CACR_OFFSET, rctx->csr.pka.v);
+
+	if (starfive_pka_wait_done(ctx))
+		dev_dbg(sdev->dev, "this is debug for lophyel pka_casr = %x %s %s %d\n",
+			starfive_sec_read(sdev, STARFIVE_PKA_CASR_OFFSET),
+			__FILE__, __func__, __LINE__);
+
+	rctx->offset = 0;
+	total = 0;
+
+	while (total < rctx->total_in) {
+		count = min(sdev->data_buf_len, rctx->total_in);
+		count = min(count, key->key_sz);
+		memset(sdev->pka_data, 0, key->key_sz);
+		data_offset = key->key_sz - count;
+
+		data_len = starfive_rsa_get_from_sg(rctx, rctx->offset, count, data_offset);
+		if (data_len < 0)
+			return data_len;
+		if (data_len != count)
+			return -EINVAL;
+
+		if (enc) {
+			key->bitlen = key->e_bitlen;
+			ret = starfive_rsa_powm(ctx, sdev->pka_data + STARFIVE_RSA_KEYSZ_LEN,
+						key->e, key->n, key->key_sz);
+		} else {
+			key->bitlen = key->d_bitlen;
+			ret = starfive_rsa_powm(ctx, sdev->pka_data + STARFIVE_RSA_KEYSZ_LEN,
+						key->d, key->n, key->key_sz);
+		}
+
+		if (ret)
+			return ret;
+
+		info = (unsigned int *)(sdev->pka_data + STARFIVE_RSA_KEYSZ_LEN);
+		for (loop = 0; loop < key->key_sz >> 2; loop++)
+			dev_dbg(sdev->dev, "result[%d] = %x\n", loop, info[loop]);
+
+		sg_copy_buffer(rctx->out_sg, sg_nents(rctx->out_sg),
+			       sdev->pka_data + STARFIVE_RSA_KEYSZ_LEN,
+			       key->key_sz, rctx->offset, 0);
+
+		rctx->offset += data_len;
+		total += data_len;
+	}
+
+	return ret;
+}
+
+static int starfive_rsa_enc(struct akcipher_request *req)
+{
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct starfive_sec_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct starfive_rsa_key *key = &ctx->rsa_key;
+	struct starfive_sec_request_ctx *rctx = akcipher_request_ctx(req);
+	int ret = 0;
+
+	if (key->key_sz > STARFIVE_RSA_MAX_KEYSZ) {
+		akcipher_request_set_tfm(req, ctx->fallback.akcipher);
+		ret = crypto_akcipher_encrypt(req);
+		akcipher_request_set_tfm(req, tfm);
+		return ret;
+	}
+
+	if (unlikely(!key->n || !key->e))
+		return -EINVAL;
+
+	if (req->dst_len < key->key_sz) {
+		req->dst_len = key->key_sz;
+		dev_err(ctx->sdev->dev, "Output buffer length less than parameter n\n");
+		return -EOVERFLOW;
+	}
+
+	mutex_lock(&ctx->sdev->lock);
+
+	rctx->in_sg = req->src;
+	rctx->out_sg = req->dst;
+	rctx->sdev = ctx->sdev;
+	ctx->rctx = rctx;
+	rctx->total_in = req->src_len;
+	rctx->total_out = req->dst_len;
+
+	ret = starfive_rsa_enc_core(ctx, 1);
+
+	mutex_unlock(&ctx->sdev->lock);
+
+	return ret;
+}
+
+static int starfive_rsa_dec(struct akcipher_request *req)
+{
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct starfive_sec_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct starfive_rsa_key *key = &ctx->rsa_key;
+	struct starfive_sec_request_ctx *rctx = akcipher_request_ctx(req);
+	int ret = 0;
+
+	if (key->key_sz > STARFIVE_RSA_MAX_KEYSZ) {
+		akcipher_request_set_tfm(req, ctx->fallback.akcipher);
+		ret = crypto_akcipher_decrypt(req);
+		akcipher_request_set_tfm(req, tfm);
+		return ret;
+	}
+
+	if (unlikely(!key->n || !key->d))
+		return -EINVAL;
+
+	if (req->dst_len < key->key_sz) {
+		req->dst_len = key->key_sz;
+		dev_err(ctx->sdev->dev, "Output buffer length less than parameter n\n");
+		return -EOVERFLOW;
+	}
+
+	mutex_lock(&ctx->sdev->lock);
+
+	rctx->in_sg = req->src;
+	rctx->out_sg = req->dst;
+	rctx->sdev = ctx->sdev;
+	ctx->rctx = rctx;
+	rctx->total_in = req->src_len;
+	rctx->total_out = req->dst_len;
+
+	ret = starfive_rsa_enc_core(ctx, 0);
+
+	mutex_unlock(&ctx->sdev->lock);
+
+	return ret;
+}
+
+static unsigned long starfive_rsa_check_keysz(unsigned int len)
+{
+	unsigned int bitslen = len << 3;
+
+	if (bitslen & 0x1f)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int starfive_rsa_set_n(struct starfive_rsa_key *rsa_key,
+			      const char *value, size_t vlen)
+{
+	const char *ptr = value;
+	int ret;
+
+	while (!*ptr && vlen) {
+		ptr++;
+		vlen--;
+	}
+	rsa_key->key_sz = vlen;
+
+	/* invalid key size provided */
+	ret = starfive_rsa_check_keysz(rsa_key->key_sz);
+	if (ret)
+		return ret;
+
+	ret = -ENOMEM;
+	rsa_key->n = kmemdup(ptr, rsa_key->key_sz, GFP_KERNEL);
+	if (!rsa_key->n)
+		goto err;
+
+	return 0;
+ err:
+	rsa_key->key_sz = 0;
+	rsa_key->n = NULL;
+	starfive_rsa_free_key(rsa_key);
+	return ret;
+}
+
+static int starfive_rsa_set_e(struct starfive_rsa_key *rsa_key,
+			      const char *value, size_t vlen)
+{
+	const char *ptr = value;
+	unsigned char pt;
+	int loop;
+
+	while (!*ptr && vlen) {
+		ptr++;
+		vlen--;
+	}
+	pt = *ptr;
+
+	if (!rsa_key->key_sz || !vlen || vlen > rsa_key->key_sz) {
+		rsa_key->e = NULL;
+		return -EINVAL;
+	}
+
+	rsa_key->e = kzalloc(rsa_key->key_sz, GFP_KERNEL);
+	if (!rsa_key->e)
+		return -ENOMEM;
+
+	for (loop = 8; loop > 0; loop--) {
+		if (pt >> (loop - 1))
+			break;
+	}
+
+	rsa_key->e_bitlen = (vlen - 1) * 8 + loop;
+
+	memcpy(rsa_key->e + (rsa_key->key_sz - vlen), ptr, vlen);
+
+	return 0;
+}
+
+static int starfive_rsa_set_d(struct starfive_rsa_key *rsa_key,
+			      const char *value, size_t vlen)
+{
+	const char *ptr = value;
+	unsigned char pt;
+	int loop;
+	int ret;
+
+	while (!*ptr && vlen) {
+		ptr++;
+		vlen--;
+	}
+	pt = *ptr;
+
+	ret = -EINVAL;
+	if (!rsa_key->key_sz || !vlen || vlen > rsa_key->key_sz)
+		goto err;
+
+	ret = -ENOMEM;
+	rsa_key->d = kzalloc(rsa_key->key_sz, GFP_KERNEL);
+	if (!rsa_key->d)
+		goto err;
+
+	for (loop = 8; loop > 0; loop--) {
+		pr_debug("this is debug for lophyel loop = %d pt >> (loop - 1) = %x value[%d] = %x %s %s %d\n",
+			 loop, pt >> (loop - 1), loop, value[loop], __FILE__, __func__, __LINE__);
+		if (pt >> (loop - 1))
+			break;
+	}
+
+	rsa_key->d_bitlen = (vlen - 1) * 8 + loop;
+
+	memcpy(rsa_key->d + (rsa_key->key_sz - vlen), ptr, vlen);
+
+	return 0;
+ err:
+	rsa_key->d = NULL;
+	return ret;
+}
+
+static int starfive_rsa_setkey(struct crypto_akcipher *tfm, const void *key,
+			       unsigned int keylen, bool private)
+{
+	struct starfive_sec_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct rsa_key raw_key = {NULL};
+	struct starfive_rsa_key *rsa_key = &ctx->rsa_key;
+	int ret;
+
+	starfive_rsa_free_key(rsa_key);
+
+	if (private)
+		ret = rsa_parse_priv_key(&raw_key, key, keylen);
+	else
+		ret = rsa_parse_pub_key(&raw_key, key, keylen);
+	if (ret < 0)
+		goto err;
+
+	ret = starfive_rsa_set_n(rsa_key, raw_key.n, raw_key.n_sz);
+	if (ret < 0)
+		return ret;
+
+	ret = starfive_rsa_set_e(rsa_key, raw_key.e, raw_key.e_sz);
+	if (ret < 0)
+		goto err;
+
+	if (private) {
+		ret = starfive_rsa_set_d(rsa_key, raw_key.d, raw_key.d_sz);
+		if (ret < 0)
+			goto err;
+	}
+
+	if (!rsa_key->n || !rsa_key->e) {
+		/* invalid key provided */
+		ret = -EINVAL;
+		goto err;
+	}
+	if (private && !rsa_key->d) {
+		/* invalid private key provided */
+		ret = -EINVAL;
+		goto err;
+	}
+
+	return 0;
+ err:
+	starfive_rsa_free_key(rsa_key);
+	return ret;
+}
+
+static int starfive_rsa_set_pub_key(struct crypto_akcipher *tfm, const void *key,
+				    unsigned int keylen)
+{
+	struct starfive_sec_ctx *ctx = akcipher_tfm_ctx(tfm);
+	int ret;
+
+	ret = crypto_akcipher_set_pub_key(ctx->fallback.akcipher, key, keylen);
+	if (ret)
+		return ret;
+
+	return starfive_rsa_setkey(tfm, key, keylen, false);
+}
+
+static int starfive_rsa_set_priv_key(struct crypto_akcipher *tfm, const void *key,
+				     unsigned int keylen)
+{
+	struct starfive_sec_ctx *ctx = akcipher_tfm_ctx(tfm);
+	int ret;
+
+	ret = crypto_akcipher_set_priv_key(ctx->fallback.akcipher, key, keylen);
+	if (ret)
+		return ret;
+
+	return starfive_rsa_setkey(tfm, key, keylen, true);
+}
+
+static unsigned int starfive_rsa_max_size(struct crypto_akcipher *tfm)
+{
+	struct starfive_sec_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	/* For key sizes > 2Kb, use software tfm */
+	if (ctx->rsa_key.key_sz > STARFIVE_RSA_MAX_KEYSZ)
+		return crypto_akcipher_maxsize(ctx->fallback.akcipher);
+
+	return ctx->rsa_key.key_sz;
+}
+
+/* Per session pkc's driver context creation function */
+static int starfive_rsa_init_tfm(struct crypto_akcipher *tfm)
+{
+	struct starfive_sec_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	ctx->fallback.akcipher = crypto_alloc_akcipher("rsa-generic", 0, 0);
+	if (IS_ERR(ctx->fallback.akcipher))
+		return PTR_ERR(ctx->fallback.akcipher);
+
+	ctx->sdev = starfive_sec_find_dev(ctx);
+	if (!ctx->sdev) {
+		crypto_free_akcipher(ctx->fallback.akcipher);
+		return -ENODEV;
+	}
+
+	akcipher_set_reqsize(tfm, sizeof(struct starfive_sec_request_ctx));
+
+	return 0;
+}
+
+/* Per session pkc's driver context cleanup function */
+static void starfive_rsa_exit_tfm(struct crypto_akcipher *tfm)
+{
+	struct starfive_sec_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct starfive_rsa_key *key = (struct starfive_rsa_key *)&ctx->rsa_key;
+
+	crypto_free_akcipher(ctx->fallback.akcipher);
+	starfive_rsa_free_key(key);
+}
+
+static struct akcipher_alg starfive_rsa = {
+	.encrypt = starfive_rsa_enc,
+	.decrypt = starfive_rsa_dec,
+	.sign = starfive_rsa_dec,
+	.verify = starfive_rsa_enc,
+	.set_pub_key = starfive_rsa_set_pub_key,
+	.set_priv_key = starfive_rsa_set_priv_key,
+	.max_size = starfive_rsa_max_size,
+	.init = starfive_rsa_init_tfm,
+	.exit = starfive_rsa_exit_tfm,
+	.reqsize = sizeof(struct starfive_sec_request_ctx),
+	.base = {
+		.cra_name = "rsa",
+		.cra_driver_name = "starfive-rsa",
+		.cra_flags = CRYPTO_ALG_TYPE_AKCIPHER |
+			     CRYPTO_ALG_ASYNC |
+			     CRYPTO_ALG_NEED_FALLBACK,
+		.cra_priority = 3000,
+		.cra_module = THIS_MODULE,
+		.cra_ctxsize = sizeof(struct starfive_sec_ctx),
+	},
+};
+
+int starfive_pka_register_algs(void)
+{
+	return crypto_register_akcipher(&starfive_rsa);
+}
+
+void starfive_pka_unregister_algs(void)
+{
+	crypto_unregister_akcipher(&starfive_rsa);
+}
diff --git a/drivers/crypto/starfive/starfive-regs.h b/drivers/crypto/starfive/starfive-regs.h
index c53b0303fb66..af3967c37a12 100644
--- a/drivers/crypto/starfive/starfive-regs.h
+++ b/drivers/crypto/starfive/starfive-regs.h
@@ -11,6 +11,7 @@
 
 #define STARFIVE_AES_REGS_OFFSET		0x100
 #define STARFIVE_HASH_REGS_OFFSET		0x300
+#define STARFIVE_PKA_REGS_OFFSET		0x400
 
 union starfive_alg_cr {
 	u32 v;
@@ -26,6 +27,70 @@ union starfive_alg_cr {
 	};
 };
 
+#define STARFIVE_PKA_CACR_OFFSET		(STARFIVE_PKA_REGS_OFFSET + 0x0)
+#define STARFIVE_PKA_CASR_OFFSET		(STARFIVE_PKA_REGS_OFFSET + 0x4)
+#define STARFIVE_PKA_CAAR_OFFSET		(STARFIVE_PKA_REGS_OFFSET + 0x8)
+#define STARFIVE_PKA_CAER_OFFSET		(STARFIVE_PKA_REGS_OFFSET + 0x108)
+#define STARFIVE_PKA_CANR_OFFSET		(STARFIVE_PKA_REGS_OFFSET + 0x208)
+#define STARFIVE_PKA_CAAFR_OFFSET		(STARFIVE_PKA_REGS_OFFSET + 0x308)
+#define STARFIVE_PKA_CAEFR_OFFSET		(STARFIVE_PKA_REGS_OFFSET + 0x30c)
+#define STARFIVE_PKA_CANFR_OFFSET		(STARFIVE_PKA_REGS_OFFSET + 0x310)
+#define STARFIVE_FIFO_COUNTER_OFFSET		(STARFIVE_PKA_REGS_OFFSET + 0x314)
+
+/* R^2 mod N and N0' */
+#define CRYPTO_CMD_PRE				0x0
+/* (A + A) mod N, ==> A */
+#define CRYPTO_CMD_AAN				0x1
+/* A ^ E mod N   ==> A */
+#define CRYPTO_CMD_AMEN				0x2
+/* A + E mod N   ==> A */
+#define CRYPTO_CMD_AAEN				0x3
+/* A - E mod N   ==> A */
+#define CRYPTO_CMD_ADEN				0x4
+/* A * R mod N   ==> A */
+#define CRYPTO_CMD_ARN				0x5
+/* A * E * R mod N ==> A */
+#define CRYPTO_CMD_AERN				0x6
+/* A * A * R mod N ==> A */
+#define CRYPTO_CMD_AARN				0x7
+/* ECC2P      ==> A */
+#define CRYPTO_CMD_ECC2P			0x8
+/* ECCPQ      ==> A */
+#define CRYPTO_CMD_ECCPQ			0x9
+
+union starfive_pka_cacr {
+	u32 v;
+	struct {
+		u32 start			:1;
+		u32 reset                       :1;
+		u32 ie                          :1;
+		u32 rsvd_0                      :1;
+		u32 fifo_mode                   :1;
+		u32 not_r2                      :1;
+		u32 ecc_sub                     :1;
+		u32 pre_expf                    :1;
+		u32 cmd                         :4;
+		u32 rsvd_1                      :1;
+		u32 ctrl_dummy                  :1;
+		u32 ctrl_false                  :1;
+		u32 cln_done                    :1;
+		u32 opsize                      :6;
+		u32 rsvd_2                      :2;
+		u32 exposize                    :6;
+		u32 rsvd_3                      :1;
+		u32 bigendian                   :1;
+	};
+};
+
+union starfive_pka_casr {
+	u32 v;
+	struct {
+#define STARFIVE_PKA_DONE_FLAGS			BIT(0)
+		u32 done                        :1;
+		u32 rsvd_0                      :31;
+	};
+};
+
 #define STARFIVE_AES_AESDIO0R			(STARFIVE_AES_REGS_OFFSET + 0x0)
 #define STARFIVE_AES_KEY0			(STARFIVE_AES_REGS_OFFSET + 0x4)
 #define STARFIVE_AES_KEY1			(STARFIVE_AES_REGS_OFFSET + 0x8)
diff --git a/drivers/crypto/starfive/starfive-str.h b/drivers/crypto/starfive/starfive-str.h
index 396529a9a8f1..13e6bf637a34 100644
--- a/drivers/crypto/starfive/starfive-str.h
+++ b/drivers/crypto/starfive/starfive-str.h
@@ -10,6 +10,8 @@
 #include <crypto/engine.h>
 #include <crypto/sha2.h>
 #include <crypto/sm3.h>
+#include <crypto/internal/akcipher.h>
+#include <crypto/internal/rsa.h>
 
 #include "starfive-regs.h"
 
@@ -19,6 +21,31 @@
 #define STARFIVE_AES_IV_LEN			AES_BLOCK_SIZE
 #define STARFIVE_AES_CTR_LEN			AES_BLOCK_SIZE
 
+struct starfive_rsa_key {
+	u8					*n;
+	u8					*e;
+	u8					*d;
+	u8					*p;
+	u8					*q;
+	u8					*dp;
+	u8					*dq;
+	u8					*qinv;
+	u8					*rinv;
+	u8					*rinv_p;
+	u8					*rinv_q;
+	u8					*mp;
+	u8					*rsqr;
+	u8					*rsqr_p;
+	u8					*rsqr_q;
+	u8					*pmp;
+	u8					*qmp;
+	int					e_bitlen;
+	int					d_bitlen;
+	int					bitlen;
+	size_t					key_sz;
+	bool					crt_mode;
+};
+
 struct starfive_sec_ctx {
 	struct crypto_engine_ctx		enginectx;
 	struct starfive_sec_dev			*sdev;
@@ -28,9 +55,12 @@ struct starfive_sec_ctx {
 	int					keylen;
 	struct scatterlist			sg[2];
 	size_t					hash_len_total;
+	size_t					rsa_key_sz;
+	struct starfive_rsa_key			rsa_key;
 	u8					*buffer;
 
 	union {
+		struct crypto_akcipher		*akcipher;
 		struct crypto_aead		*aead;
 		struct crypto_shash		*shash;
 	} fallback;
@@ -49,6 +79,7 @@ struct starfive_sec_dev {
 	phys_addr_t				io_phys_base;
 	void					*aes_data;
 	void					*hash_data;
+	void					*pka_data;
 
 	size_t					data_buf_len;
 	int					pages_count;
@@ -88,6 +119,7 @@ struct starfive_sec_request_ctx {
 	union {
 		union starfive_aes_csr		aes;
 		union starfive_hash_csr		hash;
+		union starfive_pka_cacr		pka;
 	} csr;
 
 	struct scatterlist			*in_sg;
@@ -156,4 +188,7 @@ void starfive_hash_unregister_algs(void);
 int starfive_aes_register_algs(void);
 void starfive_aes_unregister_algs(void);
 
+int starfive_pka_register_algs(void);
+void starfive_pka_unregister_algs(void);
+
 #endif
-- 
2.25.1

