Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299B561757D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiKCE2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiKCE2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:28:21 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EC3210;
        Wed,  2 Nov 2022 21:28:20 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A338Wpm012666;
        Thu, 3 Nov 2022 04:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=kDCsigLBc4RiVTNQSgXraDq+QR2Ctzc5DZfvh4IK8G0=;
 b=D5sARtk96vU0kMAXcZa/k38vmxhz4Nv8A8uIwRD6MLhHvWSQSkLL95eiAbbOgzDjkpQt
 eBDcdTZnSUlsDtlSyT5H59sB5Dmk9JUGagQwaFLxi+Jm5u/Ymp3xcaB04Rw1ioHAzslJ
 Nhkrtjv6eNF4CI1lVNt46v999hdb6xyTFiOXWBRcpgHWSaPPiKSOgmZxFYTEdxGFZCFs
 MMqeVxoPcb00+AtFlyhGebHTzKgS7+C8sxvE23+mbc9DPQE28YsMDeC2mjhJs2u9MrM3
 1yxZepQwVp7ltBODjODCj7jLIOYZl+8tzHlyYmJVGm4hz7QZmnPMSC7y/ZXqCY2Ri6ZR 2w== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3km2pfhdey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 04:28:11 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id BFB22D2AE;
        Thu,  3 Nov 2022 04:28:10 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 4DA1180A0FF;
        Thu,  3 Nov 2022 04:28:10 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 05/17] crypto: x86/crc - limit FPU preemption
Date:   Wed,  2 Nov 2022 23:27:28 -0500
Message-Id: <20221103042740.6556-6-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221103042740.6556-1-elliott@hpe.com>
References: <20221012215931.3896-1-elliott@hpe.com>
 <20221103042740.6556-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kuDi_pUWUsV-mfcQTfoU9DP58tPkJBJP
X-Proofpoint-ORIG-GUID: kuDi_pUWUsV-mfcQTfoU9DP58tPkJBJP
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 phishscore=0 suspectscore=0
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
the CPU core is unavailable for scheduling while running, leading to:
    rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: ...

Fixes: 78c37d191dd6 ("crypto: crc32 - add crc32 pclmulqdq implementation and wrappers for table implementation")
Fixes: 6a8ce1ef3940 ("crypto: crc32c - Optimize CRC32C calculation with PCLMULQDQ instruction")
Fixes: 0b95a7f85718 ("crypto: crct10dif - Glue code to cast accelerated CRCT10DIF assembly as a crypto transform")
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Robert Elliott <elliott@hpe.com>

---
v3 use while loops and static int, simplify one of the loop structures,
add algorithm-specific limits, use local stack variable in crc32 finup
rather than the context pointer like update uses
---
 arch/x86/crypto/crc32-pclmul_asm.S      |  6 +--
 arch/x86/crypto/crc32-pclmul_glue.c     | 27 +++++++++----
 arch/x86/crypto/crc32c-intel_glue.c     | 52 ++++++++++++++++++-------
 arch/x86/crypto/crct10dif-pclmul_glue.c | 48 +++++++++++++++++------
 4 files changed, 99 insertions(+), 34 deletions(-)

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
index 98cf3b4e4c9f..df3dbc754818 100644
--- a/arch/x86/crypto/crc32-pclmul_glue.c
+++ b/arch/x86/crypto/crc32-pclmul_glue.c
@@ -46,6 +46,9 @@
 #define SCALE_F			16L	/* size of xmm register */
 #define SCALE_F_MASK		(SCALE_F - 1)
 
