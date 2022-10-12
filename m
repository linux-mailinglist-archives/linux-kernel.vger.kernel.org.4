Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F47F5FCE03
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiJLWCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiJLWBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:01:19 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435E275FFB;
        Wed, 12 Oct 2022 15:00:22 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CKWT9v015442;
        Wed, 12 Oct 2022 22:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=ntW9Ji65PFoN+eegclvP9j8XWOomEfeAptNcfNSx+Ww=;
 b=c2Af7gH+FDARfJhl2E3aelLxoxX8RDfySYFsKUjxQ67YSpfZRxYlw4YkQQdalIkINgq7
 JjfBwQ+NUfhWUJWfTC7XL44LYuSYoqX+qy3QZ2Nt+lDRsS+oiL+eh9QYkkfjDuY94VZy
 oMlS6m1SdydQmyvQWHEj4p4quyKOzNrh+FhEBCyHkN1hK9sOS7oGDWGfwaafz2xPE2PB
 qjVouTBQEaYmSG7t6xIpP7VjSAPRqZzXlZOLbbhJ57xNAhm5pY4nVnI6DsufWx4A3DFL
 d5Y3kiBfBKCB618kXWqVTkyB2c/VqJ+bXCpUwYBGKHwEP0Wzuo5XTE+ORggCoZhokaMm +Q== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k615t2esc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 22:00:09 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 4962E29582;
        Wed, 12 Oct 2022 22:00:08 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id E2DA18003BA;
        Wed, 12 Oct 2022 22:00:07 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 16/19] crypto: x86 - print CPU optimized loaded messages
Date:   Wed, 12 Oct 2022 16:59:28 -0500
Message-Id: <20221012215931.3896-17-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012215931.3896-1-elliott@hpe.com>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _Qi2zLBrbtmT0s8gvCC9eeuThCRMqzid
X-Proofpoint-ORIG-GUID: _Qi2zLBrbtmT0s8gvCC9eeuThCRMqzid
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

Print a positive message at the info level if the CPU-optimized module
is loaded, for all modules except the sha modules.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/aegis128-aesni-glue.c      |  8 +++++--
 arch/x86/crypto/aesni-intel_glue.c         | 22 +++++++++++++------
 arch/x86/crypto/aria_aesni_avx_glue.c      | 13 ++++++++---
 arch/x86/crypto/blake2s-glue.c             | 14 ++++++++++--
 arch/x86/crypto/blowfish_glue.c            |  2 ++
 arch/x86/crypto/camellia_aesni_avx2_glue.c |  6 +++++-
 arch/x86/crypto/camellia_aesni_avx_glue.c  |  6 +++++-
 arch/x86/crypto/camellia_glue.c            |  3 +++
 arch/x86/crypto/cast5_avx_glue.c           |  6 +++++-
 arch/x86/crypto/cast6_avx_glue.c           |  6 +++++-
 arch/x86/crypto/chacha_glue.c              | 17 +++++++++++++--
 arch/x86/crypto/crc32-pclmul_glue.c        |  8 ++++++-
 arch/x86/crypto/crc32c-intel_glue.c        | 15 +++++++++++--
 arch/x86/crypto/crct10dif-pclmul_glue.c    |  7 +++++-
 arch/x86/crypto/curve25519-x86_64.c        | 13 +++++++++--
 arch/x86/crypto/des3_ede_glue.c            |  2 ++
 arch/x86/crypto/ghash-clmulni-intel_glue.c |  1 +
 arch/x86/crypto/nhpoly1305-avx2-glue.c     |  7 +++++-
 arch/x86/crypto/nhpoly1305-sse2-glue.c     |  7 +++++-
 arch/x86/crypto/poly1305_glue.c            | 25 ++++++++++++++++++----
 arch/x86/crypto/polyval-clmulni_glue.c     |  7 +++++-
 arch/x86/crypto/serpent_avx2_glue.c        |  7 ++++--
 arch/x86/crypto/serpent_avx_glue.c         |  6 +++++-
 arch/x86/crypto/serpent_sse2_glue.c        |  7 +++++-
 arch/x86/crypto/sm3_avx_glue.c             |  6 +++++-
 arch/x86/crypto/sm4_aesni_avx2_glue.c      |  6 +++++-
 arch/x86/crypto/sm4_aesni_avx_glue.c       |  7 ++++--
 arch/x86/crypto/twofish_avx_glue.c         | 10 ++++++---
 arch/x86/crypto/twofish_glue.c             |  7 +++++-
 arch/x86/crypto/twofish_glue_3way.c        |  9 ++++++--
 30 files changed, 213 insertions(+), 47 deletions(-)

