Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38E6664267
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjAJNvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238404AbjAJNvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:51:04 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE2118E27;
        Tue, 10 Jan 2023 05:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673358662;
  x=1704894662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XiDCiRkia9wTJveMuFF7NAesdt6ils+FDUKpwJh0mik=;
  b=gpbupfxiqCrldgXEX/gBrSdz6P3r0iCTFEd99nWiYHJxPqVzU/q7HnKt
   5rT33PockQ83RCkjWrxy4OZyLkuKJfDpoV/2yTwzoBoXyBceG0CSTG+Dv
   HtzAhsGvIgvhR9o6gu4WqDIqfRBvKo9Tdxia8zNSP6oTkuYsjyPBuuZeH
   bfZvVuCSf/GUH3h5wFXpTiG6TtkYPAUm1a6kFI142u0qXxz1sotDW/ko5
   xoM/OTN6qHBhY2Uw4W/AqOFEfIciBvIvNFxZ2wq4Ap0JdQmVrZiEOp9Nw
   i0nyK5WrepJNEO92kqb3B0lfrbmXcU6sd6XoNKIvVLG66WuoHvpCtxsIG
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <jesper.nilsson@axis.com>, <lars.persson@axis.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/12] crypto: axis - add fallback for AEAD
Date:   Tue, 10 Jan 2023 14:50:39 +0100
Message-ID: <20230110135042.2940847-10-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230110135042.2940847-1-vincent.whitchurch@axis.com>
References: <20230110135042.2940847-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware has a limit of 64 DMA descriptors.  If we hit the limit we
currently just fail the crypto operation, but this could result in
failures higher up in the stack such as in CIFS.

Add a fallback for the gcm(aes) AEAD algorithm.  The fallback handling
is based on drivers/crypto/amcc/crypto4xx_{algo,core}.c

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/crypto/Kconfig               |  1 +
 drivers/crypto/axis/artpec6_crypto.c | 58 +++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 5aa4bfb648ec..5615c9f2641e 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -773,6 +773,7 @@ config CRYPTO_DEV_ARTPEC6
 	select CRYPTO_CBC
 	select CRYPTO_CTR
 	select CRYPTO_ECB
+	select CRYPTO_GCM
 	select CRYPTO_HASH
 	select CRYPTO_SHA1
 	select CRYPTO_SHA256
diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index a05f0927f753..3b47faa06606 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -331,6 +331,7 @@ struct artpec6_cryptotfm_context {
 	u32 key_md;
 	int crypto_type;
 	struct crypto_sync_skcipher *fallback;
+	struct crypto_aead *aead_fallback;
 };
 
 struct artpec6_crypto_aead_hw_ctx {
@@ -1317,20 +1318,54 @@ static int artpec6_crypto_aead_init(struct crypto_aead *tfm)
 
 	memset(tfm_ctx, 0, sizeof(*tfm_ctx));
 
+	tfm_ctx->aead_fallback = crypto_alloc_aead(crypto_tfm_alg_name(&tfm->base),
+					      0,
+					      CRYPTO_ALG_ASYNC |
+					      CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(tfm_ctx->aead_fallback))
+		return PTR_ERR(tfm_ctx->aead_fallback);
+
 	crypto_aead_set_reqsize(tfm,
-				sizeof(struct artpec6_crypto_aead_req_ctx));
+				max(sizeof(struct aead_request) + 32 +
+				crypto_aead_reqsize(tfm_ctx->aead_fallback),
+				sizeof(struct artpec6_crypto_aead_req_ctx)));
 
 	return 0;
 }
 
