Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7360F617591
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiKCEaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiKCE3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:29:04 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E24617A8E;
        Wed,  2 Nov 2022 21:28:35 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A33VbuI014797;
        Thu, 3 Nov 2022 04:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=G7u1zUhzEy2Z3v9+f98yVaQ73+U2QkY+yVwx1BjgOZE=;
 b=HLKouWUMYSWw7quRf3qPuFiXZblLqMTPqpxKEJhH0YseFfrq34bXknRLDWqsk2YFuB+M
 r3shCI+TQ9I7+vybntd4lkHcUHwctFcTE52WoI6ijEdXqtWLuiQo+S4Z1zC/q5lo6MtL
 2aMmzVdHPLqV1i39WWg1306vsR1DnRkjLSzu6y2v9v2LISIEYRy5qGBKnZZLRSryqnVj
 tz1k9pOQMgJkVmhp2ftwtindcywpbrb1BvZd5pB0eRI3CiZVOhw186Ika4TBA8lh3dho
 rq8yEmuyC/BtmT3tFb+qJpOdU0kKcQ0vOCeUNdleUbnofc9pfesaCptRk+KyPvgGgXf2 EQ== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3km5tn8a1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 04:28:28 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 055FD80472B;
        Thu,  3 Nov 2022 04:28:28 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 85C0D808EB8;
        Thu,  3 Nov 2022 04:28:27 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 17/17] crypto: x86/nhpoly1305, poly1305 - load based on CPU features
Date:   Wed,  2 Nov 2022 23:27:40 -0500
Message-Id: <20221103042740.6556-18-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221103042740.6556-1-elliott@hpe.com>
References: <20221012215931.3896-1-elliott@hpe.com>
 <20221103042740.6556-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LvU7jicmIURC_DCUpBkpWM2HsYBXp38r
X-Proofpoint-ORIG-GUID: LvU7jicmIURC_DCUpBkpWM2HsYBXp38r
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030031
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like commit aa031b8f702e ("crypto: x86/sha512 - load based on CPU
features"), add module aliases for x86-optimized crypto modules:
    nhpoly1305, poly1305
based on CPU feature bits so udev gets a chance to load them later
in the boot process when the filesystems are all running.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/nhpoly1305-avx2-glue.c | 10 ++++++++++
 arch/x86/crypto/nhpoly1305-sse2-glue.c | 10 ++++++++++
 arch/x86/crypto/poly1305_glue.c        | 12 ++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/arch/x86/crypto/nhpoly1305-avx2-glue.c b/arch/x86/crypto/nhpoly1305-avx2-glue.c
index f7dc9c563bb5..15f98b53bfda 100644
--- a/arch/x86/crypto/nhpoly1305-avx2-glue.c
+++ b/arch/x86/crypto/nhpoly1305-avx2-glue.c
@@ -11,6 +11,7 @@
 #include <crypto/nhpoly1305.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
+#include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
 /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
@@ -60,8 +61,17 @@ static struct shash_alg nhpoly1305_alg = {
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
index daffcc7019ad..533db3e0e06f 100644
--- a/arch/x86/crypto/nhpoly1305-sse2-glue.c
+++ b/arch/x86/crypto/nhpoly1305-sse2-glue.c
@@ -11,6 +11,7 @@
 #include <crypto/nhpoly1305.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
+#include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
 /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
@@ -60,8 +61,17 @@ static struct shash_alg nhpoly1305_alg = {
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
index 16831c036d71..2ff4358e4b3f 100644
--- a/arch/x86/crypto/poly1305_glue.c
+++ b/arch/x86/crypto/poly1305_glue.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
+#include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/simd.h>
 
@@ -268,8 +269,19 @@ static struct shash_alg alg = {
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
-- 
2.37.3

