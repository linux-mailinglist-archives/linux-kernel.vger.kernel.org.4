Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E835861757C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiKCE20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiKCE2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:28:21 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8981F5;
        Wed,  2 Nov 2022 21:28:20 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A33Phpu018190;
        Thu, 3 Nov 2022 04:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=dGSE/GY5tgSgZkoUWJYyGFHTG8j40hYCG+KmboMJvsU=;
 b=MA3waoJ/fDM5wjIIvDb6bY3alnyPHcpKR3vFsXfS8VJFE4xuXlxAY6OJQ5iTd0s9KE86
 Z65ZyoeImpc1SfM7YKOoL+OyXu2EUlmI2lPTMcTL+FP7H9NS7bo+Jk/LKsv0oVxXSJ/L
 maAhQR3ot/VpcsOZ85j4YeUJYxgsy6YsVOI9jEMgvHI1IzRzwz9hd8RSgsjXx9QZ94MO
 WppqJHWaCEdfE6nLX8wz6cEoHY0h6AVCSRgD3V7tdKXbrx0tmQNIpLuTxxY9EP0Bse6+
 MxR6OQjMY+W7tG5HEVCkPVNxPWy86YIdBDzf96DTxF9xDNHwn6w4dq2Wa0NWD/e/u+sP 9A== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3kkw4a3m4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 04:28:12 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 4CC678040F4;
        Thu,  3 Nov 2022 04:28:12 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id C87A080A0FF;
        Thu,  3 Nov 2022 04:28:11 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 06/17] crypto: x86/sm3 - limit FPU preemption
Date:   Wed,  2 Nov 2022 23:27:29 -0500
Message-Id: <20221103042740.6556-7-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221103042740.6556-1-elliott@hpe.com>
References: <20221012215931.3896-1-elliott@hpe.com>
 <20221103042740.6556-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tNwcuweT85c46XsufA6fJGcnJT61Chnx
X-Proofpoint-ORIG-GUID: tNwcuweT85c46XsufA6fJGcnJT61Chnx
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
2.37.3

