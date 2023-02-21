Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B2869E58B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbjBURIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbjBURIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:08:13 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246308A45
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:08:12 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id z2so5916404plf.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYUsNUP8dQUoDWSgKDYxcEoMW5EG+1h/JUO+OZMjiY4=;
        b=RsdBBX+sC5r2XVMYPCv08erc79V+tUTLkPT1B3SGBCUU9tYmLklW8GtqzQXqvQyUfP
         mIYsOKDmpMDW8lzyA0obZhcnIHiY4kbp2Tjxf/hJZ4Jy/4KW98BrVAMjusZCiaWWCJLx
         SKyDhPwdyBZ5bEYn3UPvvpVXLQEkdHBFcR5jXfjvuc3PBiHwu6+YZMZyGvTOQy3mtNTL
         cdJNOyJJtvd9DLinL2CaIN9I/PwoCEKGwagGWO8ltt69WZeQkS6crORbvdDZ/vRauJwF
         fyZmBdNGnExwxj4BYT5iHGoSlhXWWX8L4AL/TEzKgifcQx0gx9zbLm/gfsfeMjBHUjO5
         zmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYUsNUP8dQUoDWSgKDYxcEoMW5EG+1h/JUO+OZMjiY4=;
        b=hZVPU91sQOxAoiVibOOXYzowTRP2unClrI0EKSs7dnvAYb9tjhGHh0le2B3H/XB6RC
         f1Ysfi7F6Yx1FboW+le3FpNFppvRRpdO+7Eh5qLIHrnGWkJ6LJqQz2vCYD0p9XduyjQx
         atLdnXcdNUqkTRd05D2L5xufJNoQBCCQ2VaQsZL5tDkR83bp48/kJe9KGEyJsXs3WVap
         7WQoxGVYuGBrMKGWqVhPsHgONZr2/IDfISX5A1abHVilSLnDf96AVy05+D7mS6yHLqMC
         Oyw9Y75X5zrRrrDR95M7U8zH/8cuHrKtE6uyBDpRKXozjSr3TVDRPy7po6RxKNaE4I8q
         fDnw==
X-Gm-Message-State: AO0yUKWjIUTswCYDHTYuhdworxiliekkMIuHBuViOcNYFoNGD/RpYWjm
        T/LOsLrRx7kIsGNKcoAXsvI=
X-Google-Smtp-Source: AK7set/QTqBb6mpM9nt9zdwrguE7UC6UuBo3OYYr4f7Wc5ZVgn3mHOmLsPbClWtLOF/pcgaPZnvzhw==
X-Received: by 2002:a17:90b:4b4c:b0:233:ee70:800 with SMTP id mi12-20020a17090b4b4c00b00233ee700800mr4671348pjb.37.1676999291534;
        Tue, 21 Feb 2023 09:08:11 -0800 (PST)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id 15-20020a17090a01cf00b0020b21019086sm4522572pjd.3.2023.02.21.09.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 09:08:11 -0800 (PST)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     yesshedi@gmail.com, dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [ PATCH v4 2/6] sign-file: move file signing logic to its own function
Date:   Tue, 21 Feb 2023 22:38:00 +0530
Message-Id: <20230221170804.3267242-2-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230221170804.3267242-1-sshedi@vmware.com>
References: <20230221170804.3267242-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shreenidhi Shedi <yesshedi@gmail.com>

Keep the main function bare minimal and do less in main function.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 67 +++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 29 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index dbbde1aef3d9..3e6d776d126c 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -315,10 +315,10 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 	} while (opt != -1);
 }
 
-int main(int argc, char **argv)
+static int sign_file(int argc, char **argv, struct cmd_opts *opts)
 {
 	struct module_signature sig_info = { .id_type = PKEY_ID_PKCS7 };
-	unsigned char buf[4096];
+	unsigned char buf[4096] = {0};
 	unsigned long module_size, sig_size;
 	unsigned int use_signed_attrs;
 	const EVP_MD *digest_algo;
@@ -331,36 +331,20 @@ int main(int argc, char **argv)
 	X509 *x509;
 	BIO *bd, *bm;
 	int n;
-	struct cmd_opts opts = {0};
 
-	OpenSSL_add_all_algorithms();
-	ERR_load_crypto_strings();
-	ERR_clear_error();
-
-	key_pass = getenv("KBUILD_SIGN_PIN");
+	char *hash_algo = opts->hash_algo;
+	char *dest_name = opts->dest_name;
+	char *private_key_name = opts->private_key_name;
+	char *raw_sig_name = opts->raw_sig_name;
+	char *x509_name = opts->x509_name;
+	char *module_name = opts->module_name;
+	bool save_sig = opts->save_sig;
+	bool replace_orig = opts->replace_orig;
+	bool raw_sig = opts->raw_sig;
+	bool sign_only = opts->sign_only;
 
 #ifndef USE_PKCS7
-	use_signed_attrs = CMS_NOATTR;
-#else
-	use_signed_attrs = PKCS7_NOATTR;
-#endif
-	parse_args(argc, argv, &opts);
-	argc -= optind;
-	argv += optind;
-
-	char *hash_algo = opts.hash_algo;
-	char *dest_name = opts.dest_name;
-	char *private_key_name = opts.private_key_name;
-	char *raw_sig_name = opts.raw_sig_name;
-	char *x509_name = opts.x509_name;
-	char *module_name = opts.module_name;
-	bool save_sig = opts.save_sig;
-	bool replace_orig = opts.replace_orig;
-	bool raw_sig = opts.raw_sig;
-	bool sign_only = opts.sign_only;
-
-#ifndef USE_PKCS7
-	unsigned int use_keyid = opts.use_keyid;
+	unsigned int use_keyid = opts->use_keyid;
 #endif
 
 	if (!argv[0] || argc != 1)
@@ -381,6 +365,19 @@ int main(int argc, char **argv)
 		exit(3);
 	}
 #endif
+
+	OpenSSL_add_all_algorithms();
+	ERR_load_crypto_strings();
+	ERR_clear_error();
+
+	key_pass = getenv("KBUILD_SIGN_PIN");
+
+#ifndef USE_PKCS7
+	use_signed_attrs = CMS_NOATTR;
+#else
+	use_signed_attrs = PKCS7_NOATTR;
+#endif
+
 	/* Open the module file */
 	bm = BIO_new_file(module_name, "rb");
 	ERR(!bm, "%s", module_name);
@@ -492,3 +489,15 @@ int main(int argc, char **argv)
 
 	return 0;
 }
+
+int main(int argc, char **argv)
+{
+	struct cmd_opts opts = {0};
+
+	parse_args(argc, argv, &opts);
+
+	argc -= optind;
+	argv += optind;
+
+	return sign_file(argc, argv, &opts);
+}
-- 
2.39.1

