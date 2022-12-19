Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98689651536
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiLSWDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiLSWDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:03:19 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D02413D6F;
        Mon, 19 Dec 2022 14:03:18 -0800 (PST)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJLW1rF025606;
        Mon, 19 Dec 2022 22:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=cBwySZEgLVUjwgqyHLHULZ/4YxK3sjPT9ThAW/euji8=;
 b=VJhp6fzD/f6TR2gTVRg7uEutZGe27LkEmWB5s8L1k+jlyUoxHHvYcL9vrIkf1EDtWINJ
 KVZCUNNgS8FFjj8RKDt57CO5XbZfRv1WDthh3F3mCN/wsMTIPttwCT49hs3Nwq9XBrke
 L9EqPi0m7GwQrgoPlM03aTV2crOo2V+N+/lA8k99/R8uCjDM9mlbj+nLKgpj0B7bIWBU
 jgnKaIBr32VmZop61nUkCCZJa3nMpV3mziCJSV+I9VMVDzFGF26UHkNjBSVn8BBqe34S
 k/mM8FFPf2FGop10BKXxNgJVxDmYlkZVea9rCScx64SsybkudRUsZ5LR9hbYeVz/ykQW lw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3mjx3b10y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 22:03:00 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 7AE703DE29;
        Mon, 19 Dec 2022 22:02:59 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id AECC2808734;
        Mon, 19 Dec 2022 22:02:58 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, Jason@zx2c4.com,
        ardb@kernel.org, ap420073@gmail.com, David.Laight@ACULAB.COM,
        ebiggers@kernel.org, tim.c.chen@linux.intel.com, peter@n8pjl.ca,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 10/13] crypto: x86/aegis - yield FPU context during long loops
Date:   Mon, 19 Dec 2022 16:02:20 -0600
Message-Id: <20221219220223.3982176-11-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219220223.3982176-1-elliott@hpe.com>
References: <20221219220223.3982176-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MWN4LHZ798tbmusyvRonviknI_w6SdXZ
X-Proofpoint-GUID: MWN4LHZ798tbmusyvRonviknI_w6SdXZ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212190193
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make kernel_fpu_begin() and kernel_fpu_end() calls around each
assembly language function that uses FPU context, rather than
around the entire set (init, ad, crypt, final).

During encryption, periodically check if the kernel scheduler
wants to run something else on the CPU. If so, yield the kernel
FPU context and let the scheduler intervene.  Associated data is
not limited.

Allow the skcipher_walk functions to sleep again, since they are
no longer called inside FPU context.

Fixes: 1d373d4e8e15 ("crypto: x86 - Add optimized AEGIS implementations")
Fixes: ba6771c0a0bc ("crypto: x86/aegis - fix handling chunked inputs and MAY_SLEEP")
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/aegis128-aesni-glue.c | 49 ++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/arch/x86/crypto/aegis128-aesni-glue.c b/arch/x86/crypto/aegis128-aesni-glue.c
index 4623189000d8..f99f3e597b3c 100644
--- a/arch/x86/crypto/aegis128-aesni-glue.c
+++ b/arch/x86/crypto/aegis128-aesni-glue.c
@@ -12,8 +12,8 @@
 #include <crypto/internal/skcipher.h>
 #include <crypto/scatterwalk.h>
 #include <linux/module.h>
-#include <asm/fpu/api.h>
 #include <asm/cpu_device_id.h>
+#include <asm/simd.h>
 
 #define AEGIS128_BLOCK_ALIGN 16
 #define AEGIS128_BLOCK_SIZE 16
