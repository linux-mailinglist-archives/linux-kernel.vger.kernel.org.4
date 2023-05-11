Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9356FF9FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbjEKTRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238390AbjEKTRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:17:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E5110C9;
        Thu, 11 May 2023 12:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683832658; x=1715368658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=VnDYpLbdwkHbHTiIkvaDKqWVbA92KR68yRGTX7bS//Y=;
  b=WfQ1D0a393ZIo+I56QjuD1MMzsZB1nnrshOcgPOBekITNuTiBQJfKIyZ
   h/FT34GJC9HRNKD+QNyQbukl8mfRMzCqPzFes+P0BTrJIE0UQJhxQD85a
   cKZ/iEUNDq7wqMGqdFtnryssitlsCzVz8xRYmPwbzA6NQ707oGHelQbEZ
   mECTxV8l8FlfsDCjDVqVje2XAK3RkwPb5vbG5B/CrDs5ZO2TKxlsUcr3U
   rvZZ597AT00pQT/sshpcpX2aZbtULyklN5W5kQuRDbD0jLkQ7sHPlMhgv
   Vd000dMyLvvSogmuCn7RGhrJrX2PIcLBug3qDeJSO4LHyEmVq/u2OeqIZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="416225330"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="416225330"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 12:17:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="769493704"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="769493704"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2023 12:17:37 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com
Cc:     ebiggers@kernel.org, gmazyland@gmail.com, luto@kernel.org,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@kernel.org, x86@kernel.org, herbert@gondor.apana.org.au,
        ardb@kernel.org, dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com, chang.seok.bae@intel.com,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v6 10/12] crypto: x86/aes - Prepare for a new AES implementation
Date:   Thu, 11 May 2023 12:05:17 -0700
Message-Id: <20230511190517.10149-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <08da7a0a-6b66-2c0e-eb56-96b5ee8faa30@intel.com>
References: <08da7a0a-6b66-2c0e-eb56-96b5ee8faa30@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note, this only incorporates the fix for the performance issue. It is
intended for those who want to run the series quickly. Otherwise, please
ignore this. The next posting will address all the feedback.

---

Key Locker's AES instruction set ('AES-KL') has a similar programming
interface to AES-NI. The internal ABI in the assembly code will have the
same prototype as AES-NI. Then, the glue code will be the same as AES-NI's.

Refactor the common C code to avoid code duplication. The AES-NI code uses
it with a function pointer argument to call back the AES-NI assembly code.
So will the AES-KL code.

Introduce wrappers for data transformation functions to return an error
code. AES-KL may populate an error during data transformation.

Export those refactored functions and new wrappers that the AES-KL code
will reference.

Also move some constant values to a common assembly code.

No functional change intended.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v6:
* Inline the XTS helpers. Otherwise, measurable overhead is induced
  by indirect calls with the retpoline instrumentation. (Eric Biggers)
  Then, remove the glue helper .c file.

Changes from v5:
* Clean up the staled function definition -- cbc_crypt_common().
* Ensure kernel_fpu_end() for the possible error return from
  xts_crypt_common()->crypt1_fn().

Changes from v4:
* Drop CBC mode changes. (Eric Biggers)

Changes from v3:
* Drop ECB and CTR mode changes. (Eric Biggers)
* Export symbols. (Eric Biggers)

Changes from RFC v2:
* Massage the changelog. (Dan Williams)

Changes from RFC v1:
* Added as a new patch. (Ard Biesheuvel)
  Link: https://lore.kernel.org/lkml/CAMj1kXGa4f21eH0mdxd1pQsZMUjUr1Btq+Dgw-gC=O-yYft7xw@mail.gmail.com/
---
 arch/x86/crypto/aes-intel_asm.S    |  26 ++++
 arch/x86/crypto/aes-intel_glue.h   | 162 ++++++++++++++++++++
 arch/x86/crypto/aesni-intel_asm.S  |  58 +++----
 arch/x86/crypto/aesni-intel_glue.c | 235 +++++++++--------------------
 arch/x86/crypto/aesni-intel_glue.h |  17 +++
 5 files changed, 295 insertions(+), 203 deletions(-)
 create mode 100644 arch/x86/crypto/aes-intel_asm.S
 create mode 100644 arch/x86/crypto/aes-intel_glue.h
 create mode 100644 arch/x86/crypto/aesni-intel_glue.h

