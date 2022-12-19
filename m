Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16EC651548
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbiLSWEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbiLSWDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:03:35 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904AB140D4;
        Mon, 19 Dec 2022 14:03:20 -0800 (PST)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJLIRAa027251;
        Mon, 19 Dec 2022 22:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=z/RHuqgk6c33JWJbpAkTO+kVc65c62TXc795SLcxXos=;
 b=XDIm92EbVglvc35vMp9ryw8mKvdIdK2A4WZ5BtwLCpSHIHdOM2ef1cJDc0MpKRNbQvI1
 UBIlwwkzlyVzP38kQ+uywu1qZAQxWEuKQgee86BKIOpSO7a/jNdGD/iUCBO8GfTZzaXV
 ekrj9WNaDzP+LCUKoK7kIsF3M07LU0vSLU0qB2gw2uxTGyOPB9hfK8WjdEG39h95+NOF
 O/JkD2/WC/yq3PGSWfyHMhbs6blyGuriC8ltJT51XgZmuyCpdnTrRmtl2xI0ekogbTNH
 fI/L6LbYI7Kw6/S8sR78FpbUCkaUTd3OcGaFYi4VA/RffeGP45+US4Tue79pElaZbGZq YA== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3mjyrar6gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 22:02:48 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id DB234310BD;
        Mon, 19 Dec 2022 22:02:47 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 16A9F8052C3;
        Mon, 19 Dec 2022 22:02:47 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, Jason@zx2c4.com,
        ardb@kernel.org, ap420073@gmail.com, David.Laight@ACULAB.COM,
        ebiggers@kernel.org, tim.c.chen@linux.intel.com, peter@n8pjl.ca,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 03/13] crypto: x86/sha - yield FPU context during long loops
Date:   Mon, 19 Dec 2022 16:02:13 -0600
Message-Id: <20221219220223.3982176-4-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219220223.3982176-1-elliott@hpe.com>
References: <20221219220223.3982176-1-elliott@hpe.com>
X-Proofpoint-GUID: MsXbanzF6xtEWQ2FuoUBYmcrUNTB_Ceu
X-Proofpoint-ORIG-GUID: MsXbanzF6xtEWQ2FuoUBYmcrUNTB_Ceu
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190194
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

Periodically check if the kernel scheduler wants to run something
else on the CPU. If so, yield the kernel FPU context and let the
scheduler intervene.

Fixes: 66be89515888 ("crypto: sha1 - SSSE3 based SHA1 implementation for x86-64")
Fixes: 8275d1aa6422 ("crypto: sha256 - Create module providing optimized SHA256 routines using SSSE3, AVX or AVX2 instructions.")
Fixes: 87de4579f92d ("crypto: sha512 - Create module providing optimized SHA512 routines using SSSE3, AVX or AVX2 instructions.")
Fixes: aa031b8f702e ("crypto: x86/sha512 - load based on CPU features")
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/sha1_avx2_x86_64_asm.S |   6 +-
 arch/x86/crypto/sha1_ni_asm.S          |   8 +-
 arch/x86/crypto/sha1_ssse3_glue.c      | 120 ++++++++++++++++++++-----
 arch/x86/crypto/sha256_ni_asm.S        |   8 +-
 arch/x86/crypto/sha256_ssse3_glue.c    | 115 +++++++++++++++++++-----
 arch/x86/crypto/sha512_ssse3_glue.c    |  89 ++++++++++++++----
 6 files changed, 277 insertions(+), 69 deletions(-)

diff --git a/arch/x86/crypto/sha1_avx2_x86_64_asm.S b/arch/x86/crypto/sha1_avx2_x86_64_asm.S
index c3ee9334cb0f..df03fbb2c42c 100644
--- a/arch/x86/crypto/sha1_avx2_x86_64_asm.S
+++ b/arch/x86/crypto/sha1_avx2_x86_64_asm.S
@@ -58,9 +58,9 @@
 /*
  * SHA-1 implementation with Intel(R) AVX2 instruction set extensions.
  *
- *This implementation is based on the previous SSSE3 release:
- *Visit http://software.intel.com/en-us/articles/
- *and refer to improving-the-performance-of-the-secure-hash-algorithm-1/
+ * This implementation is based on the previous SSSE3 release:
+ * Visit http://software.intel.com/en-us/articles/
+ * and refer to improving-the-performance-of-the-secure-hash-algorithm-1/
  *
  */
 
