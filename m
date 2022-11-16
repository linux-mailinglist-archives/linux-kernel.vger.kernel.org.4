Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F00762B228
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 05:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiKPEOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 23:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiKPEOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 23:14:20 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF25D31EEE;
        Tue, 15 Nov 2022 20:14:17 -0800 (PST)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG4DcFj023372;
        Wed, 16 Nov 2022 04:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=ukwY7JIs/U1Bbbab6Ibms4gk638cl7c9kt9xB3XTx+A=;
 b=kxttb0P+LQ79UvpnOJTgvoNBaX+a399Fm4RabsyfNJgL/DQ1hu3D53f8gFqmawaX/CW5
 /0uhDA/QWWIyEChrsiqXX9gQuBX6ei89re5gpt5kz6B46PBBZ408seJ2rMykvjZ1/zoK
 UQCHlW09ObeR3uWq5/9313MGb9erqRf6TsAWILfWPttfai/DYFkw8sTp/A5OWe2470D9
 VWQgWSvPUmZasNsDSPB0P6j2TsDytFuAT/d7e2KbJtOH6SQ4hN6LeeAubnF5MRLJPAPB
 QrLhezUGNR7WmZiypRfwpmKl6p6ecDUDRN/fkyTtjPSuzhGjRCVUeyVMwjV2FFPgZL4h IA== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kvrmng06w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 04:14:02 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id B62102EEE8;
        Wed, 16 Nov 2022 04:14:01 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 46F70808B9A;
        Wed, 16 Nov 2022 04:14:01 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v4 07/24] crypto: x86/ghash - use u8 rather than char
Date:   Tue, 15 Nov 2022 22:13:25 -0600
Message-Id: <20221116041342.3841-8-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116041342.3841-1-elliott@hpe.com>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OztRO2yPCF9wMos6GXUqpT1CCWFMUx0i
X-Proofpoint-ORIG-GUID: OztRO2yPCF9wMos6GXUqpT1CCWFMUx0i
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=986
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 phishscore=0 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160029
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use more consistent unambivalent types for the source and destination
buffer pointer arguments.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/ghash-clmulni-intel_asm.S  | 4 ++--
 arch/x86/crypto/ghash-clmulni-intel_glue.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/crypto/ghash-clmulni-intel_asm.S b/arch/x86/crypto/ghash-clmulni-intel_asm.S
index 2bf871899920..c7b8542facee 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_asm.S
+++ b/arch/x86/crypto/ghash-clmulni-intel_asm.S
@@ -88,7 +88,7 @@ SYM_FUNC_START_LOCAL(__clmul_gf128mul_ble)
 	RET
 SYM_FUNC_END(__clmul_gf128mul_ble)
 
-/* void clmul_ghash_mul(char *dst, const u128 *shash) */
+/* void clmul_ghash_mul(u8 *dst, const u128 *shash) */
 SYM_FUNC_START(clmul_ghash_mul)
 	FRAME_BEGIN
 	movups (%rdi), DATA
@@ -103,7 +103,7 @@ SYM_FUNC_START(clmul_ghash_mul)
 SYM_FUNC_END(clmul_ghash_mul)
 
 /*
- * void clmul_ghash_update(char *dst, const char *src, unsigned int srclen,
+ * void clmul_ghash_update(u8 *dst, const u8 *src, unsigned int srclen,
  *			   const u128 *shash);
  */
 SYM_FUNC_START(clmul_ghash_update)
diff --git a/arch/x86/crypto/ghash-clmulni-intel_glue.c b/arch/x86/crypto/ghash-clmulni-intel_glue.c
index 1f1a95f3dd0c..e996627c6583 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_glue.c
+++ b/arch/x86/crypto/ghash-clmulni-intel_glue.c
@@ -23,9 +23,9 @@
 #define GHASH_BLOCK_SIZE	16
 #define GHASH_DIGEST_SIZE	16
 
-void clmul_ghash_mul(char *dst, const u128 *shash);
+void clmul_ghash_mul(u8 *dst, const u128 *shash);
 
-void clmul_ghash_update(char *dst, const char *src, unsigned int srclen,
+void clmul_ghash_update(u8 *dst, const u8 *src, unsigned int srclen,
 			const u128 *shash);
 
 struct ghash_async_ctx {
-- 
2.38.1

