Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16662694FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjBMSux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjBMSuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:50:44 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1750D206BB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:50:25 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id w5so14452770plg.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ed18OmW7V5BJ4+t+Jo1emXPIMpbBTZM0uB02YkT43y8=;
        b=TKRHx6jErMe8hSJseU3a7PFwHZUme7YEZ3Jvhd3TvBsUjj3LHYE4jftCLXR0A31Hd7
         N5rfx2vdRU/dcGC32weUgVroIR0J11T3b63y1kQbwBohn5HBo0X9fZTBBmzP9er6GN9r
         Qz6GoRHwmGV3BlwPDnlEpPQiIl5EgrUx4xfxdvMnjNC1EPlxfXgI+3PBnEpgumZo759f
         nouBZchnqw9IodDOgxOaMkisN/5/02SyAgMe+r8ch8As/uuvtn2r6+zjCk0aQLKASALy
         78/JHnePy8KBLzJnK91BLGJxW9guWr/zq5ek1/ZbIx9LhWeGlEtV2uZ7Rw3or/2v2YHS
         r37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ed18OmW7V5BJ4+t+Jo1emXPIMpbBTZM0uB02YkT43y8=;
        b=qziTCKlexcXSSVjyKjZv02pvhvijddU7+GEjr2DqnQqtObKk3ny4nxiVTzPrDiXLtq
         NFwbFNHZTT3Z4a7ZBYG7KszXkzM1kjncImBSRQIx1+zMmQxxhc2Xne1CY5tgw6TdC5S6
         FN3NvzQl9woFxnFtQxouI6qCjE2rVB0GDRuhOTCNGG95uBXVt5tYKeGaCPkfkRHE+kHo
         i1b9YkLRaBJIQm/cInMGOAoOlfrXu9jgOjUwzNmwk+EHfbWE0J18XMRCmYu9JMegqYyq
         s5cQ3us4deiEM6s8/5xP4abBQw3fOX9HtqxZnDH6HxkXitHZYxHzhn8rj5nyImxsev13
         2UZg==
X-Gm-Message-State: AO0yUKVlw0SkWCIn+hUoQ43p7EQyydRSzYZ3GFGnnfysAi/Xn17HgnjP
        5CNNfvm4fdwFAg4zG/RL/Nw=
X-Google-Smtp-Source: AK7set8F/eNUHAwRPPt1W4+ivFXEuRFcOcL4ZVgTnv2KSr8QW93lHP9PJHopdRUuy6b9D9gT5SLSog==
X-Received: by 2002:a17:902:e884:b0:19a:a5d0:fabc with SMTP id w4-20020a170902e88400b0019aa5d0fabcmr3688747plg.12.1676314224549;
        Mon, 13 Feb 2023 10:50:24 -0800 (PST)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id p14-20020a170902a40e00b00198f256a192sm8535036plq.171.2023.02.13.10.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 10:50:24 -0800 (PST)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH v2 1/6] sign-file: refactor argument parsing logic
Date:   Tue, 14 Feb 2023 00:20:13 +0530
Message-Id: <20230213185019.56902-1-sshedi@vmware.com>
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

