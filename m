Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BB25F712A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 00:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiJFWct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 18:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiJFWcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:32:32 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251FFF1937;
        Thu,  6 Oct 2022 15:32:32 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296HWkvY000808;
        Thu, 6 Oct 2022 22:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=t163V27LVije1BDnig0VkhCY7/r4gwdWvV8VjbL84sE=;
 b=ORfCnLE5VzKy/OqP5HWtp+gHNQEl1WAdJR2ymgtBN9G0y4EA4rhp51XrhDbWQsn1j9q5
 cOXi9wnbGY5r5DElGxknqnZ26hO6X4fvt6FqKZbPnBpJvT3ifGqW8mr17e5UuHhawPa4
 ecutpGh5oXqPYZzZua4NIHnEpnpqzzb87FJqCVEcbQCWPgdt7S9hej04k+JL5vZicPs5
 ge1l9ffS/F2S1jxUEZQzaNKQKUzRoLPTztJIb/xhiCELk/tVGgwmJRxF5/cw4dscw04n
 dqQuAmOymQqyCbGePeegx1jE3aqsBq301qI4jSr4ml5bbm/tQR767xp5zijJDsn/jNNW ng== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3k23gtudem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 22:32:29 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id D3BB0806B41;
        Thu,  6 Oct 2022 22:32:28 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 80EBD8038CA;
        Thu,  6 Oct 2022 22:32:28 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [RFC PATCH 6/7] crypto: x86/ghash - limit FPU preemption
Date:   Thu,  6 Oct 2022 17:31:50 -0500
Message-Id: <20221006223151.22159-7-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221006223151.22159-1-elliott@hpe.com>
References: <20221006223151.22159-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oUq8sLBHiCTDU3XfxziFUd5z6bCvmE37
X-Proofpoint-ORIG-GUID: oUq8sLBHiCTDU3XfxziFUd5z6bCvmE37
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_05,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210060133
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
    rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {12-... } 22 jiffies s: 277 root: 0x1/.

Fixes: 0e1227d356e9 ("crypto: ghash - Add PCLMULQDQ accelerated implementation")
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/ghash-clmulni-intel_glue.c | 27 ++++++++++++++++------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/x86/crypto/ghash-clmulni-intel_glue.c b/arch/x86/crypto/ghash-clmulni-intel_glue.c
index b25730c5b267..b9a3e2187f5b 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_glue.c
+++ b/arch/x86/crypto/ghash-clmulni-intel_glue.c
@@ -25,6 +25,8 @@
 #define GHASH_BLOCK_SIZE	16
 #define GHASH_DIGEST_SIZE	16
 
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+
 void clmul_ghash_mul(char *dst, const u128 *shash);
 
 void clmul_ghash_update(char *dst, const char *src, unsigned int srclen,
@@ -81,10 +83,11 @@ static int ghash_update(struct shash_desc *desc,
 	struct ghash_desc_ctx *dctx = shash_desc_ctx(desc);
 	struct ghash_ctx *ctx = crypto_shash_ctx(desc->tfm);
 	u8 *dst = dctx->buffer;
+	unsigned int fpulen;
 
 	if (dctx->bytes) {
 		int n = min(srclen, dctx->bytes);
-		u8 *pos = dst + (GHASH_BLOCK_SIZE - dctx->bytes);
+		u8 *pos = dst + GHASH_BLOCK_SIZE - dctx->bytes;
 
 		dctx->bytes -= n;
 		srclen -= n;
@@ -99,13 +102,23 @@ static int ghash_update(struct shash_desc *desc,
 		}
 	}
 
-	kernel_fpu_begin();
-	clmul_ghash_update(dst, src, srclen, &ctx->shash);
-	kernel_fpu_end();
+	while (srclen >= GHASH_BLOCK_SIZE) {
+		fpulen = min(srclen, FPU_BYTES);
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