diff --git a/arch/x86/crypto/aegis128-aesni-glue.c b/arch/x86/crypto/aegis128-aesni-glue.c
index 122bfd04ee47..e8eaf79ef220 100644
--- a/arch/x86/crypto/aegis128-aesni-glue.c
+++ b/arch/x86/crypto/aegis128-aesni-glue.c
@@ -275,7 +275,8 @@ static struct simd_aead_alg *simd_alg;
 
 static int __init crypto_aegis128_aesni_module_init(void)
 {
-	if (!x86_match_cpu(module_cpu_ids))
+	int ret;
+
 		return -ENODEV;
 
 	if (!boot_cpu_has(X86_FEATURE_XMM2) ||
@@ -283,8 +284,11 @@ static int __init crypto_aegis128_aesni_module_init(void)
 	    !cpu_has_xfeatures(XFEATURE_MASK_SSE, NULL))
 		return -ENODEV;
 
-	return simd_register_aeads_compat(&crypto_aegis128_aesni_alg, 1,
+	ret = simd_register_aeads_compat(&crypto_aegis128_aesni_alg, 1,
 					  &simd_alg);
+	if (!ret)
+		pr_info("CPU-optimized crypto module loaded\n");
+	return ret;
 }
 
 static void __exit crypto_aegis128_aesni_module_exit(void)
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index df93cb44b4eb..56023ba70049 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -1238,25 +1238,28 @@ MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 static int __init aesni_init(void)
 {
 	int err;
+	int enabled_gcm_sse = 0;
+	int enabled_gcm_avx = 0;
+	int enabled_gcm_avx2 = 0;
+	int enabled_ctr_avx = 0;
 
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 #ifdef CONFIG_X86_64
 	if (boot_cpu_has(X86_FEATURE_AVX2)) {
-		pr_info("AVX2 version of gcm_enc/dec engaged.\n");
+		enabled_gcm_avx = 1;
+		enabled_gcm_avx2 = 1;
 		static_branch_enable(&gcm_use_avx);
 		static_branch_enable(&gcm_use_avx2);
-	} else
-	if (boot_cpu_has(X86_FEATURE_AVX)) {
-		pr_info("AVX version of gcm_enc/dec engaged.\n");
+	} else if (boot_cpu_has(X86_FEATURE_AVX)) {
+		enabled_gcm_avx = 1;
 		static_branch_enable(&gcm_use_avx);
 	} else {
-		pr_info("SSE version of gcm_enc/dec engaged.\n");
+		enabled_gcm_sse = 1;
 	}
 	if (boot_cpu_has(X86_FEATURE_AVX)) {
-		/* optimize performance of ctr mode encryption transform */
+		enabled_ctr_avx = 1;
 		static_call_update(aesni_ctr_enc_tfm, aesni_ctr_enc_avx_tfm);
-		pr_info("AES CTR mode by8 optimization enabled\n");
 	}
 #endif /* CONFIG_X86_64 */
 
@@ -1283,6 +1286,11 @@ static int __init aesni_init(void)
 		goto unregister_aeads;
 #endif /* CONFIG_X86_64 */
 
+	pr_info("CPU-optimized crypto module loaded (GCM SSE=%s, AVX=%s, AVX2=%s)(CTR AVX=%s)\n",
+		enabled_gcm_sse ? "yes" : "no",
+		enabled_gcm_avx ? "yes" : "no",
+		enabled_gcm_avx2 ? "yes" : "no",
+		enabled_ctr_avx ? "yes" : "no");
 	return 0;
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/crypto/aria_aesni_avx_glue.c b/arch/x86/crypto/aria_aesni_avx_glue.c
index 589097728bd1..d58fb995a266 100644
--- a/arch/x86/crypto/aria_aesni_avx_glue.c
+++ b/arch/x86/crypto/aria_aesni_avx_glue.c
@@ -170,6 +170,8 @@ static struct simd_skcipher_alg *aria_simd_algs[ARRAY_SIZE(aria_algs)];
 static int __init aria_avx_init(void)
 {
 	const char *feature_name;
+	int ret;
+	int enabled_gfni = 0;
 
 	if (!boot_cpu_has(X86_FEATURE_AVX) ||
 	    !boot_cpu_has(X86_FEATURE_AES) ||
@@ -188,15 +190,20 @@ static int __init aria_avx_init(void)
 		aria_ops.aria_encrypt_16way = aria_aesni_avx_gfni_encrypt_16way;
 		aria_ops.aria_decrypt_16way = aria_aesni_avx_gfni_decrypt_16way;
 		aria_ops.aria_ctr_crypt_16way = aria_aesni_avx_gfni_ctr_crypt_16way;
+		enabled_gfni = 1;
 	} else {
 		aria_ops.aria_encrypt_16way = aria_aesni_avx_encrypt_16way;
 		aria_ops.aria_decrypt_16way = aria_aesni_avx_decrypt_16way;
 		aria_ops.aria_ctr_crypt_16way = aria_aesni_avx_ctr_crypt_16way;
 	}
 
-	return simd_register_skciphers_compat(aria_algs,
-					      ARRAY_SIZE(aria_algs),
-					      aria_simd_algs);
+	ret = simd_register_skciphers_compat(aria_algs,
+					     ARRAY_SIZE(aria_algs),
+					     aria_simd_algs);
+	if (!ret)
+		pr_info("CPU-optimized crypto module loaded (GFNI=%s)\n",
+			enabled_gfni ? "yes" : "no");
+	return ret;
 }
 
 static void __exit aria_avx_exit(void)
diff --git a/arch/x86/crypto/blake2s-glue.c b/arch/x86/crypto/blake2s-glue.c
index ac7fb7a9922b..4f2f385f6674 100644
--- a/arch/x86/crypto/blake2s-glue.c
+++ b/arch/x86/crypto/blake2s-glue.c
@@ -66,11 +66,16 @@ MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
 static int __init blake2s_mod_init(void)
 {
+	int enabled_ssse3 = 0;
+	int enabled_avx512 = 0;
+
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
-	if (boot_cpu_has(X86_FEATURE_SSSE3))
+	if (boot_cpu_has(X86_FEATURE_SSSE3)) {
+		enabled_ssse3 = 1;
 		static_branch_enable(&blake2s_use_ssse3);
+	}
 
 	if (IS_ENABLED(CONFIG_AS_AVX512) &&
 	    boot_cpu_has(X86_FEATURE_AVX) &&
@@ -78,9 +83,14 @@ static int __init blake2s_mod_init(void)
 	    boot_cpu_has(X86_FEATURE_AVX512F) &&
 	    boot_cpu_has(X86_FEATURE_AVX512VL) &&
 	    cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM |
-			      XFEATURE_MASK_AVX512, NULL))
+			      XFEATURE_MASK_AVX512, NULL)) {
+		enabled_avx512 = 1;
 		static_branch_enable(&blake2s_use_avx512);
+	}
 
