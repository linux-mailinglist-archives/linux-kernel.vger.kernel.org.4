Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDD06EFAC0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 21:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239498AbjDZTMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 15:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239435AbjDZTMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:12:23 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B44D1721;
        Wed, 26 Apr 2023 12:12:13 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QJ8J5Q016399;
        Wed, 26 Apr 2023 19:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6tgBsNvOE53Oy05crjP7X2ickS45m9u/5VUuSgXlfC8=;
 b=c6ipzDa8aRixxJVS/W+d2eSKGQdUSyN4i1RF601UISKAtMrZxhmxSA050/d+Lrs7XDNl
 YCcPoepxSdPyFGCOhjiV5Pm54dTaivm78odXyewZMlS0fd/ryvnEMnI6FwpiYnaRCNkp
 VDv9meIab/jV+7hkIhinEB1nlbfMWZlR5BfQ/K3eFVUBAekw5RqNqrEh3T4xdUIJuLxe
 3DWdCFiJwBntyx36y1nPgP8RrKcFjPP5HLqRJEeRZvSZXv6ERjHjSUAIN/ExGqG38QCV
 2s8pXuKe7sEblBuFI3AaRxsjjLftsgI6Kxh01NzhfsHAdIXCQQQBg3QAvw+f/lqtyzsq kA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q78t6206d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 19:11:57 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33QIgNM5009652;
        Wed, 26 Apr 2023 19:11:56 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3q47794fcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 19:11:56 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33QJBsnZ13238886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 19:11:54 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DDF758055;
        Wed, 26 Apr 2023 19:11:54 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EBB358043;
        Wed, 26 Apr 2023 19:11:54 +0000 (GMT)
Received: from ltcden12-lp3.aus.stglabs.ibm.com (unknown [9.40.195.53])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 26 Apr 2023 19:11:54 +0000 (GMT)
From:   Danny Tsen <dtsen@linux.ibm.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com,
        Danny Tsen <dtsen@linux.ibm.com>
Subject: [PATCH v2 4/5] Glue code for optmized Poly1305 implementation for ppc64le.
Date:   Wed, 26 Apr 2023 15:11:46 -0400
Message-Id: <20230426191147.60610-5-dtsen@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230426191147.60610-1-dtsen@linux.ibm.com>
References: <20230426191147.60610-1-dtsen@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rRFqEQlnjEdSQ0BP4UJ9JjKiiTna7SVQ
X-Proofpoint-GUID: rRFqEQlnjEdSQ0BP4UJ9JjKiiTna7SVQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304260169
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
index 000000000000..95dd708573ee
--- /dev/null
+++ b/arch/powerpc/crypto/poly1305-p10-glue.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Poly1305 authenticator algorithm, RFC7539.
+ *
+ * Copyright 2023- IBM Corp. All rights reserved.
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
+		if (crypto_simd_usable() && (srclen >= POLY1305_BLOCK_SIZE*4)) {
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

