Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D376F1653
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345847AbjD1LDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345591AbjD1LCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:02:48 -0400
Received: from mail.nsr.re.kr (unknown [210.104.33.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2E54497
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 04:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; s=LIY0OQ3MUMW6182UNI14; d=nsr.re.kr; t=1682679656; c=relaxed/relaxed; h=date:from:message-id:mime-version:subject:to; bh=rvDCW46IuP5IGa7GKyZMigwgebE6hPESyLhIJOa7i3w=; b=gB1VFeCdgeREWF1eUP+9hb7kE7IwK/j73Vk4ASa+HNtPQkK9w9pVlMgHv+ZochtMd2vaFlP9NZBDgHYGZHeLJUA0VbJlOjcIOdcwjkrFLzl1ff0gtyI8ft6VDavIo0IWNBf/CJP3XBMZr/dptAObaSL6p8WMSStahIo157HtpC6zgOCI///SSDa1m4KZtjRkn1diUaCbnZ+VA5BT+2Tm2mrVNz1+ciuv+RmuGGj58G/LWWI6MzdRJjtwtxzOvg97xPgM/4nrr+S0yxxGTP9jWClbZOCr/e8mexBOtLx3wA4C03sLrKKBQAQYKQFaimSGevOCrYkIPFdlgNtFSQ8LQg==
Received: from 210.104.33.70 (nsr.re.kr)
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128 bits))
        by mail.nsr.re.kr with SMTP; Fri, 28 Apr 2023 19:59:39 +0900
Received: from 192.168.155.188 ([192.168.155.188])
          by mail.nsr.re.kr (Crinity Message Backbone-7.0.1) with SMTP ID 623;
          Fri, 28 Apr 2023 20:01:15 +0900 (KST)
From:   Dongsoo Lee <letrhee@nsr.re.kr>
To:     linux-crypto@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "David S. Miller" <abc@test.nsr.re.kr>,
        Dongsoo Lee <letrhee@gmail.com>,
        Dongsoo Lee <letrhee@nsr.re.kr>
Subject: [PATCH 3/3] crypto: LEA block cipher AVX2 optimization
Date:   Fri, 28 Apr 2023 20:00:58 +0900
Message-Id: <20230428110058.1516119-4-letrhee@nsr.re.kr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230428110058.1516119-1-letrhee@nsr.re.kr>
References: <20230428110058.1516119-1-letrhee@nsr.re.kr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the x86_64 environment, we use SSE2/MOVBE/AVX2 instructions. Since
LEA use four 32-bit unsigned integers for 128-bit block, the SSE2 and
AVX2 implementations encrypts four and eight blocks at a time for
optimization, respectively.

Our submission provides a optimized implementation of 4/8 block ECB, CBC
decryption, CTR, and XTS cipher operation modes on x86_64 CPUs
supporting AVX2.
The MOVBE instruction is used for optimizing the CTR mode.

Signed-off-by: Dongsoo Lee <letrhee@nsr.re.kr>
---
 arch/x86/crypto/Kconfig               |   22 +
 arch/x86/crypto/Makefile              |    3 +
 arch/x86/crypto/lea_avx2_glue.c       | 1112 +++++++++++++++++++++++++
 arch/x86/crypto/lea_avx2_x86_64-asm.S |  778 +++++++++++++++++
 4 files changed, 1915 insertions(+)
 create mode 100644 arch/x86/crypto/lea_avx2_glue.c
 create mode 100644 arch/x86/crypto/lea_avx2_x86_64-asm.S

diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
index 9bbfd01cfa2f..bc2620d9401a 100644
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -342,6 +342,28 @@ config CRYPTO_ARIA_GFNI_AVX512_X86_64
 
 	  Processes 64 blocks in parallel.
 
+config CRYPTO_LEA_AVX2
+	tristate "Ciphers: LEA with modes: ECB, CBC, CTR, XTS (SSE2/MOVBE/AVX2)"
+	select CRYPTO_LEA
+	imply CRYPTO_XTS
+	imply CRYPTO_CTR
+	help
+	  LEA cipher algorithm (KS X 3246, ISO/IEC 29192-2:2019)
+
+	  LEA is one of the standard cryptographic alorithms of
+	  the Republic of Korea. It consists of four 32bit word.
+
+	  See:
+	  https://seed.kisa.or.kr/kisa/algorithm/EgovLeaInfo.do
+
+	  Architecture: x86_64 using:
+	  - SSE2 (Streaming SIMD Extensions 2)
+	  - MOVBE (Move Data After Swapping Bytes)
+	  - AVX2 (Advanced Vector Extensions)
+
+	  Processes 4(SSE2), 8(AVX2) blocks in parallel.
+	  In CTR mode, the MOVBE instruction is utilized for improved performance.
+
 config CRYPTO_CHACHA20_X86_64
 	tristate "Ciphers: ChaCha20, XChaCha20, XChaCha12 (SSSE3/AVX2/AVX-512VL)"
 	depends on X86 && 64BIT
diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
index 9aa46093c91b..de23293b88df 100644
--- a/arch/x86/crypto/Makefile
+++ b/arch/x86/crypto/Makefile
@@ -109,6 +109,9 @@ aria-aesni-avx2-x86_64-y := aria-aesni-avx2-asm_64.o aria_aesni_avx2_glue.o
 obj-$(CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64) += aria-gfni-avx512-x86_64.o
 aria-gfni-avx512-x86_64-y := aria-gfni-avx512-asm_64.o aria_gfni_avx512_glue.o
 
+obj-$(CONFIG_CRYPTO_LEA_AVX2) += lea-avx2-x86_64.o
+lea-avx2-x86_64-y := lea_avx2_x86_64-asm.o lea_avx2_glue.o
+
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $< > $@
 $(obj)/%.S: $(src)/%.pl FORCE
