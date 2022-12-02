Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088BF640324
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiLBJVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbiLBJVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:21:09 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDC6BBBC5;
        Fri,  2 Dec 2022 01:21:07 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p12Dx-003Ao9-4q; Fri, 02 Dec 2022 17:20:50 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Dec 2022 17:20:49 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Fri, 02 Dec 2022 17:20:49 +0800
Subject: [PATCH 2/10] crypto: ccp - Set DMA alignment explicitly
References: <Y4nDL50nToBbi4DS@gondor.apana.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
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
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Message-Id: <E1p12Dx-003Ao9-4q@formenos.hmeau.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver has been implicitly relying on kmalloc alignment
to be sufficient for DMA.  This may no longer be the case with
upcoming arm64 changes.

This patch changes it to explicitly request DMA alignment from
the Crypto API.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 drivers/crypto/ccp/ccp-crypto-aes-cmac.c   |   21 +++++++++++----------
 drivers/crypto/ccp/ccp-crypto-aes-galois.c |   12 ++++++------
 drivers/crypto/ccp/ccp-crypto-aes-xts.c    |   20 +++++++++++---------
 drivers/crypto/ccp/ccp-crypto-aes.c        |   29 +++++++++++++++--------------
 drivers/crypto/ccp/ccp-crypto-des3.c       |   17 +++++++++--------
 drivers/crypto/ccp/ccp-crypto-main.c       |    4 ++--
 drivers/crypto/ccp/ccp-crypto-rsa.c        |   18 +++++++++---------
 drivers/crypto/ccp/ccp-crypto-sha.c        |   26 +++++++++++++-------------
 8 files changed, 76 insertions(+), 71 deletions(-)

