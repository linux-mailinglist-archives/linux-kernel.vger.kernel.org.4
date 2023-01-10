Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D10566424E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238357AbjAJNvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238252AbjAJNu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:50:56 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B228A640E;
        Tue, 10 Jan 2023 05:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673358654;
  x=1704894654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ba6MyrEzcdHDm3pPgaIKXEToqVrbCHSG8Ev/nxX8HMo=;
  b=ec1CG//8jBN74mOQIbxYfMKiUOYn6scM3jBoiLLnyNBnvPu/h3PSjrB2
   sWjzzQKMW3Cnurywa8p2c8HBk+jbA6cRhGRhF+yAFzwjJfuw48zF68Xnb
   /ObCWTzOwBx4UaMCZSYUAcmUQyOhIfmnzWFKOxSOHWDZyKLgmFDIuI3M5
   0WlUnXSJazIk919R/Lt4nKRBYLSXpz3HsiyKtmGyJ23A5V6Nz7dJiczAj
   C2smhZD0Dof+FdjLNuwaJ6xeWOkOzp/Kro7sKQtsFOpIlD1zhIqBncbUK
   kbFgsMC4Uu+SlMSIFBGrlqemvmWmXKlOLb+AQJd5FdQGm6w4DbEPXV0Al
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <jesper.nilsson@axis.com>, <lars.persson@axis.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/12] crypto: axis - fix CTR output IV
Date:   Tue, 10 Jan 2023 14:50:33 +0100
Message-ID: <20230110135042.2940847-4-vincent.whitchurch@axis.com>
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

Write the updated counter value to the IV with software since the
hardware does not do it.  Fixes this self test:

 alg: skcipher: artpec6-ctr-aes encryption test failed (wrong output IV)
 on test vector 0, cfg="in-place (one sglist)"

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/crypto/axis/artpec6_crypto.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index d3b6ee065a81..67f510c497f2 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -370,6 +370,8 @@ artpec6_crypto_complete_cbc_encrypt(struct crypto_async_request *req);
 static void
 artpec6_crypto_complete_cbc_decrypt(struct crypto_async_request *req);
 static void
+artpec6_crypto_complete_ctr(struct crypto_async_request *req);
+static void
 artpec6_crypto_complete_aead(struct crypto_async_request *req);
 static void
 artpec6_crypto_complete_hash(struct crypto_async_request *req);
@@ -1109,6 +1111,9 @@ static int artpec6_crypto_encrypt(struct skcipher_request *req)
 	case ARTPEC6_CRYPTO_CIPHER_AES_CBC:
 		complete = artpec6_crypto_complete_cbc_encrypt;
 		break;
+	case ARTPEC6_CRYPTO_CIPHER_AES_CTR:
+		complete = artpec6_crypto_complete_ctr;
+		break;
 	default:
 		complete = artpec6_crypto_complete_crypto;
 		break;
@@ -1155,6 +1160,9 @@ static int artpec6_crypto_decrypt(struct skcipher_request *req)
 	case ARTPEC6_CRYPTO_CIPHER_AES_CBC:
 		complete = artpec6_crypto_complete_cbc_decrypt;
 		break;
+	case ARTPEC6_CRYPTO_CIPHER_AES_CTR:
+		complete = artpec6_crypto_complete_ctr;
+		break;
 	default:
 		complete = artpec6_crypto_complete_crypto;
 		break;
@@ -2158,6 +2166,20 @@ static void artpec6_crypto_complete_crypto(struct crypto_async_request *req)
 	req->complete(req, 0);
 }
 
+static void artpec6_crypto_complete_ctr(struct crypto_async_request *req)
+{
+	struct skcipher_request *cipher_req = container_of(req,
+		struct skcipher_request, base);
+	unsigned int nblks = ALIGN(cipher_req->cryptlen, AES_BLOCK_SIZE) /
+			     AES_BLOCK_SIZE;
+	__be32 *iv = (void *)cipher_req->iv;
+	unsigned int counter = be32_to_cpu(iv[3]);
+
+	iv[3] = cpu_to_be32(counter + nblks);
+
+	req->complete(req, 0);
+}
+
 static void
 artpec6_crypto_complete_cbc_decrypt(struct crypto_async_request *req)
 {
-- 
2.34.1