+	pr_info("CPU-optimized crypto module loaded (SSSE3=%s, AVX512=%s)\n",
+		enabled_ssse3 ? "yes" : "no",
+		enabled_avx512 ? "yes" : "no");
 	return 0;
 }
 
diff --git a/arch/x86/crypto/blowfish_glue.c b/arch/x86/crypto/blowfish_glue.c
index 5cfcbb91c4ca..27b7aed9a488 100644
--- a/arch/x86/crypto/blowfish_glue.c
+++ b/arch/x86/crypto/blowfish_glue.c
@@ -336,6 +336,8 @@ static int __init blowfish_init(void)
 	if (err)
 		crypto_unregister_alg(&bf_cipher_alg);
 
+	if (!err)
+		pr_info("CPU-optimized crypto module loaded\n");
 	return err;
 }
 
diff --git a/arch/x86/crypto/camellia_aesni_avx2_glue.c b/arch/x86/crypto/camellia_aesni_avx2_glue.c
index 851f2a29963c..e6c4ed1e40d2 100644
--- a/arch/x86/crypto/camellia_aesni_avx2_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx2_glue.c
@@ -114,6 +114,7 @@ static struct simd_skcipher_alg *camellia_simd_algs[ARRAY_SIZE(camellia_algs)];
 static int __init camellia_aesni_init(void)
 {
 	const char *feature_name;
+	int ret;
 
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
@@ -132,9 +133,12 @@ static int __init camellia_aesni_init(void)
 		return -ENODEV;
 	}
 
-	return simd_register_skciphers_compat(camellia_algs,
+	ret = simd_register_skciphers_compat(camellia_algs,
 					      ARRAY_SIZE(camellia_algs),
 					      camellia_simd_algs);
+	if (!ret)
+		pr_info("CPU-optimized crypto module loaded\n");
+	return ret;
 }
 
 static void __exit camellia_aesni_fini(void)
diff --git a/arch/x86/crypto/camellia_aesni_avx_glue.c b/arch/x86/crypto/camellia_aesni_avx_glue.c
index 8846493c92fb..6a9eadf0fe90 100644
--- a/arch/x86/crypto/camellia_aesni_avx_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx_glue.c
@@ -113,6 +113,7 @@ static struct simd_skcipher_alg *camellia_simd_algs[ARRAY_SIZE(camellia_algs)];
 static int __init camellia_aesni_init(void)
 {
 	const char *feature_name;
+	int ret;
 
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
@@ -130,9 +131,12 @@ static int __init camellia_aesni_init(void)
 		return -ENODEV;
 	}
 
-	return simd_register_skciphers_compat(camellia_algs,
+	ret = simd_register_skciphers_compat(camellia_algs,
 					      ARRAY_SIZE(camellia_algs),
 					      camellia_simd_algs);
+	if (!ret)
+		pr_info("CPU-optimized crypto module loaded\n");
+	return ret;
 }
 
 static void __exit camellia_aesni_fini(void)
diff --git a/arch/x86/crypto/camellia_glue.c b/arch/x86/crypto/camellia_glue.c
index 3c14a904af00..94dd2973bb47 100644
--- a/arch/x86/crypto/camellia_glue.c
+++ b/arch/x86/crypto/camellia_glue.c
@@ -1410,6 +1410,9 @@ static int __init camellia_init(void)
 	if (err)
 		crypto_unregister_alg(&camellia_cipher_alg);
 
