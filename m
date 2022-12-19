Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D0D651530
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiLSWDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbiLSWDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:03:18 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E541409D;
        Mon, 19 Dec 2022 14:03:17 -0800 (PST)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJJqpHh022240;
        Mon, 19 Dec 2022 22:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=p9JbhkqMPpi3fDjAvwBFoPmQr84CYKUu0cOLpCX7Oos=;
 b=R8vnhzElii1PpLsbNT17v0Pq13SNkh97OdCOMmYK3gZBqg08UIHuF8KB2TCKL05kimPn
 cWrDjYCmo1i+csmB9g8RtK1/xDCphuS5drdfTPT4tUjQZJk08kDb/KSre7BqA/gX8Crf
 1TVQtBiuLqKbbVZWS95OfUqk+MBBXSesV3eeXM58KL8ioG+bBi6amFu0AeNZUAMhBEKP
 2rQvfcM2jrYvZBixCyOWLtKk87bXFExdBs2MFUoYHJCWFGvNmLn207QGxZv9fnSDOS6+
 wgol+YeZCK5INUMepxHDXYQs7fCJxoAiNjGwt+o4AHl0mcXuERH+5XhV7MMOaHjmkNPU 0w== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3mjx3b10xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 22:02:58 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 01CFA807130;
        Mon, 19 Dec 2022 22:02:57 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 33578805634;
        Mon, 19 Dec 2022 22:02:57 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, Jason@zx2c4.com,
        ardb@kernel.org, ap420073@gmail.com, David.Laight@ACULAB.COM,
        ebiggers@kernel.org, tim.c.chen@linux.intel.com, peter@n8pjl.ca,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 09/13] crypto: x86/poly - yield FPU context only when needed
Date:   Mon, 19 Dec 2022 16:02:19 -0600
Message-Id: <20221219220223.3982176-10-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219220223.3982176-1-elliott@hpe.com>
References: <20221219220223.3982176-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: twEmfStn_S24aIZ0bUsjbvnDIt-5xTZA
X-Proofpoint-GUID: twEmfStn_S24aIZ0bUsjbvnDIt-5xTZA
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212190193
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The x86 assembly language implementations using SIMD process data
between kernel_fpu_begin() and kernel_fpu_end() calls. That
disables scheduler preemption, so prevents the CPU core from being
used by other threads.

The update() and finup() functions might be called to process
large quantities of data, which can result in RCU stalls and
soft lockups.

Rather than break the processing into 4 KiB passes, each of which
unilaterally calls kernel_fpu_begin() and kernel_fpu_end(),
periodically check if the kernel scheduler wants to run something
else on the CPU. If so, yield the kernel FPU context and let the
scheduler intervene.

Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/nhpoly1305-avx2-glue.c | 22 +++++++-----
 arch/x86/crypto/nhpoly1305-sse2-glue.c | 22 +++++++-----
 arch/x86/crypto/poly1305_glue.c        | 47 ++++++++++++--------------
 arch/x86/crypto/polyval-clmulni_glue.c | 46 +++++++++++++++----------
 4 files changed, 79 insertions(+), 58 deletions(-)

diff --git a/arch/x86/crypto/nhpoly1305-avx2-glue.c b/arch/x86/crypto/nhpoly1305-avx2-glue.c
index 46b036204ed9..4afbfd35afda 100644
--- a/arch/x86/crypto/nhpoly1305-avx2-glue.c
+++ b/arch/x86/crypto/nhpoly1305-avx2-glue.c
@@ -22,15 +22,21 @@ static int nhpoly1305_avx2_update(struct shash_desc *desc,
 	if (srclen < 64 || !crypto_simd_usable())
 		return crypto_nhpoly1305_update(desc, src, srclen);
 
-	do {
-		unsigned int n = min_t(unsigned int, srclen, SZ_4K);
+	kernel_fpu_begin();
+	for (;;) {
+		const unsigned int chunk = min(srclen, 4096U);
+
+		crypto_nhpoly1305_update_helper(desc, src, chunk, nh_avx2);
+		srclen -= chunk;
+
+		if (!srclen)
+			break;
+
+		src += chunk;
+		kernel_fpu_yield();
+	}
+	kernel_fpu_end();
 
-		kernel_fpu_begin();
-		crypto_nhpoly1305_update_helper(desc, src, n, nh_avx2);
-		kernel_fpu_end();
-		src += n;
-		srclen -= n;
-	} while (srclen);
 	return 0;
 }
 
