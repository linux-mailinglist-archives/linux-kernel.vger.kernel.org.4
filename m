Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACCE5B54E7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiILG6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiILG63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:58:29 -0400
X-Greylist: delayed 187 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 11 Sep 2022 23:58:26 PDT
Received: from condef-09.nifty.com (condef-09.nifty.com [202.248.20.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1D418E25;
        Sun, 11 Sep 2022 23:58:26 -0700 (PDT)
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-09.nifty.com with ESMTP id 28C6s6lr029577;
        Mon, 12 Sep 2022 15:54:07 +0900
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 28C6qKb0002757;
        Mon, 12 Sep 2022 15:52:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 28C6qKb0002757
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662965541;
        bh=K8lS0G39upk9M7Zr/tS02duG7tDM8J18wNby8hcDebA=;
        h=From:To:Cc:Subject:Date:From;
        b=qLh8/t/pLV4otPJynnlFtK9MO30eONulvw2fQLCjQDHJ3C2su/WNDz+5DwkPVqd28
         OBtkk1ZrbxIdIDDgfmVLlqto5lwOIQDOe3q4CDaXOHMbXeNSUrIu8YW/FCJZbT+DJO
         +rs/kgCWlXmxazZm+awrI9LP04aa5nNXMvvx5fr6gIGBPkDi/L+ZPFjRhvPmUOtESL
         hUJ3a1kCTjx5+asDbvZ8B76m9UVLm2MWTaHLaT5dNoHEyJISfXkqkvYPd7Ifs6CIck
         SoX+9pZbmJ6cNbUWFtP7/QfOc1Y++WAgTaSW34zjZN3L50Yid+q5GcKzsL5KhdC1oj
         uXBRAalFavv+w==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Adam Borowski <kilobyte@angband.pl>,
        linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] certs: make system keyring depend on built-in x509 parser
Date:   Mon, 12 Sep 2022 15:52:10 +0900
Message-Id: <20220912065210.7932-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e90886291c7c ("certs: make system keyring depend on x509 parser")
is not the right fix because x509_load_certificate_list() can be modular.

The combination of CONFIG_SYSTEM_TRUSTED_KEYRING=y and
CONFIG_X509_CERTIFICATE_PARSER=m still results in the following error:

    LD      .tmp_vmlinux.kallsyms1
  ld: certs/system_keyring.o: in function `load_system_certificate_list':
  system_keyring.c:(.init.text+0x8c): undefined reference to `x509_load_certificate_list'
  make: *** [Makefile:1169: vmlinux] Error 1

Fixes: e90886291c7c ("certs: make system keyring depend on x509 parser")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 certs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/Kconfig b/certs/Kconfig
index bf9b511573d7..1f109b070877 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -43,7 +43,7 @@ config SYSTEM_TRUSTED_KEYRING
 	bool "Provide system-wide ring of trusted keys"
 	depends on KEYS
 	depends on ASYMMETRIC_KEY_TYPE
-	depends on X509_CERTIFICATE_PARSER
+	depends on X509_CERTIFICATE_PARSER = y
 	help
 	  Provide a system keyring to which trusted keys can be added.  Keys in
 	  the keyring are considered to be trusted.  Keys may be added at will
-- 
2.34.1

