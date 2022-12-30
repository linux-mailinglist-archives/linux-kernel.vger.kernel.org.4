Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833A86594FD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 06:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbiL3FXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 00:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbiL3FWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 00:22:30 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD0218E16;
        Thu, 29 Dec 2022 21:22:10 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pB7pq-00CDa8-1t; Fri, 30 Dec 2022 13:21:39 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 Dec 2022 13:21:38 +0800
Date:   Fri, 30 Dec 2022 13:21:38 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>
Subject: [PATCH] crypto: caam - Remove GFP_DMA and add DMA alignment padding
Message-ID: <Y651YoR58cCg3adj@gondor.apana.org.au>
References: <Y4nDL50nToBbi4DS@gondor.apana.org.au>
 <Y4xpGNNsfbucyUlt@infradead.org>
 <Y47BgCuZsYLX61A9@gondor.apana.org.au>
 <Y47g7qO8dsRdxCgf@infradead.org>
 <Y47+gxbdKR03EYCj@gondor.apana.org.au>
 <Y61WrVAjjtAMAvSh@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y61WrVAjjtAMAvSh@gondor.apana.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GFP_DMA does not guarantee that the returned memory is aligned
for DMA.  It should be removed where it is superfluous.

However, kmalloc may start returning DMA-unaligned memory in future
so fix this by adding the alignment by hand.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/caam/blob_gen.c b/drivers/crypto/caam/blob_gen.c
index 1f65df489847..0c347ba6e692 100644
--- a/drivers/crypto/caam/blob_gen.c
+++ b/drivers/crypto/caam/blob_gen.c
@@ -83,7 +83,7 @@ int caam_process_blob(struct caam_blob_priv *priv,
 		output_len = info->input_len - CAAM_BLOB_OVERHEAD;
 	}
 
-	desc = kzalloc(CAAM_BLOB_DESC_BYTES_MAX, GFP_KERNEL | GFP_DMA);
+	desc = kzalloc(CAAM_BLOB_DESC_BYTES_MAX, GFP_KERNEL);
 	if (!desc)
 		return -ENOMEM;
 
diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index ecc15bc521db..4a9b998a8d26 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -59,6 +59,8 @@
 #include <crypto/engine.h>
 #include <crypto/xts.h>
 #include <asm/unaligned.h>
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
 
 /*
  * crypto alg
@@ -1379,8 +1381,7 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 	sec4_sg_bytes = sec4_sg_len * sizeof(struct sec4_sg_entry);
 
 	/* allocate space for base edesc and hw desc commands, link tables */
