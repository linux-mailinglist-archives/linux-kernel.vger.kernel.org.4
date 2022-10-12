Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C1E5FCDF8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiJLWBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJLWAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:00:32 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A285726C;
        Wed, 12 Oct 2022 15:00:17 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CGUv8R027242;
        Wed, 12 Oct 2022 22:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=+nE5VKyWUSEW08QSYxLtY7i4Gw38jTfKxO2sgAjNaZ0=;
 b=KzCk7OZduvaetOB2063hl/uSWKsOE7U5VUXfRM/HdmRdqgIw92enm50CxKmjqfnJT3/P
 d3ZIb5KHQ79gv1D0LRvFyF/E0YC/+FPCSgDNw57DoPis4MDDfe/Y6JkAVPFJ4fFByVMe
 rN0qCnLmEuIclTZiGeXCBkDwuEjvcgl6esotD4jGy5DIYGgaLQTSTRl/+vQ7VpAMq4gt
 UzQ1JCOn6FYKWwgmYhut4TkDVPVSnMcyzuWrDwcDYVYOblXPQV6/KNGxUlZN7W7ZmgTN
 WKDzX/i1258la1dmp9wBzzxHdVQAXphqHoSzKEI3lgS4UbNFFSTTTMyDujjh6qgn6fst 0A== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k615t2eqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 22:00:00 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id D03BD801AC0;
        Wed, 12 Oct 2022 21:59:59 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 75AC8800344;
        Wed, 12 Oct 2022 21:59:59 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 10/19] crypto: x86/sha1, sha256 - load based on CPU features
Date:   Wed, 12 Oct 2022 16:59:22 -0500
Message-Id: <20221012215931.3896-11-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012215931.3896-1-elliott@hpe.com>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MKcI_SpIQ6gI5fGSk5W54aFNBmuJTDxR
X-Proofpoint-ORIG-GUID: MKcI_SpIQ6gI5fGSk5W54aFNBmuJTDxR
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_11,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=952 lowpriorityscore=0 suspectscore=0 adultscore=0
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

Like commit aa031b8f702e ("crypto: x86/sha512 - load based on CPU
features"), add module aliases for x86-optimized crypto modules:
        sha1, sha256
based on CPU feature bits so udev gets a chance to load them later in
the boot process when the filesystems are all running.

This commit covers modules that created rcu stall issues
due to kernel_fpu_begin/kernel_fpu_end calls.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/sha1_ssse3_glue.c   | 13 +++++++++++++
 arch/x86/crypto/sha256_ssse3_glue.c | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/x86/crypto/sha1_ssse3_glue.c b/arch/x86/crypto/sha1_ssse3_glue.c
index a9f5779b41ca..edffc33bd12e 100644
--- a/arch/x86/crypto/sha1_ssse3_glue.c
+++ b/arch/x86/crypto/sha1_ssse3_glue.c
@@ -24,6 +24,7 @@
 #include <linux/types.h>
 #include <crypto/sha1.h>
 #include <crypto/sha1_base.h>
+#include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
 #define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
@@ -310,6 +311,15 @@ static int register_sha1_ni(void)
 	return 0;
 }
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_SHA_NI, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_AVX2, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_SSSE3, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static void unregister_sha1_ni(void)
 {
 	if (boot_cpu_has(X86_FEATURE_SHA_NI))
@@ -326,6 +336,9 @@ static int __init sha1_ssse3_mod_init(void)
 	if (register_sha1_ssse3())
 		goto fail;
 
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (register_sha1_avx()) {
 		unregister_sha1_ssse3();
 		goto fail;
diff --git a/arch/x86/crypto/sha256_ssse3_glue.c b/arch/x86/crypto/sha256_ssse3_glue.c
index 322c8aa907af..42e8cb1a6708 100644
--- a/arch/x86/crypto/sha256_ssse3_glue.c
+++ b/arch/x86/crypto/sha256_ssse3_glue.c
@@ -38,6 +38,7 @@
 #include <crypto/sha2.h>
 #include <crypto/sha256_base.h>
 #include <linux/string.h>
+#include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
 #define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
@@ -366,6 +367,15 @@ static struct shash_alg sha256_ni_algs[] = { {
 	}
 } };
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_SHA_NI, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_AVX2, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_SSSE3, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static int register_sha256_ni(void)
 {
 	if (boot_cpu_has(X86_FEATURE_SHA_NI))
@@ -388,6 +398,9 @@ static inline void unregister_sha256_ni(void) { }
 
 static int __init sha256_ssse3_mod_init(void)
 {
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (register_sha256_ssse3())
 		goto fail;
 
-- 
2.37.3

