Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80BA5FCDF0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJLWAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJLWAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:00:20 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB343E742;
        Wed, 12 Oct 2022 15:00:11 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CL7nUZ016092;
        Wed, 12 Oct 2022 21:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=PJ23TVkPoznEmI/AzY+zwfyDq1fzzxeVCOJWO7ijd2E=;
 b=NOgzVQ6FqkEG8LF7XdZO10hs5ViDwApvL5Rc/w9UogENt2AtV+dZVdTI1fnlCldKSRs+
 BTzEab8hy5QFzbnfcxL6rVMEf4YFlWfUyy3lLmGyJuh/8MeLSDhKr29y6w29WSznkYCG
 V64eeYk+kEod5S7mijkokBYrgW/7d1/lP8nYaa3b535if8SWJUhcGjsMJdR8c5YRF1yM
 UNOmlNeqAG+RcXRR+jEhs+veQsKQriTQkQgDW2hnq6ecMrJqxDKPpscNFPc831sqpSnf
 Q64CkZX/bpfrU4QBPHKLWsdbeQ71XA64u2cRLyW23Mh/rxrLgKz28Dj67EPZCCCMF34Z 6w== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k657j8a4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 21:59:59 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 81D031396A;
        Wed, 12 Oct 2022 21:59:58 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 28796805032;
        Wed, 12 Oct 2022 21:59:58 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 09/19] crypto: x86 - use common macro for FPU limit
Date:   Wed, 12 Oct 2022 16:59:21 -0500
Message-Id: <20221012215931.3896-10-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012215931.3896-1-elliott@hpe.com>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cvBzHnz1Jrp4-w5puDxizPr6_DNBD6L8
X-Proofpoint-GUID: cvBzHnz1Jrp4-w5puDxizPr6_DNBD6L8
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_11,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120138
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a common macro name (FPU_BYTES) for the limit of the number of bytes
processed within kernel_fpu_begin and kernel_fpu_end rather than
using SZ_4K (which is a signed value), or a magic value of 4096U.

Use unsigned int rather than size_t for some of the arguments to
avoid typecasting for the min() macro.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/blake2s-glue.c         |  7 ++++---
 arch/x86/crypto/chacha_glue.c          |  4 +++-
 arch/x86/crypto/nhpoly1305-avx2-glue.c |  4 +++-
 arch/x86/crypto/nhpoly1305-sse2-glue.c |  4 +++-
 arch/x86/crypto/poly1305_glue.c        | 25 ++++++++++++++-----------
 arch/x86/crypto/polyval-clmulni_glue.c |  5 +++--
 6 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/arch/x86/crypto/blake2s-glue.c b/arch/x86/crypto/blake2s-glue.c
index aaba21230528..3054ee7fa219 100644
--- a/arch/x86/crypto/blake2s-glue.c
+++ b/arch/x86/crypto/blake2s-glue.c
@@ -16,6 +16,8 @@
 #include <asm/processor.h>
 #include <asm/simd.h>
 
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+
 asmlinkage void blake2s_compress_ssse3(struct blake2s_state *state,
 				       const u8 *block, const size_t nblocks,
 				       const u32 inc);
