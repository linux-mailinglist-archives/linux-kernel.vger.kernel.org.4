Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7EF6ED4B8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjDXSs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjDXSsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:48:22 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0538565B7;
        Mon, 24 Apr 2023 11:47:48 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OIcEm1021564;
        Mon, 24 Apr 2023 18:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=pfXCIcGsDOQtxtxG+m1wyLvRYrM/ZwqFmyj6kot5XWs=;
 b=SzMqdkrUlmpdB2jOGpCJNTlNfMKsy4QlUlr0kOMY0hzfhQThvCHR87W2YCjkuoLLHwBW
 15wz1gBihAalnIdJSry7WuwWHzZulCvwa0/gXoliLzLEwuABQcEF1i+xKZQQy4Vj7BoY
 O0iMOl04P7Xl/UZs+zhcJI6XE+zNZup74gweVCmpfrw1KlX//nzE1tMi5GAlT9vA8U8v
 0F1TL5QZ/DI19tCQO8/5OZIKwdLE1P/S443lUbD5WXQ2n5A90nzzNdUHRxgy120U9olH
 zEh4aqv/zW1LHR6omA4ZP5jSH0+vibV0eceqJsJWfv4Gnpbg4LckbEeQuguy3Jun6kpk Vw== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q5wt8340q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 18:47:35 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33OGdPBO006357;
        Mon, 24 Apr 2023 18:47:34 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3q4778qke2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 18:47:34 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33OIlW9C53477880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Apr 2023 18:47:32 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B1E65805C;
        Mon, 24 Apr 2023 18:47:32 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BF2358051;
        Mon, 24 Apr 2023 18:47:32 +0000 (GMT)
Received: from ltcden12-lp3.aus.stglabs.ibm.com (unknown [9.40.195.53])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 24 Apr 2023 18:47:31 +0000 (GMT)
From:   Danny Tsen <dtsen@linux.ibm.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com,
        Danny Tsen <dtsen@linux.ibm.com>
Subject: [PATCH 2/5] Glue code for optmized Chacha20 implementation for ppc64le.
Date:   Mon, 24 Apr 2023 14:47:23 -0400
Message-Id: <20230424184726.2091-3-dtsen@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230424184726.2091-1-dtsen@linux.ibm.com>
References: <20230424184726.2091-1-dtsen@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U3w5wTtNyEWeBnkeqLHD9lewzjc2e8IA
X-Proofpoint-ORIG-GUID: U3w5wTtNyEWeBnkeqLHD9lewzjc2e8IA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_11,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304240167
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
 arch/powerpc/crypto/chacha-p10-glue.c | 223 ++++++++++++++++++++++++++
 1 file changed, 223 insertions(+)
 create mode 100644 arch/powerpc/crypto/chacha-p10-glue.c