diff --git a/arch/x86/crypto/sha1_ni_asm.S b/arch/x86/crypto/sha1_ni_asm.S
index a69595b033c8..d513b85e242c 100644
--- a/arch/x86/crypto/sha1_ni_asm.S
+++ b/arch/x86/crypto/sha1_ni_asm.S
@@ -75,7 +75,7 @@
 .text
 
 /**
- * sha1_ni_transform - Calculate SHA1 hash using the x86 SHA-NI feature set
+ * sha1_transform_ni - Calculate SHA1 hash using the x86 SHA-NI feature set
  * @digest:	address of current 20-byte hash value (%rdi, DIGEST_PTR macro)
  * @data:	address of data (%rsi, DATA_PTR macro);
  *		data size must be a multiple of 64 bytes
@@ -94,9 +94,9 @@
  * The non-indented lines are instructions related to the message schedule.
  *
  * Return:    none
- * Prototype: asmlinkage void sha1_ni_transform(u32 *digest, const u8 *data, int blocks)
+ * Prototype: asmlinkage void sha1_transform_ni(u32 *digest, const u8 *data, int blocks)
  */
-SYM_TYPED_FUNC_START(sha1_ni_transform)
+SYM_TYPED_FUNC_START(sha1_transform_ni)
 	push		%rbp
 	mov		%rsp, %rbp
 	sub		$FRAME_SIZE, %rsp
@@ -294,7 +294,7 @@ SYM_TYPED_FUNC_START(sha1_ni_transform)
 	pop		%rbp
 
 	RET
-SYM_FUNC_END(sha1_ni_transform)
+SYM_FUNC_END(sha1_transform_ni)
 
 .section	.rodata.cst16.PSHUFFLE_BYTE_FLIP_MASK, "aM", @progbits, 16
 .align 16
diff --git a/arch/x86/crypto/sha1_ssse3_glue.c b/arch/x86/crypto/sha1_ssse3_glue.c
index 44340a1139e0..b269b455fbbe 100644
--- a/arch/x86/crypto/sha1_ssse3_glue.c
+++ b/arch/x86/crypto/sha1_ssse3_glue.c
@@ -41,9 +41,7 @@ static int sha1_update(struct shash_desc *desc, const u8 *data,
 	 */
 	BUILD_BUG_ON(offsetof(struct sha1_state, state) != 0);
 
-	kernel_fpu_begin();
 	sha1_base_do_update(desc, data, len, sha1_xform);
-	kernel_fpu_end();
 
 	return 0;
 }
@@ -54,28 +52,46 @@ static int sha1_finup(struct shash_desc *desc, const u8 *data,
 	if (!crypto_simd_usable())
 		return crypto_sha1_finup(desc, data, len, out);
 
-	kernel_fpu_begin();
 	if (len)
 		sha1_base_do_update(desc, data, len, sha1_xform);
 	sha1_base_do_finalize(desc, sha1_xform);
-	kernel_fpu_end();
 
 	return sha1_base_finish(desc, out);
 }
 
-asmlinkage void sha1_transform_ssse3(struct sha1_state *state,
-				     const u8 *data, int blocks);
+asmlinkage void sha1_transform_ssse3(u32 *digest, const u8 *data, int blocks);
+
+void __sha1_transform_ssse3(struct sha1_state *state, const u8 *data, int blocks)
+{
+	if (blocks <= 0)
+		return;
+
+	kernel_fpu_begin();
+	for (;;) {
+		const int chunks = min(blocks, 4096 / SHA1_BLOCK_SIZE);
+
+		sha1_transform_ssse3(state->state, data, chunks);
+		data += chunks * SHA1_BLOCK_SIZE;
+		blocks -= chunks;
+
+		if (blocks <= 0)
+			break;
+
+		kernel_fpu_yield();
+	}
+	kernel_fpu_end();
+}
 
 static int sha1_ssse3_update(struct shash_desc *desc, const u8 *data,
 			     unsigned int len)
 {
-	return sha1_update(desc, data, len, sha1_transform_ssse3);
+	return sha1_update(desc, data, len, __sha1_transform_ssse3);
 }
 
 static int sha1_ssse3_finup(struct shash_desc *desc, const u8 *data,
 			      unsigned int len, u8 *out)
 {
-	return sha1_finup(desc, data, len, out, sha1_transform_ssse3);
+	return sha1_finup(desc, data, len, out, __sha1_transform_ssse3);
 }
 
 /* Add padding and return the message digest. */
