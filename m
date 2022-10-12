Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B9A5FCE15
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiJLWEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiJLWEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:04:01 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B116A13954B;
        Wed, 12 Oct 2022 15:01:28 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CL7Wtg016423;
        Wed, 12 Oct 2022 22:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=X7Go4viamzwOn3WUTwlo1LbW+Q0tptmA7a1g3x+mSls=;
 b=P89Qz77nTHr377CTaQ/w4cfXZnv9P2GTFzorUYCdAaLW32Qi5hAMB4PfaApAqOM+RWxF
 8nI7zrA1czGGQBc3YGt2cA6JnciH+Gbw1GHXRFLLupGSzxZxweyF7CPlwRJkv7XvV8mB
 8R0w32EgX5W8nusFomefeeoeWXOMzh6S5y3EwWzlliueSEDXbc1KsoVwXSI9ObAJispM
 U1I0Zx0SbTwNj+jh387WY1LA7nvqHRpUjOqIYINF2JnZYDV6t2E9xiDJncFAw/clHFX+
 53fDY8vxloTFZayxAiee7eslHFFtuyuCUeuvRhHI/QcM6F3AZwBxxhU1mPzNdLd5gjRE jw== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k657c8adb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 22:00:11 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id C626129585;
        Wed, 12 Oct 2022 22:00:10 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 6DADB807DA5;
        Wed, 12 Oct 2022 22:00:10 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 18/19] crypto: x86 - standardize not loaded prints
Date:   Wed, 12 Oct 2022 16:59:30 -0500
Message-Id: <20221012215931.3896-19-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012215931.3896-1-elliott@hpe.com>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 82XBGjj4A8ErvKSGv2QYlO_RI8X_yhn1
X-Proofpoint-GUID: 82XBGjj4A8ErvKSGv2QYlO_RI8X_yhn1
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_11,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120138
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Standardize the prints that additional required CPU features are not
present along with the main CPU features (e.g., OSXSAVE is not
present along with AVX).

Although modules are not supposed to print unless loaded and
active, these are existing exceptions.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/aegis128-aesni-glue.c      | 4 +++-
 arch/x86/crypto/aria_aesni_avx_glue.c      | 4 ++--
 arch/x86/crypto/camellia_aesni_avx2_glue.c | 5 +++--
 arch/x86/crypto/camellia_aesni_avx_glue.c  | 5 +++--
 arch/x86/crypto/cast5_avx_glue.c           | 3 ++-
 arch/x86/crypto/cast6_avx_glue.c           | 3 ++-
 arch/x86/crypto/crc32-pclmul_glue.c        | 4 +++-
 arch/x86/crypto/nhpoly1305-avx2-glue.c     | 4 +++-
 arch/x86/crypto/serpent_avx2_glue.c        | 8 +++++---
 arch/x86/crypto/serpent_avx_glue.c         | 3 ++-
 arch/x86/crypto/sm3_avx_glue.c             | 7 ++++---
 arch/x86/crypto/sm4_aesni_avx2_glue.c      | 5 +++--
 arch/x86/crypto/sm4_aesni_avx_glue.c       | 5 +++--
 arch/x86/crypto/twofish_avx_glue.c         | 3 ++-
 14 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/arch/x86/crypto/aegis128-aesni-glue.c b/arch/x86/crypto/aegis128-aesni-glue.c
index e8eaf79ef220..aa94b9f8703c 100644
--- a/arch/x86/crypto/aegis128-aesni-glue.c
+++ b/arch/x86/crypto/aegis128-aesni-glue.c
@@ -281,8 +281,10 @@ static int __init crypto_aegis128_aesni_module_init(void)
 
 	if (!boot_cpu_has(X86_FEATURE_XMM2) ||
 	    !boot_cpu_has(X86_FEATURE_AES) ||
-	    !cpu_has_xfeatures(XFEATURE_MASK_SSE, NULL))
+	    !cpu_has_xfeatures(XFEATURE_MASK_SSE, NULL)) {
+		pr_info("CPU-optimized crypto module not loaded, all required CPU features (SSE2, AESNI) not supported\n");
 		return -ENODEV;
+	}
 
 	ret = simd_register_aeads_compat(&crypto_aegis128_aesni_alg, 1,
 					  &simd_alg);
