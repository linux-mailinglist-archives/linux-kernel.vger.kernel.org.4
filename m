Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAA465152F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbiLSWDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiLSWDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:03:17 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B59313F97;
        Mon, 19 Dec 2022 14:03:16 -0800 (PST)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJKW3DT015099;
        Mon, 19 Dec 2022 22:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=hrnSS/acWGmvImUo/QDE8X3zDiPvrvWWK9oGzVt4i0M=;
 b=STcXxQSXSo0nENAYhUcqOjh7Q66IsWXyNouDI9udlCce7apiUNr0jN4gvb1ifzxSXbGj
 mgv5IJf3xa1RwT1cyWuAxn8NdS6pCGhv3ZorMrV6hy3edS/3L3hCiOmmn+gtjZny1hzp
 NdTR9RDEkTh+/bDszmDh3aBpV9+DeCeE9Z2YaKZr7NDumVp4ANYMdX/vuxR4DNcaK1uJ
 iCNPwbsPWegU6hKLVD4G0rttHtU4xMn7wgO+QG/cTAtd0bP5hgh6P2IRwREbkXdnlHiP
 PQLcH4iff8aLlicxQnvGaEji9MuItOtS+AAPLKIfXvwUtzubn53EZk8DMDxgtzZVpkgG 2A== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3mjv4222vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 22:02:57 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 634A5310BD;
        Mon, 19 Dec 2022 22:02:56 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 913C0805634;
        Mon, 19 Dec 2022 22:02:55 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, Jason@zx2c4.com,
        ardb@kernel.org, ap420073@gmail.com, David.Laight@ACULAB.COM,
        ebiggers@kernel.org, tim.c.chen@linux.intel.com, peter@n8pjl.ca,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 08/13] crypto: x86/ghash - yield FPU context during long loops
Date:   Mon, 19 Dec 2022 16:02:18 -0600
Message-Id: <20221219220223.3982176-9-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219220223.3982176-1-elliott@hpe.com>
References: <20221219220223.3982176-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OTJy3vKEdfmzvoxGnRwruc0exfrYOwPG
X-Proofpoint-GUID: OTJy3vKEdfmzvoxGnRwruc0exfrYOwPG
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 phishscore=0 impostorscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190193
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The x86 assembly language implementations using SIMD process data
between kernel_fpu_begin() and kernel_fpu_end() calls. That
disables scheduler preemption, so prevents the CPU core from being
used by other threads.

The update() and finup() functions might be called to process
large quantities of data, which can result in RCU stalls and
soft lockups.

Periodically check if the kernel scheduler wants to run something
else on the CPU. If so, yield the kernel FPU context and let the
scheduler intervene.

Fixes: 0e1227d356e9 ("crypto: ghash - Add PCLMULQDQ accelerated implementation")
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/ghash-clmulni-intel_glue.c | 26 ++++++++++++++++------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/x86/crypto/ghash-clmulni-intel_glue.c b/arch/x86/crypto/ghash-clmulni-intel_glue.c
index 1bfde099de0f..cd44339abdbb 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_glue.c
+++ b/arch/x86/crypto/ghash-clmulni-intel_glue.c
@@ -82,7 +82,7 @@ static int ghash_update(struct shash_desc *desc,
 
 	if (dctx->bytes) {
 		int n = min(srclen, dctx->bytes);
-		u8 *pos = dst + (GHASH_BLOCK_SIZE - dctx->bytes);
+		u8 *pos = dst + GHASH_BLOCK_SIZE - dctx->bytes;
 
 		dctx->bytes -= n;
 		srclen -= n;
@@ -97,13 +97,25 @@ static int ghash_update(struct shash_desc *desc,
 		}
 	}
 
-	kernel_fpu_begin();
-	clmul_ghash_update(dst, src, srclen, &ctx->shash);
-	kernel_fpu_end();
+	if (srclen >= GHASH_BLOCK_SIZE) {
+		kernel_fpu_begin();
+		for (;;) {
+			const unsigned int chunk = min(srclen, 4096U);
+
+			clmul_ghash_update(dst, src, chunk, &ctx->shash);
+
+			srclen -= chunk & ~(GHASH_BLOCK_SIZE - 1);
+			src += chunk & ~(GHASH_BLOCK_SIZE - 1);
+
+			if (srclen < GHASH_BLOCK_SIZE)
+				break;
+
+			kernel_fpu_yield();
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
2.38.1

