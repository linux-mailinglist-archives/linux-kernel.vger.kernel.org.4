Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AD35FCE12
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJLWEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiJLWDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:03:44 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1F912C8A3;
        Wed, 12 Oct 2022 15:01:20 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CKwflC006339;
        Wed, 12 Oct 2022 21:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=pkIjY3xNYdD7u0iVrBec5NLvLKLYByXvLSfeEAPzOWA=;
 b=H/+AVupIA0qT3WW+ZAU2dM2Gj2l3wqwR0WsAa/VfsVsS5iNMLJC7y8Ht8zY9f5OvhkBx
 2yLbpwmj37y7COimS4bcYZXap7tWfA+f9jfIliFcbQ+513C5zXVqoqpMPMUKpaQZdv18
 hktdM2YGYo3tRFTVAi7YV1xAMWnSW89cLVpbAz4A923DrH/GUDNRl5Ld07SqTiP+PXvj
 VO8N9e4AHFDwKfHaVK05G3rZ6EdQ3Am7Xvyz8NwOIvIN/3DX0mQtHBM0ONsISnk24f22
 +trjHtXOEgf2mx27hfc02CqJehN6CTaOKRtBmoBwWIjCo4twBOe4dR3MxIan4xh9zojX PQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k653c8da7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 21:59:50 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 8611C806B5C;
        Wed, 12 Oct 2022 21:59:49 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 28602808ECE;
        Wed, 12 Oct 2022 21:59:49 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 04/19] crypto: x86/sha - limit FPU preemption
Date:   Wed, 12 Oct 2022 16:59:16 -0500
Message-Id: <20221012215931.3896-5-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012215931.3896-1-elliott@hpe.com>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Uwyq1NOSShnQQpJzF5T27vXCpBPm0wlx
X-Proofpoint-ORIG-GUID: Uwyq1NOSShnQQpJzF5T27vXCpBPm0wlx
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

As done by the ECB and CBC helpers in arch/x86/crypt/ecb_cbc_helpers.h,
limit the number of bytes processed between kernel_fpu_begin() and
kernel_fpu_end() calls.

Those functions call preempt_disable() and preempt_enable(), so
the CPU core is unavailable for scheduling while running.

This leads to "rcu_preempt detected expedited stalls" with stack dumps
pointing to the optimized hash function if the module is loaded and
used a lot:
    rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: ...

For example, that can occur during boot with the stack track pointing
to the sha512-x86 function if the system set to use SHA-512 for
module signing. The call trace includes:
    module_sig_check
    mod_verify_sig
    pkcs7_verify
    pkcs7_digest
    sha512_finup
    sha512_base_do_update

Fixes: 66be89515888 ("crypto: sha1 - SSSE3 based SHA1 implementation for x86-64")
Fixes: 8275d1aa6422 ("crypto: sha256 - Create module providing optimized SHA256 routines using SSSE3, AVX or AVX2 instructions.")
Fixes: 87de4579f92d ("crypto: sha512 - Create module providing optimized SHA512 routines using SSSE3, AVX or AVX2 instructions.")
Fixes: aa031b8f702e ("crypto: x86/sha512 - load based on CPU features")
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/sha1_ssse3_glue.c   | 32 ++++++++++++++++++++++++-----
 arch/x86/crypto/sha256_ssse3_glue.c | 32 ++++++++++++++++++++++++-----
 arch/x86/crypto/sha512_ssse3_glue.c | 32 ++++++++++++++++++++++++-----
 3 files changed, 81 insertions(+), 15 deletions(-)

