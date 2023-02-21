Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9676D69E58A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjBURIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjBURIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:08:12 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBD086BF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:08:10 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id h14so5912730plf.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hqIoKphm/OkyYYr8a4/ZQVubM5bxZPt+Ze9PMFWhwCM=;
        b=A0s8xKmTf8VpummIoIsJpDQEaIhi2iQGDChnI4t8Bz5IaBNbi7H05CYdiDJ+x077V3
         ziyiut9e1j3Bmb0pxMQrV3jLTmmq96zYkUK6AYfayiqY0M6g+w8smSRFUSE/IyuiD/wK
         mt6EBgHGmD+0GS3ChMZvzIl6GIW8UuOPLra3Ik7f4YmjBdf5TGcFGSMADLjqWQzVitgt
         ipjxVie/L/fu+hEUzPT/avrMIsEDVi5H2xzCRME65ECShlCgsbdskqUPqHhLi1Wj+MSM
         571YdiHGF3x+sbV0++IsGqfuJF5vZGExyOM0NaiKJ7Pdl4eKgOOxBf2Lig4EKs8OIe1t
         tevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqIoKphm/OkyYYr8a4/ZQVubM5bxZPt+Ze9PMFWhwCM=;
        b=wDd0w/b0zNHT9KRJLYTpJmlbD51Qq2mdDS2/VrQNOdzchT2IReUfyg0kgsPCKXgDYc
         vCqoFytHJn0chazGUATtj92Pa9yIMPvBkFyx2Dca/MRBEGpCURx6YM+1EqKuWdoUgxxp
         TuxPJciXgUklJBxGjs3nF91xU0Rf8ADP4kfMHL50fRg7O/kFzWXdPI+mTtl6UUEK52ob
         sYc9kO4EngNjaTlCi1O7HGvaabMub8mX4nMEK7xLC+EpEO4kToJm9wO+zgBtGYpFb4aN
         rEbuLt3vtlRopM0eNnQc5+9GKx19K5aOUjN6ACylsiC/FxVK08Mk2mzMz4nm8XfIMWkV
         Ksvg==
X-Gm-Message-State: AO0yUKUeQOZsZ9RIClqPwBafnK+8dOW0CVoGCPVm6ZyCHg+eXFgUbt17
        XNXZHqSbcfXhJgLYJOQsuivzo7nUVZw=
X-Google-Smtp-Source: AK7set9Ort5ijmxZ/7c/D2fdseJZ9KvW4NDqALGwU873rLr4RtP28+AJjEWDJvqyPU46JU80ZWzlWg==
X-Received: by 2002:a17:90b:384d:b0:234:31f3:e00f with SMTP id nl13-20020a17090b384d00b0023431f3e00fmr6287557pjb.43.1676999290179;
        Tue, 21 Feb 2023 09:08:10 -0800 (PST)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id 15-20020a17090a01cf00b0020b21019086sm4522572pjd.3.2023.02.21.09.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 09:08:09 -0800 (PST)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     yesshedi@gmail.com, dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [ PATCH v4 1/6] sign-file: refactor argument parsing logic
Date:   Tue, 21 Feb 2023 22:37:59 +0530
Message-Id: <20230221170804.3267242-1-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.1
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

- Use getopt_long_only for parsing input args
- Use more easy to remember command line argument names

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 156 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 122 insertions(+), 34 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 598ef5465f82..dbbde1aef3d9 100644
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
+static void parse_args(int argc, char **argv, struct cmd_opts *opts)
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
+	int n;
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

