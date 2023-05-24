Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E671B70FC61
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbjEXRLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 13:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbjEXRKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:10:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6141A4;
        Wed, 24 May 2023 10:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684948227; x=1716484227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=CraprLocyXDvhENSj+WjpPeWHSBemlZGGpDdve25Ay4=;
  b=izxE/czsUdE9+HROV9hfg372+Pf96XX2CX2TN+770RFmOArZ0AfAA0LT
   JP1RtVNq8BtRrrKuBEFu1mJxV1BH+EeLSBlODdNWXMHQElW3HRb7BrOw8
   STTnOful+vAoEmTMKyNM9gQxwWXKp0M90YMCwIdu2gyiVPqizb+sL8j6F
   /ZQsVfGv0BNbuEQpH3TOx/gJTX/uRF1Wjwvl41AuueaJkvBCHDfHUz8G8
   soGSHTfharSZuLaLxrDDB5K/z2pHcDDTVOVi9YQ9MgiDkO6200LVunjl3
   QWMCMlgwQKjuBrVumg4CJG+1ROMi/qQEj0AxUjFoKcCX3BFGNxPcuOqOf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="338206796"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="338206796"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:09:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="704427368"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="704427368"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga002.jf.intel.com with ESMTP; 24 May 2023 10:09:55 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com
Cc:     ebiggers@kernel.org, elliott@hpe.com, gmazyland@gmail.com,
        luto@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        bp@alien8.de, mingo@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au, ardb@kernel.org,
        dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com, nhuck@google.com,
        chang.seok.bae@intel.com, "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v7 10/12] crypto: x86/aesni - Use the proper data type in struct aesni_xts_ctx
Date:   Wed, 24 May 2023 09:57:15 -0700
Message-Id: <20230524165717.14062-11-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230524165717.14062-1-chang.seok.bae@intel.com>
References: <20230410225936.8940-1-chang.seok.bae@intel.com>
 <20230524165717.14062-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every field in struct aesni_xts_ctx is a pointer to a byte array. Each
array has a size of struct crypto_aes_ctx. Then, the field can be
redefined as that struct type instead of the obscure pointer.

Subsequently, the address to struct aesni_xts_ctx should be aligned
right away. This can also simplify the runtime alignment code.

Redefine struct aesni_xts_ctx, and align its address on the front.
This draws a rework by refactoring the common alignment code. Then,
clean up the alignment for the old pointers.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v6:
* Add as a new patch. (Eric Biggers)

This fix was considered to be better addressed before the preparatory
AES-NI code rework.
---
 arch/x86/crypto/aesni-intel_glue.c | 38 +++++++++++++++++-------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index a5b0cb3efeba..97a1629b84c4 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -61,8 +61,8 @@ struct generic_gcmaes_ctx {
 };
 
 struct aesni_xts_ctx {
-	u8 raw_tweak_ctx[sizeof(struct crypto_aes_ctx)] AESNI_ALIGN_ATTR;
-	u8 raw_crypt_ctx[sizeof(struct crypto_aes_ctx)] AESNI_ALIGN_ATTR;
+	struct crypto_aes_ctx tweak_ctx AESNI_ALIGN_ATTR;
+	struct crypto_aes_ctx crypt_ctx AESNI_ALIGN_ATTR;
 };
 
 #define GCM_BLOCK_LEN 16
@@ -219,14 +219,20 @@ generic_gcmaes_ctx *generic_gcmaes_ctx_get(struct crypto_aead *tfm)
 }
 #endif
 
+static inline unsigned long aes_align_addr(unsigned long addr)
+{
+	return (crypto_tfm_ctx_alignment() >= AESNI_ALIGN) ?
+	       ALIGN(addr, 1) : ALIGN(addr, AESNI_ALIGN);
+}
+
 static inline struct crypto_aes_ctx *aes_ctx(void *raw_ctx)
 {
-	unsigned long addr = (unsigned long)raw_ctx;
-	unsigned long align = AESNI_ALIGN;
+	return (struct crypto_aes_ctx *)aes_align_addr((unsigned long)raw_ctx);
+}
 
