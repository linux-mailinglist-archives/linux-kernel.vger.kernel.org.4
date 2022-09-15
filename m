Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36B75B935B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiIODky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiIODk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:40:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9719630D;
        Wed, 14 Sep 2022 20:39:50 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MSjWg58ntzNmGp;
        Thu, 15 Sep 2022 11:35:11 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 11:39:48 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <dan.j.williams@intel.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <trix@redhat.com>, <jarkko@kernel.org>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: add __init/__exit annotations to init/exit funcs
Date:   Thu, 15 Sep 2022 11:36:15 +0800
Message-ID: <20220915033615.12478-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing __init/__exit annotations to init/exit funcs.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 crypto/async_tx/raid6test.c | 4 ++--
 crypto/curve25519-generic.c | 4 ++--
 crypto/dh.c                 | 4 ++--
 crypto/ecdh.c               | 4 ++--
 crypto/ecdsa.c              | 4 ++--
 crypto/rsa.c                | 4 ++--
 crypto/sm2.c                | 4 ++--
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/crypto/async_tx/raid6test.c b/crypto/async_tx/raid6test.c
index c9d218e53bcb..9719c7520661 100644
--- a/crypto/async_tx/raid6test.c
+++ b/crypto/async_tx/raid6test.c
@@ -189,7 +189,7 @@ static int test(int disks, int *tests)
 }
 
 
-static int raid6_test(void)
+static int __init raid6_test(void)
 {
 	int err = 0;
 	int tests = 0;
@@ -236,7 +236,7 @@ static int raid6_test(void)
 	return 0;
 }
 
-static void raid6_test_exit(void)
+static void __exit raid6_test_exit(void)
 {
 }
 
diff --git a/crypto/curve25519-generic.c b/crypto/curve25519-generic.c
index bd88fd571393..d055b0784c77 100644
--- a/crypto/curve25519-generic.c
+++ b/crypto/curve25519-generic.c
@@ -72,12 +72,12 @@ static struct kpp_alg curve25519_alg = {
 	.max_size		= curve25519_max_size,
 };
 
-static int curve25519_init(void)
+static int __init curve25519_init(void)
 {
 	return crypto_register_kpp(&curve25519_alg);
 }
 
-static void curve25519_exit(void)
+static void __exit curve25519_exit(void)
 {
 	crypto_unregister_kpp(&curve25519_alg);
 }
diff --git a/crypto/dh.c b/crypto/dh.c
index 4406aeb1ff61..99c3b2ef7adc 100644
--- a/crypto/dh.c
+++ b/crypto/dh.c
@@ -893,7 +893,7 @@ static struct crypto_template crypto_ffdhe_templates[] = {};
 #endif /* CONFIG_CRYPTO_DH_RFC7919_GROUPS */
 
 
-static int dh_init(void)
+static int __init dh_init(void)
 {
 	int err;
 
@@ -911,7 +911,7 @@ static int dh_init(void)
 	return 0;
 }
 
-static void dh_exit(void)
+static void __exit dh_exit(void)
 {
 	crypto_unregister_templates(crypto_ffdhe_templates,
 				    ARRAY_SIZE(crypto_ffdhe_templates));
diff --git a/crypto/ecdh.c b/crypto/ecdh.c
index e4857d534344..80afee3234fb 100644
--- a/crypto/ecdh.c
+++ b/crypto/ecdh.c
@@ -200,7 +200,7 @@ static struct kpp_alg ecdh_nist_p384 = {
 
 static bool ecdh_nist_p192_registered;
 
-static int ecdh_init(void)
+static int __init ecdh_init(void)
 {
 	int ret;
 
@@ -227,7 +227,7 @@ static int ecdh_init(void)
 	return ret;
 }
 
-static void ecdh_exit(void)
+static void __exit ecdh_exit(void)
 {
 	if (ecdh_nist_p192_registered)
 		crypto_unregister_kpp(&ecdh_nist_p192);
diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index b3a8a6b572ba..fbd76498aba8 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -332,7 +332,7 @@ static struct akcipher_alg ecdsa_nist_p192 = {
 };
 static bool ecdsa_nist_p192_registered;
 
-static int ecdsa_init(void)
+static int __init ecdsa_init(void)
 {
 	int ret;
 
@@ -359,7 +359,7 @@ static int ecdsa_init(void)
 	return ret;
 }
 
-static void ecdsa_exit(void)
+static void __exit ecdsa_exit(void)
 {
 	if (ecdsa_nist_p192_registered)
 		crypto_unregister_akcipher(&ecdsa_nist_p192);
diff --git a/crypto/rsa.c b/crypto/rsa.c
index 0e555ee4addb..c50f2d2a4d06 100644
--- a/crypto/rsa.c
+++ b/crypto/rsa.c
@@ -327,7 +327,7 @@ static struct akcipher_alg rsa = {
 	},
 };
 
-static int rsa_init(void)
+static int __init rsa_init(void)
 {
 	int err;
 
@@ -344,7 +344,7 @@ static int rsa_init(void)
 	return 0;
 }
 
-static void rsa_exit(void)
+static void __exit rsa_exit(void)
 {
 	crypto_unregister_template(&rsa_pkcs1pad_tmpl);
 	crypto_unregister_akcipher(&rsa);
diff --git a/crypto/sm2.c b/crypto/sm2.c
index f3e1592965c0..ed9307dac3d1 100644
--- a/crypto/sm2.c
+++ b/crypto/sm2.c
@@ -441,12 +441,12 @@ static struct akcipher_alg sm2 = {
 	},
 };
 
-static int sm2_init(void)
+static int __init sm2_init(void)
 {
 	return crypto_register_akcipher(&sm2);
 }
 
-static void sm2_exit(void)
+static void __exit sm2_exit(void)
 {
 	crypto_unregister_akcipher(&sm2);
 }
-- 
2.17.1

