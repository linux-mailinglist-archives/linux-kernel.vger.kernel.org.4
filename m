Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D8C66424F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbjAJNvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238265AbjAJNu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:50:56 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DFD64FC;
        Tue, 10 Jan 2023 05:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673358654;
  x=1704894654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L3n+a/Akf31LqdGtqVeh15ZwJJgKE8dO8ZqotT6yTI8=;
  b=dfT7RTJROkP2UoyzCX2YLtwK2DUf0RPeqNlUkJJj17utqsxd/cYjLild
   /EYTajF4aPbN7cq3w7JiSapuK08qeGNkAlNFKe470CYyitTOJVRdRC4xj
   +Th/srrLUYa74s94k+JaYE5QsuLjTh5X3dqJSbOSVAG6xSLsfi4ZSoUAz
   h7B0SVTwowqEGlePI80+63/qkpgmBUeH8Q0BvaaWwgJJKaJIbWIBjkiIb
   73/jRtbSAEI/2fALajg5mIyKrIaZnom1B0jnixl6SCd47t0Owk31zxcH+
   5F+valQRPPk7dm6ci6CF7Ea1bZCu/f3WX83gpEiWRtHeA6f5aRtTl04EH
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <jesper.nilsson@axis.com>, <lars.persson@axis.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/12] crypto: axis - handle zero cryptlen
Date:   Tue, 10 Jan 2023 14:50:41 +0100
Message-ID: <20230110135042.2940847-12-vincent.whitchurch@axis.com>
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

Succeed zero length operations to prevent hangs/failures with various
CRYPTO_MANAGER_EXTRA_TESTS such as:

 artpec6-ecb-aes "random: len=0 klen=32" encryption random:
 inplace_two_sglists may_sleep use_finup src_divs=[100.0%@+2743]
 key_offset=93

For XTS, sizes lesser than the block size need to be explicitly rejected
to prevent errors like this:

 alg: skcipher: artpec6-xts-aes encryption unexpectedly succeeded on test
 vector "random: len=0 klen=64"; expected_error=-22, cfg="rando m:
 use_final nosimd src_divs=[<reimport>100.0%@+3991]
 dst_divs=[73.80%@+4003, 26.20%@+16] iv_offset=68"

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/crypto/axis/artpec6_crypto.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index 5eccb5a3a52e..938faf3afa69 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -1097,6 +1097,9 @@ static int __artpec6_crypto_encrypt(struct skcipher_request *req)
 	void (*complete)(struct crypto_async_request *req);
 	int ret;
 
+	if (!req->cryptlen)
+		return 0;
+
 	req_ctx = skcipher_request_ctx(req);
 
 	switch (ctx->crypto_type) {
@@ -1145,6 +1148,9 @@ static int __artpec6_crypto_decrypt(struct skcipher_request *req)
 	struct artpec6_crypto_request_context *req_ctx = NULL;
 	void (*complete)(struct crypto_async_request *req);
 
+	if (!req->cryptlen)
+		return 0;
+
 	req_ctx = skcipher_request_ctx(req);
 
 	switch (ctx->crypto_type) {
@@ -1311,6 +1317,9 @@ static int artpec6_crypto_ctr_decrypt(struct skcipher_request *req)
 
 static int artpec6_crypto_xts_encrypt(struct skcipher_request *req)
 {
+	if (req->cryptlen < AES_BLOCK_SIZE)
+		return -EINVAL;
+
 	/* Hardware does not implement ciphertext stealing */
 	if (!IS_ALIGNED(req->cryptlen, AES_BLOCK_SIZE))
 		return artpec6_crypto_crypt_fallback(req, true);
@@ -1320,6 +1329,9 @@ static int artpec6_crypto_xts_encrypt(struct skcipher_request *req)
 
 static int artpec6_crypto_xts_decrypt(struct skcipher_request *req)
 {
+	if (req->cryptlen < AES_BLOCK_SIZE)
+		return -EINVAL;
+
 	/* Hardware does not implement ciphertext stealing */
 	if (!IS_ALIGNED(req->cryptlen, AES_BLOCK_SIZE))
 		return artpec6_crypto_crypt_fallback(req, false);
-- 
2.34.1

