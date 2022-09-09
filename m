Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CCF5B3495
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiIIJuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiIIJt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:49:59 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E0295A4;
        Fri,  9 Sep 2022 02:49:55 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MPB2L13swz14QVv;
        Fri,  9 Sep 2022 17:46:02 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 17:49:53 +0800
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 17:49:52 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Wenkai Lin <linwenkai6@hisilicon.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 09/10] crypto: hisilicon/sec - get algorithm bitmap from registers
Date:   Fri, 9 Sep 2022 17:47:03 +0800
Message-ID: <20220909094704.32099-10-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220909094704.32099-1-qianweili@huawei.com>
References: <20220909094704.32099-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenkai Lin <linwenkai6@hisilicon.com>

Add function 'sec_get_alg_bitmap' to get hardware algorithm bitmap
before register algorithm to crypto, instead of determining
whether to register an algorithm based on hardware platform's version.

Signed-off-by: Wenkai Lin <linwenkai6@hisilicon.com>
Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec.h        |  18 ++
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 306 +++++++++++++--------
 drivers/crypto/hisilicon/sec2/sec_main.c   |  33 ++-
 3 files changed, 236 insertions(+), 121 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index 895ba9b47554..3e57fc04b377 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -201,10 +201,28 @@ enum sec_cap_type {
 	SEC_RESET_MASK_CAP,
 	SEC_OOO_SHUTDOWN_MASK_CAP,
 	SEC_CE_MASK_CAP,
+	SEC_CLUSTER_NUM_CAP,
+	SEC_CORE_TYPE_NUM_CAP,
+	SEC_CORE_NUM_CAP,
+	SEC_CORES_PER_CLUSTER_NUM_CAP,
+	SEC_CORE_ENABLE_BITMAP,
+	SEC_DRV_ALG_BITMAP_LOW,
+	SEC_DRV_ALG_BITMAP_HIGH,
+	SEC_DEV_ALG_BITMAP_LOW,
+	SEC_DEV_ALG_BITMAP_HIGH,
+	SEC_CORE1_ALG_BITMAP_LOW,
+	SEC_CORE1_ALG_BITMAP_HIGH,
+	SEC_CORE2_ALG_BITMAP_LOW,
+	SEC_CORE2_ALG_BITMAP_HIGH,
+	SEC_CORE3_ALG_BITMAP_LOW,
+	SEC_CORE3_ALG_BITMAP_HIGH,
+	SEC_CORE4_ALG_BITMAP_LOW,
+	SEC_CORE4_ALG_BITMAP_HIGH,
 };
 
 void sec_destroy_qps(struct hisi_qp **qps, int qp_num);
 struct hisi_qp **sec_create_qps(void);
 int sec_register_to_crypto(struct hisi_qm *qm);
 void sec_unregister_from_crypto(struct hisi_qm *qm);
+u64 sec_get_alg_bitmap(struct hisi_qm *qm, u32 high, u32 low);
 #endif
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index db2165e9fcbf..1be4f496d3c4 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -104,6 +104,16 @@
 #define IV_CTR_INIT		0x1
 #define IV_BYTE_OFFSET		0x8
 
+struct sec_skcipher {
+	u64 alg_msk;
+	struct skcipher_alg alg;
+};
+
+struct sec_aead {
+	u64 alg_msk;
+	struct aead_alg alg;
+};
+
 /* Get an en/de-cipher queue cyclically to balance load over queues of TFM */
 static inline int sec_alloc_queue_id(struct sec_ctx *ctx, struct sec_req *req)
 {
@@ -2160,67 +2170,80 @@ static int sec_skcipher_decrypt(struct skcipher_request *sk_req)
 	.min_keysize = sec_min_key_size,\
 	.max_keysize = sec_max_key_size,\
 	.ivsize = iv_size,\
-},
+}
 
 #define SEC_SKCIPHER_ALG(name, key_func, min_key_size, \
 	max_key_size, blk_size, iv_size) \
 	SEC_SKCIPHER_GEN_ALG(name, key_func, min_key_size, max_key_size, \
 	sec_skcipher_ctx_init, sec_skcipher_ctx_exit, blk_size, iv_size)
 