diff --git a/arch/x86/crypto/nhpoly1305-sse2-glue.c b/arch/x86/crypto/nhpoly1305-sse2-glue.c
index 4a4970d75107..f5c757f6f781 100644
--- a/arch/x86/crypto/nhpoly1305-sse2-glue.c
+++ b/arch/x86/crypto/nhpoly1305-sse2-glue.c
@@ -22,15 +22,21 @@ static int nhpoly1305_sse2_update(struct shash_desc *desc,
 	if (srclen < 64 || !crypto_simd_usable())
 		return crypto_nhpoly1305_update(desc, src, srclen);
 
-	do {
-		unsigned int n = min_t(unsigned int, srclen, SZ_4K);
+	kernel_fpu_begin();
+	for (;;) {
+		const unsigned int chunk = min(srclen, 4096U);
+
+		crypto_nhpoly1305_update_helper(desc, src, chunk, nh_sse2);
+		srclen -= chunk;
+
+		if (!srclen)
+			break;
+
+		src += chunk;
+		kernel_fpu_yield();
+	}
+	kernel_fpu_end();
 
-		kernel_fpu_begin();
-		crypto_nhpoly1305_update_helper(desc, src, n, nh_sse2);
-		kernel_fpu_end();
-		src += n;
-		srclen -= n;
-	} while (srclen);
 	return 0;
 }
 
diff --git a/arch/x86/crypto/poly1305_glue.c b/arch/x86/crypto/poly1305_glue.c
index 1dfb8af48a3c..13e2e134b458 100644
--- a/arch/x86/crypto/poly1305_glue.c
+++ b/arch/x86/crypto/poly1305_glue.c
@@ -15,20 +15,13 @@
 #include <asm/intel-family.h>
 #include <asm/simd.h>
 
-asmlinkage void poly1305_init_x86_64(void *ctx,
-				     const u8 key[POLY1305_BLOCK_SIZE]);
-asmlinkage void poly1305_blocks_x86_64(void *ctx, const u8 *inp,
-				       const size_t len, const u32 padbit);
-asmlinkage void poly1305_emit_x86_64(void *ctx, u8 mac[POLY1305_DIGEST_SIZE],
-				     const u32 nonce[4]);
-asmlinkage void poly1305_emit_avx(void *ctx, u8 mac[POLY1305_DIGEST_SIZE],
-				  const u32 nonce[4]);
-asmlinkage void poly1305_blocks_avx(void *ctx, const u8 *inp, const size_t len,
-				    const u32 padbit);
-asmlinkage void poly1305_blocks_avx2(void *ctx, const u8 *inp, const size_t len,
-				     const u32 padbit);
-asmlinkage void poly1305_blocks_avx512(void *ctx, const u8 *inp,
-				       const size_t len, const u32 padbit);
+asmlinkage void poly1305_init_x86_64(void *ctx, const u8 key[POLY1305_BLOCK_SIZE]);
+asmlinkage void poly1305_blocks_x86_64(void *ctx, const u8 *inp, unsigned int len, u32 padbit);
+asmlinkage void poly1305_emit_x86_64(void *ctx, u8 mac[POLY1305_DIGEST_SIZE], const u32 nonce[4]);
+asmlinkage void poly1305_emit_avx(void *ctx, u8 mac[POLY1305_DIGEST_SIZE], const u32 nonce[4]);
+asmlinkage void poly1305_blocks_avx(void *ctx, const u8 *inp, unsigned int len, const u32 padbit);
+asmlinkage void poly1305_blocks_avx2(void *ctx, const u8 *inp, unsigned int len, u32 padbit);
+asmlinkage void poly1305_blocks_avx512(void *ctx, const u8 *inp, unsigned int len, u32 padbit);
 
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(poly1305_use_avx);
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(poly1305_use_avx2);
@@ -86,7 +79,7 @@ static void poly1305_simd_init(void *ctx, const u8 key[POLY1305_BLOCK_SIZE])
 	poly1305_init_x86_64(ctx, key);
 }
 
