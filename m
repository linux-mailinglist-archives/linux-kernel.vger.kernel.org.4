Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED52D5F712C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 00:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiJFWdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 18:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbiJFWcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:32:51 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5360C183EE9;
        Thu,  6 Oct 2022 15:32:40 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296LnmM3028576;
        Thu, 6 Oct 2022 22:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=ndNOQqnDYieYfKjG+Qoea1ejqGoDU1XlffrmRRYeio0=;
 b=H08juEmk79ucPnqWUTDRL+jxWw+p8pbC5dZoMApglOz3bRlvILd7PeL4f4a/gwy8HTIi
 EPzT2fnKFXl6lIsXBOwuZrVX55MRqk+DVXFawnMTI5wfckYwN0WhV+vd1Ek+4X5Gnc3T
 oV/dFApBfnOPvUU7//6JX62JqaTaB14zrzSgj3xwwezEjFDbyGSCPVEziTBtMoh4nTq2
 BP054m5ckuGHpoAHMWWjdx7dw9kR9SvMPLrepktm5E+6+tqPUswcRrmnAGXsD82f+ZqP
 FtWz3KHIvDBR/7dNYwuJ5+uDGYHLqndXJQTH5UuC36Objm7RJQVSzsF5QKIpB9WIIbSG wA== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k27950a2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 22:32:36 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id EA73D806B41;
        Thu,  6 Oct 2022 22:32:30 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id A2560807F19;
        Thu,  6 Oct 2022 22:32:30 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [RFC PATCH 7/7] crypto: x86 - use common macro for FPU limit
Date:   Thu,  6 Oct 2022 17:31:51 -0500
Message-Id: <20221006223151.22159-8-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221006223151.22159-1-elliott@hpe.com>
References: <20221006223151.22159-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: s2EqSClVPHeR83IWeMZ0ZM2Rxs6EgdAQ
X-Proofpoint-GUID: s2EqSClVPHeR83IWeMZ0ZM2Rxs6EgdAQ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_05,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060133
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
 arch/x86/crypto/nhpoly1305-avx2-glue.c |  3 ++-
 arch/x86/crypto/nhpoly1305-sse2-glue.c |  4 +++-
 arch/x86/crypto/poly1305_glue.c        | 25 ++++++++++++++-----------
 arch/x86/crypto/polyval-clmulni_glue.c |  5 +++--
 6 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/arch/x86/crypto/blake2s-glue.c b/arch/x86/crypto/blake2s-glue.c
index a88522e4d0f8..02b72d29dc9b 100644
--- a/arch/x86/crypto/blake2s-glue.c
+++ b/arch/x86/crypto/blake2s-glue.c
@@ -18,6 +18,8 @@
 #include <asm/processor.h>
 #include <asm/simd.h>
 
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+
 asmlinkage void blake2s_compress_ssse3(struct blake2s_state *state,
 				       const u8 *block, const size_t nblocks,
 				       const u32 inc);
