Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352E571FCE2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjFBJAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjFBI71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:59:27 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B979D;
        Fri,  2 Jun 2023 01:59:26 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96f7bf29550so259022866b.3;
        Fri, 02 Jun 2023 01:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685696365; x=1688288365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zc7ZoC9ufmLZ0HTptACDG80Bv4ZTW0gU28aBqMAQ28=;
        b=noQ6iT+Zr7wBbvSQToDpSqgpxhB3F8DQ7YA2XsULplVfVp5R5YqmY3FHk8ovcsM6kn
         8lcvp9nUS4S2lAtbpJl+W3yn94WW7lSoeA4WLurw2tQWOaVSUw5Tu3FuinKhnn3ms0nf
         Abpz0OrT8dsy3dQ2kbcSlDoTJHo0wsJ4GuP3onbVggM6cbG7AAYa+YN3knINEHsQvjwi
         JLrSwmwT8Ze+iRo4PPzEkEdxzDcA1lK2QuRbWRDmaUBtA7vlIm6UPIzfWX3/IzG/qvIZ
         zERj6Bksr/WSc1QqwTTebH3AOjgskL/eaw6xW/K1T7G4BxRK/fekA7CD53kV4xW3YfUd
         5clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685696365; x=1688288365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zc7ZoC9ufmLZ0HTptACDG80Bv4ZTW0gU28aBqMAQ28=;
        b=TUnddiv8NmRlpx+jxZLADNmYb/2ScGcfG31i7mMnsPXezZuHLGgT5WmWg3AguX35ie
         Zizhc1QVI1ALThtptNw6knvmnkzwCU6GKs/S5apHuHuCIbGgMRuGSKirMySraM6WVR+a
         2Kj27ppkUhnVY5Ftt+Rk6ujm1hehiGaYeYskOj7UGLPvw+PAGb6Me1s6AyU+y8BtgPq+
         FseonMfTeNBo+u/9zIRkgNI9Dl6bMaafucjpbjKd3lWtpe/ew5JuhZuMDp/m/JYzkL8k
         WVLIYluXjtUJPgOAyMlauI2O8LgX78pPYHsWi0cDRHnYPkokaOIYnKuXLx+7Q/Chnm0t
         R1MQ==
X-Gm-Message-State: AC+VfDyGJE8NYLY9aqFXBMI+jsiOFtbpbczOMlioCu+yazPvo93m/bJw
        F0cj1S3L866HVbXq+XrV7VLwTv+0qsy5CQ==
X-Google-Smtp-Source: ACHHUZ5q3F2cuL5N7k8iK3ccGd51LClShaNU7udy3ltAjd77ypwS7BCN4QBAnUMxrGtMgg6BRbwqJA==
X-Received: by 2002:a17:907:2d08:b0:96f:f807:6af5 with SMTP id gs8-20020a1709072d0800b0096ff8076af5mr10701027ejc.39.1685696364694;
        Fri, 02 Jun 2023 01:59:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:7ce9:cf23:e2e1:1e2e])
        by smtp.gmail.com with ESMTPSA id h27-20020a1709062ddb00b00965cfc209d5sm505722eji.8.2023.06.02.01.59.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Jun 2023 01:59:24 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] certs/extract-cert: Fix checkpatch issues
Date:   Fri,  2 Jun 2023 10:59:02 +0200
Message-Id: <20230602085902.59006-1-franziska.naepelt@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230601190508.56610-1-franziska.naepelt@gmail.com>
References: <20230601190508.56610-1-franziska.naepelt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following issues are fixed:
- WARNING: Missing or malformed SPDX-License-Identifier tag
- ERROR: trailing statements should be on next line
- WARNING: braces {} are not necessary for single statement blocks
- ERROR: space required before the open parenthesis '('
- ERROR: code indent should use tabs where possible
- WARNING: please, no spaces at the start of a line
- WARNING: Missing a blank line after declarations

Closes: https://lore.kernel.org/oe-kbuild-all/202306021040.UTvXfH5J-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202306021102.zQU95cMI-lkp@intel.com/

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
---
v2:
 - revert noreturn changes to fix build issues
---
 certs/extract-cert.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/certs/extract-cert.c b/certs/extract-cert.c
index 70e9ec89d87d..96c0728bf4d1 100644
--- a/certs/extract-cert.c
+++ b/certs/extract-cert.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1
 /* Extract X.509 certificate in DER form from PKCS#11 or PEM.
  *
  * Copyright © 2014-2015 Red Hat, Inc. All Rights Reserved.
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

