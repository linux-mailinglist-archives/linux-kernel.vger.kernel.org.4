Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B66E70472D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjEPH6N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 16 May 2023 03:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjEPH6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:58:09 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A31A1FD8;
        Tue, 16 May 2023 00:58:04 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id C499F24E1B7;
        Tue, 16 May 2023 15:58:02 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 16 May
 2023 15:58:03 +0800
Received: from ubuntu.localdomain (202.188.176.82) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 16 May
 2023 15:58:00 +0800
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Subject: [PATCH 2/2] crypto: starfive - Add RSA algo support
Date:   Tue, 16 May 2023 15:57:52 +0800
Message-ID: <20230516075752.659287-3-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230516075752.659287-1-jiajie.ho@starfivetech.com>
References: <20230516075752.659287-1-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding RSA enc/dec and sign/verify feature for StarFive cryptographic
module. The module only supports mod sizes up to 2048, therefore
calculations more than that will use fallback algo.

Co-developed-by: Huan Feng <huan.feng@starfivetech.com>
Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 drivers/crypto/starfive/Kconfig       |   1 +
 drivers/crypto/starfive/Makefile      |   2 +-
 drivers/crypto/starfive/jh7110-cryp.c |  20 +-
 drivers/crypto/starfive/jh7110-cryp.h |  45 ++
 drivers/crypto/starfive/jh7110-rsa.c  | 618 ++++++++++++++++++++++++++
 5 files changed, 684 insertions(+), 2 deletions(-)
 create mode 100644 drivers/crypto/starfive/jh7110-rsa.c

diff --git a/drivers/crypto/starfive/Kconfig b/drivers/crypto/starfive/Kconfig
index be58d1473523..d664757b7ec1 100644
--- a/drivers/crypto/starfive/Kconfig
+++ b/drivers/crypto/starfive/Kconfig
@@ -10,6 +10,7 @@ config CRYPTO_DEV_JH7110
 	select CRYPTO_SHA256
 	select CRYPTO_SHA512
 	select CRYPTO_SM3_GENERIC
+	select CRYPTO_RSA
 	select ARM_AMBA
 	select DMADEVICES
 	select AMBA_PL08X
diff --git a/drivers/crypto/starfive/Makefile b/drivers/crypto/starfive/Makefile
index 2af49062e36d..98b01d2f1ccf 100644
--- a/drivers/crypto/starfive/Makefile
+++ b/drivers/crypto/starfive/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_CRYPTO_DEV_JH7110) += jh7110-crypto.o
-jh7110-crypto-objs := jh7110-cryp.o jh7110-hash.o
+jh7110-crypto-objs := jh7110-cryp.o jh7110-hash.o jh7110-rsa.o
diff --git a/drivers/crypto/starfive/jh7110-cryp.c b/drivers/crypto/starfive/jh7110-cryp.c
index 279b19f51cb4..cc43556b6c80 100644
--- a/drivers/crypto/starfive/jh7110-cryp.c
+++ b/drivers/crypto/starfive/jh7110-cryp.c
@@ -86,10 +86,19 @@ static irqreturn_t starfive_cryp_irq(int irq, void *priv)
 
 	status = readl(cryp->base + STARFIVE_IE_FLAG_OFFSET);
 	if (status & STARFIVE_IE_FLAG_HASH_DONE) {
-		writel(STARFIVE_IE_MASK_HASH_DONE, cryp->base + STARFIVE_IE_MASK_OFFSET);
+		status = readl(cryp->base + STARFIVE_IE_MASK_OFFSET);
+		status |= STARFIVE_IE_MASK_HASH_DONE;
+		writel(status, cryp->base + STARFIVE_IE_MASK_OFFSET);
 		tasklet_schedule(&cryp->hash_done);
 	}
 
