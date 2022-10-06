Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CDA5F7123
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 00:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiJFWc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 18:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiJFWc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:32:26 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405C9F191A;
        Thu,  6 Oct 2022 15:32:25 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296LnvEX028642;
        Thu, 6 Oct 2022 22:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=zWgczEyt8JM5uP71whdVulbYeWTSWmnUfLLvmKY1IRc=;
 b=Qpowa9nqBZ6KWbEyNYz7R+65NLNG1ybfYzpwNUHYcZB8q4PujF+KKqQqV5kIz8RYO0SW
 JLkZp4KVEwJOp5iw5g72ZtqyHoXvqdFzXZi99ULefnhhkXR5FwqL1aIcAn5hmAJUKHWU
 VLcD63toWsaB+SlgIULN9tYmbdhmDogunPUGMt+XvSZ1ohADk7RiFAFJqws1JvggVyTO
 Vkepmx/WD16jc36F53u3MakFphd8G0D/tAj/EwoEOXwiK/Q10A1LoMiRzyH6995xb5ss
 bwTprmxnvAUK6j9giWxd4lMPOOhjKtG19AqFY+m624guWb8FbcwAND7fNrBWTX6ZsTHp WQ== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k27950a0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 22:32:22 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 7F9DAB2;
        Thu,  6 Oct 2022 22:32:21 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 34D6D8065D2;
        Thu,  6 Oct 2022 22:32:21 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [RFC PATCH 2/7] crypto: x86/sha - limit FPU preemption
Date:   Thu,  6 Oct 2022 17:31:46 -0500
Message-Id: <20221006223151.22159-3-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221006223151.22159-1-elliott@hpe.com>
References: <20221006223151.22159-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9S8TRWttWHfcsOzFi-PSwOQ09LiawGst
X-Proofpoint-GUID: 9S8TRWttWHfcsOzFi-PSwOQ09LiawGst
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_05,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060132
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As done by the ECB and CBC helpers in arch/x86/crypt/ecb_cbc_helpers.h,
limit the number of bytes processed between kernel_fpu_begin() and
kernel_fpu_end() calls.

Those functions call preempt_disable() and preempt_enable(), so
the CPU core is unavailable for scheduling while running.

This leads to "rcu_preempt detected expedited stalls" with stack dumps
pointing to the optimized hash function if this module is loaded and
used a lot:
    rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {12-... } 22 jiffies s: 277 root: 0x1/.

For example, that can occur during boot with the stack track pointing
to the sha512-x86 function if the system set to use SHA-512 for
module signing. The call trace includes:
    module_sig_check
    mod_verify_sig
    pkcs7_verify
    pkcs7_digest
    sha512_finup
    sha512_base_do_update

Fixes: 66be89515888 ("crypto: sha1 - SSSE3 based SHA1 implementation for x86-64")
Fixes: 8275d1aa6422 ("crypto: sha256 - Create module providing optimized SHA256 routines using SSSE3, AVX or AVX2 instructions.")
Fixes: 87de4579f92d ("crypto: sha512 - Create module providing optimized SHA512 routines using SSSE3, AVX or AVX2 instructions.")
Fixes: aa031b8f702e ("crypto: x86/sha512 - load based on CPU features")
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/sha1_ssse3_glue.c   | 34 +++++++++++++++++++++++-----
 arch/x86/crypto/sha256_ssse3_glue.c | 35 ++++++++++++++++++++++++-----
 arch/x86/crypto/sha512_ssse3_glue.c | 35 ++++++++++++++++++++++++-----
 3 files changed, 89 insertions(+), 15 deletions(-)

