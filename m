Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F325FCDF2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiJLWAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiJLWA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:00:29 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C1E422C0;
        Wed, 12 Oct 2022 15:00:12 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CKwqKa008071;
        Wed, 12 Oct 2022 21:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=QTkyAOc86d/ALjZrO/JAy9mwf2Rc5zZNS5XWX8x3KVU=;
 b=F15R0CXaZFRQYQbo63rBujJeUwVGm5wVfZpKkJGSgieEZcMt2EFbdYPECgs4xLBYmb4k
 LVjfvJsuUDHHZj9eaItdHeqAsp7HgE4dtBkHmImBJydkqiJ0E0738Wk7VR7cisacdOxN
 l0BjpNb0qPwiM8UHOBG2Qv6gzu4KWUOV8yvHUOJH2pSKyYygfoYBFiAL/HmDfHLeDbaM
 xNHt+gQuiWoWktqp09iNI4/5DMoIzqVQdnGB+Vy4RlbDPgBPq+L/EiMrPrdag1c/Y4n0
 XOXJAzx4LoOKDOUfQEWSczS8mtxI+JV3QPrIBo95k4OevsH35qrm1Sd2X87xZta2SmJb ww== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k653c8daf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 21:59:52 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id DFE7613965;
        Wed, 12 Oct 2022 21:59:51 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 853DA808EE1;
        Wed, 12 Oct 2022 21:59:51 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 05/19] crypto: x86/crc - limit FPU preemption
Date:   Wed, 12 Oct 2022 16:59:17 -0500
Message-Id: <20221012215931.3896-6-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012215931.3896-1-elliott@hpe.com>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: P2-UHsNACr6wYY-UIFlHqmPBROyZAoO5
X-Proofpoint-ORIG-GUID: P2-UHsNACr6wYY-UIFlHqmPBROyZAoO5
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

Fixes: 78c37d191dd6 ("crypto: crc32 - add crc32 pclmulqdq implementation and wrappers for table implementation")
Fixes: 6a8ce1ef3940 ("crypto: crc32c - Optimize CRC32C calculation with PCLMULQDQ instruction")
Fixes: 0b95a7f85718 ("crypto: crct10dif - Glue code to cast accelerated CRCT10DIF assembly as a crypto transform")
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/crc32-pclmul_asm.S      |  6 ++--
 arch/x86/crypto/crc32-pclmul_glue.c     | 19 ++++++++----
 arch/x86/crypto/crc32c-intel_glue.c     | 29 ++++++++++++++----
 arch/x86/crypto/crct10dif-pclmul_glue.c | 39 ++++++++++++++++++++-----
 4 files changed, 71 insertions(+), 22 deletions(-)

diff --git a/arch/x86/crypto/crc32-pclmul_asm.S b/arch/x86/crypto/crc32-pclmul_asm.S
index ca53e96996ac..9abd861636c3 100644
--- a/arch/x86/crypto/crc32-pclmul_asm.S
+++ b/arch/x86/crypto/crc32-pclmul_asm.S
@@ -72,15 +72,15 @@
 .text
 /**
  *      Calculate crc32
- *      BUF - buffer (16 bytes aligned)
- *      LEN - sizeof buffer (16 bytes aligned), LEN should be grater than 63
+ *      BUF - buffer - must be 16 bytes aligned
+ *      LEN - sizeof buffer - must be multiple of 16 bytes and greater than 63
  *      CRC - initial crc32
  *      return %eax crc32
  *      uint crc32_pclmul_le_16(unsigned char const *buffer,
  *	                     size_t len, uint crc32)
  */
 
-SYM_FUNC_START(crc32_pclmul_le_16) /* buffer and buffer size are 16 bytes aligned */
+SYM_FUNC_START(crc32_pclmul_le_16)
 	movdqa  (BUF), %xmm1
 	movdqa  0x10(BUF), %xmm2
 	movdqa  0x20(BUF), %xmm3
diff --git a/arch/x86/crypto/crc32-pclmul_glue.c b/arch/x86/crypto/crc32-pclmul_glue.c
index 98cf3b4e4c9f..38539c6edfe5 100644
--- a/arch/x86/crypto/crc32-pclmul_glue.c
+++ b/arch/x86/crypto/crc32-pclmul_glue.c
@@ -46,6 +46,8 @@
 #define SCALE_F			16L	/* size of xmm register */
 #define SCALE_F_MASK		(SCALE_F - 1)
 
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+
 u32 crc32_pclmul_le_16(unsigned char const *buffer, size_t len, u32 crc32);
 
 static u32 __attribute__((pure))
@@ -70,12 +72,19 @@ static u32 __attribute__((pure))
 	iquotient = len & (~SCALE_F_MASK);
 	iremainder = len & SCALE_F_MASK;
 
-	kernel_fpu_begin();
-	crc = crc32_pclmul_le_16(p, iquotient, crc);
-	kernel_fpu_end();
+	do {
+		unsigned int chunk = min(iquotient, FPU_BYTES);
+
+		kernel_fpu_begin();
+		crc = crc32_pclmul_le_16(p, chunk, crc);
+		kernel_fpu_end();
+
+		iquotient -= chunk;
+		p += chunk;
+	} while (iquotient >= PCLMUL_MIN_LEN);
 
