Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB72663D0EC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiK3InK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbiK3InH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:43:07 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229C017423;
        Wed, 30 Nov 2022 00:43:05 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AU7BvHM030649;
        Wed, 30 Nov 2022 08:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4eMSML9eJqmELQj7u+vVcLwLkRvqQ9eO7+Dm5wmJh7I=;
 b=Rx8loLFRy21XLCyRS0ZUo7Lx/SNjLIISkRAJ9UzJFVtRnA40i9AD/1mfcTrk5Uc8DfWj
 5k2Yhzli7zZOgjgaTI3OcwcYF2F+rxhqvsAvQ8cHxVzrvyyVg+6JSS3SbHz6Cb7prsoe
 QYoUmU83Ma8xkVNqhqUJC+8k+HkgLhMa3J/QJAyCXMRkdHDkQlM7L5U7Aj9iGiUC4Tfu
 0lM3vgywLy3sxOo68fDy0pYDsquhUfZxbwjvb0i1HpcyI/VVK0qHK4qNYw82HSJ4mLPp
 ZVv8IIUjjzmwL1Qj1ui/a0cPy5EUOmjlrGP/XtJ2LRWgviT9r4B4h52uvKRsWNZsd3Z1 rA== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m62jq1xv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 08:42:28 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AU8ZXo8003842;
        Wed, 30 Nov 2022 08:42:27 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01wdc.us.ibm.com with ESMTP id 3m3ae9jp7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 08:42:27 +0000
Received: from smtpav06.wdc07v.mail.ibm.com ([9.208.128.115])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AU8gPdp197228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Nov 2022 08:42:26 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A806858055;
        Wed, 30 Nov 2022 08:42:25 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4735958066;
        Wed, 30 Nov 2022 08:42:25 +0000 (GMT)
Received: from ltcden12-lp3.aus.stglabs.ibm.com (unknown [9.40.195.53])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 30 Nov 2022 08:42:25 +0000 (GMT)
From:   Danny Tsen <dtsen@linux.ibm.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, ltcgcw@linux.vnet.ibm.com,
        dtsen@linux.ibm.com
Subject: [RESEND PATCH 2/6] Glue code for AES/GCM stitched implementation for Power10+ CPU(ppc64le).
Date:   Wed, 30 Nov 2022 03:42:07 -0500
Message-Id: <20221130084211.48154-3-dtsen@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221130084211.48154-1-dtsen@linux.ibm.com>
References: <20221130084211.48154-1-dtsen@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fxU2xQXzhuEp-qRY5QRbznHc6qf9UMIV
X-Proofpoint-GUID: fxU2xQXzhuEp-qRY5QRbznHc6qf9UMIV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-30_04,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211300062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Danny Tsen <dtsen@linux.ibm.com>
---
 arch/powerpc/crypto/p10-aes-gcm-glue.c | 341 +++++++++++++++++++++++++
 1 file changed, 341 insertions(+)
 create mode 100644 arch/powerpc/crypto/p10-aes-gcm-glue.c

