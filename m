Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B608262B238
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 05:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbiKPEQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 23:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiKPEOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 23:14:50 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8D231F84;
        Tue, 15 Nov 2022 20:14:27 -0800 (PST)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG31I51027442;
        Wed, 16 Nov 2022 04:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=cJKMCHkT5xvvzAOQNWsrZR5cPiaIXad3M8CPel+8VaU=;
 b=aaj4zTKHdL8CvWgZf8JaLChD8Ff6fXt/Pv3AmQNZfK1ArLiXvLY+f/SkTCyN1L2cuFJd
 lSpLZ9HLESNaKYx88cDih+LSXcm1vN5wrBMnm7fii2rvFVm8yLTYEtD74aSJS0XkJhyQ
 Q/J0IzAl/uVgC7+A8MuWWIY188bmbAi9tbRBgRKrQ4d/giIKg4He589MGK4bGzR2zHl/
 Q7l0/+Nab3lQmEWtFf5rpv1yG+YyTYMgNa6vxhO/3iuTIYsYwcgro4LfNFJs1pj87XkH
 PDqRWcin6ouzq0zQrA6wxlsTwv3zsvsy12I/MarJ3shdSTmxsscMTZywUZLReuBS+VF6 9A== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3kvqkbregf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 04:14:19 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 0606C809F54;
        Wed, 16 Nov 2022 04:14:19 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 89340808BA4;
        Wed, 16 Nov 2022 04:14:18 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v4 21/24] crypto: x86 - report used CPU features via module parameters
Date:   Tue, 15 Nov 2022 22:13:39 -0600
Message-Id: <20221116041342.3841-22-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116041342.3841-1-elliott@hpe.com>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tom0kJNCaO36T67a9Jf75QJ94g939dEK
X-Proofpoint-ORIG-GUID: tom0kJNCaO36T67a9Jf75QJ94g939dEK
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

For modules that have multiple choices, add read-only module parameters
reporting which CPU features a module is using.

The parameters show up as follows for modules that modify the behavior
of their registered drivers or register additional drivers for
each choice:
    /sys/module/aesni_intel/parameters/using_x86_avx:1
    /sys/module/aesni_intel/parameters/using_x86_avx2:1
    /sys/module/aria_aesni_avx_x86_64/parameters/using_x86_gfni:0
    /sys/module/chacha_x86_64/parameters/using_x86_avx2:1
    /sys/module/chacha_x86_64/parameters/using_x86_avx512:1
    /sys/module/crc32c_intel/parameters/using_x86_pclmulqdq:1
    /sys/module/curve25519_x86_64/parameters/using_x86_adx:1
    /sys/module/libblake2s_x86_64/parameters/using_x86_avx512:1
    /sys/module/libblake2s_x86_64/parameters/using_x86_ssse3:1
    /sys/module/poly1305_x86_64/parameters/using_x86_avx:1
    /sys/module/poly1305_x86_64/parameters/using_x86_avx2:1
    /sys/module/poly1305_x86_64/parameters/using_x86_avx512:0
    /sys/module/sha1_ssse3/parameters/using_x86_avx:1
    /sys/module/sha1_ssse3/parameters/using_x86_avx2:1
    /sys/module/sha1_ssse3/parameters/using_x86_shani:0
    /sys/module/sha1_ssse3/parameters/using_x86_ssse3:1
    /sys/module/sha256_ssse3/parameters/using_x86_avx:1
    /sys/module/sha256_ssse3/parameters/using_x86_avx2:1
    /sys/module/sha256_ssse3/parameters/using_x86_shani:0
    /sys/module/sha256_ssse3/parameters/using_x86_ssse3:1
    /sys/module/sha512_ssse3/parameters/using_x86_avx:1
    /sys/module/sha512_ssse3/parameters/using_x86_avx2:1
    /sys/module/sha512_ssse3/parameters/using_x86_ssse3:1

Delete the aesni_intel prints reporting those selections:
    pr_info("AVX2 version of gcm_enc/dec engaged.\n");

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/aesni-intel_glue.c    | 19 ++++++++-----------
 arch/x86/crypto/aria_aesni_avx_glue.c |  6 ++++++
 arch/x86/crypto/blake2s-glue.c        |  5 +++++
 arch/x86/crypto/chacha_glue.c         |  5 +++++
 arch/x86/crypto/crc32c-intel_glue.c   |  6 ++++++
 arch/x86/crypto/curve25519-x86_64.c   |  3 +++
 arch/x86/crypto/poly1305_glue.c       |  7 +++++++
 arch/x86/crypto/sha1_ssse3_glue.c     | 11 +++++++++++
 arch/x86/crypto/sha256_ssse3_glue.c   | 20 +++++++++++---------
 arch/x86/crypto/sha512_ssse3_glue.c   |  7 +++++++
 10 files changed, 69 insertions(+), 20 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 0505d4f9d2a2..80dbf98c53fd 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -1228,6 +1228,11 @@ static struct aead_alg aesni_aeads[0];
 
 static struct simd_aead_alg *aesni_simd_aeads[ARRAY_SIZE(aesni_aeads)];
 
