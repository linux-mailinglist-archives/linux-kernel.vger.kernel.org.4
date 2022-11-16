Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A8962B231
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 05:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbiKPEPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 23:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiKPEOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 23:14:24 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D687131ED3;
        Tue, 15 Nov 2022 20:14:19 -0800 (PST)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG3W9QC000909;
        Wed, 16 Nov 2022 04:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=u6FAcp+6tcSEs7tXNY3uZohFs8We5u80NlPyFDCPC14=;
 b=DItwDFUl/bic1tiBntP4bMAn2guCdy9fLGcCa7uN3s1IhXZzVXdvefc/EVOQ2ehkDeUQ
 P/gIoj01snvR+lvaXJC6+6f5DjJu1u7Rpv0GgHfCQVRmK1kvHLLyUtTt5tS2eQe4erbA
 vA0RCaRyUigcInzPwbAEJ+MOvzFL3Cd4CknTb5Rg74zqDoSluU1Og2veHmwnuY4zXiHK
 opcmVsR3CxvPauqdYSYaJBW3bS7MeMmbIWV5+rmseXiEdziax3iWTcc7S5mg5fpcPxPJ
 9EF9mAh0FnH44EYvPVhxaD19R1p3Pu2ZPbFv6OUFB5nEmOQVXqEWOnoMZbfuYUsY90xy zw== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kvqy689qj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 04:14:04 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id D55C8809F55;
        Wed, 16 Nov 2022 04:14:03 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 5FAAA808B9A;
        Wed, 16 Nov 2022 04:14:03 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v4 09/24] crypto: x86/ghash - limit FPU preemption
Date:   Tue, 15 Nov 2022 22:13:27 -0600
Message-Id: <20221116041342.3841-10-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116041342.3841-1-elliott@hpe.com>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6rRm_cgmG3Ha27Vq-sgF0mf9Hgjvp0OZ
X-Proofpoint-GUID: 6rRm_cgmG3Ha27Vq-sgF0mf9Hgjvp0OZ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160029
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
the CPU core is unavailable for scheduling while running, leading to:
    rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: ...

Fixes: 0e1227d356e9 ("crypto: ghash - Add PCLMULQDQ accelerated implementation")
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Robert Elliott <elliott@hpe.com>

---
v3 change to static int, simplify while loop
---
 arch/x86/crypto/ghash-clmulni-intel_glue.c | 28 +++++++++++++++-------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/x86/crypto/ghash-clmulni-intel_glue.c b/arch/x86/crypto/ghash-clmulni-intel_glue.c
index 22367e363d72..0f24c3b23fd2 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_glue.c
+++ b/arch/x86/crypto/ghash-clmulni-intel_glue.c
@@ -20,8 +20,11 @@
 #include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
-#define GHASH_BLOCK_SIZE	16
-#define GHASH_DIGEST_SIZE	16
+#define GHASH_BLOCK_SIZE	16U
+#define GHASH_DIGEST_SIZE	16U
+
+/* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+static const unsigned int bytes_per_fpu = 50 * 1024;
 
 void clmul_ghash_mul(u8 *dst, const u128 *shash);
 
@@ -80,9 +83,11 @@ static int ghash_update(struct shash_desc *desc,
 	struct ghash_ctx *ctx = crypto_shash_ctx(desc->tfm);
 	u8 *dst = dctx->buffer;
 
+	BUILD_BUG_ON(bytes_per_fpu < GHASH_BLOCK_SIZE);
+
 	if (dctx->bytes) {
 		int n = min(srclen, dctx->bytes);
-		u8 *pos = dst + (GHASH_BLOCK_SIZE - dctx->bytes);
+		u8 *pos = dst + GHASH_BLOCK_SIZE - dctx->bytes;
 
 		dctx->bytes -= n;
 		srclen -= n;
@@ -97,13 +102,18 @@ static int ghash_update(struct shash_desc *desc,
 		}
 	}
 
-	kernel_fpu_begin();
-	clmul_ghash_update(dst, src, srclen, &ctx->shash);
-	kernel_fpu_end();
+	while (srclen >= GHASH_BLOCK_SIZE) {
+		unsigned int chunk = min(srclen, bytes_per_fpu);
+
+		kernel_fpu_begin();
+		clmul_ghash_update(dst, src, chunk, &ctx->shash);
+		kernel_fpu_end();
+
+		src += chunk & ~(GHASH_BLOCK_SIZE - 1);
+		srclen -= chunk & ~(GHASH_BLOCK_SIZE - 1);
+	}
 
-	if (srclen & 0xf) {
-		src += srclen - (srclen & 0xf);
-		srclen &= 0xf;
+	if (srclen) {
 		dctx->bytes = GHASH_BLOCK_SIZE - srclen;
 		while (srclen--)
 			*dst++ ^= *src++;
-- 
2.38.1

