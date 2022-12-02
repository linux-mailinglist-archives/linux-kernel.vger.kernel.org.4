Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4586464032D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiLBJWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbiLBJVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:21:19 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35D5BD42D;
        Fri,  2 Dec 2022 01:21:17 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p12E9-003ApZ-KZ; Fri, 02 Dec 2022 17:21:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Dec 2022 17:21:01 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Fri, 02 Dec 2022 17:21:01 +0800
Subject: [PATCH 8/10] crypto: octeontx - Set DMA alignment explicitly
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
Message-Id: <E1p12E9-003ApZ-KZ@formenos.hmeau.com>
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

 drivers/crypto/marvell/octeontx/otx_cptvf_algs.c |   69 +++++++++++------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c b/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
index 01c48ddc4eeb..80ba77c793a7 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
@@ -103,7 +103,7 @@ static inline int validate_hmac_cipher_null(struct otx_cpt_req_info *cpt_req)
 
 	req = container_of(cpt_req->areq, struct aead_request, base);
 	tfm = crypto_aead_reqtfm(req);
-	rctx = aead_request_ctx(req);
+	rctx = aead_request_ctx_dma(req);
 	if (memcmp(rctx->fctx.hmac.s.hmac_calc,
 		   rctx->fctx.hmac.s.hmac_recv,
 		   crypto_aead_authsize(tfm)) != 0)
