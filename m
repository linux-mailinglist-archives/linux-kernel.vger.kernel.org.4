Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285AE651412
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiLSUh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbiLSUhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:37:46 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49579D13F;
        Mon, 19 Dec 2022 12:37:46 -0800 (PST)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJHcBaJ025331;
        Mon, 19 Dec 2022 20:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=0VSNaOL1jHOqTtf/WTfp7k2gMnlP7/VAaH2DyvhO7vE=;
 b=XaRQpNtawbs6fYmBkeRKeHiWgPzALDRuFchXjxuS5BcsVf6cife0cwZlC+WCBZ1fjpr6
 UtKxgbpr/Q8Cnd/Ct0NlyE35dsO4ZsuMVg2WIyox5uHVXf5Jh13dxe0u77Uu2B9H7Jzr
 uD2tcSOST4LRJAACHZ3WeI5Am6mLU61WUehsCSCUyKlGvvedJNSxOZZtwSxuc3pXLgjT
 FERrQemYQlemdyJFto1RBNp6fzR9zlHRBYE1DsBoER1nrPKWCm2BUGKfCUUxNC3Km8sa
 BdOTnjORxAWrAptZG1N3I8oY2+6lLvpvimo4OJuiAwfJeVf8vvIIL2UyhhtyJ1NqGSyA tQ== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3mjvh693mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 20:37:43 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 40CDF2F1EC;
        Mon, 19 Dec 2022 20:37:42 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id F1B5A807B14;
        Mon, 19 Dec 2022 20:37:41 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Elliott <elliott@hpe.com>
Subject: [PATCH 2/3] crypto: aead/shash - yield at end of operations
Date:   Mon, 19 Dec 2022 14:37:32 -0600
Message-Id: <20221219203733.3063192-3-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219203733.3063192-1-elliott@hpe.com>
References: <20221219203733.3063192-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EzcKw8IYXUKEw2q5tOsCcHTz0u6rdnfy
X-Proofpoint-ORIG-GUID: EzcKw8IYXUKEw2q5tOsCcHTz0u6rdnfy
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=943 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190181
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add crypto_yield() calls at the end of all the encrypt and decrypt
functions to let the scheduler use the CPU after possibly a long
tenure by the crypto driver.

This reduces RCU stalls and soft lockups when running crypto
functions back-to-back that don't have their own yield calls
(e.g., aligned generic functions).

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 crypto/aead.c  |  4 ++++
 crypto/shash.c | 32 ++++++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/crypto/aead.c b/crypto/aead.c
index 16991095270d..f88378f4d4f5 100644
--- a/crypto/aead.c
+++ b/crypto/aead.c
@@ -93,6 +93,8 @@ int crypto_aead_encrypt(struct aead_request *req)
 	else
 		ret = crypto_aead_alg(aead)->encrypt(req);
 	crypto_stats_aead_encrypt(cryptlen, alg, ret);
+
+	crypto_yield(crypto_aead_get_flags(aead));
 	return ret;
 }
 EXPORT_SYMBOL_GPL(crypto_aead_encrypt);
@@ -112,6 +114,8 @@ int crypto_aead_decrypt(struct aead_request *req)
 	else
 		ret = crypto_aead_alg(aead)->decrypt(req);
 	crypto_stats_aead_decrypt(cryptlen, alg, ret);
+
+	crypto_yield(crypto_aead_get_flags(aead));
 	return ret;
 }
 EXPORT_SYMBOL_GPL(crypto_aead_decrypt);
diff --git a/crypto/shash.c b/crypto/shash.c
index 868b6ba2b3b7..6fea17a50048 100644
--- a/crypto/shash.c
+++ b/crypto/shash.c
@@ -114,11 +114,15 @@ int crypto_shash_update(struct shash_desc *desc, const u8 *data,
 	struct crypto_shash *tfm = desc->tfm;
 	struct shash_alg *shash = crypto_shash_alg(tfm);
 	unsigned long alignmask = crypto_shash_alignmask(tfm);
+	int ret;
 
 	if ((unsigned long)data & alignmask)
-		return shash_update_unaligned(desc, data, len);
+		ret = shash_update_unaligned(desc, data, len);
+	else
+		ret = shash->update(desc, data, len);
 
-	return shash->update(desc, data, len);
+	crypto_yield(crypto_shash_get_flags(tfm));
+	return ret;
 }
 EXPORT_SYMBOL_GPL(crypto_shash_update);
 
@@ -155,11 +159,15 @@ int crypto_shash_final(struct shash_desc *desc, u8 *out)
 	struct crypto_shash *tfm = desc->tfm;
 	struct shash_alg *shash = crypto_shash_alg(tfm);
 	unsigned long alignmask = crypto_shash_alignmask(tfm);
+	int ret;
 
 	if ((unsigned long)out & alignmask)
-		return shash_final_unaligned(desc, out);
+		ret = shash_final_unaligned(desc, out);
+	else
+		ret = shash->final(desc, out);
 
-	return shash->final(desc, out);
+	crypto_yield(crypto_shash_get_flags(tfm));
+	return ret;
 }
 EXPORT_SYMBOL_GPL(crypto_shash_final);
 
@@ -176,11 +184,15 @@ int crypto_shash_finup(struct shash_desc *desc, const u8 *data,
 	struct crypto_shash *tfm = desc->tfm;
 	struct shash_alg *shash = crypto_shash_alg(tfm);
 	unsigned long alignmask = crypto_shash_alignmask(tfm);
+	int ret;
 
 	if (((unsigned long)data | (unsigned long)out) & alignmask)
-		return shash_finup_unaligned(desc, data, len, out);
+		ret = shash_finup_unaligned(desc, data, len, out);
+	else
+		ret = shash->finup(desc, data, len, out);
 
-	return shash->finup(desc, data, len, out);
+	crypto_yield(crypto_shash_get_flags(tfm));
+	return ret;
 }
 EXPORT_SYMBOL_GPL(crypto_shash_finup);
 
@@ -197,14 +209,18 @@ int crypto_shash_digest(struct shash_desc *desc, const u8 *data,
 	struct crypto_shash *tfm = desc->tfm;
 	struct shash_alg *shash = crypto_shash_alg(tfm);
 	unsigned long alignmask = crypto_shash_alignmask(tfm);
+	int ret;
 
 	if (crypto_shash_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
 		return -ENOKEY;
 
 	if (((unsigned long)data | (unsigned long)out) & alignmask)
-		return shash_digest_unaligned(desc, data, len, out);
+		ret = shash_digest_unaligned(desc, data, len, out);
+	else
+		ret = shash->digest(desc, data, len, out);
 
-	return shash->digest(desc, data, len, out);
+	crypto_yield(crypto_shash_get_flags(tfm));
+	return ret;
 }
 EXPORT_SYMBOL_GPL(crypto_shash_digest);
 
-- 
2.38.1

