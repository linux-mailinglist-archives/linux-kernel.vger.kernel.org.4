Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C825651543
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiLSWER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbiLSWDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:03:33 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9035B140D1;
        Mon, 19 Dec 2022 14:03:20 -0800 (PST)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJK6Pu2024283;
        Mon, 19 Dec 2022 22:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=Fw7SMOXU0AU3aza6EQK5/61RTV3W7f05AzzXrFzmOik=;
 b=a5+TnjmsrVS/fBlkPFiDHskIFCiHBEK+zWoazCcXt5elIrnK9M/HRq/3NlicIKuwdcOH
 6x3zU0Xs1eeOyHYKnYgL7ZWCgeo9mWRqsOv5J4nk5pFScZwCZoSYmuS8GX5SourExhU0
 KSoNywxMVUTMhyh6CJcfDm3sV6tqCTcz1N9m52JetyJ5BccqlvqWOaRaBaLEj/0SRlAt
 TBmzVALCtwe/R0Nox0q/QBG7owRcItwBBkWkcjmH1b4CzsthLsyns2OF4l3Vq5j91RHl
 er/o+L7Zf8k8w9es4A7jmHVkso3ZK/eBbOqk5UcK945re21rsrOtgegIcr2UEJVLcKIz 9Q== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3mjvh69gnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 22:02:50 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 5E9D880711F;
        Mon, 19 Dec 2022 22:02:49 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 92F7E805634;
        Mon, 19 Dec 2022 22:02:48 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, Jason@zx2c4.com,
        ardb@kernel.org, ap420073@gmail.com, David.Laight@ACULAB.COM,
        ebiggers@kernel.org, tim.c.chen@linux.intel.com, peter@n8pjl.ca,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 04/13] crypto: x86/crc - yield FPU context during long loops
Date:   Mon, 19 Dec 2022 16:02:14 -0600
Message-Id: <20221219220223.3982176-5-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219220223.3982176-1-elliott@hpe.com>
References: <20221219220223.3982176-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4FevuVYEbMsP_5mKNtJVYHc63lHdLsiw
X-Proofpoint-ORIG-GUID: 4FevuVYEbMsP_5mKNtJVYHc63lHdLsiw
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

For crc32, add a pre-alignment loop so the assembly language
function is not repeatedly called with an unaligned starting
address.

Fixes: 78c37d191dd6 ("crypto: crc32 - add crc32 pclmulqdq implementation and wrappers for table implementation")
Fixes: 6a8ce1ef3940 ("crypto: crc32c - Optimize CRC32C calculation with PCLMULQDQ instruction")
Fixes: 0b95a7f85718 ("crypto: crct10dif - Glue code to cast accelerated CRCT10DIF assembly as a crypto transform")
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/crc32-pclmul_glue.c     |  49 +++++-----
 arch/x86/crypto/crc32c-intel_glue.c     | 118 +++++++++++++++++-------
 arch/x86/crypto/crct10dif-pclmul_glue.c |  65 ++++++++++---
 3 files changed, 165 insertions(+), 67 deletions(-)

diff --git a/arch/x86/crypto/crc32-pclmul_glue.c b/arch/x86/crypto/crc32-pclmul_glue.c
index 98cf3b4e4c9f..3692b50faf1c 100644
--- a/arch/x86/crypto/crc32-pclmul_glue.c
+++ b/arch/x86/crypto/crc32-pclmul_glue.c
@@ -41,41 +41,50 @@
 #define CHKSUM_BLOCK_SIZE	1
 #define CHKSUM_DIGEST_SIZE	4
 
-#define PCLMUL_MIN_LEN		64L     /* minimum size of buffer
-					 * for crc32_pclmul_le_16 */
-#define SCALE_F			16L	/* size of xmm register */
+#define PCLMUL_MIN_LEN		64U     /* minimum size of buffer for crc32_pclmul_le_16 */
+#define SCALE_F			16U	/* size of xmm register */
 #define SCALE_F_MASK		(SCALE_F - 1)
 
-u32 crc32_pclmul_le_16(unsigned char const *buffer, size_t len, u32 crc32);
+asmlinkage u32 crc32_pclmul_le_16(const u8 *buffer, unsigned int len, u32 crc32);
 