diff --git a/arch/powerpc/crypto/p10-aes-gcm-glue.c b/arch/powerpc/crypto/p10-aes-gcm-glue.c
new file mode 100644
index 000000000000..5d3b52787828
--- /dev/null
+++ b/arch/powerpc/crypto/p10-aes-gcm-glue.c
@@ -0,0 +1,341 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Glue code for accelerated AES-GCM stitched implementation for ppc64le.
+ *
+ * Copyright 2022- IBM Inc. All rights reserved
+ */
+
+#include <asm/unaligned.h>
+#include <asm/simd.h>
+#include <asm/switch_to.h>
+#include <crypto/algapi.h>
+#include <crypto/aes.h>
+#include <crypto/algapi.h>
+#include <crypto/b128ops.h>
+#include <crypto/gf128mul.h>
+#include <crypto/internal/simd.h>
+#include <crypto/internal/aead.h>
+#include <crypto/internal/hash.h>
+#include <crypto/internal/skcipher.h>
+#include <crypto/scatterwalk.h>
+#include <linux/cpufeature.h>
+#include <linux/crypto.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+#define PPC_MODULE_FEATURE_P10	(32 + ilog2(PPC_FEATURE2_ARCH_3_1))
+#define	PPC_ALIGN		16
+#define GCM_IV_SIZE		12
+
+MODULE_DESCRIPTION("PPC64le AES-GCM with Stitched implementation");
+MODULE_AUTHOR("Danny Tsen <dtsen@linux.ibm.com");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS_CRYPTO("aes");
+
+asmlinkage int aes_p8_set_encrypt_key(const u8 *userKey, const int bits,
+				      void *key);
+asmlinkage void aes_p8_encrypt(const u8 *in, u8 *out, const void *key);
+asmlinkage void aes_p10_gcm_encrypt(u8 *in, u8 *out, size_t len,
+				    void *rkey, u8 *iv, void *Xi);
+asmlinkage void aes_p10_gcm_decrypt(u8 *in, u8 *out, size_t len,
+				    void *rkey, u8 *iv, void *Xi);
+asmlinkage void gcm_init_htable(unsigned char htable[256], unsigned char Xi[16]);
+asmlinkage void gcm_ghash_p8(unsigned char *Xi, unsigned char *Htable,
+		unsigned char *aad, unsigned int alen);
+
+struct aes_key {
+	u8 key[AES_MAX_KEYLENGTH];
+	u64 rounds;
+};
+
+struct gcm_ctx {
+	u8 iv[16];
+	u8 ivtag[16];
+	u8 aad_hash[16];
+	u64 aadLen;
+	u64 Plen;	/* offset 56 - used in aes_p10_gcm_{en/de}crypt */
+};
+struct Hash_ctx {
+	u8 H[16];	/* subkey */
+	u8 Htable[256];	/* Xi, Hash table(offset 32) */
+};
+
+struct p10_aes_gcm_ctx {
+	struct aes_key enc_key;
+};
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
+static void set_subkey(unsigned char *hash)
+{
+	*(u64 *)&hash[0] = be64_to_cpup((__be64 *)&hash[0]);
+	*(u64 *)&hash[8] = be64_to_cpup((__be64 *)&hash[8]);
+}
+
+/*
+ * Compute aad if any.
+ *   - Hash aad and copy to Xi.
+ */
+static void set_aad(struct gcm_ctx *gctx, struct Hash_ctx *hash,
+		    unsigned char *aad, int alen)
+{
+	int i;
+	u8 nXi[16] = {0, };
+
+	gctx->aadLen = alen;
+	i = alen & ~0xf;
+	if (i) {
+		gcm_ghash_p8(nXi, hash->Htable+32, aad, i);
+		aad += i;
+		alen -= 16;
+	}
+	if (alen) {
+		for (i = 0; i < alen; i++)
+			nXi[i] ^= aad[i];
+	}
+	memset(gctx->aad_hash, 0, 16);
+	gcm_ghash_p8(gctx->aad_hash, hash->Htable+32, nXi, 16);
+	memcpy(hash->Htable, gctx->aad_hash, 16);
+}
+
+static void gcmp10_init(struct gcm_ctx *gctx, u8 *iv, unsigned char *rdkey,
+			struct Hash_ctx *hash, u8 *assoc, unsigned int assoclen)
+{
+	__be32 counter = cpu_to_be32(1);
+
+	aes_p8_encrypt(hash->H, hash->H, rdkey);
+	set_subkey(hash->H);
+	gcm_init_htable(hash->Htable+32, hash->H);
+
+	*((__be32 *)(iv+12)) = counter;
+
+	gctx->Plen = 0;
+
+	/*
+	 * Encrypt counter vector as iv tag and increment counter.
+	 */
+	aes_p8_encrypt(iv, gctx->ivtag, rdkey);
+
+	counter = cpu_to_be32(2);
+	*((__be32 *)(iv+12)) = counter;
+	memcpy(gctx->iv, iv, 16);
+
+	gctx->aadLen = assoclen;
+	memset(gctx->aad_hash, 0, 16);
+	if (assoclen)
+		set_aad(gctx, hash, assoc, assoclen);
+}
+
+static void finish_tag(struct gcm_ctx *gctx, struct Hash_ctx *hash, int len)
+{
+	int i;
+	unsigned char len_ac[16 + PPC_ALIGN];
+	unsigned char *aclen = PTR_ALIGN((void *)len_ac, PPC_ALIGN);
+	__be64 clen = cpu_to_be64(len << 3);
+	__be64 alen = cpu_to_be64(gctx->aadLen << 3);
+
+	if (len == 0) {
+		memcpy(hash->Htable, gctx->ivtag, 16);
+		return;
+	}
+
+	/*
+	 * Len is in bits.
+	 */
+	*((__be64 *)(aclen)) = alen;
+	*((__be64 *)(aclen+8)) = clen;
+
+	/*
+	 * hash (AAD len and len)
+	 */
+	gcm_ghash_p8(hash->Htable, hash->Htable+32, aclen, 16);
+
+	for (i = 0; i < 16; i++)
+		hash->Htable[i] ^= gctx->ivtag[i];
+}
+
+static int set_authsize(struct crypto_aead *tfm, unsigned int authsize)
+{
+	switch (authsize) {
+	case 4:
+	case 8:
+	case 12:
+	case 13:
+	case 14:
+	case 15:
+	case 16:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int p10_aes_gcm_setkey(struct crypto_aead *aead, const u8 *key,
+			     unsigned int keylen)
+{
+	struct crypto_tfm *tfm = crypto_aead_tfm(aead);
+	struct p10_aes_gcm_ctx *ctx = crypto_tfm_ctx(tfm);
+	int ret;
+
+	vsx_begin();
+	ret = aes_p8_set_encrypt_key(key, keylen * 8, &ctx->enc_key);
+	vsx_end();
+
+	return ret ? -EINVAL : 0;
+}
+
+static int p10_aes_gcm_crypt(struct aead_request *req, int enc)
+{
+	struct crypto_tfm *tfm = req->base.tfm;
+	struct p10_aes_gcm_ctx *ctx = crypto_tfm_ctx(tfm);
+	u8 databuf[sizeof(struct gcm_ctx) + PPC_ALIGN];
+	struct gcm_ctx *gctx = PTR_ALIGN((void *)databuf, PPC_ALIGN);
+	u8 hashbuf[sizeof(struct Hash_ctx) + PPC_ALIGN];
+	struct Hash_ctx *hash = PTR_ALIGN((void *)hashbuf, PPC_ALIGN);
+	struct scatter_walk assoc_sg_walk;
+	struct skcipher_walk walk;
+	u8 *assocmem = NULL;
+	u8 *assoc;
+	unsigned int assoclen = req->assoclen;
+	unsigned int cryptlen = req->cryptlen;
+	unsigned char ivbuf[AES_BLOCK_SIZE+PPC_ALIGN];
+	unsigned char *iv = PTR_ALIGN((void *)ivbuf, PPC_ALIGN);
+	int ret;
+	unsigned long auth_tag_len = crypto_aead_authsize(__crypto_aead_cast(tfm));
+	u8 otag[16];
+	int total_processed = 0;
+
+	memset(databuf, 0, sizeof(databuf));
+	memset(hashbuf, 0, sizeof(hashbuf));
+	memset(ivbuf, 0, sizeof(ivbuf));
+	memcpy(iv, req->iv, GCM_IV_SIZE);
+
+	/* Linearize assoc, if not already linear */
+	if (req->src->length >= assoclen && req->src->length) {
+		scatterwalk_start(&assoc_sg_walk, req->src);
+		assoc = scatterwalk_map(&assoc_sg_walk);
+	} else {
+		gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
+			      GFP_KERNEL : GFP_ATOMIC;
+
+		/* assoc can be any length, so must be on heap */
+		assocmem = kmalloc(assoclen, flags);
+		if (unlikely(!assocmem))
+			return -ENOMEM;
+		assoc = assocmem;
+
+		scatterwalk_map_and_copy(assoc, req->src, 0, assoclen, 0);
+	}
+
+	vsx_begin();
+	gcmp10_init(gctx, iv, (unsigned char *) &ctx->enc_key, hash, assoc, assoclen);
+	vsx_end();
+
+	if (!assocmem)
+		scatterwalk_unmap(assoc);
+	else
+		kfree(assocmem);
+
+	if (enc)
+		ret = skcipher_walk_aead_encrypt(&walk, req, false);
+	else
+		ret = skcipher_walk_aead_decrypt(&walk, req, false);
+	if (ret)
+		return ret;
+
+	while (walk.nbytes > 0 && ret == 0) {
+
+		vsx_begin();
+		if (enc)
+			aes_p10_gcm_encrypt(walk.src.virt.addr,
+					    walk.dst.virt.addr,
+					    walk.nbytes,
+					    &ctx->enc_key, gctx->iv, hash->Htable);
+		else
+			aes_p10_gcm_decrypt(walk.src.virt.addr,
+					    walk.dst.virt.addr,
+					    walk.nbytes,
+					    &ctx->enc_key, gctx->iv, hash->Htable);
+		vsx_end();
+
+		total_processed += walk.nbytes;
+		ret = skcipher_walk_done(&walk, 0);
+	}
+
+	if (ret)
+		return ret;
+
+	/* Finalize hash */
+	vsx_begin();
+	finish_tag(gctx, hash, total_processed);
+	vsx_end();
+
+	/* copy Xi to end of dst */
+	if (enc)
+		scatterwalk_map_and_copy(hash->Htable, req->dst, req->assoclen + cryptlen,
+					 auth_tag_len, 1);
+	else {
+		scatterwalk_map_and_copy(otag, req->src,
+					 req->assoclen + cryptlen - auth_tag_len,
+					 auth_tag_len, 0);
+
+		if (crypto_memneq(otag, hash->Htable, auth_tag_len)) {
+			memzero_explicit(hash->Htable, 16);
+			return -EBADMSG;
+		}
+	}
+
+	return 0;
+}
+
+static int p10_aes_gcm_encrypt(struct aead_request *req)
+{
+	return p10_aes_gcm_crypt(req, 1);
+}
+
+static int p10_aes_gcm_decrypt(struct aead_request *req)
+{
+	return p10_aes_gcm_crypt(req, 0);
+}
+
+static struct aead_alg gcm_aes_alg = {
+	.ivsize			= GCM_IV_SIZE,
+	.maxauthsize		= 16,
+
+	.setauthsize		= set_authsize,
+	.setkey			= p10_aes_gcm_setkey,
+	.encrypt		= p10_aes_gcm_encrypt,
+	.decrypt		= p10_aes_gcm_decrypt,
+
+	.base.cra_name		= "gcm(aes)",
+	.base.cra_driver_name	= "p10_aes_gcm",
+	.base.cra_priority	= 2100,
+	.base.cra_blocksize	= 1,
+	.base.cra_ctxsize	= sizeof(struct p10_aes_gcm_ctx),
+	.base.cra_module	= THIS_MODULE,
+};
+
+static int __init p10_init(void)
+{
+	return crypto_register_aead(&gcm_aes_alg);
+}
+
+static void __exit p10_exit(void)
+{
+	crypto_unregister_aead(&gcm_aes_alg);
+}
+
+module_cpu_feature_match(PPC_MODULE_FEATURE_P10, p10_init);
+module_exit(p10_exit);
-- 
2.31.1

