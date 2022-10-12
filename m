Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA905FCDFC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiJLWBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiJLWAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:00:42 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51A22937D;
        Wed, 12 Oct 2022 15:00:20 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CKwftF006351;
        Wed, 12 Oct 2022 22:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=r+X+jLySvqDiKiHMsNUb6PPWVOp5GHi0Deu+a2h35I8=;
 b=UiswrlZFgQtCZIAdMZNiMGZr/q6aI8bgKtaV37CyrdXPdKzrgww2NYex3vIIll5zpqdH
 k9Hpf8/OT8JZvtnTtUFokJ6ms/pRVLpj/1EdxQS/veTxjpFCKcAt8S9aesQnZi2iCnvr
 ksdiQ1kGFc1WdedR8EaOTSrAnzdaWii8d+f5TSrjz8ogGCSC1d+rhJ8h59ZdlGyP68NI
 8dvB1nXDtk12JRVOh2wKwwvDZGsoDclvgAfA3ZwYGMxhDt88JrSxIScrJDWE3yMgXGUV
 d1tFFpTyNY8D1zKpvX/cF/mxqYvWugErNSrFS/joWPpcAnL1jzAN1TYVvJPiZuz+QW9u AA== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k653c8dd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 22:00:06 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id B508313943;
        Wed, 12 Oct 2022 22:00:05 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 616D5807DB8;
        Wed, 12 Oct 2022 22:00:05 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 14/19] crypto: x86 - load based on CPU features
Date:   Wed, 12 Oct 2022 16:59:26 -0500
Message-Id: <20221012215931.3896-15-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012215931.3896-1-elliott@hpe.com>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7z1WUvCAZ4qfCWocIMKTMMooH90dGYAE
X-Proofpoint-ORIG-GUID: 7z1WUvCAZ4qfCWocIMKTMMooH90dGYAE
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_11,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210120138
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 optimized crypto modules built as modules rather than built-in
to the kernel end up as .ko files in the filesystem, e.g., in
/usr/lib/modules. If the filesystem itself is a module, these might
not be available when the crypto API is initialized, resulting in
the generic implementation being used (e.g., sha512_transform rather
than sha512_transform_avx2).

In one test case, CPU utilization in the sha512 function dropped
from 15.34% to 7.18% after forcing loading of the optimized module.

Set module aliases for x86 optimized crypto modules based on CPU
feature bits so udev gets a chance to load them later in the boot
process when the filesystems are all running.

For example, with sha256, sha512, aesni_intel, and blake2s configured
as built-in and the rest configured as modules:

[   13.749145] sha256_ssse3: CPU-optimized crypto module loaded (SSSE3=no, AVX=no, AVX2=yes, SHA-NI=no)
[   13.758502] sha512_ssse3: CPU-optimized crypto module loaded (SSSE3=no, AVX=no, AVX2=yes)
[   13.766939] libblake2s_x86_64: CPU-optimized crypto module loaded (SSSE3=yes, AVX512=yes)
[   16.794502] aesni_intel: CPU-optimized crypto module loaded (GCM SSE=no, AVX=yes, AVX2=yes)(CTR AVX=yes)
...
[   18.160648] Run /init as init process
...
[   20.073484] twofish_x86_64: CPU-optimized crypto module loaded
[   23.974029] serpent_sse2_x86_64: CPU-optimized crypto module loaded
[   24.080749] serpent_avx_x86_64: CPU-optimized crypto module loaded
[   24.187148] serpent_avx2: CPU-optimized crypto module loaded
[   24.358980] des3_ede_x86_64: CPU-optimized crypto module loaded
[   24.459257] camellia_x86_64: CPU-optimized crypto module loaded
[   24.548487] camellia_aesni_avx_x86_64: CPU-optimized crypto module loaded
[   24.630777] camellia_aesni_avx2: CPU-optimized crypto module loaded
[   24.957134] blowfish_x86_64: CPU-optimized crypto module loaded
[   25.063537] aegis128_aesni: CPU-optimized crypto module loaded
[   25.174560] chacha_x86_64: CPU-optimized crypto module loaded (AVX2=yes, AVX512=yes)
[   25.270084] sha1_ssse3: CPU-optimized crypto module loaded (SSSE3=no, AVX=no, AVX2=yes, SHA-NI=no)
[   25.531724] ghash_clmulni_intel: CPU-optimized crypto module loaded
[   25.596316] crc32c_intel: CPU-optimized crypto module loaded (PCLMULQDQ=yes)
[   25.661693] crc32_pclmul: CPU-optimized crypto module loaded
[   25.696388] crct10dif_pclmul: CPU-optimized crypto module loaded
[   25.742040] poly1305_x86_64: CPU-optimized crypto module loaded (AVX=yes, AVX2=yes, AVX512=no)
[   25.841364] nhpoly1305_avx2: CPU-optimized crypto module loaded
[   25.856401] curve25519_x86_64: CPU-optimized crypto module loaded (ADX=yes)
[   25.866615] sm3_avx_x86_64: CPU-optimized crypto module loaded

