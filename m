Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5787E62B233
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 05:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiKPEPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 23:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiKPEOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 23:14:25 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A95F2D1DB;
        Tue, 15 Nov 2022 20:14:19 -0800 (PST)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG3HohF024146;
        Wed, 16 Nov 2022 04:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=3DT2dGUsYD5z+1mTOCjd0II633gWE/migA0MCL9vm7A=;
 b=J6TmsNukmxNs6mv4sMcZTauF3u6VaXudN8vrc5T3O3BUe4M+p9l3iX1oMhUgQa4piVyz
 IU5a4hXeReJMWUw/Zym5gkESWAQW7KoLufesbIAVmDeiJEY85b2eYyvD0k+ovbH6kA1l
 X7qnecawY7tjiV/8ORJyuKYZJR4bPZ1ciG6bRtr6Odca/95GiIKbbvZD3MfcMwPQfL7W
 6/lp/p1A0AYRm6JJ8WbdjY1u6GXFV+NsQ3xUsArApzYWQaztkaxleJ+swLc+c0tEOEft
 865DwGJ1fKpL00dDzOWnuvLvsOJrgcH+JcOYxJp4CSRj3eK3/tglMNnq8VVc9NZaeh/Y zQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kvqturc3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 04:14:08 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 4FF018040E8;
        Wed, 16 Nov 2022 04:14:07 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id BF1E580FE88;
        Wed, 16 Nov 2022 04:14:06 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH v4 12/24] crypto: x86/sha - register all variations
Date:   Tue, 15 Nov 2022 22:13:30 -0600
Message-Id: <20221116041342.3841-13-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116041342.3841-1-elliott@hpe.com>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Qat-OnP-xdC88svxJY34uKIPYtgqUs8v
X-Proofpoint-GUID: Qat-OnP-xdC88svxJY34uKIPYtgqUs8v
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160029
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't register and unregister each of the functions from least-
to most-optimized (e.g., SSSE3 then AVX then AVX2); register all
variations.

This enables selecting those other algorithms if needed,
such as for testing with:
  modprobe tcrypt mode=300 alg=sha512-avx
  modprobe tcrypt mode=400 alg=sha512-avx

Suggested-by: Tim Chen <tim.c.chen@linux.intel.com>
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Robert Elliott <elliott@hpe.com>

---
v3 register all the variations, not just the best one, per
Herbert's feedback. return -ENODEV if none are successful, 0
if any are successful

v4 remove driver_name strings that are only used by later
patches no longer included in this series that enhance the
prints. A future patch series might remove existing prints
rather than add and enhance them.
Reported-by: kernel test robot <lkp@intel.com>
---
 arch/x86/crypto/sha1_ssse3_glue.c   | 132 +++++++++++++--------------
 arch/x86/crypto/sha256_ssse3_glue.c | 136 +++++++++++++---------------
 arch/x86/crypto/sha512_ssse3_glue.c |  99 +++++++++-----------
 3 files changed, 168 insertions(+), 199 deletions(-)

diff --git a/arch/x86/crypto/sha1_ssse3_glue.c b/arch/x86/crypto/sha1_ssse3_glue.c
index 4bc77c84b0fb..e75a1060bb5f 100644
--- a/arch/x86/crypto/sha1_ssse3_glue.c
+++ b/arch/x86/crypto/sha1_ssse3_glue.c
@@ -34,6 +34,13 @@ static const unsigned int bytes_per_fpu_avx2 = 34 * 1024;
 static const unsigned int bytes_per_fpu_avx = 30 * 1024;
 static const unsigned int bytes_per_fpu_ssse3 = 26 * 1024;
 
+static int using_x86_ssse3;
+static int using_x86_avx;
+static int using_x86_avx2;
+#ifdef CONFIG_AS_SHA1_NI
+static int using_x86_shani;
+#endif
+
 static int sha1_update(struct shash_desc *desc, const u8 *data,
 		       unsigned int len, unsigned int bytes_per_fpu,
 		       sha1_block_fn *sha1_xform)
@@ -128,17 +135,12 @@ static struct shash_alg sha1_ssse3_alg = {
 	}
 };
 
