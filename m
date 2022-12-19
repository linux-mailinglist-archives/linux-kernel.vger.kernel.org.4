Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7267765153A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbiLSWDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiLSWDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:03:19 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDFA13F97;
        Mon, 19 Dec 2022 14:03:18 -0800 (PST)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJKsHLI016291;
        Mon, 19 Dec 2022 22:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=nSvaflAAMuZJfAIaCIotghXNKYG+XpkRDzCUXcgsa5g=;
 b=JtNnDTFqPb0hBmYH8+/JkEsBILIbaFYXXGSZdnc3lzB68YQav0oJHkwYpQFVNbClPyx0
 u/Pj0y+ndNK9Nu5Iyw+EEfFJe1QPli4e3N6yhPSeDxP8c189BQ/XGlKTkAGp1OThJANs
 YhfBAiqZXvtzeCCGdErFar8YZVz4rbKMrVHBwM9wBNa5n3WdFwwOAi8A6DaDCgawEUic
 QPRCc/EtuC04ZhT7LvEVjVLR4qDuFAqfyEXFrczTRMkj9jbTLQ3swsqQmTSJXhbYsPEA
 +26v9T3WUkxbEvsHpOCPgWSe1rPjwzaU3a3HC0l/h8u4/9GtYKauJmUhYTuHVMQMlbjW DA== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3mjy6d0etp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 22:03:01 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 3EF413DE2A;
        Mon, 19 Dec 2022 22:03:01 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 6DAE080649A;
        Mon, 19 Dec 2022 22:03:00 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, Jason@zx2c4.com,
        ardb@kernel.org, ap420073@gmail.com, David.Laight@ACULAB.COM,
        ebiggers@kernel.org, tim.c.chen@linux.intel.com, peter@n8pjl.ca,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 11/13] crypto: x86/blake - yield FPU context only when needed
Date:   Mon, 19 Dec 2022 16:02:21 -0600
Message-Id: <20221219220223.3982176-12-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219220223.3982176-1-elliott@hpe.com>
References: <20221219220223.3982176-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: O0UNo8-c_31ZUN3VBFPimjZMmRle62hI
X-Proofpoint-GUID: O0UNo8-c_31ZUN3VBFPimjZMmRle62hI
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190193
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_FILL_THIS_FORM_SHORT autolearn=ham
        autolearn_force=no version=3.4.6
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

Rather than break the processing into 4 KiB passes, each of which
unilaterally calls kernel_fpu_begin() and kernel_fpu_end(),
periodically check if the kernel scheduler wants to run something
else on the CPU. If so, yield the kernel FPU context and let the
scheduler intervene.

Adjust the type of the length arguments everywhere to be unsigned
long rather than size_t to avoid typecasts.

Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/blake2s-glue.c    | 41 ++++++++++++++++---------------
 include/crypto/internal/blake2s.h |  8 +++---
 lib/crypto/blake2s-generic.c      | 12 ++++-----
 3 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/arch/x86/crypto/blake2s-glue.c b/arch/x86/crypto/blake2s-glue.c
index aaba21230528..bbb0a67ebb1c 100644
--- a/arch/x86/crypto/blake2s-glue.c
+++ b/arch/x86/crypto/blake2s-glue.c
@@ -12,46 +12,47 @@
 #include <linux/sizes.h>
 
 #include <asm/cpufeature.h>
-#include <asm/fpu/api.h>
 #include <asm/processor.h>
 #include <asm/simd.h>
 
-asmlinkage void blake2s_compress_ssse3(struct blake2s_state *state,
-				       const u8 *block, const size_t nblocks,
-				       const u32 inc);
-asmlinkage void blake2s_compress_avx512(struct blake2s_state *state,
-					const u8 *block, const size_t nblocks,
-					const u32 inc);
+asmlinkage void blake2s_compress_ssse3(struct blake2s_state *state, const u8 *data,
+				       unsigned int nblocks, u32 inc);
+asmlinkage void blake2s_compress_avx512(struct blake2s_state *state, const u8 *data,
+					unsigned int nblocks, u32 inc);
 
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(blake2s_use_ssse3);
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(blake2s_use_avx512);
 
