Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBDB61759A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiKCEcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiKCEbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:31:55 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE681741A;
        Wed,  2 Nov 2022 21:30:16 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A34ES1M005074;
        Thu, 3 Nov 2022 04:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=WJ7ii9IOMwA1u/2F4iWjmOa0t9X/ieu9t/3cUuHQVnA=;
 b=OJOWxDIjNSfBdRAi1kareRQAhSx39aGRIvUq4iXSYGZqXs+hAo+vcZYLvHy+aQnAJ9Ot
 0Qkb2E4VETC5eSqlo1tW4/fgj1fA8TFtYNqgW3NkFKoZs5AFvzWUBbLmBXDCf1ljM4EX
 MOKINbWRw79djFZI4DeQtRqQo9zRXqDrKwpabCQxzTcr4pQiqq7zAoH012umMJjugMaR
 xVNyPJYDR8OGBsOUndLHOebR7YVbBw57XBDQFeaed5adtUlWOlXG0f3JpD7lIV+LoJUB
 Bld1Q1P5YONl6bSbltj0+5oOWJspgTOybz2/zQA7bqnA752XawOhd/z4qvYpIsDTy0oE IA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kktx6w26n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 04:29:49 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 72EFE804720;
        Thu,  3 Nov 2022 04:28:20 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 0031D802B9C;
        Thu,  3 Nov 2022 04:28:19 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 12/17] crypto: x86/sha - minimize time in FPU context
Date:   Wed,  2 Nov 2022 23:27:35 -0500
Message-Id: <20221103042740.6556-13-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221103042740.6556-1-elliott@hpe.com>
References: <20221012215931.3896-1-elliott@hpe.com>
 <20221103042740.6556-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ze3RjlDYsSLA8wP4Jrm9lOb0APM3I4fX
X-Proofpoint-ORIG-GUID: Ze3RjlDYsSLA8wP4Jrm9lOb0APM3I4fX
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=10 mlxscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030031
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Narrow the kernel_fpu_begin()/kernel_fpu_end() to just wrap the
assembly functions, not any extra C code around them (which includes
several memcpy() calls).

This reduces unnecessary time in FPU context, in which the scheduler
is prevented from preempting and the RCU subsystem is kept from
doing its work.

Example results measuring a boot, in which SHA-512 is used to check all
module signatures using finup() calls:

Before:
   calls    maxcycles      bpf   update    finup algorithm   module
======== ============ ======== ======== ======== =========== ==============
  168390      1233188    19456        0    19456 sha512-avx2 sha512_ssse3

After:
  182694      1007224    19456        0    19456 sha512-avx2 sha512_ssse3

That means it stayed in FPU context for 226k fewer clocks cycles (which
is 102 microseconds on this system, 18% less).

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/sha1_ssse3_glue.c   | 82 ++++++++++++++++++++---------
 arch/x86/crypto/sha256_ssse3_glue.c | 67 ++++++++++++++++++-----
 arch/x86/crypto/sha512_ssse3_glue.c | 48 ++++++++++++-----
 3 files changed, 145 insertions(+), 52 deletions(-)

diff --git a/arch/x86/crypto/sha1_ssse3_glue.c b/arch/x86/crypto/sha1_ssse3_glue.c
index 89aa5b787f2f..cd390083451f 100644
--- a/arch/x86/crypto/sha1_ssse3_glue.c
+++ b/arch/x86/crypto/sha1_ssse3_glue.c
@@ -34,6 +34,54 @@ static const unsigned int bytes_per_fpu_avx2 = 34 * 1024;
 static const unsigned int bytes_per_fpu_avx = 30 * 1024;
 static const unsigned int bytes_per_fpu_ssse3 = 26 * 1024;
 
