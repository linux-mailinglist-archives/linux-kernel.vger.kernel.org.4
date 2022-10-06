Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518EE5F7137
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 00:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiJFWhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 18:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbiJFWhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:37:32 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33D9F252C;
        Thu,  6 Oct 2022 15:37:27 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296Lo2xg028782;
        Thu, 6 Oct 2022 22:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=rc1eSB//t36JGFSMPIYD6WvUbxbmez76ZMUGGs5nJTI=;
 b=ZFEr9C6zrZAV6MjZyHA4bf3JnYE2HZuNC8J8jRZxVcM5C8WFr5fherR3yR0vZ49bM0YD
 AhXbboNbz4//2fcBr4FVkNt0zCbW3qKo60x2fi7DA+8LBnu4duX1PYfQfmzqX1hniiW6
 RNuZqjEnED4MrBMM55RXHzESd3JaSSCGZZfVD2vGftx5dEsn4WCcQtoQIcgB90nRBUCY
 tX0qHv/IbGaQf3iCIJI0p+v7/nOcXs6CocUYWQxUSY6g1ujiD5Fkq+dBEBDsgxDyKL2V
 VwFDunt3YPjoYgO154E/zGwGNpZfx7V9ElepgI/1CLprg/OQBOEwuQYSn8gKnT9pcc9V tg== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k27950b7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 22:37:24 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 087E9806B59;
        Thu,  6 Oct 2022 22:32:23 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id AE57E8038CA;
        Thu,  6 Oct 2022 22:32:23 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [RFC PATCH 3/7] crypto: x86/crc - limit FPU preemption
Date:   Thu,  6 Oct 2022 17:31:47 -0500
Message-Id: <20221006223151.22159-4-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221006223151.22159-1-elliott@hpe.com>
References: <20221006223151.22159-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Luei-Eh2Ae2Z24fI054UdPMjt7E04wS7
X-Proofpoint-GUID: Luei-Eh2Ae2Z24fI054UdPMjt7E04wS7
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_05,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
the CPU core is unavailable for scheduling while running, leading to:
    rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {12-... } 22 jiffies s: 277 root: 0x1/.

Fixes: 78c37d191dd6 ("crypto: crc32 - add crc32 pclmulqdq implementation and wrappers for table implementation")
Fixes: 6a8ce1ef3940 ("crypto: crc32c - Optimize CRC32C calculation with PCLMULQDQ instruction")
Fixes: 0b95a7f85718 ("crypto: crct10dif - Glue code to cast accelerated CRCT10DIF assembly as a crypto transform")
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/crc32-pclmul_glue.c     | 18 ++++++++++----
 arch/x86/crypto/crc32c-intel_glue.c     | 32 ++++++++++++++++++++-----
 arch/x86/crypto/crct10dif-pclmul_glue.c | 32 ++++++++++++++++++++-----
 3 files changed, 66 insertions(+), 16 deletions(-)

diff --git a/arch/x86/crypto/crc32-pclmul_glue.c b/arch/x86/crypto/crc32-pclmul_glue.c
index 288200fe7b4e..7cf65dc726c4 100644
--- a/arch/x86/crypto/crc32-pclmul_glue.c
+++ b/arch/x86/crypto/crc32-pclmul_glue.c
@@ -49,6 +49,8 @@
 #define SCALE_F			16L	/* size of xmm register */
 #define SCALE_F_MASK		(SCALE_F - 1)
 
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+
 u32 crc32_pclmul_le_16(unsigned char const *buffer, size_t len, u32 crc32);
 
 static u32 __attribute__((pure))
@@ -57,6 +59,7 @@ static u32 __attribute__((pure))
 	unsigned int iquotient;
 	unsigned int iremainder;
 	unsigned int prealign;
+	unsigned int chunk;
 
 	if (len < PCLMUL_MIN_LEN + SCALE_F_MASK || !crypto_simd_usable())
 		return crc32_le(crc, p, len);
@@ -73,12 +76,19 @@ static u32 __attribute__((pure))
 	iquotient = len & (~SCALE_F_MASK);
 	iremainder = len & SCALE_F_MASK;
 
-	kernel_fpu_begin();
-	crc = crc32_pclmul_le_16(p, iquotient, crc);
-	kernel_fpu_end();
+	do {
+		chunk = min(iquotient, FPU_BYTES);
+		iquotient -= chunk;
+
+		kernel_fpu_begin();
+		crc = crc32_pclmul_le_16(p, chunk, crc);
+		kernel_fpu_end();
+
+		p += chunk;
+	} while (iquotient);
 
 	if (iremainder)
-		crc = crc32_le(crc, p + iquotient, iremainder);
+		crc = crc32_le(crc, p, iremainder);
 
 	return crc;
 }