+	if (!err)
+		pr_info("CPU-optimized crypto module loaded\n");
+
 	return err;
 }
 
diff --git a/arch/x86/crypto/cast5_avx_glue.c b/arch/x86/crypto/cast5_avx_glue.c
index fdeec0849ab5..b5ae17c3ac53 100644
--- a/arch/x86/crypto/cast5_avx_glue.c
+++ b/arch/x86/crypto/cast5_avx_glue.c
@@ -107,6 +107,7 @@ static struct simd_skcipher_alg *cast5_simd_algs[ARRAY_SIZE(cast5_algs)];
 static int __init cast5_init(void)
 {
 	const char *feature_name;
+	int ret;
 
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
@@ -117,9 +118,12 @@ static int __init cast5_init(void)
 		return -ENODEV;
 	}
 
-	return simd_register_skciphers_compat(cast5_algs,
+	ret = simd_register_skciphers_compat(cast5_algs,
 					      ARRAY_SIZE(cast5_algs),
 					      cast5_simd_algs);
+	if (!ret)
+		pr_info("CPU-optimized crypto module loaded\n");
+	return ret;
 }
 
 static void __exit cast5_exit(void)
diff --git a/arch/x86/crypto/cast6_avx_glue.c b/arch/x86/crypto/cast6_avx_glue.c
index 9258082408eb..d1c14a5f80d7 100644
--- a/arch/x86/crypto/cast6_avx_glue.c
+++ b/arch/x86/crypto/cast6_avx_glue.c
@@ -107,6 +107,7 @@ static struct simd_skcipher_alg *cast6_simd_algs[ARRAY_SIZE(cast6_algs)];
 static int __init cast6_init(void)
 {
 	const char *feature_name;
+	int ret;
 
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
@@ -117,9 +118,12 @@ static int __init cast6_init(void)
 		return -ENODEV;
 	}
 
-	return simd_register_skciphers_compat(cast6_algs,
+	ret = simd_register_skciphers_compat(cast6_algs,
 					      ARRAY_SIZE(cast6_algs),
 					      cast6_simd_algs);
+	if (!ret)
+		pr_info("CPU-optimized crypto module loaded\n");
+	return ret;
 }
 
 static void __exit cast6_exit(void)
diff --git a/arch/x86/crypto/chacha_glue.c b/arch/x86/crypto/chacha_glue.c
index 8e5cadc808b4..de424fbe9f0e 100644
--- a/arch/x86/crypto/chacha_glue.c
+++ b/arch/x86/crypto/chacha_glue.c
@@ -289,6 +289,9 @@ MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
 static int __init chacha_simd_mod_init(void)
 {
+	int ret;
+	int enabled_avx2 = 0;
+	int enabled_avx512 = 0;
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
@@ -298,15 +301,25 @@ static int __init chacha_simd_mod_init(void)
 	if (boot_cpu_has(X86_FEATURE_AVX) &&
 	    boot_cpu_has(X86_FEATURE_AVX2) &&
 	    cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
+		enabled_avx2 = 1;
 		static_branch_enable(&chacha_use_avx2);
 
 		if (IS_ENABLED(CONFIG_AS_AVX512) &&
 		    boot_cpu_has(X86_FEATURE_AVX512VL) &&
-		    boot_cpu_has(X86_FEATURE_AVX512BW)) /* kmovq */
+		    boot_cpu_has(X86_FEATURE_AVX512BW)) { /* kmovq */
+			enabled_avx512 = 1;
 			static_branch_enable(&chacha_use_avx512vl);
+		}
 	}
-	return IS_REACHABLE(CONFIG_CRYPTO_SKCIPHER) ?
+	ret = IS_REACHABLE(CONFIG_CRYPTO_SKCIPHER) ?
 		crypto_register_skciphers(algs, ARRAY_SIZE(algs)) : 0;
+	if (!ret)
+		pr_info("CPU-optimized crypto module loaded (AVX2=%s, AVX512=%s)\n",
+			enabled_avx2 ? "yes" : "no",
+			enabled_avx512 ? "yes" : "no");
+	else
+		pr_info("CPU-optimized crypto module not loaded");
+	return ret;
 }
 
 static void __exit chacha_simd_mod_fini(void)
diff --git a/arch/x86/crypto/crc32-pclmul_glue.c b/arch/x86/crypto/crc32-pclmul_glue.c
index bc2b31b04e05..c56d3d3ab0a0 100644
--- a/arch/x86/crypto/crc32-pclmul_glue.c
+++ b/arch/x86/crypto/crc32-pclmul_glue.c
@@ -190,9 +190,15 @@ MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
 static int __init crc32_pclmul_mod_init(void)
 {
+	int ret;
+
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
-	return crypto_register_shash(&alg);
+
+	ret = crypto_register_shash(&alg);
+	if (!ret)
+		pr_info("CPU-optimized crypto module loaded\n");
+	return ret;
 }
 
 static void __exit crc32_pclmul_mod_fini(void)