diff --git a/arch/x86/crypto/aes-intel_asm.S b/arch/x86/crypto/aes-intel_asm.S
new file mode 100644
index 000000000000..98abf875af79
--- /dev/null
+++ b/arch/x86/crypto/aes-intel_asm.S
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/*
+ * Constant values shared between AES implementations:
+ */
+
+.pushsection .rodata
+.align 16
+.Lcts_permute_table:
+	.byte		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
+	.byte		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
+	.byte		0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07
+	.byte		0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f
+	.byte		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
+	.byte		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
+#ifdef __x86_64__
+.Lbswap_mask:
+	.byte 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0
+#endif
+.popsection
+
+.section	.rodata.cst16.gf128mul_x_ble_mask, "aM", @progbits, 16
+.align 16
+.Lgf128mul_x_ble_mask:
+	.octa 0x00000000000000010000000000000087
+.previous
diff --git a/arch/x86/crypto/aes-intel_glue.h b/arch/x86/crypto/aes-intel_glue.h
new file mode 100644
index 000000000000..5877d0988e36
--- /dev/null
+++ b/arch/x86/crypto/aes-intel_glue.h
@@ -0,0 +1,162 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Shared glue code between AES implementations, refactored from the AES-NI's.
+ *
+ * The helper code is inlined for a performance reason. With the mitigation
+ * for speculative executions like retpoline, indirect calls become very
+ * expensive at a cost of measurable overhead.
+ */
+
+#ifndef _AES_INTEL_GLUE_H
+#define _AES_INTEL_GLUE_H
+
+#include <linux/err.h>
+#include <crypto/algapi.h>
+#include <crypto/aes.h>
+#include <crypto/xts.h>
+#include <crypto/scatterwalk.h>
+#include <crypto/internal/aead.h>
+#include <crypto/internal/simd.h>
+
+#define AES_ALIGN			16
+#define AES_ALIGN_ATTR			__attribute__((__aligned__(AES_ALIGN)))
+#define AES_BLOCK_MASK			(~(AES_BLOCK_SIZE - 1))
+#define AES_ALIGN_EXTRA			((AES_ALIGN - 1) & ~(CRYPTO_MINALIGN - 1))
+#define CRYPTO_AES_CTX_SIZE		(sizeof(struct crypto_aes_ctx) + AES_ALIGN_EXTRA)
+#define XTS_AES_CTX_SIZE		(sizeof(struct aes_xts_ctx) + AES_ALIGN_EXTRA)
+
+struct aes_xts_ctx {
+	struct crypto_aes_ctx tweak_ctx AES_ALIGN_ATTR;
+	struct crypto_aes_ctx crypt_ctx AES_ALIGN_ATTR;
+};
+
+static inline struct crypto_aes_ctx *aes_ctx(void *raw_ctx)
+{
+	unsigned long addr = (unsigned long)raw_ctx;
+	unsigned long align = AES_ALIGN;
+
+	if (align <= crypto_tfm_ctx_alignment())
+		align = 1;
+
+	return (struct crypto_aes_ctx *)ALIGN(addr, align);
+}
+
+static inline int
+xts_setkey_common(struct crypto_skcipher *tfm, const u8 *key, unsigned int keylen,
+		  int (*fn)(struct crypto_tfm *tfm, void *ctx, const u8 *in_key,
+			    unsigned int key_len))
+{
+	struct aes_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
+	int err;
+
+	err = xts_verify_key(tfm, key, keylen);
+	if (err)
+		return err;
+
+	keylen /= 2;
+
+	/* first half of xts-key is for crypt */
+	err = fn(crypto_skcipher_tfm(tfm), &ctx->crypt_ctx, key, keylen);
+	if (err)
+		return err;
+
+	/* second half of xts-key is for tweak */
+	return fn(crypto_skcipher_tfm(tfm), &ctx->tweak_ctx, key + keylen, keylen);
+}
+
+static inline int
+xts_crypt_common(struct skcipher_request *req,
+		 int (*crypt_fn)(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+				 unsigned int len, u8 *iv),
+		 int (*crypt1_fn)(const void *ctx, u8 *out, const u8 *in))
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct aes_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
+	int tail = req->cryptlen % AES_BLOCK_SIZE;
+	struct skcipher_request subreq;
+	struct skcipher_walk walk;
+	int err;
+
+	if (req->cryptlen < AES_BLOCK_SIZE)
+		return -EINVAL;
+
+	err = skcipher_walk_virt(&walk, req, false);
+	if (!walk.nbytes)
+		return err;
+
+	if (unlikely(tail > 0 && walk.nbytes < walk.total)) {
+		int blocks = DIV_ROUND_UP(req->cryptlen, AES_BLOCK_SIZE) - 2;
+
+		skcipher_walk_abort(&walk);
+
+		skcipher_request_set_tfm(&subreq, tfm);
+		skcipher_request_set_callback(&subreq,
+					      skcipher_request_flags(req),
+					      NULL, NULL);
+		skcipher_request_set_crypt(&subreq, req->src, req->dst,
+					   blocks * AES_BLOCK_SIZE, req->iv);
+		req = &subreq;
+
+		err = skcipher_walk_virt(&walk, req, false);
+		if (!walk.nbytes)
+			return err;
+	} else {
+		tail = 0;
+	}
+
+	kernel_fpu_begin();
+
+	/* calculate first value of T */
+	err = crypt1_fn(aes_ctx(&ctx->tweak_ctx), walk.iv, walk.iv);
+	if (err) {
+		kernel_fpu_end();
+		return err;
+	}
+
+	while (walk.nbytes > 0) {
+		int nbytes = walk.nbytes;
+
+		if (nbytes < walk.total)
+			nbytes &= ~(AES_BLOCK_SIZE - 1);
+
+		err = crypt_fn(aes_ctx(&ctx->crypt_ctx), walk.dst.virt.addr, walk.src.virt.addr,
+			       nbytes, walk.iv);
+		kernel_fpu_end();
+		if (err)
+			return err;
+
+		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
+
+		if (walk.nbytes > 0)
+			kernel_fpu_begin();
+	}
+
+	if (unlikely(tail > 0 && !err)) {
+		struct scatterlist sg_src[2], sg_dst[2];
+		struct scatterlist *src, *dst;
+
+		dst = src = scatterwalk_ffwd(sg_src, req->src, req->cryptlen);
+		if (req->dst != req->src)
+			dst = scatterwalk_ffwd(sg_dst, req->dst, req->cryptlen);
+
+		skcipher_request_set_crypt(req, src, dst, AES_BLOCK_SIZE + tail,
+					   req->iv);
+
+		err = skcipher_walk_virt(&walk, &subreq, false);
+		if (err)
+			return err;
+
+		kernel_fpu_begin();
+		err = crypt_fn(aes_ctx(&ctx->crypt_ctx), walk.dst.virt.addr, walk.src.virt.addr,
+			       walk.nbytes, walk.iv);
+		kernel_fpu_end();
+		if (err)
+			return err;
+
+		err = skcipher_walk_done(&walk, 0);
+	}
+	return err;
+}
+
+#endif /* _AES_INTEL_GLUE_H */
diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 837c1e0aa021..9ea4f13464d5 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -28,6 +28,7 @@
 #include <linux/linkage.h>
 #include <asm/frame.h>
 #include <asm/nospec-branch.h>
