Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D4E5FCE06
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJLWDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiJLWBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:01:39 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8860610324C;
        Wed, 12 Oct 2022 15:00:27 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CKWT9x015442;
        Wed, 12 Oct 2022 22:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=K0yyN1Z9ykifAfRg9N8WShvUGMpa8FIhYC0CUsfvRDw=;
 b=mVhez82LOF2jhuRvGSI27LUkKOAUZ1b+Edj+9zvfQvsFVE3ngyNXmhmblWCmkUoyVzXx
 P4Q8i6D3de3Hw9zHBntr2L1AoqeBKOMtukz5H+kYMbH/6Fnog9chP1WlXbydGN/tiLhv
 e/Yy/WdEbxii64ByH/EoxRuYQXLjHYzASqr2bx1q12AsL6z8wFOGDZdvumKL9GAnQFUb
 uXkO98EWWUSOgjlzsSqJVqiZftJdj6UXObapdVRgGkHh4XnIBp5ewl7GY3s1Pk5adaYW
 wA2bGojpRB/fXeN0ES2aO3wdXEjMdDxPO8qLsekzkH5tUHcGhI5ZpV/amfBi4QJPpP04 tQ== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k615t2eth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 22:00:12 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 013CBD268;
        Wed, 12 Oct 2022 22:00:11 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 9B9058038C2;
        Wed, 12 Oct 2022 22:00:11 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 19/19] crypto: x86/sha - register only the best function
Date:   Wed, 12 Oct 2022 16:59:31 -0500
Message-Id: <20221012215931.3896-20-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012215931.3896-1-elliott@hpe.com>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MtKhtP7F9kP6sMI-XKAtztT-zs2OFsZc
X-Proofpoint-ORIG-GUID: MtKhtP7F9kP6sMI-XKAtztT-zs2OFsZc
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_11,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120138
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't register and unregister each of the functions from least-
to most-optimized (SSSE3 then AVX then AVX2); determine the
most-optimized function and load only that version.

Suggested-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/sha1_ssse3_glue.c   | 139 ++++++++++++-------------
 arch/x86/crypto/sha256_ssse3_glue.c | 154 ++++++++++++++--------------
 arch/x86/crypto/sha512_ssse3_glue.c | 120 ++++++++++++----------
 3 files changed, 210 insertions(+), 203 deletions(-)

diff --git a/arch/x86/crypto/sha1_ssse3_glue.c b/arch/x86/crypto/sha1_ssse3_glue.c
index edffc33bd12e..90a86d737bcf 100644
--- a/arch/x86/crypto/sha1_ssse3_glue.c
+++ b/arch/x86/crypto/sha1_ssse3_glue.c
@@ -123,17 +123,16 @@ static struct shash_alg sha1_ssse3_alg = {
 	}
 };
 
-static int register_sha1_ssse3(void)
-{
-	if (boot_cpu_has(X86_FEATURE_SSSE3))
-		return crypto_register_shash(&sha1_ssse3_alg);
-	return 0;
-}
-
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
@@ -172,28 +171,12 @@ static struct shash_alg sha1_avx_alg = {
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
@@ -201,16 +184,6 @@ static void unregister_sha1_avx(void)
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
@@ -254,17 +227,13 @@ static struct shash_alg sha1_avx2_alg = {
 	}
 };
 
-static int register_sha1_avx2(void)
-{
-	if (avx2_usable())
-		return crypto_register_shash(&sha1_avx2_alg);
-	return 0;
-}
 
 static void unregister_sha1_avx2(void)
 {
-	if (avx2_usable())
+	if (sha1_avx2_registered) {
 		crypto_unregister_shash(&sha1_avx2_alg);
+		sha1_avx2_registered = 0;
+	}
 }
 
 #ifdef CONFIG_AS_SHA1_NI
@@ -304,13 +273,6 @@ static struct shash_alg sha1_ni_alg = {
 	}
 };
 
-static int register_sha1_ni(void)
-{
-	if (boot_cpu_has(X86_FEATURE_SHA_NI))
-		return crypto_register_shash(&sha1_ni_alg);
-	return 0;
-}
-
 static const struct x86_cpu_id module_cpu_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_SHA_NI, NULL),
 	X86_MATCH_FEATURE(X86_FEATURE_AVX2, NULL),