-static struct skcipher_alg sec_skciphers[] = {
-	SEC_SKCIPHER_ALG("ecb(aes)", sec_setkey_aes_ecb,
-			 AES_MIN_KEY_SIZE, AES_MAX_KEY_SIZE,
-			 AES_BLOCK_SIZE, 0)
-
-	SEC_SKCIPHER_ALG("cbc(aes)", sec_setkey_aes_cbc,
-			 AES_MIN_KEY_SIZE, AES_MAX_KEY_SIZE,
-			 AES_BLOCK_SIZE, AES_BLOCK_SIZE)
-
-	SEC_SKCIPHER_ALG("xts(aes)", sec_setkey_aes_xts,
-			 SEC_XTS_MIN_KEY_SIZE, SEC_XTS_MAX_KEY_SIZE,
-			 AES_BLOCK_SIZE, AES_BLOCK_SIZE)
-
-	SEC_SKCIPHER_ALG("ecb(des3_ede)", sec_setkey_3des_ecb,
-			 SEC_DES3_3KEY_SIZE, SEC_DES3_3KEY_SIZE,
-			 DES3_EDE_BLOCK_SIZE, 0)
-
-	SEC_SKCIPHER_ALG("cbc(des3_ede)", sec_setkey_3des_cbc,
-			 SEC_DES3_3KEY_SIZE, SEC_DES3_3KEY_SIZE,
-			 DES3_EDE_BLOCK_SIZE, DES3_EDE_BLOCK_SIZE)
-
-	SEC_SKCIPHER_ALG("xts(sm4)", sec_setkey_sm4_xts,
-			 SEC_XTS_MIN_KEY_SIZE, SEC_XTS_MIN_KEY_SIZE,
-			 AES_BLOCK_SIZE, AES_BLOCK_SIZE)
-
-	SEC_SKCIPHER_ALG("cbc(sm4)", sec_setkey_sm4_cbc,
-			 AES_MIN_KEY_SIZE, AES_MIN_KEY_SIZE,
-			 AES_BLOCK_SIZE, AES_BLOCK_SIZE)
-};
-
-static struct skcipher_alg sec_skciphers_v3[] = {
-	SEC_SKCIPHER_ALG("ofb(aes)", sec_setkey_aes_ofb,
-			 AES_MIN_KEY_SIZE, AES_MAX_KEY_SIZE,
-			 SEC_MIN_BLOCK_SZ, AES_BLOCK_SIZE)
-
-	SEC_SKCIPHER_ALG("cfb(aes)", sec_setkey_aes_cfb,
-			 AES_MIN_KEY_SIZE, AES_MAX_KEY_SIZE,
-			 SEC_MIN_BLOCK_SZ, AES_BLOCK_SIZE)
-
-	SEC_SKCIPHER_ALG("ctr(aes)", sec_setkey_aes_ctr,
-			 AES_MIN_KEY_SIZE, AES_MAX_KEY_SIZE,
-			 SEC_MIN_BLOCK_SZ, AES_BLOCK_SIZE)
-
-	SEC_SKCIPHER_ALG("ofb(sm4)", sec_setkey_sm4_ofb,
-			 AES_MIN_KEY_SIZE, AES_MIN_KEY_SIZE,
-			 SEC_MIN_BLOCK_SZ, AES_BLOCK_SIZE)
-
-	SEC_SKCIPHER_ALG("cfb(sm4)", sec_setkey_sm4_cfb,
-			 AES_MIN_KEY_SIZE, AES_MIN_KEY_SIZE,
-			 SEC_MIN_BLOCK_SZ, AES_BLOCK_SIZE)
-
-	SEC_SKCIPHER_ALG("ctr(sm4)", sec_setkey_sm4_ctr,
-			 AES_MIN_KEY_SIZE, AES_MIN_KEY_SIZE,
-			 SEC_MIN_BLOCK_SZ, AES_BLOCK_SIZE)
+static struct sec_skcipher sec_skciphers[] = {
+	{
+		.alg_msk = BIT(0),
+		.alg = SEC_SKCIPHER_ALG("ecb(aes)", sec_setkey_aes_ecb, AES_MIN_KEY_SIZE,
+					AES_MAX_KEY_SIZE, AES_BLOCK_SIZE, 0),
+	},
+	{
+		.alg_msk = BIT(1),
+		.alg = SEC_SKCIPHER_ALG("cbc(aes)", sec_setkey_aes_cbc, AES_MIN_KEY_SIZE,
+					AES_MAX_KEY_SIZE, AES_BLOCK_SIZE, AES_BLOCK_SIZE),
+	},
+	{
+		.alg_msk = BIT(2),
+		.alg = SEC_SKCIPHER_ALG("ctr(aes)", sec_setkey_aes_ctr,	AES_MIN_KEY_SIZE,
+					AES_MAX_KEY_SIZE, SEC_MIN_BLOCK_SZ, AES_BLOCK_SIZE),
+	},
+	{
+		.alg_msk = BIT(3),
+		.alg = SEC_SKCIPHER_ALG("xts(aes)", sec_setkey_aes_xts,	SEC_XTS_MIN_KEY_SIZE,
+					SEC_XTS_MAX_KEY_SIZE, AES_BLOCK_SIZE, AES_BLOCK_SIZE),
+	},
+	{
+		.alg_msk = BIT(4),
+		.alg = SEC_SKCIPHER_ALG("ofb(aes)", sec_setkey_aes_ofb,	AES_MIN_KEY_SIZE,
+					AES_MAX_KEY_SIZE, SEC_MIN_BLOCK_SZ, AES_BLOCK_SIZE),
+	},
+	{
+		.alg_msk = BIT(5),
+		.alg = SEC_SKCIPHER_ALG("cfb(aes)", sec_setkey_aes_cfb,	AES_MIN_KEY_SIZE,
+					AES_MAX_KEY_SIZE, SEC_MIN_BLOCK_SZ, AES_BLOCK_SIZE),
+	},
+	{
+		.alg_msk = BIT(12),
+		.alg = SEC_SKCIPHER_ALG("cbc(sm4)", sec_setkey_sm4_cbc,	AES_MIN_KEY_SIZE,
+					AES_MIN_KEY_SIZE, AES_BLOCK_SIZE, AES_BLOCK_SIZE),
+	},
+	{
+		.alg_msk = BIT(13),
+		.alg = SEC_SKCIPHER_ALG("ctr(sm4)", sec_setkey_sm4_ctr, AES_MIN_KEY_SIZE,
+					AES_MIN_KEY_SIZE, SEC_MIN_BLOCK_SZ, AES_BLOCK_SIZE),
+	},
+	{
+		.alg_msk = BIT(14),
+		.alg = SEC_SKCIPHER_ALG("xts(sm4)", sec_setkey_sm4_xts,	SEC_XTS_MIN_KEY_SIZE,
+					SEC_XTS_MIN_KEY_SIZE, AES_BLOCK_SIZE, AES_BLOCK_SIZE),
+	},
+	{
+		.alg_msk = BIT(15),
+		.alg = SEC_SKCIPHER_ALG("ofb(sm4)", sec_setkey_sm4_ofb,	AES_MIN_KEY_SIZE,
+					AES_MIN_KEY_SIZE, SEC_MIN_BLOCK_SZ, AES_BLOCK_SIZE),
+	},
+	{
+		.alg_msk = BIT(16),
+		.alg = SEC_SKCIPHER_ALG("cfb(sm4)", sec_setkey_sm4_cfb,	AES_MIN_KEY_SIZE,
+					AES_MIN_KEY_SIZE, SEC_MIN_BLOCK_SZ, AES_BLOCK_SIZE),
+	},
+	{
+		.alg_msk = BIT(23),
+		.alg = SEC_SKCIPHER_ALG("ecb(des3_ede)", sec_setkey_3des_ecb, SEC_DES3_3KEY_SIZE,
+					SEC_DES3_3KEY_SIZE, DES3_EDE_BLOCK_SIZE, 0),
+	},
+	{
+		.alg_msk = BIT(24),
+		.alg = SEC_SKCIPHER_ALG("cbc(des3_ede)", sec_setkey_3des_cbc, SEC_DES3_3KEY_SIZE,
+					SEC_DES3_3KEY_SIZE, DES3_EDE_BLOCK_SIZE,
+					DES3_EDE_BLOCK_SIZE),
+	},
 };
 
 static int aead_iv_demension_check(struct aead_request *aead_req)
@@ -2414,90 +2437,135 @@ static int sec_aead_decrypt(struct aead_request *a_req)
 	.maxauthsize = max_authsize,\
 }
 