@@ -85,15 +85,19 @@ static void crypto_aegis128_aesni_process_ad(
 			if (pos > 0) {
 				unsigned int fill = AEGIS128_BLOCK_SIZE - pos;
 				memcpy(buf.bytes + pos, src, fill);
-				crypto_aegis128_aesni_ad(state,
+				kernel_fpu_begin();
+				crypto_aegis128_aesni_ad(state->blocks,
 							 AEGIS128_BLOCK_SIZE,
 							 buf.bytes);
+				kernel_fpu_end();
 				pos = 0;
 				left -= fill;
 				src += fill;
 			}
 
-			crypto_aegis128_aesni_ad(state, left, src);
+			kernel_fpu_begin();
+			crypto_aegis128_aesni_ad(state->blocks, left, src);
+			kernel_fpu_end();
 
 			src += left & ~(AEGIS128_BLOCK_SIZE - 1);
 			left &= AEGIS128_BLOCK_SIZE - 1;
@@ -110,7 +114,9 @@ static void crypto_aegis128_aesni_process_ad(
 
 	if (pos > 0) {
 		memset(buf.bytes + pos, 0, AEGIS128_BLOCK_SIZE - pos);
-		crypto_aegis128_aesni_ad(state, AEGIS128_BLOCK_SIZE, buf.bytes);
+		kernel_fpu_begin();
+		crypto_aegis128_aesni_ad(state->blocks, AEGIS128_BLOCK_SIZE, buf.bytes);
+		kernel_fpu_end();
 	}
 }
 
@@ -118,16 +124,31 @@ static void crypto_aegis128_aesni_process_crypt(
 		struct aegis_state *state, struct skcipher_walk *walk,
 		const struct aegis_crypt_ops *ops)
 {
-	while (walk->nbytes >= AEGIS128_BLOCK_SIZE) {
-		ops->crypt_blocks(state,
-				  round_down(walk->nbytes, AEGIS128_BLOCK_SIZE),
-				  walk->src.virt.addr, walk->dst.virt.addr);
-		skcipher_walk_done(walk, walk->nbytes % AEGIS128_BLOCK_SIZE);
+	if (walk->nbytes >= AEGIS128_BLOCK_SIZE) {
+		kernel_fpu_begin();
+		for (;;) {
+			unsigned int chunk = min(walk->nbytes, 4096U);
+
+			chunk = round_down(chunk, AEGIS128_BLOCK_SIZE);
+
+			ops->crypt_blocks(state->blocks, chunk,
+					  walk->src.virt.addr, walk->dst.virt.addr);
+
+			skcipher_walk_done(walk, walk->nbytes - chunk);
+
+			if (walk->nbytes < AEGIS128_BLOCK_SIZE)
+				break;
+
+			kernel_fpu_yield();
+		}
+		kernel_fpu_end();
 	}
 
 	if (walk->nbytes) {
-		ops->crypt_tail(state, walk->nbytes, walk->src.virt.addr,
+		kernel_fpu_begin();
+		ops->crypt_tail(state->blocks, walk->nbytes, walk->src.virt.addr,
 				walk->dst.virt.addr);
+		kernel_fpu_end();
 		skcipher_walk_done(walk, 0);
 	}
 }
@@ -172,15 +193,17 @@ static void crypto_aegis128_aesni_crypt(struct aead_request *req,
 	struct skcipher_walk walk;
 	struct aegis_state state;
 
-	ops->skcipher_walk_init(&walk, req, true);
+	ops->skcipher_walk_init(&walk, req, false);
 
 	kernel_fpu_begin();
+	crypto_aegis128_aesni_init(&state.blocks, ctx->key.bytes, req->iv);
+	kernel_fpu_end();
 
-	crypto_aegis128_aesni_init(&state, ctx->key.bytes, req->iv);
 	crypto_aegis128_aesni_process_ad(&state, req->src, req->assoclen);
 	crypto_aegis128_aesni_process_crypt(&state, &walk, ops);
-	crypto_aegis128_aesni_final(&state, tag_xor, req->assoclen, cryptlen);
 
+	kernel_fpu_begin();
+	crypto_aegis128_aesni_final(&state.blocks, tag_xor, req->assoclen, cryptlen);
 	kernel_fpu_end();
 }
 
-- 
2.38.1

