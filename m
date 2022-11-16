Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07C662B225
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 05:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiKPEOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 23:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiKPEOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 23:14:19 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C49A2CDCC;
        Tue, 15 Nov 2022 20:14:17 -0800 (PST)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG3Ncm8026856;
        Wed, 16 Nov 2022 04:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=cTTNWZf0gsaOChSSwVwJsJGsUpzhNtRL8Yvh4fEQViw=;
 b=oCuOJ54erZ91/ohmsoPTEJnfhsBH1vjmh1haz6V7DtH9adN81WnwEZ9Bp+lnpyziuKTr
 76WR0CsARrKK6EjpLsNa+IilhpmXSvAzfDdL9puh45aSwhSpogkAs7M/MB70t5wYX1wj
 VscpfEGI5LwWWXoW9bgT7wEzFA7VwV74/9w7Wbhb/dlbO3KM11ltNMQvu55xKrpilzuE
 OEWTH1C3FMwrFKK7EQuiiFWxXfZhYx8YKlCviIwyQont3q9oo+H/O73LAUgtgkxZfBC0
 DHWX+sHlU2OVRdACoTBKKRufgjwfv0ueaVkb2Wt3H69ilTNiOle2yhb0KVcV3Afkb/k0 5g== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kvqwqgabd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 04:14:07 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 1BFFF4B5DC;
        Wed, 16 Nov 2022 04:14:06 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id A22BE808BA7;
        Wed, 16 Nov 2022 04:14:05 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v4 11/24] crypto: x86/aegis - limit FPU preemption
Date:   Tue, 15 Nov 2022 22:13:29 -0600
Message-Id: <20221116041342.3841-12-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116041342.3841-1-elliott@hpe.com>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _Ez51FyL3s9E__eU_HvQXPq7PEMUgsSQ
X-Proofpoint-GUID: _Ez51FyL3s9E__eU_HvQXPq7PEMUgsSQ
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

Make kernel_fpu_begin() and kernel_fpu_end() calls around each
assembly language function that uses FPU context, rather than
around the entire set (init, ad, crypt, final).

Limit the processing of bulk data based on a module parameter,
so multiple blocks are processed within one FPU context
(associated data is not limited).

Allow the skcipher_walk functions to sleep again, since they are
is no longer called inside FPU context.

Motivation: calling crypto_aead_encrypt() with a single scatter-gather
list entry pointing to a 1 MiB plaintext buffer caused the aesni_encrypt
function to receive a length of 1048576 bytes and consume 306348 cycles
within FPU context to process that data.

Fixes: 1d373d4e8e15 ("crypto: x86 - Add optimized AEGIS implementations")
Fixes: ba6771c0a0bc ("crypto: x86/aegis - fix handling chunked inputs and MAY_SLEEP")
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/aegis128-aesni-glue.c | 39 ++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/x86/crypto/aegis128-aesni-glue.c b/arch/x86/crypto/aegis128-aesni-glue.c
index 4623189000d8..6e96bdda2811 100644
--- a/arch/x86/crypto/aegis128-aesni-glue.c
+++ b/arch/x86/crypto/aegis128-aesni-glue.c
@@ -23,6 +23,9 @@
 #define AEGIS128_MIN_AUTH_SIZE 8
 #define AEGIS128_MAX_AUTH_SIZE 16
 
+/* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+static const unsigned int bytes_per_fpu = 4 * 1024;
+
 asmlinkage void crypto_aegis128_aesni_init(void *state, void *key, void *iv);
 
 asmlinkage void crypto_aegis128_aesni_ad(
@@ -85,15 +88,19 @@ static void crypto_aegis128_aesni_process_ad(
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
@@ -110,7 +117,9 @@ static void crypto_aegis128_aesni_process_ad(
 
 	if (pos > 0) {
 		memset(buf.bytes + pos, 0, AEGIS128_BLOCK_SIZE - pos);
-		crypto_aegis128_aesni_ad(state, AEGIS128_BLOCK_SIZE, buf.bytes);
+		kernel_fpu_begin();
+		crypto_aegis128_aesni_ad(state->blocks, AEGIS128_BLOCK_SIZE, buf.bytes);
+		kernel_fpu_end();
 	}
 }
 
@@ -119,15 +128,23 @@ static void crypto_aegis128_aesni_process_crypt(
 		const struct aegis_crypt_ops *ops)
 {
 	while (walk->nbytes >= AEGIS128_BLOCK_SIZE) {
-		ops->crypt_blocks(state,
-				  round_down(walk->nbytes, AEGIS128_BLOCK_SIZE),
+		unsigned int chunk = min(walk->nbytes, bytes_per_fpu);
+
+		chunk = round_down(chunk, AEGIS128_BLOCK_SIZE);
+
+		kernel_fpu_begin();
+		ops->crypt_blocks(state->blocks, chunk,
 				  walk->src.virt.addr, walk->dst.virt.addr);
-		skcipher_walk_done(walk, walk->nbytes % AEGIS128_BLOCK_SIZE);
+		kernel_fpu_end();
+
+		skcipher_walk_done(walk, walk->nbytes - chunk);
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
@@ -172,15 +189,17 @@ static void crypto_aegis128_aesni_crypt(struct aead_request *req,
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

