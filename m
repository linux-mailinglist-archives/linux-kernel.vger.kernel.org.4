Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DBF62B236
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 05:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbiKPEP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 23:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKPEOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 23:14:32 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561163205E;
        Tue, 15 Nov 2022 20:14:25 -0800 (PST)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG3Zd6V015695;
        Wed, 16 Nov 2022 04:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=cTzqPQFdhTvUVOcsBjcnPT2NWlxFqM19tqppsEYjuYM=;
 b=gG3oz65q2sA8UpQnUKLlfZu9X3sSK8E6WnisyHzRLbbdryTKn++4uqJg2Q21hi80yHYl
 6T5GDkhbneJerWV5h27PFn0c176350ZaY8kI886qTKzqU7/aKdIaVHrtEwarGm+TwF9u
 zWLXpyvfIUf9cMS70MU6xv49SkIYoL/lFD2JNuc91i+UHeEdTZljrp3rul/cS3SvLLtY
 ISM1d5ZcxPrGMLXlQgPRocsZPer0gftY1flBACb6mrxoS6m4/U8COWf/XJ05n4pcl8OK
 7CN+EmjMQxj6h9MUJHOtl5rY4+1fzxdtKS+C5UJuJlaqxlmB4R+dBRHNmadpVeGtXAVP XQ== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3kvqkbreg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 04:14:14 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 0A42A4B5C9;
        Wed, 16 Nov 2022 04:14:14 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 8E539808BA4;
        Wed, 16 Nov 2022 04:14:13 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v4 17/24] crypto: x86/poly - load based on CPU features
Date:   Tue, 15 Nov 2022 22:13:35 -0600
Message-Id: <20221116041342.3841-18-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116041342.3841-1-elliott@hpe.com>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SD-tb7NqfoFHqzT8wvROtWvqBdLg81oS
X-Proofpoint-ORIG-GUID: SD-tb7NqfoFHqzT8wvROtWvqBdLg81oS
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

Like commit aa031b8f702e ("crypto: x86/sha512 - load based on CPU
features"), these x86-optimized crypto modules already have
module aliases based on CPU feature bits:
    nhpoly1305
    poly1305
    polyval

Rename the unique device table data structure to a generic name
so the code has the same pattern in all the modules.

Remove the __maybe_unused attribute from polyval since it is
always used.

Signed-off-by: Robert Elliott <elliott@hpe.com>

---
v4 Removed CPU feature checks that are unreachable because
   the x86_match_cpu call already handles them.

   Made poly1305 match on all features since it does provide
   an x86_64 asm function if avx, avx2, and avx512f are not
   available.

   Move polyval into this patch rather than pair with ghash.

   Remove __maybe_unused from polyval.
---
 arch/x86/crypto/nhpoly1305-avx2-glue.c | 13 +++++++++++--
 arch/x86/crypto/nhpoly1305-sse2-glue.c |  9 ++++++++-
 arch/x86/crypto/poly1305_glue.c        | 10 ++++++++++
 arch/x86/crypto/polyval-clmulni_glue.c |  6 +++---
 4 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/x86/crypto/nhpoly1305-avx2-glue.c b/arch/x86/crypto/nhpoly1305-avx2-glue.c
index f7dc9c563bb5..fa415fec5793 100644
--- a/arch/x86/crypto/nhpoly1305-avx2-glue.c
+++ b/arch/x86/crypto/nhpoly1305-avx2-glue.c
@@ -11,6 +11,7 @@
 #include <crypto/nhpoly1305.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
+#include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
 /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
@@ -60,10 +61,18 @@ static struct shash_alg nhpoly1305_alg = {
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
-	if (!boot_cpu_has(X86_FEATURE_AVX2) ||
-	    !boot_cpu_has(X86_FEATURE_OSXSAVE))
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
+	if (!boot_cpu_has(X86_FEATURE_OSXSAVE))
 		return -ENODEV;
 
 	return crypto_register_shash(&nhpoly1305_alg);
diff --git a/arch/x86/crypto/nhpoly1305-sse2-glue.c b/arch/x86/crypto/nhpoly1305-sse2-glue.c
index daffcc7019ad..c47765e46236 100644
--- a/arch/x86/crypto/nhpoly1305-sse2-glue.c
+++ b/arch/x86/crypto/nhpoly1305-sse2-glue.c
@@ -11,6 +11,7 @@
 #include <crypto/nhpoly1305.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
+#include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
 /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
@@ -60,9 +61,15 @@ static struct shash_alg nhpoly1305_alg = {
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
-	if (!boot_cpu_has(X86_FEATURE_XMM2))
+	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
 	return crypto_register_shash(&nhpoly1305_alg);
diff --git a/arch/x86/crypto/poly1305_glue.c b/arch/x86/crypto/poly1305_glue.c
index 16831c036d71..f1e39e23b2a3 100644
--- a/arch/x86/crypto/poly1305_glue.c
+++ b/arch/x86/crypto/poly1305_glue.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
+#include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/simd.h>
 
@@ -268,8 +269,17 @@ static struct shash_alg alg = {
 	},
 };
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_ANY, NULL),
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
diff --git a/arch/x86/crypto/polyval-clmulni_glue.c b/arch/x86/crypto/polyval-clmulni_glue.c
index de1c908f7412..b98e32f8e2a4 100644
--- a/arch/x86/crypto/polyval-clmulni_glue.c
+++ b/arch/x86/crypto/polyval-clmulni_glue.c
@@ -176,15 +176,15 @@ static struct shash_alg polyval_alg = {
 	},
 };
 
-__maybe_unused static const struct x86_cpu_id pcmul_cpu_id[] = {
+static const struct x86_cpu_id module_cpu_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_PCLMULQDQ, NULL),
 	{}
 };
-MODULE_DEVICE_TABLE(x86cpu, pcmul_cpu_id);
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
 
 static int __init polyval_clmulni_mod_init(void)
 {
-	if (!x86_match_cpu(pcmul_cpu_id))
+	if (!x86_match_cpu(module_cpu_ids))
 		return -ENODEV;
 
 	if (!boot_cpu_has(X86_FEATURE_AVX))
-- 
2.38.1