+asmlinkage void sha1_transform_ssse3(struct sha1_state *state,
+				     const u8 *data, int blocks);
+
+asmlinkage void sha1_transform_avx(struct sha1_state *state,
+				   const u8 *data, int blocks);
+
+asmlinkage void sha1_transform_avx2(struct sha1_state *state,
+				    const u8 *data, int blocks);
+
+#ifdef CONFIG_AS_SHA1_NI
+asmlinkage void sha1_ni_transform(struct sha1_state *digest, const u8 *data,
+				  int rounds);
+#endif
+
+static void fpu_sha1_transform_ssse3(struct sha1_state *state,
+				     const u8 *data, int blocks)
+{
+	kernel_fpu_begin();
+	sha1_transform_ssse3(state, data, blocks);
+	kernel_fpu_end();
+}
+
+static void fpu_sha1_transform_avx(struct sha1_state *state,
+				   const u8 *data, int blocks)
+{
+	kernel_fpu_begin();
+	sha1_transform_avx(state, data, blocks);
+	kernel_fpu_end();
+}
+
+static void fpu_sha1_transform_avx2(struct sha1_state *state,
+				    const u8 *data, int blocks)
+{
+	kernel_fpu_begin();
+	sha1_transform_avx2(state, data, blocks);
+	kernel_fpu_end();
+}
+
+#ifdef CONFIG_AS_SHA1_NI
+static void fpu_sha1_transform_shani(struct sha1_state *state,
+				     const u8 *data, int blocks)
+{
+	kernel_fpu_begin();
+	sha1_ni_transform(state, data, blocks);
+	kernel_fpu_end();
+}
+#endif
+
 static int sha1_update(struct shash_desc *desc, const u8 *data,
 		       unsigned int len, unsigned int bytes_per_fpu,
 		       sha1_block_fn *sha1_xform)
@@ -53,9 +101,7 @@ static int sha1_update(struct shash_desc *desc, const u8 *data,
 	while (len) {
 		unsigned int chunk = min(len, bytes_per_fpu);
 
-		kernel_fpu_begin();
 		sha1_base_do_update(desc, data, chunk, sha1_xform);
-		kernel_fpu_end();
 
 		len -= chunk;
 		data += chunk;
@@ -74,36 +120,29 @@ static int sha1_finup(struct shash_desc *desc, const u8 *data,
 	while (len) {
 		unsigned int chunk = min(len, bytes_per_fpu);
 
-		kernel_fpu_begin();
 		sha1_base_do_update(desc, data, chunk, sha1_xform);
-		kernel_fpu_end();
 
 		len -= chunk;
 		data += chunk;
 	}
 
-	kernel_fpu_begin();
 	sha1_base_do_finalize(desc, sha1_xform);
-	kernel_fpu_end();
 
 	return sha1_base_finish(desc, out);
 }
 
-asmlinkage void sha1_transform_ssse3(struct sha1_state *state,
-				     const u8 *data, int blocks);
-
 static int sha1_ssse3_update(struct shash_desc *desc, const u8 *data,
 			     unsigned int len)
 {
 	return sha1_update(desc, data, len, bytes_per_fpu_ssse3,
-			   sha1_transform_ssse3);
+			   fpu_sha1_transform_ssse3);
 }
 
 static int sha1_ssse3_finup(struct shash_desc *desc, const u8 *data,
 			      unsigned int len, u8 *out)
 {
 	return sha1_finup(desc, data, len, bytes_per_fpu_ssse3, out,
-			  sha1_transform_ssse3);
+			  fpu_sha1_transform_ssse3);
 }
 
 /* Add padding and return the message digest. */
@@ -141,21 +180,18 @@ static void unregister_sha1_ssse3(void)
 	}
 }
 
-asmlinkage void sha1_transform_avx(struct sha1_state *state,
-				   const u8 *data, int blocks);
-
 static int sha1_avx_update(struct shash_desc *desc, const u8 *data,
 			     unsigned int len)
 {
 	return sha1_update(desc, data, len, bytes_per_fpu_avx,
-			   sha1_transform_avx);
+			   fpu_sha1_transform_avx);
 }
 
 static int sha1_avx_finup(struct shash_desc *desc, const u8 *data,
 			      unsigned int len, u8 *out)
 {
 	return sha1_finup(desc, data, len, bytes_per_fpu_avx, out,
-			  sha1_transform_avx);
+			  fpu_sha1_transform_avx);
 }
 
 static int sha1_avx_final(struct shash_desc *desc, u8 *out)
