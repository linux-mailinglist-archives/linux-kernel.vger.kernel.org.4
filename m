Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1D061758B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiKCE33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiKCE2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:28:44 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450DA175B1;
        Wed,  2 Nov 2022 21:28:31 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A335dTU004804;
        Thu, 3 Nov 2022 04:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=SQNfvnoONXJ54nVg/eI+GcD+ZbHMamNWL/sC3a0pwlQ=;
 b=omn7kUrZ9TxlDyHGEUkHcCBt6R1vpwh9r/xIV9XkiBMph8xGsEI68BELZLJbLyHHnhUo
 Ehhrfe6sumB1xvLPXw/UBFkNDe4MgxKkXBcXelt6c9Hm10UTD0QBTNrAfvn5BCJfaMKj
 xbkAP+vBuD2ycDmkibIxYAAhxK8W6mgh7w0LA21HzR6hjeJOIGcx+Xvci5Rj9cadjeyx
 MF10piclwGZQWEynLlbsy/bgXrBoN4dmDvoe4/shq9nlQEaCK8wB/WcGGe3xVEQ7Te4/
 9kULAJi+EvWnllFFM7DXFReOSbRZd3ticvBY9khuZZINAVPoU4pC3TSD7HfVIGwFN+M1 3w== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kksmrwmth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 04:28:24 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id BA55E8040F4;
        Thu,  3 Nov 2022 04:28:13 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 41F3B802B9C;
        Thu,  3 Nov 2022 04:28:13 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 07/17] crypto: x86/ghash - use u8 rather than char
Date:   Wed,  2 Nov 2022 23:27:30 -0500
Message-Id: <20221103042740.6556-8-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221103042740.6556-1-elliott@hpe.com>
References: <20221012215931.3896-1-elliott@hpe.com>
 <20221103042740.6556-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JrmBZWePH2iFNYs0lAOfbKsUZpMD4qDk
X-Proofpoint-ORIG-GUID: JrmBZWePH2iFNYs0lAOfbKsUZpMD4qDk
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=985
 lowpriorityscore=0 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030031
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2.37.3