diff --git a/arch/x86/crypto/lea_avx2_glue.c b/arch/x86/crypto/lea_avx2_glue.c
new file mode 100644
index 000000000000..532958d3caa5
--- /dev/null
+++ b/arch/x86/crypto/lea_avx2_glue.c
@@ -0,0 +1,1112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Glue Code for the SSE2/MOVBE/AVX2 assembler instructions for the LEA Cipher
+ *
+ * Copyright (c) 2023 National Security Research.
+ * Author: Dongsoo Lee <letrhee@nsr.re.kr>
+ */
+
+#include <asm/simd.h>
+#include <asm/unaligned.h>
+#include <crypto/algapi.h>
+#include <crypto/ctr.h>
+#include <crypto/internal/simd.h>
+#include <crypto/scatterwalk.h>
+#include <crypto/skcipher.h>
+#include <crypto/internal/skcipher.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+#include <crypto/lea.h>
+#include <crypto/xts.h>
+#include "ecb_cbc_helpers.h"
+
+#define SIMD_KEY_ALIGN 16
+#define SIMD_ALIGN_ATTR __aligned(SIMD_KEY_ALIGN)
+
+struct lea_xts_ctx {
+	u8 raw_crypt_ctx[sizeof(struct crypto_lea_ctx)] SIMD_ALIGN_ATTR;
+	u8 raw_tweak_ctx[sizeof(struct crypto_lea_ctx)] SIMD_ALIGN_ATTR;
+};
+
+#define LEA_AVX2_PARALLEL_BLOCKS 8
+#define LEA_SSE2_PARALLEL_BLOCKS 4
+
+asmlinkage void lea_avx2_ecb_enc_8way(const void *ctx, u8 *dst, const u8 *src);
+asmlinkage void lea_avx2_ecb_dec_8way(const void *ctx, u8 *dst, const u8 *src);
+asmlinkage void lea_avx2_ecb_enc_4way(const void *ctx, u8 *dst, const u8 *src);
+asmlinkage void lea_avx2_ecb_dec_4way(const void *ctx, u8 *dst, const u8 *src);
+
+asmlinkage void lea_avx2_cbc_dec_8way(const void *ctx, u8 *dst, const u8 *src);
+asmlinkage void lea_avx2_cbc_dec_4way(const void *ctx, u8 *dst, const u8 *src);
+
+asmlinkage void lea_avx2_ctr_enc_8way(const void *ctx, u8 *dst, const u8 *src,
+				u8 *ctr, u8 *buffer);
+asmlinkage void lea_avx2_ctr_enc_4way(const void *ctx, u8 *dst, const u8 *src,
+				u8 *ctr);
+
+asmlinkage void lea_avx2_xts_enc_8way(const void *ctx, u8 *dst, const u8 *src,
+				u8 *tweak);
+asmlinkage void lea_avx2_xts_dec_8way(const void *ctx, u8 *dst, const u8 *src,
+				u8 *tweak);
+asmlinkage void lea_avx2_xts_enc_4way(const void *ctx, u8 *dst, const u8 *src,
+				u8 *tweak);
+asmlinkage void lea_avx2_xts_dec_4way(const void *ctx, u8 *dst, const u8 *src,
+				u8 *tweak);
+asmlinkage void lea_avx2_xts_next_tweak_sse2(u8 *tweak_out, const u8 *tweak_in);
+
+static int ecb_encrypt_8way(struct skcipher_request *req)
+{
+	ECB_WALK_START(req, LEA_BLOCK_SIZE, LEA_SSE2_PARALLEL_BLOCKS);
+	ECB_BLOCK(LEA_AVX2_PARALLEL_BLOCKS, lea_avx2_ecb_enc_8way);
+	ECB_BLOCK(LEA_SSE2_PARALLEL_BLOCKS, lea_avx2_ecb_enc_4way);
+	ECB_BLOCK(1, lea_encrypt);
+	ECB_WALK_END();
+}
+
+static int ecb_decrypt_8way(struct skcipher_request *req)
+{
+	ECB_WALK_START(req, LEA_BLOCK_SIZE, LEA_SSE2_PARALLEL_BLOCKS);
+	ECB_BLOCK(LEA_AVX2_PARALLEL_BLOCKS, lea_avx2_ecb_dec_8way);
+	ECB_BLOCK(LEA_SSE2_PARALLEL_BLOCKS, lea_avx2_ecb_dec_4way);
+	ECB_BLOCK(1, lea_decrypt);
+	ECB_WALK_END();
+}
+
+static int ecb_encrypt_4way(struct skcipher_request *req)
+{
+	ECB_WALK_START(req, LEA_BLOCK_SIZE, LEA_SSE2_PARALLEL_BLOCKS);
+	ECB_BLOCK(LEA_SSE2_PARALLEL_BLOCKS, lea_avx2_ecb_enc_4way);
+	ECB_BLOCK(1, lea_encrypt);
+	ECB_WALK_END();
+}
+
+static int ecb_decrypt_4way(struct skcipher_request *req)
+{
+	ECB_WALK_START(req, LEA_BLOCK_SIZE, LEA_SSE2_PARALLEL_BLOCKS);
+	ECB_BLOCK(LEA_SSE2_PARALLEL_BLOCKS, lea_avx2_ecb_dec_4way);
+	ECB_BLOCK(1, lea_decrypt);
+	ECB_WALK_END();
+}
+
+static int cbc_encrypt(struct skcipher_request *req)
+{
+	CBC_WALK_START(req, LEA_BLOCK_SIZE, -1);
+	CBC_ENC_BLOCK(lea_encrypt);
+	CBC_WALK_END();
+}
+
+static int cbc_decrypt_8way(struct skcipher_request *req)
+{
+	CBC_WALK_START(req, LEA_BLOCK_SIZE, LEA_SSE2_PARALLEL_BLOCKS);
+	CBC_DEC_BLOCK(LEA_AVX2_PARALLEL_BLOCKS, lea_avx2_cbc_dec_8way);
+	CBC_DEC_BLOCK(LEA_SSE2_PARALLEL_BLOCKS, lea_avx2_cbc_dec_4way);
+	CBC_DEC_BLOCK(1, lea_decrypt);
+	CBC_WALK_END();
+}
+
+static int cbc_decrypt_4way(struct skcipher_request *req)
+{
+	CBC_WALK_START(req, LEA_BLOCK_SIZE, LEA_SSE2_PARALLEL_BLOCKS);
+	CBC_DEC_BLOCK(LEA_SSE2_PARALLEL_BLOCKS, lea_avx2_cbc_dec_4way);
+	CBC_DEC_BLOCK(1, lea_decrypt);
+	CBC_WALK_END();
+}
+
+struct _lea_u128 {
+	u64 v0, v1;
+};
+
+static inline void xor_1blk(u8 *out, const u8 *in1, const u8 *in2)
+{
+	const struct _lea_u128 *_in1 = (const struct _lea_u128 *)in1;
+	const struct _lea_u128 *_in2 = (const struct _lea_u128 *)in2;
+	struct _lea_u128 *_out = (struct _lea_u128 *)out;
+
+	_out->v0 = _in1->v0 ^ _in2->v0;
+	_out->v1 = _in1->v1 ^ _in2->v1;
+}
+
+static inline void xts_next_tweak(u8 *out, const u8 *in)
+{
+	const u64 *_in = (const u64 *)in;
+	u64 *_out = (u64 *)out;
+	u64 v0 = _in[0];
+	u64 v1 = _in[1];
+	u64 carry = (u64)(((s64)v1) >> 63);
+
+	v1 = (v1 << 1) ^ (v0 >> 63);
+	v0 = (v0 << 1) ^ ((u64)carry & 0x87);
+
+	_out[0] = v0;
+	_out[1] = v1;
+}
+
+static int xts_encrypt_8way(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct crypto_tfm *tfm_ctx = crypto_skcipher_ctx(tfm);
+	struct lea_xts_ctx *ctx = crypto_tfm_ctx(tfm_ctx);
+	struct skcipher_request subreq;
+	struct skcipher_walk walk;
+
+	int ret;
+	u32 nblocks;
+	u32 tail = req->cryptlen % LEA_BLOCK_SIZE;
+	u32 edge_tail = 0;
+
+	if (req->cryptlen < LEA_BLOCK_SIZE)
+		return -EINVAL;
+
+	ret = skcipher_walk_virt(&walk, req, false);
+	if (ret)
+		return ret;
+
+	if (unlikely(tail != 0 && walk.nbytes < walk.total)) {
+		u32 req_len = req->cryptlen - LEA_BLOCK_SIZE - tail;
+
+		skcipher_walk_abort(&walk);
+
+		skcipher_request_set_tfm(&subreq, tfm);
+		skcipher_request_set_callback(
+			&subreq, skcipher_request_flags(req), NULL, NULL);
+		skcipher_request_set_crypt(&subreq, req->src, req->dst, req_len,
+					req->iv);
+		req = &subreq;
+		ret = skcipher_walk_virt(&walk, req, false);
+		if (ret)
+			return ret;
+		edge_tail = tail;
+		tail = 0;
+	}
+
+	lea_encrypt(ctx->raw_tweak_ctx, walk.iv, walk.iv);
+
+	while ((nblocks = walk.nbytes / LEA_BLOCK_SIZE) > 0) {
+		u32 nbytes = walk.nbytes;
+		const u8 *src = walk.src.virt.addr;
+		u8 *dst = walk.dst.virt.addr;
+		bool is_tail = tail != 0 &&
+				(nblocks + 1) * LEA_BLOCK_SIZE > walk.total;
+
+		if (unlikely(is_tail))
+			nblocks -= 1;
+
+		kernel_fpu_begin();
+
+		for (; nblocks >= LEA_AVX2_PARALLEL_BLOCKS;
+			nblocks -= LEA_AVX2_PARALLEL_BLOCKS) {
+			lea_avx2_xts_enc_8way(ctx->raw_crypt_ctx, dst, src, walk.iv);
+			src += LEA_AVX2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+			dst += LEA_AVX2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+			nbytes -= LEA_AVX2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+		}
+
+		for (; nblocks >= LEA_SSE2_PARALLEL_BLOCKS;
+			nblocks -= LEA_SSE2_PARALLEL_BLOCKS) {
+			lea_avx2_xts_enc_4way(ctx->raw_crypt_ctx, dst, src, walk.iv);
+			src += LEA_SSE2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+			dst += LEA_SSE2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+			nbytes -= LEA_SSE2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+		}
+
+		for (; nblocks > 0; nblocks -= 1) {
+			u8 __aligned(16) buffer[LEA_BLOCK_SIZE];
+
+			xor_1blk(buffer, walk.iv, src);
+			lea_encrypt(ctx->raw_crypt_ctx, buffer,
+						buffer);
+			xor_1blk(dst, walk.iv, buffer);
+			xts_next_tweak(walk.iv, walk.iv);
+
+			src += LEA_BLOCK_SIZE;
+			dst += LEA_BLOCK_SIZE;
+			nbytes -= LEA_BLOCK_SIZE;
+		}
+
+		if (unlikely(is_tail)) {
+			u8 __aligned(16) buffer[LEA_BLOCK_SIZE];
+
+			xor_1blk(buffer, walk.iv, src);
+			lea_encrypt(ctx->raw_crypt_ctx, buffer,
+						buffer);
+			xor_1blk(buffer, walk.iv, buffer);
+
+			memcpy(dst, buffer, LEA_BLOCK_SIZE);
+			memcpy(buffer, src + LEA_BLOCK_SIZE, tail);
+			memcpy(dst + LEA_BLOCK_SIZE, dst, tail);
+
+			xts_next_tweak(walk.iv, walk.iv);
+
+			xor_1blk(buffer, walk.iv, buffer);
+			lea_encrypt(ctx->raw_crypt_ctx, buffer,
+						buffer);
+			xor_1blk(dst, walk.iv, buffer);
+
+			nbytes -= LEA_BLOCK_SIZE + tail;
+
+			kernel_fpu_end();
+			return skcipher_walk_done(&walk, nbytes);
+		}
+
+		kernel_fpu_end();
+		ret = skcipher_walk_done(&walk, nbytes);
+		if (ret)
+			return ret;
+	}
+
+	if (unlikely(edge_tail != 0)) {
+		u8 __aligned(16) buffer[LEA_BLOCK_SIZE];
+		struct scatterlist sg_src[2];
+		struct scatterlist sg_dst[2];
+		struct scatterlist *scatter_src;
+		struct scatterlist *scatter_dst;
+		const u8 *src;
+		u8 *dst;
+
+		scatter_src = scatterwalk_ffwd(sg_src, req->src, req->cryptlen);
+		if (req->src == req->dst) {
+			scatter_dst = scatter_src;
+		} else {
+			scatter_dst = scatterwalk_ffwd(sg_dst, req->dst,
+							req->cryptlen);
+		}
+
+		skcipher_request_set_crypt(req, scatter_src, scatter_dst,
+					LEA_BLOCK_SIZE + edge_tail, req->iv);
+
+		ret = skcipher_walk_virt(&walk, req, false);
+
+		src = walk.src.virt.addr;
+		dst = walk.dst.virt.addr;
+
+		kernel_fpu_begin();
+
+		xor_1blk(buffer, walk.iv, src);
+		lea_encrypt(ctx->raw_crypt_ctx, buffer, buffer);
+		xor_1blk(buffer, walk.iv, buffer);
+
+		memcpy(dst, buffer, LEA_BLOCK_SIZE);
+		memcpy(buffer, src + LEA_BLOCK_SIZE, edge_tail);
+		memcpy(dst + LEA_BLOCK_SIZE, dst, edge_tail);
+
+		xts_next_tweak(walk.iv, walk.iv);
+
+		xor_1blk(buffer, walk.iv, buffer);
+		lea_encrypt(ctx->raw_crypt_ctx, buffer, buffer);
+		xor_1blk(dst, walk.iv, buffer);
+
+		kernel_fpu_end();
+		ret = skcipher_walk_done(&walk, 0);
+	}
+
+	return ret;
+}
+
+static int xts_decrypt_8way(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct crypto_tfm *tfm_ctx = crypto_skcipher_ctx(tfm);
+	struct lea_xts_ctx *ctx = crypto_tfm_ctx(tfm_ctx);
+	struct skcipher_request subreq;
+	struct skcipher_walk walk;
+
+	u8 __aligned(16) ntweak[16] = { 0, };
+	u8 __aligned(16) buffer[LEA_BLOCK_SIZE];
+
+	int ret;
+	u32 nblocks;
+	u32 tail = req->cryptlen % LEA_BLOCK_SIZE;
+	u32 edge_tail = 0;
+
+	if (req->cryptlen < LEA_BLOCK_SIZE)
+		return -EINVAL;
+
+	ret = skcipher_walk_virt(&walk, req, false);
+
+	if (ret)
+		return ret;
+
+	if (unlikely(tail != 0 && walk.nbytes < walk.total)) {
+		u32 req_len = req->cryptlen - LEA_BLOCK_SIZE - tail;
+
+		skcipher_walk_abort(&walk);
+
+		skcipher_request_set_tfm(&subreq, tfm);
+		skcipher_request_set_callback(
+			&subreq, skcipher_request_flags(req), NULL, NULL);
+		skcipher_request_set_crypt(&subreq, req->src, req->dst, req_len,
+					req->iv);
+		req = &subreq;
+		ret = skcipher_walk_virt(&walk, req, false);
+		if (ret)
+			return ret;
+
+		edge_tail = tail;
+		tail = 0;
+	}
+
+	lea_encrypt(ctx->raw_tweak_ctx, walk.iv, walk.iv);
+
+	while ((nblocks = walk.nbytes / LEA_BLOCK_SIZE) > 0) {
+		u32 nbytes = walk.nbytes;
+		const u8 *src = walk.src.virt.addr;
+		u8 *dst = walk.dst.virt.addr;
+		bool is_tail = tail != 0 &&
+				(nblocks + 1) * LEA_BLOCK_SIZE > walk.total;
+
+		if (unlikely(is_tail))
+			nblocks -= 1;
+
+		kernel_fpu_begin();
+
+		for (; nblocks >= LEA_AVX2_PARALLEL_BLOCKS;
+			nblocks -= LEA_AVX2_PARALLEL_BLOCKS) {
+			lea_avx2_xts_dec_8way(ctx->raw_crypt_ctx, dst, src, walk.iv);
+			src += LEA_AVX2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+			dst += LEA_AVX2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+			nbytes -= LEA_AVX2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+		}
+
+		for (; nblocks >= LEA_SSE2_PARALLEL_BLOCKS;
+			nblocks -= LEA_SSE2_PARALLEL_BLOCKS) {
+			lea_avx2_xts_dec_4way(ctx->raw_crypt_ctx, dst, src, walk.iv);
+			src += LEA_SSE2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+			dst += LEA_SSE2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+			nbytes -= LEA_SSE2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+		}
+
+		for (; nblocks > 0; nblocks -= 1) {
+			xor_1blk(buffer, walk.iv, src);
+			lea_decrypt(ctx->raw_crypt_ctx, buffer,
+						buffer);
+			xor_1blk(dst, walk.iv, buffer);
+			xts_next_tweak(walk.iv, walk.iv);
+
+			src += LEA_BLOCK_SIZE;
+			dst += LEA_BLOCK_SIZE;
+			nbytes -= LEA_BLOCK_SIZE;
+		}
+
+		if (unlikely(is_tail)) {
+			memcpy(ntweak, walk.iv, LEA_BLOCK_SIZE);
+			xts_next_tweak(walk.iv, ntweak);
+
+			xor_1blk(buffer, walk.iv, src);
+			lea_decrypt(ctx->raw_crypt_ctx, buffer,
+						buffer);
+			xor_1blk(buffer, walk.iv, buffer);
+
+			memcpy(dst, buffer, LEA_BLOCK_SIZE);
+
+			memcpy(buffer, src + 16, tail);
+			memcpy(dst + 16, dst, tail);
+
+			xor_1blk(buffer, ntweak, buffer);
+			lea_decrypt(ctx->raw_crypt_ctx, buffer,
+						buffer);
+			xor_1blk(dst, ntweak, buffer);
+
+			nbytes -= LEA_BLOCK_SIZE + tail;
+
+			kernel_fpu_end();
+			return skcipher_walk_done(&walk, nbytes);
+		}
+
+		kernel_fpu_end();
+
+		ret = skcipher_walk_done(&walk, nbytes);
+		if (ret)
+			return ret;
+	}
+
+	if (unlikely(edge_tail != 0)) {
+		struct scatterlist sg_src[2];
+		struct scatterlist sg_dst[2];
+		struct scatterlist *scatter_src;
+		struct scatterlist *scatter_dst;
+		const u8 *src;
+		u8 *dst;
+
+		scatter_src = scatterwalk_ffwd(sg_src, req->src, req->cryptlen);
+		if (req->src == req->dst) {
+			scatter_dst = scatter_src;
+		} else {
+			scatter_dst = scatterwalk_ffwd(sg_dst, req->dst,
+							req->cryptlen);
+		}
+
+		skcipher_request_set_crypt(req, scatter_src, scatter_dst,
+					LEA_BLOCK_SIZE + edge_tail, req->iv);
+
+		ret = skcipher_walk_virt(&walk, req, false);
+
+		src = walk.src.virt.addr;
+		dst = walk.dst.virt.addr;
+
+		kernel_fpu_begin();
+
+		memcpy(ntweak, walk.iv, LEA_BLOCK_SIZE);
+		xts_next_tweak(walk.iv, ntweak);
+
+		xor_1blk(buffer, walk.iv, src);
+		lea_decrypt(ctx->raw_crypt_ctx, buffer, buffer);
+		xor_1blk(buffer, walk.iv, buffer);
+
+		memcpy(dst, buffer, LEA_BLOCK_SIZE);
+
+		memcpy(buffer, src + 16, edge_tail);
+		memcpy(dst + 16, dst, edge_tail);
+
+		xor_1blk(buffer, ntweak, buffer);
+		lea_decrypt(ctx->raw_crypt_ctx, buffer, buffer);
+		xor_1blk(dst, ntweak, buffer);
+
+		kernel_fpu_end();
+		ret = skcipher_walk_done(&walk, 0);
+	}
+
+	return ret;
+}
+
+static int ctr_encrypt_4way(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct crypto_lea_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
+
+	u8 __aligned(16) buffer[LEA_BLOCK_SIZE];
+
+	int ret;
+
+	ret = skcipher_walk_virt(&walk, req, false);
+	if (ret)
+		return ret;
+
+	while (walk.nbytes > 0) {
+		u32 nbytes = walk.nbytes;
+		const u8 *src = walk.src.virt.addr;
+		u8 *dst = walk.dst.virt.addr;
+
+		kernel_fpu_begin();
+
+		while (nbytes >= LEA_SSE2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE) {
+			lea_avx2_ctr_enc_4way(ctx, dst, src, walk.iv);
+			src += LEA_SSE2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+			dst += LEA_SSE2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+			nbytes -= LEA_SSE2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+		}
+
+		while (nbytes >= LEA_BLOCK_SIZE) {
+			lea_encrypt(ctx, buffer, walk.iv);
+			xor_1blk(dst, buffer, src);
+			crypto_inc(walk.iv, LEA_BLOCK_SIZE);
+
+			src += LEA_BLOCK_SIZE;
+			dst += LEA_BLOCK_SIZE;
+			nbytes -= LEA_BLOCK_SIZE;
+		}
+
+		if (unlikely(walk.nbytes == walk.total && nbytes != 0)) {
+			lea_encrypt(ctx, buffer, walk.iv);
+			crypto_xor_cpy(dst, src, buffer, nbytes);
+			crypto_inc(walk.iv, LEA_BLOCK_SIZE);
+
+			nbytes = 0;
+		}
+
+		kernel_fpu_end();
+		ret = skcipher_walk_done(&walk, nbytes);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+static int ctr_encrypt_8way(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct crypto_lea_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
+
+	u8 __aligned(32) buffer[LEA_BLOCK_SIZE * LEA_AVX2_PARALLEL_BLOCKS];
+
+	int ret;
+
+	ret = skcipher_walk_virt(&walk, req, false);
+	if (ret)
+		return ret;
+
+	while (walk.nbytes > 0) {
+		u32 nbytes = walk.nbytes;
+		const u8 *src = walk.src.virt.addr;
+		u8 *dst = walk.dst.virt.addr;
+
+		kernel_fpu_begin();
+
+		while (nbytes >= LEA_AVX2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE) {
+			lea_avx2_ctr_enc_8way(ctx, dst, src, walk.iv, buffer);
+			src += LEA_AVX2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+			dst += LEA_AVX2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+			nbytes -= LEA_AVX2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+		}
+
+		while (nbytes >= LEA_SSE2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE) {
+			lea_avx2_ctr_enc_4way(ctx, dst, src, walk.iv);
+			src += LEA_SSE2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+			dst += LEA_SSE2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+			nbytes -= LEA_SSE2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+		}
+
+		while (nbytes >= LEA_BLOCK_SIZE) {
+			lea_encrypt(ctx, buffer, walk.iv);
+			xor_1blk(dst, buffer, src);
+			crypto_inc(walk.iv, LEA_BLOCK_SIZE);
+
+			src += LEA_BLOCK_SIZE;
+			dst += LEA_BLOCK_SIZE;
+			nbytes -= LEA_BLOCK_SIZE;
+		}
+
+		if (unlikely(walk.nbytes == walk.total && nbytes != 0)) {
+			lea_encrypt(ctx, buffer, walk.iv);
+			crypto_xor_cpy(dst, src, buffer, nbytes);
+			crypto_inc(walk.iv, LEA_BLOCK_SIZE);
+
+			nbytes = 0;
+		}
+
+		kernel_fpu_end();
+		ret = skcipher_walk_done(&walk, nbytes);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+static int xts_encrypt_4way(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct crypto_tfm *tfm_ctx = crypto_skcipher_ctx(tfm);
+	struct lea_xts_ctx *ctx = crypto_tfm_ctx(tfm_ctx);
+	struct skcipher_request subreq;
+	struct skcipher_walk walk;
+
+	u8 __aligned(16) buffer[LEA_BLOCK_SIZE];
+
+	int ret;
+	u32 nblocks;
+	u32 tail = req->cryptlen % LEA_BLOCK_SIZE;
+	u32 edge_tail = 0;
+
+	if (req->cryptlen < LEA_BLOCK_SIZE)
+		return -EINVAL;
+
+	ret = skcipher_walk_virt(&walk, req, false);
+	if (ret)
+		return ret;
+
+	if (unlikely(tail != 0 && walk.nbytes < walk.total)) {
+		u32 req_len = req->cryptlen - LEA_BLOCK_SIZE - tail;
+
+		skcipher_walk_abort(&walk);
+
+		skcipher_request_set_tfm(&subreq, tfm);
+		skcipher_request_set_callback(
+			&subreq, skcipher_request_flags(req), NULL, NULL);
+		skcipher_request_set_crypt(&subreq, req->src, req->dst, req_len,
+					req->iv);
+		req = &subreq;
+		ret = skcipher_walk_virt(&walk, req, false);
+		if (ret)
+			return ret;
+
+		edge_tail = tail;
+		tail = 0;
+	}
+
+	lea_encrypt(ctx->raw_tweak_ctx, walk.iv, walk.iv);
+
+	while ((nblocks = walk.nbytes / LEA_BLOCK_SIZE) > 0) {
+		u32 nbytes = walk.nbytes;
+		const u8 *src = walk.src.virt.addr;
+		u8 *dst = walk.dst.virt.addr;
+		bool is_tail = tail != 0 &&
+				(nblocks + 1) * LEA_BLOCK_SIZE > walk.total;
+
+		if (unlikely(is_tail))
+			nblocks -= 1;
+
+		kernel_fpu_begin();
+
+		for (; nblocks >= LEA_SSE2_PARALLEL_BLOCKS;
+			nblocks -= LEA_SSE2_PARALLEL_BLOCKS) {
+			lea_avx2_xts_enc_4way(ctx->raw_crypt_ctx, dst, src, walk.iv);
+			src += LEA_SSE2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+			dst += LEA_SSE2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+			nbytes -= LEA_SSE2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+		}
+
+		for (; nblocks > 0; nblocks -= 1) {
+
+			xor_1blk(buffer, walk.iv, src);
+			lea_encrypt(ctx->raw_crypt_ctx, buffer,
+						buffer);
+			xor_1blk(dst, walk.iv, buffer);
+			xts_next_tweak(walk.iv, walk.iv);
+
+			src += LEA_BLOCK_SIZE;
+			dst += LEA_BLOCK_SIZE;
+			nbytes -= LEA_BLOCK_SIZE;
+		}
+
+		if (unlikely(is_tail)) {
+			xor_1blk(buffer, walk.iv, src);
+			lea_encrypt(ctx->raw_crypt_ctx, buffer,
+						buffer);
+			xor_1blk(buffer, walk.iv, buffer);
+
+			memcpy(dst, buffer, LEA_BLOCK_SIZE);
+			memcpy(buffer, src + LEA_BLOCK_SIZE, tail);
+			memcpy(dst + LEA_BLOCK_SIZE, dst, tail);
+
+			xts_next_tweak(walk.iv, walk.iv);
+
+			xor_1blk(buffer, walk.iv, buffer);
+			lea_encrypt(ctx->raw_crypt_ctx, buffer,
+						buffer);
+			xor_1blk(dst, walk.iv, buffer);
+
+			nbytes -= LEA_BLOCK_SIZE + tail;
+
+			kernel_fpu_end();
+			return skcipher_walk_done(&walk, nbytes);
+		}
+
+		kernel_fpu_end();
+		ret = skcipher_walk_done(&walk, nbytes);
+		if (ret)
+			return ret;
+	}
+
+	if (unlikely(edge_tail != 0)) {
+		struct scatterlist sg_src[2];
+		struct scatterlist sg_dst[2];
+		struct scatterlist *scatter_src;
+		struct scatterlist *scatter_dst;
+		const u8 *src;
+		u8 *dst;
+
+		scatter_src = scatterwalk_ffwd(sg_src, req->src, req->cryptlen);
+		if (req->src == req->dst) {
+			scatter_dst = scatter_src;
+		} else {
+			scatter_dst = scatterwalk_ffwd(sg_dst, req->dst,
+								req->cryptlen);
+		}
+
+		skcipher_request_set_crypt(req, scatter_src, scatter_dst,
+					LEA_BLOCK_SIZE + edge_tail, req->iv);
+
+		ret = skcipher_walk_virt(&walk, req, false);
+
+		src = walk.src.virt.addr;
+		dst = walk.dst.virt.addr;
+
+		kernel_fpu_begin();
+
+		xor_1blk(buffer, walk.iv, src);
+		lea_encrypt(ctx->raw_crypt_ctx, buffer, buffer);
+		xor_1blk(buffer, walk.iv, buffer);
+
+		memcpy(dst, buffer, LEA_BLOCK_SIZE);
+		memcpy(buffer, src + LEA_BLOCK_SIZE, edge_tail);
+		memcpy(dst + LEA_BLOCK_SIZE, dst, edge_tail);
+
+		xts_next_tweak(walk.iv, walk.iv);
+
+		xor_1blk(buffer, walk.iv, buffer);
+		lea_encrypt(ctx->raw_crypt_ctx, buffer, buffer);
+		xor_1blk(dst, walk.iv, buffer);
+
+		kernel_fpu_end();
+
+		ret = skcipher_walk_done(&walk, 0);
+	}
+
+	return ret;
+}
+
+static int xts_decrypt_4way(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct crypto_tfm *tfm_ctx = crypto_skcipher_ctx(tfm);
+	struct lea_xts_ctx *ctx = crypto_tfm_ctx(tfm_ctx);
+	struct skcipher_request subreq;
+	struct skcipher_walk walk;
+
+	int ret;
+	u32 nblocks;
+	u32 tail = req->cryptlen % LEA_BLOCK_SIZE;
+	u32 edge_tail = 0;
+
+	if (req->cryptlen < LEA_BLOCK_SIZE)
+		return -EINVAL;
+
+	ret = skcipher_walk_virt(&walk, req, false);
+	if (ret)
+		return ret;
+
+	if (unlikely(tail != 0 && walk.nbytes < walk.total)) {
+		u32 req_len = req->cryptlen - LEA_BLOCK_SIZE - tail;
+
+		skcipher_walk_abort(&walk);
+
+		skcipher_request_set_tfm(&subreq, tfm);
+		skcipher_request_set_callback(
+			&subreq, skcipher_request_flags(req), NULL, NULL);
+		skcipher_request_set_crypt(&subreq, req->src, req->dst, req_len,
+					req->iv);
+		req = &subreq;
+		ret = skcipher_walk_virt(&walk, req, false);
+		if (ret)
+			return ret;
+
+		edge_tail = tail;
+		tail = 0;
+	}
+
+	lea_encrypt(ctx->raw_tweak_ctx, walk.iv, walk.iv);
+
+	while ((nblocks = walk.nbytes / LEA_BLOCK_SIZE) > 0) {
+		u32 nbytes = walk.nbytes;
+		const u8 *src = walk.src.virt.addr;
+		u8 *dst = walk.dst.virt.addr;
+		bool is_tail = tail != 0 &&
+			(nblocks + 1) * LEA_BLOCK_SIZE > walk.total;
+
+		if (unlikely(is_tail))
+			nblocks -= 1;
+
+		kernel_fpu_begin();
+
+		for (; nblocks >= LEA_SSE2_PARALLEL_BLOCKS;
+			nblocks -= LEA_SSE2_PARALLEL_BLOCKS) {
+			lea_avx2_xts_dec_4way(ctx->raw_crypt_ctx, dst, src, walk.iv);
+			src += LEA_SSE2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+			dst += LEA_SSE2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+			nbytes -= LEA_SSE2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE;
+		}
+
+		for (; nblocks > 0; nblocks -= 1) {
+			u8 __aligned(16) buffer[LEA_BLOCK_SIZE];
+
+			xor_1blk(buffer, walk.iv, src);
+			lea_decrypt(ctx->raw_crypt_ctx, buffer,
+						buffer);
+			xor_1blk(dst, walk.iv, buffer);
+			xts_next_tweak(walk.iv, walk.iv);
+
+			src += LEA_BLOCK_SIZE;
+			dst += LEA_BLOCK_SIZE;
+			nbytes -= LEA_BLOCK_SIZE;
+		}
+
+		if (unlikely(is_tail)) {
+			u8 __aligned(16) ntweak[16] = {
+				0,
+			};
+			u8 __aligned(16) buffer[LEA_BLOCK_SIZE];
+
+			memcpy(ntweak, walk.iv, LEA_BLOCK_SIZE);
+			xts_next_tweak(walk.iv, ntweak);
+
+			xor_1blk(buffer, walk.iv, src);
+			lea_decrypt(ctx->raw_crypt_ctx, buffer,
+						buffer);
+			xor_1blk(buffer, walk.iv, buffer);
+
+			memcpy(dst, buffer, LEA_BLOCK_SIZE);
+
+			memcpy(buffer, src + 16, tail);
+			memcpy(dst + 16, dst, tail);
+
+			xor_1blk(buffer, ntweak, buffer);
+			lea_decrypt(ctx->raw_crypt_ctx, buffer,
+						buffer);
+			xor_1blk(dst, ntweak, buffer);
+
+			nbytes -= LEA_BLOCK_SIZE + tail;
+
+			kernel_fpu_end();
+			return skcipher_walk_done(&walk, nbytes);
+		}
+
+		kernel_fpu_end();
+		ret = skcipher_walk_done(&walk, nbytes);
+		if (ret)
+			return ret;
+	}
+
+	if (unlikely(edge_tail != 0)) {
+		u8 __aligned(16) ntweak[16] = {
+			0,
+		};
+		u8 __aligned(16) buffer[LEA_BLOCK_SIZE];
+		struct scatterlist sg_src[2];
+		struct scatterlist sg_dst[2];
+		struct scatterlist *scatter_src;
+		struct scatterlist *scatter_dst;
+		const u8 *src;
+		u8 *dst;
+
+		scatter_src = scatterwalk_ffwd(sg_src, req->src, req->cryptlen);
+		if (req->src == req->dst) {
+			scatter_dst = scatter_src;
+		} else {
+			scatter_dst = scatterwalk_ffwd(sg_dst, req->dst,
+							req->cryptlen);
+		}
+
+		skcipher_request_set_crypt(req, scatter_src, scatter_dst,
+					LEA_BLOCK_SIZE + edge_tail, req->iv);
+
+		ret = skcipher_walk_virt(&walk, req, false);
+
+		src = walk.src.virt.addr;
+		dst = walk.dst.virt.addr;
+
+		kernel_fpu_begin();
+
+		memcpy(ntweak, walk.iv, LEA_BLOCK_SIZE);
+		xts_next_tweak(walk.iv, ntweak);
+
+		xor_1blk(buffer, walk.iv, src);
+		lea_decrypt(ctx->raw_crypt_ctx, buffer, buffer);
+		xor_1blk(buffer, walk.iv, buffer);
+
+		memcpy(dst, buffer, LEA_BLOCK_SIZE);
+
+		memcpy(buffer, src + 16, edge_tail);
+		memcpy(dst + 16, dst, edge_tail);
+
+		xor_1blk(buffer, ntweak, buffer);
+		lea_decrypt(ctx->raw_crypt_ctx, buffer, buffer);
+		xor_1blk(dst, ntweak, buffer);
+
+		kernel_fpu_end();
+		ret = skcipher_walk_done(&walk, 0);
+	}
+
+	return ret;
+}
+
+static int xts_lea_set_key(struct crypto_skcipher *tfm, const u8 *key,
+				u32 keylen)
+{
+	struct crypto_tfm *tfm_ctx = crypto_skcipher_ctx(tfm);
+	struct lea_xts_ctx *ctx = crypto_tfm_ctx(tfm_ctx);
+
+	struct crypto_lea_ctx *crypt_key =
+		(struct crypto_lea_ctx *)(ctx->raw_crypt_ctx);
+	struct crypto_lea_ctx *tweak_key =
+		(struct crypto_lea_ctx *)(ctx->raw_tweak_ctx);
+
+	int result;
+
+	result = xts_verify_key(tfm, key, keylen);
+	if (result)
+		return result;
+
+	result = lea_set_key(crypt_key, key, keylen / 2);
+
+	if (result)
+		return result;
+
+	return lea_set_key(tweak_key, key + (keylen / 2), keylen / 2);
+}
+
+static int _lea_set_key(struct crypto_skcipher *tfm, const u8 *key, u32 keylen)
+{
+	return lea_set_key(crypto_skcipher_ctx(tfm), key, keylen);
+}
+
+static struct skcipher_alg lea_simd_avx2_algs[] = {
+	{
+		.base.cra_name = "__ecb(lea)",
+		.base.cra_driver_name = "__ecb-lea-sse2",
+		.base.cra_priority = 300 - 1,
+		.base.cra_flags = CRYPTO_ALG_INTERNAL,
+		.base.cra_blocksize = LEA_BLOCK_SIZE,
+		.base.cra_ctxsize = sizeof(struct crypto_lea_ctx),
+		.base.cra_module = THIS_MODULE,
+		.min_keysize = LEA_MIN_KEY_SIZE,
+		.max_keysize = LEA_MAX_KEY_SIZE,
+		.walksize = LEA_SSE2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE,
+		.setkey = _lea_set_key,
+		.encrypt = ecb_encrypt_4way,
+		.decrypt = ecb_decrypt_4way,
+	},
+	{
+		.base.cra_name = "__cbc(lea)",
+		.base.cra_driver_name = "__cbc-lea-sse2",
+		.base.cra_priority = 300 - 1,
+		.base.cra_flags = CRYPTO_ALG_INTERNAL,
+		.base.cra_blocksize = LEA_BLOCK_SIZE,
+		.base.cra_ctxsize = sizeof(struct crypto_lea_ctx),
+		.base.cra_module = THIS_MODULE,
+		.min_keysize = LEA_MIN_KEY_SIZE,
+		.max_keysize = LEA_MAX_KEY_SIZE,
+		.walksize = LEA_SSE2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE,
+		.ivsize = LEA_BLOCK_SIZE,
+		.setkey = _lea_set_key,
+		.encrypt = cbc_encrypt,
+		.decrypt = cbc_decrypt_4way,
+	},
+	{
+		.base.cra_name = "__xts(lea)",
+		.base.cra_driver_name = "__xts-lea-sse2",
+		.base.cra_priority = 300 - 1,
+		.base.cra_flags = CRYPTO_ALG_INTERNAL,
+		.base.cra_blocksize = LEA_BLOCK_SIZE,
+		.base.cra_ctxsize = sizeof(struct lea_xts_ctx),
+		.base.cra_module = THIS_MODULE,
+		.min_keysize = LEA_MIN_KEY_SIZE * 2,
+		.max_keysize = LEA_MAX_KEY_SIZE * 2,
+		.walksize = LEA_SSE2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE,
+		.ivsize = LEA_BLOCK_SIZE,
+		.setkey = xts_lea_set_key,
+		.encrypt = xts_encrypt_4way,
+		.decrypt = xts_decrypt_4way,
+	},
+	{
+		.base.cra_name = "__ctr(lea)",
+		.base.cra_driver_name = "__ctr-lea-sse2",
+		.base.cra_priority = 300 - 1,
+		.base.cra_flags = CRYPTO_ALG_INTERNAL,
+		.base.cra_blocksize = 1,
+		.base.cra_ctxsize = sizeof(struct crypto_lea_ctx),
+		.base.cra_module = THIS_MODULE,
+		.min_keysize = LEA_MIN_KEY_SIZE,
+		.max_keysize = LEA_MAX_KEY_SIZE,
+		.chunksize = LEA_BLOCK_SIZE,
+		.walksize = LEA_SSE2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE,
+		.ivsize = LEA_BLOCK_SIZE,
+		.setkey = _lea_set_key,
+		.encrypt = ctr_encrypt_4way,
+		.decrypt = ctr_encrypt_4way,
+	},
+	{
+		.base.cra_name = "__ecb(lea)",
+		.base.cra_driver_name = "__ecb-lea-avx2",
+		.base.cra_priority = 300,
+		.base.cra_flags = CRYPTO_ALG_INTERNAL,
+		.base.cra_blocksize = LEA_BLOCK_SIZE,
+		.base.cra_ctxsize = sizeof(struct crypto_lea_ctx),
+		.base.cra_module = THIS_MODULE,
+		.min_keysize = LEA_MIN_KEY_SIZE,
+		.max_keysize = LEA_MAX_KEY_SIZE,
+		.walksize = LEA_AVX2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE,
+		.setkey = _lea_set_key,
+		.encrypt = ecb_encrypt_8way,
+		.decrypt = ecb_decrypt_8way,
+	},
+	{
+		.base.cra_name = "__ctr(lea)",
+		.base.cra_driver_name = "__ctr-lea-avx2",
+		.base.cra_priority = 300,
+		.base.cra_flags = CRYPTO_ALG_INTERNAL,
+		.base.cra_blocksize = 1,
+		.base.cra_ctxsize = sizeof(struct crypto_lea_ctx),
+		.base.cra_module = THIS_MODULE,
+		.min_keysize = LEA_MIN_KEY_SIZE,
+		.max_keysize = LEA_MAX_KEY_SIZE,
+		.chunksize = LEA_BLOCK_SIZE,
+		.walksize = LEA_AVX2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE,
+		.ivsize = LEA_BLOCK_SIZE,
+		.setkey = _lea_set_key,
+		.encrypt = ctr_encrypt_8way,
+		.decrypt = ctr_encrypt_8way,
+	},
+	{
+		.base.cra_name = "__cbc(lea)",
+		.base.cra_driver_name = "__cbc-lea-avx2",
+		.base.cra_priority = 300,
+		.base.cra_flags = CRYPTO_ALG_INTERNAL,
+		.base.cra_blocksize = LEA_BLOCK_SIZE,
+		.base.cra_ctxsize = sizeof(struct crypto_lea_ctx),
+		.base.cra_module = THIS_MODULE,
+		.min_keysize = LEA_MIN_KEY_SIZE,
+		.max_keysize = LEA_MAX_KEY_SIZE,
+		.walksize = LEA_AVX2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE,
+		.ivsize = LEA_BLOCK_SIZE,
+		.setkey = _lea_set_key,
+		.encrypt = cbc_encrypt,
+		.decrypt = cbc_decrypt_8way,
+	},
+	{
+		.base.cra_name = "__xts(lea)",
+		.base.cra_driver_name = "__xts-lea-avx2",
+		.base.cra_priority = 300,
+		.base.cra_flags = CRYPTO_ALG_INTERNAL,
+		.base.cra_blocksize = LEA_BLOCK_SIZE,
+		.base.cra_ctxsize = sizeof(struct lea_xts_ctx),
+		.base.cra_module = THIS_MODULE,
+		.min_keysize = LEA_MIN_KEY_SIZE * 2,
+		.max_keysize = LEA_MAX_KEY_SIZE * 2,
+		.walksize = LEA_AVX2_PARALLEL_BLOCKS * LEA_BLOCK_SIZE,
+		.ivsize = LEA_BLOCK_SIZE,
+		.setkey = xts_lea_set_key,
+		.encrypt = xts_encrypt_8way,
+		.decrypt = xts_decrypt_8way,
+	},
+};
+
+static struct simd_skcipher_alg *lea_simd_algs[ARRAY_SIZE(lea_simd_avx2_algs)];
+
+static int __init crypto_lea_avx2_init(void)
+{
+	const char *feature_name;
+
+	if (!boot_cpu_has(X86_FEATURE_XMM2)) {
+		pr_info("SSE2 instructions are not detected.\n");
+		return -ENODEV;
+	}
+
+	if (!boot_cpu_has(X86_FEATURE_MOVBE)) {
+		pr_info("MOVBE instructions are not detected.\n");
+		return -ENODEV;
+	}
+
+	if (!boot_cpu_has(X86_FEATURE_AVX2) || !boot_cpu_has(X86_FEATURE_AVX)) {
+		pr_info("AVX2 instructions are not detected.\n");
+		return -ENODEV;
+	}
+
+	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
+				&feature_name)) {
+		pr_info("CPU feature '%s' is not supported.\n", feature_name);
+		return -ENODEV;
+	}
+
+	return simd_register_skciphers_compat(
+		lea_simd_avx2_algs, ARRAY_SIZE(lea_simd_algs), lea_simd_algs);
+}
+
+static void __exit crypto_lea_avx2_exit(void)
+{
+	simd_unregister_skciphers(lea_simd_avx2_algs, ARRAY_SIZE(lea_simd_algs),
+				lea_simd_algs);
+}
+
+module_init(crypto_lea_avx2_init);
+module_exit(crypto_lea_avx2_exit);
+
+MODULE_DESCRIPTION("LEA Cipher Algorithm, AVX2, SSE2 SIMD, MOVBE");
+MODULE_AUTHOR("Dongsoo Lee <letrhee@nsr.re.kr>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("lea");
+MODULE_ALIAS_CRYPTO("lea-avx2");
diff --git a/arch/x86/crypto/lea_avx2_x86_64-asm.S b/arch/x86/crypto/lea_avx2_x86_64-asm.S
new file mode 100644
index 000000000000..06ad30a2ab63
--- /dev/null
+++ b/arch/x86/crypto/lea_avx2_x86_64-asm.S
@@ -0,0 +1,778 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * LEA Cipher 8-way(AVX2), 4-way(SSE2) parallel algorithm.
+ * In CTR mode, the MOVBE instruction is utilized for improved performance.
+ *
+ * Copyright (c) 2023 National Security Research.
+ * Author: Dongsoo Lee <letrhee@nsr.re.kr>
+ */
+
+#include <linux/linkage.h>
+#include <asm/frame.h>
+
+.file "lea_avx2_x86_64-asm.S"
+
+.section .text
+
+#define LEA_MAX_KEYLENGTH (32 * 6 * 4)
+
+#define ADD_CTR1_R(low, high) \
+	add $1, low; \
+	adc $0, high;
+
+#define PROC_NEXT_CTR(addr, blk_offset, low, high) \
+	ADD_CTR1_R(low, high); \
+	movbe high, (blk_offset * 16)(addr); \
+	movbe low, (blk_offset * 16 + 8)(addr);
+
+#define XTS_TW_X0 %xmm8
+#define XTS_TW_X1 %xmm9
+#define XTS_TW_I2 %xmm0
+#define XTS_TW_O2 %xmm10
+#define XTS_TW_X3 %xmm11
+#define XTS_TW_X4 %xmm12
+#define XTS_TW_X5 %xmm13
+#define XTS_TW_I6 %xmm1
+#define XTS_TW_O6 %xmm14
+#define XTS_TW_X7 %xmm15
+#define XTS_TW_X8 %xmm2
+#define XTS_MASK  %xmm7
+
+#define XTS_TW_Y0 %ymm12
+#define XTS_TW_Y1 %ymm13
+#define XTS_TW_Y2 %ymm14
+#define XTS_TW_Y3 %ymm15
+
+#define CTR_64_low %rax
+#define CTR_64_high %r9
+
+
+#define XMM(n) %xmm ##  n
+#define YMM(n) %ymm ##  n
+
+#define XAR_AVX2(v0, v1, cur, pre, tmp, rk1, rk2) \
+	vpbroadcastd rk2, tmp; \
+	vpxor        tmp, cur, cur; \
+	vpbroadcastd rk1, tmp; \
+	vpxor        pre, tmp, tmp; \
+	vpaddd       cur, tmp, tmp; \
+	vpsrld       v0, tmp, cur; \
+	vpslld       v1, tmp, tmp; \
+	vpxor        tmp, cur, cur;
+
+
+#define XSR_AVX2(v0, v1, cur, pre, tmp, rk1, rk2) \
+	vpsrld       v0, cur, tmp; \
+	vpslld       v1, cur, cur; \
+	vpxor        tmp, cur, cur; \
+	vpbroadcastd rk1, tmp; \
+	vpxor        pre, tmp, tmp; \
+	vpsubd       tmp, cur, cur; \
+	vpbroadcastd rk2, tmp; \
+	vpxor        tmp, cur, cur;
+
+#define XAR3_AVX2(cur, pre, tmp, rk1, rk2) \
+	XAR_AVX2($3, $29, cur, pre, tmp, rk1, rk2)
+
+#define XAR5_AVX2(cur, pre, tmp, rk1, rk2) \
+	XAR_AVX2($5, $27, cur, pre, tmp, rk1, rk2)
+
+#define XAR9_AVX2(cur, pre, tmp, rk1, rk2) \
+	XAR_AVX2($23, $9, cur, pre, tmp, rk1, rk2)
+
+
+#define XSR9_AVX2(cur, pre, tmp, rk1, rk2) \
+	XSR_AVX2($9, $23, cur, pre, tmp, rk1, rk2)
+
+#define XSR5_AVX2(cur, pre, tmp, rk1, rk2) \
+	XSR_AVX2($27, $5, cur, pre, tmp, rk1, rk2)
+
+#define XSR3_AVX2(cur, pre, tmp, rk1, rk2) \
+	XSR_AVX2($29, $3, cur, pre, tmp, rk1, rk2)
+
+#define LOAD_AND_JOIN8_YMM(i, ti, j, mem) \
+	vmovd (j + 0 * 16)(mem), XMM(ti); \
+	vpinsrd $0x1, (j + 1 * 16)(mem), XMM(ti), XMM(ti); \
+	vpinsrd $0x2, (j + 2 * 16)(mem), XMM(ti), XMM(ti); \
+	vpinsrd $0x3, (j + 3 * 16)(mem), XMM(ti), XMM(ti); \
+	vmovd (j + 4 * 16)(mem), XMM(i); \
+	vpinsrd $0x1, (j + 5 * 16)(mem), XMM(i), XMM(i); \
+	vpinsrd $0x2, (j + 6 * 16)(mem), XMM(i), XMM(i); \
+	vpinsrd $0x3, (j + 7 * 16)(mem), XMM(i), XMM(i); \
+	vinserti128 $0x1, XMM(ti), YMM(i), YMM(i); \
+
+#define LOAD_AND_JOIN_BLOCK8(i0, i1, i2, i3, ti0, mem) \
+	LOAD_AND_JOIN8_YMM(i0, ti0, 0, mem);\
+	LOAD_AND_JOIN8_YMM(i1, ti0, 4, mem);\
+	LOAD_AND_JOIN8_YMM(i2, ti0, 8, mem);\
+	LOAD_AND_JOIN8_YMM(i3, ti0, 12, mem);
+
+#define SPLIT_AND_STORE8_YMM(i, j, mem) \
+	vmovd XMM(i), (j + 4 * 16)(mem);\
+	vpextrd $0x1, XMM(i), (j + 5 * 16)(mem);\
+	vpextrd $0x2, XMM(i), (j + 6 * 16)(mem);\
+	vpextrd $0x3, XMM(i), (j + 7 * 16)(mem);\
+	vextracti128 $0x1, YMM(i), XMM(i);\
+	vmovd XMM(i), (j + 0 * 16)(mem);\
+	vpextrd $0x1, XMM(i), (j + 1 * 16)(mem);\
+	vpextrd $0x2, XMM(i), (j + 2 * 16)(mem);\
+	vpextrd $0x3, XMM(i), (j + 3 * 16)(mem);
+
+#define SPLIT_AND_STORE_BLOCK8(i0, i1, i2, i3, mem) \
+	SPLIT_AND_STORE8_YMM(i0, 0, mem);\
+	SPLIT_AND_STORE8_YMM(i1, 4, mem);\
+	SPLIT_AND_STORE8_YMM(i2, 8, mem);\
+	SPLIT_AND_STORE8_YMM(i3, 12, mem);
+
+
+#define LOAD_BLOCK4(x0, x1, x2, x3, mem) \
+	movdqu 0 * 16(mem), x0; \
+	movdqu 1 * 16(mem), x1; \
+	movdqu 2 * 16(mem), x2; \
+	movdqu 3 * 16(mem), x3;
+
+#define SPLIT_BLOCK4(x0, x1, out_x2, x3, tmp, in_x2) \
+	movdqa x0, out_x2; \
+	movdqa in_x2, tmp; \
+	punpckldq x1, x0; \
+	punpckhdq x1, out_x2; \
+	punpckldq x3, tmp; \
+	punpckhdq x3, in_x2; \
+	\
+	movdqa x0, x1; \
+	movdqa out_x2, x3; \
+	punpcklqdq tmp, x0; \
+	punpckhqdq tmp, x1; \
+	punpcklqdq in_x2, out_x2; \
+	punpckhqdq in_x2, x3;
+
+#define XOR_BLOCK3(x0, x1, x2, tmp0, tmp1, tmp2, mem) \
+	movdqu 0 * 16(mem), tmp0; \
+	movdqu 1 * 16(mem), tmp1; \
+	movdqu 2 * 16(mem), tmp2; \
+	pxor tmp0, x0;            \
+	pxor tmp1, x1;            \
+	pxor tmp2, x2;
+
+#define STORE_BLOCK4(x0, x1, x2, x3, mem) \
+	movdqu x0, 0 * 16(mem); \
+	movdqu x1, 1 * 16(mem); \
+	movdqu x2, 2 * 16(mem); \
+	movdqu x3, 3 * 16(mem);
+
+#define LEA_1ROUND_ENC(i0, i1, i2, i3, tmp, rk, rnd_num) \
+	XAR3_AVX2(i3, i2, tmp, (((rnd_num) * 6 + 4) * 4)(rk), (((rnd_num) * 6 + 5) * 4)(rk)); \
+	XAR5_AVX2(i2, i1, tmp, (((rnd_num) * 6 + 2) * 4)(rk), (((rnd_num) * 6 + 3) * 4)(rk)); \
+	XAR9_AVX2(i1, i0, tmp, (((rnd_num) * 6 + 0) * 4)(rk), (((rnd_num) * 6 + 1) * 4)(rk));
+
+#define LEA_4ROUND_ENC(i0, i1, i2, i3, tmp, rk, rnd_num) \
+	LEA_1ROUND_ENC(i0, i1, i2, i3, tmp, rk, rnd_num + 0); \
+	LEA_1ROUND_ENC(i1, i2, i3, i0, tmp, rk, rnd_num + 1); \
+	LEA_1ROUND_ENC(i2, i3, i0, i1, tmp, rk, rnd_num + 2); \
+	LEA_1ROUND_ENC(i3, i0, i1, i2, tmp, rk, rnd_num + 3);
+
+#define LEA_1ROUND_DEC(i0, i1, i2, i3, tmp, rk, rnd_num) \
+	XSR9_AVX2(i0, i3, tmp, (((rnd_num) * 6 + 0) * 4)(rk), (((rnd_num) * 6 + 1) * 4)(rk)); \
+	XSR5_AVX2(i1, i0, tmp, (((rnd_num) * 6 + 2) * 4)(rk), (((rnd_num) * 6 + 3) * 4)(rk)); \
+	XSR3_AVX2(i2, i1, tmp, (((rnd_num) * 6 + 4) * 4)(rk), (((rnd_num) * 6 + 5) * 4)(rk));
+
+#define LEA_4ROUND_DEC(i0, i1, i2, i3, tmp, rk, rnd_num) \
+	LEA_1ROUND_DEC(i0, i1, i2, i3, tmp, rk, rnd_num + 3); \
+	LEA_1ROUND_DEC(i3, i0, i1, i2, tmp, rk, rnd_num + 2); \
+	LEA_1ROUND_DEC(i2, i3, i0, i1, tmp, rk, rnd_num + 1); \
+	LEA_1ROUND_DEC(i1, i2, i3, i0, tmp, rk, rnd_num + 0);
+
+#define CBC_LOAD_SHUFFLE_MASK(mask) \
+	vmovdqa .Lcbc_shuffle_mask(%rip), mask;
+
+#define XTS_LOAD_TWEAK_MASK(mask) \
+	vmovdqa .Lxts_tweak_mask(%rip), mask;
+
+#define XTS_NEXT_TWEAK_1BLOCK(out0, in0, tmp0, mask) \
+	pshufd $0x13, in0, tmp0; \
+	psrad $31, tmp0; \
+	pand mask, tmp0; \
+	vpsllq $1, in0, out0; \
+	pxor tmp0, out0;
+
+#define JOIN_BLOCK4(x0, x1, out_x2, x3, tmp, in_x2) \
+	vpunpckhdq x1, x0, out_x2; \
+	vpunpckldq x1, x0, x0; \
+	vpunpckldq x3, in_x2, tmp; \
+	vpunpckhdq x3, in_x2, in_x2; \
+	\
+	vpunpckhqdq tmp, x0, x1; \
+	vpunpcklqdq tmp, x0, x0; \
+	vpunpckhqdq in_x2, out_x2, x3; \
+	vpunpcklqdq in_x2, out_x2, out_x2;
+
+
+.align 8
+SYM_FUNC_START_LOCAL(__lea_avx2_enc_4way)
+	/* input:
+	 *	%rdi: ctx, CTX
+	 *	%xmm0..%xmm3: 4 plaintext blocks
+	 * output:
+	 *	%xmm0..%xmm3: 4 encrypted blocks
+	 */
+	LEA_4ROUND_ENC(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %rdi, 0);
+	LEA_4ROUND_ENC(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %rdi, 4);
+	LEA_4ROUND_ENC(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %rdi, 8);
+	LEA_4ROUND_ENC(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %rdi, 12);
+	LEA_4ROUND_ENC(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %rdi, 16);
+	LEA_4ROUND_ENC(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %rdi, 20);
+
+	cmpl $24, LEA_MAX_KEYLENGTH(%rdi);
+	je .Lenc4_done;
+	LEA_4ROUND_ENC(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %rdi, 24);
+
+	cmpl $28, LEA_MAX_KEYLENGTH(%rdi);
+	je .Lenc4_done;
+	LEA_4ROUND_ENC(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %rdi, 28);
+
+.Lenc4_done:
+	RET;
+SYM_FUNC_END(__lea_avx2_enc_4way)
+
+.align 8
+SYM_FUNC_START_LOCAL(__lea_avx2_dec_4way)
+	/* input:
+	 *	%rdi: ctx, CTX
+	 *	%xmm0..%xmm3: 4 encrypted blocks
+	 * output:
+	 *	%xmm0..%xmm3: 4 plaintext blocks
+	 */
+	cmpl $28, LEA_MAX_KEYLENGTH(%rdi);
+	jbe .Ldec4_24;
+	LEA_4ROUND_DEC(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %rdi, 28);
+
+.Ldec4_24:
+	cmpl $24, LEA_MAX_KEYLENGTH(%rdi);
+	jbe .Ldec4_20;
+	LEA_4ROUND_DEC(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %rdi, 24);
+
+.Ldec4_20:
+	LEA_4ROUND_DEC(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %rdi, 20);
+	LEA_4ROUND_DEC(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %rdi, 16);
+	LEA_4ROUND_DEC(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %rdi, 12);
+	LEA_4ROUND_DEC(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %rdi, 8);
+	LEA_4ROUND_DEC(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %rdi, 4);
+	LEA_4ROUND_DEC(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %rdi, 0);
+
+	RET;
+SYM_FUNC_END(__lea_avx2_dec_4way)
+
+
+.align 8
+SYM_FUNC_START_LOCAL(__lea_avx2_enc_8way)
+	/* input:
+	 *	%rdi: ctx, CTX
+	 *	%ymm0..%ymm3: 8 plaintext blocks
+	 * output:
+	 *	%ymm0..%ymm3: 8 encrypted blocks
+	 */
+	LEA_4ROUND_ENC(%ymm0, %ymm1, %ymm2, %ymm3, %ymm4, %rdi, 0);
+	LEA_4ROUND_ENC(%ymm0, %ymm1, %ymm2, %ymm3, %ymm4, %rdi, 4);
+	LEA_4ROUND_ENC(%ymm0, %ymm1, %ymm2, %ymm3, %ymm4, %rdi, 8);
+	LEA_4ROUND_ENC(%ymm0, %ymm1, %ymm2, %ymm3, %ymm4, %rdi, 12);
+	LEA_4ROUND_ENC(%ymm0, %ymm1, %ymm2, %ymm3, %ymm4, %rdi, 16);
+	LEA_4ROUND_ENC(%ymm0, %ymm1, %ymm2, %ymm3, %ymm4, %rdi, 20);
+
+	cmpl $24, LEA_MAX_KEYLENGTH(%rdi);
+	je .Lenc8_done;
+	LEA_4ROUND_ENC(%ymm0, %ymm1, %ymm2, %ymm3, %ymm4, %rdi, 24);
+
+	cmpl $28, LEA_MAX_KEYLENGTH(%rdi);
+	je .Lenc8_done;
+	LEA_4ROUND_ENC(%ymm0, %ymm1, %ymm2, %ymm3, %ymm4, %rdi, 28);
+
+.Lenc8_done:
+	RET;
+SYM_FUNC_END(__lea_avx2_enc_8way)
+
+.align 8
+SYM_FUNC_START_LOCAL(__lea_avx2_dec_8way)
+	/* input:
+	 *	%rdi: ctx, CTX
+	 *	%ymm0..%ymm3: 8 encrypted blocks
+	 * output:
+	 *	%ymm0..%ymm3: 8 plaintext blocks
+	 */
+	cmpl $28, LEA_MAX_KEYLENGTH(%rdi);
+	jbe .Lenc8_24;
+	LEA_4ROUND_DEC(%ymm0, %ymm1, %ymm2, %ymm3, %ymm4, %rdi, 28);
+
+.Lenc8_24:
+	cmpl $24, LEA_MAX_KEYLENGTH(%rdi);
+	jbe .Lenc8_20;
+	LEA_4ROUND_DEC(%ymm0, %ymm1, %ymm2, %ymm3, %ymm4, %rdi, 24);
+
+.Lenc8_20:
+	LEA_4ROUND_DEC(%ymm0, %ymm1, %ymm2, %ymm3, %ymm4, %rdi, 20);
+	LEA_4ROUND_DEC(%ymm0, %ymm1, %ymm2, %ymm3, %ymm4, %rdi, 16);
+	LEA_4ROUND_DEC(%ymm0, %ymm1, %ymm2, %ymm3, %ymm4, %rdi, 12);
+	LEA_4ROUND_DEC(%ymm0, %ymm1, %ymm2, %ymm3, %ymm4, %rdi, 8);
+	LEA_4ROUND_DEC(%ymm0, %ymm1, %ymm2, %ymm3, %ymm4, %rdi, 4);
+	LEA_4ROUND_DEC(%ymm0, %ymm1, %ymm2, %ymm3, %ymm4, %rdi, 0);
+
+	RET;
+SYM_FUNC_END(__lea_avx2_dec_8way)
+
+SYM_FUNC_START(lea_avx2_ecb_enc_4way)
+	/* input:
+	 *	%rdi: ctx, CTX
+	 *	%rsi: dst (4 blocks)
+	 *	%rdx: src (4 blocks)
+	 */
+	FRAME_BEGIN
+
+	LOAD_BLOCK4(%xmm0, %xmm1, %xmm5, %xmm3, %rdx);
+	JOIN_BLOCK4(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5);
+
+	call __lea_avx2_enc_4way
+
+	SPLIT_BLOCK4(%xmm0, %xmm1, %xmm5, %xmm3, %xmm4, %xmm2);
+	STORE_BLOCK4(%xmm0, %xmm1, %xmm5, %xmm3, %rsi);
+
+	FRAME_END
+	RET;
+SYM_FUNC_END(lea_avx2_ecb_enc_4way)
+
+SYM_FUNC_START(lea_avx2_ecb_dec_4way)
+	/* input:
+	 *	%rdi: ctx, CTX
+	 *	%rsi: dst (4 blocks)
+	 *	%rdx: src (4 blocks)
+	 */
+	FRAME_BEGIN
+
+	LOAD_BLOCK4(%xmm0, %xmm1, %xmm5, %xmm3, %rdx);
+	JOIN_BLOCK4(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5);
+
+	call __lea_avx2_dec_4way
+
+	SPLIT_BLOCK4(%xmm0, %xmm1, %xmm5, %xmm3, %xmm4, %xmm2);
+	STORE_BLOCK4(%xmm0, %xmm1, %xmm5, %xmm3, %rsi);
+
+	FRAME_END
+	RET;
+SYM_FUNC_END(lea_avx2_ecb_dec_4way)
+
+SYM_FUNC_START(lea_avx2_cbc_dec_4way)
+	/* input:
+	 *	%rdi: ctx, CTX
+	 *	%rsi: dst (4 blocks)
+	 *	%rdx: src (4 blocks)
+	 */
+	FRAME_BEGIN
+
+	LOAD_BLOCK4(%xmm0, %xmm1, %xmm5, %xmm3, %rdx);
+	JOIN_BLOCK4(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5);
+
+	call __lea_avx2_dec_4way
+
+	SPLIT_BLOCK4(%xmm0, %xmm1, %xmm5, %xmm3, %xmm4, %xmm2);
+	XOR_BLOCK3(%xmm1, %xmm5, %xmm3, %xmm4, %xmm6, %xmm7, %rdx);
+	STORE_BLOCK4(%xmm0, %xmm1, %xmm5, %xmm3, %rsi);
+
+	FRAME_END
+	RET;
+SYM_FUNC_END(lea_avx2_cbc_dec_4way)
+
+SYM_FUNC_START(lea_avx2_xts_enc_4way)
+	/* input:
+	 *	%rdi: ctx, CTX
+	 *	%rsi: dst (4 blocks)
+	 *	%rdx: src (4 blocks)
+	 *	%rcx: tweak
+	 */
+	FRAME_BEGIN
+
+	LOAD_BLOCK4(%xmm0, %xmm1, %xmm5, %xmm3, %rdx);
+	movdqu (%rcx), XTS_TW_X0;
+	XTS_LOAD_TWEAK_MASK(XTS_MASK);
+	pxor XTS_TW_X0, %xmm0;
+	XTS_NEXT_TWEAK_1BLOCK(XTS_TW_X1, XTS_TW_X0, %xmm4, XTS_MASK);
+	pxor XTS_TW_X1, %xmm1;
+	XTS_NEXT_TWEAK_1BLOCK(XTS_TW_O2, XTS_TW_X1, %xmm4, XTS_MASK);
+	pxor XTS_TW_O2, %xmm5;
+	XTS_NEXT_TWEAK_1BLOCK(XTS_TW_X3, XTS_TW_O2, %xmm4, XTS_MASK);
+	pxor XTS_TW_X3, %xmm3;
+
+
+	JOIN_BLOCK4(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5);
+
+	call __lea_avx2_enc_4way
+
+	SPLIT_BLOCK4(%xmm0, %xmm1, %xmm5, %xmm3, %xmm4, %xmm2);
+
+	pxor XTS_TW_X0, %xmm0;
+	pxor XTS_TW_X1, %xmm1;
+	pxor XTS_TW_O2, %xmm5;
+	pxor XTS_TW_X3, %xmm3;
+
+	XTS_NEXT_TWEAK_1BLOCK(XTS_TW_X0, XTS_TW_X3, %xmm4, XTS_MASK);
+	movdqu XTS_TW_X0, (%rcx);
+	STORE_BLOCK4(%xmm0, %xmm1, %xmm5, %xmm3, %rsi);
+
+	FRAME_END
+	RET;
+SYM_FUNC_END(lea_avx2_xts_enc_4way)
+
+SYM_FUNC_START(lea_avx2_xts_dec_4way)
+	/* input:
+	 *	%rdi: ctx, CTX
+	 *	%rsi: dst (4 blocks)
+	 *	%rdx: src (4 blocks)
+	 *	%rcx: tweak
+	 */
+	FRAME_BEGIN
+
+	LOAD_BLOCK4(%xmm0, %xmm1, %xmm5, %xmm3, %rdx);
+	movdqu (%rcx), XTS_TW_X0;
+	XTS_LOAD_TWEAK_MASK(XTS_MASK);
+	pxor XTS_TW_X0, %xmm0;
+	XTS_NEXT_TWEAK_1BLOCK(XTS_TW_X1, XTS_TW_X0, %xmm4, XTS_MASK);
+	pxor XTS_TW_X1, %xmm1;
+	XTS_NEXT_TWEAK_1BLOCK(XTS_TW_O2, XTS_TW_X1, %xmm4, XTS_MASK);
+	pxor XTS_TW_O2, %xmm5;
+	XTS_NEXT_TWEAK_1BLOCK(XTS_TW_X3, XTS_TW_O2, %xmm4, XTS_MASK);
+	pxor XTS_TW_X3, %xmm3;
+
+	JOIN_BLOCK4(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5);
+
+	call __lea_avx2_dec_4way
+
+	SPLIT_BLOCK4(%xmm0, %xmm1, %xmm5, %xmm3, %xmm4, %xmm2);
+
+	pxor XTS_TW_X0, %xmm0;
+	pxor XTS_TW_X1, %xmm1;
+	pxor XTS_TW_O2, %xmm5;
+	pxor XTS_TW_X3, %xmm3;
+
+	XTS_NEXT_TWEAK_1BLOCK(XTS_TW_X0, XTS_TW_X3, %xmm4, XTS_MASK);
+	movdqu XTS_TW_X0, (%rcx);
+	STORE_BLOCK4(%xmm0, %xmm1, %xmm5, %xmm3, %rsi);
+
+	FRAME_END
+	RET;
+SYM_FUNC_END(lea_avx2_xts_dec_4way)
+
+SYM_FUNC_START(lea_avx2_xts_next_tweak_sse2)
+	/* input:
+	 *	%rdi: tweak_out
+	 *	%rsi: tweak_in
+	 */
+	FRAME_BEGIN
+
+	movdqu (%rsi), XTS_TW_X0;
+	XTS_LOAD_TWEAK_MASK(XTS_MASK);
+	XTS_NEXT_TWEAK_1BLOCK(XTS_TW_X0, XTS_TW_X0, %xmm5, XTS_MASK);
+	movdqu XTS_TW_X0, (%rdi);
+
+	FRAME_END
+	RET;
+SYM_FUNC_END(lea_avx2_xts_next_tweak_sse2)
+
+SYM_FUNC_START(lea_avx2_ctr_enc_4way)
+	/* input:
+	 *	%rdi: ctx, CTX
+	 *	%rsi: dst (4 blocks)
+	 *	%rdx: src (4 blocks)
+	 *	%rcx: ctr
+	 * changed:
+	 *  CTR_64_high(%r9)
+	 *  CTR_64_low(%rax)
+	 */
+	FRAME_BEGIN
+
+	push CTR_64_high;
+
+	movbe (%rcx), CTR_64_high;
+	movbe 8(%rcx), CTR_64_low;
+
+	movdqu (%rcx), %xmm0;
+	PROC_NEXT_CTR(%rcx, 0, CTR_64_low, CTR_64_high);
+	movdqu (%rcx), %xmm1;
+	PROC_NEXT_CTR(%rcx, 0, CTR_64_low, CTR_64_high);
+	movdqu (%rcx), %xmm5;
+	PROC_NEXT_CTR(%rcx, 0, CTR_64_low, CTR_64_high);
+	movdqu (%rcx), %xmm3;
+	PROC_NEXT_CTR(%rcx, 0, CTR_64_low, CTR_64_high);
+
+	JOIN_BLOCK4(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5);
+
+	call __lea_avx2_enc_4way;
+
+	SPLIT_BLOCK4(%xmm0, %xmm1, %xmm5, %xmm3, %xmm4, %xmm2);
+	LOAD_BLOCK4(%xmm6, %xmm7, %xmm8, %xmm9, %rdx);
+
+	pxor %xmm6, %xmm0;
+	pxor %xmm7, %xmm1;
+	pxor %xmm8, %xmm5;
+	pxor %xmm9, %xmm3;
+
+	STORE_BLOCK4(%xmm0, %xmm1, %xmm5, %xmm3, %rsi);
+
+	pop CTR_64_high;
+
+	FRAME_END
+	RET;
+SYM_FUNC_END(lea_avx2_ctr_enc_4way)
+
+SYM_FUNC_START(lea_avx2_ecb_enc_8way)
+	/* input:
+	 *	%rdi: ctx, CTX
+	 *	%rsi: dst (8 blocks)
+	 *	%rdx: src (8 blocks)
+	 */
+	FRAME_BEGIN
+
+	vzeroupper;
+
+	LOAD_AND_JOIN_BLOCK8(0, 1, 2, 3, 4, %rdx);
+
+	call __lea_avx2_enc_8way;
+
+	SPLIT_AND_STORE_BLOCK8(0, 1, 2, 3, %rsi);
+
+	vzeroupper;
+
+	FRAME_END
+	RET;
+SYM_FUNC_END(lea_avx2_ecb_enc_8way)
+
+SYM_FUNC_START(lea_avx2_ecb_dec_8way)
+	/* input:
+	 *	%rdi: ctx, CTX
+	 *	%rsi: dst (8 blocks)
+	 *	%rdx: src (8 blocks)
+	 */
+	FRAME_BEGIN
+
+	vzeroupper;
+
+	LOAD_AND_JOIN_BLOCK8(0, 1, 2, 3, 4, %rdx);
+
+	call __lea_avx2_dec_8way
+
+	SPLIT_AND_STORE_BLOCK8(0, 1, 2, 3, %rsi);
+
+	vzeroupper;
+
+	FRAME_END
+	RET;
+SYM_FUNC_END(lea_avx2_ecb_dec_8way)
+
+SYM_FUNC_START(lea_avx2_cbc_dec_8way)
+	/* input:
+	 *	%rdi: ctx, CTX
+	 *	%rsi: dst (8 blocks)
+	 *	%rdx: src (8 blocks)
+	 */
+	FRAME_BEGIN
+
+	vzeroupper;
+
+	LOAD_AND_JOIN_BLOCK8(0, 1, 2, 3, 4, %rdx);
+
+	CBC_LOAD_SHUFFLE_MASK(%ymm5);
+	vpxor %ymm4, %ymm4, %ymm4;
+
+	vpermd %ymm0, %ymm5, %ymm6;
+	vpermd %ymm1, %ymm5, %ymm7;
+	vpermd %ymm2, %ymm5, %ymm8;
+	vpermd %ymm3, %ymm5, %ymm9;
+
+	vpblendd $0x10, %ymm4, %ymm6, %ymm6;
+	vpblendd $0x10, %ymm4, %ymm7, %ymm7;
+	vpblendd $0x10, %ymm4, %ymm8, %ymm8;
+	vpblendd $0x10, %ymm4, %ymm9, %ymm9;
+
+	call __lea_avx2_dec_8way
+
+	vpxor  %ymm6, %ymm0, %ymm0;
+	vpxor  %ymm7, %ymm1, %ymm1;
+	vpxor  %ymm8, %ymm2, %ymm2;
+	vpxor  %ymm9, %ymm3, %ymm3;
+
+	SPLIT_AND_STORE_BLOCK8(0, 1, 2, 3, %rsi);
+
+	vzeroupper;
+
+	FRAME_END
+	RET;
+SYM_FUNC_END(lea_avx2_cbc_dec_8way)
+
+SYM_FUNC_START(lea_avx2_xts_enc_8way)
+	/* input:
+	 *	%rdi: ctx, CTX
+	 *	%rsi: dst (8 blocks)
+	 *	%rdx: src (8 blocks)
+	 *	%rcx: tweak
+	 */
+	FRAME_BEGIN
+
+	vzeroupper;
+
+	movdqu (%rcx), XTS_TW_X0;
+	XTS_LOAD_TWEAK_MASK(XTS_MASK);
+	XTS_NEXT_TWEAK_1BLOCK(XTS_TW_X1, XTS_TW_X0, XMM(5), XTS_MASK);
+	XTS_NEXT_TWEAK_1BLOCK(XTS_TW_I2, XTS_TW_X1, XMM(5), XTS_MASK);
+	XTS_NEXT_TWEAK_1BLOCK(XTS_TW_X3, XTS_TW_I2, XMM(5), XTS_MASK);
+
+	XTS_NEXT_TWEAK_1BLOCK(XTS_TW_X4, XTS_TW_X3, XMM(5), XTS_MASK);
+	XTS_NEXT_TWEAK_1BLOCK(XTS_TW_X5, XTS_TW_X4, XMM(5), XTS_MASK);
+	XTS_NEXT_TWEAK_1BLOCK(XTS_TW_I6, XTS_TW_X5, XMM(5), XTS_MASK);
+	XTS_NEXT_TWEAK_1BLOCK(XTS_TW_X7, XTS_TW_I6, XMM(5), XTS_MASK);
+
+	XTS_NEXT_TWEAK_1BLOCK(XTS_TW_X8, XTS_TW_X7, XMM(5), XTS_MASK);
+	movdqu XTS_TW_X8, (%rcx);
+
+	JOIN_BLOCK4(XTS_TW_X0, XTS_TW_X1, XTS_TW_O2, XTS_TW_X3, XMM(5), XTS_TW_I2);
+	JOIN_BLOCK4(XTS_TW_X4, XTS_TW_X5, XTS_TW_O6, XTS_TW_X7, XMM(5), XTS_TW_I6);
+
+	vinserti128 $0x1, XTS_TW_X0, XTS_TW_Y0, XTS_TW_Y0;
+	vinserti128 $0x1, XTS_TW_X1, XTS_TW_Y1, XTS_TW_Y1;
+	vinserti128 $0x1, XTS_TW_O2, XTS_TW_Y2, XTS_TW_Y2;
+	vinserti128 $0x1, XTS_TW_X3, XTS_TW_Y3, XTS_TW_Y3;
+
+	LOAD_AND_JOIN_BLOCK8(0, 1, 2, 3, 4, %rdx);
+
+	vpxor XTS_TW_Y0, %ymm0, %ymm0;
+	vpxor XTS_TW_Y1, %ymm1, %ymm1;
+	vpxor XTS_TW_Y2, %ymm2, %ymm2;
+	vpxor XTS_TW_Y3, %ymm3, %ymm3;
+
+	call __lea_avx2_enc_8way
+
+	vpxor XTS_TW_Y0, %ymm0, %ymm0;
+	vpxor XTS_TW_Y1, %ymm1, %ymm1;
+	vpxor XTS_TW_Y2, %ymm2, %ymm2;
+	vpxor XTS_TW_Y3, %ymm3, %ymm3;
+
+	SPLIT_AND_STORE_BLOCK8(0, 1, 2, 3, %rsi);
+
+	vzeroupper;
+
+	FRAME_END
+	RET;
+SYM_FUNC_END(lea_avx2_xts_enc_8way)
+
+SYM_FUNC_START(lea_avx2_xts_dec_8way)
+	/* input:
+	 *	%rdi: ctx, CTX
+	 *	%rsi: dst (8 blocks)
+	 *	%rdx: src (8 blocks)
+	 *	%rcx: tweak
+	 */
+	FRAME_BEGIN
+
+	vzeroupper;
+
+	movdqu (%rcx), XTS_TW_X0;
+	XTS_LOAD_TWEAK_MASK(XTS_MASK);
+	XTS_NEXT_TWEAK_1BLOCK(XTS_TW_X1, XTS_TW_X0, XMM(5), XTS_MASK);
+	XTS_NEXT_TWEAK_1BLOCK(XTS_TW_I2, XTS_TW_X1, XMM(5), XTS_MASK);
+	XTS_NEXT_TWEAK_1BLOCK(XTS_TW_X3, XTS_TW_I2, XMM(5), XTS_MASK);
+
+	XTS_NEXT_TWEAK_1BLOCK(XTS_TW_X4, XTS_TW_X3, XMM(5), XTS_MASK);
+	XTS_NEXT_TWEAK_1BLOCK(XTS_TW_X5, XTS_TW_X4, XMM(5), XTS_MASK);
+	XTS_NEXT_TWEAK_1BLOCK(XTS_TW_I6, XTS_TW_X5, XMM(5), XTS_MASK);
+	XTS_NEXT_TWEAK_1BLOCK(XTS_TW_X7, XTS_TW_I6, XMM(5), XTS_MASK);
+
+	XTS_NEXT_TWEAK_1BLOCK(XTS_TW_X8, XTS_TW_X7, XMM(5), XTS_MASK);
+	movdqu XTS_TW_X8, (%rcx);
+
+	JOIN_BLOCK4(XTS_TW_X0, XTS_TW_X1, XTS_TW_O2, XTS_TW_X3, XMM(5), XTS_TW_I2);
+	JOIN_BLOCK4(XTS_TW_X4, XTS_TW_X5, XTS_TW_O6, XTS_TW_X7, XMM(5), XTS_TW_I6);
+
+	vinserti128 $0x1, XTS_TW_X0, XTS_TW_Y0, XTS_TW_Y0;
+	vinserti128 $0x1, XTS_TW_X1, XTS_TW_Y1, XTS_TW_Y1;
+	vinserti128 $0x1, XTS_TW_O2, XTS_TW_Y2, XTS_TW_Y2;
+	vinserti128 $0x1, XTS_TW_X3, XTS_TW_Y3, XTS_TW_Y3;
+
+	LOAD_AND_JOIN_BLOCK8(0, 1, 2, 3, 4, %rdx);
+
+	vpxor XTS_TW_Y0, %ymm0, %ymm0;
+	vpxor XTS_TW_Y1, %ymm1, %ymm1;
+	vpxor XTS_TW_Y2, %ymm2, %ymm2;
+	vpxor XTS_TW_Y3, %ymm3, %ymm3;
+
+	call __lea_avx2_dec_8way
+
+	vpxor XTS_TW_Y0, %ymm0, %ymm0;
+	vpxor XTS_TW_Y1, %ymm1, %ymm1;
+	vpxor XTS_TW_Y2, %ymm2, %ymm2;
+	vpxor XTS_TW_Y3, %ymm3, %ymm3;
+
+	SPLIT_AND_STORE_BLOCK8(0, 1, 2, 3, %rsi);
+
+	vzeroupper;
+
+	FRAME_END
+	RET;
+SYM_FUNC_END(lea_avx2_xts_dec_8way)
+
+
+SYM_FUNC_START(lea_avx2_ctr_enc_8way)
+	/* input:
+	 *	%rdi: ctx, CTX
+	 *	%rsi: dst (8 blocks)
+	 *	%rdx: src (8 blocks)
+	 *	%rcx: ctr
+	 *  %r8 : buffer (8 blocks)
+	 * changed:
+	 *  CTR_64_high(%r9)
+	 *  CTR_64_low(%rax)
+	 */
+	FRAME_BEGIN
+
+	push CTR_64_high;
+
+	vzeroupper;
+	movbe (%rcx), CTR_64_high;
+	movbe 8(%rcx), CTR_64_low;
+	movbe CTR_64_high, (%r8);
+	movbe CTR_64_low, 8(%r8);
+
+	PROC_NEXT_CTR(%r8, 1, CTR_64_low, CTR_64_high);
+	PROC_NEXT_CTR(%r8, 2, CTR_64_low, CTR_64_high);
+	PROC_NEXT_CTR(%r8, 3, CTR_64_low, CTR_64_high);
+	PROC_NEXT_CTR(%r8, 4, CTR_64_low, CTR_64_high);
+	PROC_NEXT_CTR(%r8, 5, CTR_64_low, CTR_64_high);
+	PROC_NEXT_CTR(%r8, 6, CTR_64_low, CTR_64_high);
+	PROC_NEXT_CTR(%r8, 7, CTR_64_low, CTR_64_high);
+	PROC_NEXT_CTR(%rcx, 0, CTR_64_low, CTR_64_high);
+
+	LOAD_AND_JOIN_BLOCK8(0, 1, 2, 3, 4, %r8);
+	LOAD_AND_JOIN_BLOCK8(5, 6, 7, 8, 4, %rdx);
+
+	call __lea_avx2_enc_8way;
+
+	vpxor %ymm5, %ymm0, %ymm0;
+	vpxor %ymm6, %ymm1, %ymm1;
+	vpxor %ymm7, %ymm2, %ymm2;
+	vpxor %ymm8, %ymm3, %ymm3;
+
+	SPLIT_AND_STORE_BLOCK8(0, 1, 2, 3, %rsi);
+
+	vzeroupper;
+
+	pop CTR_64_high;
+
+	FRAME_END
+	RET;
+SYM_FUNC_END(lea_avx2_ctr_enc_8way)
+
+
+.section	.rodata.cst32.cbc_shuffle_mask, "aM", @progbits, 32
+.align 32
+.Lcbc_shuffle_mask:
+	.octa 0x00000002000000010000000000000007
+	.octa 0x00000006000000050000000400000003
+
+.section	.rodata.cst16.xts_tweak_mask, "aM", @progbits, 16
+.align 16
+.Lxts_tweak_mask:
+	.octa 0x00000000000000010000000000000087
-- 
2.34.1
