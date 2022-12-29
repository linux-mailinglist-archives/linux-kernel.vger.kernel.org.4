Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389E9658ABF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 09:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiL2I7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 03:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiL2I7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:59:00 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9271032;
        Thu, 29 Dec 2022 00:58:57 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pAok1-00Bwg6-1M; Thu, 29 Dec 2022 16:58:22 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 29 Dec 2022 16:58:21 +0800
Date:   Thu, 29 Dec 2022 16:58:21 +0800
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
        LinuxKernelMailingList@gondor.apana.org.au,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH] crypto: sun8i-ss - Remove GFP_DMA and add DMA alignment
 padding
Message-ID: <Y61WrVAjjtAMAvSh@gondor.apana.org.au>
References: <Y4nDL50nToBbi4DS@gondor.apana.org.au>
 <Y4xpGNNsfbucyUlt@infradead.org>
 <Y47BgCuZsYLX61A9@gondor.apana.org.au>
 <Y47g7qO8dsRdxCgf@infradead.org>
 <Y47+gxbdKR03EYCj@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y47+gxbdKR03EYCj@gondor.apana.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GFP_DMA does not guarantee that the returned memory is aligned
for DMA.  In fact for sun8i-ss it is superfluous and can be removed.

However, kmalloc may start returning DMA-unaligned memory in future
so fix this by adding the alignment by hand.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
index 902f6be057ec..83c6dfad77e1 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
@@ -452,7 +452,7 @@ int sun8i_ss_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	}
 	kfree_sensitive(op->key);
 	op->keylen = keylen;
-	op->key = kmemdup(key, keylen, GFP_KERNEL | GFP_DMA);
+	op->key = kmemdup(key, keylen, GFP_KERNEL);
 	if (!op->key)
 		return -ENOMEM;
 
@@ -475,7 +475,7 @@ int sun8i_ss_des3_setkey(struct crypto_skcipher *tfm, const u8 *key,
 
 	kfree_sensitive(op->key);
 	op->keylen = keylen;
-	op->key = kmemdup(key, keylen, GFP_KERNEL | GFP_DMA);
+	op->key = kmemdup(key, keylen, GFP_KERNEL);
 	if (!op->key)
 		return -ENOMEM;
 
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
index ac2329e2b0e5..c9dc06f97857 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -527,7 +528,7 @@ static int allocate_flows(struct sun8i_ss_dev *ss)
 		init_completion(&ss->flows[i].complete);
 
 		ss->flows[i].biv = devm_kmalloc(ss->dev, AES_BLOCK_SIZE,
-						GFP_KERNEL | GFP_DMA);
+						GFP_KERNEL);
 		if (!ss->flows[i].biv) {
 			err = -ENOMEM;
 			goto error_engine;
@@ -535,7 +536,7 @@ static int allocate_flows(struct sun8i_ss_dev *ss)
 
 		for (j = 0; j < MAX_SG; j++) {
 			ss->flows[i].iv[j] = devm_kmalloc(ss->dev, AES_BLOCK_SIZE,
-							  GFP_KERNEL | GFP_DMA);
+							  GFP_KERNEL);
 			if (!ss->flows[i].iv[j]) {
 				err = -ENOMEM;
 				goto error_engine;
@@ -544,13 +545,15 @@ static int allocate_flows(struct sun8i_ss_dev *ss)
 
 		/* the padding could be up to two block. */
 		ss->flows[i].pad = devm_kmalloc(ss->dev, MAX_PAD_SIZE,
-						GFP_KERNEL | GFP_DMA);
+						GFP_KERNEL);
 		if (!ss->flows[i].pad) {
 			err = -ENOMEM;
 			goto error_engine;
 		}
-		ss->flows[i].result = devm_kmalloc(ss->dev, SHA256_DIGEST_SIZE,
-						   GFP_KERNEL | GFP_DMA);
+		ss->flows[i].result =
+			devm_kmalloc(ss->dev, max(SHA256_DIGEST_SIZE,
+						  dma_get_cache_alignment()),
+				     GFP_KERNEL);
 		if (!ss->flows[i].result) {
 			err = -ENOMEM;
 			goto error_engine;
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
index 36a82b22953c..577bf636f7fb 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
@@ -79,10 +79,10 @@ int sun8i_ss_hmac_setkey(struct crypto_ahash *ahash, const u8 *key,
 		memcpy(tfmctx->key, key, keylen);
 	}
 
-	tfmctx->ipad = kzalloc(bs, GFP_KERNEL | GFP_DMA);
+	tfmctx->ipad = kzalloc(bs, GFP_KERNEL);
 	if (!tfmctx->ipad)
 		return -ENOMEM;
-	tfmctx->opad = kzalloc(bs, GFP_KERNEL | GFP_DMA);
+	tfmctx->opad = kzalloc(bs, GFP_KERNEL);
 	if (!tfmctx->opad) {
 		ret = -ENOMEM;
 		goto err_opad;
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c
index dd677e9ed06f..70c7b5d571b8 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c
@@ -11,6 +11,8 @@
  */
 #include "sun8i-ss.h"
 #include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
 #include <linux/pm_runtime.h>
 #include <crypto/internal/rng.h>
 
@@ -25,7 +27,7 @@ int sun8i_ss_prng_seed(struct crypto_rng *tfm, const u8 *seed,
 		ctx->seed = NULL;
 	}
 	if (!ctx->seed)
-		ctx->seed = kmalloc(slen, GFP_KERNEL | GFP_DMA);
+		ctx->seed = kmalloc(slen, GFP_KERNEL);
 	if (!ctx->seed)
 		return -ENOMEM;
 
@@ -58,6 +60,7 @@ int sun8i_ss_prng_generate(struct crypto_rng *tfm, const u8 *src,
 	struct sun8i_ss_rng_tfm_ctx *ctx = crypto_rng_ctx(tfm);
 	struct rng_alg *alg = crypto_rng_alg(tfm);
 	struct sun8i_ss_alg_template *algt;
+	unsigned int todo_with_padding;
 	struct sun8i_ss_dev *ss;
 	dma_addr_t dma_iv, dma_dst;
 	unsigned int todo;
@@ -81,7 +84,11 @@ int sun8i_ss_prng_generate(struct crypto_rng *tfm, const u8 *src,
 	todo = dlen + PRNG_SEED_SIZE + PRNG_DATA_SIZE;
 	todo -= todo % PRNG_DATA_SIZE;
 
-	d = kzalloc(todo, GFP_KERNEL | GFP_DMA);
+	todo_with_padding = ALIGN(todo, dma_get_cache_alignment());
+	if (todo_with_padding < todo || todo < dlen)
+		return -EOVERFLOW;
+
+	d = kzalloc(todo_with_padding, GFP_KERNEL);
 	if (!d)
 		return -ENOMEM;
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