@@ -189,17 +225,14 @@ static void unregister_sha1_avx(void)
 
 #define SHA1_AVX2_BLOCK_OPTSIZE	4	/* optimal 4*64 bytes of SHA1 blocks */
 
-asmlinkage void sha1_transform_avx2(struct sha1_state *state,
-				    const u8 *data, int blocks);
-
 static void sha1_apply_transform_avx2(struct sha1_state *state,
 				      const u8 *data, int blocks)
 {
 	/* Select the optimal transform based on data block size */
 	if (blocks >= SHA1_AVX2_BLOCK_OPTSIZE)
-		sha1_transform_avx2(state, data, blocks);
+		fpu_sha1_transform_avx2(state, data, blocks);
 	else
-		sha1_transform_avx(state, data, blocks);
+		fpu_sha1_transform_avx(state, data, blocks);
 }
 
 static int sha1_avx2_update(struct shash_desc *desc, const u8 *data,
@@ -246,21 +279,18 @@ static void unregister_sha1_avx2(void)
 }
 
 #ifdef CONFIG_AS_SHA1_NI
-asmlinkage void sha1_ni_transform(struct sha1_state *digest, const u8 *data,
-				  int rounds);
-
 static int sha1_ni_update(struct shash_desc *desc, const u8 *data,
 			     unsigned int len)
 {
 	return sha1_update(desc, data, len, bytes_per_fpu_shani,
-			   sha1_ni_transform);
+			   fpu_sha1_transform_shani);
 }
 
 static int sha1_ni_finup(struct shash_desc *desc, const u8 *data,
 			      unsigned int len, u8 *out)
 {
 	return sha1_finup(desc, data, len, bytes_per_fpu_shani, out,
-			  sha1_ni_transform);
+			  fpu_sha1_transform_shani);
 }
 
 static int sha1_ni_final(struct shash_desc *desc, u8 *out)
diff --git a/arch/x86/crypto/sha256_ssse3_glue.c b/arch/x86/crypto/sha256_ssse3_glue.c
index de320973e473..692d6f010a4d 100644
--- a/arch/x86/crypto/sha256_ssse3_glue.c
+++ b/arch/x86/crypto/sha256_ssse3_glue.c
@@ -51,6 +51,51 @@ static const unsigned int bytes_per_fpu_ssse3 = 11 * 1024;
 asmlinkage void sha256_transform_ssse3(struct sha256_state *state,
 				       const u8 *data, int blocks);
 
+asmlinkage void sha256_transform_avx(struct sha256_state *state,
+				     const u8 *data, int blocks);
+
+asmlinkage void sha256_transform_rorx(struct sha256_state *state,
+				      const u8 *data, int blocks);
+
+#ifdef CONFIG_AS_SHA256_NI
+asmlinkage void sha256_ni_transform(struct sha256_state *digest,
+				    const u8 *data, int rounds);
+#endif
+
+static void fpu_sha256_transform_ssse3(struct sha256_state *state,
+				       const u8 *data, int blocks)
+{
+	kernel_fpu_begin();
+	sha256_transform_ssse3(state, data, blocks);
+	kernel_fpu_end();
+}
+
+static void fpu_sha256_transform_avx(struct sha256_state *state,
+				     const u8 *data, int blocks)
+{
+	kernel_fpu_begin();
+	sha256_transform_avx(state, data, blocks);
+	kernel_fpu_end();
+}
+
+static void fpu_sha256_transform_avx2(struct sha256_state *state,
+				      const u8 *data, int blocks)
+{
+	kernel_fpu_begin();
+	sha256_transform_rorx(state, data, blocks);
+	kernel_fpu_end();
+}
+
+#ifdef CONFIG_AS_SHA1_NI
+static void fpu_sha256_transform_shani(struct sha256_state *state,
+				       const u8 *data, int blocks)
+{
+	kernel_fpu_begin();
+	sha256_ni_transform(state, data, blocks);
+	kernel_fpu_end();
+}
+#endif
+
 static int _sha256_update(struct shash_desc *desc, const u8 *data,
 			  unsigned int len, unsigned int bytes_per_fpu,
 			  sha256_block_fn *sha256_xform)
