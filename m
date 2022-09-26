Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880ED5E9DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbiIZJid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbiIZJhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:37:04 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BDF2DABB;
        Mon, 26 Sep 2022 02:36:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VQkJzHP_1664185004;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VQkJzHP_1664185004)
          by smtp.aliyun-inc.com;
          Mon, 26 Sep 2022 17:36:45 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 11/16] crypto: essiv - allow digestsize to be greater than keysize
Date:   Mon, 26 Sep 2022 17:36:15 +0800
Message-Id: <20220926093620.99898-12-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220926093620.99898-1-tianjia.zhang@linux.alibaba.com>
References: <20220926093620.99898-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In essiv mode, the digest of the hash algorithm is used as the key to
encrypt the IV. The current implementation requires that the digest size
of the hash algorithm is equal to the key size, which will exclude
algorithms that do not meet this situation, such as essiv(cbc(sm4),sm3),
the hash result of sm3 is fixed 256 bits, and the key size of sm4
symmetric algorithm is fixed 128 bits, which makes it impossible to use
essiv mode.

This patch allows algorithms whose digest size is greater than key size
to use esssiv mode by truncating the digest.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/essiv.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/crypto/essiv.c b/crypto/essiv.c
index e33369df9034..6ee5a61bcae4 100644
--- a/crypto/essiv.c
+++ b/crypto/essiv.c
@@ -68,6 +68,7 @@ static int essiv_skcipher_setkey(struct crypto_skcipher *tfm,
 {
 	struct essiv_tfm_ctx *tctx = crypto_skcipher_ctx(tfm);
 	u8 salt[HASH_MAX_DIGESTSIZE];
+	unsigned int saltlen;
 	int err;
 
 	crypto_skcipher_clear_flags(tctx->u.skcipher, CRYPTO_TFM_REQ_MASK);
@@ -86,8 +87,11 @@ static int essiv_skcipher_setkey(struct crypto_skcipher *tfm,
 	crypto_cipher_set_flags(tctx->essiv_cipher,
 				crypto_skcipher_get_flags(tfm) &
 				CRYPTO_TFM_REQ_MASK);
-	return crypto_cipher_setkey(tctx->essiv_cipher, salt,
-				    crypto_shash_digestsize(tctx->hash));
+
+	saltlen = min(crypto_shash_digestsize(tctx->hash),
+		      crypto_skcipher_max_keysize(tctx->u.skcipher));
+
+	return crypto_cipher_setkey(tctx->essiv_cipher, salt, saltlen);
 }
 
 static int essiv_aead_setkey(struct crypto_aead *tfm, const u8 *key,
@@ -418,8 +422,7 @@ static bool essiv_supported_algorithms(const char *essiv_cipher_name,
 	if (IS_ERR(alg))
 		return false;
 
-	if (hash_alg->digestsize < alg->cra_cipher.cia_min_keysize ||
-	    hash_alg->digestsize > alg->cra_cipher.cia_max_keysize)
+	if (hash_alg->digestsize < alg->cra_cipher.cia_min_keysize)
 		goto out;
 
 	if (ivsize != alg->cra_blocksize)
-- 
2.24.3 (Apple Git-128)

