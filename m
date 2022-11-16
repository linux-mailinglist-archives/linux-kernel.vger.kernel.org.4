Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1CA62B22F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 05:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiKPEPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 23:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiKPEOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 23:14:21 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9CD31EF2;
        Tue, 15 Nov 2022 20:14:18 -0800 (PST)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG3Ncm7026856;
        Wed, 16 Nov 2022 04:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=DZaqRBDQdjwv0XB4GveGfUUF/gpHvXgfa3E0Wxb3Tbk=;
 b=cyCS6uANQ22abyg9phMfFgKUTy3CpaXUj5VAcgX3cTEZbsoCBDPfNjrec2g6WRlzqf2G
 8N3M1lz/M7X87H82kSx19icCEFOq0U8HX5C/xPt7JEp2dvIcy80O12TezdTfduFO/FIP
 fiNaGEGs5lQym+u5hYjoYM7QJmMiurOHODMIPrJ7LLjXfChIKfSTcxN1iZcYQp/RlX/n
 HUjDBgpy9ZYSM7nJd+4w+xvi7EXait7UQJrmRpPZUkpmrSWYb20Hh9hT6gLbM8lK1vQv
 PVGLo/VSxjk+CRMSR2jY3SlRPRGDJogtl3lqNazF3QkzcT8+HhfYUmUv31fhLT4Jl4Wt 6Q== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kvqwqgaaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 04:14:01 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 9DE474B5CE;
        Wed, 16 Nov 2022 04:14:00 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 273A38065DB;
        Wed, 16 Nov 2022 04:14:00 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v4 06/24] crypto: x86/sm3 - limit FPU preemption
Date:   Tue, 15 Nov 2022 22:13:24 -0600
Message-Id: <20221116041342.3841-7-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116041342.3841-1-elliott@hpe.com>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: d93n2GK0Nadv8dJmFx5k8lFZAwdQ3ekB
X-Proofpoint-GUID: d93n2GK0Nadv8dJmFx5k8lFZAwdQ3ekB
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211160029
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Limit the number of bytes processed between kernel_fpu_begin() and
kernel_fpu_end() calls.

Those functions call preempt_disable() and preempt_enable(), so
the CPU core is unavailable for scheduling while running, causing:
    rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: ...

Fixes: 930ab34d906d ("crypto: x86/sm3 - add AVX assembly implementation")
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Robert Elliott <elliott@hpe.com>

---
v3 use while loop, static int
---
 arch/x86/crypto/sm3_avx_glue.c | 35 ++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/x86/crypto/sm3_avx_glue.c b/arch/x86/crypto/sm3_avx_glue.c
index 661b6f22ffcd..483aaed996ba 100644
--- a/arch/x86/crypto/sm3_avx_glue.c
+++ b/arch/x86/crypto/sm3_avx_glue.c
@@ -17,6 +17,9 @@
 #include <crypto/sm3_base.h>
 #include <asm/simd.h>
 
+/* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+static const unsigned int bytes_per_fpu = 11 * 1024;
+
 asmlinkage void sm3_transform_avx(struct sm3_state *state,
 			const u8 *data, int nblocks);
 
@@ -25,8 +28,10 @@ static int sm3_avx_update(struct shash_desc *desc, const u8 *data,
 {
 	struct sm3_state *sctx = shash_desc_ctx(desc);
 
+	BUILD_BUG_ON(bytes_per_fpu == 0);
+
 	if (!crypto_simd_usable() ||
-			(sctx->count % SM3_BLOCK_SIZE) + len < SM3_BLOCK_SIZE) {
+	    (sctx->count % SM3_BLOCK_SIZE) + len < SM3_BLOCK_SIZE) {
 		sm3_update(sctx, data, len);
 		return 0;
 	}
@@ -37,9 +42,16 @@ static int sm3_avx_update(struct shash_desc *desc, const u8 *data,
 	 */
 	BUILD_BUG_ON(offsetof(struct sm3_state, state) != 0);
 
-	kernel_fpu_begin();
-	sm3_base_do_update(desc, data, len, sm3_transform_avx);
-	kernel_fpu_end();
+	while (len) {
+		unsigned int chunk = min(len, bytes_per_fpu);
+
+		kernel_fpu_begin();
+		sm3_base_do_update(desc, data, chunk, sm3_transform_avx);
+		kernel_fpu_end();
+
+		len -= chunk;
+		data += chunk;
+	}
 
 	return 0;
 }
@@ -47,6 +59,8 @@ static int sm3_avx_update(struct shash_desc *desc, const u8 *data,
 static int sm3_avx_finup(struct shash_desc *desc, const u8 *data,
 		      unsigned int len, u8 *out)
 {
+	BUILD_BUG_ON(bytes_per_fpu == 0);
+
 	if (!crypto_simd_usable()) {
 		struct sm3_state *sctx = shash_desc_ctx(desc);
 
@@ -57,9 +71,18 @@ static int sm3_avx_finup(struct shash_desc *desc, const u8 *data,
 		return 0;
 	}
 
+	while (len) {
+		unsigned int chunk = min(len, bytes_per_fpu);
+
+		kernel_fpu_begin();
+		sm3_base_do_update(desc, data, chunk, sm3_transform_avx);
+		kernel_fpu_end();
+
+		len -= chunk;
+		data += chunk;
+	}
+
 	kernel_fpu_begin();
-	if (len)
-		sm3_base_do_update(desc, data, len, sm3_transform_avx);
 	sm3_base_do_finalize(desc, sm3_transform_avx);
 	kernel_fpu_end();
 
-- 
2.38.1

