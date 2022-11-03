Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6634617589
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiKCE3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiKCE2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:28:42 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E13912D35;
        Wed,  2 Nov 2022 21:28:27 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2NweTn002130;
        Thu, 3 Nov 2022 04:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=upITipPVUhAk6AiBvdbjppAU0W/4mLIWDGU9z0fzSQ0=;
 b=RPLHDz4VSKL67rKjxmQeJ4fNdgLoOBBpUXMDSmN4pjJEsqm5cfSCzk43BmrLntibHDf8
 cVQLjSBnSR4AhmkoSJGSbSvlGKzk1pY9Aclb2CH5scs4kTCM4jVLpYBmLosIT6imyymH
 YnZz84tO7z3acs+zlDlEIHKb8ZRFxuZJn+XlYetwnrvtUX8vE2daKhAMu+TqAydb1YyJ
 5yNIq0zAkffUqHQQnSIaSq2dQF+r3CFvd0MN3mJ4GwWP3Rs4wufE++MIKooZm4ZFsWcE
 8PQmqsTZRm+SKQuS0p71gErElS78i80dEM9fqtiafWXDejuMoBeYVC8x7JPeu5lPjyX9 Ww== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3km2pfhdfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 04:28:19 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 161D380471E;
        Thu,  3 Nov 2022 04:28:19 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 79C55808EB8;
        Thu,  3 Nov 2022 04:28:18 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 11/17] crypto: x86/sha - register all variations
Date:   Wed,  2 Nov 2022 23:27:34 -0500
Message-Id: <20221103042740.6556-12-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221103042740.6556-1-elliott@hpe.com>
References: <20221012215931.3896-1-elliott@hpe.com>
 <20221103042740.6556-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8xahrXpTYQUNLbIT4F605rDgfpb6pmm-
X-Proofpoint-ORIG-GUID: 8xahrXpTYQUNLbIT4F605rDgfpb6pmm-
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030031
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 arch/x86/crypto/sha1_ssse3_glue.c   | 135 +++++++++++++------------
 arch/x86/crypto/sha256_ssse3_glue.c | 146 ++++++++++++++--------------
 arch/x86/crypto/sha512_ssse3_glue.c | 108 ++++++++++----------
 3 files changed, 193 insertions(+), 196 deletions(-)

diff --git a/arch/x86/crypto/sha1_ssse3_glue.c b/arch/x86/crypto/sha1_ssse3_glue.c
index 4bc77c84b0fb..89aa5b787f2f 100644
--- a/arch/x86/crypto/sha1_ssse3_glue.c
+++ b/arch/x86/crypto/sha1_ssse3_glue.c
@@ -128,17 +128,17 @@ static struct shash_alg sha1_ssse3_alg = {
 	}
 };
 
-static int register_sha1_ssse3(void)
-{
-	if (boot_cpu_has(X86_FEATURE_SSSE3))
-		return crypto_register_shash(&sha1_ssse3_alg);
-	return 0;
-}
+static bool sha1_ssse3_registered;
+static bool sha1_avx_registered;
+static bool sha1_avx2_registered;
+static bool sha1_ni_registered;
 
 static void unregister_sha1_ssse3(void)
 {
-	if (boot_cpu_has(X86_FEATURE_SSSE3))
+	if (sha1_ssse3_registered) {
 		crypto_unregister_shash(&sha1_ssse3_alg);
+		sha1_ssse3_registered = 0;
+	}
 }
 
 asmlinkage void sha1_transform_avx(struct sha1_state *state,
@@ -179,28 +179,12 @@ static struct shash_alg sha1_avx_alg = {
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
+	if (sha1_avx_registered) {
 		crypto_unregister_shash(&sha1_avx_alg);
+		sha1_avx_registered = 0;
+	}
 }
 
 #define SHA1_AVX2_BLOCK_OPTSIZE	4	/* optimal 4*64 bytes of SHA1 blocks */
@@ -208,16 +192,6 @@ static void unregister_sha1_avx(void)
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
@@ -263,17 +237,12 @@ static struct shash_alg sha1_avx2_alg = {
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
+	if (sha1_avx2_registered) {
 		crypto_unregister_shash(&sha1_avx2_alg);
+		sha1_avx2_registered = 0;
+	}
 }
 
 #ifdef CONFIG_AS_SHA1_NI
@@ -315,49 +284,77 @@ static struct shash_alg sha1_ni_alg = {
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
+	if (sha1_ni_registered) {
 		crypto_unregister_shash(&sha1_ni_alg);
+		sha1_ni_registered = 0;
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
+	const char *driver_name = NULL;
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
+			sha1_ni_registered = 1;
+	}
+#endif
+
+	/* AVX2 */
+	if (boot_cpu_has(X86_FEATURE_AVX2)) {
+
+		if (boot_cpu_has(X86_FEATURE_BMI1) &&
+		    boot_cpu_has(X86_FEATURE_BMI2)) {
+
+			ret = crypto_register_shash(&sha1_avx2_alg);
+			if (!ret) {
+				sha1_avx2_registered = 1;
+				driver_name = sha1_avx2_alg.base.cra_driver_name;
+			}
+		}
 	}
 
-	if (register_sha1_avx2()) {
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
+			if (!ret) {
+				sha1_avx_registered = 1;
+				driver_name = sha1_avx_alg.base.cra_driver_name;
+			}
+		}
 	}
 
-	if (register_sha1_ni()) {
-		unregister_sha1_avx2();
-		unregister_sha1_avx();
-		unregister_sha1_ssse3();
-		goto fail;
+	/* SSE3 */
+	if (boot_cpu_has(X86_FEATURE_SSSE3)) {
+		ret = crypto_register_shash(&sha1_ssse3_alg);
+		if (!ret) {
+			sha1_ssse3_registered = 1;
+			driver_name = sha1_ssse3_alg.base.cra_driver_name;
+		}
 	}
 
-	return 0;
-fail:
+#ifdef CONFIG_AS_SHA1_NI
+	if (sha1_ni_registered)
+		return 0;
+#endif
+	if (sha1_avx2_registered || sha1_avx_registered || sha1_ssse3_registered)
+		return 0;
 	return -ENODEV;
 }
 
diff --git a/arch/x86/crypto/sha256_ssse3_glue.c b/arch/x86/crypto/sha256_ssse3_glue.c
index cdcdf5a80ffe..de320973e473 100644
--- a/arch/x86/crypto/sha256_ssse3_glue.c
+++ b/arch/x86/crypto/sha256_ssse3_glue.c
@@ -156,19 +156,18 @@ static struct shash_alg sha256_ssse3_algs[] = { {
 	}
 } };
 