+#include "aes-intel_asm.S"
 
 /*
  * The following macros are used to move an (un)aligned 16 byte value to/from
@@ -1820,10 +1821,10 @@ SYM_FUNC_START_LOCAL(_key_expansion_256b)
 SYM_FUNC_END(_key_expansion_256b)
 
 /*
- * int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
- *                   unsigned int key_len)
+ * int _aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
+ *                    unsigned int key_len)
  */
-SYM_FUNC_START(aesni_set_key)
+SYM_FUNC_START(_aesni_set_key)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl KEYP
@@ -1932,12 +1933,12 @@ SYM_FUNC_START(aesni_set_key)
 #endif
 	FRAME_END
 	RET
-SYM_FUNC_END(aesni_set_key)
+SYM_FUNC_END(_aesni_set_key)
 
 /*
- * void aesni_enc(const void *ctx, u8 *dst, const u8 *src)
+ * void _aesni_enc(const void *ctx, u8 *dst, const u8 *src)
  */
-SYM_FUNC_START(aesni_enc)
+SYM_FUNC_START(_aesni_enc)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl KEYP
@@ -1956,7 +1957,7 @@ SYM_FUNC_START(aesni_enc)
 #endif
 	FRAME_END
 	RET
-SYM_FUNC_END(aesni_enc)
+SYM_FUNC_END(_aesni_enc)
 
 /*
  * _aesni_enc1:		internal ABI
@@ -2124,9 +2125,9 @@ SYM_FUNC_START_LOCAL(_aesni_enc4)
 SYM_FUNC_END(_aesni_enc4)
 
 /*
- * void aesni_dec (const void *ctx, u8 *dst, const u8 *src)
+ * void _aesni_dec (const void *ctx, u8 *dst, const u8 *src)
  */