diff --git a/arch/x86/crypto/crc32c-intel_glue.c b/arch/x86/crypto/crc32c-intel_glue.c
index ebf530934a3e..c633d303f19b 100644
--- a/arch/x86/crypto/crc32c-intel_glue.c
+++ b/arch/x86/crypto/crc32c-intel_glue.c
@@ -242,16 +242,27 @@ MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
 static int __init crc32c_intel_mod_init(void)
 {
-	if (!x86_match_cpu(module_cpu_ids))
+	int ret;
+	int pcl_enabled = 0;
+
+	if (!x86_match_cpu(module_cpu_ids)) {
+		pr_info("CPU-optimized crypto module not loaded, required CPU feature (SSE4.2) not supported\n");
 		return -ENODEV;
+	}
+
 #ifdef CONFIG_X86_64
 	if (boot_cpu_has(X86_FEATURE_PCLMULQDQ)) {
+		pcl_enabled = 1;
 		alg.update = crc32c_pcl_intel_update;
 		alg.finup = crc32c_pcl_intel_finup;
 		alg.digest = crc32c_pcl_intel_digest;
 	}
 #endif
-	return crypto_register_shash(&alg);
+	ret = crypto_register_shash(&alg);
+	if (!ret)
+		pr_info("CPU-optimized crypto module loaded (PCLMULQDQ=%s)\n",
+			pcl_enabled ? "yes" : "no");
+	return ret;
 }
 
 static void __exit crc32c_intel_mod_fini(void)
diff --git a/arch/x86/crypto/crct10dif-pclmul_glue.c b/arch/x86/crypto/crct10dif-pclmul_glue.c
index 03e35a1b7677..4476b9af1e61 100644
--- a/arch/x86/crypto/crct10dif-pclmul_glue.c
+++ b/arch/x86/crypto/crct10dif-pclmul_glue.c
@@ -146,10 +146,15 @@ MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
 static int __init crct10dif_intel_mod_init(void)
 {
+	int ret;
+
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
-	return crypto_register_shash(&alg);
+	ret = crypto_register_shash(&alg);
+	if (!ret)
+		pr_info("CPU-optimized crypto module loaded\n");
+	return ret;
 }
 
 static void __exit crct10dif_intel_mod_fini(void)
diff --git a/arch/x86/crypto/curve25519-x86_64.c b/arch/x86/crypto/curve25519-x86_64.c
index f9a1adb0c183..b9289feef375 100644
--- a/arch/x86/crypto/curve25519-x86_64.c
+++ b/arch/x86/crypto/curve25519-x86_64.c
@@ -1709,15 +1709,24 @@ MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
 static int __init curve25519_mod_init(void)
 {
+	int ret;
+	int enabled_adx = 0;
+
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
-	if (boot_cpu_has(X86_FEATURE_BMI2) && boot_cpu_has(X86_FEATURE_ADX))
+	if (boot_cpu_has(X86_FEATURE_BMI2) && boot_cpu_has(X86_FEATURE_ADX)) {
+		enabled_adx = 1;
 		static_branch_enable(&curve25519_use_bmi2_adx);
+	}
 	else
 		return 0;
-	return IS_REACHABLE(CONFIG_CRYPTO_KPP) ?
+	ret = IS_REACHABLE(CONFIG_CRYPTO_KPP) ?
 		crypto_register_kpp(&curve25519_alg) : 0;
+	if (!ret)
+		pr_info("CPU-optimized crypto module loaded (ADX=%s)\n",
+			enabled_adx ? "yes" : "no");
+	return ret;
 }
 
 static void __exit curve25519_mod_exit(void)
diff --git a/arch/x86/crypto/des3_ede_glue.c b/arch/x86/crypto/des3_ede_glue.c
index 83e686a6c2f3..7b4dd02007ed 100644
--- a/arch/x86/crypto/des3_ede_glue.c
+++ b/arch/x86/crypto/des3_ede_glue.c
@@ -384,6 +384,8 @@ static int __init des3_ede_x86_init(void)
 	if (err)
 		crypto_unregister_alg(&des3_ede_cipher);
 
+	if (!err)
+		pr_info("CPU-optimized crypto module loaded\n");
 	return err;
 }
 
diff --git a/arch/x86/crypto/ghash-clmulni-intel_glue.c b/arch/x86/crypto/ghash-clmulni-intel_glue.c
index 3ad55144da48..496a410eaff7 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_glue.c
+++ b/arch/x86/crypto/ghash-clmulni-intel_glue.c
@@ -349,6 +349,7 @@ static int __init ghash_pclmulqdqni_mod_init(void)
 	if (err)
 		goto err_shash;
 
+	pr_info("CPU-optimized crypto module loaded\n");
 	return 0;
 
 err_shash:
diff --git a/arch/x86/crypto/nhpoly1305-avx2-glue.c b/arch/x86/crypto/nhpoly1305-avx2-glue.c
index 40f49107e5a9..2dc7b618771f 100644
--- a/arch/x86/crypto/nhpoly1305-avx2-glue.c
+++ b/arch/x86/crypto/nhpoly1305-avx2-glue.c
@@ -68,6 +68,8 @@ MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
 static int __init nhpoly1305_mod_init(void)
 {
+	int ret;
+
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
@@ -75,7 +77,10 @@ static int __init nhpoly1305_mod_init(void)
 	    !boot_cpu_has(X86_FEATURE_OSXSAVE))
 		return -ENODEV;
 
-	return crypto_register_shash(&nhpoly1305_alg);
+	ret = crypto_register_shash(&nhpoly1305_alg);
+	if (!ret)
+		pr_info("CPU-optimized crypto module loaded\n");
+	return ret;
 }
 
 static void __exit nhpoly1305_mod_exit(void)
diff --git a/arch/x86/crypto/nhpoly1305-sse2-glue.c b/arch/x86/crypto/nhpoly1305-sse2-glue.c
index bb40fed92c92..bf0f8ac7afd6 100644
--- a/arch/x86/crypto/nhpoly1305-sse2-glue.c
+++ b/arch/x86/crypto/nhpoly1305-sse2-glue.c
@@ -68,13 +68,18 @@ MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
 static int __init nhpoly1305_mod_init(void)
 {
+	int ret;
+
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
 	if (!boot_cpu_has(X86_FEATURE_XMM2))
 		return -ENODEV;
 
-	return crypto_register_shash(&nhpoly1305_alg);
+	ret = crypto_register_shash(&nhpoly1305_alg);
+	if (ret)
+		pr_info("CPU-optimized crypto module loaded\n");
+	return ret;
 }
 
 static void __exit nhpoly1305_mod_exit(void)
diff --git a/arch/x86/crypto/poly1305_glue.c b/arch/x86/crypto/poly1305_glue.c
index a2a7cb39cdec..c9ebb6b90d1f 100644
--- a/arch/x86/crypto/poly1305_glue.c
+++ b/arch/x86/crypto/poly1305_glue.c
@@ -273,22 +273,39 @@ MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
 static int __init poly1305_simd_mod_init(void)
 {
+	int ret;
+	int enabled_avx = 0;
+	int enabled_avx2 = 0;
+	int enabled_avx512 = 0;
+
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
 	if (boot_cpu_has(X86_FEATURE_AVX) &&
-	    cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL))
+	    cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
+		enabled_avx = 1;
 		static_branch_enable(&poly1305_use_avx);
+	}
 	if (boot_cpu_has(X86_FEATURE_AVX) && boot_cpu_has(X86_FEATURE_AVX2) &&
-	    cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL))
+	    cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
+		enabled_avx2 = 1;
 		static_branch_enable(&poly1305_use_avx2);
+	}
 	if (IS_ENABLED(CONFIG_AS_AVX512) && boot_cpu_has(X86_FEATURE_AVX) &&
 	    boot_cpu_has(X86_FEATURE_AVX2) && boot_cpu_has(X86_FEATURE_AVX512F) &&
 	    cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM | XFEATURE_MASK_AVX512, NULL) &&
 	    /* Skylake downclocks unacceptably much when using zmm, but later generations are fast. */
-	    boot_cpu_data.x86_model != INTEL_FAM6_SKYLAKE_X)
+	    boot_cpu_data.x86_model != INTEL_FAM6_SKYLAKE_X) {
+		enabled_avx512 = 1;
 		static_branch_enable(&poly1305_use_avx512);
-	return IS_REACHABLE(CONFIG_CRYPTO_HASH) ? crypto_register_shash(&alg) : 0;
+	}
+	ret = IS_REACHABLE(CONFIG_CRYPTO_HASH) ? crypto_register_shash(&alg) : 0;
+	if (!ret)
+		pr_info("CPU-optimized crypto module loaded (AVX=%s, AVX2=%s, AVX512=%s)\n",
+			enabled_avx ? "yes" : "no",
+			enabled_avx2 ? "yes" : "no",
+			enabled_avx512 ? "yes" : "no");
+	return ret;
 }
 
 static void __exit poly1305_simd_mod_exit(void)
diff --git a/arch/x86/crypto/polyval-clmulni_glue.c b/arch/x86/crypto/polyval-clmulni_glue.c
index 5a345db20ca9..7a3a80085c90 100644
--- a/arch/x86/crypto/polyval-clmulni_glue.c
+++ b/arch/x86/crypto/polyval-clmulni_glue.c
@@ -183,13 +183,18 @@ MODULE_DEVICE_TABLE(x86cpu, pcmul_cpu_id);
 
 static int __init polyval_clmulni_mod_init(void)
 {
+	int ret;
+
 	if (!x86_match_cpu(pcmul_cpu_id))
 		return -ENODEV;
 
 	if (!boot_cpu_has(X86_FEATURE_AVX))
 		return -ENODEV;
 
-	return crypto_register_shash(&polyval_alg);
+	ret = crypto_register_shash(&polyval_alg);
+	if (!ret)
+		pr_info("CPU-optimized crypto module loaded\n");
+	return ret;
 }
 
 static void __exit polyval_clmulni_mod_exit(void)
