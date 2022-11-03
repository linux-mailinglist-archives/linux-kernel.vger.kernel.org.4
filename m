Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25008617596
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiKCEaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiKCE3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:29:32 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E10211A0E;
        Wed,  2 Nov 2022 21:28:43 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A30jDjk010497;
        Thu, 3 Nov 2022 04:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=JZPdVhi4LuEFBoclA7AVxB12a7DjlsW/T2E4udvE+wc=;
 b=pAi/VWKf5eteGEOJQrk6RCvNI+dQVb3F3/jjFE3PFJVGdPCaDWxNoaf1oPuwZWNJMsqq
 255r3136kSC0+YShaH0ekSHiAi0d6/pm7ZXU34NWng1dngzh+1jGrMslXZYNqnMjU/HM
 6xkaaNKhQy3XMwOt4K/ZZyZqiWTOJWXhojxwVgaiO2xRItBS7yf+KkfoF/HgyhELNoy6
 S3UX/FeUp+mAGhlCLr+UYYqK1y+tIXlvqi5ZqPZp1MEFDOtlfLR7iHC1M+dhNgwezyLV
 63DUag1SN/igq/xbJFbEUzF+g1wbphztbck5ExdN3OSkm9asM+iLpa/DkEM5E2Le2lyP HA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kkvxsc1px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 04:28:22 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id E39ED804722;
        Thu,  3 Nov 2022 04:28:21 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 70C7A808EB4;
        Thu,  3 Nov 2022 04:28:21 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 13/17] crypto: x86/sha1, sha256 - load based on CPU features
Date:   Wed,  2 Nov 2022 23:27:36 -0500
Message-Id: <20221103042740.6556-14-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221103042740.6556-1-elliott@hpe.com>
References: <20221012215931.3896-1-elliott@hpe.com>
 <20221103042740.6556-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jqAOFoThLNkvOvl7CBCA1bm1G-sdLHyl
X-Proofpoint-GUID: jqAOFoThLNkvOvl7CBCA1bm1G-sdLHyl
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
        sha1, sha256
based on CPU feature bits so udev gets a chance to load them later in
the boot process when the filesystems are all running.

Signed-off-by: Robert Elliott <elliott@hpe.com>

---
v3 put device table SHA_NI entries inside CONFIG_SHAn_NI ifdefs,
ensure builds properly with arch/x86/Kconfig.assembler changed
to not set CONFIG_AS_SHA*_NI
---
 arch/x86/crypto/sha1_ssse3_glue.c   | 15 +++++++++++++++
 arch/x86/crypto/sha256_ssse3_glue.c | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/x86/crypto/sha1_ssse3_glue.c b/arch/x86/crypto/sha1_ssse3_glue.c
index cd390083451f..7269beaa9291 100644
--- a/arch/x86/crypto/sha1_ssse3_glue.c
+++ b/arch/x86/crypto/sha1_ssse3_glue.c
@@ -24,6 +24,7 @@
 #include <linux/types.h>
 #include <crypto/sha1.h>
 #include <crypto/sha1_base.h>
+#include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
 /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
@@ -326,12 +327,26 @@ static void unregister_sha1_ni(void)
 static inline void unregister_sha1_ni(void) { }
 #endif
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+#ifdef CONFIG_AS_SHA1_NI
+	X86_MATCH_FEATURE(X86_FEATURE_SHA_NI, NULL),
+#endif
+	X86_MATCH_FEATURE(X86_FEATURE_AVX2, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_SSSE3, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static int __init sha1_ssse3_mod_init(void)
 {
 	const char *feature_name;
 	const char *driver_name = NULL;
 	int ret;
 
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 #ifdef CONFIG_AS_SHA1_NI
 	/* SHA-NI */
 	if (boot_cpu_has(X86_FEATURE_SHA_NI)) {
diff --git a/arch/x86/crypto/sha256_ssse3_glue.c b/arch/x86/crypto/sha256_ssse3_glue.c
index 692d6f010a4d..5ce42f1d228b 100644
--- a/arch/x86/crypto/sha256_ssse3_glue.c
+++ b/arch/x86/crypto/sha256_ssse3_glue.c
@@ -38,6 +38,7 @@
 #include <crypto/sha2.h>
 #include <crypto/sha256_base.h>
 #include <linux/string.h>
+#include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
 /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
@@ -397,6 +398,17 @@ static void unregister_sha256_ni(void)
 static inline void unregister_sha256_ni(void) { }
 #endif
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+#ifdef CONFIG_AS_SHA256_NI
+	X86_MATCH_FEATURE(X86_FEATURE_SHA_NI, NULL),
+#endif
+	X86_MATCH_FEATURE(X86_FEATURE_AVX2, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_SSSE3, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static int __init sha256_ssse3_mod_init(void)
 {
 	const char *feature_name;
@@ -404,6 +416,9 @@ static int __init sha256_ssse3_mod_init(void)
 	const char *driver_name2 = NULL;
 	int ret;
 
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 #ifdef CONFIG_AS_SHA256_NI
 	/* SHA-NI */
 	if (boot_cpu_has(X86_FEATURE_SHA_NI)) {
-- 
2.37.3