-SYM_FUNC_START(aesni_dec)
+SYM_FUNC_START(_aesni_dec)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl KEYP
@@ -2146,7 +2147,7 @@ SYM_FUNC_START(aesni_dec)
 #endif
 	FRAME_END
 	RET
-SYM_FUNC_END(aesni_dec)
+SYM_FUNC_END(_aesni_dec)
 
 /*
  * _aesni_dec1:		internal ABI
@@ -2689,21 +2690,6 @@ SYM_FUNC_START(aesni_cts_cbc_dec)
 	RET
 SYM_FUNC_END(aesni_cts_cbc_dec)
 
-.pushsection .rodata
-.align 16
-.Lcts_permute_table:
-	.byte		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
-	.byte		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
-	.byte		0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07
-	.byte		0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f
-	.byte		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
-	.byte		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
-#ifdef __x86_64__
-.Lbswap_mask:
-	.byte 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0
-#endif
-.popsection
-
 #ifdef __x86_64__
 /*
  * _aesni_inc_init:	internal ABI
@@ -2819,12 +2805,6 @@ SYM_FUNC_END(aesni_ctr_enc)
 
 #endif
 
-.section	.rodata.cst16.gf128mul_x_ble_mask, "aM", @progbits, 16
-.align 16
-.Lgf128mul_x_ble_mask:
-	.octa 0x00000000000000010000000000000087
-.previous
-
 /*
  * _aesni_gf128mul_x_ble:		internal ABI
  *	Multiply in GF(2^128) for XTS IVs
@@ -2844,10 +2824,10 @@ SYM_FUNC_END(aesni_ctr_enc)
 	pxor KEY, IV;
 
 /*
- * void aesni_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *dst,
- *			  const u8 *src, unsigned int len, le128 *iv)
+ * void _aesni_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *dst,
+ *			   const u8 *src, unsigned int len, le128 *iv)
  */
-SYM_FUNC_START(aesni_xts_encrypt)
+SYM_FUNC_START(_aesni_xts_encrypt)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl IVP
@@ -2996,13 +2976,13 @@ SYM_FUNC_START(aesni_xts_encrypt)
 
 	movups STATE, (OUTP)
 	jmp .Lxts_enc_ret
-SYM_FUNC_END(aesni_xts_encrypt)
+SYM_FUNC_END(_aesni_xts_encrypt)
 
 /*
- * void aesni_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *dst,
- *			  const u8 *src, unsigned int len, le128 *iv)
+ * void _aesni_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *dst,
+ *			   const u8 *src, unsigned int len, le128 *iv)
  */
-SYM_FUNC_START(aesni_xts_decrypt)
+SYM_FUNC_START(_aesni_xts_decrypt)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl IVP
@@ -3158,4 +3138,4 @@ SYM_FUNC_START(aesni_xts_decrypt)
 
 	movups STATE, (OUTP)
 	jmp .Lxts_dec_ret
-SYM_FUNC_END(aesni_xts_decrypt)
+SYM_FUNC_END(_aesni_xts_decrypt)
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index a5b0cb3efeba..e7a9e8e01680 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -36,33 +36,24 @@
 #include <linux/spinlock.h>
 #include <linux/static_call.h>
 
+#include "aes-intel_glue.h"
+#include "aesni-intel_glue.h"
 
-#define AESNI_ALIGN	16
-#define AESNI_ALIGN_ATTR __attribute__ ((__aligned__(AESNI_ALIGN)))
-#define AES_BLOCK_MASK	(~(AES_BLOCK_SIZE - 1))
 #define RFC4106_HASH_SUBKEY_SIZE 16