+module_param_named(using_x86_avx2, gcm_use_avx2.key.enabled.counter, int, 0444);
+module_param_named(using_x86_avx, gcm_use_avx.key.enabled.counter, int, 0444);
+MODULE_PARM_DESC(using_x86_avx2, "Using x86 instruction set extensions: AVX2 (for GCM mode)");
+MODULE_PARM_DESC(using_x86_avx, "Using x86 instruction set extensions: AVX (for CTR and GCM modes)");
+
 static const struct x86_cpu_id module_cpu_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_AES, NULL),
 	{}
@@ -1241,22 +1246,14 @@ static int __init aesni_init(void)
 	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 #ifdef CONFIG_X86_64
-	if (boot_cpu_has(X86_FEATURE_AVX2)) {
-		pr_info("AVX2 version of gcm_enc/dec engaged.\n");
-		static_branch_enable(&gcm_use_avx);
+	if (boot_cpu_has(X86_FEATURE_AVX2))
 		static_branch_enable(&gcm_use_avx2);
-	} else
+
 	if (boot_cpu_has(X86_FEATURE_AVX)) {
-		pr_info("AVX version of gcm_enc/dec engaged.\n");
 		static_branch_enable(&gcm_use_avx);
-	} else {
-		pr_info("SSE version of gcm_enc/dec engaged.\n");
-	}
-	if (boot_cpu_has(X86_FEATURE_AVX)) {
-		/* optimize performance of ctr mode encryption transform */
 		static_call_update(aesni_ctr_enc_tfm, aesni_ctr_enc_avx_tfm);
-		pr_info("AES CTR mode by8 optimization enabled\n");
 	}
+
 #endif /* CONFIG_X86_64 */
 
 	err = crypto_register_alg(&aesni_cipher_alg);
diff --git a/arch/x86/crypto/aria_aesni_avx_glue.c b/arch/x86/crypto/aria_aesni_avx_glue.c
index 6a135203a767..9fd3d1fe1105 100644
--- a/arch/x86/crypto/aria_aesni_avx_glue.c
+++ b/arch/x86/crypto/aria_aesni_avx_glue.c
@@ -166,6 +166,10 @@ static struct skcipher_alg aria_algs[] = {
 
 static struct simd_skcipher_alg *aria_simd_algs[ARRAY_SIZE(aria_algs)];
 
+static int using_x86_gfni;
+module_param(using_x86_gfni, int, 0444);
+MODULE_PARM_DESC(using_x86_gfni, "Using x86 instruction set extensions: GF-NI");
+
 static const struct x86_cpu_id module_cpu_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
 	{}
@@ -192,6 +196,7 @@ static int __init aria_avx_init(void)
 	}
 
 	if (boot_cpu_has(X86_FEATURE_GFNI)) {
+		using_x86_gfni = 1;
 		aria_ops.aria_encrypt_16way = aria_aesni_avx_gfni_encrypt_16way;
 		aria_ops.aria_decrypt_16way = aria_aesni_avx_gfni_decrypt_16way;
 		aria_ops.aria_ctr_crypt_16way = aria_aesni_avx_gfni_ctr_crypt_16way;
@@ -210,6 +215,7 @@ static void __exit aria_avx_exit(void)
 {
 	simd_unregister_skciphers(aria_algs, ARRAY_SIZE(aria_algs),
 				  aria_simd_algs);
+	using_x86_gfni = 0;
 }
 
 module_init(aria_avx_init);
diff --git a/arch/x86/crypto/blake2s-glue.c b/arch/x86/crypto/blake2s-glue.c
index df757d18a35a..781cf9471cb6 100644
--- a/arch/x86/crypto/blake2s-glue.c
+++ b/arch/x86/crypto/blake2s-glue.c
@@ -55,6 +55,11 @@ void blake2s_compress(struct blake2s_state *state, const u8 *block,
 }
 EXPORT_SYMBOL(blake2s_compress);
 
+module_param_named(using_x86_ssse3, blake2s_use_ssse3.key.enabled.counter, int, 0444);
+module_param_named(using_x86_avx512vl, blake2s_use_avx512.key.enabled.counter, int, 0444);
+MODULE_PARM_DESC(using_x86_ssse3, "Using x86 instruction set extensions: SSSE3");
+MODULE_PARM_DESC(using_x86_avx512vl, "Using x86 instruction set extensions: AVX-512VL");
+
 static const struct x86_cpu_id module_cpu_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_SSSE3, NULL),
 	X86_MATCH_FEATURE(X86_FEATURE_AVX512VL, NULL),
