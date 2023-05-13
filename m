Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A709701523
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 09:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjEMHpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 03:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbjEMHos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 03:44:48 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802682729;
        Sat, 13 May 2023 00:44:44 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6436e075166so8122387b3a.0;
        Sat, 13 May 2023 00:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683963884; x=1686555884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EyjwG6MKCQXmV9JPg+U692U+dAVpezVPacDXJh0Vk0=;
        b=KF27j1V7t38Y7ifvJ+oxed0mc07/HFW74IE4yA5+4gRMZKs3tQa7iJKxEulToEfEha
         EfKdPnl1Bxma8tfYO13/lFvzxSQm0v7MaPIOZcThAIrrSF0JxoLini76BzZqbepXo04O
         2phIHIqaAMfVFE3b+YVdFEcEIVPWhJ9bHtzyH8VEkpc0TYmnjXFrgokPtwSD4SE/jZjE
         Uy2C2XEyCn986MgV31slA1xJXeOB76gMB59u/DMyfoNKdzHzHXIqpJJtuQi8H25bmbpY
         6/OSqCZamcgehKDmgWMDNPlhwJwx36ppRL9GXckippokfGHtAYsrxKUD/Ra1Uvo/9IDC
         gYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683963884; x=1686555884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9EyjwG6MKCQXmV9JPg+U692U+dAVpezVPacDXJh0Vk0=;
        b=PR1D+ozQled8x6hK3U8cX21zk8cKz5BSBth9GwjfLUyEHOqO9djdF6TR0gtzhw3CWK
         EivppQv3zG/kK6/1YzgcCL+m7lDAlOqGgpm8jWhK83/DpRUc+KB7anc8opkNF9uyjfUi
         JecNMwveJ3spxkaFdLW/iS9ppw7bZ+0hQF7O/KJf0nzv2e5cxghwREC99YWSqdrY+Wpn
         WfyFVkD+XLK1gfeB1IuHhQg8mMM3PxPayaAq5zr7j+JNPzaNHj7YRARy2jdQQFUNqsSh
         Vbn7H5SsH2cJmf7pj8A12WWqOhXexQcPmvZcQk4NXUmkPGzAB4rXsNdBs/AQt6B6Bl5p
         RfVw==
X-Gm-Message-State: AC+VfDzvtC0d0B+4aX2F29WsmSQmcLH20NYk8EfasIH5U6fWGvKmmRXO
        Ia2yDQ204smt7C7kAfYMlr3rm9MUJKDmd8IrXD4PgA==
X-Google-Smtp-Source: ACHHUZ6MMoaJdut3CYKaTh+jBH6ttyNFoeaDlJDhF0AzkNBJgF9NiBRBUR7C7uIJmEW6dFggNWmM1w==
X-Received: by 2002:a05:6a00:23d3:b0:63d:4752:4da3 with SMTP id g19-20020a056a0023d300b0063d47524da3mr35876240pfc.25.1683963883614;
        Sat, 13 May 2023 00:44:43 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.199])
        by smtp.gmail.com with ESMTPSA id u19-20020aa78393000000b006242f4a8945sm8128895pfm.182.2023.05.13.00.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 00:44:43 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>, Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] crypto: hisilicon/advca - Add SHA support
Date:   Sat, 13 May 2023 15:43:22 +0800
Message-Id: <20230513074339.266879-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230513074339.266879-1-mmyangfl@gmail.com>
References: <20230513074339.266879-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for SHA algorithm family.

Support for state injection was not tested due to lack of such device.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/crypto/hisilicon/Kconfig              |   3 +
 drivers/crypto/hisilicon/advca/Makefile       |   1 +
 .../crypto/hisilicon/advca/hisi-advca-sha.c   | 644 ++++++++++++++++++
 3 files changed, 648 insertions(+)
 create mode 100644 drivers/crypto/hisilicon/advca/hisi-advca-sha.c

diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
index 99279a9ec6b1..6e94f56e9a2c 100644
--- a/drivers/crypto/hisilicon/Kconfig
+++ b/drivers/crypto/hisilicon/Kconfig
@@ -4,6 +4,9 @@ config CRYPTO_DEV_HISI_ADVCA
 	tristate "Support for Hisilicon ADVCA Subsystem"
 	depends on ARCH_HISI || COMPILE_TEST
 	select CRYPTO_SKCIPHER
+	select CRYPTO_HASH
+	select CRYPTO_SHA1
+	select CRYPTO_SHA256
 	help
 	  Support for Hisilicon ADVCA (Advanced Conditional Access) Subsystem,
 	  which can be found on HiSilicon STB SoCs, such as Hi37xx.
diff --git a/drivers/crypto/hisilicon/advca/Makefile b/drivers/crypto/hisilicon/advca/Makefile
index 3f64b4a24e9e..e556d3f81729 100644
--- a/drivers/crypto/hisilicon/advca/Makefile
+++ b/drivers/crypto/hisilicon/advca/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_CRYPTO_DEV_HISI_ADVCA) += hisi-advca-muc.o
+obj-$(CONFIG_CRYPTO_DEV_HISI_ADVCA) += hisi-advca-sha.o
diff --git a/drivers/crypto/hisilicon/advca/hisi-advca-sha.c b/drivers/crypto/hisilicon/advca/hisi-advca-sha.c
new file mode 100644
index 000000000000..b466fe766bff
--- /dev/null
+++ b/drivers/crypto/hisilicon/advca/hisi-advca-sha.c
@@ -0,0 +1,644 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * SHA - hash device for SHA1/2
+ *
+ * Copyright (c) 2023 David Yang
+ */
+
+#include <crypto/internal/hash.h>
+#include <crypto/sha1.h>
+#include <crypto/sha2.h>
+#include <linux/clk.h>
+#include <linux/crypto.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/string.h>
+
+/******** hardware definitions ********/
+
+#define SHA_TOTAL_LEN_LOW	0x00
+#define SHA_TOTAL_LEN_HIGH	0x04
+#define SHA_STATUS		0x08
+#define  SHA_HASH_READY			BIT(0)
+#define  SHA_DMA_READY			BIT(1)
+#define  SHA_MSG_READY			BIT(2)
+#define  SHA_RECORD_READY		BIT(3)
+#define  SHA_ERR_STATE			GENMASK(5, 4)
+#define  SHA_LEN_ERR			BIT(6)
+#define SHA_CTRL		0x0c
+#define  SHA_SINGLE_READ		BIT(0)
+#define  SHA_ALG			GENMASK(2, 1)
+#define   SHA_ALG_SHA1				0
+#define   SHA_ALG_SHA256			1
+#define   SHA_ALG_SHA224			5
+#define  SHA_HMAC			BIT(3)
+#define  SHA_KEY_FROM_CPU		BIT(4)
+#define  SHA_ENDIAN			BIT(5)
+#define  SHA_USED_BY_ARM		BIT(6)  /* v1 only */
+#define  SHA_USED_BY_C51		BIT(7)  /* v1 only */
+#define  SHA_SET_INIT			BIT(6)  /* v2 only */
+#define SHA_START		0x10
+#define  SHA_START_BIT			BIT(0)
+#define SHA_DMA_ADDR		0x14
+#define SHA_DMA_LEN		0x18
+#define SHA_DATA_IN		0x1c
+#define SHA_RECORD_LEN_LOW	0x20
+#define SHA_RECORD_LEN_HIGH	0x24
+#define SHA_OUT0		0x30  /* till 7 (0x4c) */
+#define SHA_MCU_KEY0		0x70  /* till 3 (0x7c) */
+#define SHA_KL_KEY0		0x80  /* till 3 (0x8c) */
+#define SHA_INIT0		0x90  /* till 7 (0xac) */
+
+#define SHA_KEY_SIZE	16u
+#define SHA_DIGEST_SIZE	32u
+#define SHA_BLOCK_SIZE	64u
+
+/******** driver definitions ********/
+
+#define SHA_TYPE_HASH	0
+/* untested; test it before use */
+#define SHA_TYPE_MHASH	1
+
+struct hica_sha_ctrl {
+	unsigned int alg;
+};
+
+struct hica_sha_alg {
+	struct shash_alg alg;
+	struct hica_sha_ctrl ctrl;
+	struct hica_sha_priv *priv;
+};
+
+struct hica_sha_tmpl {
+	struct hica_sha_ctrl ctrl;
+
+	unsigned int digestsize;
+	unsigned int statesize;
+	unsigned int blocksize;
+
+	int (*update)(struct shash_desc *desc, const u8 *data,
+		      unsigned int len);
+
+	const char *alg_name;
+};
+
+struct hica_sha_priv {
+	void __iomem *base;
+	unsigned int type;
+
+	struct device *dev;
+	struct hica_sha_alg *algs;
+	unsigned int algs_num;
+
+	struct reset_control *rst;
+	struct clk_bulk_data *clks;
+	unsigned int clks_num;
+
+	struct mutex lock;
+};
+
+struct hica_sha_tfm_ctx {
+	struct hica_sha_priv *priv;
+	struct hica_sha_ctrl ctrl;
+
+	unsigned int digestsize;
+	unsigned int blocksize;
+
+	struct crypto_shash *fallback;
+};
+
+struct hica_sha_desc_ctx {
+	bool bypass;
+
+	/* keep this at the end of struct! */
+	struct shash_desc fallback;
+};
+
+static unsigned int bypass_size = 16 * SHA_BLOCK_SIZE;
+module_param(bypass_size, uint, 0644);
+
+/******** reg ********/
+
+static int hica_sha_wait(const struct hica_sha_priv *priv, u32 mask)
+{
+	u32 val;
+
+	return readl_relaxed_poll_timeout(priv->base + SHA_STATUS, val,
+					  val & mask, 1000, 500 * 1000);
+}
+
+static int hica_sha_record(const struct hica_sha_priv *priv, dma_addr_t addr,
+			   unsigned int len)
+{
+	if (WARN_ON(addr & 3 || len & 3))
+		return -EINVAL;
+
+	if (hica_sha_wait(priv, SHA_RECORD_READY))
+		return -ETIMEDOUT;
+
+	writel_relaxed(addr, priv->base + SHA_DMA_ADDR);
+	writel(len, priv->base + SHA_DMA_LEN);
+	return 0;
+}
+
+static int hica_sha_init(const struct hica_sha_priv *priv,
+			 const struct hica_sha_ctrl *ctrl, const void *state)
+{
+	void __iomem *init = priv->base + SHA_INIT0;
+	u32 val;
+	int ret;
+
+	/* re-enable SHA_START */
+	ret = reset_control_assert(priv->rst) ?:
+	      reset_control_deassert(priv->rst);
+	if (ret)
+		return ret;
+
+	/* config SHA_CTRL */
+	val = readl_relaxed(priv->base + SHA_CTRL);
+
+	val &= ~SHA_SINGLE_READ;
+	val &= ~SHA_ALG;
+	val |= (ctrl->alg << 1) & SHA_ALG;
+	val &= ~SHA_HMAC;
+	val |= SHA_ENDIAN;
+
+	if (priv->type == SHA_TYPE_HASH)
+		val |= SHA_USED_BY_ARM;
+	else if (state) {
+		for (unsigned int i = 0; i < SHA_DIGEST_SIZE; i += sizeof(u32))
+			writel_relaxed(cpu_to_be32(*(const u32 *) (state + i)),
+				       init + i);
+		val |= SHA_SET_INIT;
+	} else if (ctrl->alg == SHA_ALG_SHA224) {
+		writel_relaxed(cpu_to_be32(SHA224_H0), init + 0x00);
+		writel_relaxed(cpu_to_be32(SHA224_H1), init + 0x04);
+		writel_relaxed(cpu_to_be32(SHA224_H2), init + 0x08);
+		writel_relaxed(cpu_to_be32(SHA224_H3), init + 0x0c);
+		writel_relaxed(cpu_to_be32(SHA224_H4), init + 0x10);
+		writel_relaxed(cpu_to_be32(SHA224_H5), init + 0x14);
+		writel_relaxed(cpu_to_be32(SHA224_H6), init + 0x18);
+		writel_relaxed(cpu_to_be32(SHA224_H7), init + 0x1c);
+		val |= SHA_SET_INIT;
+	}
+
+	writel(val, priv->base + SHA_CTRL);
+
+	/* test SHA_CTRL */
+	val = readl_relaxed(priv->base + SHA_CTRL);
+	if (val & SHA_USED_BY_C51)
+		return -EBUSY;
+
+	/* wait ready */
+	if (hica_sha_wait(priv, SHA_HASH_READY))
+		return -ETIMEDOUT;
+
+	/* ask device to set state */
+	writel(SHA_START_BIT, priv->base + SHA_START);
+
+	pr_debug("%s: alg %u\n", __func__, ctrl->alg);
+	return 0;
+}
+
+static int hica_sha_update(const struct hica_sha_priv *priv, const void *data,
+			   unsigned int len, bool may_sleep)
+{
+	struct device *dev = priv->dev;
+	bool inplace = !((unsigned int) data & 3);
+	u8 *buf = NULL;
+	dma_addr_t addr;
+	int ret;
+
+	if (!len)
+		return 0;
+
+	if (WARN_ON(len % SHA_BLOCK_SIZE))
+		return -EINVAL;
+
+	if (inplace) {
+		addr = dma_map_single(dev, (void *) data, len, DMA_TO_DEVICE);
+		if (dma_mapping_error(dev, addr)) {
+			dev_err(dev, "error mapping src\n");
+			return -EIO;
+		}
+
+		inplace = !(addr & 3);
+		if (!inplace)
+			dma_unmap_single(dev, addr, len, DMA_TO_DEVICE);
+	}
+
+	if (!inplace) {
+		buf = dma_alloc_attrs(dev, len, &addr,
+				      may_sleep ? GFP_KERNEL : GFP_ATOMIC, 0);
+		if (!buf)
+			return -ENOMEM;
+		memcpy(buf, data, len);
+	}
+
+	dma_sync_single_for_device(dev, addr, len, DMA_TO_DEVICE);
+	ret = hica_sha_record(priv, addr, len) ?:
+	      hica_sha_wait(priv, SHA_RECORD_READY);
+
+	if (!buf)
+		dma_unmap_single(dev, addr, len, DMA_TO_DEVICE);
+	else {
+		memzero_explicit(buf, len);
+		dma_free_attrs(dev, len, buf, addr, 0);
+	}
+
+	pr_debug("%s: read %u\n", __func__, len);
+	return ret;
+}
+
+static int hica_sha_export(const struct hica_sha_priv *priv, void *out,
+			   unsigned int digestsize)
+{
+	if (hica_sha_wait(priv, SHA_RECORD_READY))
+		return -ETIMEDOUT;
+
+	for (unsigned int i = 0; i < digestsize; i += sizeof(u32))
+		*(u32 *) (out + i) =
+			be32_to_cpu(readl_relaxed(priv->base + SHA_OUT0 + i));
+
+	return 0;
+}
+
+/******** shash_alg ********/
+
+static int hica_sha_alg_init(struct shash_desc *desc)
+{
+	struct hica_sha_desc_ctx *d_ctx = shash_desc_ctx(desc);
+	struct hica_sha_tfm_ctx *ctx = crypto_shash_ctx(desc->tfm);
+
+	d_ctx->bypass = false;
+
+	d_ctx->fallback.tfm = ctx->fallback;
+	return crypto_shash_init(&d_ctx->fallback);
+}
+
+static int
+_hica_sha_alg_update(struct shash_desc *desc, const u8 *data, unsigned int len,
+		     void *buf, u32 *state, u64 *count)
+{
+	struct hica_sha_desc_ctx *d_ctx = shash_desc_ctx(desc);
+	struct hica_sha_tfm_ctx *ctx = crypto_shash_ctx(desc->tfm);
+	struct hica_sha_priv *priv = ctx->priv;
+	struct device *dev = priv->dev;
+	unsigned int top;
+	unsigned int bottom;
+	int ret;
+
+	if (d_ctx->bypass || len < bypass_size)
+		goto fallback;
+
+	ret = crypto_shash_export(&d_ctx->fallback, buf);
+	if (ret)
+		return ret;
+
+	bottom = ALIGN(*count, ctx->blocksize);
+	top = ALIGN_DOWN(*count + len, ctx->blocksize);
+	if ((priv->type == SHA_TYPE_MHASH || !*count) && bottom < top &&
+	    top - bottom >= bypass_size) {
+		unsigned int runlen = *count & (ctx->blocksize - 1);
+		unsigned int dmalen = top - bottom;
+
+		if (runlen) {
+			runlen = ctx->blocksize - runlen;
+
+			ret = crypto_shash_update(&d_ctx->fallback, data,
+						  runlen);
+			if (ret)
+				return ret;
+
+			data += runlen;
+			len -= runlen;
+		}
+
+		if (mutex_trylock(&priv->lock)) {
+			pr_debug("%s: before %llu\n", __func__, *count);
+			pm_runtime_get_sync(dev);
+
+			ret = crypto_shash_export(&d_ctx->fallback, buf) ?:
+			      hica_sha_init(priv, &ctx->ctrl,
+					    !*count ? NULL : state) ?:
+			      hica_sha_update(priv, data, dmalen,
+					      crypto_shash_get_flags(desc->tfm) &
+					      CRYPTO_TFM_REQ_MAY_SLEEP) ?:
+			      hica_sha_export(priv, state, ctx->digestsize);
+
+			pm_runtime_mark_last_busy(dev);
+			pm_runtime_put_autosuspend(dev);
+			mutex_unlock(&priv->lock);
+			if (ret)
+				return ret;
+
+			*count += dmalen;
+			pr_debug("%s: after %llu\n", __func__, *count);
+
+			ret = crypto_shash_import(&d_ctx->fallback, buf);
+			if (ret)
+				return ret;
+
+			data += dmalen;
+			len -= dmalen;
+		}
+	}
+
+	if (priv->type != SHA_TYPE_MHASH)
+		d_ctx->bypass = true;
+
+fallback:
+	return crypto_shash_update(&d_ctx->fallback, data, len);
+}
+
+static int hica_sha_alg_update_sha1(struct shash_desc *desc, const u8 *data,
+				    unsigned int len)
+{
+	struct sha1_state state;
+
+	return len ?: _hica_sha_alg_update(desc, data, len, &state, state.state,
+					   &state.count);
+}
+
+static int hica_sha_alg_update_sha256(struct shash_desc *desc, const u8 *data,
+				      unsigned int len)
+{
+	struct sha256_state state;
+
+	return len ?: _hica_sha_alg_update(desc, data, len, &state, state.state,
+					   &state.count);
+}
+
+static int hica_sha_alg_final(struct shash_desc *desc, u8 *out)
+{
+	struct hica_sha_desc_ctx *d_ctx = shash_desc_ctx(desc);
+
+	return crypto_shash_final(&d_ctx->fallback, out);
+}
+
+static int hica_sha_alg_export(struct shash_desc *desc, void *out)
+{
+	struct hica_sha_desc_ctx *d_ctx = shash_desc_ctx(desc);
+
+	return crypto_shash_export(&d_ctx->fallback, out);
+}
+
+static int hica_sha_alg_import(struct shash_desc *desc, const void *in)
+{
+	struct hica_sha_desc_ctx *d_ctx = shash_desc_ctx(desc);
+	struct hica_sha_tfm_ctx *ctx = crypto_shash_ctx(desc->tfm);
+
+	d_ctx->bypass = false;
+
+	d_ctx->fallback.tfm = ctx->fallback;
+	return crypto_shash_import(&d_ctx->fallback, in);
+}
+
+static int hica_sha_alg_init_tfm(struct crypto_shash *tfm)
+{
+	struct hica_sha_tfm_ctx *ctx = crypto_shash_ctx(tfm);
+	struct hash_alg_common *halg =
+		__crypto_hash_alg_common(tfm->base.__crt_alg);
+	struct hica_sha_alg *p_alg =
+		container_of(halg, typeof(*p_alg), alg.halg);
+
+	/* avoid pointer chain */
+	ctx->digestsize = halg->digestsize;
+	ctx->blocksize = crypto_shash_blocksize(tfm);
+	if (ctx->digestsize > SHA_DIGEST_SIZE ||
+	    ctx->blocksize > SHA_BLOCK_SIZE)
+		return -EINVAL;
+
+	ctx->fallback = crypto_alloc_shash(crypto_shash_alg_name(tfm), 0,
+					   CRYPTO_ALG_NEED_FALLBACK |
+					   CRYPTO_ALG_ALLOCATES_MEMORY);
+	if (IS_ERR(ctx->fallback))
+		return PTR_ERR(ctx->fallback);
+
+	/* update statesize from fallback algorithm */
+	tfm->descsize += crypto_shash_descsize(ctx->fallback);
+
+	ctx->priv = p_alg->priv;
+	ctx->ctrl = p_alg->ctrl;
+
+	return 0;
+}
+
+static void hica_sha_alg_exit_tfm(struct crypto_shash *tfm)
+{
+	struct hica_sha_tfm_ctx *ctx = crypto_shash_ctx(tfm);
+
+	crypto_free_shash(ctx->fallback);
+}
+
+static int hica_sha_alg_register(struct hica_sha_alg *p_alg,
+				 const struct hica_sha_tmpl *tmpl,
+				 struct hica_sha_priv *priv)
+{
+	struct crypto_alg *base = &p_alg->alg.halg.base;
+
+	*p_alg = (typeof(*p_alg)) {
+		.alg = {
+			.init = hica_sha_alg_init,
+			.update = tmpl->update,
+			.final = hica_sha_alg_final,
+			.export = hica_sha_alg_export,
+			.import = hica_sha_alg_import,
+			.init_tfm = hica_sha_alg_init_tfm,
+			.exit_tfm = hica_sha_alg_exit_tfm,
+
+			.descsize = sizeof(struct hica_sha_desc_ctx),
+
+			.halg = {
+				.digestsize = tmpl->digestsize,
+				.statesize = tmpl->statesize,
+				.base = {
+					.cra_flags = CRYPTO_ALG_TYPE_SHASH |
+						     CRYPTO_ALG_NEED_FALLBACK |
+						     CRYPTO_ALG_KERN_DRIVER_ONLY |
+						     CRYPTO_ALG_ALLOCATES_MEMORY,
+					.cra_blocksize = tmpl->blocksize,
+					.cra_ctxsize = sizeof(struct hica_sha_tfm_ctx),
+					.cra_alignmask = 0,
+
+					.cra_priority = 200,
+					.cra_module = THIS_MODULE,
+				},
+			},
+		},
+		.ctrl = tmpl->ctrl,
+		.priv = priv,
+	};
+
+	snprintf(base->cra_name, sizeof(base->cra_name), "%s", tmpl->alg_name);
+	snprintf(base->cra_driver_name, sizeof(base->cra_driver_name),
+		 "hisi-advca-%s", tmpl->alg_name);
+
+	return crypto_register_shash(&p_alg->alg);
+}
+
+#define hica_sha_tmpl_define(_ALG, _alg, state) { \
+	.ctrl = { \
+		.alg = SHA_ALG_##_ALG, \
+	}, \
+	.digestsize = _ALG##_DIGEST_SIZE, \
+	.statesize = sizeof(struct state##_state), \
+	.blocksize = _ALG##_BLOCK_SIZE, \
+	.update = hica_sha_alg_update_##state, \
+	.alg_name = #_alg, \
+}
+
+static const struct hica_sha_tmpl hica_sha_tmpls[] = {
+	hica_sha_tmpl_define(SHA1, sha1, sha1),
+	hica_sha_tmpl_define(SHA256, sha256, sha256),
+
+	/* MHASH only */
+	hica_sha_tmpl_define(SHA224, sha224, sha256),
+};
+
+/******** device ********/
+
+static int hica_sha_runtime_suspend(struct device *dev)
+{
+	struct hica_sha_priv *priv = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(priv->clks_num, priv->clks);
+
+	return 0;
+}
+
+static int hica_sha_runtime_resume(struct device *dev)
+{
+	struct hica_sha_priv *priv = dev_get_drvdata(dev);
+
+	return clk_bulk_prepare_enable(priv->clks_num, priv->clks);
+}
+
+static const struct dev_pm_ops hica_sha_pm_ops = {
+	.runtime_suspend = hica_sha_runtime_suspend,
+	.runtime_resume = hica_sha_runtime_resume,
+};
+
+static void hica_sha_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct hica_sha_priv *priv = platform_get_drvdata(pdev);
+
+	for (int i = priv->algs_num; i > 0; ) {
+		i--;
+		crypto_unregister_shash(&priv->algs[i].alg);
+	}
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	clk_bulk_disable_unprepare(priv->clks_num, priv->clks);
+}
+
+static int hica_sha_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	unsigned int saved = bypass_size;
+	struct hica_sha_priv *priv;
+	int ret;
+
+	/* acquire resources */
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	ret = devm_clk_bulk_get_all(dev, &priv->clks);
+	if (ret < 0)
+		return ret;
+	priv->clks_num = ret;
+
+	priv->rst = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(priv->rst))
+		return PTR_ERR(priv->rst);
+
+	priv->type = (uintptr_t) of_device_get_match_data(dev);
+
+	priv->algs_num = ARRAY_SIZE(hica_sha_tmpls);
+	if (priv->type != SHA_TYPE_MHASH)
+		priv->algs_num -= 1;
+
+	priv->algs = devm_kmalloc_array(dev, priv->algs_num,
+					sizeof(priv->algs[0]), GFP_KERNEL);
+	if (!priv->algs)
+		return -ENOMEM;
+
+	mutex_init(&priv->lock);
+
+	priv->dev = dev;
+	platform_set_drvdata(pdev, priv);
+	dev_set_drvdata(dev, priv);
+
+	/* bring up device */
+	ret = reset_control_assert(priv->rst) ?:
+	      clk_bulk_prepare_enable(priv->clks_num, priv->clks) ?:
+	      reset_control_deassert(priv->rst);
+	if (ret)
+		return ret;
+
+	if (hica_sha_wait(priv, SHA_HASH_READY)) {
+		dev_err(dev, "cannot bring up device\n");
+		return -ENODEV;
+	}
+
+	/* register algs */
+	bypass_size = 0;
+	for (int i = 0; i < priv->algs_num; i++) {
+		ret = hica_sha_alg_register(&priv->algs[i], &hica_sha_tmpls[i],
+					    priv);
+		if (ret) {
+			while (i > 0) {
+				i--;
+				crypto_unregister_shash(&priv->algs[i].alg);
+			}
+			bypass_size = saved;
+			return ret;
+		}
+	}
+	bypass_size = saved;
+
+	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	return 0;
+}
+
+static const struct of_device_id hica_sha_of_match[] = {
+	{ .compatible = "hisilicon,advca-hash",
+	  .data = (void *) SHA_TYPE_HASH },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hica_sha_of_match);
+
+static struct platform_driver hica_sha_driver = {
+	.probe = hica_sha_probe,
+	.remove_new = hica_sha_remove,
+	.driver = {
+		.name = "hisi-advca-sha",
+		.of_match_table = hica_sha_of_match,
+		.pm = &hica_sha_pm_ops,
+	},
+};
+
+module_platform_driver(hica_sha_driver);
+
+MODULE_DESCRIPTION("HiSilicon Advanced Conditional Access Subsystem - SHA");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("David Yang <mmyangfl@gmail.com>");
-- 
2.39.2