@@ -31,8 +33,7 @@ static __ro_after_init DEFINE_STATIC_KEY_FALSE(blake2s_use_avx512);
 void blake2s_compress(struct blake2s_state *state, const u8 *block,
 		      size_t nblocks, const u32 inc)
 {
-	/* SIMD disables preemption, so relax after processing each page. */
-	BUILD_BUG_ON(SZ_4K / BLAKE2S_BLOCK_SIZE < 8);
+	BUILD_BUG_ON(FPU_BYTES / BLAKE2S_BLOCK_SIZE < 8);
 
 	if (!static_branch_likely(&blake2s_use_ssse3) || !may_use_simd()) {
 		blake2s_compress_generic(state, block, nblocks, inc);
@@ -41,7 +42,7 @@ void blake2s_compress(struct blake2s_state *state, const u8 *block,
 
 	do {
 		const size_t blocks = min_t(size_t, nblocks,
-					    SZ_4K / BLAKE2S_BLOCK_SIZE);
+					    FPU_BYTES / BLAKE2S_BLOCK_SIZE);
 
 		kernel_fpu_begin();
 		if (IS_ENABLED(CONFIG_AS_AVX512) &&
diff --git a/arch/x86/crypto/chacha_glue.c b/arch/x86/crypto/chacha_glue.c
index feb53e90f0e3..40ddd0ce50d6 100644
--- a/arch/x86/crypto/chacha_glue.c
+++ b/arch/x86/crypto/chacha_glue.c
@@ -18,6 +18,8 @@
 #include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+
 asmlinkage void chacha_block_xor_ssse3(u32 *state, u8 *dst, const u8 *src,
 				       unsigned int len, int nrounds);
 asmlinkage void chacha_4block_xor_ssse3(u32 *state, u8 *dst, const u8 *src,
@@ -150,7 +152,7 @@ void chacha_crypt_arch(u32 *state, u8 *dst, const u8 *src, unsigned int bytes,
 		return chacha_crypt_generic(state, dst, src, bytes, nrounds);
 
 	do {
-		unsigned int todo = min_t(unsigned int, bytes, SZ_4K);
+		unsigned int todo = min(bytes, FPU_BYTES);
 
 		kernel_fpu_begin();
 		chacha_dosimd(state, dst, src, todo, nrounds);
diff --git a/arch/x86/crypto/nhpoly1305-avx2-glue.c b/arch/x86/crypto/nhpoly1305-avx2-glue.c
index 68cf24213e1c..7e65ccd86f75 100644
--- a/arch/x86/crypto/nhpoly1305-avx2-glue.c
+++ b/arch/x86/crypto/nhpoly1305-avx2-glue.c
@@ -16,6 +16,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
 
 asmlinkage void nh_avx2(const u32 *key, const u8 *message, size_t message_len,
 			u8 hash[NH_HASH_BYTES]);
@@ -34,7 +35,7 @@ static int nhpoly1305_avx2_update(struct shash_desc *desc,
 		return crypto_nhpoly1305_update(desc, src, srclen);
 
 	do {
-		unsigned int n = min_t(unsigned int, srclen, SZ_4K);
+		unsigned int n = min(srclen, FPU_BYTES);
 
 		kernel_fpu_begin();
 		crypto_nhpoly1305_update_helper(desc, src, n, _nh_avx2);
diff --git a/arch/x86/crypto/nhpoly1305-sse2-glue.c b/arch/x86/crypto/nhpoly1305-sse2-glue.c
index 75c324253b37..4f35b52e21f0 100644
--- a/arch/x86/crypto/nhpoly1305-sse2-glue.c
+++ b/arch/x86/crypto/nhpoly1305-sse2-glue.c
@@ -16,6 +16,8 @@
 #include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+
 asmlinkage void nh_sse2(const u32 *key, const u8 *message, size_t message_len,
 			u8 hash[NH_HASH_BYTES]);
 
@@ -33,7 +35,7 @@ static int nhpoly1305_sse2_update(struct shash_desc *desc,
 		return crypto_nhpoly1305_update(desc, src, srclen);
 
 	do {
-		unsigned int n = min_t(unsigned int, srclen, SZ_4K);
+		unsigned int n = min(srclen, FPU_BYTES);
 
 		kernel_fpu_begin();
 		crypto_nhpoly1305_update_helper(desc, src, n, _nh_sse2);
diff --git a/arch/x86/crypto/poly1305_glue.c b/arch/x86/crypto/poly1305_glue.c
index 59d0b01b3389..c036315dbd39 100644
--- a/arch/x86/crypto/poly1305_glue.c
+++ b/arch/x86/crypto/poly1305_glue.c
@@ -18,20 +18,24 @@
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
@@ -89,14 +93,13 @@ static void poly1305_simd_init(void *ctx, const u8 key[POLY1305_BLOCK_SIZE])
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
@@ -107,7 +110,7 @@ static void poly1305_simd_blocks(void *ctx, const u8 *inp, size_t len,
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