diff --git a/arch/x86/crypto/aria_aesni_avx_glue.c b/arch/x86/crypto/aria_aesni_avx_glue.c
index d58fb995a266..24982450a125 100644
--- a/arch/x86/crypto/aria_aesni_avx_glue.c
+++ b/arch/x86/crypto/aria_aesni_avx_glue.c
@@ -176,13 +176,13 @@ static int __init aria_avx_init(void)
 	if (!boot_cpu_has(X86_FEATURE_AVX) ||
 	    !boot_cpu_has(X86_FEATURE_AES) ||
 	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
-		pr_info("AVX or AES-NI instructions are not detected.\n");
+		pr_info("CPU-optimized crypto module not loaded, all required CPU features (AVX, AES-NI, OSXSAVE) not supported\n");
 		return -ENODEV;
 	}
 
 	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
 				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
+		pr_info("CPU extended feature '%s' is not supported\n", feature_name);
 		return -ENODEV;
 	}
 
diff --git a/arch/x86/crypto/camellia_aesni_avx2_glue.c b/arch/x86/crypto/camellia_aesni_avx2_glue.c
index e6c4ed1e40d2..bc6862077984 100644
--- a/arch/x86/crypto/camellia_aesni_avx2_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx2_glue.c
@@ -123,13 +123,14 @@ static int __init camellia_aesni_init(void)
 	    !boot_cpu_has(X86_FEATURE_AVX2) ||
 	    !boot_cpu_has(X86_FEATURE_AES) ||
 	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
-		pr_info("AVX2 or AES-NI instructions are not detected.\n");
+		pr_info("CPU-optimized crypto module not loaded, all required CPU features (AVX, AVX2, AESNI, OSXSAVE) not supported\n");
 		return -ENODEV;
 	}
 
 	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
 				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
+		pr_info("CPU-optimized crypto module not loaded, CPU extended feature '%s' is not supported\n",
+			feature_name);
 		return -ENODEV;
 	}
 
diff --git a/arch/x86/crypto/camellia_aesni_avx_glue.c b/arch/x86/crypto/camellia_aesni_avx_glue.c
index 6a9eadf0fe90..96e7e1accb6c 100644
--- a/arch/x86/crypto/camellia_aesni_avx_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx_glue.c
@@ -121,13 +121,14 @@ static int __init camellia_aesni_init(void)
 	if (!boot_cpu_has(X86_FEATURE_AVX) ||
 	    !boot_cpu_has(X86_FEATURE_AES) ||
 	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
-		pr_info("AVX or AES-NI instructions are not detected.\n");
+		pr_info("CPU-optimized crypto module not loaded, all required CPU features (AVX, AESNI, OSXSAVE) not supported\n");
 		return -ENODEV;
 	}
 
 	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
 				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
+		pr_info("CPU-optimized crypto module not loaded, CPU extended feature '%s' is not supported\n",
+			feature_name);
 		return -ENODEV;
 	}
 
diff --git a/arch/x86/crypto/cast5_avx_glue.c b/arch/x86/crypto/cast5_avx_glue.c
index b5ae17c3ac53..89650fffb550 100644
--- a/arch/x86/crypto/cast5_avx_glue.c
+++ b/arch/x86/crypto/cast5_avx_glue.c
@@ -114,7 +114,8 @@ static int __init cast5_init(void)
 
 	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
 				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
+		pr_info("CPU-optimized crypto module not loaded, CPU extended feature '%s' is not supported\n",
+		feature_name);
 		return -ENODEV;
 	}
 