-static struct aead_alg sec_aeads[] = {
-	SEC_AEAD_ALG("authenc(hmac(sha1),cbc(aes))",
-		     sec_setkey_aes_cbc_sha1, sec_aead_sha1_ctx_init,
-		     sec_aead_ctx_exit, AES_BLOCK_SIZE,
-		     AES_BLOCK_SIZE, SHA1_DIGEST_SIZE),
+static struct sec_aead sec_aeads[] = {
+	{
+		.alg_msk = BIT(6),
+		.alg = SEC_AEAD_ALG("ccm(aes)", sec_setkey_aes_ccm, sec_aead_xcm_ctx_init,
+				    sec_aead_xcm_ctx_exit, SEC_MIN_BLOCK_SZ, AES_BLOCK_SIZE,
+				    AES_BLOCK_SIZE),
+	},
+	{
+		.alg_msk = BIT(7),
+		.alg = SEC_AEAD_ALG("gcm(aes)", sec_setkey_aes_gcm, sec_aead_xcm_ctx_init,
+				    sec_aead_xcm_ctx_exit, SEC_MIN_BLOCK_SZ, SEC_AIV_SIZE,
+				    AES_BLOCK_SIZE),
+	},
+	{
+		.alg_msk = BIT(17),
+		.alg = SEC_AEAD_ALG("ccm(sm4)", sec_setkey_sm4_ccm, sec_aead_xcm_ctx_init,
+				    sec_aead_xcm_ctx_exit, SEC_MIN_BLOCK_SZ, AES_BLOCK_SIZE,
+				    AES_BLOCK_SIZE),
+	},
+	{
+		.alg_msk = BIT(18),
+		.alg = SEC_AEAD_ALG("gcm(sm4)", sec_setkey_sm4_gcm, sec_aead_xcm_ctx_init,
+				    sec_aead_xcm_ctx_exit, SEC_MIN_BLOCK_SZ, SEC_AIV_SIZE,
+				    AES_BLOCK_SIZE),
+	},
+	{
+		.alg_msk = BIT(43),
+		.alg = SEC_AEAD_ALG("authenc(hmac(sha1),cbc(aes))", sec_setkey_aes_cbc_sha1,
+				    sec_aead_sha1_ctx_init, sec_aead_ctx_exit, AES_BLOCK_SIZE,
+				    AES_BLOCK_SIZE, SHA1_DIGEST_SIZE),
+	},
+	{
+		.alg_msk = BIT(44),
+		.alg = SEC_AEAD_ALG("authenc(hmac(sha256),cbc(aes))", sec_setkey_aes_cbc_sha256,
+				    sec_aead_sha256_ctx_init, sec_aead_ctx_exit, AES_BLOCK_SIZE,
+				    AES_BLOCK_SIZE, SHA256_DIGEST_SIZE),
+	},
+	{
+		.alg_msk = BIT(45),
+		.alg = SEC_AEAD_ALG("authenc(hmac(sha512),cbc(aes))", sec_setkey_aes_cbc_sha512,
+				    sec_aead_sha512_ctx_init, sec_aead_ctx_exit, AES_BLOCK_SIZE,
+				    AES_BLOCK_SIZE, SHA512_DIGEST_SIZE),
+	},
+};
+
+static void sec_unregister_skcipher(u64 alg_mask, int end)
+{
+	int i;
 
-	SEC_AEAD_ALG("authenc(hmac(sha256),cbc(aes))",
-		     sec_setkey_aes_cbc_sha256, sec_aead_sha256_ctx_init,
-		     sec_aead_ctx_exit, AES_BLOCK_SIZE,
-		     AES_BLOCK_SIZE, SHA256_DIGEST_SIZE),
+	for (i = 0; i < end; i++)
+		if (sec_skciphers[i].alg_msk & alg_mask)
+			crypto_unregister_skcipher(&sec_skciphers[i].alg);
+}
 
-	SEC_AEAD_ALG("authenc(hmac(sha512),cbc(aes))",
-		     sec_setkey_aes_cbc_sha512, sec_aead_sha512_ctx_init,
-		     sec_aead_ctx_exit, AES_BLOCK_SIZE,
-		     AES_BLOCK_SIZE, SHA512_DIGEST_SIZE),
+static int sec_register_skcipher(u64 alg_mask)
+{
+	int i, ret, count;
 
-	SEC_AEAD_ALG("ccm(aes)", sec_setkey_aes_ccm, sec_aead_xcm_ctx_init,
-		     sec_aead_xcm_ctx_exit, SEC_MIN_BLOCK_SZ,
-		     AES_BLOCK_SIZE, AES_BLOCK_SIZE),
+	count = ARRAY_SIZE(sec_skciphers);
 
-	SEC_AEAD_ALG("gcm(aes)", sec_setkey_aes_gcm, sec_aead_xcm_ctx_init,
-		     sec_aead_xcm_ctx_exit, SEC_MIN_BLOCK_SZ,
-		     SEC_AIV_SIZE, AES_BLOCK_SIZE)
-};
+	for (i = 0; i < count; i++) {
+		if (!(sec_skciphers[i].alg_msk & alg_mask))
+			continue;
 
-static struct aead_alg sec_aeads_v3[] = {
-	SEC_AEAD_ALG("ccm(sm4)", sec_setkey_sm4_ccm, sec_aead_xcm_ctx_init,
-		     sec_aead_xcm_ctx_exit, SEC_MIN_BLOCK_SZ,
-		     AES_BLOCK_SIZE, AES_BLOCK_SIZE),
+		ret = crypto_register_skcipher(&sec_skciphers[i].alg);
+		if (ret)
+			goto err;
+	}
 
-	SEC_AEAD_ALG("gcm(sm4)", sec_setkey_sm4_gcm, sec_aead_xcm_ctx_init,
-		     sec_aead_xcm_ctx_exit, SEC_MIN_BLOCK_SZ,
-		     SEC_AIV_SIZE, AES_BLOCK_SIZE)
-};
+	return 0;
+
+err:
+	sec_unregister_skcipher(alg_mask, i);
+
+	return ret;
+}
+
+static void sec_unregister_aead(u64 alg_mask, int end)
+{
+	int i;
+
+	for (i = 0; i < end; i++)
+		if (sec_aeads[i].alg_msk & alg_mask)
+			crypto_unregister_aead(&sec_aeads[i].alg);
+}
+
+static int sec_register_aead(u64 alg_mask)
+{
+	int i, ret, count;
+
+	count = ARRAY_SIZE(sec_aeads);
+
+	for (i = 0; i < count; i++) {
+		if (!(sec_aeads[i].alg_msk & alg_mask))
+			continue;
+
+		ret = crypto_register_aead(&sec_aeads[i].alg);
+		if (ret)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	sec_unregister_aead(alg_mask, i);
+
+	return ret;
+}
 
 int sec_register_to_crypto(struct hisi_qm *qm)
 {
+	u64 alg_mask = sec_get_alg_bitmap(qm, SEC_DRV_ALG_BITMAP_HIGH, SEC_DRV_ALG_BITMAP_LOW);
 	int ret;
 
-	/* To avoid repeat register */
-	ret = crypto_register_skciphers(sec_skciphers,
-					ARRAY_SIZE(sec_skciphers));
+	ret = sec_register_skcipher(alg_mask);
 	if (ret)
 		return ret;
 
-	if (qm->ver > QM_HW_V2) {
-		ret = crypto_register_skciphers(sec_skciphers_v3,
-						ARRAY_SIZE(sec_skciphers_v3));
-		if (ret)
-			goto reg_skcipher_fail;
-	}
-
-	ret = crypto_register_aeads(sec_aeads, ARRAY_SIZE(sec_aeads));
+	ret = sec_register_aead(alg_mask);
 	if (ret)
-		goto reg_aead_fail;
-	if (qm->ver > QM_HW_V2) {
-		ret = crypto_register_aeads(sec_aeads_v3, ARRAY_SIZE(sec_aeads_v3));
-		if (ret)
-			goto reg_aead_v3_fail;
-	}
-	return ret;
+		sec_unregister_skcipher(alg_mask, ARRAY_SIZE(sec_skciphers));
 
-reg_aead_v3_fail:
-	crypto_unregister_aeads(sec_aeads, ARRAY_SIZE(sec_aeads));
-reg_aead_fail:
-	if (qm->ver > QM_HW_V2)
-		crypto_unregister_skciphers(sec_skciphers_v3,
-					    ARRAY_SIZE(sec_skciphers_v3));
-reg_skcipher_fail:
-	crypto_unregister_skciphers(sec_skciphers,
-				    ARRAY_SIZE(sec_skciphers));
 	return ret;
 }
 
 void sec_unregister_from_crypto(struct hisi_qm *qm)
 {
-	if (qm->ver > QM_HW_V2)
-		crypto_unregister_aeads(sec_aeads_v3,
-					ARRAY_SIZE(sec_aeads_v3));
-	crypto_unregister_aeads(sec_aeads, ARRAY_SIZE(sec_aeads));
+	u64 alg_mask = sec_get_alg_bitmap(qm, SEC_DRV_ALG_BITMAP_HIGH, SEC_DRV_ALG_BITMAP_LOW);
 
-	if (qm->ver > QM_HW_V2)
-		crypto_unregister_skciphers(sec_skciphers_v3,
-					    ARRAY_SIZE(sec_skciphers_v3));
-	crypto_unregister_skciphers(sec_skciphers,
-				    ARRAY_SIZE(sec_skciphers));
+	sec_unregister_aead(alg_mask, ARRAY_SIZE(sec_aeads));
+	sec_unregister_skcipher(alg_mask, ARRAY_SIZE(sec_skciphers));
 }
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index e814f94dd0d4..84233a489c74 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -41,7 +41,6 @@
 #define SEC_ECC_NUM			16
 #define SEC_ECC_MASH			0xFF
 #define SEC_CORE_INT_DISABLE		0x0
-#define SEC_SAA_ENABLE			0x17f
 
 #define SEC_RAS_CE_REG			0x301050
 #define SEC_RAS_FE_REG			0x301054
@@ -114,6 +113,8 @@
 #define SEC_DFX_COMMON1_LEN		0x45
 #define SEC_DFX_COMMON2_LEN		0xBA
 
+#define SEC_ALG_BITMAP_SHIFT		32
+
 struct sec_hw_error {
 	u32 int_msk;
 	const char *msg;
@@ -141,6 +142,23 @@ static const struct hisi_qm_cap_info sec_basic_info[] = {
 	{SEC_RESET_MASK_CAP,    0x3134, 0, GENMASK(31, 0), 0x0, 0x177, 0x177},
 	{SEC_OOO_SHUTDOWN_MASK_CAP, 0x3134, 0, GENMASK(31, 0), 0x0, 0x4, 0x177},
 	{SEC_CE_MASK_CAP,       0x3138, 0, GENMASK(31, 0), 0x0, 0x88, 0xC088},
+	{SEC_CLUSTER_NUM_CAP, 0x313c, 20, GENMASK(3, 0), 0x1, 0x1, 0x1},
+	{SEC_CORE_TYPE_NUM_CAP, 0x313c, 16, GENMASK(3, 0), 0x1, 0x1, 0x1},
+	{SEC_CORE_NUM_CAP, 0x313c, 8, GENMASK(7, 0), 0x4, 0x4, 0x4},
+	{SEC_CORES_PER_CLUSTER_NUM_CAP, 0x313c, 0, GENMASK(7, 0), 0x4, 0x4, 0x4},
+	{SEC_CORE_ENABLE_BITMAP, 0x3140, 32, GENMASK(31, 0), 0x17F, 0x17F, 0xF},
+	{SEC_DRV_ALG_BITMAP_LOW, 0x3144, 0, GENMASK(31, 0), 0x18050CB, 0x18050CB, 0x187F0FF},
+	{SEC_DRV_ALG_BITMAP_HIGH, 0x3148, 0, GENMASK(31, 0), 0x395C, 0x395C, 0x395C},
+	{SEC_DEV_ALG_BITMAP_LOW, 0x314c, 0, GENMASK(31, 0), 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF},
+	{SEC_DEV_ALG_BITMAP_HIGH, 0x3150, 0, GENMASK(31, 0), 0x3FFF, 0x3FFF, 0x3FFF},
+	{SEC_CORE1_ALG_BITMAP_LOW, 0x3154, 0, GENMASK(31, 0), 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF},
+	{SEC_CORE1_ALG_BITMAP_HIGH, 0x3158, 0, GENMASK(31, 0), 0x3FFF, 0x3FFF, 0x3FFF},
+	{SEC_CORE2_ALG_BITMAP_LOW, 0x315c, 0, GENMASK(31, 0), 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF},
+	{SEC_CORE2_ALG_BITMAP_HIGH, 0x3160, 0, GENMASK(31, 0), 0x3FFF, 0x3FFF, 0x3FFF},
+	{SEC_CORE3_ALG_BITMAP_LOW, 0x3164, 0, GENMASK(31, 0), 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF},
+	{SEC_CORE3_ALG_BITMAP_HIGH, 0x3168, 0, GENMASK(31, 0), 0x3FFF, 0x3FFF, 0x3FFF},
+	{SEC_CORE4_ALG_BITMAP_LOW, 0x316c, 0, GENMASK(31, 0), 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF},
+	{SEC_CORE4_ALG_BITMAP_HIGH, 0x3170, 0, GENMASK(31, 0), 0x3FFF, 0x3FFF, 0x3FFF},
 };
 
 static const struct sec_hw_error sec_hw_errors[] = {
@@ -345,6 +363,16 @@ struct hisi_qp **sec_create_qps(void)
 	return NULL;
 }
 
+u64 sec_get_alg_bitmap(struct hisi_qm *qm, u32 high, u32 low)
+{
+	u32 cap_val_h, cap_val_l;
+
+	cap_val_h = hisi_qm_get_hw_info(qm, sec_basic_info, high, qm->cap_ver);
+	cap_val_l = hisi_qm_get_hw_info(qm, sec_basic_info, low, qm->cap_ver);
+
+	return ((u64)cap_val_h << SEC_ALG_BITMAP_SHIFT) | (u64)cap_val_l;
+}
+
 static const struct kernel_param_ops sec_uacce_mode_ops = {
 	.set = uacce_mode_set,
 	.get = param_get_int,
@@ -512,7 +540,8 @@ static int sec_engine_init(struct hisi_qm *qm)
 	writel(SEC_SINGLE_PORT_MAX_TRANS,
 	       qm->io_base + AM_CFG_SINGLE_PORT_MAX_TRANS);
 
-	writel(SEC_SAA_ENABLE, qm->io_base + SEC_SAA_EN_REG);
+	reg = hisi_qm_get_hw_info(qm, sec_basic_info, SEC_CORE_ENABLE_BITMAP, qm->cap_ver);
+	writel(reg, qm->io_base + SEC_SAA_EN_REG);
 
 	if (qm->ver < QM_HW_V3) {
 		/* HW V2 enable sm4 extra mode, as ctr/ecb */
-- 
2.33.0