+	if (status & STARFIVE_IE_FLAG_PKA_DONE) {
+		status = readl(cryp->base + STARFIVE_IE_MASK_OFFSET);
+		status |= STARFIVE_IE_MASK_PKA_DONE;
+		writel(status, cryp->base + STARFIVE_IE_MASK_OFFSET);
+		complete(&cryp->pka_done);
+	}
+
 	return IRQ_HANDLED;
 }
 
@@ -132,6 +141,8 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(cryp->rst),
 				     "Error getting hardware reset line\n");
 
+	init_completion(&cryp->pka_done);
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
@@ -173,8 +184,14 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_algs_hash;
 
+	ret = starfive_rsa_register_algs();
+	if (ret)
+		goto err_algs_rsa;
+
 	return 0;
 
+err_algs_rsa:
+	starfive_hash_unregister_algs();
 err_algs_hash:
 	crypto_engine_stop(cryp->engine);
 err_engine_start:
@@ -200,6 +217,7 @@ static int starfive_cryp_remove(struct platform_device *pdev)
 	struct starfive_cryp_dev *cryp = platform_get_drvdata(pdev);
 
 	starfive_hash_unregister_algs();
+	starfive_rsa_unregister_algs();
 
 	tasklet_kill(&cryp->hash_done);
 
diff --git a/drivers/crypto/starfive/jh7110-cryp.h b/drivers/crypto/starfive/jh7110-cryp.h
index 021d6e24bc86..0cdcffc0d7d4 100644
--- a/drivers/crypto/starfive/jh7110-cryp.h
+++ b/drivers/crypto/starfive/jh7110-cryp.h
@@ -18,7 +18,9 @@
 #define STARFIVE_DMA_OUT_LEN_OFFSET		0x14
 
 #define STARFIVE_IE_MASK_HASH_DONE		0x4
+#define STARFIVE_IE_MASK_PKA_DONE		0x8
 #define STARFIVE_IE_FLAG_HASH_DONE		0x4
+#define STARFIVE_IE_FLAG_PKA_DONE		0x8
 
 #define STARFIVE_MSG_BUFFER_SIZE		SZ_16K
 #define MAX_KEY_SIZE				SHA512_BLOCK_SIZE
@@ -54,6 +56,39 @@ union starfive_hash_csr {
 	};
 };
 