diff --git a/arch/x86/crypto/chacha_glue.c b/arch/x86/crypto/chacha_glue.c
index 546ab0abf30c..ec7461412c5e 100644
--- a/arch/x86/crypto/chacha_glue.c
+++ b/arch/x86/crypto/chacha_glue.c
@@ -277,6 +277,11 @@ static struct skcipher_alg algs[] = {
 	},
 };
 
+module_param_named(using_x86_avx512vl, chacha_use_avx512vl.key.enabled.counter, int, 0444);
+module_param_named(using_x86_avx2, chacha_use_avx2.key.enabled.counter, int, 0444);
+MODULE_PARM_DESC(using_x86_avx512vl, "Using x86 instruction set extensions: AVX-512VL");
+MODULE_PARM_DESC(using_x86_avx2, "Using x86 instruction set extensions: AVX2");
+
 static const struct x86_cpu_id module_cpu_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_SSSE3, NULL),
 	{}
diff --git a/arch/x86/crypto/crc32c-intel_glue.c b/arch/x86/crypto/crc32c-intel_glue.c
index aff132e925ea..3c2bf7032667 100644
--- a/arch/x86/crypto/crc32c-intel_glue.c
+++ b/arch/x86/crypto/crc32c-intel_glue.c
@@ -240,6 +240,10 @@ static struct shash_alg alg = {
 	}
 };
 
+static int using_x86_pclmulqdq;
+module_param(using_x86_pclmulqdq, int, 0444);
+MODULE_PARM_DESC(using_x86_pclmulqdq, "Using x86 instruction set extensions: PCLMULQDQ");
+
 static const struct x86_cpu_id module_cpu_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_XMM4_2, NULL),
 	{}
@@ -252,6 +256,7 @@ static int __init crc32c_intel_mod_init(void)
 		return -ENODEV;
 #ifdef CONFIG_X86_64
 	if (boot_cpu_has(X86_FEATURE_PCLMULQDQ)) {
+		using_x86_pclmulqdq = 1;
 		alg.update = crc32c_pcl_intel_update;
 		alg.finup = crc32c_pcl_intel_finup;
 		alg.digest = crc32c_pcl_intel_digest;
@@ -263,6 +268,7 @@ static int __init crc32c_intel_mod_init(void)
 static void __exit crc32c_intel_mod_fini(void)
 {
 	crypto_unregister_shash(&alg);
+	using_x86_pclmulqdq = 0;
 }
 
 module_init(crc32c_intel_mod_init);
diff --git a/arch/x86/crypto/curve25519-x86_64.c b/arch/x86/crypto/curve25519-x86_64.c
index ae7536b17bf9..6d222849e409 100644
--- a/arch/x86/crypto/curve25519-x86_64.c
+++ b/arch/x86/crypto/curve25519-x86_64.c
@@ -1697,6 +1697,9 @@ static struct kpp_alg curve25519_alg = {
 	.max_size		= curve25519_max_size,
 };
 
+module_param_named(using_x86_adx, curve25519_use_bmi2_adx.key.enabled.counter, int, 0444);
+MODULE_PARM_DESC(using_x86_adx, "Using x86 instruction set extensions: ADX");
+
 static const struct x86_cpu_id module_cpu_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_ADX, NULL),
 	{}
diff --git a/arch/x86/crypto/poly1305_glue.c b/arch/x86/crypto/poly1305_glue.c
index f1e39e23b2a3..d3c0d5b335ea 100644
--- a/arch/x86/crypto/poly1305_glue.c
+++ b/arch/x86/crypto/poly1305_glue.c
@@ -269,6 +269,13 @@ static struct shash_alg alg = {
 	},
 };
 
+module_param_named(using_x86_avx, poly1305_use_avx.key.enabled.counter, int, 0444);
+module_param_named(using_x86_avx2, poly1305_use_avx2.key.enabled.counter, int, 0444);
+module_param_named(using_x86_avx512f, poly1305_use_avx512.key.enabled.counter, int, 0444);
+MODULE_PARM_DESC(using_x86_avx, "Using x86 instruction set extensions: AVX");
+MODULE_PARM_DESC(using_x86_avx2, "Using x86 instruction set extensions: AVX2");
+MODULE_PARM_DESC(using_x86_avx512f, "Using x86 instruction set extensions: AVX-512F");
+
 static const struct x86_cpu_id module_cpu_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_ANY, NULL),
 	{}
