Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B13A66425B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237980AbjAJNv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238405AbjAJNvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:51:04 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F9B1A064;
        Tue, 10 Jan 2023 05:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673358663;
  x=1704894663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OHusmXIRIHHHFddqyEz1DJQNr7nvVO78UPiDQuxU384=;
  b=L0uNsxZ+6KtsRZ4lbQvx4nEVyNQa+zsU4aAXgRHYO/zE65agHlSAeMnV
   jkp9iRzO7px4NNNuit9AWkkJlBRmK4YIk5QlykXxPhdXoN6QbYZUcjEYq
   uYvM83KfsNFtxbJs0PIczj5GZtzZq5U95uOQcBmJkeBlaeiX2+uwQ7DLd
   FBVmW+qAp84ujOhWNcQo2ipMgvzqMD4ALfUptAO2j/KqtjmE+CzRJsVf6
   o24K4Liy2m884h2Z19VkENzu8j1b0NBOnc1oIp449ubG2ggHUwe8wb7AO
   43xiQsCgJndsAmlkI0VwysVs8bFQ7nIhwDfgyjMZGMN6AKFamzsA/uYb3
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <jesper.nilsson@axis.com>, <lars.persson@axis.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/12] crypto: axis - add skcipher fallback
Date:   Tue, 10 Jan 2023 14:50:38 +0100
Message-ID: <20230110135042.2940847-9-vincent.whitchurch@axis.com>
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
failures higher up in the stack such as in CIFS.  Use software fallbacks
for all skcipher algos to handle this case.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/crypto/Kconfig               |   3 +
 drivers/crypto/axis/artpec6_crypto.c | 110 ++++++++++++++++++---------
 2 files changed, 75 insertions(+), 38 deletions(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index dfb103f81a64..5aa4bfb648ec 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -770,11 +770,14 @@ config CRYPTO_DEV_ARTPEC6
 	select CRYPTO_AES
 	select CRYPTO_ALGAPI
 	select CRYPTO_SKCIPHER
+	select CRYPTO_CBC
 	select CRYPTO_CTR
+	select CRYPTO_ECB
 	select CRYPTO_HASH
 	select CRYPTO_SHA1
 	select CRYPTO_SHA256
 	select CRYPTO_SHA512
+	select CRYPTO_XTS
 	help
 	  Enables the driver for the on-chip crypto accelerator
 	  of Axis ARTPEC SoCs.
diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index 5f30f3d0315f..a05f0927f753 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -1088,7 +1088,7 @@ artpec6_crypto_common_destroy(struct artpec6_crypto_req_common *common)
 /*
  * Ciphering functions.
  */
-static int artpec6_crypto_encrypt(struct skcipher_request *req)
+static int __artpec6_crypto_encrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *cipher = crypto_skcipher_reqtfm(req);
 	struct artpec6_cryptotfm_context *ctx = crypto_skcipher_ctx(cipher);
@@ -1136,7 +1136,7 @@ static int artpec6_crypto_encrypt(struct skcipher_request *req)
 	return artpec6_crypto_submit(&req_ctx->common);
 }
 
-static int artpec6_crypto_decrypt(struct skcipher_request *req)
+static int __artpec6_crypto_decrypt(struct skcipher_request *req)
 {
 	int ret;
 	struct crypto_skcipher *cipher = crypto_skcipher_reqtfm(req);
@@ -1188,6 +1188,53 @@ static int artpec6_crypto_decrypt(struct skcipher_request *req)
 	return artpec6_crypto_submit(&req_ctx->common);
 }
 