diff --git a/arch/powerpc/crypto/chacha-p10-glue.c b/arch/powerpc/crypto/chacha-p10-glue.c
new file mode 100644
index 000000000000..cefb150e7b3c
--- /dev/null
+++ b/arch/powerpc/crypto/chacha-p10-glue.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * PowerPC P10 (ppc64le) accelerated ChaCha and XChaCha stream ciphers,
+ * including ChaCha20 (RFC7539)
+ *
+ * Copyright 2023- IBM Inc. All rights reserved.
+ */
+
+#include <crypto/algapi.h>
+#include <crypto/internal/chacha.h>
+#include <crypto/internal/simd.h>
+#include <crypto/internal/skcipher.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/cpufeature.h>
+#include <linux/sizes.h>
+#include <asm/simd.h>
+#include <asm/switch_to.h>
+
+asmlinkage void chacha_p10le_8x(u32 *state, u8 *dst, const u8 *src,
+				unsigned int len, int nrounds);
+
+static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_p10);
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
+static void chacha_p10_do_8x(u32 *state, u8 *dst, const u8 *src,
+			     unsigned int bytes, int nrounds)
+{
+	unsigned int l = bytes & ~0x0FF;
+
+	if (l > 0) {
+		chacha_p10le_8x(state, dst, src, l, nrounds);
+		bytes -= l;
+		src += l;
+		dst += l;
+		state[12] += l / CHACHA_BLOCK_SIZE;
+	}
+
+	if (bytes > 0)
+		chacha_crypt_generic(state, dst, src, bytes, nrounds);
+}
+
+void hchacha_block_arch(const u32 *state, u32 *stream, int nrounds)
+{
+	hchacha_block_generic(state, stream, nrounds);
+}
+EXPORT_SYMBOL(hchacha_block_arch);
+
+void chacha_init_arch(u32 *state, const u32 *key, const u8 *iv)
+{
+	chacha_init_generic(state, key, iv);
+}
+EXPORT_SYMBOL(chacha_init_arch);
+
+void chacha_crypt_arch(u32 *state, u8 *dst, const u8 *src, unsigned int bytes,
+		       int nrounds)
+{
+	if (!static_branch_likely(&have_p10) || bytes <= CHACHA_BLOCK_SIZE ||
+	    !crypto_simd_usable())
+		return chacha_crypt_generic(state, dst, src, bytes, nrounds);
+
+	do {
+		unsigned int todo = min_t(unsigned int, bytes, SZ_4K);
+
+		vsx_begin();
+		chacha_p10_do_8x(state, dst, src, todo, nrounds);
+		vsx_end();
+
+		bytes -= todo;
+		src += todo;
+		dst += todo;
+	} while (bytes);
+}
+EXPORT_SYMBOL(chacha_crypt_arch);
+
+static int chacha_p10_stream_xor(struct skcipher_request *req,
+				 const struct chacha_ctx *ctx, const u8 *iv)
+{
+	struct skcipher_walk walk;
+	u32 state[16];
+	int err;
+
+	err = skcipher_walk_virt(&walk, req, false);
+	if (err)
+		return err;
+
+	chacha_init_generic(state, ctx->key, iv);
+
+	while (walk.nbytes > 0) {
+		unsigned int nbytes = walk.nbytes;
+
+		if (nbytes < walk.total)
+			nbytes = rounddown(nbytes, walk.stride);
+
+		if (!static_branch_likely(&have_p10) ||
+		    !crypto_simd_usable()) {
+			chacha_crypt_generic(state, walk.dst.virt.addr,
+					     walk.src.virt.addr, nbytes,
+					     ctx->nrounds);
+		} else {
+			vsx_begin();
+			chacha_p10_do_8x(state, walk.dst.virt.addr,
+				      walk.src.virt.addr, nbytes, ctx->nrounds);
+			vsx_end();
+		}
+		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
+static int chacha_p10(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct chacha_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	return chacha_p10_stream_xor(req, ctx, req->iv);
+}
+
+static int xchacha_p10(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct chacha_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct chacha_ctx subctx;
+	u32 state[16];
+	u8 real_iv[16];
+
+	chacha_init_generic(state, ctx->key, req->iv);
+	hchacha_block_arch(state, subctx.key, ctx->nrounds);
+	subctx.nrounds = ctx->nrounds;
+
+	memcpy(&real_iv[0], req->iv + 24, 8);
+	memcpy(&real_iv[8], req->iv + 16, 8);
+	return chacha_p10_stream_xor(req, &subctx, real_iv);
+}
+
+static struct skcipher_alg algs[] = {
+	{
+		.base.cra_name		= "chacha20",
+		.base.cra_driver_name	= "chacha20-p10",
+		.base.cra_priority	= 300,
+		.base.cra_blocksize	= 1,
+		.base.cra_ctxsize	= sizeof(struct chacha_ctx),
+		.base.cra_module	= THIS_MODULE,
+
+		.min_keysize		= CHACHA_KEY_SIZE,
+		.max_keysize		= CHACHA_KEY_SIZE,
+		.ivsize			= CHACHA_IV_SIZE,
+		.chunksize		= CHACHA_BLOCK_SIZE,
+		.setkey			= chacha20_setkey,
+		.encrypt		= chacha_p10,
+		.decrypt		= chacha_p10,
+	}, {
+		.base.cra_name		= "xchacha20",
+		.base.cra_driver_name	= "xchacha20-p10",
+		.base.cra_priority	= 300,
+		.base.cra_blocksize	= 1,
+		.base.cra_ctxsize	= sizeof(struct chacha_ctx),
+		.base.cra_module	= THIS_MODULE,
+
+		.min_keysize		= CHACHA_KEY_SIZE,
+		.max_keysize		= CHACHA_KEY_SIZE,
+		.ivsize			= XCHACHA_IV_SIZE,
+		.chunksize		= CHACHA_BLOCK_SIZE,
+		.setkey			= chacha20_setkey,
+		.encrypt		= xchacha_p10,
+		.decrypt		= xchacha_p10,
+	}, {
+		.base.cra_name		= "xchacha12",
+		.base.cra_driver_name	= "xchacha12-p10",
+		.base.cra_priority	= 300,
+		.base.cra_blocksize	= 1,
+		.base.cra_ctxsize	= sizeof(struct chacha_ctx),
+		.base.cra_module	= THIS_MODULE,
+
+		.min_keysize		= CHACHA_KEY_SIZE,
+		.max_keysize		= CHACHA_KEY_SIZE,
+		.ivsize			= XCHACHA_IV_SIZE,
+		.chunksize		= CHACHA_BLOCK_SIZE,
+		.setkey			= chacha12_setkey,
+		.encrypt		= xchacha_p10,
+		.decrypt		= xchacha_p10,
+	}
+};
+
+static int __init chacha_p10_init(void)
+{
+	static_branch_enable(&have_p10);
+
+	return IS_REACHABLE(CONFIG_CRYPTO_SKCIPHER) ?
+		crypto_register_skciphers(algs, ARRAY_SIZE(algs)) : 0;
+}
+
+static void __exit chacha_p10_exit(void)
+{
+	crypto_unregister_skciphers(algs, ARRAY_SIZE(algs));
+}
+
+module_cpu_feature_match(PPC_MODULE_FEATURE_P10, chacha_p10_init);
+module_exit(chacha_p10_exit);
+
+MODULE_DESCRIPTION("ChaCha and XChaCha stream ciphers (P10 accelerated)");
+MODULE_AUTHOR("Danny Tsen <dtsen@linux.ibm.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS_CRYPTO("chacha20");
+MODULE_ALIAS_CRYPTO("chacha20-p10");
+MODULE_ALIAS_CRYPTO("xchacha20");
+MODULE_ALIAS_CRYPTO("xchacha20-p10");
+MODULE_ALIAS_CRYPTO("xchacha12");
+MODULE_ALIAS_CRYPTO("xchacha12-p10");
-- 
2.31.1