@@ -322,44 +284,79 @@ MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
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
 
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
-	if (register_sha1_avx()) {
-		unregister_sha1_ssse3();
-		goto fail;
-	}
+	/* SHA-NI */
+	if (boot_cpu_has(X86_FEATURE_SHA_NI)) {
 
-	if (register_sha1_avx2()) {
-		unregister_sha1_avx();
-		unregister_sha1_ssse3();
-		goto fail;
-	}
+		ret = crypto_register_shash(&sha1_ni_alg);
+		if (!ret)
+			sha1_ni_registered = 1;
 
-	if (register_sha1_ni()) {
-		unregister_sha1_avx2();
-		unregister_sha1_avx();
-		unregister_sha1_ssse3();
-		goto fail;
+	/* AVX2 */
+	} else if (boot_cpu_has(X86_FEATURE_AVX2)) {
+
+		if (boot_cpu_has(X86_FEATURE_BMI1) &&
+		    boot_cpu_has(X86_FEATURE_BMI2)) {
+
+			ret = crypto_register_shash(&sha1_avx2_alg);
+			if (!ret) {
+				sha1_avx2_registered = 1;
+				driver_name = sha1_avx2_alg.base.cra_driver_name;
+			}
+		} else {
+			pr_info("AVX2-optimized version not engaged, all required features (AVX2, BMI1, BMI2) not supported\n");
+		}
+
+	/* AVX */
+	} else if (boot_cpu_has(X86_FEATURE_AVX)) {
+
+		if (cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
+			       &feature_name)) {
+
+			ret = crypto_register_shash(&sha1_avx_alg);
+			if (!ret) {
+				sha1_avx_registered = 1;
+				driver_name = sha1_avx_alg.base.cra_driver_name;
+			}
+		} else {
+			pr_info("AVX-optimized version not engaged, CPU extended feature '%s' is not supported\n",
+				feature_name);
+		}
+
+	/* SSE3 */
+	} else if (boot_cpu_has(X86_FEATURE_SSSE3)) {
+		ret = crypto_register_shash(&sha1_ssse3_alg);
+		if (!ret) {
+			sha1_ssse3_registered = 1;
+			driver_name = sha1_ssse3_alg.base.cra_driver_name;
+		}
 	}
 
+	pr_info("CPU-optimized crypto module loaded (SSSE3=%s, AVX=%s, AVX2=%s, SHA-NI=%s): driver=%s\n",
+		sha1_ssse3_registered ? "yes" : "no",
+		sha1_avx_registered ? "yes" : "no",
+		sha1_avx2_registered ? "yes" : "no",
+		sha1_ni_registered ? "yes" : "no",
+		driver_name);
 	return 0;
-fail:
-	return -ENODEV;
 }
 
 static void __exit sha1_ssse3_mod_fini(void)
