Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D9A64031F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiLBJVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiLBJVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:21:03 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E15CA9598;
        Fri,  2 Dec 2022 01:21:02 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p12Dv-003Ao0-0r; Fri, 02 Dec 2022 17:20:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Dec 2022 17:20:47 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Fri, 02 Dec 2022 17:20:47 +0800
Subject: [PATCH 1/10] crypto: cavium - Set DMA alignment explicitly
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
Message-Id: <E1p12Dv-003Ao0-0r@formenos.hmeau.com>
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

 drivers/crypto/cavium/cpt/cptvf_algs.c     |   10 +++++-----
 drivers/crypto/cavium/nitrox/nitrox_aead.c |   12 ++++++------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/cavium/cpt/cptvf_algs.c b/drivers/crypto/cavium/cpt/cptvf_algs.c
index ce3b91c612f0..9eca0c302186 100644
--- a/drivers/crypto/cavium/cpt/cptvf_algs.c
+++ b/drivers/crypto/cavium/cpt/cptvf_algs.c
@@ -97,7 +97,7 @@ static inline u32 create_ctx_hdr(struct skcipher_request *req, u32 enc,
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct cvm_enc_ctx *ctx = crypto_skcipher_ctx(tfm);
-	struct cvm_req_ctx *rctx = skcipher_request_ctx(req);
+	struct cvm_req_ctx *rctx = skcipher_request_ctx_dma(req);
 	struct fc_context *fctx = &rctx->fctx;
 	u32 enc_iv_len = crypto_skcipher_ivsize(tfm);
 	struct cpt_request_info *req_info = &rctx->cpt_req;
@@ -151,7 +151,7 @@ static inline u32 create_ctx_hdr(struct skcipher_request *req, u32 enc,
 static inline u32 create_input_list(struct skcipher_request  *req, u32 enc,
 				    u32 enc_iv_len)
 {
-	struct cvm_req_ctx *rctx = skcipher_request_ctx(req);
+	struct cvm_req_ctx *rctx = skcipher_request_ctx_dma(req);
 	struct cpt_request_info *req_info = &rctx->cpt_req;
 	u32 argcnt =  0;
 
@@ -173,7 +173,7 @@ static inline void store_cb_info(struct skcipher_request *req,
 static inline void create_output_list(struct skcipher_request *req,
 				      u32 enc_iv_len)
 {
-	struct cvm_req_ctx *rctx = skcipher_request_ctx(req);
+	struct cvm_req_ctx *rctx = skcipher_request_ctx_dma(req);
 	struct cpt_request_info *req_info = &rctx->cpt_req;
 	u32 argcnt = 0;
 
@@ -193,7 +193,7 @@ static inline void create_output_list(struct skcipher_request *req,
 static inline int cvm_enc_dec(struct skcipher_request *req, u32 enc)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct cvm_req_ctx *rctx = skcipher_request_ctx(req);
+	struct cvm_req_ctx *rctx = skcipher_request_ctx_dma(req);
 	u32 enc_iv_len = crypto_skcipher_ivsize(tfm);
 	struct fc_context *fctx = &rctx->fctx;
 	struct cpt_request_info *req_info = &rctx->cpt_req;
@@ -335,7 +335,7 @@ static int cvm_ecb_des3_setkey(struct crypto_skcipher *cipher, const u8 *key,
 
 static int cvm_enc_dec_init(struct crypto_skcipher *tfm)
 {
-	crypto_skcipher_set_reqsize(tfm, sizeof(struct cvm_req_ctx));
+	crypto_skcipher_set_reqsize_dma(tfm, sizeof(struct cvm_req_ctx));
 
 	return 0;
 }
diff --git a/drivers/crypto/cavium/nitrox/nitrox_aead.c b/drivers/crypto/cavium/nitrox/nitrox_aead.c
index c93c4e41d267..0653484df23f 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_aead.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_aead.c
@@ -392,7 +392,7 @@ static int nitrox_rfc4106_setauthsize(struct crypto_aead *aead,
 
 static int nitrox_rfc4106_set_aead_rctx_sglist(struct aead_request *areq)
 {
-	struct nitrox_rfc4106_rctx *rctx = aead_request_ctx(areq);
+	struct nitrox_rfc4106_rctx *rctx = aead_request_ctx_dma(areq);
 	struct nitrox_aead_rctx *aead_rctx = &rctx->base;
 	unsigned int assoclen = areq->assoclen - GCM_RFC4106_IV_SIZE;
 	struct scatterlist *sg;
@@ -424,7 +424,7 @@ static int nitrox_rfc4106_set_aead_rctx_sglist(struct aead_request *areq)
 static void nitrox_rfc4106_callback(void *arg, int err)
 {
 	struct aead_request *areq = arg;
-	struct nitrox_rfc4106_rctx *rctx = aead_request_ctx(areq);
+	struct nitrox_rfc4106_rctx *rctx = aead_request_ctx_dma(areq);
 	struct nitrox_kcrypt_request *nkreq = &rctx->base.nkreq;
 
 	free_src_sglist(nkreq);
@@ -441,7 +441,7 @@ static int nitrox_rfc4106_enc(struct aead_request *areq)
 {
 	struct crypto_aead *aead = crypto_aead_reqtfm(areq);
 	struct nitrox_crypto_ctx *nctx = crypto_aead_ctx(aead);
-	struct nitrox_rfc4106_rctx *rctx = aead_request_ctx(areq);
+	struct nitrox_rfc4106_rctx *rctx = aead_request_ctx_dma(areq);
 	struct nitrox_aead_rctx *aead_rctx = &rctx->base;
 	struct se_crypto_request *creq = &aead_rctx->nkreq.creq;
 	int ret;
@@ -472,7 +472,7 @@ static int nitrox_rfc4106_enc(struct aead_request *areq)
 static int nitrox_rfc4106_dec(struct aead_request *areq)
 {
 	struct crypto_aead *aead = crypto_aead_reqtfm(areq);
-	struct nitrox_crypto_ctx *nctx = crypto_aead_ctx(aead);
+	struct nitrox_crypto_ctx *nctx = crypto_aead_ctx_dma(aead);
 	struct nitrox_rfc4106_rctx *rctx = aead_request_ctx(areq);
 	struct nitrox_aead_rctx *aead_rctx = &rctx->base;
 	struct se_crypto_request *creq = &aead_rctx->nkreq.creq;
@@ -510,8 +510,8 @@ static int nitrox_rfc4106_init(struct crypto_aead *aead)
 	if (ret)
 		return ret;
 
-	crypto_aead_set_reqsize(aead, sizeof(struct aead_request) +
-				sizeof(struct nitrox_rfc4106_rctx));
+	crypto_aead_set_reqsize_dma(aead, sizeof(struct aead_request) +
+					  sizeof(struct nitrox_rfc4106_rctx));
 
 	return 0;
 }