diff --git a/arch/x86/crypto/cast6_avx_glue.c b/arch/x86/crypto/cast6_avx_glue.c
index d1c14a5f80d7..d69f62ac9553 100644
--- a/arch/x86/crypto/cast6_avx_glue.c
+++ b/arch/x86/crypto/cast6_avx_glue.c
@@ -114,7 +114,8 @@ static int __init cast6_init(void)
 
 	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
 				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
+		pr_info("CPU-optimized crypto module not loaded, CPU extended feature '%s' is not supported\n",
+			feature_name);
 		return -ENODEV;
 	}
 
diff --git a/arch/x86/crypto/crc32-pclmul_glue.c b/arch/x86/crypto/crc32-pclmul_glue.c
index c56d3d3ab0a0..4cf86f8f9428 100644
--- a/arch/x86/crypto/crc32-pclmul_glue.c
+++ b/arch/x86/crypto/crc32-pclmul_glue.c
@@ -192,8 +192,10 @@ static int __init crc32_pclmul_mod_init(void)
 {
 	int ret;
 
-	if (!x86_match_cpu(module_cpu_ids))
+	if (!x86_match_cpu(module_cpu_ids)) {
+		pr_info("CPU-optimized crypto module not loaded, required CPU feature (PCLMULQDQ) not supported\n");
 		return -ENODEV;
+	}
 
 	ret = crypto_register_shash(&alg);
 	if (!ret)
diff --git a/arch/x86/crypto/nhpoly1305-avx2-glue.c b/arch/x86/crypto/nhpoly1305-avx2-glue.c
index 2dc7b618771f..834bf64bb160 100644
--- a/arch/x86/crypto/nhpoly1305-avx2-glue.c
+++ b/arch/x86/crypto/nhpoly1305-avx2-glue.c
@@ -74,8 +74,10 @@ static int __init nhpoly1305_mod_init(void)
 		return -ENODEV;
 
 	if (!boot_cpu_has(X86_FEATURE_AVX2) ||
-	    !boot_cpu_has(X86_FEATURE_OSXSAVE))
+	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
+		pr_info("CPU-optimized crypto module not loaded, all required CPU features (AVX2, OSXSAVE) not supported\n");
 		return -ENODEV;
+	}
 
 	ret = crypto_register_shash(&nhpoly1305_alg);
 	if (!ret)
diff --git a/arch/x86/crypto/serpent_avx2_glue.c b/arch/x86/crypto/serpent_avx2_glue.c
index bf59addaf804..4bd59ccea69a 100644
--- a/arch/x86/crypto/serpent_avx2_glue.c
+++ b/arch/x86/crypto/serpent_avx2_glue.c
@@ -112,13 +112,15 @@ static int __init serpent_avx2_init(void)
 
 		return -ENODEV;
 
-	if (!boot_cpu_has(X86_FEATURE_AVX2) || !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
-		pr_info("AVX2 instructions are not detected.\n");
+	if (!boot_cpu_has(X86_FEATURE_AVX2) ||
+	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
+		pr_info("CPU-optimized crypto module not loaded, all required CPU features (AVX2, OSXSAVE) not supported\n");
 		return -ENODEV;
 	}
 	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
 				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
+		pr_info("CPU-optimized crypto module not loaded, CPU extended feature '%s' is not supported\n",
+			feature_name);
 		return -ENODEV;
 	}
 
diff --git a/arch/x86/crypto/serpent_avx_glue.c b/arch/x86/crypto/serpent_avx_glue.c
index 7b0c02a61552..853b48677d2b 100644
--- a/arch/x86/crypto/serpent_avx_glue.c
+++ b/arch/x86/crypto/serpent_avx_glue.c
@@ -121,7 +121,8 @@ static int __init serpent_init(void)
 
 	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
 				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
+		pr_info("CPU-optimized crypto module not loaded, CPU extended feature '%s' is not supported\n",
+			feature_name);
 		return -ENODEV;
 	}
 