diff --git a/arch/x86/crypto/serpent_avx2_glue.c b/arch/x86/crypto/serpent_avx2_glue.c
index 5944bf5ead2e..bf59addaf804 100644
--- a/arch/x86/crypto/serpent_avx2_glue.c
+++ b/arch/x86/crypto/serpent_avx2_glue.c
@@ -108,8 +108,8 @@ static struct simd_skcipher_alg *serpent_simd_algs[ARRAY_SIZE(serpent_algs)];
 static int __init serpent_avx2_init(void)
 {
 	const char *feature_name;
+	int ret;
 
-	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
 	if (!boot_cpu_has(X86_FEATURE_AVX2) || !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
@@ -122,9 +122,12 @@ static int __init serpent_avx2_init(void)
 		return -ENODEV;
 	}
 
-	return simd_register_skciphers_compat(serpent_algs,
+	ret = simd_register_skciphers_compat(serpent_algs,
 					      ARRAY_SIZE(serpent_algs),
 					      serpent_simd_algs);
+	if (!ret)
+		pr_info("CPU-optimized crypto module loaded\n");
+	return ret;
 }
 
 static void __exit serpent_avx2_fini(void)
diff --git a/arch/x86/crypto/serpent_avx_glue.c b/arch/x86/crypto/serpent_avx_glue.c
index 45713c7a4cb9..7b0c02a61552 100644
--- a/arch/x86/crypto/serpent_avx_glue.c
+++ b/arch/x86/crypto/serpent_avx_glue.c
@@ -114,6 +114,7 @@ static struct simd_skcipher_alg *serpent_simd_algs[ARRAY_SIZE(serpent_algs)];
 static int __init serpent_init(void)
 {
 	const char *feature_name;
+	int ret;
 
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
@@ -124,9 +125,12 @@ static int __init serpent_init(void)
 		return -ENODEV;
 	}
 
-	return simd_register_skciphers_compat(serpent_algs,
+	ret = simd_register_skciphers_compat(serpent_algs,
 					      ARRAY_SIZE(serpent_algs),
 					      serpent_simd_algs);
+	if (!ret)
+		pr_info("CPU-optimized crypto module loaded\n");
+	return ret;
 }
 
 static void __exit serpent_exit(void)
diff --git a/arch/x86/crypto/serpent_sse2_glue.c b/arch/x86/crypto/serpent_sse2_glue.c
index d8aa0d3fbf15..f82880ef6f10 100644
--- a/arch/x86/crypto/serpent_sse2_glue.c
+++ b/arch/x86/crypto/serpent_sse2_glue.c
@@ -116,6 +116,8 @@ static struct simd_skcipher_alg *serpent_simd_algs[ARRAY_SIZE(serpent_algs)];
 
 static int __init serpent_sse2_init(void)
 {
+	int ret;
+
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
@@ -124,9 +126,12 @@ static int __init serpent_sse2_init(void)
 		return -ENODEV;
 	}
 
-	return simd_register_skciphers_compat(serpent_algs,
+	ret = simd_register_skciphers_compat(serpent_algs,
 					      ARRAY_SIZE(serpent_algs),
 					      serpent_simd_algs);
+	if (!ret)
+		pr_info("CPU-optimized crypto module loaded\n");
+	return ret;
 }
 
 static void __exit serpent_sse2_exit(void)
diff --git a/arch/x86/crypto/sm3_avx_glue.c b/arch/x86/crypto/sm3_avx_glue.c
index 475b9637a06d..532f07b05745 100644
--- a/arch/x86/crypto/sm3_avx_glue.c
+++ b/arch/x86/crypto/sm3_avx_glue.c
@@ -125,6 +125,7 @@ MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 static int __init sm3_avx_mod_init(void)
 {
 	const char *feature_name;
+	int ret;
 
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
@@ -145,7 +146,10 @@ static int __init sm3_avx_mod_init(void)
 		return -ENODEV;
 	}
 
-	return crypto_register_shash(&sm3_avx_alg);
+	ret = crypto_register_shash(&sm3_avx_alg);
+	if (!ret)
+		pr_info("CPU-optimized crypto module loaded\n");
+	return ret;
 }
 
 static void __exit sm3_avx_mod_exit(void)
