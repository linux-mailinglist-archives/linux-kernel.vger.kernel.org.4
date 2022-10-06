Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0B95F7127
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 00:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiJFWcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 18:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiJFWc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:32:29 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F04C5114;
        Thu,  6 Oct 2022 15:32:28 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296IWLf3006721;
        Thu, 6 Oct 2022 22:32:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=W4jQyBaAqxB5hXYqMT2DINItd/YLoIK4YtDAVH9jynk=;
 b=SQSCgXROlXa4+csUjEQxQgo0s7+Bv+VCgPnuav2T0Ok/XDCFjoeLitDnbN/lIR87Brnm
 pl4nh196U+uul8eQJmoz/KLSRX3oVOAfwe5/m9XZYAhLgLSVuBD6WGXRF35Se6/Z2VOZ
 V5iZtJf+LDVIi+wRfrkj4Uh9g7muCdCdHAPjKeqjr6yWiOlS3YctDzFkjwCh6m6zj4iC
 8Y+uGm93CW4mxuCya50iy/yQu0OVLk59SSK4b1JYaASbcPvtvITfEEqNGToEI2Kqwmpa
 tac4+qPng5oSAdcypCYNoH8VRG7B531ofFXcMC1cIxMhTEfDlribTP78n1eP2U1Y8N5v Lw== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3k22bhmrcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 22:32:26 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 7D712D26D;
        Thu,  6 Oct 2022 22:32:25 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 291B6806184;
        Thu,  6 Oct 2022 22:32:25 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [RFC PATCH 4/7] crypto: x86/sm3 - limit FPU preemption
Date:   Thu,  6 Oct 2022 17:31:48 -0500
Message-Id: <20221006223151.22159-5-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221006223151.22159-1-elliott@hpe.com>
References: <20221006223151.22159-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: U4fVSM4QWnBCRlNVR049AYWW0stri5xV
X-Proofpoint-GUID: U4fVSM4QWnBCRlNVR049AYWW0stri5xV
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_05,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 adultscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060133
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
the CPU core is unavailable for scheduling while running, causing:
    rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {12-... } 22 jiffies s: 277 root: 0x1/.

Fixes: 930ab34d906d ("crypto: x86/sm3 - add AVX assembly implementation")
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/sm3_avx_glue.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/x86/crypto/sm3_avx_glue.c b/arch/x86/crypto/sm3_avx_glue.c
index bfd11da956a4..adb9e55e2a16 100644
--- a/arch/x86/crypto/sm3_avx_glue.c
+++ b/arch/x86/crypto/sm3_avx_glue.c
@@ -18,6 +18,8 @@
 #include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+
 asmlinkage void sm3_transform_avx(struct sm3_state *state,
 			const u8 *data, int nblocks);
 
@@ -25,6 +27,7 @@ static int sm3_avx_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
 {
 	struct sm3_state *sctx = shash_desc_ctx(desc);
+	unsigned int chunk;
 
 	if (!crypto_simd_usable() ||
 			(sctx->count % SM3_BLOCK_SIZE) + len < SM3_BLOCK_SIZE) {
@@ -38,9 +41,14 @@ static int sm3_avx_update(struct shash_desc *desc, const u8 *data,
 	 */
 	BUILD_BUG_ON(offsetof(struct sm3_state, state) != 0);
 
-	kernel_fpu_begin();
-	sm3_base_do_update(desc, data, len, sm3_transform_avx);
-	kernel_fpu_end();
+	do {
+		chunk = min(len, FPU_BYTES);
+		len -= chunk;
+		kernel_fpu_begin();
+		sm3_base_do_update(desc, data, chunk, sm3_transform_avx);
+		kernel_fpu_end();
+		data += chunk;
+	} while (len);
 
 	return 0;
 }
@@ -48,6 +56,8 @@ static int sm3_avx_update(struct shash_desc *desc, const u8 *data,
 static int sm3_avx_finup(struct shash_desc *desc, const u8 *data,
 		      unsigned int len, u8 *out)
 {
+	unsigned int chunk;
+
 	if (!crypto_simd_usable()) {
 		struct sm3_state *sctx = shash_desc_ctx(desc);
 
@@ -58,9 +68,17 @@ static int sm3_avx_finup(struct shash_desc *desc, const u8 *data,
 		return 0;
 	}
 
+	do {
+		chunk = min(len, FPU_BYTES);
+		len -= chunk;
+		if (chunk) {
+			kernel_fpu_begin();
+			sm3_base_do_update(desc, data, chunk, sm3_transform_avx);
+			kernel_fpu_end();
+		}
+		data += chunk;
+	} while (len);
 	kernel_fpu_begin();
-	if (len)
-		sm3_base_do_update(desc, data, len, sm3_transform_avx);
 	sm3_base_do_finalize(desc, sm3_transform_avx);
 	kernel_fpu_end();
 
-- 
2.37.3

