Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5807862B243
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 05:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbiKPEQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 23:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiKPEO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 23:14:56 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A8C31ED3;
        Tue, 15 Nov 2022 20:14:29 -0800 (PST)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG31FuU027400;
        Wed, 16 Nov 2022 04:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=fUEoWBalDn15t5cghIYwbOp4kr7w2eJcKg0SlIogXXk=;
 b=j/FVsITL3XCoJxa42FwyW4IUVUWbCaYUqCnslWOqvkZKz/uWmcMQjnbeMhGUDPVx1rfj
 WpqScT+88gC9OIempR+TuEiV3z6Z3Xcx7jIRmvCoO+yMwSF4lcDpAcHUX2A4VQyJKSv6
 mCkDwpLpdvYRRD97c91v5xDEajKIxb847PL/R/4IJkZIZr6ZoiO4O8fZpdZyDmlHhfyQ
 Tmr3I5zQalhn9zOhx82HadVFirJTkhccBSwjmGP/PlEL5VATDLEmh1WSulKre3AspVmK
 ps+nvZqqxSnNQpXQQ6v/3pCwPcos9R9hiilEspFwPL5edK7r2ovK8nh+3ob+Gc7Q7ZT3 Hw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3kvqkbregk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 04:14:20 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 318412EEEE;
        Wed, 16 Nov 2022 04:14:20 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id B379180FE95;
        Wed, 16 Nov 2022 04:14:19 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v4 22/24] crypto: x86 - report missing CPU features via module parameters
Date:   Tue, 15 Nov 2022 22:13:40 -0600
Message-Id: <20221116041342.3841-23-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116041342.3841-1-elliott@hpe.com>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SFk6rY61usHRwlIC9RezUVnsIZGLCIrq
X-Proofpoint-ORIG-GUID: SFk6rY61usHRwlIC9RezUVnsIZGLCIrq
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211160029
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't refuse to load modules based on missing additional x86 features
(e.g., OSXSAVE) or x86 XSAVE features (e.g., YMM). Instead, load the module,
but don't register any crypto drivers. Report the fact that one or more
features are missing in a new missing_x86_features module parameter
(0 = no problems, 1 = something is missing; each module parameter
description lists all the features that it wants).

For the SHA functions that register up to four drivers based on CPU
features, report separate module parameters for each set:
	missing_x86_features_avx2
	missing_x86_features_avx

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/aegis128-aesni-glue.c      | 15 ++++++++++---
 arch/x86/crypto/aria_aesni_avx_glue.c      | 24 +++++++++++---------
 arch/x86/crypto/camellia_aesni_avx2_glue.c | 25 ++++++++++++---------
 arch/x86/crypto/camellia_aesni_avx_glue.c  | 25 ++++++++++++---------
 arch/x86/crypto/cast5_avx_glue.c           | 20 ++++++++++-------
 arch/x86/crypto/cast6_avx_glue.c           | 20 ++++++++++-------
 arch/x86/crypto/curve25519-x86_64.c        | 12 ++++++++--
 arch/x86/crypto/nhpoly1305-avx2-glue.c     | 14 +++++++++---
 arch/x86/crypto/polyval-clmulni_glue.c     | 15 ++++++++++---
 arch/x86/crypto/serpent_avx2_glue.c        | 24 +++++++++++---------
 arch/x86/crypto/serpent_avx_glue.c         | 21 ++++++++++-------
 arch/x86/crypto/sha1_ssse3_glue.c          | 20 +++++++++++++----
 arch/x86/crypto/sha256_ssse3_glue.c        | 18 +++++++++++++--
 arch/x86/crypto/sha512_ssse3_glue.c        | 18 +++++++++++++--
 arch/x86/crypto/sm3_avx_glue.c             | 22 ++++++++++--------
 arch/x86/crypto/sm4_aesni_avx2_glue.c      | 26 +++++++++++++---------
 arch/x86/crypto/sm4_aesni_avx_glue.c       | 26 +++++++++++++---------
 arch/x86/crypto/twofish_avx_glue.c         | 19 ++++++++++------
 18 files changed, 243 insertions(+), 121 deletions(-)

diff --git a/arch/x86/crypto/aegis128-aesni-glue.c b/arch/x86/crypto/aegis128-aesni-glue.c
index a3ebd018953c..e0312ecf34a8 100644
--- a/arch/x86/crypto/aegis128-aesni-glue.c
+++ b/arch/x86/crypto/aegis128-aesni-glue.c
@@ -288,6 +288,11 @@ static const struct x86_cpu_id module_cpu_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
+static int missing_x86_features;
+module_param(missing_x86_features, int, 0444);
+MODULE_PARM_DESC(missing_x86_features,
+		 "Missing x86 instruction set extensions (SSE2) and/or XSAVE features (SSE)");
+
 static struct simd_aead_alg *simd_alg;
 
 static int __init crypto_aegis128_aesni_module_init(void)
