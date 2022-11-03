Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DE46175A0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiKCEec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKCEe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:34:28 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9293AF584;
        Wed,  2 Nov 2022 21:34:27 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3421BR024546;
        Thu, 3 Nov 2022 04:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=tECIyFvsPJywhFXUSQexirS6np6YIq2VopMOItdY5RU=;
 b=YQR9oc6CQ6SrCcwODtsWIijGOX2Fs/uznXdwwMH84PhNn1nwq4/Ts1oZB4DQwxwOz5ev
 A2hb5ehewwI4o9ZB1dR0MgFjt+hPG6BF6WkTDhb+H5cLEEhpt++/BMbvcTfkC1c/eUny
 99pvtBnzK3yGSLTGVsbt3mpVp4/Mhp/ovWRZ/XmYrAW7uJVyQeApNqGtAsoxZ06Pbjvm
 z51bkl2rEmhVtcB4fJynrd1rl2lAj/6E/ZX1lrP4EKAPbCeG6D9LmIODJgb/609pcvjq
 +xw1o/jSeWrXeFLY4OKmvOCjpMeRtmyBxabFuwQ3JT4RFjq3OoHQS3kWXNupIkuApR0L 5Q== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kkstj5yyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 04:33:17 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 60D3BD254;
        Thu,  3 Nov 2022 04:28:16 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id D7CC8801ADB;
        Thu,  3 Nov 2022 04:28:15 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 09/17] crypto: x86/ghash - limit FPU preemption
Date:   Wed,  2 Nov 2022 23:27:32 -0500
Message-Id: <20221103042740.6556-10-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221103042740.6556-1-elliott@hpe.com>
References: <20221012215931.3896-1-elliott@hpe.com>
 <20221103042740.6556-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kITOWZe31j6M8F9WiQefL_ZTAWSd0oNg
X-Proofpoint-GUID: kITOWZe31j6M8F9WiQefL_ZTAWSd0oNg
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030031
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2.37.3