@@ -113,19 +129,39 @@ static void unregister_sha1_ssse3(void)
 		crypto_unregister_shash(&sha1_ssse3_alg);
 }
 
-asmlinkage void sha1_transform_avx(struct sha1_state *state,
-				   const u8 *data, int blocks);
+asmlinkage void sha1_transform_avx(u32 *digest, const u8 *data, int blocks);
+
+void __sha1_transform_avx(struct sha1_state *state, const u8 *data, int blocks)
+{
+	if (blocks <= 0)
+		return;
+
+	kernel_fpu_begin();
+	for (;;) {
+		const int chunks = min(blocks, 4096 / SHA1_BLOCK_SIZE);
+
+		sha1_transform_avx(state->state, data, chunks);
+		data += chunks * SHA1_BLOCK_SIZE;
+		blocks -= chunks;
+
+		if (blocks <= 0)
+			break;
+
+		kernel_fpu_yield();
+	}
+	kernel_fpu_end();
+}
 
 static int sha1_avx_update(struct shash_desc *desc, const u8 *data,
 			     unsigned int len)
 {
-	return sha1_update(desc, data, len, sha1_transform_avx);
+	return sha1_update(desc, data, len, __sha1_transform_avx);
 }
 
 static int sha1_avx_finup(struct shash_desc *desc, const u8 *data,
 			      unsigned int len, u8 *out)
 {
-	return sha1_finup(desc, data, len, out, sha1_transform_avx);
+	return sha1_finup(desc, data, len, out, __sha1_transform_avx);
 }
 
 static int sha1_avx_final(struct shash_desc *desc, u8 *out)
@@ -175,8 +211,28 @@ static void unregister_sha1_avx(void)
 
 #define SHA1_AVX2_BLOCK_OPTSIZE	4	/* optimal 4*64 bytes of SHA1 blocks */
 
-asmlinkage void sha1_transform_avx2(struct sha1_state *state,
-				    const u8 *data, int blocks);
+asmlinkage void sha1_transform_avx2(u32 *digest, const u8 *data, int blocks);
+
+void __sha1_transform_avx2(struct sha1_state *state, const u8 *data, int blocks)
+{
+	if (blocks <= 0)
+		return;
+
+	kernel_fpu_begin();
+	for (;;) {
+		const int chunks = min(blocks, 4096 / SHA1_BLOCK_SIZE);
+
+		sha1_transform_avx2(state->state, data, chunks);
+		data += chunks * SHA1_BLOCK_SIZE;
+		blocks -= chunks;
+
+		if (blocks <= 0)
+			break;
+
+		kernel_fpu_yield();
+	}
+	kernel_fpu_end();
+}
 
 static bool avx2_usable(void)
 {
@@ -193,9 +249,9 @@ static void sha1_apply_transform_avx2(struct sha1_state *state,
 {
 	/* Select the optimal transform based on data block size */
 	if (blocks >= SHA1_AVX2_BLOCK_OPTSIZE)
-		sha1_transform_avx2(state, data, blocks);
+		__sha1_transform_avx2(state, data, blocks);
 	else
-		sha1_transform_avx(state, data, blocks);
+		__sha1_transform_avx(state, data, blocks);
 }
 
 static int sha1_avx2_update(struct shash_desc *desc, const u8 *data,
@@ -245,19 +301,39 @@ static void unregister_sha1_avx2(void)
 }
 
 #ifdef CONFIG_AS_SHA1_NI
-asmlinkage void sha1_ni_transform(struct sha1_state *digest, const u8 *data,
-				  int rounds);
+asmlinkage void sha1_transform_ni(u32 *digest, const u8 *data, int rounds);
+
+void __sha1_transform_ni(struct sha1_state *state, const u8 *data, int blocks)
+{
+	if (blocks <= 0)
+		return;
+
+	kernel_fpu_begin();
+	for (;;) {
+		const int chunks = min(blocks, 4096 / SHA1_BLOCK_SIZE);
+
+		sha1_transform_ni(state->state, data, chunks);
+		data += chunks * SHA1_BLOCK_SIZE;
+		blocks -= chunks;
+
+		if (blocks <= 0)
+			break;
+
+		kernel_fpu_yield();
+	}
+	kernel_fpu_end();
+}
 
 static int sha1_ni_update(struct shash_desc *desc, const u8 *data,
-			     unsigned int len)
+			  unsigned int len)
 {
-	return sha1_update(desc, data, len, sha1_ni_transform);
+	return sha1_update(desc, data, len, __sha1_transform_ni);
 }
 
 static int sha1_ni_finup(struct shash_desc *desc, const u8 *data,
-			      unsigned int len, u8 *out)
+			 unsigned int len, u8 *out)
 {
-	return sha1_finup(desc, data, len, out, sha1_ni_transform);
+	return sha1_finup(desc, data, len, out, __sha1_transform_ni);
 }
 
 static int sha1_ni_final(struct shash_desc *desc, u8 *out)
