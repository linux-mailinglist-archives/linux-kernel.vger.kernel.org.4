Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2244E6ED4B7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjDXSsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjDXSsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:48:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092706EB6;
        Mon, 24 Apr 2023 11:47:49 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OIbT59011734;
        Mon, 24 Apr 2023 18:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9HJA6qsWpwqo/FCEh68maNeE8xNqGLvRRBaYcrElDyA=;
 b=ICwAcM1evOl8mV0gp8Ar/HgtO3ncB0ktulH4k2CCD2pHXimg8POeOeFFChJle3Q9WE2S
 9UIZrHVbnSOj8SprKN6W9IDLkTqanMNI8noLkjkeMajyVYOgihSxrhPP6lPIdwvwe0jI
 E9giunp3JfB6RPrgWSEByUGnvztRTNvCDDohf+uMQZRJzplTRR+WEK6WD24McTrcbb02
 JhOHcfpV3tPe5mGY4cE03WQSrqfrAdKIzjTh+syhrzMuz6Aqj6Pj9FJZudrRKqNJ5Jpy
 8OgOgf/2PWG1sx1RLZtIxS2f2hRh/vsFyFvx0lfD4XVs0CJAmK4wQkZ3GmfMAhzcWUpa iw== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q47r7yytj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 18:47:38 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33OGPZG3010708;
        Mon, 24 Apr 2023 18:47:37 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3q47787mdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 18:47:37 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33OIlYNx7537254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Apr 2023 18:47:35 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB6A458051;
        Mon, 24 Apr 2023 18:47:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C2415805A;
        Mon, 24 Apr 2023 18:47:34 +0000 (GMT)
Received: from ltcden12-lp3.aus.stglabs.ibm.com (unknown [9.40.195.53])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 24 Apr 2023 18:47:34 +0000 (GMT)
From:   Danny Tsen <dtsen@linux.ibm.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com,
        Danny Tsen <dtsen@linux.ibm.com>
Subject: [PATCH 4/5] Glue code for optmized Poly1305 implementation for ppc64le.
Date:   Mon, 24 Apr 2023 14:47:25 -0400
Message-Id: <20230424184726.2091-5-dtsen@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230424184726.2091-1-dtsen@linux.ibm.com>
References: <20230424184726.2091-1-dtsen@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9i0R8LfUT83Q2LLlt7izEPEP1ZWABYG1
X-Proofpoint-ORIG-GUID: 9i0R8LfUT83Q2LLlt7izEPEP1ZWABYG1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_11,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304240167
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Danny Tsen <dtsen@linux.ibm.com>
---
 arch/powerpc/crypto/poly1305-p10-glue.c | 186 ++++++++++++++++++++++++
 1 file changed, 186 insertions(+)
 create mode 100644 arch/powerpc/crypto/poly1305-p10-glue.c