+static void artpec6_crypto_aead_exit(struct crypto_aead *tfm)
+{
+	struct artpec6_cryptotfm_context *ctx = crypto_aead_ctx(tfm);
+
+	crypto_free_aead(ctx->aead_fallback);
+}
+
+static int artpec6_crypto_aead_fallback_set_key(struct artpec6_cryptotfm_context *ctx,
+					 struct crypto_aead *tfm,
+					 const u8 *key,
+					 unsigned int keylen)
+{
+	struct crypto_aead *fallback = ctx->aead_fallback;
+
+	crypto_aead_clear_flags(fallback, CRYPTO_TFM_REQ_MASK);
+	crypto_aead_set_flags(fallback,
+		crypto_aead_get_flags(tfm) & CRYPTO_TFM_REQ_MASK);
+	return crypto_aead_setkey(fallback, key, keylen);
+}
+
 static int artpec6_crypto_aead_set_key(struct crypto_aead *tfm, const u8 *key,
 			       unsigned int len)
 {
 	struct artpec6_cryptotfm_context *ctx = crypto_tfm_ctx(&tfm->base);
+	int ret;
 
 	if (len != 16 && len != 24 && len != 32)
 		return -EINVAL;
 
+	ret = artpec6_crypto_aead_fallback_set_key(ctx, tfm, key, len);
+	if (ret < 0)
+		return ret;
+
 	ctx->key_length = len;
 
 	memcpy(ctx->aes_key, key, len);
@@ -1343,6 +1378,21 @@ static int artpec6_crypto_aead_setauthsize(struct crypto_aead *tfm,
 	return crypto_gcm_check_authsize(authsize);
 }
 
+static int artpec6_crypto_aead_fallback(struct aead_request *req, bool encrypt)
+{
+	struct artpec6_cryptotfm_context *tfm_ctx = crypto_tfm_ctx(req->base.tfm);
+	struct aead_request *subreq = aead_request_ctx(req);
+
+	aead_request_set_tfm(subreq, tfm_ctx->aead_fallback);
+	aead_request_set_callback(subreq, req->base.flags,
+				  req->base.complete, req->base.data);
+	aead_request_set_crypt(subreq, req->src, req->dst, req->cryptlen,
+			       req->iv);
+	aead_request_set_ad(subreq, req->assoclen);
+	return encrypt ? crypto_aead_encrypt(subreq) :
+			 crypto_aead_decrypt(subreq);
+}
+
 static int artpec6_crypto_aead_encrypt(struct aead_request *req)
 {
 	int ret;
@@ -1358,6 +1408,8 @@ static int artpec6_crypto_aead_encrypt(struct aead_request *req)
 	ret = artpec6_crypto_prepare_aead(req);
 	if (ret) {
 		artpec6_crypto_common_destroy(&req_ctx->common);
+		if (ret == -ENOSPC)
+			return artpec6_crypto_aead_fallback(req, true);
 		return ret;
 	}
 
@@ -1383,6 +1435,8 @@ static int artpec6_crypto_aead_decrypt(struct aead_request *req)
 	ret = artpec6_crypto_prepare_aead(req);
 	if (ret) {
 		artpec6_crypto_common_destroy(&req_ctx->common);
+		if (ret == -ENOSPC)
+			return artpec6_crypto_aead_fallback(req, false);
 		return ret;
 	}
 
@@ -2884,6 +2938,7 @@ static struct skcipher_alg crypto_algos[] = {
 static struct aead_alg aead_algos[] = {
 	{
 		.init   = artpec6_crypto_aead_init,
+		.exit   = artpec6_crypto_aead_exit,
 		.setkey = artpec6_crypto_aead_set_key,
 		.setauthsize = artpec6_crypto_aead_setauthsize,
 		.encrypt = artpec6_crypto_aead_encrypt,
@@ -2897,6 +2952,7 @@ static struct aead_alg aead_algos[] = {
 			.cra_priority = 300,
 			.cra_flags = CRYPTO_ALG_ASYNC |
 				     CRYPTO_ALG_ALLOCATES_MEMORY |
+				     CRYPTO_ALG_NEED_FALLBACK |
 				     CRYPTO_ALG_KERN_DRIVER_ONLY,
 			.cra_blocksize = 1,
 			.cra_ctxsize = sizeof(struct artpec6_cryptotfm_context),
-- 
2.34.1

