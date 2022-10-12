Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623945FCDEB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJLWAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiJLWAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:00:04 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830BD1D656;
        Wed, 12 Oct 2022 15:00:01 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CL7nUY016092;
        Wed, 12 Oct 2022 21:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=ucCBxZTErIqQD5ALBAy3477d9TkzMjYJkeMraMaDllo=;
 b=oO9OfIR5WNQgWIqFPF/XIYrSG39bYT/aMzXVmpBqZEKeMCtE64GD0+lwWYtTH3gh7rDL
 9R0RFoM+KeHjtUeBor6HVeDgPKlzpcqmh4WNPrbqe2JpiHzSRn7kjvLGnyZNnG8Jcvac
 o7VWjZiXjMhACKwIYhYDtCtPW2UvVDVt9jraUZUmEd5O6AOXmnLBTofSvC/Rr3MWWd56
 Pz3ucwFB5cVr35pGdIlzXZd5RWSz0GAJuS1o53L8+31nApp33wo6njkMVohYPhtHMLbm
 VAtf+X2xPgMljQeYSZvziN+FNapTs1wA5YBpVkGYDhOd+bzX1M9prGBZ0k4XUCofuwZt PQ== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k657j8a4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 21:59:54 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 8C6A429583;
        Wed, 12 Oct 2022 21:59:53 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 300CA806B5D;
        Wed, 12 Oct 2022 21:59:53 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 06/19] crypto: x86/sm3 - limit FPU preemption
Date:   Wed, 12 Oct 2022 16:59:18 -0500
Message-Id: <20221012215931.3896-7-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012215931.3896-1-elliott@hpe.com>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SsfEUl-bSa_7-e8O3HxfPvS3a8M686_J
X-Proofpoint-GUID: SsfEUl-bSa_7-e8O3HxfPvS3a8M686_J
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_11,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120138
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
    rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: ...

Fixes: 930ab34d906d ("crypto: x86/sm3 - add AVX assembly implementation")
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/sm3_avx_glue.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/x86/crypto/sm3_avx_glue.c b/arch/x86/crypto/sm3_avx_glue.c
index 661b6f22ffcd..ffb6d2f409ef 100644
--- a/arch/x86/crypto/sm3_avx_glue.c
+++ b/arch/x86/crypto/sm3_avx_glue.c
@@ -17,6 +17,8 @@
 #include <crypto/sm3_base.h>
 #include <asm/simd.h>
 
+#define FPU_BYTES 4096U /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+
 asmlinkage void sm3_transform_avx(struct sm3_state *state,
 			const u8 *data, int nblocks);
 
@@ -37,9 +39,16 @@ static int sm3_avx_update(struct shash_desc *desc, const u8 *data,
 	 */
 	BUILD_BUG_ON(offsetof(struct sm3_state, state) != 0);
 
-	kernel_fpu_begin();
-	sm3_base_do_update(desc, data, len, sm3_transform_avx);
-	kernel_fpu_end();
+	do {
+		unsigned int chunk = min(len, FPU_BYTES);
+
+		kernel_fpu_begin();
+		sm3_base_do_update(desc, data, chunk, sm3_transform_avx);
+		kernel_fpu_end();
+
+		len -= chunk;
+		data += chunk;
+	} while (len);
 
 	return 0;
 }
@@ -57,9 +66,19 @@ static int sm3_avx_finup(struct shash_desc *desc, const u8 *data,
 		return 0;
 	}
 
+	do {
+		unsigned int chunk = min(len, FPU_BYTES);
+
+		if (chunk) {
+			kernel_fpu_begin();
+			sm3_base_do_update(desc, data, chunk, sm3_transform_avx);
+			kernel_fpu_end();
+		}
+
+		len -= chunk;
+		data += chunk;
+	} while (len);
 	kernel_fpu_begin();
-	if (len)
-		sm3_base_do_update(desc, data, len, sm3_transform_avx);
 	sm3_base_do_finalize(desc, sm3_transform_avx);
 	kernel_fpu_end();
 
-- 
2.37.3

