Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6374671F29D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjFATFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjFATFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:05:21 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B070184;
        Thu,  1 Jun 2023 12:05:18 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-97458c97333so47458466b.2;
        Thu, 01 Jun 2023 12:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685646317; x=1688238317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yn6AtAHnk/JRQ6tg3VOO2xTr5zdu98dQLt73x2iUz/8=;
        b=CkNIYWFGXToMiQhfilezgCUI14q4U1K908IlgaVRn/rx+3Ygct3nZUeXPOJXo9v/cY
         bK5gUpgEJPH1jpOgpkX3DqbGcRcCXpTQaTfTmVByIYopKHGqbgRFGqt9V6V/maAjXY87
         vTPT1C1rZ2/yyVk+doBLHfa/EeEHbzu6MgtrpKNFtMabwRqQbKKsemEUU8dnuUbYb73l
         kHyQWdVbUNpOeOgxOJjpYpNC+rU4Gl4/XOUuWFsTh5c5/CxyQ9nPUpbXhIrWqUrTxxhc
         UMGpjRmc3dAHG4ZSaJlt+SOn2YfzhFeiuznIFrGwceiWJ4kG+qsykmTQ2UvpoBP21Nhf
         XlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685646317; x=1688238317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yn6AtAHnk/JRQ6tg3VOO2xTr5zdu98dQLt73x2iUz/8=;
        b=MFhbBDOc7fDe3SyhfceDvrvyDHO4lRjOQgCAocJSP9GwEAoB7KeTfGUmYIaFx3tyZg
         miWgZALAhaXqL4SAQaThU9fzFooMQs9tyF87im3bT0i3YTn64PJODv1gOC3UPsFRLE2u
         pPGe2hVWT04hMBnJ4vVeKzyDn49iFJi5yV+hsL3zAqI7nWcwsRuNHzlL75HjR/ZgZG6r
         0KWL3Q8k/e+hDtOsSkBVlWBFeyXI/xq3XnLnoPMJ5rDbRXWRJVSEE/Clho/GNvVVbaVq
         REg15tRPqj+oAJYctGCnxusCEvRNn+16bZi5JOz5Pp0C89qeuMotICdPeAi3rdMtN+RP
         fqMw==
X-Gm-Message-State: AC+VfDyw63jAP/t/8H1a5hJG5flNxQyy7vOC7yW65So6KDILdYFKp7Bh
        iD5JsQIhyk6PZ8zTxNnMf4aeFl9dWf4DEA==
X-Google-Smtp-Source: ACHHUZ6sPBq1F5986rglI1DSySnxtczgNgLz6KrKanHQAMXYm7dpG2q3r6n3t+iZpQw7PKXLF6ps8A==
X-Received: by 2002:a17:907:9806:b0:96a:9b5b:5d80 with SMTP id ji6-20020a170907980600b0096a9b5b5d80mr8935321ejc.13.1685646316531;
        Thu, 01 Jun 2023 12:05:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:d56e:8fdf:f926:4676])
        by smtp.gmail.com with ESMTPSA id k17-20020a170906681100b0096f7105b3a6sm10827323ejr.189.2023.06.01.12.05.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Jun 2023 12:05:16 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>
Subject: [PATCH] certs/extract-cert: Fix checkpatch issues
Date:   Thu,  1 Jun 2023 21:05:08 +0200
Message-Id: <20230601190508.56610-1-franziska.naepelt@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following issues are fixed:
- WARNING: Missing or malformed SPDX-License-Identifier tag
- WARNING: Prefer __noreturn over __attribute__((noreturn))
- ERROR: trailing statements should be on next line
- WARNING: braces {} are not necessary for single statement blocks
- ERROR: space required before the open parenthesis '('
- ERROR: code indent should use tabs where possible
- WARNING: please, no spaces at the start of a line
- WARNING: Missing a blank line after declarations

Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
---
 certs/extract-cert.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/certs/extract-cert.c b/certs/extract-cert.c
index 70e9ec89d87d..dd76fb0f7f8d 100644
--- a/certs/extract-cert.c
+++ b/certs/extract-cert.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1
 /* Extract X.509 certificate in DER form from PKCS#11 or PEM.
  *
  * Copyright © 2014-2015 Red Hat, Inc. All Rights Reserved.
@@ -32,7 +33,7 @@

 #define PKEY_ID_PKCS7 2

-static __attribute__((noreturn))
+static __noreturn
 void format(void)
 {
 	fprintf(stderr,
@@ -63,7 +64,8 @@ static void drain_openssl_errors(void)

 	if (ERR_peek_error() == 0)
 		return;
-	while (ERR_get_error_line(&file, &line)) {}
+	while (ERR_get_error_line(&file, &line))
+		;
 }

 #define ERR(cond, fmt, ...)				\
@@ -73,7 +75,7 @@ static void drain_openssl_errors(void)
 		if (__cond) {				\
 			err(1, fmt, ## __VA_ARGS__);	\
 		}					\
-	} while(0)
+	} while (0)

 static const char *key_pass;
 static BIO *wb;
@@ -107,7 +109,7 @@ int main(int argc, char **argv)
 	if (verbose_env && strchr(verbose_env, '1'))
 		verbose = true;

-        key_pass = getenv("KBUILD_SIGN_PIN");
+	key_pass = getenv("KBUILD_SIGN_PIN");

 	if (argc != 3)
 		format();
@@ -118,6 +120,7 @@ int main(int argc, char **argv)
 	if (!cert_src[0]) {
 		/* Invoked with no input; create empty file */
 		FILE *f = fopen(cert_dst, "wb");
+
 		ERR(!f, "%s", cert_dst);
 		fclose(f);
 		exit(0);
@@ -155,6 +158,7 @@ int main(int argc, char **argv)
 			x509 = PEM_read_bio_X509(b, NULL, NULL, NULL);
 			if (wb && !x509) {
 				unsigned long err = ERR_peek_last_error();
+
 				if (ERR_GET_LIB(err) == ERR_LIB_PEM &&
 				    ERR_GET_REASON(err) == PEM_R_NO_START_LINE) {
 					ERR_clear_error();

base-commit: 7877cb91f1081754a1487c144d85dc0d2e2e7fc4
--
2.39.2 (Apple Git-143)