diff --git a/arch/x86/crypto/sha1_ssse3_glue.c b/arch/x86/crypto/sha1_ssse3_glue.c
index 44340a1139e0..a9f5779b41ca 100644
--- a/arch/x86/crypto/sha1_ssse3_glue.c
+++ b/arch/x86/crypto/sha1_ssse3_glue.c
@@ -26,6 +26,8 @@
 #include <crypto/sha1_base.h>
 #include <asm/simd.h>
 
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+
 static int sha1_update(struct shash_desc *desc, const u8 *data,
 			     unsigned int len, sha1_block_fn *sha1_xform)
 {
@@ -41,9 +43,18 @@ static int sha1_update(struct shash_desc *desc, const u8 *data,
 	 */
 	BUILD_BUG_ON(offsetof(struct sha1_state, state) != 0);
 
-	kernel_fpu_begin();
-	sha1_base_do_update(desc, data, len, sha1_xform);
-	kernel_fpu_end();
+	do {
+		unsigned int chunk = min(len, FPU_BYTES);
+
+		if (chunk) {
+			kernel_fpu_begin();
+			sha1_base_do_update(desc, data, chunk, sha1_xform);
+			kernel_fpu_end();
+		}
+
+		len -= chunk;
+		data += chunk;
+	} while (len);
 
 	return 0;
 }
@@ -54,9 +65,20 @@ static int sha1_finup(struct shash_desc *desc, const u8 *data,
 	if (!crypto_simd_usable())
 		return crypto_sha1_finup(desc, data, len, out);
 
+	do {
+		unsigned int chunk = min(len, FPU_BYTES);
+
+		if (chunk) {
+			kernel_fpu_begin();
+			sha1_base_do_update(desc, data, chunk, sha1_xform);
+			kernel_fpu_end();
+		}
+
+		len -= chunk;
+		data += chunk;
+	} while (len);
+
 	kernel_fpu_begin();
-	if (len)
-		sha1_base_do_update(desc, data, len, sha1_xform);
 	sha1_base_do_finalize(desc, sha1_xform);
 	kernel_fpu_end();
 
diff --git a/arch/x86/crypto/sha256_ssse3_glue.c b/arch/x86/crypto/sha256_ssse3_glue.c
index 3a5f6be7dbba..322c8aa907af 100644
--- a/arch/x86/crypto/sha256_ssse3_glue.c
+++ b/arch/x86/crypto/sha256_ssse3_glue.c
@@ -40,6 +40,8 @@
 #include <linux/string.h>
 #include <asm/simd.h>
 
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+
 asmlinkage void sha256_transform_ssse3(struct sha256_state *state,
 				       const u8 *data, int blocks);
 
@@ -58,9 +60,18 @@ static int _sha256_update(struct shash_desc *desc, const u8 *data,
 	 */
 	BUILD_BUG_ON(offsetof(struct sha256_state, state) != 0);
 
-	kernel_fpu_begin();
-	sha256_base_do_update(desc, data, len, sha256_xform);
-	kernel_fpu_end();
+	do {
+		unsigned int chunk = min(len, FPU_BYTES);
+
+		if (chunk) {
+			kernel_fpu_begin();
+			sha256_base_do_update(desc, data, chunk, sha256_xform);
+			kernel_fpu_end();
+		}
+
+		len -= chunk;
+		data += chunk;
+	} while (len);
 
 	return 0;
 }
@@ -71,9 +82,20 @@ static int sha256_finup(struct shash_desc *desc, const u8 *data,
 	if (!crypto_simd_usable())
 		return crypto_sha256_finup(desc, data, len, out);
 
+	do {
+		unsigned int chunk = min(len, FPU_BYTES);
+
+		if (chunk) {
+			kernel_fpu_begin();
+			sha256_base_do_update(desc, data, chunk, sha256_xform);
+			kernel_fpu_end();
+		}
+
+		len -= chunk;
+		data += chunk;
+	} while (len);
+
 	kernel_fpu_begin();
-	if (len)
-		sha256_base_do_update(desc, data, len, sha256_xform);
 	sha256_base_do_finalize(desc, sha256_xform);
 	kernel_fpu_end();
 
diff --git a/arch/x86/crypto/sha512_ssse3_glue.c b/arch/x86/crypto/sha512_ssse3_glue.c
index 6d3b85e53d0e..fd5075a32613 100644
--- a/arch/x86/crypto/sha512_ssse3_glue.c
+++ b/arch/x86/crypto/sha512_ssse3_glue.c
@@ -39,6 +39,8 @@
 #include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+
 asmlinkage void sha512_transform_ssse3(struct sha512_state *state,
 				       const u8 *data, int blocks);
 
@@ -57,9 +59,18 @@ static int sha512_update(struct shash_desc *desc, const u8 *data,
 	 */
 	BUILD_BUG_ON(offsetof(struct sha512_state, state) != 0);
 
-	kernel_fpu_begin();
-	sha512_base_do_update(desc, data, len, sha512_xform);
-	kernel_fpu_end();
+	do {
+		unsigned int chunk = min(len, FPU_BYTES);
+
+		if (chunk) {
+			kernel_fpu_begin();
+			sha512_base_do_update(desc, data, chunk, sha512_xform);
+			kernel_fpu_end();
+		}
+
+		len -= chunk;
+		data += chunk;
+	} while (len);
 
 	return 0;
 }
@@ -70,9 +81,20 @@ static int sha512_finup(struct shash_desc *desc, const u8 *data,
 	if (!crypto_simd_usable())
 		return crypto_sha512_finup(desc, data, len, out);
 
+	do {
+		unsigned int chunk = min(len, FPU_BYTES);
+
+		if (chunk) {
+			kernel_fpu_begin();
+			sha512_base_do_update(desc, data, chunk, sha512_xform);
+			kernel_fpu_end();
+		}
+
+		len -= chunk;
+		data += chunk;
+	} while (len);
+
 	kernel_fpu_begin();
-	if (len)
-		sha512_base_do_update(desc, data, len, sha512_xform);
 	sha512_base_do_finalize(desc, sha512_xform);
 	kernel_fpu_end();
 
-- 
2.37.3