-static u32 __attribute__((pure))
-	crc32_pclmul_le(u32 crc, unsigned char const *p, size_t len)
+static u32 crc32_pclmul_le(u32 crc, const u8 *p, unsigned int len)
 {
 	unsigned int iquotient;
 	unsigned int iremainder;
-	unsigned int prealign;
 
 	if (len < PCLMUL_MIN_LEN + SCALE_F_MASK || !crypto_simd_usable())
 		return crc32_le(crc, p, len);
 
-	if ((long)p & SCALE_F_MASK) {
+	if ((unsigned long)p & SCALE_F_MASK) {
 		/* align p to 16 byte */
-		prealign = SCALE_F - ((long)p & SCALE_F_MASK);
+		unsigned int prealign = SCALE_F - ((unsigned long)p & SCALE_F_MASK);
 
 		crc = crc32_le(crc, p, prealign);
 		len -= prealign;
-		p = (unsigned char *)(((unsigned long)p + SCALE_F_MASK) &
-				     ~SCALE_F_MASK);
+		p += prealign;
 	}
-	iquotient = len & (~SCALE_F_MASK);
+	iquotient = len & ~SCALE_F_MASK;
 	iremainder = len & SCALE_F_MASK;
 
-	kernel_fpu_begin();
-	crc = crc32_pclmul_le_16(p, iquotient, crc);
-	kernel_fpu_end();
+	if (iquotient) {
+		kernel_fpu_begin();
+		for (;;) {
+			const unsigned int chunk = min(iquotient, 4096U);
 
-	if (iremainder)
-		crc = crc32_le(crc, p + iquotient, iremainder);
+			crc = crc32_pclmul_le_16(p, chunk, crc);
+			iquotient -= chunk;
+			p += chunk;
+
+			if (iquotient < PCLMUL_MIN_LEN)
+				break;
+
+			kernel_fpu_yield();
+		}
+		kernel_fpu_end();
+	}
+
+	if (iquotient || iremainder)
+		crc = crc32_le(crc, p, iquotient + iremainder);
 
 	return crc;
 }
@@ -120,8 +129,7 @@ static int crc32_pclmul_update(struct shash_desc *desc, const u8 *data,
 }
 
 /* No final XOR 0xFFFFFFFF, like crc32_le */
-static int __crc32_pclmul_finup(u32 *crcp, const u8 *data, unsigned int len,
-				u8 *out)
+static int __crc32_pclmul_finup(u32 *crcp, const u8 *data, unsigned int len, u8 *out)
 {
 	*(__le32 *)out = cpu_to_le32(crc32_pclmul_le(*crcp, data, len));
 	return 0;
@@ -144,8 +152,7 @@ static int crc32_pclmul_final(struct shash_desc *desc, u8 *out)
 static int crc32_pclmul_digest(struct shash_desc *desc, const u8 *data,
 			       unsigned int len, u8 *out)
 {
-	return __crc32_pclmul_finup(crypto_shash_ctx(desc->tfm), data, len,
-				    out);
+	return __crc32_pclmul_finup(crypto_shash_ctx(desc->tfm), data, len, out);
 }
 
 static struct shash_alg alg = {
diff --git a/arch/x86/crypto/crc32c-intel_glue.c b/arch/x86/crypto/crc32c-intel_glue.c
index feccb5254c7e..932574661ef5 100644
--- a/arch/x86/crypto/crc32c-intel_glue.c
+++ b/arch/x86/crypto/crc32c-intel_glue.c
@@ -35,19 +35,24 @@
 
 #ifdef CONFIG_X86_64
 /*
- * use carryless multiply version of crc32c when buffer
- * size is >= 512 to account
- * for fpu state save/restore overhead.
+ * only use crc_pcl() (carryless multiply version of crc32c) when buffer
+ * size is >= 512 to account for fpu state save/restore overhead.
  */
 #define CRC32C_PCL_BREAKEVEN	512
 
-asmlinkage unsigned int crc_pcl(const u8 *buffer, int len,
-				unsigned int crc_init);
+/*
+ * only pass aligned buffers to crc_pcl() to avoid special handling
+ * in each pass
+ */
+#define ALIGN_CRCPCL		16U
+#define ALIGN_CRCPCL_MASK	(ALIGN_CRCPCL - 1)
+
+asmlinkage u32 crc_pcl(const u8 *buffer, u64 len, u32 crc_init);
 #endif /* CONFIG_X86_64 */
 
-static u32 crc32c_intel_le_hw_byte(u32 crc, unsigned char const *data, size_t length)
+static u32 crc32c_intel_le_hw_byte(u32 crc, const u8 *data, unsigned int len)
 {
-	while (length--) {
+	while (len--) {
 		asm("crc32b %1, %0"
 		    : "+r" (crc) : "rm" (*data));
 		data++;
@@ -56,7 +61,7 @@ static u32 crc32c_intel_le_hw_byte(u32 crc, unsigned char const *data, size_t le
 	return crc;
 }
 
-static u32 __pure crc32c_intel_le_hw(u32 crc, unsigned char const *p, size_t len)
+static u32 __pure crc32c_intel_le_hw(u32 crc, const u8 *p, unsigned int len)
 {
 	unsigned int iquotient = len / SCALE_F;
 	unsigned int iremainder = len % SCALE_F;
@@ -69,8 +74,7 @@ static u32 __pure crc32c_intel_le_hw(u32 crc, unsigned char const *p, size_t len
 	}
 
 	if (iremainder)
-		crc = crc32c_intel_le_hw_byte(crc, (unsigned char *)ptmp,
-				 iremainder);
+		crc = crc32c_intel_le_hw_byte(crc, (u8 *)ptmp, iremainder);
 
 	return crc;
 }
@@ -110,8 +114,8 @@ static int crc32c_intel_update(struct shash_desc *desc, const u8 *data,
 	return 0;
 }
 
-static int __crc32c_intel_finup(u32 *crcp, const u8 *data, unsigned int len,
-				u8 *out)
+static int __crc32c_intel_finup(const u32 *crcp, const u8 *data,
+				unsigned int len, u8 *out)
 {
 	*(__le32 *)out = ~cpu_to_le32(crc32c_intel_le_hw(*crcp, data, len));
 	return 0;
@@ -134,8 +138,7 @@ static int crc32c_intel_final(struct shash_desc *desc, u8 *out)
 static int crc32c_intel_digest(struct shash_desc *desc, const u8 *data,
 			       unsigned int len, u8 *out)
 {
-	return __crc32c_intel_finup(crypto_shash_ctx(desc->tfm), data, len,
-				    out);
+	return __crc32c_intel_finup(crypto_shash_ctx(desc->tfm), data, len, out);
 }
 
 static int crc32c_intel_cra_init(struct crypto_tfm *tfm)
@@ -149,47 +152,96 @@ static int crc32c_intel_cra_init(struct crypto_tfm *tfm)
 
 #ifdef CONFIG_X86_64
 static int crc32c_pcl_intel_update(struct shash_desc *desc, const u8 *data,
-			       unsigned int len)
+				   unsigned int len)
 {
 	u32 *crcp = shash_desc_ctx(desc);
+	u32 crc;
+
+	BUILD_BUG_ON(CRC32C_PCL_BREAKEVEN > 4096U);
 
 	/*
 	 * use faster PCL version if datasize is large enough to
 	 * overcome kernel fpu state save/restore overhead
 	 */
-	if (len >= CRC32C_PCL_BREAKEVEN && crypto_simd_usable()) {
-		kernel_fpu_begin();
-		*crcp = crc_pcl(data, len, *crcp);
-		kernel_fpu_end();
-	} else
+	if (len < CRC32C_PCL_BREAKEVEN + ALIGN_CRCPCL_MASK || !crypto_simd_usable()) {
 		*crcp = crc32c_intel_le_hw(*crcp, data, len);
+		return 0;
+	}
+
+	crc = *crcp;
+	/*
+	 * Although crc_pcl() supports unaligned buffers, it is more efficient
+	 * handling a 16-byte aligned buffer.
+	 */
+	if ((unsigned long)data & ALIGN_CRCPCL_MASK) {
+		unsigned int prealign = ALIGN_CRCPCL - ((unsigned long)data & ALIGN_CRCPCL_MASK);
+
+		crc = crc32c_intel_le_hw(crc, data, prealign);
+		len -= prealign;
+		data += prealign;
+	}
+
+	kernel_fpu_begin();
+	for (;;) {
+		const unsigned int chunk = min(len, 4096U);
+
+		crc = crc_pcl(data, chunk, crc);
+		len -= chunk;
+
+		if (!len)
+			break;
+
+		data += chunk;
+		kernel_fpu_yield();
+	}
+	kernel_fpu_end();
+
+	*crcp = crc;
 	return 0;
 }
 
-static int __crc32c_pcl_intel_finup(u32 *crcp, const u8 *data, unsigned int len,
-				u8 *out)
+static int __crc32c_pcl_intel_finup(const u32 *crcp, const u8 *data,
+				    unsigned int len, u8 *out)
 {
-	if (len >= CRC32C_PCL_BREAKEVEN && crypto_simd_usable()) {
-		kernel_fpu_begin();
-		*(__le32 *)out = ~cpu_to_le32(crc_pcl(data, len, *crcp));
-		kernel_fpu_end();
-	} else
-		*(__le32 *)out =
-			~cpu_to_le32(crc32c_intel_le_hw(*crcp, data, len));
+	u32 crc;
+
+	BUILD_BUG_ON(CRC32C_PCL_BREAKEVEN > 4096U);
+
+	if (len < CRC32C_PCL_BREAKEVEN || !crypto_simd_usable()) {
+		*(__le32 *)out = ~cpu_to_le32(crc32c_intel_le_hw(*crcp, data, len));
+		return 0;
+	}
+
+	crc = *crcp;
+	kernel_fpu_begin();
+	for (;;) {
+		const unsigned int chunk = min(len, 4096U);
+
+		crc = crc_pcl(data, chunk, crc);
+		len -= chunk;
+
+		if (!len)
+			break;
+
+		data += chunk;
+		kernel_fpu_yield();
+	}
+	kernel_fpu_end();
+
+	*(__le32 *)out = ~cpu_to_le32(crc);
 	return 0;
 }
 
 static int crc32c_pcl_intel_finup(struct shash_desc *desc, const u8 *data,
-			      unsigned int len, u8 *out)
+				  unsigned int len, u8 *out)
 {
 	return __crc32c_pcl_intel_finup(shash_desc_ctx(desc), data, len, out);
 }
 
 static int crc32c_pcl_intel_digest(struct shash_desc *desc, const u8 *data,
-			       unsigned int len, u8 *out)
+				   unsigned int len, u8 *out)
 {
-	return __crc32c_pcl_intel_finup(crypto_shash_ctx(desc->tfm), data, len,
-				    out);
+	return __crc32c_pcl_intel_finup(crypto_shash_ctx(desc->tfm), data, len, out);
 }
 #endif /* CONFIG_X86_64 */
 
diff --git a/arch/x86/crypto/crct10dif-pclmul_glue.c b/arch/x86/crypto/crct10dif-pclmul_glue.c
index 71291d5af9f4..4d39eac94289 100644
--- a/arch/x86/crypto/crct10dif-pclmul_glue.c
+++ b/arch/x86/crypto/crct10dif-pclmul_glue.c
@@ -34,6 +34,8 @@
 #include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
+#define PCLMUL_MIN_LEN 16U /* minimum size of buffer for crc_t10dif_pcl */
+
 asmlinkage u16 crc_t10dif_pcl(u16 init_crc, const u8 *buf, size_t len);
 
 struct chksum_desc_ctx {
@@ -49,17 +51,36 @@ static int chksum_init(struct shash_desc *desc)
 	return 0;
 }
 
-static int chksum_update(struct shash_desc *desc, const u8 *data,
-			 unsigned int length)
+static int chksum_update(struct shash_desc *desc, const u8 *data, unsigned int len)
 {
 	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
+	u16 crc;
+
+	if (len < PCLMUL_MIN_LEN || !crypto_simd_usable()) {
+		ctx->crc = crc_t10dif_generic(ctx->crc, data, len);
+		return 0;
+	}
+
+	crc = ctx->crc;
+	kernel_fpu_begin();
+	for (;;) {
+		const unsigned int chunk = min(len, 4096U);
+
+		crc = crc_t10dif_pcl(crc, data, chunk);
+		len -= chunk;
+		data += chunk;
+
+		if (len < PCLMUL_MIN_LEN)
+			break;
+
+		kernel_fpu_yield();
+	}
+	kernel_fpu_end();
+
+	if (len)
+		crc = crc_t10dif_generic(crc, data, len);
 
-	if (length >= 16 && crypto_simd_usable()) {
-		kernel_fpu_begin();
-		ctx->crc = crc_t10dif_pcl(ctx->crc, data, length);
-		kernel_fpu_end();
-	} else
-		ctx->crc = crc_t10dif_generic(ctx->crc, data, length);
+	ctx->crc = crc;
 	return 0;
 }
 
@@ -73,12 +94,30 @@ static int chksum_final(struct shash_desc *desc, u8 *out)
 
 static int __chksum_finup(__u16 crc, const u8 *data, unsigned int len, u8 *out)
 {
-	if (len >= 16 && crypto_simd_usable()) {
-		kernel_fpu_begin();
-		*(__u16 *)out = crc_t10dif_pcl(crc, data, len);
-		kernel_fpu_end();
-	} else
+	if (len < PCLMUL_MIN_LEN || !crypto_simd_usable()) {
 		*(__u16 *)out = crc_t10dif_generic(crc, data, len);
+		return 0;
+	}
+
+	kernel_fpu_begin();
+	for (;;) {
+		const unsigned int chunk = min(len, 4096U);
+
+		crc = crc_t10dif_pcl(crc, data, chunk);
+		len -= chunk;
+		data += chunk;
+
+		if (len < PCLMUL_MIN_LEN)
+			break;
+
+		kernel_fpu_yield();
+	}
+	kernel_fpu_end();
+
+	if (len)
+		crc = crc_t10dif_generic(crc, data, len);
+
+	*(__u16 *)out = crc;
 	return 0;
 }
 
-- 
2.38.1