diff --git a/arch/powerpc/crypto/poly1305-p10-glue.c b/arch/powerpc/crypto/poly1305-p10-glue.c
new file mode 100644
index 000000000000..b1800f7b6af8
--- /dev/null
+++ b/arch/powerpc/crypto/poly1305-p10-glue.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Poly1305 authenticator algorithm, RFC7539.
+ *
+ * Copyright 2023- IBM Inc. All rights reserved.
+ */
+
+#include <crypto/algapi.h>
+#include <linux/crypto.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/jump_label.h>
+#include <crypto/internal/hash.h>
+#include <crypto/internal/poly1305.h>
+#include <crypto/internal/simd.h>
+#include <linux/cpufeature.h>
+#include <asm/unaligned.h>
+#include <asm/simd.h>
+#include <asm/switch_to.h>
+
+asmlinkage void poly1305_p10le_4blocks(void *h, const u8 *m, u32 mlen);
+asmlinkage void poly1305_64s(void *h, const u8 *m, u32 mlen, int highbit);
+asmlinkage void poly1305_emit_64(void *h, void *s, u8 *dst);
+
+static void vsx_begin(void)
+{
+	preempt_disable();
+	enable_kernel_vsx();
+}
+
+static void vsx_end(void)
+{
+	disable_kernel_vsx();
+	preempt_enable();
+}
+
+static int crypto_poly1305_p10_init(struct shash_desc *desc)
+{
+	struct poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
+
+	poly1305_core_init(&dctx->h);
+	dctx->buflen = 0;
+	dctx->rset = 0;
+	dctx->sset = false;
+
+	return 0;
+}
+
+static unsigned int crypto_poly1305_setdctxkey(struct poly1305_desc_ctx *dctx,
+					       const u8 *inp, unsigned int len)
+{
+	unsigned int acc = 0;
+
+	if (unlikely(!dctx->sset)) {
+		if (!dctx->rset && len >= POLY1305_BLOCK_SIZE) {
+			struct poly1305_core_key *key = &dctx->core_r;
+
+			key->key.r64[0] = get_unaligned_le64(&inp[0]);
+			key->key.r64[1] = get_unaligned_le64(&inp[8]);
+			inp += POLY1305_BLOCK_SIZE;
+			len -= POLY1305_BLOCK_SIZE;
+			acc += POLY1305_BLOCK_SIZE;
+			dctx->rset = 1;
+		}
+		if (len >= POLY1305_BLOCK_SIZE) {
+			dctx->s[0] = get_unaligned_le32(&inp[0]);
+			dctx->s[1] = get_unaligned_le32(&inp[4]);
+			dctx->s[2] = get_unaligned_le32(&inp[8]);
+			dctx->s[3] = get_unaligned_le32(&inp[12]);
+			acc += POLY1305_BLOCK_SIZE;
+			dctx->sset = true;
+		}
+	}
+	return acc;
+}
+
+static int crypto_poly1305_p10_update(struct shash_desc *desc,
+				      const u8 *src, unsigned int srclen)
+{
+	struct poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
+	unsigned int bytes, used;
+
+	if (unlikely(dctx->buflen)) {
+		bytes = min(srclen, POLY1305_BLOCK_SIZE - dctx->buflen);
+		memcpy(dctx->buf + dctx->buflen, src, bytes);
+		src += bytes;
+		srclen -= bytes;
+		dctx->buflen += bytes;
+
+		if (dctx->buflen == POLY1305_BLOCK_SIZE) {
+			if (likely(!crypto_poly1305_setdctxkey(dctx, dctx->buf,
+							       POLY1305_BLOCK_SIZE))) {
+				vsx_begin();
+				poly1305_64s(&dctx->h, dctx->buf,
+						  POLY1305_BLOCK_SIZE, 1);
+				vsx_end();
+			}
+			dctx->buflen = 0;
+		}
+	}
+
+	if (likely(srclen >= POLY1305_BLOCK_SIZE)) {
+		bytes = round_down(srclen, POLY1305_BLOCK_SIZE);
+		used = crypto_poly1305_setdctxkey(dctx, src, bytes);
+		if (likely(used)) {
+			srclen -= used;
+			src += used;
+		}
+		if (srclen >= POLY1305_BLOCK_SIZE*4) {
+			vsx_begin();
+			poly1305_p10le_4blocks(&dctx->h, src, srclen);
+			vsx_end();
+			src += srclen - (srclen % (POLY1305_BLOCK_SIZE * 4));
+			srclen %= POLY1305_BLOCK_SIZE * 4;
+		}
+		while (srclen >= POLY1305_BLOCK_SIZE) {
+			vsx_begin();
+			poly1305_64s(&dctx->h, src, POLY1305_BLOCK_SIZE, 1);
+			vsx_end();
+			srclen -= POLY1305_BLOCK_SIZE;
+			src += POLY1305_BLOCK_SIZE;
+		}
+	}
+
+	if (unlikely(srclen)) {
+		dctx->buflen = srclen;
+		memcpy(dctx->buf, src, srclen);
+	}
+
+	return 0;
+}
+
+static int crypto_poly1305_p10_final(struct shash_desc *desc, u8 *dst)
+{
+	struct poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
+
+	if (unlikely(!dctx->sset))
+		return -ENOKEY;
+
+	if ((dctx->buflen)) {
+		dctx->buf[dctx->buflen++] = 1;
+		memset(dctx->buf + dctx->buflen, 0,
+		       POLY1305_BLOCK_SIZE - dctx->buflen);
+		vsx_begin();
+		poly1305_64s(&dctx->h, dctx->buf, POLY1305_BLOCK_SIZE, 0);
+		vsx_end();
+		dctx->buflen = 0;
+	}
+
+	poly1305_emit_64(&dctx->h, &dctx->s, dst);
+	return 0;
+}
+
+static struct shash_alg poly1305_alg = {
+	.digestsize	= POLY1305_DIGEST_SIZE,
+	.init		= crypto_poly1305_p10_init,
+	.update		= crypto_poly1305_p10_update,
+	.final		= crypto_poly1305_p10_final,
+	.descsize	= sizeof(struct poly1305_desc_ctx),
+	.base		= {
+		.cra_name		= "poly1305",
+		.cra_driver_name	= "poly1305-p10",
+		.cra_priority		= 300,
+		.cra_blocksize		= POLY1305_BLOCK_SIZE,
+		.cra_module		= THIS_MODULE,
+	},
+};
+
+static int __init poly1305_p10_init(void)
+{
+	return crypto_register_shash(&poly1305_alg);
+}
+
+static void __exit poly1305_p10_exit(void)
+{
+	crypto_unregister_shash(&poly1305_alg);
+}
+
+module_cpu_feature_match(PPC_MODULE_FEATURE_P10, poly1305_p10_init);
+module_exit(poly1305_p10_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Danny Tsen <dtsen@linux.ibm.com>");
+MODULE_DESCRIPTION("Optimized Poly1305 for P10");
+MODULE_ALIAS_CRYPTO("poly1305");
+MODULE_ALIAS_CRYPTO("poly1305-p10");
-- 
2.31.1