diff --git a/arch/x86/crypto/sm4_aesni_avx2_glue.c b/arch/x86/crypto/sm4_aesni_avx2_glue.c
index 3fe9e170b880..42819ee5d36d 100644
--- a/arch/x86/crypto/sm4_aesni_avx2_glue.c
+++ b/arch/x86/crypto/sm4_aesni_avx2_glue.c
@@ -143,6 +143,7 @@ simd_sm4_aesni_avx2_skciphers[ARRAY_SIZE(sm4_aesni_avx2_skciphers)];
 static int __init sm4_init(void)
 {
 	const char *feature_name;
+	int ret;
 
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
@@ -161,9 +162,12 @@ static int __init sm4_init(void)
 		return -ENODEV;
 	}
 
-	return simd_register_skciphers_compat(sm4_aesni_avx2_skciphers,
+	ret = simd_register_skciphers_compat(sm4_aesni_avx2_skciphers,
 					ARRAY_SIZE(sm4_aesni_avx2_skciphers),
 					simd_sm4_aesni_avx2_skciphers);
+	if (!ret)
+		pr_info("CPU-optimized crypto module loaded\n");
+	return ret;
 }
 
 static void __exit sm4_exit(void)
diff --git a/arch/x86/crypto/sm4_aesni_avx_glue.c b/arch/x86/crypto/sm4_aesni_avx_glue.c
index 14ae012948ae..8a25376d341f 100644
--- a/arch/x86/crypto/sm4_aesni_avx_glue.c
+++ b/arch/x86/crypto/sm4_aesni_avx_glue.c
@@ -461,8 +461,8 @@ simd_sm4_aesni_avx_skciphers[ARRAY_SIZE(sm4_aesni_avx_skciphers)];
 static int __init sm4_init(void)
 {
 	const char *feature_name;
+	int ret;
 
-	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
 	if (!boot_cpu_has(X86_FEATURE_AVX) ||
@@ -478,9 +478,12 @@ static int __init sm4_init(void)
 		return -ENODEV;
 	}
 
-	return simd_register_skciphers_compat(sm4_aesni_avx_skciphers,
+	ret = simd_register_skciphers_compat(sm4_aesni_avx_skciphers,
 					ARRAY_SIZE(sm4_aesni_avx_skciphers),
 					simd_sm4_aesni_avx_skciphers);
+	if (!ret)
+		pr_info("CPU-optimized crypto module loaded\n");
+	return ret;
 }
 
 static void __exit sm4_exit(void)
diff --git a/arch/x86/crypto/twofish_avx_glue.c b/arch/x86/crypto/twofish_avx_glue.c
index 044e4f92e2c0..ccf016bf6ef2 100644
--- a/arch/x86/crypto/twofish_avx_glue.c
+++ b/arch/x86/crypto/twofish_avx_glue.c
@@ -117,6 +117,7 @@ static struct simd_skcipher_alg *twofish_simd_algs[ARRAY_SIZE(twofish_algs)];
 static int __init twofish_init(void)
 {
 	const char *feature_name;
+	int ret;
 
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
@@ -126,9 +127,12 @@ static int __init twofish_init(void)
 		return -ENODEV;
 	}
 
-	return simd_register_skciphers_compat(twofish_algs,
-					      ARRAY_SIZE(twofish_algs),
-					      twofish_simd_algs);
+	ret = simd_register_skciphers_compat(twofish_algs,
+					     ARRAY_SIZE(twofish_algs),
+					     twofish_simd_algs);
+	if (!ret)
+		pr_info("CPU-optimized crypto module loaded\n");
+	return ret;
 }
 
 static void __exit twofish_exit(void)
diff --git a/arch/x86/crypto/twofish_glue.c b/arch/x86/crypto/twofish_glue.c
index 031ed290c755..5756b9cab982 100644
--- a/arch/x86/crypto/twofish_glue.c
+++ b/arch/x86/crypto/twofish_glue.c
@@ -92,10 +92,15 @@ MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
 static int __init twofish_glue_init(void)
 {
+	int ret;
+
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
-	return crypto_register_alg(&alg);
+	ret = crypto_register_alg(&alg);
+	if (!ret)
+		pr_info("CPU-optimized crypto module loaded\n");
+	return ret;
 }
 
 static void __exit twofish_glue_fini(void)
diff --git a/arch/x86/crypto/twofish_glue_3way.c b/arch/x86/crypto/twofish_glue_3way.c
index 7e2a18e3abe7..2fde637b40c8 100644
--- a/arch/x86/crypto/twofish_glue_3way.c
+++ b/arch/x86/crypto/twofish_glue_3way.c
@@ -151,6 +151,8 @@ MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
 static int __init twofish_3way_init(void)
 {
+	int ret;
+
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
@@ -162,8 +164,11 @@ static int __init twofish_3way_init(void)
 		return -ENODEV;
 	}
 
-	return crypto_register_skciphers(tf_skciphers,
-					 ARRAY_SIZE(tf_skciphers));
+	ret = crypto_register_skciphers(tf_skciphers,
+					ARRAY_SIZE(tf_skciphers));
+	if (!ret)
+		pr_info("CPU-optimized crypto module loaded\n");
+	return ret;
 }
 
 static void __exit twofish_3way_fini(void)
-- 
2.37.3