@@ -70,9 +115,7 @@ static int _sha256_update(struct shash_desc *desc, const u8 *data,
 	while (len) {
 		unsigned int chunk = min(len, bytes_per_fpu);
 
-		kernel_fpu_begin();
 		sha256_base_do_update(desc, data, chunk, sha256_xform);
-		kernel_fpu_end();
 
 		len -= chunk;
 		data += chunk;
@@ -91,17 +134,13 @@ static int sha256_finup(struct shash_desc *desc, const u8 *data,
 	while (len) {
 		unsigned int chunk = min(len, bytes_per_fpu);
 
-		kernel_fpu_begin();
 		sha256_base_do_update(desc, data, chunk, sha256_xform);
-		kernel_fpu_end();
 
 		len -= chunk;
 		data += chunk;
 	}
 
-	kernel_fpu_begin();
 	sha256_base_do_finalize(desc, sha256_xform);
-	kernel_fpu_end();
 
 	return sha256_base_finish(desc, out);
 }
@@ -110,14 +149,14 @@ static int sha256_ssse3_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
 {
 	return _sha256_update(desc, data, len, bytes_per_fpu_ssse3,
-			      sha256_transform_ssse3);
+			      fpu_sha256_transform_ssse3);
 }
 
 static int sha256_ssse3_finup(struct shash_desc *desc, const u8 *data,
 	      unsigned int len, u8 *out)
 {
 	return sha256_finup(desc, data, len, bytes_per_fpu_ssse3,
-			    out, sha256_transform_ssse3);
+			    out, fpu_sha256_transform_ssse3);
 }
 
 /* Add padding and return the message digest. */
@@ -177,14 +216,14 @@ static int sha256_avx_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
 {
 	return _sha256_update(desc, data, len, bytes_per_fpu_avx,
-			      sha256_transform_avx);
+			      fpu_sha256_transform_avx);
 }
 
 static int sha256_avx_finup(struct shash_desc *desc, const u8 *data,
 		      unsigned int len, u8 *out)
 {
 	return sha256_finup(desc, data, len, bytes_per_fpu_avx,
-			    out, sha256_transform_avx);
+			    out, fpu_sha256_transform_avx);
 }
 
 static int sha256_avx_final(struct shash_desc *desc, u8 *out)
@@ -238,14 +277,14 @@ static int sha256_avx2_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
 {
 	return _sha256_update(desc, data, len, bytes_per_fpu_avx2,
-			      sha256_transform_rorx);
+			      fpu_sha256_transform_avx2);
 }
 
 static int sha256_avx2_finup(struct shash_desc *desc, const u8 *data,
 		      unsigned int len, u8 *out)
 {
 	return sha256_finup(desc, data, len, bytes_per_fpu_avx2,
-			    out, sha256_transform_rorx);
+			    out, fpu_sha256_transform_avx2);
 }
 
 static int sha256_avx2_final(struct shash_desc *desc, u8 *out)
@@ -300,14 +339,14 @@ static int sha256_ni_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
 {
 	return _sha256_update(desc, data, len, bytes_per_fpu_shani,
-			      sha256_ni_transform);
+			      fpu_sha256_transform_shani);
 }
 
 static int sha256_ni_finup(struct shash_desc *desc, const u8 *data,
 		      unsigned int len, u8 *out)
 {
 	return sha256_finup(desc, data, len, bytes_per_fpu_shani,
-			    out, sha256_ni_transform);
+			    out, fpu_sha256_transform_shani);
 }
 
 static int sha256_ni_final(struct shash_desc *desc, u8 *out)
diff --git a/arch/x86/crypto/sha512_ssse3_glue.c b/arch/x86/crypto/sha512_ssse3_glue.c
index 3e96fe51f1a0..e2698545bf47 100644
--- a/arch/x86/crypto/sha512_ssse3_glue.c
+++ b/arch/x86/crypto/sha512_ssse3_glue.c
@@ -47,6 +47,36 @@ static const unsigned int bytes_per_fpu_ssse3 = 17 * 1024;
 asmlinkage void sha512_transform_ssse3(struct sha512_state *state,
 				       const u8 *data, int blocks);
 