diff --git a/arch/x86/crypto/sha1_ssse3_glue.c b/arch/x86/crypto/sha1_ssse3_glue.c
index 4430463dee62..033812989476 100644
--- a/arch/x86/crypto/sha1_ssse3_glue.c
+++ b/arch/x86/crypto/sha1_ssse3_glue.c
@@ -27,10 +27,13 @@
 #include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+
 static int sha1_update(struct shash_desc *desc, const u8 *data,
 			     unsigned int len, sha1_block_fn *sha1_xform)
 {
 	struct sha1_state *sctx = shash_desc_ctx(desc);
+	unsigned int chunk;
 
 	if (!crypto_simd_usable() ||
 	    (sctx->count % SHA1_BLOCK_SIZE) + len < SHA1_BLOCK_SIZE)
@@ -42,9 +45,18 @@ static int sha1_update(struct shash_desc *desc, const u8 *data,
 	 */
 	BUILD_BUG_ON(offsetof(struct sha1_state, state) != 0);
 
-	kernel_fpu_begin();
-	sha1_base_do_update(desc, data, len, sha1_xform);
-	kernel_fpu_end();
+	do {
+		chunk = min(len, FPU_BYTES);
+		len -= chunk;
+
+		if (chunk) {
+			kernel_fpu_begin();
+			sha1_base_do_update(desc, data, chunk, sha1_xform);
+			kernel_fpu_end();
+		}
+
+		data += chunk;
+	} while (len);
 
 	return 0;
 }
@@ -52,12 +64,24 @@ static int sha1_update(struct shash_desc *desc, const u8 *data,
 static int sha1_finup(struct shash_desc *desc, const u8 *data,
 		      unsigned int len, u8 *out, sha1_block_fn *sha1_xform)
 {
+	unsigned int chunk;
+
 	if (!crypto_simd_usable())
 		return crypto_sha1_finup(desc, data, len, out);
 
+	do {
+		chunk = min(len, FPU_BYTES);
+		len -= chunk;
+
+		if (chunk) {
+			kernel_fpu_begin();
+			sha1_base_do_update(desc, data, chunk, sha1_xform);
+			kernel_fpu_end();
+		}
+		data += chunk;
+	} while (len);
+
 	kernel_fpu_begin();
-	if (len)
-		sha1_base_do_update(desc, data, len, sha1_xform);
 	sha1_base_do_finalize(desc, sha1_xform);
 	kernel_fpu_end();
 
diff --git a/arch/x86/crypto/sha256_ssse3_glue.c b/arch/x86/crypto/sha256_ssse3_glue.c
index e437fba0299b..99a25c238f40 100644
--- a/arch/x86/crypto/sha256_ssse3_glue.c
+++ b/arch/x86/crypto/sha256_ssse3_glue.c
@@ -40,6 +40,8 @@
 #include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+
 asmlinkage void sha256_transform_ssse3(struct sha256_state *state,
 				       const u8 *data, int blocks);
 
@@ -47,6 +49,7 @@ static int _sha256_update(struct shash_desc *desc, const u8 *data,
 			  unsigned int len, sha256_block_fn *sha256_xform)
 {
 	struct sha256_state *sctx = shash_desc_ctx(desc);
+	unsigned int chunk;
 
 	if (!crypto_simd_usable() ||
 	    (sctx->count % SHA256_BLOCK_SIZE) + len < SHA256_BLOCK_SIZE)
@@ -58,9 +61,18 @@ static int _sha256_update(struct shash_desc *desc, const u8 *data,
 	 */
 	BUILD_BUG_ON(offsetof(struct sha256_state, state) != 0);
 
-	kernel_fpu_begin();
-	sha256_base_do_update(desc, data, len, sha256_xform);
-	kernel_fpu_end();
+	do {
+		chunk = min(len, FPU_BYTES);
+		len -= chunk;
+
+		if (chunk) {
+			kernel_fpu_begin();
+			sha256_base_do_update(desc, data, chunk, sha256_xform);
+			kernel_fpu_end();
+		}
+
+		data += chunk;
+	} while (len);
 
 	return 0;
 }
@@ -68,12 +80,25 @@ static int _sha256_update(struct shash_desc *desc, const u8 *data,
 static int sha256_finup(struct shash_desc *desc, const u8 *data,
 	      unsigned int len, u8 *out, sha256_block_fn *sha256_xform)
 {
+	unsigned int chunk;
+
 	if (!crypto_simd_usable())
 		return crypto_sha256_finup(desc, data, len, out);
 
+	do {
+		chunk = min(len, FPU_BYTES);
+		len -= chunk;
+
+		if (chunk) {
+			kernel_fpu_begin();
+			sha256_base_do_update(desc, data, chunk, sha256_xform);
+			kernel_fpu_end();
+		}
+
+		data += chunk;
+	} while (len);
+
 	kernel_fpu_begin();
-	if (len)
-		sha256_base_do_update(desc, data, len, sha256_xform);
 	sha256_base_do_finalize(desc, sha256_xform);
 	kernel_fpu_end();
 
diff --git a/arch/x86/crypto/sha512_ssse3_glue.c b/arch/x86/crypto/sha512_ssse3_glue.c
index 3c19f803f288..72eee03448dc 100644
--- a/arch/x86/crypto/sha512_ssse3_glue.c
+++ b/arch/x86/crypto/sha512_ssse3_glue.c
@@ -39,6 +39,8 @@
 #include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+
 asmlinkage void sha512_transform_ssse3(struct sha512_state *state,
 				       const u8 *data, int blocks);
 
@@ -46,6 +48,7 @@ static int sha512_update(struct shash_desc *desc, const u8 *data,
 		       unsigned int len, sha512_block_fn *sha512_xform)
 {
 	struct sha512_state *sctx = shash_desc_ctx(desc);
+	unsigned int chunk;
 
 	if (!crypto_simd_usable() ||
 	    (sctx->count[0] % SHA512_BLOCK_SIZE) + len < SHA512_BLOCK_SIZE)
@@ -57,9 +60,18 @@ static int sha512_update(struct shash_desc *desc, const u8 *data,
 	 */
 	BUILD_BUG_ON(offsetof(struct sha512_state, state) != 0);
 
-	kernel_fpu_begin();
-	sha512_base_do_update(desc, data, len, sha512_xform);
-	kernel_fpu_end();
+	do {
+		chunk = min(len, FPU_BYTES);
+		len -= chunk;
+
+		if (chunk) {
+			kernel_fpu_begin();
+			sha512_base_do_update(desc, data, chunk, sha512_xform);
+			kernel_fpu_end();
+		}
+
+		data += chunk;
+	} while (len);
 
 	return 0;
 }
@@ -67,12 +79,25 @@ static int sha512_update(struct shash_desc *desc, const u8 *data,
 static int sha512_finup(struct shash_desc *desc, const u8 *data,
 	      unsigned int len, u8 *out, sha512_block_fn *sha512_xform)
 {
+	unsigned int chunk;
+
 	if (!crypto_simd_usable())
 		return crypto_sha512_finup(desc, data, len, out);
 
+	do {
+		chunk = min(len, FPU_BYTES);
+		len -= chunk;
+
+		if (chunk) {
+			kernel_fpu_begin();
+			sha512_base_do_update(desc, data, chunk, sha512_xform);
+			kernel_fpu_end();
+		}
+
+		data += chunk;
+	} while (len);
+
 	kernel_fpu_begin();
-	if (len)
-		sha512_base_do_update(desc, data, len, sha512_xform);
 	sha512_base_do_finalize(desc, sha512_xform);
 	kernel_fpu_end();
 
-- 
2.37.3

