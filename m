Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8421564032F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiLBJW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiLBJV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:21:57 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D214BD42F;
        Fri,  2 Dec 2022 01:21:19 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p12EB-003Apr-OA; Fri, 02 Dec 2022 17:21:04 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Dec 2022 17:21:03 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Fri, 02 Dec 2022 17:21:03 +0800
Subject: [PATCH 9/10] crypto: octeontx2 - Set DMA alignment explicitly
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
Message-Id: <E1p12EB-003Apr-OA@formenos.hmeau.com>
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

 drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c |   79 ++++++++++-----------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
index 67530e90bbfe..30b423605c9c 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
@@ -87,7 +87,7 @@ static inline int validate_hmac_cipher_null(struct otx2_cpt_req_info *cpt_req)
 
 	req = container_of(cpt_req->areq, struct aead_request, base);
 	tfm = crypto_aead_reqtfm(req);
-	rctx = aead_request_ctx(req);
+	rctx = aead_request_ctx_dma(req);
 	if (memcmp(rctx->fctx.hmac.s.hmac_calc,
 		   rctx->fctx.hmac.s.hmac_recv,
 		   crypto_aead_authsize(tfm)) != 0)
@@ -137,7 +137,7 @@ static void output_iv_copyback(struct crypto_async_request *areq)
 	ctx = crypto_skcipher_ctx(stfm);
 	if (ctx->cipher_type == OTX2_CPT_AES_CBC ||
 	    ctx->cipher_type == OTX2_CPT_DES3_CBC) {
-		rctx = skcipher_request_ctx(sreq);
+		rctx = skcipher_request_ctx_dma(sreq);
 		req_info = &rctx->cpt_req;
 		ivsize = crypto_skcipher_ivsize(stfm);
 		start = sreq->cryptlen - ivsize;
@@ -219,7 +219,7 @@ static inline int create_ctx_hdr(struct skcipher_request *req, u32 enc,
 				 u32 *argcnt)
 {
 	struct crypto_skcipher *stfm = crypto_skcipher_reqtfm(req);
-	struct otx2_cpt_req_ctx *rctx = skcipher_request_ctx(req);
+	struct otx2_cpt_req_ctx *rctx = skcipher_request_ctx_dma(req);
 	struct otx2_cpt_enc_ctx *ctx = crypto_skcipher_ctx(stfm);
 	struct otx2_cpt_req_info *req_info = &rctx->cpt_req;
 	struct otx2_cpt_fc_ctx *fctx = &rctx->fctx;
@@ -288,7 +288,7 @@ static inline int create_ctx_hdr(struct skcipher_request *req, u32 enc,
 static inline int create_input_list(struct skcipher_request *req, u32 enc,
 				    u32 enc_iv_len)
 {
-	struct otx2_cpt_req_ctx *rctx = skcipher_request_ctx(req);
+	struct otx2_cpt_req_ctx *rctx = skcipher_request_ctx_dma(req);
 	struct otx2_cpt_req_info *req_info = &rctx->cpt_req;
 	u32 argcnt =  0;
 	int ret;
@@ -306,7 +306,7 @@ static inline int create_input_list(struct skcipher_request *req, u32 enc,
 static inline void create_output_list(struct skcipher_request *req,
 				      u32 enc_iv_len)
 {
-	struct otx2_cpt_req_ctx *rctx = skcipher_request_ctx(req);
+	struct otx2_cpt_req_ctx *rctx = skcipher_request_ctx_dma(req);
 	struct otx2_cpt_req_info *req_info = &rctx->cpt_req;
 	u32 argcnt = 0;
 
@@ -325,7 +325,7 @@ static inline void create_output_list(struct skcipher_request *req,
 static int skcipher_do_fallback(struct skcipher_request *req, bool is_enc)
 {
 	struct crypto_skcipher *stfm = crypto_skcipher_reqtfm(req);
-	struct otx2_cpt_req_ctx *rctx = skcipher_request_ctx(req);
+	struct otx2_cpt_req_ctx *rctx = skcipher_request_ctx_dma(req);
 	struct otx2_cpt_enc_ctx *ctx = crypto_skcipher_ctx(stfm);
 	int ret;
 
@@ -348,7 +348,7 @@ static int skcipher_do_fallback(struct skcipher_request *req, bool is_enc)
 static inline int cpt_enc_dec(struct skcipher_request *req, u32 enc)
 {
 	struct crypto_skcipher *stfm = crypto_skcipher_reqtfm(req);
-	struct otx2_cpt_req_ctx *rctx = skcipher_request_ctx(req);
+	struct otx2_cpt_req_ctx *rctx = skcipher_request_ctx_dma(req);
 	struct otx2_cpt_enc_ctx *ctx = crypto_skcipher_ctx(stfm);
 	struct otx2_cpt_req_info *req_info = &rctx->cpt_req;
 	u32 enc_iv_len = crypto_skcipher_ivsize(stfm);
@@ -537,8 +537,9 @@ static int otx2_cpt_enc_dec_init(struct crypto_skcipher *stfm)
 	 * allocated since the cryptd daemon uses
 	 * this memory for request_ctx information
 	 */
-	crypto_skcipher_set_reqsize(stfm, sizeof(struct otx2_cpt_req_ctx) +
-					sizeof(struct skcipher_request));
+	crypto_skcipher_set_reqsize_dma(
+		stfm, sizeof(struct otx2_cpt_req_ctx) +
+		      sizeof(struct skcipher_request));
 
 	return cpt_skcipher_fallback_init(ctx, alg);
 }
@@ -572,7 +573,7 @@ static int cpt_aead_fallback_init(struct otx2_cpt_aead_ctx *ctx,
 
 static int cpt_aead_init(struct crypto_aead *atfm, u8 cipher_type, u8 mac_type)
 {
-	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx(atfm);
+	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(atfm);
 	struct crypto_tfm *tfm = crypto_aead_tfm(atfm);
 	struct crypto_alg *alg = tfm->__crt_alg;
 
@@ -629,7 +630,7 @@ static int cpt_aead_init(struct crypto_aead *atfm, u8 cipher_type, u8 mac_type)
 		ctx->enc_align_len = 1;
 		break;
 	}
-	crypto_aead_set_reqsize(atfm, sizeof(struct otx2_cpt_req_ctx));
+	crypto_aead_set_reqsize_dma(atfm, sizeof(struct otx2_cpt_req_ctx));
 
 	return cpt_aead_fallback_init(ctx, alg);
 }
@@ -681,7 +682,7 @@ static int otx2_cpt_aead_gcm_aes_init(struct crypto_aead *tfm)
 
 static void otx2_cpt_aead_exit(struct crypto_aead *tfm)
 {
-	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx(tfm);
+	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(tfm);
 
 	kfree(ctx->ipad);
 	kfree(ctx->opad);
@@ -698,7 +699,7 @@ static void otx2_cpt_aead_exit(struct crypto_aead *tfm)
 static int otx2_cpt_aead_gcm_set_authsize(struct crypto_aead *tfm,
 					  unsigned int authsize)
 {
-	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx(tfm);
+	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(tfm);
 
 	if (crypto_rfc4106_check_authsize(authsize))
 		return -EINVAL;
@@ -722,7 +723,7 @@ static int otx2_cpt_aead_set_authsize(struct crypto_aead *tfm,
 static int otx2_cpt_aead_null_set_authsize(struct crypto_aead *tfm,
 					   unsigned int authsize)
 {
-	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx(tfm);
+	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(tfm);
 
 	ctx->is_trunc_hmac = true;
 	tfm->authsize = authsize;
@@ -794,7 +795,7 @@ static int copy_pad(u8 mac_type, u8 *out_pad, u8 *in_pad)
 
 static int aead_hmac_init(struct crypto_aead *cipher)
 {
-	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx(cipher);
+	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(cipher);
 	int state_size = crypto_shash_statesize(ctx->hashalg);
 	int ds = crypto_shash_digestsize(ctx->hashalg);
 	int bs = crypto_shash_blocksize(ctx->hashalg);
@@ -892,7 +893,7 @@ static int otx2_cpt_aead_cbc_aes_sha_setkey(struct crypto_aead *cipher,
 					    const unsigned char *key,
 					    unsigned int keylen)
 {
-	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx(cipher);
+	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(cipher);
 	struct crypto_authenc_key_param *param;
 	int enckeylen = 0, authkeylen = 0;
 	struct rtattr *rta = (void *)key;
@@ -944,7 +945,7 @@ static int otx2_cpt_aead_ecb_null_sha_setkey(struct crypto_aead *cipher,
 					     const unsigned char *key,
 					     unsigned int keylen)
 {
-	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx(cipher);
+	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(cipher);
 	struct crypto_authenc_key_param *param;
 	struct rtattr *rta = (void *)key;
 	int enckeylen = 0;
@@ -979,7 +980,7 @@ static int otx2_cpt_aead_gcm_aes_setkey(struct crypto_aead *cipher,
 					const unsigned char *key,
 					unsigned int keylen)
 {
-	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx(cipher);
+	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(cipher);
 
 	/*
 	 * For aes gcm we expect to get encryption key (16, 24, 32 bytes)
@@ -1012,9 +1013,9 @@ static int otx2_cpt_aead_gcm_aes_setkey(struct crypto_aead *cipher,
 static inline int create_aead_ctx_hdr(struct aead_request *req, u32 enc,
 				      u32 *argcnt)
 {
-	struct otx2_cpt_req_ctx *rctx = aead_request_ctx(req);
+	struct otx2_cpt_req_ctx *rctx = aead_request_ctx_dma(req);
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx(tfm);
+	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(tfm);
 	struct otx2_cpt_req_info *req_info = &rctx->cpt_req;
 	struct otx2_cpt_fc_ctx *fctx = &rctx->fctx;
 	int mac_len = crypto_aead_authsize(tfm);
@@ -1103,9 +1104,9 @@ static inline int create_aead_ctx_hdr(struct aead_request *req, u32 enc,
 static inline void create_hmac_ctx_hdr(struct aead_request *req, u32 *argcnt,
 				      u32 enc)
 {
-	struct otx2_cpt_req_ctx *rctx = aead_request_ctx(req);
+	struct otx2_cpt_req_ctx *rctx = aead_request_ctx_dma(req);
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx(tfm);
+	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(tfm);
 	struct otx2_cpt_req_info *req_info = &rctx->cpt_req;
 
 	req_info->ctrl.s.dma_mode = OTX2_CPT_DMA_MODE_SG;
@@ -1127,7 +1128,7 @@ static inline void create_hmac_ctx_hdr(struct aead_request *req, u32 *argcnt,
 
 static inline int create_aead_input_list(struct aead_request *req, u32 enc)
 {
-	struct otx2_cpt_req_ctx *rctx = aead_request_ctx(req);
+	struct otx2_cpt_req_ctx *rctx = aead_request_ctx_dma(req);
 	struct otx2_cpt_req_info *req_info = &rctx->cpt_req;
 	u32 inputlen =  req->cryptlen + req->assoclen;
 	u32 status, argcnt = 0;
@@ -1144,7 +1145,7 @@ static inline int create_aead_input_list(struct aead_request *req, u32 enc)
 static inline void create_aead_output_list(struct aead_request *req, u32 enc,
 					   u32 mac_len)
 {
-	struct otx2_cpt_req_ctx *rctx = aead_request_ctx(req);
+	struct otx2_cpt_req_ctx *rctx = aead_request_ctx_dma(req);
 	struct otx2_cpt_req_info *req_info =  &rctx->cpt_req;
 	u32 argcnt = 0, outputlen = 0;
 
@@ -1160,7 +1161,7 @@ static inline void create_aead_output_list(struct aead_request *req, u32 enc,
 static inline void create_aead_null_input_list(struct aead_request *req,
 					       u32 enc, u32 mac_len)
 {
-	struct otx2_cpt_req_ctx *rctx = aead_request_ctx(req);
+	struct otx2_cpt_req_ctx *rctx = aead_request_ctx_dma(req);
 	struct otx2_cpt_req_info *req_info = &rctx->cpt_req;
 	u32 inputlen, argcnt = 0;
 
@@ -1177,7 +1178,7 @@ static inline void create_aead_null_input_list(struct aead_request *req,
 static inline int create_aead_null_output_list(struct aead_request *req,
 					       u32 enc, u32 mac_len)
 {
-	struct otx2_cpt_req_ctx *rctx = aead_request_ctx(req);
+	struct otx2_cpt_req_ctx *rctx = aead_request_ctx_dma(req);
 	struct otx2_cpt_req_info *req_info =  &rctx->cpt_req;
 	struct scatterlist *dst;
 	u8 *ptr = NULL;
@@ -1257,9 +1258,9 @@ static inline int create_aead_null_output_list(struct aead_request *req,
 
 static int aead_do_fallback(struct aead_request *req, bool is_enc)
 {
-	struct otx2_cpt_req_ctx *rctx = aead_request_ctx(req);
+	struct otx2_cpt_req_ctx *rctx = aead_request_ctx_dma(req);
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx(aead);
+	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(aead);
 	int ret;
 
 	if (ctx->fbk_cipher) {
@@ -1281,10 +1282,10 @@ static int aead_do_fallback(struct aead_request *req, bool is_enc)
 
 static int cpt_aead_enc_dec(struct aead_request *req, u8 reg_type, u8 enc)
 {
-	struct otx2_cpt_req_ctx *rctx = aead_request_ctx(req);
+	struct otx2_cpt_req_ctx *rctx = aead_request_ctx_dma(req);
 	struct otx2_cpt_req_info *req_info = &rctx->cpt_req;
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx(tfm);
+	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(tfm);
 	struct pci_dev *pdev;
 	int status, cpu_num;
 
@@ -1458,7 +1459,7 @@ static struct aead_alg otx2_cpt_aeads[] = { {
 		.cra_driver_name = "cpt_hmac_sha1_cbc_aes",
 		.cra_blocksize = AES_BLOCK_SIZE,
 		.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK,
-		.cra_ctxsize = sizeof(struct otx2_cpt_aead_ctx),
+		.cra_ctxsize = sizeof(struct otx2_cpt_aead_ctx) + CRYPTO_DMA_PADDING,
 		.cra_priority = 4001,
 		.cra_alignmask = 0,
 		.cra_module = THIS_MODULE,
@@ -1477,7 +1478,7 @@ static struct aead_alg otx2_cpt_aeads[] = { {
 		.cra_driver_name = "cpt_hmac_sha256_cbc_aes",
 		.cra_blocksize = AES_BLOCK_SIZE,
 		.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK,
-		.cra_ctxsize = sizeof(struct otx2_cpt_aead_ctx),
+		.cra_ctxsize = sizeof(struct otx2_cpt_aead_ctx) + CRYPTO_DMA_PADDING,
 		.cra_priority = 4001,
 		.cra_alignmask = 0,
 		.cra_module = THIS_MODULE,
@@ -1496,7 +1497,7 @@ static struct aead_alg otx2_cpt_aeads[] = { {
 		.cra_driver_name = "cpt_hmac_sha384_cbc_aes",
 		.cra_blocksize = AES_BLOCK_SIZE,
 		.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK,
-		.cra_ctxsize = sizeof(struct otx2_cpt_aead_ctx),
+		.cra_ctxsize = sizeof(struct otx2_cpt_aead_ctx) + CRYPTO_DMA_PADDING,
 		.cra_priority = 4001,
 		.cra_alignmask = 0,
 		.cra_module = THIS_MODULE,
@@ -1515,7 +1516,7 @@ static struct aead_alg otx2_cpt_aeads[] = { {
 		.cra_driver_name = "cpt_hmac_sha512_cbc_aes",
 		.cra_blocksize = AES_BLOCK_SIZE,
 		.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK,
-		.cra_ctxsize = sizeof(struct otx2_cpt_aead_ctx),
+		.cra_ctxsize = sizeof(struct otx2_cpt_aead_ctx) + CRYPTO_DMA_PADDING,
 		.cra_priority = 4001,
 		.cra_alignmask = 0,
 		.cra_module = THIS_MODULE,
@@ -1534,7 +1535,7 @@ static struct aead_alg otx2_cpt_aeads[] = { {
 		.cra_driver_name = "cpt_hmac_sha1_ecb_null",
 		.cra_blocksize = 1,
 		.cra_flags = CRYPTO_ALG_ASYNC,
-		.cra_ctxsize = sizeof(struct otx2_cpt_aead_ctx),
+		.cra_ctxsize = sizeof(struct otx2_cpt_aead_ctx) + CRYPTO_DMA_PADDING,
 		.cra_priority = 4001,
 		.cra_alignmask = 0,
 		.cra_module = THIS_MODULE,
@@ -1553,7 +1554,7 @@ static struct aead_alg otx2_cpt_aeads[] = { {
 		.cra_driver_name = "cpt_hmac_sha256_ecb_null",
 		.cra_blocksize = 1,
 		.cra_flags = CRYPTO_ALG_ASYNC,
-		.cra_ctxsize = sizeof(struct otx2_cpt_aead_ctx),
+		.cra_ctxsize = sizeof(struct otx2_cpt_aead_ctx) + CRYPTO_DMA_PADDING,
 		.cra_priority = 4001,
 		.cra_alignmask = 0,
 		.cra_module = THIS_MODULE,
@@ -1572,7 +1573,7 @@ static struct aead_alg otx2_cpt_aeads[] = { {
 		.cra_driver_name = "cpt_hmac_sha384_ecb_null",
 		.cra_blocksize = 1,
 		.cra_flags = CRYPTO_ALG_ASYNC,
-		.cra_ctxsize = sizeof(struct otx2_cpt_aead_ctx),
+		.cra_ctxsize = sizeof(struct otx2_cpt_aead_ctx) + CRYPTO_DMA_PADDING,
 		.cra_priority = 4001,
 		.cra_alignmask = 0,
 		.cra_module = THIS_MODULE,
@@ -1591,7 +1592,7 @@ static struct aead_alg otx2_cpt_aeads[] = { {
 		.cra_driver_name = "cpt_hmac_sha512_ecb_null",
 		.cra_blocksize = 1,
 		.cra_flags = CRYPTO_ALG_ASYNC,
-		.cra_ctxsize = sizeof(struct otx2_cpt_aead_ctx),
+		.cra_ctxsize = sizeof(struct otx2_cpt_aead_ctx) + CRYPTO_DMA_PADDING,
 		.cra_priority = 4001,
 		.cra_alignmask = 0,
 		.cra_module = THIS_MODULE,
@@ -1610,7 +1611,7 @@ static struct aead_alg otx2_cpt_aeads[] = { {
 		.cra_driver_name = "cpt_rfc4106_gcm_aes",
 		.cra_blocksize = 1,
 		.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK,
-		.cra_ctxsize = sizeof(struct otx2_cpt_aead_ctx),
+		.cra_ctxsize = sizeof(struct otx2_cpt_aead_ctx) + CRYPTO_DMA_PADDING,
 		.cra_priority = 4001,
 		.cra_alignmask = 0,
 		.cra_module = THIS_MODULE,