+asmlinkage void sha512_transform_avx(struct sha512_state *state,
+				     const u8 *data, int blocks);
+
+asmlinkage void sha512_transform_rorx(struct sha512_state *state,
+				      const u8 *data, int blocks);
+
+static void fpu_sha512_transform_ssse3(struct sha512_state *state,
+				       const u8 *data, int blocks)
+{
+	kernel_fpu_begin();
+	sha512_transform_ssse3(state, data, blocks);
+	kernel_fpu_end();
+}
+
+static void fpu_sha512_transform_avx(struct sha512_state *state,
+				     const u8 *data, int blocks)
+{
+	kernel_fpu_begin();
+	sha512_transform_avx(state, data, blocks);
+	kernel_fpu_end();
+}
+
+static void fpu_sha512_transform_avx2(struct sha512_state *state,
+				      const u8 *data, int blocks)
+{
+	kernel_fpu_begin();
+	sha512_transform_rorx(state, data, blocks);
+	kernel_fpu_end();
+}
+
 static int sha512_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len, unsigned int bytes_per_fpu,
 			 sha512_block_fn *sha512_xform)
@@ -66,9 +96,7 @@ static int sha512_update(struct shash_desc *desc, const u8 *data,
 	while (len) {
 		unsigned int chunk = min(len, bytes_per_fpu);
 
-		kernel_fpu_begin();
 		sha512_base_do_update(desc, data, chunk, sha512_xform);
-		kernel_fpu_end();
 
 		len -= chunk;
 		data += chunk;
@@ -87,17 +115,13 @@ static int sha512_finup(struct shash_desc *desc, const u8 *data,
 	while (len) {
 		unsigned int chunk = min(len, bytes_per_fpu);
 
-		kernel_fpu_begin();
 		sha512_base_do_update(desc, data, chunk, sha512_xform);
-		kernel_fpu_end();
 
 		len -= chunk;
 		data += chunk;
 	}
 
-	kernel_fpu_begin();
 	sha512_base_do_finalize(desc, sha512_xform);
-	kernel_fpu_end();
 
 	return sha512_base_finish(desc, out);
 }
@@ -106,14 +130,14 @@ static int sha512_ssse3_update(struct shash_desc *desc, const u8 *data,
 		       unsigned int len)
 {
 	return sha512_update(desc, data, len, bytes_per_fpu_ssse3,
-			     sha512_transform_ssse3);
+			     fpu_sha512_transform_ssse3);
 }
 
 static int sha512_ssse3_finup(struct shash_desc *desc, const u8 *data,
 	      unsigned int len, u8 *out)
 {
 	return sha512_finup(desc, data, len, bytes_per_fpu_ssse3,
-			    out, sha512_transform_ssse3);
+			    out, fpu_sha512_transform_ssse3);
 }
 
 /* Add padding and return the message digest. */
@@ -172,14 +196,14 @@ static int sha512_avx_update(struct shash_desc *desc, const u8 *data,
 		       unsigned int len)
 {
 	return sha512_update(desc, data, len, bytes_per_fpu_avx,
-			     sha512_transform_avx);
+			     fpu_sha512_transform_avx);
 }
 
 static int sha512_avx_finup(struct shash_desc *desc, const u8 *data,
 	      unsigned int len, u8 *out)
 {
 	return sha512_finup(desc, data, len, bytes_per_fpu_avx,
-			    out, sha512_transform_avx);
+			    out, fpu_sha512_transform_avx);
 }
 
 /* Add padding and return the message digest. */
@@ -234,14 +258,14 @@ static int sha512_avx2_update(struct shash_desc *desc, const u8 *data,
 		       unsigned int len)
 {
 	return sha512_update(desc, data, len, bytes_per_fpu_avx2,
-			     sha512_transform_rorx);
+			     fpu_sha512_transform_avx2);
 }
 
 static int sha512_avx2_finup(struct shash_desc *desc, const u8 *data,
 	      unsigned int len, u8 *out)
 {
 	return sha512_finup(desc, data, len, bytes_per_fpu_avx2,
-			    out, sha512_transform_rorx);
+			    out, fpu_sha512_transform_avx2);
 }
 
 /* Add padding and return the message digest. */
-- 
2.37.3