-	if (align <= crypto_tfm_ctx_alignment())
-		align = 1;
-	return (struct crypto_aes_ctx *)ALIGN(addr, align);
+static inline struct aesni_xts_ctx *aes_xts_ctx(struct crypto_skcipher *tfm)
+{
+	return (struct aesni_xts_ctx *)aes_align_addr((unsigned long)crypto_skcipher_ctx(tfm));
 }
 
 static int aes_set_key_common(struct crypto_tfm *tfm, void *raw_ctx,
@@ -883,7 +889,7 @@ static int helper_rfc4106_decrypt(struct aead_request *req)
 static int xts_aesni_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			    unsigned int keylen)
 {
-	struct aesni_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct aesni_xts_ctx *ctx = aes_xts_ctx(tfm);
 	int err;
 
 	err = xts_verify_key(tfm, key, keylen);
@@ -893,20 +899,20 @@ static int xts_aesni_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	keylen /= 2;
 
 	/* first half of xts-key is for crypt */
-	err = aes_set_key_common(crypto_skcipher_tfm(tfm), ctx->raw_crypt_ctx,
+	err = aes_set_key_common(crypto_skcipher_tfm(tfm), &ctx->crypt_ctx,
 				 key, keylen);
 	if (err)
 		return err;
 
 	/* second half of xts-key is for tweak */
-	return aes_set_key_common(crypto_skcipher_tfm(tfm), ctx->raw_tweak_ctx,
+	return aes_set_key_common(crypto_skcipher_tfm(tfm), &ctx->tweak_ctx,
 				  key + keylen, keylen);
 }
 
 static int xts_crypt(struct skcipher_request *req, bool encrypt)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct aesni_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct aesni_xts_ctx *ctx = aes_xts_ctx(tfm);
 	int tail = req->cryptlen % AES_BLOCK_SIZE;
 	struct skcipher_request subreq;
 	struct skcipher_walk walk;
@@ -942,7 +948,7 @@ static int xts_crypt(struct skcipher_request *req, bool encrypt)
 	kernel_fpu_begin();
 
 	/* calculate first value of T */
-	aesni_enc(aes_ctx(ctx->raw_tweak_ctx), walk.iv, walk.iv);
+	aesni_enc(&ctx->tweak_ctx, walk.iv, walk.iv);
 
 	while (walk.nbytes > 0) {
 		int nbytes = walk.nbytes;
@@ -951,11 +957,11 @@ static int xts_crypt(struct skcipher_request *req, bool encrypt)
 			nbytes &= ~(AES_BLOCK_SIZE - 1);
 
 		if (encrypt)
-			aesni_xts_encrypt(aes_ctx(ctx->raw_crypt_ctx),
+			aesni_xts_encrypt(&ctx->crypt_ctx,
 					  walk.dst.virt.addr, walk.src.virt.addr,
 					  nbytes, walk.iv);
 		else
-			aesni_xts_decrypt(aes_ctx(ctx->raw_crypt_ctx),
+			aesni_xts_decrypt(&ctx->crypt_ctx,
 					  walk.dst.virt.addr, walk.src.virt.addr,
 					  nbytes, walk.iv);
 		kernel_fpu_end();
@@ -983,11 +989,11 @@ static int xts_crypt(struct skcipher_request *req, bool encrypt)
 
 		kernel_fpu_begin();
 		if (encrypt)
-			aesni_xts_encrypt(aes_ctx(ctx->raw_crypt_ctx),
+			aesni_xts_encrypt(&ctx->crypt_ctx,
 					  walk.dst.virt.addr, walk.src.virt.addr,
 					  walk.nbytes, walk.iv);
 		else
-			aesni_xts_decrypt(aes_ctx(ctx->raw_crypt_ctx),
+			aesni_xts_decrypt(&ctx->crypt_ctx,
 					  walk.dst.virt.addr, walk.src.virt.addr,
 					  walk.nbytes, walk.iv);
 		kernel_fpu_end();
-- 
2.17.1

