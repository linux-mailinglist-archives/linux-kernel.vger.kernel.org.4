Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CC469502B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjBMTBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjBMTBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:01:01 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288122279C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:00:40 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id h7so3527148pfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ed18OmW7V5BJ4+t+Jo1emXPIMpbBTZM0uB02YkT43y8=;
        b=nghlAVlVep/CsRINVzU4LYlA/LryJJamOjnwnfqC6eF9IMfpmn/zUIp9m4eGI0nkDj
         3RmKI5sQEcikXSlGYjEWk/wBRK2vkw1qAB7AwQV/69kVO7DPjr9VxY1aYwEP69Cv9veI
         GcKR+wVJrKIfogGlxu/vVCtWFNpGbeOfdyIXI+n79ISI7sIKvwfmbj4kV/nYH4WsfD8l
         NuLKuHbwL+5Xtq72yXWtWuCATIcuDX3PLWJWGH27jVxErSXcnMpPbqNzq2ZwCIykxrGz
         y402LMHtyUkh+Q0z3PF3mL4HPQmYPNoz6dhnUEXbDyQb27J9O9y5e9rw9j0YspbLuD4T
         80Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ed18OmW7V5BJ4+t+Jo1emXPIMpbBTZM0uB02YkT43y8=;
        b=0YBlvz7itSBeERuZfck42JlkG4rn7beQD7MVR+xvQTOVVhluVYW2c1co4BF4iQcC+D
         P17/i/4WhAqG6ffehOgtXQCqzl4IpaNr+viBhbjOuD9JzDl33vwVLwnxMYI02xV/a+Aj
         BKJlwYgc8RpXjYSCzFM64WsUj2lXeOYRFKPP12Wqb6kUZd5smlev/uxI2YnTum1oijP1
         MGvrr4LOk01iram/gc9/PCkXkBzEd3PGaeVs7N1CqFf2tMjbgVJgL9xuiRI5I+U0wDE6
         3khDB3qnY/2dOV6eMX24MzFfWcHPFGCqdWUBbjJS1aVffCmL5EAuQec5LJR7lysShMz3
         L0Rw==
X-Gm-Message-State: AO0yUKW0YDlYCJdGuDnb5lLEY0zv2Gw4kxwHEgyyr9kCZADHmqI+916z
        dcdC8naTkNlhV6JCItec3OU=
X-Google-Smtp-Source: AK7set+JT/n1IMx+dO3UNqUQfPNJdZgSUrbrJDtypCuOLsR3kOHpfXoET9k/3zGbeGBoYcGQOZr98A==
X-Received: by 2002:aa7:9798:0:b0:5a8:58b5:bfa5 with SMTP id o24-20020aa79798000000b005a858b5bfa5mr13467860pfp.4.1676314839035;
        Mon, 13 Feb 2023 11:00:39 -0800 (PST)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id c25-20020a62e819000000b0056bc5ad4862sm2032452pfi.28.2023.02.13.11.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 11:00:38 -0800 (PST)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH v3 1/6] sign-file: refactor argument parsing logic
Date:   Tue, 14 Feb 2023 00:30:29 +0530
Message-Id: <20230213190034.57097-1-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Use getopt_long_only for parsing input args
- Use more easy to remember command line argument names

Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
---
 scripts/sign-file.c | 156 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 122 insertions(+), 34 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 598ef5465f82..cf3acbb13013 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -213,15 +213,111 @@ static X509 *read_x509(const char *x509_name)
 	return x509;
 }
 
