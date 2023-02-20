Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2040269D521
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjBTUmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjBTUmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:42:44 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBE11B548;
        Mon, 20 Feb 2023 12:42:43 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31KJXw5n012484;
        Mon, 20 Feb 2023 20:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zspp1gBeWq/Zxui8Z0/RFMWuWAGxLTXlzMS5VZFkLzk=;
 b=hvPrd8x/MwRhBcEJqdaA4XvPe1LmbX5CUR6n0GK+sHELUuIQvL5mmfc+X3Ve/fQXYEE2
 6cJiD/So2HAaCPVDwBSWhend7PfP7ykX0v/kovmLJpsM1L2mW4SbXff8U7vIa1wtOC+g
 zhUmuoD07xVfHGRGVESkow9zHYDG6m9lO9scJeiDoi9OQFmP+5PS7D8ac2Sr96rwdhio
 dB9bF5uEHV5mOjbo149yyG2ROro66ED9YNWGcdGrbvOgzD32no4ShuUS2OQOer8fbr3l
 qlmahHHJNhHvrAkchEKtanSN1NKBG7qdxgKLonycpOKuk4pFNhvy/NoDRKGq9BPHrIEJ fw== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nvf4rh707-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 20:42:35 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31KIwcim023109;
        Mon, 20 Feb 2023 20:42:35 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3ntpa6q41p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 20:42:34 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31KKgXwN6750858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 20:42:33 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B6F958060;
        Mon, 20 Feb 2023 20:42:33 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C997E5803F;
        Mon, 20 Feb 2023 20:42:32 +0000 (GMT)
Received: from ltcden12-lp3.aus.stglabs.ibm.com (unknown [9.40.195.53])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Feb 2023 20:42:32 +0000 (GMT)
From:   Danny Tsen <dtsen@linux.ibm.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, ltcgcw@linux.vnet.ibm.com,
        dtsen@us.ibm.com, Danny Tsen <dtsen@linux.ibm.com>
Subject: [PATCH v4 2/6] Glue code for AES/GCM stitched implementation.
Date:   Mon, 20 Feb 2023 15:42:20 -0500
Message-Id: <20230220204224.4907-3-dtsen@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230220204224.4907-1-dtsen@linux.ibm.com>
References: <20230220204224.4907-1-dtsen@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CTnlA42EWyqCWgPO3nIoyxmsHLulW6RL
X-Proofpoint-ORIG-GUID: CTnlA42EWyqCWgPO3nIoyxmsHLulW6RL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_16,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200190
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
 arch/powerpc/crypto/aes-gcm-p10-glue.c | 345 +++++++++++++++++++++++++
 1 file changed, 345 insertions(+)
 create mode 100644 arch/powerpc/crypto/aes-gcm-p10-glue.c

diff --git a/arch/powerpc/crypto/aes-gcm-p10-glue.c b/arch/powerpc/crypto/aes-gcm-p10-glue.c
new file mode 100644
index 000000000000..c95f5b7cc456
--- /dev/null
+++ b/arch/powerpc/crypto/aes-gcm-p10-glue.c
@@ -0,0 +1,345 @@
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
+		alen -= i;
+	}
+	if (alen) {
+		for (i = 0; i < alen; i++)
+			nXi[i] ^= aad[i];
+
+		memset(gctx->aad_hash, 0, 16);
+		gcm_ghash_p8(gctx->aad_hash, hash->Htable+32, nXi, 16);
+	} else {
+		memcpy(gctx->aad_hash, nXi, 16);
+	}
+
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
+	if (len == 0 && gctx->aadLen == 0) {
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
+	.base.cra_driver_name	= "aes_gcm_p10",
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

