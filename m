Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CE169E838
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBUT0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjBUT0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:26:23 -0500
X-Greylist: delayed 1800 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Feb 2023 11:26:21 PST
Received: from tartarus.angband.pl (tartarus.angband.pl [51.83.246.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E63F30299;
        Tue, 21 Feb 2023 11:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=angband.pl;
        s=tartarus; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=i9+A1nQzdmuXy3hp3w92VyMJn5gV+HrIvYVOE27Ezgk=; b=v9OvMN6EYOa84tupTkGKC8LNTb
        O8cZA9v/aEP93UpM2cWoSAA0oX8pLL7SVJPPEydvivoImtvY1ht5xDHZCSeIMOGJeXvKA8AXpiTEu
        8vqp+xGMu/nT/RipU/HLa8FZwk/UB7Mhv51wQB76DCj/7SByWuUOUz1Rp2zW7f2UyC3g=;
Received: from localhost ([127.0.0.1] helo=valinor.angband.pl)
        by tartarus.angband.pl with smtp (Exim 4.96)
        (envelope-from <kilobyte@valinor.angband.pl>)
        id 1pUWIa-001Rcn-2z;
        Tue, 21 Feb 2023 18:19:28 +0100
Received: (nullmailer pid 55815 invoked by uid 1000);
        Tue, 21 Feb 2023 17:19:28 -0000
From:   Adam Borowski <kilobyte@angband.pl>
To:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Subject: [PATCH v2] certs: fips test: fix build failure with PKCS7_MESSAGE_PARSER=m
Date:   Tue, 21 Feb 2023 18:19:19 +0100
Message-Id: <20230221171919.55714-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: kilobyte@valinor.angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ld: crypto/asymmetric_keys/selftest.o: in function `fips_signature_selftest':
selftest.c:(.init.text+0xcd): undefined reference to `pkcs7_parse_message'
ld: selftest.c:(.init.text+0x103): undefined reference to `pkcs7_supply_detached_data'
ld: selftest.c:(.init.text+0x10d): undefined reference to `pkcs7_verify'
ld: selftest.c:(.init.text+0x135): undefined reference to `pkcs7_validate_trust'
ld: selftest.c:(.init.text+0x157): undefined reference to `pkcs7_free_message'

Fixes: 3cde3174eb91 ("certs: Add FIPS selftests")
Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
This fail still happens on randconfig runs.

v2: expanded the Fixes tag to include that commit's subject

 crypto/asymmetric_keys/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 3df3fe4ed95f..fe007db96c69 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -83,6 +83,6 @@ config FIPS_SIGNATURE_SELFTEST
 	  for FIPS.
 	depends on KEYS
 	depends on ASYMMETRIC_KEY_TYPE
-	depends on PKCS7_MESSAGE_PARSER
+	depends on PKCS7_MESSAGE_PARSER=y
 
 endif # ASYMMETRIC_KEY_TYPE
-- 
2.39.2