+struct cmd_opts {
+	char *hash_algo;
+	char *dest_name;
+	char *private_key_name;
+	char *raw_sig_name;
+	char *x509_name;
+	char *module_name;
+	bool save_sig;
+	bool replace_orig;
+	bool raw_sig;
+	bool sign_only;
+
+#ifndef USE_PKCS7
+	unsigned int use_keyid;
+#endif
+};
+
+void parse_args(int argc, char **argv, struct cmd_opts *opts)
+{
+	struct option cmd_options[] = {
+		/* These options set a flag. */
+		{"help", no_argument, 0, 'h'},
+		{"savesig", no_argument, 0, 's'},
+		{"signonly", no_argument, 0, 'o'},
+#ifndef USE_PKCS7
+		{"usekeyid", no_argument, 0, 'k'},
+#endif
+		{"rawsig", required_argument, 0, 'r'},
+		{"privkey", required_argument, 0, 'p'},
+		{"hashalgo", required_argument, 0, 'a'},
+		{"x509", required_argument, 0, 'x'},
+		{"dest", required_argument, 0, 'd'},
+		{"replaceorig", required_argument, 0, 'l'},
+		{0, 0, 0, 0}
+	};
+
+	int opt;
+	int opt_index = 0;
+
+	do {
+#ifndef USE_PKCS7
+		opt = getopt_long_only(argc, argv, "hsobr:p:a:x:d:l:",
+				cmd_options, &opt_index);
+#else
+		opt = getopt_long_only(argc, argv, "hsobkr:p:a:x:d:l:",
+				cmd_options, &opt_index);
+#endif
+		switch (opt) {
+		case 'h':
+			format();
+			break;
+
+		case 'r':
+			opts->raw_sig = true;
+			opts->raw_sig_name = optarg;
+			break;
+
+		case 's':
+			opts->save_sig = true;
+			break;
+
+		case 'o':
+			opts->sign_only = true;
+			opts->save_sig = true;
+			break;
+
+#ifndef USE_PKCS7
+		case 'k':
+			opts->use_keyid = CMS_USE_KEYID;
+			break;
+#endif
+
+		case 'p':
+			opts->private_key_name = optarg;
+			break;
+
+		case 'a':
+			opts->hash_algo = optarg;
+			break;
+
+		case 'x':
+			opts->x509_name = optarg;
+			break;
+
+		case 'd':
+			opts->dest_name = optarg;
+			break;
+
+		case 'l':
+			opts->replace_orig = true;
+			break;
+
+		case -1:
+			break;
+
+		default:
+			format();
+			break;
+		}
+	} while (opt != -1);
+}
+
 int main(int argc, char **argv)
 {
 	struct module_signature sig_info = { .id_type = PKEY_ID_PKCS7 };
-	char *hash_algo = NULL;
-	char *private_key_name = NULL, *raw_sig_name = NULL;
-	char *x509_name, *module_name, *dest_name;
-	bool save_sig = false, replace_orig;
-	bool sign_only = false;
-	bool raw_sig = false;
 	unsigned char buf[4096];
 	unsigned long module_size, sig_size;
 	unsigned int use_signed_attrs;
@@ -229,13 +325,14 @@ int main(int argc, char **argv)
 	EVP_PKEY *private_key;
 #ifndef USE_PKCS7
 	CMS_ContentInfo *cms = NULL;
-	unsigned int use_keyid = 0;
 #else
 	PKCS7 *pkcs7 = NULL;
 #endif
 	X509 *x509;
 	BIO *bd, *bm;
-	int opt, n;
+	int i, n;
+	struct cmd_opts opts = {0};
+
 	OpenSSL_add_all_algorithms();
 	ERR_load_crypto_strings();
 	ERR_clear_error();
@@ -247,37 +344,29 @@ int main(int argc, char **argv)
 #else
 	use_signed_attrs = PKCS7_NOATTR;
 #endif
+	parse_args(argc, argv, &opts);
+	argc -= optind;
+	argv += optind;
+
+	char *hash_algo = opts.hash_algo;
+	char *dest_name = opts.dest_name;
+	char *private_key_name = opts.private_key_name;
+	char *raw_sig_name = opts.raw_sig_name;
+	char *x509_name = opts.x509_name;
+	char *module_name = opts.module_name;
+	bool save_sig = opts.save_sig;
+	bool replace_orig = opts.replace_orig;
+	bool raw_sig = opts.raw_sig;
+	bool sign_only = opts.sign_only;
 
-	do {
-		opt = getopt(argc, argv, "sdpk");
-		switch (opt) {
-		case 's': raw_sig = true; break;
-		case 'p': save_sig = true; break;
-		case 'd': sign_only = true; save_sig = true; break;
 #ifndef USE_PKCS7
-		case 'k': use_keyid = CMS_USE_KEYID; break;
+	unsigned int use_keyid = opts.use_keyid;
 #endif
-		case -1: break;
-		default: format();
-		}
-	} while (opt != -1);
 
-	argc -= optind;
-	argv += optind;
-	if (argc < 4 || argc > 5)
+	if (!argv[0] || argc != 1)
 		format();
 
-	if (raw_sig) {
-		raw_sig_name = argv[0];
-		hash_algo = argv[1];
-	} else {
-		hash_algo = argv[0];
-		private_key_name = argv[1];
-	}
-	x509_name = argv[2];
-	module_name = argv[3];
-	if (argc == 5 && strcmp(argv[3], argv[4]) != 0) {
-		dest_name = argv[4];
+	if (dest_name && strcmp(argv[0], dest_name)) {
 		replace_orig = false;
 	} else {
 		ERR(asprintf(&dest_name, "%s.~signed~", module_name) < 0,
@@ -292,7 +381,6 @@ int main(int argc, char **argv)
 		exit(3);
 	}
 #endif
-
 	/* Open the module file */
 	bm = BIO_new_file(module_name, "rb");
 	ERR(!bm, "%s", module_name);
-- 
2.39.1

