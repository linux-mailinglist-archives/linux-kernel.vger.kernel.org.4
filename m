Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EC2682755
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjAaIsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjAaIsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:48:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920BA4DCF1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:44:14 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1pMmEm-0002nr-1H; Tue, 31 Jan 2023 09:43:32 +0100
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <jlu@pengutronix.de>)
        id 1pMmEl-001eKp-HY; Tue, 31 Jan 2023 09:43:30 +0100
Received: from jlu by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <jlu@pengutronix.de>)
        id 1pMmEj-005vrb-WB; Tue, 31 Jan 2023 09:43:30 +0100
From:   Jan Luebbe <jlu@pengutronix.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Jan Luebbe <jlu@pengutronix.de>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 2/2] kbuild: modinst: Fix build error when CONFIG_MODULE_SIG_KEY is a PKCS#11 URI
Date:   Tue, 31 Jan 2023 09:43:23 +0100
Message-Id: <20230131084323.1414010-3-jlu@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230131084323.1414010-1-jlu@pengutronix.de>
References: <20230131084323.1414010-1-jlu@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_MODULE_SIG_KEY is PKCS#11 URI (pkcs11:*), signing of modules
fails:

  scripts/sign-file sha256 /.../linux/pkcs11:token=foo;object=bar;pin-value=1111 certs/signing_key.x509 /.../kernel/crypto/tcrypt.ko
  Usage: scripts/sign-file [-dp] <hash algo> <key> <x509> <module> [<dest>]
         scripts/sign-file -s <raw sig> <hash algo> <x509> <module> [<dest>]

First, we need to avoid adding the $(srctree)/ prefix to the URL.

Second, since the kconfig string values no longer include quotes, we need to add
them again when passing a PKCS#11 URI to sign-file. This avoids
splitting by the shell if the URI contains semicolons.

Fixes: 4db9c2e3d055 ("kbuild: stop using config_filename in scripts/Makefile.modsign")
Fixes: 129ab0d2d9f3 ("kbuild: do not quote string values in include/config/auto.conf")
Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
 scripts/Makefile.modinst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index 836391e5d209..4815a8e32227 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -66,9 +66,13 @@ endif
 # Don't stop modules_install even if we can't sign external modules.
 #
 ifeq ($(CONFIG_MODULE_SIG_ALL),y)
+ifeq ($(filter pkcs11:%, $(CONFIG_MODULE_SIG_KEY)),)
 sig-key := $(if $(wildcard $(CONFIG_MODULE_SIG_KEY)),,$(srctree)/)$(CONFIG_MODULE_SIG_KEY)
+else
+sig-key := $(CONFIG_MODULE_SIG_KEY)
+endif
 quiet_cmd_sign = SIGN    $@
-      cmd_sign = scripts/sign-file $(CONFIG_MODULE_SIG_HASH) $(sig-key) certs/signing_key.x509 $@ \
+      cmd_sign = scripts/sign-file $(CONFIG_MODULE_SIG_HASH) "$(sig-key)" certs/signing_key.x509 $@ \
                  $(if $(KBUILD_EXTMOD),|| true)
 else
 quiet_cmd_sign :=
-- 
2.30.2

