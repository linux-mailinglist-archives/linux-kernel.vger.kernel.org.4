Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21544664265
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238681AbjAJNvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238403AbjAJNvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:51:04 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1439CA45C;
        Tue, 10 Jan 2023 05:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673358662;
  x=1704894662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aLzM1DqrhyrQcK4KEJ/Hu+9Ne9qneBcLpxAgA6Jk/n8=;
  b=Yhvk8/Lwf0TTW//K06FShn0nKFZRo7wAi4oEconRPllfGI+cTNvmmBub
   U6eH5vro7Kkv4yF+64FTkb12ykjZc8ONyN63Lf9rzYhV0Ul+VmeAG50ot
   hlk2EepWKMfcR+e9CzBqtuGlafyAAaagujN+Jdj5L5DBu2cwVb1VF1ZpK
   bLCul3r1qHajg2L0eN+ZTRO/oIWWPogndnnJmT86oyGZKyM++jAhJvjXO
   YKtqBGGq1aLkuIsITW23qtuTy4DdkWoF6KzQu5/CupnmZPj3+L93OWUaE
   pmvbofEvwGhQPyeXVscge+mZLoc1crjudxIK44nXqX5gSmK8Ls5loLa11
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <jesper.nilsson@axis.com>, <lars.persson@axis.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/12] crypto: axis - reject invalid sizes
Date:   Tue, 10 Jan 2023 14:50:36 +0100
Message-ID: <20230110135042.2940847-7-vincent.whitchurch@axis.com>
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

Reject invalid sizes in block ciphers to fix hangs in
CRYPTO_MANAGER_EXTRA_TESTS like this:

 artpec6-ecb-aes "random: len=55 klen=32" decryption random:
 inplace_one_sglist use_final nosimd src_divs=[<reimport>87.4%@+1524,
 <flush>12.96%@+3553] key_offset=84

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/crypto/axis/artpec6_crypto.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index 0ffe6e0045aa..78d067ce4138 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -1188,6 +1188,22 @@ static int artpec6_crypto_decrypt(struct skcipher_request *req)
 	return artpec6_crypto_submit(&req_ctx->common);
 }
 
+static int artpec6_crypto_block_encrypt(struct skcipher_request *req)
+{
+	if (!IS_ALIGNED(req->cryptlen, AES_BLOCK_SIZE))
+		return -EINVAL;
+
+	return artpec6_crypto_encrypt(req);
+}
+
+static int artpec6_crypto_block_decrypt(struct skcipher_request *req)
+{
+	if (!IS_ALIGNED(req->cryptlen, AES_BLOCK_SIZE))
+		return -EINVAL;
+
+	return artpec6_crypto_decrypt(req);
+}
+
 static int
 artpec6_crypto_ctr_crypt(struct skcipher_request *req, bool encrypt)
 {
@@ -2757,8 +2773,8 @@ static struct skcipher_alg crypto_algos[] = {
 		.min_keysize = AES_MIN_KEY_SIZE,
 		.max_keysize = AES_MAX_KEY_SIZE,
 		.setkey = artpec6_crypto_cipher_set_key,
-		.encrypt = artpec6_crypto_encrypt,
-		.decrypt = artpec6_crypto_decrypt,
+		.encrypt = artpec6_crypto_block_encrypt,
+		.decrypt = artpec6_crypto_block_decrypt,
 		.init = artpec6_crypto_aes_ecb_init,
 		.exit = artpec6_crypto_aes_exit,
 	},
@@ -2802,8 +2818,8 @@ static struct skcipher_alg crypto_algos[] = {
 		.max_keysize = AES_MAX_KEY_SIZE,
 		.ivsize = AES_BLOCK_SIZE,
 		.setkey = artpec6_crypto_cipher_set_key,
-		.encrypt = artpec6_crypto_encrypt,
-		.decrypt = artpec6_crypto_decrypt,
+		.encrypt = artpec6_crypto_block_encrypt,
+		.decrypt = artpec6_crypto_block_decrypt,
 		.init = artpec6_crypto_aes_cbc_init,
 		.exit = artpec6_crypto_aes_exit
 	},
-- 
2.34.1