diff --git a/arch/x86/crypto/sha1_ssse3_glue.c b/arch/x86/crypto/sha1_ssse3_glue.c
index 806463f57b6d..2445648cf234 100644
--- a/arch/x86/crypto/sha1_ssse3_glue.c
+++ b/arch/x86/crypto/sha1_ssse3_glue.c
@@ -90,6 +90,17 @@ static int using_x86_avx2;
 static int using_x86_shani;
 #endif
 
+#ifdef CONFIG_AS_SHA1_NI
+module_param(using_x86_shani, int, 0444);
+MODULE_PARM_DESC(using_x86_shani, "Using x86 instruction set extensions: SHA-NI");
+#endif
+module_param(using_x86_ssse3, int, 0444);
+module_param(using_x86_avx, int, 0444);
+module_param(using_x86_avx2, int, 0444);
+MODULE_PARM_DESC(using_x86_ssse3, "Using x86 instruction set extensions: SSSE3");
+MODULE_PARM_DESC(using_x86_avx, "Using x86 instruction set extensions: AVX");
+MODULE_PARM_DESC(using_x86_avx2, "Using x86 instruction set extensions: AVX2");
+
 static int sha1_update(struct shash_desc *desc, const u8 *data,
 		       unsigned int len, unsigned int bytes_per_fpu,
 		       sha1_block_fn *sha1_xform)
diff --git a/arch/x86/crypto/sha256_ssse3_glue.c b/arch/x86/crypto/sha256_ssse3_glue.c
index 30c8c50c1123..1464e6ccf912 100644
--- a/arch/x86/crypto/sha256_ssse3_glue.c
+++ b/arch/x86/crypto/sha256_ssse3_glue.c
@@ -104,6 +104,17 @@ static int using_x86_avx2;
 static int using_x86_shani;
 #endif
 
+#ifdef CONFIG_AS_SHA256_NI
+module_param(using_x86_shani, int, 0444);
+MODULE_PARM_DESC(using_x86_shani, "Using x86 instruction set extensions: SHA-NI");
+#endif
+module_param(using_x86_ssse3, int, 0444);
+module_param(using_x86_avx, int, 0444);
+module_param(using_x86_avx2, int, 0444);
+MODULE_PARM_DESC(using_x86_ssse3, "Using x86 instruction set extensions: SSSE3");
+MODULE_PARM_DESC(using_x86_avx, "Using x86 instruction set extensions: AVX");
+MODULE_PARM_DESC(using_x86_avx2, "Using x86 instruction set extensions: AVX2");
+
 static int _sha256_update(struct shash_desc *desc, const u8 *data,
 			  unsigned int len, unsigned int bytes_per_fpu,
 			  sha256_block_fn *sha256_xform)
@@ -212,9 +223,6 @@ static void unregister_sha256_ssse3(void)
 	}
 }
 
-asmlinkage void sha256_transform_avx(struct sha256_state *state,
-				     const u8 *data, int blocks);
-
 static int sha256_avx_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
 {
@@ -273,9 +281,6 @@ static void unregister_sha256_avx(void)
 	}
 }
 
-asmlinkage void sha256_transform_rorx(struct sha256_state *state,
-				      const u8 *data, int blocks);
-
 static int sha256_avx2_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
 {
@@ -335,9 +340,6 @@ static void unregister_sha256_avx2(void)
 }
 
 #ifdef CONFIG_AS_SHA256_NI
-asmlinkage void sha256_ni_transform(struct sha256_state *digest,
-				    const u8 *data, int rounds);
-
 static int sha256_ni_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
 {
diff --git a/arch/x86/crypto/sha512_ssse3_glue.c b/arch/x86/crypto/sha512_ssse3_glue.c
index 48586ab40d55..04e2af951a3e 100644
--- a/arch/x86/crypto/sha512_ssse3_glue.c
+++ b/arch/x86/crypto/sha512_ssse3_glue.c
@@ -81,6 +81,13 @@ static int using_x86_ssse3;
 static int using_x86_avx;
 static int using_x86_avx2;
 
+module_param(using_x86_ssse3, int, 0444);
+module_param(using_x86_avx, int, 0444);
+module_param(using_x86_avx2, int, 0444);
+MODULE_PARM_DESC(using_x86_ssse3, "Using x86 instruction set extensions: SSSE3");
+MODULE_PARM_DESC(using_x86_avx, "Using x86 instruction set extensions: AVX");
+MODULE_PARM_DESC(using_x86_avx2, "Using x86 instruction set extensions: AVX2");
+
 static int sha512_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len, unsigned int bytes_per_fpu,
 			 sha512_block_fn *sha512_xform)
-- 
2.38.1