-#define AESNI_ALIGN_EXTRA ((AESNI_ALIGN - 1) & ~(CRYPTO_MINALIGN - 1))
-#define CRYPTO_AES_CTX_SIZE (sizeof(struct crypto_aes_ctx) + AESNI_ALIGN_EXTRA)
-#define XTS_AES_CTX_SIZE (sizeof(struct aesni_xts_ctx) + AESNI_ALIGN_EXTRA)
 
 /* This data is stored at the end of the crypto_tfm struct.
  * It's a type of per "session" data storage location.
  * This needs to be 16 byte aligned.
  */
 struct aesni_rfc4106_gcm_ctx {
-	u8 hash_subkey[16] AESNI_ALIGN_ATTR;
-	struct crypto_aes_ctx aes_key_expanded AESNI_ALIGN_ATTR;
+	u8 hash_subkey[16] AES_ALIGN_ATTR;
+	struct crypto_aes_ctx aes_key_expanded AES_ALIGN_ATTR;
 	u8 nonce[4];
 };
 
 struct generic_gcmaes_ctx {
-	u8 hash_subkey[16] AESNI_ALIGN_ATTR;
-	struct crypto_aes_ctx aes_key_expanded AESNI_ALIGN_ATTR;
-};
-
-struct aesni_xts_ctx {
-	u8 raw_tweak_ctx[sizeof(struct crypto_aes_ctx)] AESNI_ALIGN_ATTR;
-	u8 raw_crypt_ctx[sizeof(struct crypto_aes_ctx)] AESNI_ALIGN_ATTR;
+	u8 hash_subkey[16] AES_ALIGN_ATTR;
+	struct crypto_aes_ctx aes_key_expanded AES_ALIGN_ATTR;
 };
 
 #define GCM_BLOCK_LEN 16
@@ -80,10 +71,10 @@ struct gcm_context_data {
 	u8 hash_keys[GCM_BLOCK_LEN * 16];
 };
 
-asmlinkage int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
-			     unsigned int key_len);
-asmlinkage void aesni_enc(const void *ctx, u8 *out, const u8 *in);
-asmlinkage void aesni_dec(const void *ctx, u8 *out, const u8 *in);
+asmlinkage int _aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
+			      unsigned int key_len);
+asmlinkage void _aesni_enc(const void *ctx, u8 *out, const u8 *in);
+asmlinkage void _aesni_dec(const void *ctx, u8 *out, const u8 *in);
 asmlinkage void aesni_ecb_enc(struct crypto_aes_ctx *ctx, u8 *out,
 			      const u8 *in, unsigned int len);
 asmlinkage void aesni_ecb_dec(struct crypto_aes_ctx *ctx, u8 *out,
@@ -97,14 +88,51 @@ asmlinkage void aesni_cts_cbc_enc(struct crypto_aes_ctx *ctx, u8 *out,
 asmlinkage void aesni_cts_cbc_dec(struct crypto_aes_ctx *ctx, u8 *out,
 				  const u8 *in, unsigned int len, u8 *iv);
 
+int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
+		  unsigned int key_len)
+{
+	return _aesni_set_key(ctx, in_key, key_len);
+}
+EXPORT_SYMBOL_GPL(aesni_set_key);
+
+int aesni_enc(const void *ctx, u8 *out, const u8 *in)
+{
+	_aesni_enc(ctx, out, in);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aesni_enc);
+
+int aesni_dec(const void *ctx, u8 *out, const u8 *in)
+{
+	_aesni_dec(ctx, out, in);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aesni_dec);
+
 #define AVX_GEN2_OPTSIZE 640
 #define AVX_GEN4_OPTSIZE 4096
 
-asmlinkage void aesni_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *out,
-				  const u8 *in, unsigned int len, u8 *iv);
+asmlinkage void _aesni_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *out,
+				   const u8 *in, unsigned int len, u8 *iv);
 
-asmlinkage void aesni_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *out,
-				  const u8 *in, unsigned int len, u8 *iv);
+asmlinkage void _aesni_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *out,
+				   const u8 *in, unsigned int len, u8 *iv);
+
+int aesni_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+		      unsigned int len, u8 *iv)
+{
+	_aesni_xts_encrypt(ctx, out, in, len, iv);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aesni_xts_encrypt);
+
+int aesni_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+		      unsigned int len, u8 *iv)
+{
+	_aesni_xts_decrypt(ctx, out, in, len, iv);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aesni_xts_decrypt);
 
 #ifdef CONFIG_X86_64
 