@@ -296,8 +301,10 @@ static int __init crypto_aegis128_aesni_module_init(void)
 		return -ENODEV;
 
 	if (!boot_cpu_has(X86_FEATURE_XMM2) ||
-	    !cpu_has_xfeatures(XFEATURE_MASK_SSE, NULL))
-		return -ENODEV;
+	    !cpu_has_xfeatures(XFEATURE_MASK_SSE, NULL)) {
+		missing_x86_features = 1;
+		return 0;
+	}
 
 	return simd_register_aeads_compat(&crypto_aegis128_aesni_alg, 1,
 					  &simd_alg);
@@ -305,7 +312,9 @@ static int __init crypto_aegis128_aesni_module_init(void)
 
 static void __exit crypto_aegis128_aesni_module_exit(void)
 {
-	simd_unregister_aeads(&crypto_aegis128_aesni_alg, 1, &simd_alg);
+	if (!missing_x86_features)
+		simd_unregister_aeads(&crypto_aegis128_aesni_alg, 1, &simd_alg);
+	missing_x86_features = 0;
 }
 
 module_init(crypto_aegis128_aesni_module_init);
diff --git a/arch/x86/crypto/aria_aesni_avx_glue.c b/arch/x86/crypto/aria_aesni_avx_glue.c
index 9fd3d1fe1105..ebb9760967b5 100644
--- a/arch/x86/crypto/aria_aesni_avx_glue.c
+++ b/arch/x86/crypto/aria_aesni_avx_glue.c
@@ -176,23 +176,25 @@ static const struct x86_cpu_id module_cpu_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
+static int missing_x86_features;
+module_param(missing_x86_features, int, 0444);
+MODULE_PARM_DESC(missing_x86_features,
+		 "Missing x86 instruction set extensions (AES-NI, OSXSAVE) and/or XSAVE features (SSE, YMM)");
+
 static int __init aria_avx_init(void)
 {
-	const char *feature_name;
-
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
 	if (!boot_cpu_has(X86_FEATURE_AES) ||
 	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
-		pr_info("AES or OSXSAVE instructions are not detected.\n");
-		return -ENODEV;
+		missing_x86_features = 1;
+		return 0;
 	}
 
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
-		return -ENODEV;
+	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
+		missing_x86_features = 1;
+		return 0;
 	}
 
 	if (boot_cpu_has(X86_FEATURE_GFNI)) {
@@ -213,8 +215,10 @@ static int __init aria_avx_init(void)
 
 static void __exit aria_avx_exit(void)
 {
-	simd_unregister_skciphers(aria_algs, ARRAY_SIZE(aria_algs),
-				  aria_simd_algs);
+	if (!missing_x86_features)
+		simd_unregister_skciphers(aria_algs, ARRAY_SIZE(aria_algs),
+					  aria_simd_algs);
+	missing_x86_features = 0;
 	using_x86_gfni = 0;
 }
 
diff --git a/arch/x86/crypto/camellia_aesni_avx2_glue.c b/arch/x86/crypto/camellia_aesni_avx2_glue.c
index 6c48fc9f3fde..e8ae1e1a801d 100644
--- a/arch/x86/crypto/camellia_aesni_avx2_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx2_glue.c
@@ -105,26 +105,28 @@ static const struct x86_cpu_id module_cpu_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
+static int missing_x86_features;
+module_param(missing_x86_features, int, 0444);
+MODULE_PARM_DESC(missing_x86_features,
+		 "Missing x86 instruction set extensions (AES-NI, AVX, OSXSAVE) and/or XSAVE features (SSE, YMM)");
+
 static struct simd_skcipher_alg *camellia_simd_algs[ARRAY_SIZE(camellia_algs)];
 
 static int __init camellia_aesni_init(void)
 {
-	const char *feature_name;
-
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
 	if (!boot_cpu_has(X86_FEATURE_AES) ||
 	    !boot_cpu_has(X86_FEATURE_AVX) ||
 	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
-		pr_info("AES-NI, AVX, or OSXSAVE instructions are not detected.\n");
-		return -ENODEV;
+		missing_x86_features = 1;
+		return 0;
 	}
 
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
-		return -ENODEV;
+	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
+		missing_x86_features = 1;
+		return 0;
 	}
 
 	return simd_register_skciphers_compat(camellia_algs,
@@ -134,8 +136,11 @@ static int __init camellia_aesni_init(void)
 
 static void __exit camellia_aesni_fini(void)
 {
-	simd_unregister_skciphers(camellia_algs, ARRAY_SIZE(camellia_algs),
-				  camellia_simd_algs);
+	if (!missing_x86_features)
+		simd_unregister_skciphers(camellia_algs,
+					  ARRAY_SIZE(camellia_algs),
+					  camellia_simd_algs);
+	missing_x86_features = 0;
 }
 
 module_init(camellia_aesni_init);
diff --git a/arch/x86/crypto/camellia_aesni_avx_glue.c b/arch/x86/crypto/camellia_aesni_avx_glue.c
index 6d7fc96d242e..6784d631575c 100644
--- a/arch/x86/crypto/camellia_aesni_avx_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx_glue.c
@@ -105,25 +105,27 @@ static const struct x86_cpu_id module_cpu_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
+static int missing_x86_features;
+module_param(missing_x86_features, int, 0444);
+MODULE_PARM_DESC(missing_x86_features,
+		 "Missing x86 instruction set extensions (AES-NI, OSXSAVE) and/or XSAVE features (SSE, YMM)");
+
 static struct simd_skcipher_alg *camellia_simd_algs[ARRAY_SIZE(camellia_algs)];
 
 static int __init camellia_aesni_init(void)
 {
-	const char *feature_name;
-
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
 	if (!boot_cpu_has(X86_FEATURE_AES) ||
 	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
-		pr_info("AES-NI or OSXSAVE instructions are not detected.\n");
-		return -ENODEV;
+		missing_x86_features = 1;
+		return 0;
 	}
 
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
-		return -ENODEV;
+	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
+		missing_x86_features = 1;
+		return 0;
 	}
 
 	return simd_register_skciphers_compat(camellia_algs,
@@ -133,8 +135,11 @@ static int __init camellia_aesni_init(void)
 
 static void __exit camellia_aesni_fini(void)
 {
-	simd_unregister_skciphers(camellia_algs, ARRAY_SIZE(camellia_algs),
-				  camellia_simd_algs);
+	if (!missing_x86_features)
+		simd_unregister_skciphers(camellia_algs,
+					  ARRAY_SIZE(camellia_algs),
+					  camellia_simd_algs);
+	missing_x86_features = 0;
 }
 
 module_init(camellia_aesni_init);
diff --git a/arch/x86/crypto/cast5_avx_glue.c b/arch/x86/crypto/cast5_avx_glue.c
index bdc3c763334c..34ef032bb8d0 100644
--- a/arch/x86/crypto/cast5_avx_glue.c
+++ b/arch/x86/crypto/cast5_avx_glue.c
@@ -100,19 +100,21 @@ static const struct x86_cpu_id module_cpu_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
+static int missing_x86_features;
+module_param(missing_x86_features, int, 0444);
+MODULE_PARM_DESC(missing_x86_features,
+		 "Missing x86 XSAVE features (SSE, YMM)");
+
 static struct simd_skcipher_alg *cast5_simd_algs[ARRAY_SIZE(cast5_algs)];
 
 static int __init cast5_init(void)
 {
-	const char *feature_name;
-
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
-		return -ENODEV;
+	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
+		missing_x86_features = 1;
+		return 0;
 	}
 
 	return simd_register_skciphers_compat(cast5_algs,
@@ -122,8 +124,10 @@ static int __init cast5_init(void)
 
 static void __exit cast5_exit(void)
 {
-	simd_unregister_skciphers(cast5_algs, ARRAY_SIZE(cast5_algs),
-				  cast5_simd_algs);
+	if (!missing_x86_features)
+		simd_unregister_skciphers(cast5_algs, ARRAY_SIZE(cast5_algs),
+					  cast5_simd_algs);
+	missing_x86_features = 0;
 }
 
 module_init(cast5_init);
diff --git a/arch/x86/crypto/cast6_avx_glue.c b/arch/x86/crypto/cast6_avx_glue.c
index addca34b3511..71559fd3ea87 100644
--- a/arch/x86/crypto/cast6_avx_glue.c
+++ b/arch/x86/crypto/cast6_avx_glue.c
@@ -100,19 +100,21 @@ static const struct x86_cpu_id module_cpu_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
+static int missing_x86_features;
+module_param(missing_x86_features, int, 0444);
+MODULE_PARM_DESC(missing_x86_features,
+		 "Missing x86 XSAVE features (SSE, YMM)");
+
 static struct simd_skcipher_alg *cast6_simd_algs[ARRAY_SIZE(cast6_algs)];
 
 static int __init cast6_init(void)
 {
-	const char *feature_name;
-
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
-		return -ENODEV;
+	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
+		missing_x86_features = 1;
+		return 0;
 	}
 
 	return simd_register_skciphers_compat(cast6_algs,
@@ -122,8 +124,10 @@ static int __init cast6_init(void)
 
 static void __exit cast6_exit(void)
 {
-	simd_unregister_skciphers(cast6_algs, ARRAY_SIZE(cast6_algs),
-				  cast6_simd_algs);
+	if (!missing_x86_features)
+		simd_unregister_skciphers(cast6_algs, ARRAY_SIZE(cast6_algs),
+					  cast6_simd_algs);
+	missing_x86_features = 0;
 }
 
 module_init(cast6_init);
diff --git a/arch/x86/crypto/curve25519-x86_64.c b/arch/x86/crypto/curve25519-x86_64.c
index 6d222849e409..74672351e534 100644
--- a/arch/x86/crypto/curve25519-x86_64.c
+++ b/arch/x86/crypto/curve25519-x86_64.c
@@ -1706,13 +1706,20 @@ static const struct x86_cpu_id module_cpu_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
+static int missing_x86_features;
+module_param(missing_x86_features, int, 0444);
+MODULE_PARM_DESC(missing_x86_features,
+		 "Missing x86 instruction set extensions (BMI2)");
+
 static int __init curve25519_mod_init(void)
 {
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
-	if (!boot_cpu_has(X86_FEATURE_BMI2))
-		return -ENODEV;
+	if (!boot_cpu_has(X86_FEATURE_BMI2)) {
+		missing_x86_features = 1;
+		return 0;
+	}
 
 	static_branch_enable(&curve25519_use_bmi2_adx);
 
@@ -1725,6 +1732,7 @@ static void __exit curve25519_mod_exit(void)
 	if (IS_REACHABLE(CONFIG_CRYPTO_KPP) &&
 	    static_branch_likely(&curve25519_use_bmi2_adx))
 		crypto_unregister_kpp(&curve25519_alg);
+	missing_x86_features = 0;
 }
 
 module_init(curve25519_mod_init);
diff --git a/arch/x86/crypto/nhpoly1305-avx2-glue.c b/arch/x86/crypto/nhpoly1305-avx2-glue.c
index fa415fec5793..2e63947bc9fa 100644
--- a/arch/x86/crypto/nhpoly1305-avx2-glue.c
+++ b/arch/x86/crypto/nhpoly1305-avx2-glue.c
@@ -67,20 +67,28 @@ static const struct x86_cpu_id module_cpu_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
+static int missing_x86_features;
+module_param(missing_x86_features, int, 0444);
+MODULE_PARM_DESC(missing_x86_features,
+		 "Missing x86 instruction set extensions (OSXSAVE)");
+
 static int __init nhpoly1305_mod_init(void)
 {
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
-	if (!boot_cpu_has(X86_FEATURE_OSXSAVE))
-		return -ENODEV;
+	if (!boot_cpu_has(X86_FEATURE_OSXSAVE)) {
+		missing_x86_features = 1;
+		return 0;
+	}
 
 	return crypto_register_shash(&nhpoly1305_alg);
 }
 
 static void __exit nhpoly1305_mod_exit(void)
 {
-	crypto_unregister_shash(&nhpoly1305_alg);
+	if (!missing_x86_features)
+		crypto_unregister_shash(&nhpoly1305_alg);
 }
 
 module_init(nhpoly1305_mod_init);
diff --git a/arch/x86/crypto/polyval-clmulni_glue.c b/arch/x86/crypto/polyval-clmulni_glue.c
index b98e32f8e2a4..20d4a68ec1d7 100644
--- a/arch/x86/crypto/polyval-clmulni_glue.c
+++ b/arch/x86/crypto/polyval-clmulni_glue.c
@@ -182,20 +182,29 @@ static const struct x86_cpu_id module_cpu_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
+static int missing_x86_features;
+module_param(missing_x86_features, int, 0444);
+MODULE_PARM_DESC(missing_x86_features,
+		 "Missing x86 instruction set extensions (AVX)");
+
 static int __init polyval_clmulni_mod_init(void)
 {
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
-	if (!boot_cpu_has(X86_FEATURE_AVX))
-		return -ENODEV;
+	if (!boot_cpu_has(X86_FEATURE_AVX)) {
+		missing_x86_features = 1;
+		return 0;
+	}
 
 	return crypto_register_shash(&polyval_alg);
 }
 
 static void __exit polyval_clmulni_mod_exit(void)
 {
-	crypto_unregister_shash(&polyval_alg);
+	if (!missing_x86_features)
+		crypto_unregister_shash(&polyval_alg);
+	missing_x86_features = 0;
 }
 
 module_init(polyval_clmulni_mod_init);
diff --git a/arch/x86/crypto/serpent_avx2_glue.c b/arch/x86/crypto/serpent_avx2_glue.c
index bc18149fb928..2aa62c93a16f 100644
--- a/arch/x86/crypto/serpent_avx2_glue.c
+++ b/arch/x86/crypto/serpent_avx2_glue.c
@@ -101,23 +101,25 @@ static const struct x86_cpu_id module_cpu_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
+static int missing_x86_features;
+module_param(missing_x86_features, int, 0444);
+MODULE_PARM_DESC(missing_x86_features,
+		 "Missing x86 instruction set extensions (OSXSAVE) and/or XSAVE features (SSE, YMM)");
+
 static struct simd_skcipher_alg *serpent_simd_algs[ARRAY_SIZE(serpent_algs)];
 
 static int __init serpent_avx2_init(void)
 {
-	const char *feature_name;
-
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
 	if (!boot_cpu_has(X86_FEATURE_OSXSAVE)) {
-		pr_info("OSXSAVE instructions are not detected.\n");
-		return -ENODEV;
+		missing_x86_features = 1;
+		return 0;
 	}
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
-		return -ENODEV;
+	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
+		missing_x86_features = 1;
+		return 0;
 	}
 
 	return simd_register_skciphers_compat(serpent_algs,
@@ -127,8 +129,10 @@ static int __init serpent_avx2_init(void)
 
 static void __exit serpent_avx2_fini(void)
 {
-	simd_unregister_skciphers(serpent_algs, ARRAY_SIZE(serpent_algs),
-				  serpent_simd_algs);
+	if (!missing_x86_features)
+		simd_unregister_skciphers(serpent_algs, ARRAY_SIZE(serpent_algs),
+					  serpent_simd_algs);
+	missing_x86_features = 0;
 }
 
 module_init(serpent_avx2_init);
diff --git a/arch/x86/crypto/serpent_avx_glue.c b/arch/x86/crypto/serpent_avx_glue.c
index 0db18d99da50..28ee9717df49 100644
--- a/arch/x86/crypto/serpent_avx_glue.c
+++ b/arch/x86/crypto/serpent_avx_glue.c
@@ -107,19 +107,21 @@ static const struct x86_cpu_id module_cpu_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
+static int missing_x86_features;
+module_param(missing_x86_features, int, 0444);
+MODULE_PARM_DESC(missing_x86_features,
+		 "Missing x86 XSAVE features (SSE, YMM)");
+
 static struct simd_skcipher_alg *serpent_simd_algs[ARRAY_SIZE(serpent_algs)];
 
 static int __init serpent_init(void)
 {
-	const char *feature_name;
-
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
-		return -ENODEV;
+	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
+		missing_x86_features = 1;
+		return 0;
 	}
 
 	return simd_register_skciphers_compat(serpent_algs,
@@ -129,8 +131,11 @@ static int __init serpent_init(void)
 
 static void __exit serpent_exit(void)
 {
-	simd_unregister_skciphers(serpent_algs, ARRAY_SIZE(serpent_algs),
-				  serpent_simd_algs);
+	if (!missing_x86_features)
+		simd_unregister_skciphers(serpent_algs,
+					  ARRAY_SIZE(serpent_algs),
+					  serpent_simd_algs);
+	missing_x86_features = 0;
 }
 
 module_init(serpent_init);
diff --git a/arch/x86/crypto/sha1_ssse3_glue.c b/arch/x86/crypto/sha1_ssse3_glue.c
index 2445648cf234..405af5e14b67 100644
--- a/arch/x86/crypto/sha1_ssse3_glue.c
+++ b/arch/x86/crypto/sha1_ssse3_glue.c
@@ -351,9 +351,17 @@ static const struct x86_cpu_id module_cpu_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
+static int missing_x86_features_avx2;
+static int missing_x86_features_avx;
+module_param(missing_x86_features_avx2, int, 0444);
+module_param(missing_x86_features_avx, int, 0444);
+MODULE_PARM_DESC(missing_x86_features_avx2,
+		 "Missing x86 instruction set extensions (BMI1, BMI2) to support AVX2");
+MODULE_PARM_DESC(missing_x86_features_avx,
+		 "Missing x86 XSAVE features (SSE, YMM) to support AVX");
+
 static int __init sha1_ssse3_mod_init(void)
 {
-	const char *feature_name;
 	int ret;
 
 	if (!x86_match_cpu(module_cpu_ids))
@@ -374,10 +382,11 @@ static int __init sha1_ssse3_mod_init(void)
 
 		if (boot_cpu_has(X86_FEATURE_BMI1) &&
 		    boot_cpu_has(X86_FEATURE_BMI2)) {
-
 			ret = crypto_register_shash(&sha1_avx2_alg);
 			if (!ret)
 				using_x86_avx2 = 1;
+		} else {
+			missing_x86_features_avx2 = 1;
 		}
 	}
 
@@ -385,11 +394,12 @@ static int __init sha1_ssse3_mod_init(void)
 	if (boot_cpu_has(X86_FEATURE_AVX)) {
 
 		if (cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-			       &feature_name)) {
-
+				      NULL)) {
 			ret = crypto_register_shash(&sha1_avx_alg);
 			if (!ret)
 				using_x86_avx = 1;
+		} else {
+			missing_x86_features_avx = 1;
 		}
 	}
 
@@ -415,6 +425,8 @@ static void __exit sha1_ssse3_mod_fini(void)
 	unregister_sha1_avx2();
 	unregister_sha1_avx();
 	unregister_sha1_ssse3();
+	missing_x86_features_avx2 = 0;
+	missing_x86_features_avx = 0;
 }
 
 module_init(sha1_ssse3_mod_init);
diff --git a/arch/x86/crypto/sha256_ssse3_glue.c b/arch/x86/crypto/sha256_ssse3_glue.c
index 1464e6ccf912..293cf7085dd3 100644
--- a/arch/x86/crypto/sha256_ssse3_glue.c
+++ b/arch/x86/crypto/sha256_ssse3_glue.c
@@ -413,9 +413,17 @@ static const struct x86_cpu_id module_cpu_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
+static int missing_x86_features_avx2;
+static int missing_x86_features_avx;
+module_param(missing_x86_features_avx2, int, 0444);
+module_param(missing_x86_features_avx, int, 0444);
+MODULE_PARM_DESC(missing_x86_features_avx2,
+		 "Missing x86 instruction set extensions (BMI2) to support AVX2");
+MODULE_PARM_DESC(missing_x86_features_avx,
+		 "Missing x86 XSAVE features (SSE, YMM) to support AVX");
+
 static int __init sha256_ssse3_mod_init(void)
 {
-	const char *feature_name;
 	int ret;
 
 	if (!x86_match_cpu(module_cpu_ids))
@@ -440,6 +448,8 @@ static int __init sha256_ssse3_mod_init(void)
 						ARRAY_SIZE(sha256_avx2_algs));
 			if (!ret)
 				using_x86_avx2 = 1;
+		} else {
+			missing_x86_features_avx2 = 1;
 		}
 	}
 
@@ -447,11 +457,13 @@ static int __init sha256_ssse3_mod_init(void)
 	if (boot_cpu_has(X86_FEATURE_AVX)) {
 
 		if (cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-			       &feature_name)) {
+				      NULL)) {
 			ret = crypto_register_shashes(sha256_avx_algs,
 						ARRAY_SIZE(sha256_avx_algs));
 			if (!ret)
 				using_x86_avx = 1;
+		} else {
+			missing_x86_features_avx = 1;
 		}
 	}
 