diff --git a/arch/x86/crypto/sha256_ni_asm.S b/arch/x86/crypto/sha256_ni_asm.S
index e7a3b9939327..29458ec970a9 100644
--- a/arch/x86/crypto/sha256_ni_asm.S
+++ b/arch/x86/crypto/sha256_ni_asm.S
@@ -79,7 +79,7 @@
 .text
 
 /**
- * sha256_ni_transform - Calculate SHA256 hash using the x86 SHA-NI feature set
+ * sha256_transform_ni - Calculate SHA256 hash using the x86 SHA-NI feature set
  * @digest:	address of current 32-byte hash value (%rdi, DIGEST_PTR macro)
  * @data:	address of data (%rsi, DATA_PTR macro);
  *		data size must be a multiple of 64 bytes
@@ -98,9 +98,9 @@
  * The non-indented lines are instructions related to the message schedule.
  *
  * Return:	none
- * Prototype:	asmlinkage void sha256_ni_transform(u32 *digest, const u8 *data, int blocks)
+ * Prototype:	asmlinkage void sha256_transform_ni(u32 *digest, const u8 *data, int blocks)
  */
-SYM_TYPED_FUNC_START(sha256_ni_transform)
+SYM_TYPED_FUNC_START(sha256_transform_ni)
 	shl		$6, NUM_BLKS		/*  convert to bytes */
 	jz		.Ldone_hash
 	add		DATA_PTR, NUM_BLKS	/* pointer to end of data */
@@ -329,7 +329,7 @@ SYM_TYPED_FUNC_START(sha256_ni_transform)
 .Ldone_hash:
 
 	RET
-SYM_FUNC_END(sha256_ni_transform)
+SYM_FUNC_END(sha256_transform_ni)
 
 .section	.rodata.cst256.K256, "aM", @progbits, 256
 .align 64
diff --git a/arch/x86/crypto/sha256_ssse3_glue.c b/arch/x86/crypto/sha256_ssse3_glue.c
index 3a5f6be7dbba..43927cf3d06e 100644
--- a/arch/x86/crypto/sha256_ssse3_glue.c
+++ b/arch/x86/crypto/sha256_ssse3_glue.c
@@ -40,8 +40,28 @@
 #include <linux/string.h>
 #include <asm/simd.h>
 
-asmlinkage void sha256_transform_ssse3(struct sha256_state *state,
-				       const u8 *data, int blocks);
+asmlinkage void sha256_transform_ssse3(u32 *digest, const u8 *data, int blocks);
+
+void __sha256_transform_ssse3(struct sha256_state *state, const u8 *data, int blocks)
+{
+	if (blocks <= 0)
+		return;
+
+	kernel_fpu_begin();
+	for (;;) {
+		const int chunks = min(blocks, 4096 / SHA256_BLOCK_SIZE);
+
+		sha256_transform_ssse3(state->state, data, chunks);
+		data += chunks * SHA256_BLOCK_SIZE;
+		blocks -= chunks;
+
+		if (blocks <= 0)
+			break;
+
+		kernel_fpu_yield();
+	}
+	kernel_fpu_end();
+}
 
 static int _sha256_update(struct shash_desc *desc, const u8 *data,
 			  unsigned int len, sha256_block_fn *sha256_xform)
