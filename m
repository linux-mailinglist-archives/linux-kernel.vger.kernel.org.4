Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE28A7210F2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 17:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237215AbjFCPfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 11:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjFCPfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 11:35:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD3D196;
        Sat,  3 Jun 2023 08:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685806509; x=1717342509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=JuGCcbdKy6HnWD9nV+yhU/c8CjxhfWSH1IbwUpyXMUU=;
  b=eiP8cVB4bG9e4mM5Sxfnrp3hzLOGu1g0+gXnmV6OFEkm3rCSbKub05du
   I/VgeWfTeWJ4oX78rxz+EPgHpRs0cyQCRN0bhf1G2j92YEsDR6ggRM/eS
   JW86h88g4Jv28PJOC25G41gesPITI0U0hBjZ5DY0LnkRqSZTUVGkLizkp
   WFacZF3y3/thIZkERh+ACFY2gBKWDW+fYAcqSo+eb2kH6T1Bx0dY63nMs
   kOzVOXzY5hzXYHXczcEyKCdwsKSzsFbTSVBZ8Qk/gRhAGJ+x31JcGtzMA
   1K4UYniAh5lvXwZDhmxPvdyjBIpsDEdtDgaPJmuXouhqYonYxXKJ2xi2v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="356097500"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="356097500"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2023 08:35:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="702274278"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="702274278"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga007.jf.intel.com with ESMTP; 03 Jun 2023 08:35:08 -0700
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
Subject: [PATCH v8 10/12] crypto: x86/aesni - Use the proper data type in struct aesni_xts_ctx
Date:   Sat,  3 Jun 2023 08:22:25 -0700
Message-Id: <20230603152227.12335-11-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230603152227.12335-1-chang.seok.bae@intel.com>
References: <20230524165717.14062-1-chang.seok.bae@intel.com>
 <20230603152227.12335-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every field in struct aesni_xts_ctx is a pointer to a byte array. Each
array has a size of struct crypto_aes_ctx. Then, the field can be
redefined as that struct type instead of the obscure pointer.

Subsequently, the address to struct aesni_xts_ctx should be aligned
right away rather than on every access to the field.

Thus, redefine struct aesni_xts_ctx, and align its address on the
front. This draws a rework by refactoring the common alignment code.

Then, the refactored code itself appears to be useful to simplify
the overall runtime alignment. So, use it for other modes.

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
Changes from v7:
* Massage the helper function to be usable for other alignment code
  such as aesni_rfc4106_gcm_ctx_get() and generic_gcmaes_ctx_get().
  (Eric Biggers)

Changes from v6:
* Add as a new patch. (Eric Biggers)

This fix was considered to be better addressed before the preparatory
AES-NI code rework.
---
 arch/x86/crypto/aesni-intel_glue.c | 51 +++++++++++++++---------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index a5b0cb3efeba..589648142c17 100644
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
@@ -80,6 +80,13 @@ struct gcm_context_data {
 	u8 hash_keys[GCM_BLOCK_LEN * 16];
 };
 
+static inline void *aes_align_addr(void *addr)
+{
+	if (crypto_tfm_ctx_alignment() >= AESNI_ALIGN)
+		return addr;
+	return PTR_ALIGN(addr, AESNI_ALIGN);
+}
+
 asmlinkage int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
 			     unsigned int key_len);
 asmlinkage void aesni_enc(const void *ctx, u8 *out, const u8 *in);
@@ -201,32 +208,24 @@ static __ro_after_init DEFINE_STATIC_KEY_FALSE(gcm_use_avx2);
 static inline struct
 aesni_rfc4106_gcm_ctx *aesni_rfc4106_gcm_ctx_get(struct crypto_aead *tfm)
 {
-	unsigned long align = AESNI_ALIGN;
-
-	if (align <= crypto_tfm_ctx_alignment())
-		align = 1;
-	return PTR_ALIGN(crypto_aead_ctx(tfm), align);
+	return (struct aesni_rfc4106_gcm_ctx *)aes_align_addr(crypto_aead_ctx(tfm));
 }
 
 static inline struct
 generic_gcmaes_ctx *generic_gcmaes_ctx_get(struct crypto_aead *tfm)
 {
-	unsigned long align = AESNI_ALIGN;
-
-	if (align <= crypto_tfm_ctx_alignment())
-		align = 1;
-	return PTR_ALIGN(crypto_aead_ctx(tfm), align);
+	return (struct generic_gcmaes_ctx *)aes_align_addr(crypto_aead_ctx(tfm));
 }
 #endif
 
 static inline struct crypto_aes_ctx *aes_ctx(void *raw_ctx)
 {
-	unsigned long addr = (unsigned long)raw_ctx;
-	unsigned long align = AESNI_ALIGN;
+	return (struct crypto_aes_ctx *)aes_align_addr(raw_ctx);
+}
 
-	if (align <= crypto_tfm_ctx_alignment())
-		align = 1;
-	return (struct crypto_aes_ctx *)ALIGN(addr, align);
+static inline struct aesni_xts_ctx *aes_xts_ctx(struct crypto_skcipher *tfm)
+{
+	return (struct aesni_xts_ctx *)aes_align_addr(crypto_skcipher_ctx(tfm));
 }
 
 static int aes_set_key_common(struct crypto_tfm *tfm, void *raw_ctx,
@@ -883,7 +882,7 @@ static int helper_rfc4106_decrypt(struct aead_request *req)
 static int xts_aesni_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			    unsigned int keylen)
 {
-	struct aesni_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct aesni_xts_ctx *ctx = aes_xts_ctx(tfm);
 	int err;
 
 	err = xts_verify_key(tfm, key, keylen);
@@ -893,20 +892,20 @@ static int xts_aesni_setkey(struct crypto_skcipher *tfm, const u8 *key,
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
@@ -942,7 +941,7 @@ static int xts_crypt(struct skcipher_request *req, bool encrypt)
 	kernel_fpu_begin();
 
 	/* calculate first value of T */
-	aesni_enc(aes_ctx(ctx->raw_tweak_ctx), walk.iv, walk.iv);
+	aesni_enc(&ctx->tweak_ctx, walk.iv, walk.iv);
 
 	while (walk.nbytes > 0) {
 		int nbytes = walk.nbytes;
@@ -951,11 +950,11 @@ static int xts_crypt(struct skcipher_request *req, bool encrypt)
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
@@ -983,11 +982,11 @@ static int xts_crypt(struct skcipher_request *req, bool encrypt)
 
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

