Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D49638339
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 05:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiKYEiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 23:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiKYEhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 23:37:52 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9543D2A41B;
        Thu, 24 Nov 2022 20:37:01 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oyQSD-000dl0-Oh; Fri, 25 Nov 2022 12:36:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 25 Nov 2022 12:36:45 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Fri, 25 Nov 2022 12:36:45 +0800
Subject: [v2 PATCH 9/9] crypto: caam - Set DMA alignment explicitly
References: <Y4BGC2BPesy3qsEm@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Message-Id: <E1oyQSD-000dl0-Oh@formenos.hmeau.com>
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

 drivers/crypto/caam/caamalg.c     |   72 +++++++--------
 drivers/crypto/caam/caamalg_qi.c  |   52 +++++------
 drivers/crypto/caam/caamalg_qi2.c |  173 +++++++++++++++++++-------------------
 drivers/crypto/caam/caamhash.c    |   87 +++++++++----------
 drivers/crypto/caam/caampkc.c     |   47 +++++-----
 5 files changed, 216 insertions(+), 215 deletions(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index d3d8bb0a6990..ecc15bc521db 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -131,7 +131,7 @@ struct caam_aead_req_ctx {
 
 static int aead_null_set_sh_desc(struct crypto_aead *aead)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	struct caam_drv_private *ctrlpriv = dev_get_drvdata(jrdev->parent);
 	u32 *desc;
@@ -184,7 +184,7 @@ static int aead_set_sh_desc(struct crypto_aead *aead)
 	struct caam_aead_alg *alg = container_of(crypto_aead_alg(aead),
 						 struct caam_aead_alg, aead);
 	unsigned int ivsize = crypto_aead_ivsize(aead);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	struct caam_drv_private *ctrlpriv = dev_get_drvdata(jrdev->parent);
 	u32 ctx1_iv_off = 0;
@@ -312,7 +312,7 @@ static int aead_set_sh_desc(struct crypto_aead *aead)
 static int aead_setauthsize(struct crypto_aead *authenc,
 				    unsigned int authsize)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(authenc);
 
 	ctx->authsize = authsize;
 	aead_set_sh_desc(authenc);
@@ -322,7 +322,7 @@ static int aead_setauthsize(struct crypto_aead *authenc,
 
 static int gcm_set_sh_desc(struct crypto_aead *aead)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	unsigned int ivsize = crypto_aead_ivsize(aead);
 	u32 *desc;
@@ -372,7 +372,7 @@ static int gcm_set_sh_desc(struct crypto_aead *aead)
 
 static int gcm_setauthsize(struct crypto_aead *authenc, unsigned int authsize)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(authenc);
 	int err;
 
 	err = crypto_gcm_check_authsize(authsize);
@@ -387,7 +387,7 @@ static int gcm_setauthsize(struct crypto_aead *authenc, unsigned int authsize)
 
 static int rfc4106_set_sh_desc(struct crypto_aead *aead)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	unsigned int ivsize = crypto_aead_ivsize(aead);
 	u32 *desc;
@@ -440,7 +440,7 @@ static int rfc4106_set_sh_desc(struct crypto_aead *aead)
 static int rfc4106_setauthsize(struct crypto_aead *authenc,
 			       unsigned int authsize)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(authenc);
 	int err;
 
 	err = crypto_rfc4106_check_authsize(authsize);
@@ -455,7 +455,7 @@ static int rfc4106_setauthsize(struct crypto_aead *authenc,
 
 static int rfc4543_set_sh_desc(struct crypto_aead *aead)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	unsigned int ivsize = crypto_aead_ivsize(aead);
 	u32 *desc;
@@ -508,7 +508,7 @@ static int rfc4543_set_sh_desc(struct crypto_aead *aead)
 static int rfc4543_setauthsize(struct crypto_aead *authenc,
 			       unsigned int authsize)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(authenc);
 
 	if (authsize != 16)
 		return -EINVAL;
@@ -521,7 +521,7 @@ static int rfc4543_setauthsize(struct crypto_aead *authenc,
 
 static int chachapoly_set_sh_desc(struct crypto_aead *aead)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	unsigned int ivsize = crypto_aead_ivsize(aead);
 	u32 *desc;
@@ -547,7 +547,7 @@ static int chachapoly_set_sh_desc(struct crypto_aead *aead)
 static int chachapoly_setauthsize(struct crypto_aead *aead,
 				  unsigned int authsize)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 
 	if (authsize != POLY1305_DIGEST_SIZE)
 		return -EINVAL;
@@ -559,7 +559,7 @@ static int chachapoly_setauthsize(struct crypto_aead *aead,
 static int chachapoly_setkey(struct crypto_aead *aead, const u8 *key,
 			     unsigned int keylen)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	unsigned int ivsize = crypto_aead_ivsize(aead);
 	unsigned int saltlen = CHACHAPOLY_IV_SIZE - ivsize;
 
@@ -575,7 +575,7 @@ static int chachapoly_setkey(struct crypto_aead *aead, const u8 *key,
 static int aead_setkey(struct crypto_aead *aead,
 			       const u8 *key, unsigned int keylen)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	struct caam_drv_private *ctrlpriv = dev_get_drvdata(jrdev->parent);
 	struct crypto_authenc_keys keys;
@@ -656,7 +656,7 @@ static int des3_aead_setkey(struct crypto_aead *aead, const u8 *key,
 static int gcm_setkey(struct crypto_aead *aead,
 		      const u8 *key, unsigned int keylen)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	int err;
 
@@ -677,7 +677,7 @@ static int gcm_setkey(struct crypto_aead *aead,
 static int rfc4106_setkey(struct crypto_aead *aead,
 			  const u8 *key, unsigned int keylen)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	int err;
 
@@ -703,7 +703,7 @@ static int rfc4106_setkey(struct crypto_aead *aead,
 static int rfc4543_setkey(struct crypto_aead *aead,
 			  const u8 *key, unsigned int keylen)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	int err;
 
@@ -729,7 +729,7 @@ static int rfc4543_setkey(struct crypto_aead *aead,
 static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 			   unsigned int keylen, const u32 ctx1_iv_off)
 {
-	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(skcipher);
 	struct caam_skcipher_alg *alg =
 		container_of(crypto_skcipher_alg(skcipher), typeof(*alg),
 			     skcipher);
@@ -832,7 +832,7 @@ static int des3_skcipher_setkey(struct crypto_skcipher *skcipher,
 static int xts_skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 			       unsigned int keylen)
 {
-	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(skcipher);
 	struct device *jrdev = ctx->jrdev;
 	struct caam_drv_private *ctrlpriv = dev_get_drvdata(jrdev->parent);
 	u32 *desc;
@@ -1057,7 +1057,7 @@ static void init_aead_job(struct aead_request *req,
 			  bool all_contig, bool encrypt)
 {
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	int authsize = ctx->authsize;
 	u32 *desc = edesc->hw_desc;
 	u32 out_options, in_options;
@@ -1118,7 +1118,7 @@ static void init_gcm_job(struct aead_request *req,
 			 bool all_contig, bool encrypt)
 {
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	unsigned int ivsize = crypto_aead_ivsize(aead);
 	u32 *desc = edesc->hw_desc;
 	bool generic_gcm = (ivsize == GCM_AES_IV_SIZE);
@@ -1185,7 +1185,7 @@ static void init_authenc_job(struct aead_request *req,
 	struct caam_aead_alg *alg = container_of(crypto_aead_alg(aead),
 						 struct caam_aead_alg, aead);
 	unsigned int ivsize = crypto_aead_ivsize(aead);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct caam_drv_private *ctrlpriv = dev_get_drvdata(ctx->jrdev->parent);
 	const bool ctr_mode = ((ctx->cdata.algtype & OP_ALG_AAI_MASK) ==
 			       OP_ALG_AAI_CTR_MOD128);
@@ -1234,7 +1234,7 @@ static void init_skcipher_job(struct skcipher_request *req,
 			      const bool encrypt)
 {
 	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
-	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(skcipher);
 	struct device *jrdev = ctx->jrdev;
 	int ivsize = crypto_skcipher_ivsize(skcipher);
 	u32 *desc = edesc->hw_desc;
@@ -1290,7 +1290,7 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 					   bool encrypt)
 {
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	struct caam_aead_req_ctx *rctx = aead_request_ctx(req);
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
@@ -1457,7 +1457,7 @@ static inline int chachapoly_crypt(struct aead_request *req, bool encrypt)
 {
 	struct aead_edesc *edesc;
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	bool all_contig;
 	u32 *desc;
@@ -1491,7 +1491,7 @@ static inline int aead_crypt(struct aead_request *req, bool encrypt)
 {
 	struct aead_edesc *edesc;
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	bool all_contig;
 
@@ -1524,7 +1524,7 @@ static int aead_decrypt(struct aead_request *req)
 static int aead_do_one_req(struct crypto_engine *engine, void *areq)
 {
 	struct aead_request *req = aead_request_cast(areq);
-	struct caam_ctx *ctx = crypto_aead_ctx(crypto_aead_reqtfm(req));
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(crypto_aead_reqtfm(req));
 	struct caam_aead_req_ctx *rctx = aead_request_ctx(req);
 	u32 *desc = rctx->edesc->hw_desc;
 	int ret;
@@ -1550,7 +1550,7 @@ static inline int gcm_crypt(struct aead_request *req, bool encrypt)
 {
 	struct aead_edesc *edesc;
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	bool all_contig;
 
@@ -1597,7 +1597,7 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
 						   int desc_bytes)
 {
 	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
-	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(skcipher);
 	struct caam_skcipher_req_ctx *rctx = skcipher_request_ctx(req);
 	struct device *jrdev = ctx->jrdev;
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
@@ -1756,7 +1756,7 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
 static int skcipher_do_one_req(struct crypto_engine *engine, void *areq)
 {
 	struct skcipher_request *req = skcipher_request_cast(areq);
-	struct caam_ctx *ctx = crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(crypto_skcipher_reqtfm(req));
 	struct caam_skcipher_req_ctx *rctx = skcipher_request_ctx(req);
 	u32 *desc = rctx->edesc->hw_desc;
 	int ret;
@@ -1790,7 +1790,7 @@ static inline int skcipher_crypt(struct skcipher_request *req, bool encrypt)
 {
 	struct skcipher_edesc *edesc;
 	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
-	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(skcipher);
 	struct device *jrdev = ctx->jrdev;
 	struct caam_drv_private_jr *jrpriv = dev_get_drvdata(jrdev);
 	struct caam_drv_private *ctrlpriv = dev_get_drvdata(jrdev->parent);
@@ -3397,7 +3397,7 @@ static int caam_cra_init(struct crypto_skcipher *tfm)
 	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
 	struct caam_skcipher_alg *caam_alg =
 		container_of(alg, typeof(*caam_alg), skcipher);
-	struct caam_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(tfm);
 	u32 alg_aai = caam_alg->caam.class1_alg_type & OP_ALG_AAI_MASK;
 	int ret = 0;
 
@@ -3434,7 +3434,7 @@ static int caam_aead_init(struct crypto_aead *tfm)
 	struct aead_alg *alg = crypto_aead_alg(tfm);
 	struct caam_aead_alg *caam_alg =
 		 container_of(alg, struct caam_aead_alg, aead);
-	struct caam_ctx *ctx = crypto_aead_ctx(tfm);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(tfm);
 
 	crypto_aead_set_reqsize(tfm, sizeof(struct caam_aead_req_ctx));
 
@@ -3454,7 +3454,7 @@ static void caam_exit_common(struct caam_ctx *ctx)
 
 static void caam_cra_exit(struct crypto_skcipher *tfm)
 {
-	struct caam_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(tfm);
 
 	if (ctx->fallback)
 		crypto_free_skcipher(ctx->fallback);
@@ -3463,7 +3463,7 @@ static void caam_cra_exit(struct crypto_skcipher *tfm)
 
 static void caam_aead_exit(struct crypto_aead *tfm)
 {
-	caam_exit_common(crypto_aead_ctx(tfm));
+	caam_exit_common(crypto_aead_ctx_dma(tfm));
 }
 
 void caam_algapi_exit(void)
@@ -3491,7 +3491,7 @@ static void caam_skcipher_alg_init(struct caam_skcipher_alg *t_alg)
 
 	alg->base.cra_module = THIS_MODULE;
 	alg->base.cra_priority = CAAM_CRA_PRIORITY;
-	alg->base.cra_ctxsize = sizeof(struct caam_ctx);
+	alg->base.cra_ctxsize = sizeof(struct caam_ctx) + crypto_dma_padding();
 	alg->base.cra_flags |= (CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
 			      CRYPTO_ALG_KERN_DRIVER_ONLY);
 
@@ -3505,7 +3505,7 @@ static void caam_aead_alg_init(struct caam_aead_alg *t_alg)
 
 	alg->base.cra_module = THIS_MODULE;
 	alg->base.cra_priority = CAAM_CRA_PRIORITY;
-	alg->base.cra_ctxsize = sizeof(struct caam_ctx);
+	alg->base.cra_ctxsize = sizeof(struct caam_ctx) + crypto_dma_padding();
 	alg->base.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
 			      CRYPTO_ALG_KERN_DRIVER_ONLY;
 
diff --git a/drivers/crypto/caam/caamalg_qi.c b/drivers/crypto/caam/caamalg_qi.c
index 189a7438b29c..c37b67be0492 100644
--- a/drivers/crypto/caam/caamalg_qi.c
+++ b/drivers/crypto/caam/caamalg_qi.c
@@ -81,7 +81,7 @@ static int aead_set_sh_desc(struct crypto_aead *aead)
 {
 	struct caam_aead_alg *alg = container_of(crypto_aead_alg(aead),
 						 typeof(*alg), aead);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	unsigned int ivsize = crypto_aead_ivsize(aead);
 	u32 ctx1_iv_off = 0;
 	u32 *nonce = NULL;
@@ -184,7 +184,7 @@ static int aead_set_sh_desc(struct crypto_aead *aead)
 
 static int aead_setauthsize(struct crypto_aead *authenc, unsigned int authsize)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(authenc);
 
 	ctx->authsize = authsize;
 	aead_set_sh_desc(authenc);
@@ -195,7 +195,7 @@ static int aead_setauthsize(struct crypto_aead *authenc, unsigned int authsize)
 static int aead_setkey(struct crypto_aead *aead, const u8 *key,
 		       unsigned int keylen)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	struct caam_drv_private *ctrlpriv = dev_get_drvdata(jrdev->parent);
 	struct crypto_authenc_keys keys;
@@ -299,7 +299,7 @@ static int des3_aead_setkey(struct crypto_aead *aead, const u8 *key,
 
 static int gcm_set_sh_desc(struct crypto_aead *aead)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	unsigned int ivsize = crypto_aead_ivsize(aead);
 	int rem_bytes = CAAM_DESC_BYTES_MAX - DESC_JOB_IO_LEN -
 			ctx->cdata.keylen;
@@ -342,7 +342,7 @@ static int gcm_set_sh_desc(struct crypto_aead *aead)
 
 static int gcm_setauthsize(struct crypto_aead *authenc, unsigned int authsize)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(authenc);
 	int err;
 
 	err = crypto_gcm_check_authsize(authsize);
@@ -358,7 +358,7 @@ static int gcm_setauthsize(struct crypto_aead *authenc, unsigned int authsize)
 static int gcm_setkey(struct crypto_aead *aead,
 		      const u8 *key, unsigned int keylen)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	int ret;
 
@@ -402,7 +402,7 @@ static int gcm_setkey(struct crypto_aead *aead,
 
 static int rfc4106_set_sh_desc(struct crypto_aead *aead)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	unsigned int ivsize = crypto_aead_ivsize(aead);
 	int rem_bytes = CAAM_DESC_BYTES_MAX - DESC_JOB_IO_LEN -
 			ctx->cdata.keylen;
@@ -446,7 +446,7 @@ static int rfc4106_set_sh_desc(struct crypto_aead *aead)
 static int rfc4106_setauthsize(struct crypto_aead *authenc,
 			       unsigned int authsize)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(authenc);
 	int err;
 
 	err = crypto_rfc4106_check_authsize(authsize);
@@ -462,7 +462,7 @@ static int rfc4106_setauthsize(struct crypto_aead *authenc,
 static int rfc4106_setkey(struct crypto_aead *aead,
 			  const u8 *key, unsigned int keylen)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	int ret;
 
@@ -510,7 +510,7 @@ static int rfc4106_setkey(struct crypto_aead *aead,
 
 static int rfc4543_set_sh_desc(struct crypto_aead *aead)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	unsigned int ivsize = crypto_aead_ivsize(aead);
 	int rem_bytes = CAAM_DESC_BYTES_MAX - DESC_JOB_IO_LEN -
 			ctx->cdata.keylen;
@@ -554,7 +554,7 @@ static int rfc4543_set_sh_desc(struct crypto_aead *aead)
 static int rfc4543_setauthsize(struct crypto_aead *authenc,
 			       unsigned int authsize)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(authenc);
 
 	if (authsize != 16)
 		return -EINVAL;
@@ -568,7 +568,7 @@ static int rfc4543_setauthsize(struct crypto_aead *authenc,
 static int rfc4543_setkey(struct crypto_aead *aead,
 			  const u8 *key, unsigned int keylen)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *jrdev = ctx->jrdev;
 	int ret;
 
@@ -617,7 +617,7 @@ static int rfc4543_setkey(struct crypto_aead *aead,
 static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 			   unsigned int keylen, const u32 ctx1_iv_off)
 {
-	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(skcipher);
 	struct caam_skcipher_alg *alg =
 		container_of(crypto_skcipher_alg(skcipher), typeof(*alg),
 			     skcipher);
@@ -731,7 +731,7 @@ static int des_skcipher_setkey(struct crypto_skcipher *skcipher,
 static int xts_skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 			       unsigned int keylen)
 {
-	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(skcipher);
 	struct device *jrdev = ctx->jrdev;
 	struct caam_drv_private *ctrlpriv = dev_get_drvdata(jrdev->parent);
 	int ret = 0;
@@ -915,7 +915,7 @@ static void aead_done(struct caam_drv_req *drv_req, u32 status)
 	struct aead_edesc *edesc;
 	struct aead_request *aead_req = drv_req->app_ctx;
 	struct crypto_aead *aead = crypto_aead_reqtfm(aead_req);
-	struct caam_ctx *caam_ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *caam_ctx = crypto_aead_ctx_dma(aead);
 	int ecode = 0;
 
 	qidev = caam_ctx->qidev;
@@ -937,7 +937,7 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 					   bool encrypt)
 {
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct caam_aead_alg *alg = container_of(crypto_aead_alg(aead),
 						 typeof(*alg), aead);
 	struct device *qidev = ctx->qidev;
@@ -1157,7 +1157,7 @@ static inline int aead_crypt(struct aead_request *req, bool encrypt)
 {
 	struct aead_edesc *edesc;
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	int ret;
 
 	if (unlikely(caam_congested))
@@ -1207,7 +1207,7 @@ static void skcipher_done(struct caam_drv_req *drv_req, u32 status)
 	struct skcipher_edesc *edesc;
 	struct skcipher_request *req = drv_req->app_ctx;
 	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
-	struct caam_ctx *caam_ctx = crypto_skcipher_ctx(skcipher);
+	struct caam_ctx *caam_ctx = crypto_skcipher_ctx_dma(skcipher);
 	struct device *qidev = caam_ctx->qidev;
 	int ivsize = crypto_skcipher_ivsize(skcipher);
 	int ecode = 0;
@@ -1245,7 +1245,7 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
 						   bool encrypt)
 {
 	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
-	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(skcipher);
 	struct device *qidev = ctx->qidev;
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		       GFP_KERNEL : GFP_ATOMIC;
@@ -1405,7 +1405,7 @@ static inline int skcipher_crypt(struct skcipher_request *req, bool encrypt)
 {
 	struct skcipher_edesc *edesc;
 	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
-	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(skcipher);
 	struct caam_drv_private *ctrlpriv = dev_get_drvdata(ctx->jrdev->parent);
 	int ret;
 
@@ -2491,7 +2491,7 @@ static int caam_cra_init(struct crypto_skcipher *tfm)
 	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
 	struct caam_skcipher_alg *caam_alg =
 		container_of(alg, typeof(*caam_alg), skcipher);
-	struct caam_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(tfm);
 	u32 alg_aai = caam_alg->caam.class1_alg_type & OP_ALG_AAI_MASK;
 	int ret = 0;
 
@@ -2524,7 +2524,7 @@ static int caam_aead_init(struct crypto_aead *tfm)
 	struct aead_alg *alg = crypto_aead_alg(tfm);
 	struct caam_aead_alg *caam_alg = container_of(alg, typeof(*caam_alg),
 						      aead);
-	struct caam_ctx *ctx = crypto_aead_ctx(tfm);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(tfm);
 
 	return caam_init_common(ctx, &caam_alg->caam, !caam_alg->caam.nodkp);
 }
@@ -2542,7 +2542,7 @@ static void caam_exit_common(struct caam_ctx *ctx)
 
 static void caam_cra_exit(struct crypto_skcipher *tfm)
 {
-	struct caam_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(tfm);
 
 	if (ctx->fallback)
 		crypto_free_skcipher(ctx->fallback);
@@ -2551,7 +2551,7 @@ static void caam_cra_exit(struct crypto_skcipher *tfm)
 
 static void caam_aead_exit(struct crypto_aead *tfm)
 {
-	caam_exit_common(crypto_aead_ctx(tfm));
+	caam_exit_common(crypto_aead_ctx_dma(tfm));
 }
 
 void caam_qi_algapi_exit(void)
@@ -2579,7 +2579,7 @@ static void caam_skcipher_alg_init(struct caam_skcipher_alg *t_alg)
 
 	alg->base.cra_module = THIS_MODULE;
 	alg->base.cra_priority = CAAM_CRA_PRIORITY;
-	alg->base.cra_ctxsize = sizeof(struct caam_ctx);
+	alg->base.cra_ctxsize = sizeof(struct caam_ctx) + crypto_dma_padding();
 	alg->base.cra_flags |= (CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
 				CRYPTO_ALG_KERN_DRIVER_ONLY);
 
@@ -2593,7 +2593,7 @@ static void caam_aead_alg_init(struct caam_aead_alg *t_alg)
 
 	alg->base.cra_module = THIS_MODULE;
 	alg->base.cra_priority = CAAM_CRA_PRIORITY;
-	alg->base.cra_ctxsize = sizeof(struct caam_ctx);
+	alg->base.cra_ctxsize = sizeof(struct caam_ctx) + crypto_dma_padding();
 	alg->base.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
 			      CRYPTO_ALG_KERN_DRIVER_ONLY;
 
diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 4482cb145d05..1b0dd742c53f 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -134,12 +134,12 @@ static struct caam_request *to_caam_req(struct crypto_async_request *areq)
 {
 	switch (crypto_tfm_alg_type(areq->tfm)) {
 	case CRYPTO_ALG_TYPE_SKCIPHER:
-		return skcipher_request_ctx(skcipher_request_cast(areq));
+		return skcipher_request_ctx_dma(skcipher_request_cast(areq));
 	case CRYPTO_ALG_TYPE_AEAD:
-		return aead_request_ctx(container_of(areq, struct aead_request,
-						     base));
+		return aead_request_ctx_dma(
+			container_of(areq, struct aead_request, base));
 	case CRYPTO_ALG_TYPE_AHASH:
-		return ahash_request_ctx(ahash_request_cast(areq));
+		return ahash_request_ctx_dma(ahash_request_cast(areq));
 	default:
 		return ERR_PTR(-EINVAL);
 	}
@@ -171,7 +171,7 @@ static int aead_set_sh_desc(struct crypto_aead *aead)
 {
 	struct caam_aead_alg *alg = container_of(crypto_aead_alg(aead),
 						 typeof(*alg), aead);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	unsigned int ivsize = crypto_aead_ivsize(aead);
 	struct device *dev = ctx->dev;
 	struct dpaa2_caam_priv *priv = dev_get_drvdata(dev);
@@ -276,7 +276,7 @@ static int aead_set_sh_desc(struct crypto_aead *aead)
 
 static int aead_setauthsize(struct crypto_aead *authenc, unsigned int authsize)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(authenc);
 
 	ctx->authsize = authsize;
 	aead_set_sh_desc(authenc);
@@ -287,7 +287,7 @@ static int aead_setauthsize(struct crypto_aead *authenc, unsigned int authsize)
 static int aead_setkey(struct crypto_aead *aead, const u8 *key,
 		       unsigned int keylen)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *dev = ctx->dev;
 	struct crypto_authenc_keys keys;
 
@@ -350,10 +350,10 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 					   bool encrypt)
 {
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct caam_request *req_ctx = aead_request_ctx(req);
+	struct caam_request *req_ctx = aead_request_ctx_dma(req);
 	struct dpaa2_fl_entry *in_fle = &req_ctx->fd_flt[1];
 	struct dpaa2_fl_entry *out_fle = &req_ctx->fd_flt[0];
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct caam_aead_alg *alg = container_of(crypto_aead_alg(aead),
 						 typeof(*alg), aead);
 	struct device *dev = ctx->dev;
@@ -587,7 +587,7 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 
 static int chachapoly_set_sh_desc(struct crypto_aead *aead)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	unsigned int ivsize = crypto_aead_ivsize(aead);
 	struct device *dev = ctx->dev;
 	struct caam_flc *flc;
@@ -620,7 +620,7 @@ static int chachapoly_set_sh_desc(struct crypto_aead *aead)
 static int chachapoly_setauthsize(struct crypto_aead *aead,
 				  unsigned int authsize)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 
 	if (authsize != POLY1305_DIGEST_SIZE)
 		return -EINVAL;
@@ -632,7 +632,7 @@ static int chachapoly_setauthsize(struct crypto_aead *aead,
 static int chachapoly_setkey(struct crypto_aead *aead, const u8 *key,
 			     unsigned int keylen)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	unsigned int ivsize = crypto_aead_ivsize(aead);
 	unsigned int saltlen = CHACHAPOLY_IV_SIZE - ivsize;
 
@@ -647,7 +647,7 @@ static int chachapoly_setkey(struct crypto_aead *aead, const u8 *key,
 
 static int gcm_set_sh_desc(struct crypto_aead *aead)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *dev = ctx->dev;
 	unsigned int ivsize = crypto_aead_ivsize(aead);
 	struct caam_flc *flc;
@@ -704,7 +704,7 @@ static int gcm_set_sh_desc(struct crypto_aead *aead)
 
 static int gcm_setauthsize(struct crypto_aead *authenc, unsigned int authsize)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(authenc);
 	int err;
 
 	err = crypto_gcm_check_authsize(authsize);
@@ -720,7 +720,7 @@ static int gcm_setauthsize(struct crypto_aead *authenc, unsigned int authsize)
 static int gcm_setkey(struct crypto_aead *aead,
 		      const u8 *key, unsigned int keylen)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *dev = ctx->dev;
 	int ret;
 
@@ -739,7 +739,7 @@ static int gcm_setkey(struct crypto_aead *aead,
 
 static int rfc4106_set_sh_desc(struct crypto_aead *aead)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *dev = ctx->dev;
 	unsigned int ivsize = crypto_aead_ivsize(aead);
 	struct caam_flc *flc;
@@ -799,7 +799,7 @@ static int rfc4106_set_sh_desc(struct crypto_aead *aead)
 static int rfc4106_setauthsize(struct crypto_aead *authenc,
 			       unsigned int authsize)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(authenc);
 	int err;
 
 	err = crypto_rfc4106_check_authsize(authsize);
@@ -815,7 +815,7 @@ static int rfc4106_setauthsize(struct crypto_aead *authenc,
 static int rfc4106_setkey(struct crypto_aead *aead,
 			  const u8 *key, unsigned int keylen)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *dev = ctx->dev;
 	int ret;
 
@@ -840,7 +840,7 @@ static int rfc4106_setkey(struct crypto_aead *aead,
 
 static int rfc4543_set_sh_desc(struct crypto_aead *aead)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *dev = ctx->dev;
 	unsigned int ivsize = crypto_aead_ivsize(aead);
 	struct caam_flc *flc;
@@ -900,7 +900,7 @@ static int rfc4543_set_sh_desc(struct crypto_aead *aead)
 static int rfc4543_setauthsize(struct crypto_aead *authenc,
 			       unsigned int authsize)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(authenc);
 
 	if (authsize != 16)
 		return -EINVAL;
@@ -914,7 +914,7 @@ static int rfc4543_setauthsize(struct crypto_aead *authenc,
 static int rfc4543_setkey(struct crypto_aead *aead,
 			  const u8 *key, unsigned int keylen)
 {
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	struct device *dev = ctx->dev;
 	int ret;
 
@@ -940,7 +940,7 @@ static int rfc4543_setkey(struct crypto_aead *aead,
 static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 			   unsigned int keylen, const u32 ctx1_iv_off)
 {
-	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(skcipher);
 	struct caam_skcipher_alg *alg =
 		container_of(crypto_skcipher_alg(skcipher),
 			     struct caam_skcipher_alg, skcipher);
@@ -1059,7 +1059,7 @@ static int des3_skcipher_setkey(struct crypto_skcipher *skcipher,
 static int xts_skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 			       unsigned int keylen)
 {
-	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(skcipher);
 	struct device *dev = ctx->dev;
 	struct dpaa2_caam_priv *priv = dev_get_drvdata(dev);
 	struct caam_flc *flc;
@@ -1109,10 +1109,10 @@ static int xts_skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req)
 {
 	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
-	struct caam_request *req_ctx = skcipher_request_ctx(req);
+	struct caam_request *req_ctx = skcipher_request_ctx_dma(req);
 	struct dpaa2_fl_entry *in_fle = &req_ctx->fd_flt[1];
 	struct dpaa2_fl_entry *out_fle = &req_ctx->fd_flt[0];
-	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(skcipher);
 	struct device *dev = ctx->dev;
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		       GFP_KERNEL : GFP_ATOMIC;
@@ -1286,7 +1286,7 @@ static void aead_encrypt_done(void *cbk_ctx, u32 status)
 	struct caam_request *req_ctx = to_caam_req(areq);
 	struct aead_edesc *edesc = req_ctx->edesc;
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	int ecode = 0;
 
 	dev_dbg(ctx->dev, "%s %d: err 0x%x\n", __func__, __LINE__, status);
@@ -1307,7 +1307,7 @@ static void aead_decrypt_done(void *cbk_ctx, u32 status)
 	struct caam_request *req_ctx = to_caam_req(areq);
 	struct aead_edesc *edesc = req_ctx->edesc;
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
 	int ecode = 0;
 
 	dev_dbg(ctx->dev, "%s %d: err 0x%x\n", __func__, __LINE__, status);
@@ -1324,8 +1324,8 @@ static int aead_encrypt(struct aead_request *req)
 {
 	struct aead_edesc *edesc;
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
-	struct caam_request *caam_req = aead_request_ctx(req);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
+	struct caam_request *caam_req = aead_request_ctx_dma(req);
 	int ret;
 
 	/* allocate extended descriptor */
@@ -1352,8 +1352,8 @@ static int aead_decrypt(struct aead_request *req)
 {
 	struct aead_edesc *edesc;
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
-	struct caam_request *caam_req = aead_request_ctx(req);
+	struct caam_ctx *ctx = crypto_aead_ctx_dma(aead);
+	struct caam_request *caam_req = aead_request_ctx_dma(req);
 	int ret;
 
 	/* allocate extended descriptor */
@@ -1392,7 +1392,7 @@ static void skcipher_encrypt_done(void *cbk_ctx, u32 status)
 	struct skcipher_request *req = skcipher_request_cast(areq);
 	struct caam_request *req_ctx = to_caam_req(areq);
 	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
-	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(skcipher);
 	struct skcipher_edesc *edesc = req_ctx->edesc;
 	int ecode = 0;
 	int ivsize = crypto_skcipher_ivsize(skcipher);
@@ -1430,7 +1430,7 @@ static void skcipher_decrypt_done(void *cbk_ctx, u32 status)
 	struct skcipher_request *req = skcipher_request_cast(areq);
 	struct caam_request *req_ctx = to_caam_req(areq);
 	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
-	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(skcipher);
 	struct skcipher_edesc *edesc = req_ctx->edesc;
 	int ecode = 0;
 	int ivsize = crypto_skcipher_ivsize(skcipher);
@@ -1474,8 +1474,8 @@ static int skcipher_encrypt(struct skcipher_request *req)
 {
 	struct skcipher_edesc *edesc;
 	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
-	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
-	struct caam_request *caam_req = skcipher_request_ctx(req);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(skcipher);
+	struct caam_request *caam_req = skcipher_request_ctx_dma(req);
 	struct dpaa2_caam_priv *priv = dev_get_drvdata(ctx->dev);
 	int ret;
 
@@ -1524,8 +1524,8 @@ static int skcipher_decrypt(struct skcipher_request *req)
 {
 	struct skcipher_edesc *edesc;
 	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
-	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
-	struct caam_request *caam_req = skcipher_request_ctx(req);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(skcipher);
+	struct caam_request *caam_req = skcipher_request_ctx_dma(req);
 	struct dpaa2_caam_priv *priv = dev_get_drvdata(ctx->dev);
 	int ret;
 
@@ -1603,7 +1603,7 @@ static int caam_cra_init_skcipher(struct crypto_skcipher *tfm)
 	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
 	struct caam_skcipher_alg *caam_alg =
 		container_of(alg, typeof(*caam_alg), skcipher);
-	struct caam_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(tfm);
 	u32 alg_aai = caam_alg->caam.class1_alg_type & OP_ALG_AAI_MASK;
 	int ret = 0;
 
@@ -1621,10 +1621,12 @@ static int caam_cra_init_skcipher(struct crypto_skcipher *tfm)
 		}
 
 		ctx->fallback = fallback;
-		crypto_skcipher_set_reqsize(tfm, sizeof(struct caam_request) +
-					    crypto_skcipher_reqsize(fallback));
+		crypto_skcipher_set_reqsize_dma(
+			tfm, sizeof(struct caam_request) +
+			     crypto_skcipher_reqsize(fallback));
 	} else {
-		crypto_skcipher_set_reqsize(tfm, sizeof(struct caam_request));
+		crypto_skcipher_set_reqsize_dma(tfm,
+						sizeof(struct caam_request));
 	}
 
 	ret = caam_cra_init(ctx, &caam_alg->caam, false);
@@ -1640,8 +1642,8 @@ static int caam_cra_init_aead(struct crypto_aead *tfm)
 	struct caam_aead_alg *caam_alg = container_of(alg, typeof(*caam_alg),
 						      aead);
 
-	crypto_aead_set_reqsize(tfm, sizeof(struct caam_request));
-	return caam_cra_init(crypto_aead_ctx(tfm), &caam_alg->caam,
+	crypto_aead_set_reqsize_dma(tfm, sizeof(struct caam_request));
+	return caam_cra_init(crypto_aead_ctx_dma(tfm), &caam_alg->caam,
 			     !caam_alg->caam.nodkp);
 }
 
@@ -1654,7 +1656,7 @@ static void caam_exit_common(struct caam_ctx *ctx)
 
 static void caam_cra_exit(struct crypto_skcipher *tfm)
 {
-	struct caam_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(tfm);
 
 	if (ctx->fallback)
 		crypto_free_skcipher(ctx->fallback);
@@ -1663,7 +1665,7 @@ static void caam_cra_exit(struct crypto_skcipher *tfm)
 
 static void caam_cra_exit_aead(struct crypto_aead *tfm)
 {
-	caam_exit_common(crypto_aead_ctx(tfm));
+	caam_exit_common(crypto_aead_ctx_dma(tfm));
 }
 
 static struct caam_skcipher_alg driver_algs[] = {
@@ -3008,7 +3010,7 @@ static void caam_skcipher_alg_init(struct caam_skcipher_alg *t_alg)
 
 	alg->base.cra_module = THIS_MODULE;
 	alg->base.cra_priority = CAAM_CRA_PRIORITY;
-	alg->base.cra_ctxsize = sizeof(struct caam_ctx);
+	alg->base.cra_ctxsize = sizeof(struct caam_ctx) + crypto_dma_padding();
 	alg->base.cra_flags |= (CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
 			      CRYPTO_ALG_KERN_DRIVER_ONLY);
 
@@ -3022,7 +3024,7 @@ static void caam_aead_alg_init(struct caam_aead_alg *t_alg)
 
 	alg->base.cra_module = THIS_MODULE;
 	alg->base.cra_priority = CAAM_CRA_PRIORITY;
-	alg->base.cra_ctxsize = sizeof(struct caam_ctx);
+	alg->base.cra_ctxsize = sizeof(struct caam_ctx) + crypto_dma_padding();
 	alg->base.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
 			      CRYPTO_ALG_KERN_DRIVER_ONLY;
 
@@ -3132,7 +3134,7 @@ static inline int ctx_map_to_qm_sg(struct device *dev,
 
 static int ahash_set_sh_desc(struct crypto_ahash *ahash)
 {
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
 	int digestsize = crypto_ahash_digestsize(ahash);
 	struct dpaa2_caam_priv *priv = dev_get_drvdata(ctx->dev);
 	struct caam_flc *flc;
@@ -3305,7 +3307,7 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
 static int ahash_setkey(struct crypto_ahash *ahash, const u8 *key,
 			unsigned int keylen)
 {
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
 	unsigned int blocksize = crypto_tfm_alg_blocksize(&ahash->base);
 	unsigned int digestsize = crypto_ahash_digestsize(ahash);
 	int ret;
@@ -3356,7 +3358,7 @@ static int ahash_setkey(struct crypto_ahash *ahash, const u8 *key,
 static inline void ahash_unmap(struct device *dev, struct ahash_edesc *edesc,
 			       struct ahash_request *req)
 {
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 
 	if (edesc->src_nents)
 		dma_unmap_sg(dev, req->src, edesc->src_nents, DMA_TO_DEVICE);
@@ -3376,7 +3378,7 @@ static inline void ahash_unmap_ctx(struct device *dev,
 				   struct ahash_edesc *edesc,
 				   struct ahash_request *req, u32 flag)
 {
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 
 	if (state->ctx_dma) {
 		dma_unmap_single(dev, state->ctx_dma, state->ctx_dma_len, flag);
@@ -3390,9 +3392,9 @@ static void ahash_done(void *cbk_ctx, u32 status)
 	struct crypto_async_request *areq = cbk_ctx;
 	struct ahash_request *req = ahash_request_cast(areq);
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	struct ahash_edesc *edesc = state->caam_req.edesc;
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
 	int digestsize = crypto_ahash_digestsize(ahash);
 	int ecode = 0;
 
@@ -3417,9 +3419,9 @@ static void ahash_done_bi(void *cbk_ctx, u32 status)
 	struct crypto_async_request *areq = cbk_ctx;
 	struct ahash_request *req = ahash_request_cast(areq);
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	struct ahash_edesc *edesc = state->caam_req.edesc;
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
 	int ecode = 0;
 
 	dev_dbg(ctx->dev, "%s %d: err 0x%x\n", __func__, __LINE__, status);
@@ -3455,9 +3457,9 @@ static void ahash_done_ctx_src(void *cbk_ctx, u32 status)
 	struct crypto_async_request *areq = cbk_ctx;
 	struct ahash_request *req = ahash_request_cast(areq);
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	struct ahash_edesc *edesc = state->caam_req.edesc;
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
 	int digestsize = crypto_ahash_digestsize(ahash);
 	int ecode = 0;
 
@@ -3482,9 +3484,9 @@ static void ahash_done_ctx_dst(void *cbk_ctx, u32 status)
 	struct crypto_async_request *areq = cbk_ctx;
 	struct ahash_request *req = ahash_request_cast(areq);
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	struct ahash_edesc *edesc = state->caam_req.edesc;
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
 	int ecode = 0;
 
 	dev_dbg(ctx->dev, "%s %d: err 0x%x\n", __func__, __LINE__, status);
@@ -3518,8 +3520,8 @@ static void ahash_done_ctx_dst(void *cbk_ctx, u32 status)
 static int ahash_update_ctx(struct ahash_request *req)
 {
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	struct caam_request *req_ctx = &state->caam_req;
 	struct dpaa2_fl_entry *in_fle = &req_ctx->fd_flt[1];
 	struct dpaa2_fl_entry *out_fle = &req_ctx->fd_flt[0];
@@ -3637,8 +3639,8 @@ static int ahash_update_ctx(struct ahash_request *req)
 static int ahash_final_ctx(struct ahash_request *req)
 {
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	struct caam_request *req_ctx = &state->caam_req;
 	struct dpaa2_fl_entry *in_fle = &req_ctx->fd_flt[1];
 	struct dpaa2_fl_entry *out_fle = &req_ctx->fd_flt[0];
@@ -3708,8 +3710,8 @@ static int ahash_final_ctx(struct ahash_request *req)
 static int ahash_finup_ctx(struct ahash_request *req)
 {
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	struct caam_request *req_ctx = &state->caam_req;
 	struct dpaa2_fl_entry *in_fle = &req_ctx->fd_flt[1];
 	struct dpaa2_fl_entry *out_fle = &req_ctx->fd_flt[0];
@@ -3802,8 +3804,8 @@ static int ahash_finup_ctx(struct ahash_request *req)
 static int ahash_digest(struct ahash_request *req)
 {
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	struct caam_request *req_ctx = &state->caam_req;
 	struct dpaa2_fl_entry *in_fle = &req_ctx->fd_flt[1];
 	struct dpaa2_fl_entry *out_fle = &req_ctx->fd_flt[0];
@@ -3897,8 +3899,8 @@ static int ahash_digest(struct ahash_request *req)
 static int ahash_final_no_ctx(struct ahash_request *req)
 {
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	struct caam_request *req_ctx = &state->caam_req;
 	struct dpaa2_fl_entry *in_fle = &req_ctx->fd_flt[1];
 	struct dpaa2_fl_entry *out_fle = &req_ctx->fd_flt[0];
@@ -3970,8 +3972,8 @@ static int ahash_final_no_ctx(struct ahash_request *req)
 static int ahash_update_no_ctx(struct ahash_request *req)
 {
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	struct caam_request *req_ctx = &state->caam_req;
 	struct dpaa2_fl_entry *in_fle = &req_ctx->fd_flt[1];
 	struct dpaa2_fl_entry *out_fle = &req_ctx->fd_flt[0];
@@ -4091,8 +4093,8 @@ static int ahash_update_no_ctx(struct ahash_request *req)
 static int ahash_finup_no_ctx(struct ahash_request *req)
 {
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	struct caam_request *req_ctx = &state->caam_req;
 	struct dpaa2_fl_entry *in_fle = &req_ctx->fd_flt[1];
 	struct dpaa2_fl_entry *out_fle = &req_ctx->fd_flt[0];
@@ -4187,8 +4189,8 @@ static int ahash_finup_no_ctx(struct ahash_request *req)
 static int ahash_update_first(struct ahash_request *req)
 {
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	struct caam_request *req_ctx = &state->caam_req;
 	struct dpaa2_fl_entry *in_fle = &req_ctx->fd_flt[1];
 	struct dpaa2_fl_entry *out_fle = &req_ctx->fd_flt[0];
@@ -4320,7 +4322,7 @@ static int ahash_finup_first(struct ahash_request *req)
 
 static int ahash_init(struct ahash_request *req)
 {
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 
 	state->update = ahash_update_first;
 	state->finup = ahash_finup_first;
@@ -4337,28 +4339,28 @@ static int ahash_init(struct ahash_request *req)
 
 static int ahash_update(struct ahash_request *req)
 {
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 
 	return state->update(req);
 }
 
 static int ahash_finup(struct ahash_request *req)
 {
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 
 	return state->finup(req);
 }
 
 static int ahash_final(struct ahash_request *req)
 {
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 
 	return state->final(req);
 }
 
 static int ahash_export(struct ahash_request *req, void *out)
 {
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	struct caam_export_state *export = out;
 	u8 *buf = state->buf;
 	int len = state->buflen;
@@ -4375,7 +4377,7 @@ static int ahash_export(struct ahash_request *req, void *out)
 
 static int ahash_import(struct ahash_request *req, const void *in)
 {
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	const struct caam_export_state *export = in;
 
 	memset(state, 0, sizeof(*state));
@@ -4547,7 +4549,7 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 		 container_of(halg, struct ahash_alg, halg);
 	struct caam_hash_alg *caam_hash =
 		 container_of(alg, struct caam_hash_alg, ahash_alg);
-	struct caam_hash_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct caam_hash_ctx *ctx = crypto_tfm_ctx_dma(tfm);
 	/* Sizes for MDHA running digests: MD5, SHA1, 224, 256, 384, 512 */
 	static const u8 runninglen[] = { HASH_MSG_LEN + MD5_DIGEST_SIZE,
 					 HASH_MSG_LEN + SHA1_DIGEST_SIZE,
@@ -4594,8 +4596,7 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 				   OP_ALG_ALGSEL_SUBMASK) >>
 				  OP_ALG_ALGSEL_SHIFT];
 
-	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
-				 sizeof(struct caam_hash_state));
+	crypto_ahash_set_reqsize_dma(ahash, sizeof(struct caam_hash_state));
 
 	/*
 	 * For keyed hash algorithms shared descriptors
@@ -4606,7 +4607,7 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 
 static void caam_hash_cra_exit(struct crypto_tfm *tfm)
 {
-	struct caam_hash_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct caam_hash_ctx *ctx = crypto_tfm_ctx_dma(tfm);
 
 	dma_unmap_single_attrs(ctx->dev, ctx->flc_dma[0], sizeof(ctx->flc),
 			       DMA_BIDIRECTIONAL, DMA_ATTR_SKIP_CPU_SYNC);
@@ -4646,7 +4647,7 @@ static struct caam_hash_alg *caam_hash_alloc(struct device *dev,
 	alg->cra_module = THIS_MODULE;
 	alg->cra_init = caam_hash_cra_init;
 	alg->cra_exit = caam_hash_cra_exit;
-	alg->cra_ctxsize = sizeof(struct caam_hash_ctx);
+	alg->cra_ctxsize = sizeof(struct caam_hash_ctx) + crypto_dma_padding();
 	alg->cra_priority = CAAM_CRA_PRIORITY;
 	alg->cra_blocksize = template->blocksize;
 	alg->cra_alignmask = 0;
diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index 36ef738e4a18..1050e965a438 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -199,7 +199,7 @@ static inline int ctx_map_to_sec4_sg(struct device *jrdev,
 
 static int ahash_set_sh_desc(struct crypto_ahash *ahash)
 {
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
 	int digestsize = crypto_ahash_digestsize(ahash);
 	struct device *jrdev = ctx->jrdev;
 	struct caam_drv_private *ctrlpriv = dev_get_drvdata(jrdev->parent);
@@ -255,7 +255,7 @@ static int ahash_set_sh_desc(struct crypto_ahash *ahash)
 
 static int axcbc_set_sh_desc(struct crypto_ahash *ahash)
 {
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
 	int digestsize = crypto_ahash_digestsize(ahash);
 	struct device *jrdev = ctx->jrdev;
 	u32 *desc;
@@ -307,7 +307,7 @@ static int axcbc_set_sh_desc(struct crypto_ahash *ahash)
 
 static int acmac_set_sh_desc(struct crypto_ahash *ahash)
 {
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
 	int digestsize = crypto_ahash_digestsize(ahash);
 	struct device *jrdev = ctx->jrdev;
 	u32 *desc;
@@ -421,7 +421,7 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
 static int ahash_setkey(struct crypto_ahash *ahash,
 			const u8 *key, unsigned int keylen)
 {
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
 	struct device *jrdev = ctx->jrdev;
 	int blocksize = crypto_tfm_alg_blocksize(&ahash->base);
 	int digestsize = crypto_ahash_digestsize(ahash);
@@ -484,7 +484,7 @@ static int ahash_setkey(struct crypto_ahash *ahash,
 static int axcbc_setkey(struct crypto_ahash *ahash, const u8 *key,
 			unsigned int keylen)
 {
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
 	struct device *jrdev = ctx->jrdev;
 
 	if (keylen != AES_KEYSIZE_128)
@@ -504,7 +504,7 @@ static int axcbc_setkey(struct crypto_ahash *ahash, const u8 *key,
 static int acmac_setkey(struct crypto_ahash *ahash, const u8 *key,
 			unsigned int keylen)
 {
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
 	int err;
 
 	err = aes_check_keylen(keylen);
@@ -543,7 +543,7 @@ static inline void ahash_unmap(struct device *dev,
 			struct ahash_edesc *edesc,
 			struct ahash_request *req, int dst_len)
 {
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 
 	if (edesc->src_nents)
 		dma_unmap_sg(dev, req->src, edesc->src_nents, DMA_TO_DEVICE);
@@ -563,7 +563,7 @@ static inline void ahash_unmap_ctx(struct device *dev,
 			struct ahash_edesc *edesc,
 			struct ahash_request *req, int dst_len, u32 flag)
 {
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 
 	if (state->ctx_dma) {
 		dma_unmap_single(dev, state->ctx_dma, state->ctx_dma_len, flag);
@@ -580,8 +580,8 @@ static inline void ahash_done_cpy(struct device *jrdev, u32 *desc, u32 err,
 	struct ahash_edesc *edesc;
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
 	int digestsize = crypto_ahash_digestsize(ahash);
-	struct caam_hash_state *state = ahash_request_ctx(req);
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
 	int ecode = 0;
 	bool has_bklog;
 
@@ -630,8 +630,8 @@ static inline void ahash_done_switch(struct device *jrdev, u32 *desc, u32 err,
 	struct caam_drv_private_jr *jrp = dev_get_drvdata(jrdev);
 	struct ahash_edesc *edesc;
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	int digestsize = crypto_ahash_digestsize(ahash);
 	int ecode = 0;
 	bool has_bklog;
@@ -695,8 +695,8 @@ static struct ahash_edesc *ahash_edesc_alloc(struct ahash_request *req,
 					     dma_addr_t sh_desc_dma)
 {
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		       GFP_KERNEL : GFP_ATOMIC;
 	struct ahash_edesc *edesc;
@@ -755,8 +755,8 @@ static int ahash_edesc_add_src(struct caam_hash_ctx *ctx,
 static int ahash_do_one_req(struct crypto_engine *engine, void *areq)
 {
 	struct ahash_request *req = ahash_request_cast(areq);
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(crypto_ahash_reqtfm(req));
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	struct device *jrdev = ctx->jrdev;
 	u32 *desc = state->edesc->hw_desc;
 	int ret;
@@ -785,7 +785,7 @@ static int ahash_enqueue_req(struct device *jrdev,
 			     int dst_len, enum dma_data_direction dir)
 {
 	struct caam_drv_private_jr *jrpriv = dev_get_drvdata(jrdev);
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	struct ahash_edesc *edesc = state->edesc;
 	u32 *desc = edesc->hw_desc;
 	int ret;
@@ -815,8 +815,8 @@ static int ahash_enqueue_req(struct device *jrdev,
 static int ahash_update_ctx(struct ahash_request *req)
 {
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	struct device *jrdev = ctx->jrdev;
 	u8 *buf = state->buf;
 	int *buflen = &state->buflen;
@@ -940,8 +940,8 @@ static int ahash_update_ctx(struct ahash_request *req)
 static int ahash_final_ctx(struct ahash_request *req)
 {
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	struct device *jrdev = ctx->jrdev;
 	int buflen = state->buflen;
 	u32 *desc;
@@ -1001,8 +1001,8 @@ static int ahash_final_ctx(struct ahash_request *req)
 static int ahash_finup_ctx(struct ahash_request *req)
 {
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	struct device *jrdev = ctx->jrdev;
 	int buflen = state->buflen;
 	u32 *desc;
@@ -1075,8 +1075,8 @@ static int ahash_finup_ctx(struct ahash_request *req)
 static int ahash_digest(struct ahash_request *req)
 {
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	struct device *jrdev = ctx->jrdev;
 	u32 *desc;
 	int digestsize = crypto_ahash_digestsize(ahash);
@@ -1142,8 +1142,8 @@ static int ahash_digest(struct ahash_request *req)
 static int ahash_final_no_ctx(struct ahash_request *req)
 {
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	struct device *jrdev = ctx->jrdev;
 	u8 *buf = state->buf;
 	int buflen = state->buflen;
@@ -1191,8 +1191,8 @@ static int ahash_final_no_ctx(struct ahash_request *req)
 static int ahash_update_no_ctx(struct ahash_request *req)
 {
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	struct device *jrdev = ctx->jrdev;
 	u8 *buf = state->buf;
 	int *buflen = &state->buflen;
@@ -1312,8 +1312,8 @@ static int ahash_update_no_ctx(struct ahash_request *req)
 static int ahash_finup_no_ctx(struct ahash_request *req)
 {
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	struct device *jrdev = ctx->jrdev;
 	int buflen = state->buflen;
 	u32 *desc;
@@ -1388,8 +1388,8 @@ static int ahash_finup_no_ctx(struct ahash_request *req)
 static int ahash_update_first(struct ahash_request *req)
 {
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	struct device *jrdev = ctx->jrdev;
 	u8 *buf = state->buf;
 	int *buflen = &state->buflen;
@@ -1498,7 +1498,7 @@ static int ahash_finup_first(struct ahash_request *req)
 
 static int ahash_init(struct ahash_request *req)
 {
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 
 	state->update = ahash_update_first;
 	state->finup = ahash_finup_first;
@@ -1515,28 +1515,28 @@ static int ahash_init(struct ahash_request *req)
 
 static int ahash_update(struct ahash_request *req)
 {
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 
 	return state->update(req);
 }
 
 static int ahash_finup(struct ahash_request *req)
 {
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 
 	return state->finup(req);
 }
 
 static int ahash_final(struct ahash_request *req)
 {
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 
 	return state->final(req);
 }
 
 static int ahash_export(struct ahash_request *req, void *out)
 {
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	struct caam_export_state *export = out;
 	u8 *buf = state->buf;
 	int len = state->buflen;
@@ -1553,7 +1553,7 @@ static int ahash_export(struct ahash_request *req, void *out)
 
 static int ahash_import(struct ahash_request *req, const void *in)
 {
-	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	const struct caam_export_state *export = in;
 
 	memset(state, 0, sizeof(*state));
@@ -1762,7 +1762,7 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 		 container_of(halg, struct ahash_alg, halg);
 	struct caam_hash_alg *caam_hash =
 		 container_of(alg, struct caam_hash_alg, ahash_alg);
-	struct caam_hash_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
 	/* Sizes for MDHA running digests: MD5, SHA1, 224, 256, 384, 512 */
 	static const u8 runninglen[] = { HASH_MSG_LEN + MD5_DIGEST_SIZE,
 					 HASH_MSG_LEN + SHA1_DIGEST_SIZE,
@@ -1854,8 +1854,7 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 
 	ctx->enginectx.op.do_one_request = ahash_do_one_req;
 
-	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
-				 sizeof(struct caam_hash_state));
+	crypto_ahash_set_reqsize_dma(ahash, sizeof(struct caam_hash_state));
 
 	/*
 	 * For keyed hash algorithms shared descriptors
@@ -1866,7 +1865,7 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 
 static void caam_hash_cra_exit(struct crypto_tfm *tfm)
 {
-	struct caam_hash_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct caam_hash_ctx *ctx = crypto_tfm_ctx_dma(tfm);
 
 	dma_unmap_single_attrs(ctx->jrdev, ctx->sh_desc_update_dma,
 			       offsetof(struct caam_hash_ctx, key) -
@@ -1926,7 +1925,7 @@ caam_hash_alloc(struct caam_hash_template *template,
 	alg->cra_module = THIS_MODULE;
 	alg->cra_init = caam_hash_cra_init;
 	alg->cra_exit = caam_hash_cra_exit;
-	alg->cra_ctxsize = sizeof(struct caam_hash_ctx);
+	alg->cra_ctxsize = sizeof(struct caam_hash_ctx) + crypto_dma_padding();
 	alg->cra_priority = CAAM_CRA_PRIORITY;
 	alg->cra_blocksize = template->blocksize;
 	alg->cra_alignmask = 0;
diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index 642846693d7c..aef031946f33 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -57,7 +57,7 @@ static void rsa_pub_unmap(struct device *dev, struct rsa_edesc *edesc,
 			  struct akcipher_request *req)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
-	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 	struct caam_rsa_key *key = &ctx->key;
 	struct rsa_pub_pdb *pdb = &edesc->pdb.pub;
 
@@ -69,7 +69,7 @@ static void rsa_priv_f1_unmap(struct device *dev, struct rsa_edesc *edesc,
 			      struct akcipher_request *req)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
-	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 	struct caam_rsa_key *key = &ctx->key;
 	struct rsa_priv_f1_pdb *pdb = &edesc->pdb.priv_f1;
 
@@ -81,7 +81,7 @@ static void rsa_priv_f2_unmap(struct device *dev, struct rsa_edesc *edesc,
 			      struct akcipher_request *req)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
-	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 	struct caam_rsa_key *key = &ctx->key;
 	struct rsa_priv_f2_pdb *pdb = &edesc->pdb.priv_f2;
 	size_t p_sz = key->p_sz;
@@ -98,7 +98,7 @@ static void rsa_priv_f3_unmap(struct device *dev, struct rsa_edesc *edesc,
 			      struct akcipher_request *req)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
-	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 	struct caam_rsa_key *key = &ctx->key;
 	struct rsa_priv_f3_pdb *pdb = &edesc->pdb.priv_f3;
 	size_t p_sz = key->p_sz;
@@ -149,7 +149,7 @@ static void rsa_priv_f_done(struct device *dev, u32 *desc, u32 err,
 	struct akcipher_request *req = context;
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
 	struct caam_drv_private_jr *jrp = dev_get_drvdata(dev);
-	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 	struct caam_rsa_key *key = &ctx->key;
 	struct caam_rsa_req_ctx *req_ctx = akcipher_request_ctx(req);
 	struct rsa_edesc *edesc;
@@ -242,7 +242,7 @@ static struct rsa_edesc *rsa_edesc_alloc(struct akcipher_request *req,
 					 size_t desclen)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
-	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 	struct device *dev = ctx->dev;
 	struct caam_rsa_req_ctx *req_ctx = akcipher_request_ctx(req);
 	struct caam_rsa_key *key = &ctx->key;
@@ -371,7 +371,7 @@ static int akcipher_do_one_req(struct crypto_engine *engine, void *areq)
 						    base);
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
 	struct caam_rsa_req_ctx *req_ctx = akcipher_request_ctx(req);
-	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 	struct device *jrdev = ctx->dev;
 	u32 *desc = req_ctx->edesc->hw_desc;
 	int ret;
@@ -399,7 +399,7 @@ static int set_rsa_pub_pdb(struct akcipher_request *req,
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
 	struct caam_rsa_req_ctx *req_ctx = akcipher_request_ctx(req);
-	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 	struct caam_rsa_key *key = &ctx->key;
 	struct device *dev = ctx->dev;
 	struct rsa_pub_pdb *pdb = &edesc->pdb.pub;
@@ -444,7 +444,7 @@ static int set_rsa_priv_f1_pdb(struct akcipher_request *req,
 			       struct rsa_edesc *edesc)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
-	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 	struct caam_rsa_key *key = &ctx->key;
 	struct device *dev = ctx->dev;
 	struct rsa_priv_f1_pdb *pdb = &edesc->pdb.priv_f1;
@@ -491,7 +491,7 @@ static int set_rsa_priv_f2_pdb(struct akcipher_request *req,
 			       struct rsa_edesc *edesc)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
-	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 	struct caam_rsa_key *key = &ctx->key;
 	struct device *dev = ctx->dev;
 	struct rsa_priv_f2_pdb *pdb = &edesc->pdb.priv_f2;
@@ -568,7 +568,7 @@ static int set_rsa_priv_f3_pdb(struct akcipher_request *req,
 			       struct rsa_edesc *edesc)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
-	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 	struct caam_rsa_key *key = &ctx->key;
 	struct device *dev = ctx->dev;
 	struct rsa_priv_f3_pdb *pdb = &edesc->pdb.priv_f3;
@@ -664,7 +664,7 @@ static int akcipher_enqueue_req(struct device *jrdev,
 {
 	struct caam_drv_private_jr *jrpriv = dev_get_drvdata(jrdev);
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
-	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 	struct caam_rsa_key *key = &ctx->key;
 	struct caam_rsa_req_ctx *req_ctx = akcipher_request_ctx(req);
 	struct rsa_edesc *edesc = req_ctx->edesc;
@@ -707,7 +707,7 @@ static int akcipher_enqueue_req(struct device *jrdev,
 static int caam_rsa_enc(struct akcipher_request *req)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
-	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 	struct caam_rsa_key *key = &ctx->key;
 	struct device *jrdev = ctx->dev;
 	struct rsa_edesc *edesc;
@@ -746,7 +746,7 @@ static int caam_rsa_enc(struct akcipher_request *req)
 static int caam_rsa_dec_priv_f1(struct akcipher_request *req)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
-	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 	struct device *jrdev = ctx->dev;
 	struct rsa_edesc *edesc;
 	int ret;
@@ -775,7 +775,7 @@ static int caam_rsa_dec_priv_f1(struct akcipher_request *req)
 static int caam_rsa_dec_priv_f2(struct akcipher_request *req)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
-	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 	struct device *jrdev = ctx->dev;
 	struct rsa_edesc *edesc;
 	int ret;
@@ -804,7 +804,7 @@ static int caam_rsa_dec_priv_f2(struct akcipher_request *req)
 static int caam_rsa_dec_priv_f3(struct akcipher_request *req)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
-	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 	struct device *jrdev = ctx->dev;
 	struct rsa_edesc *edesc;
 	int ret;
@@ -833,7 +833,7 @@ static int caam_rsa_dec_priv_f3(struct akcipher_request *req)
 static int caam_rsa_dec(struct akcipher_request *req)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
-	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 	struct caam_rsa_key *key = &ctx->key;
 	int ret;
 
@@ -936,7 +936,7 @@ static int caam_rsa_check_key_length(unsigned int len)
 static int caam_rsa_set_pub_key(struct crypto_akcipher *tfm, const void *key,
 				unsigned int keylen)
 {
-	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 	struct rsa_key raw_key = {NULL};
 	struct caam_rsa_key *rsa_key = &ctx->key;
 	int ret;
@@ -1038,7 +1038,7 @@ static void caam_rsa_set_priv_key_form(struct caam_rsa_ctx *ctx,
 static int caam_rsa_set_priv_key(struct crypto_akcipher *tfm, const void *key,
 				 unsigned int keylen)
 {
-	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 	struct rsa_key raw_key = {NULL};
 	struct caam_rsa_key *rsa_key = &ctx->key;
 	int ret;
@@ -1089,7 +1089,7 @@ static int caam_rsa_set_priv_key(struct crypto_akcipher *tfm, const void *key,
 
 static unsigned int caam_rsa_max_size(struct crypto_akcipher *tfm)
 {
-	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 
 	return ctx->key.n_sz;
 }
@@ -1097,7 +1097,7 @@ static unsigned int caam_rsa_max_size(struct crypto_akcipher *tfm)
 /* Per session pkc's driver context creation function */
 static int caam_rsa_init_tfm(struct crypto_akcipher *tfm)
 {
-	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 
 	akcipher_set_reqsize(tfm, sizeof(struct caam_rsa_req_ctx));
 
@@ -1125,7 +1125,7 @@ static int caam_rsa_init_tfm(struct crypto_akcipher *tfm)
 /* Per session pkc's driver context cleanup function */
 static void caam_rsa_exit_tfm(struct crypto_akcipher *tfm)
 {
-	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx_dma(tfm);
 	struct caam_rsa_key *key = &ctx->key;
 
 	dma_unmap_single(ctx->dev, ctx->padding_dma, CAAM_RSA_MAX_INPUT_SIZE -
@@ -1148,7 +1148,8 @@ static struct caam_akcipher_alg caam_rsa = {
 			.cra_driver_name = "rsa-caam",
 			.cra_priority = 3000,
 			.cra_module = THIS_MODULE,
-			.cra_ctxsize = sizeof(struct caam_rsa_ctx),
+			.cra_ctxsize = sizeof(struct caam_rsa_ctx) +
+				       CRYPTO_DMA_PADDING,
 		},
 	}
 };