-	edesc = kzalloc(sizeof(*edesc) + desc_bytes + sec4_sg_bytes,
-			GFP_DMA | flags);
+	edesc = kzalloc(sizeof(*edesc) + desc_bytes + sec4_sg_bytes, flags);
 	if (!edesc) {
 		caam_unmap(jrdev, req->src, req->dst, src_nents, dst_nents, 0,
 			   0, 0, 0);
@@ -1608,6 +1609,7 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
 	u8 *iv;
 	int ivsize = crypto_skcipher_ivsize(skcipher);
 	int dst_sg_idx, sec4_sg_ents, sec4_sg_bytes;
+	unsigned int aligned_size;
 
 	src_nents = sg_nents_for_len(req->src, req->cryptlen);
 	if (unlikely(src_nents < 0)) {
@@ -1681,15 +1683,18 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
 	/*
 	 * allocate space for base edesc and hw desc commands, link tables, IV
 	 */
-	edesc = kzalloc(sizeof(*edesc) + desc_bytes + sec4_sg_bytes + ivsize,
-			GFP_DMA | flags);
-	if (!edesc) {
+	aligned_size = ALIGN(ivsize, __alignof__(*edesc));
+	aligned_size += sizeof(*edesc) + desc_bytes + sec4_sg_bytes;
+	aligned_size = ALIGN(aligned_size, dma_get_cache_alignment());
+	iv = kzalloc(aligned_size, flags);
+	if (!iv) {
 		dev_err(jrdev, "could not allocate extended descriptor\n");
 		caam_unmap(jrdev, req->src, req->dst, src_nents, dst_nents, 0,
 			   0, 0, 0);
 		return ERR_PTR(-ENOMEM);
 	}
 
+	edesc = (void *)(iv + ALIGN(ivsize, __alignof__(*edesc)));
 	edesc->src_nents = src_nents;
 	edesc->dst_nents = dst_nents;
 	edesc->mapped_src_nents = mapped_src_nents;
@@ -1701,7 +1706,6 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
 
 	/* Make sure IV is located in a DMAable area */
 	if (ivsize) {
-		iv = (u8 *)edesc->sec4_sg + sec4_sg_bytes;
 		memcpy(iv, req->iv, ivsize);
 
 		iv_dma = dma_map_single(jrdev, iv, ivsize, DMA_BIDIRECTIONAL);
diff --git a/drivers/crypto/caam/caamalg_qi.c b/drivers/crypto/caam/caamalg_qi.c
index c37b67be0492..5e218bf20d5b 100644
--- a/drivers/crypto/caam/caamalg_qi.c
+++ b/drivers/crypto/caam/caamalg_qi.c
@@ -20,6 +20,8 @@
 #include "caamalg_desc.h"
 #include <crypto/xts.h>
 #include <asm/unaligned.h>
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
 
 /*
  * crypto alg
@@ -959,7 +961,7 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 		return (struct aead_edesc *)drv_ctx;
 
 	/* allocate space for base edesc and hw desc commands, link tables */
-	edesc = qi_cache_alloc(GFP_DMA | flags);
+	edesc = qi_cache_alloc(flags);
 	if (unlikely(!edesc)) {
 		dev_err(qidev, "could not allocate extended descriptor\n");
 		return ERR_PTR(-ENOMEM);
@@ -1317,8 +1319,9 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
 		qm_sg_ents = 1 + pad_sg_nents(qm_sg_ents);
 
 	qm_sg_bytes = qm_sg_ents * sizeof(struct qm_sg_entry);
-	if (unlikely(offsetof(struct skcipher_edesc, sgt) + qm_sg_bytes +
-		     ivsize > CAAM_QI_MEMCACHE_SIZE)) {
+	if (unlikely(ALIGN(ivsize, __alignof__(*edesc)) +
+		     offsetof(struct skcipher_edesc, sgt) + qm_sg_bytes >
+		     CAAM_QI_MEMCACHE_SIZE)) {
 		dev_err(qidev, "No space for %d S/G entries and/or %dB IV\n",
 			qm_sg_ents, ivsize);
 		caam_unmap(qidev, req->src, req->dst, src_nents, dst_nents, 0,
@@ -1327,17 +1330,18 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
 	}
 
 	/* allocate space for base edesc, link tables and IV */
-	edesc = qi_cache_alloc(GFP_DMA | flags);
-	if (unlikely(!edesc)) {
+	iv = qi_cache_alloc(flags);
+	if (unlikely(!iv)) {
 		dev_err(qidev, "could not allocate extended descriptor\n");
 		caam_unmap(qidev, req->src, req->dst, src_nents, dst_nents, 0,
 			   0, DMA_NONE, 0, 0);
 		return ERR_PTR(-ENOMEM);
 	}
 
+	edesc = (void *)(iv + ALIGN(ivsize, __alignof__(*edesc)));
+
 	/* Make sure IV is located in a DMAable area */
 	sg_table = &edesc->sgt[0];
-	iv = (u8 *)(sg_table + qm_sg_ents);
 	memcpy(iv, req->iv, ivsize);
 
 	iv_dma = dma_map_single(qidev, iv, ivsize, DMA_BIDIRECTIONAL);
diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 1b0dd742c53f..0ddef9a033a1 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -16,7 +16,9 @@
 #include "caamalg_desc.h"
 #include "caamhash_desc.h"
 #include "dpseci-debugfs.h"
+#include <linux/dma-mapping.h>
 #include <linux/fsl/mc.h>
+#include <linux/kernel.h>
 #include <soc/fsl/dpaa2-io.h>
 #include <soc/fsl/dpaa2-fd.h>
 #include <crypto/xts.h>
@@ -370,7 +372,7 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 	struct dpaa2_sg_entry *sg_table;
 
 	/* allocate space for base edesc, link tables and IV */
-	edesc = qi_cache_zalloc(GFP_DMA | flags);
+	edesc = qi_cache_zalloc(flags);
 	if (unlikely(!edesc)) {
 		dev_err(dev, "could not allocate extended descriptor\n");
 		return ERR_PTR(-ENOMEM);
@@ -1189,7 +1191,7 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req)
 	}
 
 	/* allocate space for base edesc, link tables and IV */
-	edesc = qi_cache_zalloc(GFP_DMA | flags);
+	edesc = qi_cache_zalloc(flags);
 	if (unlikely(!edesc)) {
 		dev_err(dev, "could not allocate extended descriptor\n");
 		caam_unmap(dev, req->src, req->dst, src_nents, dst_nents, 0,
@@ -3220,14 +3222,14 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
 	int ret = -ENOMEM;
 	struct dpaa2_fl_entry *in_fle, *out_fle;
 
-	req_ctx = kzalloc(sizeof(*req_ctx), GFP_KERNEL | GFP_DMA);
+	req_ctx = kzalloc(sizeof(*req_ctx), GFP_KERNEL);
 	if (!req_ctx)
 		return -ENOMEM;
 
 	in_fle = &req_ctx->fd_flt[1];
 	out_fle = &req_ctx->fd_flt[0];
 
-	flc = kzalloc(sizeof(*flc), GFP_KERNEL | GFP_DMA);
+	flc = kzalloc(sizeof(*flc), GFP_KERNEL);
 	if (!flc)
 		goto err_flc;
 
@@ -3316,7 +3318,13 @@ static int ahash_setkey(struct crypto_ahash *ahash, const u8 *key,
 	dev_dbg(ctx->dev, "keylen %d blocksize %d\n", keylen, blocksize);
 
 	if (keylen > blocksize) {
-		hashed_key = kmemdup(key, keylen, GFP_KERNEL | GFP_DMA);
+		unsigned int aligned_len =
+			ALIGN(keylen, dma_get_cache_alignment());
+
+		if (aligned_len < keylen)
+			return -EOVERFLOW;
+
+		hashed_key = kmemdup(key, aligned_len, GFP_KERNEL);
 		if (!hashed_key)
 			return -ENOMEM;
 		ret = hash_digest_key(ctx, &keylen, hashed_key, digestsize);
@@ -3560,7 +3568,7 @@ static int ahash_update_ctx(struct ahash_request *req)
 		}
 
 		/* allocate space for base edesc and link tables */
-		edesc = qi_cache_zalloc(GFP_DMA | flags);
+		edesc = qi_cache_zalloc(flags);
 		if (!edesc) {
 			dma_unmap_sg(ctx->dev, req->src, src_nents,
 				     DMA_TO_DEVICE);
@@ -3654,7 +3662,7 @@ static int ahash_final_ctx(struct ahash_request *req)
 	int ret;
 
 	/* allocate space for base edesc and link tables */
-	edesc = qi_cache_zalloc(GFP_DMA | flags);
+	edesc = qi_cache_zalloc(flags);
 	if (!edesc)
 		return -ENOMEM;
 
@@ -3743,7 +3751,7 @@ static int ahash_finup_ctx(struct ahash_request *req)
 	}
 
 	/* allocate space for base edesc and link tables */
-	edesc = qi_cache_zalloc(GFP_DMA | flags);
+	edesc = qi_cache_zalloc(flags);
 	if (!edesc) {
 		dma_unmap_sg(ctx->dev, req->src, src_nents, DMA_TO_DEVICE);
 		return -ENOMEM;
@@ -3836,7 +3844,7 @@ static int ahash_digest(struct ahash_request *req)
 	}
 
 	/* allocate space for base edesc and link tables */
-	edesc = qi_cache_zalloc(GFP_DMA | flags);
+	edesc = qi_cache_zalloc(flags);
 	if (!edesc) {
 		dma_unmap_sg(ctx->dev, req->src, src_nents, DMA_TO_DEVICE);
 		return ret;
@@ -3913,7 +3921,7 @@ static int ahash_final_no_ctx(struct ahash_request *req)
 	int ret = -ENOMEM;
 
 	/* allocate space for base edesc and link tables */
-	edesc = qi_cache_zalloc(GFP_DMA | flags);
+	edesc = qi_cache_zalloc(flags);
 	if (!edesc)
 		return ret;
 
@@ -4012,7 +4020,7 @@ static int ahash_update_no_ctx(struct ahash_request *req)
 		}
 
 		/* allocate space for base edesc and link tables */
-		edesc = qi_cache_zalloc(GFP_DMA | flags);
+		edesc = qi_cache_zalloc(flags);
 		if (!edesc) {
 			dma_unmap_sg(ctx->dev, req->src, src_nents,
 				     DMA_TO_DEVICE);
@@ -4125,7 +4133,7 @@ static int ahash_finup_no_ctx(struct ahash_request *req)
 	}
 
 	/* allocate space for base edesc and link tables */
-	edesc = qi_cache_zalloc(GFP_DMA | flags);
+	edesc = qi_cache_zalloc(flags);
 	if (!edesc) {
 		dma_unmap_sg(ctx->dev, req->src, src_nents, DMA_TO_DEVICE);
 		return ret;
@@ -4230,7 +4238,7 @@ static int ahash_update_first(struct ahash_request *req)
 		}
 
 		/* allocate space for base edesc and link tables */
-		edesc = qi_cache_zalloc(GFP_DMA | flags);
+		edesc = qi_cache_zalloc(flags);
 		if (!edesc) {
 			dma_unmap_sg(ctx->dev, req->src, src_nents,
 				     DMA_TO_DEVICE);
@@ -4926,6 +4934,7 @@ static int dpaa2_dpseci_congestion_setup(struct dpaa2_caam_priv *priv,
 {
 	struct dpseci_congestion_notification_cfg cong_notif_cfg = { 0 };
 	struct device *dev = priv->dev;
+	unsigned int alignmask;
 	int err;
 
 	/*
@@ -4936,13 +4945,14 @@ static int dpaa2_dpseci_congestion_setup(struct dpaa2_caam_priv *priv,
 	    !(priv->dpseci_attr.options & DPSECI_OPT_HAS_CG))
 		return 0;
 
-	priv->cscn_mem = kzalloc(DPAA2_CSCN_SIZE + DPAA2_CSCN_ALIGN,
-				 GFP_KERNEL | GFP_DMA);
+	alignmask = DPAA2_CSCN_ALIGN - 1;
+	alignmask |= dma_get_cache_alignment() - 1;
+	priv->cscn_mem = kzalloc(ALIGN(DPAA2_CSCN_SIZE, alignmask + 1),
+				 GFP_KERNEL);
 	if (!priv->cscn_mem)
 		return -ENOMEM;
 
-	priv->cscn_mem_aligned = PTR_ALIGN(priv->cscn_mem, DPAA2_CSCN_ALIGN);
-	priv->cscn_dma = dma_map_single(dev, priv->cscn_mem_aligned,
+	priv->cscn_dma = dma_map_single(dev, priv->cscn_mem,
 					DPAA2_CSCN_SIZE, DMA_FROM_DEVICE);
 	if (dma_mapping_error(dev, priv->cscn_dma)) {
 		dev_err(dev, "Error mapping CSCN memory area\n");
@@ -5174,7 +5184,7 @@ static int dpaa2_caam_probe(struct fsl_mc_device *dpseci_dev)
 	priv->domain = iommu_get_domain_for_dev(dev);
 
 	qi_cache = kmem_cache_create("dpaa2_caamqicache", CAAM_QI_MEMCACHE_SIZE,
-				     0, SLAB_CACHE_DMA, NULL);
+				     0, 0, NULL);
 	if (!qi_cache) {
 		dev_err(dev, "Can't allocate SEC cache\n");
 		return -ENOMEM;
@@ -5451,7 +5461,7 @@ int dpaa2_caam_enqueue(struct device *dev, struct caam_request *req)
 		dma_sync_single_for_cpu(priv->dev, priv->cscn_dma,
 					DPAA2_CSCN_SIZE,
 					DMA_FROM_DEVICE);
-		if (unlikely(dpaa2_cscn_state_congested(priv->cscn_mem_aligned))) {
+		if (unlikely(dpaa2_cscn_state_congested(priv->cscn_mem))) {
 			dev_dbg_ratelimited(dev, "Dropping request\n");
 			return -EBUSY;
 		}
diff --git a/drivers/crypto/caam/caamalg_qi2.h b/drivers/crypto/caam/caamalg_qi2.h
index d35253407ade..abb502bb675c 100644
--- a/drivers/crypto/caam/caamalg_qi2.h
+++ b/drivers/crypto/caam/caamalg_qi2.h
@@ -7,13 +7,14 @@
 #ifndef _CAAMALG_QI2_H_
 #define _CAAMALG_QI2_H_
 
+#include <crypto/internal/skcipher.h>
+#include <linux/compiler_attributes.h>
 #include <soc/fsl/dpaa2-io.h>
 #include <soc/fsl/dpaa2-fd.h>
 #include <linux/threads.h>
 #include <linux/netdevice.h>
 #include "dpseci.h"
 #include "desc_constr.h"
-#include <crypto/skcipher.h>
 
 #define DPAA2_CAAM_STORE_SIZE	16
 /* NAPI weight *must* be a multiple of the store size. */
@@ -36,8 +37,6 @@
  * @tx_queue_attr: array of Tx queue attributes
  * @cscn_mem: pointer to memory region containing the congestion SCN
  *	it's size is larger than to accommodate alignment
- * @cscn_mem_aligned: pointer to congestion SCN; it is computed as
- *	PTR_ALIGN(cscn_mem, DPAA2_CSCN_ALIGN)
  * @cscn_dma: dma address used by the QMAN to write CSCN messages
  * @dev: device associated with the DPSECI object
  * @mc_io: pointer to MC portal's I/O object
@@ -58,7 +57,6 @@ struct dpaa2_caam_priv {
 
 	/* congestion */
 	void *cscn_mem;
-	void *cscn_mem_aligned;
 	dma_addr_t cscn_dma;
 
 	struct device *dev;
@@ -158,7 +156,7 @@ struct ahash_edesc {
 struct caam_flc {
 	u32 flc[16];
 	u32 sh_desc[MAX_SDLEN];
-} ____cacheline_aligned;
+} __aligned(CRYPTO_DMA_ALIGN);
 
 enum optype {
 	ENCRYPT = 0,
@@ -180,7 +178,7 @@ enum optype {
  * @edesc: extended descriptor; points to one of {skcipher,aead}_edesc
  */
 struct caam_request {
-	struct dpaa2_fl_entry fd_flt[2];
+	struct dpaa2_fl_entry fd_flt[2] __aligned(CRYPTO_DMA_ALIGN);
 	dma_addr_t fd_flt_dma;
 	struct caam_flc *flc;
 	dma_addr_t flc_dma;
diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index 1050e965a438..1f357f48c473 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -66,6 +66,8 @@
 #include "key_gen.h"
 #include "caamhash_desc.h"
 #include <crypto/engine.h>
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
 
 #define CAAM_CRA_PRIORITY		3000
 
@@ -365,7 +367,7 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
 	dma_addr_t key_dma;
 	int ret;
 
-	desc = kmalloc(CAAM_CMD_SZ * 8 + CAAM_PTR_SZ * 2, GFP_KERNEL | GFP_DMA);
+	desc = kmalloc(CAAM_CMD_SZ * 8 + CAAM_PTR_SZ * 2, GFP_KERNEL);
 	if (!desc) {
 		dev_err(jrdev, "unable to allocate key input memory\n");
 		return -ENOMEM;
@@ -432,7 +434,13 @@ static int ahash_setkey(struct crypto_ahash *ahash,
 	dev_dbg(jrdev, "keylen %d\n", keylen);
 
 	if (keylen > blocksize) {
-		hashed_key = kmemdup(key, keylen, GFP_KERNEL | GFP_DMA);
+		unsigned int aligned_len =
+			ALIGN(keylen, dma_get_cache_alignment());
+
+		if (aligned_len < keylen)
+			return -EOVERFLOW;
+
+		hashed_key = kmemdup(key, keylen, GFP_KERNEL);
 		if (!hashed_key)
 			return -ENOMEM;
 		ret = hash_digest_key(ctx, &keylen, hashed_key, digestsize);
@@ -702,7 +710,7 @@ static struct ahash_edesc *ahash_edesc_alloc(struct ahash_request *req,
 	struct ahash_edesc *edesc;
 	unsigned int sg_size = sg_num * sizeof(struct sec4_sg_entry);
 
-	edesc = kzalloc(sizeof(*edesc) + sg_size, GFP_DMA | flags);
+	edesc = kzalloc(sizeof(*edesc) + sg_size, flags);
 	if (!edesc) {
 		dev_err(ctx->jrdev, "could not allocate extended descriptor\n");
 		return NULL;
diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index aef031946f33..e40614fef39d 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -16,6 +16,8 @@
 #include "desc_constr.h"
 #include "sg_sw_sec4.h"
 #include "caampkc.h"
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
 
 #define DESC_RSA_PUB_LEN	(2 * CAAM_CMD_SZ + SIZEOF_RSA_PUB_PDB)
 #define DESC_RSA_PRIV_F1_LEN	(2 * CAAM_CMD_SZ + \
@@ -310,8 +312,7 @@ static struct rsa_edesc *rsa_edesc_alloc(struct akcipher_request *req,
 	sec4_sg_bytes = sec4_sg_len * sizeof(struct sec4_sg_entry);
 
 	/* allocate space for base edesc, hw desc commands and link tables */
-	edesc = kzalloc(sizeof(*edesc) + desclen + sec4_sg_bytes,
-			GFP_DMA | flags);
+	edesc = kzalloc(sizeof(*edesc) + desclen + sec4_sg_bytes, flags);
 	if (!edesc)
 		goto dst_fail;
 
@@ -898,7 +899,7 @@ static u8 *caam_read_rsa_crt(const u8 *ptr, size_t nbytes, size_t dstlen)
 	if (!nbytes)
 		return NULL;
 
-	dst = kzalloc(dstlen, GFP_DMA | GFP_KERNEL);
+	dst = kzalloc(dstlen, GFP_KERNEL);
 	if (!dst)
 		return NULL;
 
@@ -910,7 +911,7 @@ static u8 *caam_read_rsa_crt(const u8 *ptr, size_t nbytes, size_t dstlen)
 /**
  * caam_read_raw_data - Read a raw byte stream as a positive integer.
  * The function skips buffer's leading zeros, copies the remained data
- * to a buffer allocated in the GFP_DMA | GFP_KERNEL zone and returns
+ * to a buffer allocated in the GFP_KERNEL zone and returns
  * the address of the new buffer.
  *
  * @buf   : The data to read
@@ -923,7 +924,7 @@ static inline u8 *caam_read_raw_data(const u8 *buf, size_t *nbytes)
 	if (!*nbytes)
 		return NULL;
 
-	return kmemdup(buf, *nbytes, GFP_DMA | GFP_KERNEL);
+	return kmemdup(buf, *nbytes, GFP_KERNEL);
 }
 
 static int caam_rsa_check_key_length(unsigned int len)
@@ -949,13 +950,13 @@ static int caam_rsa_set_pub_key(struct crypto_akcipher *tfm, const void *key,
 		return ret;
 
 	/* Copy key in DMA zone */
-	rsa_key->e = kmemdup(raw_key.e, raw_key.e_sz, GFP_DMA | GFP_KERNEL);
+	rsa_key->e = kmemdup(raw_key.e, raw_key.e_sz, GFP_KERNEL);
 	if (!rsa_key->e)
 		goto err;
 
 	/*
 	 * Skip leading zeros and copy the positive integer to a buffer
-	 * allocated in the GFP_DMA | GFP_KERNEL zone. The decryption descriptor
+	 * allocated in the GFP_KERNEL zone. The decryption descriptor
 	 * expects a positive integer for the RSA modulus and uses its length as
 	 * decryption output length.
 	 */
@@ -983,6 +984,7 @@ static void caam_rsa_set_priv_key_form(struct caam_rsa_ctx *ctx,
 	struct caam_rsa_key *rsa_key = &ctx->key;
 	size_t p_sz = raw_key->p_sz;
 	size_t q_sz = raw_key->q_sz;
+	unsigned aligned_size;
 
 	rsa_key->p = caam_read_raw_data(raw_key->p, &p_sz);
 	if (!rsa_key->p)
@@ -994,11 +996,13 @@ static void caam_rsa_set_priv_key_form(struct caam_rsa_ctx *ctx,
 		goto free_p;
 	rsa_key->q_sz = q_sz;
 
-	rsa_key->tmp1 = kzalloc(raw_key->p_sz, GFP_DMA | GFP_KERNEL);
+	aligned_size = ALIGN(raw_key->p_sz, dma_get_cache_alignment());
+	rsa_key->tmp1 = kzalloc(aligned_size, GFP_KERNEL);
 	if (!rsa_key->tmp1)
 		goto free_q;
 
-	rsa_key->tmp2 = kzalloc(raw_key->q_sz, GFP_DMA | GFP_KERNEL);
+	aligned_size = ALIGN(raw_key->q_sz, dma_get_cache_alignment());
+	rsa_key->tmp2 = kzalloc(aligned_size, GFP_KERNEL);
 	if (!rsa_key->tmp2)
 		goto free_tmp1;
 
@@ -1051,17 +1055,17 @@ static int caam_rsa_set_priv_key(struct crypto_akcipher *tfm, const void *key,
 		return ret;
 
 	/* Copy key in DMA zone */
-	rsa_key->d = kmemdup(raw_key.d, raw_key.d_sz, GFP_DMA | GFP_KERNEL);
+	rsa_key->d = kmemdup(raw_key.d, raw_key.d_sz, GFP_KERNEL);
 	if (!rsa_key->d)
 		goto err;
 
-	rsa_key->e = kmemdup(raw_key.e, raw_key.e_sz, GFP_DMA | GFP_KERNEL);
+	rsa_key->e = kmemdup(raw_key.e, raw_key.e_sz, GFP_KERNEL);
 	if (!rsa_key->e)
 		goto err;
 
 	/*
 	 * Skip leading zeros and copy the positive integer to a buffer
-	 * allocated in the GFP_DMA | GFP_KERNEL zone. The decryption descriptor
+	 * allocated in the GFP_KERNEL zone. The decryption descriptor
 	 * expects a positive integer for the RSA modulus and uses its length as
 	 * decryption output length.
 	 */
@@ -1185,8 +1189,7 @@ int caam_pkc_init(struct device *ctrldev)
 		return 0;
 
 	/* allocate zero buffer, used for padding input */
-	zero_buffer = kzalloc(CAAM_RSA_MAX_INPUT_SIZE - 1, GFP_DMA |
-			      GFP_KERNEL);
+	zero_buffer = kzalloc(CAAM_RSA_MAX_INPUT_SIZE - 1, GFP_KERNEL);
 	if (!zero_buffer)
 		return -ENOMEM;
 
diff --git a/drivers/crypto/caam/caamprng.c b/drivers/crypto/caam/caamprng.c
index 4839e66300a2..6e4c1191cb28 100644
--- a/drivers/crypto/caam/caamprng.c
+++ b/drivers/crypto/caam/caamprng.c
@@ -8,6 +8,8 @@
 
 #include <linux/completion.h>
 #include <crypto/internal/rng.h>
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
 #include "compat.h"
 #include "regs.h"
 #include "intern.h"
@@ -75,6 +77,7 @@ static int caam_prng_generate(struct crypto_rng *tfm,
 			     const u8 *src, unsigned int slen,
 			     u8 *dst, unsigned int dlen)
 {
+	unsigned int aligned_dlen = ALIGN(dlen, dma_get_cache_alignment());
 	struct caam_prng_ctx ctx;
 	struct device *jrdev;
 	dma_addr_t dst_dma;
@@ -82,7 +85,10 @@ static int caam_prng_generate(struct crypto_rng *tfm,
 	u8 *buf;
 	int ret;
 
-	buf = kzalloc(dlen, GFP_KERNEL);
+	if (aligned_dlen < dlen)
+		return -EOVERFLOW;
+
+	buf = kzalloc(aligned_dlen, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
@@ -94,7 +100,7 @@ static int caam_prng_generate(struct crypto_rng *tfm,
 		return ret;
 	}
 
-	desc = kzalloc(CAAM_PRNG_MAX_DESC_LEN, GFP_KERNEL | GFP_DMA);
+	desc = kzalloc(CAAM_PRNG_MAX_DESC_LEN, GFP_KERNEL);
 	if (!desc) {
 		ret = -ENOMEM;
 		goto out1;
@@ -156,7 +162,7 @@ static int caam_prng_seed(struct crypto_rng *tfm,
 		return ret;
 	}
 
-	desc = kzalloc(CAAM_PRNG_MAX_DESC_LEN, GFP_KERNEL | GFP_DMA);
+	desc = kzalloc(CAAM_PRNG_MAX_DESC_LEN, GFP_KERNEL);
 	if (!desc) {
 		caam_jr_free(jrdev);
 		return -ENOMEM;
diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrng.c
index 1f0e82050976..1fd8ff965006 100644
--- a/drivers/crypto/caam/caamrng.c
+++ b/drivers/crypto/caam/caamrng.c
@@ -12,6 +12,8 @@
 #include <linux/hw_random.h>
 #include <linux/completion.h>
 #include <linux/atomic.h>
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
 #include <linux/kfifo.h>
 
 #include "compat.h"
@@ -176,17 +178,18 @@ static int caam_init(struct hwrng *rng)
 	int err;
 
 	ctx->desc_sync = devm_kzalloc(ctx->ctrldev, CAAM_RNG_DESC_LEN,
-				      GFP_DMA | GFP_KERNEL);
+				      GFP_KERNEL);
 	if (!ctx->desc_sync)
 		return -ENOMEM;
 
 	ctx->desc_async = devm_kzalloc(ctx->ctrldev, CAAM_RNG_DESC_LEN,
-				       GFP_DMA | GFP_KERNEL);
+				       GFP_KERNEL);
 	if (!ctx->desc_async)
 		return -ENOMEM;
 
-	if (kfifo_alloc(&ctx->fifo, CAAM_RNG_MAX_FIFO_STORE_SIZE,
-			GFP_DMA | GFP_KERNEL))
+	if (kfifo_alloc(&ctx->fifo, ALIGN(CAAM_RNG_MAX_FIFO_STORE_SIZE,
+					  dma_get_cache_alignment()),
+			GFP_KERNEL))
 		return -ENOMEM;
 
 	INIT_WORK(&ctx->worker, caam_rng_worker);
diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 32253a064d0f..6278afb951c3 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -199,7 +199,7 @@ static int deinstantiate_rng(struct device *ctrldev, int state_handle_mask)
 	u32 *desc, status;
 	int sh_idx, ret = 0;
 
-	desc = kmalloc(CAAM_CMD_SZ * 3, GFP_KERNEL | GFP_DMA);
+	desc = kmalloc(CAAM_CMD_SZ * 3, GFP_KERNEL);
 	if (!desc)
 		return -ENOMEM;
 
@@ -276,7 +276,7 @@ static int instantiate_rng(struct device *ctrldev, int state_handle_mask,
 	int ret = 0, sh_idx;
 
 	ctrl = (struct caam_ctrl __iomem *)ctrlpriv->ctrl;
-	desc = kmalloc(CAAM_CMD_SZ * 7, GFP_KERNEL | GFP_DMA);
+	desc = kmalloc(CAAM_CMD_SZ * 7, GFP_KERNEL);
 	if (!desc)
 		return -ENOMEM;
 
diff --git a/drivers/crypto/caam/key_gen.c b/drivers/crypto/caam/key_gen.c
index b0e8a4939b4f..88cc4fe2a585 100644
--- a/drivers/crypto/caam/key_gen.c
+++ b/drivers/crypto/caam/key_gen.c
@@ -64,7 +64,7 @@ int gen_split_key(struct device *jrdev, u8 *key_out,
 	if (local_max > max_keylen)
 		return -EINVAL;
 
-	desc = kmalloc(CAAM_CMD_SZ * 6 + CAAM_PTR_SZ * 2, GFP_KERNEL | GFP_DMA);
+	desc = kmalloc(CAAM_CMD_SZ * 6 + CAAM_PTR_SZ * 2, GFP_KERNEL);
 	if (!desc) {
 		dev_err(jrdev, "unable to allocate key input memory\n");
 		return ret;
diff --git a/drivers/crypto/caam/qi.c b/drivers/crypto/caam/qi.c
index c36f27376d7e..4c52c9365558 100644
--- a/drivers/crypto/caam/qi.c
+++ b/drivers/crypto/caam/qi.c
@@ -614,7 +614,7 @@ static int alloc_rsp_fq_cpu(struct device *qidev, unsigned int cpu)
 	struct qman_fq *fq;
 	int ret;
 
-	fq = kzalloc(sizeof(*fq), GFP_KERNEL | GFP_DMA);
+	fq = kzalloc(sizeof(*fq), GFP_KERNEL);
 	if (!fq)
 		return -ENOMEM;
 
@@ -756,7 +756,7 @@ int caam_qi_init(struct platform_device *caam_pdev)
 	}
 
 	qi_cache = kmem_cache_create("caamqicache", CAAM_QI_MEMCACHE_SIZE, 0,
-				     SLAB_CACHE_DMA, NULL);
+				     0, NULL);
 	if (!qi_cache) {
 		dev_err(qidev, "Can't allocate CAAM cache\n");
 		free_rsp_fqs();
diff --git a/drivers/crypto/caam/qi.h b/drivers/crypto/caam/qi.h
index 5894f16f8fe3..a96e3d213c06 100644
--- a/drivers/crypto/caam/qi.h
+++ b/drivers/crypto/caam/qi.h
@@ -9,6 +9,8 @@
 #ifndef __QI_H__
 #define __QI_H__
 
+#include <crypto/algapi.h>
+#include <linux/compiler_attributes.h>
 #include <soc/fsl/qman.h>
 #include "compat.h"
 #include "desc.h"
@@ -58,8 +60,10 @@ enum optype {
  * @qidev: device pointer for CAAM/QI backend
  */
 struct caam_drv_ctx {
-	u32 prehdr[2];
-	u32 sh_desc[MAX_SDLEN];
+	struct {
+		u32 prehdr[2];
+		u32 sh_desc[MAX_SDLEN];
+	} __aligned(CRYPTO_DMA_ALIGN);
 	dma_addr_t context_a;
 	struct qman_fq *req_fq;
 	struct qman_fq *rsp_fq;
@@ -67,7 +71,7 @@ struct caam_drv_ctx {
 	int cpu;
 	enum optype op_type;
 	struct device *qidev;
-} ____cacheline_aligned;
+};
 
 /**
  * caam_drv_req - The request structure the driver application should fill while
@@ -88,7 +92,7 @@ struct caam_drv_req {
 	struct caam_drv_ctx *drv_ctx;
 	caam_qi_cbk cbk;
 	void *app_ctx;
-} ____cacheline_aligned;
+} __aligned(CRYPTO_DMA_ALIGN);
 
 /**
  * caam_drv_ctx_init - Initialise a CAAM/QI driver context
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
