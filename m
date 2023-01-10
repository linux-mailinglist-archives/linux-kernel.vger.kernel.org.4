Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BBC66426F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238615AbjAJNwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjAJNvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:51:03 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB08CC5;
        Tue, 10 Jan 2023 05:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673358659;
  x=1704894659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TG79sBPQXvKwaZ2EoZ5EqQSwgfOpv/hMs1+X6I6t1ts=;
  b=NZyte1ViAxLyCInRm2Pq3J4l7ZdoA86ieq0Ffq598yeGaDpDR12uDL+U
   I+Gxl73y+gUUkVV+nX3mvfNmfyg4fnF8O/TpgSmpw19GNvtfKyAP2w2Jh
   GhMEkn6InvQxPI61fG3u9XIRGM5IXoJLfFMRBUAcTMCukfyg0L7ij+fyT
   TR36Ve78Cg/7FijK5+dtmbQ1xuJRxb1a9r/mUsJnXcozlwiQ7mP3uUena
   XbgD01moGQ8AYM/KODhKndeKRZWON9mSMOtb+td5xerIONhZKn0QtKxEY
   3uAa9qQmqYeyYA6fWYUOCAklY/XixS4pdNbUq+QSeuyADtDS8MXFYRo7P
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <jesper.nilsson@axis.com>, <lars.persson@axis.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/12] crypto: axis - fix XTS unaligned block size handling
Date:   Tue, 10 Jan 2023 14:50:40 +0100
Message-ID: <20230110135042.2940847-11-vincent.whitchurch@axis.com>
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

The hardware does not implement ciphertext stealing so fallback to
software if the data length is not aligned to the block size.  Fixes
this kind of errors with CRYPTO_MANAGER_EXTRA_TESTS:

 alg: skcipher: artpec6-xts-aes encryption test failed (wrong result) on
 test vector "random: len=151 klen=64", cfg="random: inplace_two_sglists
 use_digest nosimd src_divs=[96.95%@+1949, 3.5%@+30]"

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/crypto/axis/artpec6_crypto.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index 3b47faa06606..5eccb5a3a52e 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -1309,6 +1309,24 @@ static int artpec6_crypto_ctr_decrypt(struct skcipher_request *req)
 	return artpec6_crypto_ctr_crypt(req, false);
 }
 
+static int artpec6_crypto_xts_encrypt(struct skcipher_request *req)
+{
+	/* Hardware does not implement ciphertext stealing */
+	if (!IS_ALIGNED(req->cryptlen, AES_BLOCK_SIZE))
+		return artpec6_crypto_crypt_fallback(req, true);
+
+	return artpec6_crypto_encrypt(req);
+}
+
+static int artpec6_crypto_xts_decrypt(struct skcipher_request *req)
+{
+	/* Hardware does not implement ciphertext stealing */
+	if (!IS_ALIGNED(req->cryptlen, AES_BLOCK_SIZE))
+		return artpec6_crypto_crypt_fallback(req, false);
+
+	return artpec6_crypto_decrypt(req);
+}
+
 /*
  * AEAD functions
  */
@@ -2928,8 +2946,8 @@ static struct skcipher_alg crypto_algos[] = {
 		.max_keysize = 2*AES_MAX_KEY_SIZE,
 		.ivsize = 16,
 		.setkey = artpec6_crypto_xts_set_key,
-		.encrypt = artpec6_crypto_encrypt,
-		.decrypt = artpec6_crypto_decrypt,
+		.encrypt = artpec6_crypto_xts_encrypt,
+		.decrypt = artpec6_crypto_xts_decrypt,
 		.init = artpec6_crypto_aes_xts_init,
 		.exit = artpec6_crypto_aes_exit,
 	},
-- 
2.34.1