-static int register_sha1_ssse3(void)
-{
-	if (boot_cpu_has(X86_FEATURE_SSSE3))
-		return crypto_register_shash(&sha1_ssse3_alg);
-	return 0;
-}
-
 static void unregister_sha1_ssse3(void)
 {
-	if (boot_cpu_has(X86_FEATURE_SSSE3))
+	if (using_x86_ssse3) {
 		crypto_unregister_shash(&sha1_ssse3_alg);
+		using_x86_ssse3 = 0;
+	}
 }
 
 asmlinkage void sha1_transform_avx(struct sha1_state *state,
@@ -179,28 +181,12 @@ static struct shash_alg sha1_avx_alg = {
 	}
 };
 
-static bool avx_usable(void)
-{
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
-		if (boot_cpu_has(X86_FEATURE_AVX))
-			pr_info("AVX detected but unusable.\n");
-		return false;
-	}
-
-	return true;
-}
-
-static int register_sha1_avx(void)
-{
-	if (avx_usable())
-		return crypto_register_shash(&sha1_avx_alg);
-	return 0;
-}
-
 static void unregister_sha1_avx(void)
 {
-	if (avx_usable())
+	if (using_x86_avx) {
 		crypto_unregister_shash(&sha1_avx_alg);
+		using_x86_avx = 0;
+	}
 }
 
 #define SHA1_AVX2_BLOCK_OPTSIZE	4	/* optimal 4*64 bytes of SHA1 blocks */
@@ -208,16 +194,6 @@ static void unregister_sha1_avx(void)
 asmlinkage void sha1_transform_avx2(struct sha1_state *state,
 				    const u8 *data, int blocks);
 
-static bool avx2_usable(void)
-{
-	if (avx_usable() && boot_cpu_has(X86_FEATURE_AVX2)
-		&& boot_cpu_has(X86_FEATURE_BMI1)
-		&& boot_cpu_has(X86_FEATURE_BMI2))
-		return true;
-
-	return false;
-}
-
 static void sha1_apply_transform_avx2(struct sha1_state *state,
 				      const u8 *data, int blocks)
 {
@@ -263,17 +239,12 @@ static struct shash_alg sha1_avx2_alg = {
 	}
 };
 
-static int register_sha1_avx2(void)
-{
-	if (avx2_usable())
-		return crypto_register_shash(&sha1_avx2_alg);
-	return 0;
-}
-
 static void unregister_sha1_avx2(void)
 {
-	if (avx2_usable())
+	if (using_x86_avx2) {
 		crypto_unregister_shash(&sha1_avx2_alg);
+		using_x86_avx2 = 0;
+	}
 }
 
 #ifdef CONFIG_AS_SHA1_NI
@@ -315,49 +286,70 @@ static struct shash_alg sha1_ni_alg = {
 	}
 };
 
-static int register_sha1_ni(void)
-{
-	if (boot_cpu_has(X86_FEATURE_SHA_NI))
-		return crypto_register_shash(&sha1_ni_alg);
-	return 0;
-}
-
 static void unregister_sha1_ni(void)
 {
-	if (boot_cpu_has(X86_FEATURE_SHA_NI))
+	if (using_x86_shani) {
 		crypto_unregister_shash(&sha1_ni_alg);
+		using_x86_shani = 0;
+	}
 }
 
 #else