diff --git a/drivers/crypto/ccp/ccp-crypto-aes-cmac.c b/drivers/crypto/ccp/ccp-crypto-aes-cmac.c
index 11a305fa19e6..d8426bdf3190 100644
--- a/drivers/crypto/ccp/ccp-crypto-aes-cmac.c
+++ b/drivers/crypto/ccp/ccp-crypto-aes-cmac.c
@@ -25,7 +25,7 @@ static int ccp_aes_cmac_complete(struct crypto_async_request *async_req,
 {
 	struct ahash_request *req = ahash_request_cast(async_req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct ccp_aes_cmac_req_ctx *rctx = ahash_request_ctx(req);
+	struct ccp_aes_cmac_req_ctx *rctx = ahash_request_ctx_dma(req);
 	unsigned int digest_size = crypto_ahash_digestsize(tfm);
 
 	if (ret)
@@ -56,8 +56,8 @@ static int ccp_do_cmac_update(struct ahash_request *req, unsigned int nbytes,
 			      unsigned int final)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct ccp_ctx *ctx = crypto_ahash_ctx(tfm);
-	struct ccp_aes_cmac_req_ctx *rctx = ahash_request_ctx(req);
+	struct ccp_ctx *ctx = crypto_ahash_ctx_dma(tfm);
+	struct ccp_aes_cmac_req_ctx *rctx = ahash_request_ctx_dma(req);
 	struct scatterlist *sg, *cmac_key_sg = NULL;
 	unsigned int block_size =
 		crypto_tfm_alg_blocksize(crypto_ahash_tfm(tfm));
@@ -182,7 +182,7 @@ static int ccp_do_cmac_update(struct ahash_request *req, unsigned int nbytes,
 
 static int ccp_aes_cmac_init(struct ahash_request *req)
 {
-	struct ccp_aes_cmac_req_ctx *rctx = ahash_request_ctx(req);
+	struct ccp_aes_cmac_req_ctx *rctx = ahash_request_ctx_dma(req);
 
 	memset(rctx, 0, sizeof(*rctx));
 
@@ -219,7 +219,7 @@ static int ccp_aes_cmac_digest(struct ahash_request *req)
 
 static int ccp_aes_cmac_export(struct ahash_request *req, void *out)
 {
-	struct ccp_aes_cmac_req_ctx *rctx = ahash_request_ctx(req);
+	struct ccp_aes_cmac_req_ctx *rctx = ahash_request_ctx_dma(req);
 	struct ccp_aes_cmac_exp_ctx state;
 
 	/* Don't let anything leak to 'out' */
@@ -238,7 +238,7 @@ static int ccp_aes_cmac_export(struct ahash_request *req, void *out)
 
 static int ccp_aes_cmac_import(struct ahash_request *req, const void *in)
 {
-	struct ccp_aes_cmac_req_ctx *rctx = ahash_request_ctx(req);
+	struct ccp_aes_cmac_req_ctx *rctx = ahash_request_ctx_dma(req);
 	struct ccp_aes_cmac_exp_ctx state;
 
 	/* 'in' may not be aligned so memcpy to local variable */
@@ -256,7 +256,7 @@ static int ccp_aes_cmac_import(struct ahash_request *req, const void *in)
 static int ccp_aes_cmac_setkey(struct crypto_ahash *tfm, const u8 *key,
 			       unsigned int key_len)
 {
-	struct ccp_ctx *ctx = crypto_tfm_ctx(crypto_ahash_tfm(tfm));
+	struct ccp_ctx *ctx = crypto_ahash_ctx_dma(tfm);
 	struct ccp_crypto_ahash_alg *alg =
 		ccp_crypto_ahash_alg(crypto_ahash_tfm(tfm));
 	u64 k0_hi, k0_lo, k1_hi, k1_lo, k2_hi, k2_lo;
@@ -334,13 +334,14 @@ static int ccp_aes_cmac_setkey(struct crypto_ahash *tfm, const u8 *key,
 
 static int ccp_aes_cmac_cra_init(struct crypto_tfm *tfm)
 {
-	struct ccp_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct ccp_ctx *ctx = crypto_tfm_ctx_dma(tfm);
 	struct crypto_ahash *ahash = __crypto_ahash_cast(tfm);
 
 	ctx->complete = ccp_aes_cmac_complete;
 	ctx->u.aes.key_len = 0;
 
-	crypto_ahash_set_reqsize(ahash, sizeof(struct ccp_aes_cmac_req_ctx));
+	crypto_ahash_set_reqsize_dma(ahash,
+				     sizeof(struct ccp_aes_cmac_req_ctx));
 
 	return 0;
 }
@@ -382,7 +383,7 @@ int ccp_register_aes_cmac_algs(struct list_head *head)
 			  CRYPTO_ALG_KERN_DRIVER_ONLY |
 			  CRYPTO_ALG_NEED_FALLBACK;
 	base->cra_blocksize = AES_BLOCK_SIZE;
-	base->cra_ctxsize = sizeof(struct ccp_ctx);
+	base->cra_ctxsize = sizeof(struct ccp_ctx) + crypto_dma_padding();
 	base->cra_priority = CCP_CRA_PRIORITY;
 	base->cra_init = ccp_aes_cmac_cra_init;
 	base->cra_module = THIS_MODULE;
diff --git a/drivers/crypto/ccp/ccp-crypto-aes-galois.c b/drivers/crypto/ccp/ccp-crypto-aes-galois.c
index 1c1c939f5c39..b1dbb8cea559 100644
--- a/drivers/crypto/ccp/ccp-crypto-aes-galois.c
+++ b/drivers/crypto/ccp/ccp-crypto-aes-galois.c
@@ -29,7 +29,7 @@ static int ccp_aes_gcm_complete(struct crypto_async_request *async_req, int ret)
 static int ccp_aes_gcm_setkey(struct crypto_aead *tfm, const u8 *key,
 			      unsigned int key_len)
 {
-	struct ccp_ctx *ctx = crypto_aead_ctx(tfm);
+	struct ccp_ctx *ctx = crypto_aead_ctx_dma(tfm);
 
 	switch (key_len) {
 	case AES_KEYSIZE_128:
@@ -76,8 +76,8 @@ static int ccp_aes_gcm_setauthsize(struct crypto_aead *tfm,
 static int ccp_aes_gcm_crypt(struct aead_request *req, bool encrypt)
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct ccp_ctx *ctx = crypto_aead_ctx(tfm);
-	struct ccp_aes_req_ctx *rctx = aead_request_ctx(req);
+	struct ccp_ctx *ctx = crypto_aead_ctx_dma(tfm);
+	struct ccp_aes_req_ctx *rctx = aead_request_ctx_dma(req);
 	struct scatterlist *iv_sg = NULL;
 	unsigned int iv_len = 0;
 	int i;
@@ -148,12 +148,12 @@ static int ccp_aes_gcm_decrypt(struct aead_request *req)
 
 static int ccp_aes_gcm_cra_init(struct crypto_aead *tfm)
 {
-	struct ccp_ctx *ctx = crypto_aead_ctx(tfm);
+	struct ccp_ctx *ctx = crypto_aead_ctx_dma(tfm);
 
 	ctx->complete = ccp_aes_gcm_complete;
 	ctx->u.aes.key_len = 0;
 
-	crypto_aead_set_reqsize(tfm, sizeof(struct ccp_aes_req_ctx));
+	crypto_aead_set_reqsize_dma(tfm, sizeof(struct ccp_aes_req_ctx));
 
 	return 0;
 }
@@ -176,7 +176,7 @@ static struct aead_alg ccp_aes_gcm_defaults = {
 				  CRYPTO_ALG_KERN_DRIVER_ONLY |
 				  CRYPTO_ALG_NEED_FALLBACK,
 		.cra_blocksize	= AES_BLOCK_SIZE,
-		.cra_ctxsize	= sizeof(struct ccp_ctx),
+		.cra_ctxsize	= sizeof(struct ccp_ctx) + CRYPTO_DMA_PADDING,
 		.cra_priority	= CCP_CRA_PRIORITY,
 		.cra_exit	= ccp_aes_gcm_cra_exit,
 		.cra_module	= THIS_MODULE,
diff --git a/drivers/crypto/ccp/ccp-crypto-aes-xts.c b/drivers/crypto/ccp/ccp-crypto-aes-xts.c
index 6849261ca47d..93f735d6b02b 100644
--- a/drivers/crypto/ccp/ccp-crypto-aes-xts.c
+++ b/drivers/crypto/ccp/ccp-crypto-aes-xts.c
@@ -62,7 +62,7 @@ static struct ccp_unit_size_map xts_unit_sizes[] = {
 static int ccp_aes_xts_complete(struct crypto_async_request *async_req, int ret)
 {
 	struct skcipher_request *req = skcipher_request_cast(async_req);
-	struct ccp_aes_req_ctx *rctx = skcipher_request_ctx(req);
+	struct ccp_aes_req_ctx *rctx = skcipher_request_ctx_dma(req);
 
 	if (ret)
 		return ret;
@@ -75,7 +75,7 @@ static int ccp_aes_xts_complete(struct crypto_async_request *async_req, int ret)
 static int ccp_aes_xts_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			      unsigned int key_len)
 {
-	struct ccp_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct ccp_ctx *ctx = crypto_skcipher_ctx_dma(tfm);
 	unsigned int ccpversion = ccp_version();
 	int ret;
 
@@ -105,8 +105,8 @@ static int ccp_aes_xts_crypt(struct skcipher_request *req,
 			     unsigned int encrypt)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct ccp_ctx *ctx = crypto_skcipher_ctx(tfm);
-	struct ccp_aes_req_ctx *rctx = skcipher_request_ctx(req);
+	struct ccp_ctx *ctx = crypto_skcipher_ctx_dma(tfm);
+	struct ccp_aes_req_ctx *rctx = skcipher_request_ctx_dma(req);
 	unsigned int ccpversion = ccp_version();
 	unsigned int fallback = 0;
 	unsigned int unit;
@@ -196,7 +196,7 @@ static int ccp_aes_xts_decrypt(struct skcipher_request *req)
 
 static int ccp_aes_xts_init_tfm(struct crypto_skcipher *tfm)
 {
-	struct ccp_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct ccp_ctx *ctx = crypto_skcipher_ctx_dma(tfm);
 	struct crypto_skcipher *fallback_tfm;
 
 	ctx->complete = ccp_aes_xts_complete;
@@ -210,15 +210,16 @@ static int ccp_aes_xts_init_tfm(struct crypto_skcipher *tfm)
 	}
 	ctx->u.aes.tfm_skcipher = fallback_tfm;
 
-	crypto_skcipher_set_reqsize(tfm, sizeof(struct ccp_aes_req_ctx) +
-					 crypto_skcipher_reqsize(fallback_tfm));
+	crypto_skcipher_set_reqsize_dma(tfm,
+					sizeof(struct ccp_aes_req_ctx) +
+					crypto_skcipher_reqsize(fallback_tfm));
 
 	return 0;
 }
 
 static void ccp_aes_xts_exit_tfm(struct crypto_skcipher *tfm)
 {
-	struct ccp_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct ccp_ctx *ctx = crypto_skcipher_ctx_dma(tfm);
 
 	crypto_free_skcipher(ctx->u.aes.tfm_skcipher);
 }
@@ -246,7 +247,8 @@ static int ccp_register_aes_xts_alg(struct list_head *head,
 				  CRYPTO_ALG_KERN_DRIVER_ONLY |
 				  CRYPTO_ALG_NEED_FALLBACK;
 	alg->base.cra_blocksize	= AES_BLOCK_SIZE;
-	alg->base.cra_ctxsize	= sizeof(struct ccp_ctx);
+	alg->base.cra_ctxsize	= sizeof(struct ccp_ctx) +
+				  crypto_dma_padding();
 	alg->base.cra_priority	= CCP_CRA_PRIORITY;
 	alg->base.cra_module	= THIS_MODULE;
 
diff --git a/drivers/crypto/ccp/ccp-crypto-aes.c b/drivers/crypto/ccp/ccp-crypto-aes.c
index bed331953ff9..918e223f21b6 100644
--- a/drivers/crypto/ccp/ccp-crypto-aes.c
+++ b/drivers/crypto/ccp/ccp-crypto-aes.c
@@ -22,8 +22,9 @@
 static int ccp_aes_complete(struct crypto_async_request *async_req, int ret)
 {
 	struct skcipher_request *req = skcipher_request_cast(async_req);
-	struct ccp_ctx *ctx = crypto_tfm_ctx(req->base.tfm);
-	struct ccp_aes_req_ctx *rctx = skcipher_request_ctx(req);
+	struct ccp_ctx *ctx = crypto_skcipher_ctx_dma(
+		crypto_skcipher_reqtfm(req));
+	struct ccp_aes_req_ctx *rctx = skcipher_request_ctx_dma(req);
 
 	if (ret)
 		return ret;
@@ -38,7 +39,7 @@ static int ccp_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			  unsigned int key_len)
 {
 	struct ccp_crypto_skcipher_alg *alg = ccp_crypto_skcipher_alg(tfm);
-	struct ccp_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct ccp_ctx *ctx = crypto_skcipher_ctx_dma(tfm);
 
 	switch (key_len) {
 	case AES_KEYSIZE_128:
@@ -65,8 +66,8 @@ static int ccp_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
 static int ccp_aes_crypt(struct skcipher_request *req, bool encrypt)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct ccp_ctx *ctx = crypto_skcipher_ctx(tfm);
-	struct ccp_aes_req_ctx *rctx = skcipher_request_ctx(req);
+	struct ccp_ctx *ctx = crypto_skcipher_ctx_dma(tfm);
+	struct ccp_aes_req_ctx *rctx = skcipher_request_ctx_dma(req);
 	struct scatterlist *iv_sg = NULL;
 	unsigned int iv_len = 0;
 
@@ -118,7 +119,7 @@ static int ccp_aes_decrypt(struct skcipher_request *req)
 
 static int ccp_aes_init_tfm(struct crypto_skcipher *tfm)
 {
-	struct ccp_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct ccp_ctx *ctx = crypto_skcipher_ctx_dma(tfm);
 
 	ctx->complete = ccp_aes_complete;
 	ctx->u.aes.key_len = 0;
@@ -132,7 +133,7 @@ static int ccp_aes_rfc3686_complete(struct crypto_async_request *async_req,
 				    int ret)
 {
 	struct skcipher_request *req = skcipher_request_cast(async_req);
-	struct ccp_aes_req_ctx *rctx = skcipher_request_ctx(req);
+	struct ccp_aes_req_ctx *rctx = skcipher_request_ctx_dma(req);
 
 	/* Restore the original pointer */
 	req->iv = rctx->rfc3686_info;
@@ -143,7 +144,7 @@ static int ccp_aes_rfc3686_complete(struct crypto_async_request *async_req,
 static int ccp_aes_rfc3686_setkey(struct crypto_skcipher *tfm, const u8 *key,
 				  unsigned int key_len)
 {
-	struct ccp_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct ccp_ctx *ctx = crypto_skcipher_ctx_dma(tfm);
 
 	if (key_len < CTR_RFC3686_NONCE_SIZE)
 		return -EINVAL;
@@ -157,8 +158,8 @@ static int ccp_aes_rfc3686_setkey(struct crypto_skcipher *tfm, const u8 *key,
 static int ccp_aes_rfc3686_crypt(struct skcipher_request *req, bool encrypt)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct ccp_ctx *ctx = crypto_skcipher_ctx(tfm);
-	struct ccp_aes_req_ctx *rctx = skcipher_request_ctx(req);
+	struct ccp_ctx *ctx = crypto_skcipher_ctx_dma(tfm);
+	struct ccp_aes_req_ctx *rctx = skcipher_request_ctx_dma(req);
 	u8 *iv;
 
 	/* Initialize the CTR block */
@@ -190,12 +191,12 @@ static int ccp_aes_rfc3686_decrypt(struct skcipher_request *req)
 
 static int ccp_aes_rfc3686_init_tfm(struct crypto_skcipher *tfm)
 {
-	struct ccp_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct ccp_ctx *ctx = crypto_skcipher_ctx_dma(tfm);
 
 	ctx->complete = ccp_aes_rfc3686_complete;
 	ctx->u.aes.key_len = 0;
 
-	crypto_skcipher_set_reqsize(tfm, sizeof(struct ccp_aes_req_ctx));
+	crypto_skcipher_set_reqsize_dma(tfm, sizeof(struct ccp_aes_req_ctx));
 
 	return 0;
 }
@@ -213,7 +214,7 @@ static const struct skcipher_alg ccp_aes_defaults = {
 				  CRYPTO_ALG_KERN_DRIVER_ONLY |
 				  CRYPTO_ALG_NEED_FALLBACK,
 	.base.cra_blocksize	= AES_BLOCK_SIZE,
-	.base.cra_ctxsize	= sizeof(struct ccp_ctx),
+	.base.cra_ctxsize	= sizeof(struct ccp_ctx) + CRYPTO_DMA_PADDING,
 	.base.cra_priority	= CCP_CRA_PRIORITY,
 	.base.cra_module	= THIS_MODULE,
 };
@@ -231,7 +232,7 @@ static const struct skcipher_alg ccp_aes_rfc3686_defaults = {
 				  CRYPTO_ALG_KERN_DRIVER_ONLY |
 				  CRYPTO_ALG_NEED_FALLBACK,
 	.base.cra_blocksize	= CTR_RFC3686_BLOCK_SIZE,
-	.base.cra_ctxsize	= sizeof(struct ccp_ctx),
+	.base.cra_ctxsize	= sizeof(struct ccp_ctx) + CRYPTO_DMA_PADDING,
 	.base.cra_priority	= CCP_CRA_PRIORITY,
 	.base.cra_module	= THIS_MODULE,
 };
diff --git a/drivers/crypto/ccp/ccp-crypto-des3.c b/drivers/crypto/ccp/ccp-crypto-des3.c
index 278636ed251a..afae30adb703 100644
--- a/drivers/crypto/ccp/ccp-crypto-des3.c
+++ b/drivers/crypto/ccp/ccp-crypto-des3.c
@@ -21,8 +21,9 @@
 static int ccp_des3_complete(struct crypto_async_request *async_req, int ret)
 {
 	struct skcipher_request *req = skcipher_request_cast(async_req);
-	struct ccp_ctx *ctx = crypto_tfm_ctx(req->base.tfm);
-	struct ccp_des3_req_ctx *rctx = skcipher_request_ctx(req);
+	struct ccp_ctx *ctx = crypto_skcipher_ctx_dma(
+		crypto_skcipher_reqtfm(req));
+	struct ccp_des3_req_ctx *rctx = skcipher_request_ctx_dma(req);
 
 	if (ret)
 		return ret;
@@ -37,7 +38,7 @@ static int ccp_des3_setkey(struct crypto_skcipher *tfm, const u8 *key,
 		unsigned int key_len)
 {
 	struct ccp_crypto_skcipher_alg *alg = ccp_crypto_skcipher_alg(tfm);
-	struct ccp_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct ccp_ctx *ctx = crypto_skcipher_ctx_dma(tfm);
 	int err;
 
 	err = verify_skcipher_des3_key(tfm, key);
@@ -60,8 +61,8 @@ static int ccp_des3_setkey(struct crypto_skcipher *tfm, const u8 *key,
 static int ccp_des3_crypt(struct skcipher_request *req, bool encrypt)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct ccp_ctx *ctx = crypto_skcipher_ctx(tfm);
-	struct ccp_des3_req_ctx *rctx = skcipher_request_ctx(req);
+	struct ccp_ctx *ctx = crypto_skcipher_ctx_dma(tfm);
+	struct ccp_des3_req_ctx *rctx = skcipher_request_ctx_dma(req);
 	struct scatterlist *iv_sg = NULL;
 	unsigned int iv_len = 0;
 
@@ -114,12 +115,12 @@ static int ccp_des3_decrypt(struct skcipher_request *req)
 
 static int ccp_des3_init_tfm(struct crypto_skcipher *tfm)
 {
-	struct ccp_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct ccp_ctx *ctx = crypto_skcipher_ctx_dma(tfm);
 
 	ctx->complete = ccp_des3_complete;
 	ctx->u.des3.key_len = 0;
 
-	crypto_skcipher_set_reqsize(tfm, sizeof(struct ccp_des3_req_ctx));
+	crypto_skcipher_set_reqsize_dma(tfm, sizeof(struct ccp_des3_req_ctx));
 
 	return 0;
 }
@@ -137,7 +138,7 @@ static const struct skcipher_alg ccp_des3_defaults = {
 				  CRYPTO_ALG_KERN_DRIVER_ONLY |
 				  CRYPTO_ALG_NEED_FALLBACK,
 	.base.cra_blocksize	= DES3_EDE_BLOCK_SIZE,
-	.base.cra_ctxsize	= sizeof(struct ccp_ctx),
+	.base.cra_ctxsize	= sizeof(struct ccp_ctx) + CRYPTO_DMA_PADDING,
 	.base.cra_priority	= CCP_CRA_PRIORITY,
 	.base.cra_module	= THIS_MODULE,
 };
diff --git a/drivers/crypto/ccp/ccp-crypto-main.c b/drivers/crypto/ccp/ccp-crypto-main.c
index dd86d2650bea..73442a382f68 100644
--- a/drivers/crypto/ccp/ccp-crypto-main.c
+++ b/drivers/crypto/ccp/ccp-crypto-main.c
@@ -139,7 +139,7 @@ static void ccp_crypto_complete(void *data, int err)
 	struct ccp_crypto_cmd *crypto_cmd = data;
 	struct ccp_crypto_cmd *held, *next, *backlog;
 	struct crypto_async_request *req = crypto_cmd->req;
-	struct ccp_ctx *ctx = crypto_tfm_ctx(req->tfm);
+	struct ccp_ctx *ctx = crypto_tfm_ctx_dma(req->tfm);
 	int ret;
 
 	if (err == -EINPROGRESS) {
@@ -183,7 +183,7 @@ static void ccp_crypto_complete(void *data, int err)
 			break;
 
 		/* Error occurred, report it and get the next entry */
-		ctx = crypto_tfm_ctx(held->req->tfm);
+		ctx = crypto_tfm_ctx_dma(held->req->tfm);
 		if (ctx->complete)
 			ret = ctx->complete(held->req, ret);
 		held->req->complete(held->req, ret);
diff --git a/drivers/crypto/ccp/ccp-crypto-rsa.c b/drivers/crypto/ccp/ccp-crypto-rsa.c
index 1223ac70aea2..a14f85512cf4 100644
--- a/drivers/crypto/ccp/ccp-crypto-rsa.c
+++ b/drivers/crypto/ccp/ccp-crypto-rsa.c
@@ -44,7 +44,7 @@ static inline int ccp_copy_and_save_keypart(u8 **kpbuf, unsigned int *kplen,
 static int ccp_rsa_complete(struct crypto_async_request *async_req, int ret)
 {
 	struct akcipher_request *req = akcipher_request_cast(async_req);
-	struct ccp_rsa_req_ctx *rctx = akcipher_request_ctx(req);
+	struct ccp_rsa_req_ctx *rctx = akcipher_request_ctx_dma(req);
 
 	if (ret)
 		return ret;
@@ -56,7 +56,7 @@ static int ccp_rsa_complete(struct crypto_async_request *async_req, int ret)
 
 static unsigned int ccp_rsa_maxsize(struct crypto_akcipher *tfm)
 {
-	struct ccp_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct ccp_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 
 	return ctx->u.rsa.n_len;
 }
@@ -64,8 +64,8 @@ static unsigned int ccp_rsa_maxsize(struct crypto_akcipher *tfm)
 static int ccp_rsa_crypt(struct akcipher_request *req, bool encrypt)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
-	struct ccp_ctx *ctx = akcipher_tfm_ctx(tfm);
-	struct ccp_rsa_req_ctx *rctx = akcipher_request_ctx(req);
+	struct ccp_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
+	struct ccp_rsa_req_ctx *rctx = akcipher_request_ctx_dma(req);
 	int ret = 0;
 
 	memset(&rctx->cmd, 0, sizeof(rctx->cmd));
@@ -126,7 +126,7 @@ static void ccp_rsa_free_key_bufs(struct ccp_ctx *ctx)
 static int ccp_rsa_setkey(struct crypto_akcipher *tfm, const void *key,
 			  unsigned int keylen, bool private)
 {
-	struct ccp_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct ccp_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 	struct rsa_key raw_key;
 	int ret;
 
@@ -192,9 +192,9 @@ static int ccp_rsa_setpubkey(struct crypto_akcipher *tfm, const void *key,
 
 static int ccp_rsa_init_tfm(struct crypto_akcipher *tfm)
 {
-	struct ccp_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct ccp_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 
-	akcipher_set_reqsize(tfm, sizeof(struct ccp_rsa_req_ctx));
+	akcipher_set_reqsize_dma(tfm, sizeof(struct ccp_rsa_req_ctx));
 	ctx->complete = ccp_rsa_complete;
 
 	return 0;
@@ -202,7 +202,7 @@ static int ccp_rsa_init_tfm(struct crypto_akcipher *tfm)
 
 static void ccp_rsa_exit_tfm(struct crypto_akcipher *tfm)
 {
-	struct ccp_ctx *ctx = crypto_tfm_ctx(&tfm->base);
+	struct ccp_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 
 	ccp_rsa_free_key_bufs(ctx);
 }
@@ -220,7 +220,7 @@ static struct akcipher_alg ccp_rsa_defaults = {
 		.cra_driver_name = "rsa-ccp",
 		.cra_priority = CCP_CRA_PRIORITY,
 		.cra_module = THIS_MODULE,
-		.cra_ctxsize = 2 * sizeof(struct ccp_ctx),
+		.cra_ctxsize = 2 * sizeof(struct ccp_ctx) + CRYPTO_DMA_PADDING,
 	},
 };
 
diff --git a/drivers/crypto/ccp/ccp-crypto-sha.c b/drivers/crypto/ccp/ccp-crypto-sha.c
index 74fa5360e722..fa3ae8e78f6f 100644
--- a/drivers/crypto/ccp/ccp-crypto-sha.c
+++ b/drivers/crypto/ccp/ccp-crypto-sha.c
@@ -28,7 +28,7 @@ static int ccp_sha_complete(struct crypto_async_request *async_req, int ret)
 {
 	struct ahash_request *req = ahash_request_cast(async_req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct ccp_sha_req_ctx *rctx = ahash_request_ctx(req);
+	struct ccp_sha_req_ctx *rctx = ahash_request_ctx_dma(req);
 	unsigned int digest_size = crypto_ahash_digestsize(tfm);
 
 	if (ret)
@@ -59,8 +59,8 @@ static int ccp_do_sha_update(struct ahash_request *req, unsigned int nbytes,
 			     unsigned int final)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct ccp_ctx *ctx = crypto_ahash_ctx(tfm);
-	struct ccp_sha_req_ctx *rctx = ahash_request_ctx(req);
+	struct ccp_ctx *ctx = crypto_ahash_ctx_dma(tfm);
+	struct ccp_sha_req_ctx *rctx = ahash_request_ctx_dma(req);
 	struct scatterlist *sg;
 	unsigned int block_size =
 		crypto_tfm_alg_blocksize(crypto_ahash_tfm(tfm));
@@ -182,8 +182,8 @@ static int ccp_do_sha_update(struct ahash_request *req, unsigned int nbytes,
 static int ccp_sha_init(struct ahash_request *req)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct ccp_ctx *ctx = crypto_ahash_ctx(tfm);
-	struct ccp_sha_req_ctx *rctx = ahash_request_ctx(req);
+	struct ccp_ctx *ctx = crypto_ahash_ctx_dma(tfm);
+	struct ccp_sha_req_ctx *rctx = ahash_request_ctx_dma(req);
 	struct ccp_crypto_ahash_alg *alg =
 		ccp_crypto_ahash_alg(crypto_ahash_tfm(tfm));
 	unsigned int block_size =
@@ -231,7 +231,7 @@ static int ccp_sha_digest(struct ahash_request *req)
 
 static int ccp_sha_export(struct ahash_request *req, void *out)
 {
-	struct ccp_sha_req_ctx *rctx = ahash_request_ctx(req);
+	struct ccp_sha_req_ctx *rctx = ahash_request_ctx_dma(req);
 	struct ccp_sha_exp_ctx state;
 
 	/* Don't let anything leak to 'out' */
@@ -252,7 +252,7 @@ static int ccp_sha_export(struct ahash_request *req, void *out)
 
 static int ccp_sha_import(struct ahash_request *req, const void *in)
 {
-	struct ccp_sha_req_ctx *rctx = ahash_request_ctx(req);
+	struct ccp_sha_req_ctx *rctx = ahash_request_ctx_dma(req);
 	struct ccp_sha_exp_ctx state;
 
 	/* 'in' may not be aligned so memcpy to local variable */
@@ -272,7 +272,7 @@ static int ccp_sha_import(struct ahash_request *req, const void *in)
 static int ccp_sha_setkey(struct crypto_ahash *tfm, const u8 *key,
 			  unsigned int key_len)
 {
-	struct ccp_ctx *ctx = crypto_tfm_ctx(crypto_ahash_tfm(tfm));
+	struct ccp_ctx *ctx = crypto_ahash_ctx_dma(tfm);
 	struct crypto_shash *shash = ctx->u.sha.hmac_tfm;
 	unsigned int block_size = crypto_shash_blocksize(shash);
 	unsigned int digest_size = crypto_shash_digestsize(shash);
@@ -313,13 +313,13 @@ static int ccp_sha_setkey(struct crypto_ahash *tfm, const u8 *key,
 
 static int ccp_sha_cra_init(struct crypto_tfm *tfm)
 {
-	struct ccp_ctx *ctx = crypto_tfm_ctx(tfm);
 	struct crypto_ahash *ahash = __crypto_ahash_cast(tfm);
+	struct ccp_ctx *ctx = crypto_ahash_ctx_dma(ahash);
 
 	ctx->complete = ccp_sha_complete;
 	ctx->u.sha.key_len = 0;
 
-	crypto_ahash_set_reqsize(ahash, sizeof(struct ccp_sha_req_ctx));
+	crypto_ahash_set_reqsize_dma(ahash, sizeof(struct ccp_sha_req_ctx));
 
 	return 0;
 }
@@ -330,7 +330,7 @@ static void ccp_sha_cra_exit(struct crypto_tfm *tfm)
 
 static int ccp_hmac_sha_cra_init(struct crypto_tfm *tfm)
 {
-	struct ccp_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct ccp_ctx *ctx = crypto_tfm_ctx_dma(tfm);
 	struct ccp_crypto_ahash_alg *alg = ccp_crypto_ahash_alg(tfm);
 	struct crypto_shash *hmac_tfm;
 
@@ -348,7 +348,7 @@ static int ccp_hmac_sha_cra_init(struct crypto_tfm *tfm)
 
 static void ccp_hmac_sha_cra_exit(struct crypto_tfm *tfm)
 {
-	struct ccp_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct ccp_ctx *ctx = crypto_tfm_ctx_dma(tfm);
 
 	if (ctx->u.sha.hmac_tfm)
 		crypto_free_shash(ctx->u.sha.hmac_tfm);
@@ -492,7 +492,7 @@ static int ccp_register_sha_alg(struct list_head *head,
 			  CRYPTO_ALG_KERN_DRIVER_ONLY |
 			  CRYPTO_ALG_NEED_FALLBACK;
 	base->cra_blocksize = def->block_size;
-	base->cra_ctxsize = sizeof(struct ccp_ctx);
+	base->cra_ctxsize = sizeof(struct ccp_ctx) + crypto_dma_padding();
 	base->cra_priority = CCP_CRA_PRIORITY;
 	base->cra_init = ccp_sha_cra_init;
 	base->cra_exit = ccp_sha_cra_exit;
