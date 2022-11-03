Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE00617587
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiKCE3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiKCE2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:28:41 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0B112D04;
        Wed,  2 Nov 2022 21:28:27 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A33lb3J022608;
        Thu, 3 Nov 2022 04:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=vGuZr0PXmKpbWf3/OrUXsKYrtliLKtgqLvbd1+feraQ=;
 b=j+SL+nUOLN77H9p6xAu0tpDGP7/UdH5eL4rB4OYmHNA0FalTsCw60Ma/2V2kC3vDfUxw
 FstMrTLoZf7pQxeY2e/xJGF7erD672CMuC86WgNzfzvn7GzexrBr1+/mulnhcmGUbWNG
 TmwA0EpcwBn/tXJ6xxtSqQ7HcAdegCNT8/mxpI7aYeSRdVyKI3fQnVz2mkLV2yb6iOIu
 j3oyX45Lti7UEkv4lsDjKFYFwn8S9WmvZhnHU+j5FgOHT488zABISVXsHcm6sWhlJ6HA
 3cpu1fjhALECtRhJ6kTqqthFvW9gX20YSweXbHnZXiz8OBiPnfW/BrzbW/vyq6DI5s7m pQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3km624r8w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 04:28:18 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 7CD55806B55;
        Thu,  3 Nov 2022 04:28:17 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 0AAC0802B9C;
        Thu,  3 Nov 2022 04:28:17 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 10/17] crypto: x86/*poly* - limit FPU preemption
Date:   Wed,  2 Nov 2022 23:27:33 -0500
Message-Id: <20221103042740.6556-11-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221103042740.6556-1-elliott@hpe.com>
References: <20221012215931.3896-1-elliott@hpe.com>
 <20221103042740.6556-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HS5GeoggHc905C5YyySEte_unMXZTT8I
X-Proofpoint-GUID: HS5GeoggHc905C5YyySEte_unMXZTT8I
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030031
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a static const unsigned int for the limit of the number of bytes
processed between kernel_fpu_begin() and kernel_fpu_end() rather than
using the SZ_4K macro (which is a signed value), or a magic value
of 4096U embedded in the C code.

Use unsigned int rather than size_t for some of the arguments to
avoid typecasting for the min() macro.

Signed-off-by: Robert Elliott <elliott@hpe.com>

---
v3 use static int rather than macro, change to while loops
rather than do/while loops
---
 arch/x86/crypto/nhpoly1305-avx2-glue.c | 11 +++++---
 arch/x86/crypto/nhpoly1305-sse2-glue.c | 11 +++++---
 arch/x86/crypto/poly1305_glue.c        | 37 +++++++++++++++++---------
 arch/x86/crypto/polyval-clmulni_glue.c |  8 ++++--
 4 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/arch/x86/crypto/nhpoly1305-avx2-glue.c b/arch/x86/crypto/nhpoly1305-avx2-glue.c
index 8ea5ab0f1ca7..f7dc9c563bb5 100644
--- a/arch/x86/crypto/nhpoly1305-avx2-glue.c
+++ b/arch/x86/crypto/nhpoly1305-avx2-glue.c
@@ -13,6 +13,9 @@
 #include <linux/sizes.h>
 #include <asm/simd.h>
 
+/* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+static const unsigned int bytes_per_fpu = 337 * 1024;
+
 asmlinkage void nh_avx2(const u32 *key, const u8 *message, size_t message_len,
 			u8 hash[NH_HASH_BYTES]);
 
@@ -26,18 +29,20 @@ static void _nh_avx2(const u32 *key, const u8 *message, size_t message_len,
 static int nhpoly1305_avx2_update(struct shash_desc *desc,
 				  const u8 *src, unsigned int srclen)
 {
+	BUILD_BUG_ON(bytes_per_fpu == 0);
+
 	if (srclen < 64 || !crypto_simd_usable())
 		return crypto_nhpoly1305_update(desc, src, srclen);
 
-	do {
-		unsigned int n = min_t(unsigned int, srclen, SZ_4K);
+	while (srclen) {
+		unsigned int n = min(srclen, bytes_per_fpu);
 
 		kernel_fpu_begin();
 		crypto_nhpoly1305_update_helper(desc, src, n, _nh_avx2);
 		kernel_fpu_end();
 		src += n;
 		srclen -= n;
-	} while (srclen);
+	}
 	return 0;
 }
 
diff --git a/arch/x86/crypto/nhpoly1305-sse2-glue.c b/arch/x86/crypto/nhpoly1305-sse2-glue.c
index 2b353d42ed13..daffcc7019ad 100644
--- a/arch/x86/crypto/nhpoly1305-sse2-glue.c
+++ b/arch/x86/crypto/nhpoly1305-sse2-glue.c
@@ -13,6 +13,9 @@
 #include <linux/sizes.h>
 #include <asm/simd.h>
 
+/* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+static const unsigned int bytes_per_fpu = 199 * 1024;
+
 asmlinkage void nh_sse2(const u32 *key, const u8 *message, size_t message_len,
 			u8 hash[NH_HASH_BYTES]);
 
@@ -26,18 +29,20 @@ static void _nh_sse2(const u32 *key, const u8 *message, size_t message_len,
 static int nhpoly1305_sse2_update(struct shash_desc *desc,
 				  const u8 *src, unsigned int srclen)
 {
+	BUILD_BUG_ON(bytes_per_fpu == 0);
+
 	if (srclen < 64 || !crypto_simd_usable())
 		return crypto_nhpoly1305_update(desc, src, srclen);
 
-	do {
-		unsigned int n = min_t(unsigned int, srclen, SZ_4K);
+	while (srclen) {
+		unsigned int n = min(srclen, bytes_per_fpu);
 
 		kernel_fpu_begin();
 		crypto_nhpoly1305_update_helper(desc, src, n, _nh_sse2);
 		kernel_fpu_end();
 		src += n;
 		srclen -= n;
-	} while (srclen);
+	}
 	return 0;
 }
 
diff --git a/arch/x86/crypto/poly1305_glue.c b/arch/x86/crypto/poly1305_glue.c
index 1dfb8af48a3c..16831c036d71 100644
--- a/arch/x86/crypto/poly1305_glue.c
+++ b/arch/x86/crypto/poly1305_glue.c
@@ -15,20 +15,27 @@
 #include <asm/intel-family.h>
 #include <asm/simd.h>
 
+#define POLY1305_BLOCK_SIZE_MASK (~(POLY1305_BLOCK_SIZE - 1))
+
+/* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+static const unsigned int bytes_per_fpu = 217 * 1024;
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
@@ -86,14 +93,12 @@ static void poly1305_simd_init(void *ctx, const u8 key[POLY1305_BLOCK_SIZE])
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
+	BUILD_BUG_ON(bytes_per_fpu < POLY1305_BLOCK_SIZE);
 
 	if (!static_branch_likely(&poly1305_use_avx) ||
 	    (len < (POLY1305_BLOCK_SIZE * 18) && !state->is_base2_26) ||
@@ -103,8 +108,14 @@ static void poly1305_simd_blocks(void *ctx, const u8 *inp, size_t len,
 		return;
 	}
 
-	do {
-		const size_t bytes = min_t(size_t, len, SZ_4K);
+	while (len) {
+		unsigned int bytes;
+
+		if (len < POLY1305_BLOCK_SIZE)
+			bytes = len;
+		else
+			bytes = min(len,
+				    bytes_per_fpu & POLY1305_BLOCK_SIZE_MASK);
 
 		kernel_fpu_begin();
 		if (IS_ENABLED(CONFIG_AS_AVX512) && static_branch_likely(&poly1305_use_avx512))
@@ -117,7 +128,7 @@ static void poly1305_simd_blocks(void *ctx, const u8 *inp, size_t len,
 
 		len -= bytes;
 		inp += bytes;
-	} while (len);
+	}
 }
 
 static void poly1305_simd_emit(void *ctx, u8 mac[POLY1305_DIGEST_SIZE],
diff --git a/arch/x86/crypto/polyval-clmulni_glue.c b/arch/x86/crypto/polyval-clmulni_glue.c
index b7664d018851..de1c908f7412 100644
--- a/arch/x86/crypto/polyval-clmulni_glue.c
+++ b/arch/x86/crypto/polyval-clmulni_glue.c
@@ -29,6 +29,9 @@
 
 #define NUM_KEY_POWERS	8
 
+/* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+static const unsigned int bytes_per_fpu = 393 * 1024;
+
 struct polyval_tfm_ctx {
 	/*
 	 * These powers must be in the order h^8, ..., h^1.
@@ -107,6 +110,8 @@ static int polyval_x86_update(struct shash_desc *desc,
 	unsigned int nblocks;
 	unsigned int n;
 
+	BUILD_BUG_ON(bytes_per_fpu < POLYVAL_BLOCK_SIZE);
+
 	if (dctx->bytes) {
 		n = min(srclen, dctx->bytes);
 		pos = dctx->buffer + POLYVAL_BLOCK_SIZE - dctx->bytes;
@@ -123,8 +128,7 @@ static int polyval_x86_update(struct shash_desc *desc,
 	}
 
 	while (srclen >= POLYVAL_BLOCK_SIZE) {
-		/* Allow rescheduling every 4K bytes. */
-		nblocks = min(srclen, 4096U) / POLYVAL_BLOCK_SIZE;
+		nblocks = min(srclen, bytes_per_fpu) / POLYVAL_BLOCK_SIZE;
 		internal_polyval_update(tctx, src, nblocks, dctx->buffer);
 		srclen -= nblocks * POLYVAL_BLOCK_SIZE;
 		src += nblocks * POLYVAL_BLOCK_SIZE;
-- 
2.37.3

