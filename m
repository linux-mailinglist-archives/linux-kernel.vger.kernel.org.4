Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DBB64032C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbiLBJWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiLBJVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:21:17 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA757BE10A;
        Fri,  2 Dec 2022 01:21:13 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p12E5-003Ap0-F2; Fri, 02 Dec 2022 17:20:58 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Dec 2022 17:20:57 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Fri, 02 Dec 2022 17:20:57 +0800
Subject: [PATCH 6/10] crypto: safexcel - Set DMA alignment explicitly
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
Message-Id: <E1p12E5-003Ap0-F2@formenos.hmeau.com>
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

 drivers/crypto/inside-secure/safexcel_hash.c |   99 +++++++++++++--------------
 1 file changed, 50 insertions(+), 49 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel_hash.c b/drivers/crypto/inside-secure/safexcel_hash.c
index 103fc551d2af..ca46328472d4 100644
--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -231,7 +231,7 @@ static int safexcel_handle_req_result(struct safexcel_crypto_priv *priv,
 	struct safexcel_result_desc *rdesc;
 	struct ahash_request *areq = ahash_request_cast(async);
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(areq);
-	struct safexcel_ahash_req *sreq = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *sreq = ahash_request_ctx_dma(areq);
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(ahash);
 	u64 cache_len;
 
@@ -312,7 +312,7 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 				   int *commands, int *results)
 {
 	struct ahash_request *areq = ahash_request_cast(async);
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
 	struct safexcel_crypto_priv *priv = ctx->base.priv;
 	struct safexcel_command_desc *cdesc, *first_cdesc = NULL;
@@ -569,7 +569,7 @@ static int safexcel_handle_result(struct safexcel_crypto_priv *priv, int ring,
 				  bool *should_complete, int *ret)
 {
 	struct ahash_request *areq = ahash_request_cast(async);
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 	int err;
 
 	BUG_ON(!(priv->flags & EIP197_TRC_CACHE) && req->needs_inv);
@@ -608,7 +608,7 @@ static int safexcel_ahash_send(struct crypto_async_request *async,
 			       int ring, int *commands, int *results)
 {
 	struct ahash_request *areq = ahash_request_cast(async);
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 	int ret;
 
 	if (req->needs_inv)
@@ -624,7 +624,7 @@ static int safexcel_ahash_exit_inv(struct crypto_tfm *tfm)
 	struct safexcel_ahash_ctx *ctx = crypto_tfm_ctx(tfm);
 	struct safexcel_crypto_priv *priv = ctx->base.priv;
 	EIP197_REQUEST_ON_STACK(req, ahash, EIP197_AHASH_REQ_SIZE);
-	struct safexcel_ahash_req *rctx = ahash_request_ctx(req);
+	struct safexcel_ahash_req *rctx = ahash_request_ctx_dma(req);
 	struct safexcel_inv_result result = {};
 	int ring = ctx->base.ring;
 
@@ -663,7 +663,7 @@ static int safexcel_ahash_exit_inv(struct crypto_tfm *tfm)
  */
 static int safexcel_ahash_cache(struct ahash_request *areq)
 {
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 	u64 cache_len;
 
 	/* cache_len: everything accepted by the driver but not sent yet,
@@ -689,7 +689,7 @@ static int safexcel_ahash_cache(struct ahash_request *areq)
 static int safexcel_ahash_enqueue(struct ahash_request *areq)
 {
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 	struct safexcel_crypto_priv *priv = ctx->base.priv;
 	int ret, ring;
 
@@ -741,7 +741,7 @@ static int safexcel_ahash_enqueue(struct ahash_request *areq)
 
 static int safexcel_ahash_update(struct ahash_request *areq)
 {
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 	int ret;
 
 	/* If the request is 0 length, do nothing */
@@ -766,7 +766,7 @@ static int safexcel_ahash_update(struct ahash_request *areq)
 
 static int safexcel_ahash_final(struct ahash_request *areq)
 {
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
 
 	req->finish = true;
@@ -870,7 +870,7 @@ static int safexcel_ahash_final(struct ahash_request *areq)
 
 static int safexcel_ahash_finup(struct ahash_request *areq)
 {
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 
 	req->finish = true;
 
@@ -880,7 +880,7 @@ static int safexcel_ahash_finup(struct ahash_request *areq)
 
 static int safexcel_ahash_export(struct ahash_request *areq, void *out)
 {
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 	struct safexcel_ahash_export_state *export = out;
 
 	export->len = req->len;
@@ -896,7 +896,7 @@ static int safexcel_ahash_export(struct ahash_request *areq, void *out)
 
 static int safexcel_ahash_import(struct ahash_request *areq, const void *in)
 {
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 	const struct safexcel_ahash_export_state *export = in;
 	int ret;
 
@@ -927,15 +927,15 @@ static int safexcel_ahash_cra_init(struct crypto_tfm *tfm)
 	ctx->base.handle_result = safexcel_handle_result;
 	ctx->fb_do_setkey = false;
 
-	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
-				 sizeof(struct safexcel_ahash_req));
+	crypto_ahash_set_reqsize_dma(__crypto_ahash_cast(tfm),
+				     sizeof(struct safexcel_ahash_req));
 	return 0;
 }
 
 static int safexcel_sha1_init(struct ahash_request *areq)
 {
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 
 	memset(req, 0, sizeof(*req));
 
@@ -1012,7 +1012,7 @@ struct safexcel_alg_template safexcel_alg_sha1 = {
 static int safexcel_hmac_sha1_init(struct ahash_request *areq)
 {
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 
 	memset(req, 0, sizeof(*req));
 
@@ -1124,7 +1124,7 @@ static int safexcel_hmac_init_iv(struct ahash_request *areq,
 	if (ret)
 		return ret;
 
-	req = ahash_request_ctx(areq);
+	req = ahash_request_ctx_dma(areq);
 	req->hmac = true;
 	req->last_req = true;
 
@@ -1264,7 +1264,7 @@ struct safexcel_alg_template safexcel_alg_hmac_sha1 = {
 static int safexcel_sha256_init(struct ahash_request *areq)
 {
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 
 	memset(req, 0, sizeof(*req));
 
@@ -1321,7 +1321,7 @@ struct safexcel_alg_template safexcel_alg_sha256 = {
 static int safexcel_sha224_init(struct ahash_request *areq)
 {
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 
 	memset(req, 0, sizeof(*req));
 
@@ -1385,7 +1385,7 @@ static int safexcel_hmac_sha224_setkey(struct crypto_ahash *tfm, const u8 *key,
 static int safexcel_hmac_sha224_init(struct ahash_request *areq)
 {
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 
 	memset(req, 0, sizeof(*req));
 
@@ -1457,7 +1457,7 @@ static int safexcel_hmac_sha256_setkey(struct crypto_ahash *tfm, const u8 *key,
 static int safexcel_hmac_sha256_init(struct ahash_request *areq)
 {
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 
 	memset(req, 0, sizeof(*req));
 
@@ -1522,7 +1522,7 @@ struct safexcel_alg_template safexcel_alg_hmac_sha256 = {
 static int safexcel_sha512_init(struct ahash_request *areq)
 {
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 
 	memset(req, 0, sizeof(*req));
 
@@ -1579,7 +1579,7 @@ struct safexcel_alg_template safexcel_alg_sha512 = {
 static int safexcel_sha384_init(struct ahash_request *areq)
 {
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 
 	memset(req, 0, sizeof(*req));
 
@@ -1643,7 +1643,7 @@ static int safexcel_hmac_sha512_setkey(struct crypto_ahash *tfm, const u8 *key,
 static int safexcel_hmac_sha512_init(struct ahash_request *areq)
 {
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 
 	memset(req, 0, sizeof(*req));
 
@@ -1715,7 +1715,7 @@ static int safexcel_hmac_sha384_setkey(struct crypto_ahash *tfm, const u8 *key,
 static int safexcel_hmac_sha384_init(struct ahash_request *areq)
 {
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 
 	memset(req, 0, sizeof(*req));
 
@@ -1780,7 +1780,7 @@ struct safexcel_alg_template safexcel_alg_hmac_sha384 = {
 static int safexcel_md5_init(struct ahash_request *areq)
 {
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 
 	memset(req, 0, sizeof(*req));
 
@@ -1837,7 +1837,7 @@ struct safexcel_alg_template safexcel_alg_md5 = {
 static int safexcel_hmac_md5_init(struct ahash_request *areq)
 {
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 
 	memset(req, 0, sizeof(*req));
 
@@ -1920,7 +1920,7 @@ static int safexcel_crc32_cra_init(struct crypto_tfm *tfm)
 static int safexcel_crc32_init(struct ahash_request *areq)
 {
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 
 	memset(req, 0, sizeof(*req));
 
@@ -1992,7 +1992,7 @@ struct safexcel_alg_template safexcel_alg_crc32 = {
 static int safexcel_cbcmac_init(struct ahash_request *areq)
 {
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 
 	memset(req, 0, sizeof(*req));
 
@@ -2252,7 +2252,7 @@ struct safexcel_alg_template safexcel_alg_cmac = {
 static int safexcel_sm3_init(struct ahash_request *areq)
 {
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 
 	memset(req, 0, sizeof(*req));
 
@@ -2316,7 +2316,7 @@ static int safexcel_hmac_sm3_setkey(struct crypto_ahash *tfm, const u8 *key,
 static int safexcel_hmac_sm3_init(struct ahash_request *areq)
 {
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 
 	memset(req, 0, sizeof(*req));
 
@@ -2382,7 +2382,7 @@ static int safexcel_sha3_224_init(struct ahash_request *areq)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 
 	memset(req, 0, sizeof(*req));
 
@@ -2400,7 +2400,7 @@ static int safexcel_sha3_fbcheck(struct ahash_request *req)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
-	struct ahash_request *subreq = ahash_request_ctx(req);
+	struct ahash_request *subreq = ahash_request_ctx_dma(req);
 	int ret = 0;
 
 	if (ctx->do_fallback) {
@@ -2437,7 +2437,7 @@ static int safexcel_sha3_update(struct ahash_request *req)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
-	struct ahash_request *subreq = ahash_request_ctx(req);
+	struct ahash_request *subreq = ahash_request_ctx_dma(req);
 
 	ctx->do_fallback = true;
 	return safexcel_sha3_fbcheck(req) ?: crypto_ahash_update(subreq);
@@ -2447,7 +2447,7 @@ static int safexcel_sha3_final(struct ahash_request *req)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
-	struct ahash_request *subreq = ahash_request_ctx(req);
+	struct ahash_request *subreq = ahash_request_ctx_dma(req);
 
 	ctx->do_fallback = true;
 	return safexcel_sha3_fbcheck(req) ?: crypto_ahash_final(subreq);
@@ -2457,7 +2457,7 @@ static int safexcel_sha3_finup(struct ahash_request *req)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
-	struct ahash_request *subreq = ahash_request_ctx(req);
+	struct ahash_request *subreq = ahash_request_ctx_dma(req);
 
 	ctx->do_fallback |= !req->nbytes;
 	if (ctx->do_fallback)
@@ -2472,7 +2472,7 @@ static int safexcel_sha3_digest_fallback(struct ahash_request *req)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
-	struct ahash_request *subreq = ahash_request_ctx(req);
+	struct ahash_request *subreq = ahash_request_ctx_dma(req);
 
 	ctx->do_fallback = true;
 	ctx->fb_init_done = false;
@@ -2492,7 +2492,7 @@ static int safexcel_sha3_export(struct ahash_request *req, void *out)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
-	struct ahash_request *subreq = ahash_request_ctx(req);
+	struct ahash_request *subreq = ahash_request_ctx_dma(req);
 
 	ctx->do_fallback = true;
 	return safexcel_sha3_fbcheck(req) ?: crypto_ahash_export(subreq, out);
@@ -2502,7 +2502,7 @@ static int safexcel_sha3_import(struct ahash_request *req, const void *in)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
-	struct ahash_request *subreq = ahash_request_ctx(req);
+	struct ahash_request *subreq = ahash_request_ctx_dma(req);
 
 	ctx->do_fallback = true;
 	return safexcel_sha3_fbcheck(req) ?: crypto_ahash_import(subreq, in);
@@ -2526,9 +2526,10 @@ static int safexcel_sha3_cra_init(struct crypto_tfm *tfm)
 	/* Update statesize from fallback algorithm! */
 	crypto_hash_alg_common(ahash)->statesize =
 		crypto_ahash_statesize(ctx->fback);
-	crypto_ahash_set_reqsize(ahash, max(sizeof(struct safexcel_ahash_req),
-					    sizeof(struct ahash_request) +
-					    crypto_ahash_reqsize(ctx->fback)));
+	crypto_ahash_set_reqsize_dma(
+		ahash, max(sizeof(struct safexcel_ahash_req),
+			   sizeof(struct ahash_request) +
+			   crypto_ahash_reqsize(ctx->fback)));
 	return 0;
 }
 
@@ -2575,7 +2576,7 @@ static int safexcel_sha3_256_init(struct ahash_request *areq)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 
 	memset(req, 0, sizeof(*req));
 
@@ -2633,7 +2634,7 @@ static int safexcel_sha3_384_init(struct ahash_request *areq)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 
 	memset(req, 0, sizeof(*req));
 
@@ -2691,7 +2692,7 @@ static int safexcel_sha3_512_init(struct ahash_request *areq)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 
 	memset(req, 0, sizeof(*req));
 
@@ -2841,7 +2842,7 @@ static int safexcel_hmac_sha3_224_init(struct ahash_request *areq)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 
 	memset(req, 0, sizeof(*req));
 
@@ -2912,7 +2913,7 @@ static int safexcel_hmac_sha3_256_init(struct ahash_request *areq)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 
 	memset(req, 0, sizeof(*req));
 
@@ -2983,7 +2984,7 @@ static int safexcel_hmac_sha3_384_init(struct ahash_request *areq)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 
 	memset(req, 0, sizeof(*req));
 
@@ -3054,7 +3055,7 @@ static int safexcel_hmac_sha3_512_init(struct ahash_request *areq)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
-	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	struct safexcel_ahash_req *req = ahash_request_ctx_dma(areq);
 
 	memset(req, 0, sizeof(*req));
 
