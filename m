Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374F268779A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjBBIfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjBBIfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:35:09 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D061D5EF9A;
        Thu,  2 Feb 2023 00:34:25 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pNV2R-006fJr-NT; Thu, 02 Feb 2023 16:33:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 02 Feb 2023 16:33:47 +0800
Date:   Thu, 2 Feb 2023 16:33:47 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [v4 PATCH] crypto: arm64/sm4-gcm - Fix possible crash in GCM cryption
Message-ID: <Y9t1a2HkqlPT+Zfn@gondor.apana.org.au>
References: <20230201123133.99768-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201123133.99768-1-tianjia.zhang@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 08:31:33PM +0800, Tianjia Zhang wrote:
>
> +	sm4_ce_pmull_gcm_crypt(ctx->key.rkey_enc, walk->dst.virt.addr,
> +			       walk->src.virt.addr, iv, walk->nbytes, ghash,
> +			       ctx->ghash_table, (const u8 *)&lengths);

I still think this is error-prone.  When walk->nbytes == 0,
walk->src and walk->dst are undefined.  Sure you could argue
that the underlying assembly code won't touch the values, but
accessing uninitialised memory even if just to throw them away
is still a bit icky.

Anyway, here's my attempt at rewriting the gcm loop:

---8<---
An often overlooked aspect of the skcipher walker API is that an
error is not just indicated by a non-zero return value, but by the
fact that walk->nbytes is zero.

Thus it is an error to call skcipher_walk_done after getting back
walk->nbytes == 0 from the previous interaction with the walker.

This is because when walk->nbytes is zero the walker is left in
an undefined state and any further calls to it may try to free
uninitialised stack memory.

The sm4 arm64 ccm code gets this wrong and ends up calling
skcipher_walk_done even when walk->nbytes is zero.

This patch rewrites the loop in a form that resembles other callers.

Reported-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Fixes: ae1b83c7d572 ("crypto: arm64/sm4 - add CE implementation for GCM mode")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/arch/arm64/crypto/sm4-ce-gcm-glue.c b/arch/arm64/crypto/sm4-ce-gcm-glue.c
index c450a2025ca9..73bfb6972d3a 100644
--- a/arch/arm64/crypto/sm4-ce-gcm-glue.c
+++ b/arch/arm64/crypto/sm4-ce-gcm-glue.c
@@ -135,22 +135,23 @@ static void gcm_calculate_auth_mac(struct aead_request *req, u8 ghash[])
 }
 
 static int gcm_crypt(struct aead_request *req, struct skcipher_walk *walk,
-		     struct sm4_gcm_ctx *ctx, u8 ghash[],
+		     u8 ghash[], int err,
 		     void (*sm4_ce_pmull_gcm_crypt)(const u32 *rkey_enc,
 				u8 *dst, const u8 *src, u8 *iv,
 				unsigned int nbytes, u8 *ghash,
 				const u8 *ghash_table, const u8 *lengths))
 {
+	struct crypto_aead *aead = crypto_aead_reqtfm(req);
+	struct sm4_gcm_ctx *ctx = crypto_aead_ctx(aead);
 	u8 __aligned(8) iv[SM4_BLOCK_SIZE];
 	be128 __aligned(8) lengths;
-	int err;
 
 	memset(ghash, 0, SM4_BLOCK_SIZE);
 
 	lengths.a = cpu_to_be64(req->assoclen * 8);
 	lengths.b = cpu_to_be64(walk->total * 8);
 
-	memcpy(iv, walk->iv, GCM_IV_SIZE);
+	memcpy(iv, req->iv, GCM_IV_SIZE);
 	put_unaligned_be32(2, iv + GCM_IV_SIZE);
 
 	kernel_neon_begin();
@@ -158,49 +159,51 @@ static int gcm_crypt(struct aead_request *req, struct skcipher_walk *walk,
 	if (req->assoclen)
 		gcm_calculate_auth_mac(req, ghash);
 
-	do {
+	while (walk->nbytes) {
 		unsigned int tail = walk->nbytes % SM4_BLOCK_SIZE;
 		const u8 *src = walk->src.virt.addr;
 		u8 *dst = walk->dst.virt.addr;
 
 		if (walk->nbytes == walk->total) {
-			tail = 0;
-
 			sm4_ce_pmull_gcm_crypt(ctx->key.rkey_enc, dst, src, iv,
 					       walk->nbytes, ghash,
 					       ctx->ghash_table,
 					       (const u8 *)&lengths);
-		} else if (walk->nbytes - tail) {
-			sm4_ce_pmull_gcm_crypt(ctx->key.rkey_enc, dst, src, iv,
-					       walk->nbytes - tail, ghash,
-					       ctx->ghash_table, NULL);
+
+			kernel_neon_end();
+
+			return skcipher_walk_done(walk, 0);
 		}
 
+		sm4_ce_pmull_gcm_crypt(ctx->key.rkey_enc, dst, src, iv,
+				       walk->nbytes - tail, ghash,
+				       ctx->ghash_table, NULL);
+
 		kernel_neon_end();
 
 		err = skcipher_walk_done(walk, tail);
-		if (err)
-			return err;
-		if (walk->nbytes)
-			kernel_neon_begin();
-	} while (walk->nbytes > 0);
 
-	return 0;
+		kernel_neon_begin();
+	}
+
+	sm4_ce_pmull_gcm_crypt(ctx->key.rkey_enc, NULL, NULL, iv,
+			       walk->nbytes, ghash, ctx->ghash_table,
+			       (const u8 *)&lengths);
+
+	kernel_neon_end();
+
+	return err;
 }
 
 static int gcm_encrypt(struct aead_request *req)
 {
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct sm4_gcm_ctx *ctx = crypto_aead_ctx(aead);
 	u8 __aligned(8) ghash[SM4_BLOCK_SIZE];
 	struct skcipher_walk walk;
 	int err;
 
 	err = skcipher_walk_aead_encrypt(&walk, req, false);
-	if (err)
-		return err;
-
-	err = gcm_crypt(req, &walk, ctx, ghash, sm4_ce_pmull_gcm_enc);
+	err = gcm_crypt(req, &walk, ghash, err, sm4_ce_pmull_gcm_enc);
 	if (err)
 		return err;
 
@@ -215,17 +218,13 @@ static int gcm_decrypt(struct aead_request *req)
 {
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
 	unsigned int authsize = crypto_aead_authsize(aead);
-	struct sm4_gcm_ctx *ctx = crypto_aead_ctx(aead);
 	u8 __aligned(8) ghash[SM4_BLOCK_SIZE];
 	u8 authtag[SM4_BLOCK_SIZE];
 	struct skcipher_walk walk;
 	int err;
 
 	err = skcipher_walk_aead_decrypt(&walk, req, false);
-	if (err)
-		return err;
-
-	err = gcm_crypt(req, &walk, ctx, ghash, sm4_ce_pmull_gcm_dec);
+	err = gcm_crypt(req, &walk, ghash, err, sm4_ce_pmull_gcm_dec);
 	if (err)
 		return err;
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
