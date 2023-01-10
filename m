Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2C6664256
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbjAJNvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238268AbjAJNvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:51:03 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE8717040;
        Tue, 10 Jan 2023 05:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673358658;
  x=1704894658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kt3TYeUvcM4crKR3SNIuzYGknA7sW073R9rphDOt/eU=;
  b=eIrpeflUif06kYBWPYgaG3u4YDO0brpeHaalvygw4q+trJmL5yYBI9bG
   QFwTLpgZwtXkwItZ7V+DCbO/OkLHAtsi5uF8GnWYi31sK6IxDuIsfJVO0
   31stF0cChEPMAWZx+f4rlXuMkLMR9AoC8S4OsNYfmInHsnBFCpd3T1wZl
   aVuxthTYCTUyWUAXkUpcdvmIcFO5NRlllmuv54Anbgi42gXZWfdVVEQHB
   H0jnyNC8qkY7n8SjWXdoHZlL2cbDnjUfQ5OVk3DONH1PyeT46d3DXmNm2
   LcTnsl4+VUB51hYrgzPBI0NNoaRiPQu2YGvNgO3oYbH1IgsYo9VtX21bE
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <jesper.nilsson@axis.com>, <lars.persson@axis.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/12] crypto: axis - fix in-place CBC output IV
Date:   Tue, 10 Jan 2023 14:50:34 +0100
Message-ID: <20230110135042.2940847-5-vincent.whitchurch@axis.com>
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

When CBC is done in-place, the ->src is overwritten by the time the
operation is done, so the output IV must be based on a backup of the
ciphertext.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/crypto/axis/artpec6_crypto.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index 67f510c497f2..87f82c314e48 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -321,6 +321,7 @@ struct artpec6_crypto_request_context {
 	u32 cipher_md;
 	bool decrypt;
 	struct artpec6_crypto_req_common common;
+	unsigned char last_ciphertext[AES_BLOCK_SIZE];
 	unsigned char iv_bounce[AES_BLOCK_SIZE] CRYPTO_MINALIGN_ATTR;
 };
 
@@ -1158,6 +1159,10 @@ static int artpec6_crypto_decrypt(struct skcipher_request *req)
 
 	switch (ctx->crypto_type) {
 	case ARTPEC6_CRYPTO_CIPHER_AES_CBC:
+		scatterwalk_map_and_copy(req_ctx->last_ciphertext, req->src,
+					 req->cryptlen - sizeof(req_ctx->last_ciphertext),
+					 sizeof(req_ctx->last_ciphertext), 0);
+
 		complete = artpec6_crypto_complete_cbc_decrypt;
 		break;
 	case ARTPEC6_CRYPTO_CIPHER_AES_CTR:
@@ -2185,10 +2190,10 @@ artpec6_crypto_complete_cbc_decrypt(struct crypto_async_request *req)
 {
 	struct skcipher_request *cipher_req = container_of(req,
 		struct skcipher_request, base);
+	struct artpec6_crypto_request_context *req_ctx = skcipher_request_ctx(cipher_req);
+
+	memcpy(cipher_req->iv, req_ctx->last_ciphertext, sizeof(req_ctx->last_ciphertext));
 
-	scatterwalk_map_and_copy(cipher_req->iv, cipher_req->src,
-				 cipher_req->cryptlen - AES_BLOCK_SIZE,
-				 AES_BLOCK_SIZE, 0);
 	req->complete(req, 0);
 }
 
-- 
2.34.1