+/* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+static const unsigned int bytes_per_fpu = 655 * 1024;
+
 u32 crc32_pclmul_le_16(unsigned char const *buffer, size_t len, u32 crc32);
 
 static u32 __attribute__((pure))
@@ -55,6 +58,9 @@ static u32 __attribute__((pure))
 	unsigned int iremainder;
 	unsigned int prealign;
 
+	BUILD_BUG_ON(bytes_per_fpu < PCLMUL_MIN_LEN);
+	BUILD_BUG_ON(bytes_per_fpu & SCALE_F_MASK);
+
 	if (len < PCLMUL_MIN_LEN + SCALE_F_MASK || !crypto_simd_usable())
 		return crc32_le(crc, p, len);
 
@@ -70,12 +76,19 @@ static u32 __attribute__((pure))
 	iquotient = len & (~SCALE_F_MASK);
 	iremainder = len & SCALE_F_MASK;
 
-	kernel_fpu_begin();
-	crc = crc32_pclmul_le_16(p, iquotient, crc);
-	kernel_fpu_end();
+	while (iquotient >= PCLMUL_MIN_LEN) {
+		unsigned int chunk = min(iquotient, bytes_per_fpu);
+
+		kernel_fpu_begin();
+		crc = crc32_pclmul_le_16(p, chunk, crc);
+		kernel_fpu_end();
+
+		iquotient -= chunk;
+		p += chunk;
+	}
 
-	if (iremainder)
-		crc = crc32_le(crc, p + iquotient, iremainder);
+	if (iquotient || iremainder)
+		crc = crc32_le(crc, p, iquotient + iremainder);
 
 	return crc;
 }
@@ -120,8 +133,8 @@ static int crc32_pclmul_update(struct shash_desc *desc, const u8 *data,
 }
 
 /* No final XOR 0xFFFFFFFF, like crc32_le */
-static int __crc32_pclmul_finup(u32 *crcp, const u8 *data, unsigned int len,
-				u8 *out)
+static int __crc32_pclmul_finup(const u32 *crcp, const u8 *data,
+				unsigned int len, u8 *out)
 {
 	*(__le32 *)out = cpu_to_le32(crc32_pclmul_le(*crcp, data, len));
 	return 0;
diff --git a/arch/x86/crypto/crc32c-intel_glue.c b/arch/x86/crypto/crc32c-intel_glue.c
index feccb5254c7e..f08ed68ec93d 100644
--- a/arch/x86/crypto/crc32c-intel_glue.c
+++ b/arch/x86/crypto/crc32c-intel_glue.c
@@ -45,7 +45,10 @@ asmlinkage unsigned int crc_pcl(const u8 *buffer, int len,
 				unsigned int crc_init);
 #endif /* CONFIG_X86_64 */
 
-static u32 crc32c_intel_le_hw_byte(u32 crc, unsigned char const *data, size_t length)
+/* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+static const unsigned int bytes_per_fpu = 868 * 1024;
+
+static u32 crc32c_intel_le_hw_byte(u32 crc, const unsigned char *data, size_t length)
 {
 	while (length--) {
 		asm("crc32b %1, %0"
@@ -56,7 +59,7 @@ static u32 crc32c_intel_le_hw_byte(u32 crc, unsigned char const *data, size_t le
 	return crc;
 }
 
-static u32 __pure crc32c_intel_le_hw(u32 crc, unsigned char const *p, size_t len)
+static u32 __pure crc32c_intel_le_hw(u32 crc, const unsigned char *p, size_t len)
 {
 	unsigned int iquotient = len / SCALE_F;
 	unsigned int iremainder = len % SCALE_F;
@@ -110,8 +113,8 @@ static int crc32c_intel_update(struct shash_desc *desc, const u8 *data,
 	return 0;
 }
 
-static int __crc32c_intel_finup(u32 *crcp, const u8 *data, unsigned int len,
-				u8 *out)
+static int __crc32c_intel_finup(const u32 *crcp, const u8 *data,
+				unsigned int len, u8 *out)
 {
 	*(__le32 *)out = ~cpu_to_le32(crc32c_intel_le_hw(*crcp, data, len));
 	return 0;
@@ -153,29 +156,52 @@ static int crc32c_pcl_intel_update(struct shash_desc *desc, const u8 *data,
 {
 	u32 *crcp = shash_desc_ctx(desc);
 
+	BUILD_BUG_ON(bytes_per_fpu < CRC32C_PCL_BREAKEVEN);
+	BUILD_BUG_ON(bytes_per_fpu % SCALE_F);
+
 	/*
 	 * use faster PCL version if datasize is large enough to
 	 * overcome kernel fpu state save/restore overhead
 	 */
 	if (len >= CRC32C_PCL_BREAKEVEN && crypto_simd_usable()) {
-		kernel_fpu_begin();
-		*crcp = crc_pcl(data, len, *crcp);
-		kernel_fpu_end();
+		while (len) {
+			unsigned int chunk = min(len, bytes_per_fpu);
+
+			kernel_fpu_begin();
+			*crcp = crc_pcl(data, chunk, *crcp);
+			kernel_fpu_end();
+
+			len -= chunk;
+			data += chunk;
+		}
 	} else
 		*crcp = crc32c_intel_le_hw(*crcp, data, len);
 	return 0;
 }
 