@@ -29,8 +31,7 @@ static __ro_after_init DEFINE_STATIC_KEY_FALSE(blake2s_use_avx512);
 void blake2s_compress(struct blake2s_state *state, const u8 *block,
 		      size_t nblocks, const u32 inc)
 {
-	/* SIMD disables preemption, so relax after processing each page. */
-	BUILD_BUG_ON(SZ_4K / BLAKE2S_BLOCK_SIZE < 8);
+	BUILD_BUG_ON(FPU_BYTES / BLAKE2S_BLOCK_SIZE < 8);
 
 	if (!static_branch_likely(&blake2s_use_ssse3) || !may_use_simd()) {
 		blake2s_compress_generic(state, block, nblocks, inc);
@@ -39,7 +40,7 @@ void blake2s_compress(struct blake2s_state *state, const u8 *block,
 
 	do {
 		const size_t blocks = min_t(size_t, nblocks,
-					    SZ_4K / BLAKE2S_BLOCK_SIZE);
+					    FPU_BYTES / BLAKE2S_BLOCK_SIZE);
 
 		kernel_fpu_begin();
 		if (IS_ENABLED(CONFIG_AS_AVX512) &&
diff --git a/arch/x86/crypto/chacha_glue.c b/arch/x86/crypto/chacha_glue.c
index 7b3a1cf0984b..0d7e172862db 100644
--- a/arch/x86/crypto/chacha_glue.c
+++ b/arch/x86/crypto/chacha_glue.c
@@ -15,6 +15,8 @@
 #include <linux/sizes.h>
 #include <asm/simd.h>
 
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+
 asmlinkage void chacha_block_xor_ssse3(u32 *state, u8 *dst, const u8 *src,
 				       unsigned int len, int nrounds);
 asmlinkage void chacha_4block_xor_ssse3(u32 *state, u8 *dst, const u8 *src,
@@ -147,7 +149,7 @@ void chacha_crypt_arch(u32 *state, u8 *dst, const u8 *src, unsigned int bytes,
 		return chacha_crypt_generic(state, dst, src, bytes, nrounds);
 
 	do {
-		unsigned int todo = min_t(unsigned int, bytes, SZ_4K);
+		unsigned int todo = min(bytes, FPU_BYTES);
 
 		kernel_fpu_begin();
 		chacha_dosimd(state, dst, src, todo, nrounds);
diff --git a/arch/x86/crypto/nhpoly1305-avx2-glue.c b/arch/x86/crypto/nhpoly1305-avx2-glue.c
index 8ea5ab0f1ca7..59615ae95e86 100644
--- a/arch/x86/crypto/nhpoly1305-avx2-glue.c
+++ b/arch/x86/crypto/nhpoly1305-avx2-glue.c
@@ -13,6 +13,8 @@
 #include <linux/sizes.h>
 #include <asm/simd.h>
 
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+
 asmlinkage void nh_avx2(const u32 *key, const u8 *message, size_t message_len,
 			u8 hash[NH_HASH_BYTES]);
 
@@ -30,7 +32,7 @@ static int nhpoly1305_avx2_update(struct shash_desc *desc,
 		return crypto_nhpoly1305_update(desc, src, srclen);
 
 	do {
-		unsigned int n = min_t(unsigned int, srclen, SZ_4K);
+		unsigned int n = min(srclen, FPU_BYTES);
 
 		kernel_fpu_begin();
 		crypto_nhpoly1305_update_helper(desc, src, n, _nh_avx2);
diff --git a/arch/x86/crypto/nhpoly1305-sse2-glue.c b/arch/x86/crypto/nhpoly1305-sse2-glue.c
index 2b353d42ed13..bf91c375821a 100644
--- a/arch/x86/crypto/nhpoly1305-sse2-glue.c
+++ b/arch/x86/crypto/nhpoly1305-sse2-glue.c
@@ -13,6 +13,8 @@
 #include <linux/sizes.h>
 #include <asm/simd.h>
 
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+
 asmlinkage void nh_sse2(const u32 *key, const u8 *message, size_t message_len,
 			u8 hash[NH_HASH_BYTES]);
 
@@ -30,7 +32,7 @@ static int nhpoly1305_sse2_update(struct shash_desc *desc,
 		return crypto_nhpoly1305_update(desc, src, srclen);
 
 	do {
-		unsigned int n = min_t(unsigned int, srclen, SZ_4K);
+		unsigned int n = min(srclen, FPU_BYTES);
 
 		kernel_fpu_begin();
 		crypto_nhpoly1305_update_helper(desc, src, n, _nh_sse2);
diff --git a/arch/x86/crypto/poly1305_glue.c b/arch/x86/crypto/poly1305_glue.c
index 1dfb8af48a3c..3764301bdf1b 100644
--- a/arch/x86/crypto/poly1305_glue.c
+++ b/arch/x86/crypto/poly1305_glue.c
@@ -15,20 +15,24 @@
 #include <asm/intel-family.h>
 #include <asm/simd.h>
 
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+
 asmlinkage void poly1305_init_x86_64(void *ctx,
 				     const u8 key[POLY1305_BLOCK_SIZE]);
 asmlinkage void poly1305_blocks_x86_64(void *ctx, const u8 *inp,
-				       const size_t len, const u32 padbit);
+				       const unsigned int len,
+				       const u32 padbit);
 asmlinkage void poly1305_emit_x86_64(void *ctx, u8 mac[POLY1305_DIGEST_SIZE],
 				     const u32 nonce[4]);
 asmlinkage void poly1305_emit_avx(void *ctx, u8 mac[POLY1305_DIGEST_SIZE],
 				  const u32 nonce[4]);
-asmlinkage void poly1305_blocks_avx(void *ctx, const u8 *inp, const size_t len,
-				    const u32 padbit);
-asmlinkage void poly1305_blocks_avx2(void *ctx, const u8 *inp, const size_t len,
-				     const u32 padbit);
+asmlinkage void poly1305_blocks_avx(void *ctx, const u8 *inp,
+				    const unsigned int len, const u32 padbit);
+asmlinkage void poly1305_blocks_avx2(void *ctx, const u8 *inp,
+				     const unsigned int len, const u32 padbit);
 asmlinkage void poly1305_blocks_avx512(void *ctx, const u8 *inp,
-				       const size_t len, const u32 padbit);
+				       const unsigned int len,
+				       const u32 padbit);
 
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(poly1305_use_avx);
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(poly1305_use_avx2);
@@ -86,14 +90,13 @@ static void poly1305_simd_init(void *ctx, const u8 key[POLY1305_BLOCK_SIZE])
 	poly1305_init_x86_64(ctx, key);
 }
 
-static void poly1305_simd_blocks(void *ctx, const u8 *inp, size_t len,
+static void poly1305_simd_blocks(void *ctx, const u8 *inp, unsigned int len,
 				 const u32 padbit)
 {
 	struct poly1305_arch_internal *state = ctx;
 
-	/* SIMD disables preemption, so relax after processing each page. */
-	BUILD_BUG_ON(SZ_4K < POLY1305_BLOCK_SIZE ||
-		     SZ_4K % POLY1305_BLOCK_SIZE);
+	BUILD_BUG_ON(FPU_BYTES < POLY1305_BLOCK_SIZE ||
+		     FPU_BYTES % POLY1305_BLOCK_SIZE);
 
 	if (!static_branch_likely(&poly1305_use_avx) ||
 	    (len < (POLY1305_BLOCK_SIZE * 18) && !state->is_base2_26) ||
@@ -104,7 +107,7 @@ static void poly1305_simd_blocks(void *ctx, const u8 *inp, size_t len,
 	}
 
 	do {
-		const size_t bytes = min_t(size_t, len, SZ_4K);
+		const unsigned int bytes = min(len, FPU_BYTES);
 
 		kernel_fpu_begin();
 		if (IS_ENABLED(CONFIG_AS_AVX512) && static_branch_likely(&poly1305_use_avx512))
diff --git a/arch/x86/crypto/polyval-clmulni_glue.c b/arch/x86/crypto/polyval-clmulni_glue.c
index b7664d018851..2502964afef6 100644
--- a/arch/x86/crypto/polyval-clmulni_glue.c
+++ b/arch/x86/crypto/polyval-clmulni_glue.c
@@ -29,6 +29,8 @@
 
 #define NUM_KEY_POWERS	8
 
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+
 struct polyval_tfm_ctx {
 	/*
 	 * These powers must be in the order h^8, ..., h^1.
@@ -123,8 +125,7 @@ static int polyval_x86_update(struct shash_desc *desc,
 	}
 
 	while (srclen >= POLYVAL_BLOCK_SIZE) {
-		/* Allow rescheduling every 4K bytes. */
-		nblocks = min(srclen, 4096U) / POLYVAL_BLOCK_SIZE;
+		nblocks = min(srclen, FPU_BYTES) / POLYVAL_BLOCK_SIZE;
 		internal_polyval_update(tctx, src, nblocks, dctx->buffer);
 		srclen -= nblocks * POLYVAL_BLOCK_SIZE;
 		src += nblocks * POLYVAL_BLOCK_SIZE;
-- 
2.37.3

