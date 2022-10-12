Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB255FCDF6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJLWBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiJLWAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:00:30 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE8B42E7C;
        Wed, 12 Oct 2022 15:00:12 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CKwnKK007661;
        Wed, 12 Oct 2022 21:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=hdZBxgZ/TUVLMXZM2B/5tdVJYyvU0kV133lw76XKM8w=;
 b=PY7mnfOtlfIXFa4yUUY0tZviVcH/bFeyu3JBG6VGqXNQw1sfRWRcxaLVZyLmS2IrtQfz
 WVbnPSsUpjspFG1WKDsSh1Qw917II0pkRLzWUzNpG8WaEYECgzxxpyZBtclU5W7aXdND
 YyTWFu1fVJgUBCXAqrKo0Q5K/D8U6H83oEydtgDMlcPFONrhOvJMBJiup7h1ijEuSqVU
 MLFtqABpE3a8WAYQDRwu4uMQMZPoN6k8Qhe+Tf1oT67G9ej96Ukm8WCiO7Cy5BGBXHdf
 Xi8WHckpBkZCL7da+O1k77EX1gx+5T17F/OFBtLAto9aNJ6s27T/02BCC6tRjEkBNmt5 Qw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k653c8dba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 21:59:59 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 29CD513966;
        Wed, 12 Oct 2022 21:59:57 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id C24208036BF;
        Wed, 12 Oct 2022 21:59:56 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 08/19] crypto: x86/ghash - limit FPU preemption
Date:   Wed, 12 Oct 2022 16:59:20 -0500
Message-Id: <20221012215931.3896-9-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012215931.3896-1-elliott@hpe.com>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GN3sVZsnEFkLjRI-H6zI7Felq_M5_ziE
X-Proofpoint-ORIG-GUID: GN3sVZsnEFkLjRI-H6zI7Felq_M5_ziE
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
the CPU core is unavailable for scheduling while running, leading to:
    rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: ...

Fixes: 0e1227d356e9 ("crypto: ghash - Add PCLMULQDQ accelerated implementation")
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/ghash-clmulni-intel_glue.c | 26 ++++++++++++++++------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/x86/crypto/ghash-clmulni-intel_glue.c b/arch/x86/crypto/ghash-clmulni-intel_glue.c
index 53aa286ec27f..a39fc405c7cf 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_glue.c
+++ b/arch/x86/crypto/ghash-clmulni-intel_glue.c
@@ -23,6 +23,8 @@
 #define GHASH_BLOCK_SIZE	16
 #define GHASH_DIGEST_SIZE	16
 
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+
 void clmul_ghash_mul(char *dst, const u128 *shash);
 
 void clmul_ghash_update(char *dst, const char *src, unsigned int srclen,
@@ -82,7 +84,7 @@ static int ghash_update(struct shash_desc *desc,
 
 	if (dctx->bytes) {
 		int n = min(srclen, dctx->bytes);
-		u8 *pos = dst + (GHASH_BLOCK_SIZE - dctx->bytes);
+		u8 *pos = dst + GHASH_BLOCK_SIZE - dctx->bytes;
 
 		dctx->bytes -= n;
 		srclen -= n;
@@ -97,13 +99,23 @@ static int ghash_update(struct shash_desc *desc,
 		}
 	}
 
-	kernel_fpu_begin();
-	clmul_ghash_update(dst, src, srclen, &ctx->shash);
-	kernel_fpu_end();
+	while (srclen >= GHASH_BLOCK_SIZE) {
+		unsigned int fpulen = min(srclen, FPU_BYTES);
+
+		kernel_fpu_begin();
+		while (fpulen >= GHASH_BLOCK_SIZE) {
+			int n = min_t(unsigned int, fpulen, GHASH_BLOCK_SIZE);
+
+			clmul_ghash_update(dst, src, n, &ctx->shash);
+
+			srclen -= n;
+			fpulen -= n;
+			src += n;
+		}
+		kernel_fpu_end();
+	}
 
-	if (srclen & 0xf) {
-		src += srclen - (srclen & 0xf);
-		srclen &= 0xf;
+	if (srclen) {
 		dctx->bytes = GHASH_BLOCK_SIZE - srclen;
 		while (srclen--)
 			*dst++ ^= *src++;
-- 
2.37.3

