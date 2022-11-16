Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0981762B229
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 05:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiKPEOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 23:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiKPEOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 23:14:20 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0872431EF0;
        Tue, 15 Nov 2022 20:14:17 -0800 (PST)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG3Nn4B027960;
        Wed, 16 Nov 2022 04:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=yGY/aFR7vSy6xzempavBAqGCddr6XsRxi33pB4WDD80=;
 b=CQEq8NJsKhtbC5lUNvPFZZpCpE6OYxyPI0nMx52cSEfmoGpJJvCAYtGQ3R7cAHwfZry5
 oYIMCDr6c5tfgDdi6ZmJH1uqP+Whlyja820pUkxQOIRUxbDYElH9rD5UnZzqkhl7ft66
 XfD/ZVBO/AAtTXRVfrV6lVGuaGgSRvGJ5V4M6wQjSW1SG18EsIjBNvogf4HhBH7sFVTA
 0VmYAx/meod39tugh437bugwcU4EBtZifAKVd9gVPAG3iPtph0w1JaELvgE95u1+ryu5
 kG15cgnp3XE/X/5A0TYCUNqDA9pXSPNd+wBAL8B54Zs8IK+ixHnEaQa2mKP4hWyMrLB9 ew== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kvqwqgab2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 04:14:03 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id C59EC809F56;
        Wed, 16 Nov 2022 04:14:02 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 50CF78058DE;
        Wed, 16 Nov 2022 04:14:02 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v4 08/24] crypto: x86/ghash - restructure FPU context saving
Date:   Tue, 15 Nov 2022 22:13:26 -0600
Message-Id: <20221116041342.3841-9-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116041342.3841-1-elliott@hpe.com>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lWHW-zZnaofSzYJgbZJ7691Oou1zTpew
X-Proofpoint-GUID: lWHW-zZnaofSzYJgbZJ7691Oou1zTpew
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211160029
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2.38.1

