Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AAC617586
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiKCE3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiKCE2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:28:41 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D1811A28;
        Wed,  2 Nov 2022 21:28:26 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A335icD008499;
        Thu, 3 Nov 2022 04:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=6i7qkLSf27dNfAQK+C6QTFK0YUsn0GSTSCnxogIVu/I=;
 b=Cct5XUWdHcVswJgk3T6pZfN6VB+icEZRaatpBT8A7lMpJnMA+kSkjHGjsFvfm8/2WPP8
 JP1Kq7QvsjeH6BypBiDi5aGWyQe7Ic0m+7ej5yBrt0AMEERsNdsTMROQjkAXOIvUfu2v
 F3627+MhY/xkMgKuaZ4rCVmu3zn+83712QSEMvMNRPlZzTVR3S0HpXSpenrZC0Hti1q9
 WFUJVgXwvLd9TUAeqSXpoMmi0+Uo4O0aK5Wl6HVGE0jXN0RnYfpreJecvmd75MVnrMfk
 JSmDZX/ocRL9M3Zf2DlNY8No5sUaOvB1lQPW9ubuE1k8yA5vYvSelhM6fLCwceqS0xRV ew== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3km2pfhdfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 04:28:15 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 4A1BA295B3;
        Thu,  3 Nov 2022 04:28:15 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 99704808EAF;
        Thu,  3 Nov 2022 04:28:14 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 08/17] crypto: x86/ghash - restructure FPU context saving
Date:   Wed,  2 Nov 2022 23:27:31 -0500
Message-Id: <20221103042740.6556-9-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221103042740.6556-1-elliott@hpe.com>
References: <20221012215931.3896-1-elliott@hpe.com>
 <20221103042740.6556-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: z73p0svX-2GXugifPhOieRorl8zP_M1f
X-Proofpoint-ORIG-GUID: z73p0svX-2GXugifPhOieRorl8zP_M1f
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

Wrap each of the calls to clmul_hash_update and clmul_ghash__mul
in its own set of kernel_fpu_begin and kernel_fpu_end calls, preparing
to limit the amount of data processed by each _update call to avoid
RCU stalls.

This is more like how polyval-clmulni_glue is structured.

Fixes: 0e1227d356e9 ("crypto: ghash - Add PCLMULQDQ accelerated implementation")
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/ghash-clmulni-intel_glue.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/crypto/ghash-clmulni-intel_glue.c b/arch/x86/crypto/ghash-clmulni-intel_glue.c
index e996627c6583..22367e363d72 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_glue.c
+++ b/arch/x86/crypto/ghash-clmulni-intel_glue.c
@@ -80,7 +80,6 @@ static int ghash_update(struct shash_desc *desc,
 	struct ghash_ctx *ctx = crypto_shash_ctx(desc->tfm);
 	u8 *dst = dctx->buffer;
 
-	kernel_fpu_begin();
 	if (dctx->bytes) {
 		int n = min(srclen, dctx->bytes);
 		u8 *pos = dst + (GHASH_BLOCK_SIZE - dctx->bytes);
@@ -91,10 +90,14 @@ static int ghash_update(struct shash_desc *desc,
 		while (n--)
 			*pos++ ^= *src++;
 
-		if (!dctx->bytes)
+		if (!dctx->bytes) {
+			kernel_fpu_begin();
 			clmul_ghash_mul(dst, &ctx->shash);
+			kernel_fpu_end();
+		}
 	}
 
+	kernel_fpu_begin();
 	clmul_ghash_update(dst, src, srclen, &ctx->shash);
 	kernel_fpu_end();
 
-- 
2.37.3

