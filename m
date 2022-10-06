Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DFF5F7129
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 00:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiJFWco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 18:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbiJFWcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:32:31 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5188F1927;
        Thu,  6 Oct 2022 15:32:30 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296LdZOq027880;
        Thu, 6 Oct 2022 22:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=B+xhqzalsDHwm/ksRSO5kdmSiCCi1Sgu2dmiQdGIOpU=;
 b=Okw2brtWKNBoiaErRF1ACg4hUbP6nC6nKJl2/z/mzAVYMPFnkIUE5rLmWAdMFP7upOoQ
 RO4Y2MYD7yXuYfeRVu8+MrU4V77ZP5wYEbLbyjH1bCA3Q1dDtDHuq8XtIdpDPA556mr2
 uE3j40VBR1YeEb8Dj4iHA4tWGQDrQtzbeajX5NqwmrCMV0KZ4I1YvwPN6sU0sbSkejG/
 LsvQQv6Ok/pavLgp8o1UoEvQWk+kW2U0iVosOjz9RbnLnLvjAubuZQhkLC8DDrd7SyPL
 Bxv8udBYQPMHtbpu4a5tKUIdJ+5tEhh5cKQx8iJxpDC5h5B6X3tZRX3RHXJ5r3fR7MHl wg== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k274bgdda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 22:32:27 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 9A2C4801AD4;
        Thu,  6 Oct 2022 22:32:27 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 495238065D2;
        Thu,  6 Oct 2022 22:32:27 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [RFC PATCH 5/7] crypto: x86/ghash - restructure FPU context saving
Date:   Thu,  6 Oct 2022 17:31:49 -0500
Message-Id: <20221006223151.22159-6-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221006223151.22159-1-elliott@hpe.com>
References: <20221006223151.22159-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7MOIYjqP-Hhb-6ROWjn498ByW2wkiC_9
X-Proofpoint-ORIG-GUID: 7MOIYjqP-Hhb-6ROWjn498ByW2wkiC_9
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_05,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060132
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
index 3a96c167d78d..b25730c5b267 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_glue.c
+++ b/arch/x86/crypto/ghash-clmulni-intel_glue.c
@@ -82,7 +82,6 @@ static int ghash_update(struct shash_desc *desc,
 	struct ghash_ctx *ctx = crypto_shash_ctx(desc->tfm);
 	u8 *dst = dctx->buffer;
 
-	kernel_fpu_begin();
 	if (dctx->bytes) {
 		int n = min(srclen, dctx->bytes);
 		u8 *pos = dst + (GHASH_BLOCK_SIZE - dctx->bytes);
@@ -93,10 +92,14 @@ static int ghash_update(struct shash_desc *desc,
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