-static int __crc32c_pcl_intel_finup(u32 *crcp, const u8 *data, unsigned int len,
-				u8 *out)
+static int __crc32c_pcl_intel_finup(const u32 *crcp, const u8 *data,
+				    unsigned int len, u8 *out)
 {
+	u32 crc = *crcp;
+
+	BUILD_BUG_ON(bytes_per_fpu < CRC32C_PCL_BREAKEVEN);
+	BUILD_BUG_ON(bytes_per_fpu % SCALE_F);
+
 	if (len >= CRC32C_PCL_BREAKEVEN && crypto_simd_usable()) {
-		kernel_fpu_begin();
-		*(__le32 *)out = ~cpu_to_le32(crc_pcl(data, len, *crcp));
-		kernel_fpu_end();
+		while (len) {
+			unsigned int chunk = min(len, bytes_per_fpu);
+
+			kernel_fpu_begin();
+			crc = crc_pcl(data, chunk, crc);
+			kernel_fpu_end();
+
+			len -= chunk;
+			data += chunk;
+		}
+		*(__le32 *)out = ~cpu_to_le32(crc);
 	} else
 		*(__le32 *)out =
-			~cpu_to_le32(crc32c_intel_le_hw(*crcp, data, len));
+			~cpu_to_le32(crc32c_intel_le_hw(crc, data, len));
 	return 0;
 }
 
diff --git a/arch/x86/crypto/crct10dif-pclmul_glue.c b/arch/x86/crypto/crct10dif-pclmul_glue.c
index 71291d5af9f4..4f6b8c727d88 100644
--- a/arch/x86/crypto/crct10dif-pclmul_glue.c
+++ b/arch/x86/crypto/crct10dif-pclmul_glue.c
@@ -34,6 +34,11 @@
 #include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
+#define PCLMUL_MIN_LEN 16U /* minimum size of buffer for crc_t10dif_pcl */
+
+/* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+static const unsigned int bytes_per_fpu = 614 * 1024;
+
 asmlinkage u16 crc_t10dif_pcl(u16 init_crc, const u8 *buf, size_t len);
 
 struct chksum_desc_ctx {
@@ -54,11 +59,21 @@ static int chksum_update(struct shash_desc *desc, const u8 *data,
 {
 	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
 
-	if (length >= 16 && crypto_simd_usable()) {
-		kernel_fpu_begin();
-		ctx->crc = crc_t10dif_pcl(ctx->crc, data, length);
-		kernel_fpu_end();
-	} else
+	BUILD_BUG_ON(bytes_per_fpu < PCLMUL_MIN_LEN);
+
+	if (length >= PCLMUL_MIN_LEN && crypto_simd_usable()) {
+		while (length >= PCLMUL_MIN_LEN) {
+			unsigned int chunk = min(length, bytes_per_fpu);
+
+			kernel_fpu_begin();
+			ctx->crc = crc_t10dif_pcl(ctx->crc, data, chunk);
+			kernel_fpu_end();
+
+			length -= chunk;
+			data += chunk;
+		}
+	}
+	if (length)
 		ctx->crc = crc_t10dif_generic(ctx->crc, data, length);
 	return 0;
 }
@@ -73,12 +88,23 @@ static int chksum_final(struct shash_desc *desc, u8 *out)
 
 static int __chksum_finup(__u16 crc, const u8 *data, unsigned int len, u8 *out)
 {
-	if (len >= 16 && crypto_simd_usable()) {
-		kernel_fpu_begin();
-		*(__u16 *)out = crc_t10dif_pcl(crc, data, len);
-		kernel_fpu_end();
-	} else
-		*(__u16 *)out = crc_t10dif_generic(crc, data, len);
+	BUILD_BUG_ON(bytes_per_fpu < PCLMUL_MIN_LEN);
+
+	if (len >= PCLMUL_MIN_LEN && crypto_simd_usable()) {
+		while (len >= PCLMUL_MIN_LEN) {
+			unsigned int chunk = min(len, bytes_per_fpu);
+
+			kernel_fpu_begin();
+			crc = crc_t10dif_pcl(crc, data, chunk);
+			kernel_fpu_end();
+
+			len -= chunk;
+			data += chunk;
+		}
+	}
+	if (len)
+		crc = crc_t10dif_generic(crc, data, len);
+	*(__u16 *)out = crc;
 	return 0;
 }
 
-- 
2.37.3