@@ -478,6 +490,8 @@ static void __exit sha256_ssse3_mod_fini(void)
 	unregister_sha256_avx2();
 	unregister_sha256_avx();
 	unregister_sha256_ssse3();
+	missing_x86_features_avx2 = 0;
+	missing_x86_features_avx = 0;
 }
 
 module_init(sha256_ssse3_mod_init);
diff --git a/arch/x86/crypto/sha512_ssse3_glue.c b/arch/x86/crypto/sha512_ssse3_glue.c
index 04e2af951a3e..9f13baf7dda9 100644
--- a/arch/x86/crypto/sha512_ssse3_glue.c
+++ b/arch/x86/crypto/sha512_ssse3_glue.c
@@ -319,6 +319,15 @@ static const struct x86_cpu_id module_cpu_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
+static int missing_x86_features_avx2;
+static int missing_x86_features_avx;
+module_param(missing_x86_features_avx2, int, 0444);
+module_param(missing_x86_features_avx, int, 0444);
+MODULE_PARM_DESC(missing_x86_features_avx2,
+		 "Missing x86 instruction set extensions (BMI2) to support AVX2");
+MODULE_PARM_DESC(missing_x86_features_avx,
+		 "Missing x86 XSAVE features (SSE, YMM) to support AVX");
+
 static void unregister_sha512_avx2(void)
 {
 	if (using_x86_avx2) {
@@ -330,7 +339,6 @@ static void unregister_sha512_avx2(void)
 
 static int __init sha512_ssse3_mod_init(void)
 {
-	const char *feature_name;
 	int ret;
 
 	if (!x86_match_cpu(module_cpu_ids))
@@ -343,6 +351,8 @@ static int __init sha512_ssse3_mod_init(void)
 					ARRAY_SIZE(sha512_avx2_algs));
 			if (!ret)
 				using_x86_avx2 = 1;
+		} else {
+			missing_x86_features_avx2 = 1;
 		}
 	}
 
