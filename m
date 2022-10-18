Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859E1602535
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiJRHLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJRHKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:10:53 -0400
Received: from out199-1.us.a.mail.aliyun.com (out199-1.us.a.mail.aliyun.com [47.90.199.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AC47E01C;
        Tue, 18 Oct 2022 00:10:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VSTWsim_1666077020;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VSTWsim_1666077020)
          by smtp.aliyun-inc.com;
          Tue, 18 Oct 2022 15:10:21 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v2 05/15] crypto: tcrypt - add SM4 cts-cbc/essiv/xts/xcbc test
Date:   Tue, 18 Oct 2022 15:09:56 +0800
Message-Id: <20221018071006.5717-6-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20221018071006.5717-1-tianjia.zhang@linux.alibaba.com>
References: <20221018071006.5717-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added CTS-CBC/ESSIV/XTS/XCBC tests for SM4 algorithms, as well as
corresponding speed tests, this is to test performance-optimized
implementations of these modes.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/tcrypt.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index a82679b576bb..b870b2fe716d 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -1711,6 +1711,10 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 		ret += tcrypt_test("gcm(aria)");
 		break;
 
+	case 59:
+		ret += tcrypt_test("cts(cbc(sm4))");
+		break;
+
 	case 100:
 		ret += tcrypt_test("hmac(md5)");
 		break;
@@ -1811,6 +1815,10 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 		ret += tcrypt_test("cmac(sm4)");
 		break;
 
+	case 160:
+		ret += tcrypt_test("xcbc(sm4)");
+		break;
+
 	case 181:
 		ret += tcrypt_test("authenc(hmac(sha1),cbc(des))");
 		break;
@@ -1846,6 +1854,7 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 		ret += tcrypt_test("cbc(sm4)");
 		ret += tcrypt_test("cfb(sm4)");
 		ret += tcrypt_test("ctr(sm4)");
+		ret += tcrypt_test("xts(sm4)");
 		break;
 	case 192:
 		ret += tcrypt_test("ecb(aria)");
@@ -2109,6 +2118,10 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 				speed_template_16);
 		test_cipher_speed("cbc(sm4)", DECRYPT, sec, NULL, 0,
 				speed_template_16);
+		test_cipher_speed("cts(cbc(sm4))", ENCRYPT, sec, NULL, 0,
+				speed_template_16);
+		test_cipher_speed("cts(cbc(sm4))", DECRYPT, sec, NULL, 0,
+				speed_template_16);
 		test_cipher_speed("cfb(sm4)", ENCRYPT, sec, NULL, 0,
 				speed_template_16);
 		test_cipher_speed("cfb(sm4)", DECRYPT, sec, NULL, 0,
@@ -2117,6 +2130,10 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 				speed_template_16);
 		test_cipher_speed("ctr(sm4)", DECRYPT, sec, NULL, 0,
 				speed_template_16);
+		test_cipher_speed("xts(sm4)", ENCRYPT, sec, NULL, 0,
+				speed_template_32);
+		test_cipher_speed("xts(sm4)", DECRYPT, sec, NULL, 0,
+				speed_template_32);
 		break;
 
 	case 219:
@@ -2212,6 +2229,13 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 				   speed_template_16, num_mb);
 		break;
 
+	case 230:
+		test_acipher_speed("essiv(cbc(sm4),sm3)", ENCRYPT, sec,
+				   NULL, 0, speed_template_16);
+		test_acipher_speed("essiv(cbc(sm4),sm3)", DECRYPT, sec,
+				   NULL, 0, speed_template_16);
+		break;
+
 	case 300:
 		if (alg) {
 			test_hash_speed(alg, sec, generic_hash_speed_template);
@@ -2630,6 +2654,10 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 				speed_template_16);
 		test_acipher_speed("ctr(sm4)", DECRYPT, sec, NULL, 0,
 				speed_template_16);
+		test_acipher_speed("xts(sm4)", ENCRYPT, sec, NULL, 0,
+				speed_template_32);
+		test_acipher_speed("xts(sm4)", DECRYPT, sec, NULL, 0,
+				speed_template_32);
 		break;
 
 	case 519:
-- 
2.24.3 (Apple Git-128)