This commit covers modules that did not create rcu stall issues
due to kernel_fpu_begin/kernel_fpu_end calls.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/aegis128-aesni-glue.c      |  9 +++++++++
 arch/x86/crypto/aesni-intel_glue.c         |  7 +++----
 arch/x86/crypto/blake2s-glue.c             | 11 ++++++++++-
 arch/x86/crypto/blowfish_glue.c            | 10 ++++++++++
 arch/x86/crypto/camellia_aesni_avx2_glue.c | 12 ++++++++++++
 arch/x86/crypto/camellia_aesni_avx_glue.c  | 11 +++++++++++
 arch/x86/crypto/camellia_glue.c            |  9 +++++++++
 arch/x86/crypto/cast5_avx_glue.c           | 10 ++++++++++
 arch/x86/crypto/cast6_avx_glue.c           | 10 ++++++++++
 arch/x86/crypto/chacha_glue.c              | 12 ++++++++++--
 arch/x86/crypto/curve25519-x86_64.c        | 12 +++++++++++-
 arch/x86/crypto/des3_ede_glue.c            | 10 ++++++++++
 arch/x86/crypto/nhpoly1305-avx2-glue.c     | 10 ++++++++++
 arch/x86/crypto/nhpoly1305-sse2-glue.c     | 10 ++++++++++
 arch/x86/crypto/poly1305_glue.c            | 12 ++++++++++++
 arch/x86/crypto/serpent_avx2_glue.c        | 10 ++++++++++
 arch/x86/crypto/serpent_avx_glue.c         | 10 ++++++++++
 arch/x86/crypto/serpent_sse2_glue.c        | 10 ++++++++++
 arch/x86/crypto/sm4_aesni_avx2_glue.c      | 12 ++++++++++++
 arch/x86/crypto/sm4_aesni_avx_glue.c       | 11 +++++++++++
 arch/x86/crypto/twofish_avx_glue.c         | 10 ++++++++++
 arch/x86/crypto/twofish_glue.c             | 10 ++++++++++
 arch/x86/crypto/twofish_glue_3way.c        | 10 ++++++++++
 23 files changed, 230 insertions(+), 8 deletions(-)

diff --git a/arch/x86/crypto/aegis128-aesni-glue.c b/arch/x86/crypto/aegis128-aesni-glue.c
index 4623189000d8..9e4ba031704d 100644
--- a/arch/x86/crypto/aegis128-aesni-glue.c
+++ b/arch/x86/crypto/aegis128-aesni-glue.c
@@ -263,10 +263,19 @@ static struct aead_alg crypto_aegis128_aesni_alg = {
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
 	    !boot_cpu_has(X86_FEATURE_AES) ||
 	    !cpu_has_xfeatures(XFEATURE_MASK_SSE, NULL))
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index a5b0cb3efeba..4a530a558436 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -36,7 +36,6 @@
 #include <linux/spinlock.h>
 #include <linux/static_call.h>
 
-
 #define AESNI_ALIGN	16
 #define AESNI_ALIGN_ATTR __attribute__ ((__aligned__(AESNI_ALIGN)))
 #define AES_BLOCK_MASK	(~(AES_BLOCK_SIZE - 1))
@@ -1228,17 +1227,17 @@ static struct aead_alg aesni_aeads[0];
 
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
diff --git a/arch/x86/crypto/blake2s-glue.c b/arch/x86/crypto/blake2s-glue.c
index 3054ee7fa219..5153bb423dbe 100644
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
@@ -56,8 +56,17 @@ void blake2s_compress(struct blake2s_state *state, const u8 *block,
 }
 EXPORT_SYMBOL(blake2s_compress);
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_ANY, NULL),
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
index e7e4d64e9577..8e3ac5be7cf6 100644
--- a/arch/x86/crypto/camellia_aesni_avx2_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx2_glue.c
@@ -11,6 +11,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/types.h>
+#include <asm/cpu_device_id.h>
 
 #include "camellia.h"
 #include "ecb_cbc_helpers.h"