diff --git a/arch/x86/crypto/sha256_ssse3_glue.c b/arch/x86/crypto/sha256_ssse3_glue.c
index 8a0fb308fbba..cd7bf2b48f3d 100644
--- a/arch/x86/crypto/sha256_ssse3_glue.c
+++ b/arch/x86/crypto/sha256_ssse3_glue.c
@@ -150,19 +150,18 @@ static struct shash_alg sha256_ssse3_algs[] = { {
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
@@ -215,30 +214,13 @@ static struct shash_alg sha256_avx_algs[] = { {
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
@@ -291,28 +273,13 @@ static struct shash_alg sha256_avx2_algs[] = { {
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
@@ -375,55 +342,92 @@ static const struct x86_cpu_id module_cpu_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
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
-	if (!x86_match_cpu(module_cpu_ids))
+	const char *feature_name;
+	const char *driver_name = NULL;
+	const char *driver_name2 = NULL;
+	int ret;
+
+	if (!x86_match_cpu(module_cpu_ids)) {
+		pr_info("CPU-optimized crypto module not loaded, required CPU features (SSSE3, AVX, AVX2, or SHA-NI) not supported\n");
 		return -ENODEV;
+	}
 
-	if (register_sha256_ssse3())
-		goto fail;
+	/* SHA-NI */
+	if (boot_cpu_has(X86_FEATURE_SHA_NI)) {
 
-	if (register_sha256_avx()) {
-		unregister_sha256_ssse3();
-		goto fail;
-	}
+		ret = crypto_register_shashes(sha256_ni_algs,
+						ARRAY_SIZE(sha256_ni_algs));
+		if (!ret) {
+			sha256_ni_registered = 1;
+			driver_name = sha256_ni_algs[0].base.cra_driver_name;
+			driver_name2 = sha256_ni_algs[1].base.cra_driver_name;
+		}
 
-	if (register_sha256_avx2()) {
-		unregister_sha256_avx();
-		unregister_sha256_ssse3();
-		goto fail;
-	}
+	/* AVX2 */
+	} else if (boot_cpu_has(X86_FEATURE_AVX2)) {
+
+		if (boot_cpu_has(X86_FEATURE_BMI2)) {
+			ret = crypto_register_shashes(sha256_avx2_algs,
+						ARRAY_SIZE(sha256_avx2_algs));
+			if (!ret) {
+				sha256_avx2_registered = 1;
+				driver_name = sha256_avx2_algs[0].base.cra_driver_name;
+				driver_name2 = sha256_avx2_algs[1].base.cra_driver_name;
+			}
+		} else {
+			pr_info("AVX2-optimized version not engaged, all required CPU features (AVX2, BMI2) not supported\n");
+		}
 
-	if (register_sha256_ni()) {
-		unregister_sha256_avx2();
-		unregister_sha256_avx();
-		unregister_sha256_ssse3();
-		goto fail;
+	/* AVX */
+	} else if (boot_cpu_has(X86_FEATURE_AVX)) {
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
+		} else {
+			pr_info("AVX-optimized version not engaged, CPU extended feature '%s' is not supported\n",
+				feature_name);
+		}
+
+	/* SSE3 */
+	} else if (boot_cpu_has(X86_FEATURE_SSSE3)) {
+		ret = crypto_register_shashes(sha256_ssse3_algs,
+					      ARRAY_SIZE(sha256_ssse3_algs));
+		if (!ret) {
+			sha256_ssse3_registered = 1;
+			driver_name = sha256_ssse3_algs[0].base.cra_driver_name;
+			driver_name2 = sha256_ssse3_algs[1].base.cra_driver_name;
+		}
 	}
 
+	pr_info("CPU-optimized crypto module loaded (SSSE3=%s, AVX=%s, AVX2=%s, SHA-NI=%s): drivers=%s, %s\n",
+		sha256_ssse3_registered ? "yes" : "no",
+		sha256_avx_registered ? "yes" : "no",
+		sha256_avx2_registered ? "yes" : "no",
+		sha256_ni_registered ? "yes" : "no",
+		driver_name, driver_name2);
 	return 0;
-fail:
-	return -ENODEV;
 }
 
 static void __exit sha256_ssse3_mod_fini(void)
diff --git a/arch/x86/crypto/sha512_ssse3_glue.c b/arch/x86/crypto/sha512_ssse3_glue.c
index fd5075a32613..df9f8207cc79 100644
--- a/arch/x86/crypto/sha512_ssse3_glue.c
+++ b/arch/x86/crypto/sha512_ssse3_glue.c
@@ -149,33 +149,21 @@ static struct shash_alg sha512_ssse3_algs[] = { {
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
@@ -225,19 +213,13 @@ static struct shash_alg sha512_avx_algs[] = { {
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
@@ -291,22 +273,6 @@ static struct shash_alg sha512_avx2_algs[] = { {
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
@@ -317,33 +283,73 @@ MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
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
-	if (!x86_match_cpu(module_cpu_ids))
+	const char *feature_name;
+	const char *driver_name = NULL;
+	const char *driver_name2 = NULL;
+	int ret;
+
+	if (!x86_match_cpu(module_cpu_ids)) {
+		pr_info("CPU-optimized crypto module not loaded, required CPU features (SSSE3, AVX, or AVX2) not supported\n");
 		return -ENODEV;
+	}
 
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
+		} else {
+			pr_info("AVX2-optimized version not engaged, all required CPU features (AVX2, BMI2) not supported\n");
+		}
 
-	if (register_sha512_avx()) {
-		unregister_sha512_ssse3();
-		goto fail;
-	}
+	/* AVX */
+	} else if (boot_cpu_has(X86_FEATURE_AVX)) {
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
+		} else {
+			pr_info("AVX-optimized version not engaged, CPU extended feature '%s' is not supported\n",
+				feature_name);
+		}
 
-	if (register_sha512_avx2()) {
-		unregister_sha512_avx();
-		unregister_sha512_ssse3();
-		goto fail;
+	/* SSE3 */
+	} else if (boot_cpu_has(X86_FEATURE_SSSE3)) {
+		ret = crypto_register_shashes(sha512_ssse3_algs,
+					ARRAY_SIZE(sha512_ssse3_algs));
+		if (!ret) {
+			sha512_ssse3_registered = 1;
+			driver_name = sha512_ssse3_algs[0].base.cra_driver_name;
+			driver_name2 = sha512_ssse3_algs[1].base.cra_driver_name;
+		}
 	}
 
+	pr_info("CPU-optimized crypto module loaded (SSSE3=%s, AVX=%s, AVX2=%s): drivers=%s, %s\n",
+		sha512_ssse3_registered ? "yes" : "no",
+		sha512_avx_registered ? "yes" : "no",
+		sha512_avx2_registered ? "yes" : "no",
+		driver_name, driver_name2);
 	return 0;
-fail:
-	return -ENODEV;
 }
 
 static void __exit sha512_ssse3_mod_fini(void)
-- 
2.37.3