@@ -350,11 +360,13 @@ static int __init sha512_ssse3_mod_init(void)
 	if (boot_cpu_has(X86_FEATURE_AVX)) {
 
 		if (cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-				       &feature_name)) {
+				      NULL)) {
 			ret = crypto_register_shashes(sha512_avx_algs,
 					ARRAY_SIZE(sha512_avx_algs));
 			if (!ret)
 				using_x86_avx = 1;
+		} else {
+			missing_x86_features_avx = 1;
 		}
 	}
 
@@ -376,6 +388,8 @@ static void __exit sha512_ssse3_mod_fini(void)
 	unregister_sha512_avx2();
 	unregister_sha512_avx();
 	unregister_sha512_ssse3();
+	missing_x86_features_avx2 = 0;
+	missing_x86_features_avx = 0;
 }
 
 module_init(sha512_ssse3_mod_init);
diff --git a/arch/x86/crypto/sm3_avx_glue.c b/arch/x86/crypto/sm3_avx_glue.c
index c7786874319c..169ba6a2c806 100644
--- a/arch/x86/crypto/sm3_avx_glue.c
+++ b/arch/x86/crypto/sm3_avx_glue.c
@@ -126,22 +126,24 @@ static const struct x86_cpu_id module_cpu_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
+static int missing_x86_features;
+module_param(missing_x86_features, int, 0444);
+MODULE_PARM_DESC(missing_x86_features,
+		 "Missing x86 instruction set extensions (BMI2) and/or XSAVE features (SSE, YMM)");
+
 static int __init sm3_avx_mod_init(void)
 {
-	const char *feature_name;
-
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
 	if (!boot_cpu_has(X86_FEATURE_BMI2)) {
-		pr_info("BMI2 instruction are not detected.\n");
-		return -ENODEV;
+		missing_x86_features = 1;
+		return 0;
 	}
 
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
-		return -ENODEV;
+	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
+		missing_x86_features = 1;
+		return 0;
 	}
 
 	return crypto_register_shash(&sm3_avx_alg);