diff --git a/arch/x86/crypto/sm3_avx_glue.c b/arch/x86/crypto/sm3_avx_glue.c
index 532f07b05745..5250fee79147 100644
--- a/arch/x86/crypto/sm3_avx_glue.c
+++ b/arch/x86/crypto/sm3_avx_glue.c
@@ -131,18 +131,19 @@ static int __init sm3_avx_mod_init(void)
 		return -ENODEV;
 
 	if (!boot_cpu_has(X86_FEATURE_AVX)) {
-		pr_info("AVX instruction are not detected.\n");
+		pr_info("CPU-optimized crypto module not loaded, required CPU feature (AVX) not supported\n");
 		return -ENODEV;
 	}
 
 	if (!boot_cpu_has(X86_FEATURE_BMI2)) {
-		pr_info("BMI2 instruction are not detected.\n");
+		pr_info("CPU-optimized crypto module not loaded, required CPU feature (BMI2) not supported\n");
 		return -ENODEV;
 	}
 
 	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
 				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
+		pr_info("CPU-optimized crypto module not loaded, CPU extended feature '%s' is not supported\n",
+			feature_name);
 		return -ENODEV;
 	}
 
diff --git a/arch/x86/crypto/sm4_aesni_avx2_glue.c b/arch/x86/crypto/sm4_aesni_avx2_glue.c
index 42819ee5d36d..cdd7ca92ca61 100644
--- a/arch/x86/crypto/sm4_aesni_avx2_glue.c
+++ b/arch/x86/crypto/sm4_aesni_avx2_glue.c
@@ -152,13 +152,14 @@ static int __init sm4_init(void)
 	    !boot_cpu_has(X86_FEATURE_AVX2) ||
 	    !boot_cpu_has(X86_FEATURE_AES) ||
 	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
-		pr_info("AVX2 or AES-NI instructions are not detected.\n");
+		pr_info("CPU-optimized crypto module not loaded, all required CPU features (AVX, AVX2, AESNI, OSXSAVE) not supported\n");
 		return -ENODEV;
 	}
 
 	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
 				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
+		pr_info("CPU-optimized crypto module not loaded, CPU extended feature '%s' is not supported\n",
+			feature_name);
 		return -ENODEV;
 	}
 
diff --git a/arch/x86/crypto/sm4_aesni_avx_glue.c b/arch/x86/crypto/sm4_aesni_avx_glue.c
index 8a25376d341f..a2ae3d1e0a4a 100644
--- a/arch/x86/crypto/sm4_aesni_avx_glue.c
+++ b/arch/x86/crypto/sm4_aesni_avx_glue.c
@@ -468,13 +468,14 @@ static int __init sm4_init(void)
 	if (!boot_cpu_has(X86_FEATURE_AVX) ||
 	    !boot_cpu_has(X86_FEATURE_AES) ||
 	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
-		pr_info("AVX or AES-NI instructions are not detected.\n");
+		pr_info("CPU-optimized crypto module not loaded, all required CPU features (AVX, AESNI, OSXSAVE) not supported\n");
 		return -ENODEV;
 	}
 
 	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
 				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
+		pr_info("CPU-optimized crypto module not loaded, CPU extended feature '%s' is not supported\n",
+			feature_name);
 		return -ENODEV;
 	}
 
diff --git a/arch/x86/crypto/twofish_avx_glue.c b/arch/x86/crypto/twofish_avx_glue.c
index ccf016bf6ef2..70167dd01816 100644
--- a/arch/x86/crypto/twofish_avx_glue.c
+++ b/arch/x86/crypto/twofish_avx_glue.c
@@ -123,7 +123,8 @@ static int __init twofish_init(void)
 		return -ENODEV;
 
 	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, &feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
+		pr_info("CPU-optimized crypto module not loaded, CPU extended feature '%s' is not supported\n",
+			feature_name);
 		return -ENODEV;
 	}
 
-- 
2.37.3