-static inline int register_sha1_ni(void) { return 0; }
 static inline void unregister_sha1_ni(void) { }
 #endif
 
 static int __init sha1_ssse3_mod_init(void)
 {
-	if (register_sha1_ssse3())
-		goto fail;
+	const char *feature_name;
+	int ret;
+
+#ifdef CONFIG_AS_SHA1_NI
+	/* SHA-NI */
+	if (boot_cpu_has(X86_FEATURE_SHA_NI)) {
 
-	if (register_sha1_avx()) {
-		unregister_sha1_ssse3();
-		goto fail;
+		ret = crypto_register_shash(&sha1_ni_alg);
+		if (!ret)
+			using_x86_shani = 1;
 	}
+#endif
+
+	/* AVX2 */
+	if (boot_cpu_has(X86_FEATURE_AVX2)) {
 
-	if (register_sha1_avx2()) {
-		unregister_sha1_avx();
-		unregister_sha1_ssse3();
-		goto fail;
+		if (boot_cpu_has(X86_FEATURE_BMI1) &&
+		    boot_cpu_has(X86_FEATURE_BMI2)) {
+
+			ret = crypto_register_shash(&sha1_avx2_alg);
+			if (!ret)
+				using_x86_avx2 = 1;
+		}
 	}
 
-	if (register_sha1_ni()) {
-		unregister_sha1_avx2();
-		unregister_sha1_avx();
-		unregister_sha1_ssse3();
-		goto fail;
+	/* AVX */
+	if (boot_cpu_has(X86_FEATURE_AVX)) {
+
+		if (cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
+			       &feature_name)) {
+
+			ret = crypto_register_shash(&sha1_avx_alg);
+			if (!ret)
+				using_x86_avx = 1;
+		}
 	}
 
-	return 0;
-fail:
+	/* SSE3 */
+	if (boot_cpu_has(X86_FEATURE_SSSE3)) {
+		ret = crypto_register_shash(&sha1_ssse3_alg);
+		if (!ret)
+			using_x86_ssse3 = 1;
+	}
+
+#ifdef CONFIG_AS_SHA1_NI
+	if (using_x86_shani)
+		return 0;
+#endif
+	if (using_x86_avx2 || using_x86_avx || using_x86_ssse3)
+		return 0;
 	return -ENODEV;
 }
 
diff --git a/arch/x86/crypto/sha256_ssse3_glue.c b/arch/x86/crypto/sha256_ssse3_glue.c
index cdcdf5a80ffe..c6261ede4bae 100644
--- a/arch/x86/crypto/sha256_ssse3_glue.c
+++ b/arch/x86/crypto/sha256_ssse3_glue.c
@@ -51,6 +51,13 @@ static const unsigned int bytes_per_fpu_ssse3 = 11 * 1024;
 asmlinkage void sha256_transform_ssse3(struct sha256_state *state,
 				       const u8 *data, int blocks);
 
+static int using_x86_ssse3;
+static int using_x86_avx;
+static int using_x86_avx2;
+#ifdef CONFIG_AS_SHA256_NI
+static int using_x86_shani;
+#endif
+
 static int _sha256_update(struct shash_desc *desc, const u8 *data,
 			  unsigned int len, unsigned int bytes_per_fpu,
 			  sha256_block_fn *sha256_xform)
@@ -156,19 +163,13 @@ static struct shash_alg sha256_ssse3_algs[] = { {
 	}
 } };
 
-static int register_sha256_ssse3(void)
-{
-	if (boot_cpu_has(X86_FEATURE_SSSE3))
-		return crypto_register_shashes(sha256_ssse3_algs,
-				ARRAY_SIZE(sha256_ssse3_algs));
-	return 0;
-}
-
 static void unregister_sha256_ssse3(void)
 {
-	if (boot_cpu_has(X86_FEATURE_SSSE3))
+	if (using_x86_ssse3) {
 		crypto_unregister_shashes(sha256_ssse3_algs,
 				ARRAY_SIZE(sha256_ssse3_algs));
+		using_x86_ssse3 = 0;
+	}
 }
 
 asmlinkage void sha256_transform_avx(struct sha256_state *state,
@@ -223,30 +224,13 @@ static struct shash_alg sha256_avx_algs[] = { {
 	}
 } };
 
-static bool avx_usable(void)
-{
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
-		if (boot_cpu_has(X86_FEATURE_AVX))
-			pr_info("AVX detected but unusable.\n");
-		return false;
-	}
-
-	return true;
-}
-
-static int register_sha256_avx(void)
-{
-	if (avx_usable())
-		return crypto_register_shashes(sha256_avx_algs,
-				ARRAY_SIZE(sha256_avx_algs));
-	return 0;
-}
-
 static void unregister_sha256_avx(void)
 {
-	if (avx_usable())
+	if (using_x86_avx) {
 		crypto_unregister_shashes(sha256_avx_algs,
 				ARRAY_SIZE(sha256_avx_algs));
+		using_x86_avx = 0;
+	}
 }
 
 asmlinkage void sha256_transform_rorx(struct sha256_state *state,
@@ -301,28 +285,13 @@ static struct shash_alg sha256_avx2_algs[] = { {
 	}
 } };
 
-static bool avx2_usable(void)
-{
-	if (avx_usable() && boot_cpu_has(X86_FEATURE_AVX2) &&
-		    boot_cpu_has(X86_FEATURE_BMI2))
-		return true;
-
-	return false;
-}
-
-static int register_sha256_avx2(void)
-{
-	if (avx2_usable())
-		return crypto_register_shashes(sha256_avx2_algs,
-				ARRAY_SIZE(sha256_avx2_algs));
-	return 0;
-}
-
 static void unregister_sha256_avx2(void)
 {
-	if (avx2_usable())
+	if (using_x86_avx2) {
 		crypto_unregister_shashes(sha256_avx2_algs,
 				ARRAY_SIZE(sha256_avx2_algs));
+		using_x86_avx2 = 0;
+	}
 }
 
 #ifdef CONFIG_AS_SHA256_NI