-static int register_sha256_ssse3(void)
-{
-	if (boot_cpu_has(X86_FEATURE_SSSE3))
-		return crypto_register_shashes(sha256_ssse3_algs,
-				ARRAY_SIZE(sha256_ssse3_algs));
-	return 0;
-}
+static bool sha256_ssse3_registered;
+static bool sha256_avx_registered;
+static bool sha256_avx2_registered;
+static bool sha256_ni_registered;
 
 static void unregister_sha256_ssse3(void)
 {
-	if (boot_cpu_has(X86_FEATURE_SSSE3))
+	if (sha256_ssse3_registered) {
 		crypto_unregister_shashes(sha256_ssse3_algs,
 				ARRAY_SIZE(sha256_ssse3_algs));
+		sha256_ssse3_registered = 0;
+	}
 }
 
 asmlinkage void sha256_transform_avx(struct sha256_state *state,
@@ -223,30 +222,13 @@ static struct shash_alg sha256_avx_algs[] = { {
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
+	if (sha256_avx_registered) {
 		crypto_unregister_shashes(sha256_avx_algs,
 				ARRAY_SIZE(sha256_avx_algs));
+		sha256_avx_registered = 0;
+	}
 }
 
 asmlinkage void sha256_transform_rorx(struct sha256_state *state,
@@ -301,28 +283,13 @@ static struct shash_alg sha256_avx2_algs[] = { {
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
+	if (sha256_avx2_registered) {
 		crypto_unregister_shashes(sha256_avx2_algs,
 				ARRAY_SIZE(sha256_avx2_algs));
+		sha256_avx2_registered = 0;
+	}
 }
 
 #ifdef CONFIG_AS_SHA256_NI
@@ -378,51 +345,86 @@ static struct shash_alg sha256_ni_algs[] = { {
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
+	if (sha256_ni_registered) {
 		crypto_unregister_shashes(sha256_ni_algs,
 				ARRAY_SIZE(sha256_ni_algs));
+		sha256_ni_registered = 0;
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
+	const char *driver_name = NULL;
+	const char *driver_name2 = NULL;
+	int ret;
 
-	if (register_sha256_avx()) {
-		unregister_sha256_ssse3();
-		goto fail;
+#ifdef CONFIG_AS_SHA256_NI
+	/* SHA-NI */
+	if (boot_cpu_has(X86_FEATURE_SHA_NI)) {
+
+		ret = crypto_register_shashes(sha256_ni_algs,
+						ARRAY_SIZE(sha256_ni_algs));
+		if (!ret) {
+			sha256_ni_registered = 1;
+			driver_name = sha256_ni_algs[0].base.cra_driver_name;
+			driver_name2 = sha256_ni_algs[1].base.cra_driver_name;
+		}
 	}
+#endif
 
-	if (register_sha256_avx2()) {
-		unregister_sha256_avx();
-		unregister_sha256_ssse3();
-		goto fail;
+	/* AVX2 */
+	if (boot_cpu_has(X86_FEATURE_AVX2)) {
+
+		if (boot_cpu_has(X86_FEATURE_BMI2)) {
+			ret = crypto_register_shashes(sha256_avx2_algs,
+						ARRAY_SIZE(sha256_avx2_algs));
+			if (!ret) {
+				sha256_avx2_registered = 1;
+				driver_name = sha256_avx2_algs[0].base.cra_driver_name;
+				driver_name2 = sha256_avx2_algs[1].base.cra_driver_name;
+			}
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
+			if (!ret) {
+				sha256_avx_registered = 1;
+				driver_name = sha256_avx_algs[0].base.cra_driver_name;
+				driver_name2 = sha256_avx_algs[1].base.cra_driver_name;
+			}
+		}
 	}
 
-	return 0;
-fail:
+	/* SSE3 */
+	if (boot_cpu_has(X86_FEATURE_SSSE3)) {
+		ret = crypto_register_shashes(sha256_ssse3_algs,
+					      ARRAY_SIZE(sha256_ssse3_algs));
+		if (!ret) {
+			sha256_ssse3_registered = 1;
+			driver_name = sha256_ssse3_algs[0].base.cra_driver_name;
+			driver_name2 = sha256_ssse3_algs[1].base.cra_driver_name;
+		}
+	}
+
+#ifdef CONFIG_AS_SHA256_NI
+	if (sha256_ni_registered)
+		return 0;
+#endif
+	if (sha256_avx2_registered || sha256_avx_registered || sha256_ssse3_registered)
+		return 0;
 	return -ENODEV;
 }
 
diff --git a/arch/x86/crypto/sha512_ssse3_glue.c b/arch/x86/crypto/sha512_ssse3_glue.c
index c7036cfe2a7e..3e96fe51f1a0 100644
--- a/arch/x86/crypto/sha512_ssse3_glue.c
+++ b/arch/x86/crypto/sha512_ssse3_glue.c
@@ -152,33 +152,21 @@ static struct shash_alg sha512_ssse3_algs[] = { {
 	}
 } };
 
-static int register_sha512_ssse3(void)
-{
-	if (boot_cpu_has(X86_FEATURE_SSSE3))
-		return crypto_register_shashes(sha512_ssse3_algs,
-			ARRAY_SIZE(sha512_ssse3_algs));
-	return 0;
-}
+static bool sha512_ssse3_registered;
+static bool sha512_avx_registered;
+static bool sha512_avx2_registered;
 
 static void unregister_sha512_ssse3(void)
 {
-	if (boot_cpu_has(X86_FEATURE_SSSE3))
+	if (sha512_ssse3_registered) {
 		crypto_unregister_shashes(sha512_ssse3_algs,
 			ARRAY_SIZE(sha512_ssse3_algs));
+		sha512_ssse3_registered = 0;
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
+	if (sha512_avx_registered) {
 		crypto_unregister_shashes(sha512_avx_algs,
 			ARRAY_SIZE(sha512_avx_algs));
+		sha512_avx_registered = 0;
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
@@ -324,32 +290,64 @@ MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
 static void unregister_sha512_avx2(void)
 {
-	if (avx2_usable())
+	if (sha512_avx2_registered) {
 		crypto_unregister_shashes(sha512_avx2_algs,
 			ARRAY_SIZE(sha512_avx2_algs));
+		sha512_avx2_registered = 0;
+	}
 }
 
 static int __init sha512_ssse3_mod_init(void)
 {
+	const char *feature_name;
+	const char *driver_name = NULL;
+	const char *driver_name2 = NULL;
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
+			if (!ret) {
+				sha512_avx2_registered = 1;
+				driver_name = sha512_avx2_algs[0].base.cra_driver_name;
+				driver_name2 = sha512_avx2_algs[1].base.cra_driver_name;
+			}
+		}
+	}
 
-	if (register_sha512_avx()) {
-		unregister_sha512_ssse3();
-		goto fail;
+	/* AVX */
+	if (boot_cpu_has(X86_FEATURE_AVX)) {
+
+		if (cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
+				       &feature_name)) {
+			ret = crypto_register_shashes(sha512_avx_algs,
+					ARRAY_SIZE(sha512_avx_algs));
+			if (!ret) {
+				sha512_avx_registered = 1;
+				driver_name = sha512_avx_algs[0].base.cra_driver_name;
+				driver_name2 = sha512_avx_algs[1].base.cra_driver_name;
+			}
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
+		if (!ret) {
+			sha512_ssse3_registered = 1;
+			driver_name = sha512_ssse3_algs[0].base.cra_driver_name;
+			driver_name2 = sha512_ssse3_algs[1].base.cra_driver_name;
+		}
 	}
 
-	return 0;
-fail:
+	if (sha512_avx2_registered || sha512_avx_registered || sha512_ssse3_registered)
+		return 0;
 	return -ENODEV;
 }
 
-- 
2.37.3