@@ -98,12 +99,23 @@ static struct skcipher_alg camellia_algs[] = {
 	},
 };
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_AVX2, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_AES, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static struct simd_skcipher_alg *camellia_simd_algs[ARRAY_SIZE(camellia_algs)];
 
 static int __init camellia_aesni_init(void)
 {
 	const char *feature_name;
 
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (!boot_cpu_has(X86_FEATURE_AVX) ||
 	    !boot_cpu_has(X86_FEATURE_AVX2) ||
 	    !boot_cpu_has(X86_FEATURE_AES) ||
diff --git a/arch/x86/crypto/camellia_aesni_avx_glue.c b/arch/x86/crypto/camellia_aesni_avx_glue.c
index c7ccf63e741e..54fcd86160ff 100644
--- a/arch/x86/crypto/camellia_aesni_avx_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx_glue.c
@@ -11,6 +11,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/types.h>
+#include <asm/cpu_device_id.h>
 
 #include "camellia.h"
 #include "ecb_cbc_helpers.h"
@@ -98,12 +99,22 @@ static struct skcipher_alg camellia_algs[] = {
 	}
 };
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_AES, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static struct simd_skcipher_alg *camellia_simd_algs[ARRAY_SIZE(camellia_algs)];
 
 static int __init camellia_aesni_init(void)
 {
 	const char *feature_name;
 
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (!boot_cpu_has(X86_FEATURE_AVX) ||
 	    !boot_cpu_has(X86_FEATURE_AES) ||
 	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
diff --git a/arch/x86/crypto/camellia_glue.c b/arch/x86/crypto/camellia_glue.c
index d45e9c0c42ac..e21d2d5b68f9 100644
--- a/arch/x86/crypto/camellia_glue.c
+++ b/arch/x86/crypto/camellia_glue.c
@@ -1377,10 +1377,19 @@ static int force;
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
index 0d7e172862db..7275cae3380d 100644
--- a/arch/x86/crypto/chacha_glue.c
+++ b/arch/x86/crypto/chacha_glue.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
+#include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
 #define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
@@ -278,10 +279,17 @@ static struct skcipher_alg algs[] = {
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
+
 
 	static_branch_enable(&chacha_use_simd);
 
diff --git a/arch/x86/crypto/curve25519-x86_64.c b/arch/x86/crypto/curve25519-x86_64.c
index d55fa9e9b9e6..7fe395dfa79d 100644
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
 
@@ -1697,9 +1697,19 @@ static struct kpp_alg curve25519_alg = {
 	.max_size		= curve25519_max_size,
 };
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_ADX, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_SSSE3, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
 static int __init curve25519_mod_init(void)
 {
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (boot_cpu_has(X86_FEATURE_BMI2) && boot_cpu_has(X86_FEATURE_ADX))
 		static_branch_enable(&curve25519_use_bmi2_adx);
 	else
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
diff --git a/arch/x86/crypto/nhpoly1305-avx2-glue.c b/arch/x86/crypto/nhpoly1305-avx2-glue.c
index 59615ae95e86..a8046334ddca 100644
--- a/arch/x86/crypto/nhpoly1305-avx2-glue.c
+++ b/arch/x86/crypto/nhpoly1305-avx2-glue.c
@@ -11,6 +11,7 @@
 #include <crypto/nhpoly1305.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
+#include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
 #define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
@@ -57,8 +58,17 @@ static struct shash_alg nhpoly1305_alg = {
 	.descsize		= sizeof(struct nhpoly1305_state),
 };
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_AVX2, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static int __init nhpoly1305_mod_init(void)
 {
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (!boot_cpu_has(X86_FEATURE_AVX2) ||
 	    !boot_cpu_has(X86_FEATURE_OSXSAVE))
 		return -ENODEV;
diff --git a/arch/x86/crypto/nhpoly1305-sse2-glue.c b/arch/x86/crypto/nhpoly1305-sse2-glue.c
index bf91c375821a..cdbe5df00927 100644
--- a/arch/x86/crypto/nhpoly1305-sse2-glue.c
+++ b/arch/x86/crypto/nhpoly1305-sse2-glue.c
@@ -11,6 +11,7 @@
 #include <crypto/nhpoly1305.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
+#include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
 #define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
@@ -57,8 +58,17 @@ static struct shash_alg nhpoly1305_alg = {
 	.descsize		= sizeof(struct nhpoly1305_state),
 };
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_XMM2, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static int __init nhpoly1305_mod_init(void)
 {
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (!boot_cpu_has(X86_FEATURE_XMM2))
 		return -ENODEV;
 
diff --git a/arch/x86/crypto/poly1305_glue.c b/arch/x86/crypto/poly1305_glue.c
index 3764301bdf1b..3e6ff505cd26 100644
--- a/arch/x86/crypto/poly1305_glue.c
+++ b/arch/x86/crypto/poly1305_glue.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
+#include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/simd.h>
 
@@ -260,8 +261,19 @@ static struct shash_alg alg = {
 	},
 };
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_AVX2, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_AVX512F, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static int __init poly1305_simd_mod_init(void)
 {
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (boot_cpu_has(X86_FEATURE_AVX) &&
 	    cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL))
 		static_branch_enable(&poly1305_use_avx);
diff --git a/arch/x86/crypto/serpent_avx2_glue.c b/arch/x86/crypto/serpent_avx2_glue.c
index 347e97f4b713..24741d33edaf 100644
--- a/arch/x86/crypto/serpent_avx2_glue.c
+++ b/arch/x86/crypto/serpent_avx2_glue.c
@@ -12,6 +12,7 @@
 #include <crypto/algapi.h>
 #include <crypto/internal/simd.h>
 #include <crypto/serpent.h>
+#include <asm/cpu_device_id.h>
 
 #include "serpent-avx.h"
 #include "ecb_cbc_helpers.h"
@@ -94,12 +95,21 @@ static struct skcipher_alg serpent_algs[] = {
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
 
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (!boot_cpu_has(X86_FEATURE_AVX2) || !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
 		pr_info("AVX2 instructions are not detected.\n");
 		return -ENODEV;
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
index d78f37e9b2cf..5288441cc223 100644
--- a/arch/x86/crypto/serpent_sse2_glue.c
+++ b/arch/x86/crypto/serpent_sse2_glue.c
@@ -20,6 +20,7 @@
 #include <crypto/b128ops.h>
 #include <crypto/internal/simd.h>
 #include <crypto/serpent.h>
+#include <asm/cpu_device_id.h>
 
 #include "serpent-sse2.h"
 #include "ecb_cbc_helpers.h"
@@ -103,10 +104,19 @@ static struct skcipher_alg serpent_algs[] = {
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
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (!boot_cpu_has(X86_FEATURE_XMM2)) {
 		printk(KERN_INFO "SSE2 instructions are not detected.\n");
 		return -ENODEV;
diff --git a/arch/x86/crypto/sm4_aesni_avx2_glue.c b/arch/x86/crypto/sm4_aesni_avx2_glue.c
index 84bc718f49a3..2e9fe76056b8 100644
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
@@ -126,6 +127,14 @@ static struct skcipher_alg sm4_aesni_avx2_skciphers[] = {
 	}
 };
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_AVX2, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_AES, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static struct simd_skcipher_alg *
 simd_sm4_aesni_avx2_skciphers[ARRAY_SIZE(sm4_aesni_avx2_skciphers)];
 
@@ -133,6 +142,9 @@ static int __init sm4_init(void)
 {
 	const char *feature_name;
 
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (!boot_cpu_has(X86_FEATURE_AVX) ||
 	    !boot_cpu_has(X86_FEATURE_AVX2) ||
 	    !boot_cpu_has(X86_FEATURE_AES) ||
diff --git a/arch/x86/crypto/sm4_aesni_avx_glue.c b/arch/x86/crypto/sm4_aesni_avx_glue.c
index 7800f77d68ad..f730822f203a 100644
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
@@ -445,6 +446,13 @@ static struct skcipher_alg sm4_aesni_avx_skciphers[] = {
 	}
 };
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_AES, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static struct simd_skcipher_alg *
 simd_sm4_aesni_avx_skciphers[ARRAY_SIZE(sm4_aesni_avx_skciphers)];
 
@@ -452,6 +460,9 @@ static int __init sm4_init(void)
 {
 	const char *feature_name;
 
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (!boot_cpu_has(X86_FEATURE_AVX) ||
 	    !boot_cpu_has(X86_FEATURE_AES) ||
 	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
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
2.37.3