+union starfive_pka_cacr {
+	u32 v;
+	struct {
+		u32 start			:1;
+		u32 reset			:1;
+		u32 ie				:1;
+		u32 rsvd_0			:1;
+		u32 fifo_mode			:1;
+		u32 not_r2			:1;
+		u32 ecc_sub			:1;
+		u32 pre_expf			:1;
+		u32 cmd				:4;
+		u32 rsvd_1			:1;
+		u32 ctrl_dummy			:1;
+		u32 ctrl_false			:1;
+		u32 cln_done			:1;
+		u32 opsize			:6;
+		u32 rsvd_2			:2;
+		u32 exposize			:6;
+		u32 rsvd_3			:1;
+		u32 bigendian			:1;
+	};
+};
+
+struct starfive_rsa_key {
+	u8	*n;
+	u8	*e;
+	u8	*d;
+	int	e_bitlen;
+	int	d_bitlen;
+	int	bitlen;
+	size_t	key_sz;
+};
 
 union starfive_alg_cr {
 	u32 v;
@@ -78,6 +113,8 @@ struct starfive_cryp_ctx {
 	u8					key[MAX_KEY_SIZE];
 	int					keylen;
 	bool					is_hmac;
+	struct starfive_rsa_key			rsa_key;
+	struct crypto_akcipher			*akcipher_fbk;
 	struct crypto_ahash			*ahash_fbk;
 };
 
@@ -98,6 +135,7 @@ struct starfive_cryp_dev {
 	struct dma_slave_config			cfg_out;
 	struct crypto_engine			*engine;
 	struct tasklet_struct			hash_done;
+	struct completion			pka_done;
 	int					err;
 	union starfive_alg_cr			alg_cr;
 	union {
@@ -108,14 +146,18 @@ struct starfive_cryp_dev {
 struct starfive_cryp_request_ctx {
 	union {
 		union starfive_hash_csr		hash;
+		union starfive_pka_cacr		pka;
 	} csr;
 
 	struct scatterlist			*in_sg;
+	struct scatterlist			*out_sg;
 	struct ahash_request			ahash_fbk_req;
 	size_t					total;
+	size_t					nents;
 	unsigned int				blksize;
 	unsigned int				digsize;
 	unsigned long				in_sg_len;
+	u8 rsa_data[] __aligned(sizeof(u32));
 };
 
 struct starfive_cryp_dev *starfive_cryp_find_dev(struct starfive_cryp_ctx *ctx);
@@ -123,5 +165,8 @@ struct starfive_cryp_dev *starfive_cryp_find_dev(struct starfive_cryp_ctx *ctx);
 int starfive_hash_register_algs(void);
 void starfive_hash_unregister_algs(void);
 
+int starfive_rsa_register_algs(void);
+void starfive_rsa_unregister_algs(void);
+
 void starfive_hash_done_task(unsigned long param);
 #endif
diff --git a/drivers/crypto/starfive/jh7110-rsa.c b/drivers/crypto/starfive/jh7110-rsa.c
new file mode 100644
index 000000000000..a85a09495605
--- /dev/null
+++ b/drivers/crypto/starfive/jh7110-rsa.c
@@ -0,0 +1,618 @@
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
+#include <crypto/akcipher.h>
+#include <crypto/algapi.h>
+#include <crypto/internal/akcipher.h>
+#include <crypto/internal/rsa.h>
+#include <crypto/scatterwalk.h>
+
+#include "jh7110-cryp.h"
+
+#define STARFIVE_PKA_REGS_OFFSET	0x400
+#define STARFIVE_PKA_CACR_OFFSET	(STARFIVE_PKA_REGS_OFFSET + 0x0)
+#define STARFIVE_PKA_CASR_OFFSET	(STARFIVE_PKA_REGS_OFFSET + 0x4)
+#define STARFIVE_PKA_CAAR_OFFSET	(STARFIVE_PKA_REGS_OFFSET + 0x8)
+#define STARFIVE_PKA_CAER_OFFSET	(STARFIVE_PKA_REGS_OFFSET + 0x108)
+#define STARFIVE_PKA_CANR_OFFSET	(STARFIVE_PKA_REGS_OFFSET + 0x208)
+
+// R^2 mod N and N0'
+#define CRYPTO_CMD_PRE			0x0
+// A * R mod N   ==> A
+#define CRYPTO_CMD_ARN			0x5
+// A * E * R mod N ==> A
+#define CRYPTO_CMD_AERN			0x6
+// A * A * R mod N ==> A
+#define CRYPTO_CMD_AARN			0x7
+
+#define STARFIVE_RSA_MAX_KEYSZ		256
+#define STARFIVE_RSA_RESET		0x2
+
+static inline int starfive_pka_wait_done(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+
+	return wait_for_completion_timeout(&cryp->pka_done,
+					   usecs_to_jiffies(100000));
+}
+
+static inline void starfive_pka_irq_mask_clear(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	u32 stat;
+
+	reinit_completion(&cryp->pka_done);
+
+	stat = readl(cryp->base + STARFIVE_IE_MASK_OFFSET);
+	stat &= ~STARFIVE_IE_MASK_PKA_DONE;
+	writel(stat, cryp->base + STARFIVE_IE_MASK_OFFSET);
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
+static int starfive_rsa_montgomery_form(struct starfive_cryp_ctx *ctx,
+					u32 *out, u32 *in, u8 mont,
+					u32 *mod, int bit_len)
+{
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
+	int count = rctx->total / sizeof(u32) - 1;
+	int loop;
+	u32 temp;
+	u8 opsize;
+
+	opsize = (bit_len - 1) >> 5;
+	rctx->csr.pka.v = 0;
+
+	writel(rctx->csr.pka.v, cryp->base + STARFIVE_PKA_CACR_OFFSET);
+
+	for (loop = 0; loop <= opsize; loop++)
+		writel(mod[opsize - loop], cryp->base + STARFIVE_PKA_CANR_OFFSET + loop * 4);
+
+	if (mont) {
+		rctx->csr.pka.v = 0;
+		rctx->csr.pka.cln_done = 1;
+		rctx->csr.pka.opsize = opsize;
+		rctx->csr.pka.exposize = opsize;
+		rctx->csr.pka.cmd = CRYPTO_CMD_PRE;
+		rctx->csr.pka.start = 1;
+		rctx->csr.pka.not_r2 = 1;
+		rctx->csr.pka.ie = 1;
+
+		starfive_pka_irq_mask_clear(ctx);
+		writel(rctx->csr.pka.v, cryp->base + STARFIVE_PKA_CACR_OFFSET);
+
+		if (!starfive_pka_wait_done(ctx))
+			return -ETIMEDOUT;
+
+		for (loop = 0; loop <= opsize; loop++)
+			writel(in[opsize - loop], cryp->base + STARFIVE_PKA_CAAR_OFFSET + loop * 4);
+
+		writel(0x1000000, cryp->base + STARFIVE_PKA_CAER_OFFSET);
+
+		for (loop = 1; loop <= opsize; loop++)
+			writel(0, cryp->base + STARFIVE_PKA_CAER_OFFSET + loop * 4);
+
+		rctx->csr.pka.v = 0;
+		rctx->csr.pka.cln_done = 1;
+		rctx->csr.pka.opsize = opsize;
+		rctx->csr.pka.exposize = opsize;
+		rctx->csr.pka.cmd = CRYPTO_CMD_AERN;
+		rctx->csr.pka.start = 1;
+		rctx->csr.pka.ie = 1;
+
+		starfive_pka_irq_mask_clear(ctx);
+		writel(rctx->csr.pka.v, cryp->base + STARFIVE_PKA_CACR_OFFSET);
+
+		if (!starfive_pka_wait_done(ctx))
+			return -ETIMEDOUT;
+	} else {
+		rctx->csr.pka.v = 0;
+		rctx->csr.pka.cln_done = 1;
+		rctx->csr.pka.opsize = opsize;
+		rctx->csr.pka.exposize = opsize;
+		rctx->csr.pka.cmd = CRYPTO_CMD_PRE;
+		rctx->csr.pka.start = 1;
+		rctx->csr.pka.pre_expf = 1;
+		rctx->csr.pka.ie = 1;
+
+		starfive_pka_irq_mask_clear(ctx);
+		writel(rctx->csr.pka.v, cryp->base + STARFIVE_PKA_CACR_OFFSET);
+
+		if (!starfive_pka_wait_done(ctx))
+			return -ETIMEDOUT;
+
+		for (loop = 0; loop <= count; loop++)
+			writel(in[count - loop], cryp->base + STARFIVE_PKA_CAER_OFFSET + loop * 4);
+
+		/*pad with 0 up to opsize*/
+		for (loop = count + 1; loop <= opsize; loop++)
+			writel(0x0, cryp->base + STARFIVE_PKA_CAER_OFFSET + loop * 4);
+
+		rctx->csr.pka.v = 0;
+		rctx->csr.pka.cln_done = 1;
+		rctx->csr.pka.opsize = opsize;
+		rctx->csr.pka.exposize = opsize;
+		rctx->csr.pka.cmd = CRYPTO_CMD_ARN;
+		rctx->csr.pka.start = 1;
+		rctx->csr.pka.ie = 1;
+
+		starfive_pka_irq_mask_clear(ctx);
+		writel(rctx->csr.pka.v, cryp->base + STARFIVE_PKA_CACR_OFFSET);
+
+		if (!starfive_pka_wait_done(ctx))
+			return -ETIMEDOUT;
+	}
+
+	for (loop = 0; loop <= opsize; loop++) {
+		temp = readl(cryp->base + STARFIVE_PKA_CAAR_OFFSET + 0x4 * loop);
+		out[opsize - loop] = temp;
+	}
+
+	return 0;
+}
+
+static int starfive_rsa_cpu_start(struct starfive_cryp_ctx *ctx, u32 *result,
+				  u8 *de, u32 *n, int key_sz)
+{
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
+	struct starfive_rsa_key *key = &ctx->rsa_key;
+	u32 temp;
+	int ret = 0;
+	int opsize, mlen, loop;
+	unsigned int *mta;
+
+	opsize = (key_sz - 1) >> 2;
+
+	mta = kmalloc(key_sz, GFP_KERNEL);
+	if (!mta)
+		return -ENOMEM;
+
+	ret = starfive_rsa_montgomery_form(ctx, mta, (u32 *)rctx->rsa_data,
+					   0, n, key_sz << 3);
+	if (ret) {
+		dev_err_probe(cryp->dev, ret, "Conversion to Montgomery failed");
+		goto rsa_err;
+	}
+
+	for (loop = 0; loop <= opsize; loop++)
+		writel(mta[opsize - loop],
+		       cryp->base + STARFIVE_PKA_CAER_OFFSET + loop * 4);
+
+	for (loop = key->bitlen - 1; loop > 0; loop--) {
+		mlen = starfive_rsa_get_nbit(de, loop - 1, key_sz);
+
+		rctx->csr.pka.v = 0;
+		rctx->csr.pka.cln_done = 1;
+		rctx->csr.pka.opsize = opsize;
+		rctx->csr.pka.exposize = opsize;
+		rctx->csr.pka.cmd = CRYPTO_CMD_AARN;
+		rctx->csr.pka.start = 1;
+		rctx->csr.pka.ie = 1;
+
+		starfive_pka_irq_mask_clear(ctx);
+		writel(rctx->csr.pka.v, cryp->base + STARFIVE_PKA_CACR_OFFSET);
+
+		ret = -ETIMEDOUT;
+		if (!starfive_pka_wait_done(ctx))
+			goto rsa_err;
+
+		if (mlen) {
+			rctx->csr.pka.v = 0;
+			rctx->csr.pka.cln_done = 1;
+			rctx->csr.pka.opsize = opsize;
+			rctx->csr.pka.exposize = opsize;
+			rctx->csr.pka.cmd = CRYPTO_CMD_AERN;
+			rctx->csr.pka.start = 1;
+			rctx->csr.pka.ie = 1;
+
+			starfive_pka_irq_mask_clear(ctx);
+			writel(rctx->csr.pka.v, cryp->base + STARFIVE_PKA_CACR_OFFSET);
+
+			if (!starfive_pka_wait_done(ctx))
+				goto rsa_err;
+		}
+	}
+
+	for (loop = 0; loop <= opsize; loop++) {
+		temp = readl(cryp->base + STARFIVE_PKA_CAAR_OFFSET + 0x4 * loop);
+		result[opsize - loop] = temp;
+	}
+
+	ret = starfive_rsa_montgomery_form(ctx, result, result, 1, n, key_sz << 3);
+	if (ret)
+		dev_err_probe(cryp->dev, ret, "Conversion from Montgomery failed");
+rsa_err:
+	kfree(mta);
+	return ret;
+}
+
+static int starfive_rsa_start(struct starfive_cryp_ctx *ctx, u8 *result,
+			      u8 *de, u8 *n, int key_sz)
+{
+	return starfive_rsa_cpu_start(ctx, (u32 *)result, de, (u32 *)n, key_sz);
+}
+
+static int starfive_rsa_enc_core(struct starfive_cryp_ctx *ctx, int enc)
+{
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
+	struct starfive_rsa_key *key = &ctx->rsa_key;
+	int ret = 0;
+
+	writel(STARFIVE_RSA_RESET, cryp->base + STARFIVE_PKA_CACR_OFFSET);
+
+	rctx->total = sg_copy_to_buffer(rctx->in_sg, rctx->nents,
+					rctx->rsa_data, rctx->total);
+
+	if (enc) {
+		key->bitlen = key->e_bitlen;
+		ret = starfive_rsa_start(ctx, rctx->rsa_data, key->e,
+					 key->n, key->key_sz);
+	} else {
+		key->bitlen = key->d_bitlen;
+		ret = starfive_rsa_start(ctx, rctx->rsa_data, key->d,
+					 key->n, key->key_sz);
+	}
+
+	if (ret)
+		goto err_rsa_crypt;
+
+	sg_copy_buffer(rctx->out_sg, sg_nents(rctx->out_sg),
+		       rctx->rsa_data, key->key_sz, 0, 0);
+
+err_rsa_crypt:
+	writel(STARFIVE_RSA_RESET, cryp->base + STARFIVE_PKA_CACR_OFFSET);
+	kfree(rctx->rsa_data);
+	return ret;
+}
+
+static int starfive_rsa_enc(struct akcipher_request *req)
+{
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct starfive_cryp_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct starfive_rsa_key *key = &ctx->rsa_key;
+	struct starfive_cryp_request_ctx *rctx = akcipher_request_ctx(req);
+	int ret;
+
+	if (!key->key_sz) {
+		akcipher_request_set_tfm(req, ctx->akcipher_fbk);
+		ret = crypto_akcipher_encrypt(req);
+		akcipher_request_set_tfm(req, tfm);
+		return ret;
+	}
+
+	if (unlikely(!key->n || !key->e))
+		return -EINVAL;
+
+	if (req->dst_len < key->key_sz)
+		return dev_err_probe(cryp->dev, -EOVERFLOW,
+				     "Output buffer length less than parameter n\n");
+
+	rctx->in_sg = req->src;
+	rctx->out_sg = req->dst;
+	rctx->total = req->src_len;
+	rctx->nents = sg_nents(rctx->in_sg);
+	ctx->rctx = rctx;
+
+	return starfive_rsa_enc_core(ctx, 1);
+}
+
+static int starfive_rsa_dec(struct akcipher_request *req)
+{
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct starfive_cryp_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct starfive_rsa_key *key = &ctx->rsa_key;
+	struct starfive_cryp_request_ctx *rctx = akcipher_request_ctx(req);
+	int ret;
+
+	if (!key->key_sz) {
+		akcipher_request_set_tfm(req, ctx->akcipher_fbk);
+		ret = crypto_akcipher_decrypt(req);
+		akcipher_request_set_tfm(req, tfm);
+		return ret;
+	}
+
+	if (unlikely(!key->n || !key->d))
+		return -EINVAL;
+
+	if (req->dst_len < key->key_sz)
+		return dev_err_probe(cryp->dev, -EOVERFLOW,
+				     "Output buffer length less than parameter n\n");
+
+	rctx->in_sg = req->src;
+	rctx->out_sg = req->dst;
+	ctx->rctx = rctx;
+	rctx->total = req->src_len;
+
+	return starfive_rsa_enc_core(ctx, 0);
+}
+
+static int starfive_rsa_set_n(struct starfive_rsa_key *rsa_key,
+			      const char *value, size_t vlen)
+{
+	const char *ptr = value;
+	unsigned int bitslen;
+	int ret;
+
+	while (!*ptr && vlen) {
+		ptr++;
+		vlen--;
+	}
+	rsa_key->key_sz = vlen;
+	bitslen = rsa_key->key_sz << 3;
+
+	/* check valid key size */
+	if (bitslen & 0x1f)
+		return -EINVAL;
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
+	struct starfive_cryp_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct rsa_key raw_key = {NULL};
+	struct starfive_rsa_key *rsa_key = &ctx->rsa_key;
+	int ret;
+
+	if (private)
+		ret = rsa_parse_priv_key(&raw_key, key, keylen);
+	else
+		ret = rsa_parse_pub_key(&raw_key, key, keylen);
+	if (ret < 0)
+		goto err;
+
+	starfive_rsa_free_key(rsa_key);
+
+	/* Use fallback for mod > 256 + 1 byte prefix */
+	if (raw_key.n_sz > STARFIVE_RSA_MAX_KEYSZ + 1)
+		return 0;
+
+	ret = starfive_rsa_set_n(rsa_key, raw_key.n, raw_key.n_sz);
+	if (ret)
+		return ret;
+
+	ret = starfive_rsa_set_e(rsa_key, raw_key.e, raw_key.e_sz);
+	if (ret)
+		goto err;
+
+	if (private) {
+		ret = starfive_rsa_set_d(rsa_key, raw_key.d, raw_key.d_sz);
+		if (ret)
+			goto err;
+	}
+
+	if (!rsa_key->n || !rsa_key->e) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (private && !rsa_key->d) {
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
+	struct starfive_cryp_ctx *ctx = akcipher_tfm_ctx(tfm);
+	int ret;
+
+	ret = crypto_akcipher_set_pub_key(ctx->akcipher_fbk, key, keylen);
+	if (ret)
+		return ret;
+
+	return starfive_rsa_setkey(tfm, key, keylen, false);
+}
+
+static int starfive_rsa_set_priv_key(struct crypto_akcipher *tfm, const void *key,
+				     unsigned int keylen)
+{
+	struct starfive_cryp_ctx *ctx = akcipher_tfm_ctx(tfm);
+	int ret;
+
+	ret = crypto_akcipher_set_priv_key(ctx->akcipher_fbk, key, keylen);
+	if (ret)
+		return ret;
+
+	return starfive_rsa_setkey(tfm, key, keylen, true);
+}
+
+static unsigned int starfive_rsa_max_size(struct crypto_akcipher *tfm)
+{
+	struct starfive_cryp_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	if (ctx->rsa_key.key_sz)
+		return ctx->rsa_key.key_sz;
+
+	return crypto_akcipher_maxsize(ctx->akcipher_fbk);
+}
+
+static int starfive_rsa_init_tfm(struct crypto_akcipher *tfm)
+{
+	struct starfive_cryp_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	ctx->akcipher_fbk = crypto_alloc_akcipher("rsa-generic", 0, 0);
+	if (IS_ERR(ctx->akcipher_fbk))
+		return PTR_ERR(ctx->akcipher_fbk);
+
+	ctx->cryp = starfive_cryp_find_dev(ctx);
+	if (!ctx->cryp) {
+		crypto_free_akcipher(ctx->akcipher_fbk);
+		return -ENODEV;
+	}
+
+	akcipher_set_reqsize(tfm, sizeof(struct starfive_cryp_request_ctx) +
+			     crypto_akcipher_reqsize(ctx->akcipher_fbk));
+
+	return 0;
+}
+
+static void starfive_rsa_exit_tfm(struct crypto_akcipher *tfm)
+{
+	struct starfive_cryp_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct starfive_rsa_key *key = (struct starfive_rsa_key *)&ctx->rsa_key;
+
+	crypto_free_akcipher(ctx->akcipher_fbk);
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
+	.base = {
+		.cra_name = "rsa",
+		.cra_driver_name = "starfive-rsa",
+		.cra_flags = CRYPTO_ALG_TYPE_AKCIPHER |
+			     CRYPTO_ALG_ASYNC |
+			     CRYPTO_ALG_NEED_FALLBACK,
+		.cra_priority = 3000,
+		.cra_module = THIS_MODULE,
+		.cra_ctxsize = sizeof(struct starfive_cryp_ctx),
+	},
+};
+
+int starfive_rsa_register_algs(void)
+{
+	return crypto_register_akcipher(&starfive_rsa);
+}
+
+void starfive_rsa_unregister_algs(void)
+{
+	crypto_unregister_akcipher(&starfive_rsa);
+}
-- 
2.25.1

