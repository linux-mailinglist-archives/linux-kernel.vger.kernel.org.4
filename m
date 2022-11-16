Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E7962B23D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 05:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbiKPEQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 23:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiKPEO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 23:14:56 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9551E3D2;
        Tue, 15 Nov 2022 20:14:29 -0800 (PST)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG3RlJw014105;
        Wed, 16 Nov 2022 04:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=ATW8MpC9q+O4VRVxf5janx71iQ8VtXUe9qgUYqmHxAc=;
 b=jSJnt9ZEzw1YYoF1FG+NFl8t5I5zXtZnNxu2Yv8IHUkho0bBgeBxFcbZtBLmZofqJ/ij
 TPXYEGb0+E5GKSuDuWmBWuk+oto4N33EZq7h8fU7mSsdcNh2yjEjWd39BiaChMY47TfB
 D3xXGAJKkjZfbUJG/mgCSREPUpXiPgjLGGdFFtFORlT84ud9ioqaPJVXuNeoJA0lgL9o
 fAnJ7ayuiBtfihXnmQP0Le/f+Pn0ZTUh2iwEp92hZcR9SjT0kxT2K99XoYjN8K+0tZ/+
 wqcjM+96NrUV1Fgnyx+RcLaszSBxPusaGuKucgQfaPAo8fzl8eWc4LbKPt4Qgnv9dBuJ lg== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kvqyfr9jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 04:14:17 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 8C75C2EECF;
        Wed, 16 Nov 2022 04:14:16 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 1DB358065DB;
        Wed, 16 Nov 2022 04:14:16 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v4 19/24] crypto: x86/aesni - avoid type conversions
Date:   Tue, 15 Nov 2022 22:13:37 -0600
Message-Id: <20221116041342.3841-20-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116041342.3841-1-elliott@hpe.com>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 10RL2QTx2GYoy_g3Ammilg1YMs8JFH35
X-Proofpoint-ORIG-GUID: 10RL2QTx2GYoy_g3Ammilg1YMs8JFH35
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211160029
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the type of the GCM auth_tag_len argument and derivative
variables from unsigned long to unsigned int, so they preserve the
type returned by crypto_aead_authsize().

Continue to pass it to the asm functions as an unsigned long,
but let those function calls be the place where the conversion
to the possibly larger type occurs.

This avoids possible truncation for calculations like:
    scatterwalk_map_and_copy(auth_tag_msg, req->src,
                             req->assoclen + req->cryptlen - auth_tag_len,
                             auth_tag_len, 0);

whose third argument is an unsigned int. If unsigned long were
bigger than unsigned int, that equation could wrap.

Use unsigned int rather than int for intermediate variables
containing byte counts and block counts, since all the functions
using them accept unsigned int arguments.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/aesni-intel_glue.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index a5b0cb3efeba..921680373855 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -381,7 +381,7 @@ static int cts_cbc_encrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct crypto_aes_ctx *ctx = aes_ctx(crypto_skcipher_ctx(tfm));
-	int cbc_blocks = DIV_ROUND_UP(req->cryptlen, AES_BLOCK_SIZE) - 2;
+	unsigned int cbc_blocks = DIV_ROUND_UP(req->cryptlen, AES_BLOCK_SIZE) - 2;
 	struct scatterlist *src = req->src, *dst = req->dst;
 	struct scatterlist sg_src[2], sg_dst[2];
 	struct skcipher_request subreq;
@@ -437,7 +437,7 @@ static int cts_cbc_decrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct crypto_aes_ctx *ctx = aes_ctx(crypto_skcipher_ctx(tfm));
-	int cbc_blocks = DIV_ROUND_UP(req->cryptlen, AES_BLOCK_SIZE) - 2;
+	unsigned int cbc_blocks = DIV_ROUND_UP(req->cryptlen, AES_BLOCK_SIZE) - 2;
 	struct scatterlist *src = req->src, *dst = req->dst;
 	struct scatterlist sg_src[2], sg_dst[2];
 	struct skcipher_request subreq;
@@ -671,11 +671,11 @@ static int generic_gcmaes_set_authsize(struct crypto_aead *tfm,
 static int gcmaes_crypt_by_sg(bool enc, struct aead_request *req,
 			      unsigned int assoclen, u8 *hash_subkey,
 			      u8 *iv, void *aes_ctx, u8 *auth_tag,
-			      unsigned long auth_tag_len)
+			      unsigned int auth_tag_len)
 {
 	u8 databuf[sizeof(struct gcm_context_data) + (AESNI_ALIGN - 8)] __aligned(8);
 	struct gcm_context_data *data = PTR_ALIGN((void *)databuf, AESNI_ALIGN);
-	unsigned long left = req->cryptlen;
+	unsigned int left = req->cryptlen;
 	struct scatter_walk assoc_sg_walk;
 	struct skcipher_walk walk;
 	bool do_avx, do_avx2;
@@ -782,7 +782,7 @@ static int gcmaes_encrypt(struct aead_request *req, unsigned int assoclen,
 			  u8 *hash_subkey, u8 *iv, void *aes_ctx)
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	unsigned long auth_tag_len = crypto_aead_authsize(tfm);
+	unsigned int auth_tag_len = crypto_aead_authsize(tfm);
 	u8 auth_tag[16];
 	int err;
 
@@ -801,7 +801,7 @@ static int gcmaes_decrypt(struct aead_request *req, unsigned int assoclen,
 			  u8 *hash_subkey, u8 *iv, void *aes_ctx)
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	unsigned long auth_tag_len = crypto_aead_authsize(tfm);
+	unsigned int auth_tag_len = crypto_aead_authsize(tfm);
 	u8 auth_tag_msg[16];
 	u8 auth_tag[16];
 	int err;
@@ -907,7 +907,7 @@ static int xts_crypt(struct skcipher_request *req, bool encrypt)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct aesni_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
-	int tail = req->cryptlen % AES_BLOCK_SIZE;
+	unsigned int tail = req->cryptlen % AES_BLOCK_SIZE;
 	struct skcipher_request subreq;
 	struct skcipher_walk walk;
 	int err;
@@ -920,7 +920,7 @@ static int xts_crypt(struct skcipher_request *req, bool encrypt)
 		return err;
 
 	if (unlikely(tail > 0 && walk.nbytes < walk.total)) {
-		int blocks = DIV_ROUND_UP(req->cryptlen, AES_BLOCK_SIZE) - 2;
+		unsigned int blocks = DIV_ROUND_UP(req->cryptlen, AES_BLOCK_SIZE) - 2;
 
 		skcipher_walk_abort(&walk);
 
@@ -945,7 +945,7 @@ static int xts_crypt(struct skcipher_request *req, bool encrypt)
 	aesni_enc(aes_ctx(ctx->raw_tweak_ctx), walk.iv, walk.iv);
 
 	while (walk.nbytes > 0) {
-		int nbytes = walk.nbytes;
+		unsigned int nbytes = walk.nbytes;
 
 		if (nbytes < walk.total)
 			nbytes &= ~(AES_BLOCK_SIZE - 1);
-- 
2.38.1