diff --git a/arch/x86/crypto/crc32c-intel_glue.c b/arch/x86/crypto/crc32c-intel_glue.c
index c5c965b694c6..b277c215f0fb 100644
--- a/arch/x86/crypto/crc32c-intel_glue.c
+++ b/arch/x86/crypto/crc32c-intel_glue.c
@@ -44,6 +44,8 @@
  */
 #define CRC32C_PCL_BREAKEVEN	512
 
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+
 asmlinkage unsigned int crc_pcl(const u8 *buffer, int len,
 				unsigned int crc_init);
 #endif /* CONFIG_X86_64 */
@@ -155,15 +157,23 @@ static int crc32c_pcl_intel_update(struct shash_desc *desc, const u8 *data,
 			       unsigned int len)
 {
 	u32 *crcp = shash_desc_ctx(desc);
+	unsigned int chunk;
 
 	/*
 	 * use faster PCL version if datasize is large enough to
 	 * overcome kernel fpu state save/restore overhead
 	 */
 	if (len >= CRC32C_PCL_BREAKEVEN && crypto_simd_usable()) {
-		kernel_fpu_begin();
-		*crcp = crc_pcl(data, len, *crcp);
-		kernel_fpu_end();
+		do {
+			chunk = min(len, FPU_BYTES);
+			len -= chunk;
+
+			kernel_fpu_begin();
+			*crcp = crc_pcl(data, chunk, *crcp);
+			kernel_fpu_end();
+
+			data += chunk;
+		} while (len);
 	} else
 		*crcp = crc32c_intel_le_hw(*crcp, data, len);
 	return 0;
@@ -172,10 +182,20 @@ static int crc32c_pcl_intel_update(struct shash_desc *desc, const u8 *data,
 static int __crc32c_pcl_intel_finup(u32 *crcp, const u8 *data, unsigned int len,
 				u8 *out)
 {
+	unsigned int chunk;
+
 	if (len >= CRC32C_PCL_BREAKEVEN && crypto_simd_usable()) {
-		kernel_fpu_begin();
-		*(__le32 *)out = ~cpu_to_le32(crc_pcl(data, len, *crcp));
-		kernel_fpu_end();
+		do {
+			chunk = min(len, FPU_BYTES);
+			len -= chunk;
+
+			kernel_fpu_begin();
+			*crcp = crc_pcl(data, chunk, *crcp);
+			kernel_fpu_end();
+
+			data += chunk;
+		} while (len);
+		*(__le32 *)out = ~cpu_to_le32(*crcp);
 	} else
 		*(__le32 *)out =
 			~cpu_to_le32(crc32c_intel_le_hw(*crcp, data, len));
diff --git a/arch/x86/crypto/crct10dif-pclmul_glue.c b/arch/x86/crypto/crct10dif-pclmul_glue.c
index 7c5a32282d51..bcd362df6b62 100644
--- a/arch/x86/crypto/crct10dif-pclmul_glue.c
+++ b/arch/x86/crypto/crct10dif-pclmul_glue.c
@@ -36,6 +36,8 @@
 #include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+
 asmlinkage u16 crc_t10dif_pcl(u16 init_crc, const u8 *buf, size_t len);
 
 struct chksum_desc_ctx {
@@ -55,11 +57,19 @@ static int chksum_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int length)
 {
 	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
+	unsigned int chunk;
 
 	if (length >= 16 && crypto_simd_usable()) {
-		kernel_fpu_begin();
-		ctx->crc = crc_t10dif_pcl(ctx->crc, data, length);
-		kernel_fpu_end();
+		do {
+			chunk = min(length, FPU_BYTES);
+			length -= chunk;
+
+			kernel_fpu_begin();
+			ctx->crc = crc_t10dif_pcl(ctx->crc, data, chunk);
+			kernel_fpu_end();
+
+			data += chunk;
+		} while (length);
 	} else
 		ctx->crc = crc_t10dif_generic(ctx->crc, data, length);
 	return 0;
@@ -75,10 +85,20 @@ static int chksum_final(struct shash_desc *desc, u8 *out)
 
 static int __chksum_finup(__u16 crc, const u8 *data, unsigned int len, u8 *out)
 {
+	unsigned int chunk;
+
 	if (len >= 16 && crypto_simd_usable()) {
-		kernel_fpu_begin();
-		*(__u16 *)out = crc_t10dif_pcl(crc, data, len);
-		kernel_fpu_end();
+		do {
+			chunk = min(len, FPU_BYTES);
+			len -= chunk;
+
+			kernel_fpu_begin();
+			crc = crc_t10dif_pcl(crc, data, chunk);
+			kernel_fpu_end();
+
+			data += chunk;
+		} while (len);
+		*(__u16 *)out = crc;
 	} else
 		*(__u16 *)out = crc_t10dif_generic(crc, data, len);
 	return 0;
-- 
2.37.3