@@ -149,7 +151,9 @@ static int __init sm3_avx_mod_init(void)
 
 static void __exit sm3_avx_mod_exit(void)
 {
-	crypto_unregister_shash(&sm3_avx_alg);
+	if (!missing_x86_features)
+		crypto_unregister_shash(&sm3_avx_alg);
+	missing_x86_features = 0;
 }
 
 module_init(sm3_avx_mod_init);
diff --git a/arch/x86/crypto/sm4_aesni_avx2_glue.c b/arch/x86/crypto/sm4_aesni_avx2_glue.c
index 125b00db89b1..6bcf78231888 100644
--- a/arch/x86/crypto/sm4_aesni_avx2_glue.c
+++ b/arch/x86/crypto/sm4_aesni_avx2_glue.c
@@ -133,27 +133,29 @@ static const struct x86_cpu_id module_cpu_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
+static int missing_x86_features;
+module_param(missing_x86_features, int, 0444);
+MODULE_PARM_DESC(missing_x86_features,
+		 "Missing x86 instruction set extensions (AES-NI, AVX, OSXSAVE) and/or XSAVE features (SSE, YMM)");
+
 static struct simd_skcipher_alg *
 simd_sm4_aesni_avx2_skciphers[ARRAY_SIZE(sm4_aesni_avx2_skciphers)];
 
 static int __init sm4_init(void)
 {
-	const char *feature_name;
-
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
 	if (!boot_cpu_has(X86_FEATURE_AVX) ||
 	    !boot_cpu_has(X86_FEATURE_AES) ||
 	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
-		pr_info("AVX, AES-NI, and/or OSXSAVE instructions are not detected.\n");
-		return -ENODEV;
+		missing_x86_features = 1;
+		return 0;
 	}
 
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
-		return -ENODEV;
+	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
+		missing_x86_features = 1;
+		return 0;
 	}
 
 	return simd_register_skciphers_compat(sm4_aesni_avx2_skciphers,
@@ -163,9 +165,11 @@ static int __init sm4_init(void)
 
 static void __exit sm4_exit(void)
 {
-	simd_unregister_skciphers(sm4_aesni_avx2_skciphers,
-				ARRAY_SIZE(sm4_aesni_avx2_skciphers),
-				simd_sm4_aesni_avx2_skciphers);
+	if (!missing_x86_features)
+		simd_unregister_skciphers(sm4_aesni_avx2_skciphers,
+					  ARRAY_SIZE(sm4_aesni_avx2_skciphers),
+					  simd_sm4_aesni_avx2_skciphers);
+	missing_x86_features = 0;
 }
 
 module_init(sm4_init);
diff --git a/arch/x86/crypto/sm4_aesni_avx_glue.c b/arch/x86/crypto/sm4_aesni_avx_glue.c
index ac8182b197cf..03775b1079dc 100644
--- a/arch/x86/crypto/sm4_aesni_avx_glue.c
+++ b/arch/x86/crypto/sm4_aesni_avx_glue.c
@@ -452,26 +452,28 @@ static const struct x86_cpu_id module_cpu_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
+static int missing_x86_features;
+module_param(missing_x86_features, int, 0444);
+MODULE_PARM_DESC(missing_x86_features,
+		 "Missing x86 instruction set extensions (AES-NI, OSXSAVE) and/or XSAVE features (SSE, YMM)");
+
 static struct simd_skcipher_alg *
 simd_sm4_aesni_avx_skciphers[ARRAY_SIZE(sm4_aesni_avx_skciphers)];
 
 static int __init sm4_init(void)
 {
-	const char *feature_name;
-
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
 	if (!boot_cpu_has(X86_FEATURE_AES) ||
 	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
-		pr_info("AES-NI or OSXSAVE instructions are not detected.\n");
-		return -ENODEV;
+		missing_x86_features = 1;
+		return 0;
 	}
 
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
-		return -ENODEV;
+	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
+		missing_x86_features = 1;
+		return 0;
 	}
 
 	return simd_register_skciphers_compat(sm4_aesni_avx_skciphers,
@@ -481,9 +483,11 @@ static int __init sm4_init(void)
 
 static void __exit sm4_exit(void)
 {
-	simd_unregister_skciphers(sm4_aesni_avx_skciphers,
-					ARRAY_SIZE(sm4_aesni_avx_skciphers),
-					simd_sm4_aesni_avx_skciphers);
+	if (!missing_x86_features)
+		simd_unregister_skciphers(sm4_aesni_avx_skciphers,
+					  ARRAY_SIZE(sm4_aesni_avx_skciphers),
+					  simd_sm4_aesni_avx_skciphers);
+	missing_x86_features = 0;
 }
 
 module_init(sm4_init);
diff --git a/arch/x86/crypto/twofish_avx_glue.c b/arch/x86/crypto/twofish_avx_glue.c
index 4657e6efc35d..ae3cc4ad6f4f 100644
--- a/arch/x86/crypto/twofish_avx_glue.c
+++ b/arch/x86/crypto/twofish_avx_glue.c
@@ -110,18 +110,21 @@ static const struct x86_cpu_id module_cpu_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
+static int missing_x86_features;
+module_param(missing_x86_features, int, 0444);
+MODULE_PARM_DESC(missing_x86_features,
+		 "Missing x86 XSAVE features (SSE, YMM)");
+
 static struct simd_skcipher_alg *twofish_simd_algs[ARRAY_SIZE(twofish_algs)];
 
 static int __init twofish_init(void)
 {
-	const char *feature_name;
-
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, &feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
-		return -ENODEV;
+	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
+		missing_x86_features = 1;
+		return 0;
 	}
 
 	return simd_register_skciphers_compat(twofish_algs,
@@ -131,8 +134,10 @@ static int __init twofish_init(void)
 
 static void __exit twofish_exit(void)
 {
-	simd_unregister_skciphers(twofish_algs, ARRAY_SIZE(twofish_algs),
-				  twofish_simd_algs);
+	if (!missing_x86_features)
+		simd_unregister_skciphers(twofish_algs, ARRAY_SIZE(twofish_algs),
+					  twofish_simd_algs);
+	missing_x86_features = 0;
 }
 
 module_init(twofish_init);
-- 
2.38.1

