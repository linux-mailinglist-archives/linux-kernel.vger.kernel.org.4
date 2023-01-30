Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BA76811CE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbjA3OQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbjA3OQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:16:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0842A3C2A7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:16:34 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1pMUxI-0004FU-3D; Mon, 30 Jan 2023 15:16:20 +0100
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <jlu@pengutronix.de>)
        id 1pMUxI-001UGx-DS; Mon, 30 Jan 2023 15:16:19 +0100
Received: from jlu by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <jlu@pengutronix.de>)
        id 1pMUxG-00GG5L-TK; Mon, 30 Jan 2023 15:16:18 +0100
From:   Jan Luebbe <jlu@pengutronix.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Jan Luebbe <jlu@pengutronix.de>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/2] certs: Fix build error when PKCS#11 URI contains semicolon
Date:   Mon, 30 Jan 2023 15:15:52 +0100
Message-Id: <20230130141553.3825449-2-jlu@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230130141553.3825449-1-jlu@pengutronix.de>
References: <20230130141553.3825449-1-jlu@pengutronix.de>
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

Add quotes to the PKCS11_URI variable to avoid splitting by the shell.

Fixes: 129ab0d2d9f3 ("kbuild: do not quote string values in include/config/auto.conf")
Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
 certs/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/Makefile b/certs/Makefile
index 9486ed924731..cda21811ed88 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -67,7 +67,7 @@ $(obj)/system_certificates.o: $(obj)/signing_key.x509
 
 PKCS11_URI := $(filter pkcs11:%, $(CONFIG_MODULE_SIG_KEY))
 ifdef PKCS11_URI
-$(obj)/signing_key.x509: extract-cert-in := $(PKCS11_URI)
+$(obj)/signing_key.x509: extract-cert-in := "$(PKCS11_URI)"
 endif
 
 $(obj)/signing_key.x509: $(filter-out $(PKCS11_URI),$(CONFIG_MODULE_SIG_KEY)) $(obj)/extract-cert FORCE
-- 
2.30.2