@@ -201,7 +229,7 @@ static __ro_after_init DEFINE_STATIC_KEY_FALSE(gcm_use_avx2);
 static inline struct
 aesni_rfc4106_gcm_ctx *aesni_rfc4106_gcm_ctx_get(struct crypto_aead *tfm)
 {
-	unsigned long align = AESNI_ALIGN;
+	unsigned long align = AES_ALIGN;
 
 	if (align <= crypto_tfm_ctx_alignment())
 		align = 1;
@@ -211,7 +239,7 @@ aesni_rfc4106_gcm_ctx *aesni_rfc4106_gcm_ctx_get(struct crypto_aead *tfm)
 static inline struct
 generic_gcmaes_ctx *generic_gcmaes_ctx_get(struct crypto_aead *tfm)
 {
-	unsigned long align = AESNI_ALIGN;
+	unsigned long align = AES_ALIGN;
 
 	if (align <= crypto_tfm_ctx_alignment())
 		align = 1;
@@ -219,16 +247,6 @@ generic_gcmaes_ctx *generic_gcmaes_ctx_get(struct crypto_aead *tfm)
 }
 #endif
 
-static inline struct crypto_aes_ctx *aes_ctx(void *raw_ctx)
-{
-	unsigned long addr = (unsigned long)raw_ctx;
-	unsigned long align = AESNI_ALIGN;
-
-	if (align <= crypto_tfm_ctx_alignment())
-		align = 1;
-	return (struct crypto_aes_ctx *)ALIGN(addr, align);
-}
-
 static int aes_set_key_common(struct crypto_tfm *tfm, void *raw_ctx,
 			      const u8 *in_key, unsigned int key_len)
 {
@@ -243,7 +261,7 @@ static int aes_set_key_common(struct crypto_tfm *tfm, void *raw_ctx,
 		err = aes_expandkey(ctx, in_key, key_len);
 	else {
 		kernel_fpu_begin();
-		err = aesni_set_key(ctx, in_key, key_len);
+		err = _aesni_set_key(ctx, in_key, key_len);
 		kernel_fpu_end();
 	}
 
@@ -264,7 +282,7 @@ static void aesni_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 		aes_encrypt(ctx, dst, src);
 	} else {
 		kernel_fpu_begin();
-		aesni_enc(ctx, dst, src);
+		_aesni_enc(ctx, dst, src);
 		kernel_fpu_end();
 	}
 }
@@ -277,7 +295,7 @@ static void aesni_decrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 		aes_decrypt(ctx, dst, src);
 	} else {
 		kernel_fpu_begin();
-		aesni_dec(ctx, dst, src);
+		_aesni_dec(ctx, dst, src);
 		kernel_fpu_end();
 	}
 }