@@ -378,51 +347,72 @@ static struct shash_alg sha256_ni_algs[] = { {
 	}
 } };
 
-static int register_sha256_ni(void)
-{
-	if (boot_cpu_has(X86_FEATURE_SHA_NI))
-		return crypto_register_shashes(sha256_ni_algs,
-				ARRAY_SIZE(sha256_ni_algs));
-	return 0;
-}
-
 static void unregister_sha256_ni(void)
 {
-	if (boot_cpu_has(X86_FEATURE_SHA_NI))
+	if (using_x86_shani) {
 		crypto_unregister_shashes(sha256_ni_algs,
 				ARRAY_SIZE(sha256_ni_algs));
+		using_x86_shani = 0;
+	}
 }
 
 #else
-static inline int register_sha256_ni(void) { return 0; }
 static inline void unregister_sha256_ni(void) { }
 #endif
 
 static int __init sha256_ssse3_mod_init(void)
 {
-	if (register_sha256_ssse3())
-		goto fail;
+	const char *feature_name;
+	int ret;
+
+#ifdef CONFIG_AS_SHA256_NI
+	/* SHA-NI */
+	if (boot_cpu_has(X86_FEATURE_SHA_NI)) {
 
-	if (register_sha256_avx()) {
-		unregister_sha256_ssse3();
-		goto fail;
+		ret = crypto_register_shashes(sha256_ni_algs,
+						ARRAY_SIZE(sha256_ni_algs));
+		if (!ret)
+			using_x86_shani = 1;
 	}
+#endif
+
+	/* AVX2 */
+	if (boot_cpu_has(X86_FEATURE_AVX2)) {
 
-	if (register_sha256_avx2()) {
-		unregister_sha256_avx();
-		unregister_sha256_ssse3();
-		goto fail;
+		if (boot_cpu_has(X86_FEATURE_BMI2)) {
+			ret = crypto_register_shashes(sha256_avx2_algs,
+						ARRAY_SIZE(sha256_avx2_algs));
+			if (!ret)
+				using_x86_avx2 = 1;
+		}
 	}
 
-	if (register_sha256_ni()) {
-		unregister_sha256_avx2();
-		unregister_sha256_avx();
-		unregister_sha256_ssse3();
-		goto fail;
+	/* AVX */
+	if (boot_cpu_has(X86_FEATURE_AVX)) {
+
+		if (cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
+			       &feature_name)) {
+			ret = crypto_register_shashes(sha256_avx_algs,
+						ARRAY_SIZE(sha256_avx_algs));
+			if (!ret)
+				using_x86_avx = 1;
+		}
 	}
 
-	return 0;
-fail:
+	/* SSE3 */
+	if (boot_cpu_has(X86_FEATURE_SSSE3)) {
+		ret = crypto_register_shashes(sha256_ssse3_algs,
+					      ARRAY_SIZE(sha256_ssse3_algs));
+		if (!ret)
+			using_x86_ssse3 = 1;
+	}
+
+#ifdef CONFIG_AS_SHA256_NI
+	if (using_x86_shani)
+		return 0;
+#endif
+	if (using_x86_avx2 || using_x86_avx || using_x86_ssse3)
+		return 0;
 	return -ENODEV;
 }
 
diff --git a/arch/x86/crypto/sha512_ssse3_glue.c b/arch/x86/crypto/sha512_ssse3_glue.c
index c7036cfe2a7e..feae85933270 100644
--- a/arch/x86/crypto/sha512_ssse3_glue.c
+++ b/arch/x86/crypto/sha512_ssse3_glue.c
@@ -47,6 +47,10 @@ static const unsigned int bytes_per_fpu_ssse3 = 17 * 1024;
 asmlinkage void sha512_transform_ssse3(struct sha512_state *state,
 				       const u8 *data, int blocks);
 
+static int using_x86_ssse3;
+static int using_x86_avx;
+static int using_x86_avx2;
+
 static int sha512_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len, unsigned int bytes_per_fpu,
 			 sha512_block_fn *sha512_xform)
@@ -152,33 +156,17 @@ static struct shash_alg sha512_ssse3_algs[] = { {
 	}
 } };
 
