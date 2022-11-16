Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B152762B22C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 05:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbiKPEPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 23:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiKPEOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 23:14:21 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A495B31EDF;
        Tue, 15 Nov 2022 20:14:17 -0800 (PST)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG31Mrn027550;
        Wed, 16 Nov 2022 04:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=78cE9OO8uzMM2db32hW7tetx3xycoj1j3qAj8neR0YQ=;
 b=pNrzYLZ3h+rBst1BTvYNT0AiB29y0JYgoF0wCZefTrpEd1CiMK3Ny654MC0MCxA4ZCZI
 F4h4gReZSH9gul8fWRSQBDwSQGBA2xaWQVrIceGZVLSZ2yzrRC88+RYaInz1f89kSotZ
 3ZlxaJwuViu6KQu2yXlRG9SoMPIZD5ktyBSPQ6w91KIPVF52Rou1LvCBlu6uq7oHCC80
 5DMShuENZS5dfXyuQn8cauW4pLB+II1i2WHFxPRS5nPa9+VxIheDkLLa656JyTaAPlD0
 1xuOFOOL9w2oeRCyDenf/a4msm/JfJgJjhvt5iq7vXLa+lYpAmsh8mQu7oCnhshHjDiK xg== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3kvqkbrefv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 04:14:09 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 712E98040CD;
        Wed, 16 Nov 2022 04:14:08 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 008A1802DD6;
        Wed, 16 Nov 2022 04:14:07 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v4 13/24] crypto: x86/sha - minimize time in FPU context
Date:   Tue, 15 Nov 2022 22:13:31 -0600
Message-Id: <20221116041342.3841-14-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116041342.3841-1-elliott@hpe.com>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: I1qUADll7Q5ufH1ja4mJxCxa-CcDUQNj
X-Proofpoint-ORIG-GUID: I1qUADll7Q5ufH1ja4mJxCxa-CcDUQNj
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=7 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211160029
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index e75a1060bb5f..32f3310e19e2 100644
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
 static int using_x86_ssse3;
 static int using_x86_avx;
 static int using_x86_avx2;
@@ -60,9 +108,7 @@ static int sha1_update(struct shash_desc *desc, const u8 *data,
 	while (len) {
 		unsigned int chunk = min(len, bytes_per_fpu);
 
-		kernel_fpu_begin();
 		sha1_base_do_update(desc, data, chunk, sha1_xform);
-		kernel_fpu_end();
 
 		len -= chunk;
 		data += chunk;
@@ -81,36 +127,29 @@ static int sha1_finup(struct shash_desc *desc, const u8 *data,
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
@@ -143,21 +182,18 @@ static void unregister_sha1_ssse3(void)
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
@@ -191,17 +227,14 @@ static void unregister_sha1_avx(void)
 
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
@@ -248,21 +281,18 @@ static void unregister_sha1_avx2(void)
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
index c6261ede4bae..839da1b36273 100644
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
 static int using_x86_ssse3;
 static int using_x86_avx;
 static int using_x86_avx2;
@@ -77,9 +122,7 @@ static int _sha256_update(struct shash_desc *desc, const u8 *data,
 	while (len) {
 		unsigned int chunk = min(len, bytes_per_fpu);
 
-		kernel_fpu_begin();
 		sha256_base_do_update(desc, data, chunk, sha256_xform);
-		kernel_fpu_end();
 
 		len -= chunk;
 		data += chunk;
@@ -98,17 +141,13 @@ static int sha256_finup(struct shash_desc *desc, const u8 *data,
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
@@ -117,14 +156,14 @@ static int sha256_ssse3_update(struct shash_desc *desc, const u8 *data,
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
@@ -179,14 +218,14 @@ static int sha256_avx_update(struct shash_desc *desc, const u8 *data,
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
@@ -240,14 +279,14 @@ static int sha256_avx2_update(struct shash_desc *desc, const u8 *data,
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
@@ -302,14 +341,14 @@ static int sha256_ni_update(struct shash_desc *desc, const u8 *data,
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
index feae85933270..48586ab40d55 100644
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
 static int using_x86_ssse3;
 static int using_x86_avx;
 static int using_x86_avx2;
@@ -70,9 +100,7 @@ static int sha512_update(struct shash_desc *desc, const u8 *data,
 	while (len) {
 		unsigned int chunk = min(len, bytes_per_fpu);
 
-		kernel_fpu_begin();
 		sha512_base_do_update(desc, data, chunk, sha512_xform);
-		kernel_fpu_end();
 
 		len -= chunk;
 		data += chunk;
@@ -91,17 +119,13 @@ static int sha512_finup(struct shash_desc *desc, const u8 *data,
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
@@ -110,14 +134,14 @@ static int sha512_ssse3_update(struct shash_desc *desc, const u8 *data,
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
2.38.1

