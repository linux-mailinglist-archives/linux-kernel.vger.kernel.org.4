Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED05651546
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbiLSWEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbiLSWDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:03:35 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2B1140A6;
        Mon, 19 Dec 2022 14:03:22 -0800 (PST)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJI2Af6022166;
        Mon, 19 Dec 2022 22:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=r0Ub34Z3hVxIma+xs/LdQFAyE9eIoMSZK4PDG6wbiZE=;
 b=DXs2UhpRPlEH2PcRtE2PcXm4KYW1rTX0Z/zQ6SFznBcqPLLZI/XhfgE9O+AkZdGTSsjs
 KNevrI8AZxW32Tup2G9GhyTzB7urDgKH5DqkFGXp2X9jhq9SbXvg9QIYxigyYTE1JubJ
 troqSUzOLmfSijnALFE7lf3pyhQomijWGGL6wAx6TXbq0WXBBqGsezUn+/AdHjqg+QCN
 bjD7D6NV13r+M7OvTkyCXxjrU2GE2P9wP/PwzAhTjTcxoWlZeutF5F9NlYm5Q/GBXBUi
 6G46sPRMtcdscO7UUCl20WyGAoaMfENBS9C5Wz2n0yqepB1W7wGbkR/2hcpZVoY6jbrb Yw== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3mjvh69gnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 22:02:52 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 27C1B310B4;
        Mon, 19 Dec 2022 22:02:51 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 581BF8061BF;
        Mon, 19 Dec 2022 22:02:50 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, Jason@zx2c4.com,
        ardb@kernel.org, ap420073@gmail.com, David.Laight@ACULAB.COM,
        ebiggers@kernel.org, tim.c.chen@linux.intel.com, peter@n8pjl.ca,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 05/13] crypto: x86/sm3 - yield FPU context during long loops
Date:   Mon, 19 Dec 2022 16:02:15 -0600
Message-Id: <20221219220223.3982176-6-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219220223.3982176-1-elliott@hpe.com>
References: <20221219220223.3982176-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TXAUQ1xjzXxwZkk3YpfNvY56-Pji46tJ
X-Proofpoint-ORIG-GUID: TXAUQ1xjzXxwZkk3YpfNvY56-Pji46tJ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190194
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

Fixes: 930ab34d906d ("crypto: x86/sm3 - add AVX assembly implementation")
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/sm3_avx_glue.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/x86/crypto/sm3_avx_glue.c b/arch/x86/crypto/sm3_avx_glue.c
index 661b6f22ffcd..9e4b21c0e748 100644
--- a/arch/x86/crypto/sm3_avx_glue.c
+++ b/arch/x86/crypto/sm3_avx_glue.c
@@ -25,8 +25,7 @@ static int sm3_avx_update(struct shash_desc *desc, const u8 *data,
 {
 	struct sm3_state *sctx = shash_desc_ctx(desc);
 
-	if (!crypto_simd_usable() ||
-			(sctx->count % SM3_BLOCK_SIZE) + len < SM3_BLOCK_SIZE) {
+	if (((sctx->count % SM3_BLOCK_SIZE) + len < SM3_BLOCK_SIZE) || !crypto_simd_usable()) {
 		sm3_update(sctx, data, len);
 		return 0;
 	}
@@ -38,7 +37,19 @@ static int sm3_avx_update(struct shash_desc *desc, const u8 *data,
 	BUILD_BUG_ON(offsetof(struct sm3_state, state) != 0);
 
 	kernel_fpu_begin();
-	sm3_base_do_update(desc, data, len, sm3_transform_avx);
+	for (;;) {
+		const unsigned int chunk = min(len, 4096U);
+
+		sm3_base_do_update(desc, data, chunk, sm3_transform_avx);
+
+		len -= chunk;
+
+		if (!len)
+			break;
+
+		data += chunk;
+		kernel_fpu_yield();
+	}
 	kernel_fpu_end();
 
 	return 0;
@@ -58,8 +69,21 @@ static int sm3_avx_finup(struct shash_desc *desc, const u8 *data,
 	}
 
 	kernel_fpu_begin();
-	if (len)
-		sm3_base_do_update(desc, data, len, sm3_transform_avx);
+	if (len) {
+		for (;;) {
+			const unsigned int chunk = min(len, 4096U);
+
+			sm3_base_do_update(desc, data, chunk, sm3_transform_avx);
+			len -= chunk;
+
+			if (!len)
+				break;
+
+			data += chunk;
+			kernel_fpu_yield();
+		}
+	}
+
 	sm3_base_do_finalize(desc, sm3_transform_avx);
 	kernel_fpu_end();
 
-- 
2.38.1

