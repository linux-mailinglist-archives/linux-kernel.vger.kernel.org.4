Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3256682757
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjAaItA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjAaIsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:48:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E004E534
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:44:14 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1pMmEm-0002o0-1B; Tue, 31 Jan 2023 09:43:32 +0100
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <jlu@pengutronix.de>)
        id 1pMmEl-001eKt-Iq; Tue, 31 Jan 2023 09:43:30 +0100
Received: from jlu by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <jlu@pengutronix.de>)
        id 1pMmEj-005vrY-VE; Tue, 31 Jan 2023 09:43:29 +0100
From:   Jan Luebbe <jlu@pengutronix.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Jan Luebbe <jlu@pengutronix.de>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 1/2] certs: Fix build error when PKCS#11 URI contains semicolon
Date:   Tue, 31 Jan 2023 09:43:22 +0100
Message-Id: <20230131084323.1414010-2-jlu@pengutronix.de>
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

When CONFIG_MODULE_SIG_KEY is PKCS#11 URI (pkcs11:*) and contains a
semicolon, signing_key.x509 fails to build:

  certs/extract-cert pkcs11:token=foo;object=bar;pin-value=1111 certs/signing_key.x509
  Usage: extract-cert <source> <dest>

Add quotes to the extract-cert argument to avoid splitting by the shell.

This approach was suggested by Masahiro Yamada <masahiroy@kernel.org>.

Fixes: 129ab0d2d9f3 ("kbuild: do not quote string values in include/config/auto.conf")
Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
 certs/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/certs/Makefile b/certs/Makefile
index 9486ed924731..799ad7b9e68a 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -23,8 +23,8 @@ $(obj)/blacklist_hash_list: $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) FORCE
 targets += blacklist_hash_list
 
 quiet_cmd_extract_certs  = CERT    $@
-      cmd_extract_certs  = $(obj)/extract-cert $(extract-cert-in) $@
-extract-cert-in = $(or $(filter-out $(obj)/extract-cert, $(real-prereqs)),"")
+      cmd_extract_certs  = $(obj)/extract-cert "$(extract-cert-in)" $@
+extract-cert-in = $(filter-out $(obj)/extract-cert, $(real-prereqs))
 
 $(obj)/system_certificates.o: $(obj)/x509_certificate_list
 
-- 
2.30.2

