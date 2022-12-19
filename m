Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485C3651547
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbiLSWEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbiLSWDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:03:35 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D82140F6;
        Mon, 19 Dec 2022 14:03:21 -0800 (PST)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJJr66N024598;
        Mon, 19 Dec 2022 22:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=O4GnIk7zd/4MqgzKF2156bsbM+N7CAdELJWrz2MCgdk=;
 b=SXjklFqcz0t9iTLogr2jGRxusZQC60LRJIbIqsGnHdNhOeE83d0mLu6phlugRe6kfDdl
 ujMBmMkL3+aSMn/R5QtS1k8ppkPjA30SDCRTBZjjRBwzMwo5K+1PjoPBD26ysB8lyGd9
 of2PLn64zaXCZUBrDiUbra03X5J58JNqmanlAa+mW0NIHQ33QqDfYxADKh0vM7qjFsBH
 SpVWFE56M6x1iieblh75hPbo7NYyWq5txFHkhqWf/LvJly+c0NXNQ3EMH4LFCyDPiMwz
 NeyIiMhWVvzLs0BfE7BGpIv6R3CspSX1Sytg5q/vN3npNUgjoDt0DmASHBDpEeVkgWs1 SA== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3mjx3b10yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 22:03:05 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 75DB84AC45;
        Mon, 19 Dec 2022 22:03:04 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id A8B1380649A;
        Mon, 19 Dec 2022 22:03:03 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, Jason@zx2c4.com,
        ardb@kernel.org, ap420073@gmail.com, David.Laight@ACULAB.COM,
        ebiggers@kernel.org, tim.c.chen@linux.intel.com, peter@n8pjl.ca,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 13/13] crypto: x86/aria - yield FPU context only when needed
Date:   Mon, 19 Dec 2022 16:02:23 -0600
Message-Id: <20221219220223.3982176-14-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219220223.3982176-1-elliott@hpe.com>
References: <20221219220223.3982176-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: l8D768RjsgE5OEabaL3ZFIEKiFHi-Ky-
X-Proofpoint-GUID: l8D768RjsgE5OEabaL3ZFIEKiFHi-Ky-
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

The x86 assembly language implementations using SIMD process data
between kernel_fpu_begin() and kernel_fpu_end() calls. That
disables scheduler preemption, so prevents the CPU core from being
used by other threads.

During ctr mode, rather than break the processing into 256 byte
passes, each of which unilaterally calls kernel_fpu_begin() and
kernel_fpu_end(), periodically check if the kernel scheduler wants
to run something else on the CPU. If so, yield the kernel FPU
context and let the scheduler intervene.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/aria_aesni_avx_glue.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/crypto/aria_aesni_avx_glue.c b/arch/x86/crypto/aria_aesni_avx_glue.c
index c561ea4fefa5..6657ce576e6c 100644
--- a/arch/x86/crypto/aria_aesni_avx_glue.c
+++ b/arch/x86/crypto/aria_aesni_avx_glue.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2022 Taehee Yoo <ap420073@gmail.com>
  */
 
+#include <asm/simd.h>
 #include <crypto/algapi.h>
 #include <crypto/internal/simd.h>
 #include <crypto/aria.h>
@@ -85,17 +86,19 @@ static int aria_avx_ctr_encrypt(struct skcipher_request *req)
 		const u8 *src = walk.src.virt.addr;
 		u8 *dst = walk.dst.virt.addr;
 
+		kernel_fpu_begin();
 		while (nbytes >= ARIA_AESNI_PARALLEL_BLOCK_SIZE) {
 			u8 keystream[ARIA_AESNI_PARALLEL_BLOCK_SIZE];
 
-			kernel_fpu_begin();
 			aria_ops.aria_ctr_crypt_16way(ctx, dst, src, keystream,
 						      walk.iv);
-			kernel_fpu_end();
 			dst += ARIA_AESNI_PARALLEL_BLOCK_SIZE;
 			src += ARIA_AESNI_PARALLEL_BLOCK_SIZE;
 			nbytes -= ARIA_AESNI_PARALLEL_BLOCK_SIZE;
+
+			kernel_fpu_yield();
 		}
+		kernel_fpu_end();
 
 		while (nbytes >= ARIA_BLOCK_SIZE) {
 			u8 keystream[ARIA_BLOCK_SIZE];
-- 
2.38.1