-static void poly1305_simd_blocks(void *ctx, const u8 *inp, size_t len,
+static void poly1305_simd_blocks(void *ctx, const u8 *inp, unsigned int len,
 				 const u32 padbit)
 {
 	struct poly1305_arch_internal *state = ctx;
@@ -103,21 +96,25 @@ static void poly1305_simd_blocks(void *ctx, const u8 *inp, size_t len,
 		return;
 	}
 
-	do {
-		const size_t bytes = min_t(size_t, len, SZ_4K);
+	kernel_fpu_begin();
+	for (;;) {
+		const unsigned int chunk = min(len, 4096U);
 
-		kernel_fpu_begin();
 		if (IS_ENABLED(CONFIG_AS_AVX512) && static_branch_likely(&poly1305_use_avx512))
-			poly1305_blocks_avx512(ctx, inp, bytes, padbit);
+			poly1305_blocks_avx512(ctx, inp, chunk, padbit);
 		else if (static_branch_likely(&poly1305_use_avx2))
-			poly1305_blocks_avx2(ctx, inp, bytes, padbit);
+			poly1305_blocks_avx2(ctx, inp, chunk, padbit);
 		else
-			poly1305_blocks_avx(ctx, inp, bytes, padbit);
-		kernel_fpu_end();
+			poly1305_blocks_avx(ctx, inp, chunk, padbit);
+		len -= chunk;
 
-		len -= bytes;
-		inp += bytes;
-	} while (len);
+		if (!len)
+			break;
+
+		inp += chunk;
+		kernel_fpu_yield();
+	}
+	kernel_fpu_end();
 }
 
 static void poly1305_simd_emit(void *ctx, u8 mac[POLY1305_DIGEST_SIZE],
diff --git a/arch/x86/crypto/polyval-clmulni_glue.c b/arch/x86/crypto/polyval-clmulni_glue.c
index 8fa58b0f3cb3..a3d72e87d58d 100644
--- a/arch/x86/crypto/polyval-clmulni_glue.c
+++ b/arch/x86/crypto/polyval-clmulni_glue.c
@@ -45,8 +45,8 @@ struct polyval_desc_ctx {
 	u32 bytes;
 };
 
-asmlinkage void clmul_polyval_update(const struct polyval_tfm_ctx *keys,
-	const u8 *in, size_t nblocks, u8 *accumulator);
+asmlinkage void clmul_polyval_update(const struct polyval_tfm_ctx *keys, const u8 *in,
+				     unsigned int nblocks, u8 *accumulator);
 asmlinkage void clmul_polyval_mul(u8 *op1, const u8 *op2);
 
 static inline struct polyval_tfm_ctx *polyval_tfm_ctx(struct crypto_shash *tfm)
@@ -55,27 +55,40 @@ static inline struct polyval_tfm_ctx *polyval_tfm_ctx(struct crypto_shash *tfm)
 }
 
 static void internal_polyval_update(const struct polyval_tfm_ctx *keys,
-	const u8 *in, size_t nblocks, u8 *accumulator)
+	const u8 *in, unsigned int nblocks, u8 *accumulator)
 {
-	if (likely(crypto_simd_usable())) {
-		kernel_fpu_begin();
-		clmul_polyval_update(keys, in, nblocks, accumulator);
-		kernel_fpu_end();
-	} else {
+	if (!crypto_simd_usable()) {
 		polyval_update_non4k(keys->key_powers[NUM_KEY_POWERS-1], in,
 			nblocks, accumulator);
+		return;
 	}
+
+	kernel_fpu_begin();
+	for (;;) {
+		const unsigned int chunks = min(nblocks, 4096U / POLYVAL_BLOCK_SIZE);
+
+		clmul_polyval_update(keys, in, chunks, accumulator);
+		nblocks -= chunks;
+
+		if (!nblocks)
+			break;
+
+		in += chunks * POLYVAL_BLOCK_SIZE;
+		kernel_fpu_yield();
+	}
+	kernel_fpu_end();
 }
 
 static void internal_polyval_mul(u8 *op1, const u8 *op2)
 {
-	if (likely(crypto_simd_usable())) {
-		kernel_fpu_begin();
-		clmul_polyval_mul(op1, op2);
-		kernel_fpu_end();
-	} else {
+	if (!crypto_simd_usable()) {
 		polyval_mul_non4k(op1, op2);
+		return;
 	}
+
+	kernel_fpu_begin();
+	clmul_polyval_mul(op1, op2);
+	kernel_fpu_end();
 }
 
 static int polyval_x86_setkey(struct crypto_shash *tfm,
@@ -113,7 +126,6 @@ static int polyval_x86_update(struct shash_desc *desc,
 	struct polyval_desc_ctx *dctx = shash_desc_ctx(desc);
 	const struct polyval_tfm_ctx *tctx = polyval_tfm_ctx(desc->tfm);
 	u8 *pos;
-	unsigned int nblocks;
 	unsigned int n;
 
 	if (dctx->bytes) {
@@ -131,9 +143,9 @@ static int polyval_x86_update(struct shash_desc *desc,
 					    tctx->key_powers[NUM_KEY_POWERS-1]);
 	}
 
-	while (srclen >= POLYVAL_BLOCK_SIZE) {
-		/* Allow rescheduling every 4K bytes. */
-		nblocks = min(srclen, 4096U) / POLYVAL_BLOCK_SIZE;
+	if (srclen >= POLYVAL_BLOCK_SIZE) {
+		const unsigned int nblocks = srclen / POLYVAL_BLOCK_SIZE;
+
 		internal_polyval_update(tctx, src, nblocks, dctx->buffer);
 		srclen -= nblocks * POLYVAL_BLOCK_SIZE;
 		src += nblocks * POLYVAL_BLOCK_SIZE;
-- 
2.38.1