+static int artpec6_crypto_crypt_fallback(struct skcipher_request *req,
+					 bool encrypt)
+{
+	struct crypto_skcipher *cipher = crypto_skcipher_reqtfm(req);
+	struct artpec6_cryptotfm_context *ctx = crypto_skcipher_ctx(cipher);
+	SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, ctx->fallback);
+	int ret;
+
+	ret = crypto_sync_skcipher_setkey(ctx->fallback, ctx->aes_key,
+					  ctx->key_length);
+	if (ret)
+		return ret;
+
+	skcipher_request_set_sync_tfm(subreq, ctx->fallback);
+	skcipher_request_set_callback(subreq, req->base.flags,
+				      NULL, NULL);
+	skcipher_request_set_crypt(subreq, req->src, req->dst,
+				   req->cryptlen, req->iv);
+	ret = encrypt ? crypto_skcipher_encrypt(subreq)
+		      : crypto_skcipher_decrypt(subreq);
+	skcipher_request_zero(subreq);
+
+	return ret;
+}
+
+static int artpec6_crypto_encrypt(struct skcipher_request *req)
+{
+	int ret;
+
+	ret = __artpec6_crypto_encrypt(req);
+	if (ret != -ENOSPC)
+		return ret;
+
+	return artpec6_crypto_crypt_fallback(req, true);
+}
+
+static int artpec6_crypto_decrypt(struct skcipher_request *req)
+{
+	int ret;
+
+	ret = __artpec6_crypto_decrypt(req);
+	if (ret != -ENOSPC)
+		return ret;
+
+	return artpec6_crypto_crypt_fallback(req, false);
+}
+
 static int artpec6_crypto_block_encrypt(struct skcipher_request *req)
 {
 	if (!IS_ALIGNED(req->cryptlen, AES_BLOCK_SIZE))
@@ -1570,18 +1617,7 @@ static int artpec6_crypto_prepare_hash(struct ahash_request *areq)
 	return ARTPEC6_CRYPTO_PREPARE_HASH_START;
 }
 
-
-static int artpec6_crypto_aes_ecb_init(struct crypto_skcipher *tfm)
-{
-	struct artpec6_cryptotfm_context *ctx = crypto_skcipher_ctx(tfm);
-
-	tfm->reqsize = sizeof(struct artpec6_crypto_request_context);
-	ctx->crypto_type = ARTPEC6_CRYPTO_CIPHER_AES_ECB;
-
-	return 0;
-}
-
-static int artpec6_crypto_aes_ctr_init(struct crypto_skcipher *tfm)
+static int artpec6_crypto_aes_init(struct crypto_skcipher *tfm, int crypto_type)
 {
 	struct artpec6_cryptotfm_context *ctx = crypto_skcipher_ctx(tfm);
 
@@ -1592,44 +1628,39 @@ static int artpec6_crypto_aes_ctr_init(struct crypto_skcipher *tfm)
 		return PTR_ERR(ctx->fallback);
 
 	tfm->reqsize = sizeof(struct artpec6_crypto_request_context);
-	ctx->crypto_type = ARTPEC6_CRYPTO_CIPHER_AES_CTR;
+	ctx->crypto_type = crypto_type;
 
 	return 0;
 }
 
-static int artpec6_crypto_aes_cbc_init(struct crypto_skcipher *tfm)
+static int artpec6_crypto_aes_ecb_init(struct crypto_skcipher *tfm)
 {
-	struct artpec6_cryptotfm_context *ctx = crypto_skcipher_ctx(tfm);
+	return artpec6_crypto_aes_init(tfm, ARTPEC6_CRYPTO_CIPHER_AES_ECB);
+}
 
-	tfm->reqsize = sizeof(struct artpec6_crypto_request_context);
-	ctx->crypto_type = ARTPEC6_CRYPTO_CIPHER_AES_CBC;
+static int artpec6_crypto_aes_ctr_init(struct crypto_skcipher *tfm)
+{
+	return artpec6_crypto_aes_init(tfm, ARTPEC6_CRYPTO_CIPHER_AES_CTR);
+}
 