@@ -58,9 +78,7 @@ static int _sha256_update(struct shash_desc *desc, const u8 *data,
 	 */
 	BUILD_BUG_ON(offsetof(struct sha256_state, state) != 0);
 
-	kernel_fpu_begin();
 	sha256_base_do_update(desc, data, len, sha256_xform);
-	kernel_fpu_end();
 
 	return 0;
 }
@@ -71,11 +89,9 @@ static int sha256_finup(struct shash_desc *desc, const u8 *data,
 	if (!crypto_simd_usable())
 		return crypto_sha256_finup(desc, data, len, out);
 
-	kernel_fpu_begin();
 	if (len)
 		sha256_base_do_update(desc, data, len, sha256_xform);
 	sha256_base_do_finalize(desc, sha256_xform);
-	kernel_fpu_end();
 
 	return sha256_base_finish(desc, out);
 }
@@ -83,13 +99,13 @@ static int sha256_finup(struct shash_desc *desc, const u8 *data,
 static int sha256_ssse3_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
 {
-	return _sha256_update(desc, data, len, sha256_transform_ssse3);
+	return _sha256_update(desc, data, len, __sha256_transform_ssse3);
 }
 
 static int sha256_ssse3_finup(struct shash_desc *desc, const u8 *data,
 	      unsigned int len, u8 *out)
 {
-	return sha256_finup(desc, data, len, out, sha256_transform_ssse3);
+	return sha256_finup(desc, data, len, out, __sha256_transform_ssse3);
 }
 
 /* Add padding and return the message digest. */
@@ -143,19 +159,39 @@ static void unregister_sha256_ssse3(void)
 				ARRAY_SIZE(sha256_ssse3_algs));
 }
 
-asmlinkage void sha256_transform_avx(struct sha256_state *state,
-				     const u8 *data, int blocks);
+asmlinkage void sha256_transform_avx(u32 *digest, const u8 *data, int blocks);
+
+void __sha256_transform_avx(struct sha256_state *state, const u8 *data, int blocks)
+{
+	if (blocks <= 0)
+		return;
+
+	kernel_fpu_begin();
+	for (;;) {
+		const int chunks = min(blocks, 4096 / SHA256_BLOCK_SIZE);
+
+		sha256_transform_avx(state->state, data, chunks);
+		data += chunks * SHA256_BLOCK_SIZE;
+		blocks -= chunks;
+
+		if (blocks <= 0)
+			break;
+
+		kernel_fpu_yield();
+	}
+	kernel_fpu_end();
+}
 
 static int sha256_avx_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
 {
-	return _sha256_update(desc, data, len, sha256_transform_avx);
+	return _sha256_update(desc, data, len, __sha256_transform_avx);
 }
 
 static int sha256_avx_finup(struct shash_desc *desc, const u8 *data,
 		      unsigned int len, u8 *out)
 {
-	return sha256_finup(desc, data, len, out, sha256_transform_avx);
+	return sha256_finup(desc, data, len, out, __sha256_transform_avx);
 }
 
 static int sha256_avx_final(struct shash_desc *desc, u8 *out)
@@ -219,19 +255,39 @@ static void unregister_sha256_avx(void)
 				ARRAY_SIZE(sha256_avx_algs));
 }
 
-asmlinkage void sha256_transform_rorx(struct sha256_state *state,
-				      const u8 *data, int blocks);
+asmlinkage void sha256_transform_rorx(u32 *state, const u8 *data, int blocks);
+
+void __sha256_transform_avx2(struct sha256_state *state, const u8 *data, int blocks)
+{
+	if (blocks <= 0)
+		return;
+
+	kernel_fpu_begin();
+	for (;;) {
+		const int chunks = min(blocks, 4096 / SHA256_BLOCK_SIZE);
+
+		sha256_transform_rorx(state->state, data, chunks);
+		data += chunks * SHA256_BLOCK_SIZE;
+		blocks -= chunks;
+
+		if (blocks <= 0)
+			break;
+
+		kernel_fpu_yield();
+	}
+	kernel_fpu_end();
+}
 
 static int sha256_avx2_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
 {
-	return _sha256_update(desc, data, len, sha256_transform_rorx);
+	return _sha256_update(desc, data, len, __sha256_transform_avx2);
 }
 
 static int sha256_avx2_finup(struct shash_desc *desc, const u8 *data,
 		      unsigned int len, u8 *out)
 {
-	return sha256_finup(desc, data, len, out, sha256_transform_rorx);
+	return sha256_finup(desc, data, len, out, __sha256_transform_avx2);
 }
 
 static int sha256_avx2_final(struct shash_desc *desc, u8 *out)