-void blake2s_compress(struct blake2s_state *state, const u8 *block,
-		      size_t nblocks, const u32 inc)
+void blake2s_compress(struct blake2s_state *state, const u8 *data,
+		      unsigned int nblocks, const u32 inc)
 {
 	/* SIMD disables preemption, so relax after processing each page. */
 	BUILD_BUG_ON(SZ_4K / BLAKE2S_BLOCK_SIZE < 8);
 
 	if (!static_branch_likely(&blake2s_use_ssse3) || !may_use_simd()) {
-		blake2s_compress_generic(state, block, nblocks, inc);
+		blake2s_compress_generic(state, data, nblocks, inc);
 		return;
 	}
 
-	do {
-		const size_t blocks = min_t(size_t, nblocks,
-					    SZ_4K / BLAKE2S_BLOCK_SIZE);
+	kernel_fpu_begin();
+	for (;;) {
+		const unsigned int chunks = min(nblocks, 4096U / BLAKE2S_BLOCK_SIZE);
 
-		kernel_fpu_begin();
 		if (IS_ENABLED(CONFIG_AS_AVX512) &&
 		    static_branch_likely(&blake2s_use_avx512))
-			blake2s_compress_avx512(state, block, blocks, inc);
+			blake2s_compress_avx512(state, data, chunks, inc);
 		else
-			blake2s_compress_ssse3(state, block, blocks, inc);
-		kernel_fpu_end();
+			blake2s_compress_ssse3(state, data, chunks, inc);
 
-		nblocks -= blocks;
-		block += blocks * BLAKE2S_BLOCK_SIZE;
-	} while (nblocks);
+		nblocks -= chunks;
+
+		if (!nblocks)
+			break;
+
+		data += chunks * BLAKE2S_BLOCK_SIZE;
+		kernel_fpu_yield();
+	}
+	kernel_fpu_end();
 }
 EXPORT_SYMBOL(blake2s_compress);
 
diff --git a/include/crypto/internal/blake2s.h b/include/crypto/internal/blake2s.h
index 506d56530ca9..d6df791e6148 100644
--- a/include/crypto/internal/blake2s.h
+++ b/include/crypto/internal/blake2s.h
@@ -10,11 +10,11 @@
 #include <crypto/blake2s.h>
 #include <linux/string.h>
 
-void blake2s_compress_generic(struct blake2s_state *state, const u8 *block,
-			      size_t nblocks, const u32 inc);
+void blake2s_compress_generic(struct blake2s_state *state, const u8 *data,
+			      unsigned int nblocks, u32 inc);
 
-void blake2s_compress(struct blake2s_state *state, const u8 *block,
-		      size_t nblocks, const u32 inc);
+void blake2s_compress(struct blake2s_state *state, const u8 *data,
+		      unsigned int nblocks, u32 inc);
 
 bool blake2s_selftest(void);
 
diff --git a/lib/crypto/blake2s-generic.c b/lib/crypto/blake2s-generic.c
index 75ccb3e633e6..6a1caa702698 100644
--- a/lib/crypto/blake2s-generic.c
+++ b/lib/crypto/blake2s-generic.c
@@ -37,12 +37,12 @@ static inline void blake2s_increment_counter(struct blake2s_state *state,
 	state->t[1] += (state->t[0] < inc);
 }
 
-void blake2s_compress(struct blake2s_state *state, const u8 *block,
-		      size_t nblocks, const u32 inc)
+void blake2s_compress(struct blake2s_state *state, const u8 *data,
+		      unsigned int nblocks, u32 inc)
 		      __weak __alias(blake2s_compress_generic);
 
-void blake2s_compress_generic(struct blake2s_state *state, const u8 *block,
-			      size_t nblocks, const u32 inc)
+void blake2s_compress_generic(struct blake2s_state *state, const u8 *data,
+			      unsigned int nblocks, u32 inc)
 {
 	u32 m[16];
 	u32 v[16];
@@ -53,7 +53,7 @@ void blake2s_compress_generic(struct blake2s_state *state, const u8 *block,
 
 	while (nblocks > 0) {
 		blake2s_increment_counter(state, inc);
-		memcpy(m, block, BLAKE2S_BLOCK_SIZE);
+		memcpy(m, data, BLAKE2S_BLOCK_SIZE);
 		le32_to_cpu_array(m, ARRAY_SIZE(m));
 		memcpy(v, state->h, 32);
 		v[ 8] = BLAKE2S_IV0;
@@ -103,7 +103,7 @@ void blake2s_compress_generic(struct blake2s_state *state, const u8 *block,
 		for (i = 0; i < 8; ++i)
 			state->h[i] ^= v[i] ^ v[i + 8];
 
-		block += BLAKE2S_BLOCK_SIZE;
+		data += BLAKE2S_BLOCK_SIZE;
 		--nblocks;
 	}
 }
-- 
2.38.1