-	return 0;
+static int artpec6_crypto_aes_cbc_init(struct crypto_skcipher *tfm)
+{
+	return artpec6_crypto_aes_init(tfm, ARTPEC6_CRYPTO_CIPHER_AES_CBC);
 }
 
 static int artpec6_crypto_aes_xts_init(struct crypto_skcipher *tfm)
 {
-	struct artpec6_cryptotfm_context *ctx = crypto_skcipher_ctx(tfm);
-
-	tfm->reqsize = sizeof(struct artpec6_crypto_request_context);
-	ctx->crypto_type = ARTPEC6_CRYPTO_CIPHER_AES_XTS;
-
-	return 0;
+	return artpec6_crypto_aes_init(tfm, ARTPEC6_CRYPTO_CIPHER_AES_XTS);
 }
 
 static void artpec6_crypto_aes_exit(struct crypto_skcipher *tfm)
 {
 	struct artpec6_cryptotfm_context *ctx = crypto_skcipher_ctx(tfm);
 
-	memset(ctx, 0, sizeof(*ctx));
-}
+	if (ctx->fallback)
+		crypto_free_sync_skcipher(ctx->fallback);
 
-static void artpec6_crypto_aes_ctr_exit(struct crypto_skcipher *tfm)
-{
-	struct artpec6_cryptotfm_context *ctx = crypto_skcipher_ctx(tfm);
-
-	crypto_free_sync_skcipher(ctx->fallback);
-	artpec6_crypto_aes_exit(tfm);
+	memset(ctx, 0, sizeof(*ctx));
 }
 
 static int
@@ -2764,7 +2795,8 @@ static struct skcipher_alg crypto_algos[] = {
 			.cra_driver_name = "artpec6-ecb-aes",
 			.cra_priority = 300,
 			.cra_flags = CRYPTO_ALG_ASYNC |
-				     CRYPTO_ALG_ALLOCATES_MEMORY,
+				     CRYPTO_ALG_ALLOCATES_MEMORY |
+				     CRYPTO_ALG_NEED_FALLBACK,
 			.cra_blocksize = AES_BLOCK_SIZE,
 			.cra_ctxsize = sizeof(struct artpec6_cryptotfm_context),
 			.cra_alignmask = 3,
@@ -2799,7 +2831,7 @@ static struct skcipher_alg crypto_algos[] = {
 		.encrypt = artpec6_crypto_ctr_encrypt,
 		.decrypt = artpec6_crypto_ctr_decrypt,
 		.init = artpec6_crypto_aes_ctr_init,
-		.exit = artpec6_crypto_aes_ctr_exit,
+		.exit = artpec6_crypto_aes_exit,
 	},
 	/* AES - CBC */
 	{
@@ -2808,7 +2840,8 @@ static struct skcipher_alg crypto_algos[] = {
 			.cra_driver_name = "artpec6-cbc-aes",
 			.cra_priority = 300,
 			.cra_flags = CRYPTO_ALG_ASYNC |
-				     CRYPTO_ALG_ALLOCATES_MEMORY,
+				     CRYPTO_ALG_ALLOCATES_MEMORY |
+				     CRYPTO_ALG_NEED_FALLBACK,
 			.cra_blocksize = AES_BLOCK_SIZE,
 			.cra_ctxsize = sizeof(struct artpec6_cryptotfm_context),
 			.cra_alignmask = 3,
@@ -2830,7 +2863,8 @@ static struct skcipher_alg crypto_algos[] = {
 			.cra_driver_name = "artpec6-xts-aes",
 			.cra_priority = 300,
 			.cra_flags = CRYPTO_ALG_ASYNC |
-				     CRYPTO_ALG_ALLOCATES_MEMORY,
+				     CRYPTO_ALG_ALLOCATES_MEMORY |
+				     CRYPTO_ALG_NEED_FALLBACK,
 			.cra_blocksize = AES_BLOCK_SIZE,
 			.cra_ctxsize = sizeof(struct artpec6_cryptotfm_context),
 			.cra_alignmask = 3,
-- 
2.34.1

