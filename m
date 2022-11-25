Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2285D638331
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 05:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiKYEhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 23:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiKYEg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 23:36:57 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABA825C74;
        Thu, 24 Nov 2022 20:36:52 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oyQS7-000dkB-Ec; Fri, 25 Nov 2022 12:36:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 25 Nov 2022 12:36:39 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Fri, 25 Nov 2022 12:36:39 +0800
Subject: [v2 PATCH 6/9] crypto: api - Increase MAX_ALGAPI_ALIGNMASK to 127
References: <Y4BGC2BPesy3qsEm@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Message-Id: <E1oyQS7-000dkB-Ec@formenos.hmeau.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously we limited the maximum alignment mask to 63.  This
is mostly due to stack usage for shash.  This patch introduces
a separate limit for shash algorithms and increases the general
limit to 127 which is the value that we need for DMA allocations
on arm64.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 crypto/shash.c          |    9 +++++++--
 include/crypto/algapi.h |    2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/crypto/shash.c b/crypto/shash.c
index 4c88e63b3350..22c744389586 100644
--- a/crypto/shash.c
+++ b/crypto/shash.c
@@ -18,6 +18,8 @@
 
 #include "internal.h"
 
+#define MAX_SHASH_ALIGNMASK 63
+
 static const struct crypto_type crypto_shash_type;
 
 static int shash_no_setkey(struct crypto_shash *tfm, const u8 *key,
@@ -100,7 +102,7 @@ static int shash_update_unaligned(struct shash_desc *desc, const u8 *data,
 	 * We cannot count on __aligned() working for large values:
 	 * https://patchwork.kernel.org/patch/9507697/
 	 */
-	u8 ubuf[MAX_ALGAPI_ALIGNMASK * 2];
+	u8 ubuf[MAX_SHASH_ALIGNMASK * 2];
 	u8 *buf = PTR_ALIGN(&ubuf[0], alignmask + 1);
 	int err;
 
@@ -142,7 +144,7 @@ static int shash_final_unaligned(struct shash_desc *desc, u8 *out)
 	 * We cannot count on __aligned() working for large values:
 	 * https://patchwork.kernel.org/patch/9507697/
 	 */
-	u8 ubuf[MAX_ALGAPI_ALIGNMASK + HASH_MAX_DIGESTSIZE];
+	u8 ubuf[MAX_SHASH_ALIGNMASK + HASH_MAX_DIGESTSIZE];
 	u8 *buf = PTR_ALIGN(&ubuf[0], alignmask + 1);
 	int err;
 
@@ -536,6 +538,9 @@ static int shash_prepare_alg(struct shash_alg *alg)
 	    alg->statesize > HASH_MAX_STATESIZE)
 		return -EINVAL;
 
+	if (base->cra_alignmask > MAX_SHASH_ALIGNMASK)
+		return -EINVAL;
+
 	if ((alg->export && !alg->import) || (alg->import && !alg->export))
 		return -EINVAL;
 
diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index 4c99eb66e654..8722fd67f40a 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -22,7 +22,7 @@
  * algs and architectures. Ciphers have a lower maximum size.
  */
 #define MAX_ALGAPI_BLOCKSIZE		160
-#define MAX_ALGAPI_ALIGNMASK		63
+#define MAX_ALGAPI_ALIGNMASK		127
 #define MAX_CIPHER_BLOCKSIZE		16
 #define MAX_CIPHER_ALIGNMASK		15
 