-static int register_sha512_ssse3(void)
-{
-	if (boot_cpu_has(X86_FEATURE_SSSE3))
-		return crypto_register_shashes(sha512_ssse3_algs,
-			ARRAY_SIZE(sha512_ssse3_algs));
-	return 0;
-}
-
 static void unregister_sha512_ssse3(void)
 {
-	if (boot_cpu_has(X86_FEATURE_SSSE3))
+	if (using_x86_ssse3) {
 		crypto_unregister_shashes(sha512_ssse3_algs,
 			ARRAY_SIZE(sha512_ssse3_algs));
+		using_x86_ssse3 = 0;
+	}
 }
 
 asmlinkage void sha512_transform_avx(struct sha512_state *state,
 				     const u8 *data, int blocks);
-static bool avx_usable(void)
-{
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
-		if (boot_cpu_has(X86_FEATURE_AVX))
-			pr_info("AVX detected but unusable.\n");
-		return false;
-	}
-
-	return true;
-}
 
 static int sha512_avx_update(struct shash_desc *desc, const u8 *data,
 		       unsigned int len)
@@ -230,19 +218,13 @@ static struct shash_alg sha512_avx_algs[] = { {
 	}
 } };
 
-static int register_sha512_avx(void)
-{
-	if (avx_usable())
-		return crypto_register_shashes(sha512_avx_algs,
-			ARRAY_SIZE(sha512_avx_algs));
-	return 0;
-}
-
 static void unregister_sha512_avx(void)
 {
-	if (avx_usable())
+	if (using_x86_avx) {
 		crypto_unregister_shashes(sha512_avx_algs,
 			ARRAY_SIZE(sha512_avx_algs));
+		using_x86_avx = 0;
+	}
 }
 
 asmlinkage void sha512_transform_rorx(struct sha512_state *state,
@@ -298,22 +280,6 @@ static struct shash_alg sha512_avx2_algs[] = { {
 	}
 } };
 
-static bool avx2_usable(void)
-{
-	if (avx_usable() && boot_cpu_has(X86_FEATURE_AVX2) &&
-		    boot_cpu_has(X86_FEATURE_BMI2))
-		return true;
-
-	return false;
-}
-
-static int register_sha512_avx2(void)
-{
-	if (avx2_usable())
-		return crypto_register_shashes(sha512_avx2_algs,
-			ARRAY_SIZE(sha512_avx2_algs));
-	return 0;
-}
 static const struct x86_cpu_id module_cpu_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_AVX2, NULL),
 	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
@@ -324,32 +290,53 @@ MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
 static void unregister_sha512_avx2(void)
 {
-	if (avx2_usable())
+	if (using_x86_avx2) {
 		crypto_unregister_shashes(sha512_avx2_algs,
 			ARRAY_SIZE(sha512_avx2_algs));
+		using_x86_avx2 = 0;
+	}
 }
 
 static int __init sha512_ssse3_mod_init(void)
 {
+	const char *feature_name;
+	int ret;
+
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
-	if (register_sha512_ssse3())
-		goto fail;
+	/* AVX2 */
+	if (boot_cpu_has(X86_FEATURE_AVX2)) {
+		if (boot_cpu_has(X86_FEATURE_BMI2)) {
+			ret = crypto_register_shashes(sha512_avx2_algs,
+					ARRAY_SIZE(sha512_avx2_algs));
+			if (!ret)
+				using_x86_avx2 = 1;
+		}
+	}
+
+	/* AVX */
+	if (boot_cpu_has(X86_FEATURE_AVX)) {
 
-	if (register_sha512_avx()) {
-		unregister_sha512_ssse3();
-		goto fail;
+		if (cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
+				       &feature_name)) {
+			ret = crypto_register_shashes(sha512_avx_algs,
+					ARRAY_SIZE(sha512_avx_algs));
+			if (!ret)
+				using_x86_avx = 1;
+		}
 	}
 
-	if (register_sha512_avx2()) {
-		unregister_sha512_avx();
-		unregister_sha512_ssse3();
-		goto fail;
+	/* SSE3 */
+	if (boot_cpu_has(X86_FEATURE_SSSE3)) {
+		ret = crypto_register_shashes(sha512_ssse3_algs,
+					ARRAY_SIZE(sha512_ssse3_algs));
+		if (!ret)
+			using_x86_ssse3 = 1;
 	}
 
-	return 0;
-fail:
+	if (using_x86_avx2 || using_x86_avx || using_x86_ssse3)
+		return 0;
 	return -ENODEV;
 }
 
-- 
2.38.1

