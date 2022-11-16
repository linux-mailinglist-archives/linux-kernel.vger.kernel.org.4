Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4112E62B23A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 05:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbiKPEQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 23:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbiKPEOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 23:14:54 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF7932075;
        Tue, 15 Nov 2022 20:14:27 -0800 (PST)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG405Sx022067;
        Wed, 16 Nov 2022 04:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=9Vrn3Lcfdc63P//BKRWW0n5WCD4BkxzoQc4vkqFvrJ4=;
 b=g12To9Hgp8+ki2cPD7TZU/b3mY4ZW1tdICF781eb0lhMK+fvt/53XROzdTgmP4fP5cpQ
 mGtSpmERKASB9Fx9t4AoZMmZQNMsETkLrZuihBLbQEkv6Igp5XMegbCvszOCaISfjyQA
 HZ479s0hJhJ4Sb3ouriHsqX3JYXMMxuW8UwLehGnoCc/prgPLxCT79ZlL9f1qsMyH1cO
 CnEd2ld8EuS6xDMLRAtfc8yORkKHmSaMIRY93WcyWMl7sZPs1pPh4K2QIN02gGz+WSWD
 26vncZIURuEMWekJoncGtrAW7thheacC+QEhoPHNck+Y3xz2FocTarB2ZtupoLCipW1O tg== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kvrew82xf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 04:14:18 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id CC405809F55;
        Wed, 16 Nov 2022 04:14:17 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 557EA80FE88;
        Wed, 16 Nov 2022 04:14:17 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v4 20/24] crypto: x86/ciphers - load based on CPU features
Date:   Tue, 15 Nov 2022 22:13:38 -0600
Message-Id: <20221116041342.3841-21-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116041342.3841-1-elliott@hpe.com>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: veUzpVFdiJqBLXq4d6paoFfIICqaJzCv
X-Proofpoint-GUID: veUzpVFdiJqBLXq4d6paoFfIICqaJzCv
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160029
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like commit aa031b8f702e ("crypto: x86/sha512 - load based on CPU
features"), add module aliases based on CPU feature bits for
modules not implementing hash algorithms:
    aegis, aesni, aria
    blake2s, blowfish
    camellia, cast5, cast6, chacha, curve25519
    des3_ede
    serpent, sm4
    twofish

Signed-off-by: Robert Elliott <elliott@hpe.com>

---
v4 Remove CPU feature checks that are unreachable because
x86_match_cpu already handles them. Make curve25519 match
on ADX and check BMI2.
---
 arch/x86/crypto/aegis128-aesni-glue.c      | 10 +++++++++-
 arch/x86/crypto/aesni-intel_glue.c         |  6 +++---
 arch/x86/crypto/aria_aesni_avx_glue.c      | 15 ++++++++++++---
 arch/x86/crypto/blake2s-glue.c             | 12 +++++++++++-
 arch/x86/crypto/blowfish_glue.c            | 10 ++++++++++
 arch/x86/crypto/camellia_aesni_avx2_glue.c | 17 +++++++++++++----
 arch/x86/crypto/camellia_aesni_avx_glue.c  | 15 ++++++++++++---
 arch/x86/crypto/camellia_glue.c            | 10 ++++++++++
 arch/x86/crypto/cast5_avx_glue.c           | 10 ++++++++++
 arch/x86/crypto/cast6_avx_glue.c           | 10 ++++++++++
 arch/x86/crypto/chacha_glue.c              | 11 +++++++++--
 arch/x86/crypto/curve25519-x86_64.c        | 19 ++++++++++++++-----
 arch/x86/crypto/des3_ede_glue.c            | 10 ++++++++++
 arch/x86/crypto/serpent_avx2_glue.c        | 14 ++++++++++++--
 arch/x86/crypto/serpent_avx_glue.c         | 10 ++++++++++
 arch/x86/crypto/serpent_sse2_glue.c        | 11 ++++++++---
 arch/x86/crypto/sm4_aesni_avx2_glue.c      | 13 +++++++++++--
 arch/x86/crypto/sm4_aesni_avx_glue.c       | 15 ++++++++++++---
 arch/x86/crypto/twofish_avx_glue.c         | 10 ++++++++++
 arch/x86/crypto/twofish_glue.c             | 10 ++++++++++
 arch/x86/crypto/twofish_glue_3way.c        | 10 ++++++++++
 21 files changed, 216 insertions(+), 32 deletions(-)

diff --git a/arch/x86/crypto/aegis128-aesni-glue.c b/arch/x86/crypto/aegis128-aesni-glue.c
index 6e96bdda2811..a3ebd018953c 100644
--- a/arch/x86/crypto/aegis128-aesni-glue.c
+++ b/arch/x86/crypto/aegis128-aesni-glue.c
@@ -282,12 +282,20 @@ static struct aead_alg crypto_aegis128_aesni_alg = {
 	}
 };
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_AES, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static struct simd_aead_alg *simd_alg;
 
 static int __init crypto_aegis128_aesni_module_init(void)
 {
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (!boot_cpu_has(X86_FEATURE_XMM2) ||
-	    !boot_cpu_has(X86_FEATURE_AES) ||
 	    !cpu_has_xfeatures(XFEATURE_MASK_SSE, NULL))
 		return -ENODEV;
 
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 921680373855..0505d4f9d2a2 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -1228,17 +1228,17 @@ static struct aead_alg aesni_aeads[0];
 
 static struct simd_aead_alg *aesni_simd_aeads[ARRAY_SIZE(aesni_aeads)];
 
-static const struct x86_cpu_id aesni_cpu_id[] = {
+static const struct x86_cpu_id module_cpu_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_AES, NULL),
 	{}
 };