-	if (iremainder)
-		crc = crc32_le(crc, p + iquotient, iremainder);
+	if (iquotient || iremainder)
+		crc = crc32_le(crc, p, iquotient + iremainder);
 
 	return crc;
 }
diff --git a/arch/x86/crypto/crc32c-intel_glue.c b/arch/x86/crypto/crc32c-intel_glue.c
index feccb5254c7e..ece620227057 100644
--- a/arch/x86/crypto/crc32c-intel_glue.c
+++ b/arch/x86/crypto/crc32c-intel_glue.c
@@ -41,6 +41,8 @@
  */
 #define CRC32C_PCL_BREAKEVEN	512
 
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+
 asmlinkage unsigned int crc_pcl(const u8 *buffer, int len,
 				unsigned int crc_init);
 #endif /* CONFIG_X86_64 */
@@ -158,9 +160,16 @@ static int crc32c_pcl_intel_update(struct shash_desc *desc, const u8 *data,
 	 * overcome kernel fpu state save/restore overhead
 	 */
 	if (len >= CRC32C_PCL_BREAKEVEN && crypto_simd_usable()) {
-		kernel_fpu_begin();
-		*crcp = crc_pcl(data, len, *crcp);
-		kernel_fpu_end();
+		do {
+			unsigned int chunk = min(len, FPU_BYTES);
+
+			kernel_fpu_begin();
+			*crcp = crc_pcl(data, chunk, *crcp);
+			kernel_fpu_end();
+
+			len -= chunk;
+			data += chunk;
+		} while (len);
 	} else
 		*crcp = crc32c_intel_le_hw(*crcp, data, len);
 	return 0;
@@ -170,9 +179,17 @@ static int __crc32c_pcl_intel_finup(u32 *crcp, const u8 *data, unsigned int len,
 				u8 *out)
 {
 	if (len >= CRC32C_PCL_BREAKEVEN && crypto_simd_usable()) {
-		kernel_fpu_begin();
-		*(__le32 *)out = ~cpu_to_le32(crc_pcl(data, len, *crcp));
-		kernel_fpu_end();
+		do {
+			unsigned int chunk = min(len, FPU_BYTES);
+
+			kernel_fpu_begin();
+			*crcp = crc_pcl(data, chunk, *crcp);
+			kernel_fpu_end();
+
+			len -= chunk;
+			data += chunk;
+		} while (len);
+		*(__le32 *)out = ~cpu_to_le32(*crcp);
 	} else
 		*(__le32 *)out =
 			~cpu_to_le32(crc32c_intel_le_hw(*crcp, data, len));
diff --git a/arch/x86/crypto/crct10dif-pclmul_glue.c b/arch/x86/crypto/crct10dif-pclmul_glue.c
index 71291d5af9f4..54a537fc88ee 100644
--- a/arch/x86/crypto/crct10dif-pclmul_glue.c
+++ b/arch/x86/crypto/crct10dif-pclmul_glue.c
@@ -34,6 +34,10 @@
 #include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
+#define PCLMUL_MIN_LEN 16U /* minimum size of buffer for crc_t10dif_pcl */
+
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+
 asmlinkage u16 crc_t10dif_pcl(u16 init_crc, const u8 *buf, size_t len);
 
 struct chksum_desc_ctx {
@@ -54,10 +58,19 @@ static int chksum_update(struct shash_desc *desc, const u8 *data,
 {
 	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
 
-	if (length >= 16 && crypto_simd_usable()) {
-		kernel_fpu_begin();
-		ctx->crc = crc_t10dif_pcl(ctx->crc, data, length);
-		kernel_fpu_end();
+	if (length >= PCLMUL_MIN_LEN && crypto_simd_usable()) {
+		do {
+			unsigned int chunk = min(length, FPU_BYTES);
+
+			kernel_fpu_begin();
+			ctx->crc = crc_t10dif_pcl(ctx->crc, data, chunk);
+			kernel_fpu_end();
+
+			length -= chunk;
+			data += chunk;
+		} while (length >= PCLMUL_MIN_LEN);
+		if (length)
+			ctx->crc = crc_t10dif_generic(ctx->crc, data, length);
 	} else
 		ctx->crc = crc_t10dif_generic(ctx->crc, data, length);
 	return 0;
@@ -73,10 +86,20 @@ static int chksum_final(struct shash_desc *desc, u8 *out)
 
 static int __chksum_finup(__u16 crc, const u8 *data, unsigned int len, u8 *out)
 {
-	if (len >= 16 && crypto_simd_usable()) {
-		kernel_fpu_begin();
-		*(__u16 *)out = crc_t10dif_pcl(crc, data, len);
-		kernel_fpu_end();
+	if (len >= PCLMUL_MIN_LEN && crypto_simd_usable()) {
+		do {
+			unsigned int chunk = min(len, FPU_BYTES);
+
+			kernel_fpu_begin();
+			crc = crc_t10dif_pcl(crc, data, chunk);
+			kernel_fpu_end();
+
+			len -= chunk;
+			data += chunk;
+		} while (len >= PCLMUL_MIN_LEN);
+		if (len)
+			crc = crc_t10dif_generic(crc, data, len);
+		*(__u16 *)out = crc;
 	} else
 		*(__u16 *)out = crc_t10dif_generic(crc, data, len);
 	return 0;
-- 
2.37.3