@@ -491,7 +509,7 @@ static int cts_cbc_decrypt(struct skcipher_request *req)
 
 #ifdef CONFIG_X86_64
 static void aesni_ctr_enc_avx_tfm(struct crypto_aes_ctx *ctx, u8 *out,
-			      const u8 *in, unsigned int len, u8 *iv)
+				 const u8 *in, unsigned int len, u8 *iv)
 {
 	/*
 	 * based on key length, override with the by8 version
@@ -528,7 +546,7 @@ static int ctr_crypt(struct skcipher_request *req)
 		nbytes &= ~AES_BLOCK_MASK;
 
 		if (walk.nbytes == walk.total && nbytes > 0) {
-			aesni_enc(ctx, keystream, walk.iv);
+			_aesni_enc(ctx, keystream, walk.iv);
 			crypto_xor_cpy(walk.dst.virt.addr + walk.nbytes - nbytes,
 				       walk.src.virt.addr + walk.nbytes - nbytes,
 				       keystream, nbytes);
@@ -673,8 +691,8 @@ static int gcmaes_crypt_by_sg(bool enc, struct aead_request *req,
 			      u8 *iv, void *aes_ctx, u8 *auth_tag,
 			      unsigned long auth_tag_len)
 {
-	u8 databuf[sizeof(struct gcm_context_data) + (AESNI_ALIGN - 8)] __aligned(8);
-	struct gcm_context_data *data = PTR_ALIGN((void *)databuf, AESNI_ALIGN);
+	u8 databuf[sizeof(struct gcm_context_data) + (AES_ALIGN - 8)] __aligned(8);
+	struct gcm_context_data *data = PTR_ALIGN((void *)databuf, AES_ALIGN);
 	unsigned long left = req->cryptlen;
 	struct scatter_walk assoc_sg_walk;
 	struct skcipher_walk walk;
@@ -829,8 +847,8 @@ static int helper_rfc4106_encrypt(struct aead_request *req)
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct aesni_rfc4106_gcm_ctx *ctx = aesni_rfc4106_gcm_ctx_get(tfm);
 	void *aes_ctx = &(ctx->aes_key_expanded);
-	u8 ivbuf[16 + (AESNI_ALIGN - 8)] __aligned(8);
-	u8 *iv = PTR_ALIGN(&ivbuf[0], AESNI_ALIGN);
+	u8 ivbuf[16 + (AES_ALIGN - 8)] __aligned(8);
+	u8 *iv = PTR_ALIGN(&ivbuf[0], AES_ALIGN);
 	unsigned int i;
 	__be32 counter = cpu_to_be32(1);
 
@@ -857,8 +875,8 @@ static int helper_rfc4106_decrypt(struct aead_request *req)
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct aesni_rfc4106_gcm_ctx *ctx = aesni_rfc4106_gcm_ctx_get(tfm);
 	void *aes_ctx = &(ctx->aes_key_expanded);
-	u8 ivbuf[16 + (AESNI_ALIGN - 8)] __aligned(8);
-	u8 *iv = PTR_ALIGN(&ivbuf[0], AESNI_ALIGN);
+	u8 ivbuf[16 + (AES_ALIGN - 8)] __aligned(8);
+	u8 *iv = PTR_ALIGN(&ivbuf[0], AES_ALIGN);
 	unsigned int i;
 
 	if (unlikely(req->assoclen != 16 && req->assoclen != 20))
@@ -883,128 +901,17 @@ static int helper_rfc4106_decrypt(struct aead_request *req)
 static int xts_aesni_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			    unsigned int keylen)
 {
-	struct aesni_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
-	int err;
-
-	err = xts_verify_key(tfm, key, keylen);
-	if (err)
-		return err;
-
-	keylen /= 2;
-
-	/* first half of xts-key is for crypt */
-	err = aes_set_key_common(crypto_skcipher_tfm(tfm), ctx->raw_crypt_ctx,
-				 key, keylen);
-	if (err)
-		return err;
-
-	/* second half of xts-key is for tweak */
-	return aes_set_key_common(crypto_skcipher_tfm(tfm), ctx->raw_tweak_ctx,
-				  key + keylen, keylen);
-}
-
-static int xts_crypt(struct skcipher_request *req, bool encrypt)
-{
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct aesni_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
-	int tail = req->cryptlen % AES_BLOCK_SIZE;
-	struct skcipher_request subreq;
-	struct skcipher_walk walk;
-	int err;
-
-	if (req->cryptlen < AES_BLOCK_SIZE)
-		return -EINVAL;
-
-	err = skcipher_walk_virt(&walk, req, false);
-	if (!walk.nbytes)
-		return err;
-
-	if (unlikely(tail > 0 && walk.nbytes < walk.total)) {
-		int blocks = DIV_ROUND_UP(req->cryptlen, AES_BLOCK_SIZE) - 2;
-
-		skcipher_walk_abort(&walk);
-
-		skcipher_request_set_tfm(&subreq, tfm);
-		skcipher_request_set_callback(&subreq,
-					      skcipher_request_flags(req),
-					      NULL, NULL);
-		skcipher_request_set_crypt(&subreq, req->src, req->dst,
-					   blocks * AES_BLOCK_SIZE, req->iv);
-		req = &subreq;
-
-		err = skcipher_walk_virt(&walk, req, false);
-		if (!walk.nbytes)
-			return err;
-	} else {
-		tail = 0;
-	}
-
-	kernel_fpu_begin();
-
-	/* calculate first value of T */
-	aesni_enc(aes_ctx(ctx->raw_tweak_ctx), walk.iv, walk.iv);
-
-	while (walk.nbytes > 0) {
-		int nbytes = walk.nbytes;
-
-		if (nbytes < walk.total)
-			nbytes &= ~(AES_BLOCK_SIZE - 1);
-
-		if (encrypt)
-			aesni_xts_encrypt(aes_ctx(ctx->raw_crypt_ctx),
-					  walk.dst.virt.addr, walk.src.virt.addr,
-					  nbytes, walk.iv);
-		else
-			aesni_xts_decrypt(aes_ctx(ctx->raw_crypt_ctx),
-					  walk.dst.virt.addr, walk.src.virt.addr,
-					  nbytes, walk.iv);
-		kernel_fpu_end();
-
-		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
-
-		if (walk.nbytes > 0)
-			kernel_fpu_begin();
-	}
-
-	if (unlikely(tail > 0 && !err)) {
-		struct scatterlist sg_src[2], sg_dst[2];
-		struct scatterlist *src, *dst;
-
-		dst = src = scatterwalk_ffwd(sg_src, req->src, req->cryptlen);
-		if (req->dst != req->src)
-			dst = scatterwalk_ffwd(sg_dst, req->dst, req->cryptlen);
-
-		skcipher_request_set_crypt(req, src, dst, AES_BLOCK_SIZE + tail,
-					   req->iv);
-
-		err = skcipher_walk_virt(&walk, &subreq, false);
-		if (err)
-			return err;
-
-		kernel_fpu_begin();
-		if (encrypt)
-			aesni_xts_encrypt(aes_ctx(ctx->raw_crypt_ctx),
-					  walk.dst.virt.addr, walk.src.virt.addr,
-					  walk.nbytes, walk.iv);
-		else
-			aesni_xts_decrypt(aes_ctx(ctx->raw_crypt_ctx),
-					  walk.dst.virt.addr, walk.src.virt.addr,
-					  walk.nbytes, walk.iv);
-		kernel_fpu_end();
-
-		err = skcipher_walk_done(&walk, 0);
-	}
-	return err;
+	return xts_setkey_common(tfm, key, keylen, aes_set_key_common);
 }
 
 static int xts_encrypt(struct skcipher_request *req)
 {
-	return xts_crypt(req, true);
+	return xts_crypt_common(req, aesni_xts_encrypt, aesni_enc);
 }
 
 static int xts_decrypt(struct skcipher_request *req)
 {
-	return xts_crypt(req, false);
+	return xts_crypt_common(req, aesni_xts_decrypt, aesni_enc);
 }
 
 static struct crypto_alg aesni_cipher_alg = {
@@ -1160,8 +1067,8 @@ static int generic_gcmaes_encrypt(struct aead_request *req)
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct generic_gcmaes_ctx *ctx = generic_gcmaes_ctx_get(tfm);
 	void *aes_ctx = &(ctx->aes_key_expanded);
-	u8 ivbuf[16 + (AESNI_ALIGN - 8)] __aligned(8);
-	u8 *iv = PTR_ALIGN(&ivbuf[0], AESNI_ALIGN);
+	u8 ivbuf[16 + (AES_ALIGN - 8)] __aligned(8);
+	u8 *iv = PTR_ALIGN(&ivbuf[0], AES_ALIGN);
 	__be32 counter = cpu_to_be32(1);
 
 	memcpy(iv, req->iv, 12);
@@ -1177,8 +1084,8 @@ static int generic_gcmaes_decrypt(struct aead_request *req)
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct generic_gcmaes_ctx *ctx = generic_gcmaes_ctx_get(tfm);
 	void *aes_ctx = &(ctx->aes_key_expanded);
-	u8 ivbuf[16 + (AESNI_ALIGN - 8)] __aligned(8);
-	u8 *iv = PTR_ALIGN(&ivbuf[0], AESNI_ALIGN);
+	u8 ivbuf[16 + (AES_ALIGN - 8)] __aligned(8);
+	u8 *iv = PTR_ALIGN(&ivbuf[0], AES_ALIGN);
 
 	memcpy(iv, req->iv, 12);
 	*((__be32 *)(iv+12)) = counter;
diff --git a/arch/x86/crypto/aesni-intel_glue.h b/arch/x86/crypto/aesni-intel_glue.h
new file mode 100644
index 000000000000..81ecacb4e54c
--- /dev/null
+++ b/arch/x86/crypto/aesni-intel_glue.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Support for Intel AES-NI instructions. This file contains function
+ * prototypes to be referenced for other AES implementations
+ */
+
+int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key, unsigned int key_len);
+
+int aesni_enc(const void *ctx, u8 *out, const u8 *in);
+int aesni_dec(const void *ctx, u8 *out, const u8 *in);
+
+int aesni_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+		      unsigned int len, u8 *iv);
+int aesni_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+		      unsigned int len, u8 *iv);
+
-- 
2.17.1