-MODULE_DEVICE_TABLE(x86cpu, aesni_cpu_id);
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
 static int __init aesni_init(void)
 {
 	int err;
 
-	if (!x86_match_cpu(aesni_cpu_id))
+	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 #ifdef CONFIG_X86_64
 	if (boot_cpu_has(X86_FEATURE_AVX2)) {
diff --git a/arch/x86/crypto/aria_aesni_avx_glue.c b/arch/x86/crypto/aria_aesni_avx_glue.c
index c561ea4fefa5..6a135203a767 100644
--- a/arch/x86/crypto/aria_aesni_avx_glue.c
+++ b/arch/x86/crypto/aria_aesni_avx_glue.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2022 Taehee Yoo <ap420073@gmail.com>
  */
 
+#include <asm/cpu_device_id.h>
 #include <crypto/algapi.h>
 #include <crypto/internal/simd.h>
 #include <crypto/aria.h>
@@ -165,14 +166,22 @@ static struct skcipher_alg aria_algs[] = {
 
 static struct simd_skcipher_alg *aria_simd_algs[ARRAY_SIZE(aria_algs)];
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static int __init aria_avx_init(void)
 {
 	const char *feature_name;
 
-	if (!boot_cpu_has(X86_FEATURE_AVX) ||
-	    !boot_cpu_has(X86_FEATURE_AES) ||
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
+	if (!boot_cpu_has(X86_FEATURE_AES) ||
 	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
-		pr_info("AVX or AES-NI instructions are not detected.\n");
+		pr_info("AES or OSXSAVE instructions are not detected.\n");
 		return -ENODEV;
 	}
 
diff --git a/arch/x86/crypto/blake2s-glue.c b/arch/x86/crypto/blake2s-glue.c
index aaba21230528..df757d18a35a 100644
--- a/arch/x86/crypto/blake2s-glue.c
+++ b/arch/x86/crypto/blake2s-glue.c
@@ -10,7 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
-
+#include <asm/cpu_device_id.h>
 #include <asm/cpufeature.h>
 #include <asm/fpu/api.h>
 #include <asm/processor.h>
@@ -55,8 +55,18 @@ void blake2s_compress(struct blake2s_state *state, const u8 *block,
 }
 EXPORT_SYMBOL(blake2s_compress);
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_SSSE3, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_AVX512VL, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static int __init blake2s_mod_init(void)
 {
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (boot_cpu_has(X86_FEATURE_SSSE3))
 		static_branch_enable(&blake2s_use_ssse3);
 
diff --git a/arch/x86/crypto/blowfish_glue.c b/arch/x86/crypto/blowfish_glue.c
index 019c64c1340a..4c0ead71b198 100644
--- a/arch/x86/crypto/blowfish_glue.c
+++ b/arch/x86/crypto/blowfish_glue.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/types.h>
+#include <asm/cpu_device_id.h>
 
 /* regular block cipher functions */
 asmlinkage void __blowfish_enc_blk(struct bf_ctx *ctx, u8 *dst, const u8 *src,
@@ -303,10 +304,19 @@ static int force;
 module_param(force, int, 0);
 MODULE_PARM_DESC(force, "Force module load, ignore CPU blacklist");
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_ANY, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static int __init blowfish_init(void)
 {
 	int err;
 
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (!force && is_blacklisted_cpu()) {
 		printk(KERN_INFO
 			"blowfish-x86_64: performance on this CPU "
diff --git a/arch/x86/crypto/camellia_aesni_avx2_glue.c b/arch/x86/crypto/camellia_aesni_avx2_glue.c
index e7e4d64e9577..6c48fc9f3fde 100644
--- a/arch/x86/crypto/camellia_aesni_avx2_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx2_glue.c
@@ -11,6 +11,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/types.h>
+#include <asm/cpu_device_id.h>
 
 #include "camellia.h"
 #include "ecb_cbc_helpers.h"
@@ -98,17 +99,25 @@ static struct skcipher_alg camellia_algs[] = {
 	},
 };
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_AVX2, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static struct simd_skcipher_alg *camellia_simd_algs[ARRAY_SIZE(camellia_algs)];
 
 static int __init camellia_aesni_init(void)
 {
 	const char *feature_name;
 
-	if (!boot_cpu_has(X86_FEATURE_AVX) ||
-	    !boot_cpu_has(X86_FEATURE_AVX2) ||
-	    !boot_cpu_has(X86_FEATURE_AES) ||
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
+	if (!boot_cpu_has(X86_FEATURE_AES) ||
+	    !boot_cpu_has(X86_FEATURE_AVX) ||
 	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
-		pr_info("AVX2 or AES-NI instructions are not detected.\n");
+		pr_info("AES-NI, AVX, or OSXSAVE instructions are not detected.\n");
 		return -ENODEV;
 	}
 
diff --git a/arch/x86/crypto/camellia_aesni_avx_glue.c b/arch/x86/crypto/camellia_aesni_avx_glue.c
index c7ccf63e741e..6d7fc96d242e 100644
--- a/arch/x86/crypto/camellia_aesni_avx_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx_glue.c
@@ -11,6 +11,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/types.h>
+#include <asm/cpu_device_id.h>
 
 #include "camellia.h"
 #include "ecb_cbc_helpers.h"
@@ -98,16 +99,24 @@ static struct skcipher_alg camellia_algs[] = {
 	}
 };
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static struct simd_skcipher_alg *camellia_simd_algs[ARRAY_SIZE(camellia_algs)];
 
 static int __init camellia_aesni_init(void)
 {
 	const char *feature_name;
 
-	if (!boot_cpu_has(X86_FEATURE_AVX) ||
-	    !boot_cpu_has(X86_FEATURE_AES) ||
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
+	if (!boot_cpu_has(X86_FEATURE_AES) ||
 	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
-		pr_info("AVX or AES-NI instructions are not detected.\n");
+		pr_info("AES-NI or OSXSAVE instructions are not detected.\n");
 		return -ENODEV;
 	}
 
diff --git a/arch/x86/crypto/camellia_glue.c b/arch/x86/crypto/camellia_glue.c
index d45e9c0c42ac..a3df1043ed73 100644
--- a/arch/x86/crypto/camellia_glue.c
+++ b/arch/x86/crypto/camellia_glue.c
@@ -8,6 +8,7 @@
  *  Copyright (C) 2006 NTT (Nippon Telegraph and Telephone Corporation)
  */
 
+#include <asm/cpu_device_id.h>
 #include <asm/unaligned.h>
 #include <linux/crypto.h>
 #include <linux/init.h>
@@ -1377,10 +1378,19 @@ static int force;
 module_param(force, int, 0);
 MODULE_PARM_DESC(force, "Force module load, ignore CPU blacklist");
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_ANY, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static int __init camellia_init(void)
 {
 	int err;
 
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (!force && is_blacklisted_cpu()) {
 		printk(KERN_INFO
 			"camellia-x86_64: performance on this CPU "
diff --git a/arch/x86/crypto/cast5_avx_glue.c b/arch/x86/crypto/cast5_avx_glue.c
index 3976a87f92ad..bdc3c763334c 100644
--- a/arch/x86/crypto/cast5_avx_glue.c
+++ b/arch/x86/crypto/cast5_avx_glue.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/types.h>
+#include <asm/cpu_device_id.h>
 
 #include "ecb_cbc_helpers.h"
 
@@ -93,12 +94,21 @@ static struct skcipher_alg cast5_algs[] = {
 	}
 };
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static struct simd_skcipher_alg *cast5_simd_algs[ARRAY_SIZE(cast5_algs)];
 
 static int __init cast5_init(void)
 {
 	const char *feature_name;
 
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
 				&feature_name)) {
 		pr_info("CPU feature '%s' is not supported.\n", feature_name);
diff --git a/arch/x86/crypto/cast6_avx_glue.c b/arch/x86/crypto/cast6_avx_glue.c
index 7e2aea372349..addca34b3511 100644
--- a/arch/x86/crypto/cast6_avx_glue.c
+++ b/arch/x86/crypto/cast6_avx_glue.c
@@ -15,6 +15,7 @@
 #include <crypto/algapi.h>
 #include <crypto/cast6.h>
 #include <crypto/internal/simd.h>
+#include <asm/cpu_device_id.h>
 
 #include "ecb_cbc_helpers.h"
 
@@ -93,12 +94,21 @@ static struct skcipher_alg cast6_algs[] = {
 	},
 };
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static struct simd_skcipher_alg *cast6_simd_algs[ARRAY_SIZE(cast6_algs)];
 
 static int __init cast6_init(void)
 {
 	const char *feature_name;
 
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
 				&feature_name)) {
 		pr_info("CPU feature '%s' is not supported.\n", feature_name);
diff --git a/arch/x86/crypto/chacha_glue.c b/arch/x86/crypto/chacha_glue.c
index 7b3a1cf0984b..546ab0abf30c 100644
--- a/arch/x86/crypto/chacha_glue.c
+++ b/arch/x86/crypto/chacha_glue.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
+#include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
 asmlinkage void chacha_block_xor_ssse3(u32 *state, u8 *dst, const u8 *src,
@@ -276,10 +277,16 @@ static struct skcipher_alg algs[] = {
 	},
 };
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_SSSE3, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static int __init chacha_simd_mod_init(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_SSSE3))
-		return 0;
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
 
 	static_branch_enable(&chacha_use_simd);
 
diff --git a/arch/x86/crypto/curve25519-x86_64.c b/arch/x86/crypto/curve25519-x86_64.c
index d55fa9e9b9e6..ae7536b17bf9 100644
--- a/arch/x86/crypto/curve25519-x86_64.c
+++ b/arch/x86/crypto/curve25519-x86_64.c
@@ -12,7 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/scatterlist.h>
-
+#include <asm/cpu_device_id.h>
 #include <asm/cpufeature.h>
 #include <asm/processor.h>
 
@@ -1697,13 +1697,22 @@ static struct kpp_alg curve25519_alg = {
 	.max_size		= curve25519_max_size,
 };
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_ADX, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
 static int __init curve25519_mod_init(void)
 {
-	if (boot_cpu_has(X86_FEATURE_BMI2) && boot_cpu_has(X86_FEATURE_ADX))
-		static_branch_enable(&curve25519_use_bmi2_adx);
-	else
-		return 0;
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
+	if (!boot_cpu_has(X86_FEATURE_BMI2))
+		return -ENODEV;
+
+	static_branch_enable(&curve25519_use_bmi2_adx);
+
 	return IS_REACHABLE(CONFIG_CRYPTO_KPP) ?
 		crypto_register_kpp(&curve25519_alg) : 0;
 }
diff --git a/arch/x86/crypto/des3_ede_glue.c b/arch/x86/crypto/des3_ede_glue.c
index abb8b1fe123b..168cac5c6ca6 100644
--- a/arch/x86/crypto/des3_ede_glue.c
+++ b/arch/x86/crypto/des3_ede_glue.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/types.h>
+#include <asm/cpu_device_id.h>
 
 struct des3_ede_x86_ctx {
 	struct des3_ede_ctx enc;
@@ -354,10 +355,19 @@ static int force;
 module_param(force, int, 0);
 MODULE_PARM_DESC(force, "Force module load, ignore CPU blacklist");
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_ANY, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static int __init des3_ede_x86_init(void)
 {
 	int err;
 
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (!force && is_blacklisted_cpu()) {
 		pr_info("des3_ede-x86_64: performance on this CPU would be suboptimal: disabling des3_ede-x86_64.\n");
 		return -ENODEV;
diff --git a/arch/x86/crypto/serpent_avx2_glue.c b/arch/x86/crypto/serpent_avx2_glue.c
index 347e97f4b713..bc18149fb928 100644
--- a/arch/x86/crypto/serpent_avx2_glue.c
+++ b/arch/x86/crypto/serpent_avx2_glue.c
@@ -12,6 +12,7 @@
 #include <crypto/algapi.h>
 #include <crypto/internal/simd.h>
 #include <crypto/serpent.h>
+#include <asm/cpu_device_id.h>
 
 #include "serpent-avx.h"
 #include "ecb_cbc_helpers.h"
@@ -94,14 +95,23 @@ static struct skcipher_alg serpent_algs[] = {
 	},
 };
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_AVX2, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static struct simd_skcipher_alg *serpent_simd_algs[ARRAY_SIZE(serpent_algs)];
 
 static int __init serpent_avx2_init(void)
 {
 	const char *feature_name;
 
-	if (!boot_cpu_has(X86_FEATURE_AVX2) || !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
-		pr_info("AVX2 instructions are not detected.\n");
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
+	if (!boot_cpu_has(X86_FEATURE_OSXSAVE)) {
+		pr_info("OSXSAVE instructions are not detected.\n");
 		return -ENODEV;
 	}
 	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
diff --git a/arch/x86/crypto/serpent_avx_glue.c b/arch/x86/crypto/serpent_avx_glue.c
index 6c248e1ea4ef..0db18d99da50 100644
--- a/arch/x86/crypto/serpent_avx_glue.c
+++ b/arch/x86/crypto/serpent_avx_glue.c
@@ -15,6 +15,7 @@
 #include <crypto/algapi.h>
 #include <crypto/internal/simd.h>
 #include <crypto/serpent.h>
+#include <asm/cpu_device_id.h>
 
 #include "serpent-avx.h"
 #include "ecb_cbc_helpers.h"
@@ -100,12 +101,21 @@ static struct skcipher_alg serpent_algs[] = {
 	},
 };
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static struct simd_skcipher_alg *serpent_simd_algs[ARRAY_SIZE(serpent_algs)];
 
 static int __init serpent_init(void)
 {
 	const char *feature_name;
 
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
 				&feature_name)) {
 		pr_info("CPU feature '%s' is not supported.\n", feature_name);
diff --git a/arch/x86/crypto/serpent_sse2_glue.c b/arch/x86/crypto/serpent_sse2_glue.c
index d78f37e9b2cf..74f0c89f55ef 100644
--- a/arch/x86/crypto/serpent_sse2_glue.c
+++ b/arch/x86/crypto/serpent_sse2_glue.c
@@ -20,6 +20,7 @@
 #include <crypto/b128ops.h>
 #include <crypto/internal/simd.h>
 #include <crypto/serpent.h>
+#include <asm/cpu_device_id.h>
 
 #include "serpent-sse2.h"
 #include "ecb_cbc_helpers.h"
@@ -103,14 +104,18 @@ static struct skcipher_alg serpent_algs[] = {
 	},
 };
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_XMM2, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static struct simd_skcipher_alg *serpent_simd_algs[ARRAY_SIZE(serpent_algs)];
 
 static int __init serpent_sse2_init(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_XMM2)) {
-		printk(KERN_INFO "SSE2 instructions are not detected.\n");
+	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
-	}
 
 	return simd_register_skciphers_compat(serpent_algs,
 					      ARRAY_SIZE(serpent_algs),
diff --git a/arch/x86/crypto/sm4_aesni_avx2_glue.c b/arch/x86/crypto/sm4_aesni_avx2_glue.c
index 84bc718f49a3..125b00db89b1 100644
--- a/arch/x86/crypto/sm4_aesni_avx2_glue.c
+++ b/arch/x86/crypto/sm4_aesni_avx2_glue.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/crypto.h>
 #include <linux/kernel.h>
+#include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 #include <crypto/internal/simd.h>
 #include <crypto/internal/skcipher.h>
@@ -126,6 +127,12 @@ static struct skcipher_alg sm4_aesni_avx2_skciphers[] = {
 	}
 };
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_AVX2, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static struct simd_skcipher_alg *
 simd_sm4_aesni_avx2_skciphers[ARRAY_SIZE(sm4_aesni_avx2_skciphers)];
 
@@ -133,11 +140,13 @@ static int __init sm4_init(void)
 {
 	const char *feature_name;
 
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (!boot_cpu_has(X86_FEATURE_AVX) ||
-	    !boot_cpu_has(X86_FEATURE_AVX2) ||
 	    !boot_cpu_has(X86_FEATURE_AES) ||
 	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
-		pr_info("AVX2 or AES-NI instructions are not detected.\n");
+		pr_info("AVX, AES-NI, and/or OSXSAVE instructions are not detected.\n");
 		return -ENODEV;
 	}
 
diff --git a/arch/x86/crypto/sm4_aesni_avx_glue.c b/arch/x86/crypto/sm4_aesni_avx_glue.c
index 7800f77d68ad..ac8182b197cf 100644
--- a/arch/x86/crypto/sm4_aesni_avx_glue.c
+++ b/arch/x86/crypto/sm4_aesni_avx_glue.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/crypto.h>
 #include <linux/kernel.h>
+#include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 #include <crypto/internal/simd.h>
 #include <crypto/internal/skcipher.h>
@@ -445,6 +446,12 @@ static struct skcipher_alg sm4_aesni_avx_skciphers[] = {
 	}
 };
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static struct simd_skcipher_alg *
 simd_sm4_aesni_avx_skciphers[ARRAY_SIZE(sm4_aesni_avx_skciphers)];
 
@@ -452,10 +459,12 @@ static int __init sm4_init(void)
 {
 	const char *feature_name;
 
-	if (!boot_cpu_has(X86_FEATURE_AVX) ||
-	    !boot_cpu_has(X86_FEATURE_AES) ||
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
+	if (!boot_cpu_has(X86_FEATURE_AES) ||
 	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
-		pr_info("AVX or AES-NI instructions are not detected.\n");
+		pr_info("AES-NI or OSXSAVE instructions are not detected.\n");
 		return -ENODEV;
 	}
 
diff --git a/arch/x86/crypto/twofish_avx_glue.c b/arch/x86/crypto/twofish_avx_glue.c
index 3eb3440b477a..4657e6efc35d 100644
--- a/arch/x86/crypto/twofish_avx_glue.c
+++ b/arch/x86/crypto/twofish_avx_glue.c
@@ -15,6 +15,7 @@
 #include <crypto/algapi.h>
 #include <crypto/internal/simd.h>
 #include <crypto/twofish.h>
+#include <asm/cpu_device_id.h>
 
 #include "twofish.h"
 #include "ecb_cbc_helpers.h"
@@ -103,12 +104,21 @@ static struct skcipher_alg twofish_algs[] = {
 	},
 };
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static struct simd_skcipher_alg *twofish_simd_algs[ARRAY_SIZE(twofish_algs)];
 
 static int __init twofish_init(void)
 {
 	const char *feature_name;
 
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, &feature_name)) {
 		pr_info("CPU feature '%s' is not supported.\n", feature_name);
 		return -ENODEV;
diff --git a/arch/x86/crypto/twofish_glue.c b/arch/x86/crypto/twofish_glue.c
index f9c4adc27404..ade98aef3402 100644
--- a/arch/x86/crypto/twofish_glue.c
+++ b/arch/x86/crypto/twofish_glue.c
@@ -43,6 +43,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/types.h>
+#include <asm/cpu_device_id.h>
 
 asmlinkage void twofish_enc_blk(struct twofish_ctx *ctx, u8 *dst,
 				const u8 *src);
@@ -81,8 +82,17 @@ static struct crypto_alg alg = {
 	}
 };
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_ANY, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static int __init twofish_glue_init(void)
 {
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	return crypto_register_alg(&alg);
 }
 
diff --git a/arch/x86/crypto/twofish_glue_3way.c b/arch/x86/crypto/twofish_glue_3way.c
index 90454cf18e0d..790e5a59a9a7 100644
--- a/arch/x86/crypto/twofish_glue_3way.c
+++ b/arch/x86/crypto/twofish_glue_3way.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/types.h>
+#include <asm/cpu_device_id.h>
 
 #include "twofish.h"
 #include "ecb_cbc_helpers.h"
@@ -140,8 +141,17 @@ static int force;
 module_param(force, int, 0);
 MODULE_PARM_DESC(force, "Force module load, ignore CPU blacklist");
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_ANY, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static int __init twofish_3way_init(void)
 {
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (!force && is_blacklisted_cpu()) {
 		printk(KERN_INFO
 			"twofish-x86_64-3way: performance on this CPU "
-- 
2.38.1