@@ -294,19 +350,38 @@ static void unregister_sha256_avx2(void)
 }
 
 #ifdef CONFIG_AS_SHA256_NI
-asmlinkage void sha256_ni_transform(struct sha256_state *digest,
-				    const u8 *data, int rounds);
+asmlinkage void sha256_transform_ni(u32 *digest, const u8 *data, int rounds);
+
+void __sha256_transform_ni(struct sha256_state *state, const u8 *data, int blocks)
+{
+	if (blocks <= 0)
+		return;
+
+	kernel_fpu_begin();
+	for (;;) {
+		const int chunks = min(blocks, 4096 / SHA256_BLOCK_SIZE);
 
+		sha256_transform_ni(state->state, data, chunks);
+		data += chunks * SHA256_BLOCK_SIZE;
+		blocks -= chunks;
+
+		if (blocks <= 0)
+			break;
+
+		kernel_fpu_yield();
+	}
+	kernel_fpu_end();
+}
 static int sha256_ni_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
 {
-	return _sha256_update(desc, data, len, sha256_ni_transform);
+	return _sha256_update(desc, data, len, __sha256_transform_ni);
 }
 
 static int sha256_ni_finup(struct shash_desc *desc, const u8 *data,
 		      unsigned int len, u8 *out)
 {
-	return sha256_finup(desc, data, len, out, sha256_ni_transform);
+	return sha256_finup(desc, data, len, out, __sha256_transform_ni);
 }
 
 static int sha256_ni_final(struct shash_desc *desc, u8 *out)
diff --git a/arch/x86/crypto/sha512_ssse3_glue.c b/arch/x86/crypto/sha512_ssse3_glue.c
index 6d3b85e53d0e..cb6aad9d5052 100644
--- a/arch/x86/crypto/sha512_ssse3_glue.c
+++ b/arch/x86/crypto/sha512_ssse3_glue.c
@@ -39,8 +39,28 @@
 #include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
-asmlinkage void sha512_transform_ssse3(struct sha512_state *state,
-				       const u8 *data, int blocks);
+asmlinkage void sha512_transform_ssse3(u64 *digest, const u8 *data, int blocks);
+
+void __sha512_transform_ssse3(struct sha512_state *state, const u8 *data, int blocks)
+{
+	if (blocks <= 0)
+		return;
+
+	kernel_fpu_begin();
+	for (;;) {
+		const int chunks = min(blocks, 4096 / SHA512_BLOCK_SIZE);
+
+		sha512_transform_ssse3(&state->state[0], data, chunks);
+		data += chunks * SHA512_BLOCK_SIZE;
+		blocks -= chunks;
+
+		if (blocks <= 0)
+			break;
+
+		kernel_fpu_yield();
+	}
+	kernel_fpu_end();
+}
 
 static int sha512_update(struct shash_desc *desc, const u8 *data,
 		       unsigned int len, sha512_block_fn *sha512_xform)
@@ -57,9 +77,7 @@ static int sha512_update(struct shash_desc *desc, const u8 *data,
 	 */
 	BUILD_BUG_ON(offsetof(struct sha512_state, state) != 0);
 
-	kernel_fpu_begin();
 	sha512_base_do_update(desc, data, len, sha512_xform);
-	kernel_fpu_end();
 
 	return 0;
 }
@@ -70,11 +88,9 @@ static int sha512_finup(struct shash_desc *desc, const u8 *data,
 	if (!crypto_simd_usable())
 		return crypto_sha512_finup(desc, data, len, out);
 
-	kernel_fpu_begin();
 	if (len)
 		sha512_base_do_update(desc, data, len, sha512_xform);
 	sha512_base_do_finalize(desc, sha512_xform);
-	kernel_fpu_end();
 
 	return sha512_base_finish(desc, out);
 }
