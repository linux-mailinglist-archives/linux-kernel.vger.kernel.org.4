Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA187107D0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240361AbjEYInx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240330AbjEYInt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:43:49 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEE4195;
        Thu, 25 May 2023 01:43:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VjRaM-i_1685004224;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VjRaM-i_1685004224)
          by smtp.aliyun-inc.com;
          Thu, 25 May 2023 16:43:44 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH] sign-file: simplify main function implementation
Date:   Thu, 25 May 2023 16:43:43 +0800
Message-Id: <20230525084343.56824-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use_signed_attrs is an unnecessary variable, deleting this variable
can simplify the code.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 scripts/sign-file.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 94267cf72197..377d586762f9 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -224,7 +224,6 @@ int main(int argc, char **argv)
 	bool raw_sig = false;
 	unsigned char buf[4096];
 	unsigned long module_size, sig_size;
-	unsigned int use_signed_attrs;
 	const EVP_MD *digest_algo;
 	EVP_PKEY *private_key;
 #ifndef USE_PKCS7
@@ -242,12 +241,6 @@ int main(int argc, char **argv)
 
 	key_pass = getenv("KBUILD_SIGN_PIN");
 
-#ifndef USE_PKCS7
-	use_signed_attrs = CMS_NOATTR;
-#else
-	use_signed_attrs = PKCS7_NOATTR;
-#endif
-
 	do {
 		opt = getopt(argc, argv, "sdpk");
 		switch (opt) {
@@ -340,8 +333,7 @@ int main(int argc, char **argv)
 
 		ERR(!CMS_add1_signer(cms, x509, private_key, digest_algo,
 				     CMS_NOCERTS | CMS_BINARY |
-				     CMS_NOSMIMECAP | use_keyid |
-				     use_signed_attrs),
+				     CMS_NOSMIMECAP | CMS_NOATTR | use_keyid),
 		    "CMS_add1_signer");
 		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) < 0,
 		    "CMS_final");
@@ -349,7 +341,7 @@ int main(int argc, char **argv)
 #else
 		pkcs7 = PKCS7_sign(x509, private_key, NULL, bm,
 				   PKCS7_NOCERTS | PKCS7_BINARY |
-				   PKCS7_DETACHED | use_signed_attrs);
+				   PKCS7_DETACHED | PKCS7_NOATTR);
 		ERR(!pkcs7, "PKCS7_sign");
 #endif
 
-- 
2.24.3 (Apple Git-128)

