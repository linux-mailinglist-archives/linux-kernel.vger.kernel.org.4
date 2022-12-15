Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBD664DF4A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiLORFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiLOREj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:04:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD73947318;
        Thu, 15 Dec 2022 09:03:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDF6061E60;
        Thu, 15 Dec 2022 17:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2ED6C433F0;
        Thu, 15 Dec 2022 17:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671123784;
        bh=+j5/PKCDX4da27Gaivbi0EyxiiyB/ME/Rriq9u2O0TY=;
        h=From:To:Cc:Subject:Date:From;
        b=Rdhphr6zRApiRnlYm2ku5gSx7V/yGOq92PaGnKYjhZPPUVQdH59PWSgjC0XCU6Q5N
         YeHalqiRnE/nHreZTmbvVyhEnNzkyRuhPFhGuH3ZkzOGUHsfwRHyXoek+iMr070KGh
         Ym9FLBs2zeY7chwGn6vkid5iuAu6MMiL7AfWiQKM1l/8Y0IWV+eYSkVVZz+2XIMPqN
         pJj2gYM/PKhx8cYvWI1L7IxAo6Vr3itYmj9SGLgm8CUX9z59X2Ys3jRsDa6kcXw3xC
         RILQmpNwwPj0FPZanru6qWAOG4BNYGLu3xUBOUEWVJ0Be1aT6nban6HUVz3GLK/WbJ
         bIuoYHVAcItWg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Vitaly Chikunov <vt@altlinux.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: certs: fix FIPS selftest depenency
Date:   Thu, 15 Dec 2022 18:02:52 +0100
Message-Id: <20221215170259.2553400-1-arnd@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The selftest code is built into the x509_key_parser module, and depends
on the pkcs7_message_parser module, which in turn has a dependency on
the key parser, creating a dependency loop and a resulting link
failure when the pkcs7 code is a loadable module:

ld: crypto/asymmetric_keys/selftest.o: in function `fips_signature_selftest':
crypto/asymmetric_keys/selftest.c:205: undefined reference to `pkcs7_parse_message'
ld: crypto/asymmetric_keys/selftest.c:209: undefined reference to `pkcs7_supply_detached_data'
ld: crypto/asymmetric_keys/selftest.c:211: undefined reference to `pkcs7_verify'
ld: crypto/asymmetric_keys/selftest.c:215: undefined reference to `pkcs7_validate_trust'
ld: crypto/asymmetric_keys/selftest.c:219: undefined reference to `pkcs7_free_message'

Avoid this by only allowing the selftest to be enabled when either
both parts are loadable modules, or both are built-in.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 crypto/asymmetric_keys/Kconfig        | 2 +-
 crypto/asymmetric_keys/pkcs7_verify.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 3df3fe4ed95f..1ef3b46d6f6e 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -83,6 +83,6 @@ config FIPS_SIGNATURE_SELFTEST
 	  for FIPS.
 	depends on KEYS
 	depends on ASYMMETRIC_KEY_TYPE
-	depends on PKCS7_MESSAGE_PARSER
+	depends on PKCS7_MESSAGE_PARSER=X509_CERTIFICATE_PARSER
 
 endif # ASYMMETRIC_KEY_TYPE
diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index f6321c785714..4fa769c4bcdb 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -485,3 +485,4 @@ int pkcs7_supply_detached_data(struct pkcs7_message *pkcs7,
 	pkcs7->data_len = datalen;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pkcs7_supply_detached_data);
-- 
2.35.1

