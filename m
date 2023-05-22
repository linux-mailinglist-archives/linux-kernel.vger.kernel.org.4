Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03C270B3CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 05:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjEVDaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 23:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjEVDaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 23:30:00 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 820C4C6;
        Sun, 21 May 2023 20:29:57 -0700 (PDT)
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
        by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwB389ib4mpk8QZSAA--.8581S2;
        Mon, 22 May 2023 11:33:47 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
        by mail (Coremail) with SMTP id AQAAfwA34VGu4Wpk4UwAAA--.2436S3;
        Mon, 22 May 2023 11:29:50 +0800 (CST)
From:   yangmengfei1394 <yangmengfei1394@phytium.com.cn>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        yangmengfei1394 <yangmengfei1394@phytium.com.cn>
Subject: [PATCH] Crypto module : rearrange the default functions of akcipher
Date:   Mon, 22 May 2023 11:30:27 +0800
Message-Id: <20230522033027.989-1-yangmengfei1394@phytium.com.cn>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20230510075142.1638-1-yangmengfei1394@phytium.com.cn>
References: <20230510075142.1638-1-yangmengfei1394@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwA34VGu4Wpk4UwAAA--.2436S3
X-CM-SenderInfo: 51dqwzxhqjwvjlrtmko6sk53xlxphulrpou0/1tbiAQAEBmRmgN8EeAACsg
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=yangmengfe
        i1394@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7uF4UAFWfuF15Gw4kurWDtwb_yoW8Kr4rpF
        1fK397Jr4UXF1293y8JFs5Jry5XrWxA3Wayr48Cw1fKFs2gryFgr47t348CFy5JF98Ary8
        Cw4v9w1UWw4DCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
        UUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to your last email, we rearrange the default functions,
move the code that sets the default functions from
crypto_register_akcipher into akcipher_prepare_alg,
add the set_pub_key function check at the same time.

Signed-off-by: yangmengfei1394 <yangmengfei1394@phytium.com.cn>
---
 crypto/akcipher.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/crypto/akcipher.c b/crypto/akcipher.c
index 7960ceb528c3..45502446b231 100644
--- a/crypto/akcipher.c
+++ b/crypto/akcipher.c
@@ -126,19 +126,6 @@ struct crypto_akcipher *crypto_alloc_akcipher(const char *alg_name, u32 type,
 }
 EXPORT_SYMBOL_GPL(crypto_alloc_akcipher);
 
-static void akcipher_prepare_alg(struct akcipher_alg *alg)
-{
-	struct crypto_istat_akcipher *istat = akcipher_get_stat(alg);
-	struct crypto_alg *base = &alg->base;
-
-	base->cra_type = &crypto_akcipher_type;
-	base->cra_flags &= ~CRYPTO_ALG_TYPE_MASK;
-	base->cra_flags |= CRYPTO_ALG_TYPE_AKCIPHER;
-
-	if (IS_ENABLED(CONFIG_CRYPTO_STATS))
-		memset(istat, 0, sizeof(*istat));
-}
-
 static int akcipher_default_op(struct akcipher_request *req)
 {
 	return -ENOSYS;
@@ -150,8 +137,9 @@ static int akcipher_default_set_key(struct crypto_akcipher *tfm,
 	return -ENOSYS;
 }
 
-int crypto_register_akcipher(struct akcipher_alg *alg)
+static void akcipher_prepare_alg(struct akcipher_alg *alg)
 {
+	struct crypto_istat_akcipher *istat = akcipher_get_stat(alg);
 	struct crypto_alg *base = &alg->base;
 
 	if (!alg->sign)
@@ -164,6 +152,20 @@ int crypto_register_akcipher(struct akcipher_alg *alg)
 		alg->decrypt = akcipher_default_op;
 	if (!alg->set_priv_key)
 		alg->set_priv_key = akcipher_default_set_key;
+	if (!alg->set_pub_key)
+		alg->set_pub_key = akcipher_default_set_key;
+
+	base->cra_type = &crypto_akcipher_type;
+	base->cra_flags &= ~CRYPTO_ALG_TYPE_MASK;
+	base->cra_flags |= CRYPTO_ALG_TYPE_AKCIPHER;
+
+	if (IS_ENABLED(CONFIG_CRYPTO_STATS))
+		memset(istat, 0, sizeof(*istat));
+}
+
+int crypto_register_akcipher(struct akcipher_alg *alg)
+{
+	struct crypto_alg *base = &alg->base;
 
 	akcipher_prepare_alg(alg);
 	return crypto_register_alg(base);
-- 
2.35.1.windows.2