@@ -155,7 +155,7 @@ static void output_iv_copyback(struct crypto_async_request *areq)
 	ctx = crypto_skcipher_ctx(stfm);
 	if (ctx->cipher_type == OTX_CPT_AES_CBC ||
 	    ctx->cipher_type == OTX_CPT_DES3_CBC) {
-		rctx = skcipher_request_ctx(sreq);
+		rctx = skcipher_request_ctx_dma(sreq);
 		req_info = &rctx->cpt_req;
 		ivsize = crypto_skcipher_ivsize(stfm);
 		start = sreq->cryptlen - ivsize;
@@ -233,7 +233,7 @@ static inline u32 create_ctx_hdr(struct skcipher_request *req, u32 enc,
 				 u32 *argcnt)
 {
 	struct crypto_skcipher *stfm = crypto_skcipher_reqtfm(req);
-	struct otx_cpt_req_ctx *rctx = skcipher_request_ctx(req);
+	struct otx_cpt_req_ctx *rctx = skcipher_request_ctx_dma(req);
 	struct otx_cpt_req_info *req_info = &rctx->cpt_req;
 	struct crypto_tfm *tfm = crypto_skcipher_tfm(stfm);
 	struct otx_cpt_enc_ctx *ctx = crypto_tfm_ctx(tfm);
@@ -303,7 +303,7 @@ static inline u32 create_ctx_hdr(struct skcipher_request *req, u32 enc,
 static inline u32 create_input_list(struct skcipher_request *req, u32 enc,
 				    u32 enc_iv_len)
 {
-	struct otx_cpt_req_ctx *rctx = skcipher_request_ctx(req);
+	struct otx_cpt_req_ctx *rctx = skcipher_request_ctx_dma(req);
 	struct otx_cpt_req_info *req_info = &rctx->cpt_req;
 	u32 argcnt =  0;
 	int ret;
@@ -321,7 +321,7 @@ static inline u32 create_input_list(struct skcipher_request *req, u32 enc,
 static inline void create_output_list(struct skcipher_request *req,
 				      u32 enc_iv_len)
 {
-	struct otx_cpt_req_ctx *rctx = skcipher_request_ctx(req);
+	struct otx_cpt_req_ctx *rctx = skcipher_request_ctx_dma(req);
 	struct otx_cpt_req_info *req_info = &rctx->cpt_req;
 	u32 argcnt = 0;
 
@@ -340,7 +340,7 @@ static inline void create_output_list(struct skcipher_request *req,
 static inline int cpt_enc_dec(struct skcipher_request *req, u32 enc)
 {
 	struct crypto_skcipher *stfm = crypto_skcipher_reqtfm(req);
-	struct otx_cpt_req_ctx *rctx = skcipher_request_ctx(req);
+	struct otx_cpt_req_ctx *rctx = skcipher_request_ctx_dma(req);
 	struct otx_cpt_req_info *req_info = &rctx->cpt_req;
 	u32 enc_iv_len = crypto_skcipher_ivsize(stfm);
 	struct pci_dev *pdev;
@@ -501,15 +501,16 @@ static int otx_cpt_enc_dec_init(struct crypto_skcipher *tfm)
 	 * allocated since the cryptd daemon uses
 	 * this memory for request_ctx information
 	 */
-	crypto_skcipher_set_reqsize(tfm, sizeof(struct otx_cpt_req_ctx) +
-					sizeof(struct skcipher_request));
+	crypto_skcipher_set_reqsize_dma(
+		tfm, sizeof(struct otx_cpt_req_ctx) +
+		     sizeof(struct skcipher_request));
 
 	return 0;
 }
 
 static int cpt_aead_init(struct crypto_aead *tfm, u8 cipher_type, u8 mac_type)
 {
-	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx(tfm);
+	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(tfm);
 
 	ctx->cipher_type = cipher_type;
 	ctx->mac_type = mac_type;
@@ -551,7 +552,7 @@ static int cpt_aead_init(struct crypto_aead *tfm, u8 cipher_type, u8 mac_type)
 		}
 	}
 
-	crypto_aead_set_reqsize(tfm, sizeof(struct otx_cpt_req_ctx));
+	crypto_aead_set_reqsize_dma(tfm, sizeof(struct otx_cpt_req_ctx));
 
 	return 0;
 }
@@ -603,7 +604,7 @@ static int otx_cpt_aead_gcm_aes_init(struct crypto_aead *tfm)
 
 static void otx_cpt_aead_exit(struct crypto_aead *tfm)
 {
-	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx(tfm);
+	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(tfm);
 
 	kfree(ctx->ipad);
 	kfree(ctx->opad);
@@ -619,7 +620,7 @@ static void otx_cpt_aead_exit(struct crypto_aead *tfm)
 static int otx_cpt_aead_set_authsize(struct crypto_aead *tfm,
 				     unsigned int authsize)
 {
-	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx(tfm);
+	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(tfm);
 
 	switch (ctx->mac_type) {
 	case OTX_CPT_SHA1:
@@ -739,7 +740,7 @@ static int copy_pad(u8 mac_type, u8 *out_pad, u8 *in_pad)
 
 static int aead_hmac_init(struct crypto_aead *cipher)
 {
-	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx(cipher);
+	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(cipher);
 	int state_size = crypto_shash_statesize(ctx->hashalg);
 	int ds = crypto_shash_digestsize(ctx->hashalg);
 	int bs = crypto_shash_blocksize(ctx->hashalg);
@@ -837,7 +838,7 @@ static int otx_cpt_aead_cbc_aes_sha_setkey(struct crypto_aead *cipher,
 					   const unsigned char *key,
 					   unsigned int keylen)
 {
-	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx(cipher);
+	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(cipher);
 	struct crypto_authenc_key_param *param;
 	int enckeylen = 0, authkeylen = 0;
 	struct rtattr *rta = (void *)key;
@@ -896,7 +897,7 @@ static int otx_cpt_aead_ecb_null_sha_setkey(struct crypto_aead *cipher,
 					    const unsigned char *key,
 					    unsigned int keylen)
 {
-	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx(cipher);
+	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(cipher);
 	struct crypto_authenc_key_param *param;
 	struct rtattr *rta = (void *)key;
 	int enckeylen = 0;
@@ -932,7 +933,7 @@ static int otx_cpt_aead_gcm_aes_setkey(struct crypto_aead *cipher,
 				       const unsigned char *key,
 				       unsigned int keylen)
 {
-	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx(cipher);
+	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(cipher);
 
 	/*
 	 * For aes gcm we expect to get encryption key (16, 24, 32 bytes)
@@ -965,9 +966,9 @@ static int otx_cpt_aead_gcm_aes_setkey(struct crypto_aead *cipher,
 static inline u32 create_aead_ctx_hdr(struct aead_request *req, u32 enc,
 				      u32 *argcnt)
 {
-	struct otx_cpt_req_ctx *rctx = aead_request_ctx(req);
+	struct otx_cpt_req_ctx *rctx = aead_request_ctx_dma(req);
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx(tfm);
+	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(tfm);
 	struct otx_cpt_req_info *req_info = &rctx->cpt_req;
 	struct otx_cpt_fc_ctx *fctx = &rctx->fctx;
 	int mac_len = crypto_aead_authsize(tfm);
@@ -1050,9 +1051,9 @@ static inline u32 create_aead_ctx_hdr(struct aead_request *req, u32 enc,
 static inline u32 create_hmac_ctx_hdr(struct aead_request *req, u32 *argcnt,
 				      u32 enc)
 {
-	struct otx_cpt_req_ctx *rctx = aead_request_ctx(req);
+	struct otx_cpt_req_ctx *rctx = aead_request_ctx_dma(req);
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx(tfm);
+	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(tfm);
 	struct otx_cpt_req_info *req_info = &rctx->cpt_req;
 
 	req_info->ctrl.s.dma_mode = OTX_CPT_DMA_GATHER_SCATTER;
@@ -1076,7 +1077,7 @@ static inline u32 create_hmac_ctx_hdr(struct aead_request *req, u32 *argcnt,
 
 static inline u32 create_aead_input_list(struct aead_request *req, u32 enc)
 {
-	struct otx_cpt_req_ctx *rctx = aead_request_ctx(req);
+	struct otx_cpt_req_ctx *rctx = aead_request_ctx_dma(req);
 	struct otx_cpt_req_info *req_info = &rctx->cpt_req;
 	u32 inputlen =  req->cryptlen + req->assoclen;
 	u32 status, argcnt = 0;
@@ -1093,7 +1094,7 @@ static inline u32 create_aead_input_list(struct aead_request *req, u32 enc)
 static inline u32 create_aead_output_list(struct aead_request *req, u32 enc,
 					  u32 mac_len)
 {
-	struct otx_cpt_req_ctx *rctx = aead_request_ctx(req);
+	struct otx_cpt_req_ctx *rctx = aead_request_ctx_dma(req);
 	struct otx_cpt_req_info *req_info =  &rctx->cpt_req;
 	u32 argcnt = 0, outputlen = 0;
 
@@ -1111,7 +1112,7 @@ static inline u32 create_aead_output_list(struct aead_request *req, u32 enc,
 static inline u32 create_aead_null_input_list(struct aead_request *req,
 					      u32 enc, u32 mac_len)
 {
-	struct otx_cpt_req_ctx *rctx = aead_request_ctx(req);
+	struct otx_cpt_req_ctx *rctx = aead_request_ctx_dma(req);
 	struct otx_cpt_req_info *req_info = &rctx->cpt_req;
 	u32 inputlen, argcnt = 0;
 
@@ -1130,7 +1131,7 @@ static inline u32 create_aead_null_input_list(struct aead_request *req,
 static inline u32 create_aead_null_output_list(struct aead_request *req,
 					       u32 enc, u32 mac_len)
 {
-	struct otx_cpt_req_ctx *rctx = aead_request_ctx(req);
+	struct otx_cpt_req_ctx *rctx = aead_request_ctx_dma(req);
 	struct otx_cpt_req_info *req_info =  &rctx->cpt_req;
 	struct scatterlist *dst;
 	u8 *ptr = NULL;
@@ -1217,7 +1218,7 @@ static inline u32 create_aead_null_output_list(struct aead_request *req,
 
 static u32 cpt_aead_enc_dec(struct aead_request *req, u8 reg_type, u8 enc)
 {
-	struct otx_cpt_req_ctx *rctx = aead_request_ctx(req);
+	struct otx_cpt_req_ctx *rctx = aead_request_ctx_dma(req);
 	struct otx_cpt_req_info *req_info = &rctx->cpt_req;
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct pci_dev *pdev;
@@ -1409,7 +1410,7 @@ static struct aead_alg otx_cpt_aeads[] = { {
 		.cra_driver_name = "cpt_hmac_sha1_cbc_aes",
 		.cra_blocksize = AES_BLOCK_SIZE,
 		.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY,
-		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx),
+		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx) + CRYPTO_DMA_PADDING,
 		.cra_priority = 4001,
 		.cra_alignmask = 0,
 		.cra_module = THIS_MODULE,
@@ -1428,7 +1429,7 @@ static struct aead_alg otx_cpt_aeads[] = { {
 		.cra_driver_name = "cpt_hmac_sha256_cbc_aes",
 		.cra_blocksize = AES_BLOCK_SIZE,
 		.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY,
-		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx),
+		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx) + CRYPTO_DMA_PADDING,
 		.cra_priority = 4001,
 		.cra_alignmask = 0,
 		.cra_module = THIS_MODULE,
@@ -1447,7 +1448,7 @@ static struct aead_alg otx_cpt_aeads[] = { {
 		.cra_driver_name = "cpt_hmac_sha384_cbc_aes",
 		.cra_blocksize = AES_BLOCK_SIZE,
 		.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY,
-		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx),
+		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx) + CRYPTO_DMA_PADDING,
 		.cra_priority = 4001,
 		.cra_alignmask = 0,
 		.cra_module = THIS_MODULE,
@@ -1466,7 +1467,7 @@ static struct aead_alg otx_cpt_aeads[] = { {
 		.cra_driver_name = "cpt_hmac_sha512_cbc_aes",
 		.cra_blocksize = AES_BLOCK_SIZE,
 		.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY,
-		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx),
+		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx) + CRYPTO_DMA_PADDING,
 		.cra_priority = 4001,
 		.cra_alignmask = 0,
 		.cra_module = THIS_MODULE,
@@ -1485,7 +1486,7 @@ static struct aead_alg otx_cpt_aeads[] = { {
 		.cra_driver_name = "cpt_hmac_sha1_ecb_null",
 		.cra_blocksize = 1,
 		.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY,
-		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx),
+		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx) + CRYPTO_DMA_PADDING,
 		.cra_priority = 4001,
 		.cra_alignmask = 0,
 		.cra_module = THIS_MODULE,
@@ -1504,7 +1505,7 @@ static struct aead_alg otx_cpt_aeads[] = { {
 		.cra_driver_name = "cpt_hmac_sha256_ecb_null",
 		.cra_blocksize = 1,
 		.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY,
-		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx),
+		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx) + CRYPTO_DMA_PADDING,
 		.cra_priority = 4001,
 		.cra_alignmask = 0,
 		.cra_module = THIS_MODULE,
@@ -1523,7 +1524,7 @@ static struct aead_alg otx_cpt_aeads[] = { {
 		.cra_driver_name = "cpt_hmac_sha384_ecb_null",
 		.cra_blocksize = 1,
 		.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY,
-		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx),
+		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx) + CRYPTO_DMA_PADDING,
 		.cra_priority = 4001,
 		.cra_alignmask = 0,
 		.cra_module = THIS_MODULE,
@@ -1542,7 +1543,7 @@ static struct aead_alg otx_cpt_aeads[] = { {
 		.cra_driver_name = "cpt_hmac_sha512_ecb_null",
 		.cra_blocksize = 1,
 		.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY,
-		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx),
+		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx) + CRYPTO_DMA_PADDING,
 		.cra_priority = 4001,
 		.cra_alignmask = 0,
 		.cra_module = THIS_MODULE,
@@ -1561,7 +1562,7 @@ static struct aead_alg otx_cpt_aeads[] = { {
 		.cra_driver_name = "cpt_rfc4106_gcm_aes",
 		.cra_blocksize = 1,
 		.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY,
-		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx),
+		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx) + CRYPTO_DMA_PADDING,
 		.cra_priority = 4001,
 		.cra_alignmask = 0,
 		.cra_module = THIS_MODULE,