@@ -82,13 +98,13 @@ static int sha512_finup(struct shash_desc *desc, const u8 *data,
 static int sha512_ssse3_update(struct shash_desc *desc, const u8 *data,
 		       unsigned int len)
 {
-	return sha512_update(desc, data, len, sha512_transform_ssse3);
+	return sha512_update(desc, data, len, __sha512_transform_ssse3);
 }
 
 static int sha512_ssse3_finup(struct shash_desc *desc, const u8 *data,
 	      unsigned int len, u8 *out)
 {
-	return sha512_finup(desc, data, len, out, sha512_transform_ssse3);
+	return sha512_finup(desc, data, len, out, __sha512_transform_ssse3);
 }
 
 /* Add padding and return the message digest. */
@@ -142,8 +158,29 @@ static void unregister_sha512_ssse3(void)
 			ARRAY_SIZE(sha512_ssse3_algs));
 }
 
-asmlinkage void sha512_transform_avx(struct sha512_state *state,
-				     const u8 *data, int blocks);
+asmlinkage void sha512_transform_avx(u64 *digest, const u8 *data, int blocks);
+
+void __sha512_transform_avx(struct sha512_state *state, const u8 *data, int blocks)
+{
+	if (blocks <= 0)
+		return;
+
+	kernel_fpu_begin();
+	for (;;) {
+		const int chunks = min(blocks, 4096 / SHA512_BLOCK_SIZE);
+
+		sha512_transform_avx(state->state, data, chunks);
+		data += chunks * SHA512_BLOCK_SIZE;
+		blocks -= chunks;
+
+		if (blocks <= 0)
+			break;
+
+		kernel_fpu_yield();
+	}
+	kernel_fpu_end();
+}
+
 static bool avx_usable(void)
 {
 	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
@@ -158,13 +195,13 @@ static bool avx_usable(void)
 static int sha512_avx_update(struct shash_desc *desc, const u8 *data,
 		       unsigned int len)
 {
-	return sha512_update(desc, data, len, sha512_transform_avx);
+	return sha512_update(desc, data, len, __sha512_transform_avx);
 }
 
 static int sha512_avx_finup(struct shash_desc *desc, const u8 *data,
 	      unsigned int len, u8 *out)
 {
-	return sha512_finup(desc, data, len, out, sha512_transform_avx);
+	return sha512_finup(desc, data, len, out, __sha512_transform_avx);
 }
 
 /* Add padding and return the message digest. */
@@ -218,19 +255,39 @@ static void unregister_sha512_avx(void)
 			ARRAY_SIZE(sha512_avx_algs));
 }
 
-asmlinkage void sha512_transform_rorx(struct sha512_state *state,
-				      const u8 *data, int blocks);
+asmlinkage void sha512_transform_rorx(u64 *digest, const u8 *data, int blocks);
+
+void __sha512_transform_avx2(struct sha512_state *state, const u8 *data, int blocks)
+{
+	if (blocks <= 0)
+		return;
+
+	kernel_fpu_begin();
+	for (;;) {
+		const int chunks = min(blocks, 4096 / SHA512_BLOCK_SIZE);
+
+		sha512_transform_rorx(state->state, data, chunks);
+		data += chunks * SHA512_BLOCK_SIZE;
+		blocks -= chunks;
+
+		if (blocks <= 0)
+			break;
+
+		kernel_fpu_yield();
+	}
+	kernel_fpu_end();
+}
 
 static int sha512_avx2_update(struct shash_desc *desc, const u8 *data,
 		       unsigned int len)
 {
-	return sha512_update(desc, data, len, sha512_transform_rorx);
+	return sha512_update(desc, data, len, __sha512_transform_avx2);
 }
 
 static int sha512_avx2_finup(struct shash_desc *desc, const u8 *data,
 	      unsigned int len, u8 *out)
 {
-	return sha512_finup(desc, data, len, out, sha512_transform_rorx);
+	return sha512_finup(desc, data, len, out, __sha512_transform_avx2);
 }
 
 /* Add padding and return the message digest. */
-- 
2.38.1

