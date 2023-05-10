Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EE66FD8BA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbjEJH4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbjEJH4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:56:35 -0400
X-Greylist: delayed 330 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 May 2023 00:56:18 PDT
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08BB9468B;
        Wed, 10 May 2023 00:56:17 -0700 (PDT)
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
        by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBnGkysTVtkk5qWBg--.45302S2;
        Wed, 10 May 2023 15:54:20 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
        by mail (Coremail) with SMTP id AQAAfwBH0_HPTFtkk1oAAA--.470S3;
        Wed, 10 May 2023 15:50:39 +0800 (CST)
From:   yangmengfei1394@phytium.com.cn
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        ymf <yangmengfei1394@phytium.com.cn>
Subject: [PATCH] Crypto: Fix one bug when use kernel ecdsa algorithm
Date:   Wed, 10 May 2023 15:51:42 +0800
Message-Id: <20230510075142.1638-1-yangmengfei1394@phytium.com.cn>
X-Mailer: git-send-email 2.35.1.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBH0_HPTFtkk1oAAA--.470S3
X-CM-SenderInfo: 51dqwzxhqjwvjlrtmko6sk53xlxphulrpou0/1tbiAQAPBmRao6UFggABs2
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=yangmengfe
        i1394@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrZF47ZFyrZF48uFWrXF4xZwb_yoWkCrc_Ca
        s7WwsrCr15Zrn7tr47Aa18Wry2gFyIkF9xGFW0yayxt3Z8Wrs5WF93Grn7Zr4Uua1DXrZ3
        KrnYyr95Jw1I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
        Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
        UUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ymf <yangmengfei1394@phytium.com.cn>

We are trying to use kernel ecdsa algorithm to sign something.
When we call the crypto_akcipher_set_priv_key function, the
system collapses because it comes to NULL pointer.We find out
kerenl ecdsa algorithm has not offered the set_priv_key function.
So we think it might be necessary to check whether set_priv_key is
available when crypto_akcipher_set_priv_key is called.

Signed-off-by: ymf <yangmengfei1394@phytium.com.cn>
---
 include/crypto/akcipher.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/crypto/akcipher.h b/include/crypto/akcipher.h
index f35fd653e4e5..a68f0e23bf89 100644
--- a/include/crypto/akcipher.h
+++ b/include/crypto/akcipher.h
@@ -459,7 +459,9 @@ static inline int crypto_akcipher_set_priv_key(struct crypto_akcipher *tfm,
 					       unsigned int keylen)
 {
 	struct akcipher_alg *alg = crypto_akcipher_alg(tfm);
-
-	return alg->set_priv_key(tfm, key, keylen);
+	if (likely(alg->set_priv_key != NULL))
+		return alg->set_priv_key(tfm, key, keylen);
+	else
+		return -EPERM;
 }
 #endif
-- 
2.34.1

