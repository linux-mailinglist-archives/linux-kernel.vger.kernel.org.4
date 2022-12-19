Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5601651545
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiLSWEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiLSWDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:03:35 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B140140F8;
        Mon, 19 Dec 2022 14:03:22 -0800 (PST)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJKW2xn028221;
        Mon, 19 Dec 2022 22:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=AEloZssES2RC7BH2BiqVkRNNWZvMUr3nP3cZeI400jg=;
 b=cAbaJLlrHwY+t2yJT1Q1k41/eKiApkIZBwnKcdK3YSq0J8bem9gPVeNq07fTUbM4UY23
 QG6eQO3MKwq+E+s20Qp0ZJig3POddIlluStUgdYoMQxRnDn+eoVKqAsWhitkXVRPVpLd
 Fkal101DFUx+grt3BpN0HarCpfevjef0ZCtvneWpTntgD7LMt39D8dFfGRFuNG7p7GdV
 DQkrzFhSMzAlSof4dAxCHoq+pXUvYfEtbTkFVE2EPzmo8sJVNjs4MwBb7ydPGMi4u3bs
 ih2VpcZi/P8LhwF4Qxc7VXffzWHiebuiuDuUPKoVWuRyBRMYQtn9GidvuqzdxPH7Ijka WQ== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3mjx3b10xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 22:02:54 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id F270C801722;
        Mon, 19 Dec 2022 22:02:52 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 31411805E9F;
        Mon, 19 Dec 2022 22:02:52 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, Jason@zx2c4.com,
        ardb@kernel.org, ap420073@gmail.com, David.Laight@ACULAB.COM,
        ebiggers@kernel.org, tim.c.chen@linux.intel.com, peter@n8pjl.ca,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 06/13] crypto: x86/ghash - use u8 rather than char
Date:   Mon, 19 Dec 2022 16:02:16 -0600
Message-Id: <20221219220223.3982176-7-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219220223.3982176-1-elliott@hpe.com>
References: <20221219220223.3982176-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: W0daaAMd-lf2JY2jF3r3OO2XyX_3vs9G
X-Proofpoint-GUID: W0daaAMd-lf2JY2jF3r3OO2XyX_3vs9G
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212190193
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use more consistent unambivalent types (u8 rather than char)
for the source and destination buffer pointer arguments for
the asm functions.

Reference them with "asmlinkage" as well.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/ghash-clmulni-intel_asm.S  | 6 +++---
 arch/x86/crypto/ghash-clmulni-intel_glue.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/crypto/ghash-clmulni-intel_asm.S b/arch/x86/crypto/ghash-clmulni-intel_asm.S
index 09cf9271b83a..ad860836f75b 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_asm.S
+++ b/arch/x86/crypto/ghash-clmulni-intel_asm.S
@@ -96,7 +96,7 @@ SYM_FUNC_END(__clmul_gf128mul_ble)
  * This supports 64-bit CPUs.
  *
  * Return:	none (but @dst is updated)
- * Prototype:	asmlinkage void clmul_ghash_mul(char *dst, const u128 *shash)
+ * Prototype:	asmlinkage void clmul_ghash_mul(u8 *dst, const u128 *shash)
  */
 SYM_FUNC_START(clmul_ghash_mul)
 	FRAME_BEGIN
@@ -122,8 +122,8 @@ SYM_FUNC_END(clmul_ghash_mul)
  * This supports 64-bit CPUs.
  *
  * Return:	none (but @dst is updated)
- * Prototype:	asmlinkage clmul_ghash_update(char *dst, const char *src,
- *					      unsigned int srclen, const u128 *shash);
+ * Prototype:	asmlinkage void clmul_ghash_update(u8 *dst, const u8 *src,
+ *						   unsigned int srclen, const u128 *shash);
  */
 SYM_FUNC_START(clmul_ghash_update)
 	FRAME_BEGIN
diff --git a/arch/x86/crypto/ghash-clmulni-intel_glue.c b/arch/x86/crypto/ghash-clmulni-intel_glue.c
index 1f1a95f3dd0c..beac4b2eddf6 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_glue.c
+++ b/arch/x86/crypto/ghash-clmulni-intel_glue.c
@@ -23,10 +23,10 @@
 #define GHASH_BLOCK_SIZE	16
 #define GHASH_DIGEST_SIZE	16
 
-void clmul_ghash_mul(char *dst, const u128 *shash);
+asmlinkage void clmul_ghash_mul(u8 *dst, const u128 *shash);
 
-void clmul_ghash_update(char *dst, const char *src, unsigned int srclen,
-			const u128 *shash);
+asmlinkage void clmul_ghash_update(u8 *dst, const u8 *src, unsigned int srclen,
+				   const u128 *shash);
 
 struct ghash_async_ctx {
 	struct cryptd_ahash *cryptd_tfm;
-- 
2.38.1

